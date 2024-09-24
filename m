Return-Path: <linux-fsdevel+bounces-29920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A483E983B55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 04:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0AF2840BD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 02:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBFB13FFC;
	Tue, 24 Sep 2024 02:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TdOBkOUC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0259463
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 02:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727146107; cv=none; b=e0WUkg1jJyInbg9desrcdYsElfYZNACYcf494SH9ws0eGyeEV7bZmbDfOIz7QTzvat2RcFKxjntyX9ad3X6KmXodWhwEAs5iZfcoYPJI1SlthHCMXCJ/CYjAfmLAhqIgTIb2K4RLH9aZQi+Qhi/3q76ncZHzeLsNDdP+nI4Uzm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727146107; c=relaxed/simple;
	bh=eHzafNxabmGSIs26LY/np3HBRImQLK5VxqnoAlmffCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLpTLB9ajJ3AVINMC5xjWSElK8dN+vZ6PMwQq9aYL2HHXPyRwyGencvroJvieiovq6B8bc29Z9A3k3nyIdrfpkxYvRWl0522HBXXkYblwU7eWTb3FJpfiq0oKK8IUWtZkt++6M7/5IOK5hU4DxoZ2C9k0p0Tr7IQ65vCxiNZJV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TdOBkOUC; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f761461150so58332141fa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 19:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727146103; x=1727750903; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LRazYseFwv7HnZyxXE3fGsm1aCnICLJvDr/BBHvdERY=;
        b=TdOBkOUCHdBZ0I6thCd6nm+anZ1k8J5ubeFed8tPAu3bv+SngZRMdY0mEudIuEOphV
         TUUakBNU4AJX6ZEg29yylZNYNykxZfJXJpC6pqfum17A/m3s3VVQPh/1p0s5lC7I1/pw
         N4jD10NQOJ2fXpJKVUBL4PoJ+R7MZHGrC35Ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727146103; x=1727750903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRazYseFwv7HnZyxXE3fGsm1aCnICLJvDr/BBHvdERY=;
        b=fDQBoe6nTSpwH4/zJrHU4/mCpHL6eg37Ve2wYdEhNLB0H1p2yMrPjpvHZXfd9oAT3y
         ps9ygOHVSVqZqEsdeYotzTCo3TdGHQ0NBX6YU9V72Cv/7zWOoNCIxoR6swe3Fh30aHNZ
         F16Ypaf/B6v0rsvbLEyqXsiDyihxkahwaxP40WGrRrLFziCLw/k8G3mdWMq14ruxSW2I
         iiwcjJ3si3cLNazAF+HtlesZ+aekMWFCcNObNC5hO7o2e/qKgf/LIZOltqTuOB0+6lQ4
         iYpz7KOk8AmTVrRo1TV7EFTC35mHh+vwKjk+rxNkHxQ5+6yiPdJ1xp9/fe3dj2j/IyJU
         c0Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXZs+jsK4iVv5hNivKinnRqZvV2PBLbplmSHYBELPrC6+0PpPxHJg1VYYO8na19s7sGqJuEmcpiH984ibzU@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+JAXGPgwqmaVBmBjKZFfYhmkuVOtt0QGL/XlnGuErTqgV4VX
	p2HKkLOBebbINYxcJ9CbXaD7TTlmuD0FDQvM/BIesXp5lf6/aSaasajWvEoPrC505FlHeAPzeZy
	NmMIC5Q==
X-Google-Smtp-Source: AGHT+IEypdB/yvPqFBdXonhh3ikpQDd8DyKHHxe1KmW3sP5qCknMBhKgiJmK3a/5i6JF84QvD1SlsA==
X-Received: by 2002:a2e:70a:0:b0:2f7:6869:3b55 with SMTP id 38308e7fff4ca-2f7cb31c9e4mr72393181fa.21.1727146103184;
        Mon, 23 Sep 2024 19:48:23 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f8d28b4cc1sm762711fa.129.2024.09.23.19.48.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 19:48:21 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5365aa568ceso5827059e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 19:48:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWATeb5kbq88RFWt1AiZ0z/dErW1SCSc1K+9vNDQJgxYzM6LX7Q2TbDvKNpwE/jjjrv0M5HErqjUO6P/zV7@vger.kernel.org
X-Received: by 2002:a05:6512:1095:b0:530:e0fd:4a97 with SMTP id
 2adb3069b0e04-536ac17ba54mr9463642e87.0.1727146100293; Mon, 23 Sep 2024
 19:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <dtolpfivc4fvdfbqgmljygycyqfqoranpsjty4sle7ouydycez@aw7v34oibdhm>
 <CAHk-=whQTx4xmWp9nGiFofSC-T0U_zfZ9L8yt9mG5Qvx8w=_RQ@mail.gmail.com>
 <6vizzdoktqzzkyyvxqupr6jgzqcd4cclc24pujgx53irxtsy4h@lzevj646ccmg>
 <ZvIHUL+3iO3ZXtw7@dread.disaster.area> <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
In-Reply-To: <CAHk-=whbD0zwn-0RMNdgAw-8wjVJFQh4o_hGqffazAiW7DwXSQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Sep 2024 19:48:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+atcBWa34mDdG1bFGRc28eJas3tP+9QrYXX6C7BX0JQ@mail.gmail.com>
Message-ID: <CAHk-=wh+atcBWa34mDdG1bFGRc28eJas3tP+9QrYXX6C7BX0JQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs changes for 6.12-rc1
To: Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 19:26, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And I had missed the issue with PREEMPT_RT and the fact that right now
> the inode hash lock is outside the inode lock, which is problematic.

.. although I guess that could be solved by just making the spinlock
be external to the hash list, rather than part of the list like
list_bh.

You wouldn't need to do one lock per list head, you could just do some
grouping of the hash.

That said, the vfs inode hash code really is pretty disgusting and has
been accumulating these warts for a long time. So maybe a "filesystems
do their own thing" together with some helper infrastructure (like
using rhashtable) is actually the right thing to do.

              Linus

