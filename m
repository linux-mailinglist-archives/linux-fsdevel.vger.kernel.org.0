Return-Path: <linux-fsdevel+bounces-35733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F3B9D789F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 23:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77560B23A49
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 22:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669F517BB35;
	Sun, 24 Nov 2024 22:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D8ssIxss"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE61165EEB
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 22:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732488042; cv=none; b=OS00PmQ8zNbUjjjB9mYw6e4jK2cKd8z8PrGlx95hHMsyLZy+cpkKxaAwC7Gpy+wz+AKvHL51fmEj59cdl1UXvuJYRsxdDg1zNbnDbyyIJNmO5fH28vnk+kJDLNt9e/pMz86bpGWlVcmXjRHfHjjN97vUAlhPoo5srzeLOIn3SmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732488042; c=relaxed/simple;
	bh=GaQdMPFdNe40VY26/MbbYRPP1PnBJVuOeF5ZR1vbOSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJBvmtd12LTErlHjaNiNBEFHUEoa3o0lGSBvPH34jEkODdezaET6NWWxHk+X/EfPcwCaMwTlZWnydCJ2LpYlySW1epSwbLnjDbrGHafbEyIQr46hYBAD6NNOUQAGwrq8M3Omqsl5AZmdKMsUjnCQMGDVuQYDlJfb+DTChmJULDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D8ssIxss; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so9283341a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 14:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732488039; x=1733092839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KXorZl1i4MgdQSpDUwpcPC/cMs/fMYzfPrdOviHNCjg=;
        b=D8ssIxssRI7h5WQRUnmgz6ZdGc0HPnJlCwdCxcrUOB88ZIa32ea3gsL5A7FEOZ/06K
         O45OOaYB8pvPTXe7QaNWWiGmAZXuFC/dplPZIJ3nff3EhRb08aq6ZyRC1OzhfbQQjDxY
         wtbgTxvN4Hl0t7uCCWyw6rFD8TgfKCwzNeaiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732488039; x=1733092839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KXorZl1i4MgdQSpDUwpcPC/cMs/fMYzfPrdOviHNCjg=;
        b=eBi8mnFPRMXy9B5QQ0DjJBcoLDnnWZsLrLe2UBG9gL8o4ffUn03uHF8j7orUlB4fDp
         iEDT3XPaiUpV9NTevyjws755GAUnEQhFHL07thSxIEov3iCRAMvipkoQLNzz10fSHTbr
         4m0bh/AWT11TVW9/mb0JvWR5UXB7nmAOV997FfxG3fIvsddxXACB7u3Ajn/3hhPtJiWB
         dGUg+0TKLa4x+CUS0FfHW8uXZfzetH2cnIBdd6JH+1Qxj+tSwYhQyzZc7uSh1ZlKW3AZ
         xZvJY/dWHCrrMBKEF8X6fhzEZj6ORuDfp15TOOkh4QC93LSpuvxUzKLqIlKRlvkYAWru
         zQDA==
X-Forwarded-Encrypted: i=1; AJvYcCUbV3C4hrIAcdLJvWqppOIuqOxsyiyHeOyxQVn/WeeO3i9Ot7a8paedLgUIEUe6wtJd5c2bfffRiTjDxn45@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn5Xxke0k05IBDB2lGPSN5t3XpcGVnzQQ1BhSkkfspvBItxXkA
	gha6kPMIgZ2sEq7FIJw8Qh2tiZqWHQXGWSI3TJar11JOF6xPktTW8/f0qYP0TguvUJ4ZuQTAR4r
	l+/hcgg==
X-Gm-Gg: ASbGncuBPA4LPQIxMboqCRgXcC+ciCvYD53D7GPAZyPAJxHDU6GHBS2tS6BxJQTXDUV
	YTepiiu4ky1fJK8ig6bRwJdwdPEjdlqK8ewPDRxZLG0YFjPpgPkXEK2Ti9SgPW82O3XueIMVAe2
	3vFVWUAUQWe6EMqJOlCrAnBJxckx3we4skyYlERwlUUJ7H3ejK/tU73HyXocB/OqdBKyXYlj1l6
	Unj1FlUG4zsXpEhBYaR/+t+CHtsZL8pXfchDwxpy14zbZOYZOtLuechIGq72n7MGmVrcgoKOMPL
	ZOGjXzxkY+AcateKByLCOrGb
X-Google-Smtp-Source: AGHT+IGXQnodwxB2QpX46VBk+df44eFiOHdZ2Tz32Ah91egeISEWFtHrIA7I35VS2hyY43OpeUy2+g==
X-Received: by 2002:a17:906:32d4:b0:aa5:ac9:ce5f with SMTP id a640c23a62f3a-aa50ac9d235mr1225366766b.0.1732488039353;
        Sun, 24 Nov 2024 14:40:39 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa530e6f654sm263551366b.101.2024.11.24.14.40.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 14:40:37 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa4d257eb68so715959366b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 14:40:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWbaI/Ul6OtTduiLcdQB9uZm764m6Wcje2UsZ5Ux++mnmw38m8ODKkRt8zrarY0C7ZpG6a0qdePapDhLzG9@vger.kernel.org
X-Received: by 2002:a17:906:2932:b0:aa5:3853:553b with SMTP id
 a640c23a62f3a-aa5385357b4mr429896166b.20.1732488036958; Sun, 24 Nov 2024
 14:40:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn> <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
 <20241124215014.GA3387508@ZenIV> <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
 <20241124222450.GB3387508@ZenIV>
In-Reply-To: <20241124222450.GB3387508@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 14:40:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh0GvCCyuK7hG9MkXPrDTSPU1qFaQZm5GVL=Tc0BzN49w@mail.gmail.com>
Message-ID: <CAHk-=wh0GvCCyuK7hG9MkXPrDTSPU1qFaQZm5GVL=Tc0BzN49w@mail.gmail.com>
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Mateusz Guzik <mjguzik@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 14:24, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Nov 24, 2024 at 02:10:30PM -0800, Linus Torvalds wrote:
>
> > I *do* think that we could perhaps extend (and rename) the
> > inode->i_size_seqcount to just cover all of the core inode metadata
> > stuff.
>
> That would bring ->i_size_seqcount to 64bit architectures and
> potentially extend the time it's being held quite a bit even
> on 32bit...

Yes. But it seems fairly benign.

*IF* somebody really cares, that is.

         Linus

