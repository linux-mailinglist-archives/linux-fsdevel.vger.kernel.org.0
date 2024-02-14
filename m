Return-Path: <linux-fsdevel+bounces-11526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B2D85454D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 10:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F913291313
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 09:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23AD14000;
	Wed, 14 Feb 2024 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WvqSNRqh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lQr6ZTw6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C79212B69;
	Wed, 14 Feb 2024 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903061; cv=fail; b=aFyR+9h/yfPzX7qVOhceNSuKdW28ZB3PUaCasLz1if0fom7IQIBBCzf1dK8hol0pL44e5Aab37GAkzlF+gNMMuVgfkd0oTuehCNu9s3oOhamd0Wt1TMRwc8mCjgYjHCz+2nRfg6Ienhec1vQxg/JeQjQNCQRCKJsJbPr9kduxcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903061; c=relaxed/simple;
	bh=zqFrfky8wuDweIt/pHjeCJzFTBWp0d/2Ktya8xahX7U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q0xqMesfnr2uh6a5YiYkqYwOdqlmqYiYaS0RvxYAclLkqpy4E1IdVX+mFF3ZLrD+AijdSiLz4Up9ry7i59zdqx6yiHnzKKYJaj9bdsv/LkMHyi6DMDRjJcsH+U3+iXSuCnJy4tj2mVlJqk5t335FKqZX37hd0FdNvOxSf0DUZ6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WvqSNRqh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lQr6ZTw6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41E8i62v023013;
	Wed, 14 Feb 2024 09:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=aR5Q/EUW3PodunWeed+p3znwn1EkAGVeldQ40LsaLiM=;
 b=WvqSNRqhQPvFaMD+tHhDjMV/pcQfko8pBaCxlHWKDlzPteHqlgn/JeYttRwz2ar3AAUk
 pSUVAo3svDRqqfsxwKSA91o3Dt/ua0gwauweaR8yY4QUnaVDeFHkTh1f/vO8Dsjy4K11
 V9p8E9squVhsPdWCvOzTuBA80XeSkFwMaEVC0IxX5dxvM7NnsWc7Ghw0xA4cqlPtAzEL
 JvBEJ8VMwDvtRilQ/sj2NcJ++b4XiifB/7UN36lSmE+x5QtH/bOnDSFUwo2NahgdBGKv
 psJr0xPuuZ5p7rnPDJu5PCwU1q+lN3T1vZK2AgHTTt1CTAk616jKJdzqlyTYEAxjPElc PQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8ry108ta-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 09:30:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41E7eJnL031496;
	Wed, 14 Feb 2024 09:24:50 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk8nvws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 09:24:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bp9JEqOVmKkCBNXkUDcY9L4FVFiIJctrX9PpO89aHTxfGfQcE06PwTL+AGnPZ9QrLscCFzOUQQMh1RyQkABOejMv4zEEXKJXiGh9fDC8s1gc0G+oyo3pyuS/J5QQqEbO95hr1VSen98uJ8xDCJSaVLn620VYcvr+NmFdl0cJ0hz8ZeCj0mJd18gsJ+yyEfn1cpAHMjrHULyzFk/kXcQ6Cx/W7aXKCDf90nH5c9TUuVW2EujmJ+867Yd4PV6doSKC8zFAJ4bGRqIJGFgBta3OS18K19e4FjJiBUsI2YJyKBTNE3niBTECMngCQdNzSDB2KQCHx2qkcm+8TyZ85Wqgaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aR5Q/EUW3PodunWeed+p3znwn1EkAGVeldQ40LsaLiM=;
 b=ijZqTnSHtbBdBrlvQxJbseV1eyhAiFOL0g504ZPtym8D27HvDDTbMo2hTBzvxj19JA2mW4dw6utCEeMDCs7WCB7cDTpTKkuarwmehhLAng+mw6dWFAk1X5tGRbCPn++VP0CrlZjYhlRCoTyLg3Ih/N0//vhAg+UvQJLjnpqTLUknpZPnwMf64wwgE4qvlkujrXejCBXGQfcT3djPpVAniwoihalq0dUbqo/PrZOMdENn82Ou4ESGGtx4WPnuKunH01E66VaMUDPl2FLPFya/FomgmfV2sQmmwr2jQ/8R1cSza7tsnRUTb9tCPhqhMuxhjNEGuBpk9Yt0gnc8Bo9blw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aR5Q/EUW3PodunWeed+p3znwn1EkAGVeldQ40LsaLiM=;
 b=lQr6ZTw6eB+gavtn3aUZxHDk3c20GPuWzpVCTMpzd90dEqiPP65PiG0Nrh3HGnYKNSoByZgMiakpH71DmjfD1Kph1rUm2KGAuffaRJlREwrAr6Uetbplp5ghK8V6m9nDyr5e+Ucc0FVelZ2UI9Z5Vb0KW6xL/kb78LokJhsrs8k=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6871.namprd10.prod.outlook.com (2603:10b6:8:134::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 14 Feb
 2024 09:24:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 09:24:48 +0000
Message-ID: <75f08d51-e4e0-4899-8258-81470c044134@oracle.com>
Date: Wed, 14 Feb 2024 09:24:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/15] block: Limit atomic write IO size according to
 atomic_write_max_sectors
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org
References: <20240124113841.31824-1-john.g.garry@oracle.com>
 <20240124113841.31824-8-john.g.garry@oracle.com>
 <20240213062620.GD23128@lst.de>
 <749e8de5-8bbb-4fb5-a0c0-82937a9dfa38@oracle.com>
 <20240214072610.GA9881@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240214072610.GA9881@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P251CA0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6871:EE_
