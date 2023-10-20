Return-Path: <linux-fsdevel+bounces-807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CADD7D081A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 08:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE201C20D1C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 06:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9A2BE53;
	Fri, 20 Oct 2023 06:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AGsdPJ5R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F119B6112
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 06:07:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855C9126;
	Thu, 19 Oct 2023 23:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697782033; x=1729318033;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=QmnRmtauu7llxECxVGDOIuQ4umU6PdCC8bMlFkbOPzk=;
  b=AGsdPJ5RMp/V3SJBXsD4pow7qm5Zu8BPbRgejTMQbQOz0IOXtTzOI8rt
   bTc0dZRTW5t7Tl6M4lyV9m+ZeOzRB5M6s4CS9vLdDaCU9UC5FQN0W7wQr
   GfE32fxoDRGgX6oFY/I9hV4s7zxrSit94/ZiNVFwR9TTX80IiXsaOI9E6
   WtPLn6CV7jv0wolLglbaeE7B73JqvwojBo8xRxc26xpUlu+2+lC1mwVho
   Zgodll+j3TyfnIqz1Mb0Wpo8g70hshMhE9QfYZll1zwVPtosG91O2v4LR
   MfDXSyocYNgbuIbb8Xi3S1wIrokoZ1+7b0Wsjdiyz8/8AsrtwWj/ooS8s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="8000626"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="8000626"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 23:07:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="5283106"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 23:07:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 23:07:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 23:07:12 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 23:06:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nru9cV96/bw8iTkJs2V23DoH80A4kuK2yvWjQXX6qJssFpRJTrh0QJT+ZlDVa0rS0K9kG23jQzN+76ck5/0PCuEMb249PLlK2D0Gmo3YujKf1PKf4tmxsD7haCXDiARDETomNTpfbPNfGYWL5PmszIWdbwNA3sXkbOHvidLpZ/vpwMN+3QqT1TdK28zGESFLVV3XEVwUor9lspALchkx6/0GjOunfiRRwagC49tE9gX1twI79QWzMoPpajCvDis8H0Z7cvYL3G0iJEBgMz+oUZsslu/39ujyEJ5fWKdj8A89n10/0tMtjKqepI2gekrRCHtK7QBw1NsxFgA3ABflpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1URGM3KeJS0zub2VV915z26j0xAlu0l++wWPzuwy/g=;
 b=ZpwxdepPjNWjP0ReQx/eUUZQ5+hshZJEF8UZ3JzqUUkQ74nI1bg4P0WECrrpl5dQ3lNkmoaG/leIf9QOXmjcRv7yYcxdoqZYurgnh3JPQ97XCo0Pn8BbzIobCWn32ILEeEo1v9gkWqjrpQ8IBXYkn0sTJkLel//S7/Cv0LWZ60C3Ea8wKQkiHZ49ESzyuIx3b64bZb0Ag65Ax/g6FI7FPqrEih+R+eWWZtOyeVrKSfnFWT0w4PB4WsO2I0UHIuO/uOm/UhKU+4F+gCKGbj1SrTHCc7GKK144uGpMuR7jFYMHf/O3nOHWmWacizg8SXw+xzBW8OYpMUV9ees9QQv8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 06:06:41 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::134a:412c:eb02:ae17%5]) with mapi id 15.20.6863.046; Fri, 20 Oct 2023
 06:06:40 +0000
Date: Fri, 20 Oct 2023 14:06:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Alyssa Ross <hi@alyssa.is>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Eric Biederman
	<ebiederm@xmission.com>, <linux-kernel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] exec: allow executing block devices
