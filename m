Return-Path: <linux-fsdevel+bounces-63606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCE6BC6031
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 18:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A70919E37A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 16:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC138286D49;
	Wed,  8 Oct 2025 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JdVdLmaJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB1F10957
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 16:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940671; cv=none; b=uKG919nRyWXLuM90QzXhqrfptg3RhhQcy0mPDQyxnju4Zl6cW07+xdenZc/MoidDIV21Gnvh4Btvjrlr7LnpY751kFXUV6L5FhvJiubTN50SbCuOSVdxXgbtZE8CTaaXuQCvrq1b54Toq4Ubyk4YjM5R/vY4Dr0VyVrZ76lbtfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940671; c=relaxed/simple;
	bh=bPeXvap2b33+boSy523xIc4pQvXbbjN6Bg6578I0hkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VoH5uVcLX7UlzZXH6xvm/+1GXRQOjnAbO/J+Qw1gCWZ5kn/Eqp8eIvyE0rpi4bLfzmVg3g451eOhOl2UWNHjVi1VPT+wDtKh+6ViZoxZyc9pTzgcsnQ5uRmhrNuWQouw3Ccvalp66bnK3jSTbAeGdo4LJDnRtSbAp5cAHkJCM7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JdVdLmaJ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-639e1e8c8c8so1235916a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Oct 2025 09:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759940667; x=1760545467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gGv8gU8Wgrbxfvqd2t7G8Us4a0ybRRasjTDl8ZOYS+I=;
        b=JdVdLmaJQgTiCo8v/4Q1xupeDznP4fKOcuJAHOe0E2tkuCkYRFCn8IpTpYhgFDD+KQ
         C+lYiQ/7HdxYvRAKiM2+e2VJGPLKNkXpPuKCHmTbQWrqs7iwIeK8+vzcYqHRxh3PpPBG
         026npvBsd8qIKFEx7ilcpmzBB5kOMFh8U7nlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759940667; x=1760545467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGv8gU8Wgrbxfvqd2t7G8Us4a0ybRRasjTDl8ZOYS+I=;
        b=nz8CQSlpcpTcwXkFg9NSM8vuGsuypV6OxBKstjrNQOVbTwksLuixcNf1A18HrIMcKC
         3jlMHgvUTa+YI9S7Lo9xPbOdCag9d0k8wQZIz4lVbGHcI9JLe9O5t29eeCG9bBP7/9Yp
         BlL5/BN47kV0pUI6L7cqmgRK2MYblfSzP6vqjUNM6KstxC/f+9EqRh9dH7IBI3qEM13x
         +7H9+v2W8QoPsk1lJGTVbIRgPZj/BW/7OOB3+AVwNFen3fgcPgOVOG555pv8ngkgRvSB
         8wdnymJK7K27gSi1ILThgCpihKyrmm92s3XFvrdQWminwC56bvjMNJCuD8uF/Y5G/LzF
         K9Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUGy/hQv7T7+PQVIeyCT6EWVO6nlqJNad4G2fnusgjPIf8RVCP2hS6qw7YpSZ7dILud78p5wDB4dD97V9ar@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4rEDgI0cSdv9Fyn01S6rnBNzcDVz2l4Y/uCjzZn3uGwR6rl9d
	OEwL0+RnXZuyq8ysdZ+vXGjbXlGh6oL0+2dxn0GI1c3qeXTN2GCnCXQZ5LWgGgNSJ+OXHfrYxJ4
	DMkEZAeg=
X-Gm-Gg: ASbGncvzaaMwPkich8wokFp+LaqGswXKp4W3x3bjNnCnz3sgvsZsTzSzKU7nyULZSLk
	FrcCjWUHXm1NvAQDqIYpFBThPntbAvGAgLTOEAwySaeAgejVu8/KIcMiWdBCv3cEQ/MNuvrumO2
	NeNJ6q6aglP+xoS6Ht9f4wUzNxR8PnePlwlF0e8mAlQquH2yOsDV9H0J8MPsTMvikaHrs//k2sS
	Kes0Itb5ZNTGEIC0hlfVs/vR1b3/PEwAtJxDP7aL/V0KBBJ2SY2Dn3hAvU4TcuRv+NwbGpgqYrH
	whHLDQLmVumvI6bs+DBY5UIOiuu7VMjYvxi4/BI+9NciBKcsFb3U5MTkUm/m3RoYY6bnnevdNFJ
	/vyGSlRr6dAh/H1hQFCbYAYeUq3KF1+QHKghViERdL+ceT4ph5fKQ7lkqb7Fymw7iuJrFYIuO/Z
	32riu1X534n5IEOadvMnXE
