Return-Path: <linux-fsdevel+bounces-36097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0F19DBB3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 17:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41B94B23A00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 16:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FA61C07C6;
	Thu, 28 Nov 2024 16:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hM1B1O6l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B786192B74;
	Thu, 28 Nov 2024 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810978; cv=none; b=h4Q5LC9XXxScMTge91z6QSMerbwOa7+HB6UbukLN3W7js/GUptVudTjlzYESYlvYCNUZL2TqvjI7vURdbQEKj4UscYwUURrx3EJDzqbRg5T4J/0BjOFha0I+GP6M3CFAtdt6KIqycIxQgsl6G+lIRUC5MzK/I51Lo1JMbz9cgSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810978; c=relaxed/simple;
	bh=eFKfAQzJ+nI3CmoQPbJZLdIX3EU+gwJJB2MyeKvvuJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6zq1fhX9Dqgv9un+JEZOvCij17JYI6cdNZmljYVmzP1y+P0WPSGTSgFMkQ3y6v6n0in8w4hA/wg+UDFRcPye0nuhERT2aslskSpe20HgaGC2HshUhLr9jUo1mIiMXeJkMMhCe3nfAR2BuRCiyyXbwBbqcf+we/2KLISLNfdBE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hM1B1O6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA8EC4CED3;
	Thu, 28 Nov 2024 16:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732810977;
	bh=eFKfAQzJ+nI3CmoQPbJZLdIX3EU+gwJJB2MyeKvvuJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hM1B1O6lsJzIferNxlEeHKTmKmnFn18usFz+TDZ1kMXxdfFZVvE6itTeVwIJn0cqN
	 0PFSbl7UxMT2WXHZIvVPApTCm+u9/JNE6AMBbowmUXxQlMj3y+NGbA48ucoUH23y9y
	 7GrfbHgIvrP2qpFw5N8Quwje2pOk2K4MxYKq+IVI5Tx+iPMAtKLc9Z1O/SDef0Bb7i
	 iklQfXn+s8Bn94+Q3Gek7I7ssLXpRwmeOsIJa2RIdFPDQwER0eWuSL2cFmVgVrJWtQ
	 cs5QEiEwvj51YEe4GLd/vtGQf9PITHjRskd+FUqDRdNw0FqI/5SprhH22R2w7PkpiJ
	 qk1LyuQ1PXy6w==
Date: Thu, 28 Nov 2024 17:22:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ima: Discard files opened with O_PATH
Message-ID: <20241128-musikalisch-soweit-7feb366d2c7a@brauner>
References: <20241128100621.461743-1-roberto.sassu@huaweicloud.com>
 <20241128100621.461743-7-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241128100621.461743-7-roberto.sassu@huaweicloud.com>

On Thu, Nov 28, 2024 at 11:06:19AM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> According to man open.2, files opened with O_PATH are not really opened. The
> obtained file descriptor is used to indicate a location in the filesystem
> tree and to perform operations that act purely at the file descriptor
> level.
> 
> Thus, ignore open() syscalls with O_PATH, since IMA cares about file data.
> 
> Cc: stable@vger.kernel.org # v2.6.39.x
> Fixes: 1abf0c718f15a ("New kind of open files - "location only".")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 50b37420ea2c..712c3a522e6c 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -202,7 +202,8 @@ static void ima_file_free(struct file *file)
>  	struct inode *inode = file_inode(file);
>  	struct ima_iint_cache *iint;
>  
> -	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
> +	if (!ima_policy_flag || !S_ISREG(inode->i_mode) ||
> +	    (file->f_flags & O_PATH))
>  		return;
>  
>  	iint = ima_iint_find(inode);
> @@ -232,7 +233,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
>  	enum hash_algo hash_algo;
>  	unsigned int allowed_algos = 0;
>  
> -	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
> +	if (!ima_policy_flag || !S_ISREG(inode->i_mode) ||
> +	    (file->f_flags & O_PATH))
>  		return 0;

if (file->f_mode & FMODE_PATH)

please.

