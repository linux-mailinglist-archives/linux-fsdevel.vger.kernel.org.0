Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905143A083D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 02:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhFIAZn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 20:25:43 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9394 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230205AbhFIAZm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:25:42 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1590Fpps011344;
        Tue, 8 Jun 2021 17:23:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=uatrukWuEvod5FAWT7mQFdvX2+y3oONeh+6XRBeakRo=;
 b=IF1cZutx5UUbLrcjhOaBIAwFFMorjTpwmACwED6vg4dF15zNLTQJJ5fAbXXHWJF/ZnHL
 7fR2h+2Z5LzU5vqNxbw/LgQBKbX3o/8F1LZQRrQaE07mAS3xZgIgznzRvwSzdaX3tmH/
 aaAb+HOyoHyKuJsRUvmM0eQTMzo7j7veC2M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 392fmds47x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Jun 2021 17:23:42 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 17:23:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaD1Y23Rf9eaj4v4r0+x7EeSPIfs3bhgLHYb2nWDzylE0wYEeH4UhtQIdif1WjGWzDwkD6jiDDrr22gNtNoHeyQ+kYx5Yb5zpq0zosX6+bk9I600V1PofU2bNems4gHpKx3Tg+qT2jtsXXnR9gaBkeGDOCGQLKkbaDvjwGiYDyNf+PFp5pilmZNvN2F30hvOY7lUNRiL/nCrK8txL5mIS2072KKepLqjn+nwurNA5DpBnjuH/f8PsYvJgzzxxaVkAIWEdm4fy2Mk00ms1l6K13VaKfvgannbA/3Wal0K9+CJzrgzcY4VOJL3KxluWHT8Ly04fshW78T/kZwGpsXrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uatrukWuEvod5FAWT7mQFdvX2+y3oONeh+6XRBeakRo=;
 b=M9x6XCQyEGYNEXsKech7lo9UTuG+xRbT+W4T6ftWtbGKDfMoiK5UXi6H3RUuoUdujw806i2DysmW01g1fbLjESUIkpVHyGcqqkOMv1O4dJwpt1e8E5XcpB0unPDmAN5F6RDZh8Yq/ChLsD+mhtak8y8NFW2CutGIoZnbHGx1XLYFNPFBmQcWS+i7x7iywp06ugDjsbcfoFbmq0ddA8k5lO5MjpIeDvPcoUPtA3GbwmeJyj6AKnfs1mpkSRGjxL/nu3f9M7br0bBAy/le11ek+OjSmJ6xc2FQLL9IlvK4VLVw0J4FR35F/RaAUICFYUstL+adtYaeJPONtCuYLO+zYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3079.namprd15.prod.outlook.com (2603:10b6:a03:f5::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 00:23:38 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::dd03:6ead:be0f:eca0%5]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 00:23:38 +0000
Date:   Tue, 8 Jun 2021 17:23:34 -0700
From:   Roman Gushchin <guro@fb.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Tejun Heo <tj@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Dennis Zhou <dennis@kernel.org>,
        Dave Chinner <dchinner@redhat.com>, <cgroups@vger.kernel.org>
Subject: Re: [PATCH v9 8/8] writeback, cgroup: release dying cgwbs by
 switching attached inodes
Message-ID: <YMAKBgVgOhYHhB3N@carbon.dhcp.thefacebook.com>
References: <20210608230225.2078447-1-guro@fb.com>
 <20210608230225.2078447-9-guro@fb.com>
 <20210608171237.be2f4223de89458841c10fd4@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210608171237.be2f4223de89458841c10fd4@linux-foundation.org>
