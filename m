Return-Path: <linux-fsdevel+bounces-31875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 869C299C703
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 12:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5E99B245A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 10:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8CE15B966;
	Mon, 14 Oct 2024 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F14vMr94"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8566333998;
	Mon, 14 Oct 2024 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728901121; cv=none; b=lvUOLLhh7HnBLl37IKz66Gg4yYf1PpZzWJd46ITkrWR2NfAgE2l/9ijSDAFo/BeK0HQEuRxyXkpMopDv+CFcJmk/LklDSBBNHclC3FcUg1UJsTiintLBZZ5KT/Db3XEDXKDzgHkSyyEzi4KP1UsftXqfJrOa8W3n7Iw49hu31OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728901121; c=relaxed/simple;
	bh=/LxmiqMGTBpLRueUOAkbswRnRp2fGGnrDCliMJv5WMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4jhBUmkGq+hneH4rid0dGgze/0ihIj7z+D5BVcBFH/SVB4xHbeobzXIugqUBLuf3tBuozeU/s/h4Au9TDdT8Y130LUK04hoDiC8BdKn9VnRiNGBQNKxZzsJN9z3Fsl+TmHDg3UCV986susQAfROEyv+ozxv0fg5X3YVB608V9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F14vMr94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F87C4CEC3;
	Mon, 14 Oct 2024 10:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728901119;
	bh=/LxmiqMGTBpLRueUOAkbswRnRp2fGGnrDCliMJv5WMI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F14vMr94gZPsWIKrgdXC49lx96g7jrPuXLgm3jy6/va/205tTFX8j1PmUmAaoPadR
	 SU9tigi7QeES4NsfdZz6YpqK17+ThJWTFKTfVUzEkNGmHPm1VDrxebiA/kXPUr/o4D
	 CkFhAXhsd8JXi/vSLhl+5t9qJRQuziLET4v1WyrqXkla3M+UZf0DiUcLxU5Hjvk2wB
	 ydckSf7ZTk10n6yTpOP4MI0Hh8VCWOD4jd1OOAeIg0ruQi3ILdUG9dyOep76PSuIeY
	 EtXqPQh2uuKlnxWDWm2RwDCT1DzIHQlSAExqcjB7ueoHtP3ZXSS1SgkxPrywEyL8d5
	 kmm7N6hJW0INw==
Date: Mon, 14 Oct 2024 12:18:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	viro@zeniv.linux.org.uk, jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com
Subject: Re: [PATCH bpf-next 1/2] fs/xattr: bpf: Introduce security.bpf xattr
 name prefix
Message-ID: <20241014-obstgarten-zeigen-1c6576a6034f@brauner>
References: <20241002214637.3625277-1-song@kernel.org>
 <20241002214637.3625277-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241002214637.3625277-2-song@kernel.org>

On Wed, Oct 02, 2024 at 02:46:36PM -0700, Song Liu wrote:
> Introduct new xattr name prefix security.bpf, and enable reading these
> xattrs from bpf kfuncs bpf_get_[file|dentry]_xattr(). Note that
> "security.bpf" could be the name of the xattr or the prefix of the
> name. For example, both "security.bpf" and "security.bpf.xxx" are
> valid xattr name; while "security.bpfxxx" is not valid.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---

Acked-by: Christian Brauner <brauner@kernel.org>

