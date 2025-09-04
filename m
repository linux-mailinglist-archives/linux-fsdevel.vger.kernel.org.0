Return-Path: <linux-fsdevel+bounces-60308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B10B4494D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 00:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0232C189B645
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 22:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710492E7BB6;
	Thu,  4 Sep 2025 22:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hp5TB0PR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B2E2E6CA1;
	Thu,  4 Sep 2025 22:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757023626; cv=none; b=X1lKll+rx5h+yntXOJXx5QPFoAdpeXSNvXaJO1rXp6XTBi2y3hcAPAXDoBXF5IRYGqTT07TV7xydzWKIHVGPIwmbeqsUGDNcq6Btpb41BGkmxXJ/RYUJdl50GYdtjLVh6lo+kZsgBBwWCDLa2IoM5rTuqLN3LLQljctrH5IVv+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757023626; c=relaxed/simple;
	bh=cmUIM7pCpqeBWtzvFhDZqMBwneE4TTCqud36a3HePd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iW2lMzxhIRHt1uUUEMDpHwYEMO1ptAgceMY/eZdW+qIItnQiNWkW4zkmgVX/pPRmldICbNC+gf0CDOQnvUKm3cs95FsMXlsNXYEkVq7i7DU16clKPLSpguxTByVbI6jU/hUfcQwG0Uu+OX1zpTZ9R9vdfJ2IfWQChZYbr0d1ito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hp5TB0PR; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4b30d09da3aso17360141cf.3;
        Thu, 04 Sep 2025 15:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757023624; x=1757628424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qr2i0EDeenwl7qwpZXz/40ibeng6dEMSFVDO7LDo1Zs=;
        b=Hp5TB0PRQwojnu56DBgdwj7MTz78YTj1McaiaNd88mNaHzWjZ33mdlYC6Y3RL3UJ0F
         SdBe/Npj7Zt2ONmFe7uMYF8+pFOPyzG4O/9j6ZhUdv93qpQAPxcLj/uqicIbvIUPc9sy
         qWtMlMJS1XaYffKnNQTcc4P+UJyYIey6QztZ1XbKNMhB6gER7kjWidSkcHcrnw6NaS5j
         SN/uu5+UtX0tYJIosqGMZXs1zSIlwA20lVoJ0DraGHKZF5EXcm2jyXSzdrttOvL+jSKI
         +vdJBmsn6MmIS5qkwC3e/vwqXBLrBywOHba16lNoLvlTwbHBcn+N/l9D1sw3C573Y3Lh
         00Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757023624; x=1757628424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qr2i0EDeenwl7qwpZXz/40ibeng6dEMSFVDO7LDo1Zs=;
        b=diijEv9JzwaEg/RiMtI/wMYf9PlIZKU1gMBt0Ro/7tfUgySKViq24tSL/Bd1IrpB+I
         Ijni06UU70H0DKr/kpAvAL6t8/IuOKfACEuTKOT1/QVd/Ua7jJmdF/ip9OATIwchUuqb
         ca+KJJShlovNvKN/h2AKBa59Kxv1Vb4L3ZtfCGry16Dm17POfRNclbVcJ+FbwRqe0Fjc
         6FeanBO8oR0+C3bvq1BddBsYDk9sJ97P0ALCj+RLCWMnpN/oTogwJcLINnVfqodim0JN
         tqg7W66LYM7JnsXabAW6S4SvSihykinK/j95Wv3t4j0sBdctrmzkg/HRHy5T17UPjm9m
         UJcg==
X-Forwarded-Encrypted: i=1; AJvYcCVImYW5L+NVy0WlFZvwD1WGHQjWBno44zGNp99VWAx9v0SzHSsdFeSmZg4HFcSRqKaH/J6Isaoe09c=@vger.kernel.org, AJvYcCW9IwfADQDXv1ZzKaTQag92E0gqntljmzSQtl1jn0gIU7GEwCAqoMP0JNI48ZVRzx6zS5mT3ERU09WYyxp+/g==@vger.kernel.org, AJvYcCWUWwNssGgjrz/HcUzqFhgBzX4L3Pr4qqfdWbIbJt533fa4GLhokX0MALZUWlip4fezadvP4WC8OI+S@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0se3ZcznrppAwLHbyJMt1uMYvrAzSaaWL+iidRyeDU+t3Eziy
	zHBaNzi0PCTNCs8iBw+MFMlYxGXV+6ZZLJxHxvM0xMau4+LJAzhxm62PdnP3Y8Jt7yWfMzKsyyt
	CfSaoycO9BV8urL9H1Y+36STfRADJvKs=
