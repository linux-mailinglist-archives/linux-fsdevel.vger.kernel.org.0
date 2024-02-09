Return-Path: <linux-fsdevel+bounces-10894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC87D84F2C8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D60A288919
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 09:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F112F67E91;
	Fri,  9 Feb 2024 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kL4I8I47"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAF6664D6;
	Fri,  9 Feb 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472460; cv=none; b=c6YrVaTLJlrs0ij461ns1nIuM/bG2nffo2b3OgKMmuEzpBsk//VSdbm5CPj/z3YS5pe7ngwL9R1mrE7SnWg1V66HuGpEivB0qT+qIWp2kui3UF3bzD0hF0pLAeh0S7ksBw87Pi19mcGnVUK3A4ZhNjKQni8MvxrA1uoSqyIpc6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472460; c=relaxed/simple;
	bh=WwEoZgYHzCrxC+Km70vhRbnfNlWbuXqwpjdl85yjWkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKNxQYUbcHhKRmWNIPawO1lIN4PIYskV+2kOcxGjGLdH1NpnjolfQUGXWS0qkZ2JQM9LqQY39X2mwh2jroTe71ZdjfsbkRZcl45sc7yp0qQlk3lw1QXMp1G2Xb8h8ppZdBANaWzSawsxJFhBkZICGmH9JYW/Atvn6VA3/m5BIUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kL4I8I47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9A7C433C7;
	Fri,  9 Feb 2024 09:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707472459;
	bh=WwEoZgYHzCrxC+Km70vhRbnfNlWbuXqwpjdl85yjWkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kL4I8I478ey5Zpr0mwB0vmii6U2ndGcbowcZKIAfgbNu1VuEuGy5WWefiP0ipdWlT
	 iQ5Dn1xlXBBWSkOu5nACHA/xjeQEexJ3xX0vvh/SVp9dNwrLvFLkFMLlqZE1iy2jkV
	 Isg+5491MeO0UpiN+V8DXV4yvINPZylgkOw9MhpjTDKpH2+fkXheyEjqipqRQEZW1g
	 cLY9mA55fgnOuj4jZPiZZ652HxbScbM/8ubrBAHEOJP12PqKsxvlR2+Ntww5bwsOtg
	 ixp5MK3xm7vFwKOjTlYKLKH/fNvvMvEbbTLRWsI8giJPTUsaXs8ifACn3VesMzlA3o
	 hju9LDkTLxj4Q==
Date: Fri, 9 Feb 2024 10:54:10 +0100
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
Subject: Re: [PATCH v9 14/25] security: Introduce path_post_mknod hook
Message-ID: <20240209-warten-anstreben-54d2c519fba8@brauner>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-15-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115181809.885385-15-roberto.sassu@huaweicloud.com>

On Mon, Jan 15, 2024 at 07:17:58PM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the path_post_mknod hook.
> 
> IMA-appraisal requires all existing files in policy to have a file
> hash/signature stored in security.ima. An exception is made for empty files
> created by mknod, by tagging them as new files.
> 
> LSMs could also take some action after files are created.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/namei.c                    |  5 +++++

Acked-by: Christian Brauner <brauner@kernel.org>

