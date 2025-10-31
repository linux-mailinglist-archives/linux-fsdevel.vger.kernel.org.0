Return-Path: <linux-fsdevel+bounces-66609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90692C2626D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 17:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05FD1891A1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F35286D4E;
	Fri, 31 Oct 2025 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QKXy16eb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CA5170826
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761928320; cv=none; b=dr4U9oq7/ava6JyqCjbIMoSlAVl393UbAPnLMwPKeAnrTZo7RrHaVxs2kJogcJ6pGyp0THOVpw16680H1uHRcisS4Xdm95iaFycKwXpal4+t0xkS+yFJmhpdWnfKOQqdj5clrRfr/UNeejznPx+uhhoHvxbochIQRMpMyiXiZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761928320; c=relaxed/simple;
	bh=l/IsB7baxIshXUpT/OfHN+vPZ0H1TEj1uw/YI809Nlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFxshAYkeXU2IYzXTw0DUt6ZB36lyFi73kQhc0ltloN91rw2UMl4+jDVT+KxwH3VZcQix0wfo8XoH+TUEKCCCzM5MZRBCmXwPXrxxRY/f0Bcx9afPETon1mhVpXUtbkNbWujL+TEoASF3tuWVlNEFJ+b3kJ4i+GEt2wn2Na4yis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QKXy16eb; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3e9d633b78so620938666b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 09:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761928316; x=1762533116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sTzC3VMhtBJKHk8qqOYuFEBEXEPLqM6jmVq1XA7XYus=;
        b=QKXy16ebPhL/HsRyT7w9NNQgsgCR8XwfhTsJNRmWbo8xe4WPEfKRcune3FVTyjaxhS
         q5ymebnTu79LQgMId4Px6zDN88AzuKv8RiQmk28TjykzoTjEEOnNPV8NAGT4LEUl2ckO
         r1HsfXreIVvfRQEy9D7zeW3y7CjVbX1YK4WUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761928316; x=1762533116;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sTzC3VMhtBJKHk8qqOYuFEBEXEPLqM6jmVq1XA7XYus=;
        b=hU/mWTzZZTgAmlT29RVByz5bak40wqAblM14X4CPLau6nzjI7mLzQPB+JEsTMICUhI
         owWICmXusRbnxDRkxp5MaYY+eoBhIermgJKy4O+RwbJEdn5I5KFu5vnJs5WG4rm+9t6c
         O5kV3SCLZtf7HkRIYXXItfC7YMfSLcmrKzY5k6rBKS1cCOIj+NbpZPGa72Dl7FGzqQj2
         0qp4N9WZlPJc/MPZ/XpYg4hmG6w7fSDQzXVLEcLy61JB8RP4u2dUB1OD9+ssdBFJ2lKD
         pWhIQs6ScdD4gVu9h3nMZrsqFxo0zOTZlq04Ya97DTThdf4q0OWQEbCBHlSp18qO5nSf
         sY2g==
X-Forwarded-Encrypted: i=1; AJvYcCWDVytKzzYQ64YlNODM8k1sSo0hJ6/Ynwo2jI0empilX1EhYz6B5bC3g7R8VOEs9tqtjtveYi/YdF3h39uh@vger.kernel.org
X-Gm-Message-State: AOJu0YzRP160kV7Gw3S9PPCiO6OOd9BFLWiSwgVviHrbYU2cwjSpNpCG
	Xbni5si6t1dTWcxXq6GyfFB+4rq3pjvZ6yEPaY/uyiWvLDXsBmP2R65tqGCMOw+6Z1PtOAGzAb1
	M0B0qe/Y=
X-Gm-Gg: ASbGncuWXfPCNlkCoWo8R2twwgTXSINFh2rv+ZEmKSrTQ7OFxIjR+Og4rAEJYCbWuSw
	ntqjD9rRnvzeLPRZmJRnWCBAKoBP76RdVDQEa83AdzOBaXckFFoQt/3/WsnDEQddEA6RrQUS8fc
	o0WhSA3mJZq2APwQE7qQC19tTxh8O4pfXHX5nMKHrl+qQD/adckfQHdKEcuKwD5An30zeics1YA
	R2l8ziErLxAHRBTKSBYpEYvaU57gQ/0f+5D8hxrBdKkLu4R0cSo13mh77Dr3E/9DsmVClMXdxhf
	VKSyUcgt9OPtEwS96LpHjP10ONGx91/tOqEECGtelB1uvZyT1OanMm9B8GII+BVgdN/IqYk8drg
	Qyl9Tz69f1r2M9yRoNlZITOP1ji7FSG7PMxW3S78drU5B75B7QK+Hgj2HGeESu3MWJcKcf19MUB
	KIEdZpcmfePuk1lL4mPsMBthnfIcwKGFhmL3L9HOf0ByjfkDk1nDhGK3d1zyYg
X-Google-Smtp-Source: AGHT+IE6V/6a0Xbp5rUcsPzpIWmJIQCP5iPZ0aUc3vQM206h9wpyyJG4uPrid2Xo3Hrrt2ZSTLKeIw==
X-Received: by 2002:a17:907:a0c8:b0:b07:87f1:fc42 with SMTP id a640c23a62f3a-b706e54f35cmr492191366b.16.1761928315856;
        Fri, 31 Oct 2025 09:31:55 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975d8esm215765366b.12.2025.10.31.09.31.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 09:31:55 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso4581902a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 09:31:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWPkOnUPk+eR/knkUmSvyyGiQZfYkGRUcxKK/I8Pxby5CMD1Oyd8vnuhvCaIzJyC1tQo4p3OiBW9I7DToj@vger.kernel.org
X-Received: by 2002:aa7:dcd4:0:b0:640:69fe:5ec2 with SMTP id
 4fb4d7f45d1cf-64069fe5f23mr4631406a12.6.1761928314897; Fri, 31 Oct 2025
 09:31:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030105242.801528-1-mjguzik@gmail.com> <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
 <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com>
 <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
 <CAGudoHH817CKv0ts4dO08j5FOfEAWtvoBeoT06KarjzOh_U6ug@mail.gmail.com>
 <20251031-liehen-weltoffen-cddb6394cc14@brauner> <CAGudoHE-9R0ZfFk-bE9TBhejkmZE3Hu2sT0gGiy=i_1_He=9GA@mail.gmail.com>
 <CAHk-=wg8yBs7y+TVUFP=k=rjFa3eQFqqmXDDgnzN4buzSdToiA@mail.gmail.com> <CAGudoHFC9vfHZsgjvib=Hy8wNom27wYG+iJz=5G_6zNQHF2ndA@mail.gmail.com>
In-Reply-To: <CAGudoHFC9vfHZsgjvib=Hy8wNom27wYG+iJz=5G_6zNQHF2ndA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 Oct 2025 09:31:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
X-Gm-Features: AWmQ_bk0Uo4HxrcVgEGKt9-nJllcNUr5ayxKLvAURW3YE6knhWkqfLYOztYPiIs
Message-ID: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, viro@zeniv.linux.org.uk, 
	jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 09:25, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I take the intent would be still to fail compilation if
> runtime-const.h is included. The file is there for the premier
> platforms, but most platforms still resort to
> asm-generic/runtime-const.h. I think it would be beneficial to have
> that sucker also cause compilation failure if included for a module.

Good point.  Yeah, I think you're right.

             Linus

