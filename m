Return-Path: <linux-fsdevel+bounces-77623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SL1dH60xlmktcAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 22:39:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A26615A481
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 22:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 755DA3029A9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 21:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DFB314B8E;
	Wed, 18 Feb 2026 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O8MbQeWR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791ED2F39A7
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 21:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771450665; cv=none; b=ZA/jiLXROah2FdpkT+hiBQjdf32q2ZuMqRxNWd6U//kzoS2yXe4VWHn7P9UXGh42aIihDnd9URUDoq/GkUNIfnUi2jHczvkn2MaICNILZd78ndm93oHpUC21+P6YOCgy/cEpS0bJ8fLkl6x0uouRTbvwwwDG62TVHZq/qJAJVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771450665; c=relaxed/simple;
	bh=Mjj/MKiQaclsNiKatW+qobWgMLim0nxbLT7/b5xhTj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kg4HHfBfOBmVKrWGJOWup4NB75hJ2L+TxF47R7TMxamDHj3P1hgPu4nh9ZJX33P4x5qbjz8yBrpru/38dWXtKJexDXQY5aJyF5drQfsz2HN/xTmE5vD2LPMlvm+QElM55gUY8fQscPHT8LWtOdPekc+1o9YdH+yxjOJx2ACQgqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O8MbQeWR; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b8871718b00so48959866b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 13:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771450662; x=1772055462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/CXb8eFvmaA/qcXz8sFovDAQGGVYxA348RoIEhGSft0=;
        b=O8MbQeWR4CAyFGx/sF7Fw2OeJBrBRHk7cdXqZan9r5IBsyx90NMcGiwolCplHodRQA
         7QxIuD72ALabpgK/rNzmA+W2aXEDgft+nuZQHISIXskNdXiLMQ7f65xOndHFkr1kXLxA
         albtjQ7ZNV6G3oDVq+lSJD6IsxmmV23yFXxhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771450662; x=1772055462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CXb8eFvmaA/qcXz8sFovDAQGGVYxA348RoIEhGSft0=;
        b=aeKPy72S4oyiJ4wza6+WP1eBqbwL21ABwX6X0U6droyHnI9+2NUNl3j8RVKOKzv74F
         SkuqqmZ3Wi1dYJ7GxeZ+sJ4V3siceM19exJisAuj2Nyrtiyf6Q1JJhnU5XXInEmcxcWd
         lIpzjha5TP5Oiu5ei3wP4tCz6MdIbBUNB35Rs6LXZdVcYDd1jfIgX1j6wzCU1wCPJfU9
         fTLrrAlx3aZV8FDglfaGIMJl3sGTSNTCInZ5dfUd6oU2zM6pcDQYuewwm6TVWXCvzXFs
         OlRpc+xBQZPfmhArdNRYYbmYLAfBX39M9fcyXyWHFudiS9gTFP3f6zbE5VoRn4ahWhTd
         Nr1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVw3ZyACdlOqFetUh4F+fbaeqbCs127i61dXcPvmmTs1r1UyKcpzeVYhcZfNf17w1EjhOChkrhvzBukrFI8@vger.kernel.org
X-Gm-Message-State: AOJu0YwESlsiyL9fNNDUvs1YJInIadueM9mBtRQMzQHl92ihmCAtk8pt
	JlnR+3UN2olhd27l0S7nF3Ph9IHhZedNRMgkT98Cx/hcw6y7Fe9T1sCcqQNcVhYAKeUoFmn5iSV
	IQaaHSY9vtQ==
X-Gm-Gg: AZuq6aI1hSowYRL3hbHMFKn7HXII4Vk3n1ufpgg5Kim8bLi4G9Ak2Voc3skT/wwaIKw
	tOfXuUsuv4hCKpqYpRmb3dU4574PnV5rOkshJbzk0+jRyKx+xZ3t+uqSjGc1/5iXiP6nwwxzO4u
	Kfqbz6l+BwSosBxeXBOUWokUBgdJKxarJU02PfKZledxo5t92fin+pBv8XPovhFiYRGQY4hHSNY
	qg/UhyOzfadbT6Ydp0Kt8ZApN4ve6lCXjJ6yy1UMr3LVbVa4Vizp+fh5SGFLBfzpBxGoUXJPhVb
	fpVUzDk1cGGuhimCKGhn/R46N1Hsq4viwUT4Oe/31FNSxZwvPb+jhCX4P1YHOy3ZZKfOInhfqYb
	86RAe9jl48dTKyefUlSYl6ecWsVzNxnCIp7WXKQmHZUWGkg3n5o+Nmrj2Ojyyp/oiLdZmuMilel
	mtK7GAcrZqgEOmPyeCwuzq1DnIkICASYRLmWMtLJ1tmLLz7VGA0t5WlwkYG+P9INg35eQBV+VD
X-Received: by 2002:a17:907:6d24:b0:b87:756b:cfab with SMTP id a640c23a62f3a-b8fc3c4650amr809541066b.36.1771450662379;
        Wed, 18 Feb 2026 13:37:42 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc769437bsm493178666b.61.2026.02.18.13.37.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 13:37:41 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8871718b00so48955766b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 13:37:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVl1N++7BYwzxMmPo/0Poxb+3aqbD1muKzLDgOqM8epLZjERP2y3Xu97IozJRK7TD6Do1ETQhAzSY/iWOae@vger.kernel.org
X-Received: by 2002:a17:907:3fa1:b0:b87:4c37:7fd8 with SMTP id
 a640c23a62f3a-b8fc3ca9c56mr827129666b.49.1771450661207; Wed, 18 Feb 2026
 13:37:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217190835.1151964-1-willy@infradead.org> <20260217190835.1151964-2-willy@infradead.org>
 <CAHk-=wjkyw-sap1dNkW7v8at8MvF3j5wshC1Gw3XEpHBbBw6BQ@mail.gmail.com> <aZYoXsUtbzs-nRZH@casper.infradead.org>
In-Reply-To: <aZYoXsUtbzs-nRZH@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Feb 2026 13:37:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=whcwak6DH69earTrbVdMenzC8_i_xOc6juenhkHOw6xgw@mail.gmail.com>
X-Gm-Features: AaiRm50fxcXpfIuxbPEZZOitKLtoenx-LGdoyddasDL3TtlyjY6vlArlALM_suA
Message-ID: <CAHk-=whcwak6DH69earTrbVdMenzC8_i_xOc6juenhkHOw6xgw@mail.gmail.com>
Subject: Re: [RFC 1/1] rwsem: Shrink rwsem by one pointer
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-77623-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3A26615A481
X-Rspamd-Action: no action

On Wed, 18 Feb 2026 at 13:00, Matthew Wilcox <willy@infradead.org> wrote:
>
> Here's all the changes I made, and I'll post a rolled-up version
> next.

Thanks, this all looks good to me.

                  Linus

