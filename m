Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C710F4A64F4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 20:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242278AbiBAT0R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 14:26:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234151AbiBAT0R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 14:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643743576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V6LHo6un10Hww5UkITIYZqx0hJ95mxjwPuv4ZEQNJOo=;
        b=dYtVQIwWn4wlVyacLRuZbiwUkk21jpRpRETCjo/fwYHQcUh6n9uTV7DmEepW+jpppkKuzw
        PXg7KRGlE4xyYuRRNskW5l7foKswYvdyH32tAep9XSdkxrZqgZs7+UibS1IebKh5zUOtkO
        1kmz9xt8rtvl5hdW2V9LhUz2YbBAIyg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-619-M3lC_SoeOUSu4g4fX1B8yw-1; Tue, 01 Feb 2022 14:26:13 -0500
X-MC-Unique: M3lC_SoeOUSu4g4fX1B8yw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06EAD1091DA0;
        Tue,  1 Feb 2022 19:26:12 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 73DEA5D6BA;
        Tue,  1 Feb 2022 19:25:59 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 211JPwaE023932;
        Tue, 1 Feb 2022 14:25:58 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 211JPwim023928;
        Tue, 1 Feb 2022 14:25:58 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 1 Feb 2022 14:25:58 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Bart Van Assche <bvanassche@acm.org>
cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] nvme: add copy offload support
In-Reply-To: <1380d0e4-032d-133b-4ebb-f10d85e39800@acm.org>
Message-ID: <alpine.LRH.2.02.2202011421320.21843@file01.intranet.prod.int.rdu2.redhat.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com> <20220201102122.4okwj2gipjbvuyux@mpHalley-2> <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2202011332330.22481@file01.intranet.prod.int.rdu2.redhat.com>
 <1380d0e4-032d-133b-4ebb-f10d85e39800@acm.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Tue, 1 Feb 2022, Bart Van Assche wrote:

> On 2/1/22 10:33, Mikulas Patocka wrote:
> > +static inline blk_status_t nvme_setup_read_token(struct nvme_ns *ns, struct
> > request *req)
> > +{
> > +	struct bio *bio = req->bio;
> > +	struct nvme_copy_token *token =
> > page_to_virt(bio->bi_io_vec[0].bv_page) + bio->bi_io_vec[0].bv_offset;
> 
> Hmm ... shouldn't this function use bvec_kmap_local() instead of
> page_to_virt()?
> 
> Thanks,
> 
> Bart.

.bv_page is allocated only in blkdev_issue_copy with alloc_page. So, 
page_to_virt works.

But you are right that bvec_kmap_local may be nicer.

Mikulas

