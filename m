Return-Path: <linux-fsdevel+bounces-10434-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4640E84B1B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 10:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA3DC285B94
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 09:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10A112D750;
	Tue,  6 Feb 2024 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nFIE3hzK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EJFAHz3w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045D512D17A;
	Tue,  6 Feb 2024 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213428; cv=fail; b=l15ZBmorkt61Xga2cwPvQrACe9r+pab1OfF6zFZkiLv0n3CMzCqLL/slLrzeRXXJypZNG3Qa39UGGVcBbq7txUHLUbfA/5ayIhniEP6UQLXxV0fxotX2kUhFSRh2iiy8OCpL8zD0Kv/L8PiT9iDZIbaeFi9znq4S3H3GzE9ohHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213428; c=relaxed/simple;
	bh=2TrFRdnlotEfPi9k6TZvI2X3H4zzR2y65YM6NTkKQFQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tS5PB+Fw9end5DXz/oJEFHZXvWV2c8Nel/Sfp0J5Suk4msccSbJSaRQYGEg7dnkxld3mymbESo536GwkDTGsJU+m0brDFKliGv2ayrpZ7xKwEkY5+qCVKu9aUGLVqT6u7cpW8vsYaBTO2AcA0ruMrhnSap6+66dSemXKhjeFl0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nFIE3hzK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EJFAHz3w; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4161ESXS031607;
	Tue, 6 Feb 2024 09:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=w8Dfp/T+54x9Z1T71Uxn+y+ZdAviNYSKZNyc4OjszPM=;
 b=nFIE3hzKjMK9nSRY/Q1yFZwmWcacC+qmzhTDfFOjTaFH6zb3zO+8KXICfVNYmGKWLzNU
 ZIAi+v3cteY+JCQepfGwcuqv8cw1bUF7n36P8iwdHpt0Q/hl2WWTr9OM6vc7xDSoNYIW
 vZJMljQ5r7MenmRqqWigEmgn3dgMSC3Emxrg904eDhu6gUrdx7G+zQHAfmK5mHXoYR8k
 bYr1e6SPYtXE1Tku4jUfdj9sYEvhweCfFzBvkcBE+EHO7PidD/LNPhd/B3EBzQElfzDi
 LxHIKm4l7Gw59Ma2urw7gI6irMjztqnxzBIVAR4o4teY7x6x4yNBENVsXqboiCGZAhPh 9w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbe8ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 09:53:19 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4168d8Se038354;
	Tue, 6 Feb 2024 09:53:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx6ugdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 09:53:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PkwWjE7G/xfDaNzQF89jh53oLSHqHnkt/1FsuiesvNv5mwDo3H0N8bXnQgZdXLsn3PffB9fpizErdMAYBq4+RkQI8oimy+u9Li9gKTDDvAl9xSV3jImRdeAYrxAjeHqTdRuaYY8AlDpJch1t4STsfu+cA78NP+U8fiyRoTu14+gCRPSWDzt2p9yT/V0h20oy5+0NNmXdDNxYsKFWY7RcrOl8h3geLFQ7VEeC781oSprbOAjn6k9QjxK/1Mcyr9KfKkv/NsL/0j8vp0YxzQuNlDNMH1YOFZZtFL3GZpH+k6AWxDnKm1wet6OGen7fg8Kf8qW+RzQJrJ7r8lswkcqsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8Dfp/T+54x9Z1T71Uxn+y+ZdAviNYSKZNyc4OjszPM=;
 b=lfQ44RWU5ttJbJXdoucZqJdUC5i1RjMUXi1UU+OQ7ReBpGoV7wrXivz1Kb5KepNthDPwTn2gbRSqvp+Y7anQmZz2Req+uZuTNp+GvcRv7qEW6dSWxuAwypcX/Wmt/Xb94e6rEArvvXVC4OPqj9jznAE7oG8esy+SaqLIgf6txmqpI1K+Vj/LOS92mAtoyN2oD6Gx04072qdBrfR1gq4X32KgAcPtw9qwyISmzNIu90pBBILgDhICx/G2GoHr4DwMwPalDFUgLG8Nrj08CuJzsf9KW6PozMdPELlIx7oEKhuKa6BqbLK/58KXBzCWCCiVxSee80WNzdMQK84f2oJx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8Dfp/T+54x9Z1T71Uxn+y+ZdAviNYSKZNyc4OjszPM=;
 b=EJFAHz3w7rjN4XxZ0LUMYCAkLMAiS4reSBm8FZ0K3cPdmNooj79DSxlD8KKxeKozBt88pMt6E4D5Dq/1sKd6uQ6xU0nx8i1x8V68Z45jGic+dJNTryXgvOtlh+yHAiBEvrWtKBcH6uMbjsAWerGcVn1fSgYzRj8WY0bWCS2DI6A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7051.namprd10.prod.outlook.com (2603:10b6:8:147::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 09:53:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 09:53:15 +0000
Message-ID: <434c570e-39b2-4f1c-9b49-ac5241d310ca@oracle.com>
Date: Tue, 6 Feb 2024 09:53:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/6] fs: xfs: iomap atomic write support
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, hch@lst.de, viro@zeniv.linux.org.uk,
        brauner@kernel.org, dchinner@redhat.com, jack@suse.cz,
        chandan.babu@oracle.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-6-john.g.garry@oracle.com>
 <20240202184758.GA6226@frogsfrogsfrogs>
 <e61cf382-66bd-4091-b49c-afbb5ce67d8f@oracle.com>
 <ZcGIPlNCkL6EDx3Z@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZcGIPlNCkL6EDx3Z@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0293.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: 6231a617-5da6-4de2-a94f-08dc26f9704b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vbqJ5alZ4+Dny+k22gX8LGns+67AmD4p31jIUcx+Dqy79d37JEArXtrSeBz+vll7MpnO4kFhBrP9uqVwWF16oMZyeKnpoqz8a7WuyWq0mq4whBEiUSYqYHwskvV4PsIdO94QrAUcTPAUVa3EL3dRpiGEP/3X+JTjSbHc/ml4Qgg69hXC54wny6b9BPd6nlVhgpjkh2md+RujXPMa1K9SUqghmo3X31P8lLRYGa6Zl9LKK5DkNnhed4C+nV16W7ng9gmRd8b9WmELu1N2trvBSmMTgrvlnQDa4r4t/Y2g/OhYVbKcr/1Tsl9wqdpIEMocxIbUUKBiSgslQiLMVJvh/jOJwlVKjW6JPUVtLd/qbEGGpe1c3SU+Exh4dSatujGxtSzh4q7FN2NUUBtmZ27hMIDkJbLzvQpLNSBlke3AU8ydRcSs3jjlQJkvDqtRrMg9hDc67lHPY3rMmpTWh6167xJb6fSWodaZuGM91B0JS7KvUTKGXXxbDg17JzPpJpZzOvB0JiMh4wj/yTslInVXyjEx7iD4+pKiIaiDxw2/LxBcI8CYNVOauhCEGWxWpBTtQxDHBybFe1TZdyhM7Dh5GFVeW2uusDH/OBUSvSGZXxgsWDCm+e1Nme9GF6sWR6XRBl4Dg+SViMN7wXAUPVYe8A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(7416002)(86362001)(316002)(4326008)(66476007)(66556008)(6916009)(66946007)(8676002)(478600001)(6486002)(8936002)(5660300002)(31696002)(2906002)(26005)(2616005)(6666004)(6512007)(83380400001)(6506007)(38100700002)(36916002)(36756003)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VkovOTJ2RXZTd21oOG40RzFMSGRoSk5NbnR0RG82SVAyeXVNa2lSQlFhMXZX?=
 =?utf-8?B?S1dEWWhHdytiY2RVTmcvYllJYnlGanlsZ1RSWHVsblI0SHBDRjBUb3RDb205?=
 =?utf-8?B?VHAzeDBzRzMvME1EZzU3SVcxcWE5cE9PQ3NYVldicnJNWC81WEFXL3ExMEZD?=
 =?utf-8?B?NExGcG9PQ3drakFPU0lpMUUrWDZLM095ZThpeHJNanJXeHhqemI2VU9rSStk?=
 =?utf-8?B?WXlJeXgwZ0M0cGpuZTI3d3hvMSsxYThGVWdwYW56NENPZklWMVR4a01EYkkv?=
 =?utf-8?B?bjgwWW4wZ0ZuOWt0UXc5cTArQmg4ZnlVNlJxWjAyZlhObU9DQ2k3cTFJUGwy?=
 =?utf-8?B?NGZpbThoRStFOFZsWmxKUzB3aW1rYS9tWGtWRjlHQjBDMmVUY0pmdkdEcHJn?=
 =?utf-8?B?Vjl6aklEMDdzMCtMTlpvZkJHQ205aUt3Z2ZkcXJwVUJQWElrYzZsR1ZVVmgv?=
 =?utf-8?B?NGNadFRsVGpqWk4zTWxqNkFMc0pHT01rRXNCQXJodmlKU2ZReHJycnpLY29G?=
 =?utf-8?B?SHBSbStudGFkYTRZMlZndURXK3JFcnVZRWhCUTRRNWZSQlN5M3BycVUzR0Jv?=
 =?utf-8?B?VzdFaENkd1pTL0xWSTFZajNEc2lhOFVyZ3pJeTJLMXVwRDUvbTFpd1VIejB0?=
 =?utf-8?B?WjFybUxZOEZQTnpnVkd3a0JMQmdFTTlvQU1LOU9PZ01wdnBwTWxYWDJHbVE3?=
 =?utf-8?B?MmRKam9NRE5ZTlpraU4rbFpBT1JZYUlTcmJ3dDdKSVhYOHBUdVUzcDMzMlR6?=
 =?utf-8?B?QjFWdTR4L0pOMUg0YUd6TGxIc3llYVAvZ1gyeE04RisvWDVDbFBDS082ZnE5?=
 =?utf-8?B?RVVCaERoUkI5YXNRYmxrOUxmc05nVXdCakxvcFFXYWhDVm1vWHNOdDN1K3cr?=
 =?utf-8?B?THdBUkcvOW9ZeEZBb0Fhai9jbHVneGo1MXgyMSs1aEsyVFVXTDJDT3M5Y3NS?=
 =?utf-8?B?SDVIZjNUQ20wNU0raFRqSjVwaDRGaWxlbkdoa1FHZFFaNkxGNXNEeEg1QTVP?=
 =?utf-8?B?NjJPZDBDZkZsbUtURFFhM1R0SkFpMG13YjA2MFRqSWZJR3FxT2hTaEJHd2Vp?=
 =?utf-8?B?akQ0cjBiajdNdEF1RGNVRXlLbmNYakhsQUhGOGt1Tms2c1Nmc2Rkd2RDaFlh?=
 =?utf-8?B?aUE1T29JVklBazUvcGN1Zk10eklVOWtYVjZVeDNEYVFzcG9hN29IK3YvOVh1?=
 =?utf-8?B?NUlhYmZNUHlsa3RIWCtlS1dYRmx4VEhKcVRYTjd0YXlzYk5US2JnaURDeEFF?=
 =?utf-8?B?cEJTTEQzT00zbkZFWFN3RjVSRURFYUdGdEdaMEk3WXY1TGpMbjNwNW9ySmlz?=
 =?utf-8?B?cnlkOElGbkV1MHpPSm54bXFwTy8wZ3F4eDUybGZLRmM3N1BMYU96V243VUFC?=
 =?utf-8?B?WGVzN2NsZGxTY00vYXFoNUgrbm0vMUNZVlN6VWQ5VWdwZStra2dNcXNWTGJS?=
 =?utf-8?B?dzdmNDZ1WVE4eVdORjV2Znhoa0JqU2s0M1R6R2Vkclg0ejBpYUdSc0ZBQmNK?=
 =?utf-8?B?NklKQXUvcGhEbGxRbTQ2ZHFUVnpncFZsbEdYMVpUNCs5QnRDQUZZN0hJRTJj?=
 =?utf-8?B?NTczbEtEaEVqRm1ybXBiTEhEck5EZU43eVVZSG0zNEhZTU1LRk9WZTU2TWFn?=
 =?utf-8?B?TmUrWGthQnRXbUZaTTQ3cndYTy9HZGdpSmhGbHhLNmQ4K2RiYm1yOTNjU2w4?=
 =?utf-8?B?dVBNa0JFUDNxRlloNzZqUzh6cTN4Ymk2ZlEzYWVHaEFxaXNkRlVtNkR4TjBW?=
 =?utf-8?B?Vzg3c2U0azk2L2h0ZGV0SHAyS2VLR3B6QXJuVDRIcDZkU1JZbjFoN0p6QmFi?=
 =?utf-8?B?OFlYUUhCYWVYK0ptbmVnOXdCVTE1V0tzcnpiWnJ6dFlIdzNPKzZTY0dlaGc5?=
 =?utf-8?B?SXdPNGZPaUI4bk15TjJ3YlpLdHhGMGRtdkdSQ2g3QkJDdmtRNHBOb1ZhZGlS?=
 =?utf-8?B?Q0pKcXZtcDVvUUs1cnF5VlJxdkhBR2JldEx3Q1d6OVlCajdBdEk2YlN1bXhR?=
 =?utf-8?B?amwrV2V1QUZSM0FVN0xrU1NxUTVpQXFSeWhuSDdjS1RTUzBWTHlWaHlFaTI0?=
 =?utf-8?B?aHN5ZFErZXRDZVVicklCVFc4dVEzMmVZT0p2N3JUMWVlb3k0dmRFL1cxbVdS?=
 =?utf-8?Q?OjqegDYYdb0+LU4V66LtTnCmu?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4PH9lKngZ0voKFTJTL97g6XwNWHKKYx2MXc5kw5XyMY733srKAbjVoSCO0ZmWUzXqBQ037+5nylR47wXGjq+J2W5pDHcAo5umSIp0QQzPxdLBTsZ12caChjBHA0xbviRzbebwOKVkKaXnKtjQlqBGINjhptkQtFpPrOd+xSsLsTlxbP4coU9UzjpLSFBbWFwNm+PcgHbHrub8rr7hF7m2w+7F9wL5kI9u5pza1C60cf+4hLfSdR0x0xBu0F+2GgFUOh41kf4FDZRzVwClKwSidEiPKco7lcrLOxvkeAjwJ0mwHvnah8PGHVAZucucd03WmFUW6YQxVXNvqY6kLCBf4Hy2T7Dqgk01k/G7Fl1zHrwtLIbS3H3sPYnD85/vTmW7+/0lAq6ouh/+SpbE9odb8/J77wggA680fsfKvxKvq6IU3IAZzSLMWgUR56eSh3CqqjPXO0mWjJzqW8FreI7BBUgKYlV0BZEd9kTT4H/LMQt5QSCRuMeI/Qdi4Zazs4OqmJGD3YtNqDjgVoaeWR3Esbsgb10p8nIM0ygVyExOYmXcq+pSLr1XZEUFeys+MIJAQbmk1rU0ficCYha/sV3GtsB1PC0pDB+pdRzGRzdf10=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6231a617-5da6-4de2-a94f-08dc26f9704b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 09:53:15.4768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRQR+03FsgFpr+bsMON3Jy21kAjIosIaxsTvIj+0uN6+h3rUNm+rgBefyrw9doD3jqbIG3vn9MdaKOBo5AEiKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7051
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_02,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402060069
X-Proofpoint-GUID: rBeKTRVceDt89ruoLuERqYpZqH3B2PmK
X-Proofpoint-ORIG-GUID: rBeKTRVceDt89ruoLuERqYpZqH3B2PmK

