Return-Path: <linux-fsdevel+bounces-2614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86C8A7E708B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2B3BB20F3C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07693032E;
	Thu,  9 Nov 2023 17:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="t1M02Bz1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hPkqPhkP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8DC2031E;
	Thu,  9 Nov 2023 17:42:05 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71B3D58;
	Thu,  9 Nov 2023 09:42:04 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9DswEn001292;
	Thu, 9 Nov 2023 17:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1obnCMoh9CwixxQYhHlR5bdxEKW/MAWVH0VkImkazcs=;
 b=t1M02Bz14bjTwq4KCoAq6ItZg61i3tpQG9AHnm7vXe4QgN48/9OSp2CLRp/aiTsAVwb8
 emkJStVF/SvTtafQ/rsoM4U2mbV3PaipCKwOkyvityndnilD3nYz4tj/NcG5UPkiBsOj
 KU/m0Fd1vCjjOXI77I/QJHnRRPB+WN5K9mYvVDi/LV3xBDAQDDkioavhIA6u+YEksIJ0
 TTCMfyFzfIRxppEysuW78zMSL91F1p88nvh+AAZGgNzx4TIuDag1JhI8Llqp68awL6xN
 nZPfFGhiCJ7833wovz6LpgSgVeQrsJyoS9GWV9uSI3TNN/wiFReKtaqIg8I8AAMjEdnF 4g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w22mfw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Nov 2023 17:41:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9HYdUa000536;
	Thu, 9 Nov 2023 17:41:49 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1y9nnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Nov 2023 17:41:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7clEOuHjTD7UfDoqCVfJAcz2WujCR5nVMD4KI7JjcWuxPgp24V84/s3BRW4Y2q/DvBMpijwSfYwVlKqPMPoMdz6Tvf24/zh+sxak30/kmmJp4C55Wj4npeYSnsgzCUnhGBnw2imAYN0Fd0sZOktrkciAhhuBoof2UBYi1ystdnp03WHHiKkX6bsC9bCF9O0Si5NPNUttpKWvtGZYMpDfEic9eZ28NdVH7aagexGCVeqIhWyrHOPK84kISqNMRHvTjWyAf1dHep6X+OIhB9Mqcr5a6uqXZLFOmUqd246+QqxaZ4wE6dTBx2WiRndQf5qBNfUsYi9c/12ToiDwQgvKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1obnCMoh9CwixxQYhHlR5bdxEKW/MAWVH0VkImkazcs=;
 b=PMOz53GABubemFbbHvcOk4XS/bogwQHH3BT63Wx73sJRceYH0hML86FW8oHqqFNyo8bxuWlBv0k6rADXLG1CLeXUrDI9UpqvzI3tjTlfHQ2YSy/1lkLkK8N8dmXHoZG6To5qvJhWxhVu1IeCLwMGKAfuFUgt2YEypojmu9JrmvyWcw9DYghxJ9XfVv3niHRRBA4nnIXOPNBNDdbRoC8vJZIBD0UvigYzHftai3xQIj3ZaEym+ejbBBs/RVMBRUM1MVtVQkzNPySuVX0yMeQ8nFQ+fablkU1NL9lo6YV1hpQxZfCOJzn6sKNwqHxTM11nek0ZUQUYXWUOxIAPUM8ZDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1obnCMoh9CwixxQYhHlR5bdxEKW/MAWVH0VkImkazcs=;
 b=hPkqPhkPyaM2rDn48YffZsRl615Ott6UsVdAffbxz68bvi4XyICkfv6L0V4ISAIdB2W1FDUKCDRo95LMX/NHMGvrAAIkG785o5znqIxESu7Zh/AQcI5xGPUDspTg3C0A5WJeqnGwQbVO4FePP8dxR8u0pdMDGFPzYaruh4wgoqs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM3PR10MB7948.namprd10.prod.outlook.com (2603:10b6:8:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Thu, 9 Nov
 2023 17:41:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 17:41:47 +0000
Message-ID: <194b7114-2c2c-65c1-c7cc-11312b422209@oracle.com>
Date: Thu, 9 Nov 2023 17:41:42 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 02/21] block: Limit atomic writes according to bio and
 queue limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me, jejb@linux.ibm.com,
        martin.petersen@oracle.com, djwong@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chandan.babu@oracle.com, dchinner@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-api@vger.kernel.org
