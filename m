Return-Path: <linux-fsdevel+bounces-48036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C68AA8F17
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 11:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A980C174D35
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 May 2025 09:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6510C1F5425;
	Mon,  5 May 2025 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AzDtfwwu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6v7snzEX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AzDtfwwu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6v7snzEX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FB11F4622
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 May 2025 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436414; cv=none; b=k/+SfxnBMFHIGDOPEbLLu1WSGWddp0slL/UNgEzYodbezbVW5+OeDIfO0ILRGLUa1XqJTBcl2T5D8Et0B01jSIp20L3FTIDHXnU1z26xD5ThoHrk/d3u423E3NL/CEaZ9MUQ1TICbi7EH3sC3u9AuZJQvFZ+D8V+pXmnkzgAXkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436414; c=relaxed/simple;
	bh=YxPbqURGutUefK/bVjtDAZARsuuH4EvyG3tOd+KEJR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+b+C1Px5WL5xJFIwxSj+Xp8hqS3P4uyLKR7SVy4VdSAKHh/sBMZjj0+80OPJ1WPn2GZ/qSbc/k8JFJHkP16N7enRih6fYWUBM5UcXqh9ogFzaeklEUV06zy7l5UqCZinjwzNzjp6yajrN3htR06KE4+MItB1wSlSbNWlW0R4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AzDtfwwu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6v7snzEX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AzDtfwwu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6v7snzEX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BAD3D2116F;
	Mon,  5 May 2025 09:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746436410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xphATPaJZGCL+lMaOTxLn69vUtLw7LHyVcDEwboX0cg=;
	b=AzDtfwwunHhnrZElZml9wUH5unrk7/UfSd1WHHxdxBxAqrVbDoXVU0BlQm5SurCtxeQucU
	5SbrXRiZS10p+R5ivt7M4+kwDPUGGlnbdrkuDg1sVDxf/auWCudEGIayWOBzAw4ZKdy3PJ
	NUtAcW/DzBbU05yK0K7ky+i/uc2w0uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746436410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xphATPaJZGCL+lMaOTxLn69vUtLw7LHyVcDEwboX0cg=;
	b=6v7snzEXiW2cBJGUUu131J4mmd/CRaESFBJnrzKxlYW6HTD3URWVwzHNU0s+rujhxP1hsP
	eBEjlb+fLNO3siCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1746436410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xphATPaJZGCL+lMaOTxLn69vUtLw7LHyVcDEwboX0cg=;
	b=AzDtfwwunHhnrZElZml9wUH5unrk7/UfSd1WHHxdxBxAqrVbDoXVU0BlQm5SurCtxeQucU
	5SbrXRiZS10p+R5ivt7M4+kwDPUGGlnbdrkuDg1sVDxf/auWCudEGIayWOBzAw4ZKdy3PJ
	NUtAcW/DzBbU05yK0K7ky+i/uc2w0uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1746436410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xphATPaJZGCL+lMaOTxLn69vUtLw7LHyVcDEwboX0cg=;
	b=6v7snzEXiW2cBJGUUu131J4mmd/CRaESFBJnrzKxlYW6HTD3URWVwzHNU0s+rujhxP1hsP
	eBEjlb+fLNO3siCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A555E1372E;
	Mon,  5 May 2025 09:13:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 87roJzqBGGgKaAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 May 2025 09:13:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5DCC0A082A; Mon,  5 May 2025 11:13:26 +0200 (CEST)
Date: Mon, 5 May 2025 11:13:26 +0200
From: Jan Kara <jack@suse.cz>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>, 
	Dave Chinner <david@fromorbit.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Kalesh Singh <kaleshsingh@google.com>, Zi Yan <ziy@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v4 2/5] mm/readahead: Terminate async readahead on
 natural boundary
Message-ID: <3myknukhnrtdb4y5i6ewcgpubg2fopxc35ii6a4oy5ffgn7xdf@uileryotgd7z>
References: <20250430145920.3748738-1-ryan.roberts@arm.com>
 <20250430145920.3748738-3-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430145920.3748738-3-ryan.roberts@arm.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 30-04-25 15:59:15, Ryan Roberts wrote:
