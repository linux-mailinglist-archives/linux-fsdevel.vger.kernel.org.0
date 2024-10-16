Return-Path: <linux-fsdevel+bounces-32133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729D59A11C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 20:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C4C1F2558C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 18:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A15215F6E;
	Wed, 16 Oct 2024 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="HKpR4n40"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6A32139A1
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 18:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729103850; cv=none; b=IyZP3kCEGdQz6IYJPhTRCkJgNU4jXKoFCc5PEJ4T/87C47yr/Xd14BHJccO+FOd2k/TGY3RdnQ3FNxD+xkQ2R7W0i8IMcBi5tgDjB7aPaSD7bcwOvdJqpmwHf3eY/cTr2c/K2PjTInzmIBATWezC3NWIxFDNcpLZHva5BNnxJvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729103850; c=relaxed/simple;
	bh=A+zoGd3A1ihf3hMrUd12ks0TZoTO8QuN8wik0vBtFj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCjl2NKowzJvRmvasCcg6AnA/H2T590lI4LiAo7t0hBpcwttpfXrTz3iF3Ox51nzVSt0vj/ofOenLBa+8IAJxxTzYt/M8IezU5Ikkbrn4XP7UQkF8IXtjTm97tJRHGfYGGdkXV7N6MkHDzxzUjbwBDYe1sNw35Qdm/BaSNQrXd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=HKpR4n40; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f7606199so174916e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 11:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1729103845; x=1729708645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8mhi0Rm0NShxCRtmWPQ7JzqsI/SCo/BLHRuxW9NM0Ss=;
        b=HKpR4n400inKOeh5lWZe1kpwXCwEiDFWY+gTaZBkkGqfvyQ4ui05Yx7E/kiukDx/ry
         tmnttX9EW4kiORW51DP6P2L++PSLDSO8ZIztQTDEqJ+VIxQSUXsjTW2s26rhf8wXup5O
         h66zFW/BtIXB1Jz/aM4L4VixLoa5U8e5slL10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729103845; x=1729708645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mhi0Rm0NShxCRtmWPQ7JzqsI/SCo/BLHRuxW9NM0Ss=;
        b=DdDZw7l2oIooU5aSiueBvirH6P8wX3NDgHEyu9R2Jywjg5TSj35OBELHl4d9li7H6v
         d3s3w4NxO+JQk9NUm7fEn0e9D2ewpdaSyYPrQ6weB3nsE2W4rBZKE5JHMB13oKgUrars
         tV7eiudx2FYOMEH9ymEy6pI3kKtuzkqX0aXIoyU/LhQIiqEg9xfOQvd30nor09ARDQ2W
         maLuQcU1ZQNDv7R0dmt9LIW6kRiDI0JrctfWGE0zolEo97klDuU6+arwv6cnP3af0kYo
         4l6Ovm8Mb+HO8obP5HH+VNV9YLC/VDC+jUfmrm4VIuPLOofRc3v20EPfB39Vlb/b9Y88
         salQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFiqLgBfawqTL1rhA+1KNfDgAxgGnn7FgYQrsFCNrRwQ+3nGNVz4lvosx9q/7keVpYT2UhfT9I8FQ8XSWF@vger.kernel.org
X-Gm-Message-State: AOJu0Yyav3x7fasHMEq9hMpwmqghz6p3lRC1RI8yx71nOesXPjn9PPVh
	9ZOOhLEC0/73ofY1YMCtEsuINW2SIiedk8rnU77IJ4YIgpcOGFt2J88qLxDdTpRALeDfS73g36j
	2a2iHDP0sRUTaU7HeqfwVX/+wWWgsBidw7ot9tw==
X-Google-Smtp-Source: AGHT+IHz8coHWueaTNwFQ4hAEABzC4JAn2gAGVKRhvtF1vLkK1xh18Om2BQVhHyhzZQ+in4UDqaMsTGbNRyKzQpVVa4=
X-Received: by 2002:a05:6512:3b9d:b0:539:ebc8:e4ca with SMTP id
 2adb3069b0e04-539ebc8e707mr7599340e87.10.1729103845064; Wed, 16 Oct 2024
 11:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com> <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com> <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
In-Reply-To: <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 16 Oct 2024 20:37:12 +0200
Message-ID: <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and internal
 rb tree
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Oct 2024 at 19:52, Shakeel Butt <shakeel.butt@linux.dev> wrote:

> If I understand you correctly, you are saying fuse server doing wrong
> things like accessing the files it is serving is not something we need
> to care about.

I don't think detecting such recursion is feasible or even generally possible.

> More specifically all the operations which directly
> manipulates the folios it is serving (like migration) should be ignored.
> Is this correct?

Um, not sure I understand.  If migration can be triggered on fuse
folios that results in the task that triggered the migration to wait
on the fuse folio, then that's bad.  Ignoring fuse folios is the only
solution that I can see, and that's basically what the current temp
page copy does.

Sprinkling mm code with fuse specific conditionals seems the only
solution if we want to get rid of the temp page thing.  Hopefully
there aren't too many of those.

Thanks,
Miklos

