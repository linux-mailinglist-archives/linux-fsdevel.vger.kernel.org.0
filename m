Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8156651361A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 16:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348054AbiD1OG3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 10:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348073AbiD1OGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:06:04 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE79FB6454;
        Thu, 28 Apr 2022 07:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651154570; x=1682690570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h4skWhp2zeIZpA2ClyYBwaM9S88S0lAXDPHsSUH0YyA=;
  b=Fss3k9R8U39Qqn3SxHfPaAskIJoUcouFzazcg4D3LqNNRWtyJXZNxy1f
   6uDUsK36VYQjxh6EqcIAhXpmVfWgmmEK1d01YQ3iaHnp0QTqgQfvXASdP
   rNU4BYRlUFuIoYKx5cVh+/XTHrox0MCp7FcaeK6AhTzBgCCCAjZIXzYuF
   K0UbVY/Azba8sNkQ5yqggsySiKQup4rIV/DQoazCkWkdZpAnxjUprmrsR
   UMUmEZttRvdTayFLduee1AT5cMGeRGyOlYukhjWuo60Ls+8LQS2zc8Fhj
   vdEEh3+/cys4mIO6DwcPYfa4SQg3YXGkfKVYoyFNgi+0J67Wtva+oDtoN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="246856336"
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="246856336"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 07:02:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,295,1647327600"; 
   d="scan'208";a="541312589"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 28 Apr 2022 07:02:41 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nk4jA-0005Qa-9F;
        Thu, 28 Apr 2022 14:02:40 +0000
Date:   Thu, 28 Apr 2022 22:02:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     kbuild-all@lists.01.org, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Arnav Dawn <arnav.dawn@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v4 05/10] nvme: add copy offload support
Message-ID: <202204282136.kqIaq8aK-lkp@intel.com>
References: <20220426101241.30100-6-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426101241.30100-6-nj.shetty@samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nitesh,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20220422]
[cannot apply to axboe-block/for-next device-mapper-dm/for-next linus/master v5.18-rc4 v5.18-rc3 v5.18-rc2 v5.18-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Nitesh-Shetty/block-Introduce-queue-limits-for-copy-offload-support/20220426-201825
base:    e7d6987e09a328d4a949701db40ef63fbb970670
config: s390-randconfig-s032-20220427 (https://download.01.org/0day-ci/archive/20220428/202204282136.kqIaq8aK-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/e029014185aff1d7c8facf6e19447487c6ce2b93
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-Introduce-queue-limits-for-copy-offload-support/20220426-201825
        git checkout e029014185aff1d7c8facf6e19447487c6ce2b93
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash drivers/md/ drivers/nvme/host/ drivers/nvme/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/host/core.c:803:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] dspec @@     got restricted __le32 [usertype] @@
   drivers/nvme/host/core.c:803:26: sparse:     expected restricted __le16 [usertype] dspec
   drivers/nvme/host/core.c:803:26: sparse:     got restricted __le32 [usertype]

vim +803 drivers/nvme/host/core.c

   739	
   740	static inline blk_status_t nvme_setup_copy_write(struct nvme_ns *ns,
   741		       struct request *req, struct nvme_command *cmnd)
   742	{
   743		struct nvme_ctrl *ctrl = ns->ctrl;
   744		struct nvme_copy_range *range = NULL;
   745		struct bio *bio = req->bio;
   746		struct nvme_copy_token *token = bvec_kmap_local(&bio->bi_io_vec[0]);
   747		sector_t src_sector, dst_sector, n_sectors;
   748		u64 src_lba, dst_lba, n_lba;
   749		unsigned short nr_range = 1;
   750		u16 control = 0;
   751		u32 dsmgmt = 0;
   752	
   753		if (unlikely(memcmp(token->subsys, "nvme", 4)))
   754			return BLK_STS_NOTSUPP;
   755		if (unlikely(token->ns != ns))
   756			return BLK_STS_NOTSUPP;
   757	
   758		src_sector = token->src_sector;
   759		dst_sector = bio->bi_iter.bi_sector;
   760		n_sectors = token->sectors;
   761		if (WARN_ON(n_sectors != bio->bi_iter.bi_size >> 9))
   762			return BLK_STS_NOTSUPP;
   763	
   764		src_lba = nvme_sect_to_lba(ns, src_sector);
   765		dst_lba = nvme_sect_to_lba(ns, dst_sector);
   766		n_lba = nvme_sect_to_lba(ns, n_sectors);
   767	
   768		if (unlikely(nvme_lba_to_sect(ns, src_lba) != src_sector) ||
   769				unlikely(nvme_lba_to_sect(ns, dst_lba) != dst_sector) ||
   770				unlikely(nvme_lba_to_sect(ns, n_lba) != n_sectors))
   771			return BLK_STS_NOTSUPP;
   772	
   773		if (WARN_ON(!n_lba))
   774			return BLK_STS_NOTSUPP;
   775	
   776		if (req->cmd_flags & REQ_FUA)
   777			control |= NVME_RW_FUA;
   778	
   779		if (req->cmd_flags & REQ_FAILFAST_DEV)
   780			control |= NVME_RW_LR;
   781	
   782		memset(cmnd, 0, sizeof(*cmnd));
   783		cmnd->copy.opcode = nvme_cmd_copy;
   784		cmnd->copy.nsid = cpu_to_le32(ns->head->ns_id);
   785		cmnd->copy.sdlba = cpu_to_le64(dst_lba);
   786	
   787		range = kmalloc_array(nr_range, sizeof(*range),
   788				GFP_ATOMIC | __GFP_NOWARN);
   789		if (!range)
   790			return BLK_STS_RESOURCE;
   791	
   792		range[0].slba = cpu_to_le64(src_lba);
   793		range[0].nlb = cpu_to_le16(n_lba - 1);
   794	
   795		cmnd->copy.nr_range = 0;
   796	
   797		req->special_vec.bv_page = virt_to_page(range);
   798		req->special_vec.bv_offset = offset_in_page(range);
   799		req->special_vec.bv_len = sizeof(*range) * nr_range;
   800		req->rq_flags |= RQF_SPECIAL_PAYLOAD;
   801	
   802		cmnd->copy.control = cpu_to_le16(control);
 > 803		cmnd->copy.dspec = cpu_to_le32(dsmgmt);
   804	
   805		return BLK_STS_OK;
   806	}
   807	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
