Return-Path: <linux-fsdevel+bounces-10903-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C13EB84F322
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDAE288D39
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CE46994A;
	Fri,  9 Feb 2024 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXeWNxL0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541B5692E4;
	Fri,  9 Feb 2024 10:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707473837; cv=none; b=X8KpcGkD/jEU25p2OsFDZ7rxbFk7hvq5wh/1N75Rcty97prnvHrNNc4kLvJYxQ+bOKH6PlJksc1DzaIRUe4VyqbHPTHyNClwKgnABExyaBK5hJ+xsz3vLHcbLLGoXdC1tR/0zIImbc1EgYpfcckip/CrBGmDjM3aDQ3b9F9ZaAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707473837; c=relaxed/simple;
	bh=Fb/idb1jz16Rfwn5+L0Y0UqFwZm3zkyH93zlAJfk9p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftkwYY2n2pzRfqFK9KAOoS2zsAzyEchuaLQ2LKAxWK4DSCcHWV08HRkyJ+iZ3ajUKslY2WLDafm9JeOyZh+cAfro1c4z6DN2kNVeFemXNKdRKE0210YhRrbw6pvikJqfauC+FLEN5lGSeAc2Bv+rGuvCJjN6P1moif9szlAe1A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXeWNxL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED705C433F1;
	Fri,  9 Feb 2024 10:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707473836;
	bh=Fb/idb1jz16Rfwn5+L0Y0UqFwZm3zkyH93zlAJfk9p4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JXeWNxL0zUSn9gVGAMLAsbZxf6W4EM3dHfLVD7WtOXydX3R12UF+V+zQbBodsaZjV
	 FbYBzG9DWy7rmYdmS+UTW8Y5Ko/gcae75z1YWiEIYaeUJwir20tSXTl++hOyAfISLN
	 /AqHuA0VV6STaEsj1P2N94U/wjsjsDnrEossfROJ2hhi8xGYyB99LPeZC7dP58uvAD
	 t+ozFILhnLWzhxnwgGBQK9C2kBhAeHQaC0dOIvPmcPk1PC0eJ9MC6yVWdcHS1az8f0
	 8Y/wO4o0LnAyqElp10fAujqHa7wXADfhWUxhF6tYuwrx4SfaZLYH2susKFIpoZ1bUQ
	 JogAqQSRMI7Ew==
Date: Fri, 9 Feb 2024 11:17:07 +0100
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
Subject: Re: [PATCH v9 11/25] security: Introduce inode_post_removexattr hook
Message-ID: <20240209-kostprobe-herzkammer-a05406383e80@brauner>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-12-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115181809.885385-12-roberto.sassu@huaweicloud.com>

On Mon, Jan 15, 2024 at 07:17:55PM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_removexattr hook.
> 
> At inode_removexattr hook, EVM verifies the file's existing HMAC value. At
> inode_post_removexattr, EVM re-calculates the file's HMAC with the passed
> xattr removed and other file metadata.
> 
> Other LSMs could similarly take some action after successful xattr removal.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/xattr.c                    |  9 +++++----

Acked-by: Christian Brauner <brauner@kernel.org>

