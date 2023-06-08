Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC12672817E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 15:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234536AbjFHNiP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 09:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbjFHNho (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:37:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6853126BA;
        Thu,  8 Jun 2023 06:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+ntaWMiRNwH90aAjjxflPg3eZ63LQ0+JwIbegh+Wpew=; b=m4vIXuUczCK4TdQDqYrKtap0qM
        Y51LtdZcd4IKxeH0l9tH9h+wHuyn/EjeuMwljF7dge00i5QFWmjD3qpbJhP6RSfZBFL6hr7BQ0jxg
        sTXldyj4aMgt+IWFBc2+/2L2YpxKPutCK0mnzuajVRNgEylzR13iEDXE+5dOt2Lx/8KBhvPa3W8mp
        09lAK22DadZz6hXmBka65swhvHQwdjqJqqvdIflbPCuxMaaKZpjzw6dLIrcl/BB/G+Imx+Jy1jrAL
        cQ68M/9kgeev1rOQGeedls9XQBT2n41Jhls/5iBX7XrVL+BOLmpt1j/ZKtGo7jsRrEmRY6gh35/bX
        YmnJHMRg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q7FpW-00FVjJ-FS; Thu, 08 Jun 2023 13:37:34 +0000
Date:   Thu, 8 Jun 2023 14:37:34 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     hch@infradead.org, djwong@kernel.org, dchinner@redhat.com,
        kbusch@kernel.org, hare@suse.de, ritesh.list@gmail.com,
        rgoldwyn@suse.com, jack@suse.cz, patches@lists.linux.dev,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, p.raghav@samsung.com,
        da.gomez@samsung.com, rohan.puri@samsung.com,
        rpuri.linux@gmail.com, corbet@lwn.net, jake@lwn.net
Subject: Re: [RFC 4/4] bdev: extend bdev inode with it's own super_block
Message-ID: <ZIHZngefNAtYtg7L@casper.infradead.org>
References: <20230608032404.1887046-1-mcgrof@kernel.org>
 <20230608032404.1887046-5-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608032404.1887046-5-mcgrof@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 07, 2023 at 08:24:04PM -0700, Luis Chamberlain wrote:
> We currently share a single super_block for the block device cache,
> each block device corresponds to one inode on that super_block. This
> implicates sharing one aops operation though, and in the near future
> we want to be able to instead support using iomap on the super_block
> for different block devices.

> -struct super_block *blockdev_superblock __read_mostly;

Did we consider adding

+struct super_block *blockdev_sb_iomap __read_mostly;

and then considering only two superblocks instead of having a list of
all bdevs?
