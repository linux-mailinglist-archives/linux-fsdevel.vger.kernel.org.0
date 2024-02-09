Return-Path: <linux-fsdevel+bounces-10893-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B514784F2C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6749B1F22C52
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 09:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589B569944;
	Fri,  9 Feb 2024 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoTDYUtU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF1567C44;
	Fri,  9 Feb 2024 09:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472393; cv=none; b=lD+bJkUHvKCx+lE//3Gh/P13RGgED/ULddmybh9jpS6e+YinjLF+c7AJa26YFoEOXD39a84Iqlr2q6zOfExx7KoHYRfIFzo4HQRAjJjXtNQjyys/ttF5IcwDTclj2ptclhGYXTSM4tp2ilDM+1HdxCWE7/qq5buktd5+1RWEMpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472393; c=relaxed/simple;
	bh=F50zsa6+e1nT6wsZ6cj327oxGrMmpGb9BWm/DkP1WnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4OICCJf3xrpzMWRFfbIIsTy4ISG2NZIdma+33X/9ItgMb5KFEJRu8ezK5+zsTgZbUgg7HE9XtF3pF/zOt37Os2uicrSTqvcDTkoEKRQnP5F7QL5rvirWBLX1ReNb8QEwfDa9AfiGsebJzsviA8EXnAnrbYjeXihQjU/7z+VaSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoTDYUtU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337F1C433F1;
	Fri,  9 Feb 2024 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707472393;
	bh=F50zsa6+e1nT6wsZ6cj327oxGrMmpGb9BWm/DkP1WnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uoTDYUtUxBndQdOpPCazNAq3SArSxLev3LxKei5G1B78NIR1YF+TdgjHCk7S6c/Hk
	 V65ct7ks0hFg3wICAnRw8LvzayLRwQ67fixRQVikFKFbKsbUfKRP6zwcq20jj/raNJ
	 ozl8BsB6HJX0svwVcwYort5In6dW6i6MB8CcGhqT7KTvCr1kHSKaZliwvtk/nmpAYY
	 AEBO8jBBzOSHv6S11SERHAPvmOAcb4v+3/vYAqPiVEE22AFBXk9SQWs4G0KG4bVzoM
	 9sgOAjU/HK2dW3iJ/GAj8aSOEGCl9Yp5iOIzA8vTAlwequEteblg8ybM6OCXNT5i+t
	 yKT0/7wjB3Buw==
Date: Fri, 9 Feb 2024 10:53:03 +0100
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
Subject: Re: [PATCH v9 15/25] security: Introduce inode_post_create_tmpfile
 hook
Message-ID: <20240209-vorsorgen-desinfektion-0abc435eec43@brauner>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-16-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115181809.885385-16-roberto.sassu@huaweicloud.com>

On Mon, Jan 15, 2024 at 07:17:59PM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the inode_post_create_tmpfile hook.
> 
> As temp files can be made persistent, treat new temp files like other new
> files, so that the file hash is calculated and stored in the security
> xattr.
> 
> LSMs could also take some action after temp files have been created.
> 
> The new hook cannot return an error and cannot cause the operation to be
> canceled.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/namei.c                    |  1 +

Acked-by: Christian Brauner <brauner@kernel.org>

