Return-Path: <linux-fsdevel+bounces-37470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536649F2A23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 07:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8BCD1669E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Dec 2024 06:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60421CDFB9;
	Mon, 16 Dec 2024 06:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GY0AZMxm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D551C5480;
	Mon, 16 Dec 2024 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734330418; cv=none; b=kI4X9ibUvdgya9Yup6bgN216Hzlg+ILjBbSqvYl+fncwvdPQXl/Ewl/uRybEPHK1p7Cuk5r278DIfxMZ/vADh2a8wm+PffCMg05SmltJ6emdEDf05LtmBvlyKgRogGugL+drmasWPCSPQxPNTmq8RnB7OenSfQx+TB1f224jgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734330418; c=relaxed/simple;
	bh=YTeuGSh1CGSThRU7myc0e4PzU/URwKkheVQYIA9QTkw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n++DPFlq8HbvQMS8HNmpdwajmZu3ktJt9NpDNJYulifq2uAtM+UOa1hSimrVGatToQuCxVKOT8+JW5QA+yowIl/wC3vLtue9YWQOy3sNzj5BNN1+oWwa9xRmnh6PtiFD1QcH6W5TzO7SB89uwJ+l8YkV2QpfQAFecXJI2x2LWAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GY0AZMxm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640B9C4CED0;
	Mon, 16 Dec 2024 06:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1734330417;
	bh=YTeuGSh1CGSThRU7myc0e4PzU/URwKkheVQYIA9QTkw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GY0AZMxmMTcjeSKYZE7GmeuX3SKjxwb/58gdhtCO5ezpDtS7gHlr8h702y1OHXEf3
	 vY6Jr3J4GAa6Wcr8zvbFGqgmpilb6SPi4mi0P9Bicw+/iyZasNONa8WkQjjSoDOyRm
	 3Dc5fonxtLGVn5tPwYlTUYvPZ0flblYJeuQt5VAY=
Date: Sun, 15 Dec 2024 22:26:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, Dan Williams
 <dan.j.williams@intel.com>, linux-mm@kvack.org, lina@asahilina.net,
 zhang.lyra@gmail.com, gerald.schaefer@linux.ibm.com,
 vishal.l.verma@intel.com, dave.jiang@intel.com, logang@deltatee.com,
 bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com,
 will@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ira.weiny@intel.com, willy@infradead.org,
 djwong@kernel.org, tytso@mit.edu, linmiaohe@huawei.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com, sfr@canb.auug.org.au
Subject: Re: [PATCH v3 00/25] fs/dax: Fix ZONE_DEVICE page reference counts
Message-Id: <20241215222655.ef0b15148120a2e2b06b2234@linux-foundation.org>
In-Reply-To: <wysuus23bqmjtwkfu3zutqtmkse3ki3erf45x32yezlrl24qto@xlqt7qducyld>
References: <cover.e1ebdd6cab9bde0d232c1810deacf0bae25e6707.1732239628.git-series.apopple@nvidia.com>
	<675ce1e5a3d68_fad0294d0@dwillia2-xfh.jf.intel.com.notmuch>
	<45555f72-e82a-4196-94af-22d05d6ac947@redhat.com>
	<wysuus23bqmjtwkfu3zutqtmkse3ki3erf45x32yezlrl24qto@xlqt7qducyld>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 11:55:30 +1100 Alistair Popple <apopple@nvidia.com> wrote:

> The remainder are more -mm focussed. However they do depend on the fs/dax
> cleanups in the first half so the trick would be making sure Andrew only takes
> them if the nvdimm.git changes have made it into -next. I'm happy with either
> approach, so let me know if I should split the series or not.

My inclination is to put it all into the nvdimm tree, with appropriate
MM developer acks.

But I'm having difficulty determining how practical that is because the
v3 series is almost a month old so my test merging was quite ugly.

Perhaps you could prepare a new-doesn't-need-to-be-final version for
people to look at and to aid with this head-scratching?

