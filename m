Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6926F728EE8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 06:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbjFIEZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 00:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238220AbjFIEZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:25:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B33C30C1;
        Thu,  8 Jun 2023 21:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jeVnrOV1EV2Jv8KgTlC0B4lqR8S0n0kMPSfRktLMFwI=; b=xA10fLwCQtkMdvBeUrApGqup58
        UdE0v30IODwdOV2sHuX64in+XGEh2ZJSUUAiU30YuUCfq/Sha7x6SEKpNLjvkVFAlQ+We+lkKf3ET
        iDM48wKjh0C0WfRBXkLSpoghCvyI1LjmvV0E56K0Hs14qz7TuJ8uTumehrcimbba4BwUfF6aDrSJ2
        kLU0uIkJ2gUlPecy2NKj+lgRU+Qe6XHz9B2iXtKiOqueMrqx7mVIKlvWCLlpZ67m/Q76qF45EyZLv
        S4dgb4Y/q98oDmWmnBwtuSSv7i0i21oQFSHI/FBN9V5/YggYtlNj4jekpFADH/h4dFL8rP6oTZYXC
        7xr6ijdA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q7Tfy-00BaXx-39;
        Fri, 09 Jun 2023 04:24:38 +0000
Date:   Thu, 8 Jun 2023 21:24:38 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-scsi@vger.kernel.org, willy@infradead.org, hare@suse.de,
        djwong@kernel.org, bvanassche@acm.org, ming.lei@redhat.com,
        dlemoal@kernel.org, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 5/9] nvme: add copy offload support
Message-ID: <ZIKphgDavKVPREnw@infradead.org>
References: <20230605121732.28468-1-nj.shetty@samsung.com>
 <CGME20230605122310epcas5p4aaebfc26fe5377613a36fe50423cf494@epcas5p4.samsung.com>
 <20230605121732.28468-6-nj.shetty@samsung.com>
 <ZH3mjUb+yqI11XD8@infradead.org>
 <20230606113535.rjbhe6eqlyqk4pqq@green245>
 <ZIAt7vL+/isPJEl5@infradead.org>
 <20230608120817.jg4xb4jhg77mlksw@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608120817.jg4xb4jhg77mlksw@green245>
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

On Thu, Jun 08, 2023 at 05:38:17PM +0530, Nitesh Shetty wrote:
> Sure, we can do away with subsys and realign more on single namespace copy.
> We are planning to use token to store source info, such as src sector,
> len and namespace. Something like below,
> 
> struct nvme_copy_token {
> 	struct nvme_ns *ns; // to make sure we are copying within same namespace
> /* store source info during *IN operation, will be used by *OUT operation */
> 	sector_t src_sector;
> 	sector_t sectors;
> };
> Do you have any better way to handle this in mind ?

In general every time we tried to come up with a request payload that is
not just data passed to the device it has been a nightmare.

So my gut feeling would be that bi_sector and bi_iter.bi_size are the
ranges, with multiple bios being allowed to form the input data, similar
to how we implement discard merging.

The interesting part is how we'd match up these bios.  One idea would
be that since copy by definition doesn't need integrity data we just
add a copy_id that unions it, and use a simple per-gendisk copy I/D
allocator, but I'm not entirely sure how well that interacts stacking
drivers. 
