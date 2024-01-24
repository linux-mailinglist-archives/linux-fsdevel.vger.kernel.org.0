Return-Path: <linux-fsdevel+bounces-8702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 675AA83A81C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 12:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C08FBB24C49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 11:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C292C697;
	Wed, 24 Jan 2024 11:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S1LvDIWw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YwvK8uN8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1762BAF6;
	Wed, 24 Jan 2024 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096378; cv=fail; b=fI/z0bdSlYcFGy+y2T5j9a9mGNKRNC7XKTivojqELmevtOz9ihysPjs/c4dzT9QwcZILNLqukHayeOK3ExV9gv8yyTIqrGWGZ3RX0sFXCGXDaIu0OFm+Wso/Ad9xWzXGqe5kT0z5w7i6IF1znXsLCthgxyutRf1sQwPUiO6GHL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096378; c=relaxed/simple;
	bh=XNJfSX85fdmd2YsQQVatnuBVAzd7ZexIHNZEllkOQXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ezf1wHWjaDp4YgX/TNTXsE3YkiaGC6hfZvN8agGLfcKqAuXx7qzMCEfQaxeS5HmlH3yYjZSDIOVxE2anqBGTXUHht7It3IZhs74697elsqha5MX9+v4oPVOV0ufY7ZZDY76g+Rpc0y+avgsLJLbi09XJtG+Re9Ov6rahTMGOZOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S1LvDIWw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YwvK8uN8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40OAwsNs009429;
	Wed, 24 Jan 2024 11:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=Qh/T1MFYYUkLwR5mFFWEjx15hZf9sYn1Kr7j+s9Ho6A=;
 b=S1LvDIWwvA2vzQD24LnRqqWLZsb7+BZaULHiBTpCDP7oFOkdiG4BsCDZOns0jZcRXwB2
 m814/mdSxy0ifqKxPPKrEsf3EvvH7//+mZNjQ2DQSG01BlvDEbSldaBZK/NFs8O8ctz4
 OuIoUExPEIO9PgKUHkMy/F+rcpJMxr2Opn12GWL/XErD+Ldv9ZOhdGrSkR+TKXZ+ipLS
 x5qz0SBKRIBoHxZpYyCDwfxjmu18knk0LioX14brN56yM35nHvjJzERd/WjODVmQUjXA
 q2jmZCogNEHct1Sg6xYwT73ZARDqU+hp3VJLup8PJAnPePz0jrpSmvTRxqvYNeZkAKFF 9A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cy1tw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40OBZPMd015042;
	Wed, 24 Jan 2024 11:39:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vs33un2su-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jan 2024 11:39:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MygGfNm1ILIyJCJyBjhinuT7SAJMsP/zOeOoNR5Y3eld8gfDhdwbbICYpH+FY8lzblNmjg3PeLsXnPE8/LIL7N3VFg1R645nU4gmlPCrMFdO7AwVCVHoCpD7osfhA/h5W1wvvwqXZejKYuhmNp4CUCiEu+FBIQEfJxYw+RvOPP3GJrS4LcTCVEZcfrR4t/VNELWW4bhpor0ntjWYSX3IGGzRZAk/UwPmL1B/dWQVVgitrsC+zyqW/0oeBQo6QbltTalzP3PNH/oSjAG2wNrHiCk7gm9TF4XwkhefJ4ya7JK8dn6wAYYhvVAA4e7GevhRIfIkjHtYvY8nsjprJo3zMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qh/T1MFYYUkLwR5mFFWEjx15hZf9sYn1Kr7j+s9Ho6A=;
 b=kOTb+2ye+l9obkjhN20OQ0RG8UUqkIx01QfwbCF0o26+NatujmB2O/hutN5yWFIo2ErvS//rOmbf2B6DALWH+CPUnzjRvct+t+6XnG2Ikwfl/duzcrYv8b9PoHtlWVyhtp0dB7jzNbVwppyQ+GxYXfuRPPFVy7gFqbo4QG3VYX9/drbnvRI2StN3l3Z7Df8qtR9fLgtaLTAFd5meRl5Bmtx185bIiGGnZ6BU+Ad+cicvbNesl2cY551X/YHwXIsZmyK8/PkSwXCMst4Kqth6dehi7/V5ysNSAtsiEcfkqEvIhke7bV0JxG0I2wzx+MsVVJgfEgW6FAI3KFwaLaRecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qh/T1MFYYUkLwR5mFFWEjx15hZf9sYn1Kr7j+s9Ho6A=;
 b=YwvK8uN8VDeyKR6B673nHYdYiVX3NjPxrxe2RR0SsqPwssu1gl9IXVYFEx+R5Bry9/kqrdqy3ClG8A/0bWrFhNm+4QqopbAghfQIH8k3TeElO47DOfmwbr/pbogctN7zQMgd+qcCt/+ZO8My4HDDinuyMGTcBQ0QV5iBUTqIoW8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA3PR10MB7041.namprd10.prod.outlook.com (2603:10b6:806:320::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 11:39:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 11:39:16 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 07/15] block: Limit atomic write IO size according to atomic_write_max_sectors
