Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB7A612AB1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Oct 2022 14:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiJ3NGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Oct 2022 09:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3NGe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Oct 2022 09:06:34 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2074.outbound.protection.outlook.com [40.92.98.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B039B7E6;
        Sun, 30 Oct 2022 06:06:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kY4lCEF4od7dHwwKmJby7S2o0covTcLpABn46tQEyUzmkEpHQXj2QWrVvkefrpEK1L5iRKaUWESvxtcAhfcEjfuP1PhdRSp4+1LKdX8nW5rvtgnH1u1iO/lhGh4qXOB1eXwsPDmc3/M/OzBcmwaI3rMjnVkHjaRoGUWaaYPKAg3NKHdjDZsGqUz874jfCEQLYiD+NrQFc/IX2tjnMsgX+dy4D3oEro/23eV7uEG1cB3et5W7UiJVVxJnNmtHDtDPZ0ThM6J6puuODl8mbkXDp46V1yOe+Zi535Ro3/dS293cnCXSFKsK9N1PlfkNkToQpBNxC0mDUmJKZRhnFxMhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMggVciP687Vgg7SEghug6O3xMDYrOIIRttSKlgZoMo=;
 b=necs3621IzaP7FTq3wRlXQBCa76Us007HAw95kpW6B6ZTD8AhnfrGlX8CKiuzP+5RWjlhykKBN8RtvIStxU8xG7NbYSf3qLLNaKKMaTgkBrpBcU+VIlisQke6BykIRKjh88MGs5dwjaES5ePyxHmcjfx7kNvE4FL0zmWFx1CWom09VvMqoeMemajs+SEN4CE6Pi1rCxsMt7H7PIlHnah/XHNGLntn7BSToRZW7Wb4b3r9V36XWSTO5OkXul0SwumQ8O57cpsf+Wyymy7KUcz6TncmwwY0Ln8AUMFX4sgv2r9YWWRbC2V44L+lDh3YmLl0DiTFcgMWRnkoCjnvhRFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMggVciP687Vgg7SEghug6O3xMDYrOIIRttSKlgZoMo=;
 b=MRz0c9PwZTRZoT1p+ud5d/aDV91a0Lb7i/zDnHgd4t6LeXNPep++x8WTVQ5wUNxj6LxR2u9ykQNKCOr3PWUq6IU5U8ej1VnvCibLCXeCuFLFdzthaE/kp+Atghlys3HTMb59A3bW2TlPA7prKB1uLkejGGrVfeIKPDSOiao1KvSz+Kn/5Jn/1NAPaXRY78xcdPGG0/OYL80vQkmleYhE9o2WGHXT0k3w37MNOtqBQYaw4PiLGA4sPfrGj/m/Dv+VwOZP3Kq71bL3vcZMW7xHpG7/auGuLarGonr36279057bvNO8YkSJIPYShaisz5l/Bm1YN6EuYVWTvi29TKs4og==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by TYWP286MB3285.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Sun, 30 Oct
 2022 13:06:28 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c90e:cbf3:c23d:43a5]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::c90e:cbf3:c23d:43a5%7]) with mapi id 15.20.5769.018; Sun, 30 Oct 2022
 13:06:28 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     viro@zeniv.linux.org.uk
