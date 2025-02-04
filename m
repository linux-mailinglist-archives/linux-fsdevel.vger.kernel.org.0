Return-Path: <linux-fsdevel+bounces-40782-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A10D0A27790
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 17:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E253A6483
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 16:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D8D21639A;
	Tue,  4 Feb 2025 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fJP35hjO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356DD21577F
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738687819; cv=none; b=iWW++NjW3fn0P9kh8rGN390P5EU+5UcYRuuseHVBJustzH9NWTv0GkdHvRIJsoXvra8U175KbupsPjojHGoh6KBbhuB/OPSyvayRqwtF99VXHHEcM6nTPn3fgqTKEow6UEg5+i7sc6j7mZqSVMDfArIHilKr/zjSyGheq9iDxxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738687819; c=relaxed/simple;
	bh=sVVXxPDM3J5k20ScDkP4lDTsX5f6d+e7XClPzHlZnyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0eJUMpj5QSQ7h53HCLuAZuVgyLs45VHhi9UfbzmJjT5F/edWl8rkzPIjiu3MgZk4XPT/c85Oghxx+HszetbC/dRrqDqgf5gD12CfsHdJ1a1AN6oLHGpgd+OXUtHmcWdEy396MATSDrtfga5sxhj5+9zCLVAGnYAOsI09FxrxVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fJP35hjO; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab6fb1851d4so830785366b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 08:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738687815; x=1739292615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MXig0vFmla99DEaZtnnvMhOZoyypf4UMNoK7jl84rTU=;
        b=fJP35hjONH/zHydGw/WPQo/c34ItcMxn+LlzCWCnUBhrRgmMWUawExvdkVZWVseSP+
         bm/KqPUTBu30Q4XH3ydbSlv5WCZE3yxImQIzWmnJoehQVn25FK+EGcqe7mR59dxApYK2
         ISKCOr22BsUuXTz+NpEsT1yDAOlVXNw/YVwnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738687815; x=1739292615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXig0vFmla99DEaZtnnvMhOZoyypf4UMNoK7jl84rTU=;
        b=Ng2GYa+HPiDD07nzHJCtLo6boZc2FeL1rVdmOWC1QZxBSov/270RFJ8fQzAvtpSgbU
         d/zlkB7g0md9UzOmWSgXZrZBUtbe0BtccAnVZUua5GqCBpyey/t8rNXkXQx15d3pkQ/2
         Q6FxYFMqaqZNY0/RZzIRe1+PxpCUuo06tI2x0+oQ4HHw00/xrLxe6tJ2h3+0TfBIhPvX
         lkrHP42ROCUOTSM/1tx0t3hS3eZGXn4r0+ZJlX8XjllUz0pokqKWRet8zO07Pu7qK+cJ
         ff37Cs24+I7Q3o7r9tgM4+1Lmd7jIlYMRpz7eY//lhYCSWqF6IGobhBDqGjwRe1myNAQ
         EuuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUU0VL/73q08wu9ekBBNXDJ5EAzt5dFOa4dhQOrkAQyedcz/dzfAvZeZIk2rNURZLUQjsg5oXrkER/7JF1V@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj7tZnGlXAZV1n/eRiCsUHNtvnBe7/85OpT66xpTj94j04X3pd
	AS54y5Glf7vkv5sanaKA5GuQVStbrw0a3xIHuFxNWIjnsp1y9wrrIFSV4KfD/mzZo/jZaOyPMnA
	6OEQ=
X-Gm-Gg: ASbGncsA0KOphmD5tQ3+O5G+9COxTM66DeS53LOG1C/Wy1sB2gPwQUWBJf9M77pRBWG
	qnwefjucrv15HMXR5+TbXDYYi/MAZhZAiq63UldREMoLjvbAAgp3lB9K3q0jhbOaxfEK2dGdF4u
	OweCVyXGrI7dvhMlJ+rUjaLf5K/HKgMbDaWoCCyEwIgLWHJmrSgRNVa4Uvd2Fjifi4RdvZ5sqjP
	hr6o27zv+I/ALBFAh47vE/EwGGg0YJf7oI7u6I0VQb5rACBK0etZEnX61ucSigMAWrk94oC2RLY
	nECD82S7+6QRZeqGjY5eBJwa8Lv51Op1hAcIzaOApl1fDn/gG5UkTrpakZwU8nHeOg==
X-Google-Smtp-Source: AGHT+IG+PQ3iSgf78pHT//0icwtB9uMwpZoWqZ6EfCsZLlE8nwMhYCXHyTaBadGZDvLQHcjM91dgWg==
X-Received: by 2002:a17:907:6090:b0:ab6:e04e:b29 with SMTP id a640c23a62f3a-ab7483cf04amr400860766b.3.1738687815153;
        Tue, 04 Feb 2025 08:50:15 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7001e4056sm746777266b.73.2025.02.04.08.50.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 08:50:14 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab6fb1851d4so830777666b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 08:50:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0c+0TxQP1RudsrTpymdFHJyFhoaWHdSjuN2kJzHJFUmaNQBLP2BkGfe5BQ5g49txAwKp3+gAQSGrbe6wQ@vger.kernel.org
X-Received: by 2002:a17:907:97c8:b0:ab7:462d:77a5 with SMTP id
 a640c23a62f3a-ab7483f9eecmr421592366b.7.1738687813567; Tue, 04 Feb 2025
 08:50:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204132153.GA20921@redhat.com> <CAGudoHGptAB1C+vKpfoYo+S9tU2Ow2LWbQeyHKwBpzy9Xh_b=w@mail.gmail.com>
 <20250204-autohandel-gebastelt-0ca4424b697b@brauner>
In-Reply-To: <20250204-autohandel-gebastelt-0ca4424b697b@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Feb 2025 08:49:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=whetxWT58ACKO3aGPZQAb_CCpono6U_siynPuvDs2J6rg@mail.gmail.com>
X-Gm-Features: AWEUYZlKVSy7A-MdCfhCcqwKNd9dWUldBuyPBz5QZ5ZLAI0s9CnsJBESrgH_bs8
Message-ID: <CAHk-=whetxWT58ACKO3aGPZQAb_CCpono6U_siynPuvDs2J6rg@mail.gmail.com>
Subject: Re: [PATCH] pipe: don't update {a,c,m}time for anonymous pipes
To: Christian Brauner <brauner@kernel.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	David Howells <dhowells@redhat.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, 
	Oliver Sang <oliver.sang@intel.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Feb 2025 at 08:34, Christian Brauner <brauner@kernel.org> wrote:
>
> So really that mnt_get_write_access() should be pointless for
> anonymous pipes. In other words, couldn't this also just be:

I bet you'll find that even just inode_update_times() isn't all that cheap.

Yes, the silly "get writability" thing is pointless for pipes, but the
"get current time" really isn't a no-op either. There's all the crazy
"coarse time vs fine time" crud, there's justv a *lot* of overhead.

That's not really noticeable on a "real" file where you never access
just one byte anyway, and where any write costs are elsewhere. But
pipes can be very cheap, so the silly overheads really show up.

                 Linus

