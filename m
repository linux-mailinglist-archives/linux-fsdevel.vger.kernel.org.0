Return-Path: <linux-fsdevel+bounces-66202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25458C19589
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 10:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3DC03AB90F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E488320A0F;
	Wed, 29 Oct 2025 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9fxux5x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCFB31E0E1
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761729174; cv=none; b=VT26FcyMIkdlM8n5J/IOLoz2FKaewSezT5EIBljI8VACUIYCI9bI830tYu4cYwYFF5jyyIie9tm6hZoZqy1WsAuDoO29FayO7EvDOKBDAn0E356RMqpCxAwOF3D54prvKwLEte0TyT29TIl8lepeYt5rWD1wHkiJXjrYQz6wIQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761729174; c=relaxed/simple;
	bh=krm2oZWHXNyj2OY+480XxIMsziVCbnpUlmwLuLmd8oo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W6dGsn4TgoaoMh+nWC2Iu9BRcu6PAzxa8t/4UfTfNorAT4WDlQI7xJJj4th/A6+3/golKWBsdXkjr2Bl9JCe391Kb5vyidTpSgVE9PQuR/3PRViL9xNKr6JP4HwwIgspEnzHizMCxYlZpPWacTJ/1W+TUd3r7zZYPJhFm2Rmdrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9fxux5x; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63e393c4a8aso8196032d50.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 02:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761729172; x=1762333972; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BBqHz8cFPV9OUQwbjare8Pel7U5XHqHAeYtuall28CQ=;
        b=s9fxux5xToO1bCeLUpuISSCurSMgPO2RGN/AEZghDTZsuKHjzlebAInKnXS1ejB6AD
         Ho9stdAb5AnLmJlVlrdjUomZ8XqQtfP1evsGC3o9Ux6JWh0PWXPfBUyqX8PmvSI0U73K
         EiunpJooJaHg69dVaTB3oNN0nkzlc7m1YWgGdVdMEABR8itBHWTQvIhdg5EdURgIzYbc
         rxJKUtUiswTTpJU309W+A4qiPhpVsrSAr6hf5Dfec1F/PMwn/gZe2GsXexrIJpMy7HzO
         8RBvD3DwYME7i3PeKI3rTmkzHibTLdvOreYDIUJ3Xiq1B/9VHD9qeIR/5Y3O0xT4E6QG
         MUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761729172; x=1762333972;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBqHz8cFPV9OUQwbjare8Pel7U5XHqHAeYtuall28CQ=;
        b=pZyV/4/oqB1266mKBYumV4iU7O4hV4BECUY+josxUwc/DAY1sUmLWFsGhlIblJ7Q2F
         OON0QPGIRuo1KGccXY8EpvfAbmq0KOpz0wTQFnKCYz9/NwJyzqWCN8h/x6iCMochESpo
         WG+Dzs4bJ6H68XqyaXkU+5rtbMy9gEcZ6jFPknRhks7JS9VqwCvxtUfAXPJigazYkvf+
         L60WiGBn00NgYujtv7NQK7aU7QsBebDQX1zz9SCBGoZahkaFpHbBy7J+Y8XxmSKEh4sO
         fDi//b/JK0TMsTZ8bPivcsgyYY57XiIF/MxTZc6+oGLO49H/WiMH/+9plVGN/Z6s+umH
         T3mA==
X-Forwarded-Encrypted: i=1; AJvYcCVrEF5iPLqIHqovzBOX4EWVeSZaDwoTA/+p3fZYhaRcYZzI6uClsWdleAV50DXdLLCiyQjAPJ8oVmDExi2l@vger.kernel.org
X-Gm-Message-State: AOJu0YyLvAf1f5XKClGW3vOwpehl6nZyY2TbgvlPrRi5d7RvXIZPGjBS
	XDW6cV9K85CliWkTp0HfD8SrEe16S9SLJMRFQyxlHQ95r0Mf+BXRNeV1P8zTOn+Dww==
