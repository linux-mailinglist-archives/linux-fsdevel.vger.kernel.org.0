Return-Path: <linux-fsdevel+bounces-15532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EAB89032C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 16:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFF6BB21C28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A6B12F37B;
	Thu, 28 Mar 2024 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dKqPugnu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADA11EEFC
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711640206; cv=none; b=gGAmj/TSS4/xrIQoHhMygHcz8FS859iLFpub7B174K8dWa46SJGP6KIe7OEiN8A+PvTV5G5Jyijw7TWQPJa0S1HA5GUUNED9Cnaa6fCdog61BaUBpHvw0I7Dh9zO9hmhwl6B3ta18qR10U5z0khuIP4Vsu/5djkGPA6z2M0rCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711640206; c=relaxed/simple;
	bh=jNozf9uaUn62BQc5Mx2KoSKHOm3OswtOuVbxNmfLA24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmXPlLx4MQHi7iKp1RwoizeuNohnKCSDz8SytDIIWGeFXrMo8VpUAf3G56OVhq1Xi+JPkCUUV1W4biWpm1vgXzdspMBEEkt9jeUhO2wG4lnPGwTTRNK55VPkSDTt2zdgd93CO6JtboPxrt01CA0s2wgTMEJGrgbKluhtER79xJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dKqPugnu; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c3d404225dso607194b6e.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 08:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711640204; x=1712245004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNozf9uaUn62BQc5Mx2KoSKHOm3OswtOuVbxNmfLA24=;
        b=dKqPugnu2+1wldtXaYzsPlBJm0lvWnfQzVxXZOTS/u0jIB+xPfG8EqTvaUiWhNdaCp
         dpcYX54Xbj9uxgaeIEczrEMepIV/jzs6cw8VxAn/BdX8WD0mSGRXJ3+b8qCcgcfIh0t3
         KilbDFcZQjUAHRlsCOcJKbT9CutFLe/DdXhac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711640204; x=1712245004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jNozf9uaUn62BQc5Mx2KoSKHOm3OswtOuVbxNmfLA24=;
        b=kAr6DPJ+gQk+yzwkVnw/zozg34AdyfKeOOaA2dxfw47RrBEDbaH28I+usFNPWdJg0C
         4m/V3M1ev0CVPYZwTAe3QzWqYs3FavR3jlGfloRxBmnOZQYg3zQFUwsJxEX3xnpYTqQm
         ofVDy0GGKVhVB6M29V8ZjZBaAEpb2Zg30Jd3sP/Jb5atSTo4s0kvMJ4NrrZBxNaGuQyp
         yLj8T1TVcCSJcOZqwJNGyCYzCZL+u6KTxE0XNY0UFFnrCd0onuLBh7iMJqlLoQ4cCbFT
         5lRMG0Jbv+fWL1uHix+Ocn+CQ3YuuAhlXhWYPzYSBlc93NZoBSni9L/1KpI8o9L2wSX3
         xZKw==
X-Forwarded-Encrypted: i=1; AJvYcCXCuPmznfNznRBHk3ItbGiKde0/qXKwCQATxi9xFAFOSYoR8iqDbJZY5kJtW61Wi9J5VPO3ZHBl9wiRO2nnnfLQghuipJpITOxHnTddbQ==
X-Gm-Message-State: AOJu0YxomKnW9WJSWt6rWEli+uk1u7NDJCo+BkgggxLSTXfpDKKLh6P6
	9pRSJ78BIL+zwQU/8u/aCKSWNY5c+SVVitNKeM85HgHL/Bny6xVbzY6zhWL+3NUKPqPFWRe+z1U
	=
X-Google-Smtp-Source: AGHT+IFFMWO3THmA55KCP3BDVT2N9JCXIwiYRe+Y1hiImw6zvgJMCUfzL+jFHwbZh2m3b1q64L+qxg==
X-Received: by 2002:a05:6808:bc9:b0:3c3:80e4:94fb with SMTP id o9-20020a0568080bc900b003c380e494fbmr3288459oik.37.1711640204093;
        Thu, 28 Mar 2024 08:36:44 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id p11-20020a05621421eb00b0069878a4abe0sm410192qvj.79.2024.03.28.08.36.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 08:36:43 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-428405a0205so381741cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 08:36:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWAfa/sP4F76xDhsUouUJiGQ27nilFiu4irGflfYw+2/AOvVFdCJGd15a/49kLZgX8BzOYHtvT/0q8umww/WSZmkN8/mRVzT2I5TbpUhw==
X-Received: by 2002:a05:622a:5a0d:b0:431:74f8:8ae6 with SMTP id
 fy13-20020a05622a5a0d00b0043174f88ae6mr287854qtb.19.1711640203361; Thu, 28
 Mar 2024 08:36:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205092626.v2.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <CAD=FV=WgGuJLBWmXBOU5oHMvWP2M1cSMS201K8HpyXSYiBPJXQ@mail.gmail.com>
 <CAD=FV=U82H41q3sKxZK_i1ffaQuqwFo98MLiPhSo=mY8SWLJcA@mail.gmail.com> <ZgWNtmcyZOMZR1Fi@arm.com>
In-Reply-To: <ZgWNtmcyZOMZR1Fi@arm.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 28 Mar 2024 08:36:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WaiQSbCnKz8t9VFt74vVXhOCX+L=abFn-QOV9OeQx5Aw@mail.gmail.com>
Message-ID: <CAD=FV=WaiQSbCnKz8t9VFt74vVXhOCX+L=abFn-QOV9OeQx5Aw@mail.gmail.com>
Subject: Re: [PATCH v2] regset: use kvzalloc() for regset_get_alloc()
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, 
	Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>, Oleg Nesterov <oleg@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, Matthew Wilcox <willy@infradead.org>, 
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 28, 2024 at 8:33=E2=80=AFAM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> > I'm not trying to be a pest here, so if this is on someone's todo list
> > and they'll get to it eventually then feel free to tell me to go away
> > and I'll snooze this for another few months. I just want to make sure
> > it's not forgotten.
> >
> > I've been assuming that someone like Al Viro or Christian Brauner
> > would land this patch eventually and I know Al responded rather
> > quickly to my v1 [2]. I think all of Al's issues were resolved by Mark
> > Brown's patch [1] (which has landed in the arm64 tree) and my updating
> > of the patch description in v2. I see that Al and Christian are
> > flagged as maintainers of "fs/binfmt_elf.c" which is one of the two
> > files I'm touching, so that's mostly why I was assuming they would
> > land it.
> >
> > ...but I realize that perhaps my assumptions are wrong and this needs
> > to go through a different maintainer. In this case (if I'm reading it
> > correctly) Al and Christian are listed because the file is under "fs"
> > even though this isn't _really_ much of a filesystem-related patch.
> > Perhaps this needs to go through something like Andrew Morton's tree
> > since he often picks up patches that have nowhere else to land? If
> > someone else has suggestions, I'm all ears. I'm also happy to repost
> > this patch in case it helps with a maintainer applying it.
>
> FWIW, for this patch:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

> Yeah, normally Al or Christian would take it but with their ack we can
> also take it through the arm64 tree (or Andrew can pick it up through
> the mm tree).

OK, let's see what folks say.


> With Mark's fix, I assume this is no longer urgent, cc stable material,
> but rather something nice in the future to reduce the risk of allocation
> failure on this path.

It's not quite as urgent as before Mark's fix, which gets rid of the
order 7 allocation. ...but an unnecessary order 5 allocation is still
nothing to sneeze at. I'd let others make the decision about whether
to CC stable, but I'll at least advocate backporting it to all the
kernel trees I'm directly involved in.

-Doug

