Return-Path: <linux-fsdevel+bounces-18841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE46B8BD19B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 17:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 649EF1F22FD2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 May 2024 15:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314DA155727;
	Mon,  6 May 2024 15:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cQFpOZH5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B64153814
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 May 2024 15:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715009797; cv=none; b=RU244Pvm5/9Isbr0sbQic4G8Q433BLC6PgpecHg7qZx/l3s8L6Lt4iRLIlJpuWfK0sey/ZDRjGxJYA2HnvbxXhjrvlD0QhlsJljlH2nn8lgBcexHu1vBVgevJzVkUFxFUf4ZWuj/MEIMfOM5wq790pgU+xkeSn+FBcWcrWAx1Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715009797; c=relaxed/simple;
	bh=okolZHTegM6x+ttsho59LkzT+8+G6g01I/qGFOeSb1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAocHagayAPBqk+P08tdc1PWtIpvzLe2XY7nH7S29obYH675dENeeSZ9U7BiKt87Vy1C2yEksAg3zgc1aFRr4AeYwWqPg5h1UbErI5GqPKYach2Gi9m8KpcY0Pr86s1D2e8nR0I+H2YlvDl6z8heDCjUEIFyztxCje/VeCaWryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cQFpOZH5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34db6a299b8so1320576f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 May 2024 08:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715009793; x=1715614593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IgNpmP+KnJqaBxDJdkx9mmwg/WMduzGDywLz1udliyw=;
        b=cQFpOZH5Xpzym7IOsT74wRI3xbCyAlwMdjKhDrUwSQkh3C6YmrBWl84NQNRZmfINMs
         JUkE26V2JcrNSE5moXI+qSVg3YcsTvo9jXI6QLvk8FNOuOeAw6A6o+L8HjozxigwyYp/
         k4k1wYHcFVbmvO0DJlZNG3Q8s8KWLlY5n+MpkhY7lPwIcWlPOixgRrQXxFpnPU7Nburh
         Gj3SCMhK2k+yLHioZ372OOb43rKXJ8I4nw6RORWJGV1tToFgzHdCLYx5tLw0w+Yj9o4L
         riur0ex102/RYl7UW8fwIdSUVGbC1GBT10VyLWXDchWzg+ObsTMF8l9HmFXmiyS0PHLp
         ZDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715009793; x=1715614593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IgNpmP+KnJqaBxDJdkx9mmwg/WMduzGDywLz1udliyw=;
        b=V+r3+B1USqaLKgPyefcEkozVL3epltNOIoAnYMKwgFyv70/BdL1cC/GPdgQyWr3csn
         l7nJo+EW4+jS9bC7UrTrl36iigVweGQe4SNzKZwIG49WyyM0fR49QTapQTg5h3P21Gda
         fxly1Ahal2dHLKuw9WIID254rMDQB1z9+PCsrqmdiwJ7b4VL4FcUzvQTOaNleO5IeICk
         Lyewd4Km8IUidLAB7rlgvJU7kvpzod1R8vUzjiPUTeAXrZ6KJt8mvEdAmli9DJ1GZBtb
         1xuhahGtrEpGejdBUL8WDYEZvnXm+H7diye8skf5TUNMcgO/tT35s926V1vUtbGy1y0k
         Upcg==
X-Gm-Message-State: AOJu0YxuW08A10aDJleSOlKTPiRnGhGzq+YeRmExSuKQidlPvhLMmkoy
	ByCdjTYkqUqU3c5DCmvozr/wjeRwXEVLCGRMC3myYfuKJRvzej0ZiZy9zKPVyo8=
X-Google-Smtp-Source: AGHT+IGbZTNMLu6hbhyt1bmjEn3Jajf73supUMbIrefeBp7HlOrwI13gU2mgVw4zZHXxgYrif3Od3g==
X-Received: by 2002:a5d:5742:0:b0:34e:3cb3:6085 with SMTP id q2-20020a5d5742000000b0034e3cb36085mr7080161wrw.62.1715009793016;
        Mon, 06 May 2024 08:36:33 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id k3-20020adff5c3000000b00349a5b8eba6sm10895265wrp.34.2024.05.06.08.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 08:36:32 -0700 (PDT)
Date: Mon, 6 May 2024 17:36:30 +0200
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
Subject: Re: [PATCH RESEND v6 3/3] printk: Remove redundant CONFIG_BASE_FULL
Message-ID: <Zjj4_hWkz9-qHnWe@pathway.suse.cz>
References: <20240505080343.1471198-1-yoann.congal@smile.fr>
 <20240505080343.1471198-4-yoann.congal@smile.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240505080343.1471198-4-yoann.congal@smile.fr>

On Sun 2024-05-05 10:03:43, yoann.congal@smile.fr wrote:
> From: Yoann Congal <yoann.congal@smile.fr>
> 
> CONFIG_BASE_FULL is equivalent to !CONFIG_BASE_SMALL and is enabled by
> default: CONFIG_BASE_SMALL is the special case to take care of.
> So, remove CONFIG_BASE_FULL and move the config choice to
> CONFIG_BASE_SMALL (which defaults to 'n')
> 
> For defconfigs explicitely disabling BASE_FULL, explicitely enable
> BASE_SMALL.
> For defconfigs explicitely enabling BASE_FULL, drop it as it is the
> default.
> 
> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I am going to take the series via the printk tree. I am sorry
    for the delay. I somehow expected that it would go via some
    arch tree...
    

