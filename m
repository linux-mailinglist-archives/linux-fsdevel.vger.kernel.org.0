Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F83646CE27
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 08:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbhLHHPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 02:15:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55748 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240004AbhLHHPq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 02:15:46 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B82mMEe029825;
        Wed, 8 Dec 2021 07:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=41Av1VEVvMOzAH8xswKc0vuVvq6N1mJYJi8r+TuH4DQ=;
 b=OseOHifWiy9rEvLxmiHnfTVbPUr4uHR3BIxIgW4X9TKAb3EUI6XOBPP6ziy5ea9NcPt+
 p7IbuMit9wsDH3l61DY91bTMBwuJllhZqfPfWUUDG5qyTBxEBb2t9+RmCwDHrku1UwtV
 t2tLKnMCFx5JqYupHMRPaRkgZA2zub/LVeHvnbtgl8FyzOLoIRAjZCM3gMdzZ5bPCWY8
 SFOpUCLL0oNwQBi15b9q8xWclLAo2F83KdoOVD2CH4M8N+Zxy/uSLbepvtL2gzvBjQcQ
 DhB3O3fzT+XDQguSogXcpykC7LozblSKRza66WCCe0Q6t4cvNCISAHlTtbIczLn6sUHG JA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3csctwqetr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 07:12:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B875Cad153941;
        Wed, 8 Dec 2021 07:12:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by userp3030.oracle.com with ESMTP id 3cqwf00845-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Dec 2021 07:12:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfuockPoOFWyCJA7PdFZmQj/snG2X3k02aW6UjOC8iCsbdTZU+6i3bwfKMse+0Hp0xVy7yhoOG9IBo0efHsTPytoKxvVJHQUw2eFREx9GcSwocfw+vwj8JnCk3Sbq4558Ar5hKVYzNLv5tHdzCTDyOe5rzLpKvFFrNP3sPaPI7h1HElq7E5Jdir3hwsg/ZncgULyMrscn4sIVF7eX7Me0sQwKqj57dUhp8lbOhdZbAdv2cNWqItg906YKw9W4uOg5sWgxd0DxQmgU4ZPHDrKB4DXd4sISAzdiSIPSqBLPhuf+uhD6AFJif6RGFL+N/9Pi2Gc2hj9J69XL8lshTLh/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=41Av1VEVvMOzAH8xswKc0vuVvq6N1mJYJi8r+TuH4DQ=;
 b=T1FZSdz9KDMv+DsW9LL5PNMJOdSH2u1myuDYcEKwrMZ5L2RfN6orshT3pF8AgsWgr4vu8epqkpN0Ka9id+wFlu9XaqwjfTTXWqAtXz9i1ywnBFyNQS7HECZoNUkWXX823rlUVIoDh1CWHy+2EhuEEJAE3fze50ULvBuFJk+JIWaWIcUDpAtlLc5ANmTZ9S06kbKVPekv/WRNbS9EJXxe+J/zW6xJ2et7rgeE9MmymO4vwSnfeg+DrJRnb8vo4baOblfuW8RtXPkGfWmbBrl3E7pBuLrduY6k0Qt23o8zrl1JW00nJ+FxOQL5PiTpi+m4jevOHcL9XEh6i3hwL4M2lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=41Av1VEVvMOzAH8xswKc0vuVvq6N1mJYJi8r+TuH4DQ=;
 b=abrbWwj0gynhfuEkGztG6w5WqbEpg/hpnGqN/7fuHDc5d8YFH4BTCfDqRVuTMPQ3UQJhy1dDGY2sIhUPo1Hyu9KVH263HvKaVPBVOPchhQP1qDulemMwOykvEAdx72Ht5I6SM+sL6Wni6IylF+3v8dYy6Ik3TCed/fD5WtAWxj8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5410.namprd10.prod.outlook.com
 (2603:10b6:303:13d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Wed, 8 Dec
 2021 07:12:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.023; Wed, 8 Dec 2021
 07:12:08 +0000
Date:   Wed, 8 Dec 2021 10:11:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     hch@lst.de
Cc:     linux-fsdevel@vger.kernel.org
Subject: [bug report] fsdax: decouple zeroing from the iomap buffered I/O code
Message-ID: <20211208071158.GA21674@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LO4P123CA0448.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (2a02:6900:8208:1848::11d1) by LO4P123CA0448.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:1a9::21) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 8 Dec 2021 07:12:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e160f07c-9514-4e66-d815-08d9ba1a0bf6
X-MS-TrafficTypeDiagnostic: CO6PR10MB5410:EE_
X-Microsoft-Antispam-PRVS: <CO6PR10MB5410287D572688A5F5B1B34B8E6F9@CO6PR10MB5410.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lv9lMDpLvztFXlWrQq2Gm0sYV0rZjRB2aAySAx+vCJIobU2IAalnokJrXLgos4LLXg+dBZyx0JsFbyZcdFpOxrAGyLUn+tRYj7Lujx3mBQq+gu4T1iRKUpBzcyiYqdmZV0wIt0Jd7nCHQbu2JaZuc1bR8ihJII+D22IpVPdssPB1rWmsl+Ivm7OhfNEmXrtuKL9rjUNu5nB3sQ4aOaB0yxmOOGGcwBWTiZWH/Y/1sVKURnLy9bHrLjdA+Po64+Ks1KiYadT+27wZEplzfhd+x+Q/747ZhQRkVzbdqMNV6ZHV/1dI7DL5dXwhnySaoUadeL7+UL9JCLDwguo9LXQVXs0i86srWLQdJhbmztT5CFrMyg3L9LkDRph6+FJuWC1mBzUbHc4bLH54gUxZW5YRV2N2FFSWuq+1z/1gK4L614alrE7saJNJg6VI3uhro5B4efC5hXa57+E4lcCL3GFVZJS27m969DKLmRr+wE1R3D8MCjfJ2osXhN2FOTxIdBbpQ5U3ZyRUpQsNxfQTx9kf4tFqS+SadXRX+EkCSqWQ4RpP5O8S/vo8pSRD7RJinO6ZSfK/KmUMNdwX3rP6Ql4xp+vXCdxPIZfxQS5MEObp4u6rzXmlFvDl26V/IhAxHdEF7djMIB1BHpI016r7hv2/3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(38100700002)(508600001)(52116002)(6496006)(33656002)(5660300002)(6666004)(2906002)(186003)(83380400001)(1076003)(86362001)(66946007)(44832011)(9576002)(6916009)(55016003)(33716001)(66476007)(8676002)(8936002)(9686003)(4326008)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ClpAvV2Zam2R6QlhEdVLWmlQE5wOSsTY0gcj+bqPhJX+S6TqrcFC8AFqR0zf?=
 =?us-ascii?Q?Mo68Y/h0bKkX6G9dSU0vAS89HjobCne5fh2baSv8ngspu+DWr3QqTpl/HfQA?=
 =?us-ascii?Q?Vc+yyyeqxxO8HRNPHepa7QnYJ940dycj9Xj3NriWPcd/vvipvf+YuNurS9DE?=
 =?us-ascii?Q?4wIsh0NIbgNkLkX2nFWk0y78YW7vAcayp0BJ+J7uUlspZhjl0xvi17TZbSHt?=
 =?us-ascii?Q?2gzsgFarxrLTGdayWl3xAzUU/PjCRQbrKwUXX9jgTPrtG40JQhYXtWnmz2Pd?=
 =?us-ascii?Q?cMcaaOF4mHx8S8166pPd6NXAu7+QxpgYKRbOXTe0MH/ECpi5q0JNVMrHXVh6?=
 =?us-ascii?Q?3sn/NXlJZK5Gm1bFKgJO4A98aBOPNtGFOrdp0Zi9/F32A8b+OR7B95NDhy06?=
 =?us-ascii?Q?3GaxLgL5rFmJSjyRaO3kKvyKh05lRSZNX/kIcF+iaE2uGz0y6r3+9bmNyt06?=
 =?us-ascii?Q?h9vCuegPylI8NmVqM0O7Q4p2+hQRn1neCFlwRFB0/C/Sn+/wc47BlzNzPzdY?=
 =?us-ascii?Q?sTS/8bFPRqQnJWoavr3ohpGrzEItegOnQYRPOmnETKxsexJn36EwM/JHbKl1?=
 =?us-ascii?Q?DodtVtZHCzdDen9fvUpoxZwxe5LLVad3OuznzfyIZ1ga1Ze+PKviIhEZbv3V?=
 =?us-ascii?Q?Bn+6bGpRuX0FMdnig7mbgoeAQ/dLrU7qwG8FSJKdVsYk0n/7MlvfDO/EBmly?=
 =?us-ascii?Q?7UTSVHSPg0ojJH9/g3nIymfuXw00s2mU3gHhPCLPnsaAbYLK8/Ui74RviTXL?=
 =?us-ascii?Q?HowyvZegUqRtnN5zZ+3eAdBuBWPqnwpjgE9MD1XGYl15OI5UFWv2eXaRjC/d?=
 =?us-ascii?Q?lbK0OgM+8cfFBDH1HEm+LGLV8OMyMbbnf+eW1AoQPQs/5ffxNh7lHj6YXSsY?=
 =?us-ascii?Q?1+ymsEeh9/rIFiSvA46DOUbrO86vv+QlyQlBPe8/bWwiHko5AgmUr8TWL94Z?=
 =?us-ascii?Q?wptiXxnKDaS6np1GT0lrKBnb5HX+LBjUOQKY+08E76fHMt1Y/NIZ6LkwA5kl?=
 =?us-ascii?Q?CPZzw5x6KnT09VeixCTkq6QqvxM+tKhMBZmGsXNF/ODpXOAAhdXllFIFmyPh?=
 =?us-ascii?Q?GgfwYJyCTZOacu/rqEd/rKmnfXVoIXFqt6IIiPX0+i3SmZelObV96yv8ozV9?=
 =?us-ascii?Q?7NU74jYFsxyD7e5OERnIgWzB/mLeObWJVsKHSDlpzOZw7g2r8JoVcXIRDRiD?=
 =?us-ascii?Q?sCmcNeNby0TTUavbNcw45LpvXO3K3CItzgnRbUU+5zhD/5Iu92YnciNngf+c?=
 =?us-ascii?Q?W2vpKumrCWJiUPGS0AeF71BWTkTZdhd/AKj8pczH79uB//hfQ23IUljVDrlI?=
 =?us-ascii?Q?ivxM9UMDcLi4jbBIrtoErlp01U0BQzzRvIUg29oWZbkFgl2GnZpqAW6wLCJv?=
 =?us-ascii?Q?TbqC9JY6kSHa8MKa0Bsdh5TCOW9NuJGyTLH1RoswZnAnkQWhnwKLt3vDZsEQ?=
 =?us-ascii?Q?rRMHZ12Dm42ysXmoVG4uJbBHswP4NkXMHZNSZe3IpBJhXBn9pZU1yzSbquiq?=
 =?us-ascii?Q?yOGdxEV/B2OHFm0+JvGL5Utnhc2pmu9vIH0XzgDfi9WPKjA1IVRItserJZXp?=
 =?us-ascii?Q?KveGZhOoyr6KcKOQh2cIIo7qWT7oKMiLSU2+3lac5w2bN2J2RBJx0m3STvi9?=
 =?us-ascii?Q?+B7BU00LqDTaPKy1aFRNbkvzqf1WfK/SmEwVlPAp1BuGGATzht3ZltVlHomu?=
 =?us-ascii?Q?INANtLJ1phcMY76wmFSVjLgXWozSKcImB2U/u3w9pmRotw7r?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e160f07c-9514-4e66-d815-08d9ba1a0bf6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 07:12:08.3427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q947NL5P+OfNg5G3UvmLgIb0YFybLWU9+XFsvM24EHgh9q4U+Enhxx+R89ZjajdMBFycorj4LXYnr5Hoy/jtOM0pPvZS++6WWWRefd1og7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5410
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10191 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=813 bulkscore=0 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080048
X-Proofpoint-ORIG-GUID: _HzdCKBd0JOTYiCfr3qByXvCm418j54U
X-Proofpoint-GUID: _HzdCKBd0JOTYiCfr3qByXvCm418j54U
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Christoph Hellwig,

