Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C9C54F0C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 07:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380171AbiFQFt7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 01:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiFQFt6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 01:49:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738D75AA76;
        Thu, 16 Jun 2022 22:49:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 32E4621A71;
        Fri, 17 Jun 2022 05:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655444996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPlL6nx2bMMLaADut5/dPNviruCWqU5rHCkm1UD7Vl0=;
        b=GkL/kdXdhTXMECEDQfMjojeiBcYmpN+gQZGGaJues+qf5KsJTTLbOcjg/2FNVLWh7FEB2n
        Gj6ItDbt+Ra5QF75KqX9Xq6pS9KLQ//Coztnm1R8Xg3KPRC6XLE45nJJGDDinuRt3q8M/K
        AuoC5UuQnwwJl0oB4Oq4tyrHBNAL/DI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655444996;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPlL6nx2bMMLaADut5/dPNviruCWqU5rHCkm1UD7Vl0=;
        b=cL5YbDoWKM+4SaaiNstdB2MvcaaM3C+IVrH2c2ZUW6oID+W1FZcOtxKnu6vuJPSGoX6lqj
        7QO2fpjZhwaIz0Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D480F1330D;
        Fri, 17 Jun 2022 05:49:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fLptJAEWrGImVQAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 17 Jun 2022 05:49:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Daire Byrne" <daire@dneg.com>,
        Anna Schumaker <schumaker.anna@gmail.com>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 00/12] Allow concurrent directory updates.
In-reply-to: <CAPt2mGOw_PS-5KY-9WFzGOT=ax6PFhVYSTQG-dpXzV5MeGieYg@mail.gmail.com>
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>,
 <CAPt2mGNjWXad6e7nSUTu=0ez1qU1wBNegrntgHKm5hOeBs5gQA@mail.gmail.com>,
 <165534094600.26404.4349155093299535793@noble.neil.brown.name>,
 <CAPt2mGOw_PS-5KY-9WFzGOT=ax6PFhVYSTQG-dpXzV5MeGieYg@mail.gmail.com>
Date:   Fri, 17 Jun 2022 15:49:41 +1000
Message-id: <165544498126.26404.7712330810213588882@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 16 Jun 2022, Daire Byrne wrote:
>=20
> I double checked that the patch had been applied and I hadn't made a
> mistake with installation.

:-) always worth double checking...

>=20
> I could perhaps try running with just the VFS patches to see if I can
> still reproduce the "local" VFS hang without the nfsd patches? Your
> previous VFS only patchset was stable for me.

I've made quite a few changes since that VFS-only patches.  Almost
certainly the problem is not in the nfsd code.

I think that following has a reasonable chance of making things better,
both for the problem you hit and the problem Anna hit.  I haven't tested
it at all yet so no promises - up to you if you try it.

Thanks to both of you for the help with testing.

NeilBrown
=20

diff --git a/fs/namei.c b/fs/namei.c
index 31ba4dbedfcf..6d0c955d407a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1609,7 +1609,7 @@ static struct dentry *__lookup_hash(const struct qstr *=
name,
 	if (IS_ERR(dentry))
 		return dentry;
=20
-	if (wq && d_in_lookup(dentry))
+	if (wq && !d_in_lookup(dentry))
 		/* Must have raced with another thread doing the lookup */
 		return dentry;
=20
@@ -1664,6 +1664,7 @@ static struct dentry *lookup_hash_update(const struct q=
str *name,
 	}
 	if (flags & LOOKUP_EXCL) {
 		if (d_is_positive(dentry)) {
+			d_lookup_done(dentry);
 			dput(dentry);
 			err =3D -EEXIST;
 			goto out_err;
@@ -1671,6 +1672,7 @@ static struct dentry *lookup_hash_update(const struct q=
str *name,
 	}
 	if (!(flags & LOOKUP_CREATE)) {
 		if (!dentry->d_inode) {
+			d_lookup_done(dentry);
 			dput(dentry);
 			err =3D -ENOENT;
 			goto out_err;
@@ -1687,6 +1689,8 @@ static struct dentry *lookup_hash_update(const struct q=
str *name,
 	}
 	if (err2) {
 		err =3D err2;
+		d_lookup_done(dentry);
+		d_unlock_update(dentry);
 		dput(dentry);
 		goto out_err;
 	}
@@ -3273,6 +3277,7 @@ static struct dentry *lock_rename_lookup(struct dentry =
*p1, struct dentry *p2,
 		}
 		return NULL;
 	out_unlock_2:
+		d_lookup_done(d1);
 		dput(d1);
 		d1 =3D d2;
 	out_unlock_1:
@@ -3315,6 +3320,7 @@ static struct dentry *lock_rename_lookup(struct dentry =
*p1, struct dentry *p2,
 	*d2p =3D d2;
 	return p;
 unlock_out_4:
+	d_lookup_done(d1);
 	dput(d1);
 	d1 =3D d2;
 unlock_out_3:
