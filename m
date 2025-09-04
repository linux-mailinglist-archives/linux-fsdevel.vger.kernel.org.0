Return-Path: <linux-fsdevel+bounces-60310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F004B449C4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 00:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76EB3B9A78
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 22:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163DE2ECD31;
	Thu,  4 Sep 2025 22:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHMsk7JD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA552E7BD0;
	Thu,  4 Sep 2025 22:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757025448; cv=none; b=CHIvLsrSDhZ0p53RgYWq2pGgwJnY9p33MnHibkJhH0hFZcsbNe54SQhvmmAF/KIpOSXoo5/9Ly51+oiM8TTjQrQufhiKdj/iPzWzMzsd1WsbH7E6VfmH81SZse+HT4MFJaRzLZCdBGyTfbi3O6hGfKu5VsfZX/FnHwajhodYmF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757025448; c=relaxed/simple;
	bh=KS6ybUFP2zT1rNo0psCnqOfSq5tBTqo4RoFbLGz8YbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qr4ids15q7TMOPeiGRA8Fp8pMsaVkKZd5Xnh/fsFnr4BzYBYjkhoMkVHeG+vIt2SqkfUDhISThnUgqs/3yndHuQe8nn6GlDJ8f70W+tJGbhSzVIGj9XF5jHm/u3pOuNeAGSe8nQdWsFxQsP0ExEzd8mWfJdKIdARL64wnfBZuV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHMsk7JD; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7f74b42ec59so109448385a.2;
        Thu, 04 Sep 2025 15:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757025446; x=1757630246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENredkVBHq+HIC0FqubCmT4j8IWtRga5pVT2hkbdze4=;
        b=bHMsk7JD9ijF/wY+Bjioirb3FJzD1wKO69azvNlHdsfsDs2KxkOTUMoZqJLKzi+8rM
         DTcve0evq2RoaWAsst4MUUF5oJCBYth48d2j8QtwQyqAD6/B9nsAOYeOQ6D5AjmM1TZu
         bAYbIFZBYgftkjaYxm/eG8FEy6CCb2Kd/W28c5PQXw7+4O8bajhVgu6jvclw8Ju1JVi1
         mNfTCIu6FsnP8yO/rXSGz5RTPe4JdPgCNIjs1GqsLEwivJIYO7uQzmrcAo1msJ5xIZUl
         VUFOUgmkHc2M9Ziwcb8wLMIToARvPgsIygCahaFPk/O3705ww+SwzevfuH0EQ9hFejFk
         803Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757025446; x=1757630246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ENredkVBHq+HIC0FqubCmT4j8IWtRga5pVT2hkbdze4=;
        b=XqDZ5wD33t4J+FJpbSfTNjh1k15mOBe5LLNU9AiqN1ADKPbA9K9Fy0iebcVQp4BnqF
         Jk8om7e/QcJeccsbD6dMJ2UZRAo9hyVvD+PdiEPdylnkx0Vh0VkTk8MMP17rswTVYGKW
         ivJyEyIdsG32RW+EByHf5ahv3emIEZNcJ4bNdJ+Na+NE6Ait3Mc7A0KhjkJEmSPsPTMz
         Kbp+FTeOB1m+anv0AX+skjccufeCCteX1754i4nV8k0I5o61/mA9W3zU0WeppCy8qqwf
         bXH5f556m4+xffEPTBYl2eQUxAhth8aaRTsWSvThIKE3oFfKlKgCJTA24v6bZR51PBK4
         uPfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2hkOY3svjL7OKO5OUmcSDChiFxTQazPazisXIUghEq+B3n9M9mQRMDsnP2wbBDVOFCh3C+Sz5HdwW@vger.kernel.org, AJvYcCWYGvmFoupFUrNBs2jTYGMC0uZHrpXD+jFxXvFGNi79l5xNMydOH95BGieA73+Ev6iHA6nBuFRIJG0=@vger.kernel.org, AJvYcCXom/XKdVEKOqhvmWCKzsc/le6kjoc6EOoJ7f3h5Bnvm9d0C/HxAQ2Hzbu8YVCcWZ8sSY+g19JPPCxHIWpQHg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq1lq950bV1Ctz3XaRDC8dw3EGVnkj0l+7VUNaCQ64uyFYKFXI
	zbnRvSZDhp9VYdv3ZnpfH2NrknZlhyCZ/3BErRHQLfb43eCzSBA11lZtJWo4O7iPCSSaG/taksP
	7jVH5HpsPsZG+TD+dl/tFv2Ezcixom3xKe9T7
X-Gm-Gg: ASbGnctei9vkcHOxttJNHx+uGXdsLtzN9RbhDqbtBcNQfD0g8JDXiBDEsztTv7opyvQ
	fTa8ailbYzgdyK+C47Q5tlaKgBTHujaMiI0M9ifW0IKSCZG+9jOIRC0QzLW7hfGRHHXr6FJR7sE
	Kg3ckipDl/VBBZZkBPzuvx9NN8IeIVBDrpxDR+cbqU6IErKtdU4A3yiSlLWlulAfxuH0405eZ6D
	CcY1CmNk2Nx3dUup/k3lQT+rN0rFA==
X-Google-Smtp-Source: AGHT+IHa17UJupNJpBu9ASnoZxOjvfn2hJOE/hai9RaRhYpfudzrWc2UOMYj72MpURHTT2yBznSD67n6l2wjLmxqlhM=
X-Received: by 2002:a05:620a:8016:b0:7ff:e252:eea with SMTP id
 af79cd13be357-7ffe25210b3mr2000625385a.12.1757025445797; Thu, 04 Sep 2025
 15:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-8-joannelkoong@gmail.com> <20250903204348.GO1587915@frogsfrogsfrogs>
In-Reply-To: <20250903204348.GO1587915@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 4 Sep 2025 15:37:14 -0700
X-Gm-Features: Ac12FXwr89U1pwDcWfNipI31ANIDRdOQN7H6eJUlVBEpLnBbzfpmXxJGY920K8A
Message-ID: <CAJnrk1Y2zZj0uYHyXwue3KdOKa1TDxbiS0hJuoDCQSMxkjPFQQ@mail.gmail.com>
Subject: Re: [PATCH v1 07/16] iomap: iterate through entire folio in iomap_readpage_iter()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 1:43=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Fri, Aug 29, 2025 at 04:56:18PM -0700, Joanne Koong wrote:
> > Iterate through the entire folio in iomap_readpage_iter() in one go
> > instead of in pieces. This will be needed for supporting user-provided
> > async read folio callbacks (not yet added). This additionally makes the
> > iomap_readahead_iter() logic simpler to follow.
>
> This might be a good time to change the name since you're not otherwise
> changing the function declaration, and there ought to be /some/
> indication that the behavior isn't the same anymore.
>

Actually, I was thinking "iomap_readpage_iter" makes even more sense
for this function now as a name lol. Before it was not really
iterating over anything, it just handled one particular range, but now
it's actually iterating over a folio for all its ranges.

I'm happy to change this though. But I'm not sure if there's a better
name, iomap_read_folio() is already taken.


Thanks,
Joanne

> Otherwise, this looks correct to me.
>
> --D
>
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/iomap/buffered-io.c | 76 ++++++++++++++++++------------------------
> >  1 file changed, 33 insertions(+), 43 deletions(-)
> >

