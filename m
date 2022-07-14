Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA5857525C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 18:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiGNQCz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 12:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiGNQCy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:02:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719274E630;
        Thu, 14 Jul 2022 09:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657814573; x=1689350573;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a/x9N9VBVQwlHl945jqTcWUuC4UgNvxbqLeD4uvNXdQ=;
  b=ZzuHuUsRDhhnzPyIv/PXNEmphkFa5A77+uwutEsbxmw8TJPXMDvWBVWR
   IZUamN9GB3jiU+lSieyFf8ZmMJDJl5ZZmTtSb1qpSooZ5081bJQuohY6S
   1X5iQtHckduOPHTFqrMnPkgFrLlt5PuVY3ezd1xaMBt1hzusSfnCH/mNt
   LEjvRBAW9o5oos2/1I3CuoRHzLb8UknGgElVabsAq0FYPk/KejSTb2Zmd
   JzavzSHuE6mwYZZYKt0z0LH/bN59xCPjWMBJR6WIqrM6+5kQYh33pxdza
   gYNpSZoKWxshS4/qmNGE5ns6hx2NMtjtQVWihLbEjLg1WDHcx8Te26+fj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="284310962"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="284310962"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 09:02:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="600171264"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jul 2022 09:02:37 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 09:02:37 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Jul 2022 09:02:36 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Jul 2022 09:02:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Jul 2022 09:02:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Av0YtKbkzV2yWxK76rpAwrGkYihtqjfKxuhkB4wdxZXmMBHlTYqpKBYM2eb+KJIxK8w8F0tq8ed3KBTrD2z3XLXb06tUfSyh3RE7b2VSS9hoaOJMrWtukyH2IHdjEnqEiKhSGjkf9TWl6HI/M0g1u+gW7Kvbt8NbPJkbBdHDiuD1h8huhmKFvXesL9+XCmY68o7k8Rp6xe3gDw1YDK+yMHhgWLNWETrZBOTjVIx6Z9atuEnPfphwKPIvOzvU50908cOK0l7/CY8Ta5FvIkt7UjZGykdCu0yXy3fV8kWwMY/BeYGzj+0a0tjeTtXEwnQrBfDqaR5CdvE6ACC1xTTpIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NrUO+fxmqkHEEO2pe7xTP4WWQSWAOks8d4Xf1BKzUYE=;
 b=IMx39eYz9341UhoVGSvmEL8Ul0bPI2rvu040JuhjRUQdeX5yCo2o8OtfkqpXJcLoWtwNvCgHwKVWl7p4hYfjnei0L4q8m+VmtTlsrr3O7Gis4EisOgxLbzY5iCCn1WjpCUo3mQNyXOv32moEa+Pnkc8tq6Rb3/xaRBsvkL2UE8JZ+ioibqsH/tGKp5L3J/pNeCGQRMCOabsljMi8YqP/VRvdjdpSuTWu66CwSfKsey920Fr7QJ4QdCPq5kuvyVYa3NgBkF8zvqB4dG/MV2eNMQiGEgv14UOmz066YsvnzkoqdGct84+aWtvAtlnjMmN44UNlI5mOASMKkTWNO0rMZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BN9PR11MB5559.namprd11.prod.outlook.com (2603:10b6:408:104::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.23; Thu, 14 Jul
 2022 16:02:34 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::3154:e32f:e50c:4fa6%5]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 16:02:34 +0000
Date:   Thu, 14 Jul 2022 09:02:27 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/3] xarray: Introduce devm_xa_init()
Message-ID: <YtA+E1p95bk1fQ2H@iweiny-desk3>
References: <20220705232159.2218958-1-ira.weiny@intel.com>
 <20220705232159.2218958-2-ira.weiny@intel.com>
 <YshE/pwSUBPAeybU@casper.infradead.org>
 <YshGSgHiAiu9QwiZ@iweiny-desk3>
 <62d039c0cfc13_16fb972943f@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <62d039c0cfc13_16fb972943f@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: SJ0PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::34) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cd35411-b675-47d4-63bb-08da65b243ff
