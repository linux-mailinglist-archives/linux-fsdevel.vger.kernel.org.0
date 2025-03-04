Return-Path: <linux-fsdevel+bounces-43149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B337CA4EBDD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49E23B5A09
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 18:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317642512C8;
	Tue,  4 Mar 2025 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Caj+FQkl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19B4205AC7
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741111958; cv=none; b=ejIDJyZqxAyHwVOTqEzB9lT8oBaiUN3LlSE8LL4gZICLCuusvqUrhbBBwFKPEQlb6ZkN0CxWeZ56QwYb8CaTFbCGd7hP3I2/v/WnuZt0/a6ppqJ/gV3zC3MigOjwA3FaxEqrJC2ZnV8E3FjtYGrXsFiOauZMyobYGTuA6Q63lMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741111958; c=relaxed/simple;
	bh=ZKEiViHx4lfhXN2b+U2kj8U/5qjRqfhrRty0Xi1nIUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfrJMHQ4IGGy1HeHG2TDTdl+81J28q5vUqOmXBB+0rVVmKBODoIct81CcZ8Jy1/UYjxY7+KGMPhXj6alleny50Bu631jiBbS87AZSYNzLOtYc5VQjootzgvyhwT0VkVETrVySituzwhTJqnXnZZcSrpAmmElJVWX3Cgc74Pw6B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Caj+FQkl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaecf50578eso1132881466b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 10:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741111954; x=1741716754; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cotFSgUM+8LCa2jd4lHJ3XLun7qyfRX9tXHNjJu7zBA=;
        b=Caj+FQklwmk5xmk839iDNtRVa5uOH5xA520GMqIwryVMc+FZgsG2XB+WqFC02GNCmJ
         WzUtK+br0vZXS4tezm7uuTcrVgAvcbqM0WkY5+y8BkUFqI9VeGyzHmW1lPjVpXo/27sz
         YDnkvU2hm3YS8SlitycfBM81jR3Ix62RBGYI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741111954; x=1741716754;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cotFSgUM+8LCa2jd4lHJ3XLun7qyfRX9tXHNjJu7zBA=;
        b=cXP7uo+tOhSorkYbWlBPNBq5Pil6UEW1c+hXw3i+mCrmbleqj9W3Cim7TUgkOAaXyU
         2JGlmNbHYGYeOdTn/RLDAEWu9L0ZBG2X9fwC7zquLo60Wdn2yLDQxyI6Aez7TMqGXY/C
         EuGPhXU2e5ESC91n69fIf/ehwAa675/apYqOIpJpKRrPnEU5YHmUYA8Zs6fzGN4iCEex
         /EQNhSnln0VP26eILX+WtSEGrDaIByp2nVVtPtPcReWpiI+ga+jObcZmUwLv33figIpc
         W92F3P5fBK+YZWXRXEzcV3w+PzLT6Vgtj4G9ZQpmNXnF1FzFpYsoFuS7eGHQpLBGkl3z
         5hDg==
X-Forwarded-Encrypted: i=1; AJvYcCX5q05Ob65wr9XH/iSytlv+kJA0bdL4RZOV+F2Tl6Bzj2PwU1K2dJgg9M8kIfGMS6QsoDNx39X67lvrGT3q@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6mieCVG+dYzDOwyVHEadXMXm/tSGuXF+gjEk/7uqKIomkXXMi
	k9xNMp+F/TwKcc4jfDdHAOhgrPA5u5LwhMnuco8OzlzxqqavmwdZRbMDkkHxfHFCvYDOR05wm9/
	NoTSRcw==
