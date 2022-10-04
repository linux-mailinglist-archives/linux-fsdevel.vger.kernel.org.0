Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACED45F3B5B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 04:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJDCWb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 22:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiJDCWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 22:22:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70364A810;
        Mon,  3 Oct 2022 19:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664849964; x=1696385964;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q7wcFeHI9VdPLKGGIK9HDFfbdBNLiYpWa8cfcDWD6hQ=;
  b=Q8jrZShGXN3TR3XUc9vFji6cQlN+TyVau6MZRmn6a138mWkJYARVCjPM
   AmK1dnALthV9A8nhtDkJBK0GZpsim97qLLpgZVhx+8G0/64tW1KEyfTLb
   H28GDaBnQY0fUGIW2dkW8G14CyO3F5ktMS1G0gkZJmCCSwVY678utPiBa
   W6LnI+3eUipopyoSUfL2Z+mcWr3FaoAar+yw1uPdlIoEAdrTST9iMqZw0
   mOsoOJVxpQTVnPCn0QTGSUAsH4Uh8GhQvS+qYnAKyihW3TNgLcqxUC6v5
   xO2YfPNHEWEPwdJ+MVepiKmcIYi/D61l2P5ljXaCze0nbt3Wra8UOpzV5
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="389101610"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="389101610"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 19:18:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="868843592"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="868843592"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 03 Oct 2022 19:18:12 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 19:18:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 19:18:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 19:18:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 19:18:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSQf0RXWmapqIkRwzxnUisMF336XmCql6ErQUqRa+vuFHsqnTmc0phALiguVIaVhvq35E9zsbpJcd+oE1mnc8FeQg9VFve3DlPfrdGJfBNWR56DpD03xQMh5h0qbuzZAuuSq0+xBdZpO0OsMugas050tqTOKkXHY7aDjr9XOXr/ISYgYyDlooGEWQlBlbEcevacD4kRcx1iV1jSZxvBhTDYC3GDDNfQnTF9aOOKcpoQdxl4efVzSFuaSEVMfHyn48AL9XfoiSdK6bRTblX1xBW4pZ4Ma3TzrOLKCLrGtBeaY+nIudzDq+EfMi3JKbAgKnq+8dTs+TxqeaUiUG2zhZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWmcaZjpYU+YkvSptLzUP8+bj2VrGGNjEQGurkQZyuA=;
 b=nOqNHYG97l4vkHC1zEKDY6mK3mIIwm5MTgn73YK5ECtxCGYeo8qTNgdj9LO6GrLN1ARz1JX8bnzq5q1H5Kqp62fiDbEBtJPloDRXRwRWsGb/VRrrYvKGWkuAwu8b6PF6TWL57ztvfMVD+AFjYtHzzSYZV23g2u27xkaMc+KM5vF6J2Um8Qw98ARPkucmev0t9tdc9BtsMrknT3ZnqFQ5Si65oVSvQrtSrlzjb6+dzy93yF0cd21FSiw6F6nkOpTVW+Ubwr37YEUhM5Sqdwpw8AFCUSqW1fovrJtHnfxGZwy2h+ZAHZCA1wHgAx9g95+ARdSca0f0Giy1LLiyoi/Kvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6006.namprd11.prod.outlook.com (2603:10b6:510:1e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Tue, 4 Oct
 2022 02:18:04 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::b572:2e32:300b:d14a%3]) with mapi id 15.20.5654.035; Tue, 4 Oct 2022
 02:18:04 +0000
Date:   Mon, 3 Oct 2022 19:17:59 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "J. R. Okajima" <hooanon05g@gmail.com>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH][CFT] [coredump] don't use __kernel_write() on
 kmap_local_page()
Message-ID: <YzuX175G/5ucUlpC@iweiny-mobl>
References: <YzN+ZYLjK6HI1P1C@ZenIV>
 <YzSSl1ItVlARDvG3@ZenIV>
 <YzpcXU2WO8e22Cmi@iweiny-desk3>
 <7714.1664794108@jrobl>
 <Yzs4mL3zrrC0/vN+@iweiny-mobl>
 <YztfvaAFOe2kGvDz@ZenIV>
 <4011.1664837894@jrobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4011.1664837894@jrobl>
