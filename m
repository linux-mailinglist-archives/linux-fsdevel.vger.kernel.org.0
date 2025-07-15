Return-Path: <linux-fsdevel+bounces-55004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D26C6B0648A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26D7C7B3B5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72EEE27BF89;
	Tue, 15 Jul 2025 16:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GQP89nXG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0693C279347
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752597795; cv=none; b=YiLdFy1+l/1lEaBgAemrvVx26PyM6pXXYN0Zvg2DQFX0JBjtNNM8q2mGqz/5SULWbOYqK5Ii4BDgXz8h8lXNLidEZTPjFPZcUIpMtPglbevRzP4WJC/Q2BkY9ishuP2tkQIGBNeD4okhA9TAywdLOKd5VjUHqs8FL5t2KfJxRcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752597795; c=relaxed/simple;
	bh=OZLBdP80AuAPBpQatgV4tnOFj5nsWaDVvWpCLDIyI1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+vtfnmJx0ESke0CYILHZRGDFaiJVXPjLZMo3xWREljNxRa4V6ElWzy4ZTNeq3xdI5iA/x8ueLOHV+gT5AUUw9KPG6jDidDVTMrU0ys2RtMtguntVp3+EfxCRuuzsPgXVgbnDWW98QFhRYVUEs3+taGjjgHMqTqsa1ezrryPhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GQP89nXG; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60700a745e5so11728300a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752597792; x=1753202592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=46zpS+UQ3AzjYrdMtZXy87Fu+5mO7Am2ZTQb8NQ0ZbA=;
        b=GQP89nXGHmcPxSyWhA3gns+FHeUEh2bQAMUi+2WPcKYYDZmlMzhBTnQXpqIOLPNcWm
         gsmxeqJRzDOevhHu5fxdwKS24+iD+LZH02GPF3pZhj7SN0Ytq93nKQzHhfUfo9u7fW0K
         /2HSvEdEjL1EnXxUXIIqdMAJLMUwMJopFeYdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752597792; x=1753202592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46zpS+UQ3AzjYrdMtZXy87Fu+5mO7Am2ZTQb8NQ0ZbA=;
        b=oVolPARM7rUM1VaWgas7OiI6IcksC905E226FbZ3gD1yL2K2i0TxdFA96DLz6isCuG
         Gq2hs8rXC+dUmECn1K2B3/0pr28w+QdGp/ST7KA/I7TQ8Rm5uiN88+uLAV3kvz88wOPE
         EQ6r9nwlpArThXAYV7NNBcZvrt281WrUEVKLnNZYutySXtPpnJWcmW9WZwEetzukiaXu
         LFhQfXrhPB4RIgKkG/cKcsa+vzIPRiNA0KoSXt4cRmuy/ejWc7lkgqvNH3WwMIa2Y7FS
         6z4RyETM3pFYxGQ3lcqkEDnCq6X4REz+BT8Oqd59w7TkonagIByVbqvLmBt9C+2ddzDc
         WC8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmHPLqcB45NHWwWQbxNSfBCVrMKCv4ulCSQGg519LCeInP19g/r/I5qZc+Ttfw78qHqhp9TosTnj/uT51J@vger.kernel.org
X-Gm-Message-State: AOJu0YzmRMO/cHfiFTKyjLEduwnjfk/XXhSpn0JGw1fR2b1q2aaELiRZ
	tqYZnLyN/2soUQZwS1qRCkPTpN+zIF9DlPvMEDatl3pv6FN11B3eL104JWkluoSuxqNrZNcWXCh
	X05Wd+TU=
