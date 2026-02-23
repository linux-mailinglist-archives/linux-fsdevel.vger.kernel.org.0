Return-Path: <linux-fsdevel+bounces-77955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB12ObdWnGkAEQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:31:35 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 465F7176F42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7137830A52B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3A01F2B8D;
	Mon, 23 Feb 2026 13:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="RF0FDuhZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAA23A1D2;
	Mon, 23 Feb 2026 13:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853170; cv=none; b=MVskYky+PdWmhrezkK8yC90QmrYqMZcwja9AV3TWMuriGMqs7YI76J29yaJWWbSCaiF2Lv78HCoLF6GDcnAGFQUyHttLjpBjyh8YjI7d8fp/XaCyHVz/WLNwBC5PnCe80C5ZzFUTzFGz7tXfZTN9u2+yI4Y8jHH6awESVoXcoys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853170; c=relaxed/simple;
	bh=SRAVdDf8NH6dQhsGRvBt/1wpgBOdKC9BirLKSw6L//k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrGIEjfM9bZlkM0qeBDDOXQlzgGI6xUIjD4y2ofXzlLneOnIX5oRsmVkCSxeZpWTTH9FxShSE+63jCO2xdrDFKPvSiAcbqsldC7rdd82U5zYn9WgV30IsmVeCzomxoQnEhgu6r+52LbvMqATsuiY6WZGcVWNs70/Ta7y+Kx0J+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=RF0FDuhZ; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NCxnfE1835072;
	Mon, 23 Feb 2026 05:25:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=t2qu4JKn1z2iQeoE564X+mR26Wg8TVgaWbcVkQrE+7Y=; b=RF0FDuhZejP9
	O5JCFhKqWVKfqcDIItAIaN4aS/uF+/M42J1SaZfNzph56n6gBmQnmkQKTpbDbExY
	7QdsBb8uiVRoHnLbQduUssKI0YdUEX9ylj7Als1zF7UNvq6iR+VdimnNHkpLQash
	4RhHifSCjPSNG+EQMXOa36aJxrH3OJEiynucoT7UXVfV10iHn62j6XyGLTVguqX7
	0jC4Uis0I6fpScsGuFj0ZiVdShOrS6It7Zn5R1zwumY2eeHx7S1Dsc9dsc92Yaz/
	fkeH7pTObYHwdouHXPqHAKhnXs3JpHwkXxb6rOd7Bufrkwa6hp7/CfQHKQ7C7/Ce
	yy6Sd1p3+w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cgqcj0553-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 23 Feb 2026 05:25:49 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Mon, 23 Feb 2026 13:25:47 +0000
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
Subject: Re: [PATCH v2 06/15] selinux: Use simple_start_creating() / simple_done_creating()
Date: Mon, 23 Feb 2026 05:24:41 -0800
Message-ID: <20260223132533.136328-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223011210.3853517-7-neilb@ownmail.net>
References: <20260223011210.3853517-1-neilb@ownmail.net> <20260223011210.3853517-7-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: D5qTdhAt4Lmhg6QxkEqk6H5lNzMRMp0K
X-Authority-Analysis: v=2.4 cv=QqxTHFyd c=1 sm=1 tr=0 ts=699c555d cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=I-1mG6jRAAAA:8 a=VwQbUJbxAAAA:8 a=xVhDTqbCAAAA:8
 a=Gzw8Aq_Vnp1Aj3qmndoA:9 a=vAntc5lzOlbkVmf1VcWC:22 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-ORIG-GUID: D5qTdhAt4Lmhg6QxkEqk6H5lNzMRMp0K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDExNSBTYWx0ZWRfX5fZdKXimKO6+
 kZyko22vbGzQln4wurgc8tw1wzQr7Z/M/sxa8EbahSsn61ubnLHxb8gTJ7VdRxSDu08D3AwU1rY
 fYPR5qpyvuYl/aso5dEMraDpxPhDwEM2FUw26G2Sq34aXTmy17ginzdJjwK2WfiqWNj97HBe9p8
 xzMxfRJJfjVae/wvrk7NxERz6hrtQfIc0UTgUjJyybKoMBwN0ET2QchyBOq7fsFDoBQ6xl8RzCn
 lkdwDSnchrjDt/iAGlZDOY36cOEvSQBZzh6kK0FijItiyaEMAvRFvJ3Y/08YpbztYFsnOJEkB2k
 o/eLu0xtuuBfvhqQuavN/mT0/Mj81CCR9wIXZZF3NKzda21leiHjfJzLzaQPR7bNJSPejFBRgtq
 XjdDDrL5rtOWqzykt0hPhzBdEi9CZv6YlEb+KidoNOC6khhcqIxOTiEFu0wgQOmXNJJVZFBuQMG
 qbs/pm/YTtp7YlcDtHQ==
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
	TAGGED_FROM(0.00)[bounces-77955-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,paul-moore.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ownmail.net:email,meta.com:mid,meta.com:dkim]
