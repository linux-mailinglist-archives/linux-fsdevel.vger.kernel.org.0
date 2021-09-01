Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9003E3FE179
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Sep 2021 19:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344758AbhIARwz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Sep 2021 13:52:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24692 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232026AbhIARww (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Sep 2021 13:52:52 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181HOL7c016767;
        Wed, 1 Sep 2021 17:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=tvz8+mSx/6hAxHUxDTynb8tn5ymhX7NY1MEMEv78HNI=;
 b=TcYARtR6dRKwdlC93SfMD8uhUjDIdz/ihLgetWVsZVaf19lxSL02z8CxpAMSs0Jw79Uv
 SqxrjHFWm/1WtTkFYVn5bfXUJHl3aPbTC+lebdLHzCaL/BWEjGT3iryUQhDJ82TWHFA1
 TippdbktT9asf58IZKCwOEh7mHmrxxCR4m/Gzuy9yXZinkuGHtzoqrXrYSG+tHkWLxGd
 lkMR4xEWtGh/97GC3PsTbttXk5E8EEDtEBda2v8atC3XiYGbWZqY4riPiX9BP6lhjeP9
 v2ibZ1fzebURg60mB46Rq+G+4VXRX93rOQAuVxfD593PUFqMVI70Mj3OXSYWTTmXrApg Yg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=tvz8+mSx/6hAxHUxDTynb8tn5ymhX7NY1MEMEv78HNI=;
 b=vdRWX1UVId+vqgRv490cZlFSDAPwXCj8DnpWCLKBHi+Me2Xp8Yiy6Eb5ex8B4bcKpv0+
 k4+kLhRBWTzVw27vHXp6JQJBF0ezwDW/fCumfUhWnf91in4IE8MuX3ziNWW6ncnhM/+a
 65eZSrcZ2F9uuqf/eqoJtglHk3F/X0i671mTnHY+D6EN+nIDKn2kESLXrQMyNA8c6Uxh
 AJV/kiX8ZFdEpAudT/b0/ZCxXKeAfBtfrLjuJzwDU2UtX1msAOupRNAXSpIx2X96mtBe
 aIyDT8g9JN6B+Y289r8QDJT/WuwTwdNdrnrZ8nvm6PmIywTs7ce8DXMeF4Trs9gMrHKb zQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw0g2jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 17:51:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 181HnlEW128378;
        Wed, 1 Sep 2021 17:51:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3030.oracle.com with ESMTP id 3atdyvrttb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Sep 2021 17:51:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxngmESI2Gp5vKI4AKS2QaW2vEnVu0cqj/uFAgkuruNNlzlMKw0B4QPfyb5CNlHDMXNjnse/4cA6LwL+9o5DWmXGgXfAjwFvBAqgLoKLROTumlpBrU0JyCSzugIn57FTct7sXYdQHVZ60fookYWQ0ltBhJs5R6xwLDim5XIp3h2IE0aRuBm3Y4yJ+qJlvIQiMHhXJid7wKTTkBXqrScRuIm2J9BMKD3RTaGbimFYTP05V1eHaIXUWkCDHIBok71nG6d2K13BPxFTDM0NI7vD+WKbKxiS3ouSVl4X80ti9JdqVnynm4tRCn/1ZmaUOnKNtAcEwGgea51ndNEdWWLURw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvz8+mSx/6hAxHUxDTynb8tn5ymhX7NY1MEMEv78HNI=;
 b=ZOB00Ef6GcnI9TXI0stMC9zwntP8HaaTa6B82pXd6C75KpmwHAyWXvFs8Dgq43Q5zm+rIr/h9VBQqiaWHPc0OX9sRpUP8Id9ZLiyE+xq/ydEoflgw0cmXd2Lp0b+eSvUN55xUCNokq7g6aPL7WZchL/s2c7Gj9vx40C/zKwyKw3fO5jYJDEGYEQIg7reBwEQn+7JdiJCtos7HHrhxwmzJvfqDvuOiRGwdhgR7lccDndpVzgMe9H9/mAJerk7Lk58MoacRyITSjXFbYn1WjqihXZesIhNMT+jKZ3nH04n0TRfs4tkLm+rRFBShBMDuqH1KIYQs37ffoyIzhY4po6NWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvz8+mSx/6hAxHUxDTynb8tn5ymhX7NY1MEMEv78HNI=;
 b=uECNtMeCmnb2MAuR63yo55jETOe+Y00beB+76zYyk3AKQMgKPYnL0X3K2VRJMaQJZFPpzwZspimw0Cboloy512HmATcyVPqqaAuoRzDitr8p+GEWG3KX5IkWrpMM1PBKhW0vNQReBC09Mza/LvDd83okYJMnPDGuss8fkzV4llo=
Authentication-Results: zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=none action=none
 header.from=oracle.com;
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH2PR10MB3863.namprd10.prod.outlook.com (2603:10b6:610:c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Wed, 1 Sep
 2021 17:51:51 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::2c22:7eb8:a2f0:e027%7]) with mapi id 15.20.4457.025; Wed, 1 Sep 2021
 17:51:50 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] namei: Standardize callers of filename_lookup()
