Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1435A7009ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 May 2023 16:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241327AbjELOFy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 May 2023 10:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbjELOFx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 May 2023 10:05:53 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856B5197;
        Fri, 12 May 2023 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900351; x=1715436351;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aQsrwDrXTYSUlrlR/0XEbhht6wHcDB/nGNcRiSziND4=;
  b=YqnNPT2/dmLbAUDCHSYgz1TCqeECAUMSOZWz8o/bAYphz6emXoEA0UMu
   12eukqSjAmKd0RgqnCf+PzSz3TD/iUG4NrOWTXHZZGtwsof0lX3ZCbSrF
   p4XwEGGg/L75RHYTlM9jRZgW83cXHxjTxmrkbtuKzUTo+v7/wX7G0oa3j
   CiWdH+4DQCHcjtuRpwsGPxiNpDPIyR6si4pw6FhAI0PVil9JDBB1VFTZr
   0K46SXRUnsqMDuvqDc47l6PFo3saelYibyr/jpLi1aWiQpzcIIhbjNPfM
   KMtclKWBR5mippnZKmqygvUUtfVGGKCGWVmcauZsB5qCp4RTUBX/FFLcG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="350818451"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="350818451"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:05:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="694247085"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="694247085"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 May 2023 07:05:49 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxTP2-0004uW-1o;
        Fri, 12 May 2023 14:05:48 +0000