X-Rspamd-Queue-Id: 465F7176F42
X-Rspamd-Action: no action

NeilBrown <neilb@ownmail.net> wrote:
> From: NeilBrown <neil@brown.name>
> 
> Instead of explicitly locking the parent and performing a lookup in
> selinux, use simple_start_creating(), and then use
> simple_done_creating() to unlock.
> 

Hi everyone,

Amir suggested I run these through, and this commit was flagged:

commit bc981629767980bbaee2ca3c7348b5a648665a9d
Author: NeilBrown <neil@brown.name>

selinux: Use simple_start_creating() / simple_done_creating()

Instead of explicitly locking the parent and performing a lookup in
selinux, use simple_start_creating(), and then use
simple_done_creating() to unlock.

This extends the region that the directory is locked for, and also
performs a lookup. The lock extension is of no real consequence.
The lookup uses simple_lookup() and so always succeeds. Thus when
d_make_persistent() is called the dentry will already be hashed.
d_make_persistent() handles this case.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 3245cc531555b..7d4f90e5b12a0 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1931,15 +1931,16 @@ static const struct inode_operations swapover_dir_inode_operations = {
>  static struct dentry *sel_make_swapover_dir(struct super_block *sb,
>  						unsigned long *ino)
>  {
> -	struct dentry *dentry = d_alloc_name(sb->s_root, ".swapover");
> +	struct dentry *dentry;
>  	struct inode *inode;
>
> -	if (!dentry)
> +	inode = sel_make_inode(sb, S_IFDIR);
> +	if (!inode)
>  		return ERR_PTR(-ENOMEM);
>
> -	inode = sel_make_inode(sb, S_IFDIR);
> -	if (!inode) {
> -		dput(dentry);
> +	dentry = simple_start_creating(sb->s_root, ".swapover");
> +	if (!dentry) {
> +		iput(inode);
>  		return ERR_PTR(-ENOMEM);
>  	}

Can this cause a kernel crash when simple_start_creating() fails?

The function simple_start_creating() returns ERR_PTR on failure, not
NULL. The check `if (!dentry)` only catches NULL values. When
simple_start_creating() fails and returns an ERR_PTR value like
ERR_PTR(-ENOMEM), this value is non-NULL and the error check is bypassed.

Execution would continue to d_make_persistent(dentry, inode), which
attempts to lock dentry->d_lock, dereferencing the ERR_PTR value and
causing a kernel crash.

The old code used d_alloc_name() which returns NULL on error. The new
code uses simple_start_creating() which returns ERR_PTR on error, but
the error checking pattern wasn't updated to match.

Should the check be `if (IS_ERR(dentry))` instead, and return dentry
rather than ERR_PTR(-ENOMEM) to preserve the actual error code?

>
> @@ -1947,11 +1948,9 @@ static struct dentry *sel_make_swapover_dir(struct super_block *sb,
>  	inode->i_ino = ++(*ino);
>  	/* directory inodes start off with i_nlink == 2 (for "." entry) */
>  	inc_nlink(inode);
> -	inode_lock(sb->s_root->d_inode);
>  	d_make_persistent(dentry, inode);
>  	inc_nlink(sb->s_root->d_inode);
> -	inode_unlock(sb->s_root->d_inode);
> -	dput(dentry);
> +	simple_done_creating(dentry);
>  	return dentry;	// borrowed
>  }


