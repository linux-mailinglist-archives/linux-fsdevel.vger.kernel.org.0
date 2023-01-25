Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804D967B62C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 16:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbjAYPpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 10:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjAYPpP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:45:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD793BD90
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 07:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GAyvysrslSJTltFDjSfzHffL3JMbSVSA6ErXvbZsxJo=; b=Bh4S9KudTXPJNX1VT41cIwmNfb
        TrZMFgQqIO+Bz4nkjNsZz7tNDup/LJO+TYIqkUqLVdhDJG/H42AqOZZwZd36pkpBT7JHBFk9aM5wh
        66txvMugRiI34cH0oqHrt4TDONC4sXqb/2nEQPK2Ts/bl+P07m5C9uEZly4xG3mryca3HbufBTRfa
        NFj5/tfaYOU2xBtxPd9jq6lSE7/xhQliFwyPsvloxRzF3YwANoBhVLAnP0Tq3HUSjyZqcM8gLfpix
        N/b8aknXFLbxstpDESVvG/gwJJyiH4wSeo90tnrgFLyUuakPw2nHwPK92WSK5HAF/4+FMD0oUM0Mt
        oAF9U+lA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKhxU-0060y9-Hf; Wed, 25 Jan 2023 15:45:08 +0000
Date:   Wed, 25 Jan 2023 15:45:08 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] fs: don't allocate blocks beyond EOF from
 __mpage_writepage
Message-ID: <Y9FOhCjKODcZbax7@casper.infradead.org>
References: <20230103104430.27749-1-jack@suse.cz>
 <Y7r8dsLV0dcs+jBw@infradead.org>
 <20230125142351.4hfehrbuuacx3thp@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125142351.4hfehrbuuacx3thp@quack3>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 03:23:51PM +0100, Jan Kara wrote:
> On Sun 08-01-23 09:25:10, Christoph Hellwig wrote:
> > On Tue, Jan 03, 2023 at 11:44:30AM +0100, Jan Kara wrote:
> > > When __mpage_writepage() is called for a page beyond EOF, it will go and
> > > allocate all blocks underlying the page. This is not only unnecessary
> > > but this way blocks can get leaked (e.g. if a page beyond EOF is marked
> > > dirty but in the end write fails and i_size is not extended).
> > 
> > Looks good:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Matthew, Andrew, can one of you please pick up this fix? Thanks!

I don't have a pull request pending for next merge window, so probably
best if Andrew picks it up.