X-Gm-Gg: ASbGncvZxyo/l/LrzK00C6y6+RmfaqlkjYII6z74ULiTnnCk+Tzer7uyonzMKY1y7+E
	FlGnv6qZZCh67JJg7C2xnpgtMntpZnn5wWWaEzDfjX0oDpAKSa/NqKLO6em0VKjf4omfQnbC52+
	fPF0efHKFXXxxKSHf37rkSN6m6P9D2nsAK1JfDE9vEyegJ+WZJzmB8FS7g3C4VSzApqrcx8DzUo
	4tX9Y6okF0pN1HQ8rhF6Whje1jI+hR2magVrQ/8/ywcKNdcoxgOmY+Sd5aWfDhSpTdisJS7xFrR
	AcXYBH40sJkCbWaGjHrAgB6eXoSfVZcNztN4H1q3DU7sidAvualEULAKO4dmaXzIx3P+y96QBBj
	xJZD9LUwZgF/6f+fT9tPedLTWNqM5A0k9prvHj8ew/OpN5b/8V8cabGTZiKb0dyVTUXTN227Mjd
	plI9Nzzcs=
X-Google-Smtp-Source: AGHT+IG/XezZu3/EUV6i/4yc/0sAYdmrUoyhkgNWZaANfu1oa317bdNbClnZ91SvPGVXmYy1WTlxPA==
X-Received: by 2002:a17:907:7285:b0:ae6:ddc2:f9f4 with SMTP id a640c23a62f3a-ae9c9987c6fmr16174166b.6.1752597792009;
        Tue, 15 Jul 2025 09:43:12 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82645adsm1030092866b.107.2025.07.15.09.43.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 09:43:09 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6099d89a19cso10384947a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 09:43:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXc4z0q/ULKbkEokGkMCNbcW7hmTAr46gA4Elnn0Dde7oGTRXXQ3TpAVEafueYLCoP+1L1n8BKAjgecOqX+@vger.kernel.org
X-Received: by 2002:a05:6402:2686:b0:607:f64a:47f9 with SMTP id
 4fb4d7f45d1cf-61281f226d2mr26921a12.3.1752597788853; Tue, 15 Jul 2025
 09:43:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752581388.git.namcao@linutronix.de> <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
In-Reply-To: <ec92458ea357ec503c737ead0f10b2c6e4c37d47.1752581388.git.namcao@linutronix.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Jul 2025 09:42:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wheHZRWPyNNoqXB8+ygw2PqEYjbyKQfSbYpirecg5K1Nw@mail.gmail.com>
X-Gm-Features: Ac12FXwEFq81tRpxQQo-YtMJ6UxIp_wzb2appHmE6OGEEPULt8cuT-X-Zaqr3nQ
Message-ID: <CAHk-=wheHZRWPyNNoqXB8+ygw2PqEYjbyKQfSbYpirecg5K1Nw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] eventpoll: Replace rwlock with spinlock
To: Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>, Xi Ruoyao <xry111@xry111.site>, 
	Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <vschneid@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-rt-users@vger.kernel.org, Joe Damato <jdamato@fastly.com>, 
	Martin Karsten <mkarsten@uwaterloo.ca>, Jens Axboe <axboe@kernel.dk>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Jul 2025 at 05:47, Nam Cao <namcao@linutronix.de> wrote:
>
>  fs/eventpoll.c | 139 +++++++++----------------------------------------
>  1 file changed, 26 insertions(+), 113 deletions(-)

Yeah, this is more like the kind of diffstat I like to see for
eventpoll. Plus it makes things fundamentally simpler.

It might be worth looking at ep_poll_callback() - the only case that
had read_lock_irqsave() - and seeing if perhaps some of the tests
inside the lock might be done optimistically, or delayed to after the
lock.

For example, the whole wakeup sequence looks like it should be done
*after* the ep->lock has been released, because it uses its own lock
(ie the

                if (sync)
                        wake_up_sync(&ep->wq);
                else
                        wake_up(&ep->wq);

thing uses the wq lock, and there is nothing that ep->lock protects
there as far as I can tell.

So I think this has some potential for _simple_ optimizations, but I'm
not sure how worth it it is.

Thanks,
          Linus

