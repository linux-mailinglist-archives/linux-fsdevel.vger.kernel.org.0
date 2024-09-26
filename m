Return-Path: <linux-fsdevel+bounces-30162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6095A98734A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 14:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27ECD2824F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 12:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21571714D9;
	Thu, 26 Sep 2024 12:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTH+8V0g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDD4171088
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 12:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727352623; cv=none; b=aX42Jo0hr4CfhjOjLpjWf+6W3PekP6dtgW8pD/0G0aqJmvXHB1+xU9Ja3HQ6nNnFqdLF/NqJinkCA+xRA0e5FDK6hd1WPIXNz5xvWVm+RXRWkrq4gmMXyBlJG+mT9faglFQ4Yl3ItuHOl/3jk2vijayALIQfykOd4kXZUi5CFNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727352623; c=relaxed/simple;
	bh=KWWSCa4bm5iRBUvMYRVkyewVmHwFy1Gvzhu1WXJbih0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwsebJCwXTCba2VbQUXT3/JsXMYSzYGrtVetV/qaHe0lTdk6wY08EorLfDvc/GLUpfVe6pJgc1/KVY7xp6+IHOcpY6ETE3XKvevC4l/ZQud3B+SAU2U4/d7HZdbJm1ygoIHR2GzjFXdbxXCT765Fbgyvn3r819JOL/pBC4xuBWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTH+8V0g; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a99e8ad977so67983585a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 05:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727352621; x=1727957421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mf7Om00r0mCig/ZMqczV49KZAqpWgZLX+5yEYgrLlko=;
        b=aTH+8V0gXx7c8J/sZZyP7JJXXZa4/g+jz1E6sskeDMJYRIFHWWkFXcPW42BB84fQIh
         XQhwfHgA0JIF3M0EH6XsbNkO0z0DNckYv6b1nS/t5hvFhj1BDD/2LXyFnrrwBcAIdNuw
         6o3aFs6MGgzf66jW1IVWQQzqAJ94QAP2BcVZscGPMSh5A5yWkqHgs1u0eSv+jm2jigee
         k66616gzXRCS98C3VcE5HEupqCTMcUaYZiLp/adb6CjAJ6JC6Nzzg/9mBgaSaUIC8sZu
         Th6S1+nZf549YbHdKmAqv2qSLHQRWxE1veHk5WbXiLyyUKYcZoFdYn2QSkVaGc9bl+ur
         5XIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727352621; x=1727957421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mf7Om00r0mCig/ZMqczV49KZAqpWgZLX+5yEYgrLlko=;
        b=ZWN4LbB1mQ9V1uCv3PhEQQ0wK9MLgwVsIo0g9CGpcsCzFtSs+8NpaAu7/PpDVuNo1k
         MOpC6y1Z1thGUhyHE/x8uc0r8qexRMPAJL1K304jHpL8f61weH2YkrAC37AfjM7zAfhO
         EvYoZZwHHk1lH2xduHAuTbYqdvDi7ppDlPv/syU4cdO4mqsqOq0Fy0QW3CRxl1jbUfSO
         GJQJKH0rsJS8dcHLkglkfadnTVOauPpoN0KXtYCtqFkw94f9ELgDRTILok9dnhhqqDfk
         DhdTa96CFKoC5BJvXJoX4bVh7GAJWH9MvXGb3OLVlpy4gL3EYznSb+SkkHwbV+ac0BES
         Z8xg==
X-Forwarded-Encrypted: i=1; AJvYcCWBR2Jz5ddGEFlCxdQKuohQkwWMgGftxqD6NwOyjbtIGVygjXCttMn5KoZR3CpJluhUE9qM6uNtyvlCU4lT@vger.kernel.org
X-Gm-Message-State: AOJu0Yw22BpOraJCOXG0IHUnve4RBZVZpHND6WqGBJt+BC3h6rQ85eTZ
	e9cVslazOmZQzW5gOrIvXBI40x2fBFeI78XOtSVKx2eYuKGXIS0n6vm5ZVshbfIiJzF6sMqOeNG
	n8eY/Z8uAHRVw3B6vMfC/HiwFPUY=
