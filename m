Return-Path: <linux-fsdevel+bounces-7820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80BB82B715
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 23:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5812817ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 22:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB3A58AC2;
	Thu, 11 Jan 2024 22:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hnu33nXw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B052258AB8
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 22:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705011889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gtBG75u/OpOtXGJBN05gREou5jfBtFhy8ymC4RoTAOQ=;
	b=Hnu33nXwuMqVYYjfh3uEoozIjNZDkh5g2sLH2G9vwm0J0DE9rcdLzH2wUuHzOWCW4KcVku
	y06YeQg8ynOyzURuJvl/so962LkRAJeddn3zKaIIMIUVuL7Nna6jq8VUMSX3TOv+2CypeQ
	ShCMyye6/K5DLpeE6DTbCXmljZ30KXU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-ssZS43TiOFSzq1xxSFsj1w-1; Thu,
 11 Jan 2024 17:24:46 -0500
X-MC-Unique: ssZS43TiOFSzq1xxSFsj1w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FE1C3C29A66;
	Thu, 11 Jan 2024 22:24:45 +0000 (UTC)
Received: from redhat.com (unknown [10.22.17.159])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E6D751121313;
	Thu, 11 Jan 2024 22:24:44 +0000 (UTC)
Date: Thu, 11 Jan 2024 16:24:43 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	dan.j.williams@intel.com, willy@infradead.org, jack@suse.cz,
	akpm@linux-foundation.org, djwong@kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH v12 0/2] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Message-ID: <ZaBqqwKuLj5gINed@redhat.com>
References: <20230629081651.253626-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629081651.253626-1-ruansy.fnst@fujitsu.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Thu, Jun 29, 2023 at 04:16:49PM +0800, Shiyang Ruan wrote:
> This patchset is to add gracefully unbind support for pmem.
> Patch1 corrects the calculation of length and end of a given range.
> Patch2 introduces a new flag call MF_MEM_REMOVE, to let dax holder know
> it is a remove event.  With the help of notify_failure mechanism, we are
> able to shutdown the filesystem on the pmem gracefully.

What is the status of this patch?
Thanks-
Bill


> 
> Changes since v11:
>  Patch1:
>   1. correct the count calculation in xfs_failure_pgcnt().
>       (was a wrong fix in v11)
>  Patch2:
>   1. use new exclusive freeze_super/thaw_super API, to make sure the unbind
>       progress won't be disturbed by any other freezer.
> 
> Shiyang Ruan (2):
>   xfs: fix the calculation for "end" and "length"
>   mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
> 
>  drivers/dax/super.c         |  3 +-
>  fs/xfs/xfs_notify_failure.c | 95 +++++++++++++++++++++++++++++++++----
>  include/linux/mm.h          |  1 +
>  mm/memory-failure.c         | 17 +++++--
>  4 files changed, 101 insertions(+), 15 deletions(-)
> 
> -- 
> 2.40.1
> 


