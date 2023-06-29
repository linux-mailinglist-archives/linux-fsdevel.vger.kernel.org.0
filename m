Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCBA74225D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 10:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjF2Ilo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 04:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbjF2Ikx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:40:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336AE3A81
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688027651;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lcFzJ0h/r4o640kKx9oD5oKaAf0iz+R8cp1bGbk+mhI=;
        b=ZKm6mGzR3qLZKM5SAtXZOCl4UTsKeUO/g//j7/SNUn1AgxOWi6vquoRqCh+D2OX2tenMTX
        OHCLd5BFxrlqkIaAXExAKwHwQstgAwZ9A1ZGD3qM4LX+DbDNTriAnH0VUrlgjw/7W+jXxk
        fyKSidMWa+LnYO++BlLkH8G21IZgE/4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-P89DQgOTMauKEphGgInR0w-1; Thu, 29 Jun 2023 04:34:04 -0400
X-MC-Unique: P89DQgOTMauKEphGgInR0w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF498104458F;
        Thu, 29 Jun 2023 08:34:02 +0000 (UTC)
Received: from ovpn-8-26.pek2.redhat.com (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F8C5492C13;
        Thu, 29 Jun 2023 08:33:32 +0000 (UTC)
Date:   Thu, 29 Jun 2023 16:33:26 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, dlemoal@kernel.org, nitheshshetty@gmail.com,
        gost.dev@samsung.com, Vincent Fu <vincent.fu@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH v13 3/9] block: add emulation for copy
Message-ID: <ZJ1B1k0KifZrGRIp@ovpn-8-26.pek2.redhat.com>
References: <20230627183629.26571-1-nj.shetty@samsung.com>
 <CGME20230627184020epcas5p13fdcea52edead5ffa3fae444f923439e@epcas5p1.samsung.com>
 <20230627183629.26571-4-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627183629.26571-4-nj.shetty@samsung.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nitesh,

On Wed, Jun 28, 2023 at 12:06:17AM +0530, Nitesh Shetty wrote:
> For the devices which does not support copy, copy emulation is added.
> It is required for in-kernel users like fabrics, where file descriptor is

I can understand copy command does help for FS GC and fabrics storages,
but still not very clear why copy emulation is needed for kernel users,
is it just for covering both copy command and emulation in single
interface? Or other purposes?

I'd suggest to add more words about in-kernel users of copy emulation.

> not available and hence they can't use copy_file_range.
> Copy-emulation is implemented by reading from source into memory and
> writing to the corresponding destination asynchronously.
> Also emulation is used, if copy offload fails or partially completes.

Per my understanding, this kind of emulation may not be as efficient
as doing it in userspace(two linked io_uring SQEs, read & write with
shared buffer). But it is fine if there are real in-kernel such users.


Thanks,
Ming

