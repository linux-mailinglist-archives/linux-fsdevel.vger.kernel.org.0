Return-Path: <linux-fsdevel+bounces-10067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE3084776E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1398DB28CBF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 18:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B9D14D445;
	Fri,  2 Feb 2024 18:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gnjQ6rnT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A29A14D42C;
	Fri,  2 Feb 2024 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898461; cv=none; b=bUZK4N5gG3/J6sux5mF90240QViApfAMJ1dj01w/5Q5iykOAqmARL7l2EhAigLRmexQBDm82Nx9gq/mVcj9oH6MzbAcZjt1GA0RmUwoIW6e5N6O4wIfghs8riHG4bsOS5HzdOFvzD6xA4MkhAnrfFWjPnlh7nJ0dd6ewDZKJkvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898461; c=relaxed/simple;
	bh=QZie7bDJjbOlPSiKRl0NruNxTgQ/pAzQQ20lqpepnI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXNCl09Mrc918MhjAvO0add0Sqsmov+aAJhK8HbcbnWFco0Vv5IJepp7Vbf7vuV155QiZplMvUjH8tD+E2gVwye+FN7xWGSQz4UeBCg6fJBcMc1EzKPfj9BLVpJuV2Q9EGusI1SCEAVJlJtbjST7ixDtdQJv+bh7+2fOacsQtig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gnjQ6rnT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i4kd9eGtAs1wPsvn+kBqonJpOUZ4KCNMFHSGzr+hHxc=; b=gnjQ6rnTPVlsWkN5aoxyAOqIXH
	tLS6iWrLkYI/X7dwPxbuxYrEh+BE8v6ytjPUjA95dY19KQJXt0zcmBnvlRMCrx2TqMocQquBO3gXL
	2LFCp0ngm0owGoVGMycZCaGv3ESdscMQ937HOmEhPZzY0i2Ey2beER74LBKZbDkdh/CUHBjYTLtwV
	3jPnL2C9j7PKSojL4C1EUiJ8uf2zw5vkJ2NqIrnMVbbP+5gAGn4ZAofMtf2RHQEFxHCuuKsPv2BvZ
	M7hqRPW6BG9HX5EnL77ao2jNh7U27pIAxz4Wxi+9adjJNLIAXfLOR1au+Pzx78PvxOdXKJjXoXXd6
	Ie+mxI9A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rVyGC-004Ac8-0t;
	Fri, 02 Feb 2024 18:27:32 +0000
Date: Fri, 2 Feb 2024 18:27:32 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-unionfs@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: remove the inode argument to ->d_real() method
Message-ID: <20240202182732.GE2087318@ZenIV>
References: <20240202110132.1584111-1-amir73il@gmail.com>
 <20240202110132.1584111-3-amir73il@gmail.com>
 <20240202160509.GZ2087318@ZenIV>
 <20240202161601.GA976131@ZenIV>
 <063577b8-3d7f-4a7f-8ed7-332601c98122@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <063577b8-3d7f-4a7f-8ed7-332601c98122@linux.ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 02, 2024 at 12:34:15PM -0500, Stefan Berger wrote:

> I suppose this would provide a stable name?
> 
> diff --git a/security/integrity/ima/ima_api.c
> b/security/integrity/ima/ima_api.c
> index 597ea0c4d72f..48ae6911139b 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -244,7 +244,6 @@ int ima_collect_measurement(struct integrity_iint_cache
> *iint,
>         const char *audit_cause = "failed";
>         struct inode *inode = file_inode(file);
>         struct inode *real_inode = d_real_inode(file_dentry(file));
> -       const char *filename = file->f_path.dentry->d_name.name;
>         struct ima_max_digest_data hash;
>         struct kstat stat;
>         int result = 0;
> @@ -313,11 +312,17 @@ int ima_collect_measurement(struct
> integrity_iint_cache *iint,
>                 iint->flags |= IMA_COLLECTED;
>  out:
>         if (result) {
> +               struct qstr *qstr = &file->f_path.dentry->d_name;
> +               char buf[NAME_MAX + 1];
> +
>                 if (file->f_flags & O_DIRECT)
>                         audit_cause = "failed(directio)";
> 
> +               memcpy(buf, qstr->name, qstr->len);
> +               buf[qstr->len] = 0;

	Think what happens if you fetch ->len in state prior to
rename and ->name - after.  memcpy() from one memory object
with length that matches another, UAF right there.

	If you want to take a snapshot of the name, just use
take_dentry_name_snapshot() - that will copy name if it's
short or grab a reference to external name if the length is
>= 40, all of that under ->d_lock to stabilize things.

	Paired with release_dentry_name_snapshot(), to
drop the reference to external name if one had been taken.
No need to copy in long case (external names are never
rewritten) and it's kinder on the stack footprint that
way (56 bytes vs. 256).

	Something like this (completely untested):

fix a UAF in ima_collect_measurement()

->d_name.name can change on rename and the earlier value can get freed;
there are conditions sufficient to stabilize it (->d_lock on denty,
->d_lock on its parent, ->i_rwsem exclusive on the parent's inode,
rename_lock), but none of those are met in ima_collect_measurement().
Take a stable snapshot of name instead.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 597ea0c4d72f..d8be2280d97b 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -244,7 +244,6 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
 	struct inode *real_inode = d_real_inode(file_dentry(file));
-	const char *filename = file->f_path.dentry->d_name.name;
 	struct ima_max_digest_data hash;
 	struct kstat stat;
 	int result = 0;
@@ -313,12 +312,16 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 		iint->flags |= IMA_COLLECTED;
 out:
 	if (result) {
+		struct name_snapshot filename;
+
+		take_dentry_name_snapshot(&filename, file->f_path.dentry);
 		if (file->f_flags & O_DIRECT)
 			audit_cause = "failed(directio)";
 
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode,
-				    filename, "collect_data", audit_cause,
-				    result, 0);
+				    filename.name.name, "collect_data",
+				    audit_cause, result, 0);
+		release_dentry_name_snapshot(&filename);
 	}
 	return result;
 }