Hi Dave,

>>>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>>>> index 18c8f168b153..758dc1c90a42 100644
>>>> --- a/fs/xfs/xfs_iomap.c
>>>> +++ b/fs/xfs/xfs_iomap.c
>>>> @@ -289,6 +289,9 @@ xfs_iomap_write_direct(
>>>>    		}
>>>>    	}
>>>> +	if (xfs_inode_atomicwrites(ip))
>>>> +		bmapi_flags = XFS_BMAPI_ZERO;
> 
> We really, really don't want to be doing this during allocation
> unless we can avoid it. If the filesystem block size is 64kB, we
> could be allocating up to 96GB per extent, and that becomes an
> uninterruptable write stream inside a transaction context that holds
> inode metadata locked.

Where does that 96GB figure come from?

> 
> IOWs, if the inode is already dirty, this data zeroing effectively
> pins the tail of the journal until the data writes complete, and
> hence can potentially stall the entire filesystem for that length of
> time.
> 
> Historical note: XFS_BMAPI_ZERO was introduced for DAX where
> unwritten extents are not used for initial allocation because the
> direct zeroing overhead is typically much lower than unwritten
> extent conversion overhead.  It was not intended as a general
> purpose "zero data at allocation time" solution primarily because of
> how easy it would be to DOS the storage with a single, unkillable
> fallocate() call on slow storage.

