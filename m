Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7801548B656
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350327AbiAKTA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:00:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19564 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350329AbiAKTAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:00:21 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BI1guE032058;
        Tue, 11 Jan 2022 19:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=HACBNB6Dlbd22EoArX9+ZdfgySBwzu2+nWVxtO7kBp8=;
 b=EKr4XzmmKjLRdu4dip9Aij4ElPABFiCGNgjdfuc2gGjgRmnUp6FB822FlUTbmUdBT0ZN
 FAr2xhi+UbcFiFy6QSCRwJvgD5Ao9H6Ee85VlvvetQUH6VpuIYVsJfNirK6zmbJP4A7A
 5/l6H9QEWsmsY89S9cIWl8RaThj50cSosdP2WWHhmHurY/GACV1kPOhv9HSmy19oDqi9
 kyAqa/fTXF2hO/fcLpXEVl5MPRrx/wAtS8x9T3aW+k5Wtx2Ws3ivd9pXqxmvS/xqTW6u
 vb6pTSAbwacnGUoBi+nd+9zkVy6FZRr9HXjh6oU8fLpcl6NrPUlm6FPZj28e46CN8Tsp wA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgkhx43bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 19:00:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BIpcbv110950;
        Tue, 11 Jan 2022 19:00:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3020.oracle.com with ESMTP id 3df42n7d9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 19:00:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmN3t3G4XD8a5QMRS9JBHJ8mj1COlRdo5OofCnkaUORmVGE8Ke21Mkrt+Tx0cP1UAE5GUAH2b9jpZsWDF5uY7HOoymLsEX4lMjZSG5GnxZ3NLJCJGE/yEnpGjDfnyIdXPEPEbTIojwe3OIMmoXUIwo3qnuNaWdzJMEEuQ4jTCGDmfus53rtmGbzsANRIhEpfrd1xwiG8KeA/WPY8n8ebesfOmlEujOdammSt+kCtIU8vSa+wuMQgv7h+vgm4F7ndrz58mvLk7ubS9Sza7KbKNc6owmeurrX+SvcO2X4DCttvVMC09oeq61dF8LtllXO08Q+8r4uD2MQ+Ld8R6ki5Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HACBNB6Dlbd22EoArX9+ZdfgySBwzu2+nWVxtO7kBp8=;
 b=G55PzDOnkQr75B0h5lRnQqGmvjRxpcAcMyN6wiHi1RaK4HKuxcPUvTgmLOh92S4/YJNaJmnGqUuFzAiC2yccKRvzBtOCC/vnv75mzYw54kHTrTO/Ne+jBFM1p7RAmOCtFLe5670pAJMUxvbIYKc9edHKutb7ky59OhEY9rZtgoK99off2PPUsJFtvvKWPcqHctXV0D2Xwd3ZRalULN1FNejZbenXvgi2hy09MfsDJyBAlhkO/mvi0YJaJJnzPwM+sJzzeUVcw5XaCkm4G/b8FlJ58xKcZpHfApL/rmuC9KM2mvzG0dCaVb83Z5cQkaZ4YWdqo+zLV5CNdlDsgu2Tvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HACBNB6Dlbd22EoArX9+ZdfgySBwzu2+nWVxtO7kBp8=;
 b=HlIjPi1LMMbwLSi/tBS8Qjy/2NQSAIHRODN5ZlrRhT/8EFyQFhx3+j4YFDqMV5XzXb/HzatfkOZdIrQuDAAl5kVIL5iZ0pPltSEK4DonxEGYTChrV2HIA7QibQeLZLKvGgTvjDURp6PDrBc5On/dqE5F13V/8z0+KwQLaYUXnOA=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB5647.namprd10.prod.outlook.com (2603:10b6:a03:3d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 18:59:57 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::6814:f6c:b361:7071]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::6814:f6c:b361:7071%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 18:59:55 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v3 3/7] dm: make dm aware of target's DAXDEV_RECOVERY capability
