Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E03453126
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 12:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbhKPLtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 06:49:02 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28392 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235642AbhKPLsg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:48:36 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AGBDWT8013942;
        Tue, 16 Nov 2021 11:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=zZF9fTjTw8q83qYLGyPxTGDkhfdBS8QEQZRfURmUfMQ=;
 b=Y7VJeuq/SXD6cEH3DKUkvMXhY4T8tj3uuYlBx/2jgh+jYrdtB/TnigyJ3++tiHwjVhCQ
 P8F3yxcjrXFQFbdIrAzTitSCExUw4o6dIA8nUmgc03taNSiIJqM/TSGr4uKJt13JSC9Z
 6ivqUeAziaTdJyFL9QKxSXbAJCzTCDBne9ZouNQ5rKAdtgnQZbC7VoSmSLKnC482ifxw
 dqJX2yUJfwtx9mDOi2TMQCDKfraBMBb9Z0BUdq4wXtO21RxtFG3rptme+24bkBztceXp
 5yB4o1Uq4bm/FYRSr475HHOOl4RI7g3Yd1Lp/HPb3QMx32d2tsOH+HHf9vOb0moop8+V 0w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhv58xwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 11:45:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AGBaPpx057955;
        Tue, 16 Nov 2021 11:45:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3030.oracle.com with ESMTP id 3ca3dfudwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 11:45:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeWLu76spVsZJ6pgc09i7HnaX/7TC4c44MTGpFbSzornq5VjtP8Vdu9lvv+OwBxBUutpd3CpNjjAXYiFi845eZnbukxhsXj4NiLago19o1wr1gxDw/Q58W9AMEy1QAl6PNSkpSe8ARSs0e4MTgicPvfBTH0BJYHow/KRr7ZSA2q6bRFl5ovl4lH+gN/qaIACr9Ix3L9/XcFSSVkeh5TR4Fp/HvKtfgH/B31H4fJh0ZdysOW6nltr0NiMHfFMRCOqkqugf0F+o0YYl9MIH5do7iAAtCfb5CgZdSp78b6EJKcnW+M4dDEs8PSjJqGUO+W4tmULFYOFi4Mntk1JFGcBQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZF9fTjTw8q83qYLGyPxTGDkhfdBS8QEQZRfURmUfMQ=;
 b=N1541nW1mq2Jujrat9lUC/izXO1Sd9p5tZl9tOdprFA1p5cVwVPwqjWcijrXPPzGS9GmWPOJKdvvt0szdjvLIU9YvsiP3RY1rfxZ9b+XsMNdKfYAVbs1RP/tf2gzQFCXGJceXR8ZEkOWMAR+uY6WDimM1Z6KdhBPwDrKxtlKv5H/eyWOy/IB7awu0w+zsEKXSKLDIm6tq+ecEAzD5YgMAqkT5Nd895yQblzEKd3dydlVO53zqzo1pJibshSRKeGMn3fBQulzbamoAxlZ3wxNpx7Y3y0jdGngKVy5C3qitOmZOS/NhagPrYXRai3+KedGvWKIoMWo8BkrFILjOjbhHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZF9fTjTw8q83qYLGyPxTGDkhfdBS8QEQZRfURmUfMQ=;
 b=ziABCNuBJ0vQJgI4q2zkuoQlfDG+y3R+NTyAE6E9EPlNxhlQonwN8PIJnnr8zP9R32sw3r+4e0n/YqhtcJpMTfqoaMXViSCiZZpO7pZM+I8Fc1gUOGFvScIv2XY/rHN14UGlmIVXAS2gGUsYV0Ke+qg54c76d6EvbKT1EYFtFHc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4436.namprd10.prod.outlook.com
 (2603:10b6:303:91::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 16 Nov
 2021 11:45:34 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Tue, 16 Nov 2021
 11:45:34 +0000
Date:   Tue, 16 Nov 2021 14:45:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     amir73il@gmail.com
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] fanotify: record name info for FAN_DIR_MODIFY event
Message-ID: <20211116114516.GA11780@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: AM6PR04CA0012.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::25) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by AM6PR04CA0012.eurprd04.prod.outlook.com (2603:10a6:20b:92::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 16 Nov 2021 11:45:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fb9224f-a36d-4754-d4a0-08d9a8f69982
X-MS-TrafficTypeDiagnostic: CO1PR10MB4436:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4436A87F57EA3699FB8C93B98E999@CO1PR10MB4436.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xvYC5p10i/e5RAW3HotjRWBAapPsFmq3UFTV1AzfY4knzng9Xtw0/fsxUyYW+KNDowqAnZ/sx7DMRh3XvFKyy1YNK5nUz8do0VlqdA+g2tLrwr9Zzxogl9riqxrZk8TjwR1jChWxH0w1omG8anFjj0pys3sUzdEwyDiJqaWo3D6kQHWAbe2litTBQYKCumdcrO0ratnO8M+EmSZQOYHDSsXwmyD3WwyippV1InwhqtU1pYwCYeKMOm9En4ELBcG8XpY9s2/CXErp8/FcHsi/DqyyXjSJ85h5DCW1vCcuf/2ng9r2POWd5WqksCtKsWpQT7XQOvTHG7yxstglPhhRIXjGUcRspohC/QO55W4nKgQ5zHC4D6bTdvPqoNWxDFgmt6mN2t8P0czuSW59Q6dSUWq1AccHh8ioW+4xK4BT48ArxYtEYomDEbuqx7z29gy6rnTSsYfQyIzhp7fkvryn46ZP8Hfm6hsqolc+9kGAGhxiOxbBx3G4j3m5Jhy9Z/dKfexZt8cGfUGllH8mtMLrzVsRLR46kiKxl6amgAo0SEY/HuMxQL1+bVDvzE/Oq6R3dIcBqSOXQqixjyzeel26/bSBQFFE8Kaqa/9FC76F5IwgJ+vw21bfnK7WUVxrPnu++hgH2EeX8eHf2FL/o2qnOcPXHxi0eO8ZzjHiIgG2I4B85gVVfnn/2u6u8rm1i81HoHM4HpHlIyme9ftwmTV7Xg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(83380400001)(26005)(9576002)(1076003)(33656002)(956004)(33716001)(9686003)(6666004)(55016002)(8936002)(316002)(8676002)(44832011)(6496006)(66476007)(38100700002)(66946007)(38350700002)(6916009)(4326008)(66556008)(186003)(508600001)(52116002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hA2vpDwJOiUs7FPDQwNfp8ZmM4j86Pfn9YL/RYRe5QGotuJhw7EOVRMDCpq5?=
 =?us-ascii?Q?MTlVHkKgHjzcr58y+99Ayt4dS6fbB6TaIJdGf/D4UkSJXOnvSF8iMauUhi83?=
 =?us-ascii?Q?z1fxokkPDbAOLVJofOzziBk21wsJHidZURwhMIu20WhROvxJNGRmTDbO6P34?=
 =?us-ascii?Q?mzgf7GWzLSHHYO3cjrjzZjUenEJjOoruNHu+MyZo+tCKbDGuj0Hs2qWYG3o9?=
 =?us-ascii?Q?MJW855BDMmOjsOkg4CRzlgkBf7jitTDF/Uo2Slp5tHHU1+fCmnwb96rSXcCv?=
 =?us-ascii?Q?TyLQBE6FeLe4nDXpwAcsNoojes+V2pJhnX/Mmo/sqXlyFgGytc7xgkXUsOP0?=
 =?us-ascii?Q?JzYUGoU/Nct979oCsNtvQHv8AxLFsyCg+5sw5s6nCjUbehEwBXH6AaXyXfoi?=
 =?us-ascii?Q?m2xIIhS5sVvIkHVqVpo3lfV4N41eoOTWIU9XujfH8QsMsbjN13YBWEFkW5jA?=
 =?us-ascii?Q?m5t8lQ598+RkPz57xQNLntYXZJEyMy9IwS2lMD2BDebcXgHzV3P12suTqYKU?=
 =?us-ascii?Q?y7mqfrBCNV2CkqRmhGyzKvlKCAVSS/Kv00wQv4HfcF04j9Zf/Q6r3Spvudg8?=
 =?us-ascii?Q?B1TtOfsHVElQljw4S8G2ksrRgchG1AN89m4otw8KvIoapfVTAJ/U7P+/8ith?=
 =?us-ascii?Q?2gQUtUfYA0VhWDNV+j/jNHSCQ+BTBKu7s7bVwZGW3abcDly7nDUnOpog3Dzw?=
 =?us-ascii?Q?aqFec6307MzHxz/+JKEuWA90qrMp/LQAuWIXqf7/ypzrdvU2mzIg2aK0jgX0?=
 =?us-ascii?Q?kcMr4+/wHG0KCaCJinGsCF4Mpfx9zkoxmb646zKqvIpT5Osx9Xluk62TP9LK?=
 =?us-ascii?Q?axLBt7LIT/6qAHGstyEPXlMxDi6bsHfqkGhZ5xsl3aW9ySMLeRoEKSyb029w?=
 =?us-ascii?Q?g1Yxtv0XR0bNYmoVJ6gkvPCYarjuuQpEOrzDKaiTQUcBGQWcXf+Ndbyjrt0r?=
 =?us-ascii?Q?z21zQmxZIttD4e4Ns+f3t+xjQgWTJHZnfOuTss7W1Ixi7M9TiqIKd405iMup?=
 =?us-ascii?Q?z2B/2KYlP/0lNCBCWQgIovz8j3zK0q417v/mPnotU4g5p19OdTl4ozqzXKdy?=
 =?us-ascii?Q?1zGSrlBESXQf7HhV7qHF/qHVJtLu6hzrdxBPm+XT9hzizIkOtv7Oxl+XTtd3?=
 =?us-ascii?Q?IXnoiqNz5a67xOfx3+SNDDtu2bheOMSp6rLz78H7UpgMjFEXCRtezqAHG+ch?=
 =?us-ascii?Q?3ZnHp35X/6nZ1E5XZ+f8lQ7S4sdK1fssI47nY0TJ+eSUQskPaxo5TGWqkd71?=
 =?us-ascii?Q?ns96Cz5Iv8xUD1QmEUdkuYMjrFcI0l2AGb63LnVDWi/Fhg4+yVWdDwB+aDiE?=
 =?us-ascii?Q?K+T/VQmH9A8WGV1FcELAmosddXf8Di23fs/0aSW4Re6rIKEZwG6kS6IBwjbp?=
 =?us-ascii?Q?O61MW7DSl0sHAzazYlIZNQq+ThOF/u0eFLyxzImJf23n49ceo2m2YCteB6yR?=
 =?us-ascii?Q?ULzEM61T2qxjOf1Ffkae+N6HY0w5b3nG/Np1ZnbCdjjVcKqiraadNK+ywnXC?=
 =?us-ascii?Q?8C8d5ofns6LABKzgSXwHDtnPLJEc4RZlJ4KLaDJpwnpDtUJYeJJS6JpBKN3S?=
 =?us-ascii?Q?c+UqcfCiatNs3G/nLMNz5zsCavmLN3lFiBMymnE1aGv7FYC7vqOWtUtBXfNO?=
 =?us-ascii?Q?EH0RAHWMmJI7CuqGCHc9YTb9l2xzQ0nSziuNLB/NJySVyuU22Kk0xdGWP3VH?=
 =?us-ascii?Q?PgZgA+diM4/70PYoutbxIit7erw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb9224f-a36d-4754-d4a0-08d9a8f69982
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 11:45:34.1774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLIl0AmoAbRROEN79unc0UJlys6p64YABkNUz5VCGfTX+ym2MPvslqNTFRSmog4aQIdXYDbrg7BP+ajdQ8siXsW4O8x3TKOGju2C7+jEroI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4436
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111160059
X-Proofpoint-ORIG-GUID: cWH-eoKhtwlru41NR1-_pz1ZAhuRxgU4
X-Proofpoint-GUID: cWH-eoKhtwlru41NR1-_pz1ZAhuRxgU4
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Amir Goldstein,

The patch cacfb956d46e: "fanotify: record name info for
FAN_DIR_MODIFY event" from Mar 19, 2020, leads to the following
Smatch static checker warning:

	fs/notify/fanotify/fanotify_user.c:401 copy_fid_info_to_user()
	error: we previously assumed 'fh' could be null (see line 362)

fs/notify/fanotify/fanotify_user.c
    354 static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
    355                                  int info_type, const char *name,
    356                                  size_t name_len,
    357                                  char __user *buf, size_t count)
    358 {
    359         struct fanotify_event_info_fid info = { };
    360         struct file_handle handle = { };
    361         unsigned char bounce[FANOTIFY_INLINE_FH_LEN], *fh_buf;
    362         size_t fh_len = fh ? fh->len : 0;
                                ^^^^^^^^^^^^^
The patch adds a check for in "fh" is NULL

    363         size_t info_len = fanotify_fid_info_len(fh_len, name_len);
    364         size_t len = info_len;
    365 
    366         pr_debug("%s: fh_len=%zu name_len=%zu, info_len=%zu, count=%zu\n",
    367                  __func__, fh_len, name_len, info_len, count);
    368 
    369         if (WARN_ON_ONCE(len < sizeof(info) || len > count))
    370                 return -EFAULT;
    371 
    372         /*
    373          * Copy event info fid header followed by variable sized file handle
    374          * and optionally followed by variable sized filename.
    375          */
    376         switch (info_type) {
    377         case FAN_EVENT_INFO_TYPE_FID:
    378         case FAN_EVENT_INFO_TYPE_DFID:
    379                 if (WARN_ON_ONCE(name_len))
    380                         return -EFAULT;
    381                 break;
    382         case FAN_EVENT_INFO_TYPE_DFID_NAME:
    383                 if (WARN_ON_ONCE(!name || !name_len))
    384                         return -EFAULT;
    385                 break;
    386         default:
    387                 return -EFAULT;
    388         }
    389 
    390         info.hdr.info_type = info_type;
    391         info.hdr.len = len;
    392         info.fsid = *fsid;
    393         if (copy_to_user(buf, &info, sizeof(info)))
    394                 return -EFAULT;
    395 
    396         buf += sizeof(info);
    397         len -= sizeof(info);
    398         if (WARN_ON_ONCE(len < sizeof(handle)))
    399                 return -EFAULT;
    400 
--> 401         handle.handle_type = fh->type;
                                     ^^^^^^^^
But this code dereferences "fh" without checking.

    402         handle.handle_bytes = fh_len;
    403 
    404         /* Mangle handle_type for bad file_handle */
    405         if (!fh_len)
    406                 handle.handle_type = FILEID_INVALID;
    407 
    408         if (copy_to_user(buf, &handle, sizeof(handle)))
    409                 return -EFAULT;
    410 
    411         buf += sizeof(handle);
    412         len -= sizeof(handle);
    413         if (WARN_ON_ONCE(len < fh_len))
    414                 return -EFAULT;
    415 
    416         /*
    417          * For an inline fh and inline file name, copy through stack to exclude
    418          * the copy from usercopy hardening protections.
    419          */
    420         fh_buf = fanotify_fh_buf(fh);
    421         if (fh_len <= FANOTIFY_INLINE_FH_LEN) {
    422                 memcpy(bounce, fh_buf, fh_len);
    423                 fh_buf = bounce;
    424         }
    425         if (copy_to_user(buf, fh_buf, fh_len))
    426                 return -EFAULT;
    427 
    428         buf += fh_len;
    429         len -= fh_len;
    430 
    431         if (name_len) {
    432                 /* Copy the filename with terminating null */
    433                 name_len++;
    434                 if (WARN_ON_ONCE(len < name_len))
    435                         return -EFAULT;
    436 
    437                 if (copy_to_user(buf, name, name_len))
    438                         return -EFAULT;
    439 
    440                 buf += name_len;
    441                 len -= name_len;
    442         }
    443 
    444         /* Pad with 0's */
    445         WARN_ON_ONCE(len < 0 || len >= FANOTIFY_EVENT_ALIGN);
    446         if (len > 0 && clear_user(buf, len))
    447                 return -EFAULT;
    448 
    449         return info_len;
    450 }

regards,
dan carpenter
