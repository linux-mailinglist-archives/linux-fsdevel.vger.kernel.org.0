Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C5B78B276
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 16:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjH1OCn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 10:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjH1OCX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:02:23 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D183BBA;
        Mon, 28 Aug 2023 07:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EoGjlAqIr84+dzTRIVSh6MnXuXBwrPpcJyhAY3N5ock=; b=Cys3/JAywwflbjKeLLbxLR4Pml
        1ZIuH88594x0nLpO6iJLXX9l6sI1h8ZkRVdCon46JySP7xwVSIy6uJlVUPCBG0I1jMUBp/0W9K9uT
        GCXP/OFE+JrmC3Pa+vZcLym98yS0JgfF9SpK8F8b18qNPjfvCtYSzNZ2k1S35WDywJTHF23uRdIPl
        X360jIARja8/zh1+SEIlBXc4nXvwCf4DxcPHjnlmChlDL/j2yB9CBDj1MRvDfFoTePW35BIjZXSeZ
        oEnIi346oyjWFuEc9Uk6usuZ2p/gFgmA/OPtZ8mAicao0VPMQqLBW8+t2E5sM608aGZst3O1yE7EK
        cxVGuQGg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qacoc-001ZYo-2Z;
        Mon, 28 Aug 2023 14:02:03 +0000
Date:   Mon, 28 Aug 2023 15:02:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 03/12] filemap: update ki_pos in generic_perform_write
Message-ID: <20230828140202.GX3390869@ZenIV>
References: <20230601145904.1385409-1-hch@lst.de>
 <20230601145904.1385409-4-hch@lst.de>
 <20230827194122.GA325446@ZenIV>
 <20230828123023.GA11084@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828123023.GA11084@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 28, 2023 at 02:30:23PM +0200, Christoph Hellwig wrote:
> On Sun, Aug 27, 2023 at 08:41:22PM +0100, Al Viro wrote:
> > That part is somewhat fishy - there's a case where you return a positive value
> > and advance ->ki_pos by more than that amount.  I really wonder if all callers
> > of ->write_iter() are OK with that.  Consider e.g. this:
> 
> This should not exist in the latest version merged by Jens.  Can you
> check if you still  see issues in the version in the block tree or
> linux-next.

Still does - the problem has migrated into direct_write_fallback(), but
that hadn't changed the situation.  We are still left with ->ki_pos bumped
by generic_perform_write() (evaluated as an argument of direct_write_fallback()
now) and *not* retraced in case when direct_write_fallback() decides to
discard the buffered write result.  Both in -next and in mainline (since
6.5-rc1).
