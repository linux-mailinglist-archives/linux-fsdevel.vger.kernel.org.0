Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198236F1005
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Apr 2023 03:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344769AbjD1BgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 21:36:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjD1BgH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 21:36:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B14E273B;
        Thu, 27 Apr 2023 18:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682645765; x=1714181765;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=Fx8+39ymwVIh2FbMD2V+8N5710ZEhzeI0RydIfMkNSg=;
  b=WwxyanAn/qM82056YzqSAd258jAIUgp8a4DRbvwQHvEk64kT7CKl5j1L
   s+COSINge9Z/pMeBTBu0xKXogCeHpDvmkpkgj5WZvjQccRkLbI5bj0Yyx
   jn50o8hb3Yx8cHXCQ7xuiO7oxjoqOFDboq+qT1fkDDbH+FvDKWFuNPWQ5
   nPHvhZOonpqlbGmt/SDfmSBfVjBkyZyup/z4JlEW91kj8LLxk8KjLQywB
   iUZZlIR7aWloR2PxnMGYbUbpezRRlvTPfM9Z4g6ygD0v7UdbOlM70B0fE
   UVNXZ/xRhY33rK8PV4PLpNpK1W63NaT/AO1eKL6Op9Qg6BPerOR15XfB4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="327236315"
X-IronPort-AV: E=Sophos;i="5.99,233,1677571200"; 
   d="scan'208";a="327236315"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 18:36:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="671975393"
X-IronPort-AV: E=Sophos;i="5.99,233,1677571200"; 
   d="scan'208";a="671975393"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 27 Apr 2023 18:36:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 18:36:04 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 27 Apr 2023 18:36:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 27 Apr 2023 18:36:03 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 27 Apr 2023 18:36:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1RbcEYZk1DLG3q+EiPbHHeQnGA7yxqiRmjs0ELXNksh7N+CpBzYTIfm4sY58iCTfGDoWKUp8Y1oB/0+RQ0L8X5SdrQH4vU9x0fwtTZ7tUd1qEdqtzVEF6mSpsNV1OBcHTDDEsmHom4aHcqYGVU3Yn1ZjHQqq639bEj5ewZyFpxEtwH5kqJwcfkrK3gOqispBMt9mxlmgtv3ApRVNmEXiksscbgXThi9oC40Xi/DygV9P3WbTzdKAGVmTXwbes1U6kvhSOYfX2tgsBy/++zkyNrrxJStVxj7mV7pJ/ZUd/Q49cShDdCXHjuzXA8hn75qPFr3E6fIGKSXLVMKeI3mYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJgBuvdkaFdt3gC3TOAg03dmo1INdCtCYTb7dpMe2j4=;
 b=KYEszvpgKlAIK70oTB8/TMHiBWiFJCL7syO5ESAvEkARMEK/C3MSlwdE18/oK1Ie3GpCnSjhbNFjOvM/tkDVlUOCspQdhLOyFz/nQ538IqOu1axILNW19IzF5ApWOQddHhGNAbNxZq36zT+lBfM+7pNM8d7RU+u9xkH1d8lsJGCh3Rp9robK1EaqYl/kn+4IWJOVzbZ/d2wo4iJxh1w4HrakWARxuTEZNd22NNHdEwMqLMLdpQyXENXjk0lj1XCpiW5Jw2iRzShSSxHtk8s2/FSlDXQb29I3ick+XGB9VKWeAxlOzfy88BrUw1Hnoyl5VLsfX+rQGuEWDNFx1OAeAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB7968.namprd11.prod.outlook.com (2603:10b6:510:25f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 01:36:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%6]) with mapi id 15.20.6340.020; Fri, 28 Apr 2023
 01:36:00 +0000
Date:   Thu, 27 Apr 2023 18:35:57 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jane Chu <jane.chu@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <ira.weiny@intel.com>, <willy@infradead.org>,
        <viro@zeniv.linux.org.uk>, <brauner@kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] dax: enable dax fault handler to report
 VM_FAULT_HWPOISON
Message-ID: <644b22fddc18c_1b6629488@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230406230127.716716-1-jane.chu@oracle.com>
 <644aeadcba13b_2028294c9@dwillia2-xfh.jf.intel.com.notmuch>
 <a3c1bef3-4226-7c24-905a-d58bd67b89f1@oracle.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a3c1bef3-4226-7c24-905a-d58bd67b89f1@oracle.com>
