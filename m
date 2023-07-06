Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB98749664
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 09:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjGFHa2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 03:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233811AbjGFHaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 03:30:22 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2096.outbound.protection.outlook.com [40.107.117.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BC31BFB;
        Thu,  6 Jul 2023 00:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DebCL+fXHVPShfWqhiaLRYwZ4R2FnBwsk+bhmZv62XvSCniU8fQcilpZEDPRElnZlo1Cv5chwJu5tOeVC2BpUkCpiAXjg+TDbJ+6aCJF4l8pCEdSQsZjw6aiQ/Gxtc2iyomYaqZt6OMHaHvPgiL3+w5WeajtYMwaU2h0UOJSMzyKH7tCAxBun0DWIg6P50ZragOR/Hkuo5FsLgoCwcU3eG5Nnsw/WFFgOIzGt1HrsDZlguD4EmtkCriuP3HTrrjvqPtnk/o68ESaxyDTapCMeRXH2H26Ko4nMzs4L0RQZMxiD2bnlFzet9A8G7NvWfrXZJdTn+ERSs1GjWF7ZIBYdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TzezPexohaz8vxtuHzCJVbHrCTYOj+KbPTqJU3N0qs=;
 b=E/zX47NoUctk3bPLGiezaCExaZ1DhzGFoRTBeoiBtrbtYFv54lLgxt7LOhkkEQItC5gQovAuMOck6EFSs5+oKM6hryTOPqUfFwpnTGEK/cg1aU72kK2gjDS8kxdoWb2PUtoTFHD3IDsAAhIXPJHsQs/JHqNh4Bo6w4XIwnlX8BVrRuJWNjMdtzYHFBe1bd1gQCSuoID3wYCJB+k3b0GMNjdITKDqVQ67D6e++zc1lQ0pWRv56d23RPBtjZEGlaD2OlGp4htDiSQ0eP6lu6yEIIGJwvtgmtjNYV/Z4zDda8iemkT1FbzXFLijeJt7spUV0CDqvZNzhCM2s6LKK4p12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TzezPexohaz8vxtuHzCJVbHrCTYOj+KbPTqJU3N0qs=;
 b=pef6et6z3BT+zYebbnEwtzO21/SKWdLKAG2AV+ZNi5VIb75BNp0IYOYzrEvjFqVSb5jWC85ShE+zP8jiLAfKV4pyZeQ29i0KQPMQR4T77QTj6leet/hbj5bX7J+cL7/5RAepNE5NBzSVFDCrGp5b/OQf6bGnqJqwucqO9w6qcsBXOm5PnSTnRVX1qabbTzeNOqla2ZFIH/r0stoaTufrpIEbNPCQaMBJAhI4fe694BmuZLzybg5cM2jl4+L0FuK6z3tfxj3116qXjwVZbz1Ro04bEf/8DMi3KSSDDok+E2qdykHZy5HhMWHUqClL40r+lujpQ0pHZzvYO6NGWGDvfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 SI2PR06MB4316.apcprd06.prod.outlook.com (2603:1096:4:155::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Thu, 6 Jul 2023 07:30:16 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::c2b:41ab:3b14:f920%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:30:16 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE (KVM)),
        linux-kernel@vger.kernel.org (open list)
Cc:     Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] virt: kvm: Replace define function
Date:   Thu,  6 Jul 2023 15:29:53 +0800
Message-Id: <20230706072954.4881-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0163.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::31) To SG2PR06MB5288.apcprd06.prod.outlook.com
 (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|SI2PR06MB4316:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7ddf8f-6c49-428d-46bb-08db7df2d813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZ2II0XLmzbiNOHlKArTuiq1LmjNDRbdpoM95rz5G4z54wNC9Pj0p13mpZCRUBCHlv0gwTih3OI6DA1SY0f/3kdb8BCkdjV/yYxRY2k+QLZv5l0Ua3TFKFBJRM3IfhS3BkAN4CCR7YM+X83rJx5tjwW2L6vH1nAzyaFucrIcVn1aMgXFcVR5d3FUV78p142bn9NdA8ZRuxT6gy0g7EfSDvCRil5lStnIiE2bXKv6NoBu2xnt5ugGZw6E4qBlNAyBbHDDaL2K4kRi5AHvUrlR74tva7Vjiy05IM9djSeBDU3GtymbI+ktV2yDDyW3GTfgTnLjWdcuvEP0+HXZz0P8zdqRfCwgI09Pg9lzSiobiBTCOYVOa4yY5YqjYGGDJiJyPZ+iRr8jQvkPOb6Z/3h5AvNbgi0nswWtn0HMYdAIIAIHcpimzZYnxCaxZFpLBE1dovKAyHAnQLO5p2llpHgEZrCM5e1Fuzl23LAYf3yTn8ON2dSVhzT9FlU0zY2XOyvi12bhD1GajwG9erVGgPZjlzPtwAkxGDJw31XOFLzjeXb8GLNS4t65yZfnuk5t5TP6er6jxEKZkpso1AJrD7t8TUqUmAzeisc4nnjW9ACi4ISg3VZ3Un+Y4uWq2DfdwvWc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(38100700002)(38350700002)(66556008)(66476007)(2616005)(316002)(66946007)(5660300002)(8936002)(41300700001)(4326008)(86362001)(8676002)(2906002)(4744005)(6506007)(52116002)(186003)(107886003)(1076003)(6666004)(6486002)(83380400001)(26005)(478600001)(6512007)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l5mxHrs8NPwYEz3vXH8tkgd3jN+XjUIN0OjLClM+Cp/D+7jm3Wrn4ug7jv94?=
 =?us-ascii?Q?nVq4bLP8hsYhSuSo12D69QBbRcWeuhen1+hbu3q2uYTGspuh/ic0Dy0s1q8a?=
 =?us-ascii?Q?M21J3TjVILfA1xDWgqoe5plPwAI41JdZ6aCbOusNkd04NFltK3uJQG8xzQ04?=
 =?us-ascii?Q?4ik+8nIF191C37phCJ4Nrqh4CpvxdzIVNFXJP/9dJ/iuzfwryCxJEEMr0l5P?=
 =?us-ascii?Q?ghGcPp/RdpUVLVuRO3c1vmfdy1k0lg8BerENLYdLUIrY6+TSbkUz2NZf0Oet?=
 =?us-ascii?Q?fNJE0KhQdUTerDdUeXxgl5roYs86aZV43jozdowoz+QmzS1elxChwrMcvdw+?=
 =?us-ascii?Q?4CQD8giTAt64rCoxmdDDbdJ5U0Ij3d0eutyxZZ4gVS7ym9hdrIGwPyLIby0A?=
 =?us-ascii?Q?1sxzmu3Y/36ey7H4hYUKROeMq4fPABPKdteKVKvgYsWfNn+cNfxDlGmksWbK?=
 =?us-ascii?Q?Q+Rbrt1hDwrJJ173ZvnFXWwXF+o4bUdSOkzC9g9RGDvKCseZ/4HHKODQGSty?=
 =?us-ascii?Q?BhTHJuw5QFoIHOpGkYuBQCpJV2lLFcw9Te83IfUqmruiB9qo8hoQLgVYNOkj?=
 =?us-ascii?Q?pZE/YYliOdGwQjFKhPGHa+bx/5kEcEgyBxeW9Hjw/SZP+sqlkybmr/uH80Jo?=
 =?us-ascii?Q?rbXwsOY1J2+kkZtjiJUcitb0HNmpXUKLKMysumxzMTq3g964ROgLOzkD6c2c?=
 =?us-ascii?Q?wf+l1M/Hwn7fk1eGVeTiXkS9n9+mM4VqpVScDGsJb9yDrOZ7WKvJk+FwSfIj?=
 =?us-ascii?Q?uoUZy6zCwDUx3oP3Wz7c5T7RzF6HyL1PNEsCtN9s5xBlGg6rbQB0z1DdnUw5?=
 =?us-ascii?Q?JLfZzPd4PBwnTavTui2ztlVupZxmQ2Y2aNCfAVp6QjC35BEry8kpoCWKDUvr?=
 =?us-ascii?Q?uof4m2TitgBe7wj5F/0z8Nlj2zqBMIfVxMwZ9Uvv3z3pIA4i1Uo/c5Am0ixI?=
 =?us-ascii?Q?FYXQqpQYDC4lmEkC3rf3cMGLicEtYfzYuISdxmTD/2XmvFRv0e9gleMzIP7z?=
 =?us-ascii?Q?qjxq+aUZEh+pawM2Dd+uhQdToyHQUIjP03SDHd/9V9KlOUzdFxrbnyeyWh/D?=
 =?us-ascii?Q?ZxP1AEZhn0RWoXH7X/ibIPDM6X2QgPb4BKtXcLN3eg+v2yXbjfOo0YT/YiiH?=
 =?us-ascii?Q?TYiiJVeskfuJm+1DXO0c9VrinoxdSNjSB9kkFwBc5ABrddmle3JjXr0aOtdY?=
 =?us-ascii?Q?IRfzb8bpyPWhtgdRWQlLMwU8joTDQID1Xw5NVUxoAFS1tw9KNuFB92k8me7/?=
 =?us-ascii?Q?3byqZ9zNZf/yhC2IaAG8kHUiQvASh+coWl7F2fLYwmHROvEKkh9WX+EY/Rqw?=
 =?us-ascii?Q?3QA+o3Y/hNmZ388PrhB4lcQBOX4Jzr/HYClYpEyHW+yiKOhJL9QRWck0+qWj?=
 =?us-ascii?Q?kq5l1K/sFiy2WOaQAQsVuXtoltbx3mfHlOUEHi6UsDEdxWmYhkPJqmnWRvqk?=
 =?us-ascii?Q?kTZguT4zAWZzE35nx+U59QGWWfT1k3qJZKuc3SpAFoqDrZp7J8fdWr/K0tFU?=
 =?us-ascii?Q?ujUaSgizK4PtaZhUvy4tASGSox3/dHcQNmtf8pyWiknb5J7gZC2rE3AmCnnm?=
 =?us-ascii?Q?x3s4a4J3Jf1rlbO6L0xF4Pp6fI4pS7Kvp1PieQa9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7ddf8f-6c49-428d-46bb-08db7df2d813
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:30:16.5852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jc40wpLGDdPnEIiCvpoTo5M69ob7oF+J629x5d+0aipzJnw3t1sgcZpBqwY0IBLPKH3HcApUfQ6c7Pts8LnV6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4316
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dfbaafbe3..ec1fabfbd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3880,7 +3880,7 @@ static int vcpu_get_pid(void *data, u64 *val)
 	return 0;
 }
 
-DEFINE_SIMPLE_ATTRIBUTE(vcpu_get_pid_fops, vcpu_get_pid, NULL, "%llu\n");
+DEFINE_DEBUGFS_ATTRIBUTE(vcpu_get_pid_fops, vcpu_get_pid, NULL, "%llu\n");
 
 static void kvm_create_vcpu_debugfs(struct kvm_vcpu *vcpu)
 {
-- 
2.39.0

