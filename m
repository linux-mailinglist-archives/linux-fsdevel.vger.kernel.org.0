Return-Path: <linux-fsdevel+bounces-41433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71F9A2F728
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 19:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4143A301B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 18:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5681A08B5;
	Mon, 10 Feb 2025 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b="D1yCHSWs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE3225B668
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 18:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212467; cv=none; b=GVXCMHELjVxpE3M74hqR/JeiPKzv9wrSHksLI0aATkCwl3NO4NHYlJiQcwwiSF1AlwveC4UExmFHw2Y8g/yh0752NdNwvyUhlauKifzb7qutlr6KjmnhU0NY229lJTYSuQd2WvUr26uS9UK2pX6i7j7dPdhYiOPZZkvQmshodJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212467; c=relaxed/simple;
	bh=gpH9vmxvl5HIS6ETSK90Nyk5snQxXSDUPWARQbvAdj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PjbXtgSQ+lVkchYz4KoTTlYn1FmORCOYFwd1x0UCzYW0qvlz6+2eyMLHoWVMazOCzWoNjpmPxnTuD3Hz+ikA5GU9TRlad5C8IHetdrW5SLBlMBj9og6kAsOIAwHiM6qmQhpXtUFV6tk13NMlyk9QMTDAQtSsPjf/s/B52PiS4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com; spf=pass smtp.mailfrom=scylladb.com; dkim=pass (2048-bit key) header.d=scylladb.com header.i=@scylladb.com header.b=D1yCHSWs; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=scylladb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scylladb.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21f48ab13d5so75848195ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Feb 2025 10:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb.com; s=google; t=1739212465; x=1739817265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TtE8Mn8yxuEsrWyQt/824T3+/FuJ+XtVk6ePIzrR3yI=;
        b=D1yCHSWsFmch5WkUxC05c41Tl57oZNpzsP7Pxq0o1CezDCQZdkkVQauLKBbP4V998D
         2BDpxgMG3w8F0f0YAJmu/9QuhTcHMJ8FhcHU8BP1OXiIDKxuBpYSD6YRJK3viq9e0JD3
         5kQfT5e2Zviw1dqxfFJKs5r05sseHTVzNAzfM1Ly2Y5VcyjUar0gGGxOuS+AEzlsKe+L
         5om9P+vENtOyQ2Gvt8NH0L/jRk1II8JeKe8bnCXvDjVhtNz/MBxqWK4RjGpri22fCHEl
         TbG7G2bOs/8GORnSaW5YugfgGPYsleCC6Z+YRpFRMtzHA8Q0wsmVYXY9zEfMV94G/Xxa
         J9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739212465; x=1739817265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TtE8Mn8yxuEsrWyQt/824T3+/FuJ+XtVk6ePIzrR3yI=;
        b=BGNCkOuxOoQkku+LR9pGRXYb9Wb5nxq9rWIUXrEvt99URsZagX4y4WzvCEtfJKVx69
         RyzCKZnPBNIXNR4Tct1ZS7n9ca2JebebfZVS65XNkePYydtg2z9bRo1M0VQDQhPJQ35H
         IaGzOVgT5rtGAQ3MhMTZxcpbRlIscyGD2sv0T5/v6kRl+T1qGHIqbTfA9LSR5tD072hh
         N0I1qPERSQJzIzE9a9OjAxOBBWpqCn3wCBFv5YEs6HkAJGbIDt6PtCVWhVgQw8xg13VY
         mrGwj87gSj3QU3v37sKRX07fC+bkXOs7uSDlGldT2izODF/vQq290fwnMIImwBYibUYT
         QFbw==
