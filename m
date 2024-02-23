Return-Path: <linux-fsdevel+bounces-12546-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342FA860C34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 09:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DB51F22243
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 08:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026A11A28C;
	Fri, 23 Feb 2024 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8qlj/Q/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405811799D;
	Fri, 23 Feb 2024 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676630; cv=none; b=X1Qz4RtlWvIUUbbO3q0MTHkF1EY4mxC3z75Ei2ZWVzrtqIeQTRsuSXKTK3keIPvu/Bp7Me90STChbNIAeU12N+9zJjoBPWKUgpnjWJ/hop55S5NkECh2JjUY+rpRRH+2Hiqk2jRhkWZffgYsjXhaqUbbiIkKAaLhp6QcL19esnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676630; c=relaxed/simple;
	bh=2pRL/DHKpNavrBYCEdxRER3bzRbwjnSyn6+Le6BPexg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ac87q6aZBK/3JNK21bN1j9x/Rf/4nF4bp9bXtZUcO6iFOy2r3z4pn3a8AKwGkaF0uVhfRa11R0uFwtKAT/VxwuBtrDnpq08xb7GSbPDx4egY6VJe2vixl8Y7hKGbvuWbIIWfi7Q+iVGEdhW7v1h3F6hVFso+Y53lLIeSobCxY3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8qlj/Q/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6724CC433C7;
	Fri, 23 Feb 2024 08:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708676629;
	bh=2pRL/DHKpNavrBYCEdxRER3bzRbwjnSyn6+Le6BPexg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8qlj/Q/6twHNGmgMEhqf+gHAUuT1pceqZRy6RPWg+g5+1yAQGO2v7RW9qTnvz3gH
	 GnL3Hppha6HjbhiG49JDkujP9bNdPRFlNagkOllw1++EXolSNuM8IKPZ6/2Nuhxpwk
	 EOaQwj8bQZrl5NagUA2ropmzLvgV0rj6LGLvPNRRPCZokhBDJS8OnSu9qZZhdc/sFt
	 bH1FhG4aD11dzFXA4WiIYCL/ac1hi6Ae/wl5z7mmW59Ub1+EoWslwPn3W1tAjqIhsj
	 YlJim2O3buoF+rsuZy/6sZ8VIgAgKHSMU+GTEcIEm58qK6YW/YHZiTVrXKAN7bDWNp
	 au/oLYyVUv1mg==
Date: Fri, 23 Feb 2024 09:23:42 +0100
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
Subject: Re: [PATCH v2 11/25] security: add hooks for set/get/remove of fscaps
Message-ID: <20240223-anfallen-kegeln-4550c939a31a@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-11-3039364623bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221-idmap-fscap-refactor-v2-11-3039364623bd@kernel.org>

On Wed, Feb 21, 2024 at 03:24:42PM -0600, Seth Forshee (DigitalOcean) wrote:
> In preparation for moving fscaps out of the xattr code paths, add new
> security hooks. These hooks are largely needed because common kernel
> code will pass around struct vfs_caps pointers, which EVM will need to
> convert to raw xattr data for verification and updates of its hashes.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>