The patch c6f40468657d: "fsdax: decouple zeroing from the iomap
buffered I/O code" from Nov 29, 2021, leads to the following Smatch
static checker warning:

	fs/iomap/buffered-io.c:904 iomap_zero_iter()
	warn: unsigned 'bytes' is never less than zero.

fs/iomap/buffered-io.c
    879 static loff_t iomap_zero_iter(struct iomap_iter *iter, bool *did_zero)
    880 {
    881         const struct iomap *srcmap = iomap_iter_srcmap(iter);
    882         loff_t pos = iter->pos;
    883         loff_t length = iomap_length(iter);
    884         loff_t written = 0;
    885 
    886         /* already zeroed?  we're done. */
    887         if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
    888                 return length;
    889 
    890         do {
    891                 unsigned offset = offset_in_page(pos);
    892                 size_t bytes = min_t(u64, PAGE_SIZE - offset, length);
    893                 struct page *page;
    894                 int status;
    895 
    896                 status = iomap_write_begin(iter, pos, bytes, &page);
    897                 if (status)
    898                         return status;
    899 
    900                 zero_user(page, offset, bytes);
    901                 mark_page_accessed(page);
    902 
    903                 bytes = iomap_write_end(iter, pos, bytes, bytes, page);
--> 904                 if (bytes < 0)

bytes is unsigned and iomap_write_end() doesn't return negatives.

    905                         return bytes;
    906 
    907                 pos += bytes;
    908                 length -= bytes;
    909                 written += bytes;
    910                 if (did_zero)
    911                         *did_zero = true;
    912         } while (length > 0);
    913 
    914         return written;
    915 }

regards,
dan carpenter
