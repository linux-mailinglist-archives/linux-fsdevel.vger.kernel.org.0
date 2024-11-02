Return-Path: <linux-fsdevel+bounces-33570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA3E9BA25F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 21:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DB41F2355E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Nov 2024 20:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA41ABEA8;
	Sat,  2 Nov 2024 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7aOUj4o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E654A1AB52F;
	Sat,  2 Nov 2024 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730577938; cv=none; b=j8eeiKNAtJXGxiHDLV2/49Sut2mnl13XW22+An8d7g1SDRzgYyNNPohW6pt95sxaePbheGFnQM6XEeHAH2fY9LdiyZqzWfNuX4q8T1WzuW90Sz+z2UuMCCDNAtkO4KW4R0JG3FwWPAwXLv7DdsDgFszyZ2lkwahp+4MGTUIy4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730577938; c=relaxed/simple;
	bh=6pOQI71vKH2U1t1m/PWM228AhDTBFZFVdAXY5O7tmFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WudgT7RX+gYlpVZneG4fD/oMOQHJh5XRLEM/puz1XJO3MJgPkPw5R89YXyLbrF6Fb79JrIaJckoajUDOJbQQu6t0U6QLItux6u/53/No5bFHt4uQNudKOif618N+wZQJ4zrBGWPSCHdHBSvBaDtBwO+o8mLtkTVXoq512S5AewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7aOUj4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84986C4CEC3;
	Sat,  2 Nov 2024 20:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730577937;
	bh=6pOQI71vKH2U1t1m/PWM228AhDTBFZFVdAXY5O7tmFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f7aOUj4oOIcMGB555wwaczb/S10oLnefaMyFTeBdNSNmYRAhdVKjOhs3zoEr2ngKU
	 VZF9lNTV1Qi7mpprpwDElGbktCvJliNeoaXz74jJPrKFP66n9BR5yrXg8BZlzG/iBG
	 2YNkAyrH/VVoaH3RmjH3inkkN6Wped6S/Fq1MReW0M8bwLSVIXWirQ2Iwvun9OS+Mb
	 IT4OdX0Po2t5P7ZKu03rlai4UNYt9/Li/CiD6Bg0ImL6xQl5tRHg5Q85FuxIIEwrHc
	 NuV/WJ3JeXAoMulIdSCXwY6Tn3ZTsYLRQyYbr74DVJFBg1eQ8g7ZO0f1iU/KcmNYNW
	 y/7f2gefRjTNg==
From: Kees Cook <kees@kernel.org>
To: ebiederm@xmission.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nir@lichtman.org
Cc: Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] exec: move warning of null argv to be next to the relevant code
Date: Sat,  2 Nov 2024 13:05:29 -0700
Message-Id: <173057792683.2382793.11435101948652154284.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZyYUgiPc8A8i_3FH@nirs-laptop.>
References: <ZyYUgiPc8A8i_3FH@nirs-laptop.>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 02 Nov 2024 14:01:22 +0200, nir@lichtman.org wrote:
> Problem: The warning is currently printed where it is detected that the
> arg count is zero but the action is only taken place later in the flow
> even though the warning is written as if the action is taken place in
> the time of print
> 
> This could be problematic since there could be a failure between the
> print and the code that takes action which would deem this warning
> misleading
> 
> [...]

Applied to for-next/execve, thanks!

[1/1] exec: move warning of null argv to be next to the relevant code
      https://git.kernel.org/kees/c/cc0be150ca0e

Take care,

-- 
Kees Cook


