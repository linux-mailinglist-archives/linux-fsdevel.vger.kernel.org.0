Return-Path: <linux-fsdevel+bounces-38418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B64A022C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 11:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DEB1884934
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 10:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B871DA62E;
	Mon,  6 Jan 2025 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="YDnn2Zg/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B2D199391
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736158796; cv=none; b=UTGo7a2/R6XLBNdTD/ecFsVzFWAfpG2tT+4H3Qo2pUkFCM34PoLGGCyiG62PBxsV2U5jQ5VuZaQ/B+m4eIUXFKeaNqIFhaQDrZtyYeomxKtnxDyUZNdlNZE8pYAdpMicR+g1HxX3yBhbzDs+e2N5M+kbnZGkpYwEG66utDg1QKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736158796; c=relaxed/simple;
	bh=M4JLcXniCWxgRmLNkqlsFK5oZ+/pu19xKCE+Qcxy09w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fTnjKdY+NIk3kjUQ88fjdWrSnsqcniNPqn2E9xUZ4iyT45BG2QCVy3wuuOj9tKRybRRvGBXC2O8+tEVSvnZw9opzcFQKiKbYqtQ+E9ASODC1YGqK1rY3elaB76Hqn9RI+aLsbtyinTBQgL4qqce85/TqB65K0dffFh7P3GNEYaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=YDnn2Zg/; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b700c13edaso750499185a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 02:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736158793; x=1736763593; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M4JLcXniCWxgRmLNkqlsFK5oZ+/pu19xKCE+Qcxy09w=;
        b=YDnn2Zg/m/aZbCek+JfNT2wouivoVLF3P4C5HqRNtERfUdk1NCE4PZ4zj7VIsoxmDI
         sF3VxpPbT05WAP8/kd/hQPo1kYdNxrO3qKgkTpRMxgSbTjxTHwKXLBbKsqF6YB3XLffX
         j9XyZgOfknL1L9P2Lt/0qZOIKT/bR8qdwdobg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736158793; x=1736763593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M4JLcXniCWxgRmLNkqlsFK5oZ+/pu19xKCE+Qcxy09w=;
        b=WhEdkmEnOAeuLbKoHOIDvDaPG6Ea7tIZEalJB0mRq6Xn47/47MQ0x3I9KNQM041xZL
         PO/W5h4zU3L2QldaYm2kx5OOM37dJTTEuOtfSHlWLOEq4+oAlheH2slnGn60SlqPVzvy
         ROU8ZSXjcP0pPeG1X49dY/diz5VZQm/pVaz8DoGRdMELJdxePldb5oRprfmsjhETk9ku
         A1urFLHEJexO5w2pB9M54eUvwbkKI3sXLQEbCIKSz6C5EsmYkDRnUs4vC0Xt/4iiR/8b
         eVp/UpR8D/ZCrt3KEfLxr2LSAL9IRBjJYOkgFQ1DEAN0/1dnjuxP87lvJ4+djiAHdXEk
         r6HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnLO3FThwSeQtxCFhK9PJzBurs93XRlsZx7M5d54JDHwU9HaRcQ/iZ/BX9z/+i9Lay6KpQC6uRweDf9I2m@vger.kernel.org
X-Gm-Message-State: AOJu0YxhPQ944V8X2/2in+jFvilh+3cEtzld4+BflSMre2IXyGnguXMN
	9otZPYb4ovnbDKlfWg6wXruTt3swayD1o9wbgJTCAgAhkGqH88beAw/13xNYnRAYSK9QD77MwFG
	MxhliyRbXLyqPNBtfSLrYMSnBBULllqJVlX51Cw==
X-Gm-Gg: ASbGncuTzHnAdFAQO35WToidoRP4Tuqc1/wrA2hfjabrGng2porD8anjCkDEkbw451l
	VytA6q+Os8p/TYfq2zGr/yJTGhhVT/er21rco8w==
X-Google-Smtp-Source: AGHT+IE3DHywjKUr8unvAh3zVm+J5Y4+HbFc41xfV+2Kyu8zDg5Ofc1erpSD58g3pk5nkP7SRlIMRX/04s5cBG0fjww=
X-Received: by 2002:a05:620a:2a0f:b0:7b6:cedf:1b4e with SMTP id
 af79cd13be357-7b9ba7e5e4dmr8430132985a.41.1736158793661; Mon, 06 Jan 2025
 02:19:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b16bff80-758c-451b-a96c-b047f446f992@fastmail.fm>
 <9404aaa2-4fc2-4b8b-8f95-5604c54c162a@redhat.com> <qsytb6j4j6v7kzmiygmmsrdgfkwszpjudvwbq5smkhowfd75dd@beks3genju7x>
 <3f3c7254-7171-4987-bb1b-24c323e22a0f@redhat.com> <kyn5ji73biubd5fqbpycu4xsheqvomb3cu45ufw7u2paj5rmhr@bhnlclvuujcu>
 <c91b6836-fa30-44a9-bc15-afc829acaba9@redhat.com> <h3jbqkgaatads2732mzoyucjmin6rakzsvkjvdaw2xzjlieapc@k6r7xywaeozg>
 <0ed5241e-10af-43ee-baaf-87a5b4dc9694@redhat.com> <CAJnrk1ZYV3hXz_fdssk=tCWPzD_fpHyMW1L_+VRJtK8fFGD-1g@mail.gmail.com>
 <446704ab-434e-45ac-a062-45fef78815e4@redhat.com> <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com> <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com>
In-Reply-To: <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 6 Jan 2025 11:19:42 +0100
Message-ID: <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: David Hildenbrand <david@redhat.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 3 Jan 2025 at 21:31, David Hildenbrand <david@redhat.com> wrote:
> In any case, having movable pages be turned unmovable due to persistent
> writaback is something that must be fixed, not worked around. Likely a
> good topic for LSF/MM.

Yes, this seems a good cross fs-mm topic.

So the issue discussed here is that movable pages used for fuse
page-cache cause a problems when memory needs to be compacted. The
problem is either that

 - the page is skipped, leaving the physical memory block unmovable

 - the compaction is blocked for an unbounded time

While the new AS_WRITEBACK_INDETERMINATE could potentially make things
worse, the same thing happens on readahead, since the new page can be
locked for an indeterminate amount of time, which can also block
compaction, right?

What about explicitly opting fuse cache pages out of compaction by
allocating them form ZONE_UNMOVABLE?

Thanks,
Miklos

