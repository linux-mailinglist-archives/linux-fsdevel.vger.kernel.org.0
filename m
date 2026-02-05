Return-Path: <linux-fsdevel+bounces-76480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMnOF8XwhGkU6wMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 20:34:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 74393F6DEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 20:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B0070300460C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 19:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59D6327798;
	Thu,  5 Feb 2026 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="X50I8INf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE797DA66;
	Thu,  5 Feb 2026 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770320060; cv=none; b=MfhofzSyHgBQpRmt1X8e0cm+ZGMvseINfOZ+4i9XNJ2oXFlKmUoaeCJC8SNFLZEt2kCx0Klohxga//n3oBJ0xphm2pb2icBag/TevSBAr52yTvND57K8CBUpeOQQY0xR7cJrWLG0qBOW5DY5xaXKO6k3tm/CyWHIC19sU8vVQbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770320060; c=relaxed/simple;
	bh=sgA9JVigetEzKau/miI060aieg4B4yDNULQPwMqJXDk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRVwNZUp1TPkZn3u00QqdM/EZp+q0bDGpcTjN6bc1DCMEfqHrXXVNwFhNdKJga5PDW19AF5/FQne98k29j/Xu8EL/QxTIlETe8ufEOoDDIXyT1X/EXTECSuIunzhbjPQxFyjQg0tgv1IhDd2q/Gu7PFRuvVgRT8g+W4cr93OJcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=X50I8INf; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615JBU932457641;
	Thu, 5 Feb 2026 11:34:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=I2HW0xKLCUkRS87Z6Qcs58SmLqdWZc2lgEgVXRoDtZY=; b=X50I8INftt+c
	u6CjLQywt2jjLAIGVhxK+kIEeoMDlqowle/4bdrrAmhP/YgyiwKiDranivBIdNvr
	NXNPJ9TvQTasXShKHAM2Vi57gvTxQmMBeoSvvCzXtszfFQ+qS/NSw8Gr9NLFtaZ6
	5IZidLQGR1KBsVTIqITVqJEo++GQcJ3dVfSr5LIMBS1fTt6XyV7Qmr+maAAu4LQ/
	0cfWseOWnFMUPUFgN/2HEuAocoYYTLchiu3X1YnNrnI3iiZ9xxVMQL1Uc3GMgRrr
	LcciG2UnZu3JhxJnf+xChE8E/Mze3LdGh+8zSBtjQUTGNGo/VeZEbR4/oldXmmXp
	+njUWZ01OQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c4tvqd4um-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Feb 2026 11:34:05 -0800 (PST)
Received: from devbig003.atn7.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 5 Feb 2026 19:34:04 +0000
From: Chris Mason <clm@meta.com>
To: "Darrick J. Wong" <djwong@kernel.org>
CC: <miklos@szeredi.hu>, <joannelkoong@gmail.com>, <bernd@bsbernd.com>,
        <neal@gompa.dev>, <linux-ext4@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 5/5] fuse: propagate default and file acls on creation
Date: Thu, 5 Feb 2026 11:32:58 -0800
Message-ID: <20260205193349.2227351-1-clm@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <176169809360.1424347.15464466375351097387.stgit@frogsfrogsfrogs>
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs> <176169809360.1424347.15464466375351097387.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NWYhqpHPnzqjVyq-EH48gw88Xkf7y5Fx
X-Proofpoint-ORIG-GUID: NWYhqpHPnzqjVyq-EH48gw88Xkf7y5Fx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE0OCBTYWx0ZWRfX5WPQnW0CvOvj
 TEDTHJ/O5K32oYfga2pm/51cpRXy6GLUbNALS0KDJRHlSJknDDLUa3zgoYo+YnI8YeDDnZRI9qJ
 9vcVrIqI9x7Ee7osOnjWcrHCopX+S6tf4lju+7WJGg0EvE/1XQeRBI+sGbz9OPI648ghJoxXIA1
 wyRDoDwF0IdHajDAoUyZtMRBgoTtj6je0fKKAFBcU74Orpt8DZIuQncRldbiPTmXUV79IxAI+4k
 MdJbfZoiFEEYrPtRTmKzG75s1hqFHq+y19V7Pb5NZAnCsL0g2iQ9aKklWah6J7DEo9xdwquVMiP
 52IwlOuVpd17fuZKzCw+lZPw0nANaw8oLodLC1I/SI9P7jaEuCgSmbxqNq8L/u4pj72IKerxRtr
 bJxm/66DxlFt4q+h4iMuB3NhVn5RGNR632xMolp3F7I0Z4Cfpv/H7fDXcpB3I1y47OfqRlvGDJF
 5P/Kr/VqRx5zw2e5GdQ==
X-Authority-Analysis: v=2.4 cv=W4g1lBWk c=1 sm=1 tr=0 ts=6984f0ad cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=MzGJxgNEI6sSW6s0g1AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76480-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,gompa.dev,vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[meta.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim]
X-Rspamd-Queue-Id: 74393F6DEC
X-Rspamd-Action: no action

"Darrick J. Wong" <djwong@kernel.org> wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> For local filesystems, propagate the default and file access ACLs to new
> children when creating them, just like the other in-kernel local
> filesystems.
> 

Hi everyone,

I'm trying out my AI review prompts on a few more trees, and I ran it
on the fuse-iomap-cache branch:

https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache

This was the latest email lore could find, apologies if I grabbed the wrong one.

Hopefully the review below is useful, please let me know if there are places it
has gone wildly wrong.  I kept the header to make it obvious exactly which
commit I'd run through:

commit 72f7e38b8ab1d52b7e44818ba7db9335bc499476
Author: Darrick J. Wong <djwong@kernel.org>

