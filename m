Return-Path: <linux-fsdevel+bounces-44324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C56F6A67614
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 15:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C88D883153
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 14:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9146E20DD7D;
	Tue, 18 Mar 2025 14:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJUuKkQ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789520D519;
	Tue, 18 Mar 2025 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307203; cv=none; b=sS6bx+iloITV9xeVq4Mal3D9vcf2m+kqdN8OQqLH717V9INKCFWPeyiPv5TOa+Ni45F1KQUsNSKqmSfdVK12W1BozfRf521KjUG8mD18TER5B28a6VqkdM0eZa3jIkxPgOvhvplDqN1E9vnEdTK8u5qONYY0zw1NeDd7zwd2yqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307203; c=relaxed/simple;
	bh=UNbAmU2ybVAucOJ5vVVEiENUGebkcj0BNaQ6AbP4bmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtXt0lYQfi9QH1Ero4xhJ6V3dvMzkKmnlogT4UVP9IbkW3uycsO3rHo7CnkhgULZZknB+7+EsbKzcX/gsBV7GnQ6H7R2jgsozNrIEWs8VXJ4nWXNnf4C7wG2nF7QWKIdfkzPSXgZd99sPaSMisOkqArV5eDMytl0Rzv3rgBDZj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJUuKkQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6B4C4CEDD;
	Tue, 18 Mar 2025 14:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742307202;
	bh=UNbAmU2ybVAucOJ5vVVEiENUGebkcj0BNaQ6AbP4bmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJUuKkQ/i9prlUo4xbGfxy933izuSgRUXGhcG3M96o4cH6ebLUmDeiv5559u8y7nx
	 uf/n2G5imcyCUw++Tmliq8zpivIy4A9RkDtzs0L2ZO3PLRfZh/PHDvwW1680FUr1Pl
	 GQlEoZUeHxuIWTikowkZM1Vv+btt+XJyiottOn7gdhxB8hRvhapKBoxc8hi41XPU1a
	 nWiNTMs2sSYBjA4P+vWb+SHOYFwu2OHiguLK2g46QBm5mTtJ2kPlWETHa1t3Ez5PFT
	 UqDZ0rq9BkgTkvjcVc5637K2SMP6HlsaNB1Y5UcLAgrKEKrIToMh/rjzupfXcVEJoj
	 m5QA/WlCLAeVw==
Date: Tue, 18 Mar 2025 15:13:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Ard Biesheuvel <ardb@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Ryan Lee <ryan.lee@canonical.com>, Malte =?utf-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>
Subject: Re: [PATCH] efivarfs: fix NULL dereference on resume
Message-ID: <20250318-ovale-ausziehen-94ede9b50d75@brauner>
References: <3e998bf87638a442cbc6864cdcd3d8d9e08ce3e3.camel@HansenPartnership.com>
 <20250318033738.GV2023217@ZenIV>
 <CAMj1kXHOqzvpUOMTpfQfny10B7M3WnwPYdm1jVX7saP4cy2F=A@mail.gmail.com>
 <20250318074922.GX2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318074922.GX2023217@ZenIV>

> (which is what that vfs_kern_mount() boils down to).  But I would
> very much prefer to have it go over the list of children of ->s_root
> manually, instead of playing silly buggers with iterate_dir().

This is what I suggested earlier in the thread to rewrite it to not rely
on files. That's probably the full-on fix we want later.

