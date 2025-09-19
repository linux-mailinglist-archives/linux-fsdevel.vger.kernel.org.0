Return-Path: <linux-fsdevel+bounces-62255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABD5B8AD96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 20:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B184417F1BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 18:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B42258EF6;
	Fri, 19 Sep 2025 18:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyD5f8Ik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2818B24634F
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305037; cv=none; b=g1dos899Jx/xyfgijtaZZ79zGe3UXcMHTzmO+Kd070COI01eajHE1CaYm92WMMXOqH5hnJJkUHt/7JvuRzThTUJ+s2Hwq79sTAmhtc+78hhi0+otS58dDR4nyC0Pe8ADTWER0QBTPqzefqRbTb9Ud2HuipOQ6+rDhzySbH7CUTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305037; c=relaxed/simple;
	bh=oe4rO+34n8vl977MlLbGk6+3JgLpoR3i7QYKFnt+64w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nsQVJTfObBu/kiaDxn2b63Cy4vZz4WBPtjzLKncVCHMoIzcyJhAgQ2LsPXuH3V4SOzla9v1e8sSAeX5u90Xh9acshpvPOgm+addCqi07AW1VNb0PfJzot33P3b4nM3VBe8kEmav5Y7LJ0YQKm56IHnU8d+iVQqwcL0C+KunoyAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyD5f8Ik; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b79a332631so27256231cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Sep 2025 11:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758305035; x=1758909835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMJ4+OkNnkL+s6nAzePUhz2Zzq9NDO6Bsor6cODBwag=;
        b=QyD5f8IkO3gEn72448w5hEo6DtGAVF2iZlnBgOHIDQrmu+/bpv4Z5jXWpUCAiImfGK
         4FdlDIYxbIz7hqcc8HlicjjBNE4C6IKzHpho2rn130+WY0G6mQPsDwaHlcMgvRVJLCDe
         fRbXZCfPVMHDlr4c/GyRKjU1iX0dTMB88N+DOhIdOpP1cG3SSEKQwhcblWlxgXRVlDw0
         Xorq/p9EPe6W+S7K1XD2P40HCqwpAmDiWeyfINmyoUf0KSNE9jKz9xWwbphi1J8LPWMN
         9znQ0YFvgBHr7D3+jWbJMsmxkka9b8X2kXJ4JrD85QrF6v4POnCh8Q0Nok0sWiRn8MAj
         5KPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758305035; x=1758909835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qMJ4+OkNnkL+s6nAzePUhz2Zzq9NDO6Bsor6cODBwag=;
        b=M/H5NnhgLVeu2I5crXo0VNEcz6y+oLrrGaIVfmbBAnqN2mZdEiFMSf/VLC7cNpnb2m
         5dH6lNop27XhIAYjO1jDH0VjJr2QUdao/S3VBwgsEyz0Zu2mJBfzvyLvZYGXhJXlsYCQ
         rzSXZGnyHf719DBvQsoEePXAXcWG89/c2OpmTcDqjE74Fdq4MPSb2C/P5OQMkQFDRPXa
         S7s7grLA44Z6SvN3NbQ8sPT8yCe93hyK+ntFNvdyXYsDsmv8Z/SqH9xXvzg9q7WLqUt0
         T5lpbPEmAFrqcrEgJ1dW5Opo8MqsnVNRM04FBS9XvwP78wwgFoZJan/xIavsLOZilLxS
         4xCg==
X-Forwarded-Encrypted: i=1; AJvYcCUgx5HMiBFtyvEIHcpJEjR+rV8GQ3j1NIhxv2mSnOhJhqu1vtF7ZVuTQlCW6LYPKkgrj3b3ENfBz9yXKN4d@vger.kernel.org
X-Gm-Message-State: AOJu0YzDyKPJRlqhOXNNvCQG8ycwCIamIZgkyTCp6I9uZfw0h+CL9Ceg
	fACKamOUmoxU6XIGPJzS/g/Li8BhEaMafMofwp+xS1wPdBMZq98H7lJvtlUWHU0KVN4jF5KI4z8
	fEc9APOLaHrRRSpU4+vcaeGLPSnNPP6z8mIRu
X-Gm-Gg: ASbGncu/Hsk0fPPzseDy+ac94Fsp7FyIyv/gsbzrwN69s8pFUPbYYQ5EU7ITMOs0d/7
	TTSu87y4CvK1yq0OENtt4nBJ8CyhihiC4C5wOXI3fH/IEI8Q9sBA3p512+33BCrJvEHNDKGQuhW
	8Hz8c2SXrZ8dEpaEh+YJnVL6KfemE+qBmrZAXK+YnSVKsKg90W5mDRGmOLUixI5kvq/B7/O1Lrm
	cDFf7H9bEQyw+P7t7xJz2hQ+J2RLPk+H6DpREFjIAfLY2aWfhk=
