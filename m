Return-Path: <linux-fsdevel+bounces-62179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A6BB87343
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 00:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678707A5B45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 22:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04812FB625;
	Thu, 18 Sep 2025 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvVKSg1v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E722217F27
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758233432; cv=none; b=XCx/5Qp95+ga+SNLzZlZPDBiX32ilhdxcBt2JceeUNJliVm84kjBjd4Ix0vlHtUhjjxLYPzPfQdfGywhgqe+2Snv5BTnIuuXw2/sxCNs5ORq3MndBn9rCgNyk2/d8NVqz/JPsCGq4HA/0t4f9ewYntpGKrt17vHSXy/DuQIM6i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758233432; c=relaxed/simple;
	bh=6VwWe0xPzmV6FnfeDnW6efYh9BxtkUPEBFMEiPZsQos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxL+ZoaBQ7c7T3+JmndkqfYk/DiwYVg8ILr2h9kE8nhZSaMLKzawVKrrXZpqeJa4Qp6EKTDNzpJTXkgMkZ0fMyZtSuUkjdd/J2uEZJ+3otZL6g7p5EVnKq9BNgXbtGlvTOl/6/NFZmgxWczKDx5P4aoZs0TGh62tcA3hvrPqpnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvVKSg1v; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b5f7fe502dso8291001cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Sep 2025 15:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758233429; x=1758838229; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMLjismdPXyhxGkoMZ3Owc4rCn1icqDpq8x4V7KOiNo=;
        b=YvVKSg1vRUDnooP/KlKT4sMOj/sSYAcgeM87AvYjQKoPq1uKuVYipDyIQfck4quKJD
         jFXyQEVrVjWg6CHdpMlzXzf3j1PBTF4ZnTG/4PAXD0os3RYzp8iN+pGoxwqt2txSAD5i
         DTM6SRd49p5nPy1Pe+8nAsVj3uQZMs7cv3dHXjIP18dMoHVTPrHliL5CW6OgcWv5Hl/g
         dkg8pgIdkSKATj2g2/nHCeux9ZUiba4j4elOL7VLUQHVYKKjbJUiwPs0FSpX8NLPXqKf
         IT9M5OdHEMnzsrKwgYHPJQoWJkej+ulYnTKxDbdoNMeDU/3RNOyAx3aS1wOQyU611666
         KEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758233429; x=1758838229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BMLjismdPXyhxGkoMZ3Owc4rCn1icqDpq8x4V7KOiNo=;
        b=WyxnQnnkU5beYg8mfLADUOclPqNGMUAnIb3FUaPLAYlydf7YwYZRICIE/IXYVr8f3F
         xZt3cdDI7g14ilgPpHeP6BC7WFFgoYvkKTWFsjV5QLlHjZLAzziVnDMRMbnoEpfDDso+
         ZS23bnJh3C7MrUyYiMeqCZj/k9uQMLepc7CjkCiAAPG2EqwbZAPT3Z0CuzwcdAanfNdu
         99QayIeeJW/roeAHKAOZfn/ILuxKzY3U8B60HsxJ99OtAQmaXzVwQ0Bact0j4DYsj6/T
         6slluvKEzK+qh36RdgVkAXNbNXPgz2mfpmzLJLT0qDOAUk8WAZa4zPprjtwcCuwUO2bF
         iP4g==
X-Forwarded-Encrypted: i=1; AJvYcCW555z19hyNp7uh16m8KiwN9MMdlpAKauLsJLMO9Y1l1OJfCHj2eP+hsapTWp1PwVEVYzhcAd98oNr2yszI@vger.kernel.org
X-Gm-Message-State: AOJu0YxsqxRHqC33TnNS48SSRsAHcd8M3juAU/uNKL/mhhuDTnOrrXG6
	Gk5eCCkzMzmS/QvfSQtC3V9rUPh+HZG4jrXvUfvnenfxkabbZmYVcdVdZSAmehe6GYXzy9nTDce
	b5junVifxiBooSmAOwFikbUePhFzo5LsZLjV9IcM=
