Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747B268D911
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 14:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjBGNPc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 08:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjBGNPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:15:19 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2071.outbound.protection.outlook.com [40.92.107.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA3F3B662;
        Tue,  7 Feb 2023 05:15:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzzxeWMYhQJZ97ZCDcEWRVPAF9NC8GlG2ikO1iPGpXsSXUI1v5U876dZJOUVpt1zrip0vxh93AcD2A1rLIe/FXYYG0REiPEPtHUzthn/6gXmUOiM1xxInaeDTvPHjgisULmfX9Lo/nokzDLcARlEQXFeFkmqpbUnehm3uo6kze4tueHqXuyzHZjFawY/nAOqmgesvXPPhpYX79fu4x0gF0H3F0jQhqJ1pW/q0+HPdYhSa6Fe3w8miZk5C8cD9+t5InLTcwbSfDAEKD1FrdLeDW3iZvZ2QhgxJsnk2o/ne5iXiCw094FwykyxFQFp2uRXpooTEBPrsas/1cHwFCxQUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6qmJOF1hrqHvsHPzXnubGea0gejudl8j6s4/r3gYMA=;
 b=fx2xe0mJgRWJbxmh5SwVPDraIbn5GI9dr7Hb8Y0cVkGXzJsk5wHS9o0xO7dxYw3ESduU4zycitEDU80AzVXCDKeRAf6yOBb/ypgba0mggxL7kyCQuJDenMBde1K3l5dMNUzd9QmB99VtNhD5rE7gqBivBILYvtwSeV2AdihQQqYMhrpk0QbQiy6dIETo+7wkUG1MC9NS/fv7dIgs1NOtwaOxpIeAbhtK8YElIYoNrRAAlgdE7xut2iETFABPu0pybBxJC93jsO2hIecqu1GvJOToHMrqG++k8NBjk20OHez3DruQnjRtsPXhRCRoOuqk/RSvMIB/DnsF+cWtHSX+CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6qmJOF1hrqHvsHPzXnubGea0gejudl8j6s4/r3gYMA=;
 b=uWZmwTgXtyOSDsex2L2a3TSm1xkoPzDZVd9Cur493pdqTpmzr3Sf1pEjiBWvHu5YC3Qdui+RQ+3PeSJKMrPMGnKEReoDFJYBBdg5FMgNBkNxJFQn99f1iLZbYQeiFDtjrq9BMdRSFerZ4uYiDy5hWqPgEX5Sf9tlcEmSfQhp2d2s5jiLdNiet1gUEaxMK+G9bafJoJZ9BflDg1xKYRrv1chaqG2JnOKN6m+n72j5F8JLYbyda/us2F/50z0tR64bfiCPnKqQLhE9V+g2LL+ZurWMAsvmPraZaTX+tULiZsHtVSF6NItTOk97fbEwI5WboonnqfVPaqhv/7ZJnEPxbg==
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
 by TYCP286MB1539.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:180::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 13:14:31 +0000
Received: from TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::82ce:8498:c0e9:4760]) by TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
 ([fe80::82ce:8498:c0e9:4760%7]) with mapi id 15.20.6064.035; Tue, 7 Feb 2023
 13:14:30 +0000
From:   Dawei Li <set_pte_at@outlook.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dawei Li <set_pte_at@outlook.com>
Subject: [PATCH] fs: remove obsolete comments on member ordering of random layout struct
Date:   Tue,  7 Feb 2023 21:14:08 +0800
Message-ID: <TYCP286MB2323C8F54CB121755B83F5D9CADB9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [p2BlXTbNQ7+z+CiYfLY4pk6ZnbbQWmgL]
X-ClientProxiedBy: SGAP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::31)
 To TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:152::9)
