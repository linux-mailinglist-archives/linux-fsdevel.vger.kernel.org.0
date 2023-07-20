Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D5075A87F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 10:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjGTIAc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 04:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjGTIAb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:00:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA352684;
        Thu, 20 Jul 2023 01:00:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 98BAB6732D; Thu, 20 Jul 2023 10:00:26 +0200 (CEST)
Date:   Thu, 20 Jul 2023 10:00:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 5/9] nvme: add copy offload support
Message-ID: <20230720080026.GB6246@lst.de>
References: <20230627183629.26571-1-nj.shetty@samsung.com> <CGME20230627184039epcas5p2decb92731d3e7dfdf9f2c05309a90bd7@epcas5p2.samsung.com> <20230627183629.26571-6-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627183629.26571-6-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +	if (blk_rq_nr_phys_segments(req) != 2)
> +		return BLK_STS_IOERR;

The magic number of segments adding up source and dest really need
constants and helpers to make the code understandable.

> +	/* +1 shift as dst+src length is added in request merging, we send copy
> +	 * for half the length.
> +	 */
> +	n_lba = blk_rq_bytes(req) >> (ns->lba_shift + 1);

I do not understand the logic and comment here.

> +	if (WARN_ON(!n_lba))

WARN_ON_ONCE

> +		return BLK_STS_NOTSUPP;

and BLK_STS_NOTSUPP seems like the wrong error here, this is an
invalid argument.