References: <20230929102726.2985188-1-john.g.garry@oracle.com>
 <20230929102726.2985188-3-john.g.garry@oracle.com>
 <20231109151343.GB32432@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231109151343.GB32432@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0325.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM3PR10MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a16e9c3-46b7-4909-faf8-08dbe14b259c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RQkjsaeK3sYcEF0drzh7ABcv3cOr7dMZhVklh3uaOnmL2fSrQWe/DJ9uFDWkXgSSM3V7F4uFY7mc54FD0bTX7emPW98kYHH81d1z8hy55JNQIyR/js5BbDEffNizwkwgWBHNhBpW/4MAhFNlbn6Qid9NpkI5XDo6CSSvcUDlzHqnQ1sqfCdy6Ma0Gkn7oQiFVvZdQWvMe3djbPJ2i/WQ/S0KlF5LzyTHAvFrh7ZBgTVbrVOeokhxsntncFr3lPCoeEBKZyrQIyMd1MD5/HZrTNuLDUDr4vaf6b59pO4Ve26+5DVBHk/Z5dv0vTAnXN+HDgjExjLqH+Jm2tmjVMVBek3acaECnL8wciqd8p9sW4Qw47cYsUUFXKLtd9rM514kpMxyoPfmuBDmQoAZczgxl/Mc42HY69bgYO/UcjMQ9kZGzzhW2B4zb8VYtsaCIqh19CPJEFj6aFXK6HK4U4uLO6+SufuU2MNxZgldlcGCcUOJocOVr6+6I+ZXASI8xqVSZKJM5OP1e2vEee1k9xaHdxow49wfcwgnaDagvVMlZaAFOohU/el8nktPqASzcmd55IJab5wESmsiG+6YogfRquVK6w3P3CluHVeAh23I9nq6vtXahs41c0jn4RgzfyL9RPzEf4oAoLAqe8NKCW1iyg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(5660300002)(7416002)(86362001)(31696002)(2906002)(66476007)(66946007)(6916009)(316002)(66556008)(8936002)(4326008)(8676002)(36756003)(41300700001)(26005)(2616005)(83380400001)(6666004)(6512007)(36916002)(6506007)(53546011)(38100700002)(31686004)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cFBNQWRMaHRTNXNlR0NVcnJSclh5aHluNkpmcVhCQ2xpVmREdUdzK1ptOG9R?=
 =?utf-8?B?ZjIzUzhwcThITThJTE9jWXJ5dDdNanltTHIxYkhoeXk1ZlNDeG0rVE02R2Fq?=
 =?utf-8?B?NjArdWVTSTVNN0hlOU1qL0t5WUdaWkhyNEFFS0JsdHJQejNGVWtEWlNuMjF6?=
 =?utf-8?B?NHVVcGlHT0svN29FbG1FR1hCcUVYVjhybTRjMmJoRTkzdk5TWHRudzA5UnF1?=
 =?utf-8?B?NTdWQXVneE5yVGZVanFOZDNnQVJXaGlmN05STWNIV2s0WmZnVUh3cVFHaVBH?=
 =?utf-8?B?QmExK3kwOUFBdlRRNGxaWkVPZUgwZHRtQzl1dDVzRlNGZlVJQ3kveG1CdnFi?=
 =?utf-8?B?TDdxdGs2UUVtcTRpWWRoU25PU3NRRTd3ZlduSWRmK3F1cHlnQlRPNElrajlv?=
 =?utf-8?B?cXdvcUtnRm8wZ1pEUVZVV3dNb1ovbE1veSs5eHFVL0doeUpYVm5YYjVhSXZs?=
 =?utf-8?B?K25vUVJ0OFRSYjBRM0FYOUdoZ291REVycFlCTUFnbFlTcmhkMUZ6SUk5c2dC?=
 =?utf-8?B?cjNBOTN4NmlBMGVmVExoQWdnb3VuZjZmYzRTWVNYNDRPTy9EbjI4OE9SQVlR?=
 =?utf-8?B?NWdQUTE2SU1oSW56VmU4U1JJeUJ4T0JBTURtc3ZSOGk0TUdJcVRjL2VwTkdY?=
 =?utf-8?B?M01RMm84cVhhTy9ja1dqME52RFovQWxjaVBBQlIvU0d0TGlVUnR4am5yZWZG?=
 =?utf-8?B?NS9xelNzUnpvNFdmNmQ1UEdMWWx2NmZFRktYVWN5THNVeC90Qi84OEtDRmdX?=
 =?utf-8?B?d0FsWEZSbU5lbHRHKyswZVgyeWE1YjM3U2FMVE5WZnBhcFVyVXVNTFM5eURO?=
 =?utf-8?B?empCTXJSMVJoMnNKMDN1TFdaWUkvdHZKSUtnemR0RHlmRnJmQ0lvSlZrWGkx?=
 =?utf-8?B?WDhEczJ1VWRBcHRSWkpoaURRZkVhcnpOVjBramtWVVNjaWRIbWVxYm52SDF5?=
 =?utf-8?B?M1F1c2FVWWRjWU15QTY1NktTaHFZUSsyUXRqK3F1NzdtaFYwbXZmeE16ZExV?=
 =?utf-8?B?S05PRlJDeHlDOS81eURpUy90MWg5VXp3dkxDaE5iVWwvYjVTYVdVWmRFTXhC?=
 =?utf-8?B?ME1qOVZsQmdrVDlsT2VoemNZckVYTzhEWU1SUFNtL2NNMDgzQnpaNkVXMkNU?=
 =?utf-8?B?OGpSTmRmenBMM1ZZVjJEZTFBWCttTytVd0I3OUpEN2RYRUY1Y01EQkx5Yy9Q?=
 =?utf-8?B?T2dqdFVONlhSWVdqNFh2dTdNYndnWmlFRm1SNG9USDJpeXBaVzA0WVEzeU1I?=
 =?utf-8?B?TmNPVUdLTkd1eVI1WjdrWWZUM0JZYW56bzYrb01zZkw1TmFkbjJxbjVkVnNC?=
 =?utf-8?B?bUxHYTBlV0dJV0xXOU51Rm14cmoxUktERTNHSllreFFQQUlPbjY1SURlRFJS?=
 =?utf-8?B?VFBKUGg2R0hXenJacWhKYXRPSzZIS09OU0RNOXNyclhyVU5JU1hBWVM4b3I5?=
 =?utf-8?B?SDl0U0FhQWRHMGJDQWFiKzc1Zlk1VUg1U2NZNjRhZzZwRXNWQ2hXMnpzek1u?=
 =?utf-8?B?T0dCOFZvNWEzbkppd2xqUldyQkNKUU1ncERkRjdwU0MzRmtwWEp5cXBpOEVj?=
 =?utf-8?B?WHluT2tYaXNmemhIY1JhQU1NMmlLeDZ2QytJUHNYVzZJYjhNMWVHMlF2U2py?=
 =?utf-8?B?ZDl0LzE1SHhHTm9UZWhlbnR6ZGs1UG1CdHhIN1N5bmUwOEhFdmxZNExMU2xM?=
 =?utf-8?B?ZVZJMGlzbkVwM05lR3ZOczdZQjJjM1g2clZxU0lLNk03Q1FDUGdacUt1dkQy?=
 =?utf-8?B?OVhyTVpqbStoTE1SaFRtMWtqRUNaV1oxY2pGVmFmQU0yVjlGRlVSTFdiaUJ1?=
 =?utf-8?B?U282bm1LdDQ4VmlRNDN0VFhydXc5U1dNTnlOMngvRVlkUTkzRi9VcTRjVW0r?=
 =?utf-8?B?S29Hc2o4cFpGdHBSVHlEZ2FMeEgvUG9lZy9zdlFPRWZVTW84TElmeGRvYlV0?=
 =?utf-8?B?VUp1Rm9TWnluZGk5OHVMSG5DTzYyeXJ4bzFsb3laMThVQ29XSGNSSm5qQmc3?=
 =?utf-8?B?WFNPaUtoMm9iRUpqTWdtTE9KSzJ3R0FQZ1VLN0xMRm1DTHhUSm0wWDh3cHk4?=
 =?utf-8?B?TDg4eGg5TVQ5MzFqOWJyeDV5RHRFTGQ0cmJScE5kSFlxamJibUEvTC80b3dh?=
 =?utf-8?Q?QcskGhHesxcNbXV/vKQEIIUI0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?UWFFZ0VSaWxWUFRZVVQwUndySTZWR2pFTVBSV2dEb2lFMjREOUk4cTVBZFFw?=
 =?utf-8?B?WEIzM0t0UUgzT2tMYXgxU3loMllDZVZZQUJsYjJOSEpiUmN2ckxzZEhQRlFi?=
 =?utf-8?B?Z2dkdEFNblZRcTdOZHpiUDV0WHV0cXY3d3hFbS94TXpQUWFtelY3bXQyZG1z?=
 =?utf-8?B?UmhUVVVGWTFnd2EzcVUrYlNRTHR5YmRIZzlXRFFScjlESEtsSVFsTXMwQ1V0?=
 =?utf-8?B?VnYzaFFCNXF4V1JaWnAzWEx0QjZKd1ZMSjhYcXZURXdzL1I2S0JmWVlJL2t0?=
 =?utf-8?B?Z3RDUlVUN09yKzk0WjJpejdkVk9oUXRBRGU0dEhhODNTTHZyYkp4cTJ2bk1z?=
 =?utf-8?B?R3ljUUlObGg4Y1BrZithbDZpQ0NQY1F5VmRRQUNINklQNWZJOW5idlRWc0FL?=
 =?utf-8?B?YTRVemZMVkdJdlJVRTF2dFFkYUl2MkNLQmdmTGgvNzVNN1BEdzNvN0JUb2ZW?=
 =?utf-8?B?aDJJVUxxdkN6cERKQ2pRSWZtNVg5bkpONlFrZ1VKekR5VFFna0QycHBkODc2?=
 =?utf-8?B?TURwRDBDNGxVKzZLcFZGc3BEWjUweWt5eG9WQ0crRW84ZUZnaFE2bHh4c1Vr?=
 =?utf-8?B?WkJBeU1EV0hBZGV2K0lPTjVYSjV1V1lTcHNVOFpkWVRPTHdlTC81bkxibFFW?=
 =?utf-8?B?cE44RFhlZjlXc1R4a29ZaXJBZkpoUUJGK25wK0JmMmNOeHl3RXJVMisvZjBY?=
 =?utf-8?B?TW5aRzBhdmFSUk5NdGhyZmxRMTRrWXpXYjl0elViZzl2ajAzM1FiNDFSV1hO?=
 =?utf-8?B?N1RpdkFOU0Q1eHpzclJHdTM0T1d6Vklya3NvZzRSS1ZJYkg4NWlDZzhoOUJl?=
 =?utf-8?B?NS9YaXlBdC9xMllwZkY5MEpXdWM0dGRycmxuV2dJM2RiU1ZTcEZXMGNzVFAw?=
 =?utf-8?B?cmhUZ05mcUZCT0Q3SFJOSjFsZEo5M2RXSEFlallZc1FFYWpPSldpNEQ0V0Vp?=
 =?utf-8?B?UW5rRm1yckJ4dnhxMkphdnh4d1lKbjU2ZHE5QkFCcDB4MlJjUHpBMmhaWDRr?=
 =?utf-8?B?OFZsSmtqSW1waFEyWTIxZmtHTnVqVmpaUElRRWNoWTA5SlRlamJ5OWoxd3Iz?=
 =?utf-8?B?V0NlSGt6ZGViUExmRU92OVN4cVlZaFlhWDJEZDlJeHZLMW9nTjY2eWhVajUx?=
 =?utf-8?B?L0tQTEtUQlNGdXloUnQwTGdWQWFIZEJMT1VyejBBRVB3WnJDOHZ5TzRSQnNt?=
 =?utf-8?B?c1RXeHVvREVDU0FxUlBpZ3ZrdnVwTThUR0VTWjNnRG5UU1orYTZsOHlRdjFj?=
 =?utf-8?B?R1dTb3JLMDR1T2JieTBWeVZDdjBUQXVHZ1pycUtxUUtLc3lHSzlXU216K1Yx?=
 =?utf-8?B?c1dRSm8wVG0wTHNiS29mdDBkaUtpV09kWjlWbmhpRzlnOGFZVXBvaFJINGxT?=
 =?utf-8?B?d0pESytmaDNqYlJpNm4xQ2RSSk5NZmRZeW13VG90c2srMUpJQjdmbXJtbkRE?=
 =?utf-8?B?RUEwMWIvUkQxZk1MbSticjNTc0p2VlplMjNyRG9BPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a16e9c3-46b7-4909-faf8-08dbe14b259c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 17:41:47.4984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a71yk/+rJYXsTBTFUlo/K++QdSsMGAn2ZavsT0YF2+Hg3BYFdSA4011VtI8VEKIsf3e+fKOWLAdqvxXQERZBHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7948
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_14,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090133
X-Proofpoint-ORIG-GUID: lDk2RUBgL_UOXwuEccS2ojle-2Acl_Wc
X-Proofpoint-GUID: lDk2RUBgL_UOXwuEccS2ojle-2Acl_Wc

