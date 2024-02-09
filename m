Return-Path: <linux-fsdevel+bounces-10904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7FA84F32A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A63721F22BDA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D1F6994E;
	Fri,  9 Feb 2024 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7+9KYG2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAABA67E87;
	Fri,  9 Feb 2024 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707473870; cv=none; b=LDHY51G3nnsZWZ6cGw8X5O5omVkvtl4AG569M5GsWymxyEJ+yJjqgiIi48WZQ8W9o6dRwUuqhGfuZbximQD5UZp3XgRrVS3zC5qkyC3SKlRFjn+32LU0jxSBtwfai793Gz5GV7VsmMI4aYMazR6lFQBIJzOc0Cr4CEHKrY3looo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707473870; c=relaxed/simple;
	bh=xY37lD56+9JdYRX3k7Qva8TqE72lSWPSgLic4EbY6Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVNUiaoVcc76x/Ddld+38yVnT+lSaKxE02ritY7gCoxgenRow8bg9PyXe8yz1ScOFfwwHzX9PXeU0NUMB4qI33hSCwDRLfZXBQ4H0T1BcCmvEWOaeu6L4YHkq8AY1FSEgf4bhti6SABVlRA9A/88XgKRWXbfQ1Uha6Gv+hFFcyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7+9KYG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566D0C433F1;
	Fri,  9 Feb 2024 10:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707473870;
	bh=xY37lD56+9JdYRX3k7Qva8TqE72lSWPSgLic4EbY6Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J7+9KYG2oEfjQnmP30cpC5yh0acAX9F50LyOGTNhwTALt1myVzitm747OHn8ca0Sf
	 WQKhLGgoLiRUNX9tx76W8sT1atqe7+hxTeQiYI5VKIC4o8KtJQqDvktjZLC4vAyQP2
	 rSBBlzvtspncVURhGkmbuxoA491aDu69wwXDJ5v4MBZmMDgPXIBLq53AFyBq23GltP
	 B7xkn9hA8pGKPLiEXed5s9+4IY2UR4XgyhI6O4SLwL1vC2M12XEDOp+H+sVWnrcbdr
	 f/TE0/RCZuxMnphI4Wuws36bdcrpO/V9KTLSY4l0vUMUd61iWe8oRRGB+jIHEtzXuK
	 mdXdXITQeS73A==
Date: Fri, 9 Feb 2024 11:17:40 +0100
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
Subject: Re: [PATCH v9 10/25] security: Introduce inode_post_setattr hook
Message-ID: <20240209-warnhinweis-randvoll-dbcdc9d16c1d@brauner>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-11-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115181809.885385-11-roberto.sassu@huaweicloud.com>

On Mon, Jan 15, 2024 at 07:17:54PM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_setattr hook.
> 
> At inode_setattr hook, EVM verifies the file's existing HMAC value. At
> inode_post_setattr, EVM re-calculates the file's HMAC based on the modified
> file attributes and other file metadata.
> 
> Other LSMs could similarly take some action after successful file attribute
> change.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/attr.c                     |  1 +

Acked-by: Christian Brauner <brauner@kernel.org>

