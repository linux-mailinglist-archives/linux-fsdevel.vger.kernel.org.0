Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726E86B289E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 16:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjCIPWH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 10:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjCIPWF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:22:05 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2115.outbound.protection.outlook.com [40.107.255.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC11EE77E;
        Thu,  9 Mar 2023 07:22:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBZp69LbLGq3HLC+g9DslItHy6JmL9+w/Iz7oDJpbe2+mKPFnZYdfHF8QcJf6Vrw2CCfuJj2GFbQs4Ero19J+ZFaYrrnqGsjYRqppe8pdSQgkj0GShsPeElQSpoCt49/eLAGcC+6O5UM79RxTdE9YHFmRdO5C84svfEO+ckjJy+Mqjcxtxq30c2AofDp4FzlSo5oO6f4UxDMJwK7nHPloCD3KRGIRdsRMK1Q84Kj3t/CZ9yquApnEM0vWcMFydtqnlETYrPel6mpsFr5ytVm3Mhye0iXj0E9Di//1gKZ6EGHW9eSTnhw7fZWkVSQGD6XDSbmiqEcNQH4e3QNfFTbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwynQujYWLmomSTW+O+riD1QybTK4tF8eo7csGlUAVc=;
 b=SGGQlROZYZqBYiwqCGj+Z7e+5t+DutwVuif+oHYLgwW1XDtkL2C9iK4Ne1cGffwnHfT6n0JHP4L+n/WZFJ/YnTr//YiWQutG4fSIQXcXcqpuwa2JaF1cq0UUfwADogIiEUcrEFrWoRSo2uqBWMJAfgUlsWZ9T4J1syP2Ji/l9Gif0OEshzknXKN+y3Sd7PgTb3Z94MOPifeIIqKfhkyZH98ph0zGK+2jhAAgSpUBlN380miPOT+Ul1t4emJeTKOiBXlCz0LaLBYYNMDpkK0G2jFeBKGSv0XF8yqxXkFlnw9Hph+gQ1vVNlIBsSQgI7HN5Nmjd0xoLHoMCGLtTZFi9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwynQujYWLmomSTW+O+riD1QybTK4tF8eo7csGlUAVc=;
 b=QNoW48eaQIMcvUo6+PcGITmRqc/cC+5Fq8oNP2n9WRcm1gqpEYHISyyp7bfGIw02SbhFOSqWXEzI+X0xQtoprUIzDyuYHfXuXqvd2zFKK9BkvrtFO0LFkGTHGq/hLt3pQ6+VaxjEf6SC3Sa3AaXWG1wCSgVS9gQJXi0vvC+OW+lPfnk09ufw+4YW6HlIaA3zG1QZfq3dOlFXr+I1P/XOwcG1xNAtp7n44cy9u7AfJmGomVeZZFsedUJ6GzRCXdMJheBUHOYA+sa2v9C9mEGLo20y25LWWWe2tO4Fu0ZLdhio9BNR/jRryM2vD6MJ7OiV+s7KkZZI7udVgJeybcefFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB4073.apcprd06.prod.outlook.com (2603:1096:4:f5::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.19; Thu, 9 Mar 2023 15:21:59 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.019; Thu, 9 Mar 2023
 15:21:59 +0000
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
Subject: [PATCH v3 1/6] fs: add i_blockmask()
Date:   Thu,  9 Mar 2023 23:21:22 +0800
Message-Id: <20230309152127.41427-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0168.apcprd04.prod.outlook.com (2603:1096:4::30)
 To SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|SI2PR06MB4073:EE_
X-MS-Office365-Filtering-Correlation-Id: aacda692-1cf9-40a2-33fb-08db20b20679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G4Pjw5dPbaeSobXs+hHJALkpNaxqVrInZ3P/dUvslGuaxS5icrGf96zouh8jplvNB9vxQpnsRa4gaNPe9gzbGAgkRQuqoMpWK2YtRZrYOxi/fHbUg0iZZk8HjtMdiLqjf/ov0dojwJNNBbB/ygRySIB4bIdMEODvYaTpf3G0gVGsT0D7Jun1L25zdyUQ7QsQW1yWhfSr0+MOlLlMfqv+5xgdiGTE0/9yV5erJa68ZZueXzRTWL6oKJ9OuU8nXswEKxPdf6Sf5hNnaShnX4myd1MlY0lTD2ARtH5B90utrosTWZMq4TDVQ7rw6xlI6tyqtdGvGSVcLF3zxvUFn0vh1NBpjmbexF3RsSAnIj0JzZIh/N2GsbArXeBQUa+8qcXm3W0QJEmgOYGEtW1SNhwc7PT5S85ZuHMsis3CphPJz7RbmM200a7tUwDGJVpAcs2MkWYQi2cRBgudTs6l9WsnCyFwsL92Oc6AR6/FreBUQfHdmWY+LqBgWE9Slrq4X3+PdpDRUWf2u7sbODRjuh4UIcCi1fScvBGSQsiFA2hJ46TQ6HjXkwogwGmwjhaadTdg4JkwBll4ZuUrp2ySrxyu7VmevNbfjyYLp6VKPcMX2hJdzIL12yyxeh0lT9FPrjtv2D10vqjZ2dBlaq/Y79ryV3Uyg6BoTbLONg9I29xM/n0CUZYLqey0NKtt3hy9QrqF6Jzy2RudsrKq/ACGuN/QN+lKCqraob8o7IelUu4FL7k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(316002)(36756003)(921005)(86362001)(38350700002)(38100700002)(1076003)(6506007)(26005)(107886003)(6512007)(83380400001)(6666004)(186003)(2616005)(8936002)(5660300002)(6486002)(478600001)(7416002)(52116002)(41300700001)(4744005)(66946007)(2906002)(66556008)(8676002)(4326008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vFx2AaYmgjQTOiYJdNJ5Y2pz5I2+7gQRUQbTGVCKvSa8v7E+P7ep3I00wZSv?=
 =?us-ascii?Q?VfE0nFh+V+/xPB515Yiy/hhWJnlrxR2D24OkN7vT5hrKrOwK65WOdtB/q3bt?=
 =?us-ascii?Q?Cg4GXr1OcU9EWW5SXgSdswmVrlvFNICPgND5kmkmOg31+mLQ/FO8TKs7y46U?=
 =?us-ascii?Q?RKav4GuVECPl3g8Ok0L3KrAnJEzy4g5Pjrv3ooz/N+BsiyGlJo2wVWrK4gOk?=
 =?us-ascii?Q?Hx2EXIT84qNpt28auIFSAmWOqLe7e8lp9+JnhOZ0Hna6ElQYpx6XsEbYAP8b?=
 =?us-ascii?Q?2+TPTk5YPXLjFSrF+KdC/VDd5bKdG9oRDm7lI283GnZ9YRrzr7xX0/znm0MS?=
 =?us-ascii?Q?kg2zM/eD0Z5a4mImqncZgy0mNRzjS9y9oPF6CdPLarhGsKj8EOPuhx1hiH4l?=
 =?us-ascii?Q?o55dOTH46d4uIQYnWJYxb36hwjopa+sxAN71ybNjJsDhy2Q5d/vmvskZvUVc?=
 =?us-ascii?Q?xEr+h97vTkmopm4HLy8N1O2AMxRucb3LR2kSNbhFaRMQuyFtSX+EGl1RRUL8?=
 =?us-ascii?Q?Plh/gbNRe8IS/91y5TgY6uW3s0e/aUUcN4b6I+VRyV+dfQco+BXJYpgH51bi?=
 =?us-ascii?Q?L3oDXGZ//CJxHIU0GW1sVPHgPeNaa5NhxGYMz9F/mUWnd2KerbGPDMx932/T?=
 =?us-ascii?Q?YLTGfz1BvRnvSlik2oaFpdLdZcBnpn6YtIEhT5mONy/vjZZYoAbmMLB82rbp?=
 =?us-ascii?Q?tRxFb1of7/VPlkdMzzbWgudYviRcB4It6hhNjLGwm1hLN0slh2p3XAT44KaM?=
 =?us-ascii?Q?9IPR/0zcnNsDzGfOe5xUNCYlSbIVggR8FdGOtymqpBKxqVMe8Ar7NjVOrrNZ?=
 =?us-ascii?Q?MF73ThDzGmF5vbspU5mD1DtUdD+P86kcvB1D+ShJ1WXvwEnvAbaJ5bZaJ+A0?=
 =?us-ascii?Q?hL/l2HW7q/spXdnqB6TVIoLg2MAE9JnNXfzgsIuw1Plj7Qm+3mU6kpt5nLZU?=
 =?us-ascii?Q?t6mtWMTBVLx0AyboOaRr47q7TmT2Qo2HnJvJq4XYi/efWXkTwFJqimyD2z6D?=
 =?us-ascii?Q?VuVmB3oATIbFca6/vcI2oUELNeyxOevQ3WEcjeZLgDD3qfMk+vagfHq9C7Ig?=
 =?us-ascii?Q?QWbVflP8/m3opCF6XYQPhef+qBLYhsGh1pt8tKhOFQ5phA8V1KbdcYeqkuOQ?=
 =?us-ascii?Q?Ba0LLLP3RDkP/b/I+RSYNadSLCUk8nykWiG2d1yjySC6koy9py/eXuCn19A5?=
 =?us-ascii?Q?ACEBPiuO1J5+iM6HQjiTlLEwo6F3+nYRGHYY0REkw3lfHwapMsZJM6Eho4mt?=
 =?us-ascii?Q?Do/NFIq9EEQ0l1fZLO/KBXQyzYZBAE2uSMsAb65B3OXg3SJoESDA2Ff12zyS?=
 =?us-ascii?Q?m2MQhiF4Jk4Nb19tenHd0CnhzP3FFJR7mV18bLy+byQatBjnhMQb6syxZcTX?=
 =?us-ascii?Q?8Rbik+sQrcd32mOHluSAB25n0Jvyx+c0h8LnWnpD1K0eHwAi7lhyJwnDpXWL?=
 =?us-ascii?Q?Tdx4Md19zaKfKYbVwhSLY8VoKto/mpq7hLWp1kkwRQZbxsQTK9OAvELAISiC?=
 =?us-ascii?Q?qqOBniy+WF5ditT2ovAS02OEPJdCpoXN3fheGiSJWGCw6PGoShpK+wMU5Nrh?=
 =?us-ascii?Q?cQVagMdHPE9VDkQ+Z7PmcMs3dUY+Re+9mJcAZWp0?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacda692-1cf9-40a2-33fb-08db20b20679
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 15:21:59.0430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: otqDAUOTrXaBBUEezH21yUh1L+jDlF9Dyb8Bvsa2Kw1WC6aF8euhBTSXugH8TLCPAudua1xbzopsJ55utVQnWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
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
v3:
-none
v2:
-convert to i_blockmask()
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

