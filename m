Return-Path: <linux-fsdevel+bounces-75323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KF5MCrr/c2mA1AAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:09:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AC87B5FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 00:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 932D23006453
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 23:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094EA2E5B3D;
	Fri, 23 Jan 2026 23:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="loB4uze1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="odgeeCoC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF652C08CD;
	Fri, 23 Jan 2026 23:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769209780; cv=none; b=Ea9MGWKtQQbvImUZjnpdjOfReNuLCXMgIN4I/JsNCUloQwDvvEWnNfAr0MufAGClaJcjWSwCEqyUlxt0PQ5Ll4CygASgkwNHgzcUM7DMcvVCi8HSOpTy6bg7kAMvygigSHqOn9traoTGCjw2eQajohL4ZmxS9N4dxbNGmeQhNno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769209780; c=relaxed/simple;
	bh=jMoMs7+t/1zQmhCAHXcMOlVZTqtqaw5888TD/Z2KG1U=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=AffNOHJnqNKqnJJ+R7TemGCpgorXcLkXYbm3GRhwdmLcOxkKQNeUnotqLaiQKyjw/065scbBhwNn2cvgzaCgAZ9g5LsGy6oepz51a9TBjRuNtYgrvhs+D/KpGdjYqxP50BFIwyMyqeR8vLG6US9nmHHHbjoGX/u6GWBmF9+O6CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=loB4uze1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=odgeeCoC; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 421C7EC0175;
	Fri, 23 Jan 2026 18:09:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 23 Jan 2026 18:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm2; t=1769209777; x=
	1769296177; bh=6Hz74XLlXKNuXciR9/DBJO/Te/Fs/bImQLb80n1DAXM=; b=l
	oB4uze1m2uiyeoB2+3PewQUyIT5PehRm5t0WceUVeBu4w4nK2Fen78puDG3PFU9Z
	tsOUTXz5fB+eIj0OQlrATwYAkPaXgKc0Xk5J5ASFw3SWb7WDD/foCVi4rsRTE7j4
	GsuCD/t1RvVqnTHyZWVcBtQyLTdoOBS6SlVd6gRrzgFqt1zOOhgPOqVipWcDAYtE
	Zph/6fOVgf27BlHKSXMz9D+5T2C0DsNMpJoWbPnK9BBhRBhKb7H1J+6b0zx/slyF
	Bo3xOKJrn5Fyc/U9IyG2zwlMTkzKjmXVEvh/6zlZmzfiAsAhkqGh05igJYXjIagf
	S+VjAqOA9gLvthubkckAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1769209777; x=1769296177; bh=6Hz74XLlXKNuX
	ciR9/DBJO/Te/Fs/bImQLb80n1DAXM=; b=odgeeCoCk2XSHBpO8jPLZj75QIV1g
	9DDT3QH2P9EmcNRUfhf0Ai3Znt9wTE3PoYDBT5KElbnPD1lGlvWkAeP8KWch0qqj
	pc799TpdM8fGjyaYtqaFNc2MxiIn1jN3h3mdVJAtkNIM2/25IybKt8VWI4LduPkJ
	nH4CEmuBhtiGmx00Fuju/zKUvEbzPRxzvnDMowR/eo2tcKrz0XPQb3pTb0bVk3g0
	8nYZ33dQAbsw0a07HZQI4gcT1Aat1z7QGysVBfdYOeqQ2FA6Wjptud2Wo/aUhSRF
	shzxgpqX9U3Fw6Cta1Bodber1oQ1+6V7dA3qE3Dm3RCzlp+jDNcWPRHgg==
X-ME-Sender: <xms:sP9zaRwyhBqEmC0UKlan7iip9GKscI6vfDMmEjqFOE38FvkIEpu1lQ>
    <xme:sP9zadJQA4AQ25vWZeJsRYc1s6O11l0w9cAebmLpsfC1IeEzbEhhSN1EEJbsRMmC_
    ygfWVRfZPtApxG9fzBy3X2eRi84jBs6o9UbTfxxQ4IVZ1maeA>
X-ME-Received: <xmr:sP9zaYUwaemFm5uB_ZVRnKbVQyFgpv-dN6I2fmx7nUvUE3nSfXhRWjCnZ49GX0-60cJXsfIRYIJZ1KQzg26VCsAFh7T7gHVOtnwBv3DiiKSV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduhedtfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptgfgggfhvfevufffkfhrsehtqhertddttdejnecuhfhrohhmpefpvghilheurhho
    fihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnhepff
    ehfeettedtieetuedtgeevfffhffdtheelleffffeujedvleevgfdvgfelleeunecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsgesoh
    ifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdgtrhihphhtohesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgt
    phhtthhopehtrhhonhgumhihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhgrhi
    htohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvsghighhgvghrsheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegstghougguihhngheshhgrmhhmvghrshhprggtvgdrtghomh
X-ME-Proxy: <xmx:sP9zaYaRLrEnzWmNnSX6ROZmvsmP5_rTcIrDVEXPaJBKeeZcxyc0dw>
    <xmx:sP9zaXyTa2ut9LtRNkYdSdSBRuYU3Fiv3mcpiSc8VaJ41g5HZEmXOg>
    <xmx:sP9zaQ1xTRTdkzi7hZ1mwTW7QZG9XQygN7BSwG-pwFFgbuM34UZ-cQ>
    <xmx:sP9zaQlnEf2uqyi5zc4Ar8-8ydbSo0FFGxDndWT5ampzpwGv7ytbLA>
    <xmx:sf9zadw0XYSfQUu5zQ-kVvEt57whPCmyM9ACy5muSftQvvwdANH90AC4>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 18:09:33 -0500 (EST)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>,
 Benjamin Coddington <bcodding@hammerspace.com>,
 Eric Biggers <ebiggers@kernel.org>, Rick Macklem <rick.macklem@gmail.com>
