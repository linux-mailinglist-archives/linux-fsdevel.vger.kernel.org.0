Return-Path: <linux-fsdevel+bounces-77939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEVmGoFVnGlAEQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:26:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC0B176CF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0314A3044BA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BF019D081;
	Mon, 23 Feb 2026 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="uQ3peFVp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB0D1E5714;
	Mon, 23 Feb 2026 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852880; cv=none; b=ujhLqwB7uf9yTiqnt/Rr0HEwMI3iprfdw/IH0MysiGcIri9mOvKMf7YJ1vRAfq6D+2yLG/3cW4gxW1UAIofVMT7Krc5mEWiK0aer3Zprbb2nIOE14K6KW3JYZrgnvQh57NYGUigZdfvW0yDfLuxPbMtnGh1MLimIfB0dgbajP3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852880; c=relaxed/simple;
	bh=iWgTsjCk89uebRcrjCX70k5LZkhHzAYydV7uu88NyCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWvPthM66Z0AqWBwFdV0YA6wWb9kC2jJSrNvTqW0li3SGnEIka7XDyebKHSQtlcHbE3DfHJ3A1oT1Ch2cjQQAddg4At+ZwBPuBaPd3vqGrmUI5zjdoKT8hibcZvPH5f0Kxkq7rGrikzM/XW80pTdTi4555ce4iLu0RPLLrC22NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=uQ3peFVp; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N7LjTw1689366;
	Mon, 23 Feb 2026 05:20:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=+jj35zgXKhtaxe8slFh2KjLza6PRHJYalc4EKFRj1xk=; b=uQ3peFVpfrPv
	P1eNTCmO7sZzHHxSMqkZfrVpKFA1ZEnJiWX/K6a64owsi6ZEvoptl9inCEq4kFSR
	Su3fW5cc6nGdrgVNPCMEUHbdk304q1HIsAN5FKV59LzaXWQZsFEs71Pf7qXlwkbr
	F1H13bcXnIobrOpdVfZtgIPQN5ydQKhi0m9N/GEp8DNUUNu5Rob+j0mAtAx1MUoS
	73kX4wyXHXprW//vO0Qp4cgTVmqpvdF/05FYmEpkjjsqM2FdjNLFT7GqCHFxTynJ
	bR/pXaaD35diR2KJiYAqPbwXBM2QqHLdbXRSVrAGsxgdiHxWZRHZZjVcXqa4V3D4
	puHFLDf/GA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cgjehhvnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 23 Feb 2026 05:20:44 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 23 Feb 2026 13:20:42 +0000
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
Subject: Re: [PATCH v2 09/15] ovl: Simplify ovl_lookup_real_one()
Date: Mon, 23 Feb 2026 05:13:37 -0800
Message-ID: <20260223132027.4165509-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223011210.3853517-10-neilb@ownmail.net>
References: <20260223011210.3853517-1-neilb@ownmail.net> <20260223011210.3853517-10-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDExNCBTYWx0ZWRfX+kME6KZmr89V
 FuKP+HbtK6Ll3Q33VPnvmu6dSF4itJ8mVYWVnJ7GZz07InfaInBIu5fTcVWC3E0zX9IPFY3omT/
 NFDzwO5fxPFfsJlAau4AJFE+l9AIU3wjNX4G3ORzecBxHBbJ8oF+WaRyFx+8A/R3s1DZchoPfZn
 BibQx0Mjpw9jKbymWVR73+564ZbtEGwqzDPmsW7IOuY/8Obw6csoIk2hJfyMafNi5SrOz8czyFJ
 uJ70XH74dPoeTLXMkqjRRdbf1qWlwih5nYz3Hg/ux3VdEAVnTH6MFH+Puak3DUvyCgsTd+5B5ZN
 rWHWmiL/tZIpuwkvGsKU1fAPjFfWQNcucF5wuE/C/bPPnyiF4xRWJPNDkDJWCTjma7twh5jrIJ4
 J19KZBZpHaCGFAR0Vi8F67Zew8QnYtdM0FhaOWXjdsvx/vRaCJFcBkpGw5CiMVv0w84749y9QKq
 0TDcj6dO/tU+Kqu3s2Q==
