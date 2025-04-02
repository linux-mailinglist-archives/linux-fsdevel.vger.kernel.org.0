Return-Path: <linux-fsdevel+bounces-45499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 845D8A789AA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 10:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE9318940BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 08:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BB6234963;
	Wed,  2 Apr 2025 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="A5ho/n3g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDDFF4E2
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Apr 2025 08:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743581910; cv=none; b=EeO7ObC20zcecSb6UmmHPBtB1Kr1Wl1WJ5dbdKAn4IWJWRIYzKPr1tEmlQwkRA+vmIik+fKIN6xhjaiCAz/ZMmZViNVjssY57hS/XJD6iC0wyBpt/TC2HPp0K/QGfCte7ZS7okPCTcyB+gJluniayVj2hP1MHVN7rNuvZEui8+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743581910; c=relaxed/simple;
	bh=8e67ubdqmXXBC04FIgzHLvstXdZ6qmZT0OFP6KZR0u0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxHuF150Qtttx4L7DiibU8+jTs1lBo1iqhiEjF7mNVYnm659ufVbRElmCWevjcHSj/cD1Ef6bYstwpo7dThaIb56zWRy59uUDLTMbu5wxuQYgXL0I3fYCkhbl+ABo4PQ7WodcvCRVR60CW1UwAXYqnD6pAKuIlHWACBdWTZynVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=A5ho/n3g; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-477296dce76so57948291cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Apr 2025 01:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1743581906; x=1744186706; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8e67ubdqmXXBC04FIgzHLvstXdZ6qmZT0OFP6KZR0u0=;
        b=A5ho/n3gHd2rV4p7XfzB5VGcOp4GNex9ukg+juOtFE8MifTGOjlOtK3kD0gI6ukfk6
         nuCaVVobh4+IcK4YaDbgDfMLjyCmY3JWFtp2+097z5QUGMWVhShs8dXwaZ0jcW0+F0r1
         FIRlymj/RhypJ6TFwOCSHaXZqBeL0CzzrMvfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743581906; x=1744186706;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8e67ubdqmXXBC04FIgzHLvstXdZ6qmZT0OFP6KZR0u0=;
        b=EJdccBI0Yay5bBAUP4AyvU1fYRhBf1/ps+C26fk2FlsoxySt4nUN+ZLsw0isjh3KEZ
         ASjeyacFd0WbunNytiBTK5KMt8Un0dDKYbm1QI0pdCAx98yV3jAQYsBrWtMp77ZqOfh7
         mG/QFwj0LdIMzi6NEpmmjs1hbmLS1rlCecKW92sERSLhAcw+3TN5R4gs3Zuekhdv6Ils
         oadbXvXQNtqWt5YKkpTI4HD6Gj3F91a7W25Y8CbW3BBRYT6SSJu3MOdbFsDJ7G5HVHu1
         qFQ2FvPF8w8MD4WaY0xHJkqqeGN70LJ+te8aEY3AqxADRYOLB8+rkImoa2r0oJaxsbUV
         Z+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZgaoQ/BaYOXfkJVRtG+LaF/ac4UkO4/TAmybM2enzr2c1I8lOQPgyPzMj6GZsC+dJ6U35zmwPl7wQPfpB@vger.kernel.org
X-Gm-Message-State: AOJu0YyM/cGz1HI+pQGXGOTbwH7YcYRlP+2jHrG2hi/WaDZ4T5f1cf9d
	jU8f1BWYhzKpft9O2uRZbcvjn1W7FRJXL7pDqGqKT+ppjhgFbeJCQ+Z4K7BGDC980Vz4iMfOByD
	6fCHNPMnK+2CCzIlO1XgfEhXrrU8VnR08mSMqNQ==
X-Gm-Gg: ASbGncscYvb9Zwm8W0RYa4LgiCSeQuFe6d44euTimjmBiNK9dzxbQGnFbSmLhB+MN7k
	RTj1dBgBlQmGaHDDRbZtiD6ifK/iDtFR3Ffa7nnP14Y7mbXht8x/8x3EnSLQXFDKfoRQSMq07UH
	L4gpH9n3hXduSEtKfpsqut+yKBaA==
X-Google-Smtp-Source: AGHT+IGGKKwBKL/VRF9cyKMWEhNhYseEiH+wMiAFaohjj/Y3WhTHu7xHwzMyIT9ilqyaBMYQYXa+ng7b4i5Y46INwpc=
X-Received: by 2002:a05:622a:1a95:b0:476:7018:9ae4 with SMTP id
 d75a77b69052e-47909f81afcmr19689571cf.16.1743581906347; Wed, 02 Apr 2025
 01:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314221701.12509-1-jaco@uls.co.za> <20250401142831.25699-1-jaco@uls.co.za>
 <20250401142831.25699-3-jaco@uls.co.za> <CAJfpegtOGWz_r=7dbQiCh2wqjKh59BqzqJ0ruhtYtsYBB+GG2Q@mail.gmail.com>
 <19df312f-06a2-4e71-960a-32bc952b0ed2@uls.co.za> <CAJfpegseKMRLpu3-yS6PeU2aTmh_qKyAvJUWud_SLz1aCHY_tw@mail.gmail.com>
 <3f71532b-4fed-458a-a951-f631155c0107@uls.co.za>
In-Reply-To: <3f71532b-4fed-458a-a951-f631155c0107@uls.co.za>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 2 Apr 2025 10:18:15 +0200
X-Gm-Features: AQ5f1JoWWGW4t6Lowi9LpB5qejIwEk88bDTMV0GNUyEy49v_ytvZJkDPy_jQANE
Message-ID: <CAJfpegtutvpYYzkW91SscwULcLt_xHeqCGLPmUHKAjozPAQQ8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Adjust readdir() buffer to requesting buffer size.
To: Jaco Kroon <jaco@uls.co.za>
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, christophe.jaillet@wanadoo.fr, 
	joannelkoong@gmail.com, rdunlap@infradead.org, trapexit@spawn.link, 
	david.laight.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 09:55, Jaco Kroon <jaco@uls.co.za> wrote:
>
> Hi,
>
> I can definitely build on that, thank you.
>
> What's the advantage of kvmalloc over folio's here, why should it be
> preferred?

It offers the best of both worlds: first tries plain malloc (which
just does a folio alloc internally for size > PAGE_SIZE) and if that
fails, falls back to vmalloc, which should always succeed since it
uses order 0 pages.

This saves the trouble of iterating the folio alloc until it succeeds,
which is both undeterministic and complex, neither of which is
desirable.

Thanks,
Miklos

