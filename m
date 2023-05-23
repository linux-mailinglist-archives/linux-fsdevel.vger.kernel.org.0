Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1C770D263
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 05:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjEWDbL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 23:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232618AbjEWDbJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 23:31:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB3F90;
        Mon, 22 May 2023 20:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/hND79jypjGMxrh+L0AHfmoXlB7jfnZF846f0hmvk3s=; b=HROkOeYJgsW515w412weVmp0+i
        YEdCM3PRHJ8yLIzdBSb+Xne+pGdopXsi8JnT0CNNfg9oYv05lkYp5Nceqaag93z1O8A122qkxCVFv
        +izmJgPDGdRSRSfuroAjrwUvFuFU9Sr+1LDaSOnQuHT4rkaVFrGW9ZqvWG2nbNXKaUr5oZDVJK11I
        RyvLNOj1PcX4LwBEV/FegrIgbBdhvp7j2y31h8Wy7rSvHujrlGbNAYVSA0t7gLYx6nDhZYo2aTnwG
        2e2CzusZB4FwcCAcoisC1TopNtNPBuTbaa+4Xz1KrGZTS3PUwYf30EPvOgjalWOatycvM59In4SD4
        sazxHniQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q1Ijb-009k51-9e; Tue, 23 May 2023 03:30:51 +0000
Date:   Tue, 23 May 2023 04:30:51 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>,
        cluster-devel@redhat.com, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 08/13] iomap: assign current->backing_dev_info in
 iomap_file_buffered_write
Message-ID: <ZGwza3fdkBHyVG3+@casper.infradead.org>
References: <20230519093521.133226-1-hch@lst.de>
 <20230519093521.133226-9-hch@lst.de>
 <20230523010627.GD11598@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523010627.GD11598@frogsfrogsfrogs>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 06:06:27PM -0700, Darrick J. Wong wrote:
> On Fri, May 19, 2023 at 11:35:16AM +0200, Christoph Hellwig wrote:
> > Move the assignment to current->backing_dev_info from the callers into
> > iomap_file_buffered_write to reduce boiler plate code and reduce the
> > scope to just around the page dirtying loop.
> > 
> > Note that zonefs was missing this assignment before.
> 
> I'm still wondering (a) what the hell current->backing_dev_info is for,
> and (b) if we need it around the iomap_unshare operation.
> 
> $ git grep current..backing_dev_info
[results show it only set, never used]
> 
> AFAICT nobody uses it at all?  Unless there's some bizarre user that
> isn't extracting it from @current?
> 
> Oh, hey, new question (c) isn't this set incorrectly for xfs realtime
> files?

Some git archaelogy ...

This was first introduced in commit 2f45a06517a62 (in the
linux-fullhistory tree) in 2002 by one Andrew Morton.  At the time,
it added this check to the page scanner:

+                               if (page->pte.direct ||
+                                       page->mapping->backing_dev_info ==
+                                               current->backing_dev_info) {
+                                       wait_on_page_writeback(page);
+                               }

AFAICT (the code went through some metamorphoses in the intervening
twenty years), the last use of it ended up in current_may_throttle(),
and it was removed in March 2022 by Neil Brown in commit b9b1335e6403.
Since then, there have been no users of task->backing_dev_info, and I'm
pretty sure it can go away.
