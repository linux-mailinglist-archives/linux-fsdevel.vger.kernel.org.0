Return-Path: <linux-fsdevel+bounces-10891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A669584F2AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D542A1C239C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 09:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23E667E87;
	Fri,  9 Feb 2024 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPzvnhbm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E962B9B2;
	Fri,  9 Feb 2024 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472283; cv=none; b=DXqZXhhSAj48VScZyMti6yuwJY6YR9mQiYzHyJh0l4jWhxYTdAv9mbDNmJnU9RiJcAGlsIAsQA56pYVVgL99dZspjMsocNl3qdYijngalkoHzazK7mt3NPCovEJRZFa7qkh6PxHGUHyEFVPZNohcGbZ10OZhEQQisuaBAZkzPvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472283; c=relaxed/simple;
	bh=IKT4vcVGbiuP9eIaxYr/R4Z9ogqjELnGdDu9VgtEPuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CxHk6XSx0+Mq+Jdud2YRiZqZQIt+FSazjac4CkpZaKTO3u3/HMHhCrtD0uLUTjrAK3DsW7f51ssaTNPtulL3EgG8cHnMvFQy32y6ThPvkAk58bYUAqtTU7rsna2ZPbuJLLdW1lJYROvCBgNlVyqzIXEChaz+awjeH4bDZsYCvIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPzvnhbm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9624FC43601;
	Fri,  9 Feb 2024 09:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707472282;
	bh=IKT4vcVGbiuP9eIaxYr/R4Z9ogqjELnGdDu9VgtEPuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPzvnhbm+JjsqdOQ8N0VWPKTLxtR0NoF8jHzXPrVd28z09XKjPd+x8bIQ11Eh8bT+
	 5WGPW3i572Cu8Z2kSFXqJNkj6K5f4zQYoPA7VC5xqq56BNiV75PR9vAyetwjPsd0Bt
	 LLcKwrp0XymIZiDUtAo9QiwNNWIzwcbIMISRk/H+KV0M4OeBSucfOqc+4qf6d4u+/Y
	 G5413FIAtfGbiS3i7+5lIPctw4LbwdoWptBvCKcMtyl2Anxox39eKo6DFFksExdvYp
	 fQBzTzOPcUoad7+knXOHgv65MEOziESQDAH9E52bLMcJmVZqSC5CnlSrpHcTiMb0fS
	 XT8AYNquOLgaw==
Date: Fri, 9 Feb 2024 10:51:12 +0100
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
	linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, 
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 16/25] security: Introduce inode_post_set_acl hook
Message-ID: <20240209-computer-wusste-614af0faffcf@brauner>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-17-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115181809.885385-17-roberto.sassu@huaweicloud.com>

On Mon, Jan 15, 2024 at 07:18:00PM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_set_acl hook.
> 
> At inode_set_acl hook, EVM verifies the file's existing HMAC value. At
> inode_post_set_acl, EVM re-calculates the file's HMAC based on the modified
> POSIX ACL and other file metadata.
> 
> Other LSMs could similarly take some action after successful POSIX ACL
> change.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/posix_acl.c                |  1 +

Acked-by: Christian Brauner <brauner@kernel.org>

