Return-Path: <linux-fsdevel+bounces-19905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D549D8CB106
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 17:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BED9B2397A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369AD143C54;
	Tue, 21 May 2024 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hSq340AO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07AA77F2C
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716304249; cv=none; b=QsERQCU9nJmGAArrJrCsxN8OhRtFVs2gTR3Oi6JAf05y1YyTN6XqRRySMxTAGEcAvJdssdDJGO+7gYsDt7QTR9d/L39976iG/9D6USGDisNwgWNltqf4ZQaVXtRJKpbk0o86rpuJqCpL2p2v85CqMlBrwUCIjxKB31rmpgCHLY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716304249; c=relaxed/simple;
	bh=rnT4m2kbTM3d7fDaF6DU62iaWukv9/WjWYNWnrZ8dso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdlbxlRRaPWwtPrr5cp7HUu/HLgkPvWFRS+/Kcq/2Os4HWqvXYxPaUng3cx9mYQOqV09wjU+maUk2OuVPrG0WMuydqE0cqmwYWzzK3h05DVZTG/5aFaOgZuiZb/TYWenZJoX+of64ur0oX9N3PfaojOp8XmMJlLEfLVr+hPcSpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hSq340AO; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5a2d0d8644so761904466b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 08:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716304246; x=1716909046; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8YQmkdZTNn74MqXgdihPObmjoUF1z4M+6gYY01hGKcU=;
        b=hSq340AOsroBFyUZL1Ekqkt5UYKgkHQCvU/3N5uz7QosEBhgnSWAjlJx9H5zs6k61y
         9CDax1uCnL09hPwBRoyos3ap4roZY/P0Ityhqu38ZYyTnSwXzQPG1Y+gF8B3vbD4aQFm
         U72Ax6dRdVhW8mFEutgDrh1pyFf7hMYJOByjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716304246; x=1716909046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8YQmkdZTNn74MqXgdihPObmjoUF1z4M+6gYY01hGKcU=;
        b=BD8+9raVPSt9sAZR5hrv7sBzAd9LlFPBCsSnqLadaWnP0j5QNIqHAY4QMOWydhI9xs
         kSWfs0BXxP9f7U5flwdVp0Toyy5QeF6loU142kM86T6zUHeRvx70L7Fctf6kIMYoq4bZ
         wYmYRPqJ6F76yMabfG/wYtGjhVIoBsmTu7xLl4yG/JyCHe9PZqPbzih77RBS1MNf31QE
         OVM/7ksmM1qFw59cdm3+mSBL7og9//QkMi4XpTvy82D0PhT9BPT1WeBVDzEBSI+uGPb/
         3uzBbBExn/hFhDo5av2sKfK4s1q8DQhTYyhIzPp68FHYBcfpRNVHIe+uQAkEINrQqTny
         oFWg==
X-Gm-Message-State: AOJu0YyC8H9K0vhPUwkFdWVjdbuPVZ97M5Hw1ltBOinfXSLx1Xm3xlJt
	YylxTvq03j8NYFfXukFkPHedVDHCd8H8oED9+mYXjmqpSon6egUGwVN95d+90TWC6xy39Ob8aN1
	M5HohgA==
X-Google-Smtp-Source: AGHT+IFSE2+vRINTqWuLS/NIRV8aiahM/8EIPnXwCh7hsa/7iu//1inwPjCYFDQ2CikrhfpP8Sn8ew==
X-Received: by 2002:a17:907:36c:b0:a59:c6fd:5160 with SMTP id a640c23a62f3a-a5a2d6bc140mr2314667566b.76.1716304245738;
        Tue, 21 May 2024 08:10:45 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17cc5sm1615633166b.205.2024.05.21.08.10.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 08:10:45 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a621cb07d8fso4524366b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 08:10:44 -0700 (PDT)
X-Received: by 2002:a17:907:3686:b0:a5d:107b:60be with SMTP id
 a640c23a62f3a-a5d107b6287mr1049864766b.69.1716304244667; Tue, 21 May 2024
 08:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a15b1050-4b52-4740-a122-a4d055c17f11@kernel.org>
 <a65b573a-8573-4a17-a918-b5cf358c17d6@kernel.org> <84bc442d-c4dd-418e-8020-e1ff987cad13@kernel.org>
 <CAHk-=whMVsvYD4-OZx20ZR6zkOPoeMckxETxtqeJP2AAhd=Lcg@mail.gmail.com>
 <d2805915-5cf0-412e-a8e3-04ff1b18b315@kernel.org> <CAHk-=wh68QbOZi_rYaKiydsRDnYHEaCsvK6FD83-vfE6SXg5UA@mail.gmail.com>
 <CAHk-=whgMGb0qM638KfBaa2AA9TR95D3oHJTu6=5YtRoBVWa3g@mail.gmail.com>
 <e983a37b-9eb3-4b53-8f02-d671281f82f9@kernel.org> <0bbf8e1d-0590-4e42-91b2-7a35614319d3@kernel.org>
 <20240521-ambitioniert-alias-35c21f740dba@brauner> <20240521-girlanden-zehnfach-1bff7eb9218c@brauner>
In-Reply-To: <20240521-girlanden-zehnfach-1bff7eb9218c@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 May 2024 08:10:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgt2W6jmfCc9FPB+WC09Cqo4YTmwyAeCQq6Mxkx3EjACQ@mail.gmail.com>
Message-ID: <CAHk-=wgt2W6jmfCc9FPB+WC09Cqo4YTmwyAeCQq6Mxkx3EjACQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Seth Forshee <sforshee@kernel.org>, 
	Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 May 2024 at 05:40, Christian Brauner <brauner@kernel.org> wrote:
>
> Here's the updated patch appended. Linus, feel free to commit it
> directly or if you prefer I can send it to you later this week.

Applied.

> In any case, I really really would like to try to move away from the
> current insanity maybe by the end of the year. So I really hope that
> lsof changes to the same format that strace already changed to so we can
> flip the switch. That should allow us to get rid of both the weird
> non-type st_mode issue and the unpleasant name faking. Does that sound
> like something we can try?

We can try it again later and see if nobody notices because they've
updated their user space.

That said, from previous experience, some people (and some distros)
very seldom update user space, but this is hopefully enough of a
corner case that *most* people won't even realize they've hit it, so
maybe it's one of those "fraction of a fraction is zero" cases.

             Linus

