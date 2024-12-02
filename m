Return-Path: <linux-fsdevel+bounces-36265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BC09E0A71
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 18:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 945B9B8776C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 14:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B90D20E009;
	Mon,  2 Dec 2024 14:46:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pinero.vault24.org (pinero.vault24.org [69.164.212.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E84205AC3
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Dec 2024 14:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.164.212.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150786; cv=none; b=FeuwH68u1XqN7DJIGWYy9x+3kNvZveTZiw3CL1IYDkpRxfuBRWJxEaegfJqnMDaqoSvBByy6FZM73Xf3r2pXkhe+7EeRVjt+LQK57mTA4EEerrpJzTdrzLDzJih1Qo5wdYa+HliM/uYiWlhEVsKnzaUiu5TWxvFgQCbm4lC2LMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150786; c=relaxed/simple;
	bh=Lz/dislY4QwWbXA/govViVoeAYrcVD2q67apkOeK/Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AT+Jxdb7IOYBfneFEulisgFL6+RNlMRGWMlxSevmQWYU85bCAS4/8jnLHmypbmBr31B9521O6Wmoc4iqP354h0vhSzvScNm9LINufLehahRDZd82nX13xRPR9bbvX15xTcD0LbEF4QwEvfAjHAX70kh79OeGB9XtAiLivqvj6AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vault24.org; spf=pass smtp.mailfrom=vault24.org; arc=none smtp.client-ip=69.164.212.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vault24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vault24.org
Received: from feynman.vault24.org (unknown [IPv6:2601:40f:4000:c7d8::14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by pinero.vault24.org (Postfix) with ESMTPS id A449B605D;
	Mon, 02 Dec 2024 09:46:21 -0500 (EST)
Received: by feynman.vault24.org (Postfix, from userid 1000)
	id 44DF86D5F2; Mon, 02 Dec 2024 09:46:21 -0500 (EST)
Date: Mon, 2 Dec 2024 09:46:21 -0500
From: Jon DeVree <nuxi@vault24.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [BUG] 2038 warning is not printed with new mount API
Message-ID: <Z03IPaweJtozuFvV@feynman.vault24.org>
References: <Z00wR_eFKZvxFJFW@feynman.vault24.org>
 <20241202-natur-davor-864eb423be9c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241202-natur-davor-864eb423be9c@brauner>

On Mon, Dec 02, 2024 at 12:55:13 +0100, Christian Brauner wrote:
> IMHO, the best place to log a warning is either at fsmount() time or at
> superblock creation time but then the format of the warning will have to
> be slightly, changed. We could change it to:
> 
> [11526.621600] xfs filesystem supports timestamps until 2038 (0x7ffffff
> 
> libmount will log additional information about the mount to figure out
> what filesystem caused this warning to be logged.
>

Maybe it could log the device node instead of the mount point? Then the
messages from both APIs could remain consistent. One is probably as good
as the other and the other mount related log messages all seem to be
using the device node:

[   39.379071] EXT4-fs (sda3): mounted filesystem with ordered data mode. Quota mode: none.
[   39.574146] XFS (sda4): Mounting V5 Filesystem

I assume that info is available at this point because the filesystems
are able to use it in their log messages, but I could be wrong.

>
> Would that work for you?
>

I don't really have a preference for how its fixed. I reported it
because I happened to notice it go missing after a system upgrade.

I did my best to make a small suggestion despite a lack of expertise in
this area.

-- 
Jon
Doge Wrangler
X(7): A program for managing terminal windows. See also screen(1) and tmux(1).

