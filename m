Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3BC463C714
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 19:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbiK2STB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 13:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbiK2STA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:19:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9683D2A41E
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 10:18:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9154EB818A0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Nov 2022 18:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52672C433C1;
        Tue, 29 Nov 2022 18:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669745934;
        bh=5oPMcpasE0kW0BjYneeMu8nFmNU1Z74po69kSg+H1Co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFrgV8WuK2Qc5gMZtVRGqWlC47ejJ/wWx7IELKhhdkCHI6LcAMw/tRxag0JD+10ij
         F2GntKSG4HwT0hUlR4Fql+dUfNzCckL6AkVC1y5No+KIRTXdwm7IcHPAkneMpVNgus
         yJ5Bpfz5ZultKhWe15u7T2P8w9qUK8VLIOfOLRAmn0u4N/6PNYbd9FIEyX+KCbF/EH
         5/CGqlxZn7zUpkVV3awkhvLDEHFv38uzHXbiT3Lr5hvlnAsbn7VgYbzjSs20KKlwtL
         MqXucAchOW/n/Ac+PV/4i2EDpiCrh5nKwi0S2feMelAkgi3RNoly+NNTWClDd6QbN7
         QBAK7gfmS1Icw==
Date:   Tue, 29 Nov 2022 10:18:53 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/remap_range: avoid spurious writeback on zero length
 request
Message-ID: <Y4ZNDTC8rL0f9WE+@magnolia>
References: <20221128160813.3950889-1-bfoster@redhat.com>
 <Y4TubQFwHExk07w4@magnolia>
 <Y4XtL9SzQN/A4w5U@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4XtL9SzQN/A4w5U@bfoster>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 29, 2022 at 06:29:51AM -0500, Brian Foster wrote:
> On Mon, Nov 28, 2022 at 09:22:53AM -0800, Darrick J. Wong wrote:
> > On Mon, Nov 28, 2022 at 11:08:13AM -0500, Brian Foster wrote:
> > > generic_remap_checks() can reduce the effective request length (i.e.,
> > > after the reflink extend to EOF case is handled) down to zero. If this
> > > occurs, __generic_remap_file_range_prep() proceeds through dio
> > > serialization, file mapping flush calls, and may invoke file_modified()
> > > before returning back to the filesystem caller, all of which immediately
> > > check for len == 0 and return.
> > > 
> > > While this is mostly harmless, it is spurious and not completely
> > > without side effect. A filemap write call can submit I/O (but not
> > > wait on it) when the specified end byte precedes the start but
> > > happens to land on the same aligned page boundary, which can occur
> > > from __generic_remap_file_range_prep() when len is 0.
> > > 
> > > The dedupe path already has a len == 0 check to break out before doing
> > > range comparisons. Lift this check a bit earlier in the function to
> > > cover the general case of len == 0 and avoid the unnecessary work.
> > > 
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > 
> > Looks correct,
> > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > 
> > Should there be an(other) "if (!*len) return 0;" after the
> > generic_remap_check_len call to skip the mtime update if the remap
> > request gets shortened to avoid remapping an unaligned eofblock into the
> > middle of the destination file?
> > 
> 
> Looks sensible to me, though I guess I would do something like the
> appended diff. Do you want to just fold that into this patch?

Yes, could you fold it in and send a v2 with my rvb on it, please?

--D

> Brian
> 
> --- 8< ---
> 
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index 32ea992f9acc..2f236c9c5802 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -347,7 +347,7 @@ __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  
>  	ret = generic_remap_check_len(inode_in, inode_out, pos_out, len,
>  			remap_flags);
> -	if (ret)
> +	if (ret || *len == 0)
>  		return ret;
>  
>  	/* If can't alter the file contents, we're done. */
> 