Message-ID: <202310201132.ec34d76b-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231010092133.4093612-1-hi@alyssa.is>
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|IA1PR11MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0d4136-7043-464d-97d7-08dbd132ba31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MCdNEplHhNtpQlFNM+qSc1mvJQ2UKLYXdLXbGjuhL/LsZ2v71X7eFjwvf42UPozPI6UKuDoYfvn9R7dFnj35bOUTjmK5bdyOfkYDBJYXSaqQnGO6QOsVXjlvm29MI7zDQSWgQJBNt5yr3QW5rCcSV2YL/jbTzzlx1e6su23tz/GL1Tq+qGl0Rlixgual01w4MdeZoVMTxPyCrnIQ4VaWxpY/E3NlYC2Aaw9aYmbAjS47BX/tI2rA+RvmCT5r+oA5/8klG+ls9gvK+hpSoAXqeZmtWyA0zS20caHM1lM4WlXfUxapbSJxz+nkz0Y2J3gcsyjBYWqDTkA6e40hwDpQ57TZ6JpUzcmLSj/zIrHRw+QHtU5UgnLHOD+04lo0zonOE4kyM7G1X67YQFZr5vnI9vf81UJyOn9dPWRQpWhirU5YWkkuJSOKWDzud0aV328TEkw5uWXKAe6hNFAHV3ZXtNk6EaChHXxQ9ryYlzR7DM2Cc9mDE1D4jF3hnY3+p+ob+euQtQi+56g42USwD1ocCVJes4wm781SGst9TDbTPnw19vb1WBM/A+hv8B3zJfzdH56LOawSkFQlZ0FAqvfpFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(396003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(66476007)(6916009)(66946007)(66556008)(316002)(54906003)(8936002)(966005)(6666004)(6486002)(8676002)(478600001)(4326008)(41300700001)(36756003)(86362001)(83380400001)(7416002)(5660300002)(38100700002)(6506007)(26005)(107886003)(2616005)(6512007)(1076003)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GwTacHDcCtX6fr5wfSpWKDy8AReTWYQxnJQmQCm4FjfcvVqACtmS3v09frfv?=
 =?us-ascii?Q?k0bnI1qSaGTM0CgwiYkMe9KqMNUG7Sf1s/YeHwrfipjAoZYYSOTOUbquqmqk?=
 =?us-ascii?Q?7OK1wKs4aOkKWzacpWe0XnBhkMjPWLsvTs2Q5LsbQJk7sd8zgABBTmEt4VZQ?=
 =?us-ascii?Q?qjwUv4AdWBXMCFHgOb1os0pgV/RtUvvLuUa752jDSJuvBJBwngncLmFQHkRB?=
 =?us-ascii?Q?37Zy6uraQnqymzt/qWweakh0MXgH3eLzIU7f/Uh7Fvjo81N7k6o/x5vsOET+?=
 =?us-ascii?Q?pyeHeByEbflJmzMh8lXr+lWQ+oiOISdNAgrqZfMixC6CD/jUaZvGG6+nB3fU?=
 =?us-ascii?Q?bXHFsKmuW7nXdr/YzZpy7CIZ97WaEv2d2li6dXrlpLRgxjCgw3A89I7pFFkF?=
 =?us-ascii?Q?RHQw78nMcXbQkud0KeUEPrP0DFGR9hq5RgjwYNm04XX/tzZkhJ3wNEUrqAAv?=
 =?us-ascii?Q?Sd05VCBgBCeVNtYAVEDdvKQtEFwTrPEs2PqP6A321fwcygqmIiMIxF/EWk3i?=
 =?us-ascii?Q?l8MtRJ0UtJ4QucbH/+CX5ps0+FoL6mWWOGKl4AlyrFKT1KkNkZW6puYp1UY+?=
 =?us-ascii?Q?tWTp8dGEfz9fsrz6LdVFbX5m1iE5MDIlS6m4wxlo9vBx36D+BeMnMbZSTC69?=
 =?us-ascii?Q?cvdvwYvfJoWehAc5YOjycegnOtRzVkAuoQc8MXqwqeGNCl7sxtjkzkuZYxD+?=
 =?us-ascii?Q?EVQVIx2DvZV7WB2iPjZUbj83qqbI++nF2/8cPgMYcaUKpMjgidIJb+HX6GXq?=
 =?us-ascii?Q?1T1u1zI35VADOHFTYH9lR9BQgoBM2K5f16VcAtqrWBnUOBWAfL8Igr5rWnB/?=
 =?us-ascii?Q?GnVo13cxKg5w3J9z9AQLOkaoo68AoedZ93CrhQQj3xzyGSeti9N6QWhqXdcm?=
 =?us-ascii?Q?rEehvlkcRY4xyegGPHBLCnEF4jiucBushgbpBfGlavfcLsKQOBRZVb70z9Cx?=
 =?us-ascii?Q?c0AbVx1d/5SXO6FGzLKWcZNTXH34KK3NJmVWKPTFVrBRaaRr0jcvadTGve8I?=
 =?us-ascii?Q?GuaI8+wAhbda7wLuBW/RC1olBApbQOjXBSiYChzv+NN0b0V2Fu7CyvuZk3YF?=
 =?us-ascii?Q?dUysMUxpjF3Qq4N3fWauy7w3NzXLTeD3IE9vatZ7Z5zniBi8neYJxX1BW+hc?=
 =?us-ascii?Q?1zOUt1jguXOo40bBUnQE286h9xBUGUmPCzs1NxNX19j3ngc5fQqR8Yrtj9lj?=
 =?us-ascii?Q?AF2P81iImHlEgqhQBSkm1M57HUENtTQ7pbegBHo3dAlghT7IYTOOzmrWoDRp?=
 =?us-ascii?Q?omt8wm+27u5Zg4Zzn9Ta/xWiQHXqNx4cj/TMmFJPbCP/kdKe9jBZ7s3f4PRS?=
 =?us-ascii?Q?PVsK6oEcW+af6UMjzzdz9YKAF+QITmw/T3rpRdQMaw2R8CP4WNAA6T++math?=
 =?us-ascii?Q?1St8bPN1UCwtlhkCPT8YkcdijB1p3iGBIKWuVu7N3v5DCd4EdQBn9WeeYmLQ?=
 =?us-ascii?Q?UgEAfo33Hb9Q98t3GxSIGAgzqgtfZwtzImiaxPZc+LeOZB/ros8zKXlRd3NX?=
 =?us-ascii?Q?g/sApm7GYUxKOxCkb0PRnEpETzWSkdmlV0mC1QmQDKpGbK3/4vUjekcN99/z?=
 =?us-ascii?Q?ISk0Qq6eyy3ozAxJai9cVlw0gAEp8ZDENlCs5pRLyZ1eTd3shL0DoZo/M6L0?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0d4136-7043-464d-97d7-08dbd132ba31
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 06:06:40.8372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YYaslacSzQkh/Sy1wmC5kLrcdaBvwxfT+bZi8dDFGOzwb+W8ngjk7pQmlLAyMGQ+sEsa0lR9p/OtiG7f67PEww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7917
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "kernel-selftests.exec.non-regular.fail" on:

commit: f086dcc88a64a2022314af666bd15d64c6748d27 ("[PATCH] exec: allow executing block devices")
url: https://github.com/intel-lab-lkp/linux/commits/Alyssa-Ross/exec-allow-executing-block-devices/20231010-172704
patch link: https://lore.kernel.org/all/20231010092133.4093612-1-hi@alyssa.is/
patch subject: [PATCH] exec: allow executing block devices

in testcase: kernel-selftests
version: kernel-selftests-x86_64-60acb023-1_20230329
with following parameters:

	group: group-01



compiler: gcc-12
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310201132.ec34d76b-oliver.sang@intel.com



# timeout set to 300
# selftests: exec: non-regular
# TAP version 13
# 1..6
# # Starting 6 tests from 6 test cases.
# #  RUN           file.S_IFLNK.exec_errno ...
# #            OK  file.S_IFLNK.exec_errno
# ok 1 file.S_IFLNK.exec_errno
# #  RUN           file.S_IFDIR.exec_errno ...
# #            OK  file.S_IFDIR.exec_errno
# ok 2 file.S_IFDIR.exec_errno
# #  RUN           file.S_IFBLK.exec_errno ...
# # non-regular.c:166:exec_errno:Expected errno (6) == variant->expected (13)
# # exec_errno: Test failed at step #4
# #          FAIL  file.S_IFBLK.exec_errno
# not ok 3 file.S_IFBLK.exec_errno
# #  RUN           file.S_IFCHR.exec_errno ...
# #            OK  file.S_IFCHR.exec_errno
# ok 4 file.S_IFCHR.exec_errno
# #  RUN           file.S_IFIFO.exec_errno ...
# #            OK  file.S_IFIFO.exec_errno
# ok 5 file.S_IFIFO.exec_errno
# #  RUN           sock.exec_errno ...
# #            OK  sock.exec_errno
# ok 6 sock.exec_errno
# # FAILED: 5 / 6 tests passed.
# # Totals: pass:5 fail:1 xfail:0 xpass:0 skip:0 error:0
not ok 5 selftests: exec: non-regular # exit=1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231020/202310201132.ec34d76b-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


