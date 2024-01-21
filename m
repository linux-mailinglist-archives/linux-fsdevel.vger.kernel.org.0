Return-Path: <linux-fsdevel+bounces-8367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6E6835750
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 20:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC641C20B70
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 19:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FE63838F;
	Sun, 21 Jan 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gLRWntur"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7CB2A1D3
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705864163; cv=none; b=WunpQ3bO3HmGaQIPblKsZctKDlPJl1kXoOHIdkbzmoMWQ/GqEGTdcFNDFnva/5gIqUtx1hC6nBiBGx8ASAaHb9Ro5b2x5dMY9D0F+OW6GYveVHMM9WnsQeRBbCGcn2UUYxBEVk2CZshL/rPEDNMMl/+cOp7pZ+JpdhIsVqKaeJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705864163; c=relaxed/simple;
	bh=sLl2ygmLf1FqBdCR64R0SCoCUAVxQH4y2F36z/ZsWS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0Vu1yp7iAJwtfKPWcXuTNwt8gMMPBOlpGIfDvM5n16vF2u9BvcoskT0b42Kk8oH8wpBPwWN/8MUVJc86QBqdeny0BG54r/2HhUEsv/cs+2DMi2LWOUZtem69Cf28M8EI83SOWJrSauQBlXfunnkaBx4SbUBf+B8OzmEiEyMHTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gLRWntur; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso229774066b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 11:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705864159; x=1706468959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a9V/ecpVfDbfxLdGirG0A2SgTSjsnuK0GIGEU1Dyd3Y=;
        b=gLRWnturYc67SUXfUK/mwOOFF698Zc5Xzubk/AlW8WBqoYWOTtkWav9PUbljqYksgo
         51o1vaaI81Ze1EZqo+EZ7SifbdQr9mi8G/U3MOAuGxX58FW1ZsxOYPX7IVb99EGha+6R
         2PSTzql7UEi2HIb2ohTYi8S3irnlf7vp0jz4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705864159; x=1706468959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9V/ecpVfDbfxLdGirG0A2SgTSjsnuK0GIGEU1Dyd3Y=;
        b=HxdXGKUEjaFxv1Hlhxfj86Q7p+qbmlAJwFA/VO+C/QeS0/2rC84QVhmTN38j5hu10c
         YWsXB5FONPBwFub7WiiYtDKFJd9NqIa38MTQff0evCF7xHwPjnehphx9R0vCC72q8HRO
         xxO3YFk3tj8m3LNFC8/6dygJrMkbOD0hWBrV95gzrqAqYv+F35u6Dyt8NQla++rnxQXY
         3vb6ovjBiyxN6Szo87CLHKmAVwcqUSdpAyvsf/qobcekAPYfbtHhJTwykyxmHUD1+uWH
         wwswxFpqbvnbwDTzgVH/dk62wT01mWB7mWeRzrje6/OUnvWsOSvyW+lCg2ztTp2fqRlu
         6VFw==
X-Gm-Message-State: AOJu0YxvhginL4zGEeLOVAmMTMD91bY28dzurBy0a5W3q0P6ZNKTl5f0
	CPldidC1iQlke/9UCY5ZF1vs3J9k1BBLp+ZCVCV9P8Uyajcyox3Q/Oc0/olDngYiOqTuwCZIlFJ
	EC63URw==
X-Google-Smtp-Source: AGHT+IHNgC4fxcQHLa0+/Ayy8wlhtpSmzDNkoVnnLXlxSx7wZ5KoRP/SAx+ARbb6as+VmOo/Miv5Vw==
X-Received: by 2002:a17:906:e295:b0:a27:d1c5:906 with SMTP id gg21-20020a170906e29500b00a27d1c50906mr1879219ejb.60.1705864159442;
        Sun, 21 Jan 2024 11:09:19 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id cu5-20020a170906ba8500b00a2cea05669asm11074065ejd.216.2024.01.21.11.09.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 11:09:18 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a3a875f7fso2720387a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 11:09:18 -0800 (PST)
X-Received: by 2002:aa7:cd62:0:b0:55a:69e0:bd5f with SMTP id
 ca2-20020aa7cd62000000b0055a69e0bd5fmr1615340edb.74.1705864158307; Sun, 21
 Jan 2024 11:09:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119202544.19434-1-krisman@suse.de> <20240119202544.19434-2-krisman@suse.de>
 <CAHk-=whW=jahYWDezh8PeudB5ozfjNpdHnek3scMAyWHT5+=Og@mail.gmail.com> <87mssywsqs.fsf@mailhost.krisman.be>
In-Reply-To: <87mssywsqs.fsf@mailhost.krisman.be>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jan 2024 11:09:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh+4Msg7RKv6mvKz2LfNwK24zKFhnLUyxsrKzsXqni+Kg@mail.gmail.com>
Message-ID: <CAHk-=wh+4Msg7RKv6mvKz2LfNwK24zKFhnLUyxsrKzsXqni+Kg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dcache: Expose dentry_string_cmp outside of dcache
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: ebiggers@kernel.org, viro@zeniv.linux.org.uk, tytso@mit.edu, 
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Jan 2024 at 08:34, Gabriel Krisman Bertazi <krisman@suse.de> wrote:
>
> Are you ok with the earlier v2 of this patchset as-is, and I'll send a
> new series proposing this change?

Yeah, possibly updating just the commit log to mention how
__d_lookup_rcu_op_compare() takes care of the data race.

I do think that just doing the exact check in
__d_lookup_rcu_op_compare() would then avoid things like the indirect
call for that (presumably common) case, but it's not a big deal.

              Linus

