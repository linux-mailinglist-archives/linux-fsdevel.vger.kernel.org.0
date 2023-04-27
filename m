Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14BF6F0004
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 05:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242894AbjD0D6q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Apr 2023 23:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbjD0D6p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Apr 2023 23:58:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773122683;
        Wed, 26 Apr 2023 20:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M9m5Rfw4WyAfUq3Lq1g416KW1zPboz2ufjX48+QsLeI=; b=J8SOQNMg1f4YwpmOHxDfwyMDe2
        uCczSn4NUbhU2J7R2M++JwLipvI/DwKTROiGWvgj5+wccGzlcivAzjznESt1zi/KkJBHA+3BKnLn3
        3xw/yIEQVX4prPqRJQmQEX+B9Q+g3ojHId0plFCGM1tLRlAdvxQQudukYzQ/ivDReG47IKSPp50s2
        OEaLRGRwPVaWZhIHGR6MOHMZhZKXxZMsew+Utbq2Z67zJ79mYL9rnlEsHKnLF7wuvqn6Sszmjyszy
        pPjv7SskZUADaBdJyDtGsw7NnyWrD2Alzije2BK/gWFSr+Up44U+yhyZBWVEUtFxxjWucVZLwrkTa
        TbyJVy1A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1prsmC-0038hU-Ar; Thu, 27 Apr 2023 03:58:36 +0000
Date:   Thu, 27 Apr 2023 04:58:36 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        Eric Sandeen <sandeen@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Zhang Yi <yi.zhang@redhat.com>
Subject: Re: [ext4 io hang] buffered write io hang in balance_dirty_pages
Message-ID: <ZEny7Izr8iOc/23B@casper.infradead.org>
References: <ZEnb7KuOWmu5P+V9@ovpn-8-24.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEnb7KuOWmu5P+V9@ovpn-8-24.pek2.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 27, 2023 at 10:20:28AM +0800, Ming Lei wrote:
> Hello Guys,
> 
> I got one report in which buffered write IO hangs in balance_dirty_pages,
> after one nvme block device is unplugged physically, then umount can't
> succeed.

That's a feature, not a bug ... the dd should continue indefinitely?

balance_dirty_pages() is sleeping in KILLABLE state, so kill -9 of
the dd process should succeed.

