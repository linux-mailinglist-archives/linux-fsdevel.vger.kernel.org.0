Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E208B4D697C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 21:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347783AbiCKUco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 15:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiCKUcn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 15:32:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E99D1C6645;
        Fri, 11 Mar 2022 12:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SG03lQG6qHMN8Gkp16KAmYCtvGRQwl9SqagLXU3XZjE=; b=yRDSOsLGtKkCsRQ92Vhi4NWR5Q
        BsWOcTvNSRVbJvrqyESgW/VCHe+OyncwdCcCAQ6zjNUBbLG0SFitZyYGqgCKu3XWiSHKnNLp2guYO
        yO2HNJa5YHTrRLSarYsNIUJ3zaHEteMtHqifaHzvIvTkkLrPEJq6rsb+3KRnoXyBFQf3Nhu1BJOQp
        hHtnMAh5uCxIcO0H/8h7ZhoLL30quldcJjivlLGXLpSjjgf4FfsvsJp+WO+z30vn/nObut7xDdew8
        so1KYBMSLcZj9WV/j+4HQfZ9jOB7O23WfgzjxgWIE/ihfQu2A3a5j8ql8t0WnrPYYQkUGxdURs68t
        5qHBkenA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSlvH-000CK2-1M; Fri, 11 Mar 2022 20:31:39 +0000
Date:   Fri, 11 Mar 2022 12:31:39 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Message-ID: <Yiuxq0DXe5M5dsqh@bombadil.infradead.org>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <20220304001022.GJ3927073@dread.disaster.area>
 <YiKOQM+HMZXnArKT@bombadil.infradead.org>
 <20220304224257.GN3927073@dread.disaster.area>
 <YiKY6pMczvRuEovI@bombadil.infradead.org>
 <20220305073321.5apdknpmctcvo3qj@ArmHalley.localdomain>
 <20220307071229.GR3927073@dread.disaster.area>
 <Yiqcgi7G7ZrEbPHV@bombadil.infradead.org>
 <YirnIuXUj5RrUadm@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YirnIuXUj5RrUadm@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 10, 2022 at 10:07:30PM -0800, Christoph Hellwig wrote:
> On Thu, Mar 10, 2022 at 04:49:06PM -0800, Luis Chamberlain wrote:
> > Some filesystems who want to support zone storage natively have been
> > extended to do things to help with these quirks. My concerns were the
> > divergence on approaches to how filesystems use ZNS as well. Do you have
> > any plans to consider such efforts for XFS or would you rather build on
> > ZoneFS somehow?
> 
> XFS will always require a random writable area for metadata.

XFS also supports an external journal, so could that go through
a conventional zone?

> I have
> an old early draft with a fully zone aware allocator essentially
> replacing the realtime subvolume.  But it's been catching dust so far,
> maybe I'll have a chance to resurrect it if I don't have too fight too
> many stupid patchseries all at once.

Good to know thanks!

I was wondering weather or not Chinner's subvolume concept could be
applied to ZoneFS for the data area. But given the file would be on
another filesystem made me think this would probably not be possible.
Then there is the append only requirement as well...

  Luis
