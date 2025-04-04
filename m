Return-Path: <linux-fsdevel+bounces-45771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4C3A7BEF3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 16:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE5017A67B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 14:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135A11F37C3;
	Fri,  4 Apr 2025 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PO7D72Zq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454B928E3F
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 14:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743776389; cv=none; b=gesx5xDxcb7r5dqNiq+19qUDNHeMuHcmxzHl2KpSUaZStYxWK3h9vwgoZjwbfFrlk+rmdxty5o8gjk6WVfTMEq4U8k4bYjm3/t/6KgXh+gAt7/5gS42fA+xJhqB4vmmHj99YAjHboKwPeT+OpA32FZdOzKGEEizSleqnafCFor8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743776389; c=relaxed/simple;
	bh=F1/0cHmvruih221kH6aWSlZC5sD6BkHLnUQW5KdapX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mxhwgk5SN0PFo3r79t3qps3wLqBCnsDPeb8l7goASN5Wlua0AldHvT3oBZdf6t6iXqmKWdDZ8PdSjg4hhKBb0ihetsU59KK/Sxqe95CvYe+663AwiPuWPj8XCQuz3wz5wjitlofgLe6OzNVpOPLE23iT5vjIq+Q0GqHOs/D+8vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PO7D72Zq; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso355357666b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743776385; x=1744381185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4feMGy3p1zUobV244140u9UEga2t532jHyyL+FMDHoE=;
        b=PO7D72ZqgrilzdVK1s5aSP71ZTxIFTTFgpUBVNGSbAKi/nKT6ehXqAnW0xnMKbkwTr
         YQ0yA4Lj37rFHRpq3qvQFTY8OXsCOoROlHQl5r1TlltSOYonrvmNtHK9azgd/VNkezwm
         AxCl7Dn2FtKwKpn2a432RhXASGPWfKYZ5bW1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743776385; x=1744381185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4feMGy3p1zUobV244140u9UEga2t532jHyyL+FMDHoE=;
        b=D+SgfLIFtHKWgYfURUUQ98bL710Wt2DEZg5OLOzn1v5qrHRW7fhl7ngbYM5rpbNebz
         eUl0IoqgFILE9v0Ubg9g6/WMSxKiguNTlPEfoGtmqtNwxg/dqJZANJaTi/2sKVU/MWw5
         3qgLJ0CJAEWkSYxbQtJxKfxR1EkXK+fzNU7GzLTqqXJXV3DrDQr/TNHOW7ISh5GqbHDD
         YeieAESS3WBIDamggDvNPq+k5NywOqIe/ceZqq/Uts0UVvWmzS6GpcYdq0qxJUfKTXFN
         M0/+A7InJgKqkXEIJrUQRx3sMTqb8Fl+GZe/onlAuH3D10rI4cC87QgCwliCcXoGI9Wp
         IJ7A==
X-Forwarded-Encrypted: i=1; AJvYcCXXPZvvnHH0dM6sBFOvWg1D4KbiUPk2uhuUBG+NN0KDd7NVcIBPS8h1E4BKLZ0oGVGXrra3ogQEMUDcJ1bB@vger.kernel.org
X-Gm-Message-State: AOJu0YwD0jMl+81Hh7nGB88asrHC2S/hSnr8IZRJxyCJCpgcbkuaxqTr
	NVFYrVLgs3IlUeDkiV34dz9Kqg+t8H8kIAWozXOV9bnCQaKmv6oX0k2TXQ9N2rJO1OSSmT/sgCe
	nF5c=