X-Google-Smtp-Source: AGHT+IHOu02hfo2NqYxaYTeobf8HzVHsr74VBRW/0nvcQAkFKMdhB1GQQIM2rCkqtQJNfGD3OzyenMhMbx2gd7/MLMU=
X-Received: by 2002:a05:620a:45a9:b0:7a3:5f3f:c084 with SMTP id
 af79cd13be357-7ace741340fmr736526185a.30.1727352620663; Thu, 26 Sep 2024
 05:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2P153MB07182F3424619EDDD1F393EED46D2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxiuPn4g1EBAq70XU-_5tYOXh4HqO5WF6O2YsfF9kM=qPw@mail.gmail.com>
 <SI2P153MB07187CEE4DFF8CDD925D6812D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjd2pf-KHiXdHWDZ10um=_Joy9y5_1VC34gm6Yqb-JYog@mail.gmail.com>
 <SI2P153MB0718D1D7D2F39F48E6D870C1D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <SI2P153MB07187B0BE417F6662A991584D4682@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <20240925081146.5gpfxo5mfmlcg4dr@quack3> <20240925081808.lzu6ukr6pr2553tf@quack3>
 <CAOQ4uxji2ENLXB2CeUmt72YhKv_wV8=L=JhnfYTh0RTunyTQXw@mail.gmail.com>
 <20240925113834.eywqa4zslz6b6dag@quack3> <CAOQ4uxgEcQ5U=FOniFRnV1k1EYpqEjawt52377VgFh7CY2pP8A@mail.gmail.com>
 <JH0P153MB0999C71E821090B2C13227E5D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxirX3XUr4UOusAzAWhmhaAdNbVAfEx60CFWSa8Wn9y5ZQ@mail.gmail.com>
 <JH0P153MB0999464D8F8D0DE2BC38EE62D4692@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjfO0BJUsnB-QqwqsjQ6jaGuYuAizOB6N2kNgJXvf7eTg@mail.gmail.com>
 <JH0P153MB099940642723553BA921C520D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
 <CAOQ4uxjyihkjfZTF3qVX0varsj5HyjqRRGvjBHTC5s258_WpiQ@mail.gmail.com> <JH0P153MB09996860C90193AB4D293D84D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <JH0P153MB09996860C90193AB4D293D84D46A2@JH0P153MB0999.APCP153.PROD.OUTLOOK.COM>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Sep 2024 14:10:08 +0200
Message-ID: <CAOQ4uxiAyCTF30xwcMbgY5f=5He2oTGCACV26GO=s0CHYfJVyg@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: Git clone fails in p9 file system marked with FANOTIFY
To: Krishna Vivek Vitta <kvitta@microsoft.com>
Cc: Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	"v9fs@lists.linux.dev" <v9fs@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 1:17=E2=80=AFPM Krishna Vivek Vitta
<kvitta@microsoft.com> wrote:
>
> Hi Amir,
>
> Yes, and my guess is that the MDE software running on your machine had re=
acted
> fanotify_read() error as a threat and removed the .config file, that is w=
hy it could not be found by the open syscall??
> >>>>No, that can't  be because I have performed the exercises by uninstal=
ling MDE software running in WSL(5.15 and 6.3).
>
> Git clone succeeds, but the listener terminates as you see in your machin=
e in standard linux. It is the same manifestation.
>
> In MDE software, Fanotify marking was just being done only with CLOSE_WRI=
TE in mask, while the example code(fanotify listener) was having mask OPEN_=
PERM | CLOSE_WRITE.
>
> I shall include OPEN_PERM in the mask in MDE and then invoke git clone an=
d then see if it succeeds.
>
> Can you explain the significance of OPEN_PERM and its relation with CLOSE=
_WRITE ?

I cannot explain but anyway the impact of the reference that fanotify
takes in the dentry
is not exactly clear to us yet.

In my test OPEN_PERM | CLOSE_WRITE also got fanotify_read() error ENOENT
see my email.

Thanks,
Amir.

