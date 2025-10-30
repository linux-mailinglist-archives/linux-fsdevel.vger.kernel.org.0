Return-Path: <linux-fsdevel+bounces-66465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D182FC201A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 13:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921131A22D01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 12:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF474354ACB;
	Thu, 30 Oct 2025 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ctg4oghw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3D73546F1
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 12:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828761; cv=none; b=nXRnDrnLTSUiWCWzWG3E43mdzZ4Y0X8J/HBq/Mox3y/nusBuhPrGxGv09o4zOCKUh56ocYlG9uEbN98M5CHky3Ra+yPLKcscCbKD3Vt938AFyWMO2jYTTI3/KskXBzVOTvw++EhQnMvQAJyTjCBQICieqERVmJ1+aXGefxkeQ9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828761; c=relaxed/simple;
	bh=ueVmkCcZ6Fn8px+zLdb8kTT+GDQqAsSoqXj2QT6A7IE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTvkNd25zNwniLv/d/WuxfNMUxzMQo6qvhwsIryIo1OwO/b7N47RD+pnUiq2rAxLdXlNuoMFZO1ek5SJrAiNuEtV5s/DV18RCfZWJ+Cyw3BNCh8qsCWKAKo/KN2JyUN1/HBZKKxK67PqVUO5btsZ2/DmMOzZEA0/GcUJut8fATI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ctg4oghw; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-7f7835f4478so8521366d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 05:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761828758; x=1762433558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fhWJzGzGzYtcQeOF2Zd9nQeXdar54wkYdmN+7gtiSCA=;
        b=ctg4oghwmGsO8lan6lbDuCBstoSbfveEO3Xc7ptzGIUf7Bf0jjJrADE5dYPu9cyMZN
         7WY5rnS4KnUQf9W5wpfrsAbJjdsCgovUL8ufEKsiYIPf40frltth6VEDTxtVUA8CXApx
         3+n0RQNxAabApXj7GRVo5MhZ/+Qg6XikHiLtvKeCD7eJ9uwO7Inkn3oS3uB/LVI1yQkt
         0y16M47qeo8HMLdzFsJCCjwRduFfJK0yeWDapv2qKFY1rcFMYrNTyK8dJ1jIMfwk4fGC
         K3tpU8txpZz1uAY+dXc+4UDkhlzkph2VGxkgjKka2EDDidY7BVPgM3Rcx28xIkSsUsNP
         H5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761828758; x=1762433558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhWJzGzGzYtcQeOF2Zd9nQeXdar54wkYdmN+7gtiSCA=;
        b=XRW9983NLG+JNoadSx34QVDkglaovs1SNtP22b5D8mCWEPTk4XcVZguBgRV/XPaCpx
         A5TfUv8ncBOyLpPttCB1bmKAOPUwAIWFBhypkHG1GhTyXW0D5ndEve6sqKWQ2IioSTIH
         jVL7zf9q8dm9pUxWD9jmr6HXAvEVjnrfYXLZGpYYiC4X8R5mV3x1Wh1NnlaIhJ3q5Jey
         FlmLfE2Z+o/QESCWkeO0PTu+zHIT7b4fpDbLQoEU80SE5GT4u4DCE/vp3urZfC7VdpZ3
         O5ctPyqMXyqaeK1PkYaLm1boZ0imTabE9yEoQEmNUzR8dPDiP10eMqDr/gjggJMQa+FW
         4l6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4LdTZdYkMAUOQBmxOdzr/OVcDidU2v40i229wdm56B1urBSnTxLk/qdgVoZ6+H9Ut0QFaZRCBrGYencsJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwpqP9fm2BmolnjTKZ5nZV+zI9E3D1KJVB5y63Fkq+2kiEW4LFO
	2udF3Vob0alN4lUYQ8YV8qYvTa4ZXx2SwPa49lYgKy5pgZRIkJlEibDl3f5yOMzTFhI=
