Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED9663D6F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 14:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiK3NlL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 08:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiK3NlK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:41:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935352BB34
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 05:41:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27176B81B4D
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Nov 2022 13:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51033C433C1;
        Wed, 30 Nov 2022 13:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669815650;
        bh=UgdHP8h4I5gTOmpusrqU4nvSy+QOrv3LFyiy2qtK9G8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ID8h8S7z1SsNqdWUEku88ZyQCmwcSPzfwW4jcE0tlRlLtADtsFGnEUQ9uZ7jPYlwv
         swYiHqWQs1Ql2ozeguu4S5jNTs93JYHWkYYqgzRNqu3OEqpnc/pc2CknjU2DXirf7B
         /X8E9hgZLtnwPI3A+xB6Nfr2RkuoQ70mDKwc78wsJB0SZ6EyaK7rqVpfA9dVmtW83V
         rLnwoDxw4CyONiCqYCWs3Kctnw2cRYeLkN3SjgqFhpn0bXBPeWq2iOdrE+EUKOtu90
         tW+doqzaPrJrdePY37+UkEH8RxUnf5xNp/UZNZsbFYXwrWK4teXF+tv/W8tw82MPzp
         LCCPcADcPkl1g==
Message-ID: <14d1e26a57d75c92efd2fd96ca7c675aa1410f80.camel@kernel.org>
Subject: Re: [RFC PATCH] fs: drop the fl_owner_t argument from ->flush
From:   Jeff Layton <jlayton@kernel.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Christoph Hellwig <hch@infradead.org>
Date:   Wed, 30 Nov 2022 08:40:48 -0500
In-Reply-To: <CAJfpegscj=rAEn5g67DtGb5ZO5nOKjhEsd1dR_yXcVDq2K0NkQ@mail.gmail.com>
References: <20221128150301.1168324-1-jlayton@kernel.org>
         <CAJfpegscj=rAEn5g67DtGb5ZO5nOKjhEsd1dR_yXcVDq2K0NkQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1 (3.46.1-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-11-30 at 13:46 +0100, Miklos Szeredi wrote:
> On Mon, 28 Nov 2022 at 16:03, Jeff Layton <jlayton@kernel.org> wrote:
>=20
> > It would be nice to do this, but the FUSE thing may make it impossible.
> >=20
> > Is there a way to audit the various flush operations in userland FUSE
> > filesystems and see whether they do anything with the lock_owner? I did
> > take a peek at ceph-fuse and it doesn't care about the lock_owner in it=
s
> > flush op. I'm at a loss as to how to check this more broadly.
> >=20
> > If we can't do this right away, then perhaps we could try to change thi=
s
> > as part of the FUSE userland API first, and follow up with a change lik=
e
> > this later.
> >=20
> > Thoughts?
>=20
> So fuse is alone in trying to support remote POSIX locks?
>=20

No. Several network filesystems support POSIX locking. This is about the
->flush file_operation. That op is called from filp_close, just before
we remove POSIX locks:

-------------8<-----------------
int filp_close(struct file *filp, fl_owner_t id)
{
        int retval =3D 0;

        if (!file_count(filp)) {
                printk(KERN_ERR "VFS: Close: file count is 0\n");
                return 0;
        }

        if (filp->f_op->flush)
                retval =3D filp->f_op->flush(filp, id);

        if (likely(!(filp->f_mode & FMODE_PATH))) {
                dnotify_flush(filp, id);
                locks_remove_posix(filp, id);
        }
        fput(filp);
        return retval;
}
-------------8<-----------------

None of the in-kernel filesystems that define a ->flush operation do
anything with the fl_owner_t arg, aside from FUSE which just passes it
along.

ceph-fuse also seems to ignore the lock_owner in its ->flush (not that
it's necessarily a representative sample, but it does support file
locking). My suspicion is that most, if not all FUSE filesystems don't
pay attention to the lock_owner in their ->flush ops.

To be clear, fuse_common.h has this in struct fuse_file_info:

        /** Lock owner id.  Available in locking operations and flush */
        uint64_t lock_owner;

After the proposed change, we'd just change the comment to say:

	/** Lock owner id.  Available in locking operations */

The big question is whether this would negatively affect any FUSE
filesystems in the field.


> There's a feature flag in fuse: FUSE_POSIX_LOCKS.  In theory it's okay
> to remove this feature from the INIT flags, which tells the server
> that the client doesn't support remote POSIX locks.  At that point
> flush wouldn't need the lock owner.
>=20
> I'm not sure if there are any users of this feature, and whether they
> check the feature flag.
>=20
> So it's not easy to deprecate, but maybe we could  start by adding a
> CONFIG_FUSE_REMOTE_POSIX_LOCKS with an appropriate notice.
>=20

This wouldn't obviate FUSE's support for POSIX locks, but I do see a
problem for FUSE here. It looks like FUSE doesn't record POSIX locks in
the local inode. Without that, it'd never unlock due to the optimization
at the start of locks_remove_posix.

That'd be pretty simple to fix though. We could add a fstype flag that
just says "don't trust that list_empty check and always unlock". We'd
set that for FUSE and you'd still get the whole-file unlock call down to
the fs for any inode with a file_lock_context.
--=20
Jeff Layton <jlayton@kernel.org>