Date:   Fri, 12 May 2023 22:05:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        jlayton@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/4] NFSD: handle GETATTR conflict with write delegation
Message-ID: <202305122100.rFiPDpBs-lkp@intel.com>
References: <1683841383-21372-5-git-send-email-dai.ngo@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683841383-21372-5-git-send-email-dai.ngo@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dai,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.4-rc1 next-20230512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dai-Ngo/locks-allow-support-for-write-delegation/20230512-054404
base:   linus/master
patch link:    https://lore.kernel.org/r/1683841383-21372-5-git-send-email-dai.ngo%40oracle.com
patch subject: [PATCH 4/4] NFSD: handle GETATTR conflict with write delegation
config: m68k-randconfig-s041-20230509 (https://download.01.org/0day-ci/archive/20230512/202305122100.rFiPDpBs-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/9e8fd28524572f2f87cc153cbaaaa7a4120d2319
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dai-Ngo/locks-allow-support-for-write-delegation/20230512-054404
        git checkout 9e8fd28524572f2f87cc153cbaaaa7a4120d2319
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash fs/nfsd/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202305122100.rFiPDpBs-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/nfsd/nfs4xdr.c:2968:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __be32 [assigned] [usertype] status @@
   fs/nfsd/nfs4xdr.c:2968:24: sparse:     expected int
   fs/nfsd/nfs4xdr.c:2968:24: sparse:     got restricted __be32 [assigned] [usertype] status
>> fs/nfsd/nfs4xdr.c:3043:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [assigned] [usertype] status @@     got int @@
   fs/nfsd/nfs4xdr.c:3043:24: sparse:     expected restricted __be32 [assigned] [usertype] status
   fs/nfsd/nfs4xdr.c:3043:24: sparse:     got int

vim +2968 fs/nfsd/nfs4xdr.c

  2942	
  2943	static int
  2944	nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *inode,
  2945				bool *modified, u64 *size)
  2946	{
  2947		__be32 status;
  2948		struct file_lock *fl;
  2949		struct nfs4_delegation *dp;
  2950		struct nfs4_cb_fattr *ncf;
  2951		struct iattr attrs;
  2952	
  2953		*modified = false;
  2954		fl = nfs4_wrdeleg_filelock(rqstp, inode);
  2955		if (!fl)
  2956			return 0;
  2957		dp = fl->fl_owner;
  2958		ncf = &dp->dl_cb_fattr;
  2959		if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker))
  2960			return 0;
  2961	
  2962		refcount_inc(&dp->dl_stid.sc_count);
  2963		nfs4_cb_getattr(&dp->dl_cb_fattr);
  2964		wait_on_bit(&ncf->ncf_cb_flags, CB_GETATTR_BUSY, TASK_INTERRUPTIBLE);
  2965		if (ncf->ncf_cb_status) {
  2966			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
  2967			nfs4_put_stid(&dp->dl_stid);
> 2968			return status;
  2969		}
  2970		ncf->ncf_cur_fsize = ncf->ncf_cb_fsize;
  2971		if (!ncf->ncf_file_modified &&
  2972				(ncf->ncf_initial_cinfo != ncf->ncf_cb_cinfo ||
  2973				ncf->ncf_cur_fsize != ncf->ncf_cb_fsize)) {
  2974			ncf->ncf_file_modified = true;
  2975		}
  2976	
  2977		if (ncf->ncf_file_modified) {
  2978			/*
  2979			 * The server would not update the file's metadata
  2980			 * with the client's modified size.
  2981			 * nfsd4 change attribute is constructed from ctime.
  2982			 */
  2983			attrs.ia_mtime = attrs.ia_ctime = current_time(inode);
  2984			attrs.ia_valid = ATTR_MTIME | ATTR_CTIME;
  2985			setattr_copy(&nop_mnt_idmap, inode, &attrs);
  2986			mark_inode_dirty(inode);
  2987			*size = ncf->ncf_cur_fsize;
  2988			*modified = true;
  2989		}
  2990		nfs4_put_stid(&dp->dl_stid);
  2991		return 0;
  2992	}
  2993	
  2994	/*
  2995	 * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
  2996	 * ourselves.
  2997	 */
  2998	static __be32
  2999	nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
  3000			struct svc_export *exp,
  3001			struct dentry *dentry, u32 *bmval,
  3002			struct svc_rqst *rqstp, int ignore_crossmnt)
  3003	{
  3004		u32 bmval0 = bmval[0];
  3005		u32 bmval1 = bmval[1];
  3006		u32 bmval2 = bmval[2];
  3007		struct kstat stat;
  3008		struct svc_fh *tempfh = NULL;
  3009		struct kstatfs statfs;
  3010		__be32 *p, *attrlen_p;
  3011		int starting_len = xdr->buf->len;
  3012		int attrlen_offset;
  3013		u32 dummy;
  3014		u64 dummy64;
  3015		u32 rdattr_err = 0;
  3016		__be32 status;
  3017		int err;
  3018		struct nfs4_acl *acl = NULL;
  3019	#ifdef CONFIG_NFSD_V4_SECURITY_LABEL
  3020		void *context = NULL;
  3021		int contextlen;
  3022	#endif
  3023		bool contextsupport = false;
  3024		struct nfsd4_compoundres *resp = rqstp->rq_resp;
  3025		u32 minorversion = resp->cstate.minorversion;
  3026		struct path path = {
  3027			.mnt	= exp->ex_path.mnt,
  3028			.dentry	= dentry,
  3029		};
  3030		struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
  3031		bool file_modified;
  3032		u64 size = 0;
  3033	
  3034		BUG_ON(bmval1 & NFSD_WRITEONLY_ATTRS_WORD1);
  3035		BUG_ON(!nfsd_attrs_supported(minorversion, bmval));
  3036	
  3037		if (exp->ex_fslocs.migrated) {
  3038			status = fattr_handle_absent_fs(&bmval0, &bmval1, &bmval2, &rdattr_err);
  3039			if (status)
  3040				goto out;
  3041		}
  3042		if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
> 3043			status = nfs4_handle_wrdeleg_conflict(rqstp, d_inode(dentry),
  3044							&file_modified, &size);
  3045			if (status)
  3046				goto out;
  3047		}
  3048	
  3049		err = vfs_getattr(&path, &stat,
  3050				  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
  3051				  AT_STATX_SYNC_AS_STAT);
  3052		if (err)
  3053			goto out_nfserr;
  3054		if (!(stat.result_mask & STATX_BTIME))
  3055			/* underlying FS does not offer btime so we can't share it */
  3056			bmval1 &= ~FATTR4_WORD1_TIME_CREATE;
  3057		if ((bmval0 & (FATTR4_WORD0_FILES_AVAIL | FATTR4_WORD0_FILES_FREE |
  3058				FATTR4_WORD0_FILES_TOTAL | FATTR4_WORD0_MAXNAME)) ||
  3059		    (bmval1 & (FATTR4_WORD1_SPACE_AVAIL | FATTR4_WORD1_SPACE_FREE |
  3060			       FATTR4_WORD1_SPACE_TOTAL))) {
  3061			err = vfs_statfs(&path, &statfs);
  3062			if (err)
  3063				goto out_nfserr;
  3064		}
  3065		if ((bmval0 & (FATTR4_WORD0_FILEHANDLE | FATTR4_WORD0_FSID)) && !fhp) {
  3066			tempfh = kmalloc(sizeof(struct svc_fh), GFP_KERNEL);
  3067			status = nfserr_jukebox;
  3068			if (!tempfh)
  3069				goto out;
  3070			fh_init(tempfh, NFS4_FHSIZE);
  3071			status = fh_compose(tempfh, exp, dentry, NULL);
  3072			if (status)
  3073				goto out;
  3074			fhp = tempfh;
  3075		}
  3076		if (bmval0 & FATTR4_WORD0_ACL) {
  3077			err = nfsd4_get_nfs4_acl(rqstp, dentry, &acl);
  3078			if (err == -EOPNOTSUPP)
  3079				bmval0 &= ~FATTR4_WORD0_ACL;
  3080			else if (err == -EINVAL) {
  3081				status = nfserr_attrnotsupp;
  3082				goto out;
  3083			} else if (err != 0)
  3084				goto out_nfserr;
  3085		}
  3086	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
