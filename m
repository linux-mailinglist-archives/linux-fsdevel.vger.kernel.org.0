Return-Path: <linux-fsdevel+bounces-62728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18723B9F684
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 15:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9E8386243
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 13:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A793938DEC;
	Thu, 25 Sep 2025 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZaWOt+R+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFFC1FF1AD;
	Thu, 25 Sep 2025 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805544; cv=none; b=OnmbQX0ChA9bFNNbhAzRDDX9ke9e2fE2E+8mB0DsXN8oUqEYcqRghcGVqO6FBXoT1GdJl4RmLLEv1iBX4HPMDw6L3nyNr8s+9xo74M0oj0m/EfQQd6JEWqNYNPnJpO7jxbR6V0WblAnvi0saFDgpWFsiSjypCOZb3Rocr4nVZ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805544; c=relaxed/simple;
	bh=Gp4c6egSDZppUvv2xr9l0RgLesVaqe1pJuC3fuLHLQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keh7sLw1Aqb2kf9sGNtEXVRZ7JRwXFCQkj8A9nrg+GN74mpLcsmKKBR1DOegjRDD14BvR9Y0psrWZFhoqrNXDWlWjfPeSpoAm2S1g/piLmHipSf9Ac6rJbHhrWNTQV7Xkg+E5qOqCg2bMhUlBNLmnTxojOm+uNjU1kkUH+tthiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZaWOt+R+; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758805542; x=1790341542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Gp4c6egSDZppUvv2xr9l0RgLesVaqe1pJuC3fuLHLQs=;
  b=ZaWOt+R+vRlfJzTyDzmhz+/0ERE0Z8+bo9Y3BVeXqVEv6aeKk/HAlnW8
   zkPfjt7Dsee8d7GqQO0GDl7Z5e/6N2UgbOJorRrHSXQQGFF3B0cyKWCX4
   oifGDxLZl9VWtrTXk5BxHIbo/8NGMpBGz8qD2I9EFrDYblP3mDIpAy2Tx
   SxzZAmS3Xxbb2FzUjNtw4tECWfYZ2EYNW4ezwpL108I9BiFeQP2GXvz9+
   odCToJPpYoC+KZDdoQv9h/mh78pXRNHOCvjqVTqJgdTUytBI1C3U5Wp9j
   FkOtKaFf0JCbWpsxesj5RZUg+uG2LlQ/1ujHzq44PWP7VgU4tVTs4eVOi
   g==;
X-CSE-ConnectionGUID: jobh8eYaRb2vMZjL6sp0Hw==
X-CSE-MsgGUID: W9+zNA7mTuC5HxqoNKV9gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="72222912"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="72222912"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 06:05:41 -0700
X-CSE-ConnectionGUID: UdGNHChTSnyqdweHc6+WWg==
X-CSE-MsgGUID: SWWgNa2fQKOF8Kzeo62Yqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="214457447"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 25 Sep 2025 06:05:39 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1lfE-0005Ev-1N;
	Thu, 25 Sep 2025 13:05:36 +0000
Date: Thu, 25 Sep 2025 21:04:55 +0800
From: kernel test robot <lkp@intel.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com,
	amarkuze@redhat.com, Slava.Dubeyko@ibm.com, slava@dubeyko.com,
	vdubeyko@redhat.com
Subject: Re: [PATCH] ceph: introduce Kunit based unit-tests for string
 operations
Message-ID: <202509252015.tfuSHe3S-lkp@intel.com>
References: <20250919181149.500408-2-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919181149.500408-2-slava@dubeyko.com>

