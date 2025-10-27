Return-Path: <linux-fsdevel+bounces-65743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 377CEC0F746
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 17:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DE8B4FAB33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF7131353E;
	Mon, 27 Oct 2025 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WrRh2ASj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39964312821
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583761; cv=none; b=gY457qJod4t7RrBW2P6wI8rEwheGjLEobrD9INLAmPStd0zPCqaXCL6/+guRCDSW1G3c3zmyIYwGC+DjRDUSHDG59AVhsEH/lc51dkxzWoVXmbAG4pTw0dEtx2TnXDdcWZ6jFRBM4SRTngEByvfQhIP4OHHHp72s/jfyvIbSojY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583761; c=relaxed/simple;
	bh=pwFDnz2qvTBq7s3AgupkMDfXcsi90GT6AfOCXgh8tCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AgqNr2ZifbsNy/nu7I07DlbPuiin1UXIFgsEuBFvyejZTuKp9irB4zUNUVzA8sJR6SBINBpFRWZuUU5MfHZECqLHQ8x/PkUenduvN9LJu7etrQVUaREJFbP0PmKE60ezkbTJCc4/HRmcYUnSrpYi7wB7BQVEC2kxUKbJjEHrBvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WrRh2ASj; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b4f323cf89bso1168008466b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761583757; x=1762188557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S6RVQIT9XTJ1IexdP/0qbvavFIRX5x9dwzaipWLoAeY=;
        b=WrRh2ASjnIXC0aQpq3HXxX3xAp8K+df5FwhFtqtGHwej1KA9tzwrz5UBLb4GPOfm7k
         AUmOmo2gRQleLtpSgL7+k6N/Rwe2jDHdpC04TErYdlC5Fr6vnWsZn/ZSxgeXYRNBiGq1
         6lbn5DYzU7TIrlgTqlM7xx5Ne5IaDbS79VJOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761583757; x=1762188557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6RVQIT9XTJ1IexdP/0qbvavFIRX5x9dwzaipWLoAeY=;
        b=J1Gf2UY/mhCEB6dlY7FXh4ejb2/Hrd8gavqvdeTvkCTiicqg5sbBQAxEDrojOgi7uZ
         lQXXshCJZOoJEaVWPyLoucbuqGY+2WrQVLWelnS3tKLcCkL36ulf+Twxzozgow1KBURK
         pCzbgypB7OM68i70jdaIv8tupeUgZQqxvQEAxx38DC2bBG8xuBtVw1R8ZB6CyYozWgqV
         oQyslz6W2jdKwbe7oYmGG4DThiTrPL5+Qcs1xT5LYHrHeYkz8xxvODwvqz/t3qfqsDps
         zk9NmGvL+WwxBHGOEAZK21DtwG8CTO6MEwCjwCSSVSIaIA2mswxR49itQ/7rUvFJ86TV
         k03Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOMqHEV1qQWpa79MY8V9hdPU6n3sH5B5QvjOFx1BOxFG9nU5UNssDsWHux4ySDQKebYsjICZp/Q5esDL9p@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/bYRn1PzRomwr2AFwxo38GjW6erDvZo+U102ibKX4pu1wKNy+
	eOXL4I0xSXtP2ucaBd94P0bDo6G0euv3INX+XhrAN4jUGQbqEZQyr2vkJGTLU8YyGBk4pTM4G6F
	52XgPayY=
X-Gm-Gg: ASbGncvuTK/0MVLkzOJ4+Tv6HpqrhLJI3sO8cP5AgmBhXLRxsiX0MDtm3UWMlFPoASl
	Ocis+XHIrr/uGEDkzASMseyxdhwh4vH0HrczxnWGt4kzL1/3LrVg+04aGFHFcA4LQ/vSvI3NWzR
	Fv/UoOeag0J70t9b5bHHD4srSHouvPovcop0b+sdIVUP9xXgiHPKmt3+2bwqKjgdn4Lj89yNaT9
	RI7V792+8pQfPDmqLcWvgbGerxhaSwC8xZsgCYIQQv9cFKHipqnN90EnbRzJfiMMBQUGigwsxiY
	fe0KqD/4I2ZNo0ti3PtRJf2Vu1UteyDot4Hgdk0VttGW5oxoTVBTlahwyl5lv4S1Jufi2VPdTU6
	5cPp7jZpyzRIszUa+gQG2/BHMuL8eTL45Xw1ToQ+QNgk6OovYdV/OZAXfElPci4J/Dc4q/Qs6IS
	kXqmev8eRTm6hx/67xh3kay7OLyBTt3HwtZrnimsRbB+YC9yqUmg==
