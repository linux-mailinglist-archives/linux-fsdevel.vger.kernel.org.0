Return-Path: <linux-fsdevel+bounces-29509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD57597A3D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 16:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1A71C28899
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A8015C15F;
	Mon, 16 Sep 2024 14:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LTR0hKBU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E973D15C133
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 14:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495714; cv=none; b=iWpZABquOszqDkuweqHAKKfndzD49O0tfec4RRXxoypjpt56vVsC0Cu4dFs02KlV5Zo2EibTvAvuxeigc8ThtW3I8K3pHMBZTuXSqwgOo4zIbCTm4CTjbpX41QaWFbSzVakoU7H7kL08i515hv6V+OVVZWcvprsm6e+6T1SLUdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495714; c=relaxed/simple;
	bh=q8U5kapnvPe+kOauR5iQm9N3ZQpVBSaRPSAKBVrq7g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZI58bjICyW8GFn0F+NetZd9w6kX5hbKGPbygTbQRrSnFlSwsR4H0ADYSxul4zmHAxWfGZhaT28K/6rgMPRSi6Kx95OVw/+5i0pYNodc1B9TNzqYns05wwmtPn6Qm1Bufx5jzWEtfdRx7vh+C/cYE0wiAt2haJBa8wc9SCiR2NrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LTR0hKBU; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8b155b5e9eso629000166b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726495710; x=1727100510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QAADtAg3pKG46cUtxD35BjgID9lOK4j2QBKH3zg5m6Q=;
        b=LTR0hKBUh0VlpAKuyFHUwe98BsSrWM/Wd8yiNy5IlE0lwcpjJ8zmQBNU8mo6Ie6iT3
         eMjr+302IpdTvIsWY97Tjmo9GHvJzj+BkK3gakZBDUuNNg7IC5h+kHkbFrwKASV7Zxys
         KZYTw2mgxupq/soDjPlyuEfgBPbS+DvSUuPFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726495710; x=1727100510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QAADtAg3pKG46cUtxD35BjgID9lOK4j2QBKH3zg5m6Q=;
        b=uoWHkip4xmKGbmVtuMiNO7XlQjIRyAVY53MPlKIiWqucjfF8lqrtBhw6mQ0mZ+u6OL
         8qOoMBzLGO7pBEyoSE8Jq1hoOhBLRN5xawrBvzELY0j2rL9cQIH4vjGGnKZ2KfhZk1aJ
         yfujhfo/UmxksAjsYaMA1RmXGuwaDqv8vjmlnffqut2jzOenjG7AGqvHtb/vV3f/rYgm
         KKZ2QXfb0b5A4XNAi9rp3F+L9gPkxifSbyM1oeeEupUmUtCV8NVBs+CxidUnsnKwiiKi
         umbPsKbkCo4noZRq54P0fqYJCJgaD2UgjkerdzI6fvTpLWe7BFMZZfvMPRoQnTMns+Fk
         VJ3g==
X-Forwarded-Encrypted: i=1; AJvYcCUUKoCiLHy1XmAGCnHfxwzjXm+rBZTccQlXzng4vT8dSmu9zaIm8+U9PGt5dQ857zxkDV8UPjZ5Ekl9sl51@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ULAjoL6i3YSEf/zdzOgtdfJX1Ul2XHHr+c75RuvoHXyBjeaJ
	ri6K6h1dihE9FTSrFv0MRZKI2a+7J/rERk0JBo72iCD3CcyPStprt+ld7IHhikW7GpMxG/9GdcT
	krLjmRw==
X-Google-Smtp-Source: AGHT+IF5/HOyQ/pr6ytCwLzmfqsl3G1sIOlXYWE65Cxtad3WIT+PbPe0vaQCBxt5r1rzrTbmnFVLFg==
X-Received: by 2002:a17:907:72cb:b0:a8d:60e2:396b with SMTP id a640c23a62f3a-a9029678bf3mr1706561366b.65.1726495709361;
        Mon, 16 Sep 2024 07:08:29 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610966e2sm325629766b.16.2024.09.16.07.08.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 07:08:28 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c3d20eed0bso5111347a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 07:08:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWAB8ScGzSv8Y6JDq8b4TrodgqbJPiHVLk5jUBu3ck7Xm4f1oqqG9cAS7EPeDpQQ2yw4+5idqGoWkrTuEVX@vger.kernel.org
X-Received: by 2002:a05:6402:3209:b0:5c2:53a1:c209 with SMTP id
 4fb4d7f45d1cf-5c413e4c638mr14300449a12.25.1726495708331; Mon, 16 Sep 2024
 07:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913-vfs-netfs-39ef6f974061@brauner> <CAHk-=wjr8fxk20-wx=63mZruW1LTvBvAKya1GQ1EhyzXb-okMA@mail.gmail.com>
 <1947793.1726494616@warthog.procyon.org.uk>
In-Reply-To: <1947793.1726494616@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Sep 2024 16:08:10 +0200
X-Gmail-Original-Message-ID: <CAHk-=wiVC5Cgyz6QKXFu6fTaA6h4CjexDR-OV9kL6Vo5x9v8=A@mail.gmail.com>
Message-ID: <CAHk-=wiVC5Cgyz6QKXFu6fTaA6h4CjexDR-OV9kL6Vo5x9v8=A@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix cifs readv callback merge resolution issue
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Sept 2024 at 15:50, David Howells <dhowells@redhat.com> wrote:
>
> Fix this so that it is "false".  The callback to netfslib in both SMB1 and
> SMB2/3 now gets offloaded from the network message thread to a separate
> worker thread and thus it's fine to do the slow work in this thread.

Note that with this fixed, now *every* direct call of
netfs_read_subreq_terminated() has that 'was_aync' as false.

The exception ends up being the netfs_read_cache_to_pagecache() thing,
which does that 'cres->ops->read()' with
netfs_read_subreq_terminated() as a callback function. And that
callback ends up being done with ki->was_async, which is actually set
unconditionally to 'true' (except for the immediate failure case which
then sets it to false after all).

Could we please just remove that whole 'was_async' case entirely, and
just make the cres->ops->read() path just do a workqueue (which seems
to be what the true case does anyway)?

So then the netfs_read_subreq_terminated() wouldn't need to take that
pointless argument, with the only case of async use just fixing
itself? Wouldn't that be cleaner?

             Linus

