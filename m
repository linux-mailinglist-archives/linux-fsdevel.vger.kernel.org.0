Return-Path: <linux-fsdevel+bounces-69367-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C20C7812E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 10:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 3855F31E3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 09:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342BE3314DF;
	Fri, 21 Nov 2025 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/hrNQDy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7388C303CA1
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 09:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763716513; cv=none; b=cJyCfd8lLTX0XC45jYHZFCv1tNp5sSr5j2upLHkKz1HTRsBktv3n6MI9W9ZRo3jbneRBl8kO7mk8qBLum4RZH7GrpL9uJQi33H/eE49haaSGECHZSyGn42A2zJc57l/yET+ajj9af5gz8bNjm88QaiRDIeVrF+sWU9izWDgHfto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763716513; c=relaxed/simple;
	bh=l3mtlyQACDqSC8Z3FigH+5gv2lLSFBcH83UaNtTudk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+1y6GxWpbvnupF1Zv3EToW8CYUh92jxcHRBmGP5GJXmHj2vWApgWWfMn6t1mo31sFe4qUwh6hyaX+GqOLGtD13HUQZZ6X28/l1yRfOya/jTxUAfHtH7K10hS2+lEjlWVy7zNABA6i8u2Pe4g8JPc2vYlqqXz4Vu0bVDWqqjd8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/hrNQDy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so19120415e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 01:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763716508; x=1764321308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgUhDhZ/Z2c/sdO8+MQy4XIdM7cZuKBXtLrKcPdb/cI=;
        b=e/hrNQDy1F/UeDPwDHy3cvUBWHlpKG+1MXgHF8V0+T2uBSqptRKAJzno92YjWhFrH4
         Fxd/7zO5abTtKAd1yvyJt11DnxBxTj7JISiNaqb12Udv7GgyA0BiRziS5fKS3ZIz95yS
         Gjyw3iSAcKuupb0kVD2NlNUY+nyhFCd4mgzrYWipg2+EKi1Lt5vluU0q0Mbmri/Pb8c3
         FK9MDrXcDblj7mxr9JsYQfpVNDJXuTK7Ge96PPhZimXVFGu4ee2Qs5s5DDLPaBfUw4fe
         H976t2GdnseJH2ptXx61BF85sqK1MpLePrPSEzmmpQYp/Kd/A27qotadA58xKYqMjm50
         mnrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763716508; x=1764321308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bgUhDhZ/Z2c/sdO8+MQy4XIdM7cZuKBXtLrKcPdb/cI=;
        b=PPKIAnVzL4H/f61gOEqOET8nOh1zJ6qHi4WxRJaZWaB1hJGqaUtOpVZ1kYNlJkCiJT
         xaM+4fxaI2IuaGbjxmiKqv49ZQexw2RY/KYVCSF3MtI24u1ODheR1IgpdnB8DFZcAtH4
         4AyRpTT0Luy9okotNynRDtwgkqrWmklFXnFVAryj/yoDZOTLxW3S4/h9OApMerC7tWmQ
         XWapChYxBGdOWE9X2e594s72mROGHowTiQ0JbpO+qLKMAGdxnl0lqYuUU5juc2XsT5uH
         Jd25oZ7b6NrRk5rvfKDw91bRBdkmE4JnQA+7pR3WYzXxbW1mfX4nPERWtxOCFDeuBgkh
         nMTg==
X-Forwarded-Encrypted: i=1; AJvYcCWWSHZ4W/gzJYURC6LdyMAq5zsqcuJugX9O6QJzdrsisu4EvDeter1/BAEM0Z04wMaJophwySLOf9miu+Oe@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2seGEzgzd7F2DeKNJJ8mltbdJ1hy7ANzd/4og+sPKt/R0tvzB
	sOacdajCFmUO+oUN0NwFkVbcjwKxZWs8qMTjj767bvVq6Eh37i0/FG6+
X-Gm-Gg: ASbGncuyLSFRU9XaYTUvCXZjVQ6oC3snj68XFkNPzfRnYIum6tL15XSsSETVf3ZY/9U
	U5fUch3rCxi+XKl1wmPubHC0P61ere7yC3eMK4ej+bQZZ0wxFmAPs4z1BGlSel7tvLaaDioVqKI
	daCqTL+bUra5fTAbdjHYVD45wgYlJsm1501Hgq22gN1TsuTFKrTWdUMambW2qMomVHLbHze75n9
	uq238O41CxiiR+XGJngN+XyhAfw+jtT1rFcFXBIbjz1SEhm6vMXIPtp1VLs9foHRaPn1nJmaDRQ
	zVGQtgnB/XP5bPl1mFJcforrUxZ/wwP0M9EiN3/30esa0ncu9ET4R5xcFaZQIlffor9KjeBEEFf
	Tip1Qb3y4PvZr+GJq1YiiImBv7oR4yZCvOSdvaQy9vlSZaIZzCY/FKNIqWVTkn97wjJ2Pt4O4lQ
	J9rHIxMZ53C1KqagITzjYOqvB7eSsd1xbeOssnrpi/fUdPbAOeuF4c
X-Google-Smtp-Source: AGHT+IGqFFmC+Cy2NqOyJP+LD7dMPGuUhV9SUXViPCq/6VcXBmrQx9sKWYrmdnhPjCKTFT3HR+9l3A==
X-Received: by 2002:a05:600c:3ba3:b0:477:aed0:f403 with SMTP id 5b1f17b1804b1-477c110d91dmr12313975e9.8.1763716507701;
        Fri, 21 Nov 2025 01:15:07 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf36d1fasm31719435e9.7.2025.11.21.01.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 01:15:06 -0800 (PST)
