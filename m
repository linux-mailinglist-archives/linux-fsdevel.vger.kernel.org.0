Return-Path: <linux-fsdevel+bounces-33082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BB79B392E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 19:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73032B22C33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 18:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403B31DF272;
	Mon, 28 Oct 2024 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Cyx0J71D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232841E48A
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730140261; cv=none; b=cv75scmIgHjj7jmaMwC6x3mekqme9h5FaXVGb1KjCAU7hNuL8sPAeo2d6lAXXhLgxoYgGPm8tKxser0oQijKgSfY7gdNDePpzy/GTypXELnSXPRSi4T1zrHZHewstuMiJfUdctD/Vfhx65u0q/QBIPMiysJgtRph1MJrCioZ/GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730140261; c=relaxed/simple;
	bh=LfZARw4tMgY5VI/jbk2L/oVq6yaCdNBgpXbadQY3SGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2C0YXwm4FaJJQw8wJyvo6VSu5b5muu/H0GwyB4T8Et0Y7AOHE1hFE6vJHcnmthgcdGvzRFs88M7lY7omv9JcbnsnZIW0GSkGDoifyGTdetuCen6Gw7XfWSOs3dUJ6F+ysG55v8TKxmTIu0lOSwIMAms1ZUVSS6EkKWOh4K9hZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Cyx0J71D; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c94c4ad9d8so5815780a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 11:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1730140257; x=1730745057; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3qOtBMsb3cFu4ZCOeEUIxWcsVvmdmfEJ04eYWGlm9H8=;
        b=Cyx0J71DDFCg5ABgTaecVNMecOeunkdyLRX4b7US6tdSmCd8U6bj7wyPguzApWaF4+
         vgs/PXuLhw+dzIqQ2dqqjeF3puQNjKnbzVyrNdV67vizOq79UqeIo7ZAhWGC2hDP02vh
         DcsEyZ3G8IymIPuZuPCawl/ilOELdDPwm+PhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730140257; x=1730745057;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qOtBMsb3cFu4ZCOeEUIxWcsVvmdmfEJ04eYWGlm9H8=;
        b=ZerDW7+X3xa/tc+xDK0JMY1K7ez04TFnvSkcEZ63ftepXl1bcFWquW4xnr+8uHkod3
         344PFQWIF6ELP/OJ8pFvDvqLVApiP2w1ITD0uRqEq+ojQ3L1fRES53x8QbpzmR4HyhA+
         p49cHF5+aMzAsQjYOkb7+5YoIu8JYpQOaWok+w0CZEMFqDx9AXmUfZbERcm0NMgqmcR7
         EhSUmmJIogc4lM31r9vj3MTJRYbtSN2B0ov0g2NSGgqzvtWR1+MGKQ5NavV+4rqzvRor
         6pxWWECLYScluWaHzBZODXAlQCsUGWhQQFj64YovRsbReAoFDil0y+G7TKElrNKrNH01
         FvHw==
X-Forwarded-Encrypted: i=1; AJvYcCUtqJA3jXZRsBs6zGZcfULbBlGNZj1g3BCnBoGyOzgvRwPodlzHhbQ8bu7fa4dTJWq7AAAmCzoAb9+sUpWx@vger.kernel.org
X-Gm-Message-State: AOJu0YxNeVICidjhWzuldKS68AETExj6AXr+SJmvDVUO5A+C/0AWgxNt
	US/uuos3oo6sXAWvANTGXhbnrcvJDp1kwIW4rAy+I1fO32DPtnkv65rfUTUc8zIGKcQtoJ9OcVF
	k22Y=
X-Google-Smtp-Source: AGHT+IHB90ztZJxfP7VkWULKAEtpX14UbHMXGKIcONxXNVxgULSnzjkE+KyfkxCfYWxMTB+lRWcsmw==
X-Received: by 2002:a05:6402:1ed5:b0:5cb:68d3:9d81 with SMTP id 4fb4d7f45d1cf-5cbbf88650bmr6091874a12.3.1730140257123;
        Mon, 28 Oct 2024 11:30:57 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb631a258sm3375176a12.78.2024.10.28.11.30.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 11:30:56 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a0472306cso634760566b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Oct 2024 11:30:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZOcMEAJk81UNlTp1DshntsG2t2lIB9jWYuO58gGuZlFIAMrWJVvOE+Rb//E+bVrpkaFmuSsOSBe4rNAQZ@vger.kernel.org
X-Received: by 2002:a17:907:724c:b0:a9a:3e33:8d9e with SMTP id
 a640c23a62f3a-a9de5f21c2dmr780235766b.28.1730140256311; Mon, 28 Oct 2024
 11:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007-brauner-file-rcuref-v2-0-387e24dc9163@kernel.org>
 <20241007-brauner-file-rcuref-v2-3-387e24dc9163@kernel.org>
 <CAG48ez045n46OdL5hNn0232moYz4kUNDmScB-1duKMFwKafM3g@mail.gmail.com>
 <CAG48ez3nZfS4F=9dAAJzVabxWQZDqW=y3yLtc56psvA+auanxQ@mail.gmail.com> <20241028-umschalten-anzweifeln-e6444dee7ce2@brauner>
In-Reply-To: <20241028-umschalten-anzweifeln-e6444dee7ce2@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 28 Oct 2024 08:30:39 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgYW0785PeardvADuE33=J-9DW7M3U9T9UKsa=1EyvOAA@mail.gmail.com>
Message-ID: <CAHk-=wgYW0785PeardvADuE33=J-9DW7M3U9T9UKsa=1EyvOAA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fs: port files to file_ref
To: Christian Brauner <brauner@kernel.org>
Cc: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Oct 2024 at 01:17, Christian Brauner <brauner@kernel.org> wrote:
>
> Thanks for catching this. So what I did is:

You had better remove the __randomize_layout from 'struct file' too,
otherwise your patch is entirely broken.

We should damn well remove it anyway, the whole struct randomization
is just a bad joke. Nobody sane enables it, afaik. But for your patch
in particular, it's now an active bug.

Also, I wonder if we would be better off with f_count _away_ from the
other fields we touch, because the file count ref always ends up
making it cpu-local, so no shared caching behavior. We had that
reported for the inode contents.

So any threaded use of the same file will end up bouncing not just the
refcount, but also won't be caching some of the useful info at the
beginning of the file, that is basically read-only and could be shared
across CPUs.

            Linus

