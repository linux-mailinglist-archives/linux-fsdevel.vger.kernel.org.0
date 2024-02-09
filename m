Return-Path: <linux-fsdevel+bounces-10902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 948D384F313
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EB15288A8B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63F56994A;
	Fri,  9 Feb 2024 10:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PblVL+e2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E556B67E87;
	Fri,  9 Feb 2024 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707473765; cv=none; b=S0YsvEVnx/l62X2Rzy09U4UT4wkfplaD8BEsLat92l6IgpLye68LE80rQNlLserMXq8HryGoA2nVRCMdR0vKqDhI3nq5LzIRywfM6RpMA3egTGJAvfgNaIP1ypQwn7uCe0PJcV9BNUL/RslU30b10QCNZiUySQiP/wSlDAOjJtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707473765; c=relaxed/simple;
	bh=q8fR1D8+jl7lB6gqzYm90K9sVNvbh2Q3/zJ/S55QVss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gv/py/LWgqGmBCROB1W8NL8wmqak96QMvbg8I6QM3mguGEJiA0OEOxq8Nfx3/9WdiGjKpCKkSmR3OiqUM6TTcM+16a8dwIqsd8ggRVIUZENMlc2irOBQnUv0jOxCpC+RiLX6ru7i+tpS6fgpKmLyyEu9ZpoXfZNXQ3HC4zBCe0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PblVL+e2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0002C433C7;
	Fri,  9 Feb 2024 10:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707473764;
	bh=q8fR1D8+jl7lB6gqzYm90K9sVNvbh2Q3/zJ/S55QVss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PblVL+e2LpOmfBHti6Wm3KE2GCrizQbBpfvUqt+OYDSNEfihR+3XKMUdO/nQZX961
	 mlRlxLgV+5ps3JUhVz0Q0wahDJfcvh1v0LY2w/NNu0uujJMNSv3S/1nbak/tMPrfu8
	 9584RWL3h+JzxPO4gRkhagZjUOVTbza1ZpfYr99wtxAZUiwbaGDxMQWcNhfq37Txqm
	 MdHtmCwkMIvfjiNcXbE6oI9oELUl+8FnmvbAo4VG4y4Hh/NnJalz2rAvVq3je0pocr
	 DRaoz+/9K7LNvJAwP7WnyVb2sOgz6O8xXfNYiy5ywbRuBwHuqM1sK+qI04BiGYK2JD
	 p9etu16D15kJw==
Date: Fri, 9 Feb 2024 11:15:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, chuck.lever@oracle.com, jlayton@kernel.org, 
	neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, 
	stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, 
	mic@digikod.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v9 13/25] security: Introduce file_release hook
Message-ID: <20240209-latent-dachziegel-96a3a9663c7c@brauner>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-14-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115181809.885385-14-roberto.sassu@huaweicloud.com>

On Mon, Jan 15, 2024 at 07:17:57PM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the file_release hook.
> 
> IMA calculates at file close the new digest of the file content and writes
> it to security.ima, so that appraisal at next file access succeeds.
> 
> An LSM could implement an exclusive access scheme for files, only allowing
> access to files that have no references.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/file_table.c               |  1 +
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  4 ++++
>  security/security.c           | 11 +++++++++++
>  4 files changed, 17 insertions(+)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index de4a2915bfd4..c72dc75f2bd3 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -385,6 +385,7 @@ static void __fput(struct file *file)
>  	eventpoll_release(file);
>  	locks_remove_file(file);
>  
> +	security_file_release(file);
>  	ima_file_free(file);

This has always been an extremely dicy hook in here and that's caused us
issues before for stacking filesystems so I'm not enthusiastic about
exposing this to all LSMs. So reluctantly,

Acked-by: Christian Brauner <brauner@kernel.org>

