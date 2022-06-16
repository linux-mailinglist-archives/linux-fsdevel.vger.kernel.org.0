Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9173F54D6B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 03:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiFPBD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 21:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356571AbiFPBDj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 21:03:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C7A2FFDC;
        Wed, 15 Jun 2022 18:03:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3989F1FAAF;
        Thu, 16 Jun 2022 00:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655340970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ag5m5a+2z0K0KERFvs1DIq8kLpl4y1mEEs07NPdG8AI=;
        b=duanDr83X78qaYiegZLK2uyIKAtOfoZvf962cfwyNMQSG1WInTAeJTJEJUJSOEea8Cp40k
        vzPrzdVDu1U5ajpk5nWnKg7hBcKuo5iY2l14vj1kFEDSzJDVcLxvMnt6++QODAWlWlJ6RP
        dyzCDTD3jh3m0NyQf5sWIvp+nGCYj7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655340970;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ag5m5a+2z0K0KERFvs1DIq8kLpl4y1mEEs07NPdG8AI=;
        b=4DfCkt3hNcuaspefPQPCA7LSYMFUj0dibas3CIAOQ42w97LFZ48tXs1aQlS/ghUttMXn1D
        WnwxW4LfX80q/wCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48A7F13A35;
        Thu, 16 Jun 2022 00:56:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HZ2XAaZ/qmJLfQAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 16 Jun 2022 00:56:06 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Daire Byrne" <daire@dneg.com>
Cc:     "Al Viro" <viro@zeniv.linux.org.uk>,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "LKML" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 00/12] Allow concurrent directory updates.
In-reply-to: <CAPt2mGNjWXad6e7nSUTu=0ez1qU1wBNegrntgHKm5hOeBs5gQA@mail.gmail.com>
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>,
 <CAPt2mGNjWXad6e7nSUTu=0ez1qU1wBNegrntgHKm5hOeBs5gQA@mail.gmail.com>
Date:   Thu, 16 Jun 2022 10:55:46 +1000
Message-id: <165534094600.26404.4349155093299535793@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 15 Jun 2022, Daire Byrne wrote:
...
> With the patch, the aggregate increases to 15 creates/s for 10 clients
> which again matches the results of a single patched client. Not quite
> a x10 increase but a healthy improvement nonetheless.

Great!

>=20
> However, it is at this point that I started to experience some
> stability issues with the re-export server that are not present with
> the vanilla unpatched v5.19-rc2 kernel. In particular the knfsd
> threads start to lock up with stack traces like this:
>=20
> [ 1234.460696] INFO: task nfsd:5514 blocked for more than 123 seconds.
> [ 1234.461481]       Tainted: G        W   E     5.19.0-1.dneg.x86_64 #1
> [ 1234.462289] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [ 1234.463227] task:nfsd            state:D stack:    0 pid: 5514
> ppid:     2 flags:0x00004000
> [ 1234.464212] Call Trace:
> [ 1234.464677]  <TASK>
> [ 1234.465104]  __schedule+0x2a9/0x8a0
> [ 1234.465663]  schedule+0x55/0xc0
> [ 1234.466183]  ? nfs_lookup_revalidate_dentry+0x3a0/0x3a0 [nfs]
> [ 1234.466995]  __nfs_lookup_revalidate+0xdf/0x120 [nfs]

I can see the cause of this - I forget a wakeup.  This patch should fix
it, though I hope to find a better solution.

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 54c2c7adcd56..072130d000c4 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2483,17 +2483,16 @@ int nfs_unlink(struct inode *dir, struct dentry *dent=
ry)
 	if (!(dentry->d_flags & DCACHE_PAR_UPDATE)) {
 		/* Must have exclusive lock on parent */
 		did_set_par_update =3D true;
+		lock_acquire_exclusive(&dentry->d_update_map, 0,
+				       0, NULL, _THIS_IP_);
 		dentry->d_flags |=3D DCACHE_PAR_UPDATE;
 	}
=20
 	spin_unlock(&dentry->d_lock);
 	error =3D nfs_safe_remove(dentry);
 	nfs_dentry_remove_handle_error(dir, dentry, error);
-	if (did_set_par_update) {
-		spin_lock(&dentry->d_lock);
-		dentry->d_flags &=3D ~DCACHE_PAR_UPDATE;
-		spin_unlock(&dentry->d_lock);
-	}
+	if (did_set_par_update)
+		d_unlock_update(dentry);
 out:
 	trace_nfs_unlink_exit(dir, dentry, error);
 	return error;

>=20
> So all in all, the performance improvements in the knfsd re-export
> case is looking great and we have real world use cases that this helps
> with (batch processing workloads with latencies >10ms). If we can
> figure out the hanging knfsd threads, then I can test it more heavily.

Hopefully the above patch will allow the more heavy testing to continue.
In any case, thanks a lot for the testing so far,

NeilBrown
