Return-Path: <linux-fsdevel+bounces-11321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7377D852A81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C5E1C21A68
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 08:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD4917BA8;
	Tue, 13 Feb 2024 08:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ls4evBxi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="siRj81Yc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1C417996;
	Tue, 13 Feb 2024 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707811547; cv=fail; b=ht9sMnHRQwGYTginOgD6+dZwlKf28/SAfEMLkflPjRrxkJ+gKG+WcNaRftbuejtcQ88ok/pNDeXrPc72r9L/r7hPqnMiNsu4R1/Q4jeKmyK7Q19x4wCWGOZ0HWe3TAcTvoSTvf5TK1dJoRrtTdyiXDLiINiOebr6mZNxpzEPdGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707811547; c=relaxed/simple;
	bh=KcdW6gFYjLQy084lNQ2AsJebLNu36omF6NEjYqxz6BU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tmkcTYgsiR7qvcXogXFfWgqibjrVDarKvJ4njhhdMTZktlQKE+ZRYp9HhY7+2mkQH3uwQf+3wxOzJjrQp3+VSRO6KWFEFgB3J0gXKDcEkl5AIDOMLvxJ7i7oFEzwjpPmK1swsNbFaF98q1FfxHKWtFLa+WQzeO2xlKir3cy5fDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ls4evBxi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=siRj81Yc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D7Id5O006117;
	Tue, 13 Feb 2024 08:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=LyUHTi7Q7CaHzp79ArWDpcG2xO8s4cm9RPre4zSCeLk=;
 b=Ls4evBxin2B/EkgB6pC5MCfVkUSVCacsiPYUW0EuI56FLlvoKVaUZSmTV6uOuiwrG+DP
 34R3NX+l40BHyH1WeFsDSs8PFS5FxRT151Cjv565e1h0VYDuSi7IT0crJzKC2FXmsatY
 Z9Gllf1FnMRE3K/kBNTzJ222OhoFEk4KBTYkBSsBNQPUKeeYVcEMpq8+Iw5IR92BH87W
 el6Tl0+izSOB0vaqfhhknCAYwntjsYti+y1ShLMHpIOZY5XYX5MA4Jd0WEoDm9IH044g
 1umoX1MXqCZZzFsmvvz45eLsh9GRu3k+7xffwRpZx0/TtexpFA80RlxgZtoPvg/Ndjzi nw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w83ha03yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 08:05:15 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D6ZKQK024023;
	Tue, 13 Feb 2024 08:05:13 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykd81fm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 08:05:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mX1kI2L0Qz/hIYU261tZSqe9QotbMqBK3DY83Q4NmqB82hWlHn0pEtVpaZoQQChByLLha5ZntA1VPWGJU843SQqfOIBCq6TxHDcJih9eI9xIqq0mYadPs+Ly1IymOhpvLB5taVynS3XtPhoD9WwXnFESmZOM61N6kkaNU/xhQooXlbrvV8ST/MtFA2skhj2QmgoflJibpE4JhUDzIBk+TdHyLSXSMKRV+H5f0pSHpTeS+pZx+yvynCxMq/h7hmnvgIDbk6I22uCbMlu4TwoVZ2SiHVAyka5pkEqtJIJi6mQoZunKfO/us8DJ2J7T2XYvOmT3dWRTWYQCw+uyxE7k5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyUHTi7Q7CaHzp79ArWDpcG2xO8s4cm9RPre4zSCeLk=;
 b=EFkLc3XQBy2mSVZszbMTSO5wltCts69szB1V/LEmH/URa/0znYbj8TZ1KEEHhHtlerWsiBiW9h58aHcaOB9oXx5XttcO2ex4cFkHMAU7bnTZcDnUGTSZ15nAht9E2tDcN4G9pkq6JPqSRJVD4g9CRyPScoGx7Vw5AgoEmTy4OsN2xgPvqmgG6YSWLtBGta0VlVL798YNQv1c+UGNs5Hroe0ipZKGn6a20VuIyA+SJzkdRDLvvljytqy2UuS8G1Edni0uWSa2NzoHoumRP9fICZIjom2GL9kb7SQSF16Pzqhcm9SgeGLWiT+/rZ1mMPsJhE6nurRQ6g+keSiq8tLZZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyUHTi7Q7CaHzp79ArWDpcG2xO8s4cm9RPre4zSCeLk=;
 b=siRj81YcgmIqnZXgbul6wAsDooKefnS5X23wNsRVAPQQNz/JZQttu30MXOFeskkbYU+q6reHd8+jujZmgoYdjKjYsF9jUPJMkmm2d5pXRDukaT7pX288W2Cgvzx7zpC9Fd8TaafSrCsul/iopZptAULb0SgmxKD0ByePQ9lNFwQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6220.namprd10.prod.outlook.com (2603:10b6:208:3a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.32; Tue, 13 Feb
 2024 08:05:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 08:05:11 +0000
Message-ID: <1b16adba-7004-44e7-83e6-12d6c0a993aa@oracle.com>
Date: Tue, 13 Feb 2024 08:05:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/15] block: Limit atomic writes according to bio and
 queue limits
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, axboe@kernel.dk,
        kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        bvanassche@acm.org
