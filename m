Return-Path: <linux-fsdevel+bounces-35743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E539D79A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 02:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57C2281E49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 01:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F8A539A;
	Mon, 25 Nov 2024 01:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UK/LBF4d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2431310F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2024 01:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732496563; cv=none; b=P2VSGMHM4mlmNlbT/7//jCI6XM2X+iHHQyiDp8YgTQ7zI0n84nkIsUVq1LR0pgaIND/cgRMEjRGCCYV0LvFquijRCgSmeMyoJ2Y/bmCL/MVN3rPFCHOCGgerFbQaPLvESR8bf28s28h2scD1naDqSWC6vqR3YvixiJzaP4zcJ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732496563; c=relaxed/simple;
	bh=XNnjvCac9bWvQR/zH0IRaOUupHheXR6b5klmQQutxzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vDe3jDPqGrfcwGLQFFYzHOWCunEn1KGmP+PNhkpHRIPy9YUKaqIxZzFoHtfDc7pKc9qKoJKE9qeM/Slife2k7M9i+a/NHhDfp6ERUgf46NKk2wbLFQsgI+adEbcBEy7fFaH8tMWg+VDPYgbAvSnfKAamJbhE+R+n6sBbc9rcFTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UK/LBF4d; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa549f2fa32so101096666b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 17:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1732496559; x=1733101359; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3j9lfAM66cU/k+3UrceC9HJcVhxEaG6X/8s82jLLoQE=;
        b=UK/LBF4dZJQXD2L6Rl+Imx8RzRQm63d1OYP3wJj+tsk7//+CClvV9h5bjQjAnHIJtO
         bd8genmCfXhiRvdKJ0W90YE0nTbOMs4I3UGya9nSxYGfITL4E/HEQUzAIL9H30vfzB0l
         zJ67XXT8psCOSPHpmi1pUlOfB5rf9HLr/PClI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732496559; x=1733101359;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3j9lfAM66cU/k+3UrceC9HJcVhxEaG6X/8s82jLLoQE=;
        b=lYtcoDBVAKKSv9Gyr4AvytqTt4OLBEmmO98jtYBaLQ/731C+v1ifoVa84p6uNKeGlz
         Lsee5YuUcaDNQaUenUkecQlJRGGq0pVLrDL+hCWk4aqD+xJI3935EJOxNQZv0N+dKfeS
         a2U+w0C3Ss3c6NO667YjZDwdzlgOwac4rfRjBxCagVxR6B1U0WRBfIfqgJCBBSSnA53K
         poZD3aFaweegCWJ5/rxk0mDm22W466PbYd9azTfszhwf3hnDvSA+JeFpoOpo6Nk5/UH8
         dn6q7hqmOgK2w9CE8LHYkMSQroVZCCvwc615FQedG3YEAfDwCvUwWUw7S5SwmuHG6N6R
         YNxw==
X-Forwarded-Encrypted: i=1; AJvYcCV64OByNEBK+ePnZNxuysLGov82a6V0BXEj9lEkBjjIO38MxsRYaQYcxI/WHeyZnqs5+SCxsiX+67PGNlK9@vger.kernel.org
X-Gm-Message-State: AOJu0YyeoWIzzmkLp+vEfGaTMH3+CSIXWl2uZawXjXCloGfCFJmn5Jh4
	HsslhRU6ujqodElcmptRFo9qU9dG4lL0wN1uk0C4dxs9f649pegpPtzC8vaGi4RNa4c7AEDHq9O
	BkUFi/A==
X-Gm-Gg: ASbGnctwx9YHCWAQHQwMe4qrGlLpyRLyH8rmpuVkxq+s8mOeCvk0FYwg3Tb7lIwPatG
	jxPVUgrUQmbdYx9YSt6mBsM69wNS6j0Xi9rQfxmaamFFcQb4eUYTAjVLKoeSgu9LzEePl85H4MN
	0ZhhOL9zGl6D7P7jVCkjYhng6JerR4f2Je5plnnglKT9mqF/ansX1x6BRQLS6cNMBzwrFGc9F/A
	QPSbMyTxXfL/c5qnx5ijyyFl1GtrZTZChCyB37lgTnJgezL869N6prz9Su0trhtBYtIE35CjKNn
	/14E/RBNVhC4hvxX9Z9UlJmC
X-Google-Smtp-Source: AGHT+IFlhA7HFZIwrnmD5wMsF4i5esFiuHWv9obcB6kdPqQ03dMJr+QM6gyPlYZ4XGf+kDuXYu9OpA==
X-Received: by 2002:a17:907:1b27:b0:a9e:c267:78c5 with SMTP id a640c23a62f3a-aa509c00bc8mr1192380666b.55.1732496559286;
        Sun, 24 Nov 2024 17:02:39 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b5be1c4sm398998166b.203.2024.11.24.17.02.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2024 17:02:38 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9e8522445dso564380766b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 17:02:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWJiwIVDtrIOH+SyeOd03bhCvqUP3Fs3KIrdiOd9nl/MEioDVomRek3exj70pL8SAVnjd39g4VaJiPtTCzV@vger.kernel.org
X-Received: by 2002:a17:906:3293:b0:aa3:49b6:243 with SMTP id
 a640c23a62f3a-aa50990b336mr650184166b.9.1732496557620; Sun, 24 Nov 2024
 17:02:37 -0800 (PST)
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
 <20241124222450.GB3387508@ZenIV> <Z0OqCmbGz0P7hrrA@casper.infradead.org>
 <CAHk-=whxZ=jgc7up5iNBVMhA0HRX2wAKJMNOGA6Ru9Kqb7_eVw@mail.gmail.com>
 <Z0O8ZYHI_1KAXSBF@casper.infradead.org> <CAHk-=whNNdB9jT+4g2ApTKohWyHwHAqB1DJkLKQF=wWAh7c+PQ@mail.gmail.com>
In-Reply-To: <CAHk-=whNNdB9jT+4g2ApTKohWyHwHAqB1DJkLKQF=wWAh7c+PQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 24 Nov 2024 17:02:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgECCWJvNiFURP-jCHFhsYSB3wS5suFLvfMC56OYxFJEg@mail.gmail.com>
Message-ID: <CAHk-=wgECCWJvNiFURP-jCHFhsYSB3wS5suFLvfMC56OYxFJEg@mail.gmail.com>
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
To: Matthew Wilcox <willy@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mateusz Guzik <mjguzik@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, 21371365@buaa.edu.cn
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Nov 2024 at 16:53, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> and look how the reader is happy, because it got the same nanoseconds
> twice. But the reader thinks it had a time of 6.000950, and AT NO
> POINT was that actually a valid time.

And let me clarify again that I don't actually personally think we
should care deeply about any of this.

I think the race is entirely theoretical and doesn't happen in
practice (regardless of the "re-read nsec", which I don't think
works), and I don't think anybody cares that deeply about nanoseconds
anyway.

The "worst" that would happen is likely that some cache that depended
on timestamps would get invalidated, there really aren't a ton of
things that depend on exact time outside of that.

Also, fixing it with the sequence count should be fairly low-cost, but
is not entirely free.

I wouldn't worry about the writer side, but the reader side ends up
with a smp_read_acquire() on the first sequence count read, and a
smp_rmb() before the final sequence count read.

That's free on x86 where all reads are ordered (well, "free" - you
still need to actually do the sequence count read, but it is hopefully
in the same cacheline as the hot data), but smp_rmb() can be fairly
expensive on other architectures.

              Linus

