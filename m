Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EE761704C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 23:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiKBWH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 18:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiKBWHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 18:07:24 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E774E9FC4;
        Wed,  2 Nov 2022 15:07:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8RMtwYLjlcORJMERRZB5IM6k4I1P2/hL7DQR5zYnqU3tBiUC3JHZ5bfcDcyPj++16yTaiLuX7lSfbWQcfYw1VGdIleMQ/cqS2WxLnnAJlSUgypJU7YiK/xsbJ3NxNkPs2yDLJsqTFnhfOfxpwYZVMW/9GUd6BTfRdLgNjugpU6ZRzabRQQq1Lw3caXW9+4iJ3+Qjr+qmYrSqyICzdbwX6kohp5I6C7HPF9gg/eaI2HBwO3W/6N4q5MvHJVuBohipC9+GleOLlwiYE5lUcm5Bh5HBOdGjBUiGEwaJIihea1mgEOhF7aRXfn/zJ3vTi54BWTARBYA+zJgIQEdrIwwyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmgh0iZGAX/QaShdCQlzD7eUL2K+mNnD0XRsqFHwmKQ=;
 b=WQ+bfzaPxSbjwghcCrtrYWLuf0oxJ3rm7HeepCWE3686uZSOjFAzZSsdvWMkoClFEsteYBcW2ua4MZFWwLrpEhtyPY7PrtcsZmalptjHIhL/izM5eY+ETfwB26Qp8FkaH2PSXlL8FJ0JQzfDcODt698958ZIdd2stidP7Q2yS+4ylPxfyzzBseVE409AMKr/PJRhp488e6dM2gnRPklsRPLMIAOFue3/QsUAc9vJFVgtvizezMe4RMz6PgFPWHo5/T/tI+nlCMaCRjLWQm7EJQbkSzBESQ2FIaRdthvOVhVMQSyMgXqfx9oIkWBxWWcY4qy/za9615YWfrXLEeHhbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=shutemov.name smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmgh0iZGAX/QaShdCQlzD7eUL2K+mNnD0XRsqFHwmKQ=;
 b=D+EjUkf7VsYyfWM7okA4VBupydeKxXIDLiltbX9HLxlZ9DeCB0KjkvRUt7DGq3eYqvHD+D0fh92CaaPCSAbO47QHhQUvkHjT7aT825DGAzmB+dIM8pwK5GUCWB5h+6OR/MaYBmk6lhHslt9OUbPMxAsYRqBvZ/qMjPdYaNPVzMo=
