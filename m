Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5976F2306
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Apr 2023 07:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjD2FL5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Apr 2023 01:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjD2FL4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Apr 2023 01:11:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9437E2706
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Apr 2023 22:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682745067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2hAEIix55mQqheQ/XmVIMx3hso9fuBFFY9y7DgUUBM8=;
        b=Gk5p/caH9ff9TE4ldNADOIydHSmjf5IS2Jw14goLgpt/RVsm9KhEmG5GKcME0trRSDj4BM
        YdqYmgfo2d3Of2unhMir5EVA4Bx+CKAeC4pm291iQ7wu/Qq6j4Tk2zzjNFTQeM4jFhqqK8
        5snjqAqEf+G7XsFqj4jne+JToGMDNtw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-R6yLz9NvNsCULUVy6I_V-g-1; Sat, 29 Apr 2023 01:11:04 -0400
X-MC-Unique: R6yLz9NvNsCULUVy6I_V-g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6741F85A5B1;
        Sat, 29 Apr 2023 05:11:02 +0000 (UTC)
Received: from ovpn-8-24.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6EE5400F4D;
        Sat, 29 Apr 2023 05:10:54 +0000 (UTC)
Date:   Sat, 29 Apr 2023 13:10:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Theodore Ts'o <tytso@mit.edu>, Baokun Li <libaokun1@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Zhang Yi <yi.zhang@redhat.com>,
        yangerkun <yangerkun@huawei.com>, ming.lei@redhat.com
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Message-ID: <ZEym2Yf1Ud1p+L3R@ovpn-8-24.pek2.redhat.com>
References: <ZEn/KB0fZj8S1NTK@ovpn-8-24.pek2.redhat.com>
 <dbb8d8a7-3a80-34cc-5033-18d25e545ed1@huawei.com>
 <ZEpH+GEj33aUGoAD@ovpn-8-26.pek2.redhat.com>
 <663b10eb-4b61-c445-c07c-90c99f629c74@huawei.com>
 <ZEpcCOCNDhdMHQyY@ovpn-8-26.pek2.redhat.com>
 <ZEskO8md8FjFqQhv@ovpn-8-24.pek2.redhat.com>
 <fb127775-bbe4-eb50-4b9d-45a8e0e26ae7@huawei.com>
 <ZEtd6qZOgRxYnNq9@mit.edu>
 <ZEyL/sjVeW88XpIn@ovpn-8-24.pek2.redhat.com>
 <20230429044038.GA7561@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230429044038.GA7561@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 29, 2023 at 06:40:38AM +0200, Christoph Hellwig wrote:
> On Sat, Apr 29, 2023 at 11:16:14AM +0800, Ming Lei wrote:
> > OK, looks both Dave and you have same suggestion, and IMO, it isn't hard to
> > add one interface for notifying FS, and it can be either one s_ops->shutdown()
> > or shutdown_filesystem(struct super_block *sb).
> 
> It's not that simple.  You need to be able to do that for any device used
> by a file system, not just s_bdev.  This means it needs go into ops
> passed by the bdev owner, which is also needed to propagate this through
> stackable devices.

Not sure if it is needed for non s_bdev , because FS is over stackable device
directly. Stackable device has its own logic for handling underlying disks dead
or deleted, then decide if its own disk needs to be deleted, such as, it is
fine for raid1 to work from user viewpoint if one underlying disk is deleted.

> 
> I have some work on that, but the way how blkdev_get is called in the
> generic mount helpers is a such a mess that I've not been happy with
> the result yet.  Let me see if spending extra time with it will allow
> me to come up with something that doesn't suck.
> 
> > But the main job should be how this interface is implemented in FS/VFS side,
> > so it looks one more FS job, and block layer can call shutdown_filesystem()
> > from del_gendisk() simply.
> 
> This needs to be called from blk_mark_disk_dead for drivers using that,
> and from del_gendisk only if GD_DEAD isn't set yet.

OK, looks you mean the API needs to be called before GD_DEAD is set,
but I am wondering if it makes a difference, given device is already
dead.


Thanks,
Ming

