Return-Path: <linux-fsdevel+bounces-47569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55677AA0771
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2A61888AB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893A82BCF47;
	Tue, 29 Apr 2025 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TRDxPX24"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E303F1C862F;
	Tue, 29 Apr 2025 09:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745919234; cv=none; b=j9YTOlphnMg1DH9L296kEgHy/kCoQKVnuvPUd3lzcOerlUp8c6MYhvEFppgb/gup344E7lYtVV+QU43Milv0wHjbhpQp4AadZVy8g4YX4+7MFwQMgHf8O22da16k7fNmiu7Zy+aty+SmbbPtF45HKeqRaHp0aOOmzUKapV1iYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745919234; c=relaxed/simple;
	bh=T3Rg6sZlKQEl851ZaqMfKzOrF9ilEm3VnCUWPRkF9Lo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=I35bEh01Uxa3SG3Pjlpp0UZsZOeXphBOWw9hW8oKrp14A24lK1l6HrK7qPsHWhqZ90yZ0gNyXmkcHSqVPpQuWvgUfuLfJhXClOp7rXhTggVhRam8gMsjouQGcA+vbjBHDvXdCZf11Cnr4f6D166v3dL+5HAkAIhPx/OjpHfYkEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TRDxPX24; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD52C4CEEA;
	Tue, 29 Apr 2025 09:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745919233;
	bh=T3Rg6sZlKQEl851ZaqMfKzOrF9ilEm3VnCUWPRkF9Lo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TRDxPX24LVpwomd0TNa82sHoUTFadKADtJnHnXERrOtOg9tXZO9j7Xr/M/RqTSs0h
	 DRvFcnggAkyCTep+B6YWlwBFFi9py17GgRVZ7AdPEckeKCj5VIZF5NoiBsHa2xwLVr
	 8KIoz6eJS04XOJj4kJf63guebXAb/0RS4uszjSgjhBI9DqR1X/HL+bE6b+jqCXZvDJ
	 4hUsBi9LnqeVLRCbVnGTKo3FJO1z7rbnYY8zKUg4P6D6C3ZKPojwsF/XKEE5c4VhfT
	 7iUMTA66bXT6UvwS5otqbdXIMO5IOUJRHdTMBayx3hLK/dottFby0DV+f2rDGbLyP2
	 za43IyLC7oTwg==
From: Carlos Maiolino <cem@kernel.org>
To: axboe@kernel.dk, "Darrick J. Wong" <djwong@kernel.org>
Cc: hch@lst.de, mcgrof@kernel.org, hch@infradead.org, willy@infradead.org, 
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org, mcgrof@kernel.org
In-Reply-To: <174543795741.4139148.12449986894161376000.stgit@frogsfrogsfrogs>
References: <174543795664.4139148.8846677768151191269.stgit@frogsfrogsfrogs>
 <174543795741.4139148.12449986894161376000.stgit@frogsfrogsfrogs>
Subject: Re: [PATCH 3/3] xfs: stop using set_blocksize
Message-Id: <174591923085.71202.4676998618252400941.b4-ty@kernel.org>
Date: Tue, 29 Apr 2025 11:33:50 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Wed, 23 Apr 2025 12:54:13 -0700, Darrick J. Wong wrote:
> XFS has its own buffer cache for metadata that uses submit_bio, which
> means that it no longer uses the block device pagecache for anything.
> Create a more lightweight helper that runs the blocksize checks and
> flushes dirty data and use that instead.  No more truncating the
> pagecache because XFS does not use it or care about it.
> 
> 
> [...]

Applied to for-next, thanks!

[3/3] xfs: stop using set_blocksize
      commit: 5088aad3d32cc0b1c96cbe3e718569ffc0aca4ba

Best regards,
-- 
Carlos Maiolino <cem@kernel.org>