X-Gm-Gg: ASbGncsZ5O34QXM9j3Vyr4wSeDP5z6aF+WWItbr2tJx2poqJxha+V4UBQTrJRjpln1l
	bgeiYklKz2XjhLW/Yy36AI/gBiIXUbBvENyAwLK6uZd2dmRdB4RyNhiR7y6kKx5FfMt6gvb3zVH
	zRVLzP8m7AvDgYThNcaB7Bgj41wrxvbp1AQ7rvKNkJyzYXXf8Rzs0YtxHmoBt/b90kxlqNQ3O3d
	fO/H3ns/qXgbsVpuvE=
X-Google-Smtp-Source: AGHT+IFBlx3X5hlUFXtvs+ZQUGSgM4SWZgYUjgrw3wrd4qs0EaZ6PcfqLcKq5B359vcWigIg10JbbQnlog5F62FqhFg=
X-Received: by 2002:ac8:7f52:0:b0:4b3:d22:6532 with SMTP id
 d75a77b69052e-4b31dcecfa9mr228908521cf.69.1757023623981; Thu, 04 Sep 2025
 15:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-3-joannelkoong@gmail.com> <20250903202637.GL1587915@frogsfrogsfrogs>
 <aLkryaC0K58_wXRy@infradead.org>
In-Reply-To: <aLkryaC0K58_wXRy@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Sep 2025 15:06:52 -0700
X-Gm-Features: Ac12FXyFfSGKkBz5jFs9eCyI7TffwdIJ-lIvcbly65E9pS4ZMBsyucMvYLwC4R8
Message-ID: <CAJnrk1bkDSwgZ0s9jToEETtu-nvE4FQdG7iPbbH_w+gW1AA2xQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/16] iomap: rename cur_folio_in_bio to folio_unlockedOM
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:03=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Sep 03, 2025 at 01:26:37PM -0700, Darrick J. Wong wrote:
> > On Fri, Aug 29, 2025 at 04:56:13PM -0700, Joanne Koong wrote:
> > > The purpose of struct iomap_readpage_ctx's cur_folio_in_bio is to tra=
ck
> > > if the folio needs to be unlocked or not. Rename this to folio_unlock=
ed
> > > to make the purpose more clear and so that when iomap read/readahead
> > > logic is made generic, the name also makes sense for filesystems that
> > > don't use bios.
> >
> > Hrmmm.  The problem is, "cur_folio_in_bio" captures the meaning that th=
e
> > (locked) folio is attached to the bio, so the bio_io_end function has t=
o
> > unlock the folio.  The readahead context is basically borrowing the
> > folio and cannot unlock the folio itelf.
> >
> > The name folio_unlocked doesn't capture the change in ownership, it jus=
t
> > fixates on the lock state which (imo) is a side effect of the folio loc=
k
> > ownership.
>
> Agreed.  Not sure what a good name is in a world where the folio can be
> in something else than the bio.  Maybe just replace bio with ctx or
> similar? cur_folio_in_ctx?  cur_folio_locked_by_ctx?

I find the ctx naming to be more confusing, the "ctx" imo is too
easily confused with the iomap_readfolio_ctx struct.

What about "cur_folio_owned" or "cur_folio_handled"? Or keeping it as
"cur_folio_unlocked" and adding a comment to explain the change in
ownership?

>
> > > +   bool                    folio_unlocked;
> >
> > Maybe this ought to be called cur_folio_borrowed?
>
> I don't think 'borrow' makes much sense here.  It's not like we're
> borrowing it, we transfer the lock context to the bio (or whatever else
> Joanne is going to use for fuse, I haven't read down to that yet).

