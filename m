Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE7239CE9A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jun 2021 12:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhFFKnM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 06:43:12 -0400
Received: from mail-db8eur06olkn2075.outbound.protection.outlook.com ([40.92.51.75]:21281
        "EHLO EUR06-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229465AbhFFKnL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 06:43:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WA04zfXJXWvziVRLeCMaOzQbAfqH5ryl2ed5Ufl9sLoiKlftb9GgoF3FA2pYx9cZ01ytxOhUUQEfvL9vjKxECcWIe9/bzkpClAOtjsmxV/hbSjsN+35aA9Tq//ER0Y6m0SFEuZu8nMKJGMrcVoW3CV1CGncAFiTDoNY6Qocex4a7ZsYK2bfaxvHhgywjQ/+6qveJlRkuCQPiXtbVwbM5GJl3NaVZNA4xHD7zNE6qdgKfWEd5NoIo7GyDV1VTRjkxbxyleZUF2eqEb92hAN0Gk93ZQlUXV9ukuPhS3LLDalOUgr1CJqAuvZGROdkfgibR1cm5q4N6Xt/TC7Wvzu2Tmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CMzbF5oJ24FBzPyK1hDO+ZYjZ8XdIJ+SNZEUphDYcTg=;
 b=Xi7pPs7vKtpR5u0YPu5HisJ9m7izrSb/+RFmEPko51MqKADyToNw8SVvwiGZffu+3KebeA7+Dv7BBJ6kgp9VTw/0bQ8i7mPZz5RwAeENCkngGwSDcet/q+0HT8OXEBxphAY4+14YUfkj4jR/bZjJq7TBhomYaWNJqEb1wMYf+bo869mKrqqHPJdMKOFSfA2TPwXW0554AOryBYCHYP6oSJ2T7I2PqHlDkagt2dTN8X75jlbpdYs/lnNej46zdCBx7zZP0I2snaxnsj9c63AyZGWqkthl8sZjcgveJBpR5ZhzvIAByHND1/eMn8PbFHyj7/3JCcj9cq/PoQ9jGea9XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM7EUR06FT025.eop-eur06.prod.protection.outlook.com
 (2a01:111:e400:fc36::48) by
 AM7EUR06HT198.eop-eur06.prod.protection.outlook.com (2a01:111:e400:fc36::422)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.18; Sun, 6 Jun
 2021 10:41:20 +0000
Received: from AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 (2a01:111:e400:fc36::50) by AM7EUR06FT025.mail.protection.outlook.com
 (2a01:111:e400:fc36::479) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.18 via Frontend
 Transport; Sun, 6 Jun 2021 10:41:20 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:66B4EAC390992C68A83A6F27C5A8BFA92F1B4E920BC48E860A74D7F4A6A522A2;UpperCasedChecksum:F3D353D4E9F796723102BEE1B216F9CA20E5C3C392047EB5B0625DC484DB122C;SizeAsReceived:7847;Count:45
Received: from AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ad12:6a2c:b949:f65d]) by AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ad12:6a2c:b949:f65d%5]) with mapi id 15.20.4195.029; Sun, 6 Jun 2021
 10:41:20 +0000
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: [PATCH] Fix error handling in begin_new_exec
Message-ID: <AM8PR10MB47081071E64EAAB343196D5AE4399@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
Date:   Sun, 6 Jun 2021 12:41:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TMN:  [+tbO9SgzIhULFiA8X4kFUOU6R6aDiYbm]
X-ClientProxiedBy: AM0PR03CA0075.eurprd03.prod.outlook.com
 (2603:10a6:208:69::16) To AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:364::23)
X-Microsoft-Original-Message-ID: <5561c512-8fbf-f44d-05db-8d8c9fd856f4@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.101] (84.57.61.94) by AM0PR03CA0075.eurprd03.prod.outlook.com (2603:10a6:208:69::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Sun, 6 Jun 2021 10:41:19 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 45
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 2ca2089a-a010-4a7f-fba1-08d928d79e96
X-MS-TrafficTypeDiagnostic: AM7EUR06HT198:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EAj5lRodYfnInghOwQG9cxAtDJvOtsbPwyRdj7ONzqanOKUBcF8TogIlKtHGvmmRTmFixXbBAi7pE1zO6BwwyQSL3quvZRgVliOkti0DlHKINzGvalg9j/YAfJCm0og+nQOJDP0mfacSdAECc/XjFL6rUnsDeyl6peN8vd1OHVCfaY9kdDVH2bkLhhEflorZit56gaxDPmfS5gN8chZMrDn/pY2xPMrh1bOI+eNhd7KumqQmlOghUW3o5Y3mE3sDbCtPxLD/25PPd/H/UK6RrJkFAyKKy9qwmB+G3WhqMo7zfrLhzxHBibyeMWE2Kta48f5XGnMRnHHfo6O2XwW0xhStwVLFajPZokM+rMU+yFScNvjmFsnIUeJA1cxLpgs6FzfIo6nkaoaWMXEjUmlwXw==
X-MS-Exchange-AntiSpam-MessageData: pXgQUsKuKBMCCXaqrOO0GDuGOWAfn1eBefPxNqW0SX/MeskmYBCb25IJYfYPXi9qHeBsrYEVadl6Za6hnjheUAINnqEwDcWkCpHUgtBEWwjkMp3pbj0Rx22HpKHWxP/+aN7Mlm0sLtbUyZNlHVotJA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ca2089a-a010-4a7f-fba1-08d928d79e96
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 10:41:20.2390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR06FT025.eop-eur06.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7EUR06HT198
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If get_unused_fd_flags() fails, the error handling is incomplete
because bprm->cred is already set to NULL, and therefore
free_bprm will not unlock the cred_guard_mutex.
Note there are two error conditions which end up here,
one before and one after bprm->cred is cleared.

Fixes: b8a61c9e7b4 ("exec: Generic execfd support")

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
---
 fs/exec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/exec.c b/fs/exec.c
index 18594f1..d8af85f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1396,6 +1396,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 
 out_unlock:
 	up_write(&me->signal->exec_update_lock);
+	if (!bprm->cred)
+		mutex_unlock(&me->signal->cred_guard_mutex);
+
 out:
 	return retval;
 }
-- 
1.9.1
