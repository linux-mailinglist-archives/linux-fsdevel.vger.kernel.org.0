Return-Path: <linux-fsdevel+bounces-44558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3876A6A4EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 12:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33E487AD888
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 11:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2320821D3C5;
	Thu, 20 Mar 2025 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="flp4dXdE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A6B21CC6A
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469910; cv=none; b=KyNwWObTQq8G7is8JuqP006nZBXmS5MfDwUYHZ5NQ1QF34hudz6VygvJGatf1uBWBUdCMGUqcbev7lzT23r7dx+/6D/P1pYAyzMIEMWQoeeqUUZ47cWf3f4MFCfCVQNOcW4do5w/MnsfgIZYz6dih4njfYXMJvqgb/ClqK2IRqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469910; c=relaxed/simple;
	bh=w+UfEdpNccrsj6WYtYyic8XBwSgQgUUvIlGTP4cvf8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIe5ceq/B3a9Zq+zaGHErxTQp1wozfJlJDbNdg8+waRbAKeF+DP+A0iTU2Ah3icjhfLtVAhgFGqWRinG8DtoHdo+ntf8Nam6wUiUCj+iRHNaFgtNRwF41/r95Ju9iPZ88DXXT7xArwBWgzA4qeBlGtI/BomRo26Spg1YMpPzG0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=flp4dXdE; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 20 Mar 2025 07:24:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742469893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x11ReQQijxLqJZAv5Xizm9x97pwHRRaD8GZcXH/eeF8=;
	b=flp4dXdEvbquH+eusIM+dyoeo7wKgiyQE7HZoCHQ1MY7M1XO2SzhK3SnyYw1kXMCZsFcCH
	J9LGYXhfMfGtcguuaiqYQDaJczvu4eUDBI2r571KhSC9RfjSHH4taZMWMIJX1ShsMFlIpB
	JMo7qGlgahZ7tDRatn4e2lvgTc7QexI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Carlos Song <carlos.song@nxp.com>
Cc: "surenb@google.com" <surenb@google.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "willy@infradead.org" <willy@infradead.org>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Ask help about this patch b951aaff5035 " mm: enable page
 allocation tagging"
Message-ID: <x5bdxqmy7wkb4telwzotyyzgaohx5duez6xhmgy6ykxlgwpyx2@rsu2epndnvy3>
References: <VI2PR04MB11147C17A467F501A333073F4E8D82@VI2PR04MB11147.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI2PR04MB11147C17A467F501A333073F4E8D82@VI2PR04MB11147.eurprd04.prod.outlook.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 20, 2025 at 11:07:41AM +0000, Carlos Song wrote:
> Hi, all
> 
> I found a 300ms~600ms IRQ off when writing 1Gb data to mmc device at I.MX7d SDB board at Linux-kernel-v6.14.
> But I test the same case at Linux-kernel-v6.7, this longest IRQ off time is only 1ms~2ms. So the issue is introduced from v6.7~v6.14.
> 
> Run this cmd to test:
> dd if=/dev/zero of=/dev/mmcblk2p4 bs=4096 seek=12500 count=256000 conv=fsync
> 
> This issue looks from blkdev_buffered_write() function. Because when I run this cmd with "oflag=direct" to use
> blkdev_direct_write(), I can not see any long time IRQ off.
> 
> Then I use Ftrace irqoff tracer to trace the longest IRQ off event, I found some differences between v6.7 and v6.14:
> In iomap_file_buffered_write(), __folio_alloc (in v6.7) is replaced by _folio_alloc_noprof (in v6.14) by this patch.
> The spinlock disabled IRQ ~300ms+. It looks there are some fixes for this patch, but I still can see IRQ off 300ms+ at 6.14.0-rc7-next-20250319.
> 
> Do I trigger one bug? I know little about mem so I have to report it and hope I can get some help or guide.
> I put my ftrace log at the mail tail to help trace and explain.

