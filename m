Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5CF332CA7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 17:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhCIQzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 11:55:07 -0500
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com ([40.107.93.59]:9696
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231261AbhCIQy4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 11:54:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REvZNFj5NdqLRsUKrfO9REXJccQ3KwQJGQYG52qujvXt63qcAUxxe0cLXrE9CMXtfJNdLtTxOftN0pYC5rLiTss25jRr89+hFscC3/19GtqVNcHry06J8a2FMKQ7sf9TxIdybnJ58u3yRIJoraJloLzcqNPmTxyIXJvNiQKhCYS5hL9CAmrZ6aS9UrhMVeEf4FaBAMW83PV+xbyEgopr8iw3VOOJIUUQuteoU3v8llr0axyBApRJ1rVD5t58wxJJSY0/C0dbKEiY9sRA4l8I4jJlkZrMFW+RzmZTsTCjG8k8+712nACaH3aOmnZsNl8szdnmnkja3unm1kI+8MZuug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKpvK/3/3Ub2XKJ/f47QIMrZJJ50utNXNchYEtfdulw=;
 b=PFTb8zNeRDnzxIiAR+ZNjm+vvmucOuSzWb2cedwpZRDrXlRpdsHzauXmHd5cLqcKonmomFwgJEsoAnjVV5Bvk6J1upML5cbMADaNq/ps9103ZMWW46kUbK9wfFiJdCuXxIfyVtkI6V1BDEw3V12Q1hhJnhXRkL369hFxRb/uMMn5AWHGaeiLYTLbgWXY7QcOidfaZnqeiLm6iahFwnQJGvzas3dQbFlCcv4NzfiKM5fJt6EYHFZIsDttlBOZU8hRww4rl+YIIFj4hrwUGGluODj7VBYSCpPEtTHDlRFMeGTuN3sDfSU/75rNMWmOgX58UUeMJ0RWDEs/bGZ741bVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKpvK/3/3Ub2XKJ/f47QIMrZJJ50utNXNchYEtfdulw=;
 b=PZIZu0aJ9VmzfjQ5BiGNC+DvF5fWQreDhyerJAF10qutSFy8ubSjKJUdF4q60iVzWaw/TF7nm6/JxnQTpXn49fkVdhpILkbIkbiR8gsKpNc6sKYyjBC8maT66uit9ClvvsYHJ9Bap1VNEG5QpXCPF2z4AmxbX3VfYVFk84/6rmxSCpXYJSePjTmcGTefGKwvrcnECnpf38dGagwr44oGxmst6PCfYeBWGS05Mw77u2hGPL2zNKiSNgLf68H85PyTpjUa3MhQnJh7JXSk4XrpeIcPY64/mvy/f4aRu8I79AbRr623u6beSz0oaqG05fDbg27FYCiJgzC4wH9rHyzZyQ==
Authentication-Results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26; Tue, 9 Mar 2021 16:54:54 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 16:54:54 +0000
Date:   Tue, 9 Mar 2021 12:54:52 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Nadav Amit <namit@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: make alloc_anon_inode more useful
Message-ID: <20210309165452.GL2356281@nvidia.com>
References: <20210309155348.974875-1-hch@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210309155348.974875-1-hch@lst.de>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR15CA0045.namprd15.prod.outlook.com
 (2603:10b6:208:237::14) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR15CA0045.namprd15.prod.outlook.com (2603:10b6:208:237::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 16:54:54 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lJfdE-00A8qz-Vs; Tue, 09 Mar 2021 12:54:53 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ef625fe-0a3d-42c7-3b0f-08d8e31c1017
X-MS-TrafficTypeDiagnostic: DM5PR12MB1548:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15487F5E00577BA870A1831FC2929@DM5PR12MB1548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7wb1mpIictjVgMwEJkt4sPVsmOj/7ohub1dlzy2ygvLFHZwntVd5AtW5q620Eux0M5fnWJ6+0+BboPkaVvIjj4opGGgr0f/7OV7OWujUIk2K36SA6e074ZoVv94eoUgvggPwQ1V+drjLwYZNC1heck4+Y0JNjdenRreeFVbcRq5IAI3P8SjVu8lLQFJETGnR2tb4WSw3VyoJUIrnyfMAKrDx9OJYmWZcsmI1SFLd24xz0q7l84vqcKGtFUygqxD47r2RRI8nwreo4lOGpEqGXGb9My8miQVBj0M+5x8dPyFDYjkNRZIznEwxeVAEieiNFrSgTYFuLY0/qxMenyXhnVdMtsS+5JMCFhxMQ/fjG9XZLbUsiy/+YpLrRl2oaukxBMyxvPIh8e0IBl++W+pitD1bQWmo2/HCRoyqv47o0F1g7rPgyPfLi9bs2YBevJuyjy8a8H3hPaM4OUOkzx1U3qPaEAFlWjharVe0V/oKmC1N/2d8nUpdQfozlf3ZW5Icnxr3Ks7kwkF2hQ1tHbuPoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(54906003)(86362001)(5660300002)(9786002)(33656002)(36756003)(7416002)(1076003)(26005)(186003)(2906002)(4744005)(9746002)(8936002)(8676002)(426003)(4326008)(6916009)(66556008)(66946007)(2616005)(478600001)(83380400001)(66476007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jZFzFtuf5R6MqIg4O0DL4z6BTmkDWOHPy1QSqDbGA/CoOfqMTbT4dEvyov+9?=
 =?us-ascii?Q?wqDQM77xS2pkngKlHOmlV4l5xvMAidbdYX/UdjjIeHPttTps/K7XFu1ERM8v?=
 =?us-ascii?Q?xyLfkmvLaRzmV6D/ABpTRYJ+asQVGyoB1OsiwJN5pmwopkQom7Aw7xXwLFYY?=
 =?us-ascii?Q?ZF1eWbaniNXIRPBIEU7EfyE4BwFDWiCGwLluRBPAPlVXg5hTwZiyAtUmtZec?=
 =?us-ascii?Q?CcVfqa7/MT3ZqA2S3YAzo7NG+TZe1HIVGykPEBt9lHl/wEq2BjvxeQ6tgqoc?=
 =?us-ascii?Q?2mXL9f44MWl6xK6gEgQj7eAxCj/lYNzsaH+DvqI0sf+SAbfzTXhfKhuVafp7?=
 =?us-ascii?Q?BziwFtLWNOqKb20duo9JxdW3d2CfBAtsHVHdWvnn8KoeFwuDcA+2abOUorti?=
 =?us-ascii?Q?q9JHjscBDqHrhFUnREJQFlJJ9UY8BTBDhHx2QfO5VR5uX2wUXof6WdFFUzLV?=
 =?us-ascii?Q?b91+pO2LVqKGCdxxnFoUsnA5SFp7+3hhSz0ziIjqbmCL3vQD1F2dtKlexvCQ?=
 =?us-ascii?Q?cdy5uZOmn7Hfy3Oe+T/Sk9ayvXKzHp/S8AtYGn+hOC/bDh+5xv/l6wyhSYsP?=
 =?us-ascii?Q?sSrFkos6W2gAxoBricKXt7iUQOxyf7BE2AheT7taWo92fAf/pWwdglVSQLUL?=
 =?us-ascii?Q?04FvfESpwSIns6V1O+/bDIocOKKZfWG8N7K0I3P/Li5bwiCP7QwMHHhQdB7/?=
 =?us-ascii?Q?hcsTWQTGmsCk7tXycrg+PhhakES4/Mfc7exbZegewNLrn9DwYymp5D2RYR9E?=
 =?us-ascii?Q?BhvhvA4PsSISnIChINmNVijRYFB+Tpf0SLYqeDxZyHqzVteIwSH7V/ng2nPa?=
 =?us-ascii?Q?pNk4x4pQPpTJRYbDgxZVL9s2w61LzwKJ0M+Z0J0xfYSIM2SkK/NkfuHN18qf?=
 =?us-ascii?Q?ip+4HZVH1g+H1vr7LN+cUHxGtUIhVKy+h7cLU1ErQI7ey/F2MgZzU0J63dYU?=
 =?us-ascii?Q?i5AZCPSZorLJVaCF8l8qWUu6AN4RUHvxoLeW87vhQhG1FsocO2+7DZlWVouc?=
 =?us-ascii?Q?0+CwaUMK2I+pBOi9pSrN8CX00OoUsnwV3SPxP1jnpsbTRzLrwrwd8cWDP9gr?=
 =?us-ascii?Q?bLrVgdF1BcCUvnGP1q0iHHNfpdpAi93Nizn5z0BV6RwR9bkeSb/p1cGtUiPb?=
 =?us-ascii?Q?Xji18HoMq0PdwgMYcvs2G6fXWoYOaVxfZFfFlTsw+sg+cRO/rEjSwe4gLA2C?=
 =?us-ascii?Q?nrr65UdppWuAuQirJ7tenBlIbT2mK0Mk9eXsxMR6u7Zc91ZugAAWMy8i8ZfU?=
 =?us-ascii?Q?uYxJE7Iw5gvhh5ExD4JQzc3qWmXa8jHpalXT8mngHJMLuyq2/8SSeOFxsRgQ?=
 =?us-ascii?Q?+BWoUrd8PTJQ32W3UBeWTK43MyYPCmFGXzcVhuloaTuwjQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef625fe-0a3d-42c7-3b0f-08d8e31c1017
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 16:54:54.3541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yHLv7rz67JwaCrza7WpjYQGi1FXin+ClHRaejpP8M3GuoOUt1zb0btLDz04o8DaC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 09, 2021 at 04:53:39PM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> this series first renames the existing alloc_anon_inode to
> alloc_anon_inode_sb to clearly mark it as requiring a superblock.
> 
> It then adds a new alloc_anon_inode that works on the anon_inode
> file system super block, thus removing tons of boilerplate code.
> 
> The few remainig callers of alloc_anon_inode_sb all use alloc_file_pseudo
> later, but might also be ripe for some cleanup.

I like it

For a submission plan can we have this on a git branch please? I will
need a copy for RDMA and Alex will need one for vfio..

Thanks,
Jason