Hi Viacheslav,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ceph-client/testing]
[also build test WARNING on ceph-client/for-linus linus/master v6.17-rc7 next-20250924]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Viacheslav-Dubeyko/ceph-introduce-Kunit-based-unit-tests-for-string-operations/20250920-021357
base:   https://github.com/ceph/ceph-client.git testing
patch link:    https://lore.kernel.org/r/20250919181149.500408-2-slava%40dubeyko.com
patch subject: [PATCH] ceph: introduce Kunit based unit-tests for string operations
config: loongarch-randconfig-r133-20250925 (https://download.01.org/0day-ci/archive/20250925/202509252015.tfuSHe3S-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250925/202509252015.tfuSHe3S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509252015.tfuSHe3S-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> fs/ceph/strings_test.c:102:11: sparse: sparse: symbol 'ceph_str_idx_2_mds_state' was not declared. Should it be static?
>> fs/ceph/strings_test.c:247:11: sparse: sparse: symbol 'ceph_str_idx_2_mds_op' was not declared. Should it be static?
>> fs/ceph/strings_test.c:459:11: sparse: sparse: symbol 'ceph_str_idx_2_lease_op' was not declared. Should it be static?

vim +/ceph_str_idx_2_mds_state +102 fs/ceph/strings_test.c

   100	
   101	#define CEPH_MDS_STATE_STR_COUNT	(CEPH_MDS_STATE_UNKNOWN_NAME_STR_IDX)
 > 102	const int ceph_str_idx_2_mds_state[CEPH_MDS_STATE_STR_COUNT] = {
   103	/* 0 */		CEPH_MDS_STATE_DNE,
   104	/* 1 */		CEPH_MDS_STATE_STOPPED,
   105	/* 2 */		CEPH_MDS_STATE_BOOT,
   106	/* 3 */		CEPH_MDS_STATE_STANDBY,
   107	/* 4 */		CEPH_MDS_STATE_STANDBY_REPLAY,
   108	/* 5 */		CEPH_MDS_STATE_REPLAYONCE,
   109	/* 6 */		CEPH_MDS_STATE_CREATING,
   110	/* 7 */		CEPH_MDS_STATE_STARTING,
   111	/* 8 */		CEPH_MDS_STATE_REPLAY,
   112	/* 9 */		CEPH_MDS_STATE_RESOLVE,
   113	/* 10 */	CEPH_MDS_STATE_RECONNECT,
   114	/* 11 */	CEPH_MDS_STATE_REJOIN,
   115	/* 12 */	CEPH_MDS_STATE_CLIENTREPLAY,
   116	/* 13 */	CEPH_MDS_STATE_ACTIVE,
   117	/* 14 */	CEPH_MDS_STATE_STOPPING
   118	};
   119	
   120	static int ceph_mds_state_next_op(int prev)
   121	{
   122		if (prev < CEPH_MDS_STATE_REPLAYONCE)
   123			return CEPH_MDS_STATE_REPLAYONCE;
   124	
   125		/* [-9..-4] */
   126		if (prev >= CEPH_MDS_STATE_REPLAYONCE &&
   127		    prev < CEPH_MDS_STATE_BOOT)
   128			return prev + 1;
   129	
   130		/* [-4..-1] */
   131		if (prev == CEPH_MDS_STATE_BOOT)
   132			return CEPH_MDS_STATE_STOPPED;
   133	
   134		/* [-1..0] */
   135		if (prev >= CEPH_MDS_STATE_STOPPED &&
   136		    prev < CEPH_MDS_STATE_DNE)
   137			return prev + 1;
   138	
   139		/* [0..8] */
   140		if (prev == CEPH_MDS_STATE_DNE)
   141			return CEPH_MDS_STATE_REPLAY;
   142	
   143		/* [8..14] */
   144		if (prev >= CEPH_MDS_STATE_REPLAY &&
   145		    prev < CEPH_MDS_STATE_STOPPING)
   146			return prev + 1;
   147	
   148		return CEPH_MDS_STATE_STOPPING;
   149	}
   150	
   151	static void ceph_mds_state_name_test(struct kunit *test)
   152	{
   153		const char *unknown_name =
   154			ceph_mds_state_name_strings[CEPH_MDS_STATE_UNKNOWN_NAME_STR_IDX];
   155		struct ceph_op_iterator iter;
   156		int start, end;
   157		int i;
   158	
   159		/* Test valid MDS states */
   160		for (i = 0; i < CEPH_MDS_STATE_STR_COUNT; i++) {
   161			KUNIT_EXPECT_STREQ(test,
   162				   ceph_mds_state_name(ceph_str_idx_2_mds_state[i]),
   163				   ceph_mds_state_name_strings[i]);
   164		}
   165	
   166		/* Test invalid/unknown states */
   167		start = CEPH_MDS_STATE_REPLAYONCE - CEPH_KUNIT_STRINGS_TEST_RANGE;
   168		end = CEPH_MDS_STATE_STOPPING + CEPH_KUNIT_STRINGS_TEST_RANGE;
   169		ceph_op_iterator_init(&iter, start, end, ceph_mds_state_next_op);
   170	
   171		while (ceph_op_iterator_valid(&iter)) {
   172			switch (ceph_mds_state_2_str_idx(iter.cur)) {
   173			case CEPH_MDS_STATE_UNKNOWN_NAME_STR_IDX:
   174				KUNIT_EXPECT_STREQ(test,
   175						   ceph_mds_state_name(iter.cur),
   176						   unknown_name);
   177				break;
   178	
   179			default:
   180				/* do nothing */
   181				break;
   182			}
   183	
   184			ceph_op_iterator_next(&iter);
   185		}
   186	
   187		KUNIT_EXPECT_STREQ(test,
   188				   ceph_mds_state_name(CEPH_KUNIT_OP_INVALID_MIN),
   189				   unknown_name);
   190		KUNIT_EXPECT_STREQ(test,
   191				   ceph_mds_state_name(CEPH_KUNIT_OP_INVALID_MAX),
   192				   unknown_name);
   193	}
   194	
   195	static int ceph_session_next_op(int prev)
   196	{
   197		return __ceph_next_op(prev,
   198				      CEPH_SESSION_REQUEST_OPEN,
   199				      CEPH_SESSION_REQUEST_FLUSH_MDLOG);
   200	}
   201	
   202	static void ceph_session_op_name_test(struct kunit *test)
   203	{
   204		const char *unknown_name =
   205				ceph_session_op_name_strings[CEPH_SESSION_UNKNOWN_NAME];
   206		struct ceph_op_iterator iter;
   207		int start, end;
   208		int i;
   209	
   210		/* Test valid session operations */
   211		for (i = CEPH_SESSION_REQUEST_OPEN; i < CEPH_SESSION_UNKNOWN_NAME; i++) {
   212			KUNIT_EXPECT_STREQ(test,
   213					   ceph_session_op_name(i),
   214					   ceph_session_op_name_strings[i]);
   215		}
   216	
   217		/* Test invalid/unknown operations */
   218		start = CEPH_SESSION_REQUEST_OPEN - CEPH_KUNIT_STRINGS_TEST_RANGE;
   219		end = CEPH_SESSION_REQUEST_FLUSH_MDLOG + CEPH_KUNIT_STRINGS_TEST_RANGE;
   220		ceph_op_iterator_init(&iter, start, end, ceph_session_next_op);
   221	
   222		while (ceph_op_iterator_valid(&iter)) {
   223			switch (ceph_session_op_2_str_idx(iter.cur)) {
   224			case CEPH_SESSION_UNKNOWN_NAME:
   225				KUNIT_EXPECT_STREQ(test,
   226						   ceph_session_op_name(iter.cur),
   227						   unknown_name);
   228				break;
   229	
   230			default:
   231				/* do nothing */
   232				break;
   233			}
   234	
   235			ceph_op_iterator_next(&iter);
   236		}
   237	
   238		KUNIT_EXPECT_STREQ(test,
   239				   ceph_session_op_name(CEPH_KUNIT_OP_INVALID_MIN),
   240				   unknown_name);
   241		KUNIT_EXPECT_STREQ(test,
   242				   ceph_session_op_name(CEPH_KUNIT_OP_INVALID_MAX),
   243				   unknown_name);
   244	}
   245	
   246	#define CEPH_MDS_OP_STR_COUNT	(CEPH_MDS_OP_UNKNOWN_NAME_STR_IDX)
 > 247	const int ceph_str_idx_2_mds_op[CEPH_MDS_OP_STR_COUNT] = {
   248	/* 0 */		CEPH_MDS_OP_LOOKUP,
   249	/* 1 */		CEPH_MDS_OP_GETATTR,
   250	/* 2 */		CEPH_MDS_OP_LOOKUPHASH,
   251	/* 3 */		CEPH_MDS_OP_LOOKUPPARENT,
   252	/* 4 */		CEPH_MDS_OP_LOOKUPINO,
   253	/* 5 */		CEPH_MDS_OP_LOOKUPNAME,
   254	/* 6 */		CEPH_MDS_OP_GETVXATTR,
   255	/* 7 */		CEPH_MDS_OP_SETXATTR,
   256	/* 8 */		CEPH_MDS_OP_RMXATTR,
   257	/* 9 */		CEPH_MDS_OP_SETLAYOUT,
   258	/* 10 */	CEPH_MDS_OP_SETATTR,
   259	/* 11 */	CEPH_MDS_OP_SETFILELOCK,
   260	/* 12 */	CEPH_MDS_OP_GETFILELOCK,
   261	/* 13 */	CEPH_MDS_OP_SETDIRLAYOUT,
   262	/* 14 */	CEPH_MDS_OP_MKNOD,
   263	/* 15 */	CEPH_MDS_OP_LINK,
   264	/* 16 */	CEPH_MDS_OP_UNLINK,
   265	/* 17 */	CEPH_MDS_OP_RENAME,
   266	/* 18 */	CEPH_MDS_OP_MKDIR,
   267	/* 19 */	CEPH_MDS_OP_RMDIR,
   268	/* 20 */	CEPH_MDS_OP_SYMLINK,
   269	/* 21 */	CEPH_MDS_OP_CREATE,
   270	/* 22 */	CEPH_MDS_OP_OPEN,
   271	/* 23 */	CEPH_MDS_OP_READDIR,
   272	/* 24 */	CEPH_MDS_OP_LOOKUPSNAP,
   273	/* 25 */	CEPH_MDS_OP_MKSNAP,
   274	/* 26 */	CEPH_MDS_OP_RMSNAP,
   275	/* 27 */	CEPH_MDS_OP_LSSNAP,
   276	/* 28 */	CEPH_MDS_OP_RENAMESNAP
   277	};
   278	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

