Return-Path: <linux-fsdevel+bounces-51150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6454EAD32F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 11:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2855F3A417C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 09:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6A928BA90;
	Tue, 10 Jun 2025 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ACiUwdIg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B40928BA87
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 09:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749549576; cv=none; b=S6FZJEgWc8UgxCICoAOQtHX8gSUv6reluRSPcfXkA7M0ZxkTW/hn38cDCPSe/o1JSMW0c2fMLMrn1EtT2FrOX+nUhJFNaeQLDA/Fo2+7Wi5+nhCvgX6NvqU3n297obAUwwc6vCHfBWEFjLg2onnn/kJKBEmvCpqpa74DWnnpIWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749549576; c=relaxed/simple;
	bh=xf085i2l6fd/qOZ8bILMrztat3R1PycjTAfMEWFwEQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia5V80e546zAXbGe4tcgPA/M2EZ+XkW7S5SZQvMkQ/cHYNcQkJz1jOfgzIVbmVb1S5W6gCXx3rLj1BJ8QB9cJgyDF4+TYiAI5UMrIQSDq54OOkWUm7tCVSehMi3Dq3M5wcwHd8g/AQYPgxfvXCmrmwBLO7HQf/5/GB7+AZfuOXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ACiUwdIg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so62636545e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 02:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749549572; x=1750154372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WtZfRWe7jumYhORD8bhAM/HNKsZrd0S3kChFZwMp2GU=;
        b=ACiUwdIgRjWJE2RN7eqfgYHeG8BybVuLNr5sPAYsvqiCzW4JPJkTHeOkw9+mMxV7dP
         CGpTZOUt/MnyIVhvKmxxtwPR6H+LSaZ97LH1lU5I3pGqHwIK072bROGrtS1BKJPgVC/L
         uw8E/FXwnWqRnLN8HR6usNdFY2j0fRmjXVQvkfQHogn30S/QaRYETabjg4q7BWcqTC4a
         orJtAgpEPj78D1iDjeyvJwJlr9Xv5RW7Q+l224Te5AJJGwEfWFo88wmao7o6Gzz8kuWB
         yD7osxx1/s0OBLPuev6udraaCnldf154C1Bfn+NYr8VZDAwlgLhx1poeBHp6kOJwfeet
         hM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749549572; x=1750154372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtZfRWe7jumYhORD8bhAM/HNKsZrd0S3kChFZwMp2GU=;
        b=q0gpagniq3OL2ZY4qTCadiC7Ha8Sl3ojGw97NK56SrSEanVne+khsmaNg3+jwC+JPR
         VybDCYKeG68frVOKHN0+RNG5rhku69+dX6iUIQ1k25bxpHk5sL7+pWTgWBz3kM0kTyaK
         ylySi9iT3oXBPaCry7PhvN78sTskcKBbAc9fweQAXDLpWMf7woXLtGKB3jfiEUyXekIV
         ttieM8L8F4Rc/zriB6R1UR27sbjA1PJyFOJDBF7QhAJbhggkZ1mtCZenaDeSEbjUhRY6
         9dozFfH7CKbwheE8BzwmR2ayFM84PveHmOE3sRJl5rqhvbCyruF+kWZxSWzxD42cHzqx
         kOkA==
X-Forwarded-Encrypted: i=1; AJvYcCW3WCOLjpW76cNiprDK/8Gs4tlor0FPLVM4Vj+dLbH83A/MEFGWFsyiWVsPHMkvoqKkL2EewT2u87BU0Eh/@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg4c5aZBEIrxRvKVGxsRDv2rWb/QyqBnfnlii8R2lYPWPDYODh
	J8s0rQgZ02VZ3lW0x2NkJd6E6R35NVQZr5xnSPSziukjZIfiBNRMJXbfwT+714t2PC8=
X-Gm-Gg: ASbGncuTdbRDSVgjyKA+XZAAXeZV7z9E2lE9PDhxxn5wmXNhKAiOrQ8UrpL1Bc4Jfwj
	3LERkzQ7jnxo93Ed7nEY5TnLYIfVVBey7A6Kw9HrgWApfoAukBS01SMn9NBZfAfiWfPHIpxVyIV
	pMJ2ABQIH17ri4qhc6ndCkeUYwk9r4o9EnzkhlLsD2K137pwftdHz7Kk8pKbKj9fz4pmD3HTpb2
	OqsLErsTYKBUj2vLuvL7Dn1/4zLugUczR9NYREkrSM2uvgP7TWPe26hs8usZr2X4J3Sx4M5tTpw
	Ml/et5BwBz+lL8LfHkFjXvCN1aj1p2Q1xWl1koFR2efR8Tq/TNRCNzc6AferpwpRWChALi36xQz
	btmA6RpErRg==
