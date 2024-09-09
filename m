Return-Path: <linux-fsdevel+bounces-28958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2448D97201D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 19:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C47201F243E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 17:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC4F170853;
	Mon,  9 Sep 2024 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bPFxVmR+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFD516D9AA
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Sep 2024 17:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725902068; cv=none; b=AX6j3QyJI8eD3yUPY9ObgbjUBX/KG0iUG3BrJ457ywmQiHKdiTc+FGnkSPoou4jWbr2ATN2xnnx6FCP+xIzYNtCLl21KyD2GMAj8jyO/XIo4cHtTONe+CxQS1rkmbtJvoawuTSQAYH3iiMjuo1e8YnlgUfHl0OXvKg1pCZNafuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725902068; c=relaxed/simple;
	bh=MZOIBk1KVVxIFXkW1vV7yFZIGrsA+1yvtz+6vIwntm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sb0iIfy9DtzAiK1Mv25i7/4AIcB/t70aaU7PsTn4aCknzfarvQe/AdrNNYDFwvLrHXmlF44d4r5s45gQ5WXF4vSSaL9n/v9V+c6KnPfbbUZ+97TcLgp9xePwBDXPYNHMxoAwOkY8WjLI1SgXvCdLwsHGw883pR29hsPUA91A3y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bPFxVmR+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so447626266b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2024 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725902064; x=1726506864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WxmI8NiKkO8wbPu3kCjrzQtaE0L8pBmGZ0OhyJkNRrU=;
        b=bPFxVmR+Kbbz3DHHAclCEimdxk0JRMrqwN0HJzs399JROH4e5O95HiCVrNOnKFSZIV
         FPjXT1XUKn0+C26paVjhlNb8FuMORBl6moV8GXp/ys5J2dH8eEDiep/vP0Y500eQ6sLd
         zUwREF/Bgvui+HxrlxGQ/57LEtBqEFy+BpaFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725902064; x=1726506864;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxmI8NiKkO8wbPu3kCjrzQtaE0L8pBmGZ0OhyJkNRrU=;
        b=eduaq3EvhCXk1wff50vLBJ5B1V9DhJ6+yQk8p/p4QLZufghptwhF8mhhkkdhNP/B3+
         QS/tunIXaDWVV9QciYhBt/DKBEgHYwcRMG7pt8CuzbgTIgdRaLe6Aa+p63BRxQ293fxx
         VEljaEmy/1sFYXYT/3sv6LAep68Lz6wGFsbBRKX+lOTq4cQzp92rVgqmSmQJaDCW0UTC
         VySSoi9DIL126ZtU4aR+Pj5bXtOEBJR8+yDSMY8hm5/zrYPUsNrw6cZGFxBEE+kOc7ju
         t2yaA6YXVgeLKkXNfKFjYyAHbqTW96hI790vhedWnI41L85nI9p1Nyo2Lzoyvhl1/p/Z
         doLQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5qiLvD5Phi9LCYbUiFTS6d1omo4JaMyZ8q4D2AL/IbtUJ0BQNhYogv7L3cnfVHnJLlDZV/HdVmuFhxMt4@vger.kernel.org
X-Gm-Message-State: AOJu0YwtNsQni/VnHA1lW6vCYEamiZlXvtEbYeKD7GVcjZweTBuZOxDu
	5QrUaa3+/dYgjDl8oXAcF26bf6iZ4yRPDjgQBiRbI2Meh1Wc2XQA3eOQ55cO5siCq7Z3wuLKsSo
	5yzA=
X-Google-Smtp-Source: AGHT+IHPwjWNM2O9zJkl41TD9kfV8FmDwblV3RrzEUuAa2WzrGFSu1+Q0ie76igfYlVBj+JaJ4peSA==
X-Received: by 2002:a17:907:d5a0:b0:a8a:71d5:109a with SMTP id a640c23a62f3a-a8d2457c016mr589657166b.22.1725902063623;
        Mon, 09 Sep 2024 10:14:23 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25cebcb2sm364072266b.153.2024.09.09.10.14.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 10:14:23 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5bf01bdaff0so4943860a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Sep 2024 10:14:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWKXauAYQOxw2qt2yGEYq/V8LBrSQjYMSjAAZHqp7B/Z2MVUlT2QGsDkIcPG6+zQblod2/4gI7eNTXHR2AP@vger.kernel.org
X-Received: by 2002:a05:6402:3708:b0:5a4:622f:63c6 with SMTP id
 4fb4d7f45d1cf-5c3eac063cbmr3980933a12.13.1725902062748; Mon, 09 Sep 2024
 10:14:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4psosyj7qxdadmcrt7dpnk4xi2uj2ndhciimqnhzamwwijyxpi@feuo6jqg5y7u> <20240909-zutrifft-seetang-ad1079d96d70@brauner>
In-Reply-To: <20240909-zutrifft-seetang-ad1079d96d70@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 9 Sep 2024 10:14:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjkQWJ7erYe9W_jVxgRM-KVVPEZ05J+MwNRi=816WT9XA@mail.gmail.com>
Message-ID: <CAHk-=wjkQWJ7erYe9W_jVxgRM-KVVPEZ05J+MwNRi=816WT9XA@mail.gmail.com>
Subject: Re: copying from/to user question
To: Christian Brauner <brauner@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, Mike Rapoport <rppt@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Sept 2024 at 02:18, Christian Brauner <brauner@kernel.org> wrote:
>
> > Generally, new vfs apis always try hard to call helpers that copy to or
> > from userspace without any locks held as my understanding has been that
> > this is best practice as to avoid risking taking page faults while
> > holding a mutex or semaphore even though that's supposedly safe.

It's indeed "best practices" to strive to do user copies without
locks, but it's not always possible to reasonably avoid.

IOW, accessing user space with a lock held *can* cause some nasty
issues, but is not necessarily wrong.

The worst situation is where that lock then may be needed to *deal*
with user space page faults, and that complicates the write() paths in
particular (generic_perform_write() and friends using
copy_folio_from_iter_atomic() and other magical games). But that's
actually fairly unusual.

The much more common situation is just a random lock, and we have user
accesses under them all the time. You still want to be careful,
because if the lock is important enough, it can cause users to be able
to effectively DoS some subsystem and/or just be a huge nuisance (we
used to have that in the tty layer).

And no, the size of the user copy doesn't much matter. A __put_user()
isn't much better than a big copy_from_user() - it may be faster for
the simple case where things are in memory, but it's the "it's paged
out" case that causes issues, and then it's the IO (and possible extra
user-controlled fuse paths in particular) that are an issue, not
whether it's "just one 64-bit word".

Epoll is disgusting. But the real problems with epoll tend to be about
the random file descriptor recursions, not the epoll mutex that only
epoll cares about.

              Linus

