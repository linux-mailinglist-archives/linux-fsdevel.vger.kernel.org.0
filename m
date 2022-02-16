Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1404B8ACA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Feb 2022 14:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbiBPNvl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Feb 2022 08:51:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232685AbiBPNvk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Feb 2022 08:51:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1D5413E24
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Feb 2022 05:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645019486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K5DTI//Qha4u3Kat+ZKKMYxR5CxUYu7QEiiyD50iVw8=;
        b=IaL7JHopY0TqBMLF8wifvnwK/ArCz0ghOkWNMECh+MwZxT3p7bxDydwXVqXAjIy+1CRL4U
        AXbqOJB2E0P9GTT8/HlAJZEMPj8xRiDKe1mPS+oFkMOY2nIWm+ARhYAYsx9SeB0B3dpyKe
        5VBBcrggxQkDR+WG+s/l0Cr1iaafufU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-kBhArUV3NEOq_YS-Pwd6oA-1; Wed, 16 Feb 2022 08:51:21 -0500
X-MC-Unique: kBhArUV3NEOq_YS-Pwd6oA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAF6B1898291;
        Wed, 16 Feb 2022 13:51:17 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23DD17C127;
        Wed, 16 Feb 2022 13:51:08 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 21GDp8ZA023716;
        Wed, 16 Feb 2022 08:51:08 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 21GDp8bV023712;
        Wed, 16 Feb 2022 08:51:08 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 16 Feb 2022 08:51:08 -0500 (EST)
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
In-Reply-To: <20220207141348.4235-9-nj.shetty@samsung.com>
Message-ID: <alpine.LRH.2.02.2202160845210.22021@file01.intranet.prod.int.rdu2.redhat.com>
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com> <20220207141348.4235-1-nj.shetty@samsung.com> <CGME20220207141948epcas5p4534f6bdc5a1e2e676d7d09c04f8b4a5b@epcas5p4.samsung.com> <20220207141348.4235-9-nj.shetty@samsung.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Mon, 7 Feb 2022, Nitesh Shetty wrote:

> Before enabling copy for dm target, check if underlaying devices and
> dm target support copy. Avoid split happening inside dm target.
> Fail early if the request needs split, currently spliting copy
> request is not supported
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>

If a dm device is reconfigured, you must invalidate all the copy tokens 
that are in flight, otherwise they would copy stale data.

I suggest that you create a global variable "atomic64_t dm_changed".
In nvme_setup_copy_read you copy this variable to the token.
In nvme_setup_copy_write you compare the variable with the value in the 
token and fail if there is mismatch.
In dm.c:__bind you increase the variable, so that all the tokens will be 
invalidated if a dm table is changed.

Mikulas

