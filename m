Return-Path: <linux-fsdevel+bounces-8709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B4583A83D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83011C21B6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECCE55E5D;
	Wed, 24 Jan 2024 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k/WtarCr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uNL8BBn6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830C25101B;
	Wed, 24 Jan 2024 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096387; cv=fail; b=CUTU3pzttcyK+MJ3r/A+FaOw2Jee/Ao2DINv36CMFjoRro7OkFw0C6Tufvdu6qLYWE9xBVoidvzCubMgu0VEU/T5w2X8RHhQCKhTX7ci9jUtEBeAmtypD3C0UyEbMcUpFd1iUsDvDMgDV6SdjBPGjkWtI3jn8VGDVcmusX3C5j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096387; c=relaxed/simple;
	bh=QfIhboe7x1cSnq7qtz+SSZun10xPRPYrDu27KIXSn1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lH5T6Jv+m5u5B0ftt3HeF+gW1KU3q/ru7Aq6HvY5LT9ggL+8eNSYwupQjuviEBr5E2yUc5U2mt4soN5lQHpIYkdc2rhGnclls0uTN9OHnf83KsEJq8rTxeEHXyj+9o/74HcGS8Sau666gykuH4tn2xHcHhrLOfok000vmFeGJuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k/WtarCr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uNL8BBn6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAxSHE019705;
	Wed, 24 Jan 2024 11:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=zrHflAgnjCJ3UbOqx2iGBxb3ow3LN9p3DKYbo/b7M5c=;
 b=k/WtarCramFlCVUHAgUhK9Z5H/asz9PvsO6rrgBvkan0qRr1UaAgAZZvOys+FBGXv+wY
 mvAlVEAmIGExXh5vFlil86J2QkPo7ykwLAhZdSrfXc8lGAlZ4GJ2JltvdAtIfmh/5Y4W
 5OJEEgUdteIGkOkwgBRe1Dl7+0S+yCbFuycANrcbjscbsSG3s89MiuCJAJCNMYfMuVOP
 TUjhjLfsfQMgQ8KtH8r2c4tAMzX44VwTfIZP4FRBfqtLDYoi/tpjkRXZGG5licqAr7r0
 GK41RhaA+ssvqbUZOHedhSJMBmB2Ryf4Owucw65RCiyuceUt6ijVUUvDe0xqg9DiSTjP uQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7ansx8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBSk76006248;
	Wed, 24 Jan 2024 11:39:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32set4q-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQJO4OjMLDBqhHEqWtRRBo6wetCECQ0wl0c0tyLeX3+b7yJUtftCaz5xXCJZRa8dC833VcUrcA+3Kqck+dF+h2wTcRr66+RWzbFsnq8OuNAXX1F+n2apneAijrvgeSZZXtoRDJ+yrCeBeiqhBHr3NLb7RIQ1ztX/78zp+JwdkQvwp9SBoq7rwLQsPfyL7l3nNkEIM7SJYzeSrD8GaXfF2ZowqL9LqtbgI3s6bH1XawIEbtJGoRJECDTSdFYzDvRDx9ws0+zCQ1jjk+Gk65ZnMWNqId9qK5YXMNHvqLhR9iCtA+tOan1qGQB28oEnR05p8KcIYyWqFNf8E0AILmvtbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrHflAgnjCJ3UbOqx2iGBxb3ow3LN9p3DKYbo/b7M5c=;
 b=GwEfz5OYd6gC6a2p9ZiFSshFt5V9ZIcMu4e79hUub+UttQpP/YVsrCWrU6IR/LEN8NqaX7lVdRanuyWBBeaAByFRXsQl7O6E9EA6t0GquIwoDjc4YZji1i6toa25SJhhH6sO56/+ef0naWmaZzAkJ3n17XXon9ssH5f51Y9ZrXXmuyEhBESnMpb+k7MVOULiBGshCf7d4BElsvrNgHLDCPUusppZlA8YcmjipuDrqDKk0oT0EY/VZFQ8LN7v8e/LB2tJZLyh1snWu3O9zjaf5ycxGMeRmpu9TU2qLlatcSKe71PgIizpqzqScXdHe7SO18FkkgPeQ/4bnBiF2ccwpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrHflAgnjCJ3UbOqx2iGBxb3ow3LN9p3DKYbo/b7M5c=;
 b=uNL8BBn6JCPjo52yCzmL4sfym5qzzrkbXRIWduCyG73lAYelKjXf732jOqz6yEqe5P/eQh+a/Wkxg1Y/OlQW8B2gQVcEPK1IYqZv5ArEUeuZPFQKuv5UF1u9UKQ9A+bl3FpQ7Qlu0eTaKkm/O8Y03mNTMfFcWt/GbjJJYh84Gh4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB7041.namprd10.prod.outlook.com (2603:10b6:806:320::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:39:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:39:14 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org, Himanshu Madhani <himanshu.madhani@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 05/15] block: Add REQ_ATOMIC flag
