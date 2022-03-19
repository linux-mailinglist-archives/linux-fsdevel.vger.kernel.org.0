Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686594DE67D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Mar 2022 07:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242325AbiCSGbz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 19 Mar 2022 02:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242320AbiCSGbh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 19 Mar 2022 02:31:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC1F2D5A38;
        Fri, 18 Mar 2022 23:30:05 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22J1hWKI001709;
        Sat, 19 Mar 2022 06:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=nSEyfhezoAwlNyvhBjZH9FdND1rQ/6a4aYmOeSPmj0s=;
 b=SwObJ1fvIhv+6LgWZHxU+5jGRB8hjLHF6yMBxVss7WaMsSVRaVDu9Qhfu2YfLtmYcuOM
 0mFV6kJBhs7ALaK4YXvuL7ylsqngyiUGY3Bb94OEZlQXYgzDF/zZti3zUk/kJnuY0l4i
 wKXhgK37RHdaE2kDqnrMosMMHRA0exGg+kXV/1eCD+Vb4m76O7PwRsnL6J8TO4tKCH5U
 hM1JdIR42fnsJX6wCWLrXxfbdrLm4RZ1houIEudGCK05zDe2uNZTCAVj9ETVpulWqDJx
 ZgzVmalH8J1XcYa7XM5Wk9WkrFzvnDitWay+HRAdEBvtJlcMgDgBf61JrXp+5mfnPzZN 7w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew5s0g5k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 06:29:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22J6MkAJ028031;
        Sat, 19 Mar 2022 06:29:08 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2044.outbound.protection.outlook.com [104.47.56.44])
        by userp3020.oracle.com with ESMTP id 3ew8mfrwjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 19 Mar 2022 06:29:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FftQFY9KhE2S8hSfnqZNoWS3LWFO/9Erx5IxGPJ3NszF8tsa+qvuXEdJj+AUGkQ0v3diIxelFENbCKRx8qoOFxcLPxQ9egv9suL8+Eqlhvc+Afw12PKjjmJWJGNW0f2BNadEV6Nq1XVYZY9ojl1fhGFzVyt1HgMeAh0UcEQYb2g8wczgOh7nj9kN6r+JMs9pRNM0Nlhpux2BL/UeTFU2JakfUMCJDRVHzufeTd19myXFK0tsFTdokJ3J4Bo4OwOR0LdfsUMlpqxvL3WfobPLy8dxidNOMTJh2nWYrnePySK3HkywK8XsIiqRbmBvDqI2ZubggBGmT6WQq9qU8aX8Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSEyfhezoAwlNyvhBjZH9FdND1rQ/6a4aYmOeSPmj0s=;
 b=U8spj0KAvtL1Kfkn3qnZn+M1GeKkjM6+Eyl232YykQ+wct/RTuYg7zxugGCr3Q0djAjnqVXT7ZXE9jJT6bDe42PZKJjf94O/iiWoBQELPOE+rgZ9c9A9oPiCZXcIVP3OtNY5fj0HF1FSkJYcjz2qFP8I3DhGCv3rsVcus0FM4w3++4DbLL+gJ8rBxEMNnsejFZrXK/cGXteivzG9Lb+SPxjkYbXUHxR1/0cQx59c/j6cTHsOM36rMVJzR1esC52umVeRUgW/LaRyOz/1HimcyFnORFqGMSukGakSbKoxxiV/zvgjUKBGuCAyqtW+HQLQRuibCor9eSDZejBT3Rs0gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSEyfhezoAwlNyvhBjZH9FdND1rQ/6a4aYmOeSPmj0s=;
 b=kjZGA1/Yz9512345bpkexLBeqv5W/HEw2Ot+dTL4jly97qkBlfMwWal84G//w4n2aQ+l2TAtY9nOW7KD5kMoL++8tBxUh/hLXUQt810MtSl9+8TAqPWzfblhUMh22ZfMdKIcbY10nRWlfmUoQTmlx2KF2maC1/WoO7r2S1J1mdc=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by CY4PR10MB1798.namprd10.prod.outlook.com (2603:10b6:903:126::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Sat, 19 Mar
 2022 06:29:06 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336%8]) with mapi id 15.20.5081.019; Sat, 19 Mar 2022
 06:29:06 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     david@fromorbit.com, djwong@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, vishal.l.verma@intel.com, dave.jiang@intel.com,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        ira.weiny@intel.com, willy@infradead.org, vgoyal@redhat.com,
        linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: [PATCH v6 1/6] x86/mm: fix comment
