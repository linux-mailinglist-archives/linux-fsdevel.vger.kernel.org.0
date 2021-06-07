Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB1639DE21
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 15:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhFGN4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 09:56:23 -0400
Received: from mail-vi1eur06olkn2105.outbound.protection.outlook.com ([40.92.17.105]:8673
        "EHLO EUR06-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230200AbhFGN4X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 09:56:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6pnKDU+CR34Fy81FIfuDhViZ5wbJr08Cp38/GdP9Xs+R+T31DPBrhiSYrideeXPuEBA8pT/DUZOglOT6E8DPwRmjhIPTabYKatD3zLQIvCUyJvbNY25Nd7BomO5vGdyBQrgYMyFx4MRkFAoHlL0esH+R2KjcKv2N/5IGh0jABsRA3fmJhPMLrmJttBk+OAjpzigRVLhpMK1BNz6Pk12isYB4X34DFv3BNfA1m3q+WkpI5OiNsjPlCpqDn7xr4B6AsUMM4zM41pZ6xRnf7FCHy8yg3EufJKG0KJ8Y4/HOYnJ9oyNwkpgvlwiOatM4P3GJGpC0lSzJTVrup3wg1pElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNwk8Sfpw55fJEBkh9T6iBhu2n0lFvthgnDEUV6/bQ4=;
 b=eyNUC0+6MIGC2yefK7nUGeckQKHe5xd+qhehwyGzbjYLZaeWZsyVtYFgwjg/PiZ8cCSxR/qRdm1mbqIZ9YyDcJ9vskOOx7dk09mwrC6zFpQi0APyo9ai03P9zGn+d0DrzkP5TRy4t3bJE3JkWFzXvFYjDY3jxAb5QB3TAS9m9F/b5N8Vxrgdv9Hk9i3oV46UCI+5eX/vIDw5oNOWJUsH/wjdvLJVOjbgiT1de+GZkfm75BKlGazRkCj6l74nC6UlTCAqBeA2ODtl1gmpbc8UUDCwXxWqVE1P6hocNtxrrSa3NgkEqwthoLT40Pt2LvzW5baAvfbJIxlkFsV1EpKmWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DB8EUR06FT003.eop-eur06.prod.protection.outlook.com
 (2a01:111:e400:fc35::44) by
 DB8EUR06HT140.eop-eur06.prod.protection.outlook.com (2a01:111:e400:fc35::507)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.18; Mon, 7 Jun
 2021 13:54:30 +0000
Received: from AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 (2a01:111:e400:fc35::41) by DB8EUR06FT003.mail.protection.outlook.com
 (2a01:111:e400:fc35::217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.18 via Frontend
 Transport; Mon, 7 Jun 2021 13:54:30 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:F16B866306BA8707C32E0E54B32B37DB7B5BA275547D652D38C1AA6CF8A882BE;UpperCasedChecksum:20991EAA4F1729536F3D650F86EA2346A801013E4A3EE6C89E44074C9D11C90A;SizeAsReceived:7851;Count:45
Received: from AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ad12:6a2c:b949:f65d]) by AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ad12:6a2c:b949:f65d%5]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 13:54:30 +0000
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: [PATCH] exec: Copy oldsighand->action under spin-lock
Message-ID: <AM8PR10MB470871DEBD1DED081F9CC391E4389@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
Date:   Mon, 7 Jun 2021 15:54:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN:  [FjRsIOwsgINOyROqTRauOjJubFakRh2J]
X-ClientProxiedBy: FR3P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::23) To AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:364::23)
X-Microsoft-Original-Message-ID: <b4328d8a-f6ea-2429-5376-5a2ff1d1ca9e@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (84.57.61.94) by FR3P281CA0025.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.10 via Frontend Transport; Mon, 7 Jun 2021 13:54:29 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 45
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: c634e32a-4053-4210-e4e7-08d929bbc571
X-MS-TrafficTypeDiagnostic: DB8EUR06HT140:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ZCZ21lBDbDx++se0IjiCc3uCL6qXeYUVNu+Zdm2OvLgov/G2XZa++igTyY3yh4rCK+Btv+lTl2YC15lGCUWjOcKXdUIDeRo1tqoH/DDiJnKsDxZ5hEA3Ws6+VRi4VQzSuJzSp35zjLd+dW5ddU4ZJrAlk2zOqCZkf0jPQUTJ/MyU1RD3fguCROMIxZawT0BBMeA2q4G+OkjENAqf3EN+ZS/sCRh0Hx94qjqTRltUaGLVJRyLGwplZs3UiN8AzMsqHDLUZvOY9zf2QDZrErFrK6UjvAIEOJ3t1EomVH9Bn6WbAGNGGwJuIAcw5eZc9qXQhtWZq8VQOD//XwPEBllDtt0Zjahmz1OLVHtwL5Xzw0aMcTTg3AVzTMAl2bq9gNs/HsMeuoNtke9JEj3tCmITA==
X-MS-Exchange-AntiSpam-MessageData: La4XL8qusWOmwusLCk/3w9E4eoiB5wIejwgikH5/Z+pGW2ynZRZC6hI4L2WGPMkaOpFQw24nY/Tu7uSiOUMCuQL64Y01jlqvrtANFWQcf4qAoY1TYPj807y56OUp7+XC+y/0gcoy82dp2r9pnnd+TA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c634e32a-4053-4210-e4e7-08d929bbc571
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 13:54:30.1896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR06FT003.eop-eur06.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8EUR06HT140
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

unshare_sighand should only access oldsighand->action
while holding oldsighand->siglock, to make sure that
newsighand->action is in a consistent state.

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
---
 fs/exec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index d8af85f..8344fba 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1193,11 +1193,11 @@ static int unshare_sighand(struct task_struct *me)
 			return -ENOMEM;
 
 		refcount_set(&newsighand->count, 1);
-		memcpy(newsighand->action, oldsighand->action,
-		       sizeof(newsighand->action));
 
 		write_lock_irq(&tasklist_lock);
 		spin_lock(&oldsighand->siglock);
+		memcpy(newsighand->action, oldsighand->action,
+		       sizeof(newsighand->action));
 		rcu_assign_pointer(me->sighand, newsighand);
 		spin_unlock(&oldsighand->siglock);
 		write_unlock_irq(&tasklist_lock);
-- 
1.9.1