Date: Fri, 21 Nov 2025 09:15:04 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Axel
 Rasmussen <axelrasmussen@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Mike Rapoport
 <rppt@kernel.org>, Tejun Heo <tj@kernel.org>, Yuanchu Xie
 <yuanchu@google.com>
Subject: Re: [PATCH 39/44] mm: use min() instead of min_t()
Message-ID: <20251121091504.41ada607@pumpkin>
In-Reply-To: <20251120234522.GB3532564@google.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
	<20251119224140.8616-40-david.laight.linux@gmail.com>
	<7430fd6f-ead2-4ff8-8329-0c0875a39611@kernel.org>
	<20251120095946.2da34be9@pumpkin>
	<20251120234522.GB3532564@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Nov 2025 23:45:22 +0000
Eric Biggers <ebiggers@kernel.org> wrote:

> On Thu, Nov 20, 2025 at 09:59:46AM +0000, David Laight wrote:
> > On Thu, 20 Nov 2025 10:20:41 +0100
> > "David Hildenbrand (Red Hat)" <david@kernel.org> wrote:
> >   
> > > On 11/19/25 23:41, david.laight.linux@gmail.com wrote:  
> > > > From: David Laight <david.laight.linux@gmail.com>
> > > > 
> > > > min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
> > > > Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
> > > > and so cannot discard significant bits.    
> > > 
> > > I thought using min() was frowned upon and we were supposed to use 
> > > min_t() instead to make it clear which type we want to use.  
> > 
> > I'm not sure that was ever true.
> > min_t() is just an accident waiting to happen.
> > (and I found a few of them, the worst are in sched/fair.c)
> > 
> > Most of the min_t() are there because of the rather overzealous type
> > check that used to be in min().
> > But even then it would really be better to explicitly cast one of the
> > parameters to min(), so min_t(T, a, b) => min(a, (T)b).
> > Then it becomes rather more obvious that min_t(u8, x->m_u8, expr)
> > is going mask off the high bits of 'expr'.
> >   
> > > Do I misremember or have things changed?
> > > 
> > > Wasn't there a checkpatch warning that states exactly that?  
> > 
> > There is one that suggests min_t() - it ought to be nuked.
> > The real fix is to backtrack the types so there isn't an error.
> > min_t() ought to be a 'last resort' and a single cast is better.
> > 
> > With the relaxed checks in min() most of the min_t() can just
> > be replaced by min(), even this is ok:
> > 	int len = fun();
> > 	if (len < 0)
> > 		return;
> > 	count = min(len, sizeof(T));
> > 
> > I did look at the history of min() and min_t().
> > IIRC some of the networking code had a real function min() with
> > 'unsigned int' arguments.
> > This was moved to a common header, changed to a #define and had
> > a type added - so min(T, a, b).
> > Pretty much immediately that was renamed min_t() and min() added
> > that accepted any type - but checked the types of 'a' and 'b'
> > exactly matched.
> > Code was then changed (over the years) to use min(), but in many
> > cases the types didn't quite match - so min_t() was used a lot.
> > 
> > I keep spotting new commits that pass too small a type to min_t().
> > So this is the start of a '5 year' campaign to nuke min_t() (et al).  
> 
> Yes, checkpatch suggests min_t() or max_t() if you cast an argument to
> min() or max().  Grep for "typecasts on min/max could be min_t/max_t" in
> scripts/checkpatch.pl.

IMHO that is a really bad suggestion (and always has been).
In reality min(a, (T)b) is less likely to be buggy than min_t(T, a, b).
Someone will notice that (u16)long_var is likely to be buggy but min_t()
is expected to 'do something magic'.

There are a log of examples of 'T_var = min_t(T, T_var, b)' which really
needed (typeof (b))T_var rather than (T)b
and T_var = min_t(T, a, b) which just doesn't need a cast at all.


> 
> And historically you could not pass different types to min() and max(),
> which is why people use min_t() and max_t().  It looks like you fixed
> that a couple years ago in
> https://lore.kernel.org/all/b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com/,
> which is great!

I wrote that, and then Linus redid it to avoid some very long lines
from nested expansion (with some tree-wide patches that only he could do).

>  It just takes some time for the whole community to get
> the message.  Also, it seems that checkpatch is in need of an update.
> 
> Doing these conversions looks good to me, but unfortunately this is
> probably the type of thing that shouldn't be a single kernel-wide patch
> series.  They should be sent out per-subsystem.

In effect it is a list of separate patches, one per subsystem.
They just have a common 0/n wrapper.
I wanted to link them together, I guess I could have put a bit more
text in the common commit message I pasted into all the commits.

I didn't post the change to minmax.h (apart from a summary in 0/44)
because I hadn't even tried to build a 32bit kernel nevery mind
an allmodconfig or allyesconfig one.

I spent all yesterday trying to build allyesconfig...

	David

> 
> I suggest also putting a sentence in the commit message that mentions
> that min() and max() have been updated to accept arguments with
> different types.  (Seeing as historically that wasn't true.)  I suggest
> also being extra clear about when each change is a cleanup vs a fix. 
> 
> - Eric


