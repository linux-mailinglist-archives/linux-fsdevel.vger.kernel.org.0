Return-Path: <linux-fsdevel+bounces-35936-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1810B9D9ED9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 22:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC18BB27942
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 21:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A3E1DF973;
	Tue, 26 Nov 2024 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BYUaKNTh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C391BBBC9
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732656370; cv=none; b=bN0DlmBz7F/AbgySPU099Y1HzFXDl6zU4p7I9Os8pX2y3hTF3Ii+NTpoXQ+/KdzyAgfJTlzgEHEuzNS8vwrdTB9oyg1dxLAEJ/gSbkI4+pLyYBthx7ryoReFbOTmq8bKS1UTZ9bPae6eVWoviwFzYbr1Xj+nGxucdil36uPBlYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732656370; c=relaxed/simple;
	bh=Kx/0QWPX+OdEqSNki0YPTvmPzEcNouqLCCl/QMYchKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rmV29LXoPvZqPp0trTKz+9xdhcLWFCKMUhMZRrHjT1GTgosi3gNJUUD5v8b/sXLJDdQJGT888JlfRbEy4i3FXdTxj66xaL0EqZZSJd3RHPqSPHZbD4l+WRAcgaF5q7jgMPutphUup1bFVIIUXEnzWGmUKarTuD5eyBxY8a602vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BYUaKNTh; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso522891566b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 13:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732656365; x=1733261165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G2eytn+wn7/zH3xbZzSo5Ejwd3Xq1yRr1L52T1xIuRQ=;
        b=BYUaKNThMB27PRN3T4uT2Sv4qup9eKQAUHHao/Epxn+E5wjFEEBzoQ+y+XmjEWbgt8
         Sfj6iugM4ff92oS6pZt/uBr9r7FVDD0YUvbIJKKFI2q2Zpa196I0nf2XSx++2UcdDvDB
         xbGBxR43pvaoYpv2M9woI+2Ob+wyBqOlsIvHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732656365; x=1733261165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2eytn+wn7/zH3xbZzSo5Ejwd3Xq1yRr1L52T1xIuRQ=;
        b=Klv1yDgxPh14bWQ/U4JQdoecUfPLFN+MCWEPCywBMkwm3xomvce6qpXJBc2KhxmM5w
         MWjmGn8C/yVdYwWi/i5rbtmF55zb6vUVTrVpRV4U14yS/PFg4CZrsG1RiPm9V5G+NWeg
         fdO2gIV5d4ys6V8CeBhuYduG9QujtcMVZCSpO3jW1iJyStaBD7PKUUxGLGJI8vc2RNMo
         sQZoSixR3bOdJir/4i++y4pXKT1kVM9yWQWZaydpCAIFB33iBkK8E7ZzGXJ2ZslVJLOj
         CJiE1MTg5t9JFtDlSmu4kS8/0sS93ISZ0P6CdQZzD1eKy4GI1r1S6XrmkZS5cSOwKLQE
         qYDQ==
X-Gm-Message-State: AOJu0Yz4k2461F2Bglu+jQ6sz6gDLvBVxt3IzadnrHV58m26yrU9IuEV
	Iqg0koYJrelT5Tth/qU1gvdjebzuLfvVe+wJ8ShY2fnoWT/O7aEwET/Fql8R4wJgotuvFnI8BQ5
	QCHaUvw==
X-Gm-Gg: ASbGncstqQ2oEhmMz+hMJmizn3GffYnh2hphrcJs+4Y9Eq7UaadvJ2Uc7ur7wCgUVzF
	nmlvdOuhCGkdsQBb2DvxOObloca1GzgwSasqXHGNAI20DefAmXrjwPKKenkx7PcB8EMUPKUWcea
	0vqDxHFzMwrRaX3gRZWUBRicZKnlyqhThPHXs+OATzrscKQhKY+XH0uRsM0ZORo3t1C96++rsDi
	flXY534X7vllbAM2wiVWb4wSFjl7SIgkRAgruS0Nb0umFGpYMs9MC/bapTkN+j3eXxzq0gLXNnh
	fQ6p3EI9EBPsU1jywDzq3NIA
X-Google-Smtp-Source: AGHT+IEP7TqLvk7x+4dNgA2ZbQKzy/1XQHfbCOsRAXAKmQm7RkoLdHQtdB3GvNWwpEM0vAQccaBkjQ==
X-Received: by 2002:a17:906:308e:b0:a9a:dac:2ab9 with SMTP id a640c23a62f3a-aa58103dbd9mr43952666b.42.1732656365216;
        Tue, 26 Nov 2024 13:26:05 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b57bfbfsm634417166b.140.2024.11.26.13.26.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 13:26:04 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aa53ebdf3caso522887066b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Nov 2024 13:26:04 -0800 (PST)
X-Received: by 2002:a17:906:4ca:b0:aa5:b32:6966 with SMTP id
 a640c23a62f3a-aa581076b11mr40826366b.50.1732656364133; Tue, 26 Nov 2024
 13:26:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-vfs-rust-3af24a3dd7c0@brauner>
In-Reply-To: <20241126-vfs-rust-3af24a3dd7c0@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 26 Nov 2024 13:25:47 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh81Obo3jzHuB6eg_a8x2ObjRG1Oa7g_B5qWK-uds=thg@mail.gmail.com>
Message-ID: <CAHk-=wh81Obo3jzHuB6eg_a8x2ObjRG1Oa7g_B5qWK-uds=thg@mail.gmail.com>
Subject: Re: [GIT PULL] Rust bindings for pid namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Nov 2024 at 03:08, Christian Brauner <brauner@kernel.org> wrote:
>
> There'll be a merge conflict that should be resolved as below. The diff
> looks huge but the resolution hopefully shouldn't be complicated. I also
> pushed the following branch:
>
> gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs rust-v6.13.pid_namespace
>
> Where you can just steal the rust/kernel/task.rs file from.

Well, my merge resolution looks a bit different, since I ended up also
fixing up your self.0.get() to use the new self.as_ptr() model.

And I ended up putting that as_ptr() definition in a different
location (just before the first use, like it used to be).

But I think the end result is equivalent.

          Linus