Date:   Wed,  1 Sep 2021 10:51:42 -0700
Message-Id: <20210901175144.121048-3-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210901175144.121048-1-stephen.s.brennan@oracle.com>
References: <20210901175144.121048-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0131.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::16) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (148.87.23.10) by SJ0PR05CA0131.namprd05.prod.outlook.com (2603:10b6:a03:33d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.11 via Frontend Transport; Wed, 1 Sep 2021 17:51:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e585880-2035-432d-5dbd-08d96d712d3f
X-MS-TrafficTypeDiagnostic: CH2PR10MB3863:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB386321F44049CEFD85D5A110DBCD9@CH2PR10MB3863.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8unfbx/Tg6vStpT2nT6UqK/0dnbYoAKfBjnxPEWylze6EahTMcGOhIBlNkf+?=
 =?us-ascii?Q?UMfIqSB5BP234z33B2E7kHKz9c9j1syGS/xpjGRGnYPLfsJrjIn5V9LL7Qs6?=
 =?us-ascii?Q?30mLYiRukY2+KJOIthBypNE8Skd6uTrIWZKrZ1V/6biwNfWpVZugCOkT1Kd/?=
 =?us-ascii?Q?vWW62R7AsRB1trq0JQ72lVjUjfuIXjc/OILoHrLv4iKUvmqH+2uebmRhOOm1?=
 =?us-ascii?Q?kTzLnZYn2mk5yNe3FADc/EGU92V56yGLdEmFndo0ypOxuaUV2XRbdTQtp8mt?=
 =?us-ascii?Q?Mg+VEQnihBNlVfZoreb3p4jdn4lbAJXNJneiky2idQdp7/vO11nYIIm3f0ya?=
 =?us-ascii?Q?y4cmUNGXkV+j1Gwss146Z7XJ/o1Ykqg3DZOiBxngpKlciBEaceh1Dm+J+Mn3?=
 =?us-ascii?Q?FqeGQxVLQgLNdXrDhWToD3hVWBMusPXb/KtX3RBpOPLVDojXox+r084Faobo?=
 =?us-ascii?Q?z5Nw7Ofhr2HnirDVyhADpQP0XPS+OUS8DWNyh0Pa1xUguiRoGaQp0InRc5sb?=
 =?us-ascii?Q?UTzUE+QJjrpDXFd9RMwOvdK1Lys0tjsozf6zs3dQ5ER9i/QO2Mh9kd/iTMP/?=
 =?us-ascii?Q?xJ5oJEvKhug+OAdvobanQy/AeKmp0xD9tYjGbd9SuO8YCknau5udK/aywS5z?=
 =?us-ascii?Q?sAnCGKftM1pyU3q5SPJmZ0Dwrim1j07TW7zuzveCif+lIysEdzhsVwRYfJuk?=
 =?us-ascii?Q?zZNa+5g6rU8FUxxPgupGgVwPseVTxhgPhMwVIMJ6i4KNXIr06hTNpLUfriAc?=
 =?us-ascii?Q?HnhD6bJMlQ1R6b2Z97+/BCT7ASHLbleljNZ++4NYEtyjQr9kmg9BN80ATwJw?=
 =?us-ascii?Q?ZHN6d+TGin4LuhlgC/+CrjL4iNRL7YLmOszOQ+vgNsdeU171E9ijeQNFKcM6?=
 =?us-ascii?Q?XkhwGD48TB57vSKMU6vos6FMC6xv2Hfm9MhzDSCBVx0i5BTrI2DXIBJlCRTd?=
 =?us-ascii?Q?0beD/BIGzdCIrznpVa1fjX2ODnOHimMjvOXLFUNn9x1ebKlaq6tICxhvRJbz?=
 =?us-ascii?Q?L1IU3gb0EMe35boeSh/U+KvZ4PiV0uvZX06bUirFcQES7rwkZhsAPW2tb9eQ?=
 =?us-ascii?Q?BzeVxVE4a++iPSszieMtyNCk+TL2jsUYQWNeVOzYq7oAup61k8g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(39860400002)(136003)(376002)(346002)(366004)(396003)(5660300002)(316002)(4326008)(38350700002)(38100700002)(6486002)(66946007)(66476007)(66556008)(83380400001)(86362001)(8936002)(478600001)(36756003)(103116003)(8676002)(6666004)(6496006)(2906002)(52116002)(2616005)(956004)(966005)(26005)(1076003)(186003)(6916009)(23200700001);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZE2Se5kMwYomcGABi7zNvJY8f6RkSdbZusE7mtRjQAjtzEHsRkHRMzVFJeJM?=
 =?us-ascii?Q?aBdLhamQxyhslyTnMWkAeQ8pKWcb5CxxJiGBJMceq7etf6yN/aYOXnh6Xqco?=
 =?us-ascii?Q?IskOwQdaP8K/wTWwlhLv337cEemfNR4qZaQb9MajQ3N1GSA3UMs76H3Tw6EJ?=
 =?us-ascii?Q?FnORLPXwuVENtdABVjzRukHRanPfoR4lU2HWLUQIckRcAnoDxzjpeX8ZvptC?=
 =?us-ascii?Q?D3j9KQ6Pj7TpxFzWfjM8LvfrNSE+kgneEJnahcCCtkFzW5xZnsLT9hgfjICl?=
 =?us-ascii?Q?0gcWGjUEkRUnXd6IilmDkSEy40U90twObRV++TZt/h7bW6zNXRIL+mpWGyRr?=
 =?us-ascii?Q?9KcatquMOk8K0c0rfrwdhdzioL43sKdYfQMN5zUMKLbmEyCC/J/3AMvhBP2n?=
 =?us-ascii?Q?11NKze5akjelb2zqWv/KXu9Q2IMgm1AEXbfWJyZ/kfg5x0CrOw4oZyt/ShIA?=
 =?us-ascii?Q?orNMO953ar9VXCy8s6y6mEyFSfrxk+v5ctcOEGA7eeDuvvh1TKPPQIJWN+vV?=
 =?us-ascii?Q?ZwEsgBIGeS/fq/fs/qH9j5ielOXrDCdMs6/kbAN0skktYhLDefPJtKZ3tKwu?=
 =?us-ascii?Q?wqyfTjGpIYGQIbhM1WA7gkDNUTrBIFP8dFDJMHam0S73KiW+yp6Jw3G3fe58?=
 =?us-ascii?Q?HVKDL4gGZIl/LoiiwjmPQyRZF5e+Weai74nn4Z6Q66Lnn1NtB/L1zxhQAa1Q?=
 =?us-ascii?Q?TRdFrnz9Atddi8kLSs6OLGH8ChzkV6WbdcLh2O9qTCcGk3PWwi3JKBOlbyIa?=
 =?us-ascii?Q?hjVPCBQmwv/gehBW9bJVRiWwSz4dlE90eBN3rvO8vRJsf2Z2KdXolVr7veX5?=
 =?us-ascii?Q?DxhbCGv2tUYAAhp5EF+tC8XiWy8Wi4X1u6qyK3ft/LtJ95g2QHWhhPzMyBjl?=
 =?us-ascii?Q?eUNDU0H1H2kPM/uJnGp4e0UCLVxiVmKsy0W+LHcR89X1zfCIKon+Tjqt1lB2?=
 =?us-ascii?Q?vPY2wOIvsMKjN5oBf6sYsjbdAvjQ4eFYjd/4eILx34DaPnih923mKti4KM1D?=
 =?us-ascii?Q?G1Ia2ipnhUQqwB3DR/mR1pN0d4nRdSArMZ0GUiS6/8f+JEIItO+gOgZWMZ3I?=
 =?us-ascii?Q?uh3XoV4clL5FqtAn/zR66qYjqn0Bj7ocajwg/fRJffHvD0BbinK38ZM4LGb+?=
 =?us-ascii?Q?HRaOjWyz0j+qe65nNKQ2+GmtUfR907xQQN7SnNyjWIaTXzpY4zEV0mck2h6e?=
 =?us-ascii?Q?Eak/O254twMLiK6iSeSa9zbMqdzmx+97MwM7lJ/7PglIiRC10CMp7TzmPgXr?=
 =?us-ascii?Q?7zFf1Ndv2lOBuYCViVGw/KUAKjBRL3JWK9sb2b51IAe+pD6ng03tDetMIIBB?=
 =?us-ascii?Q?3U67q02PhRzVlFgcOyNTRXaz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e585880-2035-432d-5dbd-08d96d712d3f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 17:51:50.9108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uMEqJlN1+ay8OyIkKFJxfM7q99oRMJDa6tjzI/QXSjjkkX8hVguZbVs6hnK2ybGW2K0QK+CPl/HXw1mqc4mEk3Oq3ifLlWND/C2P6NudLCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3863
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109010102
X-Proofpoint-GUID: ErR0MIJ2nm1L5iDevcl87oEb5oeeK_Fz
X-Proofpoint-ORIG-GUID: ErR0MIJ2nm1L5iDevcl87oEb5oeeK_Fz
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

filename_lookup() has two variants, one which drops the caller's
reference to filename (filename_lookup), and one which does
not (__filename_lookup). This can be confusing as it's unusual to drop a
caller's reference. Remove filename_lookup, rename __filename_lookup
to filename_lookup, and convert all callers. The cost is a few slightly
longer functions, but the clarity is greater.

Link: https://lore.kernel.org/linux-fsdevel/YS+dstZ3xfcLxhoB@zeniv-ca.linux.org.uk/
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 fs/fs_parser.c |  1 -
 fs/namei.c     | 41 ++++++++++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index 980d44fd3a36..3df07c0e32b3 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -165,7 +165,6 @@ int fs_lookup_param(struct fs_context *fc,
 		return invalf(fc, "%s: not usable as path", param->key);
 	}
 
-	f->refcnt++; /* filename_lookup() drops our ref. */
 	ret = filename_lookup(param->dirfd, f, flags, _path, NULL);
 	if (ret < 0) {
 		errorf(fc, "%s: Lookup failure for '%s'", param->key, f->name);
diff --git a/fs/namei.c b/fs/namei.c
index f2af301cc79f..76871b7f127a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2467,7 +2467,7 @@ static int path_lookupat(struct nameidata *nd, unsigned flags, struct path *path
 	return err;
 }
 
-static int __filename_lookup(int dfd, struct filename *name, unsigned flags,
+int filename_lookup(int dfd, struct filename *name, unsigned flags,
 		    struct path *path, struct path *root)
 {
 	int retval;
@@ -2488,15 +2488,6 @@ static int __filename_lookup(int dfd, struct filename *name, unsigned flags,
 	return retval;
 }
 
-int filename_lookup(int dfd, struct filename *name, unsigned flags,
-		    struct path *path, struct path *root)
-{
-	int retval = __filename_lookup(dfd, name, flags, path, root);
-
-	putname(name);
-	return retval;
-}
-
 /* Returns 0 and nd will be valid on success; Retuns error, otherwise. */
 static int path_parentat(struct nameidata *nd, unsigned flags,
 				struct path *parent)
@@ -2571,8 +2562,14 @@ struct dentry *kern_path_locked(const char *name, struct path *path)
 
 int kern_path(const char *name, unsigned int flags, struct path *path)
 {
-	return filename_lookup(AT_FDCWD, getname_kernel(name),
-			       flags, path, NULL);
+	struct filename *filename;
+	int ret;
+
+	filename = getname_kernel(name);
+	ret = filename_lookup(AT_FDCWD, filename, flags, path, NULL);
+	putname(filename);
+	return ret;
+
 }
 EXPORT_SYMBOL(kern_path);
 
@@ -2588,10 +2585,15 @@ int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
 		    const char *name, unsigned int flags,
 		    struct path *path)
 {
+	struct filename *filename;
 	struct path root = {.mnt = mnt, .dentry = dentry};
+	int ret;
+
+	filename = getname_kernel(name);
 	/* the first argument of filename_lookup() is ignored with root */
-	return filename_lookup(AT_FDCWD, getname_kernel(name),
-			       flags , path, &root);
+	ret = filename_lookup(AT_FDCWD, filename, flags, path, &root);
+	putname(filename);
+	return ret;
 }
 EXPORT_SYMBOL(vfs_path_lookup);
 
@@ -2795,8 +2797,13 @@ int path_pts(struct path *path)
 int user_path_at_empty(int dfd, const char __user *name, unsigned flags,
 		 struct path *path, int *empty)
 {
-	return filename_lookup(dfd, getname_flags(name, flags, empty),
-			       flags, path, NULL);
+	struct filename *filename;
+	int ret;
+
+	filename = getname_flags(name, flags, empty);
+	ret = filename_lookup(dfd, filename, flags, path, NULL);
+	putname(filename);
+	return ret;
 }
 EXPORT_SYMBOL(user_path_at_empty);
 
@@ -4421,7 +4428,7 @@ int do_linkat(int olddfd, struct filename *old, int newdfd,
 	if (flags & AT_SYMLINK_FOLLOW)
 		how |= LOOKUP_FOLLOW;
 retry:
-	error = __filename_lookup(olddfd, old, how, &old_path, NULL);
+	error = filename_lookup(olddfd, old, how, &old_path, NULL);
 	if (error)
 		goto out_putnames;
 
-- 
2.30.2

