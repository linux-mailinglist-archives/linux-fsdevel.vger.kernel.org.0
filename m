Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0ED0770D35
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Aug 2023 03:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjHEB4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 21:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHEB4I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 21:56:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC24210C1;
        Fri,  4 Aug 2023 18:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691200566; x=1722736566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Et6Rrm61Lji+18cFR2dy374SZbyJrnpsNyX8KY8XEt0=;
  b=HNELKP9NeUt3hMkKnmsVt7EmanEsT4TGmlpRb1oalkvevPiif7ti9rdc
   YnoBYHEwzA7PAQYTJF6BMbmfxh7gCKOLHkGs/XcRajUVuO0mQ5vshcSQJ
   81ibvjfU7d7omwZp3g48QIztACT+m/+vsH3r8KjR8xRlmEkY/DLqrbnUt
   97VEBW5rJykUFYnajMuRGZWQRqeRMTfSZSrRp4kuzudOyVYiyANMEuLSE
   +gVzqHwdfNbNFpjETMLOcSMFiblnH+8QXXfal+8cT5+0saKRvFs+gC4r4
   oGuFGPyvnfw0qAPR6vFRnF4k0Y1lXgxQXYy3rBmfJ1MVy+dYj51vLqh2S
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="456661255"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="456661255"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 18:56:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="800309559"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="800309559"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2023 18:56:03 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qS6WQ-0003FD-1r;
        Sat, 05 Aug 2023 01:56:02 +0000
Date:   Sat, 5 Aug 2023 09:55:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        xiubli@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, brauner@kernel.org,
        stgraber@ubuntu.com, linux-fsdevel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 03/12] ceph: handle idmapped mounts in
 create_request_message()
