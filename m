Return-Path: <linux-fsdevel+bounces-59462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B89FCB39112
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 03:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5A01B22CDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 01:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D5118C02E;
	Thu, 28 Aug 2025 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SBkV05tV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E52320469E
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 01:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756344613; cv=none; b=LgKhX+gyxhVEFynKDSy0GOH+5PO1CHW0wDAdXoU7+NRBiThim/dOofwb+XOQTQksXjprK8GJ0644SiBCucP5s+/D4JQwuTLcCz63tB/wDAnp+YKlY/FmbF9CXcrKkmL6htCLZwbDfYYkMJEG9g27qL+8220xWqG9HtWcaWkEfns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756344613; c=relaxed/simple;
	bh=Di3BdQYvMB/PH9pWToNeloCPz/bgwL8r1tAr7QdO3LY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEk07iUtLA2gJIiOS5ETut5L0MnAx0ctSE3UscavrAke4KVpriZVilV3pj6k+mGfMYG+aFYtA/1G1FBonSYir6tNmsWQIv0+mACdws7qUxlm6BXHNSqgS6HA2Efv1huCltJTiu9llR5cU0pzn7r5aiIQdNmOHr0QsG/Wg+xpG+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SBkV05tV; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afedbb49c26so61417566b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 18:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756344608; x=1756949408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qOAH5ueaVQq1EK0iNLEdVTlIV4Dj3RwG3XIlYPBwR4o=;
        b=SBkV05tVjiI2nvQddcCh341tioET+HztP+Rnlyd7qXwbtrsr5zDDl0jncrKoHqRzX2
         C4JFHII48DpuwnbSH3xRCWLUIoJJ8mdF8NMpFtmk2nH8FH92/69tr7JsjqTHQ96kx2xq
         QUorZsp/QCwAjMEJ9o5uf221O71MFeV/C80wM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756344608; x=1756949408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOAH5ueaVQq1EK0iNLEdVTlIV4Dj3RwG3XIlYPBwR4o=;
        b=N9HlgMmjtaKdb5sg7xrgUcmzbpZ863AiRQVxU4FEDmdM6VsX4KWpGF8GmV/EPK+4ik
         S8J5sTb7aI9V6lTaUZG8ubjXC4d7a4RZYckw1pk0afgEJvHRiOAEqgvZJhdjiUnI2en2
         EzO3jXoow5K6FE+d9ASr4qH4grO5SD8Sih8zWZFcP8K+3Vi9TrRE/nnDJs4FE6EKfOIF
         0QLrRr+coZ/KG1oSXVw7vhsF4ENQbk9tWvNYq7A7eWg7xdoHLE49mozzDo9QfEEGIka0
         +BphqvbuNz1W7d/aOVyH2grV9N4NQqz4QR2I58K7wEW0d4dYOZ/TNRUhnqm7e/yg/gqG
         pl9w==
X-Forwarded-Encrypted: i=1; AJvYcCX5CDakVHF4BMBZ2GuomCEh/okKuusu5TjYD+pC4Pj/udc0yUXxVa1ZH0wWBqIR7WlumjerHpnSJ/ljDPh2@vger.kernel.org
X-Gm-Message-State: AOJu0YwFK8+1C8Gil+c2TgTPF1XbdDOEBMVOMfUAHCMlYkuDpEz+TxJd
	csyie1iqhLD7+oUdj9WwtI6CxGqDv+VVhq96yrjS4emtp++LGL+/30iiZr3mD8tM5MzZN9DVH89
	gTF+xYrE=
X-Gm-Gg: ASbGncta4V40gyvWOLen2VLgoVwjrrDtuLl2pba2ceXnJXfwO3IsxuHAUes1n79/byY
	/Wqdlep7h9kN2APCsLzNOwmgSjjRUmxp5RMgHM7s7xQyJ+7pG4Nez8nndB/SDphb8c6Wf7ned7h
	uw7WNgcDX/852VbYPrypkc760a3JNkFAhhfvIB2qwWa7d5cTFi+jlsswPh6yr3BnXHRTGaiknyy
	taVxqGzAZQEpOceFadW32CDi2+uQxFvGOocTrVuphmwjcfXgrvg3zFs6ffYDkBBgiHhE0CZvTMz
	NFrFcy/QcnAxTw/DogXZcd316NcKVYwrOPzre+OxpOLbiH+YcgefncVpL3EgyrOdpqWNZhSJUM7
	wzFNKvOy/dtiQsR6GLRScJcvXA+8CUO+kLaBzQnO9kI7zXUjS+wsmRjxjQey1BIauSlhFTHJSh1
	34Fv2xO/c=