X-Proofpoint-GUID: Fa5SgpH4NiF5_GiC7hGWmJ-OFXDNqwP8
X-Proofpoint-ORIG-GUID: Fa5SgpH4NiF5_GiC7hGWmJ-OFXDNqwP8
X-Authority-Analysis: v=2.4 cv=cK/tc1eN c=1 sm=1 tr=0 ts=699c542c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=e8O0uTMVAAAA:20 a=I-1mG6jRAAAA:8
 a=jAaqfGSQgQmH2hLIMWsA:9 a=vAntc5lzOlbkVmf1VcWC:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-23_02,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77939-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ownmail.net:email,meta.com:mid,meta.com:dkim,brown.name:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EC0B176CF0
X-Rspamd-Action: no action

NeilBrown <neilb@ownmail.net> wrote:
> From: NeilBrown <neil@brown.name>
> 
> The primary purpose of this patch is to remove the locking from
> ovl_lookup_real_one() as part of centralising all locking of directories
> for name operations.
> 
> The locking here isn't needed.  By performing consistency tests after
> the lookup we can be sure that the result of the lookup was valid at
> least for a moment, which is all the original code promised.
> 
> lookup_noperm_unlocked() is used for the lookup and it will take the
> lock if needed only where it is needed.
> 
> Also:
>  - don't take a reference to real->d_parent.  The parent is
>    only use for a pointer comparison, and no reference is needed for
>    that.
>  - Several "if" statements have a "goto" followed by "else" - the
>    else isn't needed: the following statement can directly follow
>    the "if" as a new statement
>  - Use a consistent pattern of setting "err" before performing a test
>    and possibly going to "fail".
>  - remove the "out" label (now that we don't need to dput(parent) or
>    unlock) and simply return from fail:.

Hi everyone,

Amir asked me to run these through, and this commit was flagged.  I recently
changed the prompts to include some vfs knowledge:

https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/vfs.md

And I also put in some words to make it prefer reporting problems that might
not be bugs, but that do violate some rule in the .md files.  This might
be a false positive from that new shift toward blindly trusting the guides,
but I'll let everyone here decide:

commit d1bfcef048896cdc9e4c57e3249b6ad344d64c02
Author: NeilBrown <neil@brown.name>

ovl: Simplify ovl_lookup_real_one()

This patch removes locking from ovl_lookup_real_one() and reorganizes the
control flow. The function now uses lookup_noperm_unlocked() instead of
lookup_noperm() and performs consistency validation after the lookup rather
than holding a lock during the operation.

> diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
> index 83f80fdb15674..b448fc9424b64 100644
> --- a/fs/overlayfs/export.c
> +++ b/fs/overlayfs/export.c
> @@ -349,69 +349,64 @@ static struct dentry *ovl_dentry_real_at(struct dentry *dentry, int idx)
>  	return NULL;
>  }
>
> -/*
> - * Lookup a child overlay dentry to get a connected overlay dentry whose real
> - * dentry is @real. If @real is on upper layer, we lookup a child overlay
> - * dentry with the same name as the real dentry. Otherwise, we need to consult
> - * index for lookup.
> +/**
> + * ovl_lookup_real_one -  Lookup a child overlay dentry to get an overlay dentry whose real dentry is given
> + * @connected: parent overlay dentry
> + * @real: given child real dentry
> + * @layer: layer in which @real exists
> + *
> + *
> + * Lookup a child overlay dentry in @connected with the same name as the @real
> + * dentry.  Then check that the parent of the result is the real dentry for
> + * @connected, and @real is the real dentry for the result.
> + *
> + * Returns:
> + *   %-ECHILD if the parent of @real is no longer the real dentry for @connected.
> + *   %-ESTALE if @real is no the real dentry of the found dentry.
                                       ^^
There's a typo here: "is no the" should be "is not the".

> + *   Otherwise the found dentry is returned.
>   */
>  static struct dentry *ovl_lookup_real_one(struct dentry *connected,
>  					  struct dentry *real,
>  					  const struct ovl_layer *layer)
>  {
> -	struct inode *dir = d_inode(connected);
> -	struct dentry *this, *parent = NULL;
> +	struct dentry *this;
>  	struct name_snapshot name;
>  	int err;
>
>  	/*
> -	 * Lookup child overlay dentry by real name. The dir mutex protects us
> -	 * from racing with overlay rename. If the overlay dentry that is above
> -	 * real has already been moved to a parent that is not under the
> -	 * connected overlay dir, we return -ECHILD and restart the lookup of
> -	 * connected real path from the top.
> -	 */
> -	inode_lock_nested(dir, I_MUTEX_PARENT);
> -	err = -ECHILD;
> -	parent = dget_parent(real);
> -	if (ovl_dentry_real_at(connected, layer->idx) != parent)
> -		goto fail;
> -
> -	/*
> -	 * We also need to take a snapshot of real dentry name to protect us
> +	 * We need to take a snapshot of real dentry name to protect us
>  	 * from racing with underlying layer rename. In this case, we don't
>  	 * care about returning ESTALE, only from dereferencing a free name
>  	 * pointer because we hold no lock on the real dentry.
>  	 */
>  	take_dentry_name_snapshot(&name, real);
> -	/*
> -	 * No idmap handling here: it's an internal lookup.
> -	 */
> -	this = lookup_noperm(&name.name, connected);
> +	this = lookup_noperm_unlocked(&name.name, connected);
>  	release_dentry_name_snapshot(&name);
> +
> +	err = -ECHILD;
> +	if (ovl_dentry_real_at(connected, layer->idx) != real->d_parent)
> +		goto fail;
> +

A subsystem pattern flags this as potentially concerning: the VFS subsystem
guide indicates that TOCTOU validation checking d_parent should also check
d_unhashed() because a dentry can be unhashed (removed from dcache by
concurrent operations) while its d_parent pointer remains unchanged.

The old code held inode_lock_nested(dir, I_MUTEX_PARENT) during the entire
lookup and validation, which serialized with operations that could unhash the
dentry. The new lockless pattern creates a window where:

1. lookup_noperm_unlocked() completes and returns dentry `this`
2. A concurrent unlink/remove operation unhashes `this`
3. The d_parent validation passes (parent pointer unchanged)
4. The function returns an unhashed dentry

Other overlayfs code uses the complete pattern. For example, in
ovl_lock_rename_workdir() at fs/overlayfs/util.c:

    if (work->d_parent != workdir || d_unhashed(work)) {
        ...
    }

Could this validation miss a race where the dentry is unhashed but d_parent
still matches? The subsequent checks (!this->d_inode for -ENOENT,
wrong real dentry for -ESTALE) might catch some cases, but is that
sufficient for all the scenarios where an unhashed dentry could cause
problems?

>  	err = PTR_ERR(this);
> -	if (IS_ERR(this)) {
> +	if (IS_ERR(this))
>  		goto fail;
> -	} else if (!this || !this->d_inode) {
> -		dput(this);
> -		err = -ENOENT;
> +
> +	err = -ENOENT;
> +	if (!this || !this->d_inode)
>  		goto fail;
> -	} else if (ovl_dentry_real_at(this, layer->idx) != real) {
> -		dput(this);
> -		err = -ESTALE;
> +
> +	err = -ESTALE;
> +	if (ovl_dentry_real_at(this, layer->idx) != real)
>  		goto fail;
> -	}
>
> -out:
> -	dput(parent);
> -	inode_unlock(dir);
>  	return this;
>
>  fail:
>  	pr_warn_ratelimited("failed to lookup one by real (%pd2, layer=%d, connected=%pd2, err=%i)\n",
>  			    real, layer->idx, connected, err);
> -	this = ERR_PTR(err);
> -	goto out;
> +	if (!IS_ERR(this))
> +		dput(this);
> +	return ERR_PTR(err);
>  }
>
>  static struct dentry *ovl_lookup_real(struct super_block *sb,


