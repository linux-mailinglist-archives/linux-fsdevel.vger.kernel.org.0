Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B7B4A0137
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 20:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347171AbiA1T51 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 14:57:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:38260 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349587AbiA1T5X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:57:23 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SIb47p012417;
        Fri, 28 Jan 2022 19:57:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ZsIfTF/b91ntftzOxBIZ1/5nmSx2ypOkzdVEvGRMorA=;
 b=RhdEMa7UM8O7VhaboLQC42tk2r0OAz7gkRaMZjt53K4BEA9UFiJ0zow3s8TLzTi9NsHr
 bV998cBj9MqjAgzVRve2+ClueLC0JIK38FtpwyPBxNhbbQWouHy9lhMAIZcF8Go81j3B
 I26Endmr4W5/5tOcEUM1GesJsGqKOY3IMkPrRUMxgiSK+Su6DUI8/BLLZEjqUwleWeDF
 akfz7z0/z1obiK47MTYClR80u4n5eQLJdxJAAUdiuEK0Uu073+oVNaptYmTddP5/jGk+
 9h2W+MIQAwQc/n4d5/W/YkHMA9sNvmLkNiioXqe8QXE5T77bWXF6+nyR3JOwdSupkcKy cQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duwub474w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 19:57:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SJv9hg091643;
        Fri, 28 Jan 2022 19:57:19 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by userp3030.oracle.com with ESMTP id 3dr726frq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 19:57:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4x2KXBfl1RALM9M0JTseCG29NjmyREVelktHCq5oAJgf2kKbu/GicuKpOlltdnrOzf4e8eKmhXFoyfdJAaEmMB9wkznYFj//HS48UrsMaOLvG/yeFKcw9FshJ/buk/zeX0+Ciwtnd4KdojiRgxqEs1KI/qCfVOdFOhuQ5uDONCTeSWy/H44k0Yd1KIJpuKZxesn8fXZoi1fu1jvdN0km3eNynUlic1xWqgQ9eOn7HuDTnLC7sznBZ4fHa3QKBbdZe4WOQTLObqIpQCq9SJfStQs8Ch61yPyTodDt964xunrdr2rVU4hSjOAjbVOTALlZUXwPMn5stybLZUqr1jpwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsIfTF/b91ntftzOxBIZ1/5nmSx2ypOkzdVEvGRMorA=;
 b=JlXHJgM1KXJ6CjA5HE+FUGO9EBn8qXnB7Ac73qs15fAiMZI7czuI6KRRP/MkbUAx7uXrngOxm6VX492SOHbBCu18D+thpq7Qpkg9DBtefhH/ZULwKduhPENA6e2jwiEDKqSrkcisZwWSHt20bRPH5oeictelDesT4HCiIhyaU8OgNWYHLDReWYJYAUQxRTOxT4KsszTt9nSsPDwSzl9RG0YIbvXWSuFoOky5rPvJc2/L1lYckTUUDlWwnZ7IUd+ZDNkmJ1l7fcxfTYUb5VBRV+B3afgJVN+EI4BNf7h/7Zbsoyoi+8mxN1PirZIXrMOLhNfNCOBiD2EExIk1IzGoDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsIfTF/b91ntftzOxBIZ1/5nmSx2ypOkzdVEvGRMorA=;
 b=EFg61a+SLmyDKa7PQvd86xYkWqZ/ocVCDvDNe/L/rSC4CU+kEPeG/+GJ3dQI04kDLPD0qP0DxlPGgpJ1vzC44Ii2vuqJNVv55TmKTUtH9RCpChDqv22UscFV/HFO1YzZTbXCTobIGX0xvE7opyd1t54AvPxkb+5qlmXkhtC4CKo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CY4PR1001MB2390.namprd10.prod.outlook.com
 (2603:10b6:910:41::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Fri, 28 Jan
 2022 19:57:17 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 19:57:16 +0000
Date:   Fri, 28 Jan 2022 22:57:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] fanotify: Fix stale file descriptor in copy_event_to_user()
Message-ID: <20220128195656.GA26981@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0028.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4efdf6a4-789a-4f1c-6851-08d9e298624b
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2390:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB239070A7FED653CCA3A973A18E229@CY4PR1001MB2390.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nw/fhOTu1ZSdDTb+nWA2/wbpJsYYpTt9kYMWEY8VCvx2mDtJtuZxxz2mfIbTFJaBqzCEdGnXCiTyWDaAxCQi08B2Ei3Jgk0/gVDsHnkwo6+J4OR0f/OFxqu/t4/5lkUOhaVhOBklZmaueHLsirpXSMHnp+jX+EdzQD4WHaRpxp40gXMEgm6xF1gD2Usgc9HOzTIA1a+t2t3k33dChaRWoPVPRETE8tBW9d+EP1VdBt92EnV8F1hpgvwsRUc4oQe0G9UAEKjab0m4Np+GQ91OLe/a+XUFfykSaMhDQrFydIW4ouvvT7WhZmkskkYlTxUvfpaqTzET/Yc6uMqiObO1hABsk1Kw9y2mlBnf90LeIFxleNun6nmoyREIU6er/4LQ7SPOYaGrlzepP1LmMXD1uOU3O9O43V6BtIH7c0b+dKbfQhSd5HAqcEQ14Bj1VXwrXZMIIBM8FUADENzEYI0E1HI/97WPR9uiE159tgY9jn5Ja34g9aX1qL4emw48cQLvZ0fvdnbeDQF979szlF7kxvlj8YUwcXYQzqBMTwDRovsY3Hhl+FEfg6JwlRCXEDffXchiD5sReXTodPwk3RsgFeh9ngbMB/noD86FrOciMDCxQTJba+orY5Iusu3MShJ9zQZ+vUzsvNI8iEBKZHYJOV31pYS5GmQHdV3jFyi7jllyl2Oy6omCmU9WhBy1D5UeVxyaQ/jdIlGnwjZLaTDtpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(26005)(4326008)(66476007)(33656002)(66556008)(316002)(2906002)(508600001)(83380400001)(1076003)(8936002)(33716001)(186003)(5660300002)(44832011)(38350700002)(52116002)(66946007)(110136005)(38100700002)(6486002)(8676002)(9686003)(6512007)(6506007)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jsO4Q+2OFCqEWJvs/flsYOPRJXobCfvSwcVicd3EojLrJGBbzY4l8J0PTvy+?=
 =?us-ascii?Q?yDSmWo6rHTp7S4nERQIK0gbMFXm1ykWZ5XRBOOoUoCLx/CdDvl/090R1LdIX?=
 =?us-ascii?Q?UKweokUbDuvYH+irOju4qVJiuWnwZ252DKO8A5ex7m0srdHjOMiiDxuNJcLK?=
 =?us-ascii?Q?fYd34Euvd/1mlqPZJgJyCPTvp8ZGqeWWgKxp2GcB7rrcCkSNGbOsjv+X9i4b?=
 =?us-ascii?Q?GpVyfGwwyynNEjxao6PPu3Q7RxK3RjczxS+i2CPIM4xAcwZ0fQd9VZK3P8h2?=
 =?us-ascii?Q?vWdXNRjgYfEupUuXQGdb/gEm0dgk7/IO1AK1FxTW9awUvtWQt76dwQJeAPJG?=
 =?us-ascii?Q?FpSPUCxfp77mcb083dgFN6VM1PUq7X9Oi9UF+WDD2ILizmjLiPbLAuQcTeKy?=
 =?us-ascii?Q?SvUjMoO0SNNFk807QsxVwzuD9WIqKm1qL8euyjGZb058u8nBEoaVzB/l+wtB?=
 =?us-ascii?Q?2CVkF3coAEq8/QJH94mePw7g9qlgat+hg8+/Uoe2bowfui6WCeeTS+On2uJ+?=
 =?us-ascii?Q?m1d6Kio8Sp7fUAgvGDKE9EMJNnhF9JUF/WQd/gSt8PInGhawtpsq9ewbeT/5?=
 =?us-ascii?Q?mcX4NhVqgk864ciTiu0xsyGXwQfUcgKP1J++1G8oa6bDUA3V9lUkAJLXPPin?=
 =?us-ascii?Q?3nZjCDP9wUinGHlas+obkv+ZOXwJaeXQz7mCloJcB6Ht3B4SGTAvAtNt2B3q?=
 =?us-ascii?Q?FzBjbOpzN1Wp4J3H8qt6pcZWqsuRW63m3lAZ7JOF6KFBjSyAVg9BRZtA8ltm?=
 =?us-ascii?Q?2KuHx2vHZta9WUzTGv/KWuBzl0usSVm/Fyml+QGD+d6sxjzINSu3zHCOIraY?=
 =?us-ascii?Q?klb7n0h8zYkAoo1swlyGaITad2oAWnhA2DmpGt9dViKTwj1LOmwZZVmCxjEZ?=
 =?us-ascii?Q?waEEQRw5B9kuLWeGZe/iBkdrY6dfjQBCUKeneeToeSlJgb+qF65BGN1AAk7n?=
 =?us-ascii?Q?sEnRY21WwW4y4G1mt4clbQ++xgRxzKBUHnpWVQhkIw2Kc91CClyaw7sDXxw2?=
 =?us-ascii?Q?0e/5v7qU5WCOedOm7V0e595XL8dG1c9OsdBxnRgKDr5zsRVKjrPPv/ePYnK4?=
 =?us-ascii?Q?1bxfVsJZjyyi5CBZkShytTCMi1y2sfMUElO07Ju3f5egaw4Ty4Lb4eCY4nA6?=
 =?us-ascii?Q?cRXZ/lGOy+g3HKcw0quZeO5C+FG0u2wD6vXz0BgR8V0uyQy2I4emwDI2ug6T?=
 =?us-ascii?Q?YZFZUaso7gWKHWSdyYumJKk6gcFyvvnVZHf6VtYb0ikovEkX0r87YGGcrRMr?=
 =?us-ascii?Q?lOOXip70sM4bf6RvtZFdrBdF0xftYHMgLUKSOH/TCXkqHwnilKXp8zw95ktA?=
 =?us-ascii?Q?sa9rebQ2yuvKf8XFlYA1SSuUEz/tthPRsbVaKohm+hzyPQKgYnB/anOuzo+p?=
 =?us-ascii?Q?4iDidUAxYU1LdFjGk5RQaKmEghc//3Udq+4ms/Zo+2GKCDbMp6PCNQuI7yQK?=
 =?us-ascii?Q?nizD1qqj/icL7tjWSj11+q3Y6cDWF0z557XGDz4fBL/LTrAGKrwrJ7xnNgdR?=
 =?us-ascii?Q?cft9LWl1EDgNd9xO8dzC2fOWRJGT77C4A8v4kZet2NFwm7uW7wm+0gSIsfGJ?=
 =?us-ascii?Q?aR0BSPhqCwJown1BSHINcDjfVo6ol5aqAGUhwmpodUpDkPX08xuYnCIDvbW8?=
 =?us-ascii?Q?L3pKXFsy1Vw6RtxNRHV7jK4mMuuQis4zITE2YlGLzjPyOwSkQ1d/UbnpFjmQ?=
 =?us-ascii?Q?yFlxMb+V0pDI9dCVaD8EPHkJ4sA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4efdf6a4-789a-4f1c-6851-08d9e298624b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 19:57:16.4932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hRX2unxrA/Sb5IKXgCLGHDhRwdsGYDvy7BdDXWQ9Wo1BRAnour6tokrRBlPH8qggYL3GDGb1hNyFJY1UhQfDFyuvG9dp6rNFW2//lBV7Id4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2390
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10241 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280116
X-Proofpoint-GUID: YhrKtQ9BO8X64Luvg0vt3AZ2Droj-luB
X-Proofpoint-ORIG-GUID: YhrKtQ9BO8X64Luvg0vt3AZ2Droj-luB
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This code calls fd_install() which gives the userspace access to the fd.
Then if copy_info_records_to_user() fails it calls put_unused_fd(fd) but
that will not release it and leads to a stale entry in the file
descriptor table.

Generally you can't trust the fd after a call to fd_install().  The fix
is to delay the fd_install() until everything else has succeeded.

Fortunately it requires CAP_SYS_ADMIN to reach this code so the security
impact is less.

Fixes: f644bc449b37 ("fanotify: fix copy_event_to_user() fid error clean up")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Mathias Krause <minipli@grsecurity.net>
---
 fs/notify/fanotify/fanotify_user.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 1026f67b1d1e..2ff6bd85ba8f 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -701,9 +701,6 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 	if (fanotify_is_perm_event(event->mask))
 		FANOTIFY_PERM(event)->fd = fd;
 
-	if (f)
-		fd_install(fd, f);
-
 	if (info_mode) {
 		ret = copy_info_records_to_user(event, info, info_mode, pidfd,
 						buf, count);
@@ -711,6 +708,9 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
 			goto out_close_fd;
 	}
 
+	if (f)
+		fd_install(fd, f);
+
 	return metadata.event_len;
 
 out_close_fd:
-- 
2.20.1