X-Gm-Gg: ASbGncvRS3OHE4+rUaHSwntX4ZriB99KBGCCDJvdnI2rHx47wMA0j8DXbgdatqIFnIK
	2KeXbU/cQCXt8ZXK+BACvTDsD89FIo9wN2sMIYwX6/Z7fblw6u92lAsgmPqs0j6BJq3PRv93Cjd
	FQHLHrsHHsujmHXAYW6jl9YQBVVYxCE98m4v0YSfSwMCHgZxGGz1n+Ro86kGjQ7RAIzQZQHr2Jd
	QMQM0iff+VGGdlAJupp1Bd0zuKgtqfYjAMUuUAprJhQQk3QCdA097FBcmI2QcamfZP307dsWYG9
	KJzfewKLpR19CxF/m2F7GGmyfIaaQ9jluPohCr9NysJugiiPVJCTAVOJWWvVXG9I4i9sC5dc0yE
	By9YyTHvlMpCk7Whxigg=
X-Google-Smtp-Source: AGHT+IEQLcheciGIqGtXB3rYA0uwFw7N268tpT5ir3WvCPtwfp5fD4cZ15tvSDyT5MM/hscgy668Yg==
X-Received: by 2002:a17:906:f59f:b0:ac3:24bb:f1ca with SMTP id a640c23a62f3a-ac7d166c502mr318951166b.7.1743776385293;
        Fri, 04 Apr 2025 07:19:45 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfee3815sm260760266b.80.2025.04.04.07.19.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 07:19:44 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5edc07c777eso2690054a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Apr 2025 07:19:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXntvtFd76Ip0YTmAR1NEX/43Tnau41LiuigsXtMAahqJFVdgC9P3qpqa7Bp+DmGizK+thXFRJY/zst/tOE@vger.kernel.org
X-Received: by 2002:a17:906:478d:b0:ac7:982f:c299 with SMTP id
 a640c23a62f3a-ac7d190fe23mr315600266b.38.1743776383893; Fri, 04 Apr 2025
 07:19:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322-vfs-mount-b08c842965f4@brauner> <174285005920.4171303.15547772549481189907.pr-tracker-bot@kernel.org>
 <20250401170715.GA112019@unreal> <20250403-bankintern-unsympathisch-03272ab45229@brauner>
 <20250403-quartal-kaltstart-eb56df61e784@brauner> <196c53c26e8f3862567d72ed610da6323e3dba83.camel@HansenPartnership.com>
 <6pfbsqikuizxezhevr2ltp6lk6vqbbmgomwbgqfz256osjwky5@irmbenbudp2s>
 <CAHk-=wjksLMWq8At_atu6uqHEY9MnPRu2EuRpQtAC8ANGg82zw@mail.gmail.com> <Z--YEKTkaojFNUQN@infradead.org>
In-Reply-To: <Z--YEKTkaojFNUQN@infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 4 Apr 2025 07:19:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjGb0Uik101G-B76pp+Xvq5-xa1azJF0EwRxb_kisi2Q@mail.gmail.com>
X-Gm-Features: ATxdqUH1fche2EeY8R3txz2bZ0obPWI0l3w2GZ5-Xx7oiLcX7YVSPm2_dMlQOXA
Message-ID: <CAHk-=wjjGb0Uik101G-B76pp+Xvq5-xa1azJF0EwRxb_kisi2Q@mail.gmail.com>
Subject: Re: [GIT PULL] vfs mount
To: Christoph Hellwig <hch@infradead.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Christian Brauner <brauner@kernel.org>, Leon Romanovsky <leon@kernel.org>, pr-tracker-bot@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Apr 2025 at 01:28, Christoph Hellwig <hch@infradead.org> wrote:
>
> Or just kill the non-scoped guard because it simply is an insane API.

The scoped guard may be odd, but it's actually rather a common
situation. And when used with the proper indentation, it also ends up
being pretty visually clear about what part of a function is under the
lock.

But yeah, if you don't end up using it right, it ends up very very wrong.

Not that that is any different from "if ()" or any other similar
construct, but obviously people are much more *used* to 'if ()' and
friends.

An 'if ()" without the nested statement looks very wrong - although
it's certainly not unheard of - while a 'scoped_guard()' without the
nested statement might visually pass just because it doesn't trigger
the same visceral "that's not right" reaction.

So I don't think it's an insane API, I think it's mostly that it's a
_newish_ API.

               Linus

