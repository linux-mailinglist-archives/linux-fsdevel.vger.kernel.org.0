Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F135610754
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 03:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbiJ1Bhu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Oct 2022 21:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbiJ1Bhs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Oct 2022 21:37:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3239F769;
        Thu, 27 Oct 2022 18:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666921067; x=1698457067;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=9ivB8YN/A0hiycVN1sAG0pgWfkwvRcoqpeQraBf95iU=;
  b=V8fM/uPezkVbPUn0unlTUON64Zl+P8qqZQEE/aqQ68khEpsfvM/Kr3Xn
   Mjrgv/dVmxu1Kq5/aTTFw0Al+3RsaMBWQ2SW49VJVmvSfMyEYkp+dEsnU
   6QVF2FQXaJiANrXBL4LwmlZmcMbcZOY3nvxqVJTvUptgfbpghteVNKT9X
   uN9J7qzQD9Mi2l0LKtHNuqGjCi11K5AJ9Yn7P9NhGBNwhve9KJd7/G8rl
   Ka88N4ALMa7KCKoxDJi5/OPHEEIQbBQYQxfbULj5hFzaT01z1cfavNu8l
   cBp9C8idbzuDGTmz0EegY50wYXga6Q+qqdxVz8Nt/63itfB7dBqBFNMoj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="310081654"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="310081654"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 18:37:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="807660484"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="807660484"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga005.jf.intel.com with ESMTP; 27 Oct 2022 18:37:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 18:37:44 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 18:37:43 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 27 Oct 2022 18:37:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 27 Oct 2022 18:37:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F62tZMB2lOvnSCa9F/XHpROHR03G+4AppPu7jSZEhfzhZbPUa270F3h8Pmdeqw0EpXjirIlYz4qysmSeuHsI725C5LQxRg12HIKjlenvRxzeyc5Brlm42CYeMflEY4WEGVXLwTs+4qh6SFpeqkcS8s7OqWEJrqIKtz58ovErECJFmgjSDfxMIPtWLZ+PdipWPQiHOiDeiuHPZuSmgAx0nx6YY1cLq6EAB+Zd/CsdvrOP27+v+o/lHQnZyAIFrOpCo5zuV3650B3LWhVxVdjPAQby4dUtx61nZaES5xAxmhBmgmlhoW2abcVWzlLtFNYihp7Uhyw+6zOC8Xym9K4inw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sun02OU3VntsF69xRRs5kXnWQOMDmvz5BV56uijxuJA=;
 b=L84sd9mUq5EacTs58znSlfMrI4R5YeOBegyp6c60EyIp8qiNVMmE5+PTAuIYM8ZASIspEFr4apZnQS4ErhJUP57gFa1XFHthaVPZadcwcrR+8JiP+ep7j4A0N3uZD4O/ZH5Q19E8T7YU8PHSbdJ8g73p+15y3zJ+OTueq6wn42+VV0JzB4PzYhaVTAHKPOrNv6oz8+b//jvZxV7+jX8PXbYCl5hhV/mqs1WsPmdSsREJ1Jn+3gX8JsQKSr5dql0cGkhtSbLtU2IVi55fJZwYpFGzBLcOACz4ZNy/jhFPXHNikV2YfVOblWRQl0Rs/2mV/WIb3z/1vbclTzhmyi31kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4724.namprd11.prod.outlook.com
 (2603:10b6:5:2ad::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 01:37:36 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.023; Fri, 28 Oct
 2022 01:37:36 +0000
Date:   Thu, 27 Oct 2022 18:37:33 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
CC:     Dave Chinner <david@fromorbit.com>,
        "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        Brian Foster <bfoster@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "toshi.kani@hpe.com" <toshi.kani@hpe.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Message-ID: <635b325d25889_6be129446@dwillia2-xfh.jf.intel.com.notmuch>
References: <f196bcab-6aa2-6313-8a7c-f8ab409621b7@fujitsu.com>
 <Yzx64zGt2kTiDYaP@magnolia>
 <6a83a56e-addc-f3c4-2357-9589a49bf582@fujitsu.com>
 <Y1NRNtToQTjs0Dbd@magnolia>
 <20221023220018.GX3600936@dread.disaster.area>
 <OSBPR01MB2920CA997DDE891C06776279F42E9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <20221024053109.GY3600936@dread.disaster.area>
 <dd00529c-d3ef-40e3-9dea-834c5203e3df@fujitsu.com>
 <Y1gjQ4wNZr3ve2+K@magnolia>
 <Y1rzZN0wgLcie47z@magnolia>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y1rzZN0wgLcie47z@magnolia>
X-ClientProxiedBy: BY3PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:a03:255::31) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|DM6PR11MB4724:EE_
X-MS-Office365-Filtering-Correlation-Id: ddb00ee4-d898-42cd-2289-08dab884fde9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tizIrgwnhXDWqhz4bX2FCuDtvSky/MGbUGL8dB/gjC8jUviEVY0nNrH+ZkYocaOWlun/lGYd6QnN4HqOSPhjkr6noc77Q9EVi6TCOPjuG1PjvXE+JLU6Spax2FZeohBSFFD+k4YMl9S9Hu5eau9hXWQTzTB5Exo4VBsjBrr32E5Tm+6px7XMyrDR1XPuP8sspewsuzcFBfo7YDyxcOweVWRQbywPcP10X03S8eN4QCf7gANmOJ4nxPmNM02cOoA1xtmUrtSee3b6V/RcFzxQDykd7pYoQ48CkE/7gp21C8bwhe4TNE8f8ewYKpgYuS2YLYLeFkKpcG1fnNsMqmJ/iTJqPCAI4miMkH5ySQDzaTIT9hz1Kfp/bIV3vqhH3zP9j3EZFwlD8ILbnkv8drKspDuMq7COXU6VcfVmAp3r3Pwr+R+mDPwnFMsKskobEMS9tA5kCq3FPrnFGjyVCsPeitLBOMJu3mDibbpYtJx/cAFySQljGZwBgX/9awsnfw6oBCWr92eVjLeq3q51LgmK/wUpyR+b9gab3/WcENk2q1ucdpbSF/mM89JZEtM8J/UrmFpUMshpyeDDb61eD3R9/34xFMzScDCIWDiQLridAI9C2+v+Jc79Z67ULdwkS7gs95eSRpG6wAumvuPyNiB0kFrIzo+v6OBONl6p4TxtLG6Y2ZPJhFLZfRjakIaPebCPBcXGbz3KRx2qBD2fG897Z/q0Cbu/Agr3dusVWcNKRuMm7i91efw2O4wiT47PK2ftd45kMG8qksNLpRrtstjhYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199015)(66556008)(316002)(38100700002)(41300700001)(83380400001)(6666004)(86362001)(54906003)(110136005)(66946007)(5660300002)(26005)(6512007)(2906002)(186003)(4326008)(7416002)(8936002)(6506007)(9686003)(8676002)(66476007)(478600001)(966005)(6486002)(66899015)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXlhT0ZabC9XNWNOVGpnYjRSemRIK21XeXpObk9ScHczbWpqeWw4VElRV1da?=
 =?utf-8?B?aktUMWlveklPTFZIUUlQZ1J3SEJTcmZMM2pyNWVJeWcyMVFQYnoweTI2VkRH?=
 =?utf-8?B?V2lvOXVVYnRhWm81UWxkNG8xZUF5WkgvRlo3bWhBT016ZTV3dGhOSFhIcTBL?=
 =?utf-8?B?eG13cGVCdnR2WkJKWVpJMUtna0lYenFYYmtsOHVNOXQwTkphZS9nelFFZ3lw?=
 =?utf-8?B?b2RSbEVkR285UzVKclB1L2Q2RXdPTEVLbkZhM0ZpS01nNGZUdEUyUWNsM0Zo?=
 =?utf-8?B?SXJKdnVVcUZHUFNLMThiYzRLdTV5NzNENFVGdEJTQ1B4ZnJJQ01QOHVPK1By?=
 =?utf-8?B?anY3VEpDSFN2Y3RJQ2VTVTU2RlhnRjBUWGlNV2lSaVFnc1l0YUgvM1ozQ2Fw?=
 =?utf-8?B?S1BLTno3eUZQTGJadExjd2NGb3VtamZjSlZ1WndtZ1hMcksxTDBvcE1XME56?=
 =?utf-8?B?cFVpMjZkWTBkekh5RXRYOUhrUW1UdGx2NG1lSU5SeGk3OG00OENKM1pydTJX?=
 =?utf-8?B?T1BONldOOHdhMmdDeFhMTThYRVFsNTMyUktOSzdpenNyNk5DcnJYSkNrWWs2?=
 =?utf-8?B?OTRtN21PM0VvVW5Ecm1abVFSWkNVdStBWlBPdFY0Y2htblp6UlM4TktqT1VF?=
 =?utf-8?B?citZWXJ6TzI1YVVGNTJsQXJhWURjV05icE45blN0R1YxaXNLSk5XejFWdGVj?=
 =?utf-8?B?UER6cWIwaGpJdWVRSjhMaEZUa3lUZVQ5aXZEMTloNVFLSWh0ZWkxTHF5dWRO?=
 =?utf-8?B?T21veTBVK0xCOS81V3dNWFlySS9qVE0vZTU4cEk2TXpWdVFTQTZaLzBYaCt4?=
 =?utf-8?B?TXFhOW5IK21NbU9PRXBJZDBkN3ZyZHFqeFJOOGEyZm9rVjllZzZKanRvQnNF?=
 =?utf-8?B?MGdxaEZ2VldMOTl2V25SdXk5NDdxT2xJZkxPUXlRa2k0WWRLa2FTUjNqekQ1?=
 =?utf-8?B?cS92SXJENnRlcUpiRFNjWFp4N2VLT3VKVy95b1ozVVM5dWN2ZmpWMlgvSzVp?=
 =?utf-8?B?SjRCcDVvOHFiVlpoNTY1K21GeVl0c1RzRVRuZnpCQWFzeWtyNTZwYi9BZ1Bj?=
 =?utf-8?B?amErZk44TEprSm1vSmkvMEpONm45UFZkcHh2K3hRa2s3YzZIMUozRHNQR1RJ?=
 =?utf-8?B?bmNyMFgrejBMcFpyM2poRE1PMG8wZWFjQ1FFeGtQTUF0eHNybDFxYmdYenNW?=
 =?utf-8?B?akZQZllEMjR1cjJaMXFrQnQ0RlUxYi9XQjdGQjh2SVo5bFlzV3J4cktaVnpJ?=
 =?utf-8?B?WFhJcEZraC8weXROdDQrZ3J6US83VmR2U0g4MFB2K2xneC9vdWEvbFdsMmVQ?=
 =?utf-8?B?Z0k1ZHVUUHhSaDlVTlBHT1d2SURWRzR2ZmQwdzNUS1ZZTDhpUmdWdDllVHpl?=
 =?utf-8?B?bGRuN1JscFNCZzlXakNEOXBBYXNXWG1pSkNTY05ieVNPU210cFRyc0VkeXJ5?=
 =?utf-8?B?S3orNUlGU2VsZWtWd1VoQlRlSllKQ1lZNENYOVpjMTRFclRsQ2Q1MmNNLzI4?=
 =?utf-8?B?UFh2TjhSQmp4WlhpUURPemtoSVYwRThJU01ZWWI3eDJ6Nm95djRUWDdadUZl?=
 =?utf-8?B?aE93UFBqQVZQZ25wZ1ZQK3hrdWFGbSt5ZVNJV1Bwbks4YXZUc2ZQN2J0OGhO?=
 =?utf-8?B?SUQ2RkYrK1U3R1NoVmlUd2lYWUF0VXFmQUpJVnBpMkdTcFV1TjF0Rmh3Y1Ex?=
 =?utf-8?B?OUlWdytlMzZJeTQ2NWIrNHZuV202OWl5UzM4ZlUzdHIyalIzcGNtNlVsQVhJ?=
 =?utf-8?B?U1lJWFY3SC8rend3UFdJNWNaTlRad1pFdFpBRWhkOEsyM2VaMGF1NHpSTmpF?=
 =?utf-8?B?TExSWS9nK3RjL05GTmorbnNnUTJnUzY0MndqQWlDckFuYWN2WEpIdUVSZzRn?=
 =?utf-8?B?K2ppamdMQWxsVi9QclJoZDhRSGNCckwvbjFrRWRTYVBVN2o3SVkyYk9CYjkz?=
 =?utf-8?B?Y0YrcW9kMFczbDRoNlptUmdVSE9wV3l3VmZRclE2TFY0WXYyclB0Q2tXd1NQ?=
 =?utf-8?B?TlVJWXJIbGpKMnBJYTF5V25tYmMwY01BcnZ5Z21IMC95TkZVTWxxS0R5d0FS?=
 =?utf-8?B?TER3dStPRkVTdEdoRUpkbVNpaE9DSEI5YS9IMjRnNjVpdzFDVVdYbnVDQkZB?=
 =?utf-8?B?NmhQdlg5aWt5bndQYjFMYVo2ampWZUg2YUNIeGoxZjhGZVB6U1Z0UkRqMDBV?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb00ee4-d898-42cd-2289-08dab884fde9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 01:37:36.4579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9TNKJ+HZQkeJ0CUxUHeA70N4rSe8+3/AmqzuxsnJj/dtadjNQOf7gSER9BrOaGI59Mu2tx1R24S3HOyLKHrE0zADRitPKKNBkjffXC2OkTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4724
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Darrick J. Wong wrote:
> [add tytso to cc since he asked about "How do you actually /get/ fsdax
> mode these days?" this morning]
> 
> On Tue, Oct 25, 2022 at 10:56:19AM -0700, Darrick J. Wong wrote:
> > On Tue, Oct 25, 2022 at 02:26:50PM +0000, ruansy.fnst@fujitsu.com wrote:
> > > 
> > > 
> > > 在 2022/10/24 13:31, Dave Chinner 写道:
> > > > On Mon, Oct 24, 2022 at 03:17:52AM +0000, ruansy.fnst@fujitsu.com wrote:
> > > >> 在 2022/10/24 6:00, Dave Chinner 写道:
> > > >>> On Fri, Oct 21, 2022 at 07:11:02PM -0700, Darrick J. Wong wrote:
> > > >>>> On Thu, Oct 20, 2022 at 10:17:45PM +0800, Yang, Xiao/杨 晓 wrote:
> > > >>>>> In addition, I don't like your idea about the test change because it will
> > > >>>>> make generic/470 become the special test for XFS. Do you know if we can fix
> > > >>>>> the issue by changing the test in another way? blkdiscard -z can fix the
> > > >>>>> issue because it does zero-fill rather than discard on the block device.
> > > >>>>> However, blkdiscard -z will take a lot of time when the block device is
> > > >>>>> large.
> > > >>>>
> > > >>>> Well we /could/ just do that too, but that will suck if you have 2TB of
> > > >>>> pmem. ;)
> > > >>>>
> > > >>>> Maybe as an alternative path we could just create a very small
> > > >>>> filesystem on the pmem and then blkdiscard -z it?
> > > >>>>
> > > >>>> That said -- does persistent memory actually have a future?  Intel
> > > >>>> scuttled the entire Optane product, cxl.mem sounds like expansion
> > > >>>> chassis full of DRAM, and fsdax is horribly broken in 6.0 (weird kernel
> > > >>>> asserts everywhere) and 6.1 (every time I run fstests now I see massive
> > > >>>> data corruption).
> > > >>>
> > > >>> Yup, I see the same thing. fsdax was a train wreck in 6.0 - broken
> > > >>> on both ext4 and XFS. Now that I run a quick check on 6.1-rc1, I
> > > >>> don't think that has changed at all - I still see lots of kernel
> > > >>> warnings, data corruption and "XFS_IOC_CLONE_RANGE: Invalid
> > > >>> argument" errors.
> > > >>
> > > >> Firstly, I think the "XFS_IOC_CLONE_RANGE: Invalid argument" error is
> > > >> caused by the restrictions which prevent reflink work together with DAX:
> > > >>
> > > >> a. fs/xfs/xfs_ioctl.c:1141
> > > >> /* Don't allow us to set DAX mode for a reflinked file for now. */
> > > >> if ((fa->fsx_xflags & FS_XFLAG_DAX) && xfs_is_reflink_inode(ip))
> > > >>          return -EINVAL;
> > > >>
> > > >> b. fs/xfs/xfs_iops.c:1174
> > > >> /* Only supported on non-reflinked files. */
> > > >> if (xfs_is_reflink_inode(ip))
> > > >>          return false;
> > > >>
> > > >> These restrictions were removed in "drop experimental warning" patch[1].
> > > >>    I think they should be separated from that patch.
> > > >>
> > > >> [1]
> > > >> https://lore.kernel.org/linux-xfs/1663234002-17-1-git-send-email-ruansy.fnst@fujitsu.com/
> > > >>
> > > >>
> > > >> Secondly, how the data corruption happened?
> > > > 
> > > > No idea - i"m just reporting that lots of fsx tests failed with data
> > > > corruptions. I haven't had time to look at why, I'm still trying to
> > > > sort out the fix for a different data corruption...
> > > > 
> > > >> Or which case failed?
> > > > 
> > > > *lots* of them failed with kernel warnings with reflink turned off:
> > > > 
> > > > SECTION       -- xfs_dax_noreflink
> > > > =========================
> > > > Failures: generic/051 generic/068 generic/075 generic/083
> > > > generic/112 generic/127 generic/198 generic/231 generic/247
> > > > generic/269 generic/270 generic/340 generic/344 generic/388
> > > > generic/461 generic/471 generic/476 generic/519 generic/561 xfs/011
> > > > xfs/013 xfs/073 xfs/297 xfs/305 xfs/517 xfs/538
> > > > Failed 26 of 1079 tests
> > > > 
> > > > All of those except xfs/073 and generic/471 are failures due to
> > > > warnings found in dmesg.
> > > > 
> > > > With reflink enabled, I terminated the run after g/075, g/091, g/112
> > > > and generic/127 reported fsx data corruptions and g/051, g/068,
> > > > g/075 and g/083 had reported kernel warnings in dmesg.
> > > > 
> > > >> Could
> > > >> you give me more info (such as mkfs options, xfstests configs)?
> > > > 
> > > > They are exactly the same as last time I reported these problems.
> > > > 
> > > > For the "no reflink" test issues:
> > > > 
> > > > mkfs options are "-m reflink=0,rmapbt=1", mount options "-o
> > > > dax=always" for both filesytems.  Config output at start of test
> > > > run:
> > > > 
> > > > SECTION       -- xfs_dax_noreflink
> > > > FSTYP         -- xfs (debug)
> > > > PLATFORM      -- Linux/x86_64 test3 6.1.0-rc1-dgc+ #1615 SMP PREEMPT_DYNAMIC Wed Oct 19 12:24:16 AEDT 2022
> > > > MKFS_OPTIONS  -- -f -m reflink=0,rmapbt=1 /dev/pmem1
> > > > MOUNT_OPTIONS -- -o dax=always -o context=system_u:object_r:root_t:s0 /dev/pmem1 /mnt/scratch
> > > > 
> > > > pmem devices are a pair of fake 8GB pmem regions set up by kernel
> > > > CLI via "memmap=8G!15G,8G!24G". I don't have anything special set up
> > > > - the kernel config is kept minimal for these VMs - and the only
> > > > kernel debug option I have turned on for these specific test runs is
> > > > CONFIG_XFS_DEBUG=y.
> > > 
> > > Thanks for the detailed info.  But, in my environment (and my 
> > > colleagues', and our real server with DCPMM) these failure cases (you 
> > > mentioned above, in dax+non_reflink mode, with same test options) cannot 
> > > reproduce.
> > > 
> > > Here's our test environment info:
> > >   - Ruan's env: fedora 36(v6.0-rc1) on kvm,pmem 2x4G:file backended
> > >   - Yang's env: fedora 35(v6.1-rc1) on kvm,pmem 2x1G:memmap=1G!1G,1G!2G
> > >   - Server's  : Ubuntu 20.04(v6.0-rc1) real machine,pmem 2x4G:real DCPMM
> > > 
> > > (To quickly confirm the difference, I just ran the failed 26 cases you 
> > > mentioned above.)  Except for generic/471 and generic/519, which failed 
> > > even when dax is off, the rest passed.
> > > 
> > > 
> > > We don't want fsdax to be truned off.  Right now, I think the most 
> > > important thing is solving the failed cases in dax+non_reflink mode. 
> > > So, firstly, I have to reproduce those failures.  Is there any thing 
> > > wrong with my test environments?  I konw you are using 'memmap=XXG!YYG' to 
> > > simulate pmem.  So, (to Darrick) could you show me your config of dev 
> > > environment and the 'testcloud'(I am guessing it's a server with real 
> > > nvdimm just like ours)?
> > 
> > Nope.  Since the announcement of pmem as a product, I have had 15
> > minutes of acces to one preproduction prototype server with actual
> > optane DIMMs in them.
> > 
> > I have /never/ had access to real hardware to test any of this, so it's
> > all configured via libvirt to simulate pmem in qemu:
> > https://lore.kernel.org/linux-xfs/YzXsavOWMSuwTBEC@magnolia/
> > 
> > /run/mtrdisk/[gh].mem are both regular files on a tmpfs filesystem:
> > 
> > $ grep mtrdisk /proc/mounts
> > none /run/mtrdisk tmpfs rw,relatime,size=82894848k,inode64 0 0
> > 
> > $ ls -la /run/mtrdisk/[gh].mem
> > -rw-r--r-- 1 libvirt-qemu kvm 10739515392 Oct 24 18:09 /run/mtrdisk/g.mem
> > -rw-r--r-- 1 libvirt-qemu kvm 10739515392 Oct 24 19:28 /run/mtrdisk/h.mem
> 
> Also forgot to mention that the VM with the fake pmem attached has a
> script to do:
> 
> ndctl create-namespace --mode fsdax --map dev -e namespace0.0 -f
> ndctl create-namespace --mode fsdax --map dev -e namespace1.0 -f
> 
> Every time the pmem device gets recreated, because apparently that's the
> only way to get S_DAX mode nowadays?

If you have noticed a change here it is due to VM configuration not
anything in the driver.

If you are interested there are two ways to get pmem declared the legacy
way that predates any of the DAX work, the kernel calls it E820_PRAM,
and the modern way by platform firmware tables like ACPI NFIT. The
assumption with E820_PRAM is that it is dealing with battery backed
NVDIMMs of small capacity. In that case the /dev/pmem device can support
DAX operation by default because the necessary memory for the 'struct
page' array for that memory is likely small.

Platform firmware defined PMEM can be terabytes. So the driver does not
enable DAX by default because the user needs to make policy choice about
burning gigabytes of DRAM for that metadata, or placing it in PMEM which
is abundant, but slower. So what I suspect might be happening is your
configuration changed from something that auto-allocated the 'struct
page' array, to something that needed those commands you list above to
explicitly opt-in to reserving some PMEM capacity for the page metadata.
