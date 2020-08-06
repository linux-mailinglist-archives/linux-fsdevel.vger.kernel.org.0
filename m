Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FCA23DE74
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 19:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbgHFR0E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 13:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729445AbgHFRCg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:02:36 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DAAC0A8889;
        Thu,  6 Aug 2020 07:32:24 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3gwP-00AXtN-8v; Thu, 06 Aug 2020 14:32:21 +0000
Date:   Thu, 6 Aug 2020 15:32:21 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vikas Kumar <vikas.kumar2@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, rafael@kernel.org
Subject: Re: [LTP-FAIL][02/21] fs: refactor ksys_umount
Message-ID: <20200806143221.GQ1236603@ZenIV.linux.org.uk>
References: <d28d2235-9b1c-0403-59ca-e57ac5d0460e@arm.com>
 <20200806141732.GA5902@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806141732.GA5902@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 06, 2020 at 04:17:32PM +0200, Christoph Hellwig wrote:
> Fix for umount03 below.  The other one works fine here, but from
> your logs this might be a follow on if you run it after umount without
> the fix.

Ugh...

How about 
static int may_umount(const struct path *path, int flags)
{
        struct mount *mnt = real_mount(path->mnt);

        if (flags & ~(MNT_FORCE | MNT_DETACH | MNT_EXPIRE | UMOUNT_NOFOLLOW))
                return -EINVAL;
        if (!may_mount())
                return -EPERM;
        if (path->dentry != path->mnt->mnt_root)
                return -EINVAL;
        if (!check_mnt(mnt))
                return -EINVAL;
        if (mnt->mnt.mnt_flags & MNT_LOCKED) /* Check optimistically */
                return -EINVAL;
        if (flags & MNT_FORCE && !capable(CAP_SYS_ADMIN))
                return -EPERM;
	return 0;
}

int path_umount(const struct path *path, int flags)
{
        struct mount *mnt = real_mount(path->mnt);
        int err;

	err = may_umount(path, flags);
	if (!err)
		err = do_umount(mnt, flags);

        /* we mustn't call path_put() as that would clear mnt_expiry_mark */
        dput(path->dentry);
        mntput_no_expire(mnt);
        return err;
}

instead?
