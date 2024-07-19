Return-Path: <linux-fsdevel+bounces-24024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3655937B92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 19:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC431C21D83
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 17:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375C1146A8E;
	Fri, 19 Jul 2024 17:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfEik9J9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5171465A3;
	Fri, 19 Jul 2024 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721410012; cv=none; b=DvNveYf2gCJnlF1tKqKdlpth2WiM4OkE5IqgcmoAQCx/3EEQVjd+UfLJws3NiORYSbm3eNNJ099a9lG8lnx5tuD49PYxi07+aj+M1VHLz6fJpX/UBk7nenEEEQ2DxnSk+/867QxojkYwOxp5Yo1qpjpJJNqPt8m4+TzTUwbBERI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721410012; c=relaxed/simple;
	bh=H+l5OYKqTBpbRG/P3+uUyAn1lNznpqV4QTSBbCnLoS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEz0fwHCN/aSkXBYoDrxc2Tt5BH5NQv403BgAtZLS+30/ze7kjNpeCIkUs4tyrte7RiXcQoLhGc/fIxN22EqsYME6EjOIrFuLDezB7DWnHbgwUzAw1wVZHuY5qsByxx8dtYV7pfduM5SPFGwzwQSW5lH3Ro/Suz37qEdXRQUqlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfEik9J9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EE5C4AF0D;
	Fri, 19 Jul 2024 17:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721410012;
	bh=H+l5OYKqTBpbRG/P3+uUyAn1lNznpqV4QTSBbCnLoS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MfEik9J9NYVFgokBAzi5t+13fh2eOTXDuBAgdWbjVjgVEibBQLr3uZb+iXJVUuFjc
	 LSs4gG9l07jY/JjB/NeihAtqW9OsTh76hB7gyMQuEb4uGsK4izs4rQrq9t/Mln58of
	 EHyUlkxXxDOgCfhVximKv+uSxG0D4n5f1t0XaL8mWsvNtXqbPoDgQs6cv+Skr09rg2
	 W+jpFshQGcBxYGa8u8ws8SQbedCYVCcBl43UYBI7jGcaqPnAN1bbxmJgh2VG1bg2PZ
	 H7eWS3pjWX9+iv7VV74OSKpi+ruKUH3L0bdMDLDtKAVMzFnN7uGvsOgt0glDUNtFg5
	 K4JWSBN/Yz+QQ==
Date: Fri, 19 Jul 2024 10:26:51 -0700
From: Kees Cook <kees@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: akpm@linux-foundation.org, apais@linux.microsoft.com, ardb@kernel.org,
	bigeasy@linutronix.de, brauner@kernel.org, ebiederm@xmission.com,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	nagvijay@microsoft.com, oleg@redhat.com, tandersen@netflix.com,
	vincent.whitchurch@axis.com, viro@zeniv.linux.org.uk,
	apais@microsoft.com, benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v3 0/2] binfmt_elf, coredump: Log the reason of the
 failed core dumps
Message-ID: <202407191026.DC2644DD88@keescook>
References: <20240718182743.1959160-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718182743.1959160-1-romank@linux.microsoft.com>

On Thu, Jul 18, 2024 at 11:27:23AM -0700, Roman Kisel wrote:
> A powerful way to diagnose crashes is to analyze the core dump produced upon
> the failure. Missing or malformed core dump files hinder these investigations.
> I'd like to propose changes that add logging as to why the kernel would not
> finish writing out the core dump file.
> 
> To help in diagnosing the user mode helper not writing out the entire coredump
> contents, the changes also log short statistics on the dump collection. I'd
> advocate for keeping this at the info level on these grounds.
> 
> For validation, I built the kernel and a simple user space to exercize the new
> code.
> 
> [V3]
>   - Standartized the existing logging to report TGID and comm consistently
>   - Fixed compiler warnings for the 32-bit systems (used %zd in the format strings)
> 
> [V2]
>   https://lore.kernel.org/all/20240712215223.605363-1-romank@linux.microsoft.com/
>   - Used _ratelimited to avoid spamming the system log
>   - Added comm and PID to the log messages
>   - Added logging to the failure paths in dump_interrupted, dump_skip, and dump_emit
>   - Fixed compiler warnings produced when CONFIG_COREDUMP is disabled
> 
> [V1]
>   https://lore.kernel.org/all/20240617234133.1167523-1-romank@linux.microsoft.com/
> 
> Roman Kisel (2):
>   coredump: Standartize and fix logging
>   binfmt_elf, coredump: Log the reason of the failed core dumps
> 
>  fs/binfmt_elf.c          |  48 +++++++++----
>  fs/coredump.c            | 150 +++++++++++++++++++++++++++------------
>  include/linux/coredump.h |  30 +++++++-
>  kernel/signal.c          |  21 +++++-
>  4 files changed, 188 insertions(+), 61 deletions(-)

This looks good to me! I'll put this in -next once the merge window
closes. Thanks!

-Kees

-- 
Kees Cook

