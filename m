Return-Path: <linux-fsdevel+bounces-70965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0045FCACA6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 08 Dec 2025 10:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B63B030039CB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Dec 2025 09:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6925730F95E;
	Mon,  8 Dec 2025 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHNFx9yt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EAC2C0F72
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Dec 2025 09:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765186020; cv=none; b=YIKQV6vrS/C8Oc89gYWhIzjpTFI3Tr3BLRtwB9LS7UJllyhGQEwkYDNAmBglxzh8I2R7lzvC/9uvdpi0UrNpnXLUVHd6LJeKCbITCzsmCFAQWA/z7NrcMXpZEOw5EaCKTqfxq8LaLG7UWRPlRsUmB3zv0AbDEDBcYxyFz8Tovzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765186020; c=relaxed/simple;
	bh=NOd0DlEjhmPlYghl1Z0HMLlAmM1GAArJZoG9CqkchTY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OLxzH//OIYynPBGGMnPfnrOR4o4FEVtw5ItuD+v17O2HmI5y9tBZX3Up6C5ZHlzr5u1ZxdfYvNRIklBcySVB0l/gwmkTUH+Ya5ScqJZw4pZEJm/pLIj0b0AvRHktc5T26ZKe1PCHr6/OJSwBkczlpg1CHr3kZNIKGD6ejgFa6dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHNFx9yt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47790b080e4so25412625e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Dec 2025 01:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765186017; x=1765790817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFLfpZ5l4wRVBkAGkPslmSuVObNJ4meI7Eg1f2GcF6M=;
        b=jHNFx9ytjZKlDkW8EaRcfWu2zql17kSS5gH9KUEPyVpwp5fTu5feS4dfwdrNWt4Haa
         0lyp+LoTL0rMxtXrW22WzNQUZJnFG/zPg5rU7kGRjtuub8xl/NMuNzOzkxyxwRa5Swzz
         7GIxTKWBvCtdNEcfmt9IcajPrbCrcyZJx5J09icjmVeF4Dm0BN9qLViJVVBMKD1JRjsN
         25ET8ppeCxlYrd1tV9o6NN6v8LEiRZ5EOTO84MLZtjZX8OJjKl1yviBGQpwMd3/rW1b+
         BRHQJpr0RmTyUImugxAfIa1NkBlLwUeb8puYb3jMC+WY3VnZM2dYsfOsssDn9rYwD/Th
         V3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765186017; x=1765790817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NFLfpZ5l4wRVBkAGkPslmSuVObNJ4meI7Eg1f2GcF6M=;
        b=JKmzjODmmLz+gcekDAJ8WKt8gVWIM0l9VOXs+4wT1adg1xMiGD555gsYeBVJkECC2r
         BQpXVT42QJ9ZuW0oSAYQGKgX9hRjcFUMJZGYPC++bitIb6cJl34Uogk7Y8gU8gr1Eonw
         gnbf7H92o55jopr32Hbele7cVD7IeJ6UXH8cjnJvRc76QAkiXUgLMASGcqubWgzdM0kL
         tTfvBt0DIT0vGRrug/uUJWoXa2MIPUJYHt8gyj8gDgxbXhRXZv3DcxB8tfO0DERMaBsV
         KfcrgcfNSIUUkS+uNRbFldnrq3+Y1DLgMGaP9JfPg8p/EmosO4F5dtOomtzelgcWp6Hu
         L3CA==
X-Forwarded-Encrypted: i=1; AJvYcCXxJSEUiqG1UuINWMoeKYTOHfV8UQ8LShKPHRp+AR2REXHVYWnn0qPezJ2Q7MmHBJxITA4sCiIjYjM0IoCe@vger.kernel.org
X-Gm-Message-State: AOJu0YwO0ByIiEWVbyFuOo69vwC74TQRwt7kvtuvALZLaUES3G596F4+
	o9DxC36XtiLlUrH7ikN0J3g5O1KCgNT12cBJn2xWJwhnZOUdgWlIYJQd
X-Gm-Gg: ASbGncvEh3quRR1dcf0GWHhVYpOe1uukfLGE9XLI00KIWO/kK5zzfo8Zew3fZipLz/w
	NxTatrpGOHQVCo58gUKP0vDBUUH088zBHWemdB/Be1+qwLipjr7ZiQ8XkeLkYHZUP/9AEAEPbHH
	ieXJ+enUw5iEWjQUb1xbQzsdjObpOFENdC3qGdPvBJ96xoY9lnzwdNx28wgpOIRU4nqQZC8PobB
	LnGUDTH/BRZs89qUTpBxVXrPncRveSalctFP05UhvmZU1W1rhVxKzpjWME1NiTSGHYR/O6fv6Ob
	+3CnTpXOp8smWyAU11NUhMpzgl95+N4zc9nmV5kfc6q/XVlmkTpDJsRYopOeg0XuIXZPH4ALrGE
	MFvgh9olHBh/pK7CY8G2Ruj6kiXjXxyj2emGbcAMghPXaOtrb4fVKheZ9BrAbcZYs43Y5rlbm6B
	ASAAxCl2T7VKBRUDQsUjSHBNYyeGixghjQw6d56RZO/cyRG3q8FIXs
