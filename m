Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B9653F416
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 04:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbiFGCuG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 22:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbiFGCt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 22:49:57 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2097.outbound.protection.outlook.com [40.107.117.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC32C5D8B;
        Mon,  6 Jun 2022 19:49:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChUktE4qZb/X3mWCzSggw5fRiEK/0zbbrhQhmB1YwnutRMtF1JggGqS5nzI11EXMrgxGh8OBaHrLxmGXi0BVIQGVJbyDnfDldSn4kJVfFv8tpl8syYR8NEeMGgqn3pjSOm+2ZhAbiYPTEyUiXlX7ylAZFwjwdWchIQtQQlTOka/Akhybmyy1plIVyn9UkXlKJsUZ5EXJ8/rajdVDyE69Vt2IrpGPHtNDk/j3HALN7aFst5nXS8BWtdy49F+vQu8s6dENouiNN10OBs9xPZYfb+kVjv+09eJWSj9JUsY0R0xKeMbN9SIqRoXol/OK+RlvcYhEjhDJ5f0xsI9hA/JXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bcvw37cBXAgF/BSF1p/zye6fXaE6PtlBSlqV+N6AAxI=;
 b=mxoYGcLfa80EO1nXJ63xq7tNeixMHUd+DvB+3Mx17Acvdd4DoS+mBOTCFI5SDN6/d5hzdtL/2UB1fdNKUeW5ARID5Tg+84xKIGvc49AGak6rfPIl+eRndON1fIrvoQJ7HwI5KGe7az5PXq8Fj70lDZtW9+z5C9+X1rkcmsR91Lr/RGXbdw+PB23P6GsIjLVnCzybiT2bvA0DiH5yYITlVNCRhmYSU05Kp9YXBx2QvxRPNWefhwvqYPnU1KXucE4d3h2QfcHILL/+kghC7rJ6cggschCnTjukT2Wf9k9aUkg/+1xiPfTBSqOKa7mapgcbF/aq3HBaZo4tzbvnTtpBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bcvw37cBXAgF/BSF1p/zye6fXaE6PtlBSlqV+N6AAxI=;
 b=WO7F3zm7dB3hRHS2KzUqxbHj/jJJYuv9zNVk8Sjrwz++uP8eYFzPYLf/bbv0lHFF/m8zUhB8F0lEzB0PQZBh70UrlVdFnrB5RxXWgRhFhf8P2CsrckodFTCPNfMde4iwrTfS6LagguZNZGk7Tb3V8pyYC70fDS432ZVk/lnM0YI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY2PR06MB2525.apcprd06.prod.outlook.com (2603:1096:404:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17; Tue, 7 Jun
 2022 02:49:51 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8588:9527:6e72:69c2]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::8588:9527:6e72:69c2%5]) with mapi id 15.20.5314.018; Tue, 7 Jun 2022
 02:49:51 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     linkinjeon@kernel.org, sj1557.seo@samsung.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <frank.li@vivo.com>
