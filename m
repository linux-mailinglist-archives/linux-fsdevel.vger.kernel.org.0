Return-Path: <linux-fsdevel+bounces-9134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D4B83E651
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 00:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71A0EB233FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD6533090;
	Fri, 26 Jan 2024 23:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CmF3bLZb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA6E23751
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 23:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310736; cv=none; b=Qrfw1LeIbF/qIwNiSqPMHTflbIHkROq5XFNT9fa5/R/sV8wWZYQP95ZzpEEVjvpBxtbXj6JGAqHIoMzvobvb576ZLc1rtXrvToqS3J/5Qimx9zOaUEq1+2+9aGIY9U2LiDVwQ3vAbntGg/9bSetPTP1mpI/Csy4Skf3nMuS+NCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310736; c=relaxed/simple;
	bh=2P1MSft8X93++r9/w92I/KK2xvEAgYJknw4bsWY3hGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F31wvBwTtSvS8Z2HWN6sbQiSPpoge8QKpW8nJTey31cER+GAQnt+kfpN6T1xHOT+EPSHrn6B1GBSTxjKEUabtPM+yyOQwrek4YSM+crmHK5zSWJIN6dFSxHHKrqyApcbeL2qC9T+RisqfHybDoLBzetR1YDeg1V/E26j6X3nxoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CmF3bLZb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e86a9fc4bso16245955e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 15:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706310732; x=1706915532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bdf20BJ6O42hFp/1Syn6ytLGURr08JkqxpxmJ3QroSs=;
        b=CmF3bLZbZpRjGd3lVkMpnIUpHNOb19oXWWdDGQik3yEEeWGl7qgw7ZZLaXn7ij4VJW
         1u4FgBUd9GFnZXIKzxiHv9JCRhZbc/b6zylfMxEwaAcjfNtooaXnGecD7kiaeGj1FXPj
         /x5DR0LZE6vjAigFxgg4NCSvcVDy+LB9copzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310732; x=1706915532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bdf20BJ6O42hFp/1Syn6ytLGURr08JkqxpxmJ3QroSs=;
        b=GJtBgToabqmomoJBXxEjqck1l3zta9ffC5D3EJD2kGzON34c1UWYW2n/pfEjbOc8il
         uWx+V/4sx9VNOg7i4F9GmRcCMzXXaNniVjiyMEpcPfdiraxvh4sMOxm2Fczirn/2oNof
         /NXT2WoUbfsd9S60n0Vj9iSilL6s8zEAiG2DAw1Qzx082+qaUq/jliWs0gqGXP+eWVOG
         2YNNelmb2zb3SSZu4Kt89SzV9yWnXRqMAcYwigdfjPk3JhHBe10yY/ssyL4iyD8zQRfi
         lpERINkEGbijWzWuyAiPKGMiOEzxWvVa7zbsgunUavMGb6tdlszQKgZKBJCGpMOPibJT
         ehMw==
X-Gm-Message-State: AOJu0YxQQciW3DsnXg22CnA0Iy7BsKfCwt4t+wgIIe8oeaChKmTU4MCT
	WCc3J5c5oz3ajPR85nsV8zgn49l0X9OscyjtDSlR/zkybOMfwJfeivkQQMlEFz7ClZGgSZ3/1lI
	S2c4sBg==
X-Google-Smtp-Source: AGHT+IFmkMND7tkW+IPa5Oxg/iTrpYCDkD43huvpfztYkmCZorQa5eoWlC9iAYceRR9m/4DJ4E/VfQ==
X-Received: by 2002:a05:600c:3b1b:b0:40e:cd4f:f1b5 with SMTP id m27-20020a05600c3b1b00b0040ecd4ff1b5mr358629wms.105.1706310732560;
        Fri, 26 Jan 2024 15:12:12 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id vi6-20020a170907d40600b00a2689e28445sm1100195ejc.106.2024.01.26.15.12.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 15:12:11 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55783b7b47aso727337a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 15:12:11 -0800 (PST)
X-Received: by 2002:aa7:c3cc:0:b0:55c:f699:c393 with SMTP id
 l12-20020aa7c3cc000000b0055cf699c393mr269406edr.32.1706310731406; Fri, 26 Jan
 2024 15:12:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126150209.367ff402@gandalf.local.home> <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home> <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com> <ZbQzXfqA5vK5JXZS@casper.infradead.org>
 <CAHk-=wiF0ATuuxJhwgm707izS=5q4xBUSh+06U2VwFEJj0FNRw@mail.gmail.com> <ZbQ6gkZ78kvbcF8A@casper.infradead.org>
In-Reply-To: <ZbQ6gkZ78kvbcF8A@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jan 2024 15:11:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgSy9ozqC4YfySobH5vZNt9nEyAp2kGL3dW--=4OUmmfw@mail.gmail.com>
Message-ID: <CAHk-=wgSy9ozqC4YfySobH5vZNt9nEyAp2kGL3dW--=4OUmmfw@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
To: Matthew Wilcox <willy@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Devel <linux-trace-devel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Ajay Kaher <ajay.kaher@broadcom.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 15:04, Matthew Wilcox <willy@infradead.org> wrote:
>
> Maybe we should take advantage of that historical oddity.  All files
> in eventfs have inode number 0, problem solved.

That might not be a horrible idea.

The same way "a directory with st_nlink 1 clearly cannot have a
subdirectory count" (which tools like 'find' know about), maybe it
would be a good idea to use a zero inode number for 'this file doesn't
have an inode number".

Now, presumably no tool knows that, but we could try to aim for that
being some future standard thing.

(And by "standard", I mean a practical one, not some POSIX thing. I
think POSIX just mentions "numberr of hardlinks", and then the whole
"a value of one means that we can't count subdirectories" is just a
practical reality for things like FAT).

               Linus

