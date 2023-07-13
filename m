Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD83751FF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 13:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbjGMLdR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 07:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbjGMLdQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:33:16 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2121.outbound.protection.outlook.com [40.107.255.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8057E5C;
        Thu, 13 Jul 2023 04:33:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+au0rBTmS/OogFb8sJiiz9WdeclrYr3gC23aaLtVih8cPaoy2iW4YqFnc+XBFC0ZR41iIkx++zXXQfrLPx7SnI5fArzuZs/hzvO2DR3tzn4JiOTY7eU6/6o/aYUCq70K+Z0I7s49+hcJ2NMA/EEv5fFxRPRW9N3rs4sN3Ew+vud0cXavCNsx9DIi6ep8pTWsSvwUT3U+Qjipa46ASASghHwsfN0bLmSVsMgQWlOTMg+pK2KGer6YKTSF3/4vXQsIfRi0Ogkwmo6q+G0/MhHtSlT2/9/469lbmU+C9KqS2wik4uuHCin3+A6Ehaz4OrHRBWtZUcR+WzsKgheu+sG2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkED8Tup/BiVDBlFqY6z97DBOBbHcqwFNs9Cxp+l4+4=;
 b=ndMGAWCHzlKpGA5r4X/PUi1yFqe+x7NUKrqgOIimolR+nPzswSQVYrvdvSOqNqKIu66wMcAsH4uRdsXICtVOKa2DDgQ2eAuVRlIADXzG9PpiMw7iP8XfSSxBkbRMzmusbEb5YhiDyLrQewcL30p7MZs0lKgVye+Z0kYpqVLd0ml0PMQTlSuTDUuNKmgBoPpT1sy3yCaOB65Xy7KcBDMx4BniUQONJhbE5+pJ3DfIrX5p9lKEikNbXRR6Vtl6wHUIQ34X8+AlfhnSYQbYgiWrOCQfrVyBSnSNMYsz2iMjEBSkKF8swsI+FBG55txxKGEsHSk7+G4PiTsPDtoptvoMVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkED8Tup/BiVDBlFqY6z97DBOBbHcqwFNs9Cxp+l4+4=;
 b=ox/3bW9Sdfb7h5uLEHokbfNKXGoIsflE+LzeJWV2ZDnUQKa0u5llBS0ScuA1tPLvF6JpguFEfNcmztt5IAtzv/q3Xe/5RT2IpNYUGYE94xBYqaplICSkOApkCqpv5zUl750MloExWdhcqc2HW8skblJIkrvBb0Pvh7MPBRAn1rfY9DZx3KH9Cvp5aBs1OoaZPBvvOxXeqoOsxLXR3U8vrd0zJpZYiaqcMxvu+D5QhpIWPWMUVI9z7tXhbN41irXtHrBJv8a+XW68ruszt1FCkuZI5BVgh2vEXieyxDA7FeytgjwGUqGs7cSt15yix7mkZjeb3dSX+HgXO1xGOscD8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SEZPR06MB6495.apcprd06.prod.outlook.com (2603:1096:101:189::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 11:33:12 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 11:33:12 +0000
From:   Wang Ming <machel@vivo.com>
To:     Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Al Viro <viro@zeniv.linux.org.uk>,
        xu xin <xu.xin16@zte.com.cn>,
        Zhihao Cheng <chengzhihao1@huawei.com>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] fs: proc: Add error checking for d_hash_and_lookup()
Date:   Thu, 13 Jul 2023 19:32:48 +0800
Message-Id: <20230713113303.6512-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::20)
 To SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|SEZPR06MB6495:EE_
