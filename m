Return-Path: <linux-fsdevel+bounces-61725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8576AB5954A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 13:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BA6616D401
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 11:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AC2307AD1;
	Tue, 16 Sep 2025 11:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoNvm5PM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE8B3064A6;
	Tue, 16 Sep 2025 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022489; cv=none; b=BnnTrKy+fOE8Iuj9FqZQMZp/2y7ZXU85PlWiNazp35s8XPg1sSo4mZBAPckxrb+gB9RVcx7rFufUL+PHyTCsUj4Gu0/+VMJBaglv73xFAFXiPnry/YU05IR5GNtabVDlQYBlEZVM3BJZCIrOPrGej48oESPA+Lz37nIJaFgzNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022489; c=relaxed/simple;
	bh=C2VFNh9pG4n1CHA/01gyfSaN+qDLGHCCfe5WiisML6c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gv9Eq9ILxPr1X6gO2VU9PYUb40yrKmCJxUUbjby5kbYnYrAlqBCfQb9fW02rNUtZwY5GgV3nmevG4Fn4tC95Yq4ODohJRGIccFRVCY2p69XgZiGCRn8aYPAQyv4shB2RyBwsdd4sXcH7w8wnW8nEhBtSgzAQmUevfD2KB0ryEPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoNvm5PM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94121C4CEEB;
	Tue, 16 Sep 2025 11:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758022489;
	bh=C2VFNh9pG4n1CHA/01gyfSaN+qDLGHCCfe5WiisML6c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FoNvm5PMCHajQNTMUN+OR08ZdrYXyV2yCuWoBmeyy+6G4r9zhnQK1axIhiPhg+xH5
	 V4nOGSWwFKxXuAh6X7wgGyCjo2V6Fpm3AZdmWTo4Nj/eTlp+yDtUbzfnXv0PAzXitX
	 2kqJyXpL7wii7AvyqD79eJZpHvV89ZhLX1jZQzEdm06FsBxsrHmihXJUyH8gaDN1tY
	 T8PpdFSOAIy2yhraML5cMaw0idYLB2F4Ez8gDlBBELwrTTNxeQZYfAlsM+/SKiVJv0
	 Pcc2lQuMl6O5Ds4WStfqNRe+kHvrDmp4aeKMU3JjFPxZ1UXU3kIxcznp1h8Vt+ZDwX
	 dhIbk8Ngl5K6A==
From: Carlos Maiolino <cem@kernel.org>
To: linux-xfs@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: Dave Chinner <david@fromorbit.com>, 
 "Darrick J . Wong" <djwong@kernel.org>, hch <hch@lst.de>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250901105128.14987-1-hans.holmberg@wdc.com>
References: <20250901105128.14987-1-hans.holmberg@wdc.com>
Subject: Re: [PATCH 0/3] xfs: hint based zone allocation improvements
Message-Id: <175802248724.997282.6225952797513053259.b4-ty@kernel.org>
Date: Tue, 16 Sep 2025 13:34:47 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Mon, 01 Sep 2025 10:52:03 +0000, Hans Holmberg wrote:
> This series makes the zone allocation policy a bit easier to
> understand and adjusts the policy for unset and "none" rw hints,
> avoiding mixing these with files with file data with set values.
> 
> The first patch adds an enum for the number of hints available,
> the second introduces allocation matrix without changing the policy,
> and rhe third adjusts the allocation policy.
> 
> [...]

Applied to for-next, thanks!

[1/3] fs: add an enum for number of life time hints
      commit: 94deac977fbd0246c971b4f1d17a6385f5e0b1a4
[2/3] xfs: refactor hint based zone allocation
      commit: 0301dae732a5402a68fdb8d8461b97da6b9bccc6
[3/3] xfs: adjust the hint based zone allocation policy
      commit: 8e2cdd8e18ff5073ad76ab2220910001eae39398

Best regards,
-- 
Carlos Maiolino <cem@kernel.org>