X-MS-TrafficTypeDiagnostic: BN9PR11MB5559:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhIfUue4pPq4fUctS561GXcr2rHMnCQcWOfu3OmugeMYjlQqNyHzNa/hGooVu4XfUSI+MW72VYATLP//rEc/QN85o66PTtpBQAlHTfsjJcktne+heIm2hecx8HadfzSa7OjTFT3fm1+Qh4+/B6C5woD/Ul71iwLT15iX7w16fkdncWZLbsfXmxzhO2++xWEiykQnOGNoTiYnE7lubjZjF0K5hdfShzKxxYpg1RCmJleOs35cPqrpsHp+LFSlU7B82IfOHo83Mhgn1Fd2razhYTARO+KCPGQmZnHMgt/+Q5V0eWBK/esBKmoP9YRt5ESd6XVwSg497HhQ2ztGUAE8JP/Zd8zfcjZpsHxXI8tG2dHZ6IX+Ao69nhXs1a9yhR//GnofEAY/iihynK8X9+2YV7gzsK2S937b8hGeLLSeqha5L6uNeLRVHSwRyS/UbL4UM6ikXrPxyZsi9l/OqMabOQOKUr5T59oI61OhVzq3xCsSkSVyNiNGqc3/jEa4X14CqtL2X0qAXwJ7jLecuamBEPoFeVs4WjBsBBwK9/NlAijrcwOOeqK7vX6PtqY1E5m4dUVLpqBm3zqgfDbl3Omo1X3To6aulK5NAdJ3F/3Ne9RCn8OKbqRVgraIbVOrAG2dvWnVyI0C3662MuyBwPscPM+E2yIHpTB2yDzph6pfdQ7iozW6LfjH3iLPDTk2+6vdDRspT+ud7xeGVImuBNxRlnICEiTqssSOrFDJIy+4iRhWk0WP3C+vqY9o4EWU+pmto87dreOKkFAC+joTWVuaN71QAFd3FLSnTPqTBrK33MChZ4Cx71MQXuzLVnQ3RPEM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(376002)(396003)(39860400002)(136003)(366004)(82960400001)(66946007)(6506007)(8936002)(38100700002)(8676002)(66476007)(86362001)(33716001)(4326008)(2906002)(66556008)(6862004)(6512007)(9686003)(44832011)(186003)(5660300002)(54906003)(316002)(41300700001)(6636002)(6486002)(6666004)(478600001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lWNP228mym9Dm5OXA1E+Mm+HcLXG4MKuPXnC3z3tqniwhZEl54iZfwtOw5wm?=
 =?us-ascii?Q?UwUFkBL/7hol7ZuWZ0g9c5Odmp2P/mGHJUcrpRqnVTv/mNm2T+kP8/XF+pI2?=
 =?us-ascii?Q?ZtRKgW7jdA3MtUaktjS/Eusa2w4A/JJ9ZoZUe6gDYd4+URjlBB9fq18rQcgT?=
 =?us-ascii?Q?j5A7cVud9/os1I5YxlRfMVXl27QIhjd6vszACfYB4kH5/w+/q5ELinkXDeUH?=
 =?us-ascii?Q?zg4O0S0tSGo1afdyIcKQenhEZx7LrjPHb4w/9z2sTkubj3qmPiy9NWfqmmZP?=
 =?us-ascii?Q?I0EG4jPnqZXO4cVXt+q+TRBL+UWInuhKfu4yCDXVzPrMtL6jQQHlg9bDIhPF?=
 =?us-ascii?Q?6uhJT61ACDPQHyJ9ubE39X1wreT6sIhAKgKCNhMORM0DTKNL5mU3D9tMOng5?=
 =?us-ascii?Q?CKhmzBf8y7lXI+xYaAzeIJZO4XZOY/eNQBwxNvhzRSylG851pVVLRVa7/w76?=
 =?us-ascii?Q?uSx6G9ydX6c3uSdTihacrO4otAFEIjPoh36CoKMrKgQ7ku7b1hv/pXPk0Yhx?=
 =?us-ascii?Q?lgSGC/PEC1BQAM48f/cto9NP38aaS9g3UJMwee+RE7sGkZ3s3wYq0x2K2qbk?=
 =?us-ascii?Q?XZcph0jj3zf+aOZnxFGBwHQMSzQk68gwe4LTqQzEhOmCBIOTkbclRYW1+OVY?=
 =?us-ascii?Q?FJisuIKgIe1oA0vxsU1kIQFeC+EArC8/a9hmW3oYg4kMtJ+0qAq3Zz3RWtVB?=
 =?us-ascii?Q?gAK2tJGRVwqXf0zspJLEP7j/6ZEzSLWPzVL+jMZ+DbGs/ikMV+E4dyPl5QEm?=
 =?us-ascii?Q?RQVKreamIp+7q9xTpMvGmXYnDoC4/Sd8qTRtNlqZZTTCgC6BK2jOAGrEe3uH?=
 =?us-ascii?Q?C3h8nkyxiCKof8butKjq55ou308uDeszSrpmD+wYHPsz0XCY8VSDvZtFGMVb?=
 =?us-ascii?Q?uGzTnY19S/diQL154YJwTrzhBt2PFo/0knq5+4kPnFYoeBR14pjMbsi+pWEQ?=
 =?us-ascii?Q?JQ3uE6+wMjDy3/rTAiLPHSM6+A5y7O1VXXbYiVnY92Vg/RD4HVhUObDirNQ0?=
 =?us-ascii?Q?r8D8vvXAvDyDu6ICATd9g7ZX8uhPJAzrloiahM+LkAaR38uTu2JD8aRgaw/6?=
 =?us-ascii?Q?76iRtRoGUNeR9rwQJFUWm+PhgLBXPV0wOmjGKgDts5M9Lprqa3FGINHOdQNm?=
 =?us-ascii?Q?p0Fd7bmT1tjtPzX6xADNUjCUVrmitYCx9yOzCpjNFgx7krVRHZb50GZoTas2?=
 =?us-ascii?Q?U+maD7crbZ82feFEXnX0QtnWGkjV+gN6qEmcGOLtgGeMqvCcbS6zjyXAi1D6?=
 =?us-ascii?Q?W3xQoMeu8LS/HhQXN0liVCh2SvdWpY1h1g6RbFj0N7swqATg7k328jf7lWjW?=
 =?us-ascii?Q?76TdbcOJ1MPXLxyAt4VPNEk9KPnZpb9uR0wJyMfa2FP7R6twh3+CijcJLtZo?=
 =?us-ascii?Q?ZEpjTx4yOFjmtJfqR5IdL18kq6YlGuKYHl5C7GgxgJ56gzhWFKdSVq322itc?=
 =?us-ascii?Q?TBOEF0KT3OtZrLWOMk4B4fZJ0KDC9r/SWCsV7zvNL0ZotmwpfpQr3tWSMgYc?=
 =?us-ascii?Q?DOGbbflfWqPG/fc6dSVUmb2BnxOBqoaEupl0MOLY07yXCdZc29/+y3G8a78W?=
 =?us-ascii?Q?hwsm7mD6CiaUGXf6ZFyvJpP151o9ZWlBx0R25fujmTA9GyaQsNtq3CyL/+Ry?=
 =?us-ascii?Q?PiBQGEU83KovK0Jf8kmHSQPqL4SEsYzQWNyn2JBBJl8c?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd35411-b675-47d4-63bb-08da65b243ff
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 16:02:34.7303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVbGGBlHA02oBXOvzVgAkveorlunEGuKk40B6ONoue6bJolKIrvUNogMBv7Gt9YYrxTLJ3RqOmsv3YmiWVVR+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5559
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 14, 2022 at 08:44:00AM -0700, Dan Williams wrote:
> Ira Weiny wrote:
> > On Fri, Jul 08, 2022 at 03:53:50PM +0100, Matthew Wilcox wrote:
> > > On Tue, Jul 05, 2022 at 04:21:57PM -0700, ira.weiny@intel.com wrote:
> > > > The main issue I see with this is defining devm_xa_init() in device.h.
> > > > This makes sense because a device is required to use the call.  However,
> > > > I'm worried about if users will find the call there vs including it in
> > > > xarray.h?
> > > 
> > > Honestly, I don't want users to find it.  This only makes sense if you're
> > > already bought in to the devm cult.  I worry people will think that
> > > they don't need to do anything else; that everything will be magically
> > > freed for them, and we'll leak the objects pointed to from the xarray.
> > > I don't even like having xa_destroy() in the API, because of exactly this.
> > > 
> > 
> > Fair enough.  Are you ok with the concept though?
> 
> I came here to same the same thing as Matthew. devm_xa_init() does not
> lessen review burden like other devm helpers. A reviewer still needs to
> go verfy that the patch that uses this makes sure to free all objects in
> the xarray before it gets destroyed.
> 
> If there still needs to be an open-coded "empty the xarray" step, then
> that can just do the xa_destroy() there. So for me, no, the concept of
> this just not quite jive.

Ok I'll drop it.
Ira