Subject: [PATCH] exfat: intorduce skip_stream_check mount opt
Date:   Tue,  7 Jun 2022 10:49:42 +0800
Message-Id: <20220607024942.811-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca7d2ff9-2372-46ed-2761-08da483064ac
X-MS-TrafficTypeDiagnostic: TY2PR06MB2525:EE_
X-Microsoft-Antispam-PRVS: <TY2PR06MB2525247A8CA8D6D7ECD211DCE8A59@TY2PR06MB2525.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JeeC1NW7zttV9o6E+vI3eTUSsfMdzptyw8yfXDkuLQbfkzrmwDkY4RsDrozqJDU+FDwx010mMWSEa9tFCvwAPkZ09Cpo/KFP3lwhfwkH1IsEgnNF1VBXz5KjyJ0QzrUFstGXn1CBgaVxeOCLdTiHSMU49+L/Lnpy7yCHv6yK5qTQz3T1G5jLfkMBbBaT59QeRC74jSjKjn1YwS6zMEu2cvJM4hDSqhdKvYFwbAkQQ8FbXEdsYt5VjlUwQcRrJWhqcFRNtVgNOrNgHsyajlclNSFtKYK6SMr5kHMhrvsM9eu77KMVEWoHWkBk0TZVh9lfbTvTjq0+vLgsXyl1PPOhUwljqDAZLFNi2CslybgRwlSAiCwPavO6Cb9hz0Ddt4Z/AogXX+9IHPmAq6TXnuhAkl1BSGqFaTC+nfUDn2viD1yiXOJZlioOqHXmhimOHnX8038c1WDhvbJ6ulh9XWhKOuG97ybFP7UNziYFulbugzXKIo/xkDwBKwcEFXX/9KHwL9+P061Fv5an2wBhOXETKjv6Wr94TQdu624z1tSwIL+rKyNkp+T7dtPnaFyKWNoiBIIljPKu65kGLdibGwDSZ5OFIxn5LG4XENVYMNR012JOa1Nosr2wOUYYJUvuQcQAlDIZjsiOEKM4umx5InaGtimzOA/0uSqH+j885SwqXEObLBJ17SVTQD6IOi5yKx0o
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(83380400001)(6486002)(52116002)(26005)(6506007)(107886003)(508600001)(6512007)(1076003)(2616005)(186003)(86362001)(8936002)(8676002)(4326008)(5660300002)(66476007)(66556008)(66946007)(38350700002)(2906002)(38100700002)(36756003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4ZWlsJH0EbFtmX/4jrx77n6w/R54baS/HLrYcenQy6w+NOE9XCTnhnBGhL/Q?=
 =?us-ascii?Q?xvNptnsSOsqPCq54+hFwaq2546M6cejlVfgpj5pAiJZ5+yOTRKgVbXyz6x5Q?=
 =?us-ascii?Q?T0vhd8i73iqKv3J/sQtnHOeI6Nuz2dkYHakQhXidoP+MFanNTn47CdiVNqfs?=
 =?us-ascii?Q?c962g89f4GPGEDMKmg75hGUgNdYVAjZoSOGzasN0vQC9vzD9CvacNmKRKT2M?=
 =?us-ascii?Q?1erciUk0VF0Z8ZKGgzPRwp3kBW5fF1+hKUOEqMurXT+L4CWghxyb5AVSPVva?=
 =?us-ascii?Q?WDBCLHU4dECIgDffP5aiKEN3f9sSihtk7lFXhNZ1v1WiipvOHrDn+X23bX+m?=
 =?us-ascii?Q?VYzxKPyv5hYxYkrI/h6J1YAkPx85nhLwZNsDkwwAYxSRDdGJemOb2ZaCbBp9?=
 =?us-ascii?Q?1H6ojDYCvkHdh7uP5wxBdQsR+HSShNnm8QixspMu4CsGceXTk5QJIaPCVQuO?=
 =?us-ascii?Q?1+Ws5XqnO1wUPjyesW4MkCGqjGfzRQkNwDOMgSofcTfO9u18foJaJ9dLkTU9?=
 =?us-ascii?Q?IKZY7kZs66Toxf5o/AaQcY/gOjWynXgniXzYsoAf7PmGNzlgozAyl6Eczfvc?=
 =?us-ascii?Q?n3hfbfaztg2eY3ynDMfYxpBWtuNqioBYfdEZV9z7qdPlaGKOqygnLf46U7nn?=
 =?us-ascii?Q?+tWKI+sUxHulJHIUxVSlqW8q9Ky0b7k6Zr23Pg2zfkCIIl2a8Zmm9vq06jnI?=
 =?us-ascii?Q?LL+XJJKdBOSw9CXruxsZIttVWCUtocMfsuCTLIIWKCla5XSQOKTnSoJjjVux?=
 =?us-ascii?Q?bokz4h7ulSTcFPGFz822vZmuFjDHzEO5crs/vQ4Aa1GbExx6vnVU4z3j/DjQ?=
 =?us-ascii?Q?I4/UipBPOzI9R3u5Vg3su6dMrOohQOthjIkvM74zlXU9Y0t6c3wNdXRvCOkX?=
 =?us-ascii?Q?uz2xZXKUUjkQTu/hqU/mEL8vaX7ffKyTlhftlnDWUttbyQIRG9HvAUabqH9d?=
 =?us-ascii?Q?S10Z94izM9fLOnfcxZs15Zc+PN3pUxNtUdbQXvkqS8RkKFFvnePywgNKOwM5?=
 =?us-ascii?Q?OFPyX/rCbzxyPTYBTVYV/ST1bjs1jqdMP4TrAMFeXEoyWS0W1qJTBeUUIVRL?=
 =?us-ascii?Q?5278LLuPBKCkCgqtPE0NfsQC/sLUMZ3d7L+3ETE41zjjSQL/VfR8iQS4uIcd?=
 =?us-ascii?Q?XI8CXZmNsvMyk3kAIs1+EVISbIZNwUBIHDR1Er2zVFlC3WjwSYcSOdgeXtio?=
 =?us-ascii?Q?3TFrHdc8QfaPMLaOIMAsCm4PIFIkPRZA+XQ7yPmwOG0Sfq4+YvErnfVqkMWv?=
 =?us-ascii?Q?SzGjKWTUjduC3HwnzkVeNeYGbEXmFC0bfkBkukIVhmxSh3Nazku8sWtUG6w+?=
 =?us-ascii?Q?IB9HKcwQUY+vBbPuElKSAt+ZtswFD9wU7NJA/7vBr+WAbZwgt73ZCYFrLNPG?=
 =?us-ascii?Q?DfdgdchYkcFk/Yh6m/gSFwa9N5Ye1oVKu1PkpCzTdzTn/CNSMd4XdJC1tGaP?=
 =?us-ascii?Q?7gNiwDcZvqOdtEjhM4DjhIgTpw4kRVsf6psIvKRPXJoh4Qoy/ujnCINgJm9d?=
 =?us-ascii?Q?42fvXfod2Ufa0Wmnem8tKvBVRfppi0j/tJb/dxY3bxK6rAqmzWc3RZRsNvIq?=
 =?us-ascii?Q?52uFh2fnBYuNippFVlwsVzJ+NDo/JIuMWP3QBhmheDxOhrE9jGUCTRGwxi9y?=
 =?us-ascii?Q?zu8YIdqOdmqO5+3ZbJEkZXp4SlcRhQgQ3oQeShVJRht9eiVt2EgjFblJZzPP?=
 =?us-ascii?Q?i2CW2+WoUPAhF9JjhBXGMyF0KEL2WOtq/Rt+fVVecPKcaeOvTuCddwm9LihB?=
 =?us-ascii?Q?FSJC8Ve8IA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca7d2ff9-2372-46ed-2761-08da483064ac
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 02:49:51.2386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/LhmQKChBCgfFfICx77DFkG7Y8Z1/FuSxW1yQZ922iJbVkh9X+hFLFYDbau5H7xFc0jXkqM1S/QqMCqKiIltA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR06MB2525
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are some files in my USB flash drive that can be recognized by
the Windows computer, but on Linux, only the existence of the file name
can be seen.

When executing ls command to view the file attributes or access, the file
does not exist. Therefore, when the current windows and linux drivers
access a file, there is a difference in the checking of the file metadata,
which leads to this situation.
(There is also a difference between traversing all children of the parent
directory and finding a child in the parent directory on linux.)

So, we introduce a new mount option that skips the check of the file stream
entry in exfat_find_dir_entry().

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 fs/exfat/dir.c      | 6 ++++--
 fs/exfat/exfat_fs.h | 3 ++-
 fs/exfat/super.c    | 7 +++++++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index cb1c0d8c1714..4ea0077f2955 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -1013,6 +1013,7 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 			}
 
 			if (entry_type == TYPE_STREAM) {
+				struct exfat_mount_options *opts = &sbi->options;
 				u16 name_hash;
 
 				if (step != DIRENT_STEP_STRM) {
@@ -1023,9 +1024,10 @@ int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info *ei,
 				step = DIRENT_STEP_FILE;
 				name_hash = le16_to_cpu(
 						ep->dentry.stream.name_hash);
-				if (p_uniname->name_hash == name_hash &&
+				if ((p_uniname->name_hash == name_hash &&
 				    p_uniname->name_len ==
-						ep->dentry.stream.name_len) {
+						ep->dentry.stream.name_len) ||
+					opts->skip_stream_check == 1) {
 					step = DIRENT_STEP_NAME;
 					order = 1;
 					name_len = 0;
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 1d6da61157c9..5cd00ac112d9 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -204,7 +204,8 @@ struct exfat_mount_options {
 	/* on error: continue, panic, remount-ro */
 	enum exfat_error_mode errors;
 	unsigned utf8:1, /* Use of UTF-8 character set */
-		 discard:1; /* Issue discard requests on deletions */
+		 discard:1, /* Issue discard requests on deletions */
+		 skip_stream_check:1; /* Skip stream entry check in exfat_find_dir_entry() */
 	int time_offset; /* Offset of timestamps from UTC (in minutes) */
 };
 
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 5539ffc20d16..e9c7df25f2b5 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -173,6 +173,8 @@ static int exfat_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",errors=remount-ro");
 	if (opts->discard)
 		seq_puts(m, ",discard");
+	if (opts->skip_stream_check)
+		seq_puts(m, ",skip_stream_check");
 	if (opts->time_offset)
 		seq_printf(m, ",time_offset=%d", opts->time_offset);
 	return 0;
@@ -216,6 +218,7 @@ enum {
 	Opt_charset,
 	Opt_errors,
 	Opt_discard,
+	Opt_skip_stream_check,
 	Opt_time_offset,
 
 	/* Deprecated options */
@@ -242,6 +245,7 @@ static const struct fs_parameter_spec exfat_parameters[] = {
 	fsparam_string("iocharset",		Opt_charset),
 	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
 	fsparam_flag("discard",			Opt_discard),
+	fsparam_flag("skip_stream_check",	Opt_skip_stream_check),
 	fsparam_s32("time_offset",		Opt_time_offset),
 	__fsparam(NULL, "utf8",			Opt_utf8, fs_param_deprecated,
 		  NULL),
@@ -296,6 +300,9 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_discard:
 		opts->discard = 1;
 		break;
+	case Opt_skip_stream_check:
+		opts->skip_stream_check = 1;
+		break;
 	case Opt_time_offset:
 		/*
 		 * Make the limit 24 just in case someone invents something
-- 
2.35.1

