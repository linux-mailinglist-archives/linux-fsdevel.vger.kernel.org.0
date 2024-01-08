Return-Path: <linux-fsdevel+bounces-7556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE14C827471
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 16:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F422A1C22E5A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jan 2024 15:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D8051037;
	Mon,  8 Jan 2024 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZdTnMWa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96855100D
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jan 2024 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704728911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LXzSdb2GMelu2RY7M9wBwnEHadZ8ZB5xT40HRRNlufA=;
	b=dZdTnMWauN85HiaHp06NHH2tiYWMRwWxF4WFUWOfPKq1VqFLbgOI4PVnUO+5LbrX8nTOuA
	TWtH9wQRKGm2KkxF5zYuqL6nQYNRzoPBAxhraPrzC6YoMUKnIu2KheKBlirpl6DeSbD84c
	REyHc8QRgD7S94JRf2tPXFfplVujajI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-82-5TVjKgI4NYCMEu1t82eQcQ-1; Mon,
 08 Jan 2024 10:48:28 -0500
X-MC-Unique: 5TVjKgI4NYCMEu1t82eQcQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEDDD3C025AC;
	Mon,  8 Jan 2024 15:48:27 +0000 (UTC)
Received: from [100.85.132.103] (ovpn-0-5.rdu2.redhat.com [10.22.0.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C07A8492BC7;
	Mon,  8 Jan 2024 15:48:25 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Vivek Goyal <vgoyal@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, houtao1@huawei.com
Subject: Re: [PATCH v2] virtiofs: use GFP_NOFS when enqueuing request through
 kworker
Date: Mon, 08 Jan 2024 10:48:24 -0500
Message-ID: <A7DF37C3-9C00-4C3C-BFD3-12BE0DE699B3@redhat.com>
In-Reply-To: <20240105105305.4052672-1-houtao@huaweicloud.com>
References: <20240105105305.4052672-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On 5 Jan 2024, at 5:53, Hou Tao wrote:

> From: Hou Tao <houtao1@huawei.com>
>
> When invoking virtio_fs_enqueue_req() through kworker, both the
> allocation of the sg array and the bounce buffer still use GFP_ATOMIC.
> Considering the size of both the sg array and the bounce buffer may be
> greater than PAGE_SIZE, use GFP_NOFS instead of GFP_ATOMIC to lower the
> possibility of memory allocation failure.

Perhaps not appropriate for this case, but are you aware of
memalloc_nofs_save/restore?  NFS has been converting over and cleaning out
our GFP_NOFS usage:

Documentation/core-api/gfp_mask-from-fs-io.rst

Ben