Date: Wed, 24 Jan 2024 11:38:33 +0000
Message-Id: <20240124113841.31824-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240124113841.31824-1-john.g.garry@oracle.com>
References: <20240124113841.31824-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0012.namprd17.prod.outlook.com
 (2603:10b6:208:15e::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA3PR10MB7041:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ecb720a-414c-4eea-32d6-08dc1cd1185a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qBa+bjSqn6QL/TGg5n74e4TM4F/6QotEf4HPIBcMSW9Hdh7uKApTLo9xzgJevnB79QDoTMYNUlJD0tEqTYpK6ep1dx8EvHUMxP6VjCM3JZoVfsklRupBtNZkmX6HBA9fsqBu0jHfhID9rqCjWNDkpOzoTVFXwcALU6ny1XG4adre/IbvZj0APA43aR8Fc9AmSOj/jQa94vE65PrrcTEP0VHb7Df9czT49GPgiuTdwY6EoCD0DtR3aRbkrICyYSAIo6LRXO1mMZElTH138h/QtZ0PKenrfQJztcVlAdudqGlbvCjPkenxo54ifVz9XSHbova80XqUwFR2GoAdRkT1mBD+M2kDSEr2oD/n9+UrZzkKR1OaBZHCI1l3aGPXoAVPdoLJZSWZsHkqDcD1KljAjAK/5P67o5zbF/3RnoL0Sz9fvuhgaXUy0h/4ZmW/KWo1bdmVGBDiaTzd4YKaGON1HkHwDWqzXWHXlxJRAZIapAK62P5s1ZCm78WNaeMsoaaL8StrI8ww9Ne0p+hjV6KmPzHC7ON2NoIQ6P+DJKCYFlotvslZ2Wvlk1R+SZC2U+fZ+e4zBsArOYHmq5UnubN11mJR3ekoT4Ek5i3sG0zOQFg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(8676002)(8936002)(66946007)(66556008)(316002)(66476007)(921011)(2906002)(103116003)(36756003)(5660300002)(41300700001)(86362001)(7416002)(38100700002)(6506007)(6512007)(6666004)(83380400001)(26005)(478600001)(6486002)(2616005)(107886003)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qBG4G761nKkuu250+h8+6YZKN0yOI4RhhO4t/qcnaQZaqyBQsUwfzJx2DJHd?=
 =?us-ascii?Q?o6YHFxGDH0fWLfojYQY2cxPXaslXm13pTCj3Q1I3vdFYTeoA+lQ0EP4LTLiZ?=
 =?us-ascii?Q?SMuWj8c8nK/Rk9T3ZaEvrAgE7UMbABAM79LqhMI25D2WOxdK5ZA9jtFx7hWU?=
 =?us-ascii?Q?0V6k3luh14gOfVr/cJ0QjWnIhtwqnOJED5iYn0x1P5CXpVAIHBZdsuUq+LEe?=
 =?us-ascii?Q?AKw8DMAb2xipcdEhNiyDiOPdUYGihkzyTUHV9c3wOkLKB81slVjSgF4duYL7?=
 =?us-ascii?Q?0wZWRKHECd4hiP7qA/QM8uy+cTzUky2thUTMwB+51KPNF8ems6Q1pZv4fDn+?=
 =?us-ascii?Q?UlV5QzFgvSgWHf51Jv/bPgrBP4AXnEYLAjzFbIEpy9ioQ0FAKiiEdGux6PCO?=
 =?us-ascii?Q?+p8Fs160/ab63FmsOWBIO+M9hlu20VecXgiqgFaq/IoWBnx/SviUKZt1bXsj?=
 =?us-ascii?Q?JuE0vysNrwmJZpgDixlw93JBju7NjDjKS9gmwUz5XMx9gQ1xANCHfMouOhcT?=
 =?us-ascii?Q?TRIKf7Mab4JhXHp7wVnis0CeyPcxoca2KIQXmXsXUpcPlfJfQ/VLA9nCqVLj?=
 =?us-ascii?Q?kgPI42qRptUdBbeeT6BouemZFrtbdCAfcOKRNHnUMLAtNtmn7lyg7dMocYqX?=
 =?us-ascii?Q?AmJl/rV9sIXr4AIag5MSmVSfSvAqC2Zx17FV9ZVlr7rEzRaByfliA5ZSspLp?=
 =?us-ascii?Q?JiFYZaW/r2JwLkPV3Mc7hYwpxNf0YwPEbLinWibHgeRXvWo2vZvq1A7EKw/Z?=
 =?us-ascii?Q?1yHjl6LHgdH7FBPLPjil7EOh+KaAOn4dhG3752nzNRuC4wPBla/WCsTNUcyo?=
 =?us-ascii?Q?lESlm3V1lEFX5d0YK6wUrU9Hb3jyVtoxNNQU5lsdTzs2RLyUfW+av0fBA5k8?=
 =?us-ascii?Q?VSh9lRZZcMRUoqNJLe8heVQzelVEl8KVNx74DrxRPqLWw9/vtx3es5yC1ud9?=
 =?us-ascii?Q?MPb26ISMIqd/2yav/sKz480Pouxyhg2EI1DfhS/DIKhFGulX53ylxZK6ljX+?=
 =?us-ascii?Q?2rqzZQHavb9dCwE51BpKr8fzPVfzdRerorMiMftSzmPLo+lplwgfwlt5X3zp?=
 =?us-ascii?Q?xg9k7IrOk/BqYFJR1Z6xtDSvL259ewtI263OJPQSPtVBLwfjCYgGWPnBHn+d?=
 =?us-ascii?Q?jpCFXf8ViotTTBu7ukcm+6fG5J1dUX3ntNUgG+BjImd8Dmcky+YRk/OsSgSa?=
 =?us-ascii?Q?onktH21EKvYLqmEA8gXk1SV11DwzUGF97oYCw0at07QksCVvRfyAV7yYRQxV?=
 =?us-ascii?Q?RB14TiRr86k7HDex0gi7pubxlnLjSQIzqfFxEKgYZj4+0jNgJeBn5MOouC6+?=
 =?us-ascii?Q?anYjKwXrSkj4vQE7M4lQY2xHw/oqOjJrJOkoSRNv80F0+OskqZRw1Z6ZziOv?=
 =?us-ascii?Q?Wdd5rZFF10fXlWMwXsDDWpVKQcz+VgBf+B2k5HbCWMTMpytoY9Fnsj55pNrY?=
 =?us-ascii?Q?Tn15036hBZ5Zb+NX0IRGRDZZLu1gSmtPrujidIq27XLxyCNIoCB5OmTFkRMm?=
 =?us-ascii?Q?Nt1Bdpc0zgHN/Ad8UI3RgOfNppYBUkqkaY329MvJFqMPp9nK30BU0M9L9nKj?=
 =?us-ascii?Q?YD7h7kSXDytRJTPDKMkN7TuE9G0LwoZvYOqdkZ3hrkxxk3aO3yd6xZlQG8fi?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/p3jgv6XJrzMroCzzl5I8OM9wBx0vDjPeCw972aLH28J5Dqmil0l1ncsN2v+M8J2JjtadzkDdky5VZYk75Qe8hHRIdcOd9yM6jxSEkHBT2gVnUfz+LQ2EpODtRoGfm7EyYFx9tW/geMP4MPRUBUhoMreRnMctPciyENph52NoBWj+Lrga0/vwi0cNDmt+JzQN+9EHpegP9jifrzd2od72T4DsTd7gFAd5eDw9/jNBqXL/dRLXR3WK3N6Si2HLmSIXVEyPnuV6YFp08bK3NA50by5fCHuwMW7iWA6iBn8w3JM1lDRJkjnu/kYJhkWNEUzMc1OPWO3ZZRncTNR5BLSN7NK1fkxYoY3xCRI9iw/0PRE83Y12WZzsPMYL7jrUfnWRgze4WwfZ4ie5SqEjEJrGUuQq5efaM9pe+8+ApW/wdPWL0sSd3f2m80cODYpjIPrDLb3f87i7mK6RCb1lRbtnIjxK7DszYC+SJVzBVf+dxsSJr2goym76+HTht0k6RVDM5AI2tq/dQa6C6WKeCwrBVrp+vuUN6Y6v6DOt6Go5WeZ0OFcMlbVXWNlNH3+0MHALctVFmCjpXtUA6OVioBT3f4C13LRvrRxDwC2+0Ai1rE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ecb720a-414c-4eea-32d6-08dc1cd1185a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 11:39:16.3109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spDsIh70PpUyxLasiNJfzKwPNvTR48aygKz5jzZEPsk2pgJaKpfTShujl5um/Q0E2rshwlpsZ9/Kg02qsruhXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_06,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401240083
X-Proofpoint-ORIG-GUID: bGYZ67zP7H4c9MJFATq6ujeDp06I_uBu
X-Proofpoint-GUID: bGYZ67zP7H4c9MJFATq6ujeDp06I_uBu

Currently an IO size is limited to the request_queue limits max_sectors.
Limit the size for an atomic write to queue limit atomic_write_max_sectors
value.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/blk-merge.c | 11 ++++++++++-
 block/blk.h       |  3 +++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 74e9e775f13d..6306a2c82354 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -167,7 +167,16 @@ static inline unsigned get_max_io_size(struct bio *bio,
 {
 	unsigned pbs = lim->physical_block_size >> SECTOR_SHIFT;
 	unsigned lbs = lim->logical_block_size >> SECTOR_SHIFT;
-	unsigned max_sectors = lim->max_sectors, start, end;
+	unsigned max_sectors, start, end;
+
+	/*
+	 * We ignore lim->max_sectors for atomic writes simply because
+	 * it may less than the bio size, which we cannot tolerate.
+	 */
+	if (bio->bi_opf & REQ_ATOMIC)
+		max_sectors = lim->atomic_write_max_sectors;
+	else
+		max_sectors = lim->max_sectors;
 
 	if (lim->chunk_sectors) {
 		max_sectors = min(max_sectors,
diff --git a/block/blk.h b/block/blk.h
index 050696131329..6ba8333fcf26 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -178,6 +178,9 @@ static inline unsigned int blk_queue_get_max_sectors(struct request *rq)
 	if (unlikely(op == REQ_OP_WRITE_ZEROES))
 		return q->limits.max_write_zeroes_sectors;
 
+	if (rq->cmd_flags & REQ_ATOMIC)
+		return q->limits.atomic_write_max_sectors;
+
 	return q->limits.max_sectors;
 }
 
-- 
2.31.1


