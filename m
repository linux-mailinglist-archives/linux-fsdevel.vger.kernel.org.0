Return-Path: <linux-fsdevel+bounces-54929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9336DB056B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 11:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964AF1C239DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 09:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444A12D8783;
	Tue, 15 Jul 2025 09:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWlc4BGG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3599C2749C3;
	Tue, 15 Jul 2025 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572240; cv=none; b=eNWwUmeOwo6bRKVc6xg3yBDlOP6Q/VD8eVgo/kJaC2hXAzLSm6idbXJDzsAM6buWZxF7/3KkHNOS0K9/7mQwqVKAu+0Q5OSTY/TjEANnUeeP0nRF1yNZvXY92TzF4Awre2FFAmGO7vMkwwC6bUZAwUgA+1Z0wvuTuE6qv7wwMN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572240; c=relaxed/simple;
	bh=n4E8XT76GngmIfORzdsfed/ozyV2yZxwEls3h7yIhnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVQKF8Os+U0VCl2xOC/MocAjSvY+TkSLZkfu/+sy3nGOvC/1cJMdC5vpzLJ0zpdHVohP5DqJbX2McIkYzdOn/gilwkREWXC7ncFFbB86OL7LDdGru/OV4MHJ2bH6yheqhFeRV4USCCD2VeQDGjuBxePWYVhw39Jemmrb9CYTMds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWlc4BGG; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70e77831d68so52257147b3.2;
        Tue, 15 Jul 2025 02:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752572238; x=1753177038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4E8XT76GngmIfORzdsfed/ozyV2yZxwEls3h7yIhnA=;
        b=RWlc4BGGBp6zzndH4bpp5hoepSHbWq43xyqHSJ2ZflcPyhMBca8+yWFJS4glAZe3oC
         gCl4fLPp/xMsOAbVZuJ2hswCcEkDyTkpizGG9hIDcY6LF4wLQ7zq6Akm3vPx4PhZItdA
         x9hT80rqlxlbrkHOTjxBMdV+MGpwd30NaOJP2udwPPn6H9Th+A1bqy2Oz8+vxm2Stn92
         0FMSTwNNr+219kJMc/D1cIMgu5qiLBT4YYL2jm1d+TZprs+ROLGZ4xICam9Z4z/fmLcN
         o1waysCTBTE2VmpQcYv6l0GZdmUh6fuyI1E/32XV5EG/8iVdS4jE8+XvkyX5YWbFQcC4
         O5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752572238; x=1753177038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4E8XT76GngmIfORzdsfed/ozyV2yZxwEls3h7yIhnA=;
        b=QjxgKnrV5Ea9nB2N/mzutOAfwCuM9CLzzC+G0iXO6LGV+0boGWZ9ki3unZADM3Hjzw
         G43vATkDiM7AmWFpqeWBzxkQjxD+GHniG6r+1itGkKsfvd1EK5Aw/ElY37u6Yx4tMlDK
         B02ABvqXFyPmcapIkH/JYB3mwkhpT5rhhCbit/97kVcpSgtAD0z0sXwdwV+om3Fhrd4m
         41qWqFTra/6XXxiH9Cab9sAEa6YNbeTTCAXHJEWg4sCpI0b5aV8shlbOySrPDKZp27Ed
         0x0kYYET6zG02J6xXZQmDCeoD5jRFzoi0oU5ijYqCKs9vVxVNmHT0K/rQDFsMzGui3yf
         NrOw==
X-Forwarded-Encrypted: i=1; AJvYcCUVTpToQ1Q24zsO60m9k7+nZeO66VyBCz/UPbv/4VEQutl/TrseypPWThaDkCkUMbnsD+z6xGk7clS/qE5b@vger.kernel.org, AJvYcCWR5pApZl0tdjOiFG1r+IUyKIm0y1pOp7mlst/iZQUf1HjyjvrjKNTSdDqArnB9TBMUl2aNonLYrCX6s1PUuFI=@vger.kernel.org, AJvYcCXT6RTcyGNdrmKKD6sIs2rInuS4olDeo+d30ENj43cyd8R3ygMbndJVnftIGtTXxSPk2YzS+EZzdfXNtLGy@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZ2CSjAGtX5HyErbKECF7Z6bxSOM4ZyoRmslB0OjdL9D2WaQf
	rvKLAMIVWiPH2M+Mpfwgb1Cn1fP0QbmaEtAaINM3FV524J1Fs5c+E0zzSHij8GyuYlrmujskNls
	PMj0QSEAfy9MO5rVQM+7KGKm9kmTukiU=
X-Gm-Gg: ASbGncvM0AAuK4gSSMlfiCigZjPTsBsCgivhG3kiqtsjBuH3aL08y8FXg4IleC49yxn
	GlGVf/eSDv12Sm5itbciZNSbbe+gDaCCKufExhE8M53YnfWmm1FV39p3GrlfxMisXpAcVEAkqKY
	F7xi9s3S7OgjlnHrg9TwyYPqd2JNY+7yvw+anqW5CPwU0UoquaeLstx8KzXDfN2GWU/yj5OjK4y
	JZsWGDBqSGoBGXVL1Wb2r16w7ScejBNjQCAPmh2
X-Google-Smtp-Source: AGHT+IGszuXTqF1d2MpINKB84ihNgCbgFwj/jgU2Im2zALJ0/JAaLqyVNXkuBU2tbjjyUyUJV0BYW1r+8WZLaowO+l8=
X-Received: by 2002:a05:690c:f14:b0:717:c40f:be9c with SMTP id
 00721157ae682-717d5bc0652mr238606637b3.9.1752572238134; Tue, 15 Jul 2025
 02:37:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710040607.GdzUE7A0@linutronix.de> <6f99476daa23858dc0536ca182038c8e80be53a2.camel@xry111.site>
 <20250710062127.QnaeZ8c7@linutronix.de> <d14bcceddd9f59a72ef54afced204815e9dd092e.camel@xry111.site>
 <20250710083236.V8WA6EFF@linutronix.de> <c720efb6a806e0ffa48e35d016e513943d15e7c0.camel@xry111.site>
 <20250711050217.OMtx7Cz6@linutronix.de> <20250711-ermangelung-darmentleerung-394cebde2708@brauner>
 <20250711095008.lBxtWQh6@linutronix.de> <20250714-leumund-sinnen-44309048c53d@brauner>
 <20250714101410.Su0CwBrb@linutronix.de>
In-Reply-To: <20250714101410.Su0CwBrb@linutronix.de>
From: Yann Ylavic <ylavic.dev@gmail.com>
Date: Tue, 15 Jul 2025 11:37:05 +0200
X-Gm-Features: Ac12FXww9z7t7Gv-dsrgtaU5Nku8ycGFL-OoVY3DiaRjmA8G4fLemU3BxN0zPaI
Message-ID: <CAKQ1sVOYCFS6PD0u1yssDj3=8mDmi1K1Sfy930qYWeCfRuF_ZA@mail.gmail.com>
Subject: Re: [PATCH v3] eventpoll: Fix priority inversion problem
To: Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Xi Ruoyao <xry111@xry111.site>, Frederic Weisbecker <frederic@kernel.org>, 
	Valentin Schneider <vschneid@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org, 
	Joe Damato <jdamato@fastly.com>, Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 9:48=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrot=
e:
>
> And my lesson is that lockless is hard. I still have no clue what is the
> bug in this patch.

Maybe this is related:
https://lore.kernel.org/all/20250704180804.3598503-1-shakeel.butt@linux.dev=
/
?


Regards;
Yann.

