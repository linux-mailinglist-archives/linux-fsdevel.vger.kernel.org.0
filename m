Return-Path: <linux-fsdevel+bounces-2888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC777EBFB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 10:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6F5DB20BEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 09:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811C89477;
	Wed, 15 Nov 2023 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WbAJQjnZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G8joP21o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552767E;
	Wed, 15 Nov 2023 09:50:07 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390F511C;
	Wed, 15 Nov 2023 01:50:06 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF9XvxC009796;
	Wed, 15 Nov 2023 09:49:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MaDOY22C47aelO5WcIw78QpOd+rT8aOBnCnlR5kmLGs=;
 b=WbAJQjnZGdhaRa9+kBroTcU1XklP7U9n4t5t+uIpPkT4UPK/33svATchqEIzJooVOJUu
 Fi4lnsRXVovjapFQbC4CgE4TrgRotKcEh/nK4nG4MLvTKpcaImoLbOgyoEjIsLvbBFls
 sID2AmodDvYlNZ4lSDQqSm2vs6aDTtSmT1Z7uTgMfHmdqI3kOPW4yl9U81kJ0cUPhtAI
 JQUt6WF4I3J/ooGaAeXpC/xky7Qac67tUSWEir2chjmFpIIWYi1tsQjk/ZSAolw03kbB
 FMV20vAavjoQuz7lWrtBkSEPwlc8NKvPOZv/G/LUHCspeRfCgd5rE1tk4F8DVioLYQiT dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qjqqsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Nov 2023 09:49:59 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AF8xa1a003998;
	Wed, 15 Nov 2023 09:49:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxj3hr1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Nov 2023 09:49:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+wqtjy7+2XTMm9oDXbCgwc7KEyM2fQXalohhhkOcxcDUWmnexk0oJ9TIX0paHfOLuelHb+19g8FfUnwTuM4EjLDkhDAK+L9XFqH3ktdUsWCpjftVOn+DWraH2zFJ65Kyvf6Se4iFCO2MoxB9FRS8R3pBVQ8tgXoxCG4HlItNRtDO/QKwL6yw9NRkYpns7iRDboHcKl9eg1XcJExtpTvvR2ZJLwhi5e+YzrJDQsRdfLw4BmWKecdK4dPlXSZYP3kIqPBk6yWt/yOIkI5beO/lVZf+K5rVN8h6Dh4qTepNAdkztM9izLodO3CE7M58Gn29yOck2YyqRVe5pwafz8SsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MaDOY22C47aelO5WcIw78QpOd+rT8aOBnCnlR5kmLGs=;
 b=FcFV1w9yN33EfWZ6RoT4HqiKDlGSH71+0jH03ul3ZotR5TG3+XVbMDhiFmaLou7hFV74ftLqgo51Giw6f5R7KbibBvLO/tyZsNDbphMrIkpKaregKL8Os3ahYnHRjiKCHXoT1yB4YrIQJOipgULYq5YjfS10ng98xwlLxPeT2xvuEyk2po/g/4zARCvmlgpLnUP4VCaRaT6DhOpOi0qoDCve9fm6dhNmE/0dkzRv5s12olRIKzDqrjU+9RX+XAXfaWK7v6WyNEyv8LELYiVR2MsF8ScXvV6dJtoUDXhyDetQ+MtBZBInMPcYYEEUNI6qFffD2CNwq2YvLSMNhHjfVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaDOY22C47aelO5WcIw78QpOd+rT8aOBnCnlR5kmLGs=;
 b=G8joP21oURIxo0TaqF0D2hMdC8OYkIckh0GKCHlx75m7Igqv+6/gwHVuLQ55mymlsVOps2U0mNvTEgRtZDU4ksGQMdA29adDJWIzZhPne+ah9nlhZ23/S27BM2dVu5NMSYN1IpVJmd48RfuxaXzryUNMIbUE2R+tViTPKNFMjB4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 09:49:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::50e0:d39c:37b5:27c1]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::50e0:d39c:37b5:27c1%4]) with mapi id 15.20.6977.019; Wed, 15 Nov 2023
 09:49:56 +0000
Message-ID: <6bbfbf34-aa74-4501-b36d-317022f3bc1b@oracle.com>
Date: Wed, 15 Nov 2023 17:49:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/18] btrfs: do not allow free space tree rebuild on
 extent tree v2