X-Gm-Gg: ASbGncvKcNoeNmpXaBu2y8+ZbQVqLbC2SbzfH8Cuma6Cw25n3zONhoJC3yde7sItE9N
	BOte7H4xw7mKCot63EHXGkrOOE8zG0WvsJQmGheBINX/bnLDbvjDsSINueXN+8GKcu9axo+xAE4
	spyUz+Ox+Mdo8CzLOl2zQOeevDi3K5bZEIxYbJKRsB3ypYgbaxyycrJwc/bd1Pfcma9jGPPGaCv
	h6flTbXkuvURSSgJqWlwKNKGs1NNQtFcquirfcuTWT1DGMwiKWZ1sfsNaZZpAnNxpOD8/U27V5s
	8XYzARhqMRInvQL4bmLsQK3rhsYRw8ZrpGHmtSnyO1qYyHAYweVOTHhxUtMxfJ2uKnY3oLuji0f
	kedppI7voiZWhmZPJz3xyluyW/YJ/wX07eURga2arqurfbWNCLQ6oz6JSEeHfBGPELmfqMoGtkn
	SH/Ag9Br+S+Tquspn9yAexbXqKzoaxF2jDSq/OblSuyxbEhq/WW1ShAqsh
X-Google-Smtp-Source: AGHT+IGoESvGzpUDrJdPJLRLhPWYD3SbdQgNdCWAIIjRLmFYz/jY6rOutROAlH9tr+MSKSD3bFPOYQ==
X-Received: by 2002:a05:6214:2261:b0:87c:2d74:1fef with SMTP id 6a1803df08f44-8801b2227c1mr37575316d6.52.1761828757828;
        Thu, 30 Oct 2025 05:52:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48a6befsm115003726d6.4.2025.10.30.05.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:52:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vES8o-000000058XD-1cvN;
	Thu, 30 Oct 2025 09:52:34 -0300
Date: Thu, 30 Oct 2025 09:52:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	David Rientjes <rientjes@google.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 4/4] mm: introduce and use VMA flag test helpers
Message-ID: <20251030125234.GA1204670@ziepe.ca>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <c038237ee2796802f8c766e0f5c0d2c5b04f4490.1761757731.git.lorenzo.stoakes@oracle.com>
 <20251029192214.GT760669@ziepe.ca>
 <0dd5029f-d464-4c59-aac9-4b3e9d0a3438@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dd5029f-d464-4c59-aac9-4b3e9d0a3438@lucifer.local>

On Thu, Oct 30, 2025 at 10:04:31AM +0000, Lorenzo Stoakes wrote:
> It may also just be sensible to drop the vma_test() since I've named VMA flags
> vma->flags which is kinda neat and not so painful to do:
> 
> 	if (vma_flags_test(&vma->flags, VMA_READ_BIT)) {
> 	}
> 
> Another note - I do hope to drop the _BIT at some point. But it felt egregious
> to do so _now_ since VM_READ, VMA_READ are so close it'd be _super_ easy to
> mistake the two.

Yes, you should have the bit until the non-bit versions are removed
entirely.

> Buuut I'm guessing actually you're thinking more of getting rid of
> vm_flags_word_[and, any, all]() all of which take VM_xxx parameters.

Yes
 
> > few instructions.
> >
> 
> Well I'm not sure, hopefully. Maybe I need to test this and see exactly what the
> it comes up with.
> 
> I mean you could in theory have:
> 
> vma_flags_any(&vma->flags, OR_VMA_FLAGS(VMA_PFNMAP_BIT, VMA_SEALED_BIT))

'any' here means any of the given bits set, yes? So the operation is

(flags & to_test) != 0

Which is bitmap_and, not or. In this case the compiler goes word by
word:

  flags[0] & to_test[0] != 0
  flags[1] & to_test[1] != 0
 
And constant propagation turns it into
  flags[1] & 0 != 0 ----> 0

So the extra word just disappears.

Similarly if you want to do a set bit using or

  flags[0] = flags[0] | to_set[0]
  flags[1] = flags[1] | to_set[1]

And again constant propagation
  flags[1] = flags[1] | 0 ------>  NOP

> I feel like we're going to need the 'special first word' stuff permanently for
> performance reasons.

I think not, look above..

> > Then everything only works with _BIT and we don't have the special
> > first word situation.
> 
> In any case we still need to maintain the word stuff for legacy purposes at
> least to handle the existing vm_flags_*() interfaces until the work is complete.

I think it will be hard to sustain this idea that some operations do
not work on the bits in the second word, it is just not very natural
going forward..

So I'd try to structure things to remove the non-BIT users before
adding multi-word..

Jason

