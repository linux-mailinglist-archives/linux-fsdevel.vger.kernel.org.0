Return-Path: <linux-fsdevel+bounces-43031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA9FA4D2A8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 05:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091BB170977
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 04:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3D81F4284;
	Tue,  4 Mar 2025 04:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dF8tbczv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7631273FE;
	Tue,  4 Mar 2025 04:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741063563; cv=none; b=LeAKuuh9li8StLpYV8oeTzRhH1cdK77te397pYZb3gv2PJbsrHiDZhLolNFPPViiDXlXhXdopwdLFALLxwBZro/c/Ye69jkqoV+yIj1euH198GVpg+2h4fq0zqdaOsBnQNX8qmceQYOYQX5HcXyfGqsAPHTeEbjD52ail6ETI2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741063563; c=relaxed/simple;
	bh=BIFrLh9/bQIuBnwap0eqz54Lk04kbf4V0DZ+B0m2mNI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jfB1EMyrwQsdTUZjvh8yd5fsIP45BrcNRWreoPx8oGLW5nmvs39visp7L80Py/VRJd9qbQ+cicRhBh6cOme3XsCCKu+a8kQesVZJZNDmGxfNygrX75bLRMeq9kcmXTqq3QaRAmyCTgmn9J9YrH29Nm/D7dBsYud0YOroVf89XJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dF8tbczv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13364C4CEE5;
	Tue,  4 Mar 2025 04:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1741063562;
	bh=BIFrLh9/bQIuBnwap0eqz54Lk04kbf4V0DZ+B0m2mNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dF8tbczvEn6O6hRjSdWKxvQKkGRzNDZEQd6dsg0AiFp2L+F6YCMhGyxTx3ZlL53AI
	 kaXbQDaf9UtJ2eGtPxCyhDiD+/NG8ggB7max5UArq9jsbxOqNhnoi74SE44bszJ2Pe
	 oKDZeMXGXB5LFz8Eg4Vk7YAWHaK0unPGQ7GwUCdU=
Date: Mon, 3 Mar 2025 20:46:00 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: dan.j.williams@intel.com, linux-mm@kvack.org, Alison Schofield
 <alison.schofield@intel.com>, lina@asahilina.net, zhang.lyra@gmail.com,
 gerald.schaefer@linux.ibm.com, vishal.l.verma@intel.com,
 dave.jiang@intel.com, logang@deltatee.com, bhelgaas@google.com,
 jack@suse.cz, jgg@ziepe.ca, catalin.marinas@arm.com, will@kernel.org,
 mpe@ellerman.id.au, npiggin@gmail.com, dave.hansen@linux.intel.com,
 ira.weiny@intel.com, willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
 linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
 david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
 loongarch@lists.linux.dev
Subject: Re: [PATCH v9 00/20] fs/dax: Fix ZONE_DEVICE page reference counts
Message-Id: <20250303204600.cb49d2d614efcded0b28f8c1@linux-foundation.org>
In-Reply-To: <xhbru4aekyfl25552le5tvifwonyuwoyioxrqxy6zkm2xlyhc5@oqxnudb4bope>
References: <cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nvidia.com>
	<xhbru4aekyfl25552le5tvifwonyuwoyioxrqxy6zkm2xlyhc5@oqxnudb4bope>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Feb 2025 14:42:40 +1100 Alistair Popple <apopple@nvidia.com> wrote:

> This is essentially the same as what's currently in mm-unstable aside from
> the two updates listed below. The main thing to note is it incorporates
> Balbir's fixup which is currently in mm-unstable as c98612955016
> ("mm-allow-compound-zone-device-pages-fix-fix")
> 

Thanks, I've updated mm.git to this v9 series.

