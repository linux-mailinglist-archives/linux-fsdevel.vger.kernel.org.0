Return-Path: <linux-fsdevel+bounces-65724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E11DDC0F20D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 012CC1898692
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 15:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C9C30CDB8;
	Mon, 27 Oct 2025 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BVAFZMhn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10EC22AE45
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580276; cv=none; b=V5Hy8ZS2hr1STmvItoKNRN4z//zYHkw7QEvOMsq/+3NeS5+N1VGYb7p+rm7DUs838fG3MM3hIQ56rGg5U2aJ+hFIavJPSj+jo/vFaMipeSJgzqdpfkqbC3kzwoX32Gjes95g50shpEQathAPTBZYI1JMJuBhmQz9P6yD+pwhiVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580276; c=relaxed/simple;
	bh=Td6PjAe6oZGWpKeVHOgaPYgxhjJM0vHRuXn7TA1UKwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UM5phsrLiCHYp3PX8h2tcYLVNSopImdEAldA7A2iV8sUSbAi9TWGkNKPqAxbrVcPNkYVFUQSvsKsEUMZajJn6YN8HqY+yj6sfepW1tberSZibcLlnNjpkzExCMlOYjpwyt9t0TYV9eLvP5aBv5wP0EhPOIcWdcFvC/HkRq0SvWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BVAFZMhn; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b6d70df0851so671497466b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 08:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761580272; x=1762185072; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fz5OAU8C9T/9dkzlT3ECgLDp03ETYSkJWqABI4th3fM=;
        b=BVAFZMhnEibudAIKDE12Swz50GHsRnjUEnRfYvKH2QBdzp6/v4mA4fzaIGLsIb4TI2
         wp/0Gc4UA4A10tIPWa2gIutnXJyLiCBBI7N+jXR5cNNR2uSBAZEUsIRWAz6tWk/EanS5
         MGm9eT1+QcYA1pupGDq/tmhLGeWITQA4EpkZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761580272; x=1762185072;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fz5OAU8C9T/9dkzlT3ECgLDp03ETYSkJWqABI4th3fM=;
        b=KfdjXoeue8lNl01xCrFhfqfKU75oL/JZxEXWTFMoczNG28gegqDrqEIJYHaAHSY9KK
         8b8SHdZ+o+AjLdbWe/9mqo7L5hettVu8RvfAeXA8sNdpWGcrCZUOlx94DBmBkdXSRK6u
         eK9nUhSZMWvlKwGQyb3rbZVL3vbUQJREJ8z52t7MgcCv0PRt3UupazBvOnub76ZY/dWn
         YMUG1E5I3zWpYM3yT3KtklQxPX3LrSuxO+b9zaHnen7HVcMMqnM9B2zcLkVPUcDHrfcM
         Aai9c3maGmHC8dTomEpmCKAp53f1aJLcU1xkOwHU4bGO0YRKYGFGdO8cXzejTfG1piQg
         TSxA==
X-Forwarded-Encrypted: i=1; AJvYcCWIsO4ugWQ/kTa8uyUnZmAOQd/CRhm/x2WB4JCqcRHZ/Lszwv8QLOQyg1kih89/yvraE5oihxYsrt/BNMBD@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu4inAGhmmAm8XFNuWFLnH0lReew450vA3LVUSA6fw5/2KqhW/
	BPzm5tPH3TEu9N31u1sNQMLGTOIj8GpQl0r/S7dsm/HsH9sv1vGGSdg6jbULPzY3sGLXYK0E7Wj
	CYEvpVsA=
X-Gm-Gg: ASbGncvSqrZdf06gQWYtvMQB9Nhght6BAR+5sJAovpL2y5HZ53cnTMqK1EjU4UWDb0q
	mAgVHA+W1SGcg6UDx2UJqkjtWTzWx5SxA8mUpriPvoO/v+EY1XkbCdhGQsRrMRvM12+asDneHqu
	Zcgfc74cJ5lXDtjZi0Dtz/U8PS0lS4D/J1AtoYfddyko9AvB4i9OjUSS+vjdIcDWHCQC8661uY4
	7PFr3yh5ySeICFZ7dSyu9PBXx2f/HNdj9vTV3HjgK0z+D6DuHli1CMDsgzxNivz0fXereJ4bRSY
	oOEqlep/vhzadGcPcoknME7snR7ujMFbRIk4qRC0DJ+WW6tNbq73JQwCppbDidKFPKZ0WNxLoZB
	IGRahOrXwVMuqNwjB4JlP0pyyJEXtm3VK4Q0CL424FQijv/xxeNVcy4/O98ks9T1FYuniUjOy1R
	5hrrPgPHn8dQClkf34TilJhYZKqcYxw3AVM4T05BGC5FoimWNNZg==
