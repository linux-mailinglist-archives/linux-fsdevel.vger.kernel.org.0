Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314A973022D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 16:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244305AbjFNOqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 10:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244537AbjFNOqb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:46:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DE71BF0;
        Wed, 14 Jun 2023 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4731GytQv+73cDzXwVjLlqTdzAERMJsFVXI656amdgg=; b=CVkIUOuYV9i/+dNlj/c8A5+2Ll
        Ik3noLwdzPmzDaYP4WTI752ITkiHtxxVXwNLAdwR3WRr/pSImBWb5b4ZKH8M0/3PrN1vIgsyVSiaT
        odddiOGjj287lFDs7A4izL9XxIBBh659N74iBypCyFG1/TYUFN2hsdluxvnkXH81H3vibaTxdTZo0
        WtxWnh9HHXDpXJ04cTf1GejUlszbZNN2c9m/ycwn3veRsjGdaRXyLjaJ1lYwxX56N2g/L1CmQjad3
        lUHJThbRkL8nfsHXtvNCX5oD/ZKBpwhq9SaXUBa9dqfsLBAZG1KztEZYgIz+FiVDSmJblwKCHhLGc
        Whqy4NXg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q9RlJ-006R29-7X; Wed, 14 Jun 2023 14:46:17 +0000
Date:   Wed, 14 Jun 2023 15:46:17 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Colin Walters <walters@verbum.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Theodore Ts'o <tytso@mit.edu>, yebin <yebin@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <ZInSuaeql35dtaSP@casper.infradead.org>
References: <20230612161614.10302-1-jack@suse.cz>
 <20230612162545.frpr3oqlqydsksle@quack3>
 <2f629dc3-fe39-624f-a2fe-d29eee1d2b82@acm.org>
 <a6c355f7-8c60-4aab-8f0c-5c6310f9c2a8@betaapp.fastmail.com>
 <20230613113448.5txw46hvmdjvuoif@quack3>
 <ZIln4s7//kjlApI0@infradead.org>
 <20230614101256.kgnui242k72lmp4e@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614101256.kgnui242k72lmp4e@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 12:12:56PM +0200, Jan Kara wrote:
> Well, OK, I have not been precise :). Modifying a partition table (or LVM
> description block) is impossible to distinguish from clobbering a
> filesystem on open(2) time. Once we decide we implement arbitration of each
> individual write(2), we can obviously stop writes to area covered by some
> exclusively open partition. But then you are getting at the complexity
> level of tracking used ranges of block devices which Darrick has suggested
> and you didn't seem to like that (and neither do I). Furthermore the
> protection is never going to be perfect as soon as loopback devices, device
> mapper, and similar come into the mix (or it gets really really complex).
> So I'd really prefer to stick with whatever arbitration we can perform on
> open(2).

What a shame we got rid of mandatory file locks in f7e33bdbd6d1 ;-)
