Return-Path: <linux-fsdevel+bounces-25074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673B4948A27
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 09:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A74D1C23707
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 07:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED7D1BA895;
	Tue,  6 Aug 2024 07:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gp0LJdHy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7082D13D276;
	Tue,  6 Aug 2024 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722929588; cv=none; b=K3/l0Y/SLKmZI7fzmPXUx+GcVOvNR8wddji6BKko317Xv865dl47AV9mLKkjM95VF62NoqyZf3pvofqDLs0UqjfO7M5bHP9akHUEw0Q8Js3dQidQAPZPyXE6MDzNlXJH/kaFcDqFMYxOkZBgIVqk6hSFg+c3Mg69dKH6Edb4i48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722929588; c=relaxed/simple;
	bh=YPD/n+WZ0MZj0HQ7oNrnDxq/W7V7ECbhHPZk9pXK578=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKh+oPjYaQewSiEOLcwRcFAVnazKCLMZ9TsC0iY/CMzvKcQsXkXY/7A2fR1Y7sLNqDmHV4vX5bgvP6/w+EpBJ365+0aDcZNh12UVHt+kwsh3HnKecIhHcDxnlW7Kbt4Y7G/2FduO1Qv/mW1pFMohnETE2Ica0Dyw0e/1k/oAYW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gp0LJdHy; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5b8c2a6135dso542366a12.1;
        Tue, 06 Aug 2024 00:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722929585; x=1723534385; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hUgYOwitMfNjvlBegZd5jHHXFvXNPbm0j7TY4U3RoI8=;
        b=gp0LJdHyeAfm6rCRa+ZMkYBSRU4qlEVxasMQumakSHTGttDdDywXvzP33yJfTzxoco
         Fd7O2iCVYMpDnPdf5CFPCPyaFGS+9J3jRz0TyL5jeNy26kc/hjWe98Zq+xRimHGQn5g9
         MbMF4EI6UjYtjuVA3oB/15c4QZOsPel3iT5zxXLkBM5u3IcZ+OMRgBTlKIoMz5tAMhgh
         TByDOXf3lK/yjyLttXUonz0SGHfcyjG1y3FUm5iyVC7s+LOZXfn48ZfuqkxA7BKCcKhQ
         1ZU8VCeQ4jAi7L8WJvyb2t24SxlJ4Rmg0gy/9x/Gj4XOP/p4OHrUGyCI9i78Z8z5NJNM
         jCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722929585; x=1723534385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUgYOwitMfNjvlBegZd5jHHXFvXNPbm0j7TY4U3RoI8=;
        b=KgfTynduYyT6kYHoZuBveUjCKZoBb+UW/1Z9yDBSDqGlxdNkFiF/CVP3EkbIhMk5ls
         wP1CfGPKEkyxw4jxgCWqkABo5f55TDqHIEilHH2yi5xWNCdVaWw3qrGEok0SDonaKpH2
         Z94ZdT5vL5FlQ1Br+dVl6HR1XLjtXXSkVJu0Q6jsoxHJO8QRRFEL6EJwAP4K8RtQGxRD
         wCQMW37vEBCGcSd/yVWARZ5JdZSsKov8FCjVIvyk+/57bhZhXrz61dAb40FhujjjiIMo
         CjfKooIdvGNnr4GOuW9/67hSLmeobLTsNmN+Mr+ALds32jXMKr8YOOdxHniyKV/fnoBG
         onbg==
X-Forwarded-Encrypted: i=1; AJvYcCVw++GwlRp1tLEIeGGzYM7c4agW2hBHLTTM+R+dEL4w3HlcPcGNPcuGtc4nfAzUoCi994Ux9CHKgsN3MIUdIm7ISNiv8I44kHu+dc5d251F10S/xmaRVE1MqM0/ZuawYkCgIkYATYToUtcIzA==
X-Gm-Message-State: AOJu0Yw1ltv+DT6wJwtemuhfclM2KMDSb6h2zf4AxxqMlBWFUXB9XzLw
	UkFw7v0Y2cBGrm8s99VEG1grAIO2rgbrTlyd9XBwDxK8nNgZq8ePlRUpZlptf2Zzwnzg+e8BKyp
	kMC4Q9lMMnm4GDRNAp5nMdGzJKrQ=
X-Google-Smtp-Source: AGHT+IGc6juCAA+mcB7csEd0ev35Bx3fHwmxWHLfL1b+ds9bIMp2eR/YBmKH3M5/x7neeI3qleCYppZu1tBO4t7RAnA=
X-Received: by 2002:a17:906:bc20:b0:a7a:9f0f:ab17 with SMTP id
 a640c23a62f3a-a7dc4fae90bmr913656866b.32.1722929554912; Tue, 06 Aug 2024
 00:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805100109.14367-1-rgbi3307@gmail.com> <2024080635-neglector-isotope-ea98@gregkh>
In-Reply-To: <2024080635-neglector-isotope-ea98@gregkh>
From: JaeJoon Jung <rgbi3307@gmail.com>
Date: Tue, 6 Aug 2024 16:32:22 +0900
Message-ID: <CAHOvCC4-298oO9qmBCyrCdD_NZYK5e+gh+SSLQWuMRFiJxYetA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lib/htree: Add locking interface to new Hash Tree
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sasha Levin <levinsasha928@gmail.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear, Greg Kroah-Hartman
Thank you for your reply email.

My first email(PATCH v1) is at the below link:
https://mail.google.com/mail/u/0/?tab=rm&ogbl#label/htree/FMfcgzQVxtmfRqXCVrDZjsJBdddbPLCV
[PATCH v1 1/2] lib/htree: Implementation of new Hash Tree

I missed you in the first email above.
Since I've been working on something called a new Hash Table, it may
not be needed in the kernel right now.
Since it is not currently implemented in the kernel, I have been
thinking a lot about how to release it.
I sent it as a patch file, but since there was too much content,
So, I attached the github address and PDF separately.
I'm very sorry if this doesn't meet the current patch standards.
However, I would like you to check the contents of my first email and
reply to me regarding the technical details.
I want to prove that my Hash Tree is superior.
I know you're busy, but please review it again.
Thanks.
From JaeJoon Jung.

On Tue, 6 Aug 2024 at 16:07, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 05, 2024 at 07:01:09PM +0900, JaeJoon Jung wrote:
> > Implementation of new Hash Tree [PATCH v2]
> > ------------------------------------------
> > Add spinlock.h and rcupdate.h in the include/linux/htree.h
> > Add htree_root structue to interface locking.
> > htree_root.ht_lock is spinlock_t to run spin_lock.
> > htree_root.ht_first is __rcu type to access rcu API.
> > Access the kernel standard API using macros.
>
> Why?  What is going to use this?  What needs it?
>
> > full source:
> > ------------
> > https://github.com/kernel-bz/htree.git
> >
> > Manual(PDF):
> > ------------
> > https://github.com/kernel-bz/htree/blob/main/docs/htree-20240802.pdf
>
> These obviously do not belong in a changelog text :(

