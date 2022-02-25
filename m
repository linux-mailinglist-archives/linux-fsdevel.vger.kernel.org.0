Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B764C5011
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Feb 2022 21:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbiBYUwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Feb 2022 15:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiBYUwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:52:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2122028BA;
        Fri, 25 Feb 2022 12:51:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B586B83389;
        Fri, 25 Feb 2022 20:51:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF336C340E7;
        Fri, 25 Feb 2022 20:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645822290;
        bh=F0J/fHQ4PH2PHbI5q93Nm/WbNth9O2hP5bMINbwsdqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eyc+zwquCZ/3IDTmwCbztdnSaf+0OTEgxtAnK98OsuCbT3GDEct8oNRwS3MewY3Nk
         YMcaEs1KaiUsbEoBbnSGEdZDz+mhuyYwmTNspFkAR+EbrSuq8FLpM2WSKHn5GnP97F
         xDaBrcBu9WBQaJyO3Qf0dURhIvP+eDaUe4DlOw7v1k5i9C024DfzK1Tx9cRKcGrR7F
         ETmS1LfStzM59QDQ3l99HkE7q58zaldyDcrFxCwDlj04hJpFbbGdsP3QbnKdgHvq40
         fPajHYlcbV00WyA1RilKx81Q41KPU/JKXkZv1voJMfZPhaGEJ0wP8xG1EP/aTBZHoS
         UsrSUoTlOAMLA==
Date:   Fri, 25 Feb 2022 12:51:28 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Bob Peterson <rpeterso@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Thumshirn <jth@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -v2] ext4: don't BUG if kernel subsystems dirty pages
 without asking ext4 first
Message-ID: <YhlBUCi9O30szf6l@sol.localdomain>
References: <Yg0m6IjcNmfaSokM@google.com>
 <Yhks88tO3Em/G370@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yhks88tO3Em/G370@mit.edu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 25, 2022 at 02:24:35PM -0500, Theodore Ts'o wrote:
> [un]pin_user_pages_remote is dirtying pages without properly warning
> the file system in advance (or faulting in the file data if the page
> is not yet in the page cache).  This was noted by Jan Kara in 2018[1]
> and more recently has resulted in bug reports by Syzbot in various
> Android kernels[2].
> 
> This is technically a bug in the mm/gup.c codepath, but arguably ext4
> is fragile in that a buggy get_user_pages() implementation causes ext4
> to crash, where as other file systems are not crashing (although in
> some cases the user data will be lost since gup code is not properly
> informing the file system to potentially allocate blocks or reserve
> space when writing into a sparse portion of file).  I suspect in real
> life it is rare that people are using RDMA into file-backed memory,
> which is why no one has complained to ext4 developers except fuzzing
> programs.
> 
> So instead of crashing with a BUG, issue a warning (since there may be
> potential data loss) and just mark the page as clean to avoid
> unprivileged denial of service attacks until the problem can be
> properly fixed.  More discussion and background can be found in the
> thread starting at [2].
> 
> [1] https://www.spinics.net/lists/linux-mm/msg142700.html

Can you use a lore link
(https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz/T/#u)?

> +			/*
> +			 * Should never happen but for buggy code in
> +			 * other subsystemsa that call

subsystemsa => subsystems

> +			 * set_page_dirty() without properly warning
> +			 * the file system first.  See [1] for more
> +			 * information.
> +			 *
> +			 * [1] https://www.spinics.net/lists/linux-mm/msg142700.html

Likewise, lore link here.

- Eric