Understood

> 
>>> Why do we want to write zeroes to the disk if we're allocating space
>>> even if we're not sending an atomic write?
>>>
>>> (This might want an explanation for why we're doing this at all -- it's
>>> to avoid unwritten extent conversion, which defeats hardware untorn
>>> writes.)
>>
>> It's to handle the scenario where we have a partially written extent, and
>> then try to issue an atomic write which covers the complete extent.
> 
> When/how would that ever happen with the forcealign bits being set
> preventing unaligned allocation and writes?

Consider this scenario:

# mkfs.xfs -r rtdev=/dev/sdb,extsize=64K -d rtinherit=1 /dev/sda
# mount /dev/sda mnt -o rtdev=/dev/sdb
# touch  mnt/file
# /test-pwritev2 -a -d -l 4096 -p 0 /root/mnt/file # direct IO, atomic
write, 4096B at pos 0
# filefrag -v mnt/file
Filesystem type is: 58465342
File size of mnt/file is 4096 (1 block of 4096 bytes)
   ext:     logical_offset:        physical_offset: length:   expected:
flags:
     0:        0..       0:         24..        24:      1:
last,eof
mnt/file: 1 extent found
# /test-pwritev2 -a -d -l 16384 -p 0 /root/mnt/file
wrote -1 bytes at pos 0 write_size=16384
#

