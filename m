Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1431C7407E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 03:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjF1B60 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 21:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjF1B6Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:58:25 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2108.outbound.protection.outlook.com [40.107.117.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9C8DA;
        Tue, 27 Jun 2023 18:58:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8Nj1OIsropm4MECdLXeBaIsDaMXxOlZAxIqgbqk9lS9t5xrct4mhHodoTKVVjQiZG0XHnyLjlxlqgIbMZuXQn7UWhzGAvWXgV4CRCHXJA6PlVE2ZkaRkmxzoziQ3XNqreMQwksrwuCQUayETyfnhFVXKDaBS2XSv7I8hVbOa3KNURsQ6Nz1QDncuZql9iuV2/3A0TnTrwQZSH0Bx0HIcuvfmk7j40vlqYVFEa5wXz4XcP2P/yMe97kmSEJ4BAo0dAlGGMEiPQGsYRzsr0FHZUmr1ajSyYuUeI4vEaIQc9C59e6wnetK99hgi6BniT0aGKprLk2hdlpiCtRpBvSwbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzsK2C7yTU8Ti6IoXo8eyCzEtGIyWD0f4lV7mru94wI=;
 b=nXkXAEcPGKO3p6qJJF1u3AewadcisaFBg/NlANI08zFbTa4Yu2MsA6IU876WDbPp4Cnt1ThdqdIcF6IRBgPjCkohMOVah0WOp8qLCh7+wMuUJP9YfXZm7a9XBvZkE8nl6j99+8NoAmXcndD+9E44cGlabIt9rcrCzfO2vqWMVHMR+eJ16v6RmPbUMcUmB7j99z8OpJebMXfj0xW4gKRS8gW7dbk6u12agW/n4KrTFneVfoXeikOYbKrEDmIvNX31gvGw7QEu7SfutHaK6+tY+QiHl3CQwHTyB+4nwWEeok716/Qf44QCgvwM1TetTv9kiCLq5XQkSHALy2yZPxN0Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzsK2C7yTU8Ti6IoXo8eyCzEtGIyWD0f4lV7mru94wI=;
 b=UAIc4xuhLSLOkHpiVnH9JlWkrb917kfDRLDqtHrUdioJ62PSycQj0qG+fM1tfz+nS+7DUwcE6kZZlxKpWt/i9SgViylogBiTfdb7gSAp4nb4TLyuXYVWuEnfWIsj2PPYdfXRim5tiIbJdpMdlqfJOBlbnwSeFc05gMtJdJBxizM+bXE0506KpGEH8dy4vOOKnDEtsXjClu8Gh1GGx27Cxb+8REw58Ckcz9wKAcwmGPi3JdjT38yAgRD9bnAhcZkakRYQMCv42qDUt6aFW4Tx9TPj43TPmox53mwEbBdPBavnDRCeEj1GnOQ86DEe64lHox/n5r943pBWOybpwkHNfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by PSAPR06MB4518.apcprd06.prod.outlook.com (2603:1096:301:89::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 01:58:15 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::f652:a96b:482:409e%6]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 01:58:15 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, luhongfei@vivo.com
Subject: [PATCH v2] fs: iomap: Change the type of blocksize from 'int' to 'unsigned int' in iomap_file_buffered_write_punch_delalloc
Date:   Wed, 28 Jun 2023 09:58:03 +0800
Message-Id: <20230628015803.58517-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0149.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::29) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|PSAPR06MB4518:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb26ad7-479a-4cb8-b42f-08db777b230b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /AuG6m1OuATbWRyF2Vr2qqFTLbN4BOvz+r9yoY7l9PE39NQcOS3xAuIsPkIFwKRAc6XhITjjkaQZi4sgXbejTUC6JiWZ2YaJV5mY93vZQfxoM4URGLmPkO1EDpN8TBeLY/plOBaRFH8gIbqRHca+ci54ehhnpm3C3eHzXKmcFVUvAKiaZw9c0FRSk6w7fmJevtwJTyk/YfM1zAlpwha15Cu3MEQvnh4ZA38khoSJAJHL2Erxw1htp6Nf7cni17XB8ZKc/ueA5EA9j4LDss3jWRH82u6sqnTduyGJZdgKk4JVeP/8x+F9/aGmyUPtpcfxnnVlUPbcy3AI2dLzjLJahWaRtlUdhh0rgIyOyxF1C0RWONqDDKOrY1BcmIbSPHSWf27w2GTCEcc/JAq781f65G+5or43TKXBmbD3UimJ9sWvFnks+7y+S/Z5iXLjckRQK1vvhDVr1olysM/WtDDQMOu5kdpem25sTBgSRRQHMT3AK10/tsgOa5tlU+c8AuWuCBe6c0mrFsP04KwOjFc1Wp3+j0PQkM4VVfUCqnHXAQq4FqGWyKLszQkRAsuxPh5Cw6N5bVvF4+AGaCDdHZJ0WmhdyaPeHlcxmuHkHKceVt9AFRYbOxFl5R6pcpGsf1XX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(346002)(396003)(376002)(366004)(136003)(451199021)(107886003)(6486002)(2616005)(83380400001)(110136005)(6666004)(52116002)(1076003)(4744005)(6512007)(186003)(6506007)(26005)(2906002)(478600001)(36756003)(5660300002)(38350700002)(316002)(4326008)(66946007)(38100700002)(8936002)(41300700001)(8676002)(66476007)(86362001)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WzgtLJhMJQZ5OiPiSpI5O+TH6t7XQuovep9axev6NtLRWVfv8mX9E+jBNK5P?=
 =?us-ascii?Q?BXD2rnJoqPdGQJRYqkz0w0NY9izpiSIK+C0pY+QGXEUAeeW/Ej1UOvxyeTZA?=
 =?us-ascii?Q?Vil5TQDXd3rhMiD6MSHZrJenFihKJxWkbvxpc2pgPt3YRRN4iTH0BYVio79g?=
 =?us-ascii?Q?2UV85jP5oUVR+t+CcpkcrUuIOv2ik8MLIEGeq7zepuS/Xafy0APMaxaUgG2k?=
 =?us-ascii?Q?OSv6H3DSrd7GyG7ssh2unXiG0r4clD6FQLumio/oQ9vdh9FZP/0LlTXX02jv?=
 =?us-ascii?Q?3Dx07+Z+LC+7+LugYCjORuFrtpcEr7F9wc9nKdoX4qX2HgEL5JfXuPuOzaGq?=
 =?us-ascii?Q?j09otrJ6HCav6LuKqaw5P1mB7fm9f5+58lMvfklYiYtUDW6+kllpB1EKRFC3?=
 =?us-ascii?Q?bteP2/8fsLBANmJS84rFe1+gaRMgt4o3l93c+bPOiUFJJ1QTA5lwN3myVUj3?=
 =?us-ascii?Q?ziT4SXOx+zIFcCrbgm833uCdyqRspozQZvXaFJvugTmq0thztaY6hgsHiIGl?=
 =?us-ascii?Q?IrwcrA8xyuMgr6yfrWXJiAVgjy2vC8g/gv01Sc63nBydqoivUza16OCgv7O4?=
 =?us-ascii?Q?RClgOmIhr6zd0E5vZ8rH8vb6qmsm+qxM2F0kZU8OJFqnerNuHcD7m/s/qm19?=
 =?us-ascii?Q?lR2cJvPz0EhXwkNST448183gDHUqDSo+W3CNFa0dE0WGLCjjFrA2S5tO6gb2?=
 =?us-ascii?Q?/mwhkgfq9ZKcG9o+++cNrW8nQFK9dmc8jXHzQb5Qmm6+hC19oy3WuEh6UyUl?=
 =?us-ascii?Q?AXNYIe9sbH+TPl3WhuSQcdiFoWYDD+1XIt2gnYCENyhGUkY2aZghMHuPqCRQ?=
 =?us-ascii?Q?vBb0LWwe8LrFcA9cI73AVWDMMV23E0W8i3OjovvAtAGF92mVNDz03qs+DxKi?=
 =?us-ascii?Q?iNf1BsglaudY66nCX+nafwi/lq5ayMPpkbaaDKk/ck6wnutGHl9yOMzjslWc?=
 =?us-ascii?Q?tetBEY7niMoW4uwABGdGa5G+hDqc8FG7kHXNc6qBteavE/sqEB5cAvczRLku?=
 =?us-ascii?Q?EVWJ6O69SJKHVzZB14FhLqyqyfj35uLNcGoB/jELm77uIU6KafX1kW6/ndUc?=
 =?us-ascii?Q?jErtexcCralFMcNnGP9DbDaiFXs7IZLDyFWumHEKkdgdvQBvbQo1bUOOoA3B?=
 =?us-ascii?Q?yXeMjNREZmIcblY1COY21fxXOLiylyf+EWh0r3ShoVI0UsHNm35ZZAuh5WaJ?=
 =?us-ascii?Q?yjj3DoZWvKYJu2Go8IY3f3a3FQPQ1VEjpV9P0/YcpiPudRQM/Tt6zskSr7lE?=
 =?us-ascii?Q?u7Xv6lko5dOv7t2zAE1B/RuxsE64PXemMJg6bebzLNiMUG3LTZj7FcYxvFzx?=
 =?us-ascii?Q?zH9W+4NuoxrrStQgepPR0CenyTByTrbHa9/JlieR3G/Mk9DaJyBFEI0f5b4W?=
 =?us-ascii?Q?HPccbtZrvJxwPb+3fF4Wn8njCPjk9wgWUH104Uta6XIQBobmuhBnlEHpOrdp?=
 =?us-ascii?Q?s86fPmORE5xo68cnI05cTwwJnz+VbBFn1aF4cXsn8/x8XKb0fycYy3Q1fky2?=
 =?us-ascii?Q?9SMBHHN+De4bisf+qCatO/6mxaxQrWOHXDxZSK/0TDBtPimgTCHO3//s7JAd?=
 =?us-ascii?Q?+RBejTjcobg27hQdZ0fYAPrUYKcYdNhj5qVb3VmJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fb26ad7-479a-4cb8-b42f-08db777b230b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 01:58:15.7628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASBtTFLuKElU7klo+17UVzOEEIGeycB91udGxujPajTFzfqPBB3vjz6xM12Ozd61ZqRDHt1ZFvXFebMRNp0iEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR06MB4518
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The return value type of i_blocksize() is 'unsigned int', so the
type of blocksize has been modified from 'int' to 'unsigned int'
to ensure data type consistency.

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
The modifications made compared to the previous version are as follows:
1. Keep the alignment of the variable names.

 fs/iomap/buffered-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index a4fa81af60d9..37e3daeffc0a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1076,7 +1076,7 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 {
 	loff_t			start_byte;
 	loff_t			end_byte;
-	int			blocksize = i_blocksize(inode);
+	unsigned int		blocksize = i_blocksize(inode);
 
 	if (iomap->type != IOMAP_DELALLOC)
 		return 0;
-- 
2.39.0

