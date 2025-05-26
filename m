Return-Path: <linux-fsdevel+bounces-49839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96707AC3C0A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 10:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F653AE4E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 08:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B261F17EB;
	Mon, 26 May 2025 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhUTbqDD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0648C1E47A8
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748249489; cv=none; b=Yv53m9tyaHD22ILaPntHZdLUt3EfsGKWlQ8oxDoOczegVciFYQKa0871GGg1EiYWZlpMylzP1GEIAmOns/Lv985D7d2N3DFzzPE2YCkDaJyTI/0rKhBNDkIuHWdEtTjqCopZyz3QJxLV2I2GlWdY4OU0Yoxn3SybJwyLc+DvsWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748249489; c=relaxed/simple;
	bh=D2g3BOshNGANMrfvvcGpwUiXwvGjh6r2L3++VHuKuWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/N+QAfhSlOxcqnuIY4GYbUGLG81qYuu+Hg8h1+TYgA8KniDkw5xskvJqWyujhX9YZQU/hEL+nghdIIWCnpt8HV2yzZJxjdymeQJg++4dOO42TOqR6Hjxj+U6tL7d3RU04Bb+nuAC0NSoryy9s+JU1wHP/GZ1OUiNC3Hdkc1VqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GhUTbqDD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748249486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=geMIHKTOuh5idA+ro41inh9pKXXxXAbR6ye+ZuNdSUE=;
	b=GhUTbqDDU+s2/GhxfWpAJUvbqr4mkRHbehv2VCUVvii8p6KdpnVPAQruTyOwxCX1kVXKRt
	NH9IS4KxDHnCrk939uT827BKPHyFKAaeVAIasuw58TgkHgwPriRMi/GDPJ/YKtuuU4BJUB
	6ZGq4vXTJh707McQTuPS5dD4NA9cbbg=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-MXcyopgvNe-e4eeB5HU3Cg-1; Mon, 26 May 2025 04:50:23 -0400
X-MC-Unique: MXcyopgvNe-e4eeB5HU3Cg-1
X-Mimecast-MFC-AGG-ID: MXcyopgvNe-e4eeB5HU3Cg_1748249423
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-2daf2a40894so206871fac.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 May 2025 01:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748249423; x=1748854223;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=geMIHKTOuh5idA+ro41inh9pKXXxXAbR6ye+ZuNdSUE=;
        b=K89xF/l/HHjDFJCDCYUJVcYvrlAKiKNTp6h3CHQMj+8m8uUYLwCDvqaEb5TZdfXhzq
         6eHjdcOzKj+PBoUmQhjreVd3NYEo/p2ZnSTautVfMF692+zMK6QQQs4Z8dqHEHK1vV62
         ybjbnW0MOPHG5P6f3qHsPX//Qm/0fhuvoP/WNJz1bFahCaTof1XzCbz1tTk20cZLrk6w
         8N+9TF8Pj0OpauBuUhBtehl7cuZIAT8JAX4xHOP4nyqmbHDoRPdc447FhR/bzqK6JcSC
         Q3zZFy3DT1QeqwuD8ATGdeEuW87qruHn4ZkwzViGKMR/XwgboRXJBBwsDvW5hycQTWU/
         IlEw==
X-Forwarded-Encrypted: i=1; AJvYcCVqmsgBy+toYtrvgJvNLRU4z/5lmeuOrFm5KUvB+0uOpJv5tci1hcHfKUsXdF+F8o9V80OtG1F3+9x3SbUi@vger.kernel.org
X-Gm-Message-State: AOJu0Yymb5T2GJCu5jxXhYKI2+cec8kLvhY7qxvu9xGeTVwgwwnwTeeF
	++hn9cWnZf64OisWiHseFQayc0LjINye989LR3MlTykzhCZomF1TnhnLaGjhVWbivul9UVUiosU
	/dB2JRKdV4COgri4ODOKpAaqjmI4fwq3qdTDHZSKpTEf8oru4bUQh1CywQ/qUGMaHk9r/fSMbnl
	ptWBiuN5wMEnS+AhHRBY1K/dPJANKWi3FY5HoKnz7knw==
X-Gm-Gg: ASbGnctkKlg4K/dVxuRiPZOFhmumHeM/RInYsvFIXI1xzitzMI2IN3U7Cvhbl30DPtZ
	I9RaysH68g/xPQxOtnJFQL2PXb7BIj0dXacwVfwc8fRewg1/UPg3PfWfnVZySO7PDquitZ/yYq0
	ZCercwzb4zoFNOibOzpzJBmJU=
X-Received: by 2002:a05:6808:8501:b0:401:e98b:ee41 with SMTP id 5614622812f47-40646859e99mr4014283b6e.21.1748249423205;
        Mon, 26 May 2025 01:50:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYZJnTgkIdo9LrxPRJQgjNAZ/LDU3NVWONeb7N7wo02jOsOvqQG5T55DIyeL/6wxsqzQM5a09ZMf7f7HnelMQ=
X-Received: by 2002:a05:6808:8501:b0:401:e98b:ee41 with SMTP id
 5614622812f47-40646859e99mr4014275b6e.21.1748249422893; Mon, 26 May 2025
 01:50:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegtdy7BYUpt795vGKFDHfRpyPVhqrL=gbQzauTvNawrZyw@mail.gmail.com>
 <20250514121415.2116216-1-allison.karlitskaya@redhat.com> <CAJfpegtS3HLCOywFYuJ7HLPVKaSu7i6pQv-GhKQ=PK3JAiz+JQ@mail.gmail.com>
 <20250515-dunkel-rochen-ad18a3423840@brauner> <CAJfpegutBsgbrGN740f0eP1yMtKGn4s786cwuLULJyNRiL_yRg@mail.gmail.com>
In-Reply-To: <CAJfpegutBsgbrGN740f0eP1yMtKGn4s786cwuLULJyNRiL_yRg@mail.gmail.com>
From: Allison Karlitskaya <lis@redhat.com>
Date: Mon, 26 May 2025 10:50:12 +0200
X-Gm-Features: AX0GCFtBHdO615iMstL1uewZBKAWy7pwwY3hK2xgeLZWhuBw1q6QwfjqjbmLGzk
Message-ID: <CAOYeF9Uj3R+j55vJvO+fiVr79BsDe2de-pvhSyveoq35wOeuuw@mail.gmail.com>
Subject: Re: [PATCH] fuse: add max_stack_depth to fuse_init_in
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

hi,

Sorry for being so late to reply to this: it's been busy.

On Fri, 16 May 2025 at 11:07, Miklos Szeredi <miklos@szeredi.hu> wrote:
> Okay, let's add it to fuse_init_in as uint8_t.

Is this to help save a few bytes?  I'm not sure it's worth it, for a
few reasons:
 - there are 11 reserved fields here, which is still quite a lot of room
 - even if we reduce this to a single byte, we need to add 3 extra
bytes of padding, which is a bit awkward.  We also only get to use
this if we have something else that fits into a u8 or u16, otherwise
it's wasted
 - we might imagine some sort of a beautiful future where the kernel
figures out a way to increase this restriction considerably (ie: >
256).  I'm not sure how that would look, but it seems foolish to not
consider it.

I'm happy to redo the patch if you're sure this is right (since I want
to update the commit message a bit anyway), but how should I call the
3 extra bytes in that case?  unused2?  reserved?

Thanks

lis


