Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3318714F19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 May 2023 19:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjE2Rzk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjE2Rzj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 13:55:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC136CD;
        Mon, 29 May 2023 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P/0tITYpTpGavafJMOkhwQed8uJTPSwLhyk8FXAUCS8=; b=eKO8XMAZv/UuArc8zlhV6qI5Z6
        wwoXuHeWvPqvnNzPY/wAymufwuUnWz6wKtpLuVcY2fUy6dTJzBfU0e48o8MOFMgYVur0phcqyOtjQ
        B8uuZ0z3MfECNtVeWZtb7jk1d3JWxI06vtr++Xye1e3s0OWgYfbvkkVEAQdwtpPnb42rxUe36boqU
        QAJs/GKgHmXFxleNHO/XY8yy/fJdUY60TlvLHghmlDoRv2OnYwBHpLjRKgLoErWJY4qzKidFxkgX9
        jIYWaGUnt1MoaJK9eTUHxwg+ta8SPNFmjHJ4elcGTHg/ztPEuFCYUoJMbDx1VrG5kHxGlbYz57PH2
        ZhauUOmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q3h5K-005bSP-AT; Mon, 29 May 2023 17:55:10 +0000
Date:   Mon, 29 May 2023 18:55:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, bvanassche@acm.org,
        hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
        gost.dev@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v11 2/9] block: Add copy offload support infrastructure
Message-ID: <ZHTm/v1jTZhcpDei@casper.infradead.org>
References: <20230522104146.2856-1-nj.shetty@samsung.com>
 <CGME20230522104536epcas5p23dd8108dd267ec588e5c36e8f9eb9fe8@epcas5p2.samsung.com>
 <20230522104146.2856-3-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522104146.2856-3-nj.shetty@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 04:11:33PM +0530, Nitesh Shetty wrote:
> +		token = alloc_page(gfp_mask);

Why is PAGE_SIZE the right size for 'token'?  That seems quite unlikely.
I could understand it being SECTOR_SIZE or something that's dependent on
the device, but I cannot fathom it being dependent on the host' page size.
