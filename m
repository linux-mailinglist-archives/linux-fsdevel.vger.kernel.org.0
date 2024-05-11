Return-Path: <linux-fsdevel+bounces-19324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFEB8C3269
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 18:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BEBA1C20CBA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B75F56B89;
	Sat, 11 May 2024 16:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BuDsSFss"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3E056B7B
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715444018; cv=none; b=CCvgLzmAPEZDT7xTstOeDyvh1OAkL07qr0fFifp8pR8Fs3gxVFgbwNyMLQ0R18ZlM3VoUfhfMNFg2AkU6KfGgYly4QVZSentpM8D7Qt6PEVbFZ8wuQj5KeiILPi8VRyaEnPW78g7fIGCrICuqnf3S6wlfwp2gw/X4dh+rtOSy5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715444018; c=relaxed/simple;
	bh=jykZ/mYa7ixE6v4t65BbdAdaMSLAVDxnQxjNxFE+KWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atE+yS3rO+DGBV/wsSqu2aF7BxH7aN2tY04lTeEIX7PymImq+Z4xw5Ied0MdINUepm5HMwGIjLVKNmWXcaLE7T3VrW92qgq6CxCtTTT0BFlritO4p8Fx3RbFQ3RRWjiTKGzy2XNs4QZcaMHVPB/uwzstJ3l1zmihOQmDk5FRK3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BuDsSFss; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5a4bc9578cso120018566b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 09:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715444015; x=1716048815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DRhm3hvEnL7lCfSQZVSi+PZ4tmM+Ns1HKRr+JgA9UZ8=;
        b=BuDsSFsstN4/FiC795j74NB5AXxgLfIflBuS1/v3+xOfCgr1tzwf4vrOIgZWlzXMLK
         c8fn2JGKbV+H6ESDGFBJ8V1Ry0EjH5xkcNKb/I5GniDQbH/dgWBwW0oBmN+41DAT7ntI
         Nqm1bxO4s5YquqIyHxWmyTe1HpafsvDDU/wNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715444015; x=1716048815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRhm3hvEnL7lCfSQZVSi+PZ4tmM+Ns1HKRr+JgA9UZ8=;
        b=LL9dvsVvvhXjfHWxX/LoqjvP0flwwhVlV2tL+BL5V8Z46GrAspVhmcqXXRunoCC3hi
         +3iNZjHLFXZFAC2FmRRBgg8S2/HOaNxdhdnvcH1BDJCQ0FEtmbRKloc45SFxIZlYjbb4
         9kj5CofRT0GOmpl3IIgubKq6abZ81mCHN1dFhDjAm3h02OT5SP66vKqWr8gjChqw5F5E
         +Zo/o6YAw/6O/qIKaJKXglGOSPcSbcrdMGvH2hXl7cYIPD3dqFY2aa3qHYa1BQITEBCJ
         jLQll8lUVuBZqKK+n2QBIKeEWnczxSV6M3fY0fDAOQluNJuTA1HKj/jGJjuoIWJ9WEIU
         7lqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5Upcxwm4SCcgU/Jib0j/mdlF/2Y1k6A6qrZBk9NoH/kYMux+hpSoC7yG4OPs+KVZpOdKCJZ/0BVjAWbMuL3Y8lLSFq12PbMBYEZrLzQ==
X-Gm-Message-State: AOJu0YxJ/1y7i75rb6wlNwAPMMfuwQQ8lv3glm1UgQdJwrQaHbzrTdyY
	Yk86qwmx/+tNF90yHgYDrU91zzgOPokrGVlyZD7EuTYcgL+Q+AHa/nUx6Zpep19cCdI+XhBL9en
	QrdktgA==
X-Google-Smtp-Source: AGHT+IGFsW70E3XobaUtr9gJeHB67o1jvfUBmK6tBbZe7+gXG+UCjGzCd4OBfs97WL7aQKBQ8hyzFQ==
X-Received: by 2002:a17:906:ca4d:b0:a59:af4c:c7d1 with SMTP id a640c23a62f3a-a5a2d65ecf4mr542699366b.49.1715444014804;
        Sat, 11 May 2024 09:13:34 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7e9bsm344639666b.134.2024.05.11.09.13.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 May 2024 09:13:33 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59b81d087aso760832666b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 09:13:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW81nhxxyl/UCc3ED53Cf4dLKOH17H/lD8mvg2aCG3MJLvA5MJ/ISzU7lNswlfUtLBIFTRRmJlipbJkk6AAAhasAnzalD0XWPoscOkteQ==
X-Received: by 2002:a17:906:4f83:b0:a59:ea34:fe0d with SMTP id
 a640c23a62f3a-a5a2d65ed4bmr569934366b.47.1715444013245; Sat, 11 May 2024
 09:13:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511022729.35144-1-laoar.shao@gmail.com> <CAHk-=wjs8MYigx695jk4dvF2vVPQa92K9fW_e6Li-Czt=wEGYw@mail.gmail.com>
 <CALOAHbCECWqpFzreANpvQJADicRr=AbP-nAymSEeUzUr3vGZMg@mail.gmail.com>
 <bed71a80-b701-4d04-bf30-84f189c41b2c@redhat.com> <Zj-VvK237nNfMgys@casper.infradead.org>
 <CAHk-=wiFU1QEvdba4EUMtb0HXdxwVxqTx-hoBbRd6E4b8JkL+Q@mail.gmail.com>
In-Reply-To: <CAHk-=wiFU1QEvdba4EUMtb0HXdxwVxqTx-hoBbRd6E4b8JkL+Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 11 May 2024 09:13:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg7ofKHALbEqzXCz9YMB5nyCzT8GnBLR+oxLnAAG62QCg@mail.gmail.com>
Message-ID: <CAHk-=wg7ofKHALbEqzXCz9YMB5nyCzT8GnBLR+oxLnAAG62QCg@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: dcache: Delete the associated dentry when
 deleting a file
To: Matthew Wilcox <willy@infradead.org>
Cc: Waiman Long <longman@redhat.com>, Yafang Shao <laoar.shao@gmail.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	Wangkai <wangkai86@huawei.com>, Colin Walters <walters@verbum.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 May 2024 at 09:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, the other option might be to just make the latency concerns
> smaller. It's not like removing negative dentries is very costly per
> se. I think the issue has always been the dcache_lock, not the work to
> remove the dentries themselves.

Actually, going back to re-read this particular report, at least this
time it was the inode lock of the parent, not the dcache_lock.

But the point ends up being the same - lots of negative dentries
aren't necessarily a problem in themselves, because the common
operation that matters is the hash lookup, which scales fairly well.

They mainly tend to become a problem when they hold up something else.

So better batching, or maybe just walking the negative child dentry
list after having marked the parent dead and then released the lock,
might also be the solution.

                      Linus

