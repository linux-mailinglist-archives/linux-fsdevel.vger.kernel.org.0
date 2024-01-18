Return-Path: <linux-fsdevel+bounces-8274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BDA831FBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 20:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37092284345
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jan 2024 19:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DB92E407;
	Thu, 18 Jan 2024 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZqsTfPCe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487D02E3FB
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 19:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705606193; cv=none; b=mY2EkVvjIVvNeJbF75Tk9xtA0F0XUKh6zpu5S4I8Mektw3bIxEQd6hUGCscbPFNjlj4ey673VztxWFKIjYBlKok4lSJ1IB1t6Ran1JQ1dNZinu1xkkSFu2ir3Mmvw+2gd7hhLJDbebA/uRuKgenqJRyGmFr/hrKHaO5WosTPOsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705606193; c=relaxed/simple;
	bh=xuRSN7NQz/fi5BfrOkzX+ImfdEzHw7bRMO31mZtMmJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7yMaCObujryClpbWn5NqUWy7AID+/JchMWhubS9TySfkmI7AYJAoPKwkw2xtKlrfstIGU44aFjv+E12YIylux7x1HZfsEUqesycL4aDBVyz+XbUk+xl+1xSr7vl9+Y7suVeHvp6jG/Wnt00mfnCgBcsP6jWKyJzvOltBZxFaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZqsTfPCe; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50eaaf2c7deso14471012e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 11:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705606189; x=1706210989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C7mbs8nJgeTzy4tzsS854RhwRMR+E+uBA1VIh9yLgEQ=;
        b=ZqsTfPCe/02l+egs8d3LFTSpt/lWMXXcYHNYSV/Kye7KrI26HDhBvCUnK6IN76rP31
         fuedU4fjvkWT5wBiiY5aJpGWlDgRNQfAJ3vuKdpEU4FuUAK9g68KzXQ9fMGsHqVjGp9W
         jgSajDuvL0Oj5Hb65UqWCu7rIqTgMIX+Nm+QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705606189; x=1706210989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C7mbs8nJgeTzy4tzsS854RhwRMR+E+uBA1VIh9yLgEQ=;
        b=Y4RJYkOzzF/pGwhtdzI5zmDSzVANZTN3NIamEiBwz2XvTIGiDU53x3ag03Y2oK4/r/
         hqPgCf49xZ5O666XhZzh5r0L0lfpD3mCSyAjvqjxcRqT6t0jZw/nlbM+U/Zf+JHe6Rra
         bflYtMHSl9WLjYmAGB79bYMi58DzL1xBO/clHizlPRdLbAY2T7jmh8v/kYRT71EYDb2N
         YbHKFDyq7SPh3i/GmBmRSCCMWolLguy3a7wg5zE5jeMnvKrM21W6LxTbEeUWHOixdzl6
         0X9MKRRKnBTqwVDdjUyU9qcxg5al1Z8ms/EoI7WEzw8Kf8VGVXeJw71ZBuHx/SD8B0le
         R5HQ==
X-Gm-Message-State: AOJu0YxPkfKIyBS+2lGaTxMiZubiEehNWrFmPs/9QMvp+SBCmNk/ZiWn
	ZrSK+J8Slp9NQ71pk9MlMxkxYYUNQCCgHS/cb7jHustYp3W4vJIUJGh8DG/1OmqNFQiU8ZYFEj1
	zuB0Sxg==
X-Google-Smtp-Source: AGHT+IGNR5O7Zy5zLWw4pwG+Bdhm4zSoOyRHA+ZGq0TQCZcnRmMeldyHsgv0edNRUy9w6AGQIFRueQ==
X-Received: by 2002:a05:6512:b92:b0:50e:7c9b:a8b7 with SMTP id b18-20020a0565120b9200b0050e7c9ba8b7mr92496lfv.99.1705606189123;
        Thu, 18 Jan 2024 11:29:49 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id d3-20020a170906544300b00a2693ce340csm9372721ejp.59.2024.01.18.11.29.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 11:29:48 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-559d95f1e69so2594288a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jan 2024 11:29:48 -0800 (PST)
X-Received: by 2002:a50:99d1:0:b0:55a:196:6ed6 with SMTP id
 n17-20020a5099d1000000b0055a01966ed6mr865823edb.82.1705606187982; Thu, 18 Jan
 2024 11:29:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118004618.19707-1-krisman@suse.de> <20240118035053.GB1103@sol.localdomain>
 <8734uufy1o.fsf@mailhost.krisman.be>
In-Reply-To: <8734uufy1o.fsf@mailhost.krisman.be>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Jan 2024 11:29:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=whgQXOouz7KVHKb_SYEo1qujH_1c9TjMLmaQmdbdRE_uw@mail.gmail.com>
Message-ID: <CAHk-=whgQXOouz7KVHKb_SYEo1qujH_1c9TjMLmaQmdbdRE_uw@mail.gmail.com>
Subject: Re: [PATCH v2] libfs: Attempt exact-match comparison first during
 casefold lookup
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: Eric Biggers <ebiggers@kernel.org>, tytso@mit.edu, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jaegeuk@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jan 2024 at 07:42, Gabriel Krisman Bertazi <krisman@suse.de> wrote:
>
> But I don't see how this could be a problem.  the str pointer itself
> can't change since it's already a copy of the dentry->d_name pointer; if
> the string is external, it is guaranteed to exist until the end of the
> lookup; Finally, If it's inlined, the string can change concurrently
> which, in the worst case scenario, gives us a false result. But then,
> VFS will retry, like we do for the case-insensitive comparison right
> below.
>
> ..Right? :)

Wrong, for two subtle reasons.

The issue is not that the string can go away. The issue is that the
string and the length have been loaded independently - and may not
match.

So when you do that

        if (len == name->len && !memcmp(str, name->name, len))

the 'name->len' you test for equality with 'len' may not match the
length of the string allocated in 'name->name', because they are two
different loads of two different values, and we do not hold the lock
that makes them consistent.

See the big comment (and the READ_ONCE()" in dentry_cmp(), and notice
how dentry_cmp() intentionally doesn't use 'name->len' at all.

Subtle, subtle - but this is *incredibly* performance-critical code.
Locks are completely out of the question - they would make the whole
RCU pathwalk completely pointless, and the RCU path-walk with no
stores to the dentry cache is what makes the dentry cache perform so
well.

So it's not even that locks have contention, it's literally that RCU
path lookup treats the dentries as read-only and you actually get
shared cachelines and true parallel lookups. No reference count
updates, no *nothing* like that.

This is why dentry_cmp() does that magical dentry_string_cmp(), which
is very subtle: it knows that regardless of *which* source of naem we
have, the word-aligned reads of d_name->name are safe, because
 (a) the allocations are word-aligned
 (b) the dentry name allocations all end with a NUL byte (unlike the
pathname ones that can have '/' at the end of the name)
 (c) the *pathname* length is reliable, and the previous word didn't
have a NUL byte in it because that would have ended the compare
 (d) so that "read one word from cs" is safe, *despite* the fact that
the length we have isn't something we can rely on (it comes from the
pathname side, of course).

And yes, this code is subtle. There are very few people who really
understand all the dentry rules. But it is *the* most critical piece
of code in the kernel for a lot of real-life loads. Looking up
pathnames is pretty much "Job #1" of an OS - a lot of the rest is
"details".

                   Linus