Date: Wed, 24 Jan 2024 11:38:31 +0000
Message-Id: <20240124113841.31824-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124113841.31824-1-john.g.garry@oracle.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0173.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d578f05-0c8e-42f1-7571-08dc1cd11718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	f8ylSI7NTcdB+uKtRrd/+mFeQdS4pIF1d0naF/c/xjc2oJlVBwS2VzJLCdkaLlSzq+GC1jufKwVwe2BWaA83iJow+WN0tM0mwlqAUP4Zp38rB5XB379GNeMqWmzhBCTFfuHzw1MyUf9wa63M81QLGRElSY8s7hA+IFQSbXhHTH7mUp7EIN6q6kwuQ0gnYv7sN0iB1XxemDcxgTNq9GarkfyfMdKhatjZ+4zPekTuiF5pQ56mLLFjkIY/opFleHOIQDAHRyRdR8uDcOhArx3otrTcM1Fm9UlH1XceHPhHRc2mYgsEEZwdnRj2gTfaRmDzyFjucUqHm7/Y+SPcNt7NotuW/lfNr68gUcJdbxme4hZnEMvvfv3DCoT7ufP9fKjByH74fXYsD6VvCRLLW6Pez4smGn3z713UXc2WaPCBJtC7tjKsGus1mrOZLB7bfQpw0iHyIF0w4eLRiMx5fRj9CvfRiwZWEei0thTix1QmGu64Vb8gKqbAKuC7F8kZw6+wV1HFELiQsc2u41U1/VCM5R1/JUbjzVQKJJhafD4BUgyeeemGT6/Vg4ElGx8yBmeZNm7AchkTRI/lKRK3ez1yfT0NCTl6wstpJ0oPuqQKXrU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(8676002)(8936002)(66946007)(66556008)(316002)(54906003)(66476007)(921011)(2906002)(103116003)(36756003)(5660300002)(41300700001)(86362001)(7416002)(38100700002)(6506007)(6512007)(6666004)(83380400001)(26005)(478600001)(6486002)(2616005)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Kndn0X0xmRSskrXQ8GLNH7ZbUzxXIhfrCYN3jNg4Qle9rmrxFobU+VJfInYS?=
 =?us-ascii?Q?ovGSaTQpB/AImY2dhszAjfVdo25YxYBS37FR4HmqhBKhI/xLzxOGEfsl7iz+?=
 =?us-ascii?Q?69hzptA/7PPaGDSfxq/G9e1IsU6e+0n4cdbLkLDAPbvfNgisHRU76Z7y2ccW?=
 =?us-ascii?Q?iTZsnJ5QmkdcBqLP6xu7FQbd4VX9aTuslBFJD7MUZj2Wr9fpx3szjM400r4y?=
 =?us-ascii?Q?xxbhPFNfAaEm/rqlYsLqls5WrwIhDJcpaKLDuk43HT47DBdfphCZL7jTOZtl?=
 =?us-ascii?Q?GiExGhdUYSLdvKblhOVMKkVRkGOF7QIpsW75cVDaLVbaI43LSqYwFUaKoL6P?=
 =?us-ascii?Q?rAWWBbbZzm/uNhgLk3HptmrfC3EP6k9GnDP5KAunASDw+/Il0UzAdIr1++B6?=
 =?us-ascii?Q?bDYtuqIlEWqKfluSZrPRh7bJZ7k2YMoMH3E/V0InMiruysktMbNHgg9WYI5d?=
 =?us-ascii?Q?PcEIuNevPQ1lfc2in72+fZV8iNsgS2WN4BKRpnJWIbDLhchXfuhctTJHdytV?=
 =?us-ascii?Q?Jog9poIhjcItZ70qTj5wtTLuvYTJUc1cMex1mMOfBVlpPhPe/Ee2OkDcoSL2?=
 =?us-ascii?Q?qTddufB0/H2a6CT8z60WoNn0D0ZV3o9GXx84P7GJSBMjO8n3R66+jgPfnt5d?=
 =?us-ascii?Q?OeCgTRqzSZc9TOu0oOEUz7ytCJ0ihQn9lBdGtI2/OS0fQbN+xUxTOBh4LwDE?=
 =?us-ascii?Q?yiX6uDw/o6FbcJqUsW04TJqszdRz3IisMcKPJH1s/FJhkavS7x+yqtebpN/E?=
 =?us-ascii?Q?vQ2iT1F/BGDjOMBLwLHShdWsMpmyB0epFCihuMdvcPh4HpTb+OLqNaqgPAU8?=
 =?us-ascii?Q?xDJVsRRx1BASLWepQuR7PMYKoqyUE+QjjXv1u9sffaKAd27aeWI32JTWj/iR?=
 =?us-ascii?Q?/n8jXPkOihn77YBfwrvopqnRCuAuNB8PAJlfgpkextCy6Uu1icXSulQHLZHd?=
 =?us-ascii?Q?AcAIewDRA/2Jfm7bGYMRAUsXaCZguoAbk9I4RBPscIMXt95k9y10bvaWp+QZ?=
 =?us-ascii?Q?9URqLU6XPTFFmIuBxY1Vwng2e4Z0lRryBRcJeGGzfTMrWmxRjTTSnPh7Tp3w?=
 =?us-ascii?Q?zch6V1cVg+XNwWwwl5ZKbU4ytlGZ/7frhZTMla56qnqxBglIEPTp7It93mOZ?=
 =?us-ascii?Q?qCZYUCkKLVsq27HaCDCVNAJ2xk8GE2NxtFqVPmWJhhUx7Y0Asy1hpMV4JO86?=
 =?us-ascii?Q?524ftUgHZ7FoSc0tLFRsE2L7Ca1AGQo9S945ZdqBOnPoJCSOvwhz2bIwUksq?=
 =?us-ascii?Q?D6SYWNxZu9Nl5+D/ifb/lK9dIr6TwecRUUyvQ2VkI6nhPvOdwyTFIgRuPxZS?=
 =?us-ascii?Q?qVIa43mGokHzz+Ia3Mz9JOAxRzlViVxSy2kKJXTbKcwg1Zsb6RCA7TzKhXyK?=
 =?us-ascii?Q?Vl8WyWGKrdGfjV7EVpS4XMrnkOXYvFbJIjyd8xActNRXmMmhqignHOKAp1tT?=
 =?us-ascii?Q?VtCPwqzGsrIWQVLH058Cd0tZJawSy7To/fLgNplGJb987m2Za1e8oURsogqR?=
 =?us-ascii?Q?ZGN83NZZDp263gH82yN6et+KZ47Nc+iF04cKAe/ugsK/9tuXEkdn37y2ygo3?=
 =?us-ascii?Q?iYgDFZrRF5DanaGranRsPR9tvvw9Hp2pxGQ+06HQ0Bc4rWgfiME4NlDA1ntI?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JBO7I/3utf67B+Klpe5GGA2FM9DTvCVyPUoG6bF4rttCODOaQjI2KvW3w537HcCHZLVbavWuBDERJnBV4Iv7ucIlDmWYKe2jdyhIJ1XqAyGa8wL5O3n21S7qsghl6IhjCsMgoT7wFziMCoU00eymhLIR7+wGwZOUqdV4YFutnTHpeZ2YTNJHKP3SIqP/l2aTi7YLPaRGDxfPLoF+Ba77a+I4i7XIJvObQkBkhObb/rIaQz3JpwpmTdIwXa+8FuDM+HCu6OYEEd6MjEXznadBziV3UF0LKe+cgg4HKcoqYbR8+WD3bp7HhSpxdO/nU20/Jg+PwwMq/hHc20cfnSnOqIuCfxm06hPWLCw0Im4tsLrsVqJ3BFMTSNPXGwPIthIivjlHKxXGGsHgzvOTfbtMGjuNqcgmlNdPB04d8bI8AhYhgJ20YyUPsoeykcFfJI56ljr8i0lnGT5KnZP9983Zwr67rrI4DtZRTK0R2f1PXkFhA2eosgn32NyhSKMx4VwCY1IAJUqRgsV/p1YPBWHqHEpdWoK79p+RHTgxmERlh8CNrgTRBu/Zr6qYOfufDCgRg9Y0Sv8MU8l2zdHsq7XPZkY7ACDkK0ISEDQdRuQiVb8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d578f05-0c8e-42f1-7571-08dc1cd11718
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:39:14.1789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kR3vEeieakBI8BM+t/f+eU4+pV7Ykaf4ghnu885ML6pj84+4namsLHrphq6fRa2sdgjpU8yZDYxWkYUtbXzBVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401240083
X-Proofpoint-GUID: Y7Ciy7Y9iD-vjjPBU6PKwJ-prDW2tbyT
X-Proofpoint-ORIG-GUID: Y7Ciy7Y9iD-vjjPBU6PKwJ-prDW2tbyT

