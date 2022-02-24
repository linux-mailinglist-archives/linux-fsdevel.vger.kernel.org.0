Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916B64C2336
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 06:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiBXFJN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 00:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiBXFJN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 00:09:13 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78E9165C26;
        Wed, 23 Feb 2022 21:08:43 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A53A212B8;
        Thu, 24 Feb 2022 05:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645679322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fvie5WjINF2XGuRYy4JLCTZ9z0jDxYZyBje3chiMYAU=;
        b=1l/5mEs+6B3/VXgYICSwyNHJ7RHI1SknXQ/8jjpB7rdKIdJugA4IqQsyOM1TCV9QVONhfH
        Xyc1z/4fiv56fsMF5dVoEqrD2GG/IRZDdTugEgqLsIgtG+XQrfzewvJpGDqUUpMuBZFC2d
        lHl0Q/7b06PtV/VUSuswlJ2wm6M8vtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645679322;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fvie5WjINF2XGuRYy4JLCTZ9z0jDxYZyBje3chiMYAU=;
        b=PgnnkBfPxMfuL4hmd2LHwGDkf7ie5M5so/ATJb1QG4DdwCINRTFMhTZKevWqG4kJTmgScR
        2ggPnpttKn2uIrBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B63813343;
        Thu, 24 Feb 2022 05:08:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 90EwMtcSF2JTBQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 24 Feb 2022 05:08:39 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>,
        "Daire Byrne" <daire@dneg.com>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>
Subject: Re: [PATCH/RFC] VFS: support parallel updates in the one directory.
In-reply-to: <20220222190751.GA7766@fieldses.org>
References: <164549669043.5153.2021348013072574365@noble.neil.brown.name>,
 <20220222190751.GA7766@fieldses.org>
Date:   Thu, 24 Feb 2022 16:08:36 +1100
Message-id: <164567931673.25116.15009501732764258663@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 23 Feb 2022, J. Bruce Fields wrote:
> For what it's worth, I applied this to recent upstream (038101e6b2cd)
> and fed it through my usual scripts--tests all passed, but I did see
> this lockdep warning.
>=20
> I'm not actually sure what was running at the time--probably just cthon.
>=20
> --b.
>=20
> [  142.679891] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  142.680883] WARNING: possible circular locking dependency detected
> [  142.681999] 5.17.0-rc5-00005-g64e79f877311 #1778 Not tainted
> [  142.682970] ------------------------------------------------------
> [  142.684059] test1/4557 is trying to acquire lock:
> [  142.684881] ffff888023d85398 (DENTRY_PAR_UPDATE){+.+.}-{0:0}, at: d_lock=
_update_nested+0x5/0x6a0
> [  142.686421]=20
>                but task is already holding lock:
> [  142.687171] ffff88801f618bd0 (&type->i_mutex_dir_key#6){++++}-{3:3}, at:=
 path_openat+0x7cb/0x24a0
> [  142.689098]=20
>                which lock already depends on the new lock.
>=20
> [  142.690045]=20
>                the existing dependency chain (in reverse order) is:
> [  142.691171]=20
>                -> #1 (&type->i_mutex_dir_key#6){++++}-{3:3}:
> [  142.692285]        down_write+0x82/0x130
> [  142.692844]        vfs_rmdir+0xbd/0x560
> [  142.693351]        do_rmdir+0x33d/0x400

Thanks.  I hadn't tested rmdir :-)

"rmdir" and "open(O_CREATE)" take these locks in the opposite order.

I think the simplest fix might be to change the inode_lock(_shared) taken
on the dir in open_last_Lookups() to use I_MUTEX_PARENT.  That is
consistent with unlink and rmdir etc which use I_MUTEX_PARENT on the
parent.

open() doesn't currently use I_MUTEX_PARENT because it never needs to
lock the child.  But as it *is* a parent that is being locked, using
I_MUTEX_PARENT probably make more sense.

--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3513,9 +3513,9 @@ static const char *open_last_lookups(struct nameidata *=
nd,
 	}
 	shared =3D !!(dir->d_inode->i_flags & S_PAR_UPDATE);
 	if ((open_flag & O_CREAT) && !shared)
-		inode_lock(dir->d_inode);
+		inode_lock_nested(dir->d_inode, I_MUTEX_PARENT);
 	else
-		inode_lock_shared(dir->d_inode);
+		inode_lock_shared_nested(dir->d_inode, I_MUTEX_PARENT);
 	dentry =3D lookup_open(nd, file, op, got_write);
 	if (!IS_ERR(dentry) && (file->f_mode & FMODE_CREATED))
 		fsnotify_create(dir->d_inode, dentry);

Thanks,
NeilBrown