fuse: propagate default and file acls on creation

For local filesystems, propagate the default and file access ACLs to new
children when creating them, just like the other in-kernel local
filesystems.

> diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
> index 72bb4c94079b7..f2cb7e8db4cad 100644
> --- a/fs/fuse/acl.c
> +++ b/fs/fuse/acl.c

[ ... ]

> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index b2dd3b189246e..3af81a063cc50 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -821,26 +821,28 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
>  	struct fuse_entry_out outentry;
>  	struct fuse_inode *fi;
>  	struct fuse_file *ff;
> +	struct posix_acl *default_acl = NULL, *acl = NULL;
>  	int epoch, err;
>  	bool trunc = flags & O_TRUNC;
>
>  	/* Userspace expects S_IFREG in create mode */
>  	BUG_ON((mode & S_IFMT) != S_IFREG);
>
> +	err = fuse_acl_create(dir, &mode, &default_acl, &acl);
> +	if (err)
> +		return err;
> +
>  	epoch = atomic_read(&fm->fc->epoch);
>  	forget = fuse_alloc_forget();
>  	err = -ENOMEM;
>  	if (!forget)
> -		goto out_err;
> +		goto out_acl_release;
>
>  	err = -ENOMEM;
>  	ff = fuse_file_alloc(fm, true);
>  	if (!ff)
>  		goto out_put_forget_req;
>
> -	if (!fm->fc->dont_mask)
> -		mode &= ~current_umask();
> -
>  	flags &= ~O_NOCTTY;
>  	memset(&inarg, 0, sizeof(inarg));
>  	memset(&outentry, 0, sizeof(outentry));
> @@ -892,12 +894,16 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
>  		fuse_sync_release(NULL, ff, flags);
>  		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
>  		err = -ENOMEM;
> -		goto out_err;
> +		goto out_acl_release;
>  	}
>  	kfree(forget);
>  	d_instantiate(entry, inode);
>  	entry->d_time = epoch;
>  	fuse_change_entry_timeout(entry, &outentry);
> +
> +	err = fuse_init_acls(inode, default_acl, acl);
> +	if (err)
> +		goto out_acl_release;
>  	fuse_dir_changed(dir);
>  	err = generic_file_open(inode, file);
>  	if (!err) {
> @@ -919,7 +925,9 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
>  	fuse_file_free(ff);
>  out_put_forget_req:
>  	kfree(forget);
> -out_err:
> +out_acl_release:
> +	posix_acl_release(default_acl);
> +	posix_acl_release(acl);
>  	return err;
>  }

Does this leak the ACL pointers on the success path? When fuse_acl_create()
allocates non-NULL ACLs (occurs when IS_POSIXACL(dir) &&
fuse_inode_has_local_acls(dir) and the parent directory has default ACLs),
and the file creation succeeds, the function returns directly at 'return
err;' without releasing the ACLs via posix_acl_release().

The cleanup at out_acl_release is only reached on error paths. This would
leak the posix_acl structures on every successful file creation when local
ACLs are enabled.

Compare with create_new_entry() which correctly calls posix_acl_release()
on both success and error paths (lines 1056-1057 and 1065-1066).

> @@ -979,14 +989,18 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
>  	struct fuse_forget_link *forget;
>  	int epoch, err;
>
> -	if (fuse_is_bad(dir))
> -		return ERR_PTR(-EIO);
> +	if (fuse_is_bad(dir)) {
> +		err = -EIO;
> +		goto out_acl_release;
> +	}
>
>  	epoch = atomic_read(&fm->fc->epoch);
>
>  	forget = fuse_alloc_forget();
> -	if (!forget)
> -		return ERR_PTR(-ENOMEM);
> +	if (!forget) {
> +		err = -ENOMEM;
> +		goto out_acl_release;
> +	}
>
>  	memset(&outarg, 0, sizeof(outarg));
>  	args->nodeid = get_node_id(dir);
> @@ -1016,7 +1030,8 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
>  			  &outarg.attr, ATTR_TIMEOUT(&outarg), 0, 0);
>  	if (!inode) {
>  		fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> -		return ERR_PTR(-ENOMEM);
> +		err = -ENOMEM;
> +		goto out_acl_release;
>  	}
>  	kfree(forget);
>
> @@ -1032,19 +1047,31 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
>  		entry->d_time = epoch;
>  		fuse_change_entry_timeout(entry, &outarg);
>  	}
> +
> +	err = fuse_init_acls(inode, default_acl, acl);
> +	if (err)
> +		goto out_acl_release;
>  	fuse_dir_changed(dir);
> +
> +	posix_acl_release(default_acl);
> +	posix_acl_release(acl);
>  	return d;
>
>  out_put_forget_req:
>  	if (err == -EEXIST)
>  		fuse_invalidate_entry(entry);
>  	kfree(forget);
> + out_acl_release:
> +	posix_acl_release(default_acl);
> +	posix_acl_release(acl);
>  	return ERR_PTR(err);
>  }

Chen Linxuan raised a concern in v5 about pairing fuse_acl_create and
posix_acl_release together. While the author's response explained the
design choice to have create_new_entry consume the ACL arguments, there is
a memory leak when d_splice_alias returns an error:

>  		d = d_splice_alias(inode, entry);
>  		if (IS_ERR(d))
>  			return d;

The function returns ERR_PTR without releasing the ACL pointers. The
normal path (lines 1056-1057) and error path (lines 1065-1066) both
release ACLs, but the IS_ERR(d) path at line 1041 does not.

https://lore.kernel.org/all/CAC1kPDOv4sy3NPexFtdoROFi18b98W+PbP+9t8y4Jd5fQqCxCg@mail.gmail.com/

[ ... ]


