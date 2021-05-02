Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9410D37096D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 May 2021 02:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhEBAqB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 May 2021 20:46:01 -0400
Received: from mail-co1nam11on2051.outbound.protection.outlook.com ([40.107.220.51]:31584
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231655AbhEBAqB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 May 2021 20:46:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCTGbWvELFCfXtUcZuqJ45508kEnJU7LeukSqiPhDrMyzawXyJ3XIBfKaOwW8xJeM6JCauIG4dx4/vloicL84lcJuBwSjklP5oneCeYm9PgDDw4aATQtC3ana51igyCajs3hKvjie6lToGE8+CoBUK3DSt+uUwhFSOFg2hgzjAAJlRsEenMQpH3QCOxpWnjaiQq9DQ+e7F28MzaZWV4xB3LGEIhpQBNWGpWL7c3H+WYLvuqfcXQJ9SAzXu/JA3zeOs4gFTWI4YLf70reiQkiVc43LZkfcD5Lp4tnM+LAnwy5ITvxo2LT517iow0EBRQFyz13P49oY6X7C0ppj/40mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGUKPrV7TKcpcO+9ni79bTbCoxPfCNWSpafREtv1Wuw=;
 b=Ok0NsApEJYLYDMEE7WuH9P/8FMQzqBtbDcnIS6HYb5+VSnFKO+g5DKwjeWF5AZG2bX5w9hnTZX4VLw9vlfAe87aj8fo1iQfhXMKI+Cj5tKZWlZBxZkavKHWdgT+pfWqBjBIoGVPlXwTOnxcPyWAvEu4/IkBE5xB/ZwTjEkzL/WqlOREGqTxRlLZ7SEX8h68fBVf+Lr696sJmm/ZYRHXbSEODHKpypBiNZ5mfUmtWYttYxDKFL0D59HjxS6vh68l/iSAcwT3d1aVVAy7UScfpALQNtA2bA+yRGoZtcYDPICTrK7+WnFtaL6ciyEHMiHWvufS1uoDrYOZGyDreHYLktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGUKPrV7TKcpcO+9ni79bTbCoxPfCNWSpafREtv1Wuw=;
 b=rPq4wgKGSqoGJzHe1o22oZrPPA5KQxuxRYIZQ3xR+mZ14kK8hxLtA4OnU0x+tvLhHBZsdHR1o5X4TEYmi2bf90kBLAWjnUb9p2a2qiGCPu5h8ExBwxb7EPOeIlP6KLNW3MMAaEsSOfgS9bjgHkhDl24q9P4IxZnXrTTtyDkHEW0VvdjkIFDZKtm/eSwI+S4QAANLYWNO3i7+lOA/TaKAczzk/d03y0QIPDcgdaSFIDqgv17GZWCtYppsc1Th2nqUx753Y+pHxpw0BIlJO5yQcu7KIy7toyZCQ0Z1IDK8nUA1J4WvM4jt8Dt52ztTmqzgIYSH0H20JFTNnYrfEWcSeg==
Received: from DM6PR04CA0002.namprd04.prod.outlook.com (2603:10b6:5:334::7) by
 DM5PR12MB1691.namprd12.prod.outlook.com (2603:10b6:4:8::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25; Sun, 2 May 2021 00:45:08 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::3e) by DM6PR04CA0002.outlook.office365.com
 (2603:10b6:5:334::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Sun, 2 May 2021 00:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Sun, 2 May 2021 00:45:08 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 2 May
 2021 00:45:06 +0000
Subject: Re: [PATCH v8.1 00/31] Memory Folios
From:   John Hubbard <jhubbard@nvidia.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Nicholas Piggin <npiggin@gmail.com>,
        Hugh Dickins <hughd@google.com>, <akpm@linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210430180740.2707166-1-willy@infradead.org>
 <alpine.LSU.2.11.2104301141320.16885@eggly.anvils>
 <1619832406.8taoh84cay.astroid@bobo.none>
 <df291e74-383c-cdaf-c4c4-b5ccde3df153@nvidia.com>
 <20210502001705.GW1847222@casper.infradead.org>
 <f8c968d9-e66a-3588-3811-3efe704650ae@nvidia.com>
Message-ID: <4c12edc2-c9a5-9367-7387-2af122d84d16@nvidia.com>
Date:   Sat, 1 May 2021 17:45:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <f8c968d9-e66a-3588-3811-3efe704650ae@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 102479ab-bbff-4a0c-c2d1-08d90d038924
X-MS-TrafficTypeDiagnostic: DM5PR12MB1691:
X-Microsoft-Antispam-PRVS: <DM5PR12MB16911DF9249B4F99DFAE22A4A85C9@DM5PR12MB1691.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TP4XGxpLtfwEf36eay6xWmDjfnC9FnAmQ+MKYLmT1O5rjnBbSgtjq5+taRXx5+TmDpxYj6NvqsQ1taISFMnpVy86COF6Ym6lDlLH9VG/3lP0W7UQsYpLonk7FFu9iREPGDEwUY13MQqoM961AKQ5qTiMTSgFt5EN5smKRy6wMYlZ5ZnsoqTZOmB9qQ9S8oTgga22S+LYb2VTLqUY+2SMzxIZg4oOpa9xukwV1lpWwFRGthLBBg/nQ2gjVWE35cAk4gY6vVKDy686XJNH7JzrvAakzt/rBSNEw6PsXwcg3Df+K4+8ACYe0alv2PgLdIir66zWA6+ctr5z/lq73wyJWu8VNiAGp+vIn4Xy/PQUvI1RoJ8YbPi4enF9ioTuZI5QgAwlKzhPWR/79sIQ1FRAIaTMwWr2aSD1BYZSDgOj/Ykva8O/rrMnNTFcpNUN6JhpMNB0G3XCq4OPu+rxLjwalWh2hJwrL+5FaiTKBdnavufQa6MHmwy9Fjm1wVqumP5J7F+6uY8RVcTMME52Ru7S7Gw7OLm28OgyogFMd/scqsXCSW2EJo3ld+9vSDc+TAjXndTLx27iZQ0ReUguYFf7a973ndWDsdFt3NI9yQ3XEJJzs0ONxQf2ybaBNmzgCmDc2E96kljGP9STdx3OVUjxFjGGi8+S1KgJsC8KLdCg1fs5TCrk+LNdR0W29D4wlTQK
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(46966006)(36840700001)(36906005)(16526019)(16576012)(316002)(36860700001)(47076005)(426003)(186003)(8936002)(82310400003)(8676002)(54906003)(26005)(70206006)(6916009)(2616005)(86362001)(70586007)(31686004)(5660300002)(558084003)(82740400003)(336012)(31696002)(2906002)(478600001)(53546011)(4326008)(36756003)(7636003)(356005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2021 00:45:08.5417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 102479ab-bbff-4a0c-c2d1-08d90d038924
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1691
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/1/21 5:42 PM, John Hubbard wrote:
> If "kernel-doc" is effectively a proxy for "file names are directly visible
> in the source code, then I'm a lot happier than I was, yes. :)

umm, s/file names/function names/ , please.

  thanks,
-- 
John Hubbard
NVIDIA