X-Google-Smtp-Source: AGHT+IE8/WueN3ccPevmBCwCkfUT0DqdqC0gYmR1CAj2WpuOIfsOxSEnxkaEtcuDt7bcFIe6rf1gmA==
X-Received: by 2002:a17:907:3d46:b0:b6d:5b0a:bc2c with SMTP id a640c23a62f3a-b6dba4456e8mr54719066b.7.1761583757027;
        Mon, 27 Oct 2025 09:49:17 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8548eda6sm796161366b.75.2025.10.27.09.49.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 09:49:15 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63bf76fc9faso8782711a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 09:49:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgf6tWoUdO+szYW97f7UA7nCDA2VNeZTYz8wgZ3JX+RGXX03B+p5B36O5BlNSvVG2fdmWKoRRcrVAW4tY2@vger.kernel.org
X-Received: by 2002:a05:6402:510b:b0:63c:8123:9d46 with SMTP id
 4fb4d7f45d1cf-63ed8494f82mr503142a12.11.1761583754710; Mon, 27 Oct 2025
 09:49:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141536.577466-1-kirill@shutemov.name> <dcdfb58c-5ba7-4015-9446-09d98449f022@redhat.com>
 <hb54gc3iezwzpe2j6ssgqtwcnba4pnnffzlh3eb46preujhnoa@272dqbjakaiy>
 <CAHbLzkpx7iv40Tt+CDpbSsOupkGXKcix0wfiF6cVGrLFe0dvRQ@mail.gmail.com>
 <b8e56515-3903-068c-e4bd-fc0ca5c30d94@google.com> <CAHk-=wiWmTpQwz5FZ_=At_Tw+Nm_5Fcy-9is_jXCMo9T0mshZQ@mail.gmail.com>
 <7bfd0822-5687-4ddc-9637-0cedd404c34e@redhat.com>
In-Reply-To: <7bfd0822-5687-4ddc-9637-0cedd404c34e@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Oct 2025 09:48:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgm=xTvbu4zEn3kFRC8bF8XXrOdK5fZj8iNbDn5bGB2g@mail.gmail.com>
X-Gm-Features: AWmQ_bmMCF2Bswabi5m1iDRLn-PFpqrzABrPKB_X0KjtKKqdcRXd8_cg4QARfsM
Message-ID: <CAHk-=wjgm=xTvbu4zEn3kFRC8bF8XXrOdK5fZj8iNbDn5bGB2g@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>, Kiryl Shutsemau <kirill@shutemov.name>, 
	Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Yang Shi <shy828301@gmail.com>, Dave Chinner <david@fromorbit.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 09:06, David Hildenbrand <david@redhat.com> wrote:
>
> So I really wish that we can defer optimizing this to freeing folios
> under RCU instead.

So just to see, I dug around when we started to do the rcu-protected
folio lookup (well, it was obviously not a folio at the time).

Mainly because we actually had a lot more of those subtle
folio_try_get() users than I expected us to have,

It goes back to July 2008 (commit e286781d5f2e: "mm: speculative page
references" being the first in the series).

I do have to say that the original naming was better: we used to call
the "try_get" operation "page_cache_get_speculative()", which made it
very clear that it was doing something speculative and different from
some of our other rcu patterns, where if it's successful it's all
good.

Because even when successful, the folio in folio_try_get() is still
speculative and needs checking.

Not all of our current users seem to re-verify the source of the folio
afterwards (deferred_split_scan() makes me go "Uhh - you seem to rely
on folio_try_get() as some kind of validity check" for example).

Oh well. This is all entirely unrelated to the suggested patch, just
musings from me looking at that other code that I think is a lot more
subtle and people don't seem to have issues with.

                 Linus

