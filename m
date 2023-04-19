Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC7B6E7C37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 16:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjDSOUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 10:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjDSOTu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 10:19:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85225F9;
        Wed, 19 Apr 2023 07:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+pd4oKFh0oFb9+Iu8ItMUHH7+UjLES4jQSrWjxoNntk=; b=sagm8bmiUZxQFociF+FkwReyXx
        kqdFZHQr4HuDFcx1J+L17DKTxkCc08j6JFj3DANaq0ApL8Ik4omqR93XamI7fuhXfrq7qNJIm/A3i
        250Wr67KjPr1fBJqaSoXCq1K0pnZixmxYxb7sEU4Jy79RcYVlhRuhFtZ0f8IIDkj7aPo4UtyehLpx
        WAHMINlPz6T7j+3uE2+7rYA0dRJTgkTASjEFlsEQvNF4zVW/Udb1b2RIR2ZUrhpEyMg5i7oehPGtU
        IMknaJgbzbBX8AuJwMcwzwR8HwfFibwnD9fr/HyNgJLkTvwyBmETp0+3InlkyinLD32SHgvwXOyJk
        znUSSLTg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pp8ed-00DJck-8U; Wed, 19 Apr 2023 14:19:27 +0000
Date:   Wed, 19 Apr 2023 15:19:27 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com, agruenba@redhat.com,
        cluster-devel@redhat.com, damien.lemoal@wdc.com,
        dm-devel@redhat.com, dsterba@suse.com, hare@suse.de, hch@lst.de,
        jfs-discussion@lists.sourceforge.net, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-raid@vger.kernel.org, ming.lei@redhat.com,
        rpeterso@redhat.com, shaggy@kernel.org, snitzer@kernel.org,
        song@kernel.org, Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v3 19/19] block: mark bio_add_page as __must_check
Message-ID: <ZD/4b9ZQ1YZRTgHL@casper.infradead.org>
References: <20230419140929.5924-1-jth@kernel.org>
 <20230419140929.5924-20-jth@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419140929.5924-20-jth@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 19, 2023 at 04:09:29PM +0200, Johannes Thumshirn wrote:
> Now that all users of bio_add_page check for the return value, mark
> bio_add_page as __must_check.

Should probably add __must_check to bio_add_folio too?  If this is
really the way you want to go ... means we also need a
__bio_add_folio().
