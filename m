Return-Path: <linux-fsdevel+bounces-26321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4932695765B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 23:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C031C23262
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 21:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BE315A84D;
	Mon, 19 Aug 2024 21:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hnmbyhEO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD455158A08
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724101987; cv=none; b=nqhW3wZXkK2G3bjlSUu47liZp42odwP8K2g/ktELURdZfxhdAB5MsEhPD83bxzFypW/JCHY87nLuN3/EtgBauy7xuPAShsLYp1Kp4JdAvHSwmqXtMXAeQPCHevb2JPkzdVoehRvOKz2Yg27wWnr6Osd1pNxGbdt4IZ27WyCST1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724101987; c=relaxed/simple;
	bh=v2Aym6xEcSutqoJryNuAWCSxUt2U3T2dVmbfnKDCBN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lE81LuwXQukp0+KRtEX5hoE/GARHsAG7oqR1Jx9qM2eBA1nV1dThBsddsAc0TGmPiNExfCdW1E0iN8ZMY+V8gffeNnzUKNZ+VQddfW3iHz3n9PmnHpyaeDB2Ba3DptfzpyhPXv3Jb1niyISBtJ2+eYecJ6HR0ZwSRhIPuS1y44I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hnmbyhEO; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52f04b4abdcso6043058e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 14:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724101984; x=1724706784; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5WVBrXjTXXG+AbrwGZturOsFDzAUbfUxMoRB6dkGwEE=;
        b=hnmbyhEOUCRqiWTkya7zEkK+xrDcaerbqcjG67PLLU3bjP/TM5Uc9/60sa/IiCHMoO
         2MQRP2+ripYo72p55xWv6kBdNhSGwZjgxD195qiZX2JwEbZLUEsPrePEX+TtyIDPlFL0
         QKVWKFIo+KlkM4o+CfX0279Uw6XdEuQat/Pqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724101984; x=1724706784;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WVBrXjTXXG+AbrwGZturOsFDzAUbfUxMoRB6dkGwEE=;
        b=Ao8uoAJPFkUXjiraqScIsaQgoSFEYHBv3gA1iBQWpX3vUac0rWriXvm1UVTNm6QMBK
         SBG09yZ+XidWFO7e2rkLlpRXQaDp2KuZsn0E4K6bVsp8pFof9A4Am3ymuxitRpRTHgkP
         /wDbCrbk0Cuhmbeie8XQMYLLSMiYTlY+EzVndLtXN2SOgtfYBcefioGVWF32aphlFQBM
         4zEu5eN3sv6ArDTiGheak/95P9LOaVvTKdUPCr489B7B34bmc+HuavOOXkUybLeU4hKu
         WP19hiQJHRGLH00t6lWUsavpkSyinvZhgSXF1KZZm08ZHQl/FO2fT8VlrzJnIYzBLm7p
         wrww==
X-Forwarded-Encrypted: i=1; AJvYcCUdw8a7Z4bvaq03EwyLYFBU4Lkcp4Mwr+qZg5w2b9dqG/RWdQyHvx2pQ3TM7fawmeDcGX181YTqYNYA97MlRexw5VH7BaF1V+K5s9E9uA==
X-Gm-Message-State: AOJu0YwDDYfS4pmVDnUQws+gY4ajRXDooDNmJElHucT0MS9rVFOj5hRc
	vuWrvOME8kuAWDD/2QJb3pHmVfXMDV838yzVK+b4rskwpEOBLEBCpLGkmUnP4JiEJyTVCOAYDkg
	q6wP1Iw==
X-Google-Smtp-Source: AGHT+IFHYCyQhNvgfRDRXmLpap+0SB3h5RMVGTC+CqPAucl6G7jgRNferNgb5liDNPgHFWj4q6OOeg==
X-Received: by 2002:a05:6512:3d28:b0:52e:9f17:8418 with SMTP id 2adb3069b0e04-5331c69093amr6699562e87.12.1724101983117;
        Mon, 19 Aug 2024 14:13:03 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5330d41dbaesm1597439e87.183.2024.08.19.14.13.02
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 14:13:02 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f040733086so47300001fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 14:13:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWuWlD49JVdYXAVbmnC5/IbGy1L6dLJGXtPHd+oOrjts8sivEB8qZY1+DKbyCWzs1aulUTUl2r1oaYT3nQB2irOeOfJAirQVb7fw0z1Tg==
X-Received: by 2002:a05:651c:114:b0:2f0:1a19:f3f3 with SMTP id
 38308e7fff4ca-2f3be5ddea6mr73422331fa.33.1724101981970; Mon, 19 Aug 2024
 14:13:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819053605.11706-1-neilb@suse.de> <20240819-bestbezahlt-galaabend-36a83208e172@brauner>
 <172410075061.6062.16885080304623041632@noble.neil.brown.name>
In-Reply-To: <172410075061.6062.16885080304623041632@noble.neil.brown.name>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 14:12:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4=w4pANpAPbx=Kw-jiExEabJ0pwYHFgAYXVaD0AJjrA@mail.gmail.com>
Message-ID: <CAHk-=wh4=w4pANpAPbx=Kw-jiExEabJ0pwYHFgAYXVaD0AJjrA@mail.gmail.com>
Subject: Re: [PATCH 0/9 RFC] Make wake_up_{bit,var} less fragile
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 13:52, NeilBrown <neilb@suse.de> wrote:
>
> You could fit those in a short and two bools which gives you three
> different addresses to pass to wake_up_var().

You don't actually have to even do that.

The address passed to 'wake_up_var()' doesn't actually have to *match*
anything. It's used purely as a cookie.

So you can literally do something like

   #define inode_state(X,inode) ((X)+(char *)&(inode)->i_state)

and then just use inode_state(0/1/2,inode) for waiting/waking the
different bits (and the numbers 0/1/2 do not have to bear any relation
to the bit numbers, although you may obviously do that).

              Linus

