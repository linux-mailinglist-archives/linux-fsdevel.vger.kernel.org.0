Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DBE6A3FDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 12:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjB0LAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 06:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjB0K76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 05:59:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08A020570
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 02:59:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15546B80C94
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 10:59:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA1BC433AF;
        Mon, 27 Feb 2023 10:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677495544;
        bh=NDLKzFV5RI7dMGYMLrPqrjWvAWTCQ3hQXDgoWSU85lY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X2S2Sx1dFwEEpR5sQaLFMsqOtg6oDilBtC25SjXcPg5TgvwD3ckHHRalBNrBZUxJM
         w643HPLyaPWLwcZvSDfj0nvs/rQFl2UQJVoEkYIDmiqIS7L19HeHoCuK1zTTc+tr3D
         sd7sLSCQq6jjFp8uBF+2r+LcLCP0B/9geLUy/wxTr4IR7HIJfO+RWqcxkpUAXNq8XW
         HEXGeH7KFjStcpVS2TXMRAPtwGOSqUnI9IiI7H1s8bZ7c5LcHM3btd2GDTnAtwDfqL
         2hGAs36LIlFppxEmxmd7tcDr56YEYSRNAJXOeTCvoPeIRrCxZH2fXody9P6SjtboW4
         UzBPzYj1benOA==
Date:   Mon, 27 Feb 2023 11:58:55 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
Message-ID: <20230227105855.s5sdn5juh3o37cus@wittgenstein>
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <5958ef1a-b635-96f8-7840-0752138e75e8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5958ef1a-b635-96f8-7840-0752138e75e8@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 06:45:50PM +0800, Gao Xiang wrote:
> 
> (+cc Jingbo Xu and Christian Brauner)
> 
> On 2023/2/27 17:22, Alexander Larsson wrote:
> > Hello,
> > 
> > Recently Giuseppe Scrivano and I have worked on[1] and proposed[2] the
> > Composefs filesystem. It is an opportunistically sharing, validating
> > image-based filesystem, targeting usecases like validated ostree
> > rootfs:es, validated container images that share common files, as well
> > as other image based usecases.
> > 
> > During the discussions in the composefs proposal (as seen on LWN[3])
> > is has been proposed that (with some changes to overlayfs), similar
> > behaviour can be achieved by combining the overlayfs
> > "overlay.redirect" xattr with an read-only filesystem such as erofs.
> > 
> > There are pros and cons to both these approaches, and the discussion
> > about their respective value has sometimes been heated. We would like
> > to have an in-person discussion at the summit, ideally also involving
> > more of the filesystem development community, so that we can reach
> > some consensus on what is the best apporach.
> > 
> > Good participants would be at least: Alexander Larsson, Giuseppe
> > Scrivano, Amir Goldstein, David Chinner, Gao Xiang, Miklos Szeredi,
> > Jingbo Xu
> I'd be happy to discuss this at LSF/MM/BPF this year. Also we've addressed
> the root cause of the performance gap is that
> 
> composefs read some data symlink-like payload data by using
> cfs_read_vdata_path() which involves kernel_read() and trigger heuristic
> readahead of dir data (which is also landed in composefs vdata area
> together with payload), so that most composefs dir I/O is already done
> in advance by heuristic  readahead.  And we think almost all exist
> in-kernel local fses doesn't have such heuristic readahead and if we add
> the similar stuff, EROFS could do better than composefs.
> 
> Also we've tried random stat()s about 500~1000 files in the tree you shared
> (rather than just "ls -lR") and EROFS did almost the same or better than
> composefs.  I guess further analysis (including blktrace) could be shown by
> Jingbo later.
> 
> Not sure if Christian Brauner would like to discuss this new stacked fs

I'll be at lsfmm in any case and already got my invite a while ago. I
intend to give some updates about a few vfs things and I can talk about
this as well.

Thanks, Gao!
