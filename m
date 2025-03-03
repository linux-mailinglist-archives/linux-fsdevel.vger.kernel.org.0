Return-Path: <linux-fsdevel+bounces-42999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C832A4CACE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 19:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DD667A74F3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7913222CBE3;
	Mon,  3 Mar 2025 18:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YcNk2L65"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CFF22AE5E
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 18:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741025521; cv=none; b=TZQt49mHcu0qRxzDGc2XiG3EoAOb6amcxK17ajmgQYj+ICisiREIyVwNCRk51oiPzAhWcB7wOZOjjKiFE4TEtkmaIeDV1NZzi/tBNCECrHNXQRN6Gt+9OUfGGrmL01XPS9wSAK1bzHK6V0f3PHMARzbwdjXrjlhs34jmHClPVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741025521; c=relaxed/simple;
	bh=TnxBPfGniWDH996lZir1svgM+Ifn3JDhQPzo3qayJiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8klyLczC6CyvvmzJGicFAD1QY7Mw8nYeij1Q8dg9KAXW3Ccc4muIjMG7Tsr1kuDSSbdWadbcr9y0/+yGVU3OF371GE2AEimxQgm+QTwqZeK41K2B8jbvI35sFG67REJFINqizgVxDr8QMhZaz8hjEPGf1ViMV8XekxlQgsrROU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YcNk2L65; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab771575040so1036194366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 10:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741025517; x=1741630317; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C3MNxRS6G3spvOqXxyEtEnmq/idBtxgbtnljLuGuoq0=;
        b=YcNk2L655eDgM5Pd9mSxdeyHJ+0mM8vsAXqZkYvtkVulipQOVxKDqrQB8cScXkTRwZ
         c9QnfZW8r2+s7Ob9LNCGhap9RrTLl0kswuPKGP6y5JdGdd45i/1uklaZaFrAh0NJDpY1
         Q8BV3ol3gId/0kAv+VA1WbSetb4r96XtxWpgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741025517; x=1741630317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3MNxRS6G3spvOqXxyEtEnmq/idBtxgbtnljLuGuoq0=;
        b=xKHkE976t6yUiSy4QqC4jezTjdD95CnSUbM9RXKLI3Ux5OxXv1aJIaJiY+PEn8bLCa
         KZz1FlFH0Tcd9AGOxKN5TOfw0ov+YCa1XxPgtkewwmTQzFSQ8oxj5g0b4Iu0XUaqXI4R
         lW6DJD/iRp2ljbAnwZxAFSBYdAP5mfhz8My726n1GoZjC31O6pxB/PY+gpFf7AF0W3T7
         RvUDvYJtVXNhsSqNPtBooOUVzq+wbg/N4YjMb9jBngjSlZn8ngcXH+w3w2hl9agKq7Fa
         SdnbbpnqR2y1WJagVHGlLudzem2Iq53LZcvJpWfVQxgrOmYLqxZJ90LVlQgT3iUYWHef
         iiKA==
X-Forwarded-Encrypted: i=1; AJvYcCXYybsFWK8WKYlSyR14/rUVVwLmxsajTCOpboH+aCAgYcKQwAcO+s8RoAOJKWm+hqJmxqHmrT9iIEz+I6N/@vger.kernel.org
X-Gm-Message-State: AOJu0YyxFKh8CYTrBB3DfCLfH8KWaRwrDaugSzvUCvu9Jb8hi+y7KwDd
	w6JK/pan0el/xAsez9boBar5DLH0m+KclHFFm/w9gPm5voGDHOU/jA1BMonnIST+LItO9MRlkb/
	cjok=
X-Gm-Gg: ASbGncvRwbcpgKJPvlBk1C5xkCg06IblH3gOZ7pHQ0pnYBk71DKPaenURHlqsiXruA7
	XmHn/9S6cB10QVAxCd4f+2ye2DaEKXHzNJ9kdwc+bOXVIMeEZeeXw/mkJpW93TA5Cev0/TX+Wia
	vrdhGmXZ+lx7KrpLw+HcWnbm4C0H/jQrE6AJZtrCqSC1tFNwbnaT1vHU7ikquwedmBbveEJd/8L
	ySfpRIVCC5ovHC9+mKrnOjZayob+yTTO0UH66HwWKqgdg6pVDMBHKYzgqeJmWKhl8Mw+IXO56oa
	cXmZZCGSw8sXithC8BMGtgwgGoc/TgjSB2n/jIz8DCu+yQsgYyTwEgTzhQ/yxZIK/zkOpzRqOHo
	bzSuH5y9m+nDmDaPBXvI=
X-Google-Smtp-Source: AGHT+IFcPrEeNFbK/Z/x4FlLPDgwXPR9htgw+kisGPVWETwbqP/nBLBEL1eQTM9xR09lAvGnWJvnQw==
X-Received: by 2002:a17:907:3daa:b0:abf:6d1c:8f4a with SMTP id a640c23a62f3a-ac1f12c3464mr21271766b.18.1741025517516;
        Mon, 03 Mar 2025 10:11:57 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf17fa4a4asm800817666b.92.2025.03.03.10.11.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 10:11:56 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e56b229d60so1583087a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 10:11:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWAzy8KaL7y5CMMQpsZ1VrrlGrU6R9avSTGhhM7bo5+JYJptYpxEf5ZujyoDYGdHTGsctDAMm21VtUmY9Re@vger.kernel.org
X-Received: by 2002:a17:907:8701:b0:ac1:f247:69f5 with SMTP id
 a640c23a62f3a-ac1f24773b1mr1536466b.28.1741025516145; Mon, 03 Mar 2025
 10:11:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com> <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com> <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com> <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
 <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com> <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
In-Reply-To: <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Mar 2025 08:11:39 -1000
X-Gmail-Original-Message-ID: <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
X-Gm-Features: AQ5f1Jo-KDGS5FfxZY52-hiw6AvppvhzrcZgtVg7pKdUaM30hFo6-N9SADGkoog
Message-ID: <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, 
	Oleg Nesterov <oleg@redhat.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 07:55, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Can you guys try out the patch below?
>
> It changes things up so that there is no need to read 2 different vars.

No, please don't do it this way.

I think the memory ordering is interesting, and we ignored it -
incorrectly - because all the "normal" cases are done either under the
pipe lock (safe), or are done with "wait_event()" that will retry on
wakeups.

And then we got the subtle issues with "was woken, but raced with
order of operations" case got missed. This has probably been around
forever (possibly since we got rid of the BKL).

But I don't like the "add separate full/empty fields that duplicate
things", just to have those written always under the lock, and then
loaded as one op.

I think there are better models.

So I think I'd prefer the "add the barrier" model.

We could also possibly just make head/tail be 16-bit fields, and then
read things atomically by reading them as a single 32-bit word. That
would expose the (existing) alpha issues more, since alpha doesn't
have atomic 16-bit writes, but I can't find it in myself to care. I
guess we could make it be two aligned 32-bit fields on alpha, and just
use 64-bit reads.

We already treat those fields specially with the whole READ_ONCE()
dance, so treating them even more specially would not be a noticeably
different situation.

Hmm?

I just generally dislike redundant information in data structures.
Then you get into nasty cases where some path forgets to update the
redundant fields correctly. So I'd really just prefer the existing
model, just with being careful about this case.

                    Linus

