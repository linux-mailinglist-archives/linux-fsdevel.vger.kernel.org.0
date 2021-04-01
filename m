Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDE13513C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 12:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhDAKlA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 06:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233665AbhDAKkm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 06:40:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D1E1260FEA;
        Thu,  1 Apr 2021 10:40:37 +0000 (UTC)
Date:   Thu, 1 Apr 2021 12:40:34 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Xie Yongji <xieyongji@bytedance.com>, hch@infradead.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, hridya@google.com, surenb@google.com,
        viro@zeniv.linux.org.uk, sargun@sargun.me, keescook@chromium.org,
        jasowang@redhat.com, devel@driverdev.osuosl.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] binder: Use receive_fd() to receive file from
 another process
Message-ID: <20210401104034.52qaaoea27htkpbh@wittgenstein>
References: <20210401090932.121-1-xieyongji@bytedance.com>
 <20210401090932.121-3-xieyongji@bytedance.com>
 <YGWYZYbBzglUCxB2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YGWYZYbBzglUCxB2@kroah.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 01, 2021 at 11:54:45AM +0200, Greg KH wrote:
> On Thu, Apr 01, 2021 at 05:09:32PM +0800, Xie Yongji wrote:
> > Use receive_fd() to receive file from another process instead of
> > combination of get_unused_fd_flags() and fd_install(). This simplifies
> > the logic and also makes sure we don't miss any security stuff.
> 
> But no logic is simplified here, and nothing is "missed", so I do not
> understand this change at all.
> 
> > 
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> > ---
> >  drivers/android/binder.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> > index c119736ca56a..080bcab7d632 100644
> > --- a/drivers/android/binder.c
> > +++ b/drivers/android/binder.c
> > @@ -3728,7 +3728,7 @@ static int binder_apply_fd_fixups(struct binder_proc *proc,
> >  	int ret = 0;
> >  
> >  	list_for_each_entry(fixup, &t->fd_fixups, fixup_entry) {
> > -		int fd = get_unused_fd_flags(O_CLOEXEC);
> > +		int fd  = receive_fd(fixup->file, O_CLOEXEC);
> 
> Why 2 spaces?
> 
> >  
> >  		if (fd < 0) {
> >  			binder_debug(BINDER_DEBUG_TRANSACTION,
> > @@ -3741,7 +3741,7 @@ static int binder_apply_fd_fixups(struct binder_proc *proc,
> >  			     "fd fixup txn %d fd %d\n",
> >  			     t->debug_id, fd);
> >  		trace_binder_transaction_fd_recv(t, fd, fixup->offset);
> > -		fd_install(fd, fixup->file);
> > +		fput(fixup->file);
> 
> Are you sure this is the same???
> 
> I d onot understand the need for this change at all, what is wrong with
> the existing code here?

I suggested something like this.
Some time back we added receive_fd() for seccomp and SCM_RIGHTS to have
a unified way of installing file descriptors including taking care of
handling sockets and running security hooks. The helper also encompasses
the whole get_unused_fd() + fd_install dance.
My suggestion was to look at all the places were we currently open-code
this in drivers/:

drivers/android/binder.c:               int fd = get_unused_fd_flags(O_CLOEXEC);
drivers/char/tpm/tpm_vtpm_proxy.c:      fd = get_unused_fd_flags(O_RDWR);
drivers/dma-buf/dma-buf.c:      fd = get_unused_fd_flags(flags);
drivers/dma-buf/sw_sync.c:      int fd = get_unused_fd_flags(O_CLOEXEC);
drivers/dma-buf/sync_file.c:    int fd = get_unused_fd_flags(O_CLOEXEC);
drivers/gpio/gpiolib-cdev.c:    fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
drivers/gpio/gpiolib-cdev.c:    fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
drivers/gpio/gpiolib-cdev.c:    fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c:         fd = get_unused_fd_flags(O_CLOEXEC);
drivers/gpu/drm/drm_atomic_uapi.c:      fence_state->fd = get_unused_fd_flags(O_CLOEXEC);
drivers/gpu/drm/drm_lease.c:    fd = get_unused_fd_flags(cl->flags & (O_CLOEXEC | O_NONBLOCK));
drivers/gpu/drm/drm_syncobj.c:  fd = get_unused_fd_flags(O_CLOEXEC);
drivers/gpu/drm/drm_syncobj.c:  int fd = get_unused_fd_flags(O_CLOEXEC);
drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c:           out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:         out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
drivers/gpu/drm/msm/msm_gem_submit.c:           out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
drivers/gpu/drm/virtio/virtgpu_ioctl.c:         out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c:                out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
drivers/infiniband/core/rdma_core.c:    new_fd = get_unused_fd_flags(O_CLOEXEC);
drivers/media/mc/mc-request.c:  fd = get_unused_fd_flags(O_CLOEXEC);
drivers/misc/cxl/api.c: rc = get_unused_fd_flags(flags);
drivers/scsi/cxlflash/ocxl_hw.c:        rc = get_unused_fd_flags(flags);
drivers/scsi/cxlflash/ocxl_hw.c:                dev_err(dev, "%s: get_unused_fd_flags failed rc=%d\n",
drivers/tty/pty.c:      fd = get_unused_fd_flags(flags);
drivers/vfio/vfio.c:    ret = get_unused_fd_flags(O_CLOEXEC);
drivers/virt/nitro_enclaves/ne_misc_dev.c:      enclave_fd = get_unused_fd_flags(O_CLOEXEC);

and see whether all of them can be switched to simply using
receive_fd(). I did a completely untested rough sketch to illustrate
what I meant by using binder and devpts Xie seems to have just picked
those two. But the change is obviously only worth it if all or nearly
all callers can be switched over without risk of regression.
It would most likely simplify quite a few codepaths though especially in
the error paths since we can get rid of put_unused_fd() cleanup.

But it requires buy in from others obviously.

Christian
