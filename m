Return-Path: <linux-fsdevel+bounces-33956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C789C0ED3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 20:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668AF2829E3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 19:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C896B216447;
	Thu,  7 Nov 2024 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l37VaeFo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2008198A34
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 19:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731007340; cv=none; b=cvmdYMOXIWnvtKypqREodvxOEIiorgE96gurUScV+kMz7rdWRTE66DQ3PxbX1ALO3g3J/kZdUvh6kYEeoQ53w7Ga4ZcVnXP7R7n8OOfM3/ezfD5jWE7oJ7HRGEbl2bmXnJ4ptA/wSQK4R2HWMLTsiADRkOmd+2pj08A65jV/xVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731007340; c=relaxed/simple;
	bh=sXtWj2Y3HTqxYu02uYplYXiEJZhj8vw1KblKSZrUwXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBkvknTKItEc8TpfsaXXT8FT+S4VMA3i3JXB9JaSQqI/aD4jt97leelwikEczwbnr8v7NRMZvr7jgSIAG4mjEdrIfZ998y/Fe7UZr70nMZogIpdbr4JgMIYUNdHhaS61q1eqlHW8cJqHBsac1VCwHPjmaMhQmuXDLLG1mer4BEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l37VaeFo; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-46089a6849bso8548741cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Nov 2024 11:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731007338; x=1731612138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJ038givlOHAxZsUZqaQFQHlOuEAMqS/zK8h1yi+Z+w=;
        b=l37VaeFoypGGU14Dgn2XyHxqRMyW9Am19S87e9X1vfeVowAzVd9V2kNAJdmrHh0ysn
         DhHGgAGpBzTUbvcSqa5y+5i3HnsiqLum9spZF08uWJ0TuZe7/mZpnTvR6oYHicRdceJ2
         qwPzP/n4ieDW5Pwm2QGEIrYugSggqD6J1xErdsiQ4mVFiHK7sxaZCqVDpeQyhXSsxKo1
         DA0snyI4pKPEoC8eg1vF629fLqPchUxN5q9gDgtJv+D2iZFP7Ygq03DnJCyPEditRQHW
         oBni6muZREFUIAGDZ8Yr0kMb7bG/GBYVBZeHmXCvGoT2hgZbzHUiu2DJ+r7KRolysd6G
         HKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731007338; x=1731612138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJ038givlOHAxZsUZqaQFQHlOuEAMqS/zK8h1yi+Z+w=;
        b=mIijh08SifXgikxLyp+KqA/1jIVxKFmC6SAsWoMgp4uctPBw5OlR0pXdzS0q2sC0b7
         AazLbej3/ef4xE/jLHX4dhkXHSqw80uM7pkc3OEM1swfqrcRk6qz4ddQbwsTv77bMB38
         HFfZ3q/isXFtB2nTq1F1kDirQXzl2dMMX1M7I8tqHiiIO9I1M9PfrATS7Hvl3yTd8T5Q
         fTv0PB2FpmD7pTp0ahFRnyXLwqBT+cDHKKgrgWkc0TEG1KrQpQBWbOnpnQJK14wl09BV
         aJihAocLU0A7Jma/k1o/tntb4P0zm42MR4U2MFy2aadyg4VkgjaDeKfzbn8BLYMWY6Wk
         BNCg==
X-Forwarded-Encrypted: i=1; AJvYcCVD0A5neJ9mBuGLbBe3gf6oov52gWspuNIuVIXuOKkC6crGOXPLbyx2qo2WLYPxWXNPwY/0kQ5Hcts9dT5V@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9YnB9oy8kYYmemazcx7z5FsmYg4+oP2xX/klyIw8Bj+6oy0Tf
	pGFWCE60gruF2eXpSojeCgziQ/Oo4FrUre5rWqNFGKuPBXb599BJE0AY+V5fpsWzcYppX3hvRik
	GhlK0yN8AXTcFfErxeg1x5Oue4Iw=
X-Google-Smtp-Source: AGHT+IGwTBrz9BP7du+C/LXJjkuaIAOK8rSW9dQ1QAVWYEz8nx8W+iEmOTMrUE1s+u1rZUGO2DefgYEpNRfkSGfdieY=
X-Received: by 2002:a05:622a:558e:b0:456:45c6:2c30 with SMTP id
 d75a77b69052e-463094174fdmr2631861cf.53.1731007337755; Thu, 07 Nov 2024
 11:22:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107191618.2011146-1-joannelkoong@gmail.com> <20241107191618.2011146-6-joannelkoong@gmail.com>
In-Reply-To: <20241107191618.2011146-6-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 7 Nov 2024 11:22:06 -0800
Message-ID: <CAJnrk1YGqrssNGa6hzyd==LmfdJ2-TN86ofrHWi+9HLfDidDfw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mm/migrate: fail MIGRATE_SYNC for folios under
 writeback with AS_WRITEBACK_MAY_BLOCK mappings
To: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org
Cc: shakeel.butt@linux.dev, jefflexu@linux.alibaba.com, josef@toxicpanda.com, 
	linux-mm@kvack.org, bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 11:17=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> For folios with mappings that have the AS_WRITEBACK_MAY_BLOCK flag set
> on it, fail MIGRATE_SYNC mode migration with -EBUSY if the folio is
> currently under writeback. If the AS_WRITEBACK_MAY_BLOCK flag is set on
> the mapping, the writeback may take an indeterminate amount of time to
> complete, so we cannot wait on writeback.

Please ignore this patch (i meant to delete it from my local repo but
forgot before submitting) - it is superseded by
https://lore.kernel.org/linux-fsdevel/20241107191618.2011146-7-joannelkoong=
@gmail.com/T/#u,
which is the same change but has a more correct commit message. The
migration is skipped (see migrate_pages_batch() logic), not failed.


Thanks,
Joanne

>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  mm/migrate.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index df91248755e4..1d038a4202ae 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1260,7 +1260,10 @@ static int migrate_folio_unmap(new_folio_t get_new=
_folio,
>                  */
>                 switch (mode) {
>                 case MIGRATE_SYNC:
> -                       break;
> +                       if (!src->mapping ||
> +                           !mapping_writeback_may_block(src->mapping))
> +                               break;
> +                       fallthrough;
>                 default:
>                         rc =3D -EBUSY;
>                         goto out;
> --
> 2.43.5
>