Message-ID: <202308050925.ifGg1BUH-lkp@intel.com>
References: <20230804084858.126104-4-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804084858.126104-4-aleksandr.mikhalitsyn@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ceph-client/testing]
[cannot apply to ceph-client/for-linus brauner-vfs/vfs.all linus/master vfs-idmapping/for-next v6.5-rc4 next-20230804]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Mikhalitsyn/fs-export-mnt_idmap_get-mnt_idmap_put/20230804-165330
base:   https://github.com/ceph/ceph-client.git testing
patch link:    https://lore.kernel.org/r/20230804084858.126104-4-aleksandr.mikhalitsyn%40canonical.com
patch subject: [PATCH v9 03/12] ceph: handle idmapped mounts in create_request_message()
config: um-randconfig-r091-20230730 (https://download.01.org/0day-ci/archive/20230805/202308050925.ifGg1BUH-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230805/202308050925.ifGg1BUH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308050925.ifGg1BUH-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/ceph/mds_client.c:3082:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] struct_len @@     got unsigned long @@
   fs/ceph/mds_client.c:3082:35: sparse:     expected restricted __le32 [usertype] struct_len
   fs/ceph/mds_client.c:3082:35: sparse:     got unsigned long

vim +3082 fs/ceph/mds_client.c

  2927	
  2928	/*
  2929	 * called under mdsc->mutex
  2930	 */
  2931	static struct ceph_msg *create_request_message(struct ceph_mds_session *session,
  2932						       struct ceph_mds_request *req,
  2933						       bool drop_cap_releases)
  2934	{
  2935		int mds = session->s_mds;
  2936		struct ceph_mds_client *mdsc = session->s_mdsc;
  2937		struct ceph_client *cl = mdsc->fsc->client;
  2938		struct ceph_msg *msg;
  2939		struct ceph_mds_request_head_legacy *lhead;
  2940		const char *path1 = NULL;
  2941		const char *path2 = NULL;
  2942		u64 ino1 = 0, ino2 = 0;
  2943		int pathlen1 = 0, pathlen2 = 0;
  2944		bool freepath1 = false, freepath2 = false;
  2945		struct dentry *old_dentry = NULL;
  2946		int len;
  2947		u16 releases;
  2948		void *p, *end;
  2949		int ret;
  2950		bool legacy = !(session->s_con.peer_features & CEPH_FEATURE_FS_BTIME);
  2951		u16 request_head_version = mds_supported_head_version(session);
  2952	
  2953		ret = set_request_path_attr(mdsc, req->r_inode, req->r_dentry,
  2954				      req->r_parent, req->r_path1, req->r_ino1.ino,
  2955				      &path1, &pathlen1, &ino1, &freepath1,
  2956				      test_bit(CEPH_MDS_R_PARENT_LOCKED,
  2957						&req->r_req_flags));
  2958		if (ret < 0) {
  2959			msg = ERR_PTR(ret);
  2960			goto out;
  2961		}
  2962	
  2963		/* If r_old_dentry is set, then assume that its parent is locked */
  2964		if (req->r_old_dentry &&
  2965		    !(req->r_old_dentry->d_flags & DCACHE_DISCONNECTED))
  2966			old_dentry = req->r_old_dentry;
  2967		ret = set_request_path_attr(mdsc, NULL, old_dentry,
  2968				      req->r_old_dentry_dir,
  2969				      req->r_path2, req->r_ino2.ino,
  2970				      &path2, &pathlen2, &ino2, &freepath2, true);
  2971		if (ret < 0) {
  2972			msg = ERR_PTR(ret);
  2973			goto out_free1;
  2974		}
  2975	
  2976		req->r_altname = get_fscrypt_altname(req, &req->r_altname_len);
  2977		if (IS_ERR(req->r_altname)) {
  2978			msg = ERR_CAST(req->r_altname);
  2979			req->r_altname = NULL;
  2980			goto out_free2;
  2981		}
  2982	
  2983		/*
  2984		 * For old cephs without supporting the 32bit retry/fwd feature
  2985		 * it will copy the raw memories directly when decoding the
  2986		 * requests. While new cephs will decode the head depending the
  2987		 * version member, so we need to make sure it will be compatible
  2988		 * with them both.
  2989		 */
  2990		if (legacy)
  2991			len = sizeof(struct ceph_mds_request_head_legacy);
  2992		else if (request_head_version == 1)
  2993			len = sizeof(struct ceph_mds_request_head_old);
  2994		else if (request_head_version == 2)
  2995			len = offsetofend(struct ceph_mds_request_head, ext_num_fwd);
  2996		else
  2997			len = sizeof(struct ceph_mds_request_head);
  2998	
  2999		/* filepaths */
  3000		len += 2 * (1 + sizeof(u32) + sizeof(u64));
  3001		len += pathlen1 + pathlen2;
  3002	
  3003		/* cap releases */
  3004		len += sizeof(struct ceph_mds_request_release) *
  3005			(!!req->r_inode_drop + !!req->r_dentry_drop +
  3006			 !!req->r_old_inode_drop + !!req->r_old_dentry_drop);
  3007	
  3008		if (req->r_dentry_drop)
  3009			len += pathlen1;
  3010		if (req->r_old_dentry_drop)
  3011			len += pathlen2;
  3012	
  3013		/* MClientRequest tail */
  3014	
  3015		/* req->r_stamp */
  3016		len += sizeof(struct ceph_timespec);
  3017	
  3018		/* gid list */
  3019		len += sizeof(u32) + (sizeof(u64) * req->r_cred->group_info->ngroups);
  3020	
  3021		/* alternate name */
  3022		len += sizeof(u32) + req->r_altname_len;
  3023	
  3024		/* fscrypt_auth */
  3025		len += sizeof(u32); // fscrypt_auth
  3026		if (req->r_fscrypt_auth)
  3027			len += ceph_fscrypt_auth_len(req->r_fscrypt_auth);
  3028	
  3029		/* fscrypt_file */
  3030		len += sizeof(u32);
  3031		if (test_bit(CEPH_MDS_R_FSCRYPT_FILE, &req->r_req_flags))
  3032			len += sizeof(__le64);
  3033	
  3034		msg = ceph_msg_new2(CEPH_MSG_CLIENT_REQUEST, len, 1, GFP_NOFS, false);
  3035		if (!msg) {
  3036			msg = ERR_PTR(-ENOMEM);
  3037			goto out_free2;
  3038		}
  3039	
  3040		msg->hdr.tid = cpu_to_le64(req->r_tid);
  3041	
  3042		lhead = find_legacy_request_head(msg->front.iov_base,
  3043						 session->s_con.peer_features);
  3044	
  3045		if ((req->r_mnt_idmap != &nop_mnt_idmap) &&
  3046		    !test_bit(CEPHFS_FEATURE_HAS_OWNER_UIDGID, &session->s_features)) {
  3047			pr_err_ratelimited_client(cl,
  3048				"idmapped mount is used and CEPHFS_FEATURE_HAS_OWNER_UIDGID"
  3049				" is not supported by MDS. Fail request with -EIO.\n");
  3050	
  3051			ret = -EIO;
  3052			goto out_err;
  3053		}
  3054	
  3055		/*
  3056		 * The ceph_mds_request_head_legacy didn't contain a version field, and
  3057		 * one was added when we moved the message version from 3->4.
  3058		 */
  3059		if (legacy) {
  3060			msg->hdr.version = cpu_to_le16(3);
  3061			p = msg->front.iov_base + sizeof(*lhead);
  3062		} else if (request_head_version == 1) {
  3063			struct ceph_mds_request_head_old *ohead = msg->front.iov_base;
  3064	
  3065			msg->hdr.version = cpu_to_le16(4);
  3066			ohead->version = cpu_to_le16(1);
  3067			p = msg->front.iov_base + sizeof(*ohead);
  3068		} else if (request_head_version == 2) {
  3069			struct ceph_mds_request_head *nhead = msg->front.iov_base;
  3070	
  3071			msg->hdr.version = cpu_to_le16(6);
  3072			nhead->version = cpu_to_le16(2);
  3073	
  3074			p = msg->front.iov_base + offsetofend(struct ceph_mds_request_head, ext_num_fwd);
  3075		} else {
  3076			struct ceph_mds_request_head *nhead = msg->front.iov_base;
  3077			kuid_t owner_fsuid;
  3078			kgid_t owner_fsgid;
  3079	
  3080			msg->hdr.version = cpu_to_le16(6);
  3081			nhead->version = cpu_to_le16(CEPH_MDS_REQUEST_HEAD_VERSION);
> 3082			nhead->struct_len = sizeof(struct ceph_mds_request_head);
  3083	
  3084			owner_fsuid = from_vfsuid(req->r_mnt_idmap, &init_user_ns,
  3085						  VFSUIDT_INIT(req->r_cred->fsuid));
  3086			owner_fsgid = from_vfsgid(req->r_mnt_idmap, &init_user_ns,
  3087						  VFSGIDT_INIT(req->r_cred->fsgid));
  3088			nhead->owner_uid = cpu_to_le32(from_kuid(&init_user_ns, owner_fsuid));
  3089			nhead->owner_gid = cpu_to_le32(from_kgid(&init_user_ns, owner_fsgid));
  3090			p = msg->front.iov_base + sizeof(*nhead);
  3091		}
  3092	
  3093		end = msg->front.iov_base + msg->front.iov_len;
  3094	
  3095		lhead->mdsmap_epoch = cpu_to_le32(mdsc->mdsmap->m_epoch);
  3096		lhead->op = cpu_to_le32(req->r_op);
  3097		lhead->caller_uid = cpu_to_le32(from_kuid(&init_user_ns,
  3098							  req->r_cred->fsuid));
  3099		lhead->caller_gid = cpu_to_le32(from_kgid(&init_user_ns,
  3100							  req->r_cred->fsgid));
  3101		lhead->ino = cpu_to_le64(req->r_deleg_ino);
  3102		lhead->args = req->r_args;
  3103	
  3104		ceph_encode_filepath(&p, end, ino1, path1);
  3105		ceph_encode_filepath(&p, end, ino2, path2);
  3106	
  3107		/* make note of release offset, in case we need to replay */
  3108		req->r_request_release_offset = p - msg->front.iov_base;
  3109	
  3110		/* cap releases */
  3111		releases = 0;
  3112		if (req->r_inode_drop)
  3113			releases += ceph_encode_inode_release(&p,
  3114			      req->r_inode ? req->r_inode : d_inode(req->r_dentry),
  3115			      mds, req->r_inode_drop, req->r_inode_unless,
  3116			      req->r_op == CEPH_MDS_OP_READDIR);
  3117		if (req->r_dentry_drop) {
  3118			ret = ceph_encode_dentry_release(&p, req->r_dentry,
  3119					req->r_parent, mds, req->r_dentry_drop,
  3120					req->r_dentry_unless);
  3121			if (ret < 0)
  3122				goto out_err;
  3123			releases += ret;
  3124		}
  3125		if (req->r_old_dentry_drop) {
  3126			ret = ceph_encode_dentry_release(&p, req->r_old_dentry,
  3127					req->r_old_dentry_dir, mds,
  3128					req->r_old_dentry_drop,
  3129					req->r_old_dentry_unless);
  3130			if (ret < 0)
  3131				goto out_err;
  3132			releases += ret;
  3133		}
  3134		if (req->r_old_inode_drop)
  3135			releases += ceph_encode_inode_release(&p,
  3136			      d_inode(req->r_old_dentry),
  3137			      mds, req->r_old_inode_drop, req->r_old_inode_unless, 0);
  3138	
  3139		if (drop_cap_releases) {
  3140			releases = 0;
  3141			p = msg->front.iov_base + req->r_request_release_offset;
  3142		}
  3143	
  3144		lhead->num_releases = cpu_to_le16(releases);
  3145	
  3146		encode_mclientrequest_tail(&p, req);
  3147	
  3148		if (WARN_ON_ONCE(p > end)) {
  3149			ceph_msg_put(msg);
  3150			msg = ERR_PTR(-ERANGE);
  3151			goto out_free2;
  3152		}
  3153	
  3154		msg->front.iov_len = p - msg->front.iov_base;
  3155		msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
  3156	
  3157		if (req->r_pagelist) {
  3158			struct ceph_pagelist *pagelist = req->r_pagelist;
  3159			ceph_msg_data_add_pagelist(msg, pagelist);
  3160			msg->hdr.data_len = cpu_to_le32(pagelist->length);
  3161		} else {
  3162			msg->hdr.data_len = 0;
  3163		}
  3164	
  3165		msg->hdr.data_off = cpu_to_le16(0);
  3166	
  3167	out_free2:
  3168		if (freepath2)
  3169			ceph_mdsc_free_path((char *)path2, pathlen2);
  3170	out_free1:
  3171		if (freepath1)
  3172			ceph_mdsc_free_path((char *)path1, pathlen1);
  3173	out:
  3174		return msg;
  3175	out_err:
  3176		ceph_msg_put(msg);
  3177		msg = ERR_PTR(ret);
  3178		goto out_free2;
  3179	}
  3180	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