> Previously asynchonous readahead would read ra_pages (usually 128K)
> directly after the end of the synchonous readahead and given the
> synchronous readahead portion had no alignment guarantees (beyond page
> boundaries) it is possible (and likely) that the end of the initial 128K
> region would not fall on a natural boundary for the folio size being
> used. Therefore smaller folios were used to align down to the required
> boundary, both at the end of the previous readahead block and at the
> start of the new one.
> 
> In the worst cases, this can result in never properly ramping up the
> folio size, and instead getting stuck oscillating between order-0, -1
> and -2 folios. The next readahead will try to use folios whose order is
> +2 bigger than the folio that had the readahead marker. But because of
> the alignment requirements, that folio (the first one in the readahead
> block) can end up being order-0 in some cases.
> 
> There will be 2 modifications to solve this issue:
> 
> 1) Calculate the readahead size so the end is aligned to a folio
>    boundary. This prevents needing to allocate small folios to align
>    down at the end of the window and fixes the oscillation problem.
> 
> 2) Remember the "preferred folio order" in the ra state instead of
>    inferring it from the folio with the readahead marker. This solves
>    the slow ramp up problem (discussed in a subsequent patch).
> 
> This patch addresses (1) only. A subsequent patch will address (2).
> 
> Worked example:
> 
> The following shows the previous pathalogical behaviour when the initial
> synchronous readahead is unaligned. We start reading at page 17 in the
> file and read sequentially from there. I'm showing a dump of the pages
> in the page cache just after we read the first page of the folio with
> the readahead marker.
> 
> Initially there are no pages in the page cache:
> 
> TYPE    STARTOFFS     ENDOFFS        SIZE  STARTPG    ENDPG   NRPG  ORDER  RA
> -----  ----------  ----------  ----------  -------  -------  -----  -----  --
> HOLE   0x00000000  0x00800000     8388608        0     2048   2048
> 
> Then we access page 17, causing synchonous read-around of 128K with a
> readahead marker set up at page 25. So far, all as expected:
> 
> TYPE    STARTOFFS     ENDOFFS        SIZE  STARTPG    ENDPG   NRPG  ORDER  RA
> -----  ----------  ----------  ----------  -------  -------  -----  -----  --
> HOLE   0x00000000  0x00001000        4096        0        1      1
> FOLIO  0x00001000  0x00002000        4096        1        2      1      0
> FOLIO  0x00002000  0x00003000        4096        2        3      1      0
> FOLIO  0x00003000  0x00004000        4096        3        4      1      0
> FOLIO  0x00004000  0x00005000        4096        4        5      1      0
> FOLIO  0x00005000  0x00006000        4096        5        6      1      0
> FOLIO  0x00006000  0x00007000        4096        6        7      1      0
> FOLIO  0x00007000  0x00008000        4096        7        8      1      0
> FOLIO  0x00008000  0x00009000        4096        8        9      1      0
> FOLIO  0x00009000  0x0000a000        4096        9       10      1      0
> FOLIO  0x0000a000  0x0000b000        4096       10       11      1      0
> FOLIO  0x0000b000  0x0000c000        4096       11       12      1      0
> FOLIO  0x0000c000  0x0000d000        4096       12       13      1      0
> FOLIO  0x0000d000  0x0000e000        4096       13       14      1      0
> FOLIO  0x0000e000  0x0000f000        4096       14       15      1      0
> FOLIO  0x0000f000  0x00010000        4096       15       16      1      0
> FOLIO  0x00010000  0x00011000        4096       16       17      1      0
> FOLIO  0x00011000  0x00012000        4096       17       18      1      0
> FOLIO  0x00012000  0x00013000        4096       18       19      1      0
> FOLIO  0x00013000  0x00014000        4096       19       20      1      0
> FOLIO  0x00014000  0x00015000        4096       20       21      1      0
> FOLIO  0x00015000  0x00016000        4096       21       22      1      0
> FOLIO  0x00016000  0x00017000        4096       22       23      1      0
> FOLIO  0x00017000  0x00018000        4096       23       24      1      0
> FOLIO  0x00018000  0x00019000        4096       24       25      1      0
> FOLIO  0x00019000  0x0001a000        4096       25       26      1      0  Y
> FOLIO  0x0001a000  0x0001b000        4096       26       27      1      0
> FOLIO  0x0001b000  0x0001c000        4096       27       28      1      0
> FOLIO  0x0001c000  0x0001d000        4096       28       29      1      0
> FOLIO  0x0001d000  0x0001e000        4096       29       30      1      0
> FOLIO  0x0001e000  0x0001f000        4096       30       31      1      0
> FOLIO  0x0001f000  0x00020000        4096       31       32      1      0
> FOLIO  0x00020000  0x00021000        4096       32       33      1      0
> HOLE   0x00021000  0x00800000     8253440       33     2048   2015
> 
> Now access pages 18-25 inclusive. This causes an asynchronous 128K
> readahead starting at page 33. But since we are unaligned, even though
> the preferred folio order is 2, the first folio in this batch (the one
> with the new readahead marker) is order-0:
> 
> TYPE    STARTOFFS     ENDOFFS        SIZE  STARTPG    ENDPG   NRPG  ORDER  RA
> -----  ----------  ----------  ----------  -------  -------  -----  -----  --
> HOLE   0x00000000  0x00001000        4096        0        1      1
> FOLIO  0x00001000  0x00002000        4096        1        2      1      0
> FOLIO  0x00002000  0x00003000        4096        2        3      1      0
> FOLIO  0x00003000  0x00004000        4096        3        4      1      0
> FOLIO  0x00004000  0x00005000        4096        4        5      1      0
> FOLIO  0x00005000  0x00006000        4096        5        6      1      0
> FOLIO  0x00006000  0x00007000        4096        6        7      1      0
> FOLIO  0x00007000  0x00008000        4096        7        8      1      0
> FOLIO  0x00008000  0x00009000        4096        8        9      1      0
> FOLIO  0x00009000  0x0000a000        4096        9       10      1      0
> FOLIO  0x0000a000  0x0000b000        4096       10       11      1      0
> FOLIO  0x0000b000  0x0000c000        4096       11       12      1      0
> FOLIO  0x0000c000  0x0000d000        4096       12       13      1      0
> FOLIO  0x0000d000  0x0000e000        4096       13       14      1      0
> FOLIO  0x0000e000  0x0000f000        4096       14       15      1      0
> FOLIO  0x0000f000  0x00010000        4096       15       16      1      0
> FOLIO  0x00010000  0x00011000        4096       16       17      1      0
> FOLIO  0x00011000  0x00012000        4096       17       18      1      0
> FOLIO  0x00012000  0x00013000        4096       18       19      1      0
> FOLIO  0x00013000  0x00014000        4096       19       20      1      0
> FOLIO  0x00014000  0x00015000        4096       20       21      1      0
> FOLIO  0x00015000  0x00016000        4096       21       22      1      0
> FOLIO  0x00016000  0x00017000        4096       22       23      1      0
> FOLIO  0x00017000  0x00018000        4096       23       24      1      0
> FOLIO  0x00018000  0x00019000        4096       24       25      1      0
> FOLIO  0x00019000  0x0001a000        4096       25       26      1      0
> FOLIO  0x0001a000  0x0001b000        4096       26       27      1      0
> FOLIO  0x0001b000  0x0001c000        4096       27       28      1      0
> FOLIO  0x0001c000  0x0001d000        4096       28       29      1      0
> FOLIO  0x0001d000  0x0001e000        4096       29       30      1      0
> FOLIO  0x0001e000  0x0001f000        4096       30       31      1      0
> FOLIO  0x0001f000  0x00020000        4096       31       32      1      0
> FOLIO  0x00020000  0x00021000        4096       32       33      1      0
> FOLIO  0x00021000  0x00022000        4096       33       34      1      0  Y
> FOLIO  0x00022000  0x00024000        8192       34       36      2      1
> FOLIO  0x00024000  0x00028000       16384       36       40      4      2
> FOLIO  0x00028000  0x0002c000       16384       40       44      4      2
> FOLIO  0x0002c000  0x00030000       16384       44       48      4      2
> FOLIO  0x00030000  0x00034000       16384       48       52      4      2
> FOLIO  0x00034000  0x00038000       16384       52       56      4      2
> FOLIO  0x00038000  0x0003c000       16384       56       60      4      2
> FOLIO  0x0003c000  0x00040000       16384       60       64      4      2
> FOLIO  0x00040000  0x00041000        4096       64       65      1      0
> HOLE   0x00041000  0x00800000     8122368       65     2048   1983
> 
> Which means that when we now read pages 26-33 and readahead is kicked
> off again, the new preferred order is 2 (0 + 2), not 4 as we intended:
> 
> TYPE    STARTOFFS     ENDOFFS        SIZE  STARTPG    ENDPG   NRPG  ORDER  RA
> -----  ----------  ----------  ----------  -------  -------  -----  -----  --
> HOLE   0x00000000  0x00001000        4096        0        1      1
> FOLIO  0x00001000  0x00002000        4096        1        2      1      0
> FOLIO  0x00002000  0x00003000        4096        2        3      1      0
> FOLIO  0x00003000  0x00004000        4096        3        4      1      0
> FOLIO  0x00004000  0x00005000        4096        4        5      1      0
> FOLIO  0x00005000  0x00006000        4096        5        6      1      0
> FOLIO  0x00006000  0x00007000        4096        6        7      1      0
> FOLIO  0x00007000  0x00008000        4096        7        8      1      0
> FOLIO  0x00008000  0x00009000        4096        8        9      1      0
> FOLIO  0x00009000  0x0000a000        4096        9       10      1      0
> FOLIO  0x0000a000  0x0000b000        4096       10       11      1      0
> FOLIO  0x0000b000  0x0000c000        4096       11       12      1      0
> FOLIO  0x0000c000  0x0000d000        4096       12       13      1      0
> FOLIO  0x0000d000  0x0000e000        4096       13       14      1      0
> FOLIO  0x0000e000  0x0000f000        4096       14       15      1      0
> FOLIO  0x0000f000  0x00010000        4096       15       16      1      0
> FOLIO  0x00010000  0x00011000        4096       16       17      1      0
> FOLIO  0x00011000  0x00012000        4096       17       18      1      0
> FOLIO  0x00012000  0x00013000        4096       18       19      1      0
> FOLIO  0x00013000  0x00014000        4096       19       20      1      0
> FOLIO  0x00014000  0x00015000        4096       20       21      1      0
> FOLIO  0x00015000  0x00016000        4096       21       22      1      0
> FOLIO  0x00016000  0x00017000        4096       22       23      1      0
> FOLIO  0x00017000  0x00018000        4096       23       24      1      0
> FOLIO  0x00018000  0x00019000        4096       24       25      1      0
> FOLIO  0x00019000  0x0001a000        4096       25       26      1      0
> FOLIO  0x0001a000  0x0001b000        4096       26       27      1      0
> FOLIO  0x0001b000  0x0001c000        4096       27       28      1      0
> FOLIO  0x0001c000  0x0001d000        4096       28       29      1      0
> FOLIO  0x0001d000  0x0001e000        4096       29       30      1      0
> FOLIO  0x0001e000  0x0001f000        4096       30       31      1      0
> FOLIO  0x0001f000  0x00020000        4096       31       32      1      0
> FOLIO  0x00020000  0x00021000        4096       32       33      1      0
> FOLIO  0x00021000  0x00022000        4096       33       34      1      0
> FOLIO  0x00022000  0x00024000        8192       34       36      2      1
> FOLIO  0x00024000  0x00028000       16384       36       40      4      2
> FOLIO  0x00028000  0x0002c000       16384       40       44      4      2
> FOLIO  0x0002c000  0x00030000       16384       44       48      4      2
> FOLIO  0x00030000  0x00034000       16384       48       52      4      2
> FOLIO  0x00034000  0x00038000       16384       52       56      4      2
> FOLIO  0x00038000  0x0003c000       16384       56       60      4      2
> FOLIO  0x0003c000  0x00040000       16384       60       64      4      2
> FOLIO  0x00040000  0x00041000        4096       64       65      1      0
> FOLIO  0x00041000  0x00042000        4096       65       66      1      0  Y
> FOLIO  0x00042000  0x00044000        8192       66       68      2      1
> FOLIO  0x00044000  0x00048000       16384       68       72      4      2
> FOLIO  0x00048000  0x0004c000       16384       72       76      4      2
> FOLIO  0x0004c000  0x00050000       16384       76       80      4      2
> FOLIO  0x00050000  0x00054000       16384       80       84      4      2
> FOLIO  0x00054000  0x00058000       16384       84       88      4      2
> FOLIO  0x00058000  0x0005c000       16384       88       92      4      2
> FOLIO  0x0005c000  0x00060000       16384       92       96      4      2
> FOLIO  0x00060000  0x00061000        4096       96       97      1      0
> HOLE   0x00061000  0x00800000     7991296       97     2048   1951
> 
> This ramp up from order-0 with smaller orders at the edges for alignment
> cycle continues all the way to the end of the file (not shown).
> 
> After the change, we round down the end boundary to the order boundary
> so we no longer get stuck in the cycle and can ramp up the order over
> time. Note that the rate of the ramp up is still not as we would expect
> it. We will fix that next. Here we are touching pages 17-256
> sequentially:
> 
> TYPE    STARTOFFS     ENDOFFS        SIZE  STARTPG    ENDPG   NRPG  ORDER  RA
> -----  ----------  ----------  ----------  -------  -------  -----  -----  --
> HOLE   0x00000000  0x00001000        4096        0        1      1
> FOLIO  0x00001000  0x00002000        4096        1        2      1      0
> FOLIO  0x00002000  0x00003000        4096        2        3      1      0
> FOLIO  0x00003000  0x00004000        4096        3        4      1      0
> FOLIO  0x00004000  0x00005000        4096        4        5      1      0
> FOLIO  0x00005000  0x00006000        4096        5        6      1      0
> FOLIO  0x00006000  0x00007000        4096        6        7      1      0
> FOLIO  0x00007000  0x00008000        4096        7        8      1      0
> FOLIO  0x00008000  0x00009000        4096        8        9      1      0
> FOLIO  0x00009000  0x0000a000        4096        9       10      1      0
> FOLIO  0x0000a000  0x0000b000        4096       10       11      1      0
> FOLIO  0x0000b000  0x0000c000        4096       11       12      1      0
> FOLIO  0x0000c000  0x0000d000        4096       12       13      1      0
> FOLIO  0x0000d000  0x0000e000        4096       13       14      1      0
> FOLIO  0x0000e000  0x0000f000        4096       14       15      1      0
> FOLIO  0x0000f000  0x00010000        4096       15       16      1      0
> FOLIO  0x00010000  0x00011000        4096       16       17      1      0
> FOLIO  0x00011000  0x00012000        4096       17       18      1      0
> FOLIO  0x00012000  0x00013000        4096       18       19      1      0
> FOLIO  0x00013000  0x00014000        4096       19       20      1      0
> FOLIO  0x00014000  0x00015000        4096       20       21      1      0
> FOLIO  0x00015000  0x00016000        4096       21       22      1      0
> FOLIO  0x00016000  0x00017000        4096       22       23      1      0
> FOLIO  0x00017000  0x00018000        4096       23       24      1      0
> FOLIO  0x00018000  0x00019000        4096       24       25      1      0
> FOLIO  0x00019000  0x0001a000        4096       25       26      1      0
> FOLIO  0x0001a000  0x0001b000        4096       26       27      1      0
> FOLIO  0x0001b000  0x0001c000        4096       27       28      1      0
> FOLIO  0x0001c000  0x0001d000        4096       28       29      1      0
> FOLIO  0x0001d000  0x0001e000        4096       29       30      1      0
> FOLIO  0x0001e000  0x0001f000        4096       30       31      1      0
> FOLIO  0x0001f000  0x00020000        4096       31       32      1      0
> FOLIO  0x00020000  0x00021000        4096       32       33      1      0
> FOLIO  0x00021000  0x00022000        4096       33       34      1      0
> FOLIO  0x00022000  0x00024000        8192       34       36      2      1
> FOLIO  0x00024000  0x00028000       16384       36       40      4      2
> FOLIO  0x00028000  0x0002c000       16384       40       44      4      2
> FOLIO  0x0002c000  0x00030000       16384       44       48      4      2
> FOLIO  0x00030000  0x00034000       16384       48       52      4      2
> FOLIO  0x00034000  0x00038000       16384       52       56      4      2
> FOLIO  0x00038000  0x0003c000       16384       56       60      4      2
> FOLIO  0x0003c000  0x00040000       16384       60       64      4      2
> FOLIO  0x00040000  0x00044000       16384       64       68      4      2
> FOLIO  0x00044000  0x00048000       16384       68       72      4      2
> FOLIO  0x00048000  0x0004c000       16384       72       76      4      2
> FOLIO  0x0004c000  0x00050000       16384       76       80      4      2
> FOLIO  0x00050000  0x00054000       16384       80       84      4      2
> FOLIO  0x00054000  0x00058000       16384       84       88      4      2
> FOLIO  0x00058000  0x0005c000       16384       88       92      4      2
> FOLIO  0x0005c000  0x00060000       16384       92       96      4      2
> FOLIO  0x00060000  0x00070000       65536       96      112     16      4
> FOLIO  0x00070000  0x00080000       65536      112      128     16      4
> FOLIO  0x00080000  0x000a0000      131072      128      160     32      5
> FOLIO  0x000a0000  0x000c0000      131072      160      192     32      5
> FOLIO  0x000c0000  0x000e0000      131072      192      224     32      5
> FOLIO  0x000e0000  0x00100000      131072      224      256     32      5
> FOLIO  0x00100000  0x00120000      131072      256      288     32      5
> FOLIO  0x00120000  0x00140000      131072      288      320     32      5  Y
> HOLE   0x00140000  0x00800000     7077888      320     2048   1728
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Looks good. When I was reading this code some time ago, I also felt we
should rather do some rounding instead of creating small folios so thanks
for working on this. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  mm/readahead.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 8bb316f5a842..82f9f623f2d7 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -625,7 +625,7 @@ void page_cache_async_ra(struct readahead_control *ractl,
>  	unsigned long max_pages;
>  	struct file_ra_state *ra = ractl->ra;
>  	pgoff_t index = readahead_index(ractl);
> -	pgoff_t expected, start;
> +	pgoff_t expected, start, end, aligned_end;
>  	unsigned int order = folio_order(folio);
>  
>  	/* no readahead */
> @@ -657,7 +657,6 @@ void page_cache_async_ra(struct readahead_control *ractl,
>  		 * the readahead window.
>  		 */
>  		ra->size = max(ra->size, get_next_ra_size(ra, max_pages));
> -		ra->async_size = ra->size;
>  		goto readit;
>  	}
>  
> @@ -678,9 +677,13 @@ void page_cache_async_ra(struct readahead_control *ractl,
>  	ra->size = start - index;	/* old async_size */
>  	ra->size += req_count;
>  	ra->size = get_next_ra_size(ra, max_pages);
> -	ra->async_size = ra->size;
>  readit:
>  	order += 2;
> +	end = ra->start + ra->size;
> +	aligned_end = round_down(end, 1UL << order);
> +	if (aligned_end > ra->start)
> +		ra->size -= end - aligned_end;
> +	ra->async_size = ra->size;
>  	ractl->_index = ra->start;
>  	page_cache_ra_order(ractl, ra, order);
>  }
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

