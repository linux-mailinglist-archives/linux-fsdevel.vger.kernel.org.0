Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC316B362A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 06:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjCJFtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 00:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCJFtL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 00:49:11 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2117.outbound.protection.outlook.com [40.107.117.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22220F98CB;
        Thu,  9 Mar 2023 21:49:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwkRTiksMlNNeCiakrmb83uKXGeusGyimWPUXjJ3mO+HGrSuOJTs/ZY0dHCxieMNEUJ/7byyMduQneVy8ErbqnfjF78/AWF8LzRgy5DWyVOV9jx7nZT1ZxwktNJZ1sa0eQtVO7SUyvLuhTtxAVGcV+APm1ZMci/Mo6ir43Z4qh16e3q0pwP43zt36qnKIzdftSl9WhOuVaqBuwgZhHc5MXQHUNGEhLKWmPVtOuFycTmId18Y5kG9l/vpLil76rhrX14AXy8475uoHiuI0OK2bGTerrc4HkogaHy5TwKyBBzfCe94rVL/vcEeo2sZKNPjf3m8+YF6tlin1CWq8a1MEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3TAffNeOIPDXwmJpJmg+oAqVVOrB+2BtWDSDZs2nixE=;
 b=hi1wUju2c9ZwhegyrxrDv+F3AlPk2VxMa2fDoHB1ZMgRkezMKQ7a1LDcNtMTw90Klqvm5s714/R4EOi3VdjVnnoffQcnA8S4X44/3QXXn4PllcckrJYqNuKhyRDyVZLeP+Ea4RgmTvNdbcLKu+Ji/lMekPngutZisZMrva/apLWXo23jzvWQ5INVU1x9VTpU6pMSpB4SqR26+P48SBNf+enqlXWT+d6eAW1yfUDywlZ29x6MRrE6GgvP55cGTgQAlSVL+xorJpLhFiYrWIXoaRFWgHZVto+acxfOr51f8MVk0hPNd6q+yzXkgrrPQlSsUACt4bgQqNaXjnt48V/4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3TAffNeOIPDXwmJpJmg+oAqVVOrB+2BtWDSDZs2nixE=;
 b=PnMuaBEzswFltY0fcHXCO7pPnp2DZKrwcx9UR8s3y/hHG+l3R3mR87q7uY/aq/beKl+R8Ukf9KNVZUecw3zbIzerPjQNAdnnIUOmgyFqf92h4k2J/dm2Ov+dNPYt5KMHYiShkTjQCodOHTR4eKQIQqUfjAG0mw9spF8vz5Nm1naJOFmE0h4oUP+7kNNCHCceFlfmabY9bwW42v+TSa44BL+J10FEa1av0VDl+u9R8TWv+MNBfDd3/sahso0m1U/yhQ15bK9fnwJsUxx9pgoeIH3PkUVHP6TuT5ptWUg047+YC5dGWQ5A67HUYCoOSIXTN1YwGV6SqZwBEYsnmU20Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYZPR06MB6023.apcprd06.prod.outlook.com (2603:1096:400:341::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Fri, 10 Mar
 2023 05:49:05 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 05:49:05 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
        jefflexu@linux.alibaba.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH v4 1/5] fs: add i_blockmask()
Date:   Fri, 10 Mar 2023 13:48:25 +0800
Message-Id: <20230310054829.4241-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYZPR06MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: f656adcf-6898-4ad5-6580-08db212b28c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q5loVG/P0L8dPSpzK4iqHvOo3G3acBqRX7+o4Q0X6w8SrT+S8DT8na1IHtp+t0Nd0a+KxLiV/YGfQBZBFl8JeQ4YeCp13xBXGrq8xjrREtuRmG6rp9IcAcRjWVWeNrH27dHIsEsz4Qbcvi2thbipeWR2MlZKEhkGXhl4YUcwZQCrD4OCg78xMofqdo9dQhIRc2HFF27RX/xkaKZGE0RBIU4sH9au2kaUEHGnioNyJS2VFnH//IGT82dUP1IkqBEWuar/Tzudp8lWOz+0xQaem2kEdOI2Gu7TQ3EGcYoK+TjxZnfQ45sJ4FU5V0LLhBsDslIOLUrb2KCFiuh3WEn174RJR90kXavhQ11Q4qztfm0d69QVt3ZvGL8KcEGEts1La2sr5kx9xzaHrHU0w+xrD0TwcRVCwe3IXp7oUSmBWAVJtU/rVM2kWkYrWDEc+j27xm5/YfVse8HC/2oTTPag+dlg+CqigwQTHaGZ/FgpCRSUUlhkh2lVBDlZDH54lSiiE/BPFd4VWyU8vgcNlC5+psPv+yVDf5rO4RtMFZMEazHxiKPZJmVRO5dtFsX4erUOkmTvpZtWwMa6SLc46Yi61wu1vIDrzVDxQfrNYBeGxPKUtKJaY3q2TYO7mWcK+/EU6vWHS+YAjowY5R/3CAxJ29tpTidrDY1hE/2qGcMA/i9fhsTXAb5CQws5POwxWlcKNKvcmb8r6t9/eyRlitjWxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39850400004)(136003)(396003)(366004)(451199018)(52116002)(6486002)(1076003)(26005)(6506007)(6666004)(6512007)(107886003)(186003)(4744005)(41300700001)(66946007)(66476007)(66556008)(4326008)(8676002)(7416002)(8936002)(5660300002)(86362001)(2906002)(36756003)(316002)(478600001)(921005)(83380400001)(38100700002)(38350700002)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aprk+g84nqLMpNNI5rUbx6iM5UMphBCJ9RK2qPxGW7h8m8JzB33rKsiQRtDV?=
 =?us-ascii?Q?pqTgd2pTe/i0h1kLN61ORIlFcpiP2n4isWBMiYUUneQEvNgRxGy1UtDo01ct?=
 =?us-ascii?Q?Dy7orjvXIF1ER90NC0gvD3lD3XUL6L/xN+CMSuo99tN/nPb5hSLUEJRpvjUm?=
 =?us-ascii?Q?iCyg/KQiGQ4eGfC5saOz53S9umPvgZKV+Z2p2fvcOvOt8ZCblkIGPiomX2QZ?=
 =?us-ascii?Q?edoRVO6/J+Pas2jZ9AlVIaGJd7hhpWPOz3WuYOyIQHVWlLXUs1zMVVrkMdEm?=
 =?us-ascii?Q?KBSdeJn7sDvsTt35C4Fw9OtZlpgk+Kt9j2S/o2S3JveIIh2GdQpyjygtu8dv?=
 =?us-ascii?Q?bJw3TM6Vl2goTKl/yxqnEyPeIwGXfTI5nFzIgFXMVk1cyCq9L54cYhNTcS3L?=
 =?us-ascii?Q?LuSly58RXb0K+GhG2FUyjXqgzx8y9MNP+uTMHF6LOBJlnzqnHFIXWJLmQlfi?=
 =?us-ascii?Q?FIg03nXNrVvgr8v+NukhifRPLYg4CWnJ786W8TzVqnEs6iiLfO1TAw354g19?=
 =?us-ascii?Q?aSyYRMh1a+aGVEoZwFKlSnEsMtVZ7MYgwDkhgMpaAFzAldNyvxVkcdzWP57N?=
 =?us-ascii?Q?+hkjrev+7rtzAvF1IuPceA0zNFqGxkCB4gof2eWz5E4Yb6b4bD6sHJguvsQY?=
 =?us-ascii?Q?YzMWA6R1xIGOtXAtmDCOUr2+6J/XTRkdsjNL8dFjqfWo/NhSYUhxL1loNri2?=
 =?us-ascii?Q?3vEuXMGkJvhgEMhbZ7kVdpWaA0NBZ0toLmZ7zbM4e6HEs2m+L087UK8dFfEH?=
 =?us-ascii?Q?w1vl+cyhLtRhL8VkRHwlUgJIXh2TcR8hCJK1idwUHduJm4YjCtPkWTmCqQmv?=
 =?us-ascii?Q?PLqO5+h8Cic2DilnEhehXkbgJDNrtHSQ4WWw8V08JbcxqRusfW9U3SgM0lkD?=
 =?us-ascii?Q?MJfYF/6qFZ+/rkrzprrfDUQ+oK1/HXNT8jOWTflh3Soz2LRmFZNq3NZmx8RH?=
 =?us-ascii?Q?/zAn9ikbrNJ2F/Jn9Xs260X+8UyVLTcsATP6y9MrhbP6xY/m4SNERB8R1fGV?=
 =?us-ascii?Q?t3J59j/nGGuyRwRgCKUaY0i3QAkVPXCfP7rrvAuNPiUN8NgbOyb4v2G45Ow0?=
 =?us-ascii?Q?8ZBtMUOQpugU7fg7FEFEQE6AYap2TlKeF0GGC7eUIuNwnuhNerWUdOrXCOEc?=
 =?us-ascii?Q?J1DHTkzkDceh/gcHn2bEYGxeppiX3jToHz8T6BfCh/+iqmiQwaiQGLyhMy0P?=
 =?us-ascii?Q?RRo45RPFtFyJ8Rwjks5xRrAWRHj6nJpAeDpt+i462y80yje9Cd5WRn1dZi9v?=
 =?us-ascii?Q?UnFBys9tA5/rWziHAe2+3Ppc421RraD1Borf7GHDUSb5PDYuaVNhN1VGcF11?=
 =?us-ascii?Q?AijhZ+Y0rNgUD7FZnZcOVXHwd6Af/086bTtdDaUh8D6fIwoBQePvhW7XntN3?=
 =?us-ascii?Q?BaQeD8lFToPFFI+A2Vj6WSJ8b8Eilh5aIYUPHMsKHfdpMl/zARi/k2FezH8O?=
 =?us-ascii?Q?JgdhcRAFPb0heyF/EOeX2TLusKQHWcWK17l/0E0/pkiX8xi8akjCf7vUXM8x?=
 =?us-ascii?Q?z4oJNpsB4osfWJS/7uBgRB8z9ZvxD3bpjQ2Pce49vpeyJoIF4nUIf4rNXW02?=
 =?us-ascii?Q?50b2EBkBmkDPuA20By6EezsCBfMTa2Cgee4Np7PS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f656adcf-6898-4ad5-6580-08db212b28c0
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 05:49:05.6408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GGE7Fo335S2snThWbu0+AtI41kdP2hhJuIk+9ccCwlb+qS60p9Ofe5+dBMtZRWhKpBx6n8xGTGX62ets8gdCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce i_blockmask() to simplify code, which replace
(i_blocksize(node) - 1). Like done in commit
93407472a21b("fs: add i_blocksize()").

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
v4:
-drop ext4 patch
-erofs patch based on mainline
-a bit change in ocfs2 patch
 include/linux/fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c85916e9f7db..17387d465b8b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -711,6 +711,11 @@ static inline unsigned int i_blocksize(const struct inode *node)
 	return (1 << node->i_blkbits);
 }
 
+static inline unsigned int i_blockmask(const struct inode *node)
+{
+	return i_blocksize(node) - 1;
+}
+
 static inline int inode_unhashed(struct inode *inode)
 {
 	return hlist_unhashed(&inode->i_hash);
-- 
2.25.1

