Return-Path: <linux-fsdevel+bounces-35746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 878119D79C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 02:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0B92825F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 01:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E746BE5E;
	Mon, 25 Nov 2024 01:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CVuzn8QU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6008462
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 01:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732498006; cv=none; b=Sq4aEaM85uj2t261Of0810UwsjIPbUdfGFVm82MiV+uK4KfVO1mWB1r0aeoRRg0+XlyDOtnXm4220Qz/eydEo+VVoPTGZyImMbYHHJwIl5Ae/Q9CExhZVgEhqeS5flMcx4rkgy0baYeE9aM+wXWDs3dXTV9abKihk9no1H7mYPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732498006; c=relaxed/simple;
	bh=mQBlwudP0DfgTUBOWsoqAJWn9pKuKv5wOYnWBD/F4ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gal15pXYVM8V3KxGE7GIdsTEBy/WKh6g6vX2qE1B9w25d49DOmntOQ+le/MaygZQVvJ5bcplUWktgIm7uG0M2Vl0IUqzPTEnV0/0xIxCkxyJti13N0K4zj8kE2f4BRq42bW5JB5Kg/hToff/bAv/sZiMbEydWi6xc5DVzA/KqmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CVuzn8QU; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ffc76368c6so511041fa.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 17:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732498003; x=1733102803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ieFB/E3uQUpwOL5elkCs1Fu1xJKYr7cXOoEikGe05FE=;
        b=CVuzn8QUF349aqn0HAAEETIfz8NBpU/pdoMbw5rjVP6QMsYSUCW2WP4Gri0GfAbo3I
         XdW14yMllXmTRq7dKVEoOFn6YR+MNMWugk3nkTJGcgIzXFVbMRX0U8ieriGIyzVrcv9X
         nI6Az/Xejr0FO+mRyvwqhuBijGhHLca6XU1aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732498003; x=1733102803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ieFB/E3uQUpwOL5elkCs1Fu1xJKYr7cXOoEikGe05FE=;
        b=HoquJZx37vYcW8iZCekkZGdDYMNBSFv/DTZrb7UIy8ZcjlBQtITu8/JEs70YFlZoFH
         4614a38hxc0ka0H16WJp/NksNytJEe8tLJRwtj7Ohpk/zf8HYcb3rXmz9QYyZ2n8sIxB
         QvKZCfFPbu7wtx2vPTzEuOKBp6JM+r2tITdO8tWZ+2aVpwrQXocxBWrX/+wUqD7+0LF7
         HMQyaxuG94kMQDiLHGMLO5++GXJkZFzuDYGtcfvglc4y6KAA4wo8Q1lbqPzzrtSki+hZ
         akbGPiZaxn9FWIUZFde1eTUXitDjcNYBdXCLr0COCE+JGhHz+7fRkLltHF4XvG3BEMPF
         pVmg==
X-Forwarded-Encrypted: i=1; AJvYcCVJrZioev3Iv5Qyj85oXO76RLBP7dt0PYvvS0LEdSUpM7zGbhJj2bhSORYEWVNEUUjB5zBJ8HuUYJgnNTau@vger.kernel.org
X-Gm-Message-State: AOJu0YzAr6JB5edZiXXWH8tyKSXV+ZhsLHAGxzmYjqCNz3/ez5zwMnGh
	7F+5pT6+qePShIM/zfwOtZlPW5WzqUQO4z56ttEnJAdDfM9x1B079d6v7dHJQpNab647Aq4JeJ4
	/ywQ73g==
X-Gm-Gg: ASbGncsiYED3BuJYQsT8jYibzWe3kB3BrRJdAaWh1Ycvg2ov0uI2JeTIk0fAL4tqNRv
	Ie41AGCQGGkXOIctu057RONoqRnCAWoxEYTW2Msk67FqhpftkH9fVmh8kk9o6zwZ7e5W50hpK3x
	5Jt9Or1eLSYSkt67pu6XNfe1Lo26fDBuLJRv7sh7Hb9lQxXa/GlyxtEyNZ0Eu8dTRvsfBzsRI8f
	dtvY232YOCITtQExkjNHzfRq2mTKgYbRm9tGR9EU59xD0pqbIxYBrqml2WXTz12YJQqiSIv5zna
	xyIRnhtx3OYxvmLOdn2DQnw6
X-Google-Smtp-Source: AGHT+IHGahtQOFH33MYp1p+7Nejm7NRt3JmR78Nsfr4mji+pLRmZkoBuDmblXUL2/piOt6kdCsA0xg==
X-Received: by 2002:a05:651c:158f:b0:2fb:8c9a:fe3f with SMTP id 38308e7fff4ca-2ffa7124fdcmr80326141fa.22.1732498002611;
        Sun, 24 Nov 2024 17:26:42 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b57d4d5sm400356866b.163.2024.11.24.17.26.40
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 17:26:41 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a044dce2so3675785e9.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 17:26:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWSWATVGQOa860I4IT4VH3csHk392hg/KLPWnNh9NoAbVQdNYL+caNi7zxFG1IAUpy/txgL9AdDmKTFB9/p@vger.kernel.org
X-Received: by 2002:a05:6000:42c6:b0:382:5070:53a5 with SMTP id
 ffacd0b85a97d-38260b552dbmr7674736f8f.22.1732498000442; Sun, 24 Nov 2024
 17:26:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124094253.565643-1-zhenghaoran@buaa.edu.cn>
 <20241124174435.GB620578@frogsfrogsfrogs> <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
 <20241124215014.GA3387508@ZenIV> <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
 <20241124222450.GB3387508@ZenIV> <Z0OqCmbGz0P7hrrA@casper.infradead.org>
 <CAHk-=whxZ=jgc7up5iNBVMhA0HRX2wAKJMNOGA6Ru9Kqb7_eVw@mail.gmail.com>
 <Z0O8ZYHI_1KAXSBF@casper.infradead.org> <CAHk-=whNNdB9jT+4g2ApTKohWyHwHAqB1DJkLKQF=wWAh7c+PQ@mail.gmail.com>
 <Z0PPl_B6kxGRCZk7@casper.infradead.org>
In-Reply-To: <Z0PPl_B6kxGRCZk7@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 17:26:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgC9fB-Fq=pZQBDC0nZBWkxPRz-R95vbKjwHmSyU7Ex3w@mail.gmail.com>
Message-ID: <CAHk-=wgC9fB-Fq=pZQBDC0nZBWkxPRz-R95vbKjwHmSyU7Ex3w@mail.gmail.com>
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mateusz Guzik <mjguzik@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 17:15, Matthew Wilcox <willy@infradead.org> wrote:
>
> I literally said that.

Bah, I misunderstood you.

Then yes, if all the writers are always in order, and you don't
actually care about exact time matching but only ordering, I guess it
might work.

But since you need all the same barriers that you would need for just
doing it right with a seqcount, it's not much of an advantage, and it
doesn't give you consistency for any other kind of action.

             Linus

