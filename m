Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4255B1F0C33
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jun 2020 17:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgFGPA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Jun 2020 11:00:26 -0400
Received: from mail-eopbgr40130.outbound.protection.outlook.com ([40.107.4.130]:62749
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbgFGPAZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Jun 2020 11:00:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwPinMB7I61IGTEeWsdoTjQnwzwAc4dQFpYPylJhRdL66HjavqiphwcUcum5Wzot1Q09fxS+fmGLxedH9WwRtdo5wCaSX5S4ZX7GsJVw6ALtAAZ3XusvvY0EcUh9pY6fYFvvkNixSmwQsJXeAFnAomfTPasLUljXm0TnmDw68/Z3plv1vWZF4MWp59QfEtO74+bX+PvjacmzAOgUgkx9qM3isZR/nPc36/svSfzheinjJYBnw1f/v60guamBmjtKIbvrL5N8B047ruc8cw9HIlF3H1x+IHQwTPuJJvI2sUztCLdrYylW9DLz5kuhXUtRCp8djJS/ZHcbvTUHznVAFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzzGAWkpqbMaNlYBdkhrlVjx85syVGN8ecR0PZcbUrM=;
 b=IYrbXD4iCL/lEUuxPRaACtk8IwN1UsardZL+Rae81Y5y0YNM8i+gpB13sCyN2PPDS1ONOkbHN8DkX4ghJ+ygBmZ7eAoRX0UoXyx6H0cGgMQXrTMD52BzuXqc2dpb4NWf9ST/MAc0XB07MzFI2SrVxm+SYtvx3y44H/1n3zhW0XSNBRQ5UUx0L7Cx3DXSEx1mKylUnAfkw2gfvO7WAvCc2soRDhJdweXCcHE8MSVsf/h+aw1Z3qlEGYN1xvfBlD64Pqdnt77BlHSxtpFX/a9Lr4VM0sgDZ8wZSN2J+WkWj/bccE4MBSEfGJgxmKNcEZMIYZ2c/Je6OHQmkJ1yR6zsqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzzGAWkpqbMaNlYBdkhrlVjx85syVGN8ecR0PZcbUrM=;
 b=A2MOyiJp0aMpR8GR3YLFlz4RrNUNq/0nDufSxPuLYliZP/GxpYyS/Gl/5s9ccnkqKnJULyt5VR02n1CGwughO2Uluu82a5aSWlcPYGlzNkQFSG67MeJlvtB6/iOWGtezcSTtb2DYFXabbh/NonGS+6jjhtHEJ3VL11+4zCPWpQM=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
 by AM0PR08MB4081.eurprd08.prod.outlook.com (2603:10a6:208:12b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Sun, 7 Jun
 2020 15:00:21 +0000
Received: from AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::b8a9:edfd:bfd6:a1a2]) by AM0PR08MB5140.eurprd08.prod.outlook.com
 ([fe80::b8a9:edfd:bfd6:a1a2%6]) with mapi id 15.20.3066.023; Sun, 7 Jun 2020
 15:00:21 +0000
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] path_pts: missing check for d_hash_and_lookup()
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <9c28c58f-f90c-fe61-66ed-14dbb03088e7@virtuozzo.com>
Date:   Sun, 7 Jun 2020 18:00:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0061.eurprd03.prod.outlook.com (2603:10a6:208::38)
 To AM0PR08MB5140.eurprd08.prod.outlook.com (2603:10a6:208:162::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.24.21] (185.231.240.5) by AM0PR03CA0061.eurprd03.prod.outlook.com (2603:10a6:208::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Sun, 7 Jun 2020 15:00:20 +0000
X-Originating-IP: [185.231.240.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73ecc3c4-b6d0-4e52-6635-08d80af37f8a
X-MS-TrafficTypeDiagnostic: AM0PR08MB4081:
X-Microsoft-Antispam-PRVS: <AM0PR08MB4081600D9828F4B271C575D9AA840@AM0PR08MB4081.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:114;
X-Forefront-PRVS: 04270EF89C
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Enggc3RV1ZWgN55DPQFVic5bSUXxdGuAWUt30xv9kGWCeL1NUvktyxzO3PVW84E86bBPtqYwwsM1ycO6m1FA7SAFEK2cWkLwyLOiKJtKEjGKS963qNzu1U+sBg6dOCX25OH6VLSGSlgyS3axs+g7/SushNMQmOVYU15DMfd/cXx8ioh/GAC12/b9JIsYi2P6VKesrvHPy16Z4wxpKNkP3yjM45iwctnbJoLrV/3fNTpJ3orI5ozybG6/+Y8IRUxCX06B2AQ/iTkAj2L0W4NPJxju1i6ARan2vEVsJO/aN8U+4IvXAizsUWhlutqErVuwEECgPwAIcZd79HaRhBqZDZA6swSfMZpSBe9oaCC6ZJdKfYNvru3DocdBm88MKRiJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB5140.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39830400003)(6916009)(956004)(2616005)(66476007)(186003)(4744005)(5660300002)(316002)(26005)(16526019)(52116002)(16576012)(31686004)(66946007)(8936002)(4326008)(36756003)(31696002)(6486002)(66556008)(2906002)(86362001)(478600001)(8676002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: n9SUYpDfhThNqqtBMp8p5lSZTppARtHALVOogU3bsAzCliDs2Ri6UyiABzAcpji+3eRBY0rNZk6YmefK9qCT2+5tb1Ug9sMoz6TfNCwnJLNjZXaVsnYx5e6e34C0xNLpIvIezMH9XwhS+JfUXYmQhqU37d2Nki88MtGYEVIO5vHE85y85m08FOtVD1692cAOtnMWSA8BTeV9m7hzjXEA18B2x1fEDXNYzkEdSUyFCQRzJvKPs3wR3PQ24mQlLIrCkh30smfqKOCwqhI0W9kGBrHrxceTAjGvqDRsGt3WeZI0ERYOcdQAkL9Bma3e6hoKhs5foWLUCenYxZFV2cQACKit8OvN9Ov+YKtUsJn1CIp83X5wYUVAKscbqZ6CLCtM723dgu/Y+JFJi9gCyuPp5PA6I5L+QdZU92U1zidXmRaGI4raPDN7WTKt1KaGWPvDdwpXG8d/f3stINSaTZpJpwKtlZyJTIa9G7m0BcrBn6w=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ecc3c4-b6d0-4e52-6635-08d80af37f8a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2020 15:00:20.8161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g28zP4UA4Jwv7QCngvPRVL8l0GkMij1YNsPUaaVFmkQW1hKorizvEb3Tw/RIjfYJ1Y8OxOQVvxlMowhRV/o0HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4081
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Parent dentry can be located on any file system
therefore d_hash_and_lookup() can return ERR_PTR

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 fs/namei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index a320371899cf..6c97599f307b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2616,6 +2616,8 @@ int path_pts(struct path *path)
 	dput(path->dentry);
 	path->dentry = parent;
 	child = d_hash_and_lookup(parent, &this);
+	if (IS_ERR(child))
+		return PTR_ERR(child);
 	if (!child)
 		return -ENOENT;
 
-- 
2.17.1

