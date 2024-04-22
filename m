Return-Path: <linux-fsdevel+bounces-17437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B11568AD598
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 22:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BF71F21288
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 20:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632AE155723;
	Mon, 22 Apr 2024 20:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eUR+HEre"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD7A15535D
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 20:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816401; cv=none; b=JHOBsIWgw3Ni175ssg2sGtWf6w+T7RQlYhHuv+P2o0lJfEJMdb08EdibL8K3SYL6Mfd3RWejdnSNtPMxlOHlF2MqJw8XQN30Ous1AVJIWXBNKuOh7/N6qSPD60uQYx8033YP9Do8EtHok/2+sQoCDZx/4W2oxlPvcEVmOw0lIp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816401; c=relaxed/simple;
	bh=2/7JJY4Qu5L4+OdjNSuo6CjRPPVe2dKcAMrnefj0VM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gl4wSuARU/I10SwMhSCRVE/S/oPLRwGx4z9RUzk9VY5SwZql+ZkHiDvTijUn3wnzYPcnhNvTm5cGRCOPGlM1Ptadz5xco5UdEFTX1uSBzikwFqiZXlzYgLghmu2ZcKkGVo5l5NyWD0dea11znnCsmorYsp64WgxsqpItRML0vEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eUR+HEre; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713816398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0lIPjvLLe8W5yhs9jb7Hopq3RJaIntEtybS+M9hbeM8=;
	b=eUR+HEreYKRM6Vargnu6s5flzQRXB7Y6qFtXwUu7xQeSwWYrz7xnraO0jrG6/trlAmjspv
	5uw9CEpzjSiepF72JSs3zKa/fvwSNSJUlhcsY4KWOumvHFCi20NdQjaZU4r0U3PAgdoipT
	VseuqedxYXXmyJ1qwnni8cehHYgvPsw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-ZQV8BaweNF6XJv5DdfZNCA-1; Mon, 22 Apr 2024 16:06:37 -0400
X-MC-Unique: ZQV8BaweNF6XJv5DdfZNCA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-349cf13db2fso2971919f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Apr 2024 13:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713816396; x=1714421196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lIPjvLLe8W5yhs9jb7Hopq3RJaIntEtybS+M9hbeM8=;
        b=HnyxoL9LTv3I/qxOU3VGVjFLDP6+j0B7B92tfOA1VsUDE8EuE0qcw2tawIqxfyfvDi
         bBiAcmKw41WA9xG9zIUhabBQk114XfAi1RdGX/HanJcRC6bhVw5YBJOu4wn9yEomw4mc
         kHqgvr0jf0WMm158xRlUFO7LhDzG0VNI77OgFfDJpBbBtCg/DX3+r22bbQpJUgrmKPwb
         i4mpJCfLm87q4Bs3onOP9z23kCYn2fuz4GFXm70dOHkG+YAnJHDL4hJwQA190itCchE0
         5xC2AmnFlfneD4JGaXrud6I43TFA7jFyfWaQMWAQJlZqFBcw0mHvqtCLtDzKHPxDPKb2
         qB/g==
X-Gm-Message-State: AOJu0YxZLsqaoGzcqlzm8XvnlR3V7JPTDjwXgbt01ydX2Yro/CbhLVxc
	IrKUNFRY6GLKU2VtQyp2b3K5m88eXtWdD/7L7cusJR6EcGV9L3rVB5C3cILVHrZUIHcLn8SoOqR
	rXZPpjHqKKD5uROPbVRMHfcxa5iTO+/wk7B38nKTn2kGPrPrrHrQwvs9SLaFGJEY=
X-Received: by 2002:adf:f18b:0:b0:34a:1a7a:9d60 with SMTP id h11-20020adff18b000000b0034a1a7a9d60mr7640304wro.62.1713816395863;
        Mon, 22 Apr 2024 13:06:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHND6Vh2XDHMA3jWgmPOvHXsu3zVgYNWXES4lL4e0odswgf6F1OyS6srhg0vHCgMCGs6pJ3TA==
X-Received: by 2002:adf:f18b:0:b0:34a:1a7a:9d60 with SMTP id h11-20020adff18b000000b0034a1a7a9d60mr7640282wro.62.1713816395286;
        Mon, 22 Apr 2024 13:06:35 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d62cc000000b00349c42f2559sm12839263wrv.11.2024.04.22.13.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:06:34 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:06:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hou Tao <houtao@huaweicloud.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	Matthew Wilcox <willy@infradead.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	houtao1@huawei.com
