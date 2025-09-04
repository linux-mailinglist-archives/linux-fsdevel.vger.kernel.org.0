Return-Path: <linux-fsdevel+bounces-60309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B266DB4497F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 00:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E9D1883464
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 22:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D928D2F5339;
	Thu,  4 Sep 2025 22:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCFuZr1e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97302ED144;
	Thu,  4 Sep 2025 22:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024458; cv=none; b=TRqRRQkIBF2YMUJGaJH6gCy17RnlTYWKaPcc8qNzeRCiBC0go6rU7dl7JTuAyRQE5GWM2IFgOrBRPdLlFpmsgII7GSLfzXbm1mi7dP/gTfW/MmqUwS+Av7pbc7guNlpNritqGwM2o2yK8MhY0OXT8s8ZUKnoQyZ18EuDQVn3kbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024458; c=relaxed/simple;
	bh=nA1NKZlxUBArACz0CYle5VsP35z5Df9kIKNbZgIDcRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JyWNstNrJgpl9cOFZG0zszBqr7rFgxdbGWabUkp8JEiFUT4ghHcO3QubqRoT0eqjxmCgrxhvRFrPaFYr6iTBIOfAKQwqgqRgxTs3YmHcPLA1goAK1QUEzBOl1DMu1fSkn1rH/1rDsMKzzg/6HqSoThHEiDmJ23WNdRp9XwiczVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCFuZr1e; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b2f0660a7bso15073941cf.1;
        Thu, 04 Sep 2025 15:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757024456; x=1757629256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nA1NKZlxUBArACz0CYle5VsP35z5Df9kIKNbZgIDcRk=;
        b=MCFuZr1eA6DJ7HM3z+w9lXt/pwKRjhE/kZXt1XoKw/3L1IoGvlIqFCazOwtcOeIf7u
         EqTqyvhgeGSAirIpmUQ2E4+q+oQCWPxOGTq2M1Bo+6x3HDVq5i6rSOOSCfg4KdJ61sIc
         0Q3BbG4Z04qVQr4Ce1ZL4Zg4VBibU0xTaF3CTyrML+CV6JLo/HrUTq0EdNoZtyJ3BLC7
         wda6zFcqC74O5uv+QGV0Mg/PgBw0f4uDqukb4xQj/ryBKZt3oUguLGKEKFFq8KRIlKiq
         1cNYdkCTyF6t1iIq5XRSaXtdUnFl8GNch8NxwasY3TYfhJRW2KwST+u8vtxPf/eRLL+a
         wmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757024456; x=1757629256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nA1NKZlxUBArACz0CYle5VsP35z5Df9kIKNbZgIDcRk=;
        b=I3GeOv+JQfIMdjJqua46mZvOp27wdoMEoc1WjsZr1JLdiuNKCyIGG6CLKb7ejq8D01
         ZwWUhZVQb5iJfxxuy8PVC1HiYOgCiqC68wNesL1V2PAwVG6iTlFjiWhj6ERtEBRk7qNv
         eoFzwLGWxteu5FOwvkzHuDz2ibYAi6kt70ZQvO59HkULY3JME0kxqLvxgyKqKCiEo1d3
         ptQIVTId8kmskJK1TicvmcYSLgveyNNx8DY1CESX93rfCvwnpwjDtdfpOUkR3CaEJ7xt
         C+fJFyKvu5JyZhne++KMKkScvjbj4Yo1T/qqD6Y85VWZDDQqDP3hjRGJ6nw6VxWM6P8E
         C+nw==
