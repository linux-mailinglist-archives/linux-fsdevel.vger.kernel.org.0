Return-Path: <linux-fsdevel+bounces-16975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E568A5E46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 01:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9160B22349
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 23:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E281591F8;
	Mon, 15 Apr 2024 23:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMHpyaLW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF34156F35;
	Mon, 15 Apr 2024 23:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713223734; cv=none; b=cXWA0Qmg4894u/D2WBfLslmT6b/BetLh6jnQNhtWcJofLYjaJ0fAH2uzN9NvE8HEO4YvAERK/8LceJj2r1C7o6Z3nPdduXBR69Jeb/w6kIpneIeGcUgTGjf1FBT+W17+bTVxK+y+lOEPEcfsSGT+h/bJVH1Y1fZtonI4Pczu6YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713223734; c=relaxed/simple;
	bh=t8z87Ip4jFRpsn1iMjSMQLbePeEqhnJSK8LyQ97WBXI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Yo0Ja3v8IaEUvEwDNrsdaQNdgTQAQ6mHIFIil8BBXXsCjI/iu9N0O3hldqKSBmCp/53LlMfzas2Gubn1Or63cZzgWUqgi85OqE/vxxWBMQ2FgVF03DlKmHVVreOep0Pb5HE0RrTjS7cboza1PadiGhmP+Ii37k4v17JfkD92FV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMHpyaLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F49C113CC;
	Mon, 15 Apr 2024 23:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713223733;
	bh=t8z87Ip4jFRpsn1iMjSMQLbePeEqhnJSK8LyQ97WBXI=;
	h=Date:From:To:Cc:Subject:From;
	b=kMHpyaLWfdgm8seb2tFe/E2XQTAl3NfBJ1BVEg46Lgi43Q4/AZiqdF0RQV+qEZ4V3
	 B21r+SD0D6RC0l/ckxTJ7gMNOGJ3j1ICxlEr/bpUyKhNtfxSO0x+v7myjjQ0mfj6AF
	 SBETdBKGnTLmCI5X8hQg8kSGkX9v723zaBLdBD7okBbMDPGc3EJ3ciD9BjenOPMZPC
	 dnZ/yWN5fZMl6eUnDos3oNw/N1M/k+oTSIPwVh6nnSdSE1hGr3omoG8hXzCYTZ5EfW
	 lsY1mcsVnPcdyj6aXmviPWciciJLz444sq5dOyyIq/Nx4LzFkivQ0Dc6xLxyCGls7h
	 C3t4F2/lD8iyA==
Date: Mon, 15 Apr 2024 16:28:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: [PATCHBOMB v30.3] xfs: online repair, part 1 is done
Message-ID: <20240415232853.GE11948@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone,

I'm about to send pull requests to Chandan for all the fully reviewed
patchsets that I have in my development tree.  Due to all the recent
design changes, I have decided to resend all patches to that the list
can record the final versions of these patches with complete tagging.

--D

