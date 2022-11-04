Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28DF61A037
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 19:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiKDSqF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 14:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKDSqE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:46:04 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877F15FEB
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Nov 2022 11:46:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mM20QpYacgnATNX/oKGBapnnOL3IEbMq8fmKWz+4nDvNTODlnB0tP6VP0oU2uConX/dqWaVGZWzih0Kyjf4BV6wX85L4szlfTDiTAxagZYNlboNpI4hIonTf1ILslQlZVbO6d6EVyVxaQJ57nOOWemrS7AOjmy6iA1rxxzHCKxwmDQE0mPRFDNhFYXVPnQC32fj0tOGWdE/ym11AVKQYhyGZdr1SkFuE63wABI/kYw8wIAEJQpVAtFQ9MZxrtZ84CRs+DIK+ekxcwRXDXGmSzUDIx2CV7VhpgEYJrRcMIobqq1gYQm2I778awyH2HM3A1aVzjrjJ2ufOJvB/Y0SxRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0GX4235k99VAUObO7UdlEmALmgnq5huqyT46N2pYhw=;
 b=LwbqCaK3Wm9gMEMwzNddWhsEsny+2kpEKZ3cavywkLS451jYSNE5rV25c+DxDvF9ggclJbcicC3XAbhGWS2Xd+omhH9c0p1QiWLFp5HnO3F1E9EXMcVQ+k3v9XaD8oS2pix+lo04yCSqxQcptBZnUZ0S8seKMJGXmvE6icUPfW74cTDC9sMX7yWDyT7vtUuhScpshEGvksS59lsrwYyei9LUk0H7xdl95A1IfDzr8qaYHZc2LMrHhHBTk/UFRLZgnOOckFFyIZc/ADUUKenRdebjaLqps4XqxPCW2zNGT54wrCT3FLUr+AlclEFPDoNtbDDrHkvBhEOWnvxLThugMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0GX4235k99VAUObO7UdlEmALmgnq5huqyT46N2pYhw=;
 b=Hjow2y/BMsP2V5ohMbD6QUy9E9zDDoLZlQoRdSSKQmDKKCYPv06Urffglnw2ZlGGkMY7e37nCj0s0flZSvXYiiByw7Hz3dwl9wqMJCk8AWdaWVmWCszZYMY4h6xqiI9EeIdhsz5ItsltR5F9Ep/XHVTMvL1SfNTgEM4UBfeq6lE/5LI7oPhWGL79A3pgqx+JXnMh064MBBfda1P0gnbX1maKHv/+tmG3cv9YvoioIqSjG/5SXjL1eOzV9JMctl+0ZRkleGd32gClWeDJaG+WNfhN+KSOvijIutb0ASZvWgupH1yzvpErdGIpt1LNeCcPmvsGjd4InfxjnlLqZtX7IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5373.namprd12.prod.outlook.com (2603:10b6:5:39d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 18:45:57 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Fri, 4 Nov 2022
 18:45:57 +0000
Date:   Fri, 4 Nov 2022 15:45:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     zhengqi.arch@bytedance.com, Matthew Wilcox <willy@infradead.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: xarray, fault injection and syzkaller
Message-ID: <Y2Vd5HnbxlNED92b@nvidia.com>
References: <Y2QR0EDvq7p9i1xw@nvidia.com>
 <Y2Qd2dBqpOXuJm22@casper.infradead.org>
 <Y2QfkszbNaI297nl@nvidia.com>
 <CACT4Y+YViHZh0xzy_=RU=vUrM145e9hsD09CyKShUbUmH=1Cdg@mail.gmail.com>
 <Y2RbCUdEY2syxRLW@nvidia.com>
 <CACT4Y+aENA5FouC3fkUHiYqo0hv9xdRoRS043ukJf+qPZU1gbQ@mail.gmail.com>
 <Y2VT6b/AgwddWxYj@nvidia.com>
 <CACT4Y+aog92JBEGqga1QxZ7w6iPsEvEKE=6v7m78pROGAQ7KEA@mail.gmail.com>
 <Y2VaSZcX7uqRvRf3@nvidia.com>
 <CACT4Y+awm4SLe4jBOFNTNYT1KAi+zvDWfXik79=eASc4bPC98w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+awm4SLe4jBOFNTNYT1KAi+zvDWfXik79=eASc4bPC98w@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0314.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5373:EE_
X-MS-Office365-Filtering-Correlation-Id: 63e28edd-a705-41c5-8c45-08dabe94cfb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j/mK8u41HbSaAbJz2RtPwPxa56g5SRW/4kjBZqkq4VunjrUbCfIXmdjsn2vI6Xp5TvXSKgUCGumE7zB+q/hE149UWrLdp2+FDI3BYtOQtFu3v6RMctoplKiuezUcF3343PiQPwo9gLuWByxbId6CfXAPNsleS5oysspQPaITsShPlZSka9X3y1iB4jMQkCxczANRfepBXhlLhEuzsXFIHxpa+/0E68tDSD4hWBDuAL4PFOuQ2rpzzGQnOtwz4EX4UUeBlZv+chrB+a4JN2O4RXMUZbX1UtnGh72JXNkNwanVUS0IuDOJdAq83HxvzD2Tg9Zh4zPtmxV2s7ermOhPG/jiqWksf/AqdJd0/x+X1See3oq31kmDLOpa5j3p11uc8uhwJfJiGcG7Q766wtwUhwb0iwFcF1hgK8SzHRnEuqITP8S3kMU0MfiNq/5Otk961YRSAiMCI/p5qWgcnpnRmgwSyTW9GF/y1xDDWBaQMELJUESC2UdrBg5WJrQ+X9Z/orIV0SIYvvE7CmG/jw2fw5CCLmUuvlyNOwhE6jPS09XW3LFF2Q+mgnnifM3kwPV7LpuygwFRf7BStr2sjYz8mGBt+ef5ptNQYHjIJR+trXYnWU7XPd0hSqCC2iXT2xWqVV445VlJJ5JzmNkcLPaWWR1WkXe1vPh/O0AOQvkBmh5OvLV7PTN37Mz1kNLRuoj8vVbT+VRctSnbkQ5bj7ixTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(8676002)(4326008)(478600001)(186003)(66476007)(2616005)(36756003)(83380400001)(5660300002)(41300700001)(8936002)(6916009)(2906002)(86362001)(38100700002)(316002)(6486002)(66946007)(66556008)(54906003)(26005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FFpxbiJ/ptCZ/FzQgmLfMS1QDx2+Uc0T3fVDl3SVMoXnQ04U5JEdNPNtEbO0?=
 =?us-ascii?Q?ECaVVKpWysV8YjjZqXI6hP/RgXZRu83AFJb6DQpwdBIEkpzv4xLT30GpDwOu?=
 =?us-ascii?Q?hPBmd7Vi1reSzoLRmV2qiy4sIf3sscPpScFAvxZYKMB0ja5Q+VfQj7Rbng8j?=
 =?us-ascii?Q?2mL1JQPDgezhfV6T3DmKT2SHi0A8WhkbGjB5KrUzSg1WHwUg/FARojkdhrlT?=
 =?us-ascii?Q?L3bNJiqiLhrfRw7m3OLRpiZWYsLs7Jkbgy+6FkSn1YiYfjKbbmiuKmviLUB2?=
 =?us-ascii?Q?obOKqm9pjH0TXn38pZ8DTIGpq0MemOS/ArFcfF3m7LzHYU6d/+sw4KcC/m3Z?=
 =?us-ascii?Q?ZpE61FcRS65Q3tOAfm+qLus/Q7bCTQmQcOY9PMJvo/OYZUP7FMCXcl+wtzae?=
 =?us-ascii?Q?btr0gckjAqtzDS9+mNFwEzwP150blVLIp98w7lYdoKWRhq+Hj/qzic1etf8/?=
 =?us-ascii?Q?MAHHxL1el2v+vk79VlcphWolxtjpL7n5WG5/KrpaHdKReKB1By2xbSay2Le5?=
 =?us-ascii?Q?wWFXzE/WOO1RoDpfgBtCm1Eyuy9w7cjKTIgsfL8Lrs21KtvDuFYZ3s2AUFjT?=
 =?us-ascii?Q?opTHUh7UQBCsThkgsanTt44HZM4h2iEx5L27BLEH6Qj1ngaDN8LQGy4i6iLK?=
 =?us-ascii?Q?iGdV8mRsBg2LC/F4qCyZHlVN10qiRP8fb/Mk2QuRMmJOCiJpcaay0x+ffMBJ?=
 =?us-ascii?Q?IbOOGWkHNAAhQWiFTumpL4KWhZ6mPrMBj2aeY+HF7N1mBT5MjwFCerLHcS/z?=
 =?us-ascii?Q?M8whgQGxXsy3YAZJTJg7F2UsPkcd7fR8LZ2cxAx4KkZfE0oKZSpDik4/4f8C?=
 =?us-ascii?Q?a9jRNdhsTARHljdNvAXGp1i7K3ofIUpJ3v9tJube/PZ7eWI5zgxqPbWDqVy0?=
 =?us-ascii?Q?MdyAOGVfXwhGHE+wRV7Iva60DAuw1mBRmoNtvKWLUVGR0JXbUjD0ds0LI8Ma?=
 =?us-ascii?Q?R6jOl0lqmTacdaS7n6r79Ll7X3oUwzDGuWAe7cuBMAxU2SHExgs6vENUu8tq?=
 =?us-ascii?Q?p68Jcwv9TQ+6cRm6ozDh3J2RknCH/OnUPZc7/6BCDrh08GdnWA+3a3B7CV/C?=
 =?us-ascii?Q?Cj9uQvS0b6Nk/GLpDdHQ3KwxWKQ2ksdty/LxkWB5Rcbyr0A+swrxvfRs3N8B?=
 =?us-ascii?Q?bO6VpdemaOSI7Nh+PV40SJ8EXg2vL/v7lR/E0/Ue57iLTkTRSu0gr51RIzIY?=
 =?us-ascii?Q?npKrR+l6QCXUTaG/xm/OudQkfmuCnkyG2VcDDriwfXH2kv6OMBSagAIfpslQ?=
 =?us-ascii?Q?fM5TP/nlva+DsFTS+NzEQJbnMpEnWtQRm7/9lxl6UqSZBuJ3by54xDfnP18H?=
 =?us-ascii?Q?QOHg/E1OahDjNsPbBbiex14STybFmHD049qfJLDLyd/7qqq2xnCA+wce+uOx?=
 =?us-ascii?Q?MHB42orUIe/mIlDMYf+Fn2Og9GfJQu2hx1pYuAPEeipmcShRMIgxYDRRL2o/?=
 =?us-ascii?Q?nBkS4ccNL4HKgm9ZVvAPF0NcntZZPgCqbbCJd0kaXyY0AJqslUdvDCOQlKW2?=
 =?us-ascii?Q?2lNvjh5WGLiOtTseIvjpfvudicr8MkxFzGlFs84e9EdOY3PjQhqflCmho8p2?=
 =?us-ascii?Q?s37Z0cnlWD0FEKPZwwc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63e28edd-a705-41c5-8c45-08dabe94cfb8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 18:45:57.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/5t+JWuYyEWbg9SSxZXCg+0e/V9175u2QNZC7T0b288wzqo0vXZT8HP7weybRDs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5373
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 04, 2022 at 11:38:48AM -0700, Dmitry Vyukov wrote:
> On Fri, 4 Nov 2022 at 11:30, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > On Fri, Nov 04, 2022 at 11:21:21AM -0700, Dmitry Vyukov wrote:
> >
> > > But I am not sure if we really don't want to issue the fault injection
> > > stack in this case. It's not a WARNING, it's merely an information
> > > message. It looks useful in all cases, even with GFP_NOWARN. Why
> > > should it be suppressed?
> >
> > I think it is fine to suppress it for *this call* but the bug turns it
> > off forever more
> 
> Is it just "fine", or "good"? I agree it's probably "fine", but
> wouldn't it be better to not suppress it?

It seems sensible to me that fail*/verbosity=2 should *always* print
if a fault has been injected.

I don't know why someone thought this one deserves to be shut down.

GFP_NOWARN is about the caller indicating that it expects and will
handle an allocation failure (eg it is asking for big regions and has
fallbacks) so we shouldn't print the general OOM warning.

Jason
