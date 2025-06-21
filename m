Return-Path: <linux-fsdevel+bounces-52373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FF5AE2723
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 04:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D89F7B037A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 02:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F0B153BF0;
	Sat, 21 Jun 2025 02:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdTk4+F0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D67A145B3F;
	Sat, 21 Jun 2025 02:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750473910; cv=none; b=tOpaoAY302tnbPs5wh5JpuJapSjJn+4KKBQprRTG0Y7GaIhGVRcFLmuXXfPQtLUr+sc3jH20My61nJAjo7HjY+u86+xKecKa8Uq1H1VFyK4KxpL0pdVh5V61CZWQvgXXBFmWl2l1AUzKqhLNl9dbzDWpicxZkNHQcyzMpdj8oa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750473910; c=relaxed/simple;
	bh=ArCxk7ADbTRh0TJY4cvHsZszyaAEmGPJmkniRoX3nao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/HAoMkS1DSQzA1YVIUsXgOrQn4AdEHPtPzsHiVgKDgv4GwZ+oHhwhg8uLhO3GjnxArmTgpwaCp42yiSpJy6EFQZs8LMsEUQBXDmBk2uhCNLXbrc/+EumLGDQTK6EIZPNnaENzY9Fucf3ssHb2XwQHU6lV2sgmk+rFWq78pXnII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdTk4+F0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA37DC4CEE3;
	Sat, 21 Jun 2025 02:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750473909;
	bh=ArCxk7ADbTRh0TJY4cvHsZszyaAEmGPJmkniRoX3nao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JdTk4+F0CeQkPV80djCfvpL/3NSZlu7zb5rxgPQe4YiR/h8AUGVFs3RqhqKQIe+8h
	 OxZLNIqQGlIAh1bzFhJMLwJ1J4D5PR/LZewD4t4cHL0TuP5Q8C3ItsstnF+930p15z
	 DRtmfkd++osPxBh+MLoGqO2cjCkicmIIchrhrLInW+JMY0jMRj5C7a6hAkYbUUDkE+
	 SujuxiQg4LyiJfKMv4X5lUtzguzeY6y6yBLWhxPpTd39sWu7pEcyG5h9r3k2TUjtYa
	 pepYTJWXc1sWJ4LNiitQgH5qs9EPEyvbguYVqaeEJVal5lJvNszgedRK5XnpnIlH/r
	 RWYQj7LRBAu1A==
Date: Fri, 20 Jun 2025 16:45:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com,
	gregkh@linuxfoundation.org, daan.j.demeyer@gmail.com
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: Mark cgroup_subsys_state->cgroup
 RCU safe
Message-ID: <aFYctPFTPOg97cjA@slm.duckdns.org>
References: <20250619220114.3956120-1-song@kernel.org>
 <20250619220114.3956120-4-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619220114.3956120-4-song@kernel.org>

On Thu, Jun 19, 2025 at 03:01:12PM -0700, Song Liu wrote:
> Mark struct cgroup_subsys_state->cgroup as safe under RCU read lock. This
> will enable accessing css->cgroup from a bpf css iterator.
> 
> Signed-off-by: Song Liu <song@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

