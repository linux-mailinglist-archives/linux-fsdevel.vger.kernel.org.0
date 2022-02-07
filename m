Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF7E4ACA40
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 21:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbiBGURV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 15:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241230AbiBGUNT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 15:13:19 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90109C0401DA;
        Mon,  7 Feb 2022 12:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644264798; x=1675800798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E/9q+1vanuIWMxEsBVm7dkTx6y+5b6TFiPq1WZ6/6pU=;
  b=ULKIsdy3G19Ot3HZvDfzzVvVCZ1Uv7m1RuB/2id/OjO6Iz62C/o5DqYP
   5yqammATD8lqCxpX2hs8+V/yzvgkaMQCjIP0uJ0+vk31xkyQ6eydr7UjS
   mbGYDEWAuBD4PNxuvtA06mw/V29Okt/XOonnmYhKt2C1DQAzgZG/SS1nx
   g3Q13bqeGOEBexBmrX4kcnctu9AQ0zhriDjonqC0jI2Oz8ZW9I8bL3mki
   H6gXrDQGDLABcm5XE4C1Zb07L9evoFMiHcnkJlMzg+U/cdVSVdRX5ExWN
   B4ti3PgCCbXqaCGbUO2UBfY/KZQIwWGapSgnrRgn2vr3JmD3K/ACids83
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="248749072"
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="248749072"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 12:12:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,350,1635231600"; 
   d="scan'208";a="700590505"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 07 Feb 2022 12:12:53 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nHANY-0000vV-JD; Mon, 07 Feb 2022 20:12:52 +0000
Date:   Tue, 8 Feb 2022 04:12:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>, mpatocka@redhat.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, javier@javigon.com,
        chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, msnitzer@redhat.com
Subject: Re: [PATCH v2 07/10] nvmet: add copy command support for bdev and
 file ns
Message-ID: <202202080346.u4ubCCIs-lkp@intel.com>
References: <20220207141348.4235-8-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207141348.4235-8-nj.shetty@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Nitesh,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v5.17-rc3 next-20220207]
[cannot apply to device-mapper-dm/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nitesh-Shetty/block-make-bio_map_kern-non-static/20220207-231407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: arm64-randconfig-r031-20220207 (https://download.01.org/0day-ci/archive/20220208/202202080346.u4ubCCIs-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0d8850ae2cae85d49bea6ae0799fa41c7202c05c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/6bb6ea64499e1ac27975e79bb2eee89f07861893
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-make-bio_map_kern-non-static/20220207-231407
        git checkout 6bb6ea64499e1ac27975e79bb2eee89f07861893
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/nvme/target/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/nvme/target/admin-cmd.c:534:15: warning: implicit conversion from '__le32' (aka 'unsigned int') to '__le16' (aka 'unsigned short') changes value from 2097152 to 0 [-Wconstant-conversion]
                   id->mssrl = cpu_to_le32(BIO_MAX_VECS << (PAGE_SHIFT - SECTOR_SHIFT));
                             ~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/byteorder/generic.h:88:21: note: expanded from macro 'cpu_to_le32'
   #define cpu_to_le32 __cpu_to_le32
                       ^
   include/uapi/linux/byteorder/big_endian.h:34:27: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +534 drivers/nvme/target/admin-cmd.c

   488	
   489	static void nvmet_execute_identify_ns(struct nvmet_req *req)
   490	{
   491		struct nvme_id_ns *id;
   492		u16 status;
   493	
   494		if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
   495			req->error_loc = offsetof(struct nvme_identify, nsid);
   496			status = NVME_SC_INVALID_NS | NVME_SC_DNR;
   497			goto out;
   498		}
   499	
   500		id = kzalloc(sizeof(*id), GFP_KERNEL);
   501		if (!id) {
   502			status = NVME_SC_INTERNAL;
   503			goto out;
   504		}
   505	
   506		/* return an all zeroed buffer if we can't find an active namespace */
   507		status = nvmet_req_find_ns(req);
   508		if (status) {
   509			status = 0;
   510			goto done;
   511		}
   512	
   513		nvmet_ns_revalidate(req->ns);
   514	
   515		/*
   516		 * nuse = ncap = nsze isn't always true, but we have no way to find
   517		 * that out from the underlying device.
   518		 */
   519		id->ncap = id->nsze =
   520			cpu_to_le64(req->ns->size >> req->ns->blksize_shift);
   521		switch (req->port->ana_state[req->ns->anagrpid]) {
   522		case NVME_ANA_INACCESSIBLE:
   523		case NVME_ANA_PERSISTENT_LOSS:
   524			break;
   525		default:
   526			id->nuse = id->nsze;
   527			break;
   528		}
   529	
   530		if (req->ns->bdev)
   531			nvmet_bdev_set_limits(req->ns->bdev, id);
   532		else {
   533			id->msrc = to0based(BIO_MAX_VECS);
 > 534			id->mssrl = cpu_to_le32(BIO_MAX_VECS << (PAGE_SHIFT - SECTOR_SHIFT));
   535			id->mcl = cpu_to_le64(le32_to_cpu(id->mssrl) * BIO_MAX_VECS);
   536		}
   537	
   538		/*
   539		 * We just provide a single LBA format that matches what the
   540		 * underlying device reports.
   541		 */
   542		id->nlbaf = 0;
   543		id->flbas = 0;
   544	
   545		/*
   546		 * Our namespace might always be shared.  Not just with other
   547		 * controllers, but also with any other user of the block device.
   548		 */
   549		id->nmic = NVME_NS_NMIC_SHARED;
   550		id->anagrpid = cpu_to_le32(req->ns->anagrpid);
   551	
   552		memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
   553	
   554		id->lbaf[0].ds = req->ns->blksize_shift;
   555	
   556		if (req->sq->ctrl->pi_support && nvmet_ns_has_pi(req->ns)) {
   557			id->dpc = NVME_NS_DPC_PI_FIRST | NVME_NS_DPC_PI_LAST |
   558				  NVME_NS_DPC_PI_TYPE1 | NVME_NS_DPC_PI_TYPE2 |
   559				  NVME_NS_DPC_PI_TYPE3;
   560			id->mc = NVME_MC_EXTENDED_LBA;
   561			id->dps = req->ns->pi_type;
   562			id->flbas = NVME_NS_FLBAS_META_EXT;
   563			id->lbaf[0].ms = cpu_to_le16(req->ns->metadata_size);
   564		}
   565	
   566		if (req->ns->readonly)
   567			id->nsattr |= (1 << 0);
   568	done:
   569		if (!status)
   570			status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
   571	
   572		kfree(id);
   573	out:
   574		nvmet_req_complete(req, status);
   575	}
   576	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