X-Microsoft-Original-Message-ID: <20230207131408.3097-1-set_pte_at@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2323:EE_|TYCP286MB1539:EE_
X-MS-Office365-Filtering-Correlation-Id: 39d97177-c28c-4914-ce37-08db090d3f26
X-MS-Exchange-SLBlob-MailProps: dx7TrgQSB6caxMgnSm8xVge/hOROgBR3OE8ehTvoI6HdHnczsS06YhVbtV3cVkY4JCCoZTo6tXPAmc/yJPdlFe/2OCHLeTAsrhf2yTOlS1JgmXAcHLGu3HTiPpOIc7+eeUumE1WaW7FSYqxo9dDNVJhZ2W6KarGvK2Vlfl1n/foqkAyOmR670737fadiOQRo/etunWFVYqt14fk1UfT0tG/GQfYGTRo4vm+nDLhxiJfv5M4AGO1VUNkuXhlzJzoCmHBynrw4hl3fU8Rf2zYu36MrEHPmj4SBJNETQfYVs9k7kabnMSCQ57X7qUtI+VWywOuhXUEEOHWMZvpMRjI+PSnOqUL2qXk/zVVWDBScbjEn/CU4BOqANgRPrZ4VvkeIXqZ9lR9rOQ/PgKdyANcaWwauRtCUDTHpWypOcILB+ByqjYNyIgNnhm32Cx0wkYURqLbxi5Lsjr6DwPduyhnzIWc4ffrsKbA7Tk1wBpHizjFOEdVHdh8ojRYpfzXBs/oh2rR0GpPaOiNQo7eBeIf3mq+f4a3ZCHvTW//WGnp9lqvMLpaJ8Lgoya91AyL6m8uPdiiF9vMhO1R76ARa1SL228KAm2O0+/rjBVGt1Ax6XHnKX3hUCEMp0u4uC6S2F5a7U+4tj4K6Q+5Ozw1ctYyWJsfAk07Q19qUrNnG5WcRk7dIDMGB7y7nZZgrbrfIlHyWJpm8KKTknixijyOgWmoXmZh00Yb8oeLJ/2HGYoiMQR5Hhhm3EQw1vwf+n9PzgFVA79RjyZSDLEI=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8LFDcU1kxI6bdqO17sydsg6lU5aHUyF+P9EFJYOMLq22sSCr6HZ0w8QMTsMBiDcJePMXHXEW36TKLUdIVXk8E6RFxltCW2XN3gf99qp9xp0/an3yeZdp5CSGzPg13Nwbh0D8FlT/4mIBMY6ABv4Cvg+xYQ2Zj4QotIksyJr2VQDjDd99AgJjPs3CxxfwgLY/pE3RHBQmsZCkaslA26CTt5iigtzcM1gdL0L3Z91GUCt1hjivYkGI2wDlvVX35VDTTw2jKL+FX7oTScG3ZG0rHSXbT62zekYCC52PBU1xVxWROCC4mGNTtp6pIiZrkET0mYE51+D4ta/Lxbt4DrKjmCmPIQfPgKY1qXLI9q58UkVphprGMTpKuccZoXMU/WMOeUa5m1fOBlzHfLP38bRn/9TujVu+5k9BOkOuYVRyQ8Kh/gbfc3OWm4Xkz4Q7L1tI0kqUPv4d6djtOnh2gEoCT5W1rcFmACKL45bTEiTAHfdwLUavw09DaYctPrbEKBAHjgQIgEOYRRpakhReiZiziEzCZBQ0V5HQzzpNBXCXeI610kKzVo32I8enP7m0AmjdniI0I1075d5pyXSccRBiJY9IDnyBlCw05NM3XIBgZJ3oNj+96TfJoBCJ4eqjLzBEeMapVEhpRrmcx6QDl1nifX3mmvB613ZX855PeMEAhCo=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r8KVHFXRv6qm8aXnFQfBQ8s9IAQ/02dsczMMcFm7u4bEshKgSNJTezTzCP3q?=
 =?us-ascii?Q?XuFMdEgE13U/fUjyWDUo9UdDJlNVJ95WAm3dg5f5bZz1EvJ2nwGJR+Y9wa9D?=
 =?us-ascii?Q?X8SzlQ6PvCE8FOagaH27CVmnGqrtjm4yo1fV/WlO0MGTWun+qA9O7t7ESqhE?=
 =?us-ascii?Q?5CQpHTFeF8NcuVhqaGibiSdruoUIuijeKyma+wRjC9u4Fv8TbSRUZYT56CwR?=
 =?us-ascii?Q?GHhqIzyvRQhnAL25lCR1rH+QImEb9/rWnknPPkk1vm/8kR+f7/Aif9j0wpyt?=
 =?us-ascii?Q?nfQIOlOq1RRJxezcozDsztp2V/jyVtjzgZd5X3jDzuNPVciBx0kkvAA0RzFb?=
 =?us-ascii?Q?wcq/8FhDlZ3iAW+KcMCNkY4rb3T2vyEYUZBaR69q2lZhytScGonFtWYAr0Mo?=
 =?us-ascii?Q?IdJd9NwmdBks6IeMzzhwRPXYeqIfZWXbkcMJ6e6bgbhpnNsQh/woByobJ+tT?=
 =?us-ascii?Q?oprJQfSn/mN9T5ZKoiZHswYtGjGSfE6MfVqoxwXvTqvPAEkI/PGE03zkzcWo?=
 =?us-ascii?Q?8K+PnQwbDMYsrMxJzH0dFlH/o5Eq3ByScrYBOrenSSILZ6jl1oPNhBPQbrha?=
 =?us-ascii?Q?K2K2NQfVCoZHhk5bkK0UGg8xbMtAn6kx3I9xpuyH/i4HpKBHHkoQj9fVOm1t?=
 =?us-ascii?Q?Rr1+Hq97Kx0VuO0lah0vtW4CnBCNYmdmEwGXFLfr1CjnXfWIRIFDVKuL+MPB?=
 =?us-ascii?Q?2rVYLTtc6eyCKsmUOpXF/CBbiNSUZiPu9JCPYHy3QGlF9QY/78jO2KLH6M6+?=
 =?us-ascii?Q?QUwXzSZxvb4DRIPmubnagP2/AJl19fTi6MBTkt4WYLPT/MjZ/By5GwNARJwd?=
 =?us-ascii?Q?bs2NbHd/Ir3nLiqdK5S3I7ezqy6sT/I5O54L5P8bo5QR0My6mJvZGxaR40HB?=
 =?us-ascii?Q?zjhFVVErVQw6BiIMW4PWQH5IyUTX4FOGNvllf6oJzQ98rLmnvpMG1AjPkRym?=
 =?us-ascii?Q?kDy6UlGhpW4Vt17+8nOa+M9IBa2JWKr74iF5bI/u3SyhdjbsgHwoSMn/n86u?=
 =?us-ascii?Q?nPuU/QembxGxGc6uqX5+VlQpcSUV6J1MxlP02WO6mKjGZPFrF00XQnI67sdo?=
 =?us-ascii?Q?xdgJFBVWThYfc3sH1qc2FekkN2HMLV+2X0J94CNjEB26bb9WZrJP5Ns19lu9?=
 =?us-ascii?Q?rbBudUwox9loiNIGOjim13Mx6p7jaU4Xx3EaL4wwmQZuyH3wmzwn1i2alEYz?=
 =?us-ascii?Q?au3VMtStY/RYQG9mxxkJ7YtsmpfSXbxMMGnDCtjh1W3oaGyJaptRug+z68Qi?=
 =?us-ascii?Q?/Gl91bn6r3Mz3QDTQ7s0Z1/Z+xjeAYm8gI9a/vyqCA=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39d97177-c28c-4914-ce37-08db090d3f26
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 13:14:30.5694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1539
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Structures marked with __randomize_layout are supposed to reorder layout
of members randomly. Although layout is not guranteed to be reordered
since dependency on hardening config, but let's not make assumption such
as "member foo is first".

Signed-off-by: Dawei Li <set_pte_at@outlook.com>
---
 include/linux/fs.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c1769a2c5d70..9114c4e44154 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -585,11 +585,6 @@ is_uncached_acl(struct posix_acl *acl)
 
 struct fsnotify_mark_connector;
 
-/*
- * Keep mostly read-only and often accessed (especially for
- * the RCU path lookup and 'stat' data) fields at the beginning
- * of the 'struct inode'
- */
 struct inode {
 	umode_t			i_mode;
 	unsigned short		i_opflags;
@@ -1471,7 +1466,7 @@ struct sb_writers {
 };
 
 struct super_block {
-	struct list_head	s_list;		/* Keep this first */
+	struct list_head	s_list;
 	dev_t			s_dev;		/* search index; _not_ kdev_t */
 	unsigned char		s_blocksize_bits;
 	unsigned long		s_blocksize;
-- 
2.25.1