For the 2nd write, which would cover a 16KB extent, the iomap code will 
iter twice and produce 2x BIOs, which we don't want - that's why it 
errors there.

With the change in this patch, instead we have something like this after 
the first write:

# /test-pwritev2 -a -d -l 4096 -p 0 /root/mnt/file
wrote 4096 bytes at pos 0 write_size=4096
# filefrag -v mnt/file
Filesystem type is: 58465342
File size of mnt/file is 4096 (1 block of 4096 bytes)
   ext:     logical_offset:        physical_offset: length:   expected:
flags:
     0:        0..       3:         24..        27:      4:
last,eof
mnt/file: 1 extent found
#

So the 16KB extent is in written state and the 2nd 16KB write would iter 
once, producing a single BIO.

> 
>> In this
>> scenario, the iomap code will issue 2x IOs, which is unacceptable. So we
>> ensure that the extent is completely written whenever we allocate it. At
>> least that is my idea.
> 
> So return an unaligned extent, and then the IOMAP_ATOMIC checks you
> add below say "no" and then the application has to do things the
> slow, safe way....

We have been porting atomic write support to some database apps and they 
(database developers) have had to do something like manually zero the 
complete file to get around this issue, but that's not a good user 
experience.

Note that in their case the first 4KB write is non-atomic, but that does 
not change things. They do these 4KB writes in some DB setup phase.

