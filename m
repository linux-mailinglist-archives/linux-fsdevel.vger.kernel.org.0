Return-Path: <linux-fsdevel+bounces-50667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74451ACE488
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 20:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53ABF7A2663
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 18:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737F11F5423;
	Wed,  4 Jun 2025 18:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgtY8ST9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EEF320F;
	Wed,  4 Jun 2025 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749063177; cv=none; b=cla868EWHBIPfDnL6+flQtezyG/tB4dE8hvCAdS4zsukySI1PwG1yrYdQDnu+KGAaK90XR9qJ1IBmJiF/6kefqypG7/AJKgFq+EhdEHl4MAga0hV0hapSMDQEgfbL9K+fHHc27f/MWsH0FRh7Yv0kkAl7FkKi5L1OiGy1OG91rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749063177; c=relaxed/simple;
	bh=8Nq1mvFsPAkdB/ONlRB0QG9AxsWYQKTuGvCQTys/lzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=fWx9O9alSI2Tza72BZn6QLxE969U2jb7USnu6lLwSkOP31mHzAzSq+P8xhSr1Pa/wiokclPfo5GdAMOGacqvdQqqali7D/V0ZNrZ6KCSSE8VeJg5zC12Uvwo9sd1xH76YDHhCL1GxSy3mCdLbjl2IGDA2aEp3Q9j4EoImpFNAJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgtY8ST9; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b1fd59851baso95023a12.0;
        Wed, 04 Jun 2025 11:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749063174; x=1749667974; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PJNut2ZlX+StosYLoGKIswQY2iwzTASwF8X3cOkETt0=;
        b=KgtY8ST9l9CvvRtfp8Jqz26LkxTNIeqJf0orzxWJz0/JGr+ch7mOWLBuD2xDWZzQ5o
         lIvia27RSgJ4Er7XnpvmSRBcELWIRgZJbuF2uiTDFeXfCcgsUwCaIKZelsiG2ttZ0FUo
         GPESOnMFFhxih3qSAFsdq+Y3WFHpetGvQdaN2fTKs4bzYyXgxi+l3ZXDOuR9Pran/puN
         46qU3r+gDb8zVkgbT9rLJAw1p6XSxVlfG4twOphqICw9WErRiaaT41IN1zrE/bkNmTjF
         t1sAKxADTFrWu2SbJyM7RIsKbW4vAlOFpjKimZjqNjOFwYkw/x8MI9QBAhIA38LuaaEm
         DcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749063174; x=1749667974;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PJNut2ZlX+StosYLoGKIswQY2iwzTASwF8X3cOkETt0=;
        b=k3K6qUTKJyJicCVZB9gkO7HajqdoQRtsR7nPzFL0yrntM4YSctWkIcoAm7bS/krCkG
         3mdKe6cKUB6A1nDfR1G5+uXZARE1i3ejgvY+43xICmeVYSfbM1Knk/LKP+i+lfKTRkVS
         YmKRxKVtfdSCAUK32uCyF59o45prG3sq+XOpff+czeZs41NCTf4ihYQD3acNq1qWY7+N
         ArAWlxTHzklLdkmPbkqAhdFYmyHZP1wXjkmO/WAcQ3gGKgMe6lXYvjhio35f2qWNNZvA
         VDeiw8tJrjlhFyQnZnJtFgcGS4zhGZHfjDOm1FedkWOZAqv+exfeBMoPMBPIrFcw6qjh
         D7WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpzQ3ryTo0rVs4OzgQBx7rkxp1Ii85Y4bul5Agj6YmGkOOn5Wh6/NUZFjb6e9LN3Oo5tS2lrxw349UMjVD@vger.kernel.org
X-Gm-Message-State: AOJu0YxVqnmUE/EHWfxbnd69DzkqDasybxyOEvRpI1mV5o2KxmHPvvw9
	QxqWiOIjgROvo6MOr3qXsba+eltupDppVgF4Xdaqn4wokgtr1E+QFgqdDjKFf0rxl2ZWJtSurFj
	mFQeG1wsUI0dQ00a+vqb0sGPgv/AbHcCKgH75
X-Gm-Gg: ASbGncvR0SAl/NDTvAZxZXAYYqNoVNYDPB80Ua4flZ6/QNl9QBabeFityeCePE6/u7s
	5ia2dcnbPj6j7Puk0LzgLYhWg6pzzg8RtqricdUoad8kXsZhJcYc7/lvVz0YYS7xMdbyvSQmfmR
	AHVH9P2Nsrksaj2JH95BTYyeAgv2wFFi7N
X-Google-Smtp-Source: AGHT+IFx62PRX+zHGAhyNtnp95DyUa+J4Bto/Ds3ma9yNZW7jyJejNBhVQzO67t9iSe0yCR6CotiEHXrSpZD3Yvexfw=
X-Received: by 2002:a17:90b:4b4a:b0:313:17ec:80ec with SMTP id
 98e67ed59e1d1-31324908cf0mr1901111a91.26.1749063174414; Wed, 04 Jun 2025
 11:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
In-Reply-To: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Wed, 4 Jun 2025 20:52:16 +0200
X-Gm-Features: AX0GCFu2MDygi9pMjFpuDqjqIs1dnWu4FkFLqbfTUU_ENnBRzZ3lVtzTmxugjVE
Message-ID: <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
Subject: Re: LInux NFSv4.1 client and server- case insensitive filesystems supported?
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Jun 2025 at 19:58, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>
> Good evening!
>
> Does the Linux NFSv4.1 client and server support case insensitive
> filesystems, e.g. exported FAT or NTFS?

Just found this in Linux kernel fs/nfsd/nfs4xdr.

        if (bmval0 & FATTR4_WORD0_CASE_INSENSITIVE) {
               p = xdr_reserve_space(xdr, 4);
               if (!p)
                       goto out_resource;
               *p++ = cpu_to_be32(0);
       }
       if (bmval0 & FATTR4_WORD0_CASE_PRESERVING) {
               p = xdr_reserve_space(xdr, 4);
               if (!p)
                       goto out_resource;
               *p++ = cpu_to_be32(1);
       }

How did this pass code review, ever?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