From: Himanshu Madhani <himanshu.madhani@oracle.com>

Add flag REQ_ATOMIC, meaning an atomic operation. This should only be
used in conjunction with REQ_OP_WRITE.

We will not add a special "request atomic write" operation, as to try to
avoid maintenance effort for an operation which is almost the same as
REQ_OP_WRITE.

Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/blk_types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index f288c94374b3..cd7cceb8565d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -422,6 +422,7 @@ enum req_flag_bits {
 	__REQ_DRV,		/* for driver use */
 	__REQ_FS_PRIVATE,	/* for file system (submitter) use */
 
+	__REQ_ATOMIC,		/* for atomic write operations */
 	/*
 	 * Command specific flags, keep last:
 	 */
@@ -448,6 +449,7 @@ enum req_flag_bits {
 #define REQ_RAHEAD	(__force blk_opf_t)(1ULL << __REQ_RAHEAD)
 #define REQ_BACKGROUND	(__force blk_opf_t)(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT	(__force blk_opf_t)(1ULL << __REQ_NOWAIT)
+#define REQ_ATOMIC	(__force blk_opf_t)(1ULL << __REQ_ATOMIC)
 #define REQ_POLLED	(__force blk_opf_t)(1ULL << __REQ_POLLED)
 #define REQ_ALLOC_CACHE	(__force blk_opf_t)(1ULL << __REQ_ALLOC_CACHE)
 #define REQ_SWAP	(__force blk_opf_t)(1ULL << __REQ_SWAP)
-- 
2.31.1


