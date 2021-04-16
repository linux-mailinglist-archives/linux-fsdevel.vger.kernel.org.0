Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D351F36263C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 19:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236502AbhDPRAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 13:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbhDPRAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:00:51 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFC6C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 10:00:26 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXRpD-005oHE-Uz; Fri, 16 Apr 2021 17:00:12 +0000
Date:   Fri, 16 Apr 2021 17:00:11 +0000
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
Message-ID: <YHnCm0Zzi+envOGB@zeniv-ca.linux.org.uk>
References: <YGWYZYbBzglUCxB2@kroah.com>
 <20210401104034.52qaaoea27htkpbh@wittgenstein>
 <YHkedhnn1wdVFTV3@zeniv-ca.linux.org.uk>
 <YHkmxCyJ8yekgGKl@zeniv-ca.linux.org.uk>
 <20210416134252.v3zfjp36tpk33tqz@wittgenstein>
 <YHmanzAMdeCtZUjy@zeniv-ca.linux.org.uk>
 <20210416151310.nqkxfwocm32lnqfq@wittgenstein>
 <YHmu3/Cw4bUnTSH9@zeniv-ca.linux.org.uk>
 <20210416155815.ayjpnx37dv3a4jos@wittgenstein>
 <20210416160038.ojbhqf73dkrl4dk6@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416160038.ojbhqf73dkrl4dk6@wittgenstein>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 06:00:38PM +0200, Christian Brauner wrote:

> (dma_buf_fd() seems like another good candidate. But again, I don't have
> any plans to shove this down anyone's throat.)

Sure, there are candidates for such a helper.  Just as there are legitimate
users of anon_inode_getfd().

However, it is *NOT* something we can use as a vehicle for some hooks (pardon
the obscenity); it won't be consistently used in all cases - it simply is not
feasible for many of the fd_install() users.

Incidentally, looking at the user of receive_fd_user(), I would say that it
would be easier to follow in this form:
	case VDUSE_IOTLB_GET_ENTRY: {
		struct vduse_iotlb_entry entry;
		struct vhost_iotlb_map *map;
		struct vduse_iova_domain *domain = dev->domain;
		struct file *f = NULL;

		if (copy_from_user(&entry, argp, sizeof(entry)))
			return -EFAULT;
		entry.fd = get_unused_fd_flags(perm_to_file_flags(entry.perm));
		if (entry.fd < 0)
			return entry.fd;
		spin_lock(&domain->iotlb_lock);
		map = vhost_iotlb_itree_first(domain->iotlb,
					      entry.start, entry.start + 1);
		if (map) {
			struct vdpa_map_file *map_file = map->opaque;

			f = get_file(map_file->file);
			entry.offset = map_file->offset;
			entry.start = map->start;
			entry.last = map->last;
			entry.perm = map->perm;
		}
		spin_unlock(&domain->iotlb_lock);
		if (!f) {
			put_unused_fd(entry.fd);
			return -EINVAL;
		}
		if (copy_to_user(argp, &entry, sizeof(entry))) {
			put_unused_fd(entry.fd);
			fput(f);
			return -EFAULT;
		}
		// point of no return
		fd_install(entry.fd, f);
		return 0;
	}