Subject: Re: [PATCH v2 0/6] virtiofs: fix the warning for ITER_KVEC dio
Message-ID: <20240422160615-mutt-send-email-mst@kernel.org>
References: <20240228144126.2864064-1-houtao@huaweicloud.com>
 <20240408034514-mutt-send-email-mst@kernel.org>
 <413bd868-a16b-f024-0098-3c70f7808d3c@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413bd868-a16b-f024-0098-3c70f7808d3c@huaweicloud.com>

On Tue, Apr 09, 2024 at 09:48:08AM +0800, Hou Tao wrote:
> Hi,
> 
> On 4/8/2024 3:45 PM, Michael S. Tsirkin wrote:
> > On Wed, Feb 28, 2024 at 10:41:20PM +0800, Hou Tao wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> Hi,
> >>
> >> The patch set aims to fix the warning related to an abnormal size
> >> parameter of kmalloc() in virtiofs. The warning occurred when attempting
> >> to insert a 10MB sized kernel module kept in a virtiofs with cache
> >> disabled. As analyzed in patch #1, the root cause is that the length of
> >> the read buffer is no limited, and the read buffer is passed directly to
> >> virtiofs through out_args[0].value. Therefore patch #1 limits the
> >> length of the read buffer passed to virtiofs by using max_pages. However
> >> it is not enough, because now the maximal value of max_pages is 256.
> >> Consequently, when reading a 10MB-sized kernel module, the length of the
> >> bounce buffer in virtiofs will be 40 + (256 * 4096), and kmalloc will
> >> try to allocate 2MB from memory subsystem. The request for 2MB of
> >> physically contiguous memory significantly stress the memory subsystem
> >> and may fail indefinitely on hosts with fragmented memory. To address
> >> this, patch #2~#5 use scattered pages in a bio_vec to replace the
> >> kmalloc-allocated bounce buffer when the length of the bounce buffer for
> >> KVEC_ITER dio is larger than PAGE_SIZE. The final issue with the
> >> allocation of the bounce buffer and sg array in virtiofs is that
> >> GFP_ATOMIC is used even when the allocation occurs in a kworker context.
> >> Therefore the last patch uses GFP_NOFS for the allocation of both sg
> >> array and bounce buffer when initiated by the kworker. For more details,
> >> please check the individual patches.
> >>
> >> As usual, comments are always welcome.
> >>
> >> Change Log:
> > Bernd should I just merge the patchset as is?
> > It seems to fix a real problem and no one has the
> > time to work on a better fix .... WDYT?
> 
> Sorry for the long delay. I am just start to prepare for v3. In v3, I
> plan to avoid the unnecessary memory copy between fuse args and bio_vec.
> Will post it before next week.

Didn't happen before this week apparently.

> >
> >
> >> v2:
> >>   * limit the length of ITER_KVEC dio by max_pages instead of the
> >>     newly-introduced max_nopage_rw. Using max_pages make the ITER_KVEC
> >>     dio being consistent with other rw operations.
> >>   * replace kmalloc-allocated bounce buffer by using a bounce buffer
> >>     backed by scattered pages when the length of the bounce buffer for
> >>     KVEC_ITER dio is larger than PAG_SIZE, so even on hosts with
> >>     fragmented memory, the KVEC_ITER dio can be handled normally by
> >>     virtiofs. (Bernd Schubert)
> >>   * merge the GFP_NOFS patch [1] into this patch-set and use
> >>     memalloc_nofs_{save|restore}+GFP_KERNEL instead of GFP_NOFS
> >>     (Benjamin Coddington)
> >>
> >> v1: https://lore.kernel.org/linux-fsdevel/20240103105929.1902658-1-houtao@huaweicloud.com/
> >>
> >> [1]: https://lore.kernel.org/linux-fsdevel/20240105105305.4052672-1-houtao@huaweicloud.com/
> >>
> >> Hou Tao (6):
> >>   fuse: limit the length of ITER_KVEC dio by max_pages
> >>   virtiofs: move alloc/free of argbuf into separated helpers
> >>   virtiofs: factor out more common methods for argbuf
> >>   virtiofs: support bounce buffer backed by scattered pages
> >>   virtiofs: use scattered bounce buffer for ITER_KVEC dio
> >>   virtiofs: use GFP_NOFS when enqueuing request through kworker
> >>
> >>  fs/fuse/file.c      |  12 +-
> >>  fs/fuse/virtio_fs.c | 336 +++++++++++++++++++++++++++++++++++++-------
> >>  2 files changed, 296 insertions(+), 52 deletions(-)
> >>
> >> -- 
> >> 2.29.2


