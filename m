Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11BF62CB55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Nov 2022 21:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbiKPUqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Nov 2022 15:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKPUqC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:46:02 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6CA1CFE6;
        Wed, 16 Nov 2022 12:45:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ohrbm9vmK640FhYnF/RPQufgQboEgBjILIgbk0iMhEWxvoLANF4Qsuuu4LpEMZsQN6angQ7d8QWpRwfInXP6NgbhiwFRQZXFptHsuRqKFM/9/RNsAn0lhQY5DCMBxsUfbleuWZ3ln54cuHcS0yfsjJlhAxL/t5wQskT7Pwoqs/9/f/4U9pGLBS/qQqRF8HynDN4MlQKVV9YbzEaZlaA1z5qypmLGb2jM9E+jaVVSWUbD5hn/PhM4YZBLUDtuG1/7kb1VA4bq0qBWuqZWLsb2qOZKrLo4Su2+6bJhJ/1mWgX7JcNCVg6j5O9LJaV3GS+8F8Jokkhc04xnXkBkwHJ3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CrjtNxLTW3jPW5PQgpeE33v+g8UUrFILnLj40R33c0c=;
 b=DS5EdhW7BsuY87cH73Z55Gd5htmhh45lqPIJZVt0hNJESyL1TA8nAn8Pii6IpkvpmOTd0Zeti1sd7/TLyzIXjsbJUiPfK3jRnBkrroB362P1Na4yEebmngW5CCVlFj6uIlT/vy5AjiETBlKG/nysoO6YTWTKywDbw8PlEaDpSa4ZX+qcEnt7e+/xynJ/EPEXagH7lABwERLPJRPTmUEwNrbJCh6olJa90JpPFQXJpwyMuVP1ZE+J2lSDwEx60DHzdkAFD/nAC3E6w7npOTsnskidUMdZDik6Ao+gEtfd5flhtwQOObx/MsaNE3Ozl0ywK5Tm4yi28chLK3ASDLQ3Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=bytedance.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CrjtNxLTW3jPW5PQgpeE33v+g8UUrFILnLj40R33c0c=;
 b=sorwRJA+fnoF1h2hKUyvzeqB9FamP+caDp9en3yh8hqxDr089/p9DajWCGOLqmUu8FkGyaMV1v7bwqNfqOexVn0d8+Lx0x26raOunTj9G0djqsGf5mX/zVHHDFPIdUWx4ZqhFnSNWbEslO5K+MRThihWXzSB+aG+LFGoTej9tq/MxDzqcfxtY5UpcHBfWdCBUxxYZc6az78Md/AMrq/ad/LH6mQXwAosSFFxNmZ3lW62rS64MsqNxgHEtIaUmELDZFg9KS4ET0CVTwk/mXQSLG5qPME9zSKjN5aHbvFxwBhD9Y5S7qtAgn5zheJuGpU6s/dmHxohT5UCO113PfAkHg==
Received: from MW4PR04CA0174.namprd04.prod.outlook.com (2603:10b6:303:85::29)
 by MN0PR12MB6198.namprd12.prod.outlook.com (2603:10b6:208:3c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 20:45:57 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::e0) by MW4PR04CA0174.outlook.office365.com
 (2603:10b6:303:85::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18 via Frontend
 Transport; Wed, 16 Nov 2022 20:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.8 via Frontend Transport; Wed, 16 Nov 2022 20:45:56 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 16 Nov
 2022 12:45:44 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 16 Nov
 2022 12:45:43 -0800
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 16 Nov 2022 12:45:43 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     <ligang.bdlg@bytedance.com>
CC:     <linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Valentin Schneider" <vschneid@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] sched/numa: add per-process numa_balancing
Date:   Wed, 16 Nov 2022 12:45:40 -0800
Message-ID: <20221116204540.163222-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221027025302.45766-1-ligang.bdlg@bytedance.com>
References: <20221027025302.45766-1-ligang.bdlg@bytedance.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT064:EE_|MN0PR12MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: ea886a98-c424-4683-9720-08dac8138fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7j4CmThscefgrqEUCiwuylGOwQijgZS4guH8U3tudT4MW2t/pJuhbhxj/AhJpTAUL83upyFY8BpJ9ANoRodaPkjEE9zzcL3Gnj74gZpK4VTD98tR8mrFTz5VSiIvKxWiOHzdXkzsZHgqybj4wMnlDY5q4k+fb1SvocYfUohTwgPNaZXLJx/hgujRXX4Z5Zjv+xkfDXAGFSP7XBcQpWdBU0c5d6EgzfOdwRs/retwPPxSkpbsjHz8qt4Tbixs8wtN66T7V4Cle+2N4XnvMVA/KXX/DvXNdMdy1TPWMfIgraZocsoQQrLtSuEEStvso+mPAYoGvmSkwXWsDTJKgiMcB8pvzSaNEm/B2Mk+9FYf9RnKMnxtk0adecfbUa333P1EnZsJG5rIsYuKF3QBbfh6w1BjfmJCKuRKt7cEpHRSp2E2reC9W5Y2Scr50CCsFT7NlsLVcxxRDg5yxje+nHvLW6e6T3tnaugZbb29hlvmGdG6ypjPQGOB4pEKZ6Z95/f7/X1X9s3s1QBj6kGlEfSNQTafKlFI7Qz48pIpi/wyGDPWxpgSOZlrHUb6zRj9qFC+bBxwzGPuVOTSOP3+z9a+axAYlsQwbu4271Xmp3Wvvg9sRxwz3hs3PAnEzAhPvabeR6R9hh/a4ZN1RqU3MAgMUA0LvoDVLGksUsyq5MC8dyI6+bwFAcBtkfAQM6ZMMe5Q7Vo0WAjRxjL8US+SH7ohDouXHwnPHE9+seBCoykrL+dpcdZ+F8McyhofYWd9mhqSjB5xNSO3slOL6SW7f/JFwSJv744CXTvEhWdWVkpVK7JYRySi93FlRXIXzFg55/082+6+t/Fm3x4WTthhFxOquUgXFct8hqvMtn9RzWnNvG9ZlrxLoqqbPWUq6D7WTAif2MQ4YuhR96WTSN8JQKbmuA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(356005)(40460700003)(54906003)(426003)(36756003)(6916009)(7416002)(40480700001)(26005)(83380400001)(2906002)(41300700001)(4744005)(47076005)(336012)(82740400003)(7636003)(86362001)(478600001)(8936002)(2616005)(1076003)(316002)(36860700001)(70586007)(70206006)(82310400005)(5660300002)(4326008)(7696005)(8676002)(186003)(966005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 20:45:56.5533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea886a98-c424-4683-9720-08dac8138fa8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6198
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Gang Li,

If you want this to move forward, you'll likely need to include the
original To: and Cc: people. And also, any new ones who responded with
review comments. I've added here, those that I found in your v4 series
[1].

The message that I'm replying to appears to only be sent to a couple of
generic lists, and so it's going to be invisible to most of those
people.

Also, I already acked this series separately [2], before I saw the
missing Cc's.

[1] https://lore.kernel.org/all/20220929064359.46932-1-ligang.bdlg@bytedance.com/

[2] https://lore.kernel.org/all/49ed07b1-e167-7f94-9986-8e86fb60bb09@nvidia.com/

thanks,
-- 
John Hubbard
NVIDIA
