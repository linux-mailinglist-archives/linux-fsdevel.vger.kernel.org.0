Return-Path: <linux-fsdevel+bounces-60294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6F9B445FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 20:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E6D3AA751
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 18:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8C226E153;
	Thu,  4 Sep 2025 18:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZRHGV5N+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881D3265637
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012377; cv=none; b=ju/HEODy7oMrxatQi8pw12bMgWJSDAfABtyCSC5fJ8eYpAGT+Hd8rfgXQGw1KCXBFssPbQmpIiI8vusE3zo2i49ypCNTx4DJM6NMjpSa/VsMEbGCwzTtSjhwpQPMCJV92ms+0Vvs/rHryzM+vXFiRHnVWOzLg+FCDTuMsvXSsQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012377; c=relaxed/simple;
	bh=Y5iWYnH+pLZoMyAiiA7keWLVeUvesRJho2W44MPqRXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tn6HVYjqXLWkb2F43D1rV2MFVKlkk7Bz88yZPAanwAWqobrXvftev6XI1rMicKZz92BDgdQcjECcVPRq1/PP1tAVz0tn40vCj5uT7Oo2pQzCSN6OHsDQ3xx8sZB6ZFvxdW60HVf+4yyuKMT2RGnEm+/FVfJcS7nn6EnfTUibA/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZRHGV5N+; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b042cc3954fso241775366b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Sep 2025 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757012374; x=1757617174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0faex8QOhJPt8Vci+19wvhA8/Z9ZLQVGf/atVrddCS0=;
        b=ZRHGV5N+l7/FRevH0U84NpMZDVfG/7eTu5Z64NtDK2Yud8Cs8wlEaP6KgMmlVBJZtS
         EmgsfdGbqT0woY2j/UKiCGHm9eahux3hRG7w4rp5UjlBlwgte77aY3mb2iat6H+fqbTA
         eNv1orjHI242HW+5kb8dCxYFsyn1zp8RF55+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757012374; x=1757617174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0faex8QOhJPt8Vci+19wvhA8/Z9ZLQVGf/atVrddCS0=;
        b=PkTSLkJ6Co43xbfgklGZeAo3r/PSEqeO5wXX071ORKWhR0duKPh4oXXekln65BUM18
         15dwz6L7v0dc32a7HCOefJt2+JnnRseH9T4xObz0GQpksUsMTDCW2S69Jf8I08PdZ/Qo
         KziOsp9TCCGpmt8mYEuvuGxyIrP/7luyy3iAnkh98nKd+4hxqJi4tV2wBFIQ2Xjxs4BO
         qrFg0NRNzttEdFR2etjJVdTWodkHR6ntnorxIZoV1IuKlgXKmK3bfztr2sf65jEezsYv
         q/nhbvo59OTSFKXRFhJHfti44Axcq2WgArr/OITSVER4mYsXIR/Zdeay7ylyNRKAHZ2c
         bcTw==
X-Forwarded-Encrypted: i=1; AJvYcCUAhvgsH4EmQmBDUuh9spkhLzMJK7kkSFlGO0HRb3g3h5Q9PIU+4XC1zYC+M5OyQXnkoNM05neE+JeMlRaE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz50SaM93nAR1dERbIvSG4PtN+LtYShL5//3b9kJ2EVnvXJUU7f
	5e8DSYDS7fHB/yhemGlTBWPF1y/BevdtaKhcyNFWp8CmdKFUwj3AWewfijMqaOgb4HRGz+m/mdf
	ehcZDnaM=
X-Gm-Gg: ASbGncsU7FjmevqvXtwvslRnV+YQacOBdGf+hu0BuEsVMdx1LUBnSs5/m8Y4AQnF411
	/CQ01n+GHwv5BC+zOrRmadYIOp/WoQieJRbdU8zgUAitA/jNtkNxps9ZjBayNWY89TxCSxSLqW9
	wa2OVqx7yuVGdLWMdVZhS2YfqbaHJt9cZNoyDw79TEMwNPHrIZ/EUn6CpNEDBWNXFhGG/7FN3dL
	A2lTF581qZZSdIeVGg8y0pzajVmksiJy8nNAvlqiTx8UVrGu1VONLx2co4jeZHDq8bnx92Eheay
	ARyYqGK5XS7FgOpfQ9vL8DJs04z3bUhC4rzeuUDhnuBZas3nTIlguxmkoDFe2y2lgc3amxZ0z2f
	NmKlhD1oRAHmiyYLvBfL1Ii8PgLPbu+gtGs6b752y5l2cyFjCQ/FF0Oe0FVOctL26v91C1n/P+n
	2lA0GimQc=
X-Google-Smtp-Source: AGHT+IH4dim3uDnAqR3CjmlepTtF7w0mQiSp7gRepDtFUgx/EQ7E/10CvhlvUgLOFsyyD8RYFdqzHw==
X-Received: by 2002:a17:907:6088:b0:b04:3c93:21f9 with SMTP id a640c23a62f3a-b043c932597mr1424278566b.24.1757012373482;
        Thu, 04 Sep 2025 11:59:33 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b046e6c630fsm412990066b.55.2025.09.04.11.59.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 11:59:31 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b042cc3954fso241768866b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Sep 2025 11:59:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0Fk2qV9q58Rle8p75PQpoxqzfxkVyHxfwE8lb13tZ0LDTfW6Komgy4rT/OxFcFO/gZ3UwEZz/uHPjJODf@vger.kernel.org
X-Received: by 2002:a17:907:9808:b0:afd:d9e4:51e9 with SMTP id
 a640c23a62f3a-b01f20bfb23mr2012322366b.65.1757012371237; Thu, 04 Sep 2025
 11:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825044046.GI39973@ZenIV> <20250828230706.GA3340273@ZenIV>
 <20250903045432.GH39973@ZenIV> <CAHk-=wgXnEyXQ4ENAbMNyFxTfJ=bo4wawdx8s0dBBHVxhfZDCQ@mail.gmail.com>
 <20250903181429.GL39973@ZenIV> <aLjamdL8M7T-ZFOS@dread.disaster.area>
 <20250904032024.GN39973@ZenIV> <20250904055514.GA3194878@ZenIV> <20250904121836.GO39973@ZenIV>
In-Reply-To: <20250904121836.GO39973@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Sep 2025 11:59:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgHwcLri+JfcNaVnAfKzuURiR2TBDH5F4Ngtu+bThZrfA@mail.gmail.com>
X-Gm-Features: Ac12FXzIor8itIDcowSFjQD3KtAyD1-Eeab0_z7n5uosWAaSB4aAT0iSXyQ8yv0
Message-ID: <CAHk-=wgHwcLri+JfcNaVnAfKzuURiR2TBDH5F4Ngtu+bThZrfA@mail.gmail.com>
Subject: Re: [PATCHES v3][RFC][CFT] mount-related stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dave Chinner <david@fromorbit.com>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sept 2025 at 05:18, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> In any case, I doubt that it's a scheduler bug; something exposed by
> the timings change, but that's about it...

Not great, but not entirely unexpected. It would have been nice to see
a smoking gun pointing to an obvious cause, but we've had these kinds
of timing-dependent test failures before, and umount tends to be
special.

And generic/475 clearly ends up exposing various issues, as shown by

  git log --grep=generic/475 fs/

which shows a variety of filesystems having had issues with it.

           Linus

