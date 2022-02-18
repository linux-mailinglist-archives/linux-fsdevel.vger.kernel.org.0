Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045044BB399
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 08:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiBRHwf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 02:52:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiBRHwd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 02:52:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B7F580E8;
        Thu, 17 Feb 2022 23:52:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0E7AB82537;
        Fri, 18 Feb 2022 07:52:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F70C340ED;
        Fri, 18 Feb 2022 07:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645170733;
        bh=V+9C48iv9XRk+MUoKRdXyp5e9Ugr2dXDUyMumpaYQ6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J50nw6T8dG5KzH/M8aFe8tHATxgNAosOGLEUAPRWPC99g6+YSWDb3TC1slK7qRKWZ
         r78c+ZEleASEcNm80gohZLsLprX9bBCL6K6KaMuVr2gqJBrcyOrVrFUF3a4hahRmSw
         sXqJy5WNvMLvQQMBN93Q3HkJKsbSpOSsUalvBZyA=
Date:   Fri, 18 Feb 2022 08:51:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [REPORT] kernel BUG at fs/ext4/inode.c:2620 - page_buffers()
Message-ID: <Yg9QGm2Rygrv+lMj@kroah.com>
References: <Yg0m6IjcNmfaSokM@google.com>
 <82d0f4e4-c911-a245-4701-4712453592d9@nvidia.com>
 <Yg8bxiz02WBGf6qO@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yg8bxiz02WBGf6qO@mit.edu>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 17, 2022 at 11:08:38PM -0500, Theodore Ts'o wrote:
> On Thu, Feb 17, 2022 at 05:06:45PM -0800, John Hubbard wrote:
> > Yes. And looking at the pair of backtraces below, this looks very much
> > like another aspect of the "get_user_pages problem" [1], originally
> > described in Jan Kara's 2018 email [2].
> 
> Hmm... I just posted my analysis, which tracks with yours; but I had
> forgotten about Jan's 2018 e-mail on the matter.
> 
> > I'm getting close to posting an RFC for the direct IO conversion to
> > FOLL_PIN, but even after that, various parts of the kernel (reclaim,
> > filesystems/block layer) still need to be changed so as to use
> > page_maybe_dma_pinned() to help avoid this problem. There's a bit
> > more than that, actually.
> 
> The challenge is that fixing this "the right away" is probably not
> something we can backport into an LTS kernel, whether it's 5.15 or
> 5.10... or 4.19.

Don't worry about stable backports to start with.  Do it the "right way"
first and then we can consider if it needs to be backported or not.

thanks,

greg k-h
