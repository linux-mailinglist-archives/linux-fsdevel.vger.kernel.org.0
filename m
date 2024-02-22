Return-Path: <linux-fsdevel+bounces-12482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3B885FB32
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 15:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CCBEB25593
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FB71474C0;
	Thu, 22 Feb 2024 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCe4JnuZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D38A1332AD;
	Thu, 22 Feb 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708611916; cv=none; b=bFTqTiVjZWS9kdDIxpgioFBUz7ifFclZaL8hT+jhXYSWbFGyO24hKY14VcsNdUWBZHSF0Fus1CryMe5cERVreUOSK1wI62NbN2DRkZXtQFrgnmDUvq9KGyYDLXTkRkaiHxRW8hsauCV5mkMcmdK1eO62B+aCp34Tv9r6DYCJoo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708611916; c=relaxed/simple;
	bh=JtPn97F2Ii4Jbu6c1i5egJu0rHoewIinCG21qiikLiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5xoMmOk8k/BSaToAuMiz7mUHR8m7nlL0Z6H9YEk3ysd+mINMb4SJSqkbdcidfOXpRlbQYpYG8OYTDohSbrD7FMBJDFe+NEVrI8PDX2FrzlhLlJB+/KK2dwNTkIFqZ90Hi6Ly+Ii8awSvZVEwUKAEwK1Qe7uMKSpYENn0mZ+27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCe4JnuZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97681C433F1;
	Thu, 22 Feb 2024 14:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708611915;
	bh=JtPn97F2Ii4Jbu6c1i5egJu0rHoewIinCG21qiikLiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCe4JnuZ6f7TvKSPeX6qSl5MwubUKSFW+E62GzuTnfuV8CeU+irIheZ5ugSwG/pgA
	 C6YXsUsVnfD61qqaqYzz3tIf3PUl+rZ5kwKh1SNVrguyyhjBisj3DmUEznDPxR8vjS
	 YPk/9iy0luzVyxs9yBTpRHovHP3XSktGKn5gwjzoQODh9MROWaTUB8EKskF9lPf4Ut
	 prWuraXTx5qQwMX+CPSVplIvlRlGvlvrDeQjewn4FL+uMagdpK7Du/IWEer8RnaeIx
	 YaxV+oxvNORTxMwCnSqHcOuT0I8kQkoRpzJyOuXsoVKFwsDqYJYwF8tairn9Z7lZgR
	 PFYaygpSCqAuA==
Date: Thu, 22 Feb 2024 15:25:08 +0100
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
Subject: Re: [PATCH v2 05/25] capability: use vfsuid_t for vfs_caps rootids
Message-ID: <20240222-inhalieren-einbog-1ab3ab2a9aaf@brauner>
References: <20240221-idmap-fscap-refactor-v2-0-3039364623bd@kernel.org>
 <20240221-idmap-fscap-refactor-v2-5-3039364623bd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240221-idmap-fscap-refactor-v2-5-3039364623bd@kernel.org>

On Wed, Feb 21, 2024 at 03:24:36PM -0600, Seth Forshee (DigitalOcean) wrote:
> The rootid is a kuid_t, but it contains an id which maped into a mount
> idmapping, so it is really a vfsuid. This is confusing and creates
> potential for misuse of the value, so change it to vfsuid_t.
> 
> Acked-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---

Looks good,
Reviewed-by: Christian Brauner <brauner@kernel.org>