X-Gm-Gg: ASbGnct0HQOHtsm1CY1xpy319ynhb8+YRxn69UfDyErpEjU0Xrq2qv5xb6zUlKed9gD
	JgbCCzWvXmUL9dc+ct+4aDnHedc4zHq1rujQPagAnjY4yMQ7MWMXsyAmlGKNyCaAgBCpPB6u8x1
	BWb/ZCKR6vRwbYxdHJg31rpNdevyz7/UqZCX4n5Xrl7dJhMvuaYnCknPIPkWJRIC9RXg6IaVJqH
	Fg49kL7cNkGYM0DG5+r9266+1fUSaN9ZIEb8ry0Sv6qhpXVOpNxaLxCtYc=
X-Google-Smtp-Source: AGHT+IGjdL034BALwTmUdxjSXlOGWZyplNPvLP19rLkgfseOZk3Ugy7fDNveBvPN8Hi+/A69y1Rk5PPcZKYyk2nw0cw=
X-Received: by 2002:a05:622a:11cc:b0:4b7:976e:8c48 with SMTP id
 d75a77b69052e-4c06e3fab4emr12835861cf.14.1758233429428; Thu, 18 Sep 2025
 15:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917004001.2602922-1-joannelkoong@gmail.com>
 <aMqzoK1BAq0ed-pB@bfoster> <CAJnrk1ZeYWseb0rpTT7w5S-c1YuVXe-w-qMVCAiwTJRpgm+fbQ@mail.gmail.com>
 <aMvtlfIRvb9dzABh@bfoster> <aMwW0Zp2hdXfTGos@infradead.org> <aMxpFWnIDOpEWR1U@bfoster>
In-Reply-To: <aMxpFWnIDOpEWR1U@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 18 Sep 2025 15:10:18 -0700
X-Gm-Features: AS18NWDwA7X-ONVkveKmDgwbimKxayr87pUKVFaacfpPIbDZBHVxH8s9c2UeJHs
Message-ID: <CAJnrk1azO4iZD05atv9VJCG9f1G=8YCW6cyUw2LbW=4_ufi8gw@mail.gmail.com>
Subject: Re: [PATCH v1] iomap: simplify iomap_iter_advance()
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 1:14=E2=80=AFPM Brian Foster <bfoster@redhat.com> w=
rote:
>
> On Thu, Sep 18, 2025 at 07:27:29AM -0700, Christoph Hellwig wrote:
> > On Thu, Sep 18, 2025 at 07:31:33AM -0400, Brian Foster wrote:
> > > IME the __iomap_iter_advance() would be the most low level and flexib=
le
> > > version, whereas the wrappers simplify things. There's also the point
> > > that the wrapper seems the more common case, so maybe that makes thin=
gs
> > > cleaner if that one is used more often.
> > >
> > > But TBH I'm not sure there is strong precedent. I'm content if we can
> > > retain the current variant for the callers that take advantage of it.
> > > Another idea is you could rename the current function to
> > > iomap_iter_advance_and_update_length_for_loopy_callers() and see what
> > > alternative suggestions come up. ;)
> >
> > Yeah, __ names are a bit nasty.  I prefer to mostly limit them to
> > local helpers, or to things with an obvious inline wrapper for the
> > fast path.  So I your latest suggestions actually aims in the right
> > directly, but maybe we can shorten the name a little and do something
> > like:
> >
> > iomap_iter_advance_and_update_len
> >
> > although even that would probably lead a few lines to spill.
> > iomap_iter_advance_len would be a shorter, but a little more confusing,
> > but still better than __-naming, so maybe it should be fine with a good
> > kerneldoc comment?
> >
>
> Ack, anything like that is fine with me, even something like
> iomap_iter_advance_and_length() with a comment that just points out it
> also calls iomap_length().
>
> Another thought was to have one helper that returns the remaining length
> or error and then a wrapper that translates the return (i.e. return ret
> >=3D 0 ? 0 : ret). But when I thought more about it seemed like it just
> created confusion.
>
> Brian
>

I'm looking at this patch again and wondering if the second helper is
all that necessary. I feel like if we're adding it because the caller
could be confused/unclear about needing to update their local length
variable, then wouldn't they also be confused about having to use
iomap_iter_advance_and_length() instead of iomap_iter_advance()? I
feel like if they know enough to know that they need to use
iomap_iter_advance_and_length() instead of iomap_iter_advance(), then
they know enough to update their local length variable themsevles
through iomap_length(). imo it seems cleaner / less cluttery to just
have iomap_iter_advance(). But I'm happy to add the
"iomap_advance_and_length()" helper for v2 if you guys disagree and
prefer having a 2nd helper.


Thanks,
Joanne

