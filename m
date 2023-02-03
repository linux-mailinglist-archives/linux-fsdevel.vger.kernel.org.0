Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7FD688C0B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 01:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjBCAnI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Feb 2023 19:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjBCAnH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:43:07 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0C1F77C;
        Thu,  2 Feb 2023 16:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675384985; x=1706920985;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=FwCpM0hHorwM6TVIV759CWxqhR9dEzXpSRKc0OjTHPw=;
  b=SnpA9AvUlRbhGzgmPVdLTX65WFoMfaxjHqIgZA+rmwjfYpTSGjc2440s
   OCY5ILXXc8pAmvKsUm45RpUNdU5DP6M9B04xouTEKBrDPff+AmUoaOOyW
   Rh5/ooaZpA8vdOPQC6eZ5JqRJy8vv5FBke6CNqzJlhnASA7RGAK5OWG/q
   CIEQuLeCflEhXLpuTEod+6CTGBxLOvxdfUZL1PNZ9JQSRlOxxcSJyC9w8
   Pn1mrdIeFh+rNuJO1iV7Q0jRhYU4eJvm81FTNVDNQOd7MXI2PJEQ5Rswh
   qwLLsjlojkBXX4RqW9HOqSr3MXbvzO6ar3ARbYI25Y0vWA8i3p/Ilbqvz
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="393209599"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="393209599"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 16:43:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="839409429"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="839409429"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 02 Feb 2023 16:43:03 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 16:43:03 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 16:43:02 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 16:43:02 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 16:43:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1gNDeIWmPlQf3UeDdolL6F8X4lTxeaTVvVUiGS7ckyT0nHkkttJIGyR9X+voLhH3RfUxLbD6birwBATvJ32wPCVdzgNR0G868H8eL7vnVOst12T3UW2jzmRXHxeeURqYyTrMwYBnqjznMB9JNTMVmzUqxHFdoRFyASOH4uRf4vLXprJ/vb1EocT8yFPBdnTYFJnoRrebDivcQ6iX3rG9hdeWLw0IeFbSsSyKTqafhNtBMPodV90SC/vnkFhIIDcDzGei64AQolEF3q3d27aH/To4BrVQLp1i7HYzWN5/iQj4hfS8vk/hWj+rWiKykitt+NPpGTcqb+fRuTEo47nmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VU9mixYGQrPbvyrUmM0UH0wbKlANgFpksF5Jg1bEXlY=;
 b=eltLdVOmL+jkYZDkcICOSknF2/Lwdq82rwc5ooHmwx0KFWrN2LFrersA8gVbSAd3caE6dSh3PeTixCgrgMORKmag7AkNsm0KBXVhyfl9RJItSySZjKiLzBZLY9GYH6JB/nIU1SnIIoYQ4yDD7FiaMmBySMTjFgGkMBZqtMOzCDaFHc3gvNd0dggYonCwbGtrP0UgE+Z1lCDZS6zLRg/fBgXpZoiopxd6r/R/V4dCrqeP9Sw2NeYZ+P7EexmGyuvGo8gExavjlVRmnsHcigBflTCmKbZOx77Clx8R1aM3saXI0qgoRaealvj5SqvDmmhjRQtXVGKEYpXnyYW6gJz26g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7300.namprd11.prod.outlook.com (2603:10b6:610:150::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 00:43:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6043.038; Fri, 3 Feb 2023
 00:43:00 +0000
Date:   Thu, 2 Feb 2023 16:42:58 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
CC:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        <linux-xfs@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <djwong@kernel.org>,
        <david@fromorbit.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH] fsdax: dax_unshare_iter() should return a valid length
Message-ID: <63dc589276926_ea22229493@dwillia2-xfh.jf.intel.com.notmuch>
References: <1675341227-14-1-git-send-email-ruansy.fnst@fujitsu.com>
 <Y9xAw+poZxOyMk1J@casper.infradead.org>
 <20230202162348.f90fea5cbff377b977f7b6b1@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230202162348.f90fea5cbff377b977f7b6b1@linux-foundation.org>
