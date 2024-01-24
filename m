Return-Path: <linux-fsdevel+bounces-8680-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7563883A26C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 07:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DBC02892AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 06:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276F714F86;
	Wed, 24 Jan 2024 06:59:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50B010795;
	Wed, 24 Jan 2024 06:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079580; cv=none; b=KAIUNtNY8Au4qmC1XefgXV95oCa5RBDYMXAoAiKQ4YNksEjBSx3+2zBEa+MW3rniuW3L+SiswZxRowjLO2lfPLFzEGrRUIy5e0+GcdgxP9chaawhKORPw0sdokQLDT8xi7C4i1d0sX7fzs6t/midzw8q4ynFcWzq9ilvtlJDuss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079580; c=relaxed/simple;
	bh=tr6lQdy8MC4HevkGJesocwPxqTCKOaSttUC/8n8LgJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hvFcwyY49PEeSiihcIlIMGn+N9qhCva5/NbH/lTQmg+vIXMdyfxZC/xi5kvvhc0egJhf2PSxlckhfTl9+jjQfImYYsMzdVdfrFww9L5Vdlq2DZRDFk37rOyL1gYz/2miQfrT5J08nnnXYy9sqcpAifkKBH79+bQ0mFHrya30zk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rSXEQ-0007VV-Rl; Wed, 24 Jan 2024 07:59:30 +0100
Message-ID: <aeab5703-20a2-410c-bd57-c144e3283e41@leemhuis.info>
Date: Wed, 24 Jan 2024 07:59:30 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Recent-ish changes in binfmt_elf made my program segfault
Content-Language: en-US, de-DE
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
From: "Linux regression tracking #adding (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1706079578;b1f518a3;
X-HE-SMSGID: 1rSXEQ-0007VV-Rl

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 22.01.24 13:01, Jan Bujak wrote:
> 
> I recently updated my kernel and one of my programs started segfaulting.
> 
> [...]
> I bisected the issue to the following commit:
> 
> commit 585a018627b4d7ed37387211f667916840b5c5ea
> Author: Eric W. Biederman <ebiederm@xmission.com>
> Date:   Thu Sep 28 20:24:29 2023 -0700
> 
>     binfmt_elf: Support segments with 0 filesz and misaligned starts
> [...]

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 585a018627b4d7ed37387211f667916840b5c5e
#regzbot title binfmt_elf: programs started segfaulting
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