On 09/11/2023 15:13, Christoph Hellwig wrote:
> On Fri, Sep 29, 2023 at 10:27:07AM +0000, John Garry wrote:
>> We rely the block layer always being able to send a bio of size
>> atomic_write_unit_max without being required to split it due to request
>> queue or other bio limits.
>>
>> A bio may contain min(BIO_MAX_VECS, limits->max_segments) vectors,
>> and each vector is at worst case the device logical block size from
>> direct IO alignment requirement.
> A bio can have more than BIO_MAX_VECS if you use bio_init.

Right, FWIW we are only concerned with codepaths which use BIO_MAX_VECS, 
but I suppose that is not good enough as a guarantee.

> 
>> +static unsigned int blk_queue_max_guaranteed_bio_size_sectors(
>> +					struct request_queue *q)
>> +{
>> +	struct queue_limits *limits = &q->limits;
>> +	unsigned int max_segments = min_t(unsigned int, BIO_MAX_VECS,
>> +					limits->max_segments);
>> +	/*  Limit according to dev sector size as we only support direct-io */
> Who is "we", and how tells the caller to only ever use direct I/O?

I think that this can be dropped as a comment. My earlier series used 
PAGE_SIZE and not sector size here, which I think was proper.

> And how would a type of userspace I/O even matter for low-level
> block code.

It shouldn't do, but we still need to limit according to request queue 
limits.

>  What if I wanted to use this for file system metadata?
> 

As mentioned, I think that the direct-IO comment can be dropped.

Thanks,
John