X-MS-Office365-Filtering-Correlation-Id: 369c02a7-255c-4db2-8ad1-08dc2d3eca05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	szFPcCyeOWgcImYp1Y85s/XwlebzcSWu1VwLfkktnAI3CVvU+fDNWH395uoVFGVKkkiotm1r4CtOrUxSEDI8O4FJ/UvqtIWyf3yyNY/zpRRKnte99ZGcO4XLldQExktxdhLGt34lNGVGRzsLsUzWiJyhqTaUQlGLZd4OzH9Gwy+C5d2haVFL5ODp6aCu5oChM2WPsjykgbgygSR5uLkZ01e4YMV0BHI8vDSAz+ihzFa2U0UYuY1t3Dl2uytB72HteDaYEK6YRN6Zo/LODcRZhWUfxS0eXyE2bHlcQ6ULhoW0bg7qGmsTsti369Z6sSZ50pB5KXrAM0q54kdhmePqionSa5nFvuCE4lJiIg6cY3ZMp4Jqyc1DmP0WsBM9IaGBgWxXp5cnBYzcjxDqA8Ite9kE+soz/7akmoP2DrXh3O+fyH9ef9ug8vn+S5h/w8Z3xXbKq0rWgIXNdMxkIP1xLGjLmPJfXapQ7Bt31WLkLhRp/7EJfTZkvbCAVPgwVpjj8/ZNpNOpaeURk3fdOEqtEdLKPBmD7ERU8Sf90RxcSbA1NFzVQsE7J5BM3MyZJxuB
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(2906002)(5660300002)(4744005)(31686004)(7416002)(26005)(86362001)(66899024)(41300700001)(38100700002)(8676002)(31696002)(66946007)(2616005)(36916002)(6486002)(6506007)(66476007)(6512007)(83380400001)(53546011)(6666004)(8936002)(66556008)(36756003)(478600001)(4326008)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eFUzNmhOc050dGVhRUpCZ3YwNkdKRGJXQmp2dkN2SmJmcVVHd1dYV0YvbG9O?=
 =?utf-8?B?K2VBdklUbzA5S3ppT2NkdFNVdGk0bmY4T3h3NThIbzJnM2JxZ2twVUlZaVhF?=
 =?utf-8?B?MEUzYWdab0xTZDU3UUtqQkx5SEZCN1B6eXNXam5pT09QbmQrWm1mMWNySGpm?=
 =?utf-8?B?emhJSko3LzdzV0U5YnhZNXhQekhrb1AvV0o5WEFFMGRGVit4MXh3djBWM2pl?=
 =?utf-8?B?OXU5aEtnMDN5YzBzcTl2TU5ianFobjRodkxoRTVlWHBiS2VjMHJGeUYrS00y?=
 =?utf-8?B?c1FDYTVkVnBPclgxWTNodXBYUncycUZIME5Xem5wYlBEbUpLeUptWmtKNjJU?=
 =?utf-8?B?Uk9IOFhndHFjYVNDVmpGcVEvdGQ2RlUxcnFVelJKdFpZSWJKMDBKNmxQR052?=
 =?utf-8?B?eTM0OE53UTJRT0pmTW8wVjloV3lLYlFLQVdaMzg5NXcrSFNIdUFycUlZbXJD?=
 =?utf-8?B?UU1QWjBRMkdkR2tNdGZMaEpmUzB5VUxpNTJiZ3RtS3YrZWN4d3IwejJYNVM1?=
 =?utf-8?B?L3ZiWURNVmwwdUdlYjdIY2I2SkZLR3hQb3ZWZ2h5VWQ2Z3lsakkxT2MvRWo4?=
 =?utf-8?B?czBVbkpOc1krRWNPSE0vN29nZ2R5TzBsR1NJUWZGajc2K3Bwai9sZUh6eHBU?=
 =?utf-8?B?SGU0RnRMN2d2WEI5T3ViY1gzRXZ6YkNzcTNNdmV5ZktEWE1PREhwMkgxeEdv?=
 =?utf-8?B?K1R5S1I5K1RRb3cwNFJLVDFVVVBkRXV5ZnptTGNHSkkzcFJPT3pSTTNXNlFk?=
 =?utf-8?B?RXo2UWJMRFJDMEhmWERLZkxDSlNPK3VqTWRZSVdUcm5sSmFqREsvRWZYT1ho?=
 =?utf-8?B?dFZqeG9qaXhjWEx6Ung2dW5IbFhudUdvWUZTRXlZazQrR1lJM1BYRXZUR0hj?=
 =?utf-8?B?a2RGdWYxYWNRNVd4bkdGOGRxLzJEWlZZNkV3NDJmTFpXU1RzaVpGa25ObWVm?=
 =?utf-8?B?T2cvZDBUSHlGZThhay80OUpSVVdidGVOOEZud0NRVmJObVZKUGk3Wno5VFhl?=
 =?utf-8?B?N0RzUTVzaVhGNXV6UXRtTFMxdWQvaEtoWm5kV1UzSVNpaXF4TFhoN2xNQWFT?=
 =?utf-8?B?V3FsU21YcEF5dTFQZGxvbldtZHFHNWIwcmZNeHN4K0V4eFEwREl2VzdyYzZz?=
 =?utf-8?B?d1laZW5VbXJQQzFyYmpaWE1UVHF6RFNCaUVsMjZaRXJXZXdIY2MzOCt1WXdG?=
 =?utf-8?B?cExlaVZsUm9uQlhNZFFNd0czdGhqTHpicXJXN1ZVcXN3QWxLbzZJdCtsMW1u?=
 =?utf-8?B?Qzk1NytGS0ovbFRMdDdTWmZndTdMck5WUlR1ZWdSdllBelg3YWtva3FueU4r?=
 =?utf-8?B?cDVUeGNUS1MwUldOVDM5TlRDNE5pTkxGU0JMZEp2S3hORUVYY3RDSXpTdlhv?=
 =?utf-8?B?UmhGalJ4M2NsMWZ2aG1OZnZkY1lOQVY1d0lPZFZ0eEhzMEJjRlVPUmV0SXA4?=
 =?utf-8?B?REZ3VExZV2Z2amhaSDVtSHhabDVVaVdTWmVaWGE3dExvSlovSXE3MHpoVitJ?=
 =?utf-8?B?R3FUY09wc1lLL3pkL05RQ0dpUUdRLzFlZjNUb3RwR3M3YlJZSkl4VTgyblQz?=
 =?utf-8?B?dng0Si96QXh0bmhjK1Fjem5scFExS2k2d21xYTR2KzNVbVRLZVR0Tkl1Q0lh?=
 =?utf-8?B?UUJqWTdOM2FWT1ZLcWZFc28yK0hzQzVwMjc1ME1OV3JVZk9KdFV4VjB3YmJ1?=
 =?utf-8?B?NFRvdVZ2UmVjVEFocHZpM2xaRlN6VDVTTVdZaVZ0WmVWclNVbUxqUktFUmhW?=
 =?utf-8?B?WVNaRU5sYVA2RmlYUTBjaTRDd3NoMUhVVGtMT29MMk4vVG81bjJGTVp4UWY4?=
 =?utf-8?B?elltUENLZGw2aEhQVDd2VkgvVXlMU1k4WlJ5ZHFTTFhKWWtOWVRTTGRFVVpn?=
 =?utf-8?B?by9vMDhjd3VFM29hYTkxcUpKSFNTc0ZXTjhjdnU5V2F5OUlKY2ZLbHhsNXh1?=
 =?utf-8?B?bm5KUVVWVWQ1ejlWTHR0TGZUYUZsNGRVMmR1YlJvTXMzOVE3SnV5Wm9WdWo2?=
 =?utf-8?B?bjErWWQvQVkwdy9ONVhPQkZvSXR6NjJ2RlJkNXFKQldMV1JXZmFUUnM4Qi9m?=
 =?utf-8?B?M0hhSnV5SXJQeDNTOHY1L1dQb0VpSjVERTFyek9GOHV0Sm1UY3VIN3dFS3dR?=
 =?utf-8?B?QzNWRklCaHlzKzE2cHBzQ0RhQWFzdkk1OXNZVFROT1lTSFNwaTFkeDhuSEIr?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	/UL6dwi+YF/+2iOUEhaXVcEfGo7k5XsiI6qxmLhchxacBY2FVj7rvyx0o+QTmklEN8MMvRf/EHlj/McT7fKwS4Y+TxjvT2fVjX8oPQKjxs5QB8u8wewGs+QzVaRLCxszgQU6vH5Evra09ydxbDs2AB7xTaXJRGgyvqrArInjfNjCE7xzOU5qA+DAERtpSU/WoQS7208WmJlXTG2+Pe8zGvuB+ZKI0WR77jNCx2MkIOdS6+K7gSqliaSeVYGy5XXPw5gOwJ4z8CmvY45pW0NeLn11sh9ED1E/19Rf11K4dK4AeBvyCGAcPL2a3rlKXs54Y/D33zjQM5sAjIDLWCi2bPSmqS4mu8TZXYCPxwxw8STrsW/7vMkWAiEehjwuzroW95lvOoSwnzyZ6/BnuqocMMKJ7A6iiH5VBV6324wo3bPx+pUXV1OHAXhuwGhWD05GCeoCiyFU1lSq6WNwaQ7tp7JeRbZFHQWcQ+amMl6/FvTEm3wvDkcjYjPuO6EB3job9pfW8UPTM80sWdU5nA+fJscUh8md0e5Xxxq5nUIvwnea/ACFTABmjYNfSZqYED/FLvvYoqo9nVZZX7ysRmDHBvcVdl1MQ/6DyGUcH42Jd/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369c02a7-255c-4db2-8ad1-08dc2d3eca05
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 09:24:48.2161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Y4cX34tRMKi+qbdSXPKqq1kwn4cyN7Sc1VOcpBHOy51/e4U/BqKJe1h7mgesl6vdqj8jGn3IhBhL5wyp2992w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_02,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=990 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140073
X-Proofpoint-ORIG-GUID: s0awLkMpll6b157E0moajxiMgvQsEPr_
X-Proofpoint-GUID: s0awLkMpll6b157E0moajxiMgvQsEPr_

On 14/02/2024 07:26, Christoph Hellwig wrote:
> On Tue, Feb 13, 2024 at 08:15:08AM +0000, John Garry wrote:
>> I'm note sure if that would be better in the fops.c patch (or not added)
> 
> We'll need the partition check.  If you want to get fancy you could
> also add the atomic boundary offset thing there as a partitions would
> make devices with that "feature" useful again, although I'd prefer to
> only deal with that if the need actually arises.

Yeah, that is my general philosophy about possible weird HW.

> 
> The right place is in the core infrastructure, the bdev patch is just
> a user of the block infrastructure.  bdev really are just another
> file system and a consumer of the block layer APIs.

ok, I'll try to find a good place for it.

Thanks,
John

