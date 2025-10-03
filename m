Return-Path: <linux-fsdevel+bounces-63403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 883C9BB82EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 23:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AED19E72BD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 21:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E3025DCE0;
	Fri,  3 Oct 2025 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TTDCmv1d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E5623E25B
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 21:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759526395; cv=none; b=H/CP+X4h6PNcr+4u9xsOdpq3e5IMas7ALJ1dj8ylihhK1W5XUeHWfB6z83Uff2vraZk0VSKJKp/a7pZrterlVqscksEPOZDFDDq5JnpdM/A9OeI4nsLAM/I8srES1otC1xo6ev2xOm2NRVCo9IhSbBSP2ykUaUMl8jvy0wLU3iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759526395; c=relaxed/simple;
	bh=TcIrAhfJe4VtTEqGgO9rBJ8IV9b7zqYozWRG0FEufHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6Tc2v0F+laDVPZpIvNz67PTns/B0adJlEoix3OqMsTWUZwFxrGRx+wwrMa+oqbpBNu4JO4cQNxQViUZgalZgwwRM+c1VmbmOJsCQj1U2kwLlLAVCnlNQs3WwNq5Yb4VTvc1rj8EzztVpU+o01znFKiyKOtV/Z/WKIggzIZf2FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TTDCmv1d; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-631df7b2dffso6302246a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 14:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759526391; x=1760131191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2SJPE8jSqyeMykIvhtCruOgef39wlR1tnh5jl5Y5FJY=;
        b=TTDCmv1dMEL7JGG7AmvqjIfsRrWD3PXoIOfv07kvsRYcwowuJEMDwF2tlGWAmMUtlw
         jX/1wWpTgQKWBIvLy0zkMrxc3hS2W+5TTXOWlQbOS3WbYHT+MI6vE6jJ/7jUAfiNFJaW
         td1fG8AUF3hD4aIQgLpltbF2LAZBOwXwJ3Xc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759526391; x=1760131191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SJPE8jSqyeMykIvhtCruOgef39wlR1tnh5jl5Y5FJY=;
        b=k/iydhw6iFMeCAbWaExB0PxmAzSArM2IINsC76DnK1+DZ5h5Ph0dVm0g6mqku8l6GJ
         w/Jy0kew7/iEa/WnHmUWKZU60SVia0lP7qxYIkRwCosIylYgM6R5dVqt6xtW2UR6/UfC
         Ur1RsSxbySe8M4x6fk+r7Dmpbfg7VNLPbwItWChLJLa1j3b3KSEflsFx/ZDTrz395NCy
         HNbSr5AXLu7Z/1Q420Ag2IY9GLRE4qJ3S7/hxxdXgV0uwOQYSCbc45670ysDvlMQbQXd
         4ywV90dCTMKniWDFP7ZwUJMLtPq+5qcSxJ7L5UPxH0a+W+WOUyMoruBQv1/B0XQK2Tie
         Iysg==
X-Gm-Message-State: AOJu0YziEgtiF1XfNaF0yruVvKpImOUUy1TGaCRFdnL05CHc2TZkkL2z
	CDVIDbkn/LRshmaOdB6GlhwoxN3W4muoPRGeSEhBP/Zk5PGjP2ajWIZNwXgchid6Utxk0hNbHCY
	NzN8MmWI=
X-Gm-Gg: ASbGncttydROZrjNaPbO+uoccfnyUcOAy65hxUhUiBd29zrbJ2Wa8jM94OKHzOtdaZS
	7I7y/T5aXaH906YXQuImmpV8mWQlI7WDZq5kR+ThOlAqPpgzOMWh4qvwDSDeEhU0EqS0Xe4jnUH
	3BX6X33ROKi/UdaTKuEtAOxCzi3HWAjmmsxhGCiuuoHdrueILGeJj/8N+RgK8LoOJ4fEjFPCVR3
	sRC1XEUBttOKtF+Fv/hhFIFwprFFW+6U2lSkrv0zq2nT4fLuZQwxK0qs3TgUAJaDrKgt9KIb5Xl
	1+d1aIzX77yce2MQXDWPOZuccRoGMvhPZWLDAp5ZYaT8Pe/kCCZo6byvMjejd+0Bz+4a6OcG1WS
	tCK50wjb7E1PzMUgDr2UyOK2vK0pSXfvRg1zw58dzEQlu1sAvP1J45h5knVR+iOY4IEkZ2EnW98
	/JAL38gTQYm/QJ+WwHr1hY
X-Google-Smtp-Source: AGHT+IE9oblCgjvaLdLmkwfc9VBxRKPQ8Y0A3k7vsenrH2jQALilPnYA/1uLRJu1A8NJB1cydAJ1Aw==
X-Received: by 2002:a05:6402:26c5:b0:634:54f3:2fbb with SMTP id 4fb4d7f45d1cf-638fcb6734emr5700262a12.3.1759526391475;
        Fri, 03 Oct 2025 14:19:51 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63788110080sm4786374a12.34.2025.10.03.14.19.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 14:19:50 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso6749481a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 14:19:50 -0700 (PDT)
X-Received: by 2002:a17:907:728f:b0:b37:3d20:f35c with SMTP id
 a640c23a62f3a-b49c1974d9dmr531927266b.12.1759526390474; Fri, 03 Oct 2025
 14:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002055437.GG39973@ZenIV> <CAHk-=wjwQpQQb8A5594h8fTODkLHLBuw23TK1jL=Y9CLckR0kw@mail.gmail.com>
 <20251003211351.GA1738725@ZenIV>
In-Reply-To: <20251003211351.GA1738725@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 3 Oct 2025 14:19:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXzL8AWveoocRaE5Cu_B_-bFYOmuicJLFNfZN7pP=0Vw@mail.gmail.com>
X-Gm-Features: AS18NWBoPqEJMbihtHgJRsqBu8_XMyyUuR44ryLJbDFTlelpgEdW8S0FBGsx61Q
Message-ID: <CAHk-=wjXzL8AWveoocRaE5Cu_B_-bFYOmuicJLFNfZN7pP=0Vw@mail.gmail.com>
Subject: Re: [git pull] pile 1: mount stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Oct 2025 at 14:13, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> >  /*
> > - * locks: mount_lock [read_seqlock_excl], namespace_sem [excl]
> > + * locks: mount_lock [read_seqlock_excl], fs_namespace.sem [excl]
>
>  * locks: mount_locked_reader, namespace_excl

That was all just search-and-replace coding, as I'm sure you realize.

The patch looked fine to me, but it really was a quick hack in between
pulls to just make my suggestion more explicit.

I've long since removed the patch from my tree in order to continue
pulling filesystem updates, it really was a throw-away.

But I'd obviously be happy to see a real patch that takes that as a
starting point.

             Linus

