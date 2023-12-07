Return-Path: <linux-fsdevel+bounces-5125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFE5808324
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 09:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1FB282E2A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E59328B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 08:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DfhrW129"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB4C182C4;
	Thu,  7 Dec 2023 07:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E745C433CA;
	Thu,  7 Dec 2023 07:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701934307;
	bh=AQ3zRaWsxl12kZ8IbNOLzKipBmlx9MwTy7N5XYMJexA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DfhrW129VGKpUM3TCX2gNqhQjeGfTNPP0SAxtinRm24SLzTOlmXfo800Ka24OTXpr
	 87dvSP087+Z3Z2U65zg19ilH9Aj/9G9DRZhpw2R/Wz2nN/Rc8t+a0ia1SQfRIhjNS0
	 yxed0pwSEub43xZZYv2Wy0FozCrcInu2zwI2iOEA=
Date: Thu, 7 Dec 2023 08:31:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Sourav Panda <souravpanda@google.com>, corbet@lwn.net,
	rafael@kernel.org, mike.kravetz@oracle.com, muchun.song@linux.dev,
	rppt@kernel.org, david@redhat.com, rdunlap@infradead.org,
	chenlinxuan@uniontech.com, yang.yang29@zte.com.cn,
	tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com,
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com,
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
	surenb@google.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, weixugc@google.com
Subject: Re: [PATCH v6 0/1] mm: report per-page metadata information
Message-ID: <2023120731-deception-handmade-8d49@gregkh>
References: <20231205223118.3575485-1-souravpanda@google.com>
 <2023120648-droplet-slit-0e31@gregkh>
 <CA+CK2bARjZgnMBL9bOD7p1u=02-fGgWwfiGvsFVpsJWL-VR2ng@mail.gmail.com>
 <2023120645-survey-puppet-4ae0@gregkh>
 <20231206075913.fa2633991bf257f5ffe5f3f8@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206075913.fa2633991bf257f5ffe5f3f8@linux-foundation.org>

On Wed, Dec 06, 2023 at 07:59:13AM -0800, Andrew Morton wrote:
> On Wed, 6 Dec 2023 12:12:10 +0900 Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Tue, Dec 05, 2023 at 09:57:36PM -0500, Pasha Tatashin wrote:
> > > Hi Greg,
> > > 
> > > Sourav removed the new field from sys/device../nodeN/meminfo as you
> > > requested; however, in nodeN/vmstat fields still get appended, as
> > > there is code that displays every item in zone_stat_item,
> > > node_stat_item without option to opt-out. I mentioned it to you at
> > > LPC.
> > 
> > Sorry, I thought that was a proc file, not a sysfs file.  Don't grow
> > that file please, it should not be that way and adding to it will just
> > cause others to also want to add to it and we end up with the whole proc
> > file mess...
> > 
> > > In my IOMMU [1] series, there are also fields that are added to
> > > node_stat_item that as result are appended to nodeN/vmstat.
> > 
> > I missed that, that too shouldn't be done please.
> > 
> > Again, sysfs is "one value per file" for a reason, don't abuse the fact
> > that we missed this abuse of the rules for that file by adding more
> > things to it.
> 
> I'm afraid that horse has bolted.
> 
> hp2:/usr/src/25> wc /sys/devices/system/node/node0/vmstat 
>   61  122 1309 /sys/devices/system/node/node0/vmstat
> 
> We're never going to unpick this into 61 separate files so adding new
> files at this stage is pointless.

But if it keeps growing, it will eventually overflow and start crashing
the kernel and you will then have to do the horrid thing of turning it
into a binary sysfs file.

So I can please ask that no new entries be added to the file please,
let's not keep making things worse.  For new items, just add new files,
don't add to the existing mess.

thanks,

greg k-h