X-Google-Smtp-Source: AGHT+IGjHjePxbGZwvJZjBfaryAqADvkTfhJFpET/NE0mk/ANXaMMuN4qzmglvNgDrw4AGEbUpF+ng==
X-Received: by 2002:a17:906:c141:b0:ad5:d597:561e with SMTP id a640c23a62f3a-b50aca01320mr505050466b.56.1759940666779;
        Wed, 08 Oct 2025 09:24:26 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639f3d03662sm308950a12.29.2025.10.08.09.24.25
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 09:24:25 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso183103a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Oct 2025 09:24:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWNAz7WSCIrQEANLaq7KO45M9HVAo+9gEcy/Fdrv3sJV7XkZHhiUH3T4viH1qQORGjwuV1P248Zezqa6dfH@vger.kernel.org
X-Received: by 2002:a05:6402:5193:b0:634:c1a5:3106 with SMTP id
 4fb4d7f45d1cf-639d5c5a3dfmr3717885a12.31.1759940665182; Wed, 08 Oct 2025
 09:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wgy=oOSu+A3cMfVhBK66zdFsstDV3cgVO-=RF4cJ2bZ+A@mail.gmail.com>
 <CAHk-=whThZaXqDdum21SEWXjKQXmBcFN8E5zStX8W-EMEhAFdQ@mail.gmail.com>
 <a3nryktlvr6raisphhw56mdkvff6zr5athu2bsyiotrtkjchf3@z6rdwygtybft>
 <CAHk-=wg-eq7s8UMogFCS8OJQt9hwajwKP6kzW88avbx+4JXhcA@mail.gmail.com>
 <4bjh23pk56gtnhutt4i46magq74zx3nlkuo4ym2tkn54rv4gjl@rhxb6t6ncewp>
 <CAHk-=wi4Cma0HL2DVLWRrvte5NDpcb2A6VZNwUc0riBr2=7TXw@mail.gmail.com>
 <5zq4qlllkr7zlif3dohwuraa7rukykkuu6khifumnwoltcijfc@po27djfyqbka>
 <CAHk-=wjDvkQ9H9kEv-wWKTzdBsnCWpwgnvkaknv4rjSdLErG0g@mail.gmail.com>
 <CAHk-=wiTqdaadro3ACg6vJWtazNn6sKyLuHHMn=1va2+DVPafw@mail.gmail.com>
 <CAHk-=wgzXWxG=PCmi_NQ6Z50_EXAL9vGHQSGMNAVkK4ooqOLiA@mail.gmail.com> <bbagpeesjg73emxpwkxnvaepcn5hjrsrabaamtth2m26khhppa@7hpwl2mk3mlc>
In-Reply-To: <bbagpeesjg73emxpwkxnvaepcn5hjrsrabaamtth2m26khhppa@7hpwl2mk3mlc>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Oct 2025 09:24:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZvzPZbzWt2Cuww3myOjQmvoaRtqme0jRawoUQnvWCrA@mail.gmail.com>
X-Gm-Features: AS18NWB5H0D_6NxOrszgcVIeZjT3XVd-PPCC5ZrYzJUv77q1XMrMBBR0-VbvhII
Message-ID: <CAHk-=wiZvzPZbzWt2Cuww3myOjQmvoaRtqme0jRawoUQnvWCrA@mail.gmail.com>
Subject: Re: Optimizing small reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 03:28, Kiryl Shutsemau <kirill@shutemov.name> wrote:
>
> PAGE_SIZE is somewhat arbitrary here. We might want to see if we can do
> full length (or until the first failure). But holding RCU read lock whole
> time might not be a good idea in this case.

There are other considerations too. If you do large reads, then you
might want to do the gang lookup of pages etc.

This low-latency path is unlikely to be the best one for big reads, in
other words.

I agree that the exact point where you do that is pretty arbitrary.

> filemap_fast_read() will only read short on EOF. So if it reads short we
> don't need additional iterations.

That's only true in the current stupid implementation.

If we actualyl do page crossing reads etc, then filemap_fast_read()
will return partial reads for when it hits a folio end etc.

Right now it does that

                /* No partial reads */
                return 0;

but that's a *current* limitation and only makes sense in the "oh,
we're going to have to fall back to the slow case anyway" model.

In the "we'll try again" model it's actually not a sensible thing.

            Linus

