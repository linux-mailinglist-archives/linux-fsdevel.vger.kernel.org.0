Return-Path: <linux-fsdevel+bounces-4930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E499C806645
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 05:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85917B2120C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 04:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1EE10787
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 04:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nsk8LGL8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83567256D;
	Wed,  6 Dec 2023 03:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755B4C433C7;
	Wed,  6 Dec 2023 03:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701832336;
	bh=lTHpF9Bti1w65vYiC1cnqYOAb09SPxfwZH3wTHGdKGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nsk8LGL8rZUevibrNp9VycS3Ts/i/qovwSjTyj0lZGoABYFWLf3hXOiM6HQjb/Zj8
	 9jxgRJSZLWBW+UEsmX+Ef6P/mO5LqHc26jy5VolPFDzhf3Vc2tZfmENkW53VKWssaq
	 pKi/rWLanfouDImA9l3BctRWwYxJ0Ns20wABdfRM=
Date: Wed, 6 Dec 2023 12:12:10 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Sourav Panda <souravpanda@google.com>, corbet@lwn.net,
	rafael@kernel.org, akpm@linux-foundation.org,
	mike.kravetz@oracle.com, muchun.song@linux.dev, rppt@kernel.org,
	david@redhat.com, rdunlap@infradead.org, chenlinxuan@uniontech.com,
	yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
	bhelgaas@google.com, ivan@cloudflare.com, yosryahmed@google.com,
	hannes@cmpxchg.org, shakeelb@google.com,
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
	surenb@google.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-mm@kvack.org, willy@infradead.org, weixugc@google.com
Subject: Re: [PATCH v6 0/1] mm: report per-page metadata information
Message-ID: <2023120645-survey-puppet-4ae0@gregkh>
References: <20231205223118.3575485-1-souravpanda@google.com>
 <2023120648-droplet-slit-0e31@gregkh>
 <CA+CK2bARjZgnMBL9bOD7p1u=02-fGgWwfiGvsFVpsJWL-VR2ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bARjZgnMBL9bOD7p1u=02-fGgWwfiGvsFVpsJWL-VR2ng@mail.gmail.com>

On Tue, Dec 05, 2023 at 09:57:36PM -0500, Pasha Tatashin wrote:
> Hi Greg,
> 
> Sourav removed the new field from sys/device../nodeN/meminfo as you
> requested; however, in nodeN/vmstat fields still get appended, as
> there is code that displays every item in zone_stat_item,
> node_stat_item without option to opt-out. I mentioned it to you at
> LPC.

Sorry, I thought that was a proc file, not a sysfs file.  Don't grow
that file please, it should not be that way and adding to it will just
cause others to also want to add to it and we end up with the whole proc
file mess...

> In my IOMMU [1] series, there are also fields that are added to
> node_stat_item that as result are appended to nodeN/vmstat.

I missed that, that too shouldn't be done please.

Again, sysfs is "one value per file" for a reason, don't abuse the fact
that we missed this abuse of the rules for that file by adding more
things to it.

thanks,

greg k-h