Date:   Sat, 19 Mar 2022 00:28:28 -0600
Message-Id: <20220319062833.3136528-2-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20220319062833.3136528-1-jane.chu@oracle.com>
References: <20220319062833.3136528-1-jane.chu@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0025.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::38) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9caddc3-7e76-46d1-809e-08da0971c4bb
X-MS-TrafficTypeDiagnostic: CY4PR10MB1798:EE_
X-Microsoft-Antispam-PRVS: <CY4PR10MB1798CAC8F55A764B3050D216F3149@CY4PR10MB1798.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5bGlc+erw/EVNfrGAuQsEybCZ3gcdK69SDlfloAagjkZnFIrVgrcGv2mLxIvuuwOaica3k2TVXwvQ2oKomCKSKdhiHfQydvQ4caQ7ZtT1tS/1X3q8EtBMGHAOiwYahakTJNhBLb+NDRRVJi/Uzccm0THsE4mub5enIDM3ntXv58bSxyE8pMY7MBnG343x42zbTAXlqBwYSdb4B7faucg3OlGW0xIULRb/pGkvUmyKRLETck4fzX6xO/vRtKBxngEDux2gxeckUa2WVCheWXDIK1oUwfhAXVM0mA5hJaxOIvjQzyx2I2mLtSXixzdN4EGXDkOWlpXy7Q1pO3e4v6iZKSJ5LO9zN0GsxtUnVMxtdCXm68RCj/FLFYOSjawgx7ZUnxVBCedybNo5/ZpOpCTUoNxlmqokFbal4slS0aN9zRl3wPgAw/Xwl08+O42iPw3yLDIeiIQM/d+x/TCbnS2eyvwkPgcOB4LoOX9hL49NY3LUC0eWBVgggDOt3HgMeSQ+PmdkuFO7IHW6/P2+F20JMcR+evlmIvFDdGkAMiy9w+3/2r3y/wxI2btBs0jLnkLWYOmGK2B/iWNuopNDKESet9zwzG1PecVcxxSPcgNjKe/DTeHl9rMD58XifusdGli/GWmLvwDcsjaXMvecK0ZAjmDi3YSsAaJMqEBcqaE/HmBoTVngA2FHSiIbBNMhRg9Wsd8fMJtPc09WS4J17CIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52116002)(6512007)(66476007)(8676002)(83380400001)(66556008)(316002)(6506007)(2906002)(38100700002)(66946007)(508600001)(44832011)(5660300002)(8936002)(7416002)(4744005)(36756003)(1076003)(6486002)(86362001)(186003)(2616005)(921005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mwYwvJZo19hXF07BhyUXxGivvBuBW0S+2vhfW2Gzn1c48V+6gu3IFpzhbk+a?=
 =?us-ascii?Q?en3Af7rJQgq+IszkMR4LTUfllaILZWyZNEDC+W0nTS9tucHPU7Sybh9RJqE/?=
 =?us-ascii?Q?cFPULaVDDromGdJ6jf3bA6vGgrpavB5Cc6hHu+fokfNBTI27GH/D6qmTfpc/?=
 =?us-ascii?Q?1TfHbj3o3plTtiDQxg3pKs+IQM/w31QCSA1rrgqmt6OtUXeLVlUvlln1a9OL?=
 =?us-ascii?Q?GSuSsm9H3jYCp0JgqRrXJDfmqIHQxLxM+VyQ6wh1tHzmqpb8FYh+/EfgwPRI?=
 =?us-ascii?Q?GB6bzDSn4YBZFww5YLY89Suv93pmfmpBmoXPadsDtmT4BRqKwgZBxkj4k1yQ?=
 =?us-ascii?Q?y0MIMAys8UzneQNYKiz+fP8F8mFvgysAuMQVsCXTmhN4B/7KinjekED3nv+y?=
 =?us-ascii?Q?rktPNImC9BBjByTnoi125mtwEseei2XIehBKi6Ifrb60Ex3VDUVdU9n0CeWQ?=
 =?us-ascii?Q?VKM6V0aXrLvq0MT3hIlD6Ofl6HVqTW74ig85RpY2YQHE0w3ghA+TW/BIVPre?=
 =?us-ascii?Q?CQz1sG43pZ92eu0ZNpdjq99nfQ1vRy3uf5s4ABdPH5kZonWGO9XEkbKnAS53?=
 =?us-ascii?Q?VziJdkULsWTbGhm1c7MUyMWaxDDBYIA3RfEP9QuSvo36XxtScskxzh7Xr3/L?=
 =?us-ascii?Q?vpkJOPi1T8kzE0gZBB4Iq/7CBjNKpTNqjwNChwHIHLs6KHs+JXT298fyJqy9?=
 =?us-ascii?Q?G/JaAJPTRhO1Hdyy7pR3pfDA9dcDZU8k0E36VjfNcnrHZ/Cjr6RHJtY6Ffjv?=
 =?us-ascii?Q?6PR9Jko8qR4PzBHMNQ0UHHVhx/l36b6nPVZRgJSVaKkzZAc5PlSISFCFNT8L?=
 =?us-ascii?Q?vfAC7JQe2GCXawZGYtkm3R/ZaB+URoN+4/rypJ9T6lqmWlvBtM9babLfFXUl?=
 =?us-ascii?Q?/Fw05OojyP7hnrHWig6RB78MprVL3Pb9hA2xOJ3g7A/yLWHyN5JhXU2AGGZ4?=
 =?us-ascii?Q?jK1t5XNF2rT9xvKIpjDfwb+qVidAa6pRTZAROvlcSjcGJcI/90RLW9NhAcXe?=
 =?us-ascii?Q?iBQM+ALB+myyYD0WNHBkQc7/r+IbGtiMEQDLDgwKoy8ZnQu8s4s+CVTKMcPE?=
 =?us-ascii?Q?+K86pkbGXce5e81BtH1swhkn7CY602WHba4jm0puWEjiYrT7KQ2ix7u1kopH?=
 =?us-ascii?Q?hs7/+/E8d2aNZ5i6bFphJav9vG1D5m7UTIHwlQZGptTdaKb0IBO7p0+kKOkk?=
 =?us-ascii?Q?WGdeZm6CptGr481KR8C0dfmJ/bSM99+G8YTzVAuQ4AD3uOvjq89EkPDYOnQP?=
 =?us-ascii?Q?pSA0UdUvW5aDHnSC9CZNeSzZN2nMZ/TBSHR8JClMMXpiRHQh91TMt5STMi4L?=
 =?us-ascii?Q?aeLR6tsH3D2rfiXgznSn/bMK4IWBesrkjHcdDyrkYKCigpQKmsMj7RYjufg4?=
 =?us-ascii?Q?oSsE62T8GcGmWAPymAd5EMj8rk0A7wi3XcpzFf+QD5ten1zai35Ixaf7/Cnw?=
 =?us-ascii?Q?VcGgYJZ1qy+HNzeYKlVIIrKn8Il1t3ouBeYa4OA3df3hnMJRYcVMNUo/toqb?=
 =?us-ascii?Q?3519Qq1Oz+d4CeI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9caddc3-7e76-46d1-809e-08da0971c4bb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2022 06:29:06.6495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bQQsYdQeD6pUtDnOf4J+sI3axJsdWuvKFK8pzJTMVHu4WgQyWozFWqfJla0inFnkA2sUTPJS9dzo31vfLsuQSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1798
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10290 signatures=694221
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=826 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203190038
X-Proofpoint-GUID: ilkLvOq1iKrCtLQGpAotQwpPApzqyRw0
X-Proofpoint-ORIG-GUID: ilkLvOq1iKrCtLQGpAotQwpPApzqyRw0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no _set_memory_prot internal helper, while coming across
the code, might as well fix the comment.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 arch/x86/mm/pat/set_memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index b4072115c8ef..042cfac6272b 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1816,7 +1816,7 @@ static inline int cpa_clear_pages_array(struct page **pages, int numpages,
 }
 
 /*
- * _set_memory_prot is an internal helper for callers that have been passed
+ * __set_memory_prot is an internal helper for callers that have been passed
  * a pgprot_t value from upper layers and a reservation has already been taken.
  * If you want to set the pgprot to a specific page protocol, use the
  * set_memory_xx() functions.
-- 
2.18.4