References: <87h6idugnd.fsf@doe.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87h6idugnd.fsf@doe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0614.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a625e55-e96a-4d75-777c-08dc2c6a808e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	C1pzGoC1mrA4DDDnKn5VGZp16WJWPGSOwQWF5E1nPmRLfkdvIQGlL7KVulJ3vwURN+mwZDcPDK07AxHDe+hymTSzcDUjjqHP3hDMdDoH+D9y0WuHlSdASXvO/904ykDantKetE2No5gj9geB2RQRMzF/F1x2wyVhrnRkP/rfTDDiVQ0nsqKgTPSQkK1UpP/zJDGsiPWiI7BStACNnggrsHo3nt+8eiiG4lau6/fgK3QfQRxLJfe6nRTDWp7z5QEpKBFDKgSvSJYfBTovLfsRRFndTGChyaRTsY66neTNuT6M3s22CQ1lRdlNx3y2C1LSdM6zIhDkwy+HgonIoyEuuD8txDw2DdzUPSU+TsIZveKVej49r9qfxiubjm1K1IWX4vpoEGGRPuMP+Bq1A2lKm1b/1EBqQERznmHcKVEfJ4IPj2VNcRcDAYu/lKx1XQOTzDQlt7+wltKhy39/UmUqrN1biRpZIDkdiV6Ug9Uu/2SeeqCZVo+cI7IHUGybANnwXJOoIz0DiLKhl/rODuIxLFfbSoRYHjY83rP/qHCb8oCIuLcrC7FkaAAQLrcYv/YuO7BDMj9nBpktZqqc8ZAgmXn9fyyx6HmqQ3vyeFkn4XA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(7416002)(2906002)(66476007)(8936002)(66556008)(4326008)(8676002)(5660300002)(66946007)(86362001)(36756003)(38100700002)(921011)(6486002)(478600001)(6666004)(6506007)(53546011)(316002)(36916002)(83380400001)(6512007)(41300700001)(2616005)(26005)(31686004)(31696002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L05qZzJOc3VmcklqZ3RmUnRtSWN5Y1A1YVlJQU1xNTNYZTZUY0YrcXpiV21L?=
 =?utf-8?B?Qno3OFlqalFHWTlEU2s2Q1BuRnU3K25aYkJ6RVcwR1FqWXY5YW5wQkRxdzdW?=
 =?utf-8?B?bXlTTDk1QXh5ZjZ2Wnk2elZYblZHOFRpK01ncXRPMnNQdzBKNXVVNXgxL05q?=
 =?utf-8?B?eFFCMnhVVG9GUXJrK2NFUGRGK3NRSUpxZ3VpNDVxWTVWdXUxV1h5ZFBRWkdh?=
 =?utf-8?B?c2ZGNTFXU0lXTGFiMDFrQmdRTU5ScDRLV0Q2VHVlZXp0UHlGK0o2OEZJMVh1?=
 =?utf-8?B?Yk1KYjJ3ZDZ2SVdHaE1MelNIQUQxVFBoZmpsWXJKR1pPN1dhdGwzYlA2SVhm?=
 =?utf-8?B?b3ErQnNrY2J1NzlpSkZBWXRZRlVSZHl0NGpQb2FSdlVlT0d6cFJNc3V5SkZk?=
 =?utf-8?B?U003U1MvWXV6TDdVZU1nM0MyaGZxOHh2YzN5RW5tMEcvaUFhenhHRGd5aTVG?=
 =?utf-8?B?dXE0MXlENXc4bTZVNUxpQnlRcFk2Q1FlUk5ibW5sM3Y0ZmJFSVV4NXFBVGpi?=
 =?utf-8?B?Zk85VmxMRlZQclBQbWtiWjFyT0hRZHdKRFphWFNBU09kNGhYSG1jMHNiUEtv?=
 =?utf-8?B?UGdJZ3g4UjZlQ3hWVDd5bFVJdHRXRlBWc3RCVzBDbWhPdzNxMUU5MTJIVjJC?=
 =?utf-8?B?cFlYTWVQYWZVcG5kNThVTGxHZzNkMGhXbGRNem9iZ3FOZStuR0g4REdWL24w?=
 =?utf-8?B?RnJCNzZkcmxkYTNsWG5NNlQrd3RSeFY3TUxUc0MwSERqdWtKOFhXaytkOGtP?=
 =?utf-8?B?emxQRFJFT3MxV0NNTnNmVHJ0MkgwQUZhMTFoZEM3aUVsSllmRzF0d1ZtbHQy?=
 =?utf-8?B?Q3lyM2FOZmhydWNJZEljb0lRbkt2M1luOUpKd1JEMXpVUytOSHZjS3NRQ0xC?=
 =?utf-8?B?aktMMHhmY1VEa0gzdjJUcU1YdHJ6SnpFQzZvWFNYUlFJeVBFNGtpcng0cytz?=
 =?utf-8?B?cytkQUFwYXhhNlhCOTkySWtoYTJ0VWNDOVRvRUlsVjAvUks1MWZvZ2cxUE5Z?=
 =?utf-8?B?Y0N3b1phcU90ajJIcGpqRjNhTWFDc051ZU1HK1ZUdVJPQWljTEFuUGFlZldi?=
 =?utf-8?B?eW1SelZ4aGJwbVpFck02dlpYcGdLNGdvSzBWdjNYbitqSkRLUjI1SEE3RkdL?=
 =?utf-8?B?Zm90MVdrN2V1K0ZoTUJLY0loOTVJSG43a3dsYTYrZDNYS2hLK2JSZDA3c3l5?=
 =?utf-8?B?dnpMWFVYbkF2eXdIR3UvU2tvYlZ3bmhCd0U0Ymh6RlUwMG5EbjZWM3pqcm9D?=
 =?utf-8?B?MnhKallML1dzeno3QjEvc0doajVKRTRWYnpkeFR0RFJTbWdWM3lvVGhTWEtE?=
 =?utf-8?B?U01UQU9jUjZ3UXFZMDZlT3VZL3dCc2RpRkI4ZTVUdURvb1YrSnplTjFmSFZ1?=
 =?utf-8?B?K2dUa0w0eDJCaU1oMmNILzZya1JoZG04L3NGd2Fhb0JCaXk2UER4RS9MUzlp?=
 =?utf-8?B?VHhyaVdscUE2VlFVbmZaalJGSmIybEphWHBjVjNKYXkwSURBQ3F3ZzFsQXoz?=
 =?utf-8?B?WjZDdHZUTERFa3VCUFMrZ0t3MXplZGxUZjd1aThqNzhSRnYxME40TU1QOW05?=
 =?utf-8?B?cEdJZ3JXdXZZeTVBclNhNk9DUFU0akQzNVNUUnVZYUlLbVowY3NZS05vQTQ1?=
 =?utf-8?B?U1V4ZzlVZFo2YzBIZG8ycHpZMVYrWlc3YmNqcnY0RWJsUUViZHBHMkQwYWtX?=
 =?utf-8?B?R3hJTm1RcTNsWW1IS1NpMm9oSFNRRzVMU2dIV2t3R0JjS3lKeC9FMnRMdC9l?=
 =?utf-8?B?eWxPWTB1R1BMSHpNVE9Gd0NXaFV2WDJJdm44NUN6NlFxNGdpcWxiRlQwR1Ar?=
 =?utf-8?B?azl2OG5JdmJyRGU1L0ZTSlFDT0tYZFZxMFF4eUo4Y0h5Z1dFazFMRkV6eVIw?=
 =?utf-8?B?WUp5OUthRG1WU2x0ZEF1RzF3SUZxOGZWcjhIRElCdmJUaWtiTkFKVzJGNGg4?=
 =?utf-8?B?Yjg2NUVDRGtPYlR6TWxEWVpKdms4TkJIZmJudVh5SXBsakx1OVFTNDVEME1t?=
 =?utf-8?B?RkIrdmkxT1JZekVNMjNXK241WERmR1loNUEydzV4UDQrRHBYVHRUa0ZhMFI5?=
 =?utf-8?B?UnlWYXZlNHBITmdnek9mWjAyK2xoRmVZRVVIL2NTTFAwV3d2ajhMVVEwYmc4?=
 =?utf-8?Q?YwgvuLOLQ6iRWIvolrQQOILJB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dLEab8KzH/LtwRgE5jvkuyIj8IraEhMiucSiohHaRK+NzICclukz3VeRPSI5A6XmXgxZ0y57EpVEZPk8zlCmtdjSp2mHvNqI9POhQ3fU2noOMrdNRPXL7H1hzhNZ8rhw0uBU8u2oAq8nS7Pf4nPzPT1qkizPqrVL4d24JpsZVHGIEEUTiGCgv35cyDCT9S+wbz8sDs2yx7f2zKwgLV5Z6z99j6PLOP3xCRDvoGKd7h7zQvr/Xqg599iXW1h5+02VresRawRFdUZB78Mbp+LIu+88jNpcyNOeDYeq7N3IGKknx+tqT92ptShRMt0jOD7uFecUkMRQaIWmU0ett4Y8v610WDMV+28kfZy0GOYqkqwugN7q6fn0WuFv/gjpL+n2x3ROpfqk4dkzY8FVXomneggyZCcVsEL6AkcJq9pyaC1/U2rBgxL+TNeBaeQ+cZd0WDN1Kf+/mwJAO8DGl1KkQ+xmEJuJ/NNrgoUpdw0oy3GBW6oWwe3KS0wa7vTfeEeGbxHYrMzGKS81CmbdGHIqE1u0MhfPgQ5aYncXXs4BwkdVPOtEg2uWerabTznIdST9v7asymhTtJiLcBDlZyGdLhMxLsG8zWvKZCWNaMo8nWU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a625e55-e96a-4d75-777c-08dc2c6a808e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 08:05:11.7377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BfG23o/qDzoKHhe3P19MW8tpf0fg1EOnpLrDogM5j5vY9rP/CvT71ivtmq2OSqf0NSy6UiDWv5rxaTDcIvNl9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130062
X-Proofpoint-ORIG-GUID: kkVWY63roWKH5qTKHjp5TxySthcYRWl1
X-Proofpoint-GUID: kkVWY63roWKH5qTKHjp5TxySthcYRWl1

On 13/02/2024 04:33, Ritesh Harjani (IBM) wrote:
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index 11c0361c2313..176f26374abc 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -108,18 +108,42 @@ void blk_queue_bounce_limit(struct request_queue *q, enum blk_bounce bounce)
>>   }
>>   EXPORT_SYMBOL(blk_queue_bounce_limit);
>>   
>> +
>> +/*
>> + * Returns max guaranteed sectors which we can fit in a bio. For convenience of
>> + * users, rounddown_pow_of_two() the return value.
>> + *
>> + * We always assume that we can fit in at least PAGE_SIZE in a segment, apart
>> + * from first and last segments.
>> + */
> It took sometime to really understand what is special about the first
> and the last vector. Looks like what we are discussing here is the
> I/O covering a partial page, i.e. the starting offset and the end
> boundary might not cover the whole page.
> 
> It still isn't very clear that why do we need to consider
> queue_logical_block_size(q) and not the PAGE_SIZE for those 2 vectors
> (1. given atomic writes starting offset and length has alignment
> restrictions?
We are using the direct IO alignment restriction, and that is the iovecs 
need to be bdev logical block size aligned - please see 
bdev_iter_is_aligned().

We are also supporting a single iovec currently. As such, the middle 
bvecs will always contain at least PAGE_SIZE, and the first/last must 
have at least LBS data.

Note that we will want to support atomic writes in future for buffered 
IO, but it would be sensible to keep this direct IO alignment 
restriction there as well.

Let me know if this needs to be made clearer in the code/commit message.

Thanks,
John

