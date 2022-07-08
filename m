Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CEA56B6E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 12:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbiGHKMm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 06:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbiGHKMZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:12:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B659783F3D;
        Fri,  8 Jul 2022 03:12:24 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 267LPjkM002415;
        Fri, 8 Jul 2022 03:12:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=vKUzmmaj9HD089hhxLbjvs0fUXwF6qLRWuimkKOR9tc=;
 b=odbZaz4jO+mv5h4T40r86aerUD52QnhP+ZY1i8ha2KWUu436elXfL43ZI4dQxQOZXJOO
 BOIZzT6fZGweFBTil7Dg6LK55Hwvo46Nq7YqSyXb9IINh+zqcH6daalahzxpb/xNylen
 lwVygHg8IvvOAVAuuYwLVqkkqMs9J58Ijpo= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h67d23c6j-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Jul 2022 03:12:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AlKn/Wk0WI6Jq9M9PThjvrNeiv45B2IvNsVKekpT6Anh/siD6UpDpSRrphPf7axtFseSPAqJITKUNVRRk9IZ04qfwiVg3q7ZPq3Kd7emOduk5OrIJ4ykrzphcVF38TgDVUxq30qb9pYqb6WZuGogxDlyqoqF2NI8NX4E5YG+tCMyRMG6QaiPo97jVyHuBQg8PVtYsCIL79VqTY0CCO6rFAY5FTGI701UfKTc18oRJkJ0opEcD/xLMkc/rllEOLgU7ve/9mb5BP9WN7sum46rKfzOkt6vaKVdWxDKONsbmmrMHsB6c8HvyeB6mRaP4bXnSgNDM3Y6969l0clid36Xsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKUzmmaj9HD089hhxLbjvs0fUXwF6qLRWuimkKOR9tc=;
 b=nGyWPboa2kPPLFZznXen8Z6/a2VSMTQc8h+44dASbV/fVFfgGqnsO69Zpi0OKQVaMMsUdpqquzV2E2U6vZA4Qf0WlHB4zBiAJUlAe6cqdiczyNgv2pvPXGt52pBmle0PVGXRSGyHn73Wr9BKlIxUpNui0YTsM1EGGCI0Fjunwgdg0OFdZB7oCuK/y8011vZijvsD9M/ZcUVe2uVVLOf6GTrjobEIRHKei7b+ac8BCZgZ55lzXvHCictFE5AsmfmiQ3ft+tXl9Cd2S9IiFrhgc53q5VQn6MSgbjzGYmx7y03cUt2G1eh1MSJ5EBml97RWWwEbtkANMLjW/WGjRdaNsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com (2603:10b6:a03:379::12)
 by BYAPR15MB2501.namprd15.prod.outlook.com (2603:10b6:a02:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 10:12:22 +0000
Received: from SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174]) by SJ0PR15MB4552.namprd15.prod.outlook.com
 ([fe80::81f9:c21c:c5bf:e174%8]) with mapi id 15.20.5417.017; Fri, 8 Jul 2022
 10:12:22 +0000
From:   Jonathan McDowell <noodles@fb.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Dmitrii Potoskuev <dpotoskuev@fb.com>
Subject: [RFC PATCH 5/7] lib/cpio: Add a parse-only option that doesn't
 extract any files
Thread-Topic: [RFC PATCH 5/7] lib/cpio: Add a parse-only option that doesn't
 extract any files
