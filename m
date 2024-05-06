Return-Path: <linux-fsdevel+bounces-18842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4658BD1FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 17:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D89E1F24592
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 15:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D7B155A52;
	Mon,  6 May 2024 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q5Y1FjE7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C48E4D58E
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715011126; cv=none; b=VDm9YpdTg/Q+TE1wtxNU4XrgrUDrM7OTx1SWvo/1oil682NnXTMNv0F5s4dbNxr9PsX9rB/snzzsy0efxPUt1uUQVZA6tPumZI5W4JzVkgOiAoGuVNaO+LZK9wQzdGPy/0gNlB+kU/tQ8jani8vyYsb9Yu7itYquQrzZctWf6oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715011126; c=relaxed/simple;
	bh=e+ZSe+ZA9xaJO5eEBFHbnwpPwoeLA8xT48mtZrmDIak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdw3VWGJFX4u7nWwojgIajVope//twWNxC57kKwgIQrnrIEtqQrTZQfR4KrvMQH+VIBm24roRl4vL9tv/4aaM4TWsBFZLEGqwC5UL9aMl9wNBZ3HN0j+10AXnCn4LSAlm5ueeLER00o4VtR0iIRWkyyR7JkF2vbgA/qupbNxPfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q5Y1FjE7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34d99ec52e1so1307279f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2024 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715011122; x=1715615922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b77bW1UHopiAiUiwt+teFfDgmUSq65L4Labg5fS22oM=;
        b=Q5Y1FjE7a/VuhZbsHhx2X9OhIrC6dc7qblhpdUdax5eI2SdbEO6kx/YJoRiKhEyy9h
         W73ef+3G6tWk7Mw66NJ3TdC9Y/MMV6FBDqzVlAiBS63YURu1d4NotgBUPNezW3VY6e2e
         b6LnubxGKzi+SdiIiTDsSrmgMaXPRsMs+VN6pHK0KaOycWJ5TnZFLVpfZPujHkja/zqN
         FE+glFGwhUZigi/W9DmCMg+3CH15qrMOyxcqsbcS/DXFgK16B0x6dkBkWyfU2VSU13Zk
         0LKmZHnuPlvHxGC9wZQTFD7VS+VszAONoOUbceXIokgaYu8E1A3Kii0C/am8BddqEDTO
         EeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715011122; x=1715615922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b77bW1UHopiAiUiwt+teFfDgmUSq65L4Labg5fS22oM=;
        b=WY+FbRWBxMi5++/OX8gQSM1YCqQbo0h5nB1YIETURiewtKlENUgNFM/SiDMNTLMmki
         MRl8MyUQ8KVpTAN4f0vOnzP2vaQj6ZjSAwxXou+gaRNwX7njVijSrIpWL3UZC5+Jn5jI
         1yhECwahzQc77t/RBGV5DIVzdwnu4dlYN2gdO9A9QfrpaRGoOfJvctHyViaYbs9vl0Sm
         3fCt35GLiIX72TwPFDS9r9GpcDNMHmloDZUDQj0v+aArUg2WthBdd95gjKOnauIDDixh
         GAWGD/1PCqcVm7B5kCj28xC/RCmRh2ARalwtg2fueUzQfA6pxfEpZnuwXLYmYhnnDeJm
         KDSw==
X-Gm-Message-State: AOJu0Yw6ejzqPWXmNToMLacBDn0QXpB+3mSDkSZ+kxnN0TbVwBL9qfLr
	MkPgm03gZboSEz3274RfAhj7KqCWLhGRcElTzNe2Ian0a0Csg/w329wCmuTwzoM=
X-Google-Smtp-Source: AGHT+IFSFaunKOZ8WI6/uX/7mp9FL9IL1kmUTfFZ/AIhGtSFSDgsttFAOhXLCCCeUTyT3rqTdOQ2lw==
X-Received: by 2002:adf:f0cd:0:b0:34d:7cdf:7fb3 with SMTP id x13-20020adff0cd000000b0034d7cdf7fb3mr7405652wro.62.1715011121850;
        Mon, 06 May 2024 08:58:41 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0041bb11ff5a7sm20325100wmq.8.2024.05.06.08.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 08:58:41 -0700 (PDT)
Date: Mon, 6 May 2024 17:58:39 +0200
From: Petr Mladek <pmladek@suse.com>
To: yoann.congal@smile.fr
Cc: linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	x86@kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Borislav Petkov <bp@alien8.de>, Darren Hart <dvhart@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Josh Triplett <josh@joshtriplett.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH RESEND v6 0/3] printk: CONFIG_BASE_SMALL fix for
 LOG_CPU_MAX_BUF_SHIFT and removal of CONFIG_BASE_FULL
Message-ID: <Zjj-L-FuVyMmRPth@pathway.suse.cz>
References: <20240505080343.1471198-1-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505080343.1471198-1-yoann.congal@smile.fr>

On Sun 2024-05-05 10:03:40, yoann.congal@smile.fr wrote:
> From: Yoann Congal <yoann.congal@smile.fr>
> 
> This series focuses on CONFIG_BASE_SMALL.
> The first patch fixes LOG_CPU_MAX_BUF_SHIFT when CONFIG_BASE_SMALL is
> used.
> The second patch globally changes the type of CONFIG_BASE_SMALL and
> adapts usages.
> The third patch removes the now redundant BASE_FULL, puts BASE_SMALL
> in its place in the config menus and updates usages in defconfigs.

The patchset has been committed into printk/linux.git,
branch for-6.10-base-small.

Best Regards,
Petr

