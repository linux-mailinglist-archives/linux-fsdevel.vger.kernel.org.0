Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F345690DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 19:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233948AbiGFRmh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 13:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiGFRmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:42:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ECA255AB;
        Wed,  6 Jul 2022 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5Xz4cgyr907laE8FVhXtKTrrGymLfm+M6u2vDoD+N0M=; b=GvPwHahMBbuNaNdNezm22avvV9
        vEac+n/N1Md008SH2L9+RDomZy7o87JiMqMajIYvZXSQyUWO2GenBJAXWxZQyy4d8LU0kQ+wuiB4k
        NxtxcPAT8s2zJx1qInWe7P31NX/HMJOck6wbES12nfC+bEDbeTCgdXS8Ew77H04ohvWLCy5kLxDkR
        V8eZ2n6shRdVtN++uP0oM6PTMFz8/tiCXLPt2D6q735qAFICn1hUOb2hLczXweoLsSsDN55y5VwDI
        fETBNiD7Fh1XFY5nzF9NnBzGZK+Dt8XwewYnqS7DzAJC3mrAbIABzZvzPdzeT5X83wyn7tXopbVkk
        pqvxP0ng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o992T-001q54-UO; Wed, 06 Jul 2022 17:42:13 +0000
Date:   Wed, 6 Jul 2022 18:42:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, agk@redhat.com, song@kernel.org,
        djwong@kernel.org, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, javier@javigon.com,
        johannes.thumshirn@wdc.com, bvanassche@acm.org,
        dongli.zhang@oracle.com, ming.lei@redhat.com,
        jefflexu@linux.alibaba.com, josef@toxicpanda.com, clm@fb.com,
        dsterba@suse.com, jack@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, jlayton@kernel.org, idryomov@gmail.com,
        danil.kipnis@cloud.ionos.com, ebiggers@google.com,
        jinpu.wang@cloud.ionos.com
Subject: Re: [PATCH 0/6] block: add support for REQ_OP_VERIFY
Message-ID: <YsXJdXnXsMtaC8DJ@casper.infradead.org>
References: <20220630091406.19624-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630091406.19624-1-kch@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 30, 2022 at 02:14:00AM -0700, Chaitanya Kulkarni wrote:
> This adds support for the REQ_OP_VERIFY. In this version we add

IMO, VERIFY is a useless command.  The history of storage is full of
devices which simply lie.  Since there's no way for the host to check if
the device did any work, cheap devices may simply implement it as a NOOP.
Even expensive devices where there's an ironclad legal contract between
the vendor and customer may have bugs that result in only some of the
bytes being VERIFYed.  We shouldn't support it.

Now, everything you say about its value (not consuming bus bandwidth)
is true, but the device should provide the host with proof-of-work.
I'd suggest calculating some kind of checksum, even something like a
SHA-1 of the contents would be worth having.  It doesn't need to be
crypto-secure; just something the host can verify the device didn't spoof.