X-Google-Smtp-Source: AGHT+IGl3y7tGpOe1smwbVjVe6Qrr+nVtzasTtqSpTPNV7IeliyjEvSIX1HfFN4Q5jCM9QnyAR7OyQ==
X-Received: by 2002:a05:600c:37c9:b0:43d:1b95:6d0e with SMTP id 5b1f17b1804b1-452013d7e24mr138183715e9.23.1749549572531;
        Tue, 10 Jun 2025 02:59:32 -0700 (PDT)
Received: from localhost (109-81-91-146.rct.o2.cz. [109.81.91.146])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a53229de7csm12006149f8f.14.2025.06.10.02.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 02:59:32 -0700 (PDT)
Date: Tue, 10 Jun 2025 11:59:31 +0200
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>, david@redhat.com,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	rppt@kernel.org, surenb@google.com, donettom@linux.ibm.com,
	aboorvad@linux.ibm.com, sj@kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: fix the inaccurate memory statistics issue for
 users
Message-ID: <aEgCA3lJDWVu32Gc@tiehlicka>
References: <f4586b17f66f97c174f7fd1f8647374fdb53de1c.1749119050.git.baolin.wang@linux.alibaba.com>
 <87bjqx4h82.fsf@gmail.com>
 <aEaOzpQElnG2I3Tz@tiehlicka>
 <890b825e-b3b1-4d32-83ec-662495e35023@linux.alibaba.com>
 <87a56h48ow.fsf@gmail.com>
 <4c113d58-c858-4ef8-a7f1-bae05c293edf@suse.cz>
 <06d9981e-4a4a-4b99-9418-9dec0a3420e8@suse.cz>
 <20250609171758.afc946b81451e1ad5a8ce027@linux-foundation.org>
 <advwinpel3emiq3otlxet2q7k5qwl43urgewhicvqhqliyqpcg@vztzhkqjig6n>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <advwinpel3emiq3otlxet2q7k5qwl43urgewhicvqhqliyqpcg@vztzhkqjig6n>

On Mon 09-06-25 17:45:05, Shakeel Butt wrote:
> On Mon, Jun 09, 2025 at 05:17:58PM -0700, Andrew Morton wrote:
> > On Mon, 9 Jun 2025 10:56:46 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> > 
> > > On 6/9/25 10:52 AM, Vlastimil Babka wrote:
> > > > On 6/9/25 10:31 AM, Ritesh Harjani (IBM) wrote:
> > > >> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> > > >>
> > > >>> On 2025/6/9 15:35, Michal Hocko wrote:
> > > >>>> On Mon 09-06-25 10:57:41, Ritesh Harjani wrote:
> > > >>>>>
> > > >>>>> Any reason why we dropped the Fixes tag? I see there were a series of
> > > >>>>> discussion on v1 and it got concluded that the fix was correct, then why
> > > >>>>> drop the fixes tag?
> > > >>>>
> > > >>>> This seems more like an improvement than a bug fix.
> > > >>>
> > > >>> Yes. I don't have a strong opinion on this, but we (Alibaba) will 
> > > >>> backport it manually,
> > > >>>
> > > >>> because some of user-space monitoring tools depend 
> > > >>> on these statistics.
> > > >>
> > > >> That sounds like a regression then, isn't it?
> > > > 
> > > > Hm if counters were accurate before f1a7941243c1 and not afterwards, and
> > > > this is making them accurate again, and some userspace depends on it,
> > > > then Fixes: and stable is probably warranted then. If this was just a
> > > > perf improvement, then not. But AFAIU f1a7941243c1 was the perf
> > > > improvement...
> > > 
> > > Dang, should have re-read the commit log of f1a7941243c1 first. It seems
> > > like the error margin due to batching existed also before f1a7941243c1.
> > > 
> > > " This patch converts the rss_stats into percpu_counter to convert the
> > > error  margin from (nr_threads * 64) to approximately (nr_cpus ^ 2)."
> > > 
> > > so if on some systems this means worse margin than before, the above
> > > "if" chain of thought might still hold.
> > 
> > f1a7941243c1 seems like a good enough place to tell -stable
> > maintainers where to insert the patch (why does this sound rude).
> > 
> > The patch is simple enough.  I'll add fixes:f1a7941243c1 and cc:stable
> > and, as the problem has been there for years, I'll leave the patch in
> > mm-unstable so it will eventually get into LTS, in a well tested state.
> 
> One thing f1a7941243c1 noted was that the percpu counter conversion
> enabled us to get more accurate stats with some cpu cost and in this
> patch Baolin has shown that the cpu cost of accurate stats is
> reasonable, so seems safe for stable backport. Also it seems like
> multiple users are impacted by this issue, so I am fine with stable
> backport.

Fair point.

-- 
Michal Hocko
SUSE Labs

