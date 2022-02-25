Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E6D4C4105
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 10:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238923AbiBYJNk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 04:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbiBYJNf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:13:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54FD417FD04
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Feb 2022 01:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645780382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5x1l60kOJzalIbidbr6kbs5D9dFUyUJTKOBS5WSBmqI=;
        b=UCIilkMNxW3EDdwxJAh6UH+7GNK0Wye+jYHdK0krGQ2aLN7LZofuebGHuJNfaEUxESETTx
        dZgX7cWmy36s8E6zHEzMN4vLe7Nmqe/tjML65zMaaMzRK3dBCQMhlbyNZtMqkqcglo3M/u
        EJl+KK6vVo+7fx1G7Ncp74KNhucElA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-90-TNa3oj-LMGKC9XopOpGK-Q-1; Fri, 25 Feb 2022 04:12:56 -0500
X-MC-Unique: TNa3oj-LMGKC9XopOpGK-Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1E561854E27;
        Fri, 25 Feb 2022 09:12:52 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D26B1006870;
        Fri, 25 Feb 2022 09:12:33 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 21P9CW8f021225;
        Fri, 25 Feb 2022 04:12:32 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 21P9CVVN021221;
        Fri, 25 Feb 2022 04:12:31 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 25 Feb 2022 04:12:31 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Nitesh Shetty <nj.shetty@samsung.com>
cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, roland@purestorage.com, hare@suse.de,
        kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com,
        zach.brown@ni.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com
Subject: Re: [PATCH v2 08/10] dm: Add support for copy offload.
In-Reply-To: <20220224124213.GD9117@test-zns>
Message-ID: <alpine.LRH.2.02.2202250410210.20694@file01.intranet.prod.int.rdu2.redhat.com>
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com> <20220207141348.4235-1-nj.shetty@samsung.com> <CGME20220207141948epcas5p4534f6bdc5a1e2e676d7d09c04f8b4a5b@epcas5p4.samsung.com> <20220207141348.4235-9-nj.shetty@samsung.com>
 <alpine.LRH.2.02.2202160845210.22021@file01.intranet.prod.int.rdu2.redhat.com> <20220224124213.GD9117@test-zns>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Thu, 24 Feb 2022, Nitesh Shetty wrote:

> On Wed, Feb 16, 2022 at 08:51:08AM -0500, Mikulas Patocka wrote:
> > 
> > 
> > On Mon, 7 Feb 2022, Nitesh Shetty wrote:
> > 
> > > Before enabling copy for dm target, check if underlaying devices and
> > > dm target support copy. Avoid split happening inside dm target.
> > > Fail early if the request needs split, currently spliting copy
> > > request is not supported
> > > 
> > > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > 
> > If a dm device is reconfigured, you must invalidate all the copy tokens 
> > that are in flight, otherwise they would copy stale data.
> > 
> > I suggest that you create a global variable "atomic64_t dm_changed".
> > In nvme_setup_copy_read you copy this variable to the token.
> > In nvme_setup_copy_write you compare the variable with the value in the 
> > token and fail if there is mismatch.
> > In dm.c:__bind you increase the variable, so that all the tokens will be 
> > invalidated if a dm table is changed.
> > 
> > Mikulas
> > 
> >
> Yes, you are right about the reconfiguration of dm device. But wouldn't having a
> single global counter(dm_changed), will invalidate for all in-flight copy IO's
> across all dm devices. Is my understanding correct?
> 
> --
> Nitesh Shetty

Yes, changing it will invalidate all the copy IO's.

But invalidating only IO's affected by the table reload would be hard to 
achieve.

Mikulas

