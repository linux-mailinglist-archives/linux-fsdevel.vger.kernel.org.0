Return-Path: <linux-fsdevel+bounces-40222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB7EA20908
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 11:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34781887667
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 10:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB9719F111;
	Tue, 28 Jan 2025 10:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4s8OZHu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245A1991CA;
	Tue, 28 Jan 2025 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738061618; cv=none; b=JERxMGU0I7C+svqDuSesk17lEhQhvB3RNMXWWDscRnhakHTucAdk/VSwAiLSn4fLeYgaMyAVH9y+Eqh/kDeM6h1PF9oQqhBghLZCHIERMIYb08zc2+ETQc6K1BLM9P4fpTHRCqdUDf2D47+x0g6TmUmudGA6AQfn8sxuBwERbEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738061618; c=relaxed/simple;
	bh=00eIms3w6U/reCylURdKda0TahrnMkOHRbYdkatctdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSbP9NeTF4Q+9egs7+UKv5kpWdU8YB7gqCs8OH26fOHl/8ahhP42++8dB+DZ4bA0nCjiqmEb+ut8ngc/NLfyMX7xcH+xq+7L4q/VX1bAzU4qW8pB/SPBPhsP9UEKCH+tEZpuUtxaraBm8wJtbN7fr9/N7x7pTuaxvwfZ0jJGN4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4s8OZHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEE4C4CED3;
	Tue, 28 Jan 2025 10:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738061617;
	bh=00eIms3w6U/reCylURdKda0TahrnMkOHRbYdkatctdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r4s8OZHu2pJ4xxPGZG1zYttv9xsXTbwec5J0uUh79tk2z0BfgMXUkpgRgVphdmSoa
	 YF/R2WauChtdo13cbpda+mENBj7z0yTqnbXiL1Ic9IqQ1bVCwwrCcUFBFlWwsbIzby
	 ckKv/tIU+JcMfI6JcVM9JPfR89dKzDabsyzpyEoA2mnI1cHMhKWZ3TrDDrIv4wbrfT
	 YGR4niztdkPBf66B78geVWSvsY1iM/4x8DE3ZeTPOKWU2jXfoP4dJ/l6uZoKJcyOJu
	 i7Tu/dWKCMVLc9zu7TRsUWDzfGNdsTS1Wq+OcNUz3umJ1KznoQ/X5rmlFpsbDtkhxn
	 pllQ9p5cShsLw==
Date: Tue, 28 Jan 2025 11:53:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, liamwisehart@meta.com, shankaran@meta.com
Subject: Re: [PATCH v10 bpf-next 6/7] bpf: fs/xattr: Add BPF kfuncs to set
 and remove xattrs
Message-ID: <20250128-hochhalten-ankam-6dcb5832a316@brauner>
References: <20250124202911.3264715-1-song@kernel.org>
 <20250124202911.3264715-7-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250124202911.3264715-7-song@kernel.org>

On Fri, Jan 24, 2025 at 12:29:10PM -0800, Song Liu wrote:
> Add the following kfuncs to set and remove xattrs from BPF programs:
> 
>   bpf_set_dentry_xattr
>   bpf_remove_dentry_xattr
>   bpf_set_dentry_xattr_locked
>   bpf_remove_dentry_xattr_locked
> 
> The _locked version of these kfuncs are called from hooks where
> dentry->d_inode is already locked. Instead of requiring the user
> to know which version of the kfuncs to use, the verifier will pick
> the proper kfunc based on the calling hook.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---

Seems ok to me,
Acked-by: Christian Brauner <brauner@kernel.org>