Cc:     brauner@kernel.org, neilb@suse.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH v2] vfs: Make vfs_get_super() internal
Date:   Sun, 30 Oct 2022 21:06:08 +0800
Message-ID: <TYCP286MB23233CC984811CFD38F69BC1CA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [a1MSuscDjuw04a0Hxbe5QSsAteaEVHJubvwCUNFWI6s=]
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20221030130608.16590-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|TYWP286MB3285:EE_
X-MS-Office365-Filtering-Correlation-Id: 7961be13-0878-4118-6353-08daba778ed3
X-MS-Exchange-SLBlob-MailProps: Mga27o8vReEJoBefUVF2zuDjMP+5Vl/4cr2vb2wKsk75fcfOaR4hT9qp6h8Iv4P/Hkh9gGth6mVSGqJdKjqDytn+KHM5m5tge7vJTgKyCXIqIdg3e5em2Js7PkZXmwElTCtk+pqo97i8f0mKdEb4+2Yp6/JrDQuj90GcGpwIwOwxuGfZfeN0k5etRB9QCwvJIZEBbPsZ0WDxtqsGM1aHUJOworuYr/jrG5NJJvcfDDpbQlFVwYfLgzlWMXqtlYkSWQRqCkY5cSlJeUMroakHUmCOsB5Xnzd0vS+8D/tRtqRTyuAVXr1YsqVr7OpoypAKhOGVNL/i0cn8XEJpXGWeH3Gz3fColT7XcjYrJGI6VC8nGvOoiv3EpkxuyL78P6DfQ/Z/j3Qn7MhiJfEy8aQjurkOOPe8ssKOW8jPchHiUiYOCAHdpjeqREa83HHzhWzl4RDseLi6vF1RaVACSNCvOAHvcL/qepdDBq6fw4ISosfQKFHMKsVDRZSua225kvYWsWhdhoCWGs1PPkvWCE5wZIvQhKtn0B9JEgXbALe+EjhaShZ9P3NFDQG8DIpas6lfhsE43F60nviV1hUJeSMFdOOKkaiZHImK8TQNj10rBnCSbcSTE068RD6PZ537oZxB1c5qIRS1w9PJiI0+4zjXFiskHyGjPeT8CN3m8i2ysq4LeAxX1uA579w+zHywCUUXNOtRm7TwcligSRhmj194i5YsmRfDHOsJyHgCSs19pZX691bxYl9XC+iiew1fHV+OPcXrRKyJhJRJzPNZpyTnXcr09qAwerm3tA85uwhsJtG6Ui7GnDTK8g==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i2+1Ymo/eI8i5trGNAVcjOAtKzOliiEuUPlbap5ch8UVdDRpq+ZfaXIDDkwvaKUEHPcRCiFBzgWTbwEtm2Zowg8HRQUfcs17hdledMsQOKyHskySerpdSjWnxXWh52ybU7ZrnNbIl8vvlsmCMxsPNQcUmGZgkKFxuSRu5hLS7Di7a1i4e3wk7d5zpathpOAYuBWnQvJXDXjXHisP3bVRtYHiOsw3SkTaMn18zGF9Yqa5u3gEAe3e28ICEN0ntFjga1PJTnI0w6t1DrGvQOeN18c1I+WtowX9ExiF/LceMDSi77W3vOsGJdnoWH7oclREmkrQ1NSiQfAUp2l/LRosh37v659beuAJWpz6Xw1XQ41lwrcRguezfQF2fj9Jq+4qrpRN8LnHtEU+/0/vd/13cDKV2TdgK/2pOCe/+OTpjBVrZZAOoPpndMuVFkMKb2h1hZ78SReu+AGAeb0A16ebmiin4Ia1MgxhSPP78tfvYtwUVBLe3zYKb9VA2EuUlM3iGq60GgAZ4Fk2/CN7uPvEnJQf5DOZhNNMRCZ9ez5+hEcMkL60w0eCuvFjsC7N6arD9/J6vaj4cG2ImEokOzR4H+GD4z4RqYSWqYgC1eKkOrU4klQQYHrkwq9ExR21BhQxuPwpWhRg7vAvQ2jsG9PyOb5Vb9ECcwowIMOE9J7MHHGABiFhVaghnytKthF/EykB
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s4ekeDZdI694MTfEaxX9FoySyL605HeKuYhMRDfsP1MkfLu4iaZEJGHFvjHG?=
 =?us-ascii?Q?nAbEyJ544f9iEx5/oJoahAg+ZTkag52ZKuJv/KyvAYZnLgnRbXv1sVYBTylN?=
 =?us-ascii?Q?RY7f6hZZq0oRNYphVtXc7k3ugjXYowBMhCZBa5McAxrBVGiH9scmr49/7vP5?=
 =?us-ascii?Q?K6w0svbD0SgL6shpM+lcL8H5S+CrQ0745zzthINcFqU8cMEIYLcDrRR4HcDV?=
 =?us-ascii?Q?fKPNT/4AdyKXCW2wz0AGXy98WDVP92qH0THQFf1NFn3FH3NtAn0kadHbMO+5?=
 =?us-ascii?Q?99aDEV/9AcxBhCSDwIOLAvlvi+z2yBEfGTe5Uey/CmIrRlm9roETyELaO9kt?=
 =?us-ascii?Q?vs1Bl4m5nqfjhSgpKiGU218eLkv3xyn6rg61T/zOvXtmphcAx/ejQ24cODn1?=
 =?us-ascii?Q?1GYz0KAd1+SQBZsU3OdxmBgnhXUb9lyPPNRY5pLQYWeSOFJ6oW9NUw0dyO7y?=
 =?us-ascii?Q?GzK3s1kY5r9ro3aUnuqJCijXvkjMrQKw5GXx246a/XPbf/1shDVaXUdniZ+Q?=
 =?us-ascii?Q?sAl3nKV4lCx38R0B28niHXW1xRQeJ3ukLIbGA9kQGKTfs/FWklE8ZGODIHvo?=
 =?us-ascii?Q?vpY8NmfmRNxI+QZcmV3uFZrM29puuO/6wdbknhuO0s52c7NkARLHDmHNq5f+?=
 =?us-ascii?Q?MNuiUapRqizWRrXXbcaPNrdUf3XGBJ7QitSgw6iEP/7L4pJl2efsBwX3hJa2?=
 =?us-ascii?Q?eNfhnWK/9Y8wJTs7osj6Fu8UO6rb0jTiZzSPKhOPxnFzd4jlwf1bL2MvKjMQ?=
 =?us-ascii?Q?Jv6p9qZAuE5OoEAhNxT9gcfuXIUX7+nqw2oNS3MThKMIdld8nCZkiw4l9fpC?=
 =?us-ascii?Q?ypfPRKVSXbLDweBMSgeblAz5Fb26z8Jwt7CO+9ensPU+i4fQvgux5hJ1EF69?=
 =?us-ascii?Q?9orwJfvdtMferkPGGGPefq2DkobOqtj2673QUp3PAXIJ7opKzLYIRlEteS4M?=
 =?us-ascii?Q?b7MZ5YcEB6J8gAg2a06tdvop1OS4YMRSWM+fMUl+i/3RzW5BUc6F21OHnj5E?=
 =?us-ascii?Q?0ETT+lEyi+G5SvcE0iQqsKTJhzJ7vm5ov+sKxn4Kk2L69nDYd+vXYyfqlsLd?=
 =?us-ascii?Q?eT24toDlyQsDC5sgccq6vypok0ggN4HBUBwD7OFu2Mh8SAm7nhePDRjCv73w?=
 =?us-ascii?Q?6YHdWw70w/dtQzqIQLbC1qoV1IGRk6zUAzadbektDEk+DAjERmIm+7aE1fA4?=
 =?us-ascii?Q?Bh1Bcjcg44/6qWG9QN30h087aA3ndJrBn/+zUeo2YCY8oGBifaLs16lPma9y?=
 =?us-ascii?Q?xakmM8gcCTq0znHHda9jKCPUpeNbC8FHA3l4v8JdVQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7961be13-0878-4118-6353-08daba778ed3
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2022 13:06:28.8616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3285
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For now there are no external callers of vfs_get_super(),
so just make it an internal API.

