Return-Path: <linux-fsdevel+bounces-51332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EAFAD59EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 17:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6510D3A830C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 15:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412241AE875;
	Wed, 11 Jun 2025 15:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f9LRhXrh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137B31A9B23
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749654657; cv=none; b=paUP+GXrZyRL7CAkF6ocCguWgxeH76QPBnauOo1GoyWNNz+SXZPrnEm13KX01lKtSYZaLHjFsDlnQi7CBRU/pjYQus8NEBrjiERhVy7DuUewTInj+RGJ/c4+fHDvmK0AgrY1g3/2KV6Xbf79RoBGFcq8N6aIECK42m+nm5V4UiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749654657; c=relaxed/simple;
	bh=J+Cb82L7O/BiPrcKvhRJcV6B/aNRdSmFiESgx/lMDDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rq8jkyYph/5RJ/TwKNm6KEsfqzt75IE3EHENHAkJO/4IrAwSuz6q5CTLdTLim3yzNWM7xxHehAjo9ei2akNLibGzC8eKpmEg6DfdaXEG6EFsuoXwVDiDkhOuD/wdm/s51bdbdzWIJWJLvkj0hQcGjkjknUTUSQNQhmuh7G4HH38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f9LRhXrh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749654655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lWkNewhRJ4wpEDm7PPC52E6cJKu2Um4iV+x8uvVQe/M=;
	b=f9LRhXrhXzTOfcBRaJN4qHvUgL9IoveOVZ09RwMNI1VLb+2o83rd/MJEJiFjRnDaQHLQxg
	13I0mz6dq2F0tj/4oUcr+/vSg18lqi+cs58KVx7DOIGALITBvRA8F47xDpBjr+cSywZc/D
	gbQiHFojnPJ2iW9EPqiYLO46o2tBfek=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-zveqg8ABN8KQBI07Ze_SoA-1; Wed,
 11 Jun 2025 11:10:49 -0400
X-MC-Unique: zveqg8ABN8KQBI07Ze_SoA-1
X-Mimecast-MFC-AGG-ID: zveqg8ABN8KQBI07Ze_SoA_1749654647
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69F09195604F;
	Wed, 11 Jun 2025 15:10:46 +0000 (UTC)
Received: from fedora (unknown [10.72.116.18])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4AFD11956087;
	Wed, 11 Jun 2025 15:10:33 +0000 (UTC)
Date: Wed, 11 Jun 2025 23:10:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Cc: stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
	Hagar Hemdan <hagarhem@amazon.com>, Shaoying Xu <shaoyi@amazon.com>,
	Jens Axboe <axboe@kernel.dk>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Revert "block: don't reorder requests in
 blk_add_rq_to_plug"
Message-ID: <aEmcZLGtQFWMDDXZ@fedora>
References: <20250611121626.7252-1-abuehaze@amazon.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611121626.7252-1-abuehaze@amazon.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Wed, Jun 11, 2025 at 12:14:54PM +0000, Hazem Mohamed Abuelfotoh wrote:
> This reverts commit e70c301faece15b618e54b613b1fd6ece3dd05b4.
> 
> Commit <e70c301faece> ("block: don't reorder requests in
> blk_add_rq_to_plug") reversed how requests are stored in the blk_plug
> list, this had significant impact on bio merging with requests exist on
> the plug list. This impact has been reported in [1] and could easily be
> reproducible using 4k randwrite fio benchmark on an NVME based SSD without
> having any filesystem on the disk.
> 
> My benchmark is:
> 
>     fio --time_based --name=benchmark --size=50G --rw=randwrite \
> 	--runtime=60 --filename="/dev/nvme1n1" --ioengine=psync \
> 	--randrepeat=0 --iodepth=1 --fsync=64 --invalidate=1 \
> 	--verify=0 --verify_fatal=0 --blocksize=4k --numjobs=4 \
> 	--group_reporting
> 
> On 1.9TiB SSD(180K Max IOPS) attached to i3.16xlarge AWS EC2 instance.
> 
> Kernel        |  fio (B.W MiB/sec)  | I/O size (iostat)
> --------------+---------------------+--------------------
> 6.15.1        |   362               |  2KiB
> 6.15.1+revert |   660 (+82%)        |  4KiB
> --------------+---------------------+--------------------

I just run one quick test in my test VM, but can't reproduce it.

Also be curious, why does writeback produce so many 2KiB bios?


Thanks,
Ming


