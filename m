Return-Path: <linux-fsdevel+bounces-34699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 124239C7D0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 21:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA26CB2474F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3957120696F;
	Wed, 13 Nov 2024 20:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc0pSnJ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83CD15AAC1;
	Wed, 13 Nov 2024 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530418; cv=none; b=fuJfH2UOGaReb0sADHl9lAK8A76i4j+lluA8EF80aND7rO2BYybL+IINr8XJRPvwFgD1GCQ5y1dImMTHGKSrs8c+8kddnPEvsMKoOZCxZZGVn/f82iyXKl5AKDZjVaUvyMO2yPN3RwjAxhLMj9NdZvg81AcyJTRK2uZUeJpZweg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530418; c=relaxed/simple;
	bh=Q9cli+kCVKJ2P8UDJY1NxhptXbef82Sv+c9EkbAez14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXiBNBtF+tr76M1TLuuu5oHnD2jyiXHE/t/Ch/JzsdvyUgfi+TGLnSkQ9y5VC38H2VFlFemzydoAXWRtIF42zIYBfU/sPCptoGpbO7KeK+JfjuGq2WZ5FP7O9C5ZMy//GzXrRwN/1SpcAnMOIvCkSdUmhWVip3juB+HXlAeO8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hc0pSnJ/; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e9ff76facaso61240a91.0;
        Wed, 13 Nov 2024 12:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731530416; x=1732135216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Obijmw8/sQW0F0LwFn0X5RCh3HGTWixqBW+9CSoAPQ=;
        b=Hc0pSnJ/7ubG1bjlSQYjQ7an8cgfSYdJAxEZT14ZEJsSnZUUR/lVDM+HNkYwPgofvn
         5W9IIC6QNhlG2ljQRxbWH3nDtRo96WFZva6q+DqZoCT2ZWC5SuSm3uWjfmAVmI9ectXj
         YW7cSIgPnXZdzLo3FHa8TslrDIqY6H4xtCWDXup1MQUObEl3wBWEOzjf1Z4fyXfqFRd0
         jdna3hlZZxqoEGM6uh7N9YxJzbYySXRNFM+pXBmTj8Zzo7/ZpSc2aMl6YXK/BQ6x7u6E
         zBn6SAz6lb4KP0FINsfkOUwI8ZthldKpLxBiSVLaq0kyUzSTeNTNP2sMonT3dbgmP7me
         GxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731530416; x=1732135216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Obijmw8/sQW0F0LwFn0X5RCh3HGTWixqBW+9CSoAPQ=;
        b=BpIFIBY/uKfOCixt7Z8FB813UbK6EdfGXjgJ7GJA2qNo0mIcqtPG80gTEhhwMTySL0
         t4w0MuSavu4ddAlC9v03MWHaYXyzp0ZM37hAgQ+rmEXs0J3rS5UBQKBctEQssCtHkTqE
         F6l3IqeICUXLv5UkrrSMRPDOf2+c7hXck1YGNb1o0nLmwSPPZbHPsm3inF3p+pD8WS6r
         5HTil/1os3Guu+3DG1X0ZnE1VibIdO8LM65Y15YHpjR4RNIZgtTIL/zXHRKYwA2sO8r7
         1yB2aG12FJPopBOsONIYHXLSbr5N8gojmEeRs3pxCwy15fo7EfdahS+2MsMExAIyJqR9
         tG1g==
X-Forwarded-Encrypted: i=1; AJvYcCVIZaOPXPYd5ZNrCDkRwdLhhXv0igkfoeqSXTGR3IpSvQipdahBVlpZQ6/eCOOcTiK5TJK8qjna5QD2DyEmvw==@vger.kernel.org, AJvYcCVpvfAMJoE7BgFyBu/bRHbGAT2cKO2lWCl+QCze+LF0t6rov8flYjOxpobfzdRir+O57oY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNkI4xxFjRKgfUgiqtc6zppK2yvDKuLl2hxXfhtAW+9VNzVoxT
	iiobEUM8BDbhtpaEwf3GdCEFnP/OqYj+1asmiN1OvOkKtF7cAKZ5X99a4FKy4AOFO1oYXZTqR/H
	bzoM3wdyU4Xbs3jbAAOJTiEiMfb4=