Thread-Index: AQHYkrM2UIzPSfO/y02wvkpXYXbtcw==
Date:   Fri, 8 Jul 2022 10:12:22 +0000
Message-ID: <b5f14649db9615bb9cbfc66863547aa96f7e7786.1657272362.git.noodles@fb.com>
References: <cover.1657272362.git.noodles@fb.com>
In-Reply-To: <cover.1657272362.git.noodles@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf9c15bc-651b-4f73-0768-08da60ca5927
x-ms-traffictypediagnostic: BYAPR15MB2501:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: svbtnW8+4R/botIKPLcPPhQEiof4E4vT6+GlfoftHBkxw95+fVNKo9NYL/OO5Q1Ok8WgyDObH4G+t+rEFtgekfh1T2xr/m3AD56U8jYbFy/HZwdVKu2TozbZlseM8uPB7zxkFe05t0ipG4e0+loxKIZRcVikGn7venbYoqxM7zqgKiFi1ec7gLWeRQBcQJItyK0Gxy/gtrzrEzjGfq+pyCS8LRqmMZ1Xsx1tTKxlaMjQeO2gelhdVOESG6q9qLGetc5aAc2xMYSjaaeWc5b2hpMMlanRY3E7aw+dfCwUi0dljWJOkGjrZDwg4IcdrDF1lUSLKPwJwgc4Z+0N21BRkXEdZD6gYbCpcbV90SiL1sTJz/BkaSRrWDBWYtd+nV0MqUbkMuQMIF4XNDReYXkRHw+wqEnLtAIkvbLqkTxG0J4k/FmUpCsZhJCJOWUIk0vCKa0APahg3v9FfpyQozsEXljCHXU5/Hi+YPQ8Z5JglkBG+H/5ur6GQRmtMhamnnICsZn6QE97qw2E5ByZEe+uXeFmn/u/6pKSa/eQjy/Iz6AWuX5n4KuPlxzpjuMyCxQMkGUs3olhr3PM6MCim9wnZiNeMoh6Bp7XQioIDY9mzv4glzKE30W7YDfWRnXM7wUaG1k8lbeaaC5zO5JKj2Gna7vrCqB5c/VWuy5yMOblFlI/EJO8ugKPCaLb+VSdGZWv91oRqflc4NcK2vaUKA6W6ewluKgP09QgqilCGvHfHUofvjEdWRcYrOxFJGP6cAcQ7jUPXoI9nWp6L2aJtBYCP/qW2g+KkOYkQKPKL0XM71rgyJSRbrRFDVy86Hm8Y9ef
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB4552.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(38100700002)(110136005)(2906002)(54906003)(122000001)(316002)(7416002)(83380400001)(8936002)(2616005)(5660300002)(36756003)(6506007)(38070700005)(6512007)(26005)(76116006)(91956017)(8676002)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(71200400001)(186003)(86362001)(6486002)(478600001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WSyiQEewKk72uRrJo6vTlJ5sTsju0ISQtOyM4AsEMZwV8azPdtCAZxyGksQE?=
 =?us-ascii?Q?QEfsskrJZ6Q0rv7uDR5gOtIN/8hIYvw72JUh/CnEYHNruNFhfNvDFlKhNBQM?=
 =?us-ascii?Q?URWIjA2QlaENDsXk7Qe2Q+NpsayCEhnBc5TyiDRNMQXO26pVewezLX4j6Txb?=
 =?us-ascii?Q?KUrD7vhN42dDHYCylxtJQSd4qTVmJqkfOnTGACvfZiLA4k7TYhV3Tzf+GMar?=
 =?us-ascii?Q?Y2RVjde5TePEggTwMXg9UTyp9efA6nbaz0a8f3hdgkk4pi8rTsRBdYIyFO+z?=
 =?us-ascii?Q?NuFBAKg3LRyfgnm0DUeuzXC0ck2yBrpc2i9plnPyWISQvhQBwaj5XHrVa5hE?=
 =?us-ascii?Q?WcUMRHhhjbS3PBSzuNjngHjCPx9HEjxx/l8vjsSNvT4Y13q3mENwDyC0tVuu?=
 =?us-ascii?Q?kzgHPqyd89p7RYgXjsLY/AnwvkbYtqIc4Go2nMycr8WX86tme5/c90cCLf/O?=
 =?us-ascii?Q?cxKwNZ/p4yEtTlHh25QmhPT7n5zAmbg3wxmRVVq+8M6x02EgRdszQpQbcS/7?=
 =?us-ascii?Q?elK7F+b+TF6vR+kcfW2jO8v+PH1suIrrRTrkfaxk90BjuUEeAoOWxAHbm1pF?=
 =?us-ascii?Q?7cTtnozKAVEZAyTfHZV4Oyndbdi3lfJKQhd7ZORW7vszXCA3qYl+WJogvuSu?=
 =?us-ascii?Q?xYd2qbRPy8quMg71cmifEhk+mZuDwRikZLFra2qrdLelEl4JDCY0u+GndV2n?=
 =?us-ascii?Q?YjQdx8WxXtT06ynyUIt3WUSzavaXDU5mWavxzzFnNuDfBu9mrtICqOZvH5mq?=
 =?us-ascii?Q?8MHtuV5PDCIZy7Jdp7XOM5eEy92QLMksxJ0LjTLj1g48NUexv+elZBuFsoBd?=
 =?us-ascii?Q?Dujt5i5BqTZswk5kZSM8v8SPQ7NAK/+aNJ7sQq61/E6wpQFJbGyyRzOwxk1Y?=
 =?us-ascii?Q?lNBuUY/zxOBP0GHFeSFtu2jAxhv6FkJqPK7FCfYZtC7we4Ne4XIyq44s+yLI?=
 =?us-ascii?Q?w4mHkNzbxiIHP0Pc7LysaLRGu6bDCmYdtHb3DCkSSHNAsTJJWy674KN7hQXj?=
 =?us-ascii?Q?7jqK0kfLOtZYvsqe3HGeOyNCIX8/9Ed0P72k/3tKP45Q2mpVjF7uEpfGRa7A?=
 =?us-ascii?Q?OofYb3h4EvR7Erql6WCVgixFuw0mD3EBigILM5cTYBNG9ec7sDAjvkJWuvza?=
 =?us-ascii?Q?siScDA5oU29vgnImAjLX1dBVPsJjdHNs4QlWDsIDduZjA9sLgt+OYCzIw8cx?=
 =?us-ascii?Q?k7Jz5rP2bVz9mkJMz7x7pZKQurjqhYH6icwec5iUecXX5FS/vxDvmz30qSYy?=
 =?us-ascii?Q?peEWTionMmR6+0uXVr83jAQjNdRYAcxqqQgzbt2lJavnl3T5H9a7/eErfgpp?=
 =?us-ascii?Q?YKcVnOvCOgcVvl1jp52QCJy/b3COK3hNt+XGIXejqy3jF4azoucWJsL9/M4/?=
 =?us-ascii?Q?WAYmGi5cEl/b6jm9p0GrIAyue9UhFKxVq88+Et9OYFydiaTxqqYrHarNhcGc?=
 =?us-ascii?Q?UNo649nOadfOBCPhSWN5xTMFOQbyu923rRPEsYPSwiXXE4i/CdkJsQnrSJ7s?=
 =?us-ascii?Q?bX5OxhtJsOFHDhIKLvljZwCoRLRRk6mgpb9LOzHxXYFMcPjs2FXm56aZXBnM?=
 =?us-ascii?Q?1cMpIN3i0oI5BCxrNaSM6yFMv9AqBY50dsnbz9UO?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0BEEE6E71A15F449B39A5A2AF84B6F74@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB4552.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9c15bc-651b-4f73-0768-08da60ca5927
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2022 10:12:22.1268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdp7/B8hTBq9FchY0v7PzPCx9QAT6ztgCcKfS5j5+fxQUVaqysFzN2tgGcfDF5pa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2501
X-Proofpoint-GUID: dfGwPNSXUFXQGG0wBPbnBPYjVR2Cuyo6
X-Proofpoint-ORIG-GUID: dfGwPNSXUFXQGG0wBPbnBPYjVR2Cuyo6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-08_08,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to allow a CPIO archive to be parsed without actually
extracting anything add a parse_only flag.

Signed-off-by: Jonathan McDowell <noodles@fb.com>
---
 include/linux/cpio.h |  2 ++
 lib/cpio.c           | 35 ++++++++++++++++++++++++++++-------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/linux/cpio.h b/include/linux/cpio.h
index b05140a565cb..86a43270d186 100644
--- a/include/linux/cpio.h
+++ b/include/linux/cpio.h
@@ -77,6 +77,8 @@ struct cpio_context {
 	struct cpio_link_hash *link_hash[CPIO_LINK_HASH_SIZE];
 
 	struct list_head dir_list;
+
+	bool parse_only;
 };
 
 int __cpio cpio_start(struct cpio_context *ctx);
diff --git a/lib/cpio.c b/lib/cpio.c
index 16629ad1e339..36357806eb70 100644
--- a/lib/cpio.c
+++ b/lib/cpio.c
@@ -15,7 +15,12 @@ static ssize_t __cpio xwrite(struct cpio_context *ctx, struct file *file,
 
 	/* sys_write only can write MAX_RW_COUNT aka 2G-4K bytes at most */
 	while (count) {
-		ssize_t rv = kernel_write(file, p, count, pos);
+		ssize_t rv;
+
+		if (ctx->parse_only)
+			rv = count;
+		else
+			rv = kernel_write(file, p, count, pos);
 
 		if (rv < 0) {
 			if (rv == -EINTR || rv == -EAGAIN)
@@ -136,7 +141,8 @@ static void __cpio dir_utime(struct cpio_context *ctx)
 
 	list_for_each_entry_safe(de, tmp, &ctx->dir_list, list) {
 		list_del(&de->list);
-		do_utime(de->name, de->mtime);
+		if (!ctx->parse_only)
+			do_utime(de->name, de->mtime);
 		kfree(de);
 	}
 }
@@ -374,6 +380,13 @@ static int __cpio do_name(struct cpio_context *ctx)
 		free_hash(ctx);
 		return 0;
 	}
+
+	if (ctx->parse_only) {
+		if (S_ISREG(ctx->mode))
+			ctx->state = CPIO_COPYFILE;
+		return 0;
+	}
+
 	clean_path(ctx->collected, ctx->mode);
 	if (S_ISREG(ctx->mode)) {
 		int ml = maybe_link(ctx);
@@ -452,8 +465,10 @@ static int __cpio do_copy(struct cpio_context *ctx)
 		if (ret != ctx->body_len)
 			return (ret < 0) ? ret : -EIO;
 
-		do_utime_path(&ctx->wfile->f_path, ctx->mtime);
-		fput(ctx->wfile);
+		if (!ctx->parse_only) {
+			do_utime_path(&ctx->wfile->f_path, ctx->mtime);
+			fput(ctx->wfile);
+		}
 		if (ctx->csum_present && ctx->io_csum != ctx->hdr_csum)
 			return -EBADMSG;
 
@@ -478,6 +493,12 @@ static int __cpio do_symlink(struct cpio_context *ctx)
 	struct path path;
 	int error;
 
+	ctx->state = CPIO_SKIPIT;
+	ctx->next_state = CPIO_RESET;
+
+	if (ctx->parse_only)
+		return 0;
+
 	ctx->collected[N_ALIGN(ctx->name_len) + ctx->body_len] = '\0';
 	clean_path(ctx->collected, 0);
 
@@ -496,8 +517,7 @@ static int __cpio do_symlink(struct cpio_context *ctx)
 
 	cpio_chown(ctx->collected, ctx->uid, ctx->gid, AT_SYMLINK_NOFOLLOW);
 	do_utime(ctx->collected, ctx->mtime);
-	ctx->state = CPIO_SKIPIT;
-	ctx->next_state = CPIO_RESET;
+
 	return 0;
 }
 
@@ -579,7 +599,8 @@ int __cpio cpio_start(struct cpio_context *ctx)
 
 void __cpio cpio_finish(struct cpio_context *ctx)
 {
-	dir_utime(ctx);
+	if (!ctx->parse_only)
+		dir_utime(ctx);
 	kfree(ctx->name_buf);
 	kfree(ctx->symlink_buf);
 	kfree(ctx->header_buf);
-- 
2.36.1
