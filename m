Return-Path: <linux-fsdevel+bounces-78-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E01D7C580B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 17:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D692928248E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CDF208AB;
	Wed, 11 Oct 2023 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ePYJptlP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8520220332
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 15:27:10 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2072.outbound.protection.outlook.com [40.107.96.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F0798
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 08:27:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5T/Nm4gX5Mi/w0O5rAc4BDurlJUiTBe7ZcygF9n032R3klbxVAp97d+HzvvRpnnyAGkOdE/2NDuZMln+XTiRdsK/2aQL7BkcLe95hjQ+lfiWFAzS9bL6BqxwCu52dXDs+MvoGq6IYfFL83xqq9MINk56q71rO7e/g1fYrPkHbah11GrzR+Dyu7v0hgi27EY5TrWRHxnAMowFw/QdF7GGvsn9jLlTHVWC+9rpF0EBwn+alJ4um4aiu++rIPMMOIWhtnRrGqfOma6s/Anf5MTqp/7kASdlsEd2ogMmiF4M3SZzvlOxjAnXn+F4vmKvm7Uce8VeUt+zXvykwCtb/TyhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aoJV1AMClfetEybnmXpYoRqcDFzFBRnxfDJZV6meKLA=;
 b=O+giksGx7keu+dTnCS0QpCo+Av5EuKvjC6//KzFGFNKCa5ToPYkCyoUrgxRcU3SO9wKhO14DTgj/z0+oilR9OAj2KkMjbG4bIciG4Pp1UhFNi0xMdeFF8ZzcDbc31QH097ea2QzZR9FmI8lF+JuvtiZUPvZ0siszE3JL37rlrOUVSfQinM4C96x5LW/AgqaUyWGeO0Vwb4s4f4UFYpEBzJPUV7nbW2Ju9M46lNLcQMMdSYBYr9IJLMVhmJQ6XZQQHRZ1/yNkMiUefST+wQXtF1MhzheqotDhYyHUTYSW/nFOxrh524RQnsR9Hh88frR4rSJwtCioMeB6dMeed3fuEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoJV1AMClfetEybnmXpYoRqcDFzFBRnxfDJZV6meKLA=;
 b=ePYJptlP4HBAgV5eM+XfF625bTmB96Tf2daLZvb6x/19+JNdeyAsBGYeiyUsnxwWWJyq3jt10dEb/WyKg/4s8JmLgiMnPVKEpylHnMLslNdk5EoAlGoHIC/kJiBrXAKrez8X9DE12d2n4sOC18g/X0SWHckL2prrY0g1wggEqsdsBemseP5eUgaRLM+fZY9E3SIMd1v2HzWlIa9khcY1JRwfzA7u1IbVsJs6EHRQwRCjHktThA7ntNHFcwMPIoq3DdAnkSpxcA8bwwBsmgQkqgzKF168TZ2kqpm8SmwDnxYCqRHJEg1hj0nbETr7/EopCToKpaLtYOccWc9L0/wOTA==
Received: from SA0PR11CA0123.namprd11.prod.outlook.com (2603:10b6:806:131::8)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Wed, 11 Oct
 2023 15:27:07 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:131:cafe::77) by SA0PR11CA0123.outlook.office365.com
 (2603:10b6:806:131::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.27 via Frontend
 Transport; Wed, 11 Oct 2023 15:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 15:27:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 08:26:49 -0700
Received: from fedora.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 11 Oct
 2023 08:26:47 -0700
User-agent: mu4e 1.8.11; emacs 28.2
From: Vlad Buslov <vladbu@nvidia.com>
To: Chuck Lever <chuck.lever@oracle.com>
CC: <linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>,
	Gal Pressman <gal@nvidia.com>
Subject: memleak in libfs report
Date: Wed, 11 Oct 2023 18:15:58 +0300
Message-ID: <87y1g9xjre.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f63d84a-4f72-402a-c7ed-08dbca6e875e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YxYgXWMtGmkv9poDTTct+uDYA5Jne3x/ZkQs/go1e59Gaa6/arxFnZ3yNezyLYqN/ksaFhrBjHV6Zltf9FH2OQPe+2UmLBLfO5kpnQlzgEOY80SsjDowsqwNCBd7WIwvhFLwBSIcI6b5fpwlXe3HL1Dg98aaktyJ7eBQsZb5t4ng3UKsNoXwbu0L350NoZomH6PhJdu0YE5MNZcHU9QdLXTJ9qCnytBQk89aNX6V5ZapQFRQ2RrAE6WIuO/xusUQwIyOc3iWMq/0iI1QNAKhkUT3nctjhFoyCK3Is/d0wjWVnctmoqinTdMceepmOgNVXWEvcyrWpCKs9/4GRhyqxKvZ/vSvf56Bcdn9P1Z10TA2CdmqcqFA0odwDDePzv2E9Rgzo37cPax/N2B8XZORc7M+fgooAh2XaaAeEDrM++04E7ayYOrK1ecQ3IHZiZ3Z/fe5JWirhCy1xYBHEWfu4zArv4VY8Y9ZujKLyo2azEJYPMARrWXtH0wVg3tvM/tdl/fFf5CXgChev3tBzKE5uC9eRoQRiup024TlnJA2ycuU/CRAtE/nQPaJPZAVT7xwogZnhbnl7DzuhRgn75Ec+1LhULJsxaqo/euRgsUs7su6awYTWKRR8arL+pfLkP36Gz6TyV8qWKT1StX5tp2T5JLNZTp4zvWnrcQDFiqO0VB4SC+imHPm3lYl3CidsgAQPYP+0uGwP7oCrSuzc0SFOnXPwstA2irWd749b6O3726XZN+5I4xASYLy6YkW6P6bRn7m1bBp9VQrPgPUqo6tQA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(16526019)(26005)(426003)(336012)(2616005)(82740400003)(40460700003)(86362001)(36756003)(40480700001)(3480700007)(7636003)(356005)(4326008)(478600001)(2906002)(8676002)(7696005)(107886003)(36860700001)(41300700001)(8936002)(47076005)(6666004)(6916009)(316002)(5660300002)(54906003)(70586007)(70206006)(505234007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 15:27:06.8156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f63d84a-4f72-402a-c7ed-08dbca6e875e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Chuck,

We have been getting memleaks in offset_ctx->xa in our networking tests:

unreferenced object 0xffff8881004cd080 (size 576):
  comm "systemd", pid 1, jiffies 4294893373 (age 1992.864s)
  hex dump (first 32 bytes):
    00 00 06 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    38 5c 7c 02 81 88 ff ff 98 d0 4c 00 81 88 ff ff  8\|.......L.....
  backtrace:
    [<000000000f554608>] xas_alloc+0x306/0x430
    [<0000000075537d52>] xas_create+0x4b4/0xc80
    [<00000000a927aab2>] xas_store+0x73/0x1680
    [<0000000020a61203>] __xa_alloc+0x1d8/0x2d0
    [<00000000ae300af2>] __xa_alloc_cyclic+0xf1/0x310
    [<000000001032332c>] simple_offset_add+0xd8/0x170
    [<0000000073229fad>] shmem_mknod+0xbf/0x180
    [<00000000242520ce>] vfs_mknod+0x3b0/0x5c0
    [<000000001ef218dd>] unix_bind+0x2c2/0xdb0
    [<0000000009b9a8dd>] __sys_bind+0x127/0x1e0
    [<000000003c949fbb>] __x64_sys_bind+0x6e/0xb0
    [<00000000b8a767c7>] do_syscall_64+0x3d/0x90
    [<000000006132ae0d>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

It looks like those may be caused by recent commit 6faddda69f62 ("libfs:
Add directory operations for stable offsets") but we don't have a proper
reproduction, just sometimes arbitrary getting the memleak complains
during/after the regression run.

Regards,
Vlad

