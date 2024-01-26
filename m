Return-Path: <linux-fsdevel+bounces-9125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4518983E56A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35EE282CF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9F82556B;
	Fri, 26 Jan 2024 22:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HMMmvQiZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683882511A
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308162; cv=none; b=mq2hmgEwdfdT4F0nkuAAVy+ukToQTwanavHaZzs81rW9lkIF7NztkpxbSZ8tp0poCExH3HzVnkD8s9mc0scbMRIcsaKkfBkN5XlbSQceMKW16sfM/0mnBWpFfnvNAAPQepTsJ79w3X6fUoQo9B5RWjDcf1sb6nXJhdcKMxQC9wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308162; c=relaxed/simple;
	bh=bnGLdwzstqH5AfSoLZdw6+SstBNNV6/ADu5DzEq61y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uu+ABuonPHe6/pozpix8pOArX27Z3phMFJfA0oUTSrEo10EbtmYySglEStVhVVynPjrR2yInihJ028CMar2GWdtgtxI1N53UuwShlGXFPskVKZY9r+wkskjFK4AQwD/31vo6t2gCkoa3VDM4B2Io6Js1ApdB1ECjRA0ruwZWpvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HMMmvQiZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so13995485e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 14:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706308159; x=1706912959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tRiurWLUnvaCNMuWmJHCRa1/X+mumAqXgtZJfgR1jGc=;
        b=HMMmvQiZpcgtqcBgmKLGP1OTAtqXFA5fFA1zn82JXWqVQdz05IFfEqaQtgeeSAdoCG
         B80fFH/6MXRB1fcioh3BmndcuHCC+zV22aIWr0b1o8zPyt2MTVBf0CvRtlOhvffp7QOF
         BPmGL2/okUnkrEyYQ0B7JKZ7I17BgPp78XZJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308159; x=1706912959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tRiurWLUnvaCNMuWmJHCRa1/X+mumAqXgtZJfgR1jGc=;
        b=XxRkQUBYvX7lR+JpWVjZ34eVi0y323uCfNFyfmVX7q1ly1YtMevDBrYeVe1DqBKAMW
         eHr+CPmI8PcaQ042JezCv9tZcFJ3huMSvmMvvuruLwSqSrp1n2VWNrm17Sz7oaJ62z8J
         XdblWeDYgSSjMp99D65iSXtEqY2EI2vFXAoPzi6WtWhrEAHY7EDJ7DJl6BRrIWrbtRui
         dOH0v5RCWvzgLhcf4ft58TyoR5vMkF6jk3hWlodwZZeYDo6cnxfyNN+dTLWF/GFL63SE
         5CxUpLpgD5csRyTjqP5UV0MGSjaEfmlAXkC6/BB/awaOshEkjlMReqxr/U4N5HPwFt3r
         upUw==
X-Gm-Message-State: AOJu0YxxK32zYSPopMd15Iu1Io7Bbl1pnReOSVHJdWOZUHSvrv88AOze
	P31/YnFGhEbF4zSU1OEScG1RLiRNsnuxD63S3IyKJV43LX8SGtWdDBSx+zUoSpbpqITbLLV6SLK
	WqjaGmA==
X-Google-Smtp-Source: AGHT+IF7qimmhato+y7gsZXMgQK5r7dT+XIVMeLpw/kJiCF/Ztw04lp2ckYlwDTUNL0wblQt88ryRQ==
X-Received: by 2002:a05:600c:1c81:b0:40e:d176:1c2b with SMTP id k1-20020a05600c1c8100b0040ed1761c2bmr368574wms.64.1706308159529;
        Fri, 26 Jan 2024 14:29:19 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id o20-20020a17090611d400b00a3260cc1803sm1062034eja.188.2024.01.26.14.29.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 14:29:18 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-337d05b8942so1114925f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 14:29:18 -0800 (PST)
X-Received: by 2002:a7b:c5cc:0:b0:40e:c5fd:8ad2 with SMTP id
 n12-20020a7bc5cc000000b0040ec5fd8ad2mr348816wmk.44.1706308158118; Fri, 26 Jan
 2024 14:29:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com> <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com>
In-Reply-To: <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 14:29:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=whAG6TM6PgH0YnsRe6U=RzL+JMvCi=_f0Bhw+q_7SSZuw@mail.gmail.com>
Message-ID: <CAHk-=whAG6TM6PgH0YnsRe6U=RzL+JMvCi=_f0Bhw+q_7SSZuw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 14:14, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> I do however have a concern with the approach of using the same
> inode number for various files on the same filesystem: AFAIU it
> breaks userspace ABI expectations.

Virtual filesystems have always done that in various ways.

Look at the whole discussion about the size of the file. Then look at /proc.

And honestly, eventfs needs to be simplified. It's a mess. It's less
of a mess than it used to be, but people should *NOT* think that it's
a real filesystem.

Don't use some POSIX standard as an expectation for things like /proc,
/sys or tracefs.

              Linus

