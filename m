Return-Path: <linux-fsdevel+bounces-77959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJqBOcFdnGmkEwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77959-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 15:01:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7F71779FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 15:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A33813053B1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B290226B77D;
	Mon, 23 Feb 2026 13:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="O7iWbrkM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEC526CE11;
	Mon, 23 Feb 2026 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854957; cv=none; b=LqzaL+yIwlxAkHEwBraBUqa6WqoKFGk6vUKiVy4WmdtqdEJHl6bxhUdP3YEW+dYIl1zUKIqw+/0WBmcPEUhs9BURwiuHqSSuZLluhMzE/glQt/FDAh1JqYJ0049JuqYCf4IPkcWfChcL12zmtzam6Hz+zat8i0MH15EDd74Q8BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854957; c=relaxed/simple;
	bh=cob0C8Ov+h8656u06111mqzKR1cDutR4IPFn7vbdlZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZSMdRVRYG7AVxwc40Ks8BNMA0fLQ//sgwM5Tq/t0FXrkPuQedfj98ppS43/3BARLJHUAYxEIEfmaYkTYYOuxmrhNu14dejponDVY3E3BfbIhfrp4KgnD3exL68Q0ewgwNcrUSdQ9rMhJQmFvCxScyRs2O7fYyFxj2yNQHwQB+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=O7iWbrkM; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N2DCME2422251;
	Mon, 23 Feb 2026 05:55:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=c1zYe2uBv30hniiOy2AATcivJzhRYWxq08QkgSI+OoM=; b=O7iWbrkMm4tk
	2RCH4QP+2zBMZMAmVpCkKZQjHJ+WY5txycbt9tSHFy+hA61bQuo5oehU/EdTgFvr
	+0T3mOOhe41mRHOqRi6lWvNMOSOb5wjFWYjPe60+r4whTji2axdtE6vmNySdHQjM
	LiUjhTnnGsPjtwxvO+fbtKG9Y3wnDhxjkdWU89BVtlylMYk1ro1GlETET2Vm/q2A
	6eLrsBfuo3df+n8adNnQBdnPIiYiI34MRsUwYgBazfJw4rxXVEPl6QBRmvZf1AcB
	A98EzEen20WvcDY0ZSjCXINVFey9aQXJSy538qpkeiQQ/7XBrtYbOfhnLBh7cXid
	vmAF2XS4GA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cgdwwk975-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 23 Feb 2026 05:55:32 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 23 Feb 2026 13:55:30 +0000
From: Chris Mason <clm@meta.com>
To: NeilBrown <neil@brown.name>
CC: Christian Brauner <brauner@kernel.org>,
        Alexander Viro
	<viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>, Jan Kara
	<jack@suse.cz>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton
	<jlayton@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein
	<amir73il@gmail.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore
	<paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn"
	<serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>, <linux-kernel@vger.kernel.org>,
        <netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
        <linux-nfs@vger.kernel.org>, <linux-unionfs@vger.kernel.org>,
        <apparmor@lists.ubuntu.com>, <linux-security-module@vger.kernel.org>,
        <selinux@vger.kernel.org>
Subject: Re: [PATCH v2 01/15] VFS: note error returns is documentation for various lookup functions
Date: Mon, 23 Feb 2026 05:52:10 -0800
Message-ID: <20260223135517.1229434-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223011210.3853517-2-neilb@ownmail.net>
References: <20260223011210.3853517-1-neilb@ownmail.net> <20260223011210.3853517-2-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3VAPDQqQA9urDNWnBOCbuGLWeYoMbRO9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDExNyBTYWx0ZWRfX4S3buN7Z5VJc
 jXcVuMMKhmmICPL4fOCNdNF5o0+DIGSGFsoIz1K+XpE2dIMgRWbAvMafxzvEE5SgN900SEU6sNj
 0lY5IZUXE4bxGELXRUVaByAVy1poJLTGWq8UzKyS7IKeggwbf3BxhbDyg1oQlzgrkkDwz9/54f9
 O/qnxxrLH/kZvyWp2RiaZxfyrQk0zv6Msk2AyLdEjr7wklkEHwOQvOv+YjIFJUdlKXgfzp5Pzuk
 poaBSL7OVrIxXyGH9sNOtfatZJJ3RAhts+F89zflYZ7NnVNPhf+pPrONOzZILTH6GaoBbAMcG8p
 FwesOaPe+X6to4yiJxCdtGBzPIQZKrC2kKC+V699bCJaWNdf/Ayh0imZi7ADN7vU4BDKEn5aYUI
 70aIqZ4cW/fuHpz9Osi9qNgEWi4W++qzJg8J3KSWERnITEpdG94I2yBA0ohjn/Jqp9LTvIQBSpw
 kfEXyFbrjHMEtRtYGmA==