X-Google-Smtp-Source: AGHT+IHojEX23VDsygt3ALVaB6koy85KM2XZe3lsMntBbpBgGnMPUb++LOsJBnCIkyeM2dwfndjplA==
X-Received: by 2002:a05:600c:a087:b0:477:7925:f7f3 with SMTP id 5b1f17b1804b1-47939df563amr90509565e9.14.1765186017202;
        Mon, 08 Dec 2025 01:26:57 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b04e1c1sm118716705e9.5.2025.12.08.01.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 01:26:56 -0800 (PST)
Date: Mon, 8 Dec 2025 09:26:54 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: <linux@armlinux.org.uk>, <viro@zeniv.linux.org.uk>,
 <akpm@linux-foundation.org>, <brauner@kernel.org>,
 <catalin.marinas@arm.com>, <hch@lst.de>, <jack@suse.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <pangliyuan1@huawei.com>, <torvalds@linux-foundation.org>,
 <wangkefeng.wang@huawei.com>, <will@kernel.org>, <wozizhi@huaweicloud.com>,
 <yangerkun@huawei.com>
Subject: Re: [Bug report] hash_name() may cross page boundary and trigger
 sleep in RCU context
Message-ID: <20251208092655.6d88af9f@pumpkin>
In-Reply-To: <20251208023206.44238-1-xieyuanbin1@huawei.com>
References: <aTLLLuup7TeAqFVL@shell.armlinux.org.uk>
	<20251208023206.44238-1-xieyuanbin1@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Dec 2025 10:32:06 +0800
Xie Yuanbin <xieyuanbin1@huawei.com> wrote:

> On Fri, 5 Dec 2025 12:08:14 +0000, Russell King wrote:
> > On Wed, Dec 03, 2025 at 09:48:00AM +0800, Xie Yuanbin wrote:  
> >> On Tue, 2 Dec 2025 14:07:25 -0800, Linus Torvalds wrote:  
> >> > On Tue, 2 Dec 2025 at 04:43, Russell King (Oracle)
> >> > <linux@armlinux.org.uk> wrote:  
> >> >>
> >> >> What I'm thinking is to address both of these by handling kernel space
> >> >> page faults (which will be permission or PTE-not-present) separately
> >> >> (not even build tested):  
> >> >
> >> > That patch looks sane to me.
> >> >
> >> > But I also didn't build test it, just scanned it visually ;)  
> >>
> >> That patch removes harden_branch_predictor() from __do_user_fault(), and
> >> moves it to do_page_fault()->do_kernel_address_page_fault().
> >> This resolves previously mentioned kernel warning issue. However,
> >> __do_user_fault() is not only called by do_page_fault(), it is
> >> alse called by do_bad_area(), do_sect_fault() and do_translation_fault().
> >>
> >> So I think that some harden_branch_predictor() is missing on other paths.
> >> According to my tests, when CONFIG_ARM_LPAE=n, harden_branch_predictor()
> >> will never be called anymore, even if a user program trys to access the
> >> kernel address.
> >>
> >> Or perhaps I've misunderstood something, could you please point it out?
> >> Thank you very much.  
> >
> > Right, let's split these issues into separate patches. Please test this
> > patch, which should address only the hash_name() fault issue, and
> > provides the basis for fixing the branch predictor issue.  
> 
> I conducted a simple test, and it seems that both the hash_name()
> might sleep issue and the branch predictor issue have been fixed.
> 
> BTW, even with this patch, test cases may still fail. There is another
> bug in hash_name() will also be triggered by the testcase, which will be
> fixed in this patch:
> Link: https://lore.kernel.org/20251127025848.363992-1-pangliyuan1@huawei.com
> 
> Test case is from:
> Link: https://lore.kernel.org/20251127140109.191657-1-xieyuanbin1@huawei.com
> 
> Test in commit 6987d58a9cbc5bd57c98 ("Add linux-next specific files for
> 20251205") from linux-next branch.
> 
> I still have a question about this patch: Is 
> ```patch
> +		if (interrupts_enabled(regs))
> +			local_irq_enable();
> ```
> necessary? Although this implementation is closer to the original code,
> which can reduce side effects, do_bad_area(), do_sect_fault(),
> and do_translation_fault() all call __do_kernel_fault() with interrupts
> disabled.

It has to be safer to leave them disabled.
But you don't want to do that over long code paths.
But I'd have thought the 'act on an exception table entry or panic'
path wouldn't be long compared to an actual ISR (or other code that
disables interrupts) so there is no real point enabling them here.
But that is just my 2c.

	David

> 
> Thanks very much!
> 


