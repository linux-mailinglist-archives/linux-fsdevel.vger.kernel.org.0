Return-Path: <linux-fsdevel+bounces-35154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 600BA9D1B1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 23:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1E31F21C28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 22:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483FE1E8841;
	Mon, 18 Nov 2024 22:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="YulGoWQn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC8C1E5730
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731968839; cv=none; b=Ja5/CquOvZtqNuFhqyN4RqGg+U8FIz+38TfO/rh+PfomZIyErm5v89wXxXAxTLBbUJhAjQjtjkKqRxf6b5/ya2DqYzx50J/cXDnOKDa27AKIpxArBzxkMFI69vY+FZT2+DqwW+PbnixDxL+SxUSmhBm/7NTrfRYTvwq741wtYTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731968839; c=relaxed/simple;
	bh=Rvg5bbdOvYJPMLoczIrnRiEARLYMNTvHZS3WZenhK6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2F3BWakb6OUuGf0ZIMkHviGjIqRBxQH9RGvTKfOFhE5XeN7PoFzbm3pXly1K/UMpd0S7m5WPGXhS4opl5f2xZEBIxAwxDpUh8ooRR2NT5+erPsah3todEZ/sJLUOQi7WTKVPjHBLlP8kNM2vHGNyrr2BjFW3CxSwElU9cQhjnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=YulGoWQn; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46096aadaf0so31214781cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Nov 2024 14:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1731968837; x=1732573637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rvg5bbdOvYJPMLoczIrnRiEARLYMNTvHZS3WZenhK6o=;
        b=YulGoWQn5V95Hr3GXX0a47ucZAzvekLRFK2k3z9O8NbgJUuKRTUV8+xqUEdMQxUBaY
         C5JXglBWXhMbUaZuqzxXecsIC4Jt1AOa99aPFa5AZ0t+FL0zlhgIhmuIne1Zn91EqAQG
         0hDKd3WlSNXN7L3SGwwbjZwRnvYlMQx7s7FWiITa4aGIyf/80pH65xO/1LtsJcAGpDX8
         BWTnX/Spi7bDhX5s5ljb9xVd6xcEpb0PHgM61bv5/9rdebsE1z3xlNhkbKY9i1ZCYpjL
         XsxLssZkg7bphL/DyOxeEjd9v+7ur9lbIYt8ivA6DqpU3Hqa0Njx+IHxlxJgfet6DMR6
         0qcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731968837; x=1732573637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rvg5bbdOvYJPMLoczIrnRiEARLYMNTvHZS3WZenhK6o=;
        b=bjIUYBB/jhN6Hg+rTh6W+gRzPmGez4wuN6SCHpLx69Hukxa04D1iYpA2dzbdqNijCS
         tcHblOEgF1ptWN6NyZ11hhPywt2IwUk4irIU+YE816XqdJiqbC6Yeme8ZHBeNNHPUljs
         ghw8Mo9GH2F07K3vhjJAigPfHWbiadOMT0HTIA7wdseIBiTWRP2rDUg8Q3Tt+OZJlLLF
         lkeiWuSpbdBSgCeJv7dm0VHxypfyHuv5jQPBidXrtWzFMB/17mYIaXgeasp3ZFFbJcS/
         CQNhh2ryXVLWn+kY+4KwSPiM+OsUQZNAyfA/2NZG5YPd45CJlnwg/QazypnseJpPfml3
         JmYg==
X-Forwarded-Encrypted: i=1; AJvYcCWWkZn0euW56JNrST9KO9npIKOB5vLWCTcolEbZBVFzI1/saJcSOca9Tt7Ld60XX0JpH8VHObypXn/qbvka@vger.kernel.org
X-Gm-Message-State: AOJu0YybbBuIRVKtSxjDZ18ozljfnlSR+SQXt1n/XAVwL05FrGuMwEH/
	OwkK4avg0PdD6vEruNOweQ/E59Mjjs5TXkUVZ5ixUbhTD3SK1vFMlTfEgRxHSnaNvnfAyg0DZDh
	I5W42lU3p0vYJYBGJ/VFo5ww8NAccLwYDP/JK9g==
X-Google-Smtp-Source: AGHT+IHqiNZSSuRgMIGzeQbAsyUzuR5eC/kcwrOx7kFHxfRG4MSHz3HHm0p1YAsqzGlVtXTmEOgHQPQhoyYoLazVVIo=
X-Received: by 2002:a05:622a:2a1a:b0:461:41cb:823c with SMTP id
 d75a77b69052e-46363b72104mr162429471cf.0.1731968837193; Mon, 18 Nov 2024
 14:27:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <20241116175922.3265872-2-pasha.tatashin@soleen.com> <8871d4b3-0cd8-4499-afe6-38a9c3426527@lucifer.local>
 <CA+CK2bBqi7+RExARBq5m91kaxC+w+nLYnLf4wyM_MJjaxr2rAw@mail.gmail.com> <ZzunOu4TcHcJIOht@casper.infradead.org>
In-Reply-To: <ZzunOu4TcHcJIOht@casper.infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 18 Nov 2024 17:26:40 -0500
Message-ID: <CA+CK2bAhB5KXnm8WSXe2SocMj1zyQnswQ0a=4AgDawcCcisSxg@mail.gmail.com>
Subject: Re: [RFCv1 1/6] mm: Make get_vma_name() function public
To: Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, tj@kernel.org, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, muchun.song@linux.dev, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	osalvador@suse.de, usama.anjum@collabora.com, andrii@kernel.org, 
	ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 3:44=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Nov 18, 2024 at 03:40:57PM -0500, Pasha Tatashin wrote:
> > > You're putting something in an mm/ C-file and the header in fs.h? Eh?
> >
> > This is done so we do not have to include struct path into vma.h. fs.h
> > already has some vma functions like: vma_is_dax() and vma_is_fsdax().
>
> Yes, but DAX is a monumental layering violation, not something to be
> emulated.

Fair enough, but I do not like adding "struct path" dependency to
vma.h, is there a better place to put it?

Pasha

