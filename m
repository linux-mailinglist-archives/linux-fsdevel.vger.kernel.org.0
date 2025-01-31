Return-Path: <linux-fsdevel+bounces-40516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F4EA243AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 21:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE70C188AB0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 20:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110F81F2C51;
	Fri, 31 Jan 2025 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="T5Tca/iJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F60615B546
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 20:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738354026; cv=none; b=JLBTaY98LsP9XWW+l1zkqCfK/AYkp7ZIvfk+1p+WRAQJ5OxX2DpWC59yvYaAKW/O/XDfwwc9FrNI9pEZqjLqSJYQA4/8pYYT2UV7eskbwDTVzPjp8Ow/NGEcS8cXL6RgupLRI8mIVYOEU7BNEFeDbpwbOQYN+PoflPzHpt4VX1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738354026; c=relaxed/simple;
	bh=FMQ3sOMKsQB43uj5pNEYT05d5zJRRgzna6CDksmwbeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5Sh/jeFusU6TTxK1c+19e5V/T/fLJ2KEADEXbpxH1cwo7WZBAc9apn2E7x8oZ3A5AiDI9tFiN8ZjDoDPAGfqJHPQhftYHLI3bz8j/FXiMUeGLm0DZ4vQkaMH1IosSD6hwpgBQyTwM8rT4BaeS40ia4sOJaE7NZbJTiwvy0wRXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=T5Tca/iJ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaedd529ba1so330888066b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 12:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738354023; x=1738958823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=giWomTFI9TF/E38QchJwLWohYFKLV3+xm+Xcrv6mGrc=;
        b=T5Tca/iJ+1hF8DS9TSziqEzqZK7797j9TXiMP1rgSdVIw6LaeNMi91s4bGeT9IO2qJ
         +8gO8vKrSvkj1Sqj3x0x4dQLrEyVHW4NFG7Cr5yqgnPDSHOxeGaahttdAzd8yNkYqTGv
         IRgeYlTnKx7eKhF2DHMR2trByKpQUY6iixSKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738354023; x=1738958823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giWomTFI9TF/E38QchJwLWohYFKLV3+xm+Xcrv6mGrc=;
        b=Yf3LC6UBVZi+qUq58PBcsG27i1oagSJ4UhtsrmBU2EL6sy4unaS9WnrBB5d7OByCao
         gM30BrkYMM4mBOoT4gL81mlYTGmBX8EPz8PC1wCniAO6Cw+cftWt+kovMjfM47b8Cc90
         aWhSXF49iyb4yH9ZdAOFo1epnEOAowujdjQDX0mB5XuTBua1vxCcHKqYXf8oYCPEcmfW
         oFseh00n/H7QmND3NH1so1Z55uJywP72gnS5gJz5GaUzhO7YmcOViyK/FIt7ZYDvKcqm
         x/BwUk/7PzZH6m6ghT6wenEj6vTm+ZhOVClAWATZ6L5rDoT/j4GAE1G8hcRjbDHgMRqf
         srPg==
X-Forwarded-Encrypted: i=1; AJvYcCUAKu9hjJyMJN3/DqWReW9jbsIYC1xT8+R6m8j2lpmlWarnzjIaDkgePa8l3QK9uoZ62vhD1bPFJJ4iY6kB@vger.kernel.org
X-Gm-Message-State: AOJu0YzUOkHM5Y74QIOKu24eX27Cq6uQSL0ebG0j8vZbcCnkInMM4OOx
	sgyoLtiyPh+12clvRNMzoPGgaQKCxra+IwqwysB+jxKi46f6mmH8skL9g0euEomvex8qvx8+zdb
	mO9c=
X-Gm-Gg: ASbGncvk9e7Ugp9gllET8QTTRjx9zi49fcxTPiV7nv6R/RhYg1znFh7NnzTxbexSVtt
	y+CMV9ZFBXBqa0pXOhuPgcoyhgZZmaSCMSBQKiGh/EUgRJHhu4TE1fu63PSqgNyj9+H8DQnMz6I
	bb88o736jyAWIrbrzvlPDGhg+H4u9m3SFK7WBTaOSdggsgbYDbdAGq5n9Eh1NqEMInjHtF4kldg
	+6nTC9E3yxrxPnMzbA4nLCjrR24+RzWuHJwn6TGWhr9XKbwZDhqK3AgXrkX12KLMSC/XxTW3jVP
	+1BAmlsOaQTSJe+ZUJgmr56rPjjOz6UILLKHRSfxedP7CjSvUFQuaQnDPYkA5eK7VA==
X-Google-Smtp-Source: AGHT+IFcIi9kzni+A0P6kxEehSm5OLBj5RWTlfXzlvq87Uku5COI6HNAMnvPK2NXSv3kSHkJQmRMWA==
X-Received: by 2002:a05:6402:4401:b0:5dc:5a51:cbfa with SMTP id 4fb4d7f45d1cf-5dc5efa8a90mr33593402a12.6.1738354022666;
        Fri, 31 Jan 2025 12:07:02 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc723cff72sm3342446a12.15.2025.01.31.12.07.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 12:07:00 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5da12292b67so3687906a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 12:07:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUZbfHvp3whwP4U60oTWbTQd9z4P3R6gXUxwhy4iSTwBF/WJhGHdhsQySXKfPaKYRm7Ca3AzhyeuPow3HKC@vger.kernel.org
X-Received: by 2002:a05:6402:2546:b0:5d0:cfad:f71 with SMTP id
 4fb4d7f45d1cf-5dc5effe67amr28614245a12.32.1738354020481; Fri, 31 Jan 2025
 12:07:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250102140715.GA7091@redhat.com> <3170d16e-eb67-4db8-a327-eb8188397fdb@amd.com>
In-Reply-To: <3170d16e-eb67-4db8-a327-eb8188397fdb@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 Jan 2025 12:06:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wioaHG2P0KH=1zP0Zy=CcQb_JxZrksSS2+-FwcptHtntw@mail.gmail.com>
X-Gm-Features: AWEUYZlc4nE8uEABWPl3kngqh7LgFJ1Rjob1HO3aFikc9cUu0-QUHp6KA_BURuI
Message-ID: <CAHk-=wioaHG2P0KH=1zP0Zy=CcQb_JxZrksSS2+-FwcptHtntw@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Jan 2025 at 01:50, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> On my 3rd Generation EPYC system (2 x 64C/128T), I see that on reverting
> the changes on the above mentioned commit, sched-messaging sees a
> regression up until the 8 group case which contains 320 tasks, however
> with 16 groups (640 tasks), the revert helps with performance.

I suspect that the extra wakeups just end up perturbing timing, and
then you just randomly get better performance on that particular
test-case and machine.

I'm not sure this is worth worrying about, unless there's a real load
somewhere that shows this regression.

            Linus

