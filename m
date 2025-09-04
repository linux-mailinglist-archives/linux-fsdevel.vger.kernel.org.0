Return-Path: <linux-fsdevel+bounces-60280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADF7B44031
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 17:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9B487B955D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 15:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5C9312800;
	Thu,  4 Sep 2025 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="qPS6/+oU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9308F311C39
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998756; cv=none; b=UXw5iAOw/G7JIom57z0QvWx44jmm2xgRbpJ67HMexIbbmSPq4SZSrrOXJTBLzy1aYnqO8EzzlyjwbJQptOe+beHvfzabN7ZCErvQn/EaE/ndgcrWJwOyZ/y+2vv1fvf1hFtYpNxetHt37xKklKhlxSJkaUr6WqIQo+2XMflGxX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998756; c=relaxed/simple;
	bh=aIikodAWNvOPuawsDRH+xHUIshm6ytHMJPcjPbVbcAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KSaO94qnFxnCKoaT/1t5hpichLDueCz//6myiO+1Nb6hEpCpYxICSv2zQQ7VzrVaoijIc2JrBt44mViXSB2Ow8wcV5bGCg3oKRSOrSHZRcxI6TIMdYnhGaEmNj0dkmkwJgoY9MRglqTkhYhmfzqGM2IrdluvuQNA+ju6oRTeuh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=qPS6/+oU; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b34a3a6f64so9669951cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Sep 2025 08:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756998753; x=1757603553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x2bseHOEBBpGAfAnc9SJg8Haxdiy2CnaUt+NMaQGK5o=;
        b=qPS6/+oUwtYxPhddKOTTWnn+0stngF+iEzMWAoFELKJeparcWb1DWaT+6x3cWG6cD+
         wTrLHxFxQ8KU0ZTHsVR0GyCMYr6y+cgyjb4vOCgN8pB/YdGsrplDeE6NhsIqlZt9kGhA
         fwcxnsvyM219+ouGLAUP0AIReZ6wzYrIU/cuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756998753; x=1757603553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2bseHOEBBpGAfAnc9SJg8Haxdiy2CnaUt+NMaQGK5o=;
        b=s2ytbIzpKiUE2L0dcsa74btK5mCJdWnX42D0x8gIpghZ1GWEUsfkhGuiK6fYwobgXY
         KCVNLqYFt89FcGiBa5Z2+Vdli074bgBzLs8IPH9WjoCwnFogya0xTsTAR57VxEiAnHaN
         i5Pb8SoErNk6YASVORQIQaOIabfidHE79mAJs6e5w9ryDtHCuKsAZf++peQMnrh/YMJD
         /NSgXeLxT45C61/Yn5U/aAzt7GGO2jKkwNYi6VBu37DRjUUgcD+JIZNUX4ZUVribQ2ud
         ecxWMM+mGyUDaWgWD9CxsOZqiA0nRkyzU6+AY+9OxPIPFB4nQf2Tm6mXnLR0s/za80dh
         Dr5A==
X-Forwarded-Encrypted: i=1; AJvYcCUB6CwfT61nETKgRmWp2rSXQ9WfAtPSEIPnGMJ1t12MZXuHwrm8PI8V6GLW3muyZNKs2QNTfM9z5n6uflVs@vger.kernel.org
X-Gm-Message-State: AOJu0YxKb9xCh68Yl+nGmlXUPc62QgK8/sz89QTR2QQ33u3SpQwlcqMh
	MSCATlGyp/hmBL5QI8lFMuKh/WscaRycPrfE70HITfrbZW9r/C9cPIYsOk9QuXNH7Vcsr4ELYiD
	ibOxY9I4qnNgfqk7ujLC9v8RIoSxpdIRHWQMfP6YiQg==
X-Gm-Gg: ASbGncvaolYFcC5UZ5stmNAbRja8khGOcKT23zzNiyNKFTubiKeowgKizLXIvTBkzF8
	jArwDuJ/1u/WHyAyH8xFBowj8znSMX5LnTDioIu/roapP62abc57zX6gj87NwDeAt7dtDAcsI4B
	vOPmRO+9s/2uKSvKAVwECSnGPklNfiPs21n+yMYAl+IPGicLIVe6P+abSQNUKhhQUiF+NhQul+U
	FKVkgw8DTa7pvCsShABO6T1L+XIKspYkME0pHHXKdDbu/YpNs8S
X-Google-Smtp-Source: AGHT+IGYoiUq9hLqdDhzQXAPvGDwZgTV3OTOBEHfhfMZ5TfTMnC+BZzwi6grw50t1TVvEnrlpUut5Ji/maPGx4WqxCY=
X-Received: by 2002:a05:622a:5e0d:b0:4b4:8f03:9c43 with SMTP id
 d75a77b69052e-4b48f039e59mr48948401cf.29.1756998753246; Thu, 04 Sep 2025
 08:12:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828162951.60437-1-luis@igalia.com> <20250828162951.60437-2-luis@igalia.com>
 <CAJfpegtfeCJgzSLOYABTaZ7Hec6JDMHpQtxDzg61jAPJcRZQZA@mail.gmail.com> <87y0qul3mb.fsf@wotan.olymp>
In-Reply-To: <87y0qul3mb.fsf@wotan.olymp>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Sep 2025 17:12:21 +0200
X-Gm-Features: Ac12FXx8qpQZ9xst0OSDZqziPMoq9ZJx5kTOnXlgc4SkVe1D4F_OHpOoeKH4bk0
Message-ID: <CAJfpeguPytg1b4k3jRuCHzXMUbwh6AT3Q4rptnVoRrHOA0PHMA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 1/2] fuse: new work queue to periodically
 invalidate expired dentries
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Laura Promberger <laura.promberger@cern.ch>, 
	Dave Chinner <david@fromorbit.com>, Matt Harvey <mharvey@jumptrading.com>, 
	linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Sept 2025 at 16:00, Luis Henriques <luis@igalia.com> wrote:
>
> Hi Miklos,
>
> On Thu, Sep 04 2025, Miklos Szeredi wrote:
>
> > On Thu, 28 Aug 2025 at 18:30, Luis Henriques <luis@igalia.com> wrote:

> >> +       if (!inval_wq && RB_EMPTY_NODE(&fd->node))
> >> +               return;
> >
> > inval_wq can change to zero, which shouldn't prevent removing from the rbtree.
>
> Maybe I didn't understood your comment, but isn't that what's happening
> here?  If the 'fd' is in a tree, it will be removed, independently of the
> 'inval_wq' value.

I somehow thought it was || not &&.

But I still don't see the point.  The only caller already checked
RB_EMPTY_NODE, so that is false. No race possible since it's called
form the destruction of the dentry, and so this expression is
guaranteed to evaluate to false.

> (By the way, I considered using mutexes here instead.  Do you have any
> thoughts on this?)

Use mutex where protected code might sleep, spin lock otherwise.

>
> What I don't understand in your comment is where you suggest these helpers
> could be in a higher level.  Could you elaborate on what exactly you have
> in mind?

E.g.

void d_dispose_if_unused(struct dentry *dentry, struct list_head *dispose)
{
        spin_lock(&dentry->d_lock);
        if (!dentry->d_lockref.count)
                to_shrink_list(dentry, dispose);
        spin_unlock(&dentry->d_lock);
}

Which is in fact taken from d_prune_aliases(), which could be modified
to use this helper.

Thanks,
Miklos