X-Forwarded-Encrypted: i=1; AJvYcCXQKFoadJwuAHRQ8ggM9t4UOuNgccrtEVq2TDSeikN4wt4frdHhNtPzT+juHlnla951WivVROMkkpbXJoad@vger.kernel.org
X-Gm-Message-State: AOJu0YzxGIVZGl0rJl9KKkR5iKnZ1kZwWHFMyMXAZe4fvb3II8QHqQw0
	ufRAI1k5gbHmpjKIsPQm5b9Pking1TGbCF+HPESYyymken99yF0Qmtd5hPaCXrzEtQqKmGitONS
	rM9p0oM19remZzlLNMyFVd/gfqPUZCz6w5d8N+XOCMbfFAs1az+lWbr1K4NIeG/cSmzQtqDtF5R
	24utkv1eASUj5U9/0TCsnur40ZP3uPRLlQCX7VFSax3r5GxnyBdjHFvIHJZbNdUrQPoZVxxk49m
	KwuSMElzaULZhKAMLd/xIQf+BfqLGZ0/7epTK3lozh+N1gSzD1t652nynViqDlSF0ZHsu2bKFFw
	mnNkon1TRi2OZHY8ohBgX/V01mQf8nr/57d2k+aP1kDblUO2+SNRR/ZunIN3wI0C07/S8QtVIgg
	Mh/b78EtIW5UZOIIe7qfWG4+u
X-Gm-Gg: ASbGncv4pnjfeyVttgZvkpzKqMJwiM6t+2b2uvRgBS0IhQU6Bp8Iy+Qf2rKMnAhzUF4
	9hql69QA3HrDZ7uQCxh1N1xw0glF7fPWHAatEHpNyE/n+AGDELdoHH2U9yGiTLeOFjBY+SRTcRU
	tT/Q3WztlNkfkVYw==
X-Google-Smtp-Source: AGHT+IGMZzGJbQn2M+JIUBkEh5RD6eTxlW+LYFah5rG4D3ms6esly6cH0lvgQtkr+zBFEsKYJcLey9gtT4kURkMhaM4=
X-Received: by 2002:a17:902:ea01:b0:216:5448:22a4 with SMTP id
 d9443c01a7336-21f4e6a037dmr213747695ad.10.1739212464930; Mon, 10 Feb 2025
 10:34:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKhLTr1UL3ePTpYjXOx2AJfNk8Ku2EdcEfu+CH1sf3Asr=B-Dw@mail.gmail.com>
 <CAKhLTr08CK1pPbnahvwJWu-k1wnwVV4ztVMGrmXRY5Yuz03YeA@mail.gmail.com>
In-Reply-To: <CAKhLTr08CK1pPbnahvwJWu-k1wnwVV4ztVMGrmXRY5Yuz03YeA@mail.gmail.com>
From: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Date: Mon, 10 Feb 2025 15:34:07 -0300
X-Gm-Features: AWEUYZlSn_nHGLCmKITeKjm9ehxtqZAOMEeXOg252a-rnBJWIdsjsDJhyFDqBto
Message-ID: <CAKhLTr1-UpCWuMk2KsJ9=BLSADiRmDAtBU7LoCq6Zq4JFN2LgA@mail.gmail.com>
Subject: Re: Possible regression with buffered writes + NOWAIT behavior, under
 memory pressure
To: linux-xfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Cc: djwong@kernel.org, Dave Chinner <david@fromorbit.com>, hch@lst.de, 
	Avi Kivity <avi@scylladb.com>
Content-Type: text/plain; charset="UTF-8"
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylladb,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: scylla,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0

> > A possible way to fix it is this one-liner, but I am not well versed
> > in this area, so someone may end up suggesting a better fix:
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 804d7365680c..9e698a619545 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -1964,7 +1964,7 @@ struct folio *__filemap_get_folio(struct
> > address_space *mapping, pgoff_t index,
> >                 do {
> >                         gfp_t alloc_gfp = gfp;
> >
> > -                       err = -ENOMEM;
> > +                       err = (fgp_flags & FGP_NOWAIT) ? -ENOMEM : -EAGAIN;
>
> Sorry, I actually meant this:
> +                       err = (fgp_flags & FGP_NOWAIT) ? -EAGAIN : -ENOMEM;

Digging a bit more, I realized a better patch (assuming regression
indeed exists) is this one, since it accounts for ENOMEM coming from
filemap_add_folio, which might allocate in xas_split_alloc() under
same fgp flags:

diff --git a/mm/filemap.c b/mm/filemap.c
index 804d7365680c..dcf1f57e0a9a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1984,6 +1984,8 @@ struct folio *__filemap_get_folio(struct
address_space *mapping, pgoff_t index,
                        folio = NULL;
                } while (order-- > min_order);

+               if ((fgp_flags & FGP_NOWAIT) && err == -ENOMEM)
+                       return ERR_PTR(-EAGAIN);
                if (err == -EEXIST)
                        goto repeat;
                if (err)

