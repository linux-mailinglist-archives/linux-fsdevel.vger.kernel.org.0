Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3468D4BF079
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Feb 2022 05:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbiBVDRV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 22:17:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiBVDRU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 22:17:20 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B95F73;
        Mon, 21 Feb 2022 19:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645499815; x=1677035815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Pb8e2G+GuH8BcVicwGHPqL0koQdXd5XV3os9pLa+pGY=;
  b=c2J1p921pyeZq7W1ZJcTPPdvvyKMSa1NBjCgoO/728S7T9A76GxNiSZH
   dSmurQNemHmoxUmDkbh0VPlw6WuV/e20MWlcCyE1EHJNkYKdjhtAKlv/R
   9VZI5jU6ObyWkgXJyMRnHcAR2Gf74t0v1Bd7PPvsnqh67PQb0KnjBo9dM
   2r7LGic3ntMO+Ze0mCRchlQ7IJonr5QxckhrXNFZ9TX6B/sqNxkoIx5gi
   RnBZYR/UfEtvAgH/EDLLfMivN+rD/eDA5pQ7iIzy24WiALrBlXXOAr1Da
   c+ROSkndjQRRfSJ3p9k5TVlmpZUh+EQE9uI6C65CdJokAyY6cS+GZQl3A
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="249181597"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="249181597"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 19:16:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="683361065"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2022 19:16:49 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMLfV-0002Gw-5s; Tue, 22 Feb 2022 03:16:49 +0000
Date:   Tue, 22 Feb 2022 11:16:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 06/11] landlock: Add support for file reparenting with
 LANDLOCK_ACCESS_FS_REFER
Message-ID: <202202221149.qLO9DEqo-lkp@intel.com>
References: <20220221212522.320243-7-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220221212522.320243-7-mic@digikod.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi "Mickaël,

I love your patch! Yet something to improve:

[auto build test ERROR on cfb92440ee71adcc2105b0890bb01ac3cddb8507]

