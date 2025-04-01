Return-Path: <linux-fsdevel+bounces-45418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1318DA7761B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 10:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6059818880F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 08:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC261E98F8;
	Tue,  1 Apr 2025 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcT+bi1N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FC7C147;
	Tue,  1 Apr 2025 08:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743495377; cv=none; b=VL0/6jqCUfAOxptBwXEIyxTKp/VrxscSk2QZQaY4JBm2+ovxa0CJJ1OIR8xW9Maz671/MkIa7tQVRABE4zGH9IIoirNf/NZvyXxTWZyenK5l5NGfQ+PcM+X653MIWoxL3+Z4R3TbvRWd0dG4rQWFfbM6U/3rePdPmIfQozxHUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743495377; c=relaxed/simple;
	bh=mqFRguA2xwGcVCXVOJHsT6BjnxhfZGODMo5hMb4xpw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnMfNs2bO+G7HrzReoflC6+3exP5mu78Y93RF0rMQ784yY9+sADcnTnlIrlgmmk96Sh8opFnN/HmjZH9NcKd7Wijr2AcVkwhhqUh518WHclrG1qp1nkTzXYMbyYbmfsTbullNIdx4NIthaDXe36giIijHwvq4e+cHYWEu9ufi18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcT+bi1N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87DEC4CEE4;
	Tue,  1 Apr 2025 08:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743495375;
	bh=mqFRguA2xwGcVCXVOJHsT6BjnxhfZGODMo5hMb4xpw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcT+bi1NgKrAR494xr8qC3rB781782Vkp5ULfg8R59LuUEGYf6bEDJREi6PVwP7Yd
	 Db3WkNmcxk4X40SqkAIh9FT3G08aPP6gFS7foXTVp6QVi/DL36LXKIW0tw4kpTW93G
	 DOx8Ht54XGuUkdfUxnr4+U8M9R7YzT3gIrbfvrhlbn6TOeHKh9e+ThY5Jip0e5diB8
	 M3sqvPczPH4Ug/hxtYRR0dOSooTrgb5NaDvMxZr1YBbNtWSlP1VuH2aRoUCRePbP1i
	 womV0evVCMF9HAxnpKhVBSC1uH+6/7C+bWmMfPL16AMVYdgsJJKmCDbg0AAJvahXDJ
	 Rr/5MSy4aL2yA==
Date: Tue, 1 Apr 2025 10:16:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: jack@suse.cz, rafael@kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, djwong@kernel.org, 
	pavel@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org, 
	boqun.feng@gmail.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/6] power: wire-up filesystem freeze/thaw with
 suspend/resume
Message-ID: <20250401-zuhilfenahme-kursbuch-ec2d774d991b@brauner>
References: <20250331-work-freeze-v1-0-6dfbe8253b9f@kernel.org>
 <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>

On Tue, Apr 01, 2025 at 02:32:45AM +0200, Christian Brauner wrote:
> The whole shebang can also be found at:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=work.freeze
> 
> I know nothing about power or hibernation.

I would like to place this behind a Kconfig option and add a
/sys/power/freeze_on_suspend option as these changes are pretty
sensitive and to give userspace the ability to experiment with this for
a while until we remove it. That means we should skip the removal of all
the freezer changes in the filesystems until we're happy enough that
this works reliable enough.