X-Gm-Gg: ASbGncsmXE6CLsH8dqpnUm2IAsJE5Pnevgp5KYN46mdRNZj8Wt/ZOnxxuY9IrEJ2kma
	+gxBuCs8RXyC7i5oWr62+g7ElJKQbpMKnPlBZx70prFI2PUXhQNA4kYhQnExuXbWiNZbJHQmhIP
	SqZXONoBnh9oIVaBe1L8gjhSj2YvSs9rUZ7845Edh4NtirJtHF73PZFII8UVuD285dcivyL1ae+
	hHE+I1Nt+y1OacMad747Q3EMJjOft5m5IwQ/48HOsq2OQ78L1Zg4Junnh2EmyUXa5NQgKdm80US
	9PkHQ/0W8TrQ/vSp1oam4v2pe40EY2Qlv5ivDTHCSjGy6HaJwyRE9qMf85PD1bsDTRoio+YiX05
	9V79H6A63KKjDdwhK/Yc=
X-Google-Smtp-Source: AGHT+IF9tce3jDkmDWWsrAD6Fm+5S5CZSF31XNWZQR2eqqnKheZEDk3ZHceORJ8iMcRTnyYTv/06rA==
X-Received: by 2002:a17:906:c14f:b0:ab7:cb84:ecd6 with SMTP id a640c23a62f3a-ac20e468fe8mr15580766b.56.1741111953877;
        Tue, 04 Mar 2025 10:12:33 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf74e85fbfsm425053366b.15.2025.03.04.10.12.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 10:12:32 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abf5f4e82caso577480066b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 10:12:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVR1xld7ogqzredLHMy0b5d50QyPpQIFUFIpohnvCc3qQiJ1JBW4Gz5bRegEQyeDoxSJ0feacycsiIF4Fol@vger.kernel.org
X-Received: by 2002:a17:907:96aa:b0:abf:40ac:4395 with SMTP id
 a640c23a62f3a-ac20db4ce56mr17933166b.31.1741111951498; Tue, 04 Mar 2025
 10:12:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303230409.452687-1-mjguzik@gmail.com> <20250303230409.452687-2-mjguzik@gmail.com>
 <20250304140726.GD26141@redhat.com> <20250304154410.GB5756@redhat.com>
In-Reply-To: <20250304154410.GB5756@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 08:12:14 -1000
X-Gmail-Original-Message-ID: <CAHk-=wj1V4wQBPUuhWRwmQ7Nfp2WJrH=yAv-v0sP-jXBKGoPdw@mail.gmail.com>
X-Gm-Features: AQ5f1JqjSP27LVMyo09ZwIOqft6imz235TbU_7WRePdslf_UMXdRbBjWU8irOdU
Message-ID: <CAHk-=wj1V4wQBPUuhWRwmQ7Nfp2WJrH=yAv-v0sP-jXBKGoPdw@mail.gmail.com>
Subject: Re: pipes && EPOLLET, again
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 05:45, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Linus,
>
> On 03/04, Oleg Nesterov wrote:
> >
> > and we need to cleanup the poll_usage
> > logic first.
>
> We have already discussed this before, I'll probably do this later,
> but lets forget it for now.
>
> Don't we need the trivial one-liner below anyway?

See this email of mine:

  https://lore.kernel.org/all/CAHk-=wiCRwRFi0kGwd_Uv+Xv4HOB-ivHyUp9it6CNSmrKT4gOA@mail.gmail.com/

and the last paragraph in particular.

The whole "poll_usage" thing is a kernel *hack* to deal with broken
user space that expected garbage semantics that aren't real, and were
never real.

They were a random implementation detail, and they were *wrong*.

But because we have a strict "we don't break user space", we
introduced that completely bogus hack to say "ok, we'll send these
completely wrong extraneous events despite the fact that nothing has
changed, because some broken user space program was written to expect
them".

> I am not saying this is a bug, but please consider

That program is buggy, and we're not adding new hacks for new bugs.

If you ask for an edge-triggered EPOLL event, you get an *edge*
triggered EPOLL event. And there is no edge - the pipe was already
readable, no edge anywhere in sight.

So to clarify: we added the hack to work around *existing* user space
bugs that happened to work before.

If anything, we might consider removing the crazy "poll_usage" hack in
the (probably futile) hope that user space has been fixed.

But we're not encouraging *new* bugs.

               Linus

