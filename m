Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258892D4100
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 12:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbgLILWd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 06:22:33 -0500
Received: from mail-bn8nam11on2073.outbound.protection.outlook.com ([40.107.236.73]:46049
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730694AbgLILWS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:22:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHh41nGi063lAaBv2Q0ycDFfHcEta/irCuQafcW84yg/lMb9FtnJhyakcsO9NleSqTXknicuJBlBQlnLi1CDN84E+uSf2tQUts9Hk/mwYcLDndqoVd6FFjelEfC80pvRADsPscQJAzFgTw0lKiGOnvEl6AVSbqK4hYzNbmKTsR9OK3vPBkj83N65o5Tl9Y5ek3fvgMtcysd5DIVmulkOj0KZ/haLV2ISZIJ0OHNJ0Uv8zuFNRdHX7g6VgGienLF+YYNa0iMPtEajvH1CnVDTGbmmE/L0ZgDoINyPJ+fayoAZBbp/3jPC3dGmLkBhQtnLiJIFIkMwwsrTqZp5Hlqfkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gyKXYNpWM3ZfMulhNf5jSBot0agrlG8oUqHzsor/Ag=;
 b=BPbA/VStJCM9ibiuEw+LR37xBsp07CXMsWtw/NNEm2OjgMjcLNekmFCulJHK8tr+g9sEnubHD8m4Ni6bQPlDO8RlGkXWHSc2fO99SLSaoR95G+HtvvbFbv4gwOdfBiWavuc09EJWY5+DvMyh6XLdCgR5EEYLvCJJmt17qoB6wOET3cXVK5B2EgLgZZcMGoHOSMazngyA7FYDIEl/XEnStJ9IOHOp1WLnwEt+658AacwbiIdzMYyLSNRJSB/ra4KMZ0E+fZTGg7Y/NL8km5UQdsj9L37aToX2BTqZhDEoRRBIJrb8GAJ5c9k7BXocfSpM76Y0qEx/PIbB5wqUgVURTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4gyKXYNpWM3ZfMulhNf5jSBot0agrlG8oUqHzsor/Ag=;
 b=HkrqrxpDUyl49o15FM4U9jJPWFJ5s6JRnQshkOZTsLIT5CtTv6Q9AQHV8YeycrFXWmwoiA8uvzw3eHeV3hUr6NaQehhsrwvoKSn/5KAYmUk9/HHcuMc4yAgA1nvQcJ0eHF61EzvXJI7nL8gGRoYg+2TvW366u6BCjCfQJzEjZD0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM5PR11MB1674.namprd11.prod.outlook.com (2603:10b6:4:b::8) by
 DM6PR11MB3515.namprd11.prod.outlook.com (2603:10b6:5:6c::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Wed, 9 Dec 2020 11:21:56 +0000
Received: from DM5PR11MB1674.namprd11.prod.outlook.com
 ([fe80::b41f:d3df:5f86:58f7]) by DM5PR11MB1674.namprd11.prod.outlook.com
 ([fe80::b41f:d3df:5f86:58f7%10]) with mapi id 15.20.3632.018; Wed, 9 Dec 2020
 11:21:56 +0000
From:   Yahu Gao <yahu.gao@windriver.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        yahu.gao@windriver.com
Subject: [PATCH] fs/proc: Fix NULL pointer dereference in pid_delete_dentry
Date:   Wed,  9 Dec 2020 19:21:00 +0800
Message-Id: <20201209112100.47653-2-yahu.gao@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201209112100.47653-1-yahu.gao@windriver.com>
References: <20201209112100.47653-1-yahu.gao@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To DM5PR11MB1674.namprd11.prod.outlook.com
 (2603:10b6:4:b::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-ygao-d1.wrs.com (60.247.85.82) by SJ0PR13CA0086.namprd13.prod.outlook.com (2603:10b6:a03:2c4::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.7 via Frontend Transport; Wed, 9 Dec 2020 11:21:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd525bc8-68e9-4654-2527-08d89c34a363
X-MS-TrafficTypeDiagnostic: DM6PR11MB3515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB3515C650B3BC4A910191680999CC0@DM6PR11MB3515.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lt431TYiK765ZumgCWChNSIXDBdx61RTEQG49CE0xjqRD9itQYrO1ZvV9yZKOr371fmgDHcs9F1VdLf6rWTCThZJAgFK7xq/9NC8h1LIgS3Y2kLIn6rm8rtuv7MaOUxV9Mf2Rc/Zkjo092pJjBeb/H/xgAt8JnO9rZzYUWWjrq3bH0VobjbNA5BHGK25qXW8g5T56tSuQ0N8BgFqw5M/GSyaa42ZeTOVapuiTE8JxxWMIaQonMahc4fBlu+I4oGE9Hsax+ZroBToW024nCdTmJsHeadxWLGAw/RkGt/o9yjPN7mWMTlIbPxInWzdIJHjWHV1PPHMN/w5YPpEmbdR2LZdU7KKpk8XrUQduKeeSs57DXf7CQ8yhHjnE2Uv8Ae6iCUtT9zpMbSP4iUICOzrfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(5660300002)(66946007)(44832011)(16526019)(6916009)(508600001)(66476007)(26005)(186003)(6512007)(86362001)(4326008)(6506007)(4744005)(2906002)(52116002)(66556008)(2616005)(8676002)(34490700003)(6486002)(107886003)(36756003)(6666004)(1076003)(956004)(83380400001)(8936002)(358055004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zd80dHIZVNsXQFXN6IspMBrojv13n8FRDUviwWeYjoXeC6I3ZojaXFKNtEu3?=
 =?us-ascii?Q?KtpmiXOLUoy3OR9J0dTmK2vr7tzgzVPAbcW06yWYuXpagixkxPrGBwbr9lAU?=
 =?us-ascii?Q?NT3PJ3e0R3BxHLoFxL3ntFsMxfJRt9n0PV16jcUpF/xga1lC7fq33pXlSSZN?=
 =?us-ascii?Q?8iav5UWUxPlinq9EwkmftliF1VNwlptNEqdTMtz9VApZ+lFQA9tSsJ3oriL7?=
 =?us-ascii?Q?xL2aRrqjg/WJeNSet7TYwZPiODCeH/zO+AY0bKxRoY93qBKAEmn0DoDQHaeB?=
 =?us-ascii?Q?kicMWhqOu4f8viG0higJNSFkwTCOMNlac/i+nA89frzbV8ns3w8ZkeoBk7u8?=
 =?us-ascii?Q?rjnGoCIKH5OceJEXY2LJiR5qD4aZszfXm3XTP2GzQ1Wr09XVnsqeNMoP/U7h?=
 =?us-ascii?Q?SCuAPpKeZcYbgR5djEJJIN/VCw+cPGpRRTfuosRuqPsUvpTFPgFZJRFpR+ZT?=
 =?us-ascii?Q?tn3Ki0cBEkDpH8ukkAmE3yxSs0GyqC8c94V7busYpBYiXVemf4YmCc+OWAJJ?=
 =?us-ascii?Q?WB9oeD3FWDfpplLPF2jBk1U1D9qyRD6jHg/lmRQNHi9VktyY70slGM6CyG7H?=
 =?us-ascii?Q?PRsX5lhR7CzU9tbmEou0FF71VJgzDFhNTWPvuTUwe2uMm0ktuAwCnV1mmvW0?=
 =?us-ascii?Q?xtOjmt0tMZ9uc3wLb6AzIIDaH4Hnv0rmhGZh102Ed1DtBLdBcXk7Xhss+uVV?=
 =?us-ascii?Q?o30s1/cEcrJb5LOBMI/QIbiIxHA3PBfc1aFJQNb0Sqy+NeyrqAkMiKsdkk66?=
 =?us-ascii?Q?6vEnJmWUqQRhrpRHJrf7CyMaceSzVPjvBaylPBgQBCEbxy2o8qegU7t2Iedq?=
 =?us-ascii?Q?S7iHARXb5qn+nnl6VXBVpagn9lRXovujwHvMuQ4S5nq5UEc06s+OMET3mkjD?=
 =?us-ascii?Q?CZGTju7wxGXAeLT3D04cRx/saTw1xTnBmExPijz/v3wXWFtpmyWPl+XCKQzx?=
 =?us-ascii?Q?EeTTkpFkTdfbwx5H1ovtD6jhScRsapSdzXEHBNRpBWo=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 11:21:56.5331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-Network-Message-Id: dd525bc8-68e9-4654-2527-08d89c34a363
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klULGsn2Zwcgvska0mcMhuO3sr+dSFNIUmxozHf69Jj0EL8gtYrLWxnBcZAWKh9QukiqwrnwBJ6C3SsxK2zQQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3515
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Get the staus of task from the pointer of proc inode directly is not
safe. The function get_proc_task make it happen in RCU protection.

Signed-off-by: Yahu Gao <yahu.gao@windriver.com>
---
 fs/proc/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 1bc9bcdef09f..05f33bb35067 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1994,7 +1994,7 @@ static int pid_revalidate(struct dentry *dentry, unsigned int flags)
 
 static inline bool proc_inode_is_dead(struct inode *inode)
 {
-	return !proc_pid(inode)->tasks[PIDTYPE_PID].first;
+	return !get_proc_task(inode);
 }
 
 int pid_delete_dentry(const struct dentry *dentry)
-- 
2.25.1

