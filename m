Return-Path: <linux-fsdevel+bounces-52644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBC7AE4E5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 22:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9759F1796D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 20:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00953201032;
	Mon, 23 Jun 2025 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d50KseD/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02E91DD0C7;
	Mon, 23 Jun 2025 20:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750712037; cv=none; b=oGID7cpOJg0TCVoZ0TnPD4UPcwM4nVJeSvFUlOg5cr3onCxnzBvAXXLYxNfmMlEaeRkSW4BkVrVaHmJEjJRqJmMfSMIHim8wP/kk+0QT5WHIAy2R41trebEnpQmjtEHImElHXSfjQRR06vgE2QPWqBZ7xyHyFEZfkCiXd/GrEcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750712037; c=relaxed/simple;
	bh=gYR6bgGJD8ae5EJvhXOCUPtyFAnFDbG4ZGcAwnbt89k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgW1axsa9IMyXtkNmqLCsKIj9nvF7zOBrlBFDWr3/MgkYAUoC34MN8vvzemdVk9rlH+kFX/H6JkmVyCSd3h0AgSPQIwQvFMH2MRv/rm6tdziEQCgU7xrVGFGnM9s2FqjV0JOIHkWl6rlv6AIVKi+X7KCpjDY4qemha9+AzX+7D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d50KseD/; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a6f6d52af7so55666711cf.1;
        Mon, 23 Jun 2025 13:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750712035; x=1751316835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UU3r72AzS4cmZLX6fAP/84JxPlnFoiZ3cfMSc6bqNgs=;
        b=d50KseD/riFI8SrW5XZdXMtT/LYZbpsGS9yE/vPK/Rp/sO7p2ey4QXnBlKa2Qptyy0
         iuv9vAYAGWONJRs1OFLsS1epy/BYQAM66p2EZilEiixUYGtwIW83dKgVwmnutcIIFRkD
         5wkmKzcJ4uk87RGWdFMwX506Bp1f+VyniYinlKOmARtCFIwJvi11+/14pgoTGsYTTEMD
         lpqafAWeSZ5gHHVDH1Hwz8lhVAagDfNLORj4bgYXSQ24oGPJEw4QGl0RNBCP4SL83CFK
         S4kXNdvhoBuS/IKi8evAcSfobaL5uuYe6I0f6xxYhfEtga9vv2cOtFtheA97HrFavFWz
         LGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750712035; x=1751316835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UU3r72AzS4cmZLX6fAP/84JxPlnFoiZ3cfMSc6bqNgs=;
        b=TRBYSJETOtfRsiszT72/KTNMPV/SxDv9gv7JthoCatmPPgoqmm4f6nzDxZPr6WZaKF
         6rEq1JlGBXu059k0unh+uw1qaY1Yi7BaIl1TNCYbbo9EXyglSBm5JhONwLAX2fOL1OAb
         UXqbPP+11b6LWWEdqEJJhHnY7CYMPMZUctRlRMQfY76BioJqliTgsO9OIS+QCHSGx4Eo
         X1byhs/2s4HuSWopvfZhl67vCgTK0h6EWz77PFBZvTMJVf2ilCNL5oWzFOHBZWxIC9mf
         qAStZg9T0XmH+uU+oiU04DDcgnKCUpQ0PYNaguWxgKSEyWyXlGTcvZ29cOuD1iIFkHz1
         WjPg==
X-Forwarded-Encrypted: i=1; AJvYcCXWRiBijJt28LB69TTjN6Ofh1NhzEdEg/bGVYLxw2LfbwqBXBFTHNjDHazpQiqtMlknUEO41RprhwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9U9qjZyGP4y5+mS6SDVYV5uQem24pnEHGbmZqm16xzBGfqw+j
	lqfSb9akdu/45VJqFjxT7ZVLybcMlRNCWa2QmB1HqkEQKEZt0LV10DoCUoR5RbYxns52uJh0tGX
	pUFjEMvpO+o4/n4dhS/XImIzXi7sB13A=
X-Gm-Gg: ASbGncs6MiIHwlEh8VVy0YQnc3N14Rl0O8ZHqNrtj6rg1gdGtPqfvph8UNQfSMnptzr
	BbddU0mSGOfmTlJj9aMkJPpg/xJTZYuvDODsqlA6LlXwi/fPTzD8i6w/ytqZR2BCWt6G7rtkBdL
	K+vOjUNJU5VoXLucRUpkkLrayEueK+2+vFqM8B23f6J0g=
X-Google-Smtp-Source: AGHT+IEDAvrUy2dMGyo2HVEkMaO8HOf/RKRBYKfkRynSetG8rgX1Cw1TnAkDcW1MgWFxJzzMpwWu8gYmVO38hl6fhOQ=
X-Received: by 2002:a05:622a:18aa:b0:494:ac2d:dc11 with SMTP id
 d75a77b69052e-4a77a232efdmr226043571cf.27.1750712034825; Mon, 23 Jun 2025
 13:53:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613214642.2903225-1-joannelkoong@gmail.com>
 <20250613214642.2903225-5-joannelkoong@gmail.com> <aFAS9SMi1GkqFVg2@infradead.org>
 <CAJnrk1ZCeeVumEaMy+kxqqwn3n1gtSBjtCGUrT1nctjnJaKkZA@mail.gmail.com>
 <aFDxNWQtInriqLU8@infradead.org> <CAJnrk1ZrgXL2=7t2rCdAmBz0nNcRT0q7nBUtOUDfz2+CwCWb-A@mail.gmail.com>
 <aFJEXZgiGuszZfh6@infradead.org> <CAJnrk1aCo308fxgzYRnei1A29qskvMtiWNS50BJNwiyrQ2A_oA@mail.gmail.com>
 <aFkFYkleaEc9HxSr@infradead.org>
In-Reply-To: <aFkFYkleaEc9HxSr@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 23 Jun 2025 13:53:44 -0700
X-Gm-Features: AX0GCFsTKM917XJ-5a_TB4fqqWe07D5IKvPgA2_2q6l7HaPMJGkTL5dQEOWZFYY
Message-ID: <CAJnrk1YVoDrFL2Tb8o6QGJrXBuVtfVO2Z78X6z0Fv1LG3PbT-Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] iomap: add wrapper function iomap_bio_readpage()
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, djwong@kernel.org, anuj1072538@gmail.com, 
	miklos@szeredi.hu, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 12:42=E2=80=AFAM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Wed, Jun 18, 2025 at 12:17:14PM -0700, Joanne Koong wrote:
> > > Sure.  What I mean is that I want to do this last before getting the
> > > series ready to merge.  I.e. don't bother with until we have somethin=
g
> > > we're all fine with on a conceptual level.
> >
> > I'm pausing this patchset until yours lands and then I was planning to
> > rebase this (the CONFIG_BLOCK and fuse specifics) on top of yours. Not
> > sure if that's what you mean or not, but yes, happy to go with
> > whatever you think works best.
>
> It's not going to land without a user..
>
> At some point we'll need to fuse side of this to go ahead.  I'm happy
> to either hand control of the series to you, or work with you on a
> common tree to make that happen.

I will send v3 today with:

Patches 1 to 11: the patches in your patchset in [1]
Patches 12 to 15: the fuse patches in this patchset  (14/16, 15/16, and 16/=
16)

and temporarily drop the CONFIG_BLOCK patches until the series is
ready to merge.

[1] https://lore.kernel.org/linux-fsdevel/20250617105514.3393938-1-hch@lst.=
de/