X-Proofpoint-GUID: 3VAPDQqQA9urDNWnBOCbuGLWeYoMbRO9
X-Authority-Analysis: v=2.4 cv=a+49NESF c=1 sm=1 tr=0 ts=699c5c54 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=I-1mG6jRAAAA:8
 a=v_1R9vC89HT8ZXP7cqwA:9 a=vAntc5lzOlbkVmf1VcWC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_03,2026-02-23_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RSPAMD_URIBL_FAIL(0.00)[ownmail.net:query timed out];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77959-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,brown.name:email]
X-Rspamd-Queue-Id: 7E7F71779FD
X-Rspamd-Action: no action

NeilBrown <neilb@ownmail.net> wrote:
> From: NeilBrown <neil@brown.name>
> 
> Darrick recently noted that try_lookup_noperm() is documented as
> "Look up a dentry by name in the dcache, returning NULL if it does not
> currently exist." but it can in fact return an error.
> 
> So update the documentation for that and related function.
>

Hi everyone,

I don't normally forward the typos, but since this is a documentation-y patch:

commit 0254b9b974f23889898562aa94f6428bf30eb6b5
Author: NeilBrown <neil@brown.name>

VFS: note error returns is documentation for various lookup functions
                       ^^^^^ in?

Darrick recently noted that try_lookup_noperm() is documented as
"Look up a dentry by name in the dcache, returning NULL if it does not
currently exist." but it can in fact return an error. So update the
documentation for that and related function.

Link: https://lore.kernel.org/all/20260218234917.GA6490@frogsfrogsfrogs/

> diff --git a/fs/namei.c b/fs/namei.c
> index 58f715f7657e2..e4ac07a4090e7 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3124,7 +3124,8 @@ static int lookup_one_common(struct mnt_idmap *idmap,
>   * @base:	base directory to lookup from
>   *
>   * Look up a dentry by name in the dcache, returning NULL if it does not
> - * currently exist.  The function does not try to create a dentry and if one
> + * currently exist or an error is there is a problem with the name.
                                       ^^

There's a grammar error: "is there is" should be "if there is".

> + * The function does not try to create a dentry and if one
>   * is found it doesn't try to revalidate it.
>   *
>   * Note that this routine is purely a helper for filesystem usage and should
> @@ -3132,6 +3133,11 @@ static int lookup_one_common(struct mnt_idmap *idmap,
>   *
>   * No locks need be held - only a counted reference to @base is needed.
>   *
> + * Returns:
> + *   - ref-counted dentry on success, or
> + *   - %NULL if name could not be found, or
> + *   - ERR_PTR(-EACCES) if name is dot or dotdot or contains a slash or nul, or
> + *   - ERR_PTR() if fs provide ->d_hash, and this returned an error.
>   */
>  struct dentry *try_lookup_noperm(struct qstr *name, struct dentry *base)
>  {

[ ... ]

> @@ -3208,6 +3214,11 @@ EXPORT_SYMBOL(lookup_one);
>   *
>   * Unlike lookup_one, it should be called without the parent
>   * i_rwsem held, and will take the i_rwsem itself if necessary.
> + *
> + * Returns:= A dentry, possibly negative, or
           ^^^

There's a typo: "Returns:=" should be "Returns:".

> + *	   - same errors as try_lookup_noperm() or
> + *	   - ERR_PTR(-ENOENT) if parent has been removed, or
> + *	   - ERR_PTR(-EACCES) if parent directory is not searchable.
>   */
>  struct dentry *lookup_one_unlocked(struct mnt_idmap *idmap, struct qstr *name,
>  				   struct dentry *base)

[ ... ]

> @@ -3244,6 +3255,10 @@ EXPORT_SYMBOL(lookup_one_unlocked);
>   * It should be called without the parent i_rwsem held, and will take
>   * the i_rwsem itself if necessary.  If a fatal signal is pending or
>   * delivered, it will return %-EINTR if the lock is needed.
> + *
> + * Returns: A dentry, possibly negative, or
> + *	   - same errors as lookup_one_unlocked() or
> + *	   - ERR_PTR(-EINTR) is a fatal signal is pending.
                             ^^

There's a grammar error: "is a fatal signal is pending" should be "if a
fatal signal is pending".

> + */
>  struct dentry *lookup_one_positive_killable(struct mnt_idmap *idmap,
>  					    struct qstr *name,


