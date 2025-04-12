Return-Path: <linux-fsdevel+bounces-46326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A640A87002
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Apr 2025 00:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4BC17C81B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 22:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CF4219A86;
	Sat, 12 Apr 2025 22:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="afy7699b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1A7182B7
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Apr 2025 22:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744497384; cv=none; b=LhggwH8G3fbUgIKHimpNOHCwx7BZm+/zKo8TwhXKl4mRx0c3Nxrme8W7sHBzL1GK0gCoiNxieOL68wPh0HGAiC6WmkoLUShtVHSnHtnvedILLhMfEGxS1hqdwmGzWhANC05EEbDN8rQjdhRySDa6db3aucDQqwlCKZXbhtHdVAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744497384; c=relaxed/simple;
	bh=WCcnEaGnErt22gwtTCSLCZCag0tD0wwfK8GeevMTpco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9xZLuSg0pwROcqcPCAefFmdfEXtVn2ZyZ3NWuS54gLl6iGnj3dA/ksgfsT60SPw97bdM2X/8F/NbcrBIKxpSE+VCirN9OQtG5SQnjkx+8FLaJufl0Xeo9Qs8b5K8Yhz2PWEgCi46XKGyimOOLQZpgS19a/ud9hGAGK1G0mDXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=afy7699b; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so618264766b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Apr 2025 15:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1744497380; x=1745102180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jX1PlPChRu+hkU1daePKyzTiusOmrXQ67aQ/gDwc+Ng=;
        b=afy7699bRNiw/t9njjDrwn07wS08x4oEvFdDjsVyS2BpUFOoGVOJZD18P9k4jQe/Ud
         7WlghDnMWt0XHG2ZqGrGFkjZ6Q6UuA4FtRKOz4ze5f+yNvBDjp1XjO924XB80AtnhD5t
         BJqqCcBCHCBK1MDfof2CoWcwN0VHk6Ws+q7cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744497380; x=1745102180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jX1PlPChRu+hkU1daePKyzTiusOmrXQ67aQ/gDwc+Ng=;
        b=lC0oJUWz73+13FtCUUBjuR50keMlkuATj3HhysLEI8qUDLJ7uuoZyWXHnblkYfTRUm
         jZkNWRpqbpLd88pLukV5FWFAUHvciWtgUPfKcxYhbuzblsN3uh6nb081O5jSmWMCdTUh
         hXGsAwS4D05TXzKQNjJvL282s//fIOdDLDM3LpzkaPQMKCgm1+qsKrAlPSVSfgEo7QFV
         iGv5iHCqKh1sXiYcZ3VbsbUR5/W9RnT18TjqQFRHFsXqGcBL/vJMKNdG5cR1qtsmdwjI
         hScFkVVwbFu+SsDQ2dz0NHkdWB4Px0beawXP2Xvq1c/NbZGeCpLGjlFUP3Sl3RktEfif
         KLJg==
X-Forwarded-Encrypted: i=1; AJvYcCWGcoYlApxHuZnT/hxAzURrYRkJ/X6XLwvPhnP4gLa3anv+CMbIjF/WDVeSQHbKMMKmjbv2WdaqEEKCuQNb@vger.kernel.org
X-Gm-Message-State: AOJu0YxopgqMFTNxGRN0X8KqB5mnsNqkKTJ/NY/+6mH4jRzzRHID6G6U
	ANkYkHzwjMZA7PEmikSpXJlyMbEoYUv+h3wnKDAY3VADmmHiByl1xkWMfvMpFSwA7KUsJ/eYcTZ
	td5Q=
X-Gm-Gg: ASbGncvVPssiekHR06/2GUbmmZYO8+yN4EGM765YB0G7cYhDEoP3YgTOmCYppo8vkaj
	kwK8Gm2IZXzvJAKfqX4CeoqLNuheiyFZuw3HWRcHZdefwgItXmwrOPwZnWdNEP2UT4dk2l6/6xP
	WnAGzUiCM0e+uDzcXW5g1sCNV4CxInRjOvBONM6FGP7PO6Job8K0n7092c9kjvDWWtyZVPCPu6O
	Jk/t9e1bp9dwHAFji/cj46OAZf28HtODYwMBO/Fuhkgymk4Q6sAFp21nqUhMzHPL1MuP3TO+zWP
	hAFxkCZ8xQxU1kvfHsIndbsj9EMWlu8+PA5fcsron4rM4zb37CnqvlA/e1fcLoXnXtWCjjEb3M6
	+kh5p6ToDs7egZdo=
X-Google-Smtp-Source: AGHT+IFiN9vg46eo+gH4pWWnr5OaI5LIhw2zkQnIq3Wo6u/Mt4KTej8DQJ+Aw3zmtNrb+OTe3BJHnQ==
X-Received: by 2002:a17:907:7ea5:b0:ac2:b1e2:4b85 with SMTP id a640c23a62f3a-acad3456e28mr674290166b.3.1744497379696;
        Sat, 12 Apr 2025 15:36:19 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3508sm645761566b.8.2025.04.12.15.36.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Apr 2025 15:36:18 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac289147833so618826466b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Apr 2025 15:36:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqUq07tMe3n9/9P1lHMw3OPpepDEg432+G8Tut6/CJn8bR7IcEvBB19+PZdTcmObncOb9UmQT+y2+gB6wv@vger.kernel.org
X-Received: by 2002:a17:906:6a07:b0:ac6:da00:83f4 with SMTP id
 a640c23a62f3a-acad36c1cbfmr628750966b.53.1744497377143; Sat, 12 Apr 2025
 15:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031-klaglos-geldmangel-c0e7775d42a7@brauner> <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
 <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
 <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
 <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>
 <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
 <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com>
 <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com> <20250412215257.GF13132@mit.edu>
In-Reply-To: <20250412215257.GF13132@mit.edu>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 12 Apr 2025 15:36:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifig365Ej8JQrXBzK1_BzU9H9kqvvbBGuboF7CzR28VQ@mail.gmail.com>
X-Gm-Features: ATxdqUEK5hSoCq0fceztzyq2OA_Su-uY2GQRpxFeTK4CRtjiK3zYuE7qtEBD8PU
Message-ID: <CAHk-=wifig365Ej8JQrXBzK1_BzU9H9kqvvbBGuboF7CzR28VQ@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>, Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Apr 2025 at 14:53, Theodore Ts'o <tytso@mit.edu> wrote:
>
> Linus, what problems did you run into?

So this is a resurrected thread from November last year, and I have
long since paged out the exact details...

But when I did basically the exact patch that Mateusz posted, it
didn't actually change any behavior for me, and I still had roughly
half the lookups done the slow way (I also had a really hacky patch
that literally just counted "has cached ACL vs has not").

It is also entirely possible that I messed something up. My
*assumption* at the time was that I was hitting something like this:

> tests if the inode does not have an extended attribute.  Posix ACL's
> are stored as xattr's --- but if there are any extended attributes (or
> in some cases, inline data), in order to authoratatively determine
> whether there is an ACL or not will require iterating over all of the
> extended attributes.

Indeed. I sent a query to the ext4 list (and I think you) about
whether my test was even the right one.

Also, while I did a "getfattr -dR" to see if there are any *existing*
attributes (and couldn't find any), I also assume that if a file has
ever *had* any attributes, the filesystem may have the attribute block
allocated even if it's now empty.

And I have this memory that some gnome GUI tools used to use extended
attributes for things like file icon caching purposes. I didn't even
know how to sanely check for that.

I assume there's some trivial e2fstools thing to show things like
that, but it needs more ext4 specific knowledge than I have.

                 Linus