X-Google-Smtp-Source: AGHT+IHrMSAIkTQCww/TnHPam5K1n+l8xp8FTp7wCo7N3VUnZCda4EiJw8m1pHQSBXMEed01p7ZCqNpVJ8Dmb1Vluos=
X-Received: by 2002:a17:90b:1a8c:b0:2d8:85fc:464c with SMTP id
 98e67ed59e1d1-2e9fe6a2c12mr1143573a91.11.1731530415982; Wed, 13 Nov 2024
 12:40:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829174232.3133883-1-andrii@kernel.org> <20240829174232.3133883-10-andrii@kernel.org>
 <20241111055146.GA1458936@google.com> <CAEf4BzZz_L5yc8OE21x93zb2RU+bujNsyQJTmvOvpm3Y--Uwpw@mail.gmail.com>
 <20241112012941.GC1458936@google.com>
In-Reply-To: <20241112012941.GC1458936@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Nov 2024 12:40:03 -0800
Message-ID: <CAEf4BzZ5er5kgo-jCLfC6_MXPw6BCg_m27n+K6ZzTGF-4+F91w@mail.gmail.com>
Subject: Re: [PATCH v7 bpf-next 09/10] bpf: wire up sleepable bpf_get_stack()
 and bpf_get_task_stack() helpers
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	akpm@linux-foundation.org, adobriyan@gmail.com, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, ak@linux.intel.com, osandov@osandov.com, song@kernel.org, 
	jannh@google.com, linux-fsdevel@vger.kernel.org, willy@infradead.org, 
	Eduard Zingerman <eddyz87@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 5:29=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/11/11 09:49), Andrii Nakryiko wrote:
> > > On (24/08/29 10:42), Andrii Nakryiko wrote:
> > > > Now that build ID related internals in kernel/bpf/stackmap.c can be=
 used
> > > > both in sleepable and non-sleepable contexts, we need to add additi=
onal
> > > > rcu_read_lock()/rcu_read_unlock() protection around fetching
> > > > perf_callchain_entry, but with the refactoring in previous commit i=
t's
> > > > now pretty straightforward. We make sure to do rcu_read_unlock (in
> > > > sleepable mode only) right before stack_map_get_build_id_offset() c=
all
> > > > which can sleep. By that time we don't have any more use of
> > > > perf_callchain_entry.
> > >
> > > Shouldn't this be backported to stable kernels?  It seems that those =
still
> > > do suspicious-RCU deference:
> > >
> > > __bpf_get_stack()
> > >   get_perf_callchain()
> > >     perf_callchain_user()
> > >       perf_get_guest_cbs()
> >
> > Do you see this issue in practice or have some repro?
> > __bpf_get_stack() shouldn't be callable from sleepable BPF programs
> > until my patch set, so I don't think there is anything to be
> > backported. But maybe I'm missing something, which is why I'm asking
> > whether this is a conclusion drawn from source code analysis, or there
> > was actually a report somewhere.
>
> I see a syzkaller report (internal) which triggers this call chain
> and RCU-usage error.  Not sure how practical that is, but syzkaller
> was able to hit it (the report I'm looking at is against 5.15, but
> __bpf_get_stack()-wise I don't see any differences between 5.15,
> 6.1 and 6.6)

Hmm.. thinking about this some more, I suspect we do allow
bpf_get_stack() and bpf_get_stackid() from sleepable uprobes, so yeah,
it's possible to run into this.

But for backporting this into older kernels, we'd need to prepare a
separate patch that would fix the RCU issue, but wouldn't add
sleepable build ID parts.

