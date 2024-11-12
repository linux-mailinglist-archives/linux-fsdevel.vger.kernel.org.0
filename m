Return-Path: <linux-fsdevel+bounces-34536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577919C6349
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 22:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6319B3BA3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 19:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F1E20B218;
	Tue, 12 Nov 2024 19:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hu5pVYR0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAF9217F47
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 19:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731441279; cv=none; b=fQI6H4jnZeD+IlipctWSmubD5RJxFvCu2N8ilWb+GeXlFbMzNoIen5LRbnrMjqo7Y+Fb8D+v6s49I3arw8vMpEDmg3MNl4StnbTmZbHIVzizlszLO3f8hGpvvHbUILVtXUUPxU7KCrSP1xEAn9/Y0Ieg6KVJZEI5rvKCv7Uhg8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731441279; c=relaxed/simple;
	bh=w5M4DdbV0JDQqGXDCjJMEXFd24rwLm/qJCT5r02ClmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ay7V/kt8bfB0ewj/p9wPNnb7zxwWRlhpflPizxzrvoq2rvQTGeJlrqvyRQMK4m3QlQlZfpwzvqk3ymzzWMxhm4jiyq9mBaqSdSQCaEbkqIVk9X1cpklYY6wIbllA5tOBzIM1TZPzVF6uQk/bMbAk9xAfEXu/TegIZ8jnfxZpdAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hu5pVYR0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cefa22e9d5so6850407a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 11:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731441275; x=1732046075; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5b0rySYUL4FjfsS4jGUX3HJrYE8uK75+UecupTqejZA=;
        b=hu5pVYR0mz1FJoA4GR9DYhAkDz0lBba3sZ2VH2T1/cnRy9T4/TFP6K2mburFcsFm0x
         VDwWRVjsidGKgAp6MG2gBS4eNRGHG+E+0qonvyPFM8q3nTioyhZQOfLnZhxZIwVBROqA
         zRDZN0N68mWHAwuU4i7qGCU6mmoamB4dTM+8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731441275; x=1732046075;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5b0rySYUL4FjfsS4jGUX3HJrYE8uK75+UecupTqejZA=;
        b=YaNsKNrQtRCh9z/RPGk4nYir7mwKU2FEiClOrQ1WM0NNsyKUoZym/xEcT/TyYMfSxN
         52PwiNTIpdNshUudQWbLgOIdBxY4FzcFcuVcHM2Lw5/hjZbfMBqMA+i6Gm5QwFST0Hew
         S249fsftZZOotclRFCq4MC+ecCQVQojbzXpXwFzIKsk72W6PdL3Tgc6aKtcSG0k/HPCo
         rpoJKLTE3L9JsPlR4QWSLKawMaV0ASbU9y/GJYsQhUxgGROpbtP55qtJJbomvzLJD9uy
         WOLzhozYI85NBm94jjxdnE2n5dIEsAeaSF7NbLmLpX49b0VJ2vkqYj/dd541arzcfE03
         6R2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSKgbOkp8nc3vLS15yDh1telT2gIQu05HKeuz1YKcD8FlT6i+WRcW7Z+UeRybhvqZnCXB6r0qKeNdlPfR3@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgjk0jJTFjDdZjlceK98AaKiLoBI98R3+d7/ebXo0D0i6OfKS0
	1o6dOH+7a6IKPpxpknQIfZ0/wkBOxzXpH9saIqkLRTnYTZLfP1TWUF3jzUGtYyeT5Ovf0O1CySP
	T9UriGQ==
X-Google-Smtp-Source: AGHT+IGwYGVlvHbM6cJhLLwhLl88j2XWSjgxyxVzE+tBellmAGQZoTH+LGBWyiEAHVzCld+w0VelcA==
X-Received: by 2002:aa7:da53:0:b0:5ce:dfee:7926 with SMTP id 4fb4d7f45d1cf-5cf0a446f8amr11260477a12.24.1731441275149;
        Tue, 12 Nov 2024 11:54:35 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03a26cffsm6395007a12.0.2024.11.12.11.54.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 11:54:34 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9aa8895facso1118660366b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 11:54:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV5NpezhPHUMrFrJ8qkSNPPjdZX5ZqrgkcjPcw32qMAovcgqqJzneJ+OryggwUdWGimAsS37o1K9H07J9kX@vger.kernel.org
X-Received: by 2002:a17:907:1b21:b0:a99:ff70:3abd with SMTP id
 a640c23a62f3a-a9eeff25d17mr1761977066b.31.1731441272860; Tue, 12 Nov 2024
 11:54:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <60a2309da948dc81e4c66b9e5fe3f1e2faa2010e.1731433903.git.josef@toxicpanda.com>
In-Reply-To: <60a2309da948dc81e4c66b9e5fe3f1e2faa2010e.1731433903.git.josef@toxicpanda.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 11:54:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgNFNYinkWCUvT2UnH2E2K_qPexEPgrm-xgr68YXnEQ_g@mail.gmail.com>
Message-ID: <CAHk-=wgNFNYinkWCUvT2UnH2E2K_qPexEPgrm-xgr68YXnEQ_g@mail.gmail.com>
Subject: Re: [PATCH v7 07/18] fsnotify: generate pre-content permission event
 on open
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 09:56, Josef Bacik <josef@toxicpanda.com> wrote:
>
> +       /*
> +        * This permission hook is different than fsnotify_open_perm() hook.
> +        * This is a pre-content hook that is called without sb_writers held
> +        * and after the file was truncated.
> +        */
> +       return fsnotify_file_area_perm(file, MAY_OPEN, &file->f_pos, 0);
>  }

I still object to this all.

You can't say "permission denied" after you've already truncated the
file. It's not a sane model. I complained about that earlier, it seems
that complaint was missed in the other complaints.

Also, this whole "This permission hook is different than
fsnotify_open_perm() hook" statement is purely because
fsnotify_open_perm() itself was broken and called from the wrong place
as mentioned in the other email.

Fix *THAT* first, then unify the two places that should *not* be
different into one single "this is the fsnotify_open" code. And that
place explicitly sets that FMODE_NOTIFY_PERM bit, and makes sure that
it does *not* set it for FMODE_NONOTIFY or FMODE_PATH cases.

And then please work on making sure that that isn't called unless
actually required.

The actual real "pre-content permission events" should then ONLY test
the FMODE_NOTIFY_PERM bit. Nothing else. None of this "re-use the
existing fsnotify_file() logic" stuff. Noe extra tests, no extra
logic.

Don't make me jump through filve layers of inline functions that all
test different 'mask' bits, just to verify that the open / read /
write paths don't do something stupid.

IOW, make it straightforward and obvious what you are doing, and make
it very clear that you're not pointlessly testing things like
FMODE_NONOTIFY when the *ONLY* thing that should be tested is whether
FMODE_NOTIFY_PERM is set.

Please.

              Linus

