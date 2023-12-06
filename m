Return-Path: <linux-fsdevel+bounces-5025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F9C807547
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 17:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4EDC1C20B4A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C9848CC5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0O5bufUD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182014595E;
	Wed,  6 Dec 2023 15:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B370AC433CC;
	Wed,  6 Dec 2023 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1701878354;
	bh=vpZXpKKJhkH6bdcDcPHqena5ZG4UsjJfgD/hPx3L2wQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=0O5bufUDnm1ei+vk3IbzWI0+SGmHFkjtd6P/tbLUa0VD2zyoLUc9ML6LLfMDUXl5C
	 yRdObtb5p8LZmfnfyRicLGcpZ8FCC68mIA1KatDT2DvCTEeb1KBjR+kCNwXLN/furT
	 8J2CnqhbUUGYxwraCtuy+GBB+DipyZMAyamjRRB0=
Date: Wed, 6 Dec 2023 07:59:13 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Sourav Panda
 <souravpanda@google.com>, corbet@lwn.net, rafael@kernel.org,
 mike.kravetz@oracle.com, muchun.song@linux.dev, rppt@kernel.org,
 david@redhat.com, rdunlap@infradead.org, chenlinxuan@uniontech.com,
 yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com, bhelgaas@google.com,
 ivan@cloudflare.com, yosryahmed@google.com, hannes@cmpxchg.org,
 shakeelb@google.com, kirill.shutemov@linux.intel.com,
 wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz,
 Liam.Howlett@oracle.com, surenb@google.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, weixugc@google.com
Subject: Re: [PATCH v6 0/1] mm: report per-page metadata information
Message-Id: <20231206075913.fa2633991bf257f5ffe5f3f8@linux-foundation.org>
In-Reply-To: <2023120645-survey-puppet-4ae0@gregkh>
References: <20231205223118.3575485-1-souravpanda@google.com>
	<2023120648-droplet-slit-0e31@gregkh>
	<CA+CK2bARjZgnMBL9bOD7p1u=02-fGgWwfiGvsFVpsJWL-VR2ng@mail.gmail.com>
	<2023120645-survey-puppet-4ae0@gregkh>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Dec 2023 12:12:10 +0900 Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Dec 05, 2023 at 09:57:36PM -0500, Pasha Tatashin wrote:
> > Hi Greg,
> > 
> > Sourav removed the new field from sys/device../nodeN/meminfo as you
> > requested; however, in nodeN/vmstat fields still get appended, as
> > there is code that displays every item in zone_stat_item,
> > node_stat_item without option to opt-out. I mentioned it to you at
> > LPC.
> 
> Sorry, I thought that was a proc file, not a sysfs file.  Don't grow
> that file please, it should not be that way and adding to it will just
> cause others to also want to add to it and we end up with the whole proc
> file mess...
> 
> > In my IOMMU [1] series, there are also fields that are added to
> > node_stat_item that as result are appended to nodeN/vmstat.
> 
> I missed that, that too shouldn't be done please.
> 
> Again, sysfs is "one value per file" for a reason, don't abuse the fact
> that we missed this abuse of the rules for that file by adding more
> things to it.

I'm afraid that horse has bolted.

hp2:/usr/src/25> wc /sys/devices/system/node/node0/vmstat 
  61  122 1309 /sys/devices/system/node/node0/vmstat

We're never going to unpick this into 61 separate files so adding new
files at this stage is pointless.