X-Originating-IP: [2620:10d:c090:400::5:59a2]
X-ClientProxiedBy: SJ0PR03CA0329.namprd03.prod.outlook.com
 (2603:10b6:a03:39d::34) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:59a2) by SJ0PR03CA0329.namprd03.prod.outlook.com (2603:10b6:a03:39d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Wed, 9 Jun 2021 00:23:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb55995d-b6b3-4dd8-4054-08d92adcd363
X-MS-TrafficTypeDiagnostic: BYAPR15MB3079:
X-Microsoft-Antispam-PRVS: <BYAPR15MB30798878B53D45021B367DD6BE369@BYAPR15MB3079.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WlaUBpN7bjnr1S/yN+lKwD6zcdaORCX/0YaGJQPiBEmSva+r41vT5ZQu7ti2dC8o1wRH5GrWy0/ZHaJhrDJG70JJQZRFBpSZYofplZCfb0yVCr8rOt385BoBE2DG6T5ego+fftLIaLY/2LunadIQE3jt+/p/zGyQWF7ojLOf7rB5tNKoDJu+wcZa4xfk7EPz+mlX5tRUA0MczP5PktraRPWw6Kks2q1OH+AzjGrzWqdFFazU5lBTKGq8LaUeBOEyLLpiFXbVNDX+lVGXAW2QtPzrggFHqo5BF05pyLwI2D+YPRHONlewEsy77wsqO9tQD7C4fNVTL5NVCf5KUv0oj4IsfpTBcv55HqKeFJan6ljXEyYQ+MCPTv02JdNnCzmpqVd46F5J/UCTT/im3hLeEVaBnBF68BVxIG5PMQ3nn929SUQqtouOTMvMnUGGlG8KoUyl8t0CkXunGRY49DzUqhmI+3ufjvN/eiv+mnniTqF09L8GLqJg/3yCMOwhHOn+4AWiag4p33UDhwXd3FlqW8BhkdkBhRtuNUMXhVR03tswgfG4vonLt3Kw9Q34jf/K/vOgLtMkjulAOFYBt5VoQKU8fX6F8+NyQN2v9QyBrZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(66946007)(52116002)(66556008)(16526019)(83380400001)(5660300002)(478600001)(7696005)(55016002)(86362001)(38100700002)(9686003)(7416002)(6916009)(8676002)(2906002)(8936002)(4326008)(6506007)(54906003)(186003)(6666004)(66476007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e9RG3E+nPzLaSxxfxxiS8T8uPCidiuYeIFellXf+qfaCHQMPKLVWysvPDYHh?=
 =?us-ascii?Q?OAofJcH0ZrcGSTRPVADU9J9aLa5arRXIHVBH/NjaAKfZAXVMNvJP7IfbiiP2?=
 =?us-ascii?Q?WD7wfCvfdaGX4c3icGHnv4QUmcR2pvpRUJuYiTJKpOnGtB2Dv4HkrLh+c4fn?=
 =?us-ascii?Q?TicCqxe5rJ6tGI3TdK3aARqA55JtApMb/gfk+ACszL7+NffSMhrv4QOwslJH?=
 =?us-ascii?Q?GkPfapF1GIWkr3RTyoO4pOvG83JIpznkZ48S8gNCckRxaNrFQWsjc0oFEira?=
 =?us-ascii?Q?h2yxJFo8JfI5l96fAU2JuR1FBqyTwhiUXvepS15qxgcKzV0EHwX32JKC5IXU?=
 =?us-ascii?Q?6NB/EGoGShO89jYo3xRQguV7dS15PUKhrgRlJoUAGNTtSiJtw9l6ISfmjcFA?=
 =?us-ascii?Q?PdXdoogAY0JQbm6zWuiCGp4MY2s5BmV5Tl5bhddsFn1/pwIx979qHtQH65uf?=
 =?us-ascii?Q?toE/8iL/fOPVw20KqsnWt7uhWMM4zpyWSz8rn8TBb9T9yH2wUYYbVZ5Q9LmK?=
 =?us-ascii?Q?VCf44xLXK1YSPsGsBWyx4LeG3XcbSNn+/bDVYa6f50EWUCbQj2rJ1cIte8TB?=
 =?us-ascii?Q?KnZn9pD/n9O4k0yIwiH3aFDyMvfnFK7DKeiU6rejAPgs2+tg5xMaB1tpmYqL?=
 =?us-ascii?Q?KIXODkJ0ZOkRHlQtu0IR88qCONn502BIppeOU03Ki5w6kZPtZuTcM7MjggsA?=
 =?us-ascii?Q?MShSy8RD0sXuI6i3RGfJgQzUn3F/9UdW9hnlEVwf0JcYUlKT96KlKv2R+gXD?=
 =?us-ascii?Q?jA3YZgyqy/5+kM0cCmyiVeAFKDSUG0HP9TsgcU6MCk9opWbKe7ZUgp3lv9uZ?=
 =?us-ascii?Q?65BjsDFmpkNjR0s8Xbyhyapm4orIeAEV9RrpMw3hLt9lRkF7ch6+6O4JGMNM?=
 =?us-ascii?Q?Hjqs6sBAh834sdPrY3KhxGlgnqb59sYQQKEtnJq9i4CRIYP6b/F6Ry6NheZv?=
 =?us-ascii?Q?Zde9jzyfh/xkoXuC0u3QAYuFJGsSGhI4nV2itktj4GgI1TQStnko3gMwir/Y?=
 =?us-ascii?Q?YFqwppp4du5Bn2pm4HH09/YiWIkSnqnpYrCL8FA6FestgTjxJOGFvWkusyMg?=
 =?us-ascii?Q?l0smrPH6yQZkRDPBXQ3j4QDP/w9eAjX7bvkYStC1IPtKtjkE9YRy/gKEK6+M?=
 =?us-ascii?Q?q8t5BTWJcaRPHTFg98VJpRItOOwXvfPlM0rrMbPLXZX92GyJFw3Bo5nVGbQd?=
 =?us-ascii?Q?06zBuKX0PZ2eIvhFr2LbKZ24YzHnb89m2yi0xQ/LLutDzJx9V4+gFlCeoJzq?=
 =?us-ascii?Q?zbhF64woYeODGsGnnhGyBOakl/1aKEFIqp9zBRds55RGf4nYo3QuPtiGLetK?=
 =?us-ascii?Q?+AycftUQgQUH9JHeIdpHLJkbMMrpci98ziMq577ItwotkQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb55995d-b6b3-4dd8-4054-08d92adcd363
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 00:23:37.8573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mz5NQVrmQjsn+xm70/N4IxDIPcgODoqrqsn+C5n8Ms+5uAeyIbMBgfqZo9tKgjZW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3079
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: CkQopPbLzsNUK7Dt9oowP3_5uZfKbHy-
X-Proofpoint-ORIG-GUID: CkQopPbLzsNUK7Dt9oowP3_5uZfKbHy-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_17:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=596 bulkscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106090000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 08, 2021 at 05:12:37PM -0700, Andrew Morton wrote:
> On Tue, 8 Jun 2021 16:02:25 -0700 Roman Gushchin <guro@fb.com> wrote:
> 
> > Asynchronously try to release dying cgwbs by switching attached inodes
> > to the nearest living ancestor wb. It helps to get rid of per-cgroup
> > writeback structures themselves and of pinned memory and block cgroups,
> > which are significantly larger structures (mostly due to large per-cpu
> > statistics data). This prevents memory waste and helps to avoid
> > different scalability problems caused by large piles of dying cgroups.
> > 
> > Reuse the existing mechanism of inode switching used for foreign inode
> > detection. To speed things up batch up to 115 inode switching in a
> > single operation (the maximum number is selected so that the resulting
> > struct inode_switch_wbs_context can fit into 1024 bytes). Because
> > every switching consists of two steps divided by an RCU grace period,
> > it would be too slow without batching. Please note that the whole
> > batch counts as a single operation (when increasing/decreasing
> > isw_nr_in_flight). This allows to keep umounting working (flush the
> > switching queue), however prevents cleanups from consuming the whole
> > switching quota and effectively blocking the frn switching.
> > 
> > A cgwb cleanup operation can fail due to different reasons (e.g. not
> > enough memory, the cgwb has an in-flight/pending io, an attached inode
> > in a wrong state, etc). In this case the next scheduled cleanup will
> > make a new attempt. An attempt is made each time a new cgwb is offlined
> > (in other words a memcg and/or a blkcg is deleted by a user). In the
> > future an additional attempt scheduled by a timer can be implemented.
> > 
> > ...
> >
> > +/*
> > + * Maximum inodes per isw.  A specific value has been chosen to make
> > + * struct inode_switch_wbs_context fit into 1024 bytes kmalloc.
> > + */
> > +#define WB_MAX_INODES_PER_ISW	115
> 
> Can't we do 1024/sizeof(struct inode_switch_wbs_context)?

It must be something like
DIV_ROUND_DOWN_ULL(1024 - sizeof(struct inode_switch_wbs_context), sizeof(struct inode *)) + 1

But honestly 1024 came out of a thin air too, so I'm not sure it worth it.
I liked the number 128 but then made it fit into the closest kmalloc cache.

Btw, thank you for picking these patches up!
