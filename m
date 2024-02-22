Return-Path: <linux-fsdevel+bounces-12479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C68685FAD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 15:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B642820D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 14:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC971468F7;
	Thu, 22 Feb 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZa/qNan"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFF312EBC0;
	Thu, 22 Feb 2024 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610996; cv=none; b=DVfxElp7TUJlDWiE3/4OmAltc1IYhCSZz2WamwyThmrHnvyfz6EWN+mTRkhd0dB7fNdAJwiHfsDRh+io7O4pdond3/At6y1PT1KpLx8rK67ppGFJZOYli1OWcqKez+IgtqW47LPW44Jb8AAmlBYcOcwE7hGiarlOjSshlm+rxls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610996; c=relaxed/simple;
	bh=iXuv7bzxq9UHAbkqbOnig6KlGcXIMJhp1qQT805xIFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2Y/MXdXO2Oyzg06EK4EtMIaVHZtb6gg5Ccat1YI/rmWWzSbedhhEGPG99u1rHDq4W0Dmyru5dq8md+ZxdTNqGSrZlBPM3+axS02c1A4q9+XOYPnJf8k3ZLq5WNjWPPZNl113/sedqjldpQlrInmb6/yK0hWCnygxlIlQS6WZ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZa/qNan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59BEC433C7;
	Thu, 22 Feb 2024 14:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708610995;
	bh=iXuv7bzxq9UHAbkqbOnig6KlGcXIMJhp1qQT805xIFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kZa/qNanunrl5R/jQ7FT7/NOrz0HuR1S0Qm965r4gX8dnxNGNCbCQX8n7bsHzF8RH
	 2+6mUfciwdSn9O0ECi5ykW8Xq/jpGsHlyfqZJVKliAlM8j+dy0yMdlzteqzlgi6P2Q
	 CC6DHz97OGXcASqhiFB/hAHs7MiKw4pwQIj6HUqR1BujU78FRXHfrkgD+31MBCsYKp
	 Wlo+DmOR6ygBOug6t4G55K2NXVh1Dbk5uRvHuE4qz7IpuwLCMgLxuK84SQcFSGABOB
	 o0/I+sYjyX6reahh70OpGhZWjaq3OQvAk/M8J8kerCtB4QLUiE4Pcj72EnkQ7MKFpz
	 qcmspxntLc5CQ==
Date: Thu, 22 Feb 2024 15:09:47 +0100
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
Subject: Re: [PATCH v2 01/25] mnt_idmapping: split out core vfs[ug]id_t
 definitions into vfsid.h
Message-ID: <20240222-eilzug-gotik-db1a08e4341f@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-1-3039364623bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221-idmap-fscap-refactor-v2-1-3039364623bd@kernel.org>

On Wed, Feb 21, 2024 at 03:24:32PM -0600, Seth Forshee (DigitalOcean) wrote:
> The rootid member of cpu_vfs_cap_data is a kuid_t, but it should be a
> vfsuid_t as the id stored there is mapped into the mount idmapping. It's
> currently impossible to use vfsuid_t within cred.h though as it is
> defined in mnt_idmapping.h, which uses definitions from cred.h.
> 
> Split out the core vfsid type definitions into a separate file which can
> be included from cred.h.
> 
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>

