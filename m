Return-Path: <linux-fsdevel+bounces-9187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0DC83EAF1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 05:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1961F21E6A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 04:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1615812B68;
	Sat, 27 Jan 2024 04:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="je/Tyirg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9FF125A1
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 04:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706328713; cv=none; b=MmsNuWkficIAne21xI68RL/jXdQ0BMfn6QOIMq9g1KVofvyKxYWdsL18tAR8QclxSu0kzWN3bCXlXlJ/bw4wyAPd96OvFTArz6+uEhv9Q6RVC121CaEBh1NirW5GCglra7rZJ1O0rlIOH+VFDyTAfgVlKZnUUHIUg6UqhrtVSU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706328713; c=relaxed/simple;
	bh=jMPR0vaX8eatPJwW9fYk7h9CZo9RDW3RzyeGohOr7Lw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=YlfABrEzMXejgOsneNSzHPtkI2dibDKIJxpgWMLvvzP+R4j45iGXouC72UkY2LIVvnC8e9279hIPD5o0c4H6HP4Ccqp6YTdd+utk1CS37aa2S7L13f6pv3XBmn5ab9BN9DwK0emMjLsN1uV9uxjfmMfOqC/aQtS2KjEvDjOdqJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=je/Tyirg; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5ff828b93f0so12007167b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 20:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706328711; x=1706933511; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jMPR0vaX8eatPJwW9fYk7h9CZo9RDW3RzyeGohOr7Lw=;
        b=je/TyirgRomHE1Syymfw+gFrpOiz4oyrN9jqRIKXRLdMq+0AXSqz5PkonH+KpBlkSi
         mMvNeBgkeBWe9ON0wwADJNUCCje7dnx1PKR6eVZKl+/hP21dHEA4Z7ctMd+bDc51DTqj
         sn18vReffrROF4iw1mSe6vQZIGgO1+9Swxf1IOKKufTUljQuGJml2WXDjbUpdRtUlFQE
         H3wLBG0j4OGSDdk1o9OXUDk4C4/J1m3WXjSiVg7cbWx3sPD6jiXxCvrp6rwMEvzRXP/P
         7zxTgUpM06/aoD2KfofpeH6f0zPzyhKaQ+4B7BxcjpiBaIuAzQagW6XOFW7LRo5Nifz2
         rbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706328711; x=1706933511;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jMPR0vaX8eatPJwW9fYk7h9CZo9RDW3RzyeGohOr7Lw=;
        b=H5OJka9HgWOUvjVWgM6ib7mbO96p1NTIqG8rod9+fq6oIF1ajg+ENGWYh5bSduRzpZ
         yziLxUCAUpebfDaFGjs0CVIEugPAfRkGuoGhL6iFtRWJvgTRwBqYRTqSL/l4UTDZm4HO
         hEKyNpdDKZk5fkCqicDqjJW/bmlNt1Y47wrEQYcYaZcSXdtCOf2R6vj3KWs5eINj8ury
         AbATUJr4wY0EqvqjbUEbMuTWKX80xoX2q7aP4UznLMvZ0CKonzFLSUkLv9iomZA2lKKL
         mkgYQJDHTcphzWluAJrrJVVbuMxVB6Os9s+9Xe+sLBKWNk0lEjWSrxJgslZxEkTrUFsB
         ZcuA==
X-Gm-Message-State: AOJu0YzaqaIDMSNwruHd0YTf/Ao0urck7OD6otCTcXM0BgivAU0PjXRJ
	eZ7alWhUUy5CirBHTxU0VvX1s0OhGhe6M3g2qU+uB7M+iwJVXkSqLho5LaZIzCfjp1GzSf0QA+E
	qcYFLA8DbOeSrNATqVtft8ShKVhArNmVKEjm2
X-Google-Smtp-Source: AGHT+IFZQArCs7q6I0823C2/39lnMu074bWaoNwgZJpRvoYQHsPHTAYqAZFIrNqMmv8kl9rQQ89gpXK3OABbH4dC0Fk=
X-Received: by 2002:a0d:d242:0:b0:5ff:7cb4:d200 with SMTP id
 u63-20020a0dd242000000b005ff7cb4d200mr982422ywd.17.1706328710633; Fri, 26 Jan
 2024 20:11:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 26 Jan 2024 20:11:37 -0800
Message-ID: <CAJuCfpGixJHag+71RZzzTHKC2ra4DpRZMozpxujegFVamJUOGA@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] Memory allocation profiling
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Aleksei Vetrov <vvvvvv@google.com>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"

We would like to discuss the progress and new requirements for memory
allocation profiling [1].
The latest v2 version of the patchset is posted at [2] and we are
working on providing compiler support discussed at LPC 2023 [3]. The
goal is to discuss current state and direction as well as new
requirements from new potential users.

Kent Overstreet, Michal Hocko, Steven Rostedt, Johannes Weiner,
Matthew Wilcox, Andrew
Morton, Aleksei Vetrov, Pasha Tatashin, David Hildenbrand, Vlastimil
Babka, Roman Gushchin would be good participants.

[1] https://lwn.net/Articles/906660/
[2] https://lore.kernel.org/all/20231024134637.3120277-1-surenb@google.com/
[3] https://lpc.events/event/17/contributions/1615/

