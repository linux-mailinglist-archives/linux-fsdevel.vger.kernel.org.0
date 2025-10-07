Return-Path: <linux-fsdevel+bounces-63570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7AEBC2F42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 01:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBE3B4E4585
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 23:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D86258EF3;
	Tue,  7 Oct 2025 23:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Kbjqrpg0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D4F34BA35
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759879842; cv=none; b=GOZZC5JHyq1wHfmo6KXR3HnSuQPeQ3QKmI4px5UEx6gzh+Uww7TJf7A4vFh2LatPue4A+4J5dd5vFJ8k8VWggaBLX/knXC9xJPjtiOA0Y8WsEoA3c0hAgz0K3B0gC2guGmWanqHNZ94fYzNrIxf+wmEUHTvT5pyAYDD3GXPfdl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759879842; c=relaxed/simple;
	bh=TXH+aleueAUqFpBInRSZRFxUhG9b2/z9O5U+CUs/jBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PF1u/b+Rq0zB7sPai3sa5qfL+90q9ynQPpLqYsp7p9MqHJhmLzryUGjs2A9nh59iXAYFOymTAvlElD4iSSwxz47S6rbGegEzZvp3oYaqTtXrpPkehV33iAjbuNwjuQIp10NMhoZmArI2iki6pbR9P5gUG7hfWRl+xxW6YR5EePs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Kbjqrpg0; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6394938e0ecso9182679a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 16:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759879839; x=1760484639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rh8ozCfyhmaZ3ik2fPfPADB3YdiPuymeBZjBZkPgUH4=;
        b=Kbjqrpg0Yv4uKEcqBU8il6QQS3rBmkBG4WhmJc+3sWDotUweGvRdfXZgE863aaiJVi
         jAoJQ5QrUJeVwkZ/kMKPBYfPXZ6hCsCeSV+eRFkAPzynrZ4K+8ZtvMfVx1ELKCovaaV8
         k7gvL5fbqGNNp98pVgfysmEIl3xOG9ZhrXJzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759879839; x=1760484639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rh8ozCfyhmaZ3ik2fPfPADB3YdiPuymeBZjBZkPgUH4=;
        b=t6pKBv5VrMKrfYlcNkdMVrIrwSAJIabjs/fkvIutuz+JciUWCtbBtkLdalfmhw03Yb
         SmEr9Kzjkwki8FlFRS/EZtZFeGRzQibOb03oUwb8R0HpO9DHeZGokZc1QCuXgE6cIq4Q
         c28TIwit67V9LVQuWZ4VWeknolz/+GvzUXlN49y4sGTnrp9SJ5O3idC9sZDCiX0DpTlu
         BzQ6McfkTZ+Q/KXmS8BZASBjExDyssV6Rpdy18kof7BGk3xPXepPYRhiHCQ2eUcmxV0J
         8Bq1h5dGNylUo86QqdUZoPUuQXWRFOTn6j1FA4uqb7VCIeu2xeGlt8jbMg9yOwbI7Z9Q
         bIDg==
X-Forwarded-Encrypted: i=1; AJvYcCVTbzWSksdpcCJ3Z5myNgsGW7OpCYyPX7Kg2PoVgM4AUeP8FUtg0FNInobAmINaHx7q0OgZOOLstWX7gLKM@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1r+e+nIvX5/OQ+Tk4WAr8UpimbE66KC3oe24DsvZRg+AK26M
	SK2jSBcAaHnmiiBmptyYPMIfnwAeQ7xCbx0JVAaOfDsDfqtC/SNkT3tGIoZLd+T4jW2LYHqQp6j
	YWAG9p8E=
X-Gm-Gg: ASbGnctxtSALk+lpRPOXe9I0N64TjEeQ1VreHFAkdJPBclyjU9d8iXSmvst0kebxUw7
	HL5yyFztEd9UjECiPWCUPrtJOH63wgSQZlg/HdHLFoZxTq+XjwkV+Vh/KjL/zc5vgWOyI4FrdWQ
	GpY4nghD6Af0Usz//zqbhP4Hf1MS8a1IHlbtQ5CvokJRH8D18snhZZy8mRY3H7OYjterHdmzM7j
	ruVTHp4cEmyHqgYVpevVIuoz32HUmwY5ZljjtdQkG+4LmjpNoML2N/WZVcHcVanBlbltRulNhYq
	1UfAK2TkoJsGXe7v+wLAckYf0sDuV4+kbEijjY7Flz9uhJCAN8P6tfW8C4SZI2GEiDKE8IJeCoV
	7InsB/9BlAxFiRI2Y7IXP8YL2Hq3t4u1bCEuy9li8mb2G0A6ChWWMl8P72b9QA2Vjpvhpmit/Io
	y/DR7DrPqxM0nhc6IkLeOe