Did you track down which spinlock?

> 
> commit b951aaff503502a7fe066eeed2744ba8a6413c89
> Author: Suren Baghdasaryan surenb@google.com<mailto:surenb@google.com>
> Date:   Thu Mar 21 09:36:40 2024 -0700
> 
>     mm: enable page allocation tagging
> 
>     Redefine page allocators to record allocation tags upon their invocation.
>     Instrument post_alloc_hook and free_pages_prepare to modify current
>     allocation tag.
> 
>     [surenb@google.com: undo _noprof additions in the documentation]
>       Link: https://lkml.kernel.org/r/20240326231453.1206227-3-surenb@google.com
>     Link: https://lkml.kernel.org/r/20240321163705.3067592-19-surenb@google.com
>     Signed-off-by: Suren Baghdasaryan surenb@google.com<mailto:surenb@google.com>
>     Co-developed-by: Kent Overstreet kent.overstreet@linux.dev<mailto:kent.overstreet@linux.dev>
>     Signed-off-by: Kent Overstreet kent.overstreet@linux.dev<mailto:kent.overstreet@linux.dev>
>     Reviewed-by: Kees Cook keescook@chromium.org<mailto:keescook@chromium.org>
>     Tested-by: Kees Cook keescook@chromium.org<mailto:keescook@chromium.org>
>     Cc: Alexander Viro viro@zeniv.linux.org.uk<mailto:viro@zeniv.linux.org.uk>
>     Cc: Alex Gaynor alex.gaynor@gmail.com<mailto:alex.gaynor@gmail.com>
>     Cc: Alice Ryhl aliceryhl@google.com<mailto:aliceryhl@google.com>
>     Cc: Andreas Hindborg a.hindborg@samsung.com<mailto:a.hindborg@samsung.com>
>     Cc: Benno Lossin benno.lossin@proton.me<mailto:benno.lossin@proton.me>
>     Cc: "Björn Roy Baron" bjorn3_gh@protonmail.com<mailto:bjorn3_gh@protonmail.com>
>     Cc: Boqun Feng boqun.feng@gmail.com<mailto:boqun.feng@gmail.com>
>     Cc: Christoph Lameter cl@linux.com<mailto:cl@linux.com>
>     Cc: Dennis Zhou dennis@kernel.org<mailto:dennis@kernel.org>
>     Cc: Gary Guo gary@garyguo.net<mailto:gary@garyguo.net>
>     Cc: Miguel Ojeda ojeda@kernel.org<mailto:ojeda@kernel.org>
>     Cc: Pasha Tatashin pasha.tatashin@soleen.com<mailto:pasha.tatashin@soleen.com>
>     Cc: Peter Zijlstra peterz@infradead.org<mailto:peterz@infradead.org>
>     Cc: Tejun Heo tj@kernel.org<mailto:tj@kernel.org>
>     Cc: Vlastimil Babka vbabka@suse.cz<mailto:vbabka@suse.cz>
>     Cc: Wedson Almeida Filho wedsonaf@gmail.com<mailto:wedsonaf@gmail.com>
>     Signed-off-by: Andrew Morton akpm@linux-foundation.org<mailto:akpm@linux-foundation.org>
> 
> 
> Ftrace irqoff tracer shows detail:
> At v6.14:
> # tracer: irqsoff
> #
> # irqsoff latency trace v1.1.5 on 6.14.0-rc7-next-20250319
> # --------------------------------------------------------------------
> # latency: 279663 us, #21352/21352, CPU#0 | (M:NONE VP:0, KP:0, SP:0 HP:0 #P:2)
> #    -----------------
> #    | task: dd-805 (uid:0 nice:0 policy:0 rt_prio:0)
> #    -----------------
> #  => started at: __rmqueue_pcplist
> #  => ended at:   _raw_spin_unlock_irqrestore
> #
> #
> #                    _------=> CPU#
> #                   / _-----=> irqs-off/BH-disabled
> #                  | / _----=> need-resched
> #                  || / _---=> hardirq/softirq
> #                  ||| / _--=> preempt-depth
> #                  |||| / _-=> migrate-disable
> #                  ||||| /     delay
> #  cmd     pid     |||||| time  |   caller
> #     \   /        ||||||  \    |    /
>       dd-805       0d....    1us : __rmqueue_pcplist
>       dd-805       0d....    3us : _raw_spin_trylock <-__rmqueue_pcplist
>       dd-805       0d....    7us : __mod_zone_page_state <-__rmqueue_pcplist
>       dd-805       0d....   10us : __mod_zone_page_state <-__rmqueue_pcplist
>       dd-805       0d....   12us : __mod_zone_page_state <-__rmqueue_pcplist
>       dd-805       0d....   15us : __mod_zone_page_state <-__rmqueue_pcplist
>       dd-805       0d....   17us : __mod_zone_page_state <-__rmqueue_pcplist
>       dd-805       0d....   19us : __mod_zone_page_state <-__rmqueue_pcplist
>    ...
>       dd-805       0d.... 1535us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-805       0d.... 1538us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-805       0d.... 1539us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-805       0d.... 1542us+: try_to_claim_block <-__rmqueue_pcplist
>       dd-805       0d.... 1597us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-805       0d.... 1599us+: try_to_claim_block <-__rmqueue_pcplist
>       dd-805       0d.... 1674us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-805       0d.... 1676us+: try_to_claim_block <-__rmqueue_pcplist
>       dd-805       0d.... 1716us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-805       0d.... 1718us+: try_to_claim_block <-__rmqueue_pcplist
>       dd-805       0d.... 1801us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-805       0d.... 1803us+: try_to_claim_block <-__rmqueue_pcplist
> ...
>      dd-805       0d.... 279555us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-805       0d.... 279556us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-805       0d.... 279558us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-805       0d.... 279560us+: try_to_claim_block <-__rmqueue_pcplist
>       dd-805       0d.... 279616us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-805       0d.... 279618us : __mod_zone_page_state <-__rmqueue_pcplist
>       dd-805       0d.... 279620us : find_suitable_fallback <-__rmqueue_pcplist
> ...
>       dd-805       0d.... 279658us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-805       0d.... 279660us : _raw_spin_unlock_irqrestore <-__rmqueue_pcplist
>       dd-805       0d.... 279662us : _raw_spin_unlock_irqrestore
>       dd-805       0d.... 279666us+: trace_hardirqs_on <-_raw_spin_unlock_irqrestore
>       dd-805       0d.... 279712us : <stack trace>
> => get_page_from_freelist
> => __alloc_frozen_pages_noprof
> => __folio_alloc_noprof
> => __filemap_get_folio
> => iomap_write_begin
> => iomap_file_buffered_write
> => blkdev_write_iter
> => vfs_write
> => ksys_write
> => ret_fast_syscall
> 
> At v6.7:
> # tracer: irqsoff
> #
> # irqsoff latency trace v1.1.5 on 6.7.0
> # --------------------------------------------------------------------
> # latency: 2477 us, #146/146, CPU#0 | (M:server VP:0, KP:0, SP:0 HP:0 #P:2)
> #    -----------------
> #    | task: dd-808 (uid:0 nice:0 policy:0 rt_prio:0)
> #    -----------------
> #  => started at: _raw_spin_lock_irqsave
> #  => ended at:   _raw_spin_unlock_irqrestore
> #
> #
> #                    _------=> CPU#
> #                   / _-----=> irqs-off/BH-disabled
> #                  | / _----=> need-resched
> #                  || / _---=> hardirq/softirq
> #                  ||| / _--=> preempt-depth
> #                  |||| / _-=> migrate-disable
> #                  ||||| /     delay
> #  cmd     pid     |||||| time  |   caller
> #     \   /        ||||||  \    |    /
>       dd-808       0d....    1us!: _raw_spin_lock_irqsave
>       dd-808       0d....  186us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  189us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  191us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  192us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  194us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  196us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  199us : steal_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  203us!: move_freepages_block <-steal_suitable_fallback
>       dd-808       0d....  330us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  332us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  334us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  336us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  338us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  339us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  341us : steal_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  343us!: move_freepages_block <-steal_suitable_fallback
>       dd-808       0d....  479us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  481us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  483us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  485us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  486us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  488us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  490us : steal_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  492us!: move_freepages_block <-steal_suitable_fallback
>       dd-808       0d....  630us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  632us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  634us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  636us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  638us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  640us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  642us : steal_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  644us!: move_freepages_block <-steal_suitable_fallback
>       dd-808       0d....  771us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  773us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  775us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  777us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  778us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  780us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  782us : steal_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  784us!: move_freepages_block <-steal_suitable_fallback
>       dd-808       0d....  911us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  913us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  915us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  916us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  918us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  920us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  922us : steal_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d....  924us!: move_freepages_block <-steal_suitable_fallback
>       dd-808       0d.... 1055us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1058us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1059us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1061us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1063us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1065us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1066us : steal_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1068us!: move_freepages_block <-steal_suitable_fallback
>       dd-808       0d.... 1194us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1196us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1198us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1200us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1202us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1203us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1205us : steal_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1208us!: move_freepages_block <-steal_suitable_fallback
>       dd-808       0d.... 1333us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1335us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1337us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1339us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1341us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1342us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1344us : steal_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1346us!: move_freepages_block <-steal_suitable_fallback
>       dd-808       0d.... 1480us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1482us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1484us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1486us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1488us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1490us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1492us : steal_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1494us!: move_freepages_block <-steal_suitable_fallback
>       dd-808       0d.... 1621us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1623us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1625us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1627us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1629us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1630us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1632us : steal_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1634us!: move_freepages_block <-steal_suitable_fallback
>       dd-808       0d.... 1761us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1763us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1765us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1766us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1768us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1770us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1772us : steal_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1774us!: move_freepages_block <-steal_suitable_fallback
>       dd-808       0d.... 1900us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1902us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1903us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1905us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1907us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1909us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1911us : steal_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 1913us!: move_freepages_block <-steal_suitable_fallback
>       dd-808       0d.... 2038us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2040us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2042us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2044us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2046us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2047us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2049us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2051us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2053us : steal_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2055us!: move_freepages_block <-steal_suitable_fallback
>       dd-808       0d.... 2175us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2176us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2178us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2180us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2182us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2183us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2185us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2187us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2189us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2191us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2192us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2194us : steal_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2196us!: move_freepages_block <-steal_suitable_fallback
>       dd-808       0d.... 2323us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2325us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2327us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2328us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2330us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2332us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2334us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2335us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2337us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2339us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2341us : find_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2343us : steal_suitable_fallback <-__rmqueue_pcplist
>       dd-808       0d.... 2345us!: move_freepages_block <-steal_suitable_fallback
>       dd-808       0d.... 2470us : __mod_zone_page_state <-__rmqueue_pcplist
>       dd-808       0d.... 2473us : _raw_spin_unlock_irqrestore <-__rmqueue_pcplist
>       dd-808       0d.... 2476us : _raw_spin_unlock_irqrestore
>       dd-808       0d.... 2479us+: tracer_hardirqs_on <-_raw_spin_unlock_irqrestore
>       dd-808       0d.... 2520us : <stack trace>
> => get_page_from_freelist
> => __alloc_pages
> => __folio_alloc
> => __filemap_get_folio
> => iomap_write_begin
> => iomap_file_buffered_write
> => blkdev_write_iter
> => vfs_write
> => ksys_write
> => ret_fast_syscall
> 
> Best Regard
> Carlos Song
> 