url:    https://github.com/0day-ci/linux/commits/Micka-l-Sala-n/Landlock-file-linking-and-renaming-support/20220222-051842
base:   cfb92440ee71adcc2105b0890bb01ac3cddb8507
config: hexagon-randconfig-r002-20220221 (https://download.01.org/0day-ci/archive/20220222/202202221149.qLO9DEqo-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c68b879f54d6262963d435a18cedbc238b7faeaf
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Micka-l-Sala-n/Landlock-file-linking-and-renaming-support/20220222-051842
        git checkout c68b879f54d6262963d435a18cedbc238b7faeaf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> security/landlock/fs.c:463:2: error: call to __compiletime_assert_228 declared with 'error' attribute: BUILD_BUG_ON failed: !layer_masks_dst_parent
           BUILD_BUG_ON(!layer_masks_dst_parent);
           ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
           BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:346:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:334:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:327:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:170:1: note: expanded from here
   __compiletime_assert_228
   ^
>> security/landlock/fs.c:670:2: error: call to __compiletime_assert_229 declared with 'error' attribute: BUILD_BUG_ON failed: !layer_masks_dom
           BUILD_BUG_ON(!layer_masks_dom);
           ^
   include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
           BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
           ^
   include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
   #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
                                       ^
   include/linux/compiler_types.h:346:2: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ^
   include/linux/compiler_types.h:334:2: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ^
   include/linux/compiler_types.h:327:4: note: expanded from macro '__compiletime_assert'
                           prefix ## suffix();                             \
                           ^
   <scratch space>:174:1: note: expanded from here
   __compiletime_assert_229
   ^
   2 errors generated.


vim +/error +463 security/landlock/fs.c

   401	
   402	/**
   403	 * check_access_path_dual - Check a source and a destination accesses
   404	 *
   405	 * @domain: Domain to check against.
   406	 * @path: File hierarchy to walk through.
   407	 * @child_is_directory: Must be set to true if the (original) leaf is a
   408	 *     directory, false otherwise.
   409	 * @access_request_dst_parent: Accesses to check, once @layer_masks_dst_parent
   410	 *     is equal to @layer_masks_src_parent (if any).
   411	 * @layer_masks_dst_parent: Pointer to a matrix of layer masks per access
   412	 *     masks, identifying the layers that forbid a specific access.  Bits from
   413	 *     this matrix can be unset according to the @path walk.  An empty matrix
   414	 *     means that @domain allows all possible Landlock accesses (i.e. not only
   415	 *     those identified by @access_request_dst_parent).  This matrix can
   416	 *     initially refer to domain layer masks and, when the accesses for the
   417	 *     destination and source are the same, to request layer masks.
   418	 * @access_request_src_parent: Similar to @access_request_dst_parent but for an
   419	 *     initial source path request.  Only taken into account if
   420	 *     @layer_masks_src_parent is not NULL.
   421	 * @layer_masks_src_parent: Similar to @layer_masks_dst_parent but for an
   422	 *     initial source path walk.  This can be NULL if only dealing with a
   423	 *     destination access request (i.e. not a rename nor a link action).
   424	 * @layer_masks_child: Similar to @layer_masks_src_parent but only for the
   425	 *     linked or renamed inode (without hierarchy).  This is only used if
   426	 *     @layer_masks_src_parent is not NULL.
   427	 *
   428	 * This helper first checks that the destination has a superset of restrictions
   429	 * compared to the source (if any) for a common path.  It then checks that the
   430	 * collected accesses and the remaining ones are enough to allow the request.
   431	 *
   432	 * Returns:
   433	 * - 0 if the access request is granted;
   434	 * - -EACCES if it is denied because of access right other than
   435	 *   LANDLOCK_ACCESS_FS_REFER;
   436	 * - -EXDEV if the renaming or linking would be a privileged escalation
   437	 *   (according to each layered policies), or if LANDLOCK_ACCESS_FS_REFER is
   438	 *   not allowed by the source or the destination.
   439	 */
   440	static int check_access_path_dual(const struct landlock_ruleset *const domain,
   441			const struct path *const path,
   442			bool child_is_directory,
   443			const access_mask_t access_request_dst_parent,
   444			layer_mask_t (*const
   445				layer_masks_dst_parent)[LANDLOCK_NUM_ACCESS_FS],
   446			const access_mask_t access_request_src_parent,
   447			layer_mask_t (*layer_masks_src_parent)[LANDLOCK_NUM_ACCESS_FS],
   448			layer_mask_t (*layer_masks_child)[LANDLOCK_NUM_ACCESS_FS])
   449	{
   450		bool allowed_dst_parent = false, allowed_src_parent = false, is_dom_check;
   451		struct path walker_path;
   452		access_mask_t access_masked_dst_parent, access_masked_src_parent;
   453	
   454		if (!access_request_dst_parent && !access_request_src_parent)
   455			return 0;
   456		if (WARN_ON_ONCE(!domain || !path))
   457			return 0;
   458		if (is_nouser_or_private(path->dentry))
   459			return 0;
   460		if (WARN_ON_ONCE(domain->num_layers < 1))
   461			return -EACCES;
   462	
 > 463		BUILD_BUG_ON(!layer_masks_dst_parent);
   464		if (layer_masks_src_parent) {
   465			if (WARN_ON_ONCE(!layer_masks_child))
   466				return -EACCES;
   467			access_masked_dst_parent = access_masked_src_parent =
   468				get_handled_accesses(domain);
   469			is_dom_check = true;
   470		} else {
   471			if (WARN_ON_ONCE(layer_masks_child))
   472				return -EACCES;
   473			access_masked_dst_parent = access_request_dst_parent;
   474			access_masked_src_parent = access_request_src_parent;
   475			is_dom_check = false;
   476		}
   477	
   478		walker_path = *path;
   479		path_get(&walker_path);
   480		/*
   481		 * We need to walk through all the hierarchy to not miss any relevant
   482		 * restriction.
   483		 */
   484		while (true) {
   485			struct dentry *parent_dentry;
   486			const struct landlock_rule *rule;
   487	
   488			/*
   489			 * If at least all accesses allowed on the destination are
   490			 * already allowed on the source, respectively if there is at
   491			 * least as much as restrictions on the destination than on the
   492			 * source, then we can safely refer files from the source to
   493			 * the destination without risking a privilege escalation.
   494			 * This is crucial for standalone multilayered security
   495			 * policies.  Furthermore, this helps avoid policy writers to
   496			 * shoot themselves in the foot.
   497			 */
   498			if (is_dom_check && is_superset(child_is_directory,
   499						layer_masks_dst_parent,
   500						layer_masks_src_parent,
   501						layer_masks_child)) {
   502				allowed_dst_parent =
   503					scope_to_request(access_request_dst_parent,
   504							layer_masks_dst_parent);
   505				allowed_src_parent =
   506					scope_to_request(access_request_src_parent,
   507							layer_masks_src_parent);
   508	
   509				/* Stops when all accesses are granted. */
   510				if (allowed_dst_parent && allowed_src_parent)
   511					break;
   512	
   513				/*
   514				 * Downgrades checks from domain handled accesses to
   515				 * requested accesses.
   516				 */
   517				is_dom_check = false;
   518				access_masked_dst_parent = access_request_dst_parent;
   519				access_masked_src_parent = access_request_src_parent;
   520			}
   521	
   522			rule = find_rule(domain, walker_path.dentry);
   523			allowed_dst_parent = unmask_layers(rule, access_masked_dst_parent,
   524					layer_masks_dst_parent);
   525			allowed_src_parent = unmask_layers(rule, access_masked_src_parent,
   526					layer_masks_src_parent);
   527	
   528			/* Stops when a rule from each layer grants access. */
   529			if (allowed_dst_parent && allowed_src_parent)
   530				break;
   531	
   532	jump_up:
   533			if (walker_path.dentry == walker_path.mnt->mnt_root) {
   534				if (follow_up(&walker_path)) {
   535					/* Ignores hidden mount points. */
   536					goto jump_up;
   537				} else {
   538					/*
   539					 * Stops at the real root.  Denies access
   540					 * because not all layers have granted access.
   541					 */
   542					allowed_dst_parent = false;
   543					break;
   544				}
   545			}
   546			if (unlikely(IS_ROOT(walker_path.dentry))) {
   547				/*
   548				 * Stops at disconnected root directories.  Only allows
   549				 * access to internal filesystems (e.g. nsfs, which is
   550				 * reachable through /proc/<pid>/ns/<namespace>).
   551				 */
   552				allowed_dst_parent = !!(walker_path.mnt->mnt_flags &
   553						MNT_INTERNAL);
   554				break;
   555			}
   556			parent_dentry = dget_parent(walker_path.dentry);
   557			dput(walker_path.dentry);
   558			walker_path.dentry = parent_dentry;
   559		}
   560		path_put(&walker_path);
   561	
   562		if (allowed_dst_parent && allowed_src_parent)
   563			return 0;
   564	
   565		/*
   566		 * Unfortunately, we cannot prioritize EACCES over EXDEV for all
   567		 * RENAME_EXCHANGE cases because it depends on the source and
   568		 * destination order.  This could be changed with a new
   569		 * security_path_rename hook implementation.
   570		 */
   571		if (likely(is_eacces(layer_masks_dst_parent, access_request_dst_parent)
   572					|| is_eacces(layer_masks_src_parent,
   573						access_request_src_parent)))
   574			return -EACCES;
   575	
   576		/*
   577		 * Gracefully forbids reparenting if the destination directory
   578		 * hierarchy is not a superset of restrictions of the source directory
   579		 * hierarchy, or if LANDLOCK_ACCESS_FS_REFER is not allowed by the
   580		 * source or the destination.
   581		 */
   582		return -EXDEV;
   583	}
   584	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