v1: https://lore.kernel.org/all/TYCP286MB2323D37F4F6400FD07D7C7F7CA319@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM/

v2: move vfs_get_super_keying to super.c, as the suggestion
from Christian Brauner.

base-commit: 3aca47127a646165965ff52803e2b269eed91afc

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 fs/super.c                 | 13 +++++++++++--
 include/linux/fs_context.h | 14 --------------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 6a82660e1adb..24e31e458552 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1111,6 +1111,16 @@ static int test_single_super(struct super_block *s, struct fs_context *fc)
 	return 1;
 }
 
+/*
+ * sget() wrappers to be called from the ->get_tree() op.
+ */
+enum vfs_get_super_keying {
+	vfs_get_single_super,	/* Only one such superblock may exist */
+	vfs_get_single_reconf_super, /* As above, but reconfigure if it exists */
+	vfs_get_keyed_super,	/* Superblocks with different s_fs_info keys may exist */
+	vfs_get_independent_super, /* Multiple independent superblocks may exist */
+};
+
 /**
  * vfs_get_super - Get a superblock with a search key set in s_fs_info.
  * @fc: The filesystem context holding the parameters
@@ -1136,7 +1146,7 @@ static int test_single_super(struct super_block *s, struct fs_context *fc)
  * A permissions check is made by sget_fc() unless we're getting a superblock
  * for a kernel-internal mount or a submount.
  */
-int vfs_get_super(struct fs_context *fc,
+static int vfs_get_super(struct fs_context *fc,
 		  enum vfs_get_super_keying keying,
 		  int (*fill_super)(struct super_block *sb,
 				    struct fs_context *fc))
@@ -1189,7 +1199,6 @@ int vfs_get_super(struct fs_context *fc,
 	deactivate_locked_super(sb);
 	return err;
 }
-EXPORT_SYMBOL(vfs_get_super);
 
 int get_tree_nodev(struct fs_context *fc,
 		  int (*fill_super)(struct super_block *sb,
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 13fa6f3df8e4..87a34f2fa68d 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -145,20 +145,6 @@ extern void fc_drop_locked(struct fs_context *fc);
 int reconfigure_single(struct super_block *s,
 		       int flags, void *data);
 
-/*
- * sget() wrappers to be called from the ->get_tree() op.
- */
-enum vfs_get_super_keying {
-	vfs_get_single_super,	/* Only one such superblock may exist */
-	vfs_get_single_reconf_super, /* As above, but reconfigure if it exists */
-	vfs_get_keyed_super,	/* Superblocks with different s_fs_info keys may exist */
-	vfs_get_independent_super, /* Multiple independent superblocks may exist */
-};
-extern int vfs_get_super(struct fs_context *fc,
-			 enum vfs_get_super_keying keying,
-			 int (*fill_super)(struct super_block *sb,
-					   struct fs_context *fc));
-
 extern int get_tree_nodev(struct fs_context *fc,
 			 int (*fill_super)(struct super_block *sb,
 					   struct fs_context *fc));
-- 
2.25.1

