Return-Path: <linux-fsdevel+bounces-34198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF099C3A15
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 09:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8FA1F221D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 08:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1471616F0D0;
	Mon, 11 Nov 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIHqUfSt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672B216A930;
	Mon, 11 Nov 2024 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731315132; cv=none; b=u80ZW13/F1eLJc/LyrEzBrHu0Jc1wiuOdO08P4qMKIeFq1Sj2W1eCf1ppy4l9zNGWpbFUnarIgGHhY5EV8YHwcIqf9aR2Na+FpHaSiiFlpmM8gdvpesn1MYJAY1VF4+11p3sZpH1t+I7lcpEVlmkAXU8BHCAKblGe9inCp3Pcu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731315132; c=relaxed/simple;
	bh=oE70LvyPHTDoCPA/I9zQ1cQFKLRDfcjfwSpcP91s2gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIpj81EiLb9BZkZFOLj2iQ+b7N9IBThHhfeOrv9jajGVy1C0loEocAD4dXxdFQPMQIOnKwzadK0WIjg1Ymqrvhl1Ubw/XQwrCNnmXYKrI1y6c3wiUTiTQXMxvJ8Pa36mgDmsQFb7V73zb6kHnOuM/LR85JubyoGRLqfZUZ+LwK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIHqUfSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC8EC4CED4;
	Mon, 11 Nov 2024 08:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731315132;
	bh=oE70LvyPHTDoCPA/I9zQ1cQFKLRDfcjfwSpcP91s2gE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iIHqUfStn5kznNiwYjxx7ffPyEpIrUJG9+I3XgiEOzTrHljkcZ4g7IKQzYpLoeU2J
	 ma3cWEynJ9/iZ3TLl/pGc2Ny4CujSyO9vHwiy1f4XZ6c/AohS0V2EenmXlx0XRks0A
	 fHrCNghvbkxDGbr+nKAv2zBB+ncf0I24otDeOi9GKZcjCBSsClZTWO3q20hg4tuULn
	 /3nB5peen2pQSxpj44TM51Ih+TwdizeJ1JddaJGJrL75C86oKRe9vOa+Zgk+TJDZ1a
	 1rkrtV+Wg8L3WVizyBS9DGNhjfR08yqaDarX8BcuRc9TDmjdewLNQzTWzwlujqexh8
	 NF820q5pD8CMA==
Date: Mon, 11 Nov 2024 09:52:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>, 
	fstests@vger.kernel.org, stable@vger.kernel.org, Leah Rumancik <leah.rumancik@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: generic/645 failing on ext4, xfs (probably others) on all LTS
 kernels
Message-ID: <20241111-tragik-busfahren-483825df1c00@brauner>
References: <20241110180533.GA200429@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241110180533.GA200429@mit.edu>

On Sun, Nov 10, 2024 at 01:05:33PM -0500, Theodore Ts'o wrote:
> The test generic/645 is failing on (at least) 6.6, 6.1, 5.15 LTS
> kernels.
> 
> This fix is apparently commit dacfd001eaf2 ("fs/mnt_idmapping.c:
> Return -EINVAL when no map is written"), but in order to take this
> patch, it looks like we need to backport the 4 patch series
> "mnt_idmapping: decouple from namespaces"[1] (and possibly others; I
> haven't tried yet).
> 
> [1] https://lore.kernel.org/all/20231122-vfs-mnt_idmap-v1-0-dae4abdde5bd@kernel.org/
> 
> This looks fairly involved so the questions I have are:
> 
> (1) Should we request this patch series plus commit dacfd001eaf2 into
> the stable kernels --- or should I just add a versioned excludes[2]
> and just skip generic/645 from all kernels older than Linux 6.9 if we
> think it's too involved and/or risky to backport these id mapping
> changes?
> 
> (2) How much do we care that generic/645 is failing on LTS kernels?
> Are user/applications going to notice or care?

No userspace used an empty idmapping and it was unclear whether the
behavior would be well-specified so the patch changed that quite some
time ago.

Backporting this to older LTS kernels isn't difficult. We just need
custom patches for the LTS kernels but they should all be very simple.

Alternatively, you can just ignore the test on older kernels.

