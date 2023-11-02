Return-Path: <linux-fsdevel+bounces-1832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 731897DF502
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 15:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2D3281B75
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 14:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F017D1BDD1;
	Thu,  2 Nov 2023 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M/uLoMdZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CF01642F;
	Thu,  2 Nov 2023 14:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DE8C433BA;
	Thu,  2 Nov 2023 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1698935343;
	bh=bRsB7LoOlwnaeDzBn85F8lO8jv7acyGjA2Bu9E6BZ2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M/uLoMdZ7OeZHtSdv51jpB5lwNINNYilKSiD8FCSlvz3Wd5OhVqN7DpoiuTvn8mhi
	 HNUUEXa//lmAQ4U16ismcVo9rOtNfuc8BrCzIZLvx2pYfPkaY3OsmYoSvxxpv3NEMP
	 SULUnKFIWBs+xxjqeYA6fjFYOPDA5cvceyUbPu/U=
Date: Thu, 2 Nov 2023 15:28:58 +0100
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
Subject: Re: [PATCH v5 1/1] mm: report per-page metadata information
Message-ID: <2023110216-labrador-neurosis-1e6e@gregkh>
References: <20231101230816.1459373-1-souravpanda@google.com>
 <20231101230816.1459373-2-souravpanda@google.com>
 <2023110205-enquirer-sponge-4f35@gregkh>
 <CA+CK2bDUaQDwgF-Q0vfNzHfXmn-QhnHTSE32_RfttHSGB7O3DA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDUaQDwgF-Q0vfNzHfXmn-QhnHTSE32_RfttHSGB7O3DA@mail.gmail.com>

On Thu, Nov 02, 2023 at 10:24:04AM -0400, Pasha Tatashin wrote:
> On Thu, Nov 2, 2023 at 1:42 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Nov 01, 2023 at 04:08:16PM -0700, Sourav Panda wrote:
> > > Adds a new per-node PageMetadata field to
> > > /sys/devices/system/node/nodeN/meminfo
> >
> > No, this file is already an abuse of sysfs and we need to get rid of it
> > (it has multiple values in one file.)  Please do not add to the
> > nightmare by adding new values.
> 
> Hi Greg,
> 
> Today, nodeN/meminfo is a counterpart of /proc/meminfo, they contain
> almost identical fields, but show node-wide and system-wide views.

And that is wrong, and again, an abuse of sysfs, please do not continue
to add to it, that will only cause problems.

> Since per-page metadata is added into /proc/meminfo, it is logical to
> add into nodeN/meminfo, some nodes can have more or less struct page
> data based on size of the node, and also the way memory is configured,
> such as use of vmemamp optimization etc, therefore this information is
> useful to users.
> 
> I am not aware of any example of where a system-wide field from
> /proc/meminfo is represented as a separate sysfs file under node0/. If
> nodeN/meminfo is ever broken down into separate files it will affect
> all the fields in it the same way with or without per-page metadata

All of the fields should be individual files, please start adding them
if you want to add new items, I do not want to see additional abuse here
as that will cause problems (as you are seeing with the proc file.)

> > Also, even if you did want to do this, you didn't document it properly
> > in Documentation/ABI/ :(
> 
>  The documentation for the fields in nodeN/meminfo is only specified
> in  Documentation/filesystems/proc.rst, there is no separate sysfs
> Documentation for the fields in this file, we could certainly add
> that.

All sysfs files need to be documented in Documentation/ABI/ otherwise
you should get a warning when running our testing scripts.

thanks,

greg k-h

