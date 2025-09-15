Return-Path: <linux-fsdevel+bounces-61330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 102F0B579A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2D7162DE9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7821D7984;
	Mon, 15 Sep 2025 12:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9RLBFaQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1601C1C4609
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937685; cv=none; b=cSLF7q1WU6oak2WJWfbpsrnrJwJedVVWu4Zl8zzg6QFVXWJNfgd9NvsLn8CLKIq0b03yEfC/vHxe4f1UkLrHvGz5fhPw5x+p2ww39kxCUo6bF/XDoNPI2PxmwtlxoKvnY9kwtrpZZUxqnlhFSHbLaPYoQRQrXOfFh6jK8n+9ywM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937685; c=relaxed/simple;
	bh=UFDzyoGVJEbUuh+4uXeDQN0XAYiKXTygTDXxcGwvTvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XH4aAK3IzhwQZCX49xbeVgwZU51NHULGv6NpEzseJHr+7DMaPiWyXIISPPT/oAglWxTHNQdt/KO3XTLA4arppsYQlvmx+EHlS4f8oaW3GeCAwqvrEOUh3EpVesezCMUXEATkr6NqqvzWL7gXOcr85qSt8AJDPIZlQVxtb0YuQ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9RLBFaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FCBC4CEF7;
	Mon, 15 Sep 2025 12:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757937684;
	bh=UFDzyoGVJEbUuh+4uXeDQN0XAYiKXTygTDXxcGwvTvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9RLBFaQ/dNmo6FLeA1BYNd73iUKASH5YVSpFWwqFZWP3ARtpbpeqXsMr6depm+vp
	 iiiqTV7F/wujcDcqX88QJSsUEOyRk/T/MGbrDgcUfsiYzAlTRDpKwdqul7HEekh+fv
	 Ttb50sITGAKkSwZKs3+jHfHeImw3LRZpCtv2DOu8vPeu/JU/Y6zfBTs5Z3D2obt5km
	 WXYcgEDGkuvivKjwkUFjaSj9k6otsJggbf/TgEMKNkPj6oV2do8vpXINqbQCWIxdbe
	 g5o/6XAxfzTHRG1IEn2rEqkn/Ki+1Tui1+lvVriMthrou0gzgA3Bgfnhb67WvVW/fW
	 zI+fl1OZxFkQQ==
Date: Mon, 15 Sep 2025 14:01:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	torvalds@linux-foundation.org, amir73il@gmail.com, chuck.lever@oracle.com, 
	linkinjeon@kernel.org, john@apparmor.net
Subject: Re: [PATCH 02/21] constify path argument of vfs_statx_path()
Message-ID: <20250915-exkurs-farblich-29cfde07630c@brauner>
References: <20250906090738.GA31600@ZenIV>
 <20250906091137.95554-1-viro@zeniv.linux.org.uk>
 <20250906091137.95554-2-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906091137.95554-2-viro@zeniv.linux.org.uk>

On Sat, Sep 06, 2025 at 10:11:18AM +0100, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

