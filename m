Return-Path: <linux-fsdevel+bounces-10318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 320E7849BDF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 14:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92AF41F2448F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896E420DC8;
	Mon,  5 Feb 2024 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QvflKCCq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B2E28E0D
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140077; cv=none; b=sZPupclRz2GIqixeE+uig2gUQxrnxA1LKQn/pq2kpSi0O1/lje8W4iF5TS7nOJ+MEwJX+eKJBK9/f3SE21aNKuxQq17p0omOzBiuaN59OUwZKBbFbn2aoHdG9pX39MbvBnlIuA4hutm5DuPkjh6EpOnM1a3KcepkDLnmBmOwdqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140077; c=relaxed/simple;
	bh=UW3im1Ox52r7lMN+hqUD1btlAY9FG9HoD4t9HdhYE9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tv8JS3LNjLu4m5vo1CCkMEYESCp+hm6Vx7fMQllxYV+nnUTDZxVdlB+aH4d1Wj786O2l00+nAn9HIjND6AIuUui1hqZpqmmGL29TeeoztbPRwyKRIY1N69x6jhSr4/Vk2U92OX/jLTp922gh7sMCc5RwNWfhzRZwgfO/5p8a/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QvflKCCq; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so5385948a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 05:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707140073; x=1707744873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MoY22caN72Vu9KETh7xj+mgQ1cwoewKUNf39bRI8TM4=;
        b=QvflKCCqPT8NaOkNUQLqtciDfXwlIRUFHRJxHry180Am8utFKkstCAa5P2g5wL2mTy
         D0sx4+i69x94FFoLXRJy1kCNqOeTaP8hZT9pjzMCIXmPn2wTAuVlhQX3vp7s99NpTFn3
         k+8quJ9db25UqbTP1YOTlzJyCHZH+HuV1O2a/H8bN6WCnN8N0C8OSaDlvA0lrkSmYos+
         rnzavng8fi+1zc8YclT898Dg5PPbQCr/eN7j0qmZsTvavTkFMKGusMjaITS25Bl2mwoQ
         PJ8KdLiyULQGEdsBt3YBR1z7Oal9l8fLGmK/ufHCnL5k8Jp9vWCSAdFeaJ4b7d5sOEDh
         L8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707140073; x=1707744873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MoY22caN72Vu9KETh7xj+mgQ1cwoewKUNf39bRI8TM4=;
        b=n768UeAf7WO/83gx9EgcSHTYvciEI30ZMDSdeaXRqfXRsIRE5fXnqS8JXSj3/2xKb5
         DkIFEYmQHou3kzAAvRIpHf7LmMjjYYCKnB5YahqVkmpRXInws3jyTTNyZqdLKI1fYkMz
         kIhJUWvdxEtmMy3g9X9Q5dLQSVBXaB1fsnTWdxAx3YS+zDCkSDycIsh2m9Ib1hceksij
         rEeb1EK2XZMFxxBfcdo81AjW0N1N9RVZDn7sCPbUR32/t4IecjR1jF6IKYDR1dBmeOSU
         ZW8m0tZ8+mRDMHkPJZCncW5om5PLcXslnyCZdGjvBadiGSCgimJ4keX9EhKqvZ5l7lcx
         /qAg==
X-Gm-Message-State: AOJu0YwNB0Jhd/BBnW0LQPcHx1UtoERhnCaD6xl3V1fJnYSZhz89gKLk
	G5c9LERRAHO9Ifb7RBj9XAC8IkobYxkNurql+PVDnPkoPPRK4sdrYZZ6EqFQxUM=
