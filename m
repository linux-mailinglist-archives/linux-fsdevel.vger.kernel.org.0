Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09E872F581
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 09:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242751AbjFNHHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 03:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjFNHHc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:07:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ED6129;
        Wed, 14 Jun 2023 00:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X8oBK+aRsv2PFyfDBYhfNAVfWjSHoTIQiIy5LeMUfN4=; b=33E5p1Vw1VdYhD/NFwTO5yeNlb
        K4jAHC1Q76zWb2ppdkIud463PzyGPIfUXXqIVT8m+p25tmvV/DYRTw51fCV41bQfLkQeaNNFWbiiW
        ocYtuxT+tqfjnZYx5iaBWCW6whn1r6IG89n+7EkFAgQhyjvkJrl69egFWdPlsrnIAlLGchrQBKgd7
        wqcwjMVUS17hetS/ehOnwx1sdVIcoTUic5MbWAOqcY1L/VIUOsNAZP6Z69ZbZrYQcHxZn/gJhrfxE
        I0iJfP8HWav/h5hjrf0oLArlM8WKYPM3Rb0mXQeCZoMzkCK3jae9qofDqKDch0b5lP3RN6QJvXlUZ
        +RrBd48g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q9KbG-00Aavt-35;
        Wed, 14 Jun 2023 07:07:26 +0000
Date:   Wed, 14 Jun 2023 00:07:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Colin Walters <walters@verbum.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Theodore Ts'o <tytso@mit.edu>, yebin <yebin@huaweicloud.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted
 devices
Message-ID: <ZIlnLjA0IcjfNPxn@infradead.org>
References: <20230612161614.10302-1-jack@suse.cz>
 <20230612162545.frpr3oqlqydsksle@quack3>
 <2f629dc3-fe39-624f-a2fe-d29eee1d2b82@acm.org>
 <a6c355f7-8c60-4aab-8f0c-5c6310f9c2a8@betaapp.fastmail.com>
 <20230613113448.5txw46hvmdjvuoif@quack3>
 <20230614-talent-davor-e447eb7bcd93@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614-talent-davor-e447eb7bcd93@brauner>
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

On Wed, Jun 14, 2023 at 09:05:41AM +0200, Christian Brauner wrote:
> > I kind of like the flexibility of device cgroups but it does not seem to
> 
> Let's not bring in device cgroups here just yet. They're an optional LSM
> security measure while your change is more fundamental which is the
> right thing to do imho.

Yes.  That last thing we need is hiding fundamentally security tradeoffs
in weird optional corners of the kernel.
