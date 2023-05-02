Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6198A6F3B90
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 02:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjEBA6b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 20:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjEBA6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 20:58:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4E230F6
        for <linux-fsdevel@vger.kernel.org>; Mon,  1 May 2023 17:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682989070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ee9kbmLrY2Y7aS+ZkEL+0QK6onncfphaK4NZ0iubdi0=;
        b=UuLJJH+uMWz5brHja81cVtK5Bo+Yt87q6S32bVsygxww5K5fDwhgBLJMShFkauLLAe8m4o
        EO+RAhBgIpjGyzgKb8MBFLy7+HRt6Qw0RZLbfMBpmX7T/DNO0ixZWclmjn+PyDdMALztu0
        iKuuoCJCDKVSxjDuM/ojOnFDa7Sjw1k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-547-s2Q55i0OMv6b0B-q6gLVuQ-1; Mon, 01 May 2023 20:57:46 -0400
X-MC-Unique: s2Q55i0OMv6b0B-q6gLVuQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58E6E101A531;
        Tue,  2 May 2023 00:57:45 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A9082400F4D;
        Tue,  2 May 2023 00:57:37 +0000 (UTC)
Date:   Tue, 2 May 2023 08:57:32 +0800
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
Message-ID: <ZFBf/CXN2ktVYL/N@ovpn-8-16.pek2.redhat.com>
References: <ZEpH+GEj33aUGoAD@ovpn-8-26.pek2.redhat.com>
 <663b10eb-4b61-c445-c07c-90c99f629c74@huawei.com>
 <ZEpcCOCNDhdMHQyY@ovpn-8-26.pek2.redhat.com>
 <ZEskO8md8FjFqQhv@ovpn-8-24.pek2.redhat.com>
 <fb127775-bbe4-eb50-4b9d-45a8e0e26ae7@huawei.com>
 <ZEtd6qZOgRxYnNq9@mit.edu>
 <ZEyL/sjVeW88XpIn@ovpn-8-24.pek2.redhat.com>
 <20230429044038.GA7561@lst.de>
 <ZEym2Yf1Ud1p+L3R@ovpn-8-24.pek2.redhat.com>
 <20230501044744.GA20056@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501044744.GA20056@lst.de>
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

On Mon, May 01, 2023 at 06:47:44AM +0200, Christoph Hellwig wrote:
> On Sat, Apr 29, 2023 at 01:10:49PM +0800, Ming Lei wrote:
> > Not sure if it is needed for non s_bdev
> 
> So you don't want to work this at all for btrfs?  Or the XFS log device,
> or ..

Basically FS can provide one generic API of shutdown_filesystem() which
shutdown FS generically, meantime calls each fs's ->shutdown() for
dealing with fs specific shutdown.

If there isn't superblock attached for one bdev, can you explain a bit what
filesystem code can do? Same with block layer bdev.

The current bio->bi_status together disk_live()(maybe bdev_live() is
needed) should be enough for FS code to handle non s_bdev.

> 
> > , because FS is over stackable device
> > directly. Stackable device has its own logic for handling underlying disks dead
> > or deleted, then decide if its own disk needs to be deleted, such as, it is
> > fine for raid1 to work from user viewpoint if one underlying disk is deleted.
> 
> We still need to propagate the even that device has been removed upwards.
> Right now some file systems (especially XFS) are good at just propagating
> it from an I/O error.  And explicity call would be much better.

It depends on the above question about how FS code handle non s_bdev
deletion/dead.


Thanks,
Ming

