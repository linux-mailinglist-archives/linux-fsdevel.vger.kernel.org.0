Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42403AB5E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 16:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhFQO2C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 10:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhFQO2C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:28:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38382C061574;
        Thu, 17 Jun 2021 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wzZhieUCTydu3GyeTVG9mMeeZV6Pcd3sEaD/7vJ14DE=; b=WFK4gPH3RMnGJEiPQBkbbzCReG
        e6lx/HO4t41Z/sImtffnNLojRPbVSDUBztDOF5Cj5mCbDlO5K1py0Ud8f5E1fpuh465GetCfEDH+K
        qUSDIj3GnT0ffxm5aRgzlCLxkDltYLm24JlVyPoV+9isVWbYcKOSb24kI6w57KhH0PP5dUXBHH40N
        dhSfTHusBDvoxmftQBwHDyipEB6Vv9i1O1NRsvNqcWSJuODlqo20Fb/hM+6pUK1Yhuyp39iE7BIxE
        tnoNhMHHttdV2lU3m8lLJRKpEjgyUbPTMyGLd/GsKeCMZNUlbMs3/a1umEUg42qsM3RGKPi5hiOXc
        6m3bw7wg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltsx2-009Did-5K; Thu, 17 Jun 2021 14:25:06 +0000
Date:   Thu, 17 Jun 2021 15:25:00 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, viro@zeniv.linux.org.uk, dhowells@redhat.com,
        richard.weinberger@gmail.com, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v2 0/2] Add support to boot virtiofs and 9pfs as rootfs
Message-ID: <YMtbPDW+T5Z1uBZt@infradead.org>
References: <20210614174454.903555-1-vgoyal@redhat.com>
 <YMsgaPS90iKIqSvi@infradead.org>
 <20210617133052.GA1142820@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617133052.GA1142820@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 17, 2021 at 09:30:52AM -0400, Vivek Goyal wrote:
> > +static int __init mount_nodev_root(void)
> > +{
> > +	struct file_system_type *fs = get_fs_type(root_fs_names);
> 
> get_fs_type() assumes root_fs_names is not null. So if I pass
> "root=myfs rw", it crashes with null pointer dereference.

Ok, I'll need to fix that.

> > +	int err = -ENODEV;
> > +
> > +	if (!fs)
> > +		goto out;
> > +	if (fs->fs_flags & FS_REQUIRES_DEV)
> > +		goto out_put_filesystem;
> > +
> > +	fs_names = (void *)__get_free_page(GFP_KERNEL);
> > +	if (!fs_names)
> > +		goto out_put_filesystem;
> > +	get_fs_names(fs_names);
> 
> I am wondering what use case we are trying to address by calling
> get_fs_names() and trying do_mount_root() on all filesystems
> returned by get_fs_names(). I am assuming following use cases
> you have in mind.
> 
> A. User passes a single filesystem in rootfstype.
>    
>    root=myfs rootfstype=virtiofs rw
> 
> B. User passes multiple filesystems in rootfstype and kernel tries all
>    of them one after the other
> 
>    root=myfs, rootfstype=9p,virtiofs rw
> 
> C. User does not pass a filesystem type at all. And kernel will get a
>    list of in-built filesystems and will try these one after the other.
> 
>    root=myfs rw
> 
> If that's the thought, will it make sense to call get_fs_names() first
> and then inside the for loop call get_fs_type() and try mounting
> only if FS_REQUIRES_DEV is not set, otherwise skip and move onto th
> next filesystem in the list (fs_names).

I thought of A and B.  I did not think at all of C and think it is
a rather bad idea.  I'll revisit the patch to avoid C and will resend it
as a formal patch.
