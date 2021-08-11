Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6FE3E8AB8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 09:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhHKHGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 03:06:14 -0400
Received: from mail-bn8nam11on2069.outbound.protection.outlook.com ([40.107.236.69]:26176
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234960AbhHKHGN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 03:06:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4g7Zej2bps7myysB9dEPA1PVUnbk9DHEPcUgDJZ1Xlz6naYfaCAi9W6ToicvnVMai4biKIKhczA08/pNmasd5Rk9KTe2ycIeV7f56I8NUuTyCk+IslpnsAO+N5PCFdCXoSRwnBEjxdhcy+NwUV+Py6JxJ01z6DKfdM7D4akAIS3ZgEtBLsWVdZJv4R9h0PTrvm6apTRWZlnhf6+Y7OuMVE036z6U9kLvtuSwsiaEy5MgAs/3EAF/c/F+OUNEhlMR7MJcqztgLft7m8RtaEu654vkTd4Dh1jVi1/pqrSPLxrOuklRRMIgJjHHdsTEa/6fRix/emClIOHaRrdtLAQnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7i/UDoKV5J2rdtNQ34m66mc0jlQo77TgvUA4NI5/ZM=;
 b=UcpE9p/ktIuqZ3671Ij120NS8rv7O+1Kepe12dCaf8hs+PNhUy55U0gUtoPWQYK5KBT89nQzVziZh0kibf6laXKiV3gUfzXaXSu4F3U7Azcy24O5nE6/+PVPvTzjkWe/H3NZxgxwo9nZnpm+b9+9hlhzSRIUa9Yf4Z38hlgGdaWDgOHJE2XlWtL/0RdvY6U+Lw3G7tbS5k7dybambwb5Kxsk8vN3H0UllnfDDSxVoS0/8IJJxKYMnNI5Ne1KIsHbnRD4bnJIKhqgNNHJ9xCYAVEMZP3CgVYVYFpmgZcHZWXNz4OkqHf7Njr8uu0n2CMoDcyShZNjp+XJtid7wmptug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7i/UDoKV5J2rdtNQ34m66mc0jlQo77TgvUA4NI5/ZM=;
 b=n+m0252AKt50hw7I1Gcuye5mNyrZioaO5Df3zkK6vQQuhJiS680kIlp+OHQPFjbfGWmCwFkDqwc+HcTuiv9LlBn7l637UEOnOTa//zGLKxZWiUcra/V2GMoriCfT1Fxn0tOil+NkqowOMgARl8SHNYB4jb3GkkXQYK4zwyPforFWTP2hxKSRILFNHxTa9BMGIluzjmQ3putDdty3GWsEUpcwLcJZ4LgAYDqHauwvqYN4jtmbJ0LcreZXTdya4ZcGl+pRaGq+/Aw6fq+2mfzZGWiYQvwgyiMMiTaAIfBo/Iz1Bq8mWMDNBTunlJi0PcpJQF2nuUHLEXLbGstDr95/sA==
Received: from BN6PR1401CA0020.namprd14.prod.outlook.com
 (2603:10b6:405:4b::30) by BY5PR12MB4145.namprd12.prod.outlook.com
 (2603:10b6:a03:212::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Wed, 11 Aug
 2021 07:05:48 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::8c) by BN6PR1401CA0020.outlook.office365.com
 (2603:10b6:405:4b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Wed, 11 Aug 2021 07:05:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4415.16 via Frontend Transport; Wed, 11 Aug 2021 07:05:47 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 11 Aug
 2021 07:05:47 +0000
Received: from sandstorm.attlocal.net (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 11 Aug 2021 00:05:46 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-s390@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/3] A few gup refactorings and documentation updates
Date:   Wed, 11 Aug 2021 00:05:39 -0700
Message-ID: <20210811070542.3403116-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb11b7c3-0756-4bda-ead4-08d95c96721c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4145:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41459FD30F8766A9EF45186AA8F89@BY5PR12MB4145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /I/2dEYzdqm74Zreh/SHh4Tq/9lxzuFxa/EqaeVcJI7RIIEtEL0sNnJbgSgmBZVVmRMzCVqReCxiz547S1PU8EydEZ9RtIbucPlTbak3/srSFDyTdUwfwMXtNJw04iEZ6uM+EBrz4ZsHPTA2VgoCJnHXdjWSKXwVzszbf07IU8i7B335KWhC7DSgQ4Cn3wqvUXF7YHb9N7++A9pB4XTLwzZFcXzjMXZrw19iA9f49UwtvrbqRN9s+KqbpqhrE4wN330AbkRB31bowaboVvZT1pUVeF/LIchyiwq9kW61bW8sIqah4Ullkg3xjSPJPt9+XivJ+ZkQhjJnRrGWlVw23NKfx036r80cmxoJyTcr2d7lqc5aW0u6zNlgWydSIvMMdalZBexmqv32Xfki9Y37RgP1FgKs1KTPJscQFWQi+sq0QvTtYnnq8BdCFzZIP3QbxXLU8JazGxjRa5pPdiT0wIEN4B5/x8n8a/AH3sreqYq/wQ66k+wHe5zy1HrwjQrdW2tQuzneF3uLpsuDAUkWq2vAREeTWJEvmFVnG5gwziuYw3Dw9SxhOHHjDvyTex1yYFtffmqkhJqIQExHkjtNAgBovn8ZiLvACjXtRFlKYMi7yCqWph3VCxzfcS+RpyHzA7+Dt5vfre8ZakuvD0KleHDHXxhMwUoph/d4d16qqz8CJlP1eroLu7CFIuX7aQlfrUhci/JxkQWnfskLrhhQrYSI7ft7sFN0us6Mrroa/YpU0oN+XxywmTgoNLY7v0EuQ47FInsjWbnKz6AqBABCgD4S9LRCltaV3raqgnoJxmE=
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(36840700001)(46966006)(54906003)(36906005)(316002)(336012)(26005)(6916009)(70586007)(1076003)(82310400003)(107886003)(356005)(82740400003)(15650500001)(8676002)(426003)(86362001)(70206006)(36756003)(7636003)(478600001)(47076005)(6666004)(5660300002)(2906002)(966005)(2616005)(4326008)(186003)(83380400001)(36860700001)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 07:05:47.7314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb11b7c3-0756-4bda-ead4-08d95c96721c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

OK, here is v2 with changes as recommended by Christoph Hellwig and
Matthew Wilcox (thanks!):

* Changed refs to @refs, and added some more documentation as well.

* Completely removed try_get_page(). (I'm adding more people and lists
to Cc, because of those call site changes.)

* Reversed the logic in try_grab_page() to make it a touch more
  readable.

Also, this has been rebased to today's linux-next (next-20210810), and
re-tested on that.

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

And the original v1 is here:
https://lore.kernel.org/r/20210808235018.1924918-1-jhubbard@nvidia.com

John Hubbard (3):
  mm/gup: documentation corrections for gup/pup
  mm/gup: small refactoring: simplify try_grab_page()
  mm/gup: Remove try_get_page(), call try_get_compound_head() directly

 arch/s390/mm/fault.c |  2 +-
 fs/pipe.c            |  2 +-
 include/linux/mm.h   | 10 +-----
 mm/gup.c             | 79 ++++++++++++++++++++++----------------------
 4 files changed, 43 insertions(+), 50 deletions(-)

--
2.32.0

