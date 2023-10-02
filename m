Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4907B4AA6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 03:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbjJBB7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 1 Oct 2023 21:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbjJBB7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 1 Oct 2023 21:59:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2B5C9;
        Sun,  1 Oct 2023 18:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696211959; x=1727747959;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W88JVX1gXyO0U29l0jTJHljfHkuQ/YgOQ/ZzLImDnS0=;
  b=BdQe1xE4OIO0bvOUh3nbyB2rPtnNMViptKIOqnE8BDK18dFxQ8zcOfUy
   1ROS9nk/l1phxusmkbcS7GZMja13uK6LSI7hnSq8EPnTnJ/D+ee3Rx1lJ
   lFKlvuaai0M81VwJakdinXNyC9IFTPW+9I7UYOI/kz/KTqdpClmBubr75
   54BPhKPcy6QFaDpE5O58v6kjzneBGEu1aJQm4yLWjuMtiHdgD67n3LjbX
   73p6KeZDLFeFqXrQJw5v1AdgfK6/PnkAR/dsvP2a/4ouQfh5ZZjn6MZD3
   kNTc8fzjSCflL5UtbwIkanh4ThxApc02dLA25jtg/wFjBAEb5PBlOX45v
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="372920002"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="372920002"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 18:59:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="840862065"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="840862065"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Oct 2023 18:59:13 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qn8DG-0005fl-1j;
        Mon, 02 Oct 2023 01:59:10 +0000
Date:   Mon, 2 Oct 2023 09:58:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, nitheshshetty@gmail.com,
        anuj1072538@gmail.com, gost.dev@samsung.com, mcgrof@kernel.org,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Hannes Reinecke <hare@suse.de>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v16 08/12] nvmet: add copy command support for bdev and
 file ns
Message-ID: <202310020910.TaSOIepO-lkp@intel.com>
References: <20230920080756.11919-9-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920080756.11919-9-nj.shetty@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nitesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7fc7222d9680366edeecc219c21ca96310bdbc10]

url:    https://github.com/intel-lab-lkp/linux/commits/Nitesh-Shetty/block-Introduce-queue-limits-and-sysfs-for-copy-offload-support/20230920-170132
base:   7fc7222d9680366edeecc219c21ca96310bdbc10
patch link:    https://lore.kernel.org/r/20230920080756.11919-9-nj.shetty%40samsung.com
patch subject: [PATCH v16 08/12] nvmet: add copy command support for bdev and file ns
config: i386-randconfig-061-20231002 (https://download.01.org/0day-ci/archive/20231002/202310020910.TaSOIepO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231002/202310020910.TaSOIepO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310020910.TaSOIepO-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/io-cmd-bdev.c:498:30: sparse: sparse: restricted __le16 degrades to integer
>> drivers/nvme/target/io-cmd-bdev.c:514:41: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted blk_status_t [usertype] blk_sts @@     got int [assigned] [usertype] ret @@
   drivers/nvme/target/io-cmd-bdev.c:514:41: sparse:     expected restricted blk_status_t [usertype] blk_sts
   drivers/nvme/target/io-cmd-bdev.c:514:41: sparse:     got int [assigned] [usertype] ret

vim +498 drivers/nvme/target/io-cmd-bdev.c

   478	
   479	/*
   480	 * At present we handle only one range entry, since copy offload is aligned with
   481	 * copy_file_range, only one entry is passed from block layer.
   482	 */
   483	static void nvmet_bdev_execute_copy(struct nvmet_req *rq)
   484	{
   485		struct nvme_copy_range range;
   486		struct nvme_command *cmd = rq->cmd;
   487		ssize_t ret;
   488		off_t dst, src;
   489	
   490		u16 status;
   491	
   492		status = nvmet_copy_from_sgl(rq, 0, &range, sizeof(range));
   493		if (status)
   494			goto err_rq_complete;
   495	
   496		dst = le64_to_cpu(cmd->copy.sdlba) << rq->ns->blksize_shift;
   497		src = le64_to_cpu(range.slba) << rq->ns->blksize_shift;
 > 498		rq->copy_len = (range.nlb + 1) << rq->ns->blksize_shift;
   499	
   500		if (bdev_max_copy_sectors(rq->ns->bdev)) {
   501			ret = blkdev_copy_offload(rq->ns->bdev, dst, src, rq->copy_len,
   502						  nvmet_bdev_copy_endio,
   503						  (void *)rq, GFP_KERNEL);
   504		} else {
   505			ret = blkdev_copy_emulation(rq->ns->bdev, dst,
   506						    rq->ns->bdev, src, rq->copy_len,
   507						    nvmet_bdev_copy_endio,
   508						    (void *)rq, GFP_KERNEL);
   509		}
   510		if (ret == -EIOCBQUEUED)
   511			return;
   512	
   513		rq->cqe->result.u32 = cpu_to_le32(0);
 > 514		status = blk_to_nvme_status(rq, ret);
   515	err_rq_complete:
   516		nvmet_req_complete(rq, status);
   517	}
   518	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
