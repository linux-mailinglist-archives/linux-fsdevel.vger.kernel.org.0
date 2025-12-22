Return-Path: <linux-fsdevel+bounces-71842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 917C3CD7398
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 857F73015944
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 21:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5AB30FC21;
	Mon, 22 Dec 2025 21:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBi9kc7c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1463A299A8F
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 21:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766440151; cv=none; b=VuKcs0aouzCBJlZPlmST6UZTfeDCLQ2P6rD8EMRPUS3WTEfiOFBDFAOMS2nGeAfEiiOAHcywRJF1uCtzKSyDRKdSbCzcttQczismZfqE0La7bCQumOZMr8SOERL+yYG2JHV/Y036p+n0iktDha/bpSBwWTn3PxcMUNUI2Ms1iBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766440151; c=relaxed/simple;
	bh=AbHyintDQfce/jrMibCP4m6cxdrn7a7eGJY0xaHlHO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfLZjnwg+iWBrFfurhbfHgy8U22xaaqHYfwY6GS/SOuhtzzhtk9c1wMwAASRJOjqsV1RwaUb/+3Djnmy+8nCvfy2nS3mGhVbUo83fUFP7fOuB+wWQkg7dxp9Ozo2FuA1+gFrQX5At1rexp1pFafvWQg/v2ZfnsCPmKGdShTQssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBi9kc7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCC7C4CEF1;
	Mon, 22 Dec 2025 21:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766440150;
	bh=AbHyintDQfce/jrMibCP4m6cxdrn7a7eGJY0xaHlHO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sBi9kc7cRjbCY+JGI7ywjMp1x33UCWWExRCL+N0v4MaAGreYYDr3Lrs68X1Ja8Enn
	 VfFESYEYKn/YN1Re06wCFfEaO/+lFDyxrQr6ta0onGCz4EKygmiE6heKiTjNLkETKW
	 2SnQiXiXeEO4FARluRJmcF4ObI34TeMMsEuhPm//jBFc6GBbEZSY9DZDIKBiU0wg1M
	 21oZ+Pi7wE2HZAXitJibgI33FvTjMi0hsemtbOAutE6HzhosWviMLeg0bCzL0uHR4O
	 H0I52a2vnRnItfY5mlCbsCYqCZQ7vCCu9Vqk4NA2dGXZg6KlOuanzgFQhox19/RdFx
	 s+6kY4eCLQqzA==
Date: Mon, 22 Dec 2025 13:49:07 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] pidfs: simplify PIDFD_GET_<type>_NAMESPACE ioctls
Message-ID: <20251222214907.GA189632@quark>
References: <20251117-eidesstattlich-apotheke-36d2e644079f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117-eidesstattlich-apotheke-36d2e644079f@brauner>

On Mon, Nov 17, 2025 at 01:36:13PM +0100, Christian Brauner wrote:
> We have reworked namespaces sufficiently that all this special-casing
> shouldn't be needed anymore
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

This causes a NULL dereference in nsfs_evict() when CONFIG_NET_NS=n.
Nothing special needed besides that: it happens just when booting the
system, using systemd.

Reverting this commit on mainline fixes the bug.

- Eric