X-ClientProxiedBy: BY5PR16CA0020.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB7968:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc3864e-c841-43a9-fb2d-08db4788ec07
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jn8wVUaTj6/IQe66j9qeQsJ5o2z5ICwtdSgyqgPQZ7FQToGKggP8JB/Mcuv37jUtMHNeQNv9hG3mWrr3k/UNy21xKDUG1sU570UEexLmQuQG3VMn3GP4IWTDs/8dYsz2GGfwLC+Ko21lmXWX/SI6pFK52f0QFJWhmPDWUuTyNwKhbmi799Xg000sD+Mz/v+Zuo/Ee4/iSp+2b+2BNTpwXVwqv8S12Qa8UcRm05ZY+5DYn/gvimqzjgRm1Ld/SJ8+dtgvJMcjq0PhbaqRqN8kFMsocdZppqCn21WfaDyqutIGCAXxn/cdhcsC779WikU2fc5LBpKQAUo7/2HD1e7hLd4Oy4SqacqL8PlKEtqyknzdx//3ziRuMdlRcIK7aVyfUNPGOhhDrcGJ+f2cXGMrHmYQ1tGU78LtUfEbwa3bmcVvfiViBTTG81n6USeY6raV5FFDr+7bwvih9o8uoJUulpLUIhkC4RYPWLt+W8ibXFRNe0jQ2H/pKlps9g4tIrjYZYlueRV7WFPQrIJ+PKyfWJXCBwGNg6CYK6E6IWM+Tdrf2srm6FHmMDc+97gSxrpAI4R7uK+sZpd2vI5s4PJ+iV9MeVqZJVD8rSVAx4mENB0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199021)(41300700001)(921005)(26005)(53546011)(6512007)(9686003)(6506007)(82960400001)(5660300002)(8936002)(8676002)(83380400001)(38100700002)(2906002)(66946007)(316002)(66556008)(66476007)(478600001)(86362001)(186003)(110136005)(6486002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OGazJdA6+GAxi33Of2uAUNkb2Zj9kL7bvkM0TJtLBPX86iJB1k7jW4OV0MJS?=
 =?us-ascii?Q?bY5y0W3YOMAcGbDowwKqzxH3nXKrgJN9hjOzz1uY3oCIlhNopaD93mce/lg1?=
 =?us-ascii?Q?niu6QfXkD8SjmyWPwwJHIajdb+SeG2hbOxnCk1a2ECkEDRONOY3PE9SpYSr2?=
 =?us-ascii?Q?sQdKQVQQmXiZDzBbjj/2KvPWudRU+ob0Plze4Uws7Cn1Lzjpxw5L+xjlDt8g?=
 =?us-ascii?Q?nOu/SHlCzPP43pZ6s9xVbGDSVVhnYSr2yWcI5+CL/1ADmbQkuBLj9s5mWlls?=
 =?us-ascii?Q?/O4ksfcpQ+HRSK0rbTBWYgdsGFb5naG45TOuALBqtPICy9Fpmk5Y521vFeRh?=
 =?us-ascii?Q?z2vtQWPpQFqwEyLkJrr3dp6Rk+sgRxsn8PWKJiAvfN/TQqfRGEvNqXfi+U6W?=
 =?us-ascii?Q?Jw3k1WWIm9L/SR69ZhTPR4Et/MlVKZIjfa+d6jERD4C7ylW99u+RNCyrUvqz?=
 =?us-ascii?Q?fmbfYmaljO9FxRthn24McFwnIa9iuBFrZbrW7aAk5O2To0UsWvvETv3cp1/u?=
 =?us-ascii?Q?8yMTVCQngVKChmkihJBajVjs8tWtdcwyp/s21smML3Vx5LUY6NwTCQctimS+?=
 =?us-ascii?Q?1DGxVs8WMC+w6SyuLH/XFDbn5WgQUtk7JSP1uPcxs1OYX8P7Qa74qdjsnklF?=
 =?us-ascii?Q?yFhas9ZSXHqrhL/PMZ9yIocw5ewAFYWvGN7eVns2nOszxbcxAap8wlOc6drX?=
 =?us-ascii?Q?K4FxX/vZThKCZSqerXVLF3XgcAJ40i2ppKW0hvsDFJJWu7Gv8WS3c0Nd51aG?=
 =?us-ascii?Q?DAHldJ0IATKmyzev+LJINbKAqnYfEPgPQS/gpTuZUjMmKEQbKDkkj/WVGRW7?=
 =?us-ascii?Q?iX2sslWl7XHmMwGcXvLw390ZpOTz93ZbF4//MCgMoc1SR6f0d9QBPk5HujuE?=
 =?us-ascii?Q?tEGOv7MBk+TawRUldmxsCgOmm9xNw9ccgOK7P0E+OCyaqc/tbxPBl35GFSkv?=
 =?us-ascii?Q?+kSVsZ3MPvbKQjigKPezdAMpjR1WT2L9/UcOFkIiA0zcaYVW5BHLG77YXUI7?=
 =?us-ascii?Q?9e29/s2q/gCc1BOemS8fZ8mJtjKu7EyKvc5d9ZOBCcmwsvdOSEr8mBabXzP5?=
 =?us-ascii?Q?jXTaFd/qc1GjHSWzc/ISHvD1T5abEP+igXlkSbS0qORwfFxLBChWa46WBIoU?=
 =?us-ascii?Q?kz1A8SnN1Bjvr49yA/2qOy5hQjB9ZtkKh9n0GgDKmcGHCewcVE6FmLHtTu7N?=
 =?us-ascii?Q?fWADGGEmf0xrjdGrgdUzvhPiYjDYLUuUSBmMDQXbhfOEvP7y1W9tCvxntyCO?=
 =?us-ascii?Q?P5Ih43rRaIvNLAQBW0D93c2p339vDm5FGA0pWIYa4nTF18MO+oI9h83TQEmX?=
 =?us-ascii?Q?gn9Ciy4Imx0I10doyvc1IHfimFHsQzrGciREIZ2t5gR2Yf2vGznf5cv6V9ke?=
 =?us-ascii?Q?6q06XeGI0K/2eubhd9fnn08VZF7Paqe1Kn9km/Im8XG7X/cLn9wP04P+yh+o?=
 =?us-ascii?Q?S3VzIVttA62Hf7shdQVat6bGyDIi7++s5DgsTTVrA4QJCpR45sxGpfhEgtxE?=
 =?us-ascii?Q?rRfjTJziovjd7z7q59nA9MHPg76DXbLD61u91MRbynjAomCKQWQb6dG3hFbn?=
 =?us-ascii?Q?4iiNyYAaGO4n69mBrNfe5AUXq5eXoNVZpnkhwJ5XDcZeBJqyVPvzBWZagGVx?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc3864e-c841-43a9-fb2d-08db4788ec07
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 01:36:00.7496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5s/UbIsXod2GFMuCbr8r4Pmob5RO+QzrT2tS8+YQT84kuRFX5uy1SrVQnPOLku/mUpVGPHWdcov+pjrmbpEbwxqw4YsnDkio9IeYQRUuoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7968
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jane Chu wrote:
> Hi, Dan,
> 
> On 4/27/2023 2:36 PM, Dan Williams wrote:
> > Jane Chu wrote:
> >> When dax fault handler fails to provision the fault page due to
> >> hwpoison, it returns VM_FAULT_SIGBUS which lead to a sigbus delivered
> >> to userspace with .si_code BUS_ADRERR.  Channel dax backend driver's
> >> detection on hwpoison to the filesystem to provide the precise reason
> >> for the fault.
> > 
> > It's not yet clear to me by this description why this is an improvement
> > or will not cause other confusion. In this case the reason for the
> > SIGBUS is because the driver wants to prevent access to poison, not that
> > the CPU consumed poison. Can you clarify what is lost by *not* making
> > this change?
> 
> Elsewhere when hwpoison is detected by page fault handler and helpers as 
> the direct cause to failure, VM_FAULT_HWPOISON or 
> VM_FAULT_HWPOISON_LARGE is flagged to ensure accurate SIGBUS payload is 
> produced, such as wp_page_copy() in COW case, do_swap_page() from 
> handle_pte_fault(), hugetlb_fault() in hugetlb page fault case where the 
> huge fault size would be indicated in the payload.
> 
> But dax fault has been an exception in that the SIGBUS payload does not 
> indicate poison, nor fault size.  I don't see why it should be though,
> recall an internal user expressing confusion regarding the different 
> SIGBUS payloads.

...but again this the typical behavior with block devices. If a block
device has badblock that causes page cache page not to be populated
that's a SIGBUS without hwpoison information. If the page cache is
properly populated and then the CPU consumes poison that's a SIGBUS with
the additional hwpoison information.

Applications should have a consistent error response regardless of pmem
or dax.