X-ClientProxiedBy: SJ0PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: 988d610f-d35d-4fb0-1336-08db057f99f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: twHpH2cte13CyCWck3DSlrYx2YuVUjs2FGRZg++2fXK5pskVp3e7IZcVF9f+p5INQi8BSZXSBY7hwub8l/7k2L90IzmLtfS1OTsM0IQrP0Eve93/Rj0uWrYUrgM4wU+RTOnKJ91VvPYj3+jOMZjmhNg2lgG0FRr3OR2sRi5iQYc0Z6H2uZMw/FWF0ySkc+PXyv1VmBYu8xCmBil/ik/JVT++oQP0DJfevcjoVMkAXLf1LaU8wEJ/Ukh5oRn6dTd6ClAIm+Kk++Em3eqxoYvy7FOcDiFaDVB7trEw0JNnVStJA/dWapAHqA78zBggRnNYRZ01m5CSfEuKppcX3tvkLlxIZcYcoz0y1ZOml/WgY84ygZf3OSi1Id7gjSxl7O73x8trYfOghykQ/U396VcHeRM7RymTws07hv2iEok/tSiA3DnOZ/lxQXGyEc4qzs2RXOZFJ6ltmjFusgAF2QPk8tqEiG6ZCb88+/JWHku34H49vgpKJeWATsQyFVVEVIbbvUlkf31dC2RMGesMC3LSOLoXk4zToRfLOdxP6asUecySeHbngooGxTFlL3/3ekhdHG2CEkdDSH56oLmRpn10nG8Z4IaERQy/vn7XjsYRC2TASiWLSx6qQUc/2apGg8DEuR7insdFZA+gLbt9GzhqTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199018)(66946007)(8676002)(6486002)(478600001)(26005)(110136005)(9686003)(6512007)(6506007)(186003)(316002)(86362001)(5660300002)(2906002)(41300700001)(66476007)(8936002)(66556008)(4744005)(107886003)(4326008)(38100700002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QHWnck74XgCZwfY8ztu9O4pR8OGZq0LTTjv8eeipfEbCyqPmNSD+sfMlnRa4?=
 =?us-ascii?Q?77uvnEPI4uj8so802r+qqQUm8CjLUiY3Acy2+zT2yXzrYUB9k4hGcTHzLoSZ?=
 =?us-ascii?Q?Dk6EOaKJl7Zg3tHrFqS709/ElXrk/wMWcHjtWLaP5bMNchptCWmdYCeEvol2?=
 =?us-ascii?Q?nD75laliKaQcx+dWxKTD6DVKcsmPoznpfQ++wcokT/hzKnlVGlAllBlfFR5F?=
 =?us-ascii?Q?S+IkcEVP/Ckt1/qNfPwNjsVmZmTJLxfhhz7LNMTxSy1WreubgoVPlGlWzJ4G?=
 =?us-ascii?Q?q1TXjkvgWM/cxeb7SyW/orvbhlrsQDtm73pwMmlWY6w0hHfCY9TKfFZHT29Y?=
 =?us-ascii?Q?19Q/yKW97eUm+nKLl1F6ZKcnWmHMUWGI4GctMMti3s2qYB1OiQusI1Pf+IaI?=
 =?us-ascii?Q?Ew8yPqlsJ5J45fl0HDO3B1iRbCwu2WmE2IaLVa5TACXrscxV0N6NyRW1xJjQ?=
 =?us-ascii?Q?jOlouKuCpieKGwnCH2WLDCuaiqRa9Ghy6gIE2akn1cGWTw9cdBA4yIXm4pJs?=
 =?us-ascii?Q?hgwaWAB2NPHe8zoFp9JGmoWtjEUFq1nMhz4PH1PL6IlIsMXKR6XK3d0rCAeg?=
 =?us-ascii?Q?nK3x9ojC8hr4pgXkRBvSYaS+YyU+ihfrnvM3M74IvFGDnIsbbNM2Kwc5kT33?=
 =?us-ascii?Q?HMNku8pJO3VFdKIYbVMnxAwe74xwtnatJUrf6v6Qv701u/ICYxfLif+cs+ZS?=
 =?us-ascii?Q?uhJgssSl4U021P6Dui03jI1KR/neWIDIJ7RMzUIHvOOnqrItGwJszp2JzH5a?=
 =?us-ascii?Q?jbatmm/6igWGZWbk8wASSmxV1NttzfnZ2w4Akdvz11vjtqbDvaByyK8sOC/N?=
 =?us-ascii?Q?CGdKcpeCcoytxe3MkfkaGXsuF/lrJODNXcoNml6LPHGKKoMwYtnUsfzXMfdE?=
 =?us-ascii?Q?e2FIkjlvqpXWIkScBAXLO0AnMHZyViTfYlCRjcmC9rQ3MgPicpGwepiSsGYk?=
 =?us-ascii?Q?wwW5rfB94LvxRBIgTwIfdl4nvczNkwDhP83srP4BpbfIm4hOHHwuZVLmw4gh?=
 =?us-ascii?Q?lpkkd+l98tzCaKU+YemUnSiynTvkWJ/wreN+6DB5Os52DWUg4Lar2lPXy66l?=
 =?us-ascii?Q?5JFgrgy1lbOehG8WIqFREcJpMwSheKmVBR008Saa50+hsGBOzBIKMCyDiGVN?=
 =?us-ascii?Q?JGKK/b5CGP5lRqN6HawTns20fPJgD+FXNXa7YzKa+3suF3YWJi3e16Ye66yw?=
 =?us-ascii?Q?0xEfkc71kPpU3wLkSb+gu1ZszjMaKSSYDhp8DAlh4zsS9Z2NciqeAJ5jQDjm?=
 =?us-ascii?Q?cCSEycPI0CV9fW2gogU/lI3Xy3IhE/Du/H+6J5qHoI9wv2/dvizRCvj2e/ii?=
 =?us-ascii?Q?hpTzCnLFzO5zyoXmGzFAiBBtzw5wJ2BOHZDGqyzMv0zZEmCMLq+y8Dujsmng?=
 =?us-ascii?Q?hWQEHinOa2s3O7sQetzKrXCP1D84xLAvX27sR8fqGPhFl0v71pEYAeVSCy9c?=
 =?us-ascii?Q?SM4smgnrgYe42F8ebmLc237XUaP8Hkl19XewR/U/piE5k+pgAoXkF12McR8p?=
 =?us-ascii?Q?XeWeNfhf3iO+9/x9IKQ6nagbuNVQj/8G3QeIbCzQIggfa4JMM/9UaHS2MjoN?=
 =?us-ascii?Q?EFyRzd9xhSvXSdL3qZRZiReJYV0RDtLe/FdMe4prpH3VmekPJFXaVkfUtCNG?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 988d610f-d35d-4fb0-1336-08db057f99f7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 00:43:00.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5PBJ/qzLuE7l10oLJyY9VPwez1ouJBsow+ifr4jey4TnWeGXxagixYxfDyAeGkNkdWesltbUvHhYMz3G+bnoxjNUw4+LqfljojEyYQgXCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7300
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 2 Feb 2023 23:01:23 +0000 Matthew Wilcox <willy@infradead.org> wrote:
> 
> > On Thu, Feb 02, 2023 at 12:33:47PM +0000, Shiyang Ruan wrote:
> > > The copy_mc_to_kernel() will return 0 if it executed successfully.
> > > Then the return value should be set to the length it copied.
> > > 
> > > Fixes: d984648e428b ("fsdax,xfs: port unshare to fsdax")
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
[..]
> 
> Clearer, methinks:
> 
> 	if (copy_mc_to_kernel(daddr, saddr, length) == 0)
> 		ret = length;
> 	else
> 		ret = -EIO;
> 

That looks good to me.