X-Google-Smtp-Source: AGHT+IHIOm+tzjqUWofeCQHdNdhCBg2LXGi0LVJ/jIFAGRL66/lvjHO77kZ0WDNCYCIVTEYKKyyofQ==
X-Received: by 2002:a17:907:d10:b0:afe:dd9:de24 with SMTP id a640c23a62f3a-afe2979fd28mr1809824166b.60.1756344608412;
        Wed, 27 Aug 2025 18:30:08 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe6fddf163sm891191366b.53.2025.08.27.18.30.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 18:30:07 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ae31caso68910966b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 18:30:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMymw46AGs0b3aTTM8UYAjI4YhRu27FvBMwCU7oYavctYCi1cdiLnP7xtCf+1OqLsXzA+fqlEVvCgya71c@vger.kernel.org
X-Received: by 2002:a17:907:7e8d:b0:afe:e0d5:c72 with SMTP id
 a640c23a62f3a-afee0d521fbmr80467466b.13.1756344607384; Wed, 27 Aug 2025
 18:30:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825044046.GI39973@ZenIV> <20250825-glanz-qualm-bcbae4e2c683@brauner>
 <20250825161114.GM39973@ZenIV> <20250825174312.GQ39973@ZenIV>
 <20250826-umbenannt-bersten-c42dd9c4dc6a@brauner> <CAHk-=whBm4Y=962=HuYNpbmYBEq-7X8O_aOAPQpqFKv5h5UbSA@mail.gmail.com>
 <CAHk-=wgWD9Kyzyy53iL=r4Qp68jhySp+8pHxfqfcxT3amoj5Bw@mail.gmail.com>
 <20250827-military-grinning-orca-edb838@lemur> <CAHk-=wiwiuG93ZeGdTt0n79hzE5HGwSU=ZWW61cc_6Sp9qkG=w@mail.gmail.com>
 <20250827-sandy-dog-of-perspective-54c2ce@lemur>
In-Reply-To: <20250827-sandy-dog-of-perspective-54c2ce@lemur>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Aug 2025 18:29:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcTwA5E7YT8KT6=87nQaJ78A0hqUAVGo9bYRWt9dTe3Q@mail.gmail.com>
X-Gm-Features: Ac12FXxLZ5soUfFpEiGpNqk9wKd1nQ7kHrjW4S0h4bdKrujT86HGkiiKEXYMNoQ
Message-ID: <CAHk-=wjcTwA5E7YT8KT6=87nQaJ78A0hqUAVGo9bYRWt9dTe3Q@mail.gmail.com>
Subject: Re: [PATCHED][RFC][CFT] mount-related stuff
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Aug 2025 at 17:41, Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> I'm not sure what you mean. The Link: trailer is added when the maintainer
> pulls in the series into their tree.

That's my point. Adding it to the commit at that point is entirely
useless, because

 (a) that email doesn't have the *reason* for the patch (or rather, if
it does, then the link to the email is pointless, since the *real*
reason was mentioned already)

 (b) at that point clearly it doesn't have any *problems* associated
with it either, since if it did, it shouldn't have been included in
the first place.

So there is absolutely zero information in the link.

It's pure pointless noise.

> maintainer marks a reliable mapping of "this commit came from this thread" and
>
> It serves a real purpose.

It damn well does not serve any purpose at all, because there is
nothing useful there.

Your logic isn't logic - it's just empty words.

I can come up with tons of "reliable mappings".  How about we make the
automation add the weather.com report for the weather in Kuala Lumpur
when b4 downloads the series? We could do that reliably too.

Notice how the reliability of something is entirely irrelevant. Just
because you can reliably automate it doesn't make it relevant
information.

And dammit, it's WORSE than worthless information. I _constantly_ end
up being disappointed by those useless links, and I've wasted time
following them in the hope of finding something useful.

So it's actually reliably NEGATIVE information that wastes peoples time.

> We cannot *reliably* map commits to patches.

What we care about is about things being *USEFUL*.

"Reliable" is entirely irrelevant if it's not useful.

Because reliable but useless is still useless.

And always will be.

So I'll take "Useful information that you might not always have",
every single time over "Useless, but always there".

Get it?

                    Linus

