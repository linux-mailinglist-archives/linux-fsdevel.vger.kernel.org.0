Return-Path: <linux-fsdevel+bounces-14842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F878806CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 22:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C556A1C22116
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 21:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8AC4C626;
	Tue, 19 Mar 2024 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="2d6FvCDm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC95C3BBD5;
	Tue, 19 Mar 2024 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710884003; cv=none; b=Cas8ZzaznoogGNVHakHAFHoKRFdX5no2FU9YmTmY5F37i2yomQCvFrF8HLtWpQehgJfO065jivGQYZZVeZ9Wmt4VuGLq2CqcIILb+1hnP1g6r1kSku+22quc97hAR0weC46cL6CQYhIdl/4otKEpI4/MqSTmEE6ssYCeU1VAjGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710884003; c=relaxed/simple;
	bh=J5WT7lTwbAC1lXKfreuO+YX+l04IPqUHj6iyt9rvxuk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ktumXU42crwD6JGNvu7mPnHJAf8/MvsYeQuiCLA8W4z222zlIkfXLpKfA1Qe0v+rS1NFhb6fIXzQTAqakcRdVkTIItdmDloQw1fHOnzAi4zZczFmyVkRuy+zOWHhT16KeOXZbasLOqs4O827PeUUlgT1LjBB6SyHygDxA4Me3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=2d6FvCDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82463C433C7;
	Tue, 19 Mar 2024 21:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1710884002;
	bh=J5WT7lTwbAC1lXKfreuO+YX+l04IPqUHj6iyt9rvxuk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=2d6FvCDmUDzCnQWUs6H1g2ELt5Bif7X71Z0u7gzOPi0w7QcSwE+An+R17OMSTIPx9
	 iCrN2n/gl/q8nd4aqoJcuV+U1EQOnvyWcioTDrjzxiER2uJb1RnEqHkyaLundadVRQ
	 uoD5sWxCE/LS3LSNv7W7xNDhZ+rS13k/+syZCdXE=
Date: Tue, 19 Mar 2024 14:33:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sourav Panda <souravpanda@google.com>
Cc: corbet@lwn.net, gregkh@linuxfoundation.org, rafael@kernel.org,
 mike.kravetz@oracle.com, muchun.song@linux.dev, rppt@kernel.org,
 david@redhat.com, rdunlap@infradead.org, chenlinxuan@uniontech.com,
 yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com, bhelgaas@google.com,
 ivan@cloudflare.com, pasha.tatashin@soleen.com, yosryahmed@google.com,
 hannes@cmpxchg.org, shakeelb@google.com, kirill.shutemov@linux.intel.com,
 wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz,
 Liam.Howlett@Oracle.com, surenb@google.com, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, willy@infradead.org, weixugc@google.com
Subject: Re: [PATCH v9 1/1] mm: report per-page metadata information
Message-Id: <20240319143320.d1b1ef7f6fa77b748579ba59@linux-foundation.org>
In-Reply-To: <20240220214558.3377482-2-souravpanda@google.com>
References: <20240220214558.3377482-1-souravpanda@google.com>
	<20240220214558.3377482-2-souravpanda@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 13:45:58 -0800 Sourav Panda <souravpanda@google.com> wrote:

> Adds two new per-node fields, namely nr_memmap and nr_memmap_boot,
> to /sys/devices/system/node/nodeN/vmstat and a global Memmap field
> to /proc/meminfo. This information can be used by users to see how
> much memory is being used by per-page metadata, which can vary
> depending on build configuration, machine architecture, and system
> use.

I yield to no man in my admiration of changelogging but boy, that's a
lot of changelogging.  Would it be possible to consolidate the [0/N]
coverletter and the [1/N] changelog into a single thing please?

>  Documentation/filesystems/proc.rst |  3 +++
>  fs/proc/meminfo.c                  |  4 ++++
>  include/linux/mmzone.h             |  4 ++++
>  include/linux/vmstat.h             |  4 ++++
>  mm/hugetlb_vmemmap.c               | 17 ++++++++++++----
>  mm/mm_init.c                       |  3 +++
>  mm/page_alloc.c                    |  1 +
>  mm/page_ext.c                      | 32 +++++++++++++++++++++---------
>  mm/sparse-vmemmap.c                |  8 ++++++++
>  mm/sparse.c                        |  7 ++++++-
>  mm/vmstat.c                        | 26 +++++++++++++++++++++++-
>  11 files changed, 94 insertions(+), 15 deletions(-)

And yet we offer the users basically no documentation.  The new sysfs
file should be documented under Documentation/ABI somewhere and
perhaps we could prepare some more expansive user-facing documentation
elsewhere?

I'd like to hear others' views on the overall usefulness/utility of this
change, please?

