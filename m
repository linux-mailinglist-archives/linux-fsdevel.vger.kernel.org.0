Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273CF361935
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 07:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbhDPFUe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 01:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236787AbhDPFUc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:20:32 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D981C061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Apr 2021 22:20:07 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXGtS-005gO5-MU; Fri, 16 Apr 2021 05:19:50 +0000
Date:   Fri, 16 Apr 2021 05:19:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Xie Yongji <xieyongji@bytedance.com>, hch@infradead.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, hridya@google.com, surenb@google.com,
        sargun@sargun.me, keescook@chromium.org, jasowang@redhat.com,
        devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] binder: Use receive_fd() to receive file from
 another process
Message-ID: <YHkedhnn1wdVFTV3@zeniv-ca.linux.org.uk>
References: <20210401090932.121-1-xieyongji@bytedance.com>
 <20210401090932.121-3-xieyongji@bytedance.com>
 <YGWYZYbBzglUCxB2@kroah.com>
 <20210401104034.52qaaoea27htkpbh@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401104034.52qaaoea27htkpbh@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 12:40:34PM +0200, Christian Brauner wrote:
> My suggestion was to look at all the places were we currently open-code
> this in drivers/:
> 
> drivers/android/binder.c:               int fd = get_unused_fd_flags(O_CLOEXEC);
> drivers/char/tpm/tpm_vtpm_proxy.c:      fd = get_unused_fd_flags(O_RDWR);
> drivers/dma-buf/dma-buf.c:      fd = get_unused_fd_flags(flags);
> drivers/dma-buf/sw_sync.c:      int fd = get_unused_fd_flags(O_CLOEXEC);
> drivers/dma-buf/sync_file.c:    int fd = get_unused_fd_flags(O_CLOEXEC);
> drivers/gpio/gpiolib-cdev.c:    fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
> drivers/gpio/gpiolib-cdev.c:    fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
> drivers/gpio/gpiolib-cdev.c:    fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
> drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:         fd = get_unused_fd_flags(O_CLOEXEC);
> drivers/gpu/drm/drm_atomic_uapi.c:      fence_state->fd = get_unused_fd_flags(O_CLOEXEC);
> drivers/gpu/drm/drm_lease.c:    fd = get_unused_fd_flags(cl->flags & (O_CLOEXEC | O_NONBLOCK));
> drivers/gpu/drm/drm_syncobj.c:  fd = get_unused_fd_flags(O_CLOEXEC);
> drivers/gpu/drm/drm_syncobj.c:  int fd = get_unused_fd_flags(O_CLOEXEC);
> drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c:           out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
> drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:         out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
> drivers/gpu/drm/msm/msm_gem_submit.c:           out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
> drivers/gpu/drm/virtio/virtgpu_ioctl.c:         out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
> drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c:                out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
> drivers/infiniband/core/rdma_core.c:    new_fd = get_unused_fd_flags(O_CLOEXEC);
> drivers/media/mc/mc-request.c:  fd = get_unused_fd_flags(O_CLOEXEC);
> drivers/misc/cxl/api.c: rc = get_unused_fd_flags(flags);
> drivers/scsi/cxlflash/ocxl_hw.c:        rc = get_unused_fd_flags(flags);
> drivers/scsi/cxlflash/ocxl_hw.c:                dev_err(dev, "%s: get_unused_fd_flags failed rc=%d\n",
> drivers/tty/pty.c:      fd = get_unused_fd_flags(flags);
> drivers/vfio/vfio.c:    ret = get_unused_fd_flags(O_CLOEXEC);
> drivers/virt/nitro_enclaves/ne_misc_dev.c:      enclave_fd = get_unused_fd_flags(O_CLOEXEC);
> 
> and see whether all of them can be switched to simply using
> receive_fd(). I did a completely untested rough sketch to illustrate
> what I meant by using binder and devpts Xie seems to have just picked
> those two. But the change is obviously only worth it if all or nearly
> all callers can be switched over without risk of regression.
> It would most likely simplify quite a few codepaths though especially in
> the error paths since we can get rid of put_unused_fd() cleanup.
> 
> But it requires buy in from others obviously.

Opening a file can have non-trivial side effects; reserving a descriptor
can't.  Moreover, if you look at the second hit in your list, you'll see
that we do *NOT* want that combined thing there - fd_install() is
completely irreversible, so we can't do that until we made sure the
reply (struct vtpm_proxy_new_dev) has been successfully copied to
userland.  No, your receive_fd_user() does not cover that.

There's a bunch of other cases like that - the next ones on your list
are drivers/dma-buf/sw_sync.c and drivers/dma-buf/sync_file.c, etc.

So I would consider receive_fd() as an attractive nuisance if it
is ever suggested (and available) for wide use...
