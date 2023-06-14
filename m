Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498A97301FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 16:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244206AbjFNObN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 10:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244533AbjFNObK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:31:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9F62697;
        Wed, 14 Jun 2023 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rB8JFk5K99YKXzStmqgYF9E3nSRDDREOo2MajlfIWQA=; b=A1wm0Nd7/eVEtnBe2ZIa4jMH/W
        pOQXx8yuu8fCCYzs79aZWKa8wtk2hxzNtskcpOqaKQjr00hyfa8IBg7qADOvorPOWAB+nMQ2TZVJ2
        cz2gl3a59Dia4Y4Gtsa4EEqzeIdcGQ6zSaTdsQZrWFBneY7sTThUxRKNB6cAeWQvfFsfHwgf4683w
        +7lqAJOUv+ilZeQ9X5sQ+CfKEXI94BzcYpW25Uueuv9YTbF7E2DrOyL2DqLQEXPW8rFyR0Vrz5MDF
        rj1jcuR0EMxMNEAQFGH9oFzvKsGU4oXdnmmjAspc7XGOvIf8YG3RYrILJIDeehEgf9MDtRzStfW8B
        ClAlgXiQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9RWA-00Butb-0u;
        Wed, 14 Jun 2023 14:30:38 +0000
Date:   Wed, 14 Jun 2023 07:30:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
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
Message-ID: <ZInPDsjs/4Hsk8mW@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
> and you didn't seem to like that (and neither do I).

Well, we track these ranges in the block_devices hanging off the gendisk
anyway, so this is a totally different league.  But in the end parsing
partition tables is a little easier than parsing file system metadata
but not fundamentally different.  So if we really want to lock down
broken sideband manipulations we can't allow that either and need
in-kernel support for manipulating partition tables if that is required
at run time.

