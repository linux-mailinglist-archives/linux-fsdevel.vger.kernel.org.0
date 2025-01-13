Return-Path: <linux-fsdevel+bounces-39057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C317A0BC3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 16:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44DBC3A43C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 15:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92961C5D6B;
	Mon, 13 Jan 2025 15:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RtPTfkBK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B2329D19
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782913; cv=none; b=HOGYV29k7CxlHkZ/Hk3PTFUvNHxxNB7uIZpSRs2cxznbaxU//+ysFCKdAx6XbsuXqSv0/Dp630bAZarNrEVrrXq98FOGjwtTZCKfEPmvptLRm3JNnZ9nLFHYHUzryHDf1p9xUc9r97ZZG2vbP4keqgWkBoS68VArBBIMEBRq9kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782913; c=relaxed/simple;
	bh=gYg7v2wBLlHvxcDn7o6TkmSFMBdkJ3utWV5WpaEbvQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4HjwIMXHFG5oSnr53xv1n9slzpu0CTmtvJDeeWTL05tmqI/OsDMOkm+Aop4Oy92WPNV8oHCsNoB7tSP+uu19X+prWEpaGG/fQtw+6kLVHuHhBjbDpgFgb3X4A/VJ3w4GiTwBqcOJgEpOnORuwN5E9jvhoSrzlZSJfV2q68vENA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RtPTfkBK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736782910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gYg7v2wBLlHvxcDn7o6TkmSFMBdkJ3utWV5WpaEbvQs=;
	b=RtPTfkBKV+FIU2mXqHYdBKfi62qlVTM4oNI9GFiA6gdH2xScf0ko+ApASGX8pyt6esgHUR
	ZbfFmBF1P/ysiVHXnZtbcO9kNAeFCPRXQ2F2l32A003cQsI9eufiabKoSoaO7uHlQp1nG4
	J+cbi+QNSLF2QaI5XRQFyC1ZsSFaacU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-jZtWFn9KN0aYcqGCc2JSpQ-1; Mon, 13 Jan 2025 10:41:49 -0500
X-MC-Unique: jZtWFn9KN0aYcqGCc2JSpQ-1
X-Mimecast-MFC-AGG-ID: jZtWFn9KN0aYcqGCc2JSpQ
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-216387ddda8so84938745ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2025 07:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736782908; x=1737387708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gYg7v2wBLlHvxcDn7o6TkmSFMBdkJ3utWV5WpaEbvQs=;
        b=WKkG+PcV3OISn+4dQfjPeDo5y+V94txcotnxQSjiwk1wQKPWCqKkFzQFZmp3BrUGWU
         7B1u1REuk1lhft56xcB3whDytTDg+XcO2m7f1TDYb9dR8ZV7IH5X5T3cPvG/kM/+7EVL
         2q3UEwhEOYjP+qrWc8bDAmSZEIv3Mr+EE/6OjyaeH+4msjdsj2q2ibg5Q6q3xbiS7kuC
         0iALm+YOmUOqkTDizyw3AtBkgpR+/w12WqXkIJ5riEXCEtELK33UxJ4MGPPXiIAg1OPJ
         ml7mvME4tRtL0S/7wqRocfUE3Mkg8NGkTBAcXfoV4GY8cSuB8zaWkr6yhdMicH+pCs7U
         QOAA==
X-Forwarded-Encrypted: i=1; AJvYcCUFTDBpknYRfrmcERZsJwss7OxROvmE4D1oHmW6Gh4k9kL5HuIW/km76+Kr1uS98I0JiKz+ovls0WXmOdCZ@vger.kernel.org
X-Gm-Message-State: AOJu0YymDLLP2s69aBiA36BILNmTlQowCjRPmyPG1aReYx63FWeYcQtF
	k0t6Ohf6j3sGtj3fc4P3naLARNf7Wz/o4BEa0FBDGE/UDTZ2gzEVwYY5jLXmb1TszW6wwYwAA/S
	FpTKocbBp3ewlDJIjMqtd7dicuMN9BBEOBfeuIYlzFt6TqghXmzEos74I+/kSoaIhu8tz4zsdHT
	o2+6Rq/JdH+AZTx3/a3CREFvparhWAaScB0mASDg==
X-Gm-Gg: ASbGncsZ12cmYV5coPyV0yKx6iL6ZpJNUrlQyArYMrkrPaxAIhw6XDUyFBVJwI46wgU
	+dCFLKOojtJy341BFjjLqR+RmUK06m1a6b59y
X-Received: by 2002:a17:902:dac6:b0:215:b058:289c with SMTP id d9443c01a7336-21a83f339f2mr301613425ad.8.1736782908216;
        Mon, 13 Jan 2025 07:41:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ/Z5o9hGA5nCeYoJCsyh8QaRo/h/BrqoQ80/+eLg/gXfDpGr/wo5b7xjgaelY6+5vLVTddk3Z9C1Ag9z4SMk=
X-Received: by 2002:a17:902:dac6:b0:215:b058:289c with SMTP id
 d9443c01a7336-21a83f339f2mr301613125ad.8.1736782907907; Mon, 13 Jan 2025
 07:41:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
 <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
 <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn> <6yd5s7fxnr7wtmluqa667lok54sphgtg4eppubntulelwidvca@ffyohkeovnyn>
 <31A10938-C36E-40A2-8A1D-180BD95528DD@m.fudan.edu.cn> <xqx6qkwti3ouotgkq5teay3adsja37ypjinrhur4m3wzagf5ia@ippcgcsvem5b>
 <86F5589E-BC3A-49E5-824F-0E840F75F46D@m.fudan.edu.cn>
In-Reply-To: <86F5589E-BC3A-49E5-824F-0E840F75F46D@m.fudan.edu.cn>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 13 Jan 2025 16:41:36 +0100
X-Gm-Features: AbW1kvZme8_fiRYjqU8QPQBZD6KR6UiY7TzmRpAKFob7Q2UrgMDwN0Cf7_ov7-0
Message-ID: <CAHc6FU5YgChLiiUtEmS8pJGHUUhHAK3eYrrGd+FaNMDLti786g@mail.gmail.com>
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>, gfs2@lists.linux.dev, 
	Kun Hu <huk23@m.fudan.edu.cn>
Content-Type: text/plain; charset="UTF-8"

Hi Jan,

Am Fr., 10. Jan. 2025 um 18:18 Uhr schrieb Kun Hu <huk23@m.fudan.edu.cn>:
> > Thanks. Based on the crash report and the reproducer it indeed looks like
> > some mixing of iomap_folio_state and buffer heads attached to a folio
> > (iomap_folio_state is attached there but we end up calling
> > __block_write_begin_int() which expects buffer heads there) in GFS2. GFS2
> > guys, care to have a look?
> >
>
> Thanks to Jan.
>
> Hi Andreas,
>
> It seems that iomap_write_begin is expected to handle I/O directly based on folio, rather than entering the buffer head path. Is it possible that GFS2 incorrectly passes data related to buffer head to iomap_write_begin?
>
> Could you please help us to check the exact cause of the issue?

32generated_program.c memory maps the filesystem image, mounts it, and
then modifies it through the memory map. It's those modifications that
cause gfs2 to crash, so the test case is invalid.

Is disabling CONFIG_BLK_DEV_WRITE_MOUNTED supposed to prevent that? If
so, then it doesn't seem to be working.

Thanks,
Andreas