X-Forwarded-Encrypted: i=1; AJvYcCU4qx8qVovxrr0DF9yIAhH5P5GgU7LwfzcZtsQpRD6b3STy3cCNWRJGOCEEQdpo4H7KEOMnUlI1/vxP@vger.kernel.org, AJvYcCVCs8vgZY1AUDBlyTKCzFaGWUjGLKEQdOyKBgzoQLRWXZ5T14o7j850eBcbtIZ1nZTJf1RCCmu6N4z62/DlQg==@vger.kernel.org, AJvYcCXSZ7pbNxbzttbMH07aQpRUA8+NPvHKXnNnWmkyHt9CRQ+6ErqEgZK27Llx24fph6woTbaC/ccs8EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH1VbRlSP0jMGAqaQ/jqgTxIck75yZs0tjicnZLXKCwnGmuL24
	LKiwFELUHsoEPq4u+c0+PPYr1WMtOMLBqwKZhdmAROJSIZ2zuMqn+E8wWE/w4wRKcWhuyACzF5b
	7nQBY8LvrA28TrW0bhxVsNseIQTBAP24=
X-Gm-Gg: ASbGnct64hRFygWMOU6AgGr74kGo8z/AJsFXy7LUERflXlVD8MX3irxTeoK9m4d261n
	Bqw7EhRJmVGwFLodmlJaLD8yFZfupa0awxemcujPrnfxxk2MRlKXYd7IVVB7XBzw8Fk+lFcpcBw
	PKhyKBDZ5w1rlbnP/uL3K+5RqcUzVZd7xeCC6UT2sWQvChnkqIO5Q61gRK5uW3vxCA6zsSaOdev
	a2Yn8z0eldNZp7tyYs=
X-Google-Smtp-Source: AGHT+IFRILE+lxoacIPDYmI8ffUNwaHhjm1DV4PUwuma6DPAiBS2JeajXuoATCPWelzGU6HckCWrgR23rIBIOyemMdo=
X-Received: by 2002:a05:622a:4c0e:b0:4b3:19b1:99d4 with SMTP id
 d75a77b69052e-4b31dd773bdmr294126741cf.80.1757024455585; Thu, 04 Sep 2025
 15:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-5-joannelkoong@gmail.com> <20250903203031.GM1587915@frogsfrogsfrogs>
 <aLkskcgl3Z91oIVB@infradead.org>
In-Reply-To: <aLkskcgl3Z91oIVB@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Sep 2025 15:20:44 -0700
X-Gm-Features: Ac12FXwcaYEebJN1KKqhY99UqwDS8PM_1fcFR0E200UBuemuEUfc6ODz_aC9U2w
Message-ID: <CAJnrk1aaHYQLsEtWkoqL-ehGDvpajc53GoHnLjmf=nB7aXQ=YQ@mail.gmail.com>
Subject: Re: [PATCH v1 04/16] iomap: use iomap_iter->private for stashing
 read/readahead bio
To: Christoph Hellwig <hch@infradead.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 11:07=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Wed, Sep 03, 2025 at 01:30:31PM -0700, Darrick J. Wong wrote:
> > On Fri, Aug 29, 2025 at 04:56:15PM -0700, Joanne Koong wrote:
> > > Use the iomap_iter->private field for stashing any read/readahead bio=
s
> > > instead of defining the bio as part of the iomap_readpage_ctx struct.
> > > This makes the read/readahead interface more generic. Some filesystem=
s
> > > that will be using iomap for read/readahead may not have CONFIG_BLOCK
> > > set.
> >
> > Sorry, but I don't like abusing iomap_iter::private because (a) it's a
> > void pointer which means shenanigans; and (b) private exists to store
> > some private data for an iomap caller, not iomap itself.

Fair enough. For callers that provide custom read handling, their
equivalent of "bios" is stored in iter->private, so i was thinking it
would be nice symmetry to have the two match, but I get your point.

>
> I don't think we can do without the void pointer for a generic
> lower library, but I fully agree on not using iomap_iter::private.
> We'll need that for something caller provided sooner or later.
>
> The right way ahead is to have a void pointer for the I/O-type specific
> context in iomap_readpage_ctx, and then hopefully reasonable type safe
> wrappers around it.
>
Do we need a void pointer for this in iomap_readpage_ctx if the only
user of it is bios? For callers who do custom read handling, their
pointer is stashed in iter->private where the whole iter then gets
passed to ->read_folio_range(iter, ...). It seems like maybe we should
just do

#ifdef CONFIG_BLOCK
struct bio *bio;
#endif

in that case.

