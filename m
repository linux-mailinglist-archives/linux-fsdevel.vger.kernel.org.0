Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860F334F35C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 23:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhC3V2d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 17:28:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50410 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbhC3V2J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:28:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOG4R130445;
        Tue, 30 Mar 2021 21:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=S5mxt1NIEyrRs7BS4f3y+XZwhYNVLCfqk6ZBT9heJ/w=;
 b=ftpagAZcp4SiMqaFdJ7S3YQJfC25BEDCzVQdVldIWCPt6V4YjBkujRy8BLT/y15r0rO0
 fBmlMvJXD1puHCFNISXp2pH0THfjl2W/UpjrgqR+dt9nOlFNdNKXG8j+5L4/e3tnu7Bc
 6EbmWBWTwVcnBVb6kQeuE27rb7n2jRpl23qQY2Fv9mFkJuOotQbl6E9xwFuHWhCpLJyD
 Kyb43hjoGu8+5v8lp8/BeR1F2IHnEoKQqe48FlVAFq0bkcVDcoZ7pH6BZGhyAPm/RJ8W
 Ypm096wLTUq7uhIp2dPu/+EMH7stqiT3HmRlDtHB6CwzDz0k3XGY+hXuflW1hcL+uSeW Bw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 37mabqr8qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ULOnW5184074;
        Tue, 30 Mar 2021 21:27:26 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2050.outbound.protection.outlook.com [104.47.36.50])
        by aserp3020.oracle.com with ESMTP id 37mac7u59j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Mar 2021 21:27:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2BTvqLp1yhE5MbWaj03ZQkzTsfx35X3FMrg9VAlfZ2LYY1dF7oQvbE6k6VQT8Mtyfblc+zYmE/40g7Tw+qC3Al967+J4oZwFfA/KFKOyQcRiHQ3lHadMd7wrMnmlCuxsBqhAdGVxFxKfWGeHOrTD7pVQBFbPpN1RgeNEaA3+wy5zn6I3Z9dXlzcD/JaWowe3InjbDOj+QP5D+wWAb1YLHL+nEGNLMhu+XEYMzw4y3mqdJxYvlgP9BRZVfDjV4M3yen8Lzxwww1Ll8LcKF3yEOYbd61eA8S0zwcwddckuCw8QFP7aXTolXtvvZG8wNbNtSXi7sr0rOt6wE+nno+Pwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5mxt1NIEyrRs7BS4f3y+XZwhYNVLCfqk6ZBT9heJ/w=;
 b=UUcx0DGO6ewhNhdkrJ6DboafCJ1XuqEUXWuWd9Ef1bBINIMUL7BZurJzYjOAgMeI0ZetX0teKDJyBk+J66Mzp4q2M5mDWrJQq5I3YaZHkbikjY2pBBYJlxsWDphgcpMS+v2lNLnbnM5KQ6GmGvblyDSi4oIWrSs9jA3VaIQuKq2DXgKo5b5utsy1UdHCEcFXyRQDU+Jf/banO8FdGf+EIjJQvHaraY+XfltYWngPaFrItWieF8NtmP/CD+iu2MngCKJ1RTWqSIopPA/Oz8nI6EfokbB2kCdfZlbAISZ5z3AWVCWF+rj+o6FPanI4zePVL488XD+YH6ULEQDWBWFVtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5mxt1NIEyrRs7BS4f3y+XZwhYNVLCfqk6ZBT9heJ/w=;
 b=HeHPyDdayOhpmTePn5O2bcH5jtQmfTggq4d/JGECOY/3Sa4eMOz65vDrw3sizK8fJpmRdR8Dcp3TjxFbdnNpSSUyCppv1GDKf0T93dTosz/6eUw5eWPqtMIVpcKzEsSQRIKEgGGQVwA+2Gni5q3JHPH6rOoaNk04avq9SpOgQ4w=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB3533.namprd10.prod.outlook.com (2603:10b6:208:118::32)
 by MN2PR10MB3679.namprd10.prod.outlook.com (2603:10b6:208:11d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 21:27:24 +0000
Received: from MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254]) by MN2PR10MB3533.namprd10.prod.outlook.com
 ([fe80::cc79:c40e:430f:e254%4]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 21:27:24 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, corbet@lwn.net, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        rppt@kernel.org, akpm@linux-foundation.org, hughd@google.com,
        ebiederm@xmission.com, keescook@chromium.org, ardb@kernel.org,
        nivedita@alum.mit.edu, jroedel@suse.de, masahiroy@kernel.org,
        nathan@kernel.org, terrelln@fb.com, vincenzo.frascino@arm.com,
        martin.b.radev@gmail.com, andreyknvl@google.com,
        daniel.kiper@oracle.com, rafael.j.wysocki@intel.com,
        dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
        bhe@redhat.com, rminnich@gmail.com, ashish.kalra@amd.com,
        guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        iamjoonsoo.kim@lge.com, vbabka@suse.cz, alex.shi@linux.alibaba.com,
        david@redhat.com, richard.weiyang@gmail.com,
        vdavydov.dev@gmail.com, graf@amazon.com, jason.zeng@intel.com,
        lei.l.li@intel.com, daniel.m.jordan@oracle.com,
        steven.sistare@oracle.com, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org
Subject: [RFC v2 33/43] PKRAM: atomically add and remove link pages
Date:   Tue, 30 Mar 2021 14:36:08 -0700
Message-Id: <1617140178-8773-34-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
References: <1617140178-8773-1-git-send-email-anthony.yznaga@oracle.com>
Content-Type: text/plain
X-Originating-IP: [148.87.23.8]
X-ClientProxiedBy: BYAPR11CA0099.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::40) To MN2PR10MB3533.namprd10.prod.outlook.com
 (2603:10b6:208:118::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-qasparc-x86-2.us.oracle.com (148.87.23.8) by BYAPR11CA0099.namprd11.prod.outlook.com (2603:10b6:a03:f4::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26 via Frontend Transport; Tue, 30 Mar 2021 21:27:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59b955ca-22b9-4a44-a88e-08d8f3c29bca
X-MS-TrafficTypeDiagnostic: MN2PR10MB3679:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR10MB3679B1D2812EF47502484504EC7D9@MN2PR10MB3679.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nehKIMHqflSPc5GbX/hVXOw3+BWvJNJJQHxQ2sO6zIWi6YKrmwzBEZ3H2FcUNlL7ABnC6v7B+xaU0GpbJw3Bvhohzuls9ekRm9lFi79AvNrfC8GIYdS0Yo726elgDECRYfaJuqP6mreyahxXYye2iM7LVLSDAEdo030RKX/BMEVs0Z7NOSVhCjMU3JBJs/Uv/9W+etpSSev2mkYpkvGACuM3zJxutHAL9ssudUacNEw5SuF+Danh8RU4Fn3NILQxmKH+hz97xBtJh9dnkAlAW/oPHtwPbeLlgRtEH4zxMHxTSQahqlH7AJbd9jI68muxCauKodJxin62SSf8cqDb8P/OVcfe6+7+LnFnol6RK7luu+LXqNJCWAotTB2W+5/532Edm15repOKs7v6W6IettVVdZDrOwhniztJmmh3fwwYBMjoJZtaYn+0dKk82KMZtNmwvzROHDJdh5pSooPK6JY0UndflMGe04rAhU+misgk4pLteXDsOrMaHd9fm0TSBC44viGqsoFRMSR6h/0NQjF7fOo1t6ywaEJsPdcEO9afygZeiOkT7m4BrutgYLJEIJwSJu+DfBaVKL+gQq0RJDkS2w8B/sExiZbNmYHRO+f5SgqNQBikVj1K4kZZRECfsK8uG3YHX5qujFw3vBqD3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3533.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6666004)(4326008)(86362001)(52116002)(186003)(478600001)(36756003)(5660300002)(7416002)(26005)(66946007)(66556008)(7696005)(2616005)(16526019)(8676002)(316002)(2906002)(66476007)(956004)(38100700001)(6486002)(7406005)(8936002)(44832011)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bx2ZzxssyvqZcOPsXQVTmegxiQvA6zoABOf8cd7fOdZxZuKrI0VY79kAaDLw?=
 =?us-ascii?Q?txgU4ELsf7goIEIluaW0Yz1Mmt3gp0iPGBtC8yeKQXy2DtlCJuNO8gYD2kLG?=
 =?us-ascii?Q?pS/6FE0RIyy4NZsOhjfN6Sj5jf6v/3vJNrJB3DHdVfsbBOxtYfmNg6Q87duu?=
 =?us-ascii?Q?pE6EG5Q1ppdpSiBdWbslTnN9Ou5atqyykzJVN/cYIOc+uLdJ0t5G97L/UaAm?=
 =?us-ascii?Q?qUFXWKE8UgdFrI4rSoMB8KZZIxHdrh30Pq63QWjRH1LikGdDYun8Mz77cF81?=
 =?us-ascii?Q?hjVV/z3dyD64R/Wi3zRTV5EOedHwmoPLvixpHAY2v40SqKWJX+Al9VnMod0a?=
 =?us-ascii?Q?VZjVQOY+JFROU3HTmhY3fJUaLrxktdvbOJU7GFOIGgBcPHS8kJUIL7PJ9nmh?=
 =?us-ascii?Q?WjUosVyG5HojTgFQvhIpb/xIyq/Ha10rFhEaLnTsUDdqQjgEi+cEYCgdl6l+?=
 =?us-ascii?Q?pRzQjGNr99+L3Ha/w9/EpAvcQYR3kfA+axRNw3cU+iFiiMeL+7Vas7qJQavd?=
 =?us-ascii?Q?b8PmN8ZH++q2FFShZm9kH8gkQWAXDCYp6LG3/eehVgkIeR4IwLggO1ApNrmM?=
 =?us-ascii?Q?Me4uD1HGS1je/GDl6nkBK3cUNg1oiu61XInwmmhDf62E6HlrALB6olDSqi9y?=
 =?us-ascii?Q?Yij1p6nnS9d5pWSzFKURL2Zfmh/KkqM+q1Y1Gs0X8Hnm8HNa+zWlBnUlwjai?=
 =?us-ascii?Q?Tax3SaZsHqvpIPQ4cRynXZ5bZHdKluEvK6ZVSP7vAv3/BAcWoXWGTHBvH3TX?=
 =?us-ascii?Q?oQGwhaD+8ECr+bJFd3d0QXiPZT/ZkkEmvPMkkFZYKP5KlTBEC14//ySU3+j/?=
 =?us-ascii?Q?7vMHgE176y0Yziw73I6LXDrFAOS97xcVpOPzrrelSjT3mJvBPeGXe/E8CLzj?=
 =?us-ascii?Q?gSWExMf7KSNjoqIAV0VMj6MG1agmG0CBE4u+IOCfXgE8SkWNROAyhC8uoJJj?=
 =?us-ascii?Q?EYH8xON3ZlvQ2lYiF4QobDkUrlMYqq5zZ63oKANN9AugD1IALZYmWXvI+Cyf?=
 =?us-ascii?Q?mfV3/F0XMQxrQfWookm6hpBB6g50IeFavHw3y/WPQrfs7DdCD4Yhh6sUpgQB?=
 =?us-ascii?Q?Siyd6v9Ec1LlKM7oRlBwfJzD6Iwb0uCmM5uy5W94TFWaR3s5aVKvujpVssP/?=
 =?us-ascii?Q?B0NpcXg+9UbpwoF+nl10DEV4RQ+xiSS7aeFp9givMepEohsitJJA0skWjTSY?=
 =?us-ascii?Q?3G83qSs9DizUmog9YAEZhdcTtKSKxCu3xoqEbry4via5jaqefKHpvMTOdjSm?=
 =?us-ascii?Q?C2sh4ZVnvE1IYBMYde70iKn66AXVE9vLpBCa0rHbvPslGI31yVmH28X2egD4?=
 =?us-ascii?Q?ZIKh5UeJpLiMpIRhaUH3fE5E?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b955ca-22b9-4a44-a88e-08d8f3c29bca
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3533.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 21:27:23.7559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eR8Uivv1NrltwMOKHX+QJeYYwqHh7bjDruvpFZqGU3nCkum3VPHNf9ZUEASNnW5JiPbbsw9DTlU3fTxuJCRonX0OYdBbKvBb1Sn2VueEBOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3679
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
X-Proofpoint-ORIG-GUID: lVqEfo8D4jLu3BAYlthptuDqwnbws6vH
X-Proofpoint-GUID: lVqEfo8D4jLu3BAYlthptuDqwnbws6vH
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9939 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103300000
 definitions=main-2103300156
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add and remove pkram_link pages from a pkram_obj atomically to prepare
for multithreading.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 mm/pkram.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/mm/pkram.c b/mm/pkram.c
index 08144c18d425..382ccf6f789f 100644
--- a/mm/pkram.c
+++ b/mm/pkram.c
@@ -535,33 +535,42 @@ static void pkram_truncate(void)
 static void pkram_add_link(struct pkram_link *link, struct pkram_data_stream *pds)
 {
 	__u64 link_pfn = page_to_pfn(virt_to_page(link));
+	__u64 *tail = pds->tail_link_pfnp;
+	__u64 tail_pfn;
 
-	if (!*pds->head_link_pfnp) {
+	do {
+		tail_pfn = *tail;
+	} while (cmpxchg64(tail, tail_pfn, link_pfn) != tail_pfn);
+
+	if (!tail_pfn) {
 		*pds->head_link_pfnp = link_pfn;
-		*pds->tail_link_pfnp = link_pfn;
 	} else {
-		struct pkram_link *tail = pfn_to_kaddr(*pds->tail_link_pfnp);
+		struct pkram_link *prev_tail = pfn_to_kaddr(tail_pfn);
 
-		tail->link_pfn = link_pfn;
-		*pds->tail_link_pfnp = link_pfn;
+		prev_tail->link_pfn = link_pfn;
 	}
 }
 
 static struct pkram_link *pkram_remove_link(struct pkram_data_stream *pds)
 {
-	struct pkram_link *link;
+	__u64 *head = pds->head_link_pfnp;
+	__u64 head_pfn = *head;
 
-	if (!*pds->head_link_pfnp)
-		return NULL;
+	while (head_pfn) {
+		struct pkram_link *link = pfn_to_kaddr(head_pfn);
 
-	link = pfn_to_kaddr(*pds->head_link_pfnp);
-	*pds->head_link_pfnp = link->link_pfn;
-	if (!*pds->head_link_pfnp)
-		*pds->tail_link_pfnp = 0;
-	else
-		link->link_pfn = 0;
+		if (cmpxchg64(head, head_pfn, link->link_pfn) == head_pfn) {
+			if (!*head)
+				*pds->tail_link_pfnp = 0;
+			else
+				link->link_pfn = 0;
+			return link;
+		}
 
-	return link;
+		head_pfn = *head;
+	}
+
+	return NULL;
 }
 
 static struct pkram_link *pkram_new_link(struct pkram_data_stream *pds, gfp_t gfp_mask)
-- 
1.8.3.1

