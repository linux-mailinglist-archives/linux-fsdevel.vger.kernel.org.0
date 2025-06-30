Return-Path: <linux-fsdevel+bounces-53240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3655EAED22F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 03:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04AFC3B3883
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 01:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9B8131E49;
	Mon, 30 Jun 2025 01:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="t/LHqihr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DA31BC2A;
	Mon, 30 Jun 2025 01:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751246339; cv=none; b=a4rvERifr1t796ahYjSwoMTmTCksw7aqLFrcWhylNZNRBwx+rX9XUL3qhgiZYxbIq5Qfk3/R0LfSD/3N1Jtu3/XOgGJ7AWD6+xBY8l6uzDq74nGAkkXzcaT5oCZWRZgtiobSkd6O5xV7S9WBo4i0VSZ9KgBR03k/kBY9Y5gm3GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751246339; c=relaxed/simple;
	bh=RbZOpy8J0k5RuQe6TfwdpEBKFEQv7E87hUnTEjHxunw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=celMWC0KYi64lJ1p5pmDGNrtABiQ9SNb9PwPNxO7WyCaoVq71/wbIMYjEWu/HPFNDiteEOqJ+zzKK22AiGp0KE+psz3lcUtMYazS9DAgDOb1OoJAoMTJ6uOMRFD3iHUAFVGMQZ7M9FUNeuepo/vAvDqbPnGlOlAexMMjRNsuElI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=t/LHqihr; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751246328; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=RbZOpy8J0k5RuQe6TfwdpEBKFEQv7E87hUnTEjHxunw=;
	b=t/LHqihrskVy6VS5sWIGW/gbybXBOmjMXIaxNd7ZtpYz4VC3rK21Z+L5ZjoCuR6NcqpHyQ7kTSRR6/W7f3V60tKKzxyPF5PY0A1B0GWVmon8i96GvJDacQJPCIjqP5wPVcpnAqvsWpWqbJzG1RvSz6/hcMjmRUVaZHAEQlJwy8U=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0Wg2L3YV_1751246322 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 30 Jun 2025 09:18:43 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org,  linux-mm@kvack.org,
  linux-doc@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
  virtualization@lists.linux.dev,  linux-fsdevel@vger.kernel.org,  Andrew
 Morton <akpm@linux-foundation.org>,  Jonathan Corbet <corbet@lwn.net>,
  Madhavan Srinivasan <maddy@linux.ibm.com>,  Michael Ellerman
 <mpe@ellerman.id.au>,  Nicholas Piggin <npiggin@gmail.com>,  Christophe
 Leroy <christophe.leroy@csgroup.eu>,  Jerrin Shaji George
 <jerrin.shaji-george@broadcom.com>,  Arnd Bergmann <arnd@arndb.de>,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  Eugenio =?utf-8?Q?P=C3=A9rez?=
 <eperezma@redhat.com>,
  Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Jan Kara <jack@suse.cz>,  Zi Yan <ziy@nvidia.com>,
  Matthew Brost <matthew.brost@intel.com>,  Joshua Hahn
 <joshua.hahnjy@gmail.com>,  Rakie Kim <rakie.kim@sk.com>,  Byungchul Park
 <byungchul@sk.com>,  Gregory Price <gourry@gourry.net>,  Alistair Popple
 <apopple@nvidia.com>,  Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
  "Liam R. Howlett" <Liam.Howlett@oracle.com>,  Vlastimil Babka
 <vbabka@suse.cz>,  Mike Rapoport <rppt@kernel.org>,  Suren Baghdasaryan
 <surenb@google.com>,  Michal Hocko <mhocko@suse.com>,  "Matthew Wilcox
 (Oracle)" <willy@infradead.org>,  Minchan Kim <minchan@kernel.org>,
  Sergey Senozhatsky <senozhatsky@chromium.org>,  Brendan Jackman
 <jackmanb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Jason
 Gunthorpe <jgg@ziepe.ca>,  John Hubbard <jhubbard@nvidia.com>,  Peter Xu
 <peterx@redhat.com>,  Xu Xin <xu.xin16@zte.com.cn>,  Chengming Zhou
 <chengming.zhou@linux.dev>,  Miaohe Lin <linmiaohe@huawei.com>,  Naoya
 Horiguchi <nao.horiguchi@gmail.com>,  Oscar Salvador <osalvador@suse.de>,
  Rik van Riel <riel@surriel.com>,  Harry Yoo <harry.yoo@oracle.com>,  Qi
 Zheng <zhengqi.arch@bytedance.com>,  Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH RFC 13/29] mm/balloon_compaction: stop using
 __ClearPageMovable()
In-Reply-To: <20250618174014.1168640-14-david@redhat.com> (David Hildenbrand's
	message of "Wed, 18 Jun 2025 19:39:56 +0200")
References: <20250618174014.1168640-1-david@redhat.com>
	<20250618174014.1168640-14-david@redhat.com>
Date: Mon, 30 Jun 2025 09:18:42 +0800
Message-ID: <87ldpaowlp.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

David Hildenbrand <david@redhat.com> writes:

> We can just look at the balloon device (stored in page->private), to see
> of the page is still part of the balloon.

s/of/if/

?

just a trivial issue if I'm not wrong.

> As isolated balloon pages cannot get released (they are taken off the
> balloon list while isolated), we don't have to worry about this case in
> the putback and migration callback. Add a WARN_ON_ONCE for now.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

[snip]

---
Best Regards,
Huang, Ying

