Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD0B7197A5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 11:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjFAJuV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 05:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbjFAJuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:50:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD5A95;
        Thu,  1 Jun 2023 02:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D43756425C;
        Thu,  1 Jun 2023 09:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7162C433EF;
        Thu,  1 Jun 2023 09:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685613009;
        bh=fUFnP8JClGnkC9Vy2F7MOXl5BeYzlX+HFhd4pvaRKEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hw085gAQLoUmZavmnB+3G/SMg5IaFloQgLLlbOstLecC/Fu3S/lz7yXW31YFirolX
         S/1RtdLNWznxI8Fwb+T1hELUWKQciw6y7RnT+qNt7APCDD2YDzXlKS5NReVgI0GaqI
         8kDRekd5510mPBJ6FzrhdxyuOhW3uChD8gX9B82v31SB50XVD2mhPdlVFwq9glSH6L
         S3q+TWbVA5o9L400RNtiznTZ5cBdHWjpq+J7dCD0wOcxIbSKw1DyWjgbO+2c0jeruV
         xHYuEvsnQGhD/5aMf5O4u9WRSadRMQx5Nf17fK2hF1AmcsFs3n+iiisksQESTiV+zt
         ax2QzrDwZIZ6g==
Date:   Thu, 1 Jun 2023 11:49:59 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     chenzhiyin <zhiyin.chen@intel.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, nanhai.zou@intel.com,
        Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fs.h: Optimize file struct to prevent false sharing
Message-ID: <20230601-pelle-gemustert-4ba4b700c3db@brauner>
References: <20230531-wahlkabine-unantastbar-9f73a13262c0@brauner>
 <20230601092400.27162-1-zhiyin.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230601092400.27162-1-zhiyin.chen@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 05:24:00AM -0400, chenzhiyin wrote:
> In the syscall test of UnixBench, performance regression occurred due
> to false sharing.
> 
> The lock and atomic members, including file::f_lock, file::f_count and
> file::f_pos_lock are highly contended and frequently updated in the
> high-concurrency test scenarios. perf c2c indentified one affected
> read access, file::f_op.
> To prevent false sharing, the layout of file struct is changed as
> following
> (A) f_lock, f_count and f_pos_lock are put together to share the same
> cache line.
> (B) The read mostly members, including f_path, f_inode, f_op are put
> into a separate cache line.
> (C) f_mode is put together with f_count, since they are used frequently
>  at the same time.
> Due to '__randomize_layout' attribute of file struct, the updated layout
> only can be effective when CONFIG_RANDSTRUCT_NONE is 'y'.
> 
> The optimization has been validated in the syscall test of UnixBench.
> performance gain is 30~50%. Furthermore, to confirm the optimization
> effectiveness on the other codes path, the results of fsdisk, fsbuffer
> and fstime are also shown.
> 
> Here are the detailed test results of unixbench.
> 
> Command: numactl -C 3-18 ./Run -c 16 syscall fsbuffer fstime fsdisk
> 
> Without Patch
> ------------------------------------------------------------------------
> File Copy 1024 bufsize 2000 maxblocks   875052.1 KBps  (30.0 s, 2 samples)
> File Copy 256 bufsize 500 maxblocks     235484.0 KBps  (30.0 s, 2 samples)
> File Copy 4096 bufsize 8000 maxblocks  2815153.5 KBps  (30.0 s, 2 samples)
> System Call Overhead                   5772268.3 lps   (10.0 s, 7 samples)
> 
> System Benchmarks Partial Index         BASELINE       RESULT    INDEX
> File Copy 1024 bufsize 2000 maxblocks     3960.0     875052.1   2209.7
> File Copy 256 bufsize 500 maxblocks       1655.0     235484.0   1422.9
> File Copy 4096 bufsize 8000 maxblocks     5800.0    2815153.5   4853.7
> System Call Overhead                     15000.0    5772268.3   3848.2
>                                                               ========
> System Benchmarks Index Score (Partial Only)                    2768.3
> 
> With Patch
> ------------------------------------------------------------------------
> File Copy 1024 bufsize 2000 maxblocks  1009977.2 KBps  (30.0 s, 2 samples)
> File Copy 256 bufsize 500 maxblocks     264765.9 KBps  (30.0 s, 2 samples)
> File Copy 4096 bufsize 8000 maxblocks  3052236.0 KBps  (30.0 s, 2 samples)
> System Call Overhead                   8237404.4 lps   (10.0 s, 7 samples)
> 
> System Benchmarks Partial Index         BASELINE       RESULT    INDEX
> File Copy 1024 bufsize 2000 maxblocks     3960.0    1009977.2   2550.4
> File Copy 256 bufsize 500 maxblocks       1655.0     264765.9   1599.8
> File Copy 4096 bufsize 8000 maxblocks     5800.0    3052236.0   5262.5
> System Call Overhead                     15000.0    8237404.4   5491.6
>                                                               ========
> System Benchmarks Index Score (Partial Only)                    3295.3
> 
> Signed-off-by: chenzhiyin <zhiyin.chen@intel.com>
> ---

Dave had some more concerns and perf analysis requests for this. So this
will be put on hold until these are addressed.