Received: from MW4PR03CA0106.namprd03.prod.outlook.com (2603:10b6:303:b7::21)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 22:07:20 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::47) by MW4PR03CA0106.outlook.office365.com
 (2603:10b6:303:b7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20 via Frontend
 Transport; Wed, 2 Nov 2022 22:07:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Wed, 2 Nov 2022 22:07:20 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 17:07:18 -0500
Date:   Wed, 2 Nov 2022 17:07:00 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     Chao Peng <chao.p.peng@linux.intel.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        <luto@kernel.org>, <jun.nakajima@intel.com>,
        <dave.hansen@intel.com>, <ak@linux.intel.com>, <david@redhat.com>,
        <aarcange@redhat.com>, <ddutile@redhat.com>, <dhildenb@redhat.com>,
        Quentin Perret <qperret@google.com>, <tabba@google.com>,
        <mhocko@suse.com>, Muchun Song <songmuchun@bytedance.com>,
        <wei.w.wang@intel.com>
Subject: Re: [PATCH v9 1/8] mm: Introduce memfd_restricted system call to
 create restricted user memory
Message-ID: <20221102220700.5u4mj7fm37m6ust2@amd.com>
References: <20221025151344.3784230-1-chao.p.peng@linux.intel.com>
 <20221025151344.3784230-2-chao.p.peng@linux.intel.com>
 <20221031174738.fklhlia5fmaiinpe@amd.com>
 <20221102211404.l5whyif3j3k67fv2@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221102211404.l5whyif3j3k67fv2@box.shutemov.name>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: ff531ccf-3b4d-4dae-a24f-08dabd1e9cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hC8O7xYZw4KFGp1bNZdyhvnG7UfsRdVmw4OKn2REFbUZDpuTxcdT4NtGFSWYx6dGw96vzaMUT+Mj9LlBPM02HNyy0EPlowS8hUS5L1zpcTkPM5wid2w5aLewwbL1Inz31kbu3ykJUeEth7dX4VN1r33kddPCS0nqKfO6DUvY9UJSSEeVJUDTDd98D85oAiwG4VaLKxQTspvHcr352emgwNf6rer5N0Duy4tjQoQ8yO2NoPFWxHi+pw69Rds9PXE0TsBOKq+GJ8x8zfqdD+tyXiX8A9dKFnkEJmvlN1AvmZ3AkVr2wZcE1PdAcGO/E0/qKUDLWoagXcpuUReAEDO/nyGLhWIlz6DzUrL0/5jP783Zxxw3HtZLFsva4jd7YTg0/tOMV61WF+krJcXZ3nv25myMJPKbMTmylWvY71zEkaN9zxt1XadCvzo6Iy5+91/4hBbtNveG+q2GIwsmNpkAPTd81wM3tEX5cKdtF6v3wfJXunDs8Rizf6b6qHboJBDwJi97cQvNLLidVEZ5XFd5UXgSC665zpt7iKB2D7/jhcDegco8dHMh7DZUsEVEgf+7Nq1HGzIPsNiw072D+Nprkp6lqnxLuPs6n2KcbSW9oBKDgtZ7a7r+svitQQ1bpttTMefNaN8KPib/leePspTWzLV4ZpfVqLCTRFMzc24UYnLBVcpvAT6ivwm1BnPDeot+hJTq71bO7KaZ7Au3L/UimZYTtM72xuFD+JKmYEc0om5y/wu/LCmyKsEGbDrUdr/k8RGhPnWb22Bccd3w+RwqAzrXQlzFNGxTBbHDbaVtssdxY18dzbABCJeC99XubarZvBsxLUwRjIF00tt60jkCQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(86362001)(81166007)(356005)(36756003)(82740400003)(40480700001)(26005)(8676002)(83380400001)(2906002)(40460700003)(186003)(4326008)(41300700001)(8936002)(70586007)(16526019)(70206006)(336012)(2616005)(426003)(82310400005)(47076005)(1076003)(6666004)(44832011)(966005)(7406005)(5660300002)(478600001)(7416002)(6916009)(316002)(54906003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 22:07:20.2830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff531ccf-3b4d-4dae-a24f-08dabd1e9cd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 03, 2022 at 12:14:04AM +0300, Kirill A. Shutemov wrote:
> On Mon, Oct 31, 2022 at 12:47:38PM -0500, Michael Roth wrote:
> > 
> > In v8 there was some discussion about potentially passing the page/folio
> > and order as part of the invalidation callback, I ended up needing
> > something similar for SEV-SNP, and think it might make sense for other
> > platforms. This main reasoning is:
> > 
> >   1) restoring kernel directmap:
> > 
> >      Currently SNP (and I believe TDX) need to either split or remove kernel
> >      direct mappings for restricted PFNs, since there is no guarantee that
> >      other PFNs within a 2MB range won't be used for non-restricted
> >      (which will cause an RMP #PF in the case of SNP since the 2MB
> >      mapping overlaps with guest-owned pages)
> 
> That's news to me. Where the restriction for SNP comes from?

Sorry, missed your first question.

For SNP at least, the restriction is documented in APM Volume 2, Section
15.36.10, First row of Table 15-36 (preceeding paragraph has more
context). I forgot to mention this is only pertaining to writes by the
host to 2MB pages that contain guest-owned subpages, for reads it's
not an issue, but I think the implementation requirements end up being
the same either way:

  https://www.amd.com/system/files/TechDocs/24593.pdf

-Mike

> That's news to me. Where the restriction for SNP comes from? There's no
> such limitation on TDX side AFAIK?
> 
> Could you point me to relevant documentation if there's any?
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