Content-Language: en-US
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com, linux-fsdevel@vger.kernel.org, brauner@kernel.org
References: <cover.1699470345.git.josef@toxicpanda.com>
 <6a2c827b0ed8b24c3be1045ccac49b29e850118e.1699470345.git.josef@toxicpanda.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <6a2c827b0ed8b24c3be1045ccac49b29e850118e.1699470345.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::31) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BLAPR10MB5044:EE_
X-MS-Office365-Filtering-Correlation-Id: f5d4507c-015b-4286-01f2-08dbe5c0393c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2LY3bwyvPwfA4THQML6bI9TGUakSib5SWuaKUA7HLdgiCUvNuLc0lLGJBl6ImZaNVdhIkx3dEZIVDHF6Z9KFiIBMe1ubuKNMV3OtFHFDvYULLMmrAzdW/bqNLIZoTxtIRojM8Tr+imo3XCVX9bNj7kMImepl+L5++Z/9yGbp3eML1uplP71FI+CqKnvCVn7Mu6nRyF8LYxwW8ac3Dg9ZqVaojx6sHFh0chlVgWJQMiFx2LHtqKo1/Y4O8K6A7Z6RjbQO01N7axxmWP1Lkp0a0PAsqsBh+HRZj/Wtc6x9IkBndV1eooXAreKf8dNrgnmX3y93nLlSwHCOQlOcFvU6sVDD+sN4LokIGKO7Kqpho4JV6S7TID9A+TZNfUajkMmt2OohkyhbGNM012pafi6F3PH07l1Cj01cxQQ27n+EzIcHHomt+/JOTNZx4KBcq/NpvAg5HSQbU07PiHShRu9/ULJ7UBmK++3kH9/WTouoCorhcekEtnf9risgVRQfUMDOLHpVUFEs8ROYXiHWwvGMKT7oYgG0hXVXDWxxpbA+tIHeXH1EwSmXlki4hdCd26fd8r4Lcrv380SPdQ/kK4XGlTFQV9vNOS5KgssRO1HJpSqJOWiUOzNBcOfHmH3KpO/xPRvLsws6C055HyYccybi8w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(41300700001)(8936002)(8676002)(31686004)(26005)(83380400001)(38100700002)(36756003)(31696002)(2616005)(53546011)(6506007)(86362001)(2906002)(6486002)(478600001)(6512007)(44832011)(316002)(66556008)(66476007)(66946007)(6666004)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dVNrdWNsNThsVXVtc2tDdGI5cUdQMkRCeUxrY0oxc2ZYMm5TQXZ2SU16am02?=
 =?utf-8?B?ci9hSDVIQlV5aDNRZ2s4STVkRDJqWUp3c0lRamdQY3hiMXo3K29iTmYrclFV?=
 =?utf-8?B?ZEFTQy8yckN4VU5aV09ZQ0hlMFE0ZVZ3ZVpCZktYMGJaWTVJMEttdGt1TytR?=
 =?utf-8?B?dkFrRitQUCt4MXh3OTBNTXE5YmtrOEJrMU0rUjNwMGNOeGwxWU90ZllUSnB0?=
 =?utf-8?B?TGVGWDQvY1NZbTlubXR1S1I2NGcwTWVqd29YYmpvaXRZRXlTU1lpczI1RmtY?=
 =?utf-8?B?d3VtNHNnQ0tyQS9DcnVTVTkrT2d4V0JNUnl4NmVWNWhERGtaNXpQT205RGIw?=
 =?utf-8?B?N2hEd2EwMHVVWnduNkE4ajJvT1dEK1JzSHBCTmtadzJHbGx4bDhDb1U3K3d1?=
 =?utf-8?B?Q1ZGTUNaVzFRZmtOU0pUYjlMdDB4T0QrZ2t2dEdNT0NmVTltV3Nya2d1VjZU?=
 =?utf-8?B?L2w1dlpZK2dUcFdvd2phZkNRVkNSaHV2dnQ3ZkhzaU4xcDBzUkZDY0V2UUY3?=
 =?utf-8?B?UUJpNjVFL0lxdEZ2NnZ2VDAzbHRSVzgyVmRSZlRDVk1QTzVYMlBZbGxpM1hB?=
 =?utf-8?B?eEFTcDZEU0ptd1JrVm9vTGpzRmR1QWNCMXNVcFNqQ1BIMTFZaTcrSVE5Nitp?=
 =?utf-8?B?L0RsZHpmNC9QRzk0bHV6b1paZ0lxSmQrMklqWGVvRkVXTDNJcG8rVmtEUzlu?=
 =?utf-8?B?K0RSbW54aTV6Z3FPekY1R2hkNk5IcjYxWEpxZTdtTkpuTzE2TzNWY2FCMkcz?=
 =?utf-8?B?QkRzRTd6cVRrbk9oaVRYSzIvdTJZaTM1MnF6bUJpS0Y0cjdDUFNkdCtwOHg5?=
 =?utf-8?B?YW9iSks2WGdsTlc3MWc1eEZ1SGZmRjdXMmpodjlnMFoyUVg3bmNhT2c2VVo0?=
 =?utf-8?B?aTlZWHpaN1NrcWtyOGc3L2ZTcVUzMG9GVFpVZVJqM1FvbmVFcW81NmQ1TWZK?=
 =?utf-8?B?ZlpDaFNHRjhNZzdVVkRKcms1UWxCTTh5SHNWSmR1bFN4dzM0eHBNN2JydlM3?=
 =?utf-8?B?SmhkUEY3bytIdXN1UWpiNTJUazBoUVd4TlFqNGlWQWpyT0Jla21mSG9YMkFr?=
 =?utf-8?B?c1BIVjFSME01ajUzRkdPTVZzZ3RtYUhGbXphZFhNbzJQVmlTM2NjSmx3cy9N?=
 =?utf-8?B?TkdZcSt2Y2xPMXpSZXNBb2Eyd3c3dWV5VlR1bGlHUkYwWnJUWHllYTJHSTBY?=
 =?utf-8?B?SmxJVEFoekJRTFZkODJ2WGV3NjdCYWhpNlhYNFgzQm5ZS2FDUzQ4b1UxRVFa?=
 =?utf-8?B?Tzl1SDFpZGkzT0Rra3IvSFB3Q2dqSmJHWDlvZWNjME8yNUhNeVNua04vdzVq?=
 =?utf-8?B?eDVBclJKVWg2UFIxc0w0WVYyZUZkTzhvcDZNR292bWd4NklWWkdhQkxteU1i?=
 =?utf-8?B?V2t4Vjh1eUpheVp3NlJ5dG5mTmxXQThmTlUxR2h3Y2ZpOFA4Q1ZMT0ppS0hs?=
 =?utf-8?B?YXdEbzdWQ3FQSC9iTEZEMktJbllQRU1oQTNQdCtIRC9nNC9Pa3VxSURHT0Zx?=
 =?utf-8?B?Ymw3Y2ptMXl6RTRDMEhmbWhZZnVvVm9KMHBRSlN2N0RUR3AvV1BoMWRDY2dD?=
 =?utf-8?B?VXdFSkdzbkZqRVVwZXE5K1BVRDYxOXluQVo3cTZsTnZuRHJ6bzBZRkdBUXRq?=
 =?utf-8?B?bjBQMk1WOXk3Q0tUSmR1aktYcDUrVW8waE9aZ1pVOWF3UElmbmNqVGZNSVNF?=
 =?utf-8?B?TE8rYndFb0x2UW9oR1RzaHZjNUFsY2FXeStEVU8zQU1RK0lpay9PbkJsdHp2?=
 =?utf-8?B?SVJWTEVIQmdzbnpVeXljOUJObDBUV2JYWm1iTnU2a1BSNDBqa1gyQ1M4eitl?=
 =?utf-8?B?L1BCL00zSlFyWkc5NHpxZ1hBaW14U1l3ZFhTZS8xY3JBN3ZQK2xIaVBOODNn?=
 =?utf-8?B?dEZndjBEc1NYRWJ5ZDBOM0VVVEZtd3dFLzVCbXh3Rnl5OCtrRTlINXBnVVVB?=
 =?utf-8?B?dEdNc05XN01LMi9TWk1uOVc3elVBTnJnK3lrdjdmelZtdW9hZTZObXY4Znp0?=
 =?utf-8?B?RXlnTHd5OEQzOTJJUWdXSlRoRXlQU1hwQXJBbWZaSU5PSkhCdVZySUlzSzhW?=
 =?utf-8?B?ZG92LzdBU0NCM2RDcUg3ejFaMHlMNVFCWDJ4Wm1raU1LVFhiRG1BQ01wSzJr?=
 =?utf-8?Q?YxXVragSCjFzg2s/IqAqXSiN8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8amiCzDmKZmCGl8D3x7XNUeHk4PXWpG7aDfIOEQ+j3dBaviojjJYkKSQsNRasgSDwv2CLfosoHD27Tazda3UvCOgDfxWgXKmwVq7ZtB5IVxsSHelTnXiHMPAMA2ucAbfXcuTdlZ4Y/f33KjEiE6/n8Rksjq2K2UwgXzvC5OnSsknqjOSGDEmKYE76V/iJ/DW8hpFRSBPW0iERDHZM+64oMz3EKOIiBSaUlvuPjylM62lcVQSSi4lBX8I7F2KKWCaOz9IDVWP93OawTup0fBA8QcXd1aVX3Q3zyD9UG73OrlvsC73m5LXaaXWKkqQE5bKbupjRP59c3tfOuTAmnp06UxZ1lB6Fd6TcAaLckvyRcw0uPa4MODReVyZhcMteloLUiFmcYS2LBj+YxcDiwlzgx9IHtqWDWOnkHYKeHM+MjFIsLwoT/EFS4Md+64Lq9HwYKH/+NiJ8L8rBSf67AbvHkTbzKTF9pFvqicDyfrsKembCjXmG+jGuTdUMT6+IYLVtIMsujVE+5bcn8LatS/AOPmjFW84La1XMQKdpgL9PSJ7/CAzu17gtVov1vKDB5ekDEvowmEiaXeluIYqtm4lvT19TsetsMSEvmZeI9HfdlrK+3xDsBUKN9QxWP67Rz7qqfZrX7d0sEpSn+vqRYQbilXrpWjhmsmClhSSWWuLu0/iJI7IQTQJMnUEn/N3jLkg+q+djEjqNLWqhBdFyoHsMhcnPPa8jGE2imgzx6BvzrrfBnO5LdGwM2UgUMbFPARzKGMqjFTk//AbofqTBoCtGr/7v1PA0lMg+RLNV7GIsYKb/FiZw9esRgjg/G9NjC+cUCubFo78haak4yCErcdkZtwPA64WXkvGMkws6DvDxgM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5d4507c-015b-4286-01f2-08dbe5c0393c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 09:49:56.2924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 48QfPAbZOpA0cX0T6Ttr4WXkY3OfIV57bTcVEZtfHSTPTh0eF4nm+c5CmZca3wuDGkhrhcGaVcYcCjWotARjug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_08,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150074