> 
>>> I think we should support IOCB_ATOMIC when the mapping is unwritten --
>>> the data will land on disk in an untorn fashion, the unwritten extent
>>> conversion on IO completion is itself atomic, and callers still have to
>>> set O_DSYNC to persist anything.
>>
>> But does this work for the scenario above?
> 
> Probably not, but if we want the mapping to return a single
> contiguous extent mapping that spans both unwritten and written
> states, then we should directly code that behaviour for atomic
> IO and not try to hack around it via XFS_BMAPI_ZERO.
> 
> Unwritten extent conversion will already do the right thing in that
> it will only convert unwritten regions to written in the larger
> range that is passed to it, but if there are multiple regions that
> need conversion then the conversion won't be atomic.

We would need something atomic.

> 
>>> Then we can avoid the cost of
>>> BMAPI_ZERO, because double-writes aren't free.
>>
>> About double-writes not being free, I thought that this was acceptable to
>> just have this write zero when initially allocating the extent as it should
>> not add too much overhead in practice, i.e. it's one off.
> 
> The whole point about atomic writes is they are a performance
> optimisation. If the cost of enabling atomic writes is that we
> double the amount of IO we are doing, then we've lost more
> performance than we gained by using atomic writes. That doesn't
> seem desirable....

But the zero'ing is a one off per extent allocation, right? I would 
expect just an initial overhead when the database is being created/extended.

