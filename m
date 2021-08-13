Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56FF3EAF5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 06:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbhHMEmF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 00:42:05 -0400
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com ([40.107.93.85]:14432
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238659AbhHMEmE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 00:42:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0Id2QdDXDWDCQ9pg2uC79ZXK3CzqcRE38hKaS8/oiPLYhCe1VGzb1L3Rspat9/gAUjZoqRrZ7yNzP1Mf6NXi2dncaDKABVIVaXeuGu0le+EVzndpcT+Xi5klPMTM/B/zSj1pYefcqxMYybA347zeh7Uhn1h9pMSHJlVgc8uqJz25EvhTfG2JZHG7nnDEw17zQOdJPlNzrRYoJ7eUf5qEwo3AJgRBDEEUcXsGwmg1qaIECsL0+LEA66tohAcJibKxCKbBMM1X6KwEMzMK//kC+D/CWc+0xwqDiZUeJDdLgoWIMFv9BST3lw15/fP7U4z07T/UyBXpLkV+/BFymuLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0I7PUlOFBEhWujC+EitLHQR3QU54bgs+GKvRXWLYopY=;
 b=Z3tZmmR7EU7olaQHFXbUpzzvdAAdZ135dJSyeyomx9ps0Lp6FH2lvUFojqeRGyFCNWZmbUVpswv/KH0OyWf7I6k93wNg0vQrzRhAnVZ2bZURQR2nePBAHEK4ODOeB46QigFYPBnO7ddslpDHcLgQN4soEUZER7kkteEFDJ19fdjOJWnTmGTfYVwmCkLFVvddVpGsktZBRXEyLu3ciSleE7AQHLBFL/pqQOWDHRDxvfvdsX5QSRh2uk7faGpRoCENUsQLIZH8kRHI7Vrq2Ue/lI74A/E6j1+NBWXM0tSAUq4KA3CvHm2tJEhLX7O/ISHBkhTCdP8uTM6C87fOc+dY9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0I7PUlOFBEhWujC+EitLHQR3QU54bgs+GKvRXWLYopY=;
 b=Hw3u+cNMX/XR5btFWei6zZe5sSZADf+gnMfGXhhzuu7buRD1uI+JsL+3iA+y2qypCu/IEMup/dJfw5IaZTTYFX+Pq/SK1LSMunnDXBEwy+ABSo97CrmHO5Nk33iPBFrCEajJxxkGGgHfsqjHX+9vqKwHGtn5j0xud5sw3Z1w4z4boAqhmljCP57eqRanOsqbUGg9tZTx+UF4EnQvdYp6PTJt3i6XEnjp7IZ1mFlxawpCWO3+jfjB8CPX+X7Rnl4fEz1UJEzSN7hGjpenYJIYluebUxPfqPyhWW3mvnFX9Ra30ZJciTyvk8h99T9htxV+e+XUNA83xQLT8Z/iKv8ing==
Received: from BN9PR03CA0089.namprd03.prod.outlook.com (2603:10b6:408:fc::34)
 by MN2PR12MB4109.namprd12.prod.outlook.com (2603:10b6:208:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14; Fri, 13 Aug
 2021 04:41:36 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::bf) by BN9PR03CA0089.outlook.office365.com
 (2603:10b6:408:fc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Fri, 13 Aug 2021 04:41:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 04:41:35 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 12 Aug
 2021 21:41:35 -0700
Received: from sandstorm.attlocal.net (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 13 Aug 2021 04:41:35 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-s390@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 0/3] A few gup refactorings and documentation updates
Date:   Thu, 12 Aug 2021 21:41:30 -0700
Message-ID: <20210813044133.1536842-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0c33d47-2210-4d80-b792-08d95e14a1d3
X-MS-TrafficTypeDiagnostic: MN2PR12MB4109:
X-Microsoft-Antispam-PRVS: <MN2PR12MB410909599F0B041010C398F5A8FA9@MN2PR12MB4109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: orTKmo2OLiFDP3xM32hQGOnALTmSOidxEnY/uqK5HMd32SEzvgDOkc3vP8wW9iQDoIiKOVn5zXaBiot5Ix1HTd4XjNO6gP2jeijUbMK0isi+0/9SSp6Noq05GYuL1C/hhfBubSJb1t7cVKNVx2iD1EhBzwz1cWg+F1CkeSpGx8UdT2cgO+Jdt1W8gAjv/ACQq2M3YwzrygDhmtxX3kskyYDabVwvmJi6H+a3nkVBj8sH0yJ9+V5Ouvo7YS9/gSSTWESpBq/wrQFREAohot9dCF8ENzGHZ1OXtQE1QvwtD8203+hFhA/ZkTpGHd01yIYcMRcA3sleRKAyVfoTLAwDJlqZssig5Ff4YL6uM7DYu9lQD3OOdvsilH8k9wrzrnOhtadl30qxmyDLUgmopUPENOtD687lR9fj3ZpLH4RcAS250JzrQL3eh+alaHfA1D3vGQVuKh2WA9LvvcP2p1AHYIi2odRhhSAoNPTYhA5h+9aIoWI1qcAar6XE0wxtqBsfV93SCG0Nz+oTuhx8abzfxPBfikcfMMI7/d18mDnHe9RhqM7Mnq31PPhn3dn5u+/60jXiwAFF2Y76hIOvqd1TysxoF/SL6Kk2tG8G5XmKM39eWmTvg/poFDkueEQJc1eQFjdzwVQRE5mHyhs3g0Ii07EPS4+ER7LvJCtSswStiPaY4MDLEg+VI9osb4jlJV/g5X02AnAGLL3IMOkHPyygJgBoZyfAe8p6LMeev1HXju4MAax53K+7WWkyH9gFB79IlVC8iS5wVKLqa9MHKir3ZGn+e8Ugu2g0k3270pvCv1LTro7EoMtsFP5Q/z2obgoxV13vMyqNxCqTFTJrWnxckg==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(36840700001)(82740400003)(83380400001)(6666004)(86362001)(36756003)(2906002)(7636003)(4326008)(356005)(70206006)(82310400003)(7416002)(15650500001)(54906003)(36860700001)(336012)(5660300002)(26005)(107886003)(966005)(426003)(1076003)(186003)(47076005)(2616005)(478600001)(8676002)(316002)(70586007)(6916009)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 04:41:35.5120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c33d47-2210-4d80-b792-08d95e14a1d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Here is what's new for v3:

* Removed __maybe_unused from try_grab_compound_head
* Removed some unnecessary comparisons against NULL.
* Added Christoph's Reviewed-by tags to patches 2 and 3

Changes in v2:

* Changed refs to @refs, and added some more documentation as well.
* Completely removed try_get_page(). (I'm adding more people and lists
  to Cc, because of those call site changes.) * Reversed the logic in
try_grab_page() to make it a touch more
  readable.
* Rebased to linux-next (next-20210810).

Original v2 is here:
https://lore.kernel.org/r/20210811070542.3403116-1-jhubbard@nvidia.com

Here is the v1 cover letter, edited slightly to keep up with the latest
story.

While reviewing some of the other things going on around gup.c, I
noticed that the documentation was wrong for a few of the routines that
I wrote. And then I noticed that there was some significant code
duplication too. So this fixes those issues.

This is not entirely risk-free, but after looking closely at this, I
think it's actually a useful improvement, getting rid of the code
duplication here.

However, it is possible I've overlooked something. I did some local LTP
and other testing on an x86 test machine but failed to find any problems
yet.

Original v1 is here:
https://lore.kernel.org/r/20210808235018.1924918-1-jhubbard@nvidia.com



John Hubbard (3):
  mm/gup: documentation corrections for gup/pup
  mm/gup: small refactoring: simplify try_grab_page()
  mm/gup: Remove try_get_page(), call try_get_compound_head() directly

 arch/s390/mm/fault.c |  2 +-
 fs/pipe.c            |  2 +-
 include/linux/mm.h   | 14 ++------
 mm/gup.c             | 83 ++++++++++++++++++++++----------------------
 4 files changed, 47 insertions(+), 54 deletions(-)

-- 
2.32.0