X-ClientProxiedBy: SJ0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::30) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a8715a3-10cf-4d81-fbc2-08daa5aeab1c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppx1koZuUF1e7s2lkQi/asyxtBv55Cwv4KO4lFatk8XQOETrYw3CQKvjCw/YCIqgv77teq+X+B+o8R4u3B/VakCgCN+3ctJ5+5gFRGf2CUSSUgXHCG4u0oyX9EAW0kFvWICPtxHIqG5agP3OzDQLSigflAj6XTNdM3trlxb6X4uHjQqZX5d1vrMBE6G65NywNMJBjfBLsxX7QhSMpe55VnbOKiC1IDB+y2jyb4asEV1/x1lDKlZN8rEFXiPSR+Rq2hVmnlhJodsG7G8/axcAcPfCNlKEKz4Y8HeQ9IU818Zw/MXiCsgqQ/uKtiSV4788kFefiwXTM1kDEmZam30CK4Mf0KKzlUPwvalVSS6dMOxZt0fwuEk5iL6ewIvh/VXM36LRu6oV93eALw7q8/0rN0m9bplZms6WcR8fNtRSBGgTVLaIMvrs+R4V5iAsdVbOBEgl6F+43dIJjYLww7Y7gntBkK7IuopCMGDvN2BL7fh7M0CddqkTu1CRaZKwqX5+B+3QD6EwMRfPgIOCBWvehqoiiPL+JARa47DqoQHwPYCnMw5UqJnQcBIEhhEYPFBkYgJlwEmEiRDjth2JAe4BQukkV+mGFwlo5YAjbuWxRcBa7MnBV2Vsf0T5HDDlQQNqUItgxQVhiEBWdCyZ1cH57SCnlDzNw2w4hxDo8f9+/KzIAk2p81nwKzxUvaYSx9Cay5ghTh/dEbjMGxZ5Sipexw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(136003)(366004)(346002)(39860400002)(376002)(451199015)(66556008)(8676002)(4326008)(6666004)(66946007)(38100700002)(186003)(41300700001)(66476007)(2906002)(6506007)(8936002)(4744005)(86362001)(44832011)(6512007)(5660300002)(9686003)(6916009)(33716001)(54906003)(478600001)(316002)(82960400001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LNvzXAmOFP8AdyoMauTyn8vOPmG75M4sIwAN8K6W1H6nxULJHuAkc9wgZKCr?=
 =?us-ascii?Q?L9eCUo4rbZgxvDRCx4tEGf6GJy/Urv5CUlGnTl+UBmxeK4hx0s8YmB8G5lFh?=
 =?us-ascii?Q?8tXWRbZI5dyIqTMYrD0b83MaYMHyWK4u2H81/lBfdSVetbleW9imwqw/Gd1h?=
 =?us-ascii?Q?YZE04cH9a/aDIlbNFukMtTo59qw0EPfgKiw2ykBywNtp4M/DSgQiv+rTeLNS?=
 =?us-ascii?Q?hIkBfG9TKdSR0HLL+2Xs1qva+V9jbEVeG7KAXFWJVkHxai96O1LaBTpmw1IC?=
 =?us-ascii?Q?a27fmdGEjUVARM6EdxzDrkfxqlB6yz96yoPfR+tlXJekXiPz8lv9CpyxcJwT?=
 =?us-ascii?Q?3UeIR2j0h9U4MFNccDBfUzMfG5bFpKAZyHIMqq8YiZh6/kau9apZPgn+dNT0?=
 =?us-ascii?Q?WWvHb5kRf+eLuQtEX81MpSTkTeMItX+UZiRliyx4IlcE7R5rEIpbRrwUcXXz?=
 =?us-ascii?Q?E9SDdPPTf7xaA8eK7I3ENChjJwKsZBAP4KAlv/ao4yModqe57m+CNnJ7+ahb?=
 =?us-ascii?Q?84epBY+hJzxwV6ghDfYpdVF9ZJtaQOoM/wkiLQVwqmT5VoCasQPNdz1QAGfq?=
 =?us-ascii?Q?OvaylDHm2VoDJOdhNuWoyIsAwpbZ79OdRCqmeCu9Isseo53LYWt6FdkkSzYV?=
 =?us-ascii?Q?soT57ajmjzfFTIjvu0ZY9V5YlGMdQrwgXd6EBap4ajkBoQvsjyA9mmj0ZLcH?=
 =?us-ascii?Q?aNvbIkA2f4mtUBgEE4j1XqKdLfm7+EgTYOrXTP4+5i/+PDfuGPKeuTon/Mhm?=
 =?us-ascii?Q?+gPduJIjf8Z+CoO/Kfqtd2SoI9JpR/mZlAvVeptxm1lD5iJMUkH8Q+If9wiy?=
 =?us-ascii?Q?ZiO+ou23OPNPTKeSJjRPSyyTXTeuhlAgex0KZ7Du2Ecb/k1uiLZRN3lhnQnw?=
 =?us-ascii?Q?SS1wGvnhA+sQu9H4LPVKon9W4c5xHylyA9n8b42rXvpEI+Fq9X3khHapBazv?=
 =?us-ascii?Q?quDe/dpz23YhRy+bn1LXDkl7pSFWCQ5t7Kqm/H2lalsXTdS70hK08ejfle50?=
 =?us-ascii?Q?oLIJ9VJCzQkZ5JR8lMSoqqWLc2tG90iIuM1xsPCRiaMlcpP/DDART4O/BjoL?=
 =?us-ascii?Q?FDH3GrySnhG60NcByxDmzJm+T4xJHAju8aFegAdFOqNz1MCYoud7+gG081rL?=
 =?us-ascii?Q?MBz9Xmbf1UNvjv0hBaWmIchCAmzcJu0p/L3tCw4wCQeVsLdrTtoJ5IdClKjc?=
 =?us-ascii?Q?45s/Nv9GiXSI9zM2HrKduY86fGR/69yjCaDuNiaQb/z3lwkf09r96r37YHww?=
 =?us-ascii?Q?G3lvimwsLf9LnG0e7MBN7UbCyrD7nQmGE7lJ4IT+BIKL1N6e6rg7CYdqS2MA?=
 =?us-ascii?Q?PkWiU+BJlrtCMLNt5NcyfdgBHWTZ80zeX9dt7rneQY32zwlm2PuXbFR7BH/H?=
 =?us-ascii?Q?0UpX94dE7qUdshXY6QLodPnDiuvkRcFYSKahA7imGhY4ez8e/fj3w6XP8UWK?=
 =?us-ascii?Q?AHgsSzBuaLjc8LJLrFJtUeG1FkHubvjD2qsi5lRzANqV3vO50Vj3SbWC9i2h?=
 =?us-ascii?Q?s/vGGYQ41umjSRoLPOB5NvPc17WCKI7VFWEThJRQSsc7ZWNeqokEd9Jby4Ua?=
 =?us-ascii?Q?qIDecNHLT8mEnSSvEmW2YDXDULybHQXohjBg8R8ILe672Rb8QSKL7BW2aSbI?=
 =?us-ascii?Q?rtTp9xwU3KLW+u3lQUQ24d83zmlyD5FEQO7q31ejfDU7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a8715a3-10cf-4d81-fbc2-08daa5aeab1c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 02:18:04.1135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWgH0xs7yB4gmg69R6RaMBJcUBBPTd1WTveezzBZD2i8Xh2NaSorh54J3QVJfifZyxhANbuCk2hKf9EelpT5PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6006
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 04, 2022 at 07:58:14AM +0900, J. R. Okajima wrote:
> Al Viro:
> > Argh....  Try this:
> >
> > fix coredump breakage caused by badly tested "[coredump] don't use __kernel_write() on kmap_local_page()"
> 
> Thanx, it passed my local test.

My mess up too.  I thought I had tested this when I had tested the
kmap_to_page() fix.

:-(

This works for me too now that I have my git trees straight.

Sorry.
Ira

> 
> 
> > * fix for problem that occurs on rather uncommon setups (and hadn't
> > been observed in the wild) sent very late in the cycle.
> 
> If the commit was merged in RC versions, I guess someone found the
> problem earlier.
> 
> 
> J. R. Okajima
