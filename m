Return-Path: <linux-fsdevel+bounces-12480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E3F85FAD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 15:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3261F257DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 14:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AC2146904;
	Thu, 22 Feb 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJvtr83C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F69F133983;
	Thu, 22 Feb 2024 14:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708611175; cv=none; b=BnK3WwpbN6nNL6rSA4esugttbj2BUur7Obz6VvE9hEF3fIeYyjCc5mX/oig2qOjS0hvg5/efPe0KtSQwxAcT4O1YPW30u9lkZb/7TWBpMoC0HdxCSd0roZ1jXaZszDbhc6JVdwlLuc4WuhKWUD7R85qKpI4Kz3wW8gE6OCYypGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708611175; c=relaxed/simple;
	bh=Wa/jJ674FywgbCgHjPv9wpvoEmZGaPZHPHxVR47BgcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZs5CvCATk8YsFPjFHwG8P1joqfb22AEZ/j5DQrUrHUQesRsDiHT8mJxdaVMrhUY8cZ96+7cArlqbebnk12BAhVXJYV+fs60ol7n85cz0bAIn4/kM50uK8KIvGEDxj67iRm1tLPgqcT2IJCKgURfnSf6yrs6+kT46nlOwxj3R+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJvtr83C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB59C433F1;
	Thu, 22 Feb 2024 14:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708611174;
	bh=Wa/jJ674FywgbCgHjPv9wpvoEmZGaPZHPHxVR47BgcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sJvtr83CaNl4jLRIvw9WTS1Iulehg1nuCpc8uok7CUvXsf87hFsS+hHK+QvZ2CVIb
	 PaFE1KJH9qhZ6fv7yOJrPEP1m75Cl41bZSj2GvxqkhLKX+WXR9hxB93c+IryFT0nv2
	 GFJ9EnOK18G6XIR3LYh6C+Gs8+568Cwtn0eqZzh3qaNk7ztxPWR0rYOtyWnx75nEvh
	 RONeUWHRQaj673CKMrxHMNVypSkLAHKdyQTTi7pWiv5cqvXYDfGS+/Nd2oWGGpbDCD
	 EiYZ3vgODy2pG/8MvtsZgBEKNPm+X/8ch6gYI9s0zs8HLyjTYgje0nAialqPFXG/XY
	 xMy8fQueLBTLA==
Date: Thu, 22 Feb 2024 15:12:47 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc: Serge Hallyn <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jonathan Corbet <corbet@lwn.net>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, selinux@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 02/25] mnt_idmapping: include cred.h
Message-ID: <20240222-abblitzen-hippen-1244e3ec7c34@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-2-3039364623bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221-idmap-fscap-refactor-v2-2-3039364623bd@kernel.org>

On Wed, Feb 21, 2024 at 03:24:33PM -0600, Seth Forshee (DigitalOcean) wrote:
> mnt_idmapping.h uses declarations from cred.h, so it should include that
> file directly.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>

