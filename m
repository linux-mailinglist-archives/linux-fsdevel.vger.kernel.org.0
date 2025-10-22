Return-Path: <linux-fsdevel+bounces-65030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305C0BF9F07
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 06:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE923B15D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 04:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91D82D661D;
	Wed, 22 Oct 2025 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MxOvMvzc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A08F1FF7B3
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 04:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107153; cv=none; b=E7ZdN6xNOblcOaoJ40xAsctiYwjeGdboLpt+uvS639S4nFn5ISBQJHepnp/kT9110xY/QOhGqBnq0iCql3T4zcOD3MnW6cfLN8RhsFo+NV8toYA98X7Etwwdv+4ItCswv9XqU7zbTqSYA+98eENqnmu42D+2sIFbyJWcjNufAs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107153; c=relaxed/simple;
	bh=hfRSNQb9rBE7UUr5J/K6aWGqynTuTf2c3cqKlfXvUig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKs7/DGuUQyMrqYoScmOwMUPNkYaNFh6J5ivPn1vN//9yBAh3QWKIOtQssBGmzCzZqsAXn/Z6SbpWqPaaWkdqkx+NmI9JHskaE4onl4R3cmndA8uerc5sFrHG1w7bK9zQQbbU6bIGGNgYREKLkvzgheZVetX/IbNkU2VBZgSz/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MxOvMvzc; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so12075596a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 21:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761107149; x=1761711949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UfKYMPlRA7Hil19lucydJ3Oagf4wOyjxoqA3QWKCuV8=;
        b=MxOvMvzcJhcv5wQdUhGprRemxlKUDu7K31BIpYaorDxNaj3Horzwc7KBHbjvv3cYWW
         a8N8pL1OrSkU3cGmRJfM8OzT8y0Dvlg7IqWwTp3YMtnzKmj8SnlK059hupgSQbcH+F+b
         VHlKdCFYW1wBFevHl0/xCmd21cmcfVlCu1r/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107149; x=1761711949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfKYMPlRA7Hil19lucydJ3Oagf4wOyjxoqA3QWKCuV8=;
        b=gWVbwrmk2/++AdKFFUrOo2Q4brDEBDB11L6XNxETyNPogLRpnlyNAu1pd8Wz3xS7hr
         +1Rq8hP9LW+o8t81Ddoj81EQ4/hKzY9hrSvfKaogGuWO5xr73qSFG3VZWjBZZk3+Qbtv
         ATo0iYUisqKKGB6F7S6XeGqmWk10JaSKf/KinunRI2hLNtybI6GBBgKgPrTLAJ4Rpq5b
         Q8k7vizqfngr/8SjqVI0Oz/qb64upxfdrB4Gq1Cw91ynuaztzATSmVPo5AwCO/NKnNhd
         tjucGsCVhvsncKF83kc0Nh/ZobNOE9PcW3neVeu6KpUsoOFlER38x7AxRke+H26qh3Cv
         CDDg==
X-Forwarded-Encrypted: i=1; AJvYcCX2A8fKWHymphg8jOIY8aQxvdxOzIOS5sotFmtsr7ybmICsiJTWhX8igjGM5hQeYftpwTc4Xg4lJwHe0hsk@vger.kernel.org
X-Gm-Message-State: AOJu0YzEV5rzZeRzK/rrVjZaCYJxpPXG3lFQM6SLar3dCDqbpT3voHX8
	yf4DZ50H1DnXwoZHqwxlITUxQ6nC+wgsy8WruloHIF+5fX9NkoEnEYUlOQeb9QGxwlOvY/3ETqp
	nwNqHN4wiuA==
X-Gm-Gg: ASbGnctyzids/I+e9ns6YafyXxm+F1Bj5n+UDXOfX1+xQ3E+WEoq+nehbqpxf5FdlSK
	dC3I8zJYjy7kX31c8iW8yySYRCW9qsvke4SH+h1bJDR9xc+cSRRGaGFMelZmpsjnRQOtJifDSe3
	hZyXQYdPjJLfrg79dYCR0okOIDk0l9FBrW0kXV1ApoQLrBMag7qHNGRDhhritzkwtUkYrIAY6yN
	M1inmMr8+y+Ysi848H71NO7pPxiajdjurV5fDC9r/CEZ+Ee+/UXxbo6OAFBlmFiNKSPEy5JpMmm
	wKp0RdExfJAg+oRwsfi8Zt9IUvs3I/0JguaD0JJicuziq3xwrwkCKgpgiOjwICxl8G6UJJ7Jp4+
	7MBl+zZIPLoGjph/ypfyP7zmfL1N8ogAqmqk48bPL8AaIdBSMIEK/iLqXlg48jPHQVrdjFPTJil
	Rjn1GJmUvvmQUaBtMncVRmXRmJCMFDb1UdXxkzusXEiwIgvI1XFw==
X-Google-Smtp-Source: AGHT+IHfMjGEdQaOtmbahg8nX7QmHlFfZa4i3S0o9eW6yLIe+7xgMVGvFD4watCacbalnjo7kXv73A==
X-Received: by 2002:a05:6402:4504:b0:63c:1417:c185 with SMTP id 4fb4d7f45d1cf-63c1f57553bmr18689524a12.0.1761107149250;
        Tue, 21 Oct 2025 21:25:49 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c49469330sm11088423a12.34.2025.10.21.21.25.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 21:25:48 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63d6ee383bdso3725377a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 21:25:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSenYd2KCK6q8n8ly5BPYjEv/GOUYhrcLZpV+s2ITC1k2kzzeKfbGF6IuCnQXYmvUBXP5fma2pdmbFW3c+@vger.kernel.org
X-Received: by 2002:a05:6402:2113:b0:63b:f91e:60a2 with SMTP id
 4fb4d7f45d1cf-63c1f6c1fc8mr18494752a12.25.1761107146449; Tue, 21 Oct 2025
 21:25:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141536.577466-1-kirill@shutemov.name> <20251019215328.3b529dc78222787226bd4ffe@linux-foundation.org>
 <44ubh4cybuwsb4b6na3m4h3yrjbweiso5pafzgf57a4wgzd235@pgl54elpqgxa> <aPgZthYaP7Flda0z@dread.disaster.area>
In-Reply-To: <aPgZthYaP7Flda0z@dread.disaster.area>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Oct 2025 18:25:30 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjaR_v5Gc_SUGkiz39_hiRHb-AEChknoAu9BUrQRSznAw@mail.gmail.com>
X-Gm-Features: AS18NWB9CwG0IBKbkuN6M06jeHmD1GxcMpSycRZvl1CF5oywYvt7kYLWS-f-Gn8
Message-ID: <CAHk-=wjaR_v5Gc_SUGkiz39_hiRHb-AEChknoAu9BUrQRSznAw@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Dave Chinner <david@fromorbit.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 13:39, Dave Chinner <david@fromorbit.com> wrote:
>
> > > >   1. Locate a folio in XArray.
> > > >   2. Obtain a reference on the folio using folio_try_get().
> > > >   3. If successful, verify that the folio still belongs to
> > > >      the mapping and has not been truncated or reclaimed.
>
> What about if it has been hole-punched?

The sequence number check should take care of anything like that. Do
you have any reason to believe it doesn't?

Yes, you can get the "before or after or between" behavior, but you
can get that with perfectly regular reads that take the refcount on
the page.

Reads have never taken the page lock, and have never been serialized that way.

So the fast case changes absolutely nothing in this respect that I can see.

               Linus