Date:   Tue, 11 Jan 2022 11:59:26 -0700
Message-Id: <20220111185930.2601421-4-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220111185930.2601421-1-jane.chu@oracle.com>
References: <20220111185930.2601421-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:217::10) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76ec3292-9b57-435b-fb2d-08d9d5348e02
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5647:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB56473B846789ABB7E9F30D30F3519@SJ0PR10MB5647.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nehgXv/AgvweR3kemRCqUP3R5JRhncYKtXgcW+cScD3gOwFBeGM6nJb37lT9mRGVUwILLoje3lApomZk+8UAlVgm91MteX2JYTozLnbw5y9+cyKl5l8WuZP7l+bizJSVgtTwrT0hZrem1IOWFqguwdevYtuVxmv6CVuP4ioRFBxyKQyd6ADMQKrxJEN81Wi/wD0wLbVbTqcmOJ8jNjLyOWkTYHrvAOZlZLx0p+7DifmrNp6+kxbipOgYbuo/WI5O1ntVMATNdpfUkCzfAVizfwTfm7tnMSf3BssShOiAp7fxfUAhZaEUu655zLzi/woQtNI/qegnL3L5hGN0F6Lcs7gdQ1edBwe+KlebKhPQyh07c16H6lC50/ZIM6tEX1ZC7wAFQ29BMn5X1nQlauy6Dz2buRFTLJm/oo5VL2doGttYzdbp8o1iSRN0gxeDjMkP0MPrWrXpLxrgSRmGLQMIdNYGNTvWdCllCmVYcY9N/aAHCbDpObZms0aWG59Mm6frn6TE9zi4z/WoZ729KETP1WBY++Xf3sUApXe70LQuMJO4tjS2LGsTS57P64tn/V6yUYsn2D2XNwHJNGvmUPWAeQnZ935BgMWA2aEQdJ8PjiKeX7HG/jcbdIXzC02bDO8NZDI9IoBjd5/usI99oTmRJio6HRPsnPdph+kxjKeb0OYCmRfwEvwYhZ6L9qAzRuxu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(66476007)(508600001)(6512007)(44832011)(66556008)(66946007)(86362001)(83380400001)(1076003)(38100700002)(6486002)(36756003)(316002)(8936002)(6666004)(2616005)(921005)(7416002)(6506007)(2906002)(186003)(52116002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JkP1HNOe7bx56TDfbEjiFQsDbDZ0hNnKORzize5DLgOD3xM6fSsLzq6zbCgm?=
 =?us-ascii?Q?F/UwJQGKgjtruKFscoKP19MWB3HfyVDbLwGt+OiOvbDszqy0rpiUQhSa7/1M?=
 =?us-ascii?Q?c0JozcmVxwJOAkLZzOAZSOE9V+Mz2oOn1FiERTE6eybfpyxtvoGYJG3UNnay?=
 =?us-ascii?Q?a9ekBMh88tkP7M44ed68cyIHMa7gMuHQ6ZHJo2jFwH1CKFsXSYNrOvKvKugW?=
 =?us-ascii?Q?f8dfDAt2fpqBqeeF1s6Ux6mLX/wzE9G9oCZLKbTRP50xhSMYckngUefqXNCw?=
 =?us-ascii?Q?RwyoFYsbMAptbDH16aditqNM8sRcNTvGXRp7qJjnO7ltBi9E81TLpvhxN4U7?=
 =?us-ascii?Q?fWtLFqm5O33gnz1mUqiZQOnWqmYCTE1vt0ky+UtHYD1pesv8wK/Xd6Gz58IP?=
 =?us-ascii?Q?DZNfCeypZ9ea7qRw/vpzx/rh/xz5ZLj87z6/HpSms4xS6btD1bEHb3IkNgLn?=
 =?us-ascii?Q?DgohgombLdVzKTBOxjG0DumIW94Kjh5/tItAuF7AHGi+rHNKxaC+LwThtEqP?=
 =?us-ascii?Q?S6vbkJrtw8Wyiwqz+Bhb2oN2lpMketLBuPe2L2ZZuqZcstuxBMLVd9ujkY01?=
 =?us-ascii?Q?ADcDFl7EJMEiwS+lax8sZYSgq6MY9loujwQ+YBak+ZlvZ3nGekBEHWrEz1vu?=
 =?us-ascii?Q?g8JBbjypYA3L/QW1XdatnJ9YPIZzJK2sF7vx6XRB7PpFuspLbP7vlh2fUyVR?=
 =?us-ascii?Q?yqqJCUro04seEHLYgn4ckGX1aiBBgOtUzXn48vL9rcStWg3gWHzeE5aP0rbu?=
 =?us-ascii?Q?QdfvkaOzLUe6eBcl/NqcBryjJrizLHDwaGKJSCYrXqL26w0jjJJR+0n7P4Uj?=
 =?us-ascii?Q?gRe+oAis5v8X2r0zsnBRvq8sw1HbFHPRUchfKVPXG+P0+labHtSQwmnV5UCG?=
 =?us-ascii?Q?NOgg8u9+BC6/KRciHzVospUlWmolq2OcfpVJpcLjTr9BH7zZxh325KjxGuQm?=
 =?us-ascii?Q?qZXR/69rwTzfYlKHgqy/wP+Kt+3zAPgE3oUqEgqTW4Ac5dxkSER7SyRd9I7L?=
 =?us-ascii?Q?a0/uxeI3JExGzwk8O4y9EWvvKYZ/yKSU9Xp1c6HuFurEcd7lUCXuZOUCDh1K?=
 =?us-ascii?Q?OkbFzREyJKdLouC+oFoDCdghzo9jDJG2zRDxqakXi9aaqq9kQhZRekkGCK2Z?=
 =?us-ascii?Q?RoQYJQ6WhjzQwyxjHGZt5fmNcNi9oZqp7l9BL/z4pobipCAhtaGMtKv86HKC?=
 =?us-ascii?Q?iVdcvqttLCqUBBAohyp1kLoqvHMA+UTjz/f4rRkTAJMT66bSE35T74RwaTD7?=
 =?us-ascii?Q?w3prdJ9Iw66mMyTXyoq4SRV0GGhUnT9TPJqSwOVaBnqyAPVQeGk/kw7Or5rQ?=
 =?us-ascii?Q?lsjf5rR4sa0Q3UklGClU/YfovioFSpAUZbTTlQMcFxqyF82D1mySVZVuFlql?=
 =?us-ascii?Q?UUNWDxjLWTL40S+DojaoIB/wAMxrBcXZ9HsiOwylxby24Noyfl4OMKLWNYPF?=
 =?us-ascii?Q?XILWWshe7S23yH41FSNO1Trdq8ofsZhpR8uBTDt0TTbwCR09k0ym++5MgU0i?=
 =?us-ascii?Q?I4/AJ7spdSoLC/Kvg3Qm/qfvnvXaoberKbmihAdcDhFvaJiBYLCuDoe6lV9k?=
 =?us-ascii?Q?OE3QHCBz8GxMZqG9WmPGykW6LrF9jLc0Bf8Dg9D/dphfidqPKJnxl6/Ge08u?=
 =?us-ascii?Q?iapSXx0HXWJXEsU9Q6KALtFD81BvQSDTPF9tbMxiOzHx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ec3292-9b57-435b-fb2d-08d9d5348e02
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:59:55.0009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jf8n3MwflJ9cSgUycG/8ogNbn5WjJrnfF6heofqr4Pggt2DgfWESg2bH8oaqBT7HIp93/ZhExKjQgpFvICGuSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5647
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10224 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110101
X-Proofpoint-GUID: UurHFB4B-z4XiL92ZyMri78J8F3bMuYb
X-Proofpoint-ORIG-GUID: UurHFB4B-z4XiL92ZyMri78J8F3bMuYb
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If one of the MD raid participating target dax device supports
DAXDEV_RECOVERY, then it'll be declared on the whole that the
MD device is capable of DAXDEV_RECOVERY.
And only when the recovery process reaches to the target driver,
it becomes deterministic whether a certain dax address range
maybe recovered, or not.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 drivers/md/dm-table.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index e43096cfe9e2..8af8a81b6172 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -844,6 +844,36 @@ static bool dm_table_supports_dax(struct dm_table *t,
 	return true;
 }
 
+/* Check whether device is capable of dax poison recovery */
+static int device_poison_recovery_capable(struct dm_target *ti,
+	struct dm_dev *dev, sector_t start, sector_t len, void *data)
+{
+	if (!dev->dax_dev)
+		return false;
+	return dax_recovery_capable(dev->dax_dev);
+}
+
+static bool dm_table_supports_poison_recovery(struct dm_table *t,
+	iterate_devices_callout_fn func)
+{
+	struct dm_target *ti;
+	unsigned int i;
+
+	/* Check if any DAX target supports poison recovery */
+	for (i = 0; i < dm_table_get_num_targets(t); i++) {
+		ti = dm_table_get_target(t, i);
+
+		if (!ti->type->direct_access)
+			return false;
+
+		if (ti->type->iterate_devices &&
+		    ti->type->iterate_devices(ti, func, NULL))
+			return true;
+	}
+
+	return false;
+}
+
 static int device_is_rq_stackable(struct dm_target *ti, struct dm_dev *dev,
 				  sector_t start, sector_t len, void *data)
 {
@@ -2014,6 +2044,9 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 		blk_queue_flag_set(QUEUE_FLAG_DAX, q);
 		if (dm_table_supports_dax(t, device_not_dax_synchronous_capable))
 			set_dax_synchronous(t->md->dax_dev);
+		if (dm_table_supports_poison_recovery(t,
+					device_poison_recovery_capable))
+			set_dax_recovery(t->md->dax_dev);
 	}
 	else
 		blk_queue_flag_clear(QUEUE_FLAG_DAX, q);
-- 
2.18.4

