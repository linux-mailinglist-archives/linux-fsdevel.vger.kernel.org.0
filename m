Return-Path: <linux-fsdevel+bounces-10892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA4284F2B2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A5C282D63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 09:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D0267E87;
	Fri,  9 Feb 2024 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jWD+PSJt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C590DA2A;
	Fri,  9 Feb 2024 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472341; cv=none; b=VuVyaU9uhWIt21ZXlvDoc5dwStP9M2guDm5QdvqUJF0EyiDNyLIM3g/H5FOz6uMCCuGOcT/OcKLUEgfhM5tStlgVlsuqMHyUwmiqBRR8pqNCv1KJ/FoxarCE75f1lLlPE5qIEuHQyN8pFls6A1o4+vfCXD5gYtA/kjHJN0P10H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472341; c=relaxed/simple;
	bh=HBuy4+FyarlMIkakKm+gcSj2tdXPC9SwD5fN9HJf71g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H68Zzbdp+mH4Cwsh+G7pk9h0gOvvzQ8hEnoXg7tvI+tMSuhCTPTtFBmFv6xH1BBDWFDGX0ETeCZikSr+VlLf+hQ9jQXydJP8Wt1FvsAjDvufGLuautmq/g373SskoRHF1HAhwZ4NQUbu3edFBr77xuhgskFe8WDeSW6wWlfDoDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jWD+PSJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECD0C433C7;
	Fri,  9 Feb 2024 09:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707472341;
	bh=HBuy4+FyarlMIkakKm+gcSj2tdXPC9SwD5fN9HJf71g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jWD+PSJt3YwjiKjRzpjSiCqnbeBB0VXyANrDEziqDA4bC5rbN8cTl/Xr9tY29L+fh
	 Y2ImVan6/xVkC9DpJ0W+myNU+Rp/bwfSYONuQsSEwXpdJIgTAURqn8IdL0iDRud6GY
	 0LYFj5b0p2LyQ0wnarpG1sUhH8t/q9jB11CfRmhnVGOfciUzhOdKf2wdpOMZH6nWEC
	 mo/d1oCa85kVQwU+V0/+ya1cbBZZye5SRSWAgF32YVncIouaHAzoJHGIKuuHjQTmu7
	 WDNGFgrcJvMqtg4f9B8HhEGiQBz7baelIKmeDitdNhYlQfzq4rhEp/H3mkmlOai0wm
	 FrVRsNaHJfSNw==
Date: Fri, 9 Feb 2024 10:52:10 +0100
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
Subject: Re: [PATCH v9 17/25] security: Introduce inode_post_remove_acl hook
Message-ID: <20240209-gelee-parken-3ecebd605e73@brauner>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-18-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115181809.885385-18-roberto.sassu@huaweicloud.com>

On Mon, Jan 15, 2024 at 07:18:01PM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_remove_acl hook.
> 
> At inode_remove_acl hook, EVM verifies the file's existing HMAC value. At
> inode_post_remove_acl, EVM re-calculates the file's HMAC with the passed
> POSIX ACL removed and other file metadata.
> 
> Other LSMs could similarly take some action after successful POSIX ACL
> removal.
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

