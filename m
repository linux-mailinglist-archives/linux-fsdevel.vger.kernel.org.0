Return-Path: <linux-fsdevel+bounces-53967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 173D2AF96DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 17:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A851D1CA53C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 15:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094D61E9B21;
	Fri,  4 Jul 2025 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emz5PoLd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611A61C3C18
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751643301; cv=none; b=KQTwbVUxAiTaGJ3iEVQVPFgHJz6H4EJzr9vYOkpN94CIOXmc4jX2JzFIoh62V2qAbon9BNisF14R+xzHzIBy69XcEW/gnkLkMnId87sMhlkoNKRbbBMx+M0mQF1W5k8wNqFngwscjixUdke1C2uooxrmr55cf3CGMPi002AjYAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751643301; c=relaxed/simple;
	bh=i/PYE1o9TcIAThmf/v3ptk0oOIanNyX13IGbjmgvdRQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gTftWjoP15WOAcsC0fMbLVtBulsWigxaUPXeHbxsjDbeZWRnVYXdH2puUz5pg2qaCscEHemRiCLPrFxWhSQt/HZqFNENMPwohCOYel4jtCsY1FEraTLcGMW/IbYRCNoEzZHDvbQv4CIRt1gJkdHOQH0JeRMegzYFnFlxBxADhCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emz5PoLd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13615C4CEE3;
	Fri,  4 Jul 2025 15:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751643300;
	bh=i/PYE1o9TcIAThmf/v3ptk0oOIanNyX13IGbjmgvdRQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=emz5PoLdLLOlj8sPuzgfrMguPZhZCzWKWcT9Ul5U7DV2ZmxpOxcfSp7vBxTNfwlx8
	 1OCnVwKk05GC8PfLKB+tVOOwfKrWOLRipr1DRE1iCWDlu68SCpGdzRy8ZAAJ1vnaXi
	 PbNlLEePQ9DFS9Ski9YHp9dug2Ln3Z5PPsNwZvRc617lEIARVEdNglbCcjAjCMbYBI
	 mcsiTOTNSN/GqrA/oyEA8beunkOHPH0Q9G7VAFKTymjPfKai0F/Vrx/Cev5KbqM5l9
	 tWiv21oGvrDBPSJD2dvHmqA6TeN+BPPoXPlHuDdxDANWV5Qrs/fPvKGL88fkDbG1JK
	 /pcWWyxUtDHjw==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20250702211408.GA3406663@ZenIV>
References: <20250702211408.GA3406663@ZenIV>
Subject: Re: (subset) [PATCH 01/11] zynqmp: don't bother with
 debugfs_file_{get,put}() in proxied fops
Message-Id: <175164329981.97594.15505661775329412408.b4-ty@kernel.org>
Date: Fri, 04 Jul 2025 16:34:59 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Wed, 02 Jul 2025 22:14:08 +0100, Al Viro wrote:
> When debugfs file has been created by debugfs_create_file_unsafe(),
> we do need the file_operations methods to use debugfs_file_{get,put}()
> to prevent concurrent removal; for files created by debugfs_create_file()
> that is done in the wrappers that call underlying methods, so there's
> no point whatsoever duplicating that in the underlying methods themselves.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[03/11] regmap: get rid of redundant debugfs_file_{get,put}()
        commit: 9f711c9321cffe3e03709176873c277fa911c366

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


