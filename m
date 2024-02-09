Return-Path: <linux-fsdevel+bounces-10898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9431F84F2E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2F97B22530
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B789692EF;
	Fri,  9 Feb 2024 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFelY5Gt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47755657B0;
	Fri,  9 Feb 2024 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707472792; cv=none; b=YdDsxoFnHEQ7c+fcDKOj7KNvaY6ar+3Aq+yR8aUg6Yy4XcoLAveVvDKrMSOd9zzetBkiFVWxK1reVtqYVMy8euSpBWBubbyasZovruSTmhnWYUa7oG+Dn00ZIBdDEJdZPFIAdN0DRwjyP90JExgS081OF0mUyTf53SnHwUxVRUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707472792; c=relaxed/simple;
	bh=fY8XhgsREKr/Fhdp2itvjdD+qMPJVaofVRb9lUhD3nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLCrBa67qtc0sRSkBgWL+QDGLyflEnS8htl6QBM8w0QrwHT1DjnwQrYWpwkaHtRxDJHHKNOEAf5mhkLT4GcoHwFUT0Ac1PklKbRcb+seWy38/E7hwaTQ7IJUmaoorJmudpxqbXy0GgoayS7tbUX3o1Gq92FphqlhPPqANAJ/7/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFelY5Gt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEC3C433C7;
	Fri,  9 Feb 2024 09:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707472791;
	bh=fY8XhgsREKr/Fhdp2itvjdD+qMPJVaofVRb9lUhD3nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFelY5Gt/fg78SHCgqTtWzVfzfKWzMGpy8YcZj5oquBVSIPR+KETu7glgxijNPGNY
	 Ygs7huivMiZViTGEUrVjFfvGN//gSsPtQFxH35iRUttJ5gtQSj4/757M5ylKpNRRRj
	 887Dxiogp7d+75aNymSqyWQMlgNk9QO3I9qJ6hkXp794WDgyvN99vJMoQOncHyPAsa
	 7kejYUkWEJr+UTznvlOIqIg0TMduRShwZD8M7kNMnVEhPdZBXmcfiJH0IFBW7slsRL
	 5h5XOmYDAnmPG6ncQC1KWhs/8bgpDv1l5Yx1zVE2FxmJN7JrD4ucQWdlKA9LxU9uBt
	 9qnevPqDlB1AA==
Date: Fri, 9 Feb 2024 10:59:42 +0100
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
Subject: Re: [PATCH v9 12/25] security: Introduce file_post_open hook
Message-ID: <20240209-kunterbunt-abgefackelt-04b54394da2a@brauner>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-13-roberto.sassu@huaweicloud.com>
 <20240209-wertlos-opern-45e9bce87014@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240209-wertlos-opern-45e9bce87014@brauner>

On Fri, Feb 09, 2024 at 10:56:33AM +0100, Christian Brauner wrote:
> On Mon, Jan 15, 2024 at 07:17:56PM +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > In preparation to move IMA and EVM to the LSM infrastructure, introduce the
> > file_post_open hook. Also, export security_file_post_open() for NFS.
> > 
> > Based on policy, IMA calculates the digest of the file content and
> > extends the TPM with the digest, verifies the file's integrity based on
> > the digest, and/or includes the file digest in the audit log.
> > 
> > LSMs could similarly take action depending on the file content and the
> > access mask requested with open().
> > 
> > The new hook returns a value and can cause the open to be aborted.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  fs/namei.c                    |  2 ++
> 
> Acked-by: Christian Brauner <brauner@kernel.org>

Redacting that. I have a question.