X-Proofpoint-GUID: k40rNaLB37eCU4VZ-bMcRu1dSbABNlRr
X-Proofpoint-ORIG-GUID: k40rNaLB37eCU4VZ-bMcRu1dSbABNlRr

On 11/9/23 03:08, Josef Bacik wrote:
> We currently don't allow these options to be set if we're extent tree v2
> via the mount option parsing.  However when we switch to the new mount
> API we'll no longer have the super block loaded, so won't be able to
> make this distinction at mount option parsing time.  Address this by
> checking for extent tree v2 at the point where we make the decision to
> rebuild the free space tree.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   fs/btrfs/disk-io.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index b486cbec492b..072c45811c41 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2951,7 +2951,8 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
>   	bool rebuild_free_space_tree = false;
>   
>   	if (btrfs_test_opt(fs_info, CLEAR_CACHE) &&
> -	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE)) {
> +	    btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
> +	    !btrfs_fs_incompat(fs_info, EXTENT_TREE_V2)) {
>   		rebuild_free_space_tree = true;
>   	} else if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
>   		   !btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE_VALID)) {

If there is v3 you can consider to add a comment similar to that
is in btrfs_parse_options().
Also, IMO, it is a good idea to include a btrfs_info() statement
to indicate that the clear_cache option is ignored.

--------------------
                 case Opt_clear_cache:
                         /*
                          * We cannot clear the free space tree with 
extent tree
                          * v2, ignore this option.
                          */
                         if (btrfs_fs_incompat(info, EXTENT_TREE_V2))
                                 break;
                         btrfs_set_and_info(info, CLEAR_CACHE,
                                            "force clearing of disk cache");
                         break;
--------------------

Thanks, Anand