X-Google-Smtp-Source: AGHT+IEqXJc7bK/JTur4Xb1+yxkHHyb66ASNS0XwbZvUUJzSmcBczywS7KIHryflm4hDeZmDlI/ltA==
X-Received: by 2002:a17:907:7255:b0:b45:66f6:6a0a with SMTP id a640c23a62f3a-b6dba58bff9mr38744066b.44.1761580271846;
        Mon, 27 Oct 2025 08:51:11 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8530905dsm798709766b.6.2025.10.27.08.51.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 08:51:10 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63b9da57cecso7401301a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 08:51:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXl+Jj/Iw7jydMmL5eZq7KsfXPHUQk/e4zbAJPilnfl/BUTaBfzcdK33a6WXZlyM2zty+ynUaOtjqxwF/MB@vger.kernel.org
X-Received: by 2002:a05:6402:5208:b0:63c:45da:2878 with SMTP id
 4fb4d7f45d1cf-63ed8262ceemr407724a12.25.1761580269751; Mon, 27 Oct 2025
 08:51:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141536.577466-1-kirill@shutemov.name> <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com>
 <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
 <CAHbLzkpx7iv40Tt+CDpbSsOupkGXKcix0wfiF6cVGrLFe0dvRQ@mail.gmail.com> <b8e56515-3903-068c-e4bd-fc0ca5c30d94@google.com>
In-Reply-To: <b8e56515-3903-068c-e4bd-fc0ca5c30d94@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Oct 2025 08:50:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiWmTpQwz5FZ_=At_Tw+Nm_5Fcy-9is_jXCMo9T0mshZQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmga7yjIxTmcYa49QdMzCJ_rjqDZmpAlOCSXqWKYw9598-EirU5Tn5Et44
Message-ID: <CAHk-=wiWmTpQwz5FZ_=At_Tw+Nm_5Fcy-9is_jXCMo9T0mshZQ@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Hugh Dickins <hughd@google.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, David Hildenbrand <david@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Yang Shi <shy828301@gmail.com>, Dave Chinner <david@fromorbit.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 03:49, Hugh Dickins <hughd@google.com> wrote:
>
> This makes a fundamental change to speculative page cache assumptions.

Yes, but I'm a bit surprised by people who find that scary.

The page cache does *much* more scary things elsewhere, particularly
the whole folio_try_get() dance (in filemap_get_entry() and other
places).

I suspect you ignore that just because it's been that way forever, so
you're comfortable with it.

I'd argue that that is much *much* more subtle because it means that
somebody may be incrementing the page count of a page that has already
been re-allocated by somebody else.

Talk about cognitive load: that code makes you think that "hey, the
tryget means that if it has been released, we don't get a ref to it",
because that's how many of our *other* speculative RCU accesses do in
fact work.

But that's not how the page cache works, exactly because freeing isn't
actually RCU-delayed.

So while the code visually follows the exact same pattern as some
other "look up speculatively under RCU, skip if it's not there any
more", it actually does exactly the same thing as the "copy data under
RCU, then check later if it was ok". Except it does "increment
refcount under RCU, then check later if it was actually valid".

That said, I wonder if we might not consider making page cache freeing
be RCU-delayed. This has come up before (exactly *because* of that
"folio_try_get()").

Because while I am pretty sure that filemap_get_entry() is fine (and a
number of other core users), I'm not convinced that some of the other
users of folio_try_get() are necessarily aware of just how subtle that
thing is.

Anyway, I'm certainly not going to push that patch very hard.

But I do think that a "3x performance improvement on a case that is
known to be an issue for at least one real-world customer"  shouldn't
be called "a niche case". I've seen *way* more niche than that.

(I do think RCU-freeing folios would potentially be an interesting
thing to look into, but I don't think the patch under discussion is
necessarily the reason to do so).

               Linus

