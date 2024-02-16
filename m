Return-Path: <linux-fsdevel+bounces-11786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CF4857254
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 01:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C51A02829A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 00:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E70746B1;
	Fri, 16 Feb 2024 00:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NmuFr7oc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCC1320A;
	Fri, 16 Feb 2024 00:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042484; cv=none; b=LqKkqju+PWdzbEIai+0FfCo2or/GirgB5DMGzDaOj2msLPGTAqmlki2qTn4GFnC+fvwy0o2bhLB5eT/TujHf1/iRGTEHvxOFPwJkVKYVSInfxkI431aLHuT/MJ2G5PKKK/SW0uxHP7W7DNZ3yXAT9kEbnHNK0sKtJ6QZw/bFLDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042484; c=relaxed/simple;
	bh=8459CvzrorfNe/cHAzd0ENqIMMQm58MSFuttK55PuAY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aoOQXz4IWy8j7t1Xp4GJ/X1UL3g8GnB4He5mKjTytTKOIxcyO7wqiTM7bcUpyZMrCzApIjINTw278t1LPsbv94w86ZLbgO5sN0EKqoGTd4DRDwxsaLmwT+0kR7R8hOHbDutXQaZ727fJm195jKuJ+8UamuGGOZDRemEIC3+DwtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NmuFr7oc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C5DC433F1;
	Fri, 16 Feb 2024 00:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708042483;
	bh=8459CvzrorfNe/cHAzd0ENqIMMQm58MSFuttK55PuAY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NmuFr7ocD51+UfkvZDHdvyhHagtotjPmkxo7YcRAWBCFwI6mcb1Dk8SCHmgCXuvdB
	 n0AX/l1ga0WmPPMZCUeBERXcafl8pl0yCjOhZDCFHuAUl6NY44ayokHvZqWCiY91PU
	 uv3zTNGTY0GhIcYj/dVFAIW1OmfzQsp3zc+0Nm5E=
Date: Thu, 15 Feb 2024 16:14:41 -0800
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
Subject: Re: [PATCH v8 1/1] mm: report per-page metadata information
Message-Id: <20240215161441.c8a2350a61f6929c0dbe9e7b@linux-foundation.org>
In-Reply-To: <20240214225741.403783-2-souravpanda@google.com>
References: <20240214225741.403783-1-souravpanda@google.com>
	<20240214225741.403783-2-souravpanda@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 14:57:40 -0800 Sourav Panda <souravpanda@google.com> wrote:

> Adds two new per-node fields, namely nr_memmap and nr_memmap_boot,
> to /sys/devices/system/node/nodeN/vmstat and a global Memmap field
> to /proc/meminfo. This information can be used by users to see how
> much memory is being used by per-page metadata, which can vary
> depending on build configuration, machine architecture, and system
> use.

Would this information be available by the proposed memory
allocation profiling?

https://lkml.kernel.org/r/20240212213922.783301-1-surenb@google.com