X-Google-Smtp-Source: AGHT+IFTemq44lhpW2+fJUp9d3hIXojtq1qkmNSVmmBtkm06YKH1jP0CIAKomtVZrtha0lMFnJy1JgZi/TpI2BzThpU=
X-Received: by 2002:ac8:7d0d:0:b0:4b5:ef93:913d with SMTP id
 d75a77b69052e-4c06fc18019mr42613951cf.14.1758305034846; Fri, 19 Sep 2025
 11:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917004001.2602922-1-joannelkoong@gmail.com>
 <aMqzoK1BAq0ed-pB@bfoster> <CAJnrk1ZeYWseb0rpTT7w5S-c1YuVXe-w-qMVCAiwTJRpgm+fbQ@mail.gmail.com>
 <aMvtlfIRvb9dzABh@bfoster> <aMwW0Zp2hdXfTGos@infradead.org>
 <aMxpFWnIDOpEWR1U@bfoster> <CAJnrk1azO4iZD05atv9VJCG9f1G=8YCW6cyUw2LbW=4_ufi8gw@mail.gmail.com>
 <aM0_9f7r5l6U4lHS@bfoster>
In-Reply-To: <aM0_9f7r5l6U4lHS@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 19 Sep 2025 11:03:43 -0700
X-Gm-Features: AS18NWCrzg_zUKc7WVi6gzUBUvUGI0T2NeWxo9taFUa1ihS2czYWhg_xhLHWMrY
Message-ID: <CAJnrk1b9DgM1WwKgpoUeWNuJaV7m-k-yUGKT0Pdn4FjLSmhKMQ@mail.gmail.com>
Subject: Re: [PATCH v1] iomap: simplify iomap_iter_advance()
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 4:31=E2=80=AFAM Brian Foster <bfoster@redhat.com> w=
rote:
>
> On Thu, Sep 18, 2025 at 03:10:18PM -0700, Joanne Koong wrote:
> > On Thu, Sep 18, 2025 at 1:14=E2=80=AFPM Brian Foster <bfoster@redhat.co=
m> wrote:
> > >
> > > On Thu, Sep 18, 2025 at 07:27:29AM -0700, Christoph Hellwig wrote:
> > > > On Thu, Sep 18, 2025 at 07:31:33AM -0400, Brian Foster wrote:
> > > > > IME the __iomap_iter_advance() would be the most low level and fl=
exible
> > > > > version, whereas the wrappers simplify things. There's also the p=
oint
> > > > > that the wrapper seems the more common case, so maybe that makes =
things
> > > > > cleaner if that one is used more often.
> > > > >
> > > > > But TBH I'm not sure there is strong precedent. I'm content if we=
 can
> > > > > retain the current variant for the callers that take advantage of=
 it.
> > > > > Another idea is you could rename the current function to
> > > > > iomap_iter_advance_and_update_length_for_loopy_callers() and see =
what
> > > > > alternative suggestions come up. ;)
> > > >
> > > > Yeah, __ names are a bit nasty.  I prefer to mostly limit them to
> > > > local helpers, or to things with an obvious inline wrapper for the
> > > > fast path.  So I your latest suggestions actually aims in the right
> > > > directly, but maybe we can shorten the name a little and do somethi=
ng
> > > > like:
> > > >
> > > > iomap_iter_advance_and_update_len
> > > >
> > > > although even that would probably lead a few lines to spill.
> > > > iomap_iter_advance_len would be a shorter, but a little more confus=
ing,
> > > > but still better than __-naming, so maybe it should be fine with a =
good
> > > > kerneldoc comment?
> > > >
> > >
> > > Ack, anything like that is fine with me, even something like
> > > iomap_iter_advance_and_length() with a comment that just points out i=
t
> > > also calls iomap_length().
> > >
> > > Another thought was to have one helper that returns the remaining len=
gth
> > > or error and then a wrapper that translates the return (i.e. return r=
et
> > > >=3D 0 ? 0 : ret). But when I thought more about it seemed like it ju=
st
> > > created confusion.
> > >
> > > Brian
> > >
> >
> > I'm looking at this patch again and wondering if the second helper is
> > all that necessary. I feel like if we're adding it because the caller
> > could be confused/unclear about needing to update their local length
> > variable, then wouldn't they also be confused about having to use
> > iomap_iter_advance_and_length() instead of iomap_iter_advance()? I
> > feel like if they know enough to know that they need to use
> > iomap_iter_advance_and_length() instead of iomap_iter_advance(), then
> > they know enough to update their local length variable themsevles
> > through iomap_length(). imo it seems cleaner / less cluttery to just
> > have iomap_iter_advance(). But I'm happy to add the
> > "iomap_advance_and_length()" helper for v2 if you guys disagree and
> > prefer having a 2nd helper.
> >
>
> Eh fair point. As mentioned at the top I'm not that worried about it,
> just wanted to entertain discussion on a potentially clean way to do
> both (thanks). Sounds more like it's not worth it.
>
> Looking back at the patch again, my only followup comment is for the
> handful of cases where the newly added iomap_length() is clearly the
> tail of a loop, could we instead add the call to the loop iteration
> line? I.e.:
>
>         do {
>                 ...
>                 iomap_iter_advance();
>         while ((length =3D iomap_length(iter)) > 0)
>

This sounds great, I will add this in for v2. Thanks for the review and
discussion on this.


> With that tweak I'm good with it:
>
> Reviewed-by: Brian Foster <bfoster@redhat.com>
>
> Brian
>
> >
> > Thanks,
> > Joanne
> >
>

