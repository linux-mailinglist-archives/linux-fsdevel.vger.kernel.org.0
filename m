Return-Path: <linux-fsdevel+bounces-66467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE8FC201D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 13:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26BAB4EA90F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 12:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27230351FCF;
	Thu, 30 Oct 2025 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gdlfWGl2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E38341645
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761828927; cv=none; b=K+7SlMbiSA+E4RBGFTBgUT7jmHGsiEV13Bacsa1kd6YGHFpPmM+NVMV1BEXA0w6YMRwhpYdQDFXZQqJlZaEmgpem18KhPzdNUCO3wUYX8i7e4pSFgz9jN2fq58auMh3SEaNySvL68KFdXb6g3QZHfUqWQxpHo9pe1oGl+YYx0f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761828927; c=relaxed/simple;
	bh=hDoug8aqE0H9YWALi8NfTTpqiEkwG6fAlIEDVp5LNbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yv80nyE9KiQKkgfx4K+/obNNN96dupSr52pQToLn6Br3VzFIE5BZ5WiXRS8+avNLtDjZir0/tIApm/X9ZwtxRZoxoxlNPxtmuxEf+qpsUspj3JPxWG9QfTai6ERiQ//u1TbENjVyf5Ni9YuRqdadVDtaRn4JYvIxip+hKkLt6Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gdlfWGl2; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4eba313770dso11240501cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761828925; x=1762433725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AjXAFY7Yf0YuI8Me8mv/zue8i3Kx5a6EOrshoHCz3hk=;
        b=gdlfWGl23B3iDrrHFGSttI8Y/8tZxBxzJg8KDgqgdS4zU5P+1v37Ve0nxK/BzbRREL
         JhJn/KKB2wtreDb0dXEg0qc0RixaE+nwDG9OQ/IHH/YZNDNzaBCd9Cdd/+0wFoPROD7i
         Nplc2KuY3IutsnF1D9lcpvZkYk9Nm93CgUHY6NtLQosK5c74slUgrGq0hRWhbkgmEtIt
         X4qeTx/z5WjNndyM1jOLMIjyGRcbfF3yfJToIm8aatTcK+OtI8q9R/9InR/jQmAWsL5p
         35AZ3sik0OAo7+9vTt+4gmkLpWGBE/x+pXpTScIV0/t7Ggkb2KHw1RAzuUmx4sn898xj
         OLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761828925; x=1762433725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AjXAFY7Yf0YuI8Me8mv/zue8i3Kx5a6EOrshoHCz3hk=;
        b=xH4Ad853AukRUtbCQ7E6od8leTAz4KD7J/NprPn/eWoPO0t98swYjx8q8Vr/fbW00d
         7K129lL00awC1yEt/J3xSXeX7pkW5l6VzYvd3IuefoM6NdgJleb7t89tj5MUNw7LkI4Y
         7IiKVC/Hepe3QK94xd6KUVH3zSIs3E+AKkFE9RbNeyc/Jf3nDgNWK6C+tqww/djzBhsk
         75TgM+T1110vL2RoptWXkvr8kNL3kY1I2ZlBBky6q7i7YB0lhaeys8zPrkodvws78b0a
         zpy4oZ/9DzBn1WMGxkubYLZ9N4qmkvBjqxrLy363++pWnagR+wLVJI95pohL4j+bS2Zn
         cBgA==
X-Forwarded-Encrypted: i=1; AJvYcCWb4eW0+DGYoaJX4eflrTsdprGfo0+2aNOVtIQtEukdvRWkPTXLLjx2W5Exi1xXdP/NN/LwgQa+sEXrttZW@vger.kernel.org
X-Gm-Message-State: AOJu0YxuLfiHCpQHr4VDZYbMB+zEeVwVhHP/F+GSJ0m261pN/wPVYcSk
	GBbp9+bRV5Fs9fWyjmExkzH9xPJu+em01Y0cgjA735cee8ge5ZzabQo3RoWW30rq1D4=
X-Gm-Gg: ASbGncuODg3k7h5H90OduOM/JbTyUaGe9p9enFJdhDgZdWBSaO9HJRrEXBcwzEYoFKG
	ujDiNO2nWUGkayrjY0aHHbhCQu8HN/sLb6ehT3AiDxCnCb8txMJIV28s7jeh8zmaqt79zZWyfKi
	KUMzp+XBw6t5qyXD7pXnlN85MVSpeLMvl41/xHfRPpkUAB7lozW/ukpvkcD5hj0NqZNetYmMDnx
	apjOAW8+7CPGH1/v8JTkmVUMgTef3h0Qf57Lq1bSUJCSDyWjgPHhAuKSwf3YM4Z5mGXc0w4/gSF
	Dm4EI9DwZV85GIs6CMe0ds8RrMX69E59mZMxQnLrFv3ERk94OJ8eeJTpAkkq0R/2WupotMJMLMy
	Velw3AvmNjofj0zJt+ymK/YnPXVmCn9Oqv7zUo9qNDsDc98fm0pKuI4VXUfYxsPPFlCSXSim4Iz
	nWVQmfGR/9h0AeiwmpH/qGJNo7zJ9y676u2PySxyBr+4SWP41OAx/nNQf6
X-Google-Smtp-Source: AGHT+IFa87tUftxLW7en98BSp1AWY+Kl/BwNB6G5pnoREpGqN6QyPQ5zvarZ4A1oRBRNtr+ofNzIbw==
X-Received: by 2002:ac8:5a50:0:b0:4ec:b598:2544 with SMTP id d75a77b69052e-4ed15c19a74mr78731841cf.54.1761828923949;
        Thu, 30 Oct 2025 05:55:23 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba3860692sm110493811cf.30.2025.10.30.05.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:55:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vESBV-000000058Xq-46nj;
	Thu, 30 Oct 2025 09:55:21 -0300
Date: Thu, 30 Oct 2025 09:55:21 -0300
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
Subject: Re: [PATCH 1/4] mm: declare VMA flags by bit
Message-ID: <20251030125521.GB1204670@ziepe.ca>
References: <cover.1761757731.git.lorenzo.stoakes@oracle.com>
 <a94b3842778068c408758686fbb5adcb91bdbc3c.1761757731.git.lorenzo.stoakes@oracle.com>
 <20251029190228.GS760669@ziepe.ca>
 <f1d67c7b-5e08-43b3-b98c-8a35a5095052@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1d67c7b-5e08-43b3-b98c-8a35a5095052@lucifer.local>

On Thu, Oct 30, 2025 at 09:07:19AM +0000, Lorenzo Stoakes wrote:
> > >  fs/proc/task_mmu.c               |   4 +-
> > >  include/linux/mm.h               | 286 +++++++++++++++++---------
> > >  tools/testing/vma/vma_internal.h | 341 +++++++++++++++++++++++++++----
> >
> > Maybe take the moment to put them in some vma_flags.h and then can
> > that be included from tools/testing to avoid this copying??
> 
> It sucks to have this copy/paste yeah. The problem is to make the VMA
> userland testing work, we intentionally isolate vma.h/vma.c dependencies
> into vma_internal.h in mm/ and also do the same in the userland component,
> so we can #include vma.c/h in the userland code.
> 
> So we'd have to have a strict requirement that vma_flags.h doesn't import
> any other headers or at least none which aren't substituted somehow in the
> tools/include directory.

I think that's fine, much better than copying it like this..
 
> The issue is people might quite reasonably update include/linux/vma_flags.h
> to do more later and then break all of the VMA userland testing...

If only the selftest build system wasn't such a PITA maybe more people
would run it :(

Jason

