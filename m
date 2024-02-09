Return-Path: <linux-fsdevel+bounces-10889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AD084F29F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABED1F26A1A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 09:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CADC67E80;
	Fri,  9 Feb 2024 09:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tj23qJkh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDBF66B54;
	Fri,  9 Feb 2024 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472215; cv=none; b=qbjEfw6Xk1NCIi+0EDa0XncgYioj2W6s+NTAbWa1yDIkuuDx7L3TxyOEFoMuLbLtoD3WR8ZrsrIwveTkUFVbNNmWW6TjkTMYxv0g5IsNuZrK4KZJ9PVXovjED2BcUg0dgbWkVaE9WqV3uWUiTqaYqQO+zVJ8WLzff11PmgM7EtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472215; c=relaxed/simple;
	bh=p9KT0bMR+IID1hXXuOL2WksmLXvhHF8bNUuC9TAfm+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jD7aMfJg+jSO6Xi+hkqms2kYcuruPgkUHpAbAMvFREMc+MqTEu1DqC5MFaeQMVjyMJqD89K8HOfvPZEkMoM3Uu6Ui6EOHEwEqiabbLu0erQApW5DpnvNJi3mHlhTl0W8bjD1Op4DS3JpPXWU8E08mOsdJOC9f3td6Ig94oNH+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tj23qJkh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD211C433F1;
	Fri,  9 Feb 2024 09:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707472214;
	bh=p9KT0bMR+IID1hXXuOL2WksmLXvhHF8bNUuC9TAfm+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tj23qJkhmVHPXUAdr5N2zoIBOtiVMhgLk0BsGvQiaIvxYCTuSQH5S327SU/teJOgP
	 r0C/F+Xn6q3Y4FVKXDsFRskERs4mjCUAo0lYnxNtnyj2BdDkNe++YOvj6eF/ZeTVcs
	 gQuE8h8p/mThFnYZ1WTPqCxTMpENjFZgzR1MI38U3uWpbO0w06mO0cXGIIRd+EJF+l
	 Kh050UFuf6avm8IK9y0Mp9Up5jIWGUM26zHnw9mgZrzVO362Cl6PT0xJ7gfRoS17nN
	 eEe1iYCUk7M3a79BYQ+vhdXO+IjG+Xazskk5yVi1oUWMOCO+d/biTL7kmxW6pPeRzo
	 CnuniTtr224EQ==
Date: Fri, 9 Feb 2024 10:50:05 +0100
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
Subject: Re: [PATCH v9 20/25] ima: Move to LSM infrastructure
Message-ID: <20240209-zensor-antilopen-e6c5e64b8706@brauner>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-21-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240115181809.885385-21-roberto.sassu@huaweicloud.com>

On Mon, Jan 15, 2024 at 07:18:04PM +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Move hardcoded IMA function calls (not appraisal-specific functions) from
> various places in the kernel to the LSM infrastructure, by introducing a
> new LSM named 'ima' (at the end of the LSM list and always enabled like
> 'integrity').
> 
> Having IMA before EVM in the Makefile is sufficient to preserve the
> relative order of the new 'ima' LSM in respect to the upcoming 'evm' LSM,
> and thus the order of IMA and EVM function calls as when they were
> hardcoded.
> 
> Make moved functions as static (except ima_post_key_create_or_update(),
> which is not in ima_main.c), and register them as implementation of the
> respective hooks in the new function init_ima_lsm().
> 
> Select CONFIG_SECURITY_PATH, to ensure that the path-based LSM hook
> path_post_mknod is always available and ima_post_path_mknod() is always
> executed to mark files as new, as before the move.
> 
> A slight difference is that IMA and EVM functions registered for the
> inode_post_setattr, inode_post_removexattr, path_post_mknod,
> inode_post_create_tmpfile, inode_post_set_acl and inode_post_remove_acl
> won't be executed for private inodes. Since those inodes are supposed to be
> fs-internal, they should not be of interest of IMA or EVM. The S_PRIVATE
> flag is used for anonymous inodes, hugetlbfs, reiserfs xattrs, XFS scrub
> and kernel-internal tmpfs files.
> 
> Conditionally register ima_post_key_create_or_update() if
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is enabled. Also, conditionally register
> ima_kernel_module_request() if CONFIG_INTEGRITY_ASYMMETRIC_KEYS is enabled.
> 
> Finally, add the LSM_ID_IMA case in lsm_list_modules_test.c.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> ---
>  fs/file_table.c                               |   2 -
>  fs/namei.c                                    |   6 -
>  fs/nfsd/vfs.c                                 |   7 --
>  fs/open.c                                     |   1 -

Acked-by: Christian Brauner <brauner@kernel.org>

