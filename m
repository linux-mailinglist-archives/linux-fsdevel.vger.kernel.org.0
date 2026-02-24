Return-Path: <linux-fsdevel+bounces-78290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sI2HMA3anWk0SQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 18:04:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF0318A42F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 18:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D9ED3004F1C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 17:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473843A9605;
	Tue, 24 Feb 2026 17:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sLZSwrLz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9393A8FE1
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771952650; cv=none; b=Z9dWAaAVO9zgUdiDYkPzQHhUsWAxkKu8ZrXX60+GwpapTuYLr9f5vVUxN2V+uPYGF4zAaEaXPE0GpMi3WpSQMkEOZUoQxUI5J00zGMBnLVp0Gd5VGJJhrAYDoqu8u2wlI8GATHHvYy4S1ZwpLh4rSW6TajeiYp7ypPkX4xNecmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771952650; c=relaxed/simple;
	bh=SqzPShHEstlFamEB9LA4insQ+w1yM38vMTVAfaA2e5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5Kx4jBGaaZgkaLMTuY6H31n4qHKvwqvRwLPipyUOTeqcQouM/Uq3vv6kntO39eRYgf0tx453d1fCXQc1H3NpdBFMTbwEGJGT0LDSM4k5TvRBf10EVfvUJQo0IJ0ys4BuRgXIHxx84l7yEvk2NMFSlz9hFtMzr72UtnXaqS+xrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sLZSwrLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66590C116D0;
	Tue, 24 Feb 2026 17:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771952650;
	bh=SqzPShHEstlFamEB9LA4insQ+w1yM38vMTVAfaA2e5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sLZSwrLzXi+ETrkfE/rAYVRBUlptz1wGuBjyZmhsOa+mJhNR1HhJefPYQ15YXG6FJ
	 xR6B5MB2MddIEw7tJrGZlv8RzCFBkd26F8xy33p6myds+ZTxSIqALpFgIz6XjF9F1U
	 nd5vX/P4UD8l2v2roCmYNtWvFyKoWudOn+mzbedZGNk94R6xsu5WEPhJNEosJ+RBEh
	 iyP+uE4KN9eWEbOMdsyarXPGSg1aGLegbYmpjIVMKN4C05MijmdwBJAcn+CJ46tet2
	 YiftZhC+AsVgL7z1Rbpj/OMetTv5BbwertZnqI39N5GxwhFU8lJlZ90v6IuLLygRt4
	 5WY+BZeWWZbJA==
Date: Tue, 24 Feb 2026 17:04:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Guillaume Tucker <gtucker@gtucker.io>, Tejun Heo <tj@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, kunit-dev@googlegroups.com,
	David Gow <davidgow@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: make_task_dead() & kthread_exit()
Message-ID: <9aa90f39-2c13-4e81-94ac-e2f61970b85b@sirena.org.uk>
References: <20260120-work-pidfs-rhashtable-v2-1-d593c4d0f576@kernel.org>
 <0150e237-41d2-40ae-a857-4f97ca664468@gtucker.io>
 <20260224-kurzgeschichten-urteil-976e57a38c5c@brauner>
 <20260224-mittlerweile-besessen-2738831ae7f6@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zzGsHm5qTVBik/ym"
Content-Disposition: inline
In-Reply-To: <20260224-mittlerweile-besessen-2738831ae7f6@brauner>
X-Cookie: An apple a day makes 365 apples a year.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78290-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gtucker.io,kernel.org,gmail.com,zeniv.linux.org.uk,suse.cz,vger.kernel.org,googlegroups.com,google.com,linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: 6AF0318A42F
X-Rspamd-Action: no action


--zzGsHm5qTVBik/ym
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 05:25:21PM +0100, Christian Brauner wrote:

> Ugh, yuck squared.

> IIUC, the bug is a UAF in free_kthread_struct(). It wasn't easy
> detectable until the pidfs rhashtable conversion changed struct pid's
> size and field layout.

Eeew, indeed.  Thanks for figuring this out!

> Fix should be something like

>     void free_kthread_struct(struct task_struct *k)
>     {
>         struct kthread *kthread;
>=20
>         kthread =3D to_kthread(k);
>         if (!kthread)
>             return;
>=20
>     +   if (!list_empty(&kthread->affinity_node)) {
>     +       mutex_lock(&kthread_affinity_lock);
>     +       list_del(&kthread->affinity_node);
>     +       mutex_unlock(&kthread_affinity_lock);
>     +   }
>     +   if (kthread->preferred_affinity)
>     +       kfree(kthread->preferred_affinity);
>=20
>     #ifdef CONFIG_BLK_CGROUP
>         WARN_ON_ONCE(kthread->blkcg_css);
>     #endif
>         k->worker_private =3D NULL;
>         kfree(kthread->full_name);
>         kfree(kthread);
>     }

> The normal kthread_exit() path already unlinks the node. After
> list_del(), the node's pointers are set to LIST_POISON1/LIST_POISON2, so
> list_empty() returns false. To avoid a double-unlink, kthread_exit()
> should use list_del_init() instead of list_del(), so that
> free_kthread_struct()'s list_empty() check correctly detects the
> already-unlinked state.

Confirmed that the above patch plus the list_del_init() change seems to
fix the issue for me, the full patch I tested with is below to confirm.
Feel free to add:

Tested-by: Mark Brown <broonie@kernel.org>

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 20451b624b67..3778fcbc56db 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -147,6 +147,13 @@ void free_kthread_struct(struct task_struct *k)
 	kthread =3D to_kthread(k);
 	if (!kthread)
 		return;
+	if (!list_empty(&kthread->affinity_node)) {
+		mutex_lock(&kthread_affinity_lock);
+		list_del(&kthread->affinity_node);
+		mutex_unlock(&kthread_affinity_lock);
+	}
+	if (kthread->preferred_affinity)
+		kfree(kthread->preferred_affinity);
=20
 #ifdef CONFIG_BLK_CGROUP
 	WARN_ON_ONCE(kthread->blkcg_css);
@@ -325,7 +332,7 @@ void __noreturn kthread_exit(long result)
 	kthread->result =3D result;
 	if (!list_empty(&kthread->affinity_node)) {
 		mutex_lock(&kthread_affinity_lock);
-		list_del(&kthread->affinity_node);
+		list_del_init(&kthread->affinity_node);
 		mutex_unlock(&kthread_affinity_lock);
=20
 		if (kthread->preferred_affinity) {

--zzGsHm5qTVBik/ym
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmd2gQACgkQJNaLcl1U
h9ArVAf+Iawzf0ZYUHr+Uhn6SiAu30xa9CYC/TeAZt4iVm43t22VFtQy52n+6QH3
SD2DtBi5sP5xUOHfZ8kkzRGmC3Bo+3Qdwgy9wcJZLrTy0IrpZpHhk1oAHrONpCJ9
nN+XTLTU8QBW3b7uTikiyfCKu/4f5qq7xEgEcuMo33Q0Q7wpAWf6zINPOIwGX5RS
+7odbXCCdhv7XcPSSWihaJMT3suQgMrnwDlIMbRX+KvpTGlVGujwNyM4CV9SQTYC
YWLM1ZhCPx2mhV46XIn4rxn7XyEQVDlw/s9DJXdIMjTk8GYemm5BPjCTJGZBlCDK
mYWbJ7iua6odSlMMw0wBXliZP2+E1g==
=yPwl
-----END PGP SIGNATURE-----

--zzGsHm5qTVBik/ym--

