Return-Path: <linux-fsdevel+bounces-66511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF997C2190F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 18:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF151A6186A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 17:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3C436C248;
	Thu, 30 Oct 2025 17:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N+Bjn4dc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D90236CA8B
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846866; cv=none; b=KVX5c7WHmPOUHSOb8VAE8wa2UQ1UZsbVdQEBwPIHitALhf6XXTkRdEIe0Vi/Z8Q+/Cs8mL85natd8XJjHZLPl93CbTUk1yQa/TrnX1r/1BhgFiwN/9/uRSWQYmBsr6We3js0H3bijJ5jomCxaNtNeJMWrerJBBWIGKfXbNp+WDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846866; c=relaxed/simple;
	bh=Ot7VKAWVA6U63aveIdvENPMHR/fzA9s/Q7X9vk9yVwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/z9/yju46tZbP12OUM4fSHGp/4GoJf2q3+NV7LggTwdsHLZXluAPIDGkriUbHKBXZCIdAJmnGRIUll1W0J8Yq+1QD7heOok89FhbHPqKIiJyc2bcvW58LtP9Mt1vRIWmB/q8q4LqqIpVX49TFLX3LCm1t9ss2yytwOo+kS2054=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=N+Bjn4dc; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8738c6fdbe8so16552246d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 10:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761846863; x=1762451663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xnGHUYavdaKYzYofeQc3x2iVgQ4gD7UndQ+CtCjwQis=;
        b=N+Bjn4dcHxxWfAqV5hI3zJl3PYNYCY0uv75DXJhSXvCmXBbvQfPNU1WBIEBGisZ36d
         V2ODdNFGqlmq0qf3nwfIjp8XNEy1TF+bglyj04noDoCc1VIGLJg5MxROuTF3Eex2G6L6
         tDhihRmak7FM9v4o5Y97AqUVjwogUChlcbtnGp45XUXTE477CB902zHsT4UjtoKX1ykr
         jcXG5mavr9wVgbR2zKc9i+VrSKd80EAOpmO0dKi0yMioQRgA+ABo4sazB7U2xPvp7d4E
         /j3GaBnfE2+Tl89HZjnDxNV2p1M3TagBhUHGfVRaSdIf1bMaBKUtSOn2Bdr/Bp1zIgy4
         w39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846863; x=1762451663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xnGHUYavdaKYzYofeQc3x2iVgQ4gD7UndQ+CtCjwQis=;
        b=mH5fpwWG8ULta9E7FnGDxaitVIfUDE2KMjfNmCFGvsctjd21BJAinkHi2SuptwmXYb
         sBH1BKQ3AgthOAtZjDLIT4mcLo05RFP2etCPyq5GfpMJL886Dsl7E1xiRuaDpZe9n4xI
         DjK7hyGzLISRXRx+gq2qzbMMSD/d4j3az3++MjBNAP76cDAiAVA37GiOVTrgghJlCWda
         1ELpMhwP+ZEcsCuKNRvpUECCjXlgnCMLifNII4QZ9OqI0P+vlvidtl/2ijGZTD5FRaN/
         w2rZFGhbOZx18gbNLjkye0I8YhV8Oo1gFcmjozz0sPuavAP2xtHEreC5ZDlF1NxV6Nv5
         b+YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTeA4sMiQYgL8WTsuaNmackIWjA3j6YRGVNNTTwwd2IvZMLB9Qzj37Wdh0H+jd9cLu9ADVIww8oshfY3a4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1+P9vKhAhuEpFYP4kMx+nK3ENDWgWd83vX4tBy7CIaGi89lQr
	68qnUWC7z0QG9fwAxLKv4+Lcaa8qLI+Y5BkwRdBKl3QhT1RE+UvrLVK85qp8trBl+s0=
X-Gm-Gg: ASbGncvA4yh5JDHaReXLrCCuhak/dcsBWV0nIEnOYnnSSrdxrE86ot8DeY9KO0j7TOs
	dqM7IJnKl/T7qvYC+bCj79E9Z3YqVLeXZVWO4V75mSB9G9AreecS+SB6bJk34FecO6Ufm3p9mP5
	7zG8GKxUJngw3mj0Yj2LoKWTJ6uQvq9GfTQfyGBPSh5Kmh6GfYw+feJIhAZevB/oSKtGNOQf4zF
	q6PkXK7b0l0E1MPhT5fb8BbJ3KbMSkZDFSHff5Xv7+P8XI1PSH+cNCp2QbPMJSeBMh/T03WNROM
	LpiENrBJQEUD3IJZdk2nvLZUqgmtyeQ+cs4xT0qyPH12BLCXS+b1MzbISzEMj2ZUYR0GwciW4tu
	tvvM2lhHO5/BHHV4iKswBDlSqYaADWyTlvVJVhodlqao6jpvBlB5D0JVotXjb97HT2IOzv/NZoi
	r65lTBritFVPldKZCpkAgAMcALZy5myAGsys5Tf7cpVZFpuw==
X-Google-Smtp-Source: AGHT+IFT5Fmbku/PhtCEDW1KeFw5jyVfP+ejaWvNde5H/+ME0TqKpHB8wRouWON1EINpWnQqdBBBmg==
X-Received: by 2002:ad4:5ca5:0:b0:87c:2095:c582 with SMTP id 6a1803df08f44-8801aca0a1bmr63713946d6.18.1761846863017;
        Thu, 30 Oct 2025 10:54:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba387a61bsm115313061cf.36.2025.10.30.10.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:54:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vEWqr-00000005AuU-2aX4;
	Thu, 30 Oct 2025 14:54:21 -0300
Date: Thu, 30 Oct 2025 14:54:21 -0300
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
Message-ID: <20251030175421.GC1204670@ziepe.ca>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <c038237ee2796802f8c766e0f5c0d2c5b04f4490.1761757731.git.lorenzo.stoakes@oracle.com>
 <20251029192214.GT760669@ziepe.ca>
 <0dd5029f-d464-4c59-aac9-4b3e9d0a3438@lucifer.local>
 <20251030125234.GA1204670@ziepe.ca>
 <a7161d7d-7445-4015-8821-b32c469d6eaf@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7161d7d-7445-4015-8821-b32c469d6eaf@lucifer.local>

On Thu, Oct 30, 2025 at 02:03:02PM +0000, Lorenzo Stoakes wrote:

> Yeah, OK well your point has been made here, the compiler _is_ smart enough
> to save us here :)
> 
> Let's avoid this first word stuff altogether then.

I suggest to add some helpers to the general include/linux/bitmap.h
"subsystem" that lets it help do this:

#define BITMAP_OR_BITS(type, member, bit1, bit2, bit3) 

returns a type with the bitmap array member initialized to those bits

Then some other bitmap helpers that are doing the specific maths you
want..

* bitmap_and_eq(src1, src2, src3, nbits)  true if *src1 & *src2 == *src3
* bitmap_and_eq_zero(src1, src2, nbits)   true if *src1 & *src1 == 0
etc

Jason

