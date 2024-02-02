Return-Path: <linux-fsdevel+bounces-9972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE362846B8D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 10:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D50B24912
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 09:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B05474281;
	Fri,  2 Feb 2024 09:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Lr5RkQm1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630267E97
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864955; cv=none; b=b6Vt4UGfMUQ6kU//R3VEM1KnxIsxfmtqo7TrnCPP68yn9PB4j2Wsr6ooWGXigp0ll1a5UbzLtELGaxygV+UEtik28n//0cVWi+k3sBqREk58wmOtn7r4hiM41KAyotzn05ihUJWBTM71Dkun259g4NWojdkogoNoMZI3e1ZqvWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864955; c=relaxed/simple;
	bh=K5RNrjZNne+9BhySI8vABslxCokSSL7jfngtWXORFLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oGCF7xDg3SKgJBn1a0PrOvtSIwDJMCiwYxM0w0A2W/v82yPYs74VFCorjNZyH3SAY9NP7WqAXwxLZfpXnd7aNGja/WDORhZVlBAYdT1ZFHbuFmtyKoky3331y30mwEAV37RtEatyKsUO6dIpvx1qMeALt/y8oE8jklVV7K7wQ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Lr5RkQm1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a370328e8b8so56073066b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 01:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1706864951; x=1707469751; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qVe4EBuC1wLLm/F/+zAhu2k0n4XVT4KAE++V21QJr+w=;
        b=Lr5RkQm1MHq3AwS+Qd/97KRSUSJ34ct4wUx0V7HyUfDpK1vQaHHT7BIhbLtNu3u6tV
         n19ESsgyMR8MNE3zrTVBREMfTBL6DoRtxKT51Csr3AGZHMHEUdUtaRA6yxj4/2JD6f3X
         OBOhEQGY/S8Ng8CFFjGeMIVN1qSzcfuADQu7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706864951; x=1707469751;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qVe4EBuC1wLLm/F/+zAhu2k0n4XVT4KAE++V21QJr+w=;
        b=w7wSXb/IiFlTOzuhZGzefk/oAJGxoTkV/CvevgdcIZrI5Id80zgFTLA/tgwyfsM+pt
         FUjiGubNm4KHvF9l6TlAVDNsot5amTIwE+yx7XyejWvBJNiK5Yoo8xrSnzv5G3I9iXNI
         hus3M/3fBi7YF1IXBWhAA808ndRAIhlN5Q8742dXusahYxVWbFM9Xw5sDE3ln33jgPjF
         H65OnmWiPUifkWPHBm4fIE14tgCYYdfpFUhuhiuL9RLm29cfh6WRMKZlQuHsZpHHM11J
         OJuW17ho5UL7TVr1A6NuLR6HsN88jWeqOtoWxh/FsxJeXFsMEXPDlcIOlC2H/SW7UoYt
         Rktg==
X-Gm-Message-State: AOJu0Yx9WNU4BBz/nGtJtTO5FZTYJKsMMD0INmLNTGw9CjrAn6TlWHkK
	/FkJ904+DwpRbKrBDRUx3JNvTMxbdwl6TbxbjkJoFKFGBHY/iruB+Jbl9EZzeTh35hnJYegLcfn
	1UUOH9jwGqZxL7uc3MWWGNbf2tqgn8SzgiuvBJw==
X-Google-Smtp-Source: AGHT+IHj3NH/ISBNdebgtuteIrihmJMBrJmXVr5sMJoQYHMqXa7Vh7uOvbmGRCvRuwAPdVjQYrM/OqS8wrk9a6pik9w=
X-Received: by 2002:a17:907:75cc:b0:a31:13e5:8fb3 with SMTP id
 jl12-20020a17090775cc00b00a3113e58fb3mr927763ejc.38.1706864950497; Fri, 02
 Feb 2024 01:09:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2701318.1706863882@warthog.procyon.org.uk>
In-Reply-To: <2701318.1706863882@warthog.procyon.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 2 Feb 2024 10:08:59 +0100
Message-ID: <CAJfpegtOiiBqhFeFBbuaY=TaS2xMafLOES=LHdNx8BhwUz7aCg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Replacing TASK_(UN)INTERRUPTIBLE with regions
 of uninterruptibility
To: David Howells <dhowells@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, Matthew Wilcox <willy@infradead.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, dwmw2@infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 09:51, David Howells <dhowells@redhat.com> wrote:
>
> Hi,
>
> We have various locks, mutexes, etc., that are taken on entry to filesystem
> code, for example, and a bunch of them are taken interruptibly or killably (or
> ought to be) - but filesystem code might be called into from uninterruptible
> code, such as the memory allocator, fscache, etc..

Are you suggesting to make lots more filesystem/vfs/mm sleeps
killable?  That would present problems with being called from certain
contexts.

Or are there bugs already?

Thanks,
Miklos