X-Google-Smtp-Source: AGHT+IEnPpq4xzuSXbDFL3eY3FMeOuOmz+zBjoBJUyJXHw/OV/PFGz8XVHiUJSVwOerPizypGv/d8w==
X-Received: by 2002:a05:6402:2347:b0:639:5cc2:a442 with SMTP id 4fb4d7f45d1cf-639d5c371fcmr1173679a12.18.1759879838838;
        Tue, 07 Oct 2025 16:30:38 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-637881011e9sm13292831a12.25.2025.10.07.16.30.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 16:30:37 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-62ecd3c21d3so12525002a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 16:30:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOAU1zClsvahQxZLCEstxCHhP9+5Aa6vgES0ud3Wow1ejBggc0+Gr34HzNfhtviqsKiKNCI3qDCH/ifHs7@vger.kernel.org
X-Received: by 2002:a05:6402:40cd:b0:639:dbe7:37e4 with SMTP id
 4fb4d7f45d1cf-639dbe73c97mr263633a12.25.1759879836643; Tue, 07 Oct 2025
 16:30:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wj00-nGmXEkxY=-=Z_qP6kiGUziSFvxHJ9N-cLWry5zpA@mail.gmail.com>
 <flg637pjmcnxqpgmsgo5yvikwznak2rl4il2srddcui2564br5@zmpwmxibahw2>
 <CAHk-=wgy=oOSu+A3cMfVhBK66zdFsstDV3cgVO-=RF4cJ2bZ+A@mail.gmail.com>
 <CAHk-=whThZaXqDdum21SEWXjKQXmBcFN8E5zStX8W-EMEhAFdQ@mail.gmail.com>
 <a3nryktlvr6raisphhw56mdkvff6zr5athu2bsyiotrtkjchf3@z6rdwygtybft>
 <CAHk-=wg-eq7s8UMogFCS8OJQt9hwajwKP6kzW88avbx+4JXhcA@mail.gmail.com>
 <4bjh23pk56gtnhutt4i46magq74zx3nlkuo4ym2tkn54rv4gjl@rhxb6t6ncewp>
 <CAHk-=wi4Cma0HL2DVLWRrvte5NDpcb2A6VZNwUc0riBr2=7TXw@mail.gmail.com>
 <5zq4qlllkr7zlif3dohwuraa7rukykkuu6khifumnwoltcijfc@po27djfyqbka>
 <CAHk-=wjDvkQ9H9kEv-wWKTzdBsnCWpwgnvkaknv4rjSdLErG0g@mail.gmail.com>
 <CAHk-=wiTqdaadro3ACg6vJWtazNn6sKyLuHHMn=1va2+DVPafw@mail.gmail.com> <CAHk-=wgzXWxG=PCmi_NQ6Z50_EXAL9vGHQSGMNAVkK4ooqOLiA@mail.gmail.com>
In-Reply-To: <CAHk-=wgzXWxG=PCmi_NQ6Z50_EXAL9vGHQSGMNAVkK4ooqOLiA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 Oct 2025 16:30:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbQ-aS3U7gCg=qc9mzoZXaS_o+pKVOLs75_aEn9H_scw@mail.gmail.com>
X-Gm-Features: AS18NWA9Q8bImiOINU0aBi7Bh8WTXoi67-A8OJXyv8c9c55rYcgKothlbnB8krQ
Message-ID: <CAHk-=wgbQ-aS3U7gCg=qc9mzoZXaS_o+pKVOLs75_aEn9H_scw@mail.gmail.com>
Subject: Re: Optimizing small reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 15:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So here's the slightly fixed patch that actually does boot - and that
> I'm running right now. But I wouldn't call it exactly "tested".
>
> Caveat patchor.

From a quick look at profiles, the major issue is that clac/stac is
very expensive on the machine I'm testing this on, and that makes the
looping over smaller copies unnecessarily costly.

And the iov_iter overhead is quite costly too.

Both would be fixed by instead of just checking the iov_iter_count(),
we should likely check just the first iov_iter entry, and make sure
it's a user space iterator.

Then we'd be able to use the usual - and *much* cheaper -
user_access_begin/end() and unsafe_copy_to_user() functions, and do
the iter update at the end outside the loop.

Anyway, this all feels fairly easily fixable and not some difficult
fundamental issue, but it just requires being careful and getting the
small details right. Not difficult, just "care needed".

But even without that, and in this simplistic form, this should
*scale* beautifully, because all the overheads are purely CPU-local.
So it does avoid the whole atomic page reference stuff etc
synchronization.

                  Linus

