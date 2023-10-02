Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A3E7B5D55
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 00:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbjJBWuz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 18:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236211AbjJBWuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 18:50:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0D4AD;
        Mon,  2 Oct 2023 15:50:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04535C433C8;
        Mon,  2 Oct 2023 22:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696287051;
        bh=EcTJa+PR680qpcWHsiMUeaqOdORB94EtacTE7leHuW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a6XxXmRA0+dUcG7H509G8/9uBhjEXxmfyV2Dk4iQaPWMO7ZWyW8eLOTzD2kT+Okr/
         sGWS+kPe7FQCpR5zpIez6GqPPKtenghyybtzHt78rPpQt0e6+r0e0JUJO7AyezLfAK
         s23w5ZDnE49M5I23U0GVG4WXs2xNexBzh1aV0qtsuqriBtS0KCCvl2AB93bozUVPwZ
         Fy3zwa3qHro4ggbtFAC8lqkyZ0sMl3n2Y/GL4FPzTTRsHMS0JAAbjzq+YgyD5ACCgj
         SuEz1MLvphmPavk2qiir6nAwuagBo6+44PI92PkCBUoGuNxY2Zj8Pu2/2JMSJZzdvo
         pYbvpkenZoHdA==
Date:   Mon, 2 Oct 2023 15:50:48 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        chandan.babu@oracle.com, dchinner@redhat.com, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-api@vger.kernel.org
Subject: Re: [PATCH 09/21] block: Add checks to merging of atomic writes
Message-ID: <20231002225048.GA558147@dev-arch.thelio-3990X>
References: <20230929102726.2985188-10-john.g.garry@oracle.com>
 <202309302100.L6ynQWub-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202309302100.L6ynQWub-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 30, 2023 at 09:40:30PM +0800, kernel test robot wrote:
> Hi John,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on xfs-linux/for-next]
> [also build test ERROR on axboe-block/for-next mkp-scsi/for-next jejb-scsi/for-next linus/master v6.6-rc3 next-20230929]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/John-Garry/block-Add-atomic-write-operations-to-request_queue-limits/20230929-184542
> base:   https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git for-next
> patch link:    https://lore.kernel.org/r/20230929102726.2985188-10-john.g.garry%40oracle.com
> patch subject: [PATCH 09/21] block: Add checks to merging of atomic writes
> config: mips-mtx1_defconfig (https://download.01.org/0day-ci/archive/20230930/202309302100.L6ynQWub-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309302100.L6ynQWub-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309302100.L6ynQWub-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: undefined symbol: __moddi3
>    >>> referenced by blk-merge.c
>    >>>               block/blk-merge.o:(ll_back_merge_fn) in archive vmlinux.a
>    >>> referenced by blk-merge.c
>    >>>               block/blk-merge.o:(ll_back_merge_fn) in archive vmlinux.a
>    >>> referenced by blk-merge.c
>    >>>               block/blk-merge.o:(bio_attempt_front_merge) in archive vmlinux.a
>    >>> referenced 3 more times

This does not appear to be clang specific, I can reproduce it with GCC
12.3.0 and the same configuration target.

Cheers,
Nathan
