Return-Path: <linux-fsdevel+bounces-13576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 148218713F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 03:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C8D288C6A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 02:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113ED29416;
	Tue,  5 Mar 2024 02:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e1OCmsnv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D8A28E3F
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 02:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709607403; cv=none; b=s90+T0xttb3EW5M6D3ceQGEh4jdJiXaT8wweXdpwRXbwe1pw2S/leYOLFXLAc6LjmApwpXyNh2uWc+lon6LTuhy0E49As3QUxn+eTongseemrg7MNv2rjqUNKFRZQxUNf0Gh98GJQh+yk6ItKisp8UlJc5duJTU+QthmJw/8X5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709607403; c=relaxed/simple;
	bh=+a/bGF67RrRMq/JJCQOD+w1zfeBPslpGFRIpJTwCIY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pi0atUVKsei6pCeZ333iYQKwymrLG7cHSwfXT6vQzYo2berLf0aPJTThUX6I5aG0pfEt9JwGquXHy8JGNZhgOjsY4y0Mz8LggOIxoZZ0u2CzfwSoMDxJz1nFRvsoz5OCxpJ8BFlhUgOYf8UKaA7JfvyomnvLsD68u7xAsdkzJis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e1OCmsnv; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a45aa7cb2b3so5585066b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 18:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709607400; x=1710212200; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+a/bGF67RrRMq/JJCQOD+w1zfeBPslpGFRIpJTwCIY4=;
        b=e1OCmsnv8XlFPgejoHQ5aea1Zw52YR9l+Ck1pub3MTLZ8GKcNz90+JFQlvO231p5lS
         Hi2oEqsZuosFR1kgb0uccthEK0LJzCdhiPdpRRIA9ipOPFBaRfotPLCFKV4NCjZ4ihBZ
         N49oZk+OcgPluM8w+m9P8nNAWzFWHaFyP/A6W2InrsHfD4zYHWh1dBEabp9MX250DKy7
         iKzaKcbL0ew5+gxGrUUu04RufhwM5DvWq/StVWBkeQzEQd5xzmXrrZAvaT94zBzKBb86
         O5pH3FRDYXME4eugCyGo/wOgy4yyN6zGs67CGzbK5P4L44J0CLm/bs7qBbi4eiz0/ygB
         dL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709607400; x=1710212200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+a/bGF67RrRMq/JJCQOD+w1zfeBPslpGFRIpJTwCIY4=;
        b=q7OH35e4MKt0vWp4jbiD2gYmhqmmCk+zWsJ4i6kvafmHBNz9o/K7BIav7l73iBe479
         f6lCb3uxpMNBjQIDGwLqUyeNEX/aX4H54vm34W5oxP270kl9hi69G7ttzAsjSiYrUnZy
         zM1uQ3KtBkZLqlNNyGx8krCCoNtFmOq1qT2qcWifSNkBWXR+RKJ2esbmG28ZOA32EbAD
         m+KC2XBz9dOsDDTYp4/Bmr4weL9QptsTEDFmGg4+fTV7Tp4ulDUush8drvxgT+OO6ZxP
         20/D+Hk5tG5wSL5/Me/h6ONBTi6XEGgv8BwDzsldp2PjlMFIrXmA4dzgoRUYZzi3SiDt
         3ing==
X-Forwarded-Encrypted: i=1; AJvYcCWOGFGxoyYV+M8+/G/IMt47+qoFiknIQpEja3vXXPX4bxzLYYhqO4QNk2ugvxGd6K/1KCh9VmQl1S2N6pqBOr4Pp+aUlO8mvGJeOZ7rag==
X-Gm-Message-State: AOJu0YxWRTnq1LEbgAs9u9rlZR6ZGWxOujQbgREEzzlpP6X0Cnqqn1Kh
	zFxi3puSQK2G3D6cXGgdC5DYk5eB3dwHKihHFL0O+dTXUHRhYPnF86lHrBrAmuACQ/Kxl5DoU7K
	NWkcagYJT61wtZ9cdsfMNQ/7e3S5DyzfiV+PF
X-Google-Smtp-Source: AGHT+IEIgWXWVlIkMLWUnRUlc/2I1/rqfquInSautNQmo/qXB6Oh3m/iRLbUOiWj9p8n8RIRlXKQ1Yj+9lYKswa/KdE=
X-Received: by 2002:a17:906:e1b:b0:a43:2290:7689 with SMTP id
 l27-20020a1709060e1b00b00a4322907689mr7096674eji.65.1709607399891; Mon, 04
 Mar 2024 18:56:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <d4cc365a-6217-4c99-a055-2a0bf34350dc@paulmck-laptop> <aq2mefny5fahoggtgfmxwufanwsqmwideyioiiatg777i6quk4@fy72ug5aszzt>
In-Reply-To: <aq2mefny5fahoggtgfmxwufanwsqmwideyioiiatg777i6quk4@fy72ug5aszzt>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 4 Mar 2024 18:56:03 -0800
Message-ID: <CAJD7tkZdbSK=2BRZUmjYyq_=rDF+OsxFspgr2opusCAh-XS8Fw@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

[..]

> Willy and I were just chatting about this and I think the conclusion
> we're coming to is that we'll probably want to try just RCU freeing
> _everything_ at first, the reason being that anonymous pages are
> probably going to get included and that may end up being most of the
> allocations and frees - so why not just do everything.
>
> Meaning - _lots _of memory cycling through RCU, not bounded by device
> bandwidth like I initially thought.
>
> Another relevant topic: https://kernelnewbies.org/MatthewWilcox/Memdescs
>
> The plan has been to eventually get an actual enum/type tag for our
> different page types, and that would be really helpful for system
> visibility/introspection in general, and in particular for this project
> where we're going to want to be able to put numbers on different things
> for performance analysis and then later probably excluding things from
> RCU freeing in a sane standard way (slab, at least).
>
> I wonder if anyone wants to solve this. The problem with doing it now is
> that we've got no more page flags on 32 bit, but it'd be _very_ helpful
> in future cleanups if we could figure out a way to make it hapen.
>
> That'd help with another wrinkle, which is non compound higher order
> pages. Those are tricky to handle, because how do we know the order from
> the RCU callback? If we just don't RCU free them, that's sketchy without
> the page type enum because we have no way to have a master
> definition/list of "these types of pages are RCU freed, these aren't".
>
> Possibly we can just fake-compound them - store the order like it is in
> compound pages but don't initialize every page like happens for compound
> pages.

(Not following the thread closely, sorry if this is completely meaningless)

Why not store the metadata we need in the page itself, given that it
is being freed anyway?