X-Google-Smtp-Source: AGHT+IEC3kTLCzb3x/ZJNrQ3m7qH7T73JdE8hFqGPq0po96TlHhVpjsMylVBEMEi0JY0ZcznB5vRdA==
X-Received: by 2002:aa7:d053:0:b0:560:1c4:cb31 with SMTP id n19-20020aa7d053000000b0056001c4cb31mr5211174edo.17.1707140072720;
        Mon, 05 Feb 2024 05:34:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWHvq8X17Q4c52RNFavgb5jCUgIyRYRaA7nmdEqwDRd8gtd1CIP7FTGjqjnlcFy9HC8NgTPlJjX1a6MB1SL/XYNjUvOFM2/ZVKmpLUANk9reiPUl/r7cFZq6Q68RMZ2KMNNoY/OmBdTr+j6PY6OZIc5zehJcaXY0BkPHtJ10damWnmTsIx0rX9pELJEYlI9Xe2owYhNT403E92YKvFvEUMp1pa2HVpN7mZZyuJn9NDNJRU6CZqfvhNkn6T9lJUEYBIphM5I3ZOmlaEuSVPHpBs8vplk6Syf7V6K7JlPQ0J0wbhxTt2ei2bDeN9eZ7LeJxMUpvAx0PkkCr3yrS8CJtqu/8QLHetSIYcfOuWMOz/WvYKE8EXKJC9CQNXGJZcEIpASA8jdLhSxFRh2odfpdKd9/ek2MaaIraTkonN+f0hUE9QPTXArPcNnmkck7rIy3MM0ETv3Idb3C4RrF57UhHsdw1B+58QEW1NPQoR1KPCX4akh1v/2UWpgqR+bqq4pxdmblx13T0S6PxCqEggOia5cdZ+YVjqedsSGxGsi/fd5oGc01RTu8TYrZS9zvryqI3aKkVulI8oGLq7vxy9akEMaeGOP+BJxorOjjAngW/8vB0APgHAE18Hxtv/o8AZUn8x9r8GMLGt7q5qEidT9eOls2oUEuFQduq29WmCn6vkyYdPbsSySuYWuFOvLLH2TlQgo/DUbST2vDu2VgkbdgZVMpLa8VkepdEdNYtEAovYT8vqYkOKU0OT2DVj+wMwaM2NvPpdd3KoE9pLcmO0jLUvgUUe9XPTOA+2f8XlaVXA=
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ew11-20020a056402538b00b0055fed0e2017sm3601596edb.16.2024.02.05.05.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 05:34:32 -0800 (PST)
Date: Mon, 5 Feb 2024 14:34:30 +0100
From: Petr Mladek <pmladek@suse.com>
To: Yoann Congal <yoann.congal@smile.fr>
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
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH v3 1/2] printk: Fix LOG_CPU_MAX_BUF_SHIFT when BASE_SMALL
 is enabled
Message-ID: <ZcDj5hZeu_LqEsuH@alley>
References: <20240204232945.1576403-1-yoann.congal@smile.fr>
 <20240204232945.1576403-2-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204232945.1576403-2-yoann.congal@smile.fr>

On Mon 2024-02-05 00:29:44, Yoann Congal wrote:
> LOG_CPU_MAX_BUF_SHIFT default value depends on BASE_SMALL:
>   config LOG_CPU_MAX_BUF_SHIFT
>   	default 12 if !BASE_SMALL
>   	default 0 if BASE_SMALL
> But, BASE_SMALL is a config of type int and "!BASE_SMALL" is always
> evaluated to true whatever is the value of BASE_SMALL.
> 
> This patch fixes this by using BASE_FULL (type bool) which is equivalent
> to BASE_SMALL==0.
> 
> Note: This changes CONFIG_LOG_CPU_MAX_BUF_SHIFT=12 to
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=0 for BASE_SMALL defconfigs, but that will
> not be a big impact due to this code in kernel/printk/printk.c:
>   /* by default this will only continue through for large > 64 CPUs */
>   if (cpu_extra <= __LOG_BUF_LEN / 2)
>           return;
> Systems using CONFIG_BASE_SMALL and having 64+ CPUs should be quite
> rare.
> 
> John Ogness <john.ogness@linutronix.de> (printk reviewer) wrote:
> > For printk this will mean that BASE_SMALL systems were probably
> > previously allocating/using the dynamic ringbuffer and now they will
> > just continue to use the static ringbuffer. Which is fine and saves
> > memory (as it should).

More precisely, it allocated the buffer dynamically when the sum
of per-CPU-extra space exceeded half of the default static ring
buffer. This happened for systems with more than 64 CPUs with
the default config values.

I believe that this patch won't have any effect in practice.
It is hard to imagine a system with >64 CPUs which would require
BASE_SMALL kernel. Well, never say never ;-)

> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/all/CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com/
> Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
> Closes: https://lore.kernel.org/all/f6856be8-54b7-0fa0-1d17-39632bf29ada@oracle.com/
> Fixes: 4e244c10eab3 ("kconfig: remove unneeded symbol_empty variable")

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