X-MS-Office365-Filtering-Correlation-Id: 2176feae-0092-411e-16ae-08db8394f0cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WhF4RkEPjZZ9GRiyhZDjklE7jLzv8iYmC+zLfmlRQCt67m/ovSntLrPzwivKnRM2tqKpvTyZw9mbrDjtHHmuYi3vX+dtWiH763IAHyhsIsP36hWHd/9j9XilsbM3HcGfO/1TSMpKhnS/Tnx/yGNWmaX0lYjmr/RHi9fqRxsf0vijWFwhrocZBIE5lB4yWHZQRTo7BB8Hm6A3TNguwFBu9eXHDAYBfMjSyr0kIWniaE8QUyW6rmHKyHcA8WJalLzPv7cu1N5/+MRUH86uIb8m4XwmmLc9erFC0oxY+hB+MWQsJGf4KEJWZxGi8QID8dUq1ZbIhnECkjVMdsmDOmaVdIJxicbCQAoI2M/MD+8TYkHMhIV6HawRmtyvdOEZ+vn05KVK+OnkJ7HtdH2whDzvo3F66J/X2DiRAgqIx7qX99GpPdpt9rMJqiE7mDWFlkw/k2oHqKqOWNB0XVneQ8wK0csGX0NFX56Y114V3D/6Ep7YbQv7JfGFxk6LY1qhTJX3Ub1qz7zYevw5Oe4Laug2KskPomIJJ/2ulP270XXBGlr0OEM6Yf9huKQ2xPecJjUIQL0KOuuVHOTRLPLFB2QH8WsiwbHjaa2yChR5JGzgJYIw7A+tW+xlzmmrr10gBRGrRV7AAHZn9x+yW3UN0qyXxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199021)(2906002)(4744005)(83380400001)(26005)(1076003)(6506007)(186003)(66556008)(66946007)(52116002)(6666004)(6486002)(6512007)(66476007)(110136005)(478600001)(38350700002)(38100700002)(107886003)(86362001)(921005)(2616005)(4326008)(316002)(36756003)(7416002)(41300700001)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+bfvz9QwLPYVU/yKyZXbPM4IVOgSYeNIfNdcbQdV5uB0LhSsSPjY1bpAkLv/?=
 =?us-ascii?Q?YbefV4Zet7mlsV+D9KIsmA4sIJisiJObVjXRYwIXxhyOmSxqveP4ehfHMhBE?=
 =?us-ascii?Q?qLO2Ctoen/443HYnq2HAKUqpVinVa3sQrkoxSfcWBF81Uj5YETLWAGJjlUyM?=
 =?us-ascii?Q?CtgV4fDnU7illJUJ9VrGkX/hzKoIj1bTSBTYoaXGSTmZfBhru6f2UtkDGTt8?=
 =?us-ascii?Q?4VxtknSOcE9H4cLBriPJ7hPeaTnFo+TLygBD32591gyfsEuYNGdid2if314u?=
 =?us-ascii?Q?G/hWag7fZoxkQIhqk4JyUHTlLkRxQA84irxqB9wQhvv0Q0eioC8QYgIKrSxt?=
 =?us-ascii?Q?9TodLzgPGb9VCdJMRvqMEEXClr9EpOk6t6v86Dr3iCooh3TQS0/6VGNjGgUm?=
 =?us-ascii?Q?FUIOisX1IqJ2i7XRCiIvXraKY51ZOmB6PsfnOAtQOSuDsgp6EqpeBJ9BIis0?=
 =?us-ascii?Q?zzlCrbBnHDwR4cRau6UrfD9v5kJzkLd5ddDAzAtIHV6sGlMNjF9VPYvQajaz?=
 =?us-ascii?Q?01i5G//csIHCIZdaKBT2lX0wgJFwhV3/Y8gtPEbwD15FNYJAhMilZo56P4/A?=
 =?us-ascii?Q?BIe8mw9SaCloo2Yy0T8DrFlOK9oQWXodrUXpXKqK6w+j5IKgPCHUe1tf3vwi?=
 =?us-ascii?Q?eqO/CUa4vqdSliL1yh0DS9C2IsktsS1HSEq+ypwcWIcDmWRnXafTyUO89KQ3?=
 =?us-ascii?Q?0KuwZhMuY00Rn/g0E3mGgGBIJ1+MpiKX+kOQOvQ9PsR5Zju/plWh8UQ3wn4w?=
 =?us-ascii?Q?0Y8Eb8sc7Ys7J0brI3vUwCOmsuVZwWIr3RM2lOck8OWyhMbawwZeluewXQA0?=
 =?us-ascii?Q?gG6xlrIJ5WUv8U/mjUUAZhV4BIUzPkHeuTsTBBSv30ay37eKtzlns+1/jX36?=
 =?us-ascii?Q?FIxS4OgWsQaMq1Y5mFy/TmDmu6S/huW2qGekhgRnAFA4dX5/ik9nOkVAIbfw?=
 =?us-ascii?Q?juI0F3afkPJmK4CnDo6MWrmkulRpim0HwEjNDWMzTrar4zNBsZj8Y2+1lMVL?=
 =?us-ascii?Q?0mnvPD21Scn/HbG1847VmrJvAthG8UrwBhuz5n0Id/Qi6mOqjMvdr8H8MUal?=
 =?us-ascii?Q?2X5t55/UWeIKQXk3FgsXmtKmjoegRMOjk/gLhLt/aJiGwU6t65VtUQhxyPy2?=
 =?us-ascii?Q?jcghMTCOMDmQ6WcErq/sea4hmaysUGMiKb/HiJXykyI6QyJFKncNAlcLRgA6?=
 =?us-ascii?Q?gKR+9IEzeSmQYy2kzRZ19LJkmSthh/1M0kjvtx+TDNkt9/597BXJ9Z7dV7n5?=
 =?us-ascii?Q?97HKfJLhsmYJo2zRFnXyqBq+ocn1T0x2XSSX+EahCnhI84VXecXMlfpaXPnU?=
 =?us-ascii?Q?JTHeI71HA5hNHWY6YHliLBCQuS9EXnt7TAAXWu7duGv/P/KpmRD7qZltTHas?=
 =?us-ascii?Q?1mCns2BlWN5LemhrdcWO4PUpfQYozN5P6CDXWyRmmiqDCcCZ38RZrgAwTh+Y?=
 =?us-ascii?Q?DnnaqUuU/rhPekD60WhYDfR/Z7vCx7D/Hr04zG9hnwpPz43j4AlMQ2CPVC53?=
 =?us-ascii?Q?shesXCAkKBywZiYj+rbxEXWeRNWPEj+vxVxq66KPvCX/j6bVs+uW3Vp19+MF?=
 =?us-ascii?Q?ALkDujUrsI9jsL5iOkadRgKMPawwyc2zMOzCibgJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2176feae-0092-411e-16ae-08db8394f0cb
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 11:33:12.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YMHz+FeoDxpvSMLm5ufYaQeZ8KVDD5fLOWwxsQTWoxvAjIVvSF0VCeY4JPGa5FAPFW/tzMWpTmcY7o0ApigtJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6495
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In case of failure, d_hash_and_lookup() returns NULL or an error
pointer. The proc_fill_cache() needs to add the handling of the
error pointer returned by d_hash_and_lookup().

Signed-off-by: Wang Ming <machel@vivo.com>
---
 fs/proc/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index bbc998fd2a2f..4c0e8329b318 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2071,6 +2071,8 @@ bool proc_fill_cache(struct file *file, struct dir_context *ctx,
 	ino_t ino = 1;
 
 	child = d_hash_and_lookup(dir, &qname);
+	if (IS_ERR(child))
+		goto end_instantiate;
 	if (!child) {
 		DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 		child = d_alloc_parallel(dir, &qname, &wq);
-- 
2.25.1