Anyway, I did mark this as an RFC for this same reason.

> 
>>
>>>
>>>> +
>>>>    	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write, dblocks,
>>>>    			rblocks, force, &tp);
>>>>    	if (error)
>>>> @@ -812,6 +815,44 @@ xfs_direct_write_iomap_begin(
>>>>    	if (error)
>>>>    		goto out_unlock;
>>>> +	if (flags & IOMAP_ATOMIC) {
>>>> +		xfs_filblks_t unit_min_fsb, unit_max_fsb;
>>>> +		unsigned int unit_min, unit_max;
>>>> +
>>>> +		xfs_get_atomic_write_attr(ip, &unit_min, &unit_max);
>>>> +		unit_min_fsb = XFS_B_TO_FSBT(mp, unit_min);
>>>> +		unit_max_fsb = XFS_B_TO_FSBT(mp, unit_max);
>>>> +
>>>> +		if (!imap_spans_range(&imap, offset_fsb, end_fsb)) {
>>>> +			error = -EINVAL;
>>>> +			goto out_unlock;
>>>> +		}
>>>> +
>>>> +		if ((offset & mp->m_blockmask) ||
>>>> +		    (length & mp->m_blockmask)) {
>>>> +			error = -EINVAL;
>>>> +			goto out_unlock;
>>>> +		}
> 
> That belongs in the iomap DIO setup code, not here. It's also only
> checking the data offset/length is filesystem block aligned, not
> atomic IO aligned, too.

hmmm... I'm not sure about that. Initially XFS will only support writes 
whose size is a multiple of FS block size, and this is what we are 
checking here, even if it is not obvious.

The idea is that we can first ensure size is a multiple of FS blocksize, 
and then can use br_blockcount directly, below.

> 
>>>> +
>>>> +		if (imap.br_blockcount == unit_min_fsb ||
>>>> +		    imap.br_blockcount == unit_max_fsb) {
>>>> +			/* ok if exactly min or max */
> 
> Why? Exact sizing doesn't imply alignment is correct.

We're not checking alignment specifically, but just checking that the 
size is ok.

> 
>>>> +		} else if (imap.br_blockcount < unit_min_fsb ||
>>>> +			   imap.br_blockcount > unit_max_fsb) {
>>>> +			error = -EINVAL;
>>>> +			goto out_unlock;
> 
> Why do this after an exact check?

And this is a continuation of the size check.

> 
>>>> +		} else if (!is_power_of_2(imap.br_blockcount)) {
>>>> +			error = -EINVAL;
>>>> +			goto out_unlock;
> 
> Why does this matter? If the extent mapping spans a range larger
> than was asked for, who cares what size it is as the infrastructure
> is only going to do IO for the sub-range in the mapping the user
> asked for....

ok, so where would be a better check for power-of-2 write length? In 
iomap DIO code?

I was thinking of doing that, but not so happy with sparse checks.

> 
>>>> +		}
>>>> +
>>>> +		if (imap.br_startoff &&
>>>> +		    imap.br_startoff & (imap.br_blockcount - 1)) {
>>>
>>> Not sure why we care about the file position, it's br_startblock that
>>> gets passed into the bio, not br_startoff.
>>
>> We just want to ensure that the length of the write is valid w.r.t. to the
>> offset within the extent, and br_startoff would be the offset within the
>> aligned extent.
> 
> I'm not sure why the filesystem extent mapping code needs to care
> about IOMAP_ATOMIC like this - the extent allocation behaviour is
> determined by the inode forcealign flag, not IOMAP_ATOMIC.
> Everything else we have to do is just mapping the offset/len that
> was passed to it from the iomap DIO layer. As long as we allocate
> with correct alignment and return a mapping that spans the start
> offset of the requested range, we've done our job here.
> 
> Actually determining if the mapping returned for IO is suitable for
> the type of IO we are doing (i.e. IOMAP_ATOMIC) is the
> responsibility of the iomap infrastructure. The same checks will
> have to be done for every filesystem that implements atomic writes,
> so these checks belong in the generic code, not the filesystem
> mapping callouts.

We can move some of these checks to the core iomap code.

However, the core iomap code does not know FS atomic write min and max 
per inode, so we need some checks here.

Thanks,
John


