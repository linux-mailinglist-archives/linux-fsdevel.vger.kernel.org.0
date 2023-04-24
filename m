Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD646ED56E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Apr 2023 21:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjDXThY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Apr 2023 15:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjDXThX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Apr 2023 15:37:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BAE5B88;
        Mon, 24 Apr 2023 12:37:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3359462883;
        Mon, 24 Apr 2023 19:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566D4C433B3;
        Mon, 24 Apr 2023 19:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682365041;
        bh=YWbSyHY7pUE5AOb/3VWzPWd3sWsQ69Y7x41HE1Dt2f8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kDBWBxcRX36vIRCPQdN4ZUSdbSHX1O4Pd+ZO4nc3vupupBHzNk5Dk91nuDsIQ1rOH
         TqW+/Qd/EiK0dYyV1/5FLrIBnUSpq7xs31OE+7UwRsA5LpC1j9OwF7djbzyJxgWSHk
         cTzUpSzsdO3OotdRptYWv3/TZvD6lEfUf01ojwlUPWNODt2ILOz0Uec1W97Nv2KpIK
         2MP4gf/Xry+1mHMPMV0NAd9hTZgWH4WczEdoc62VroOonVWQQs1erBn2kICiokJEP7
         PLFzocQ/KEmEsnnhZ4aDYS/btGy3oYDzDHqf6NvUrV/g4vv33mYH1BCgXtB4Gbp2FJ
         D0frIKzhrqALw==
Date:   Mon, 24 Apr 2023 13:37:18 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] fs: remove the special !CONFIG_BLOCK def_blk_fops
Message-ID: <ZEbabjCZhl6j1Pk+@kbusch-mbp.dhcp.thefacebook.com>
References: <20230424054926.26927-1-hch@lst.de>
 <20230424054926.26927-3-hch@lst.de>
 <5f30b56e-b46b-1d3f-75fb-7f30ff6ca3e9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f30b56e-b46b-1d3f-75fb-7f30ff6ca3e9@infradead.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 24, 2023 at 12:22:30PM -0700, Randy Dunlap wrote:
> On 4/23/23 22:49, Christoph Hellwig wrote:
> > +		if (IS_ENABLED(CONFIG_BLOCK))
> > +			inode->i_fop = &def_blk_fops;
> 
> It looks like def_blk_fops is being removed (commit message and patch
> fragment below), but here (above line) it is being used.
> 
> Am I just confused?

The def_blk_fops is removed only for the !CONFIG_BLOCK case. Its usage is under
a branch known at compile time, so it's optimized out for that case before
trying to resolve the symbol.
