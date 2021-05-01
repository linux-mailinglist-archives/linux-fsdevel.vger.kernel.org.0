Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E00370917
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 May 2021 23:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhEAVjq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 May 2021 17:39:46 -0400
Received: from mail-dm3nam07on2050.outbound.protection.outlook.com ([40.107.95.50]:36320
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229912AbhEAVjo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 May 2021 17:39:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXgP7UWOZZ/8zxDYq9pHKqWLZ2cifuGJldaP3E3EGqilIaKulDVdv+O57Jz7bl7FvcGyLbNXIqqheLhmuP4UeNJ5NybfJXm4X/8F6CZqGE/JIr4bAkHOq1Sz2/xYAhCVUsIi9Mwy/Inn+xPWA2gFebI6DkbDu4DHZy1E3x3y1jThOjlO8Uh18k5rz9jYxihK+553ihLi4xQpH28lGdGkbQb4RB6egRa/bFzBadTGFP3+Ja2g8xnhpVe0D9bor0s5wqmKzyu39pMsj9rC3JI65zqdZZxCqDNrejbgQC8OBOSPwqMFh9Y4aNImR9xODxzblW/sduDd/gcie3EZ05bFWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxGLKHVsPqcuoyvj0hjPeft3M52Hcx62/NO7TS4i+DY=;
 b=k/7rmN6YDqSLj0IE1Tn5UxWT1sSTtEUlhRktR4b7kkQeGiJCZ6dVAUd5kG59rnmDjqe/lN7GEC2JIMhfAN2BdoP+lnlvq7uP10yJYwlba4EIOMHNMw1yQd4yNJH46EXmo3GL4zkMZcsEwoRoyb+S2x0D5MBkmxh/XoKk2Bu7/VjEHL3qS/b+ieQpU+HGB5YAR+Rt+jsqvXIRNKnaFT8Qmn+fVQYcPqC5mYawUYvIdIJ4/eLJbKIL1XYuqE0dRDXjaNnX65S81in57zCm53OtbYTb02XsEBEo3WWlB3FYZiaG/cpdOPOrz+L8NsdhRbL9htgP9JaJFhIuFgvq4fzDUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxGLKHVsPqcuoyvj0hjPeft3M52Hcx62/NO7TS4i+DY=;
 b=ogq53eOdTUmKfgXi5+2IJe6nAQZc8OSsDZAhu14euotVclIq8x1deeBkPQQ0biCzK/6cdm52Jr+Ee9iUrVFxvywICDi9R1gZD8HyyhRH5E5PiHLzw0Md3kyS0NNUO8ctceBQaXBCUUk8ecRVOTPSfQ88uD0uCovFyAFGy9JkB8NZ95fInhsN86sGmF0ccKd5JPUaWOWgAVonzkL+rra3dAJ2A9lKiv9cr+YPkYZvHX1BSIktboIa0NdjrEXvuD8KD9kjorXrEJc1GkWSBzG7x7d/WIzg0jDc3v8+kp0L8o+0YGcNzrnvwWDeomAAgCqHWkf3JwlrsxnufNXR2HSa4A==
Received: from BN9PR03CA0426.namprd03.prod.outlook.com (2603:10b6:408:113::11)
 by DM6PR12MB3913.namprd12.prod.outlook.com (2603:10b6:5:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Sat, 1 May
 2021 21:38:51 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::b5) by BN9PR03CA0426.outlook.office365.com
 (2603:10b6:408:113::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Sat, 1 May 2021 21:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Sat, 1 May 2021 21:38:51 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 1 May
 2021 21:38:51 +0000
Subject: Re: [PATCH v8.1 00/31] Memory Folios
To:     Nicholas Piggin <npiggin@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210430180740.2707166-1-willy@infradead.org>
 <alpine.LSU.2.11.2104301141320.16885@eggly.anvils>
 <1619832406.8taoh84cay.astroid@bobo.none>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <df291e74-383c-cdaf-c4c4-b5ccde3df153@nvidia.com>
Date:   Sat, 1 May 2021 14:38:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1619832406.8taoh84cay.astroid@bobo.none>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0430111a-d1a4-45c0-f2af-08d90ce98333
X-MS-TrafficTypeDiagnostic: DM6PR12MB3913:
X-Microsoft-Antispam-PRVS: <DM6PR12MB391384EE14DFA7EFC68EE7F2A85D9@DM6PR12MB3913.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jHFykTJx6/hHvUBLmGjcuOkeXFiJrSt0pQL+7W3jDGjyE2puHJq9zyX1rHNoT0Vjtc2AGct8oCibcRe6VG6yagye4r1u2XYGnlTzaparUA0DekcFQAKFzmPUdGdjfNVKaysKze5u7K8xGHit7jIRsSOKhgFECJRq2kBZpk1MnofjtnurZlxXEGy4mYsD4sz8UKJ5NNxYTYjALefLMyFRbvXy7hM/JyOpj6VBifZXmivEKRPf5GnHtPWepGPwCVEcsmKxIWvzmsLzzWx4VixlQ3kyQn1tMTjo862YVp50vY63dv+vBC2nTadC3dgMHjCx4vDotqGpcX8QJI9pd3gvPkqIPzfiBpT8QBkdn2ONn23w1yIzfWlQQCO4JH2Uxlz61qgwo7gqKQHANINjD1YB8YLIBEH4flv0beS0H4ijhdTI2hon96Fd+3Ozp6iPEeHCP0jr61JChFkJkjUcR6t12fh4KEAhIj7TOm+RKVKUbSe67MotBzkPuO+cp19wlVjmB1DyEVUq5qqTjXXKgt5ZucsEtbtjEQeDg2sywq4SDrtjjJJAGTO0DGkM0V2W9O85umIEOQqpiebdAUZplLwVQ0AAeYT+JBP1Nl4a6jE60YzsY7c9tn6191yfTk0NK5Z/SZNsOrS+GMflhfZr2hGoWzFHAQnZq3anFDE+iq9CPjNDWs4a5CisDXNBZBEqL/oj
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(36840700001)(46966006)(70586007)(316002)(36756003)(26005)(8676002)(53546011)(16526019)(5660300002)(36860700001)(82740400003)(426003)(31696002)(83380400001)(8936002)(2906002)(7636003)(31686004)(4326008)(478600001)(2616005)(54906003)(356005)(16576012)(186003)(82310400003)(36906005)(110136005)(336012)(86362001)(70206006)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2021 21:38:51.5999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0430111a-d1a4-45c0-f2af-08d90ce98333
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3913
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/30/21 6:32 PM, Nicholas Piggin wrote:
...
>>>   - Big renaming (thanks to peterz):
>>>     - PageFoo() becomes folio_foo()
>>>     - SetFolioFoo() becomes folio_set_foo()
>>>     - ClearFolioFoo() becomes folio_clear_foo()
>>>     - __SetFolioFoo() becomes __folio_set_foo()
>>>     - __ClearFolioFoo() becomes __folio_clear_foo()
>>>     - TestSetPageFoo() becomes folio_test_set_foo()
>>>     - TestClearPageFoo() becomes folio_test_clear_foo()
>>>     - PageHuge() is now folio_hugetlb()
> 
> If you rename these things at the same time, can you make it clear
> they're flags (folio_flag_set_foo())? The weird camel case accessors at
> least make that clear (after you get to know them).
> 

In addition to pointing out that the name was a page flag, the weird
camel case also meant, "if you try to search for this symbol, you will
be defeated", because the darn thing is constructed via macro
concatenation. Which was a reasonable tradeoff of "cannot find it" vs.
"it's extremely simple, and a macro keeps out the bugs when making lots
of these".

Except that over time, it turned out to be not quite that simple, and
people started adding functionality. So now it's "cannot find it, and
it's also got little goodies hiding in there--maybe!".

And now with this change, we have for example:

     #define CLEARPAGEFLAG_NOOP(uname, lname)				\
     static inline void folio_clear_##lname(struct folio *folio) { }	\
     static inline void ClearPage##uname(struct page *page) {  }

...which is both inconsistent, and as Nicholas points out, no longer
obviously a macro-concatenated name.

Given all that, I'd argue for either:

     a) sticking with the camel case ("ClearFolioFoo), or

     b) changing a bunch of the items to actual written-out names. What's
        the harm? We'd end up with a longer file, but one could grep or
        cscope for the names.

thanks,
-- 
John Hubbard
NVIDIA

> We have a set_page_dirty(), so page_set_dirty() would be annoying.
> page_flag_set_dirty() keeps the easy distinction that SetPageDirty()
> provides.
> 
> Thanks,
> Nick
> 
