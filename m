Return-Path: <linux-fsdevel+bounces-47308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D823CA9BC00
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 02:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF951BA3E57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 00:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFC313AF2;
	Fri, 25 Apr 2025 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MhrR0iNt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50D28C1F
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 00:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745542534; cv=none; b=Vn9Nw2fIdkkaieZ5LGTf+CmO0i3pHXOU7ulm0ehNQN75dzfGsmpx/iHpTru/W/AbcynsmLsLuqlCjea5Uvd+qElgSGNNltR7xDsm1sJX52VODJWaxnw8VXcqnhHtUTwWy6rW1mVu17D71ITopM2HrxCunMwpBKQs3sg11MXmEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745542534; c=relaxed/simple;
	bh=CW1b2OED0G//1ZZFOlC23pwj0ev22AaJzWK9jQsYbbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qTDK6tueaX/DscFJdLhr4mt1lU6bY/UbeDjx+Ws3JFvZcwNKTUiJSVU4e2qZ1Sn2U6KYZsA0AHepIbogyThpopyl/BTiKXmtcZvFwiajrBOGKbmlNF8g68Q40/wUKf17/3U+VYy4OJxQqYnObVjFyH7Yls88Ald9ekBxH0Zphus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MhrR0iNt; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4774611d40bso135721cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 17:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745542531; x=1746147331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CW1b2OED0G//1ZZFOlC23pwj0ev22AaJzWK9jQsYbbs=;
        b=MhrR0iNtGEAYsesXmbPU8YjLSVJnTCcg7gR8mw0tWakpriQ8S0EFwNuiI0aD3dfjan
         sW2LY3iJl3b7p6H2oRUXIBndQxFQMc0o0Slb15RTlbgLH+JxrF7R2fTwmWiX0bnOnQl6
         BFMMIFRTMUiKWcg6Q47M4UhXyw5jVDijmmkglb9KGAZtwVnVc3Z/ztSbdWc6AkpfntNj
         xDZ835N7B9J/+wmVTWpBcxCIhpfes6IQWNdtt/Jz8lNLVYBLKtjJduGBZhJKsEalp/0c
         qLlPKA7DkPeB7FV+0byvdUGqaBkcVDtpNz9Sv/Und3uthoRsUsTt8WRh7Vw7x7Ed0P+q
         P35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745542531; x=1746147331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CW1b2OED0G//1ZZFOlC23pwj0ev22AaJzWK9jQsYbbs=;
        b=u2o0hQnHX9SN8tQ7ZNN6RybMfRzsjY/EubuplYEbw2QcfD5aTZp1LLof9ZvUXTo0rK
         Qx6cE2RKHtdAqnrresYIynBGSDSO7YlfiF11B6KdtnVV7AowNh8WsQYXdatOHSROeP/K
         XkSxBRterIBZDfxUxhhz8FzfdW2EN6T0PFRgHjdNikGKCdGM2bKFBmrnTqJZRnvp1NdD
         UJJFwglw165egUlccZYNFibPgCeeM2Cin6tHS/rGJPuBmSGrFv3gIYSH8HoaMhJMF0N7
         pDCIpnUBWt3Zs3YH5i54nVJ6U3+mmMhXjnl3xZsn+Utl2vpm21LBnpErcD0lWhmY8pyK
         IWIg==
X-Forwarded-Encrypted: i=1; AJvYcCV/d6n0j55wkNRJTD715NcraV0i5HmuZeHZS832dqIo59cY5LyRe72pc4351uONqdryajXNUY5cLewyMlg2@vger.kernel.org
X-Gm-Message-State: AOJu0YzLdK8IyGKNzdnfbqEqYm5eTDn5d/aH78r/phrVYe++RHXVHlqH
	EM2bDj9ygfZLfmUMISDDd8GbXEfaAtDJNRizAxNkWYThdooG+uxSFghmQEBl8rDIhKm346NRQsy
	Mk74LgkSUJ+wdOeg5dIqu6tNUeivgfAh8Nv18
X-Gm-Gg: ASbGncuB2rcFeJAJN70a5Ba6lVYmBBJ9+29ub3ooBv+Mp2EDFW4i7wFIemECLYVnD6r
	5yDXeAOejenCPofK8jCpmi5kCrKIznWu2c4JXheX7yi+9nFoihiuw5n+UgU7YmIvOjedInYrBDK
	+fCF1XlqMRVpNnLcL23l6VMPWGxr/TdJswLd1ZVGNBvR4JtYcsaPek
X-Google-Smtp-Source: AGHT+IGUMVaUGZkihZUOPiW8Abitj36Ep1RYrzE/SYCPukIhW/QWeJw/+4Je82RpbdMjH3dJZ+hc3C5ScUV0Jb2DDrU=
X-Received: by 2002:ac8:6f10:0:b0:477:7644:b738 with SMTP id
 d75a77b69052e-4800cb867ffmr954941cf.17.1745542531439; Thu, 24 Apr 2025
 17:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <e7b4c979ec056ddc3a8ef909d41cc45148d1056f.1745528282.git.lorenzo.stoakes@oracle.com>
 <57e543a2-4c5a-445e-a3ab-affbea337d93@redhat.com>
In-Reply-To: <57e543a2-4c5a-445e-a3ab-affbea337d93@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 24 Apr 2025 17:55:20 -0700
X-Gm-Features: ATxdqUG1BVTg3OizTv06IUR2zSLFUz1in85-BLHN6Z2oKaR-BCqnQENZzZmcljw
Message-ID: <CAJuCfpGx0UTXcFYE2Fw2Xaw83QGTVhWVOx6zt-TSgZWHVAYHCA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm: abstract initial stack setup to mm subsystem
To: David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 2:30=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 24.04.25 23:15, Lorenzo Stoakes wrote:
> > There are peculiarities within the kernel where what is very clearly mm
> > code is performed elsewhere arbitrarily.
> >
> > This violates separation of concerns and makes it harder to refactor co=
de
> > to make changes to how fundamental initialisation and operation of mm l=
ogic
> > is performed.
> >
> > One such case is the creation of the VMA containing the initial stack u=
pon
> > execve()'ing a new process. This is currently performed in __bprm_mm_in=
it()
> > in fs/exec.c.
> >
> > Abstract this operation to create_init_stack_vma(). This allows us to l=
imit
> > use of vma allocation and free code to fork and mm only.
> >
> > We previously did the same for the step at which we relocate the initia=
l
> > stack VMA downwards via relocate_vma_down(), now we move the initial VM=
A
> > establishment too.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> ...
>
> > +/*
> > + * Establish the stack VMA in an execve'd process, located temporarily=
 at the
> > + * maximum stack address provided by the architecture.
> > + *
> > + * We later relocate this downwards in relocate_vma_down().
> > + *
> > + * This function is almost certainly NOT what you want for anything ot=
her than
> > + * early executable initialisation.
> > + *
> > + * On success, returns 0 and sets *vmap to the stack VMA and *top_mem_=
p to the
> > + * maximum addressable location in the stack (that is capable of stori=
ng a
> > + * system word of data).
> > + *
> > + * on failure, returns an error code.

nit: s/on/On
You could also skip this sentence altogether since it's kinda obvious
but up to you.

> > + */
>
> I was about to say, if you already write that much documentation, why
> not turn it into kerneldoc? :) But this function is clearly not intended
> to have more than one caller, so ... :)
>
> Acked-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

>
> --
> Cheers,
>
> David / dhildenb
>

