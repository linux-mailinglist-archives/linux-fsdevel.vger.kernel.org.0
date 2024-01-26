Return-Path: <linux-fsdevel+bounces-9109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B3883E3F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E441F21F07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 21:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D9A24A07;
	Fri, 26 Jan 2024 21:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q7ydLpfR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF84250EC
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 21:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706304682; cv=none; b=C/JW6/SHVcpkcQ+qBXpKEk09IYnA5k99IC7utuiF+Vj03sIO9RMBFhtn6sAuS5VHP3b4XhOaOiO8/4JBZUCjeB54xB69KOM5KYNmSn8DwBTcsy6Cnjct/zErvkqsPppy/D7SURrRt3TwUAcxxQoVlAxgN4zzwqWNEY/9QaXNWuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706304682; c=relaxed/simple;
	bh=6mukGWAjPX2YjUL4JezyXFLuCN/rYL2RbG8PlJMIYCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKg1lZE0pR7x+9IzNBsWOYfnVC9aMYj6r3xgxkkpfEa5alPAOSasRM2M4LUgItIiBjcggPbWp8NN5k1xMeCIsT4oNnme1Hx+JpPluB/dCFfnrkjFGxMKn9tpSBdCRjANYXmcNKnnzYIc4alWBLIZH0T3XBvMAevMcedBglmlUxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q7ydLpfR; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so1483820a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 13:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706304678; x=1706909478; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=maDpcikpyh6FEh8N/tIM7o82tGen2/tmETzOibUg/is=;
        b=Q7ydLpfRJBIPc1zDGpnWKX59E/L2MQWkHam27t3ye3pXQ8KhaHdVt0cKFF7tR4dRhW
         8FJHYZqd8atnsWngv3bauKLiWGGaYBjyXN/6BBDtmjfKU0cxI5e9ZJu7aCAHhq8d6EVd
         ERs1EzNLsVqS933T2uYBsrpwCzZJu/0QPBC+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706304678; x=1706909478;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=maDpcikpyh6FEh8N/tIM7o82tGen2/tmETzOibUg/is=;
        b=YNwXRxQ0cQgRUcuo59rSeP0XzK9Ve5NOMiZnzsZYA1kmgiQlzJffQUwp/1RdasO78+
         PVI0rQ5impXoMIC7zUG2fUqolZWb6JIwHl4DVAFcLFgbtoX/zmvaf4EiZKmFXBbHvV+o
         oEBrIWcwaQ1wdQzn3GpyfnyFzGgZvmzCEN/j7WtrgSH2HkMt03FdwrcDgNFZFe/sILMg
         4ybcKqmt0q+Nlgralv8AjIeW0FCVtkSfn5ckUcci2MhY7g1P/9u91xzVPab+rO2lWwz4
         5sLuZNJeUVdgoN2tlbEQPsD9av1cCupOpWWg2+F8Sm3BPvUQMS+WQDUPkikQUy7BxMWm
         PS5g==
X-Gm-Message-State: AOJu0YyS5Nz4+pnLY8rY7Qhqk5rAzaTl+5VGPGQFY3UTN0vykPnqVT2H
	natqkIDg6Y5Z32m38SilBqczKwG2nwVt6qXXo98KAo85XNO1qMbTL74G1p9CXPjOa3pzsQda1q5
	HO6ZlRg==
X-Google-Smtp-Source: AGHT+IH6G6BwsEOFAhrEGzk5Oz0nGar7cgisfsNcxoZcFXpljZn/VCAd7F4QrDHdjFZGtqh3hm7Ixg==
X-Received: by 2002:aa7:cf17:0:b0:558:b48a:b5f1 with SMTP id a23-20020aa7cf17000000b00558b48ab5f1mr2356583edy.7.1706304678633;
        Fri, 26 Jan 2024 13:31:18 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id p4-20020a056402044400b0055c7d4d29bbsm980233edw.93.2024.01.26.13.31.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 13:31:17 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so165036266b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 13:31:17 -0800 (PST)
X-Received: by 2002:a17:907:75cd:b0:a30:e9a6:68f6 with SMTP id
 jl13-20020a17090775cd00b00a30e9a668f6mr2088169ejc.37.1706304677484; Fri, 26
 Jan 2024 13:31:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home>
In-Reply-To: <20240126162626.31d90da9@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 13:31:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=witahEb8eXvRHGUGDQPj5u0uTBW+W=AwznWRf3=9GhzxQ@mail.gmail.com>
Message-ID: <CAHk-=witahEb8eXvRHGUGDQPj5u0uTBW+W=AwznWRf3=9GhzxQ@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 13:26, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> So we keep the same inode number until something breaks with it, even
> though, using unique ones is not that complicated?

Using unique ones for directories was a trivial cleanup.

The file case is clearly different. I thought it would be the same
trivial one-liner, but nope.

When you have to add 30 lines of code just to get unique inode numbers
that nobody has shown any interest in, it's 30 lines too much.

And when it happens in a filesystem that has a history of copying code
from the VFS layer and having nasty bugs, it's *definitely* too much.

Simplify. If you can clean things up and we have a few release of
not-horrendous-bugs every other day, I may change my mind.

As it is, I feel like I have to waste my time checking all your
patches, and I'm saying "it's not worth it".

               Linus