Cc: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Subject: [PATCH/RFC] nfsd: rate limit requests that result in -ESTALE from the
 filesystem
Date: Sat, 24 Jan 2026 10:09:31 +1100
Message-id: <176920977124.16766.1785815212991547773@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ownmail.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[ownmail.net:s=fm2,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-75323-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,brown.name,hammerspace.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[ownmail.net];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neilb@ownmail.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[ownmail.net:+,messagingengine.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[neil@brown.name];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,brown.name:replyto,brown.name:email,noble.neil.brown.name:mid]
X-Rspamd-Queue-Id: 84AC87B5FF
X-Rspamd-Action: no action


This is an idea for an alternate approach to address the problem that
Ben is trying to address by signing file handles.

The reasons I think an alternate is worth considering are:

 - Ben's approach requires some configuration, though not much.
   This approach requires zero configuration which is always better.

 - Ben's approach adds a siphash calculation or two to (almost) every
   NFS request.  This may not be a great cost but it is still some time
   and some power.  Less is more.

Filehandles already contain 32 bits of randomness.  Rather than adding
another 64 bits as Ben's patch does, this patch increase the time it
take to test all possible values for those 32 bits to make it an
impractical attack.

Comments welcome.

Thanks,
NeilBrown



From: NeilBrown <neil@brown.name>
Subject: [PATCH] nfsd: rate limit requests that result in -ESTALE from the
 filesystem

NFS file handles typically contain a 32 bit generation number which is
randomly generated by the filesystem when the inode (or inode number) is
allocated.  This makes it hard to guess correct file handles.  Hard but
not impossible on a low latency network with a high speed server.

The NFS server will reject a request to access the file associated with
a filehandle if the user credential given is now allowed the access the
file, but it is not able to check if the user (or client) should be
allowed to even know that filehandle.  This would require knowing all
the paths to a given file, all the credential that the client has access
to, when whether some combination of those credential can complete a
walk down any of the paths.

So the NFS server currently depends on the client to "do the right
thing".

In some circumstances the client may not be sufficiently trusted, and
path-based access controls may be an important part of the access
management strategy.  In these cases the protection provided by nfsd may
not be sufficient.

The only known attack methodology is to guess the inode number of a file
of interest, then iterate over all possible generation numbers.  This
would be expected to achieve success (if the inode number is valid) in,
on average, 2^31 guesses.  At one per microsecond this is less than one
hour.  At one per 10 microseconds this is less than one day.

When presented with an incorrect guess the filesystem with report an
error to nfsd, either NULL or ERR_PTR(-ESTALE).  This patch causes nfsd
to detect those errors and insert a 15ms delay.  It also take a lock so
that all such delays are serialised.  This increases the expected time
to success to 1 year.

Normally NFSERR_STALE errors are rare and are no on a fast path.
Normal accesses which use a filehandle which has become stale will now
incur a 15msec does which is likely to be unnoticeable.  An attack will
notice an intolerable delay.

Possible this code could detect if there are ever a large number of
requests over an extended time and then take more firm action.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/netns.h  |  2 ++
 fs/nfsd/nfsctl.c |  1 +
 fs/nfsd/nfsfh.c  | 15 +++++++++++++++
 3 files changed, 18 insertions(+)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 9fa600602658..f7229d1f9d86 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -219,6 +219,8 @@ struct nfsd_net {
 	/* last time an admin-revoke happened for NFSv4.0 */
 	time64_t		nfs40_last_revoke;
=20
+	struct mutex		estale_rate_limit_mutex;
+
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	/* Local clients to be invalidated when net is shut down */
 	spinlock_t              local_clients_lock;
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 7587c64bf26d..55d25d9b414f 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2198,6 +2198,7 @@ static __net_init int nfsd_net_init(struct net *net)
 	nfsd4_init_leases_net(nn);
 	get_random_bytes(&nn->siphash_key, sizeof(nn->siphash_key));
 	seqlock_init(&nn->writeverf_lock);
+	mutex_init(&nn->estale_rate_limit_mutex);
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	spin_lock_init(&nn->local_clients_lock);
 	INIT_LIST_HEAD(&nn->local_clients);
diff --git a/fs/nfsd/nfsfh.c b/fs/nfsd/nfsfh.c
index ed85dd43da18..7032f65fe21a 100644
--- a/fs/nfsd/nfsfh.c
+++ b/fs/nfsd/nfsfh.c
@@ -244,6 +244,8 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp, =
struct net *net,
 						data_left, fileid_type, 0,
 						nfsd_acceptable, exp);
 		if (IS_ERR_OR_NULL(dentry)) {
+			struct nfsd_net *nn =3D net_generic(net, nfsd_net_id);
+
 			trace_nfsd_set_fh_dentry_badhandle(rqstp, fhp,
 					dentry ?  PTR_ERR(dentry) : -ESTALE);
 			switch (PTR_ERR(dentry)) {
@@ -252,6 +254,19 @@ static __be32 nfsd_set_fh_dentry(struct svc_rqst *rqstp,=
 struct net *net,
 				break;
 			default:
 				dentry =3D ERR_PTR(-ESTALE);
+				/* We limit ESTALE returns to 1 every
+				 * 15 milliseconds (across all threads) to
+				 * prevent a client from guessing the
+				 * correct (32 bit) generation number
+				 * for an given inode in significantly
+				 * less than 1 year.  This ensures clients
+				 * can only access files for which they
+				 * are allowed to access a path from the
+				 * exported root.
+				 */
+				mutex_lock(&nn->estale_rate_limit_mutex);
+				msleep(15);
+				mutex_unlock(&nn->estale_rate_limit_mutex);
 			}
 		}
 	}


