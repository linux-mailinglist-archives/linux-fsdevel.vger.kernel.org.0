Return-Path: <linux-fsdevel+bounces-9269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F06E683FA60
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 23:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EE911C2236B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Jan 2024 22:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583EF3D3AC;
	Sun, 28 Jan 2024 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V3mAWFT2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CAD3C494
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706481596; cv=none; b=PHOefEVM2ys7Ut+W47zM7mDLfv/DFVSdg7NSjOkd/JU+HNRjJ1PZwd5hJyKPbM97l0jAYkEW6KkJ37D++FalD4gwKUK/6OXqTbaLNU7y517L5qW4HB8JxChiliiL43Iyz9U64Wqfqu2qm8mTCf9RpDTUpOq9DbiBbDNvlj8j83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706481596; c=relaxed/simple;
	bh=0bngCnVE1UVaB8Z16F7RhEvHk/Mk62Xo1gIMpFRyOoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gblGwmZpRzdCcRMsnzMC+l1CIplpgW4e4NHqTwOsk0ZhjnUpv1oxGD+OdL4J26fn3CbjNzWwQ9qvoc69fBFj9iXbWYZ+EDye2I6hs8sqj50w9LAblyBnbnbcz6+lfu+QViXK5ojLtUcyMUDukcL+IGrD7qCGFF6s5lOF5mDgkOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V3mAWFT2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so185058966b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 14:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706481593; x=1707086393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iplMPbX9nfLmdwf9iuaiDoK2OJZv8fxfr2mQwn9osC8=;
        b=V3mAWFT2aEgWx3Tebp3bR06Nq8P9lZSlHztzBLwxzP6VfpHlDdxGGiuUJx3+gaTiSh
         BMvf/KuMzRWMGQbwU1Rpzg3tIiR/QkIHWbYwaQZ7pxtE0UQJSrM4zHXJW915T+a6Int8
         R1/5kTtjrNygHrWnQ8vR3JQx9ortIB1fLeAww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706481593; x=1707086393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iplMPbX9nfLmdwf9iuaiDoK2OJZv8fxfr2mQwn9osC8=;
        b=M20ZxuwNUn1Dtcq1L0FpkRds1Fo1HY3BkcWP0L/i0E1r7k6jePNh5QJyvahw9l9kjl
         rxejClqCv8ylWz6uJmOU7Y4tI2ezax2FL2fIoOXSyQMfgsh+V4iuE2F4rIO+FOvCVyG8
         5e4iZuRX0LGEK1BWgN54ArTZOAnTOcluOOjKO7a/ps5ceA62xXDBMs8id9Wd6Kw+UuKm
         8QJ0mck7rbTnvbiJV7xOm/C8POgdv3QdKqj1EW7jYt4AMbC316j+Mwr6PrjqsoA6AkRS
         BGHxmV9YPL2PlKNFG+EPAdq0zfucvyewhjS2eFCc6W/maxbvkr1cb8ilNs7UDSwzhERB
         dJUg==
X-Gm-Message-State: AOJu0YzwQVHfsNQ2li7g9wML+9RPRFIzsEIjW5/gCX9QE+okGISTg8YR
	KCfCS5tFfN5TrM6bMAjKzmSqNVq0sXXLO/PO0/+gq8WRFj7wkCs2a/mb67NV+xx6KJL8PR9WbyE
	2JS3hjg==
X-Google-Smtp-Source: AGHT+IHA3Muxm5DymYIfC3UM1/tww8r7JlRyEcXrNMmIklpE149xDPSuDJ4cEVrkqqaiHzQXgC6Qrw==
X-Received: by 2002:a17:906:a445:b0:a30:51c4:bf9f with SMTP id cb5-20020a170906a44500b00a3051c4bf9fmr3035543ejb.54.1706481592869;
        Sun, 28 Jan 2024 14:39:52 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id j9-20020a170906254900b00a311685890csm3251757ejb.22.2024.01.28.14.39.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 14:39:52 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-557dcb0f870so1807900a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jan 2024 14:39:52 -0800 (PST)
X-Received: by 2002:a05:6402:74d:b0:55c:57bd:c780 with SMTP id
 p13-20020a056402074d00b0055c57bdc780mr2626730edy.27.1706481591957; Sun, 28
 Jan 2024 14:39:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401280650.Us2Lrkgl-lkp@intel.com> <20240128211544.GD2087318@ZenIV>
 <CAHk-=wj8LUAX_rwM4=N9kNGeg=E+KoxY6uQfyqf=k7MOrb4+aA@mail.gmail.com> <20240128220904.GF2087318@ZenIV>
In-Reply-To: <20240128220904.GF2087318@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 14:39:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wih5PvaVpdgjLrAof6cX0SP9kM-z-pWczDk8EaHscDGzg@mail.gmail.com>
Message-ID: <CAHk-=wih5PvaVpdgjLrAof6cX0SP9kM-z-pWczDk8EaHscDGzg@mail.gmail.com>
Subject: Re: [viro-vfs:work.alpha 5/8] arch/alpha/kernel/io.c:655:1: error:
 redefinition of 'scr_memcpyw'
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 14:09, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Do we ever use that thing on iomem in non-VGA setups?

On iomem? No. But I think several of the routines just work on either
VGA screen memory directly (c->vc_origin = vga_vram_base), or normal
RAM (vc_allocate)

But who knows.. I *used* to know all this code, but happily no longer.

                Linus

