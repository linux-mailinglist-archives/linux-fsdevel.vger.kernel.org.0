Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D528725528
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 09:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbjFGHNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 03:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbjFGHNJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:13:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04C11720;
        Wed,  7 Jun 2023 00:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4CbgdtrMRU8SgCC/lj9k+w8TeWMG8R3cL1TBFp6UuqY=; b=hvjiRjbQ931WaCH5rTfNFZ43dF
        7MB76TsmX5AAZsrITTyNmsY08/KqALkDgqg2ybIdFoPx+0KRcOqaGtnGD4Y4XdVJfjIXZZcxc/n2R
        CRxH2cDLvRo07ZSmt+1U35fV22n1a0d5zDxD4Z7SjPd02ggrx2ENbFosvjOhkq/LNWw612Ykx7Pay
        b8+aC4Rmb9lAjJRV7jYB25fCMsCLGRolxDysouwQz39Hjkif3EpTqgD0oud9OF2wNJGV33aSjcb9v
        XUZhVXcJFLYijKWVedmkYvRDC0/VuhfDmjDiE/4Dtf+7UI4Gy8scv6ROC+Hc6wl3xvZMgPLhQwXCE
        Z3Qsa4QA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q6nLa-004gCI-2l;
        Wed, 07 Jun 2023 07:12:46 +0000
Date:   Wed, 7 Jun 2023 00:12:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v12 5/9] nvme: add copy offload support
Message-ID: <ZIAt7vL+/isPJEl5@infradead.org>
References: <20230605121732.28468-1-nj.shetty@samsung.com>
 <CGME20230605122310epcas5p4aaebfc26fe5377613a36fe50423cf494@epcas5p4.samsung.com>
 <20230605121732.28468-6-nj.shetty@samsung.com>
 <ZH3mjUb+yqI11XD8@infradead.org>
 <20230606113535.rjbhe6eqlyqk4pqq@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606113535.rjbhe6eqlyqk4pqq@green245>
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

On Tue, Jun 06, 2023 at 05:05:35PM +0530, Nitesh Shetty wrote:
> Downside will be duplicating checks which are present for read, write in
> block layer, device-mapper and zoned devices.
> But we can do this, shouldn't be an issue.

Yes.  Please never overload operations, this is just causing problems
everywhere, and that why I split the operations from the flag a few
years ago.

> The idea behind subsys is to prevent copy across different subsystem.
> For example, copy across nvme subsystem and the scsi subsystem. [1]
> At present, we don't support inter-namespace(copy across NVMe namespace),
> but after community feedback for previous series we left scope for it.

Never leave scope for something that isn't actually added.  That just
creates a giant maintainance nightmare.  Cross-device copies are giant
nightmare in general, and in the case of NVMe completely unusable
as currently done in the working group.  Messing up something that
is entirely reasonable (local copy) for something like that is a sure
way to never get this series in.