X-Gm-Gg: ASbGncv6znZym/DsYQWPDViJpGwl9F2vvRFxAjATEFKuLI1fqii7kCn82ln/qsfKdCG
	q9S7GhSl6UsDZgNQM5o2SXfDSILHEBKIQmqbEyfkj/2An4s5rdUJCKN/5lR26+6Rvk7yHU1usgf
	T2Gexr2dyyJ0KqjLAQIvt16h/OCwLza3Kdb4Q8B3qqEz+OuHnb3f1f5g9kqcBCiu1RwW5+NZbtX
	EtgWEGmEJbwDniWtqnGddVql37FrMA81ThkXYovNnYREeyhCh16ZtmrIxis0XkUfmj4xvCdGANE
	7FuDYcq5v1WRZMCTI76Lrfjjn3HyKOWquxEOHBu1qrJ1vTJrFRIWyw+V3SUei4TpEUSyfvj92vA
	ycimWH3+WXy6GH8hr5eMKtCIKXkUmE20WDbR+GrMof3g0f9rqNx6sZ13snP+Ub6qA84SdT94GRd
	uqqUjCZGJZJYr9EPfX5GMZfIRzqhBI5nIH0zkU2HyuphberPMKsOl4L+sCjkae
X-Google-Smtp-Source: AGHT+IEUyMs7bw/KHzPZ51AbmO3wPAApjy9icdxMigxwWyr9bCi7kzw4YLn0xUhUa4b2Nc69MgGvKQ==
X-Received: by 2002:a53:cdcc:0:b0:63e:187b:f383 with SMTP id 956f58d0204a3-63f76dced0dmr1569801d50.52.1761729172087;
        Wed, 29 Oct 2025 02:12:52 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed198ef9sm34560117b3.24.2025.10.29.02.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 02:12:51 -0700 (PDT)
Date: Wed, 29 Oct 2025 02:12:48 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, 
    Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
    "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
    Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
    Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
    Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>, 
    Johannes Weiner <hannes@cmpxchg.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>, 
    linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/2] mm/truncate: Unmap large folio on split failure
In-Reply-To: <qte6322kbhn3xydiukyitgn73lbepaqlhqq43mdwhyycgdeuho@5b6wty5mcclt>
Message-ID: <eaa8023f-f3e1-239d-a020-52f50df873e7@google.com>
References: <20251023093251.54146-1-kirill@shutemov.name> <20251023093251.54146-3-kirill@shutemov.name> <9c7ae4c5-cc63-f11f-c5b0-5d539df153e1@google.com> <qte6322kbhn3xydiukyitgn73lbepaqlhqq43mdwhyycgdeuho@5b6wty5mcclt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 27 Oct 2025, Kiryl Shutsemau wrote:
> On Mon, Oct 27, 2025 at 03:10:29AM -0700, Hugh Dickins wrote:
...
> 
> > Aside from shmem/tmpfs, it does seem to me that this patch is
> > doing more work than it needs to (but how many lines of source
> > do we want to add to avoid doing work in the failed split case?):
> > 
> > The intent is to enable SIGBUS beyond EOF: but the changes are
> > being applied unnecessarily to hole-punch in addition to truncation.
> 
> I am not sure much it should apply to hole-punch. Filesystem folks talk
> about writing to a folio beyond round_up(i_size, PAGE_SIZE) being
> problematic for correctness. I have no clue if the same applies to
> writing to hole-punched parts of the folio.
> 
> Dave, any comments?
> 
> Hm. But if it is problematic it has be caught on fault. We don't do
> this. It will be silently mapped.

There are strict rules about what happens beyond i_size, hence this
patch.  But hole-punch has no persistent "i_size" to define it, and
silently remapping in a fresh zeroed page is the correct behaviour.

So the patch is making more work than is needed for hole-punch.

But I am thinking there of the view from above, from userspace.
If I think of the view from below, from the filesystem, then I'm
not at all sure how a filesystem is expected to deal with a failed
folio_split - and that goes beyond this patch, and therefore I
don't think it should concern you in this patch.

If a filesystem is asked to punch a hole, but mm cannot split the
folio which covers that hole, then page cache and filesystem are
left out of synch?  And if filesystem thinks one block has been
freed, and it's the last block in that filesystem, and it's then
given out to someone else, then our unsplit folio hides an ENOSPC?

Maybe this has all been well thought out, and each large folio
filesystem deals with it appropriately somehow; but I wouldn't
know, since a tmpfs is simply backed by its page cache.

Hugh

