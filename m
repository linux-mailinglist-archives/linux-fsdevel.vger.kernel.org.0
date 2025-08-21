Return-Path: <linux-fsdevel+bounces-58425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 440BAB2E9AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 02:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCFAC4E17F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 00:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9521E32D3;
	Thu, 21 Aug 2025 00:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW3fSUGK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7DD1B2186
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 00:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755737298; cv=none; b=hJuPo2htYO22tOHQF5fboBv9BqFdY7Kw2bHzytbrpNGDmr+EDVM4kXAtIG0eHka/NqioLDbqd1k8fTn5AEB1a/6hZ1kdOf4cDQk4F3jFzeMl7VEUneiyjcVE1GNjn+nuP59o3S0Y+xFeD/Caq9y8npcquP9kGxyHN0Ag+BKTffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755737298; c=relaxed/simple;
	bh=x94rOtR88DtMviWe6z9XukoN9p+lmc+Y16UCOPU2hMw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICFmDMQKs1J2QLo6NiWKPgm4lBNaCaYj4irBmgzhUKZVH6iu8gcR2ePsdlDT6u5cTtou9FS2QO7fshTLkoikZ1CQzZbJBt+69by6gznh/ctMbKvepklLCY5JMXgjT5onx70weXQjOwqxh63VlcBPxhWHq45Q9BbSRWXRwRNCi4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SW3fSUGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02864C4CEE7;
	Thu, 21 Aug 2025 00:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755737298;
	bh=x94rOtR88DtMviWe6z9XukoN9p+lmc+Y16UCOPU2hMw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=SW3fSUGKjAVgMbAEGSj6wwZtSCl4GIfGOKSvCYQ81sh9DvK+WAVfFKthiboeai8qT
	 NJUBYG7UcbEmK5myTalpWEUfaMucLo1OpKxm2KnGE0C3wwBYwY1WA6rINAt1jVPMzN
	 6+zW2lOuDE4F6iTx9cMJEZqjiu7z37jDa9TElA1EFyyyRXCxMEfYPZcrDM3+TaQpfx
	 kY/OmM8KjYAeRYPlgSbKZfTH/PCBpfeeT9EQVLojg0DLYFj3VlLpyYBliQUPHNFR2Y
	 0R7Kw0BA3gRGAnB90sh+CKpOSgCcMcarTJ3XWb8jCgJbOn/T2OZ8sIMvP2vH2IeEsc
	 HzNUIlpspSvxQ==
Date: Wed, 20 Aug 2025 17:48:17 -0700
Subject: [PATCHSET RFC v4 1/4] libfuse: general bug fixes
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573710975.19062.7329425679466983566.stgit@frogsfrogsfrogs>
In-Reply-To: <20250821003720.GA4194186@frogsfrogsfrogs>
References: <20250821003720.GA4194186@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

Here's a collection of fixes that I *think* are bugs in libfuse.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-fixes
---
Commits in this patchset:
 * libfuse: don't put HAVE_STATX in a public header
---
 include/fuse.h           |    2 --
 include/fuse_lowlevel.h  |    2 --
 example/memfs_ll.cc      |    2 +-
 example/passthrough.c    |    2 +-
 example/passthrough_fh.c |    2 +-
 example/passthrough_ll.c |    2 +-
 6 files changed, 4 insertions(+), 8 deletions(-)


