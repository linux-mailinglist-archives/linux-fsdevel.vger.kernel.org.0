Return-Path: <linux-fsdevel+bounces-14353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9188287B15E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 20:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F42288E52
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Mar 2024 19:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935A16350D;
	Wed, 13 Mar 2024 18:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="flm0orjv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qhC4Ji5v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2121A38C3;
	Wed, 13 Mar 2024 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355291; cv=fail; b=clpJZtJOzaMJcL4rE1sFt/uchZMe4Cu+5BKk5foCoangiIwKPflZ8ZWUQVbd/bpnXxHVdmaAqKHG775jKqKTH2/Efa91veEpbozxV22PYlHPZXB4UdW+izXOSp/zeiby/gUQmGgC8sG+X07mV6HfYzNCozrq94uekLVcXiEmA2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355291; c=relaxed/simple;
	bh=zXNgd5vL0dE0Cj5OTcrUqOTeHkkOH/3PcOduUM0yy7I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ryRHl3M7p6/OvgiBISjV89Dh4zYjAO/MhblEUEGhTSiCLAEhDlboeEImNZ0eMYdcSwmVcROrE2TAlpeUfSayR9tHdmxa/kknKDAlPwGJpxp/sfeOFijWbH104hM6uPfHhiNAyXxquC7QCyCpXy7ap/pGe0FnmUUxeteTpH/wNYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=flm0orjv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qhC4Ji5v; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42DHxd4r022142;
	Wed, 13 Mar 2024 18:41:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lJkY/+T6J/1Fyz2mB8gOdqFRsQ0HJYrFjwY+9sK/HMA=;
 b=flm0orjvrGnSX+Ppp8+ij1PZdMamp7WRWPpMqxYSuTjwBBw/llMIX0/A0deTIagEmpgm
 XKQzFJ9WmnQv9xtH4Yo17ncpoobwyqI8pM1YWG7jOZoZrAK+NIVB/uYZlqtSyxCG++eg
 WoklbLvXh0jiaQV3ghJk8anMnGrECCelr1qsJ6O+sDvR16GZuA/I4Pxu9VcFo+3blWYa
 lNf5v1k2tuRHWJtQDXo4yMi8bQRN5auQUXiMhIwemPZuaLxFgOCJWonAnG/Y53Ykh6z8
 1KBqWVntkR0rFd+GUa6T/4EKQIeoaPlJOyvTPuAjT3oo3Hw/5kWYO+wqrSAPaMXz9uR8 ug== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrepd1meh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 18:41:01 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42DH5ul7038449;
	Wed, 13 Mar 2024 18:41:00 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre798p6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Mar 2024 18:41:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMRUqHwwXM71onhXJ0hNgyCnNX85GeqWP5xBL0/B2NsNscFmQ94Od0ziZUUt99yfW+ImSlQN2PuDhEpBI4ODfV+tlaoasTxV+eodYE9rgJx+i3Rb0l1bEPenieS4JOvML+wbD3zKwzQGNjNPPocjP61Myg39NuCU2hPp4M2WMU/wyNZID5g3fUohvSD8zcTtpkoQvJ2V7MHBkLDtosOFcRRbKwxYY1Nab30kFnvb4li1AUu1U9xAOyEx+DtSG2CIDlPpI2PuYWDrkMeeTgpnkYvJOGmmP+KREanG72adxBi0vWLuvwiZRleR6SvijVryV5rXh00Jf4TfVR50r7kvUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJkY/+T6J/1Fyz2mB8gOdqFRsQ0HJYrFjwY+9sK/HMA=;
 b=Q178uYZannbZGabA75lzPV3gGtVqRj6ISaghXpHgwy+4kja/Mg8Qu3giH0zd2geJvxDOq+Rijv9NZgwQmNcIpyGw8UvjjGKod++OQp0JrJuQaFdHXaHZWh3o2YI+49JiQliTCv9KTiF2/WHYV+1KI04RjoEvLOwV8EWhdEK1rpyL08ZaAebd975IfCNvaTvQmSDJZQI8M2YX0MXrCvJPlM9f4pC3UEhTM2RTT8Pg2RbgfgrWWPbqsTFG0YlDBESuoxAGGtgTORoCUafVLXKZk/Qsp59qzm3sIelojr73VlcXedwji64lD+xEjVfHKNQ6scCJzYiGjgoGuZbCfGvLvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJkY/+T6J/1Fyz2mB8gOdqFRsQ0HJYrFjwY+9sK/HMA=;
 b=qhC4Ji5vX4ZAulKdIZkhvUW/YT1C6wstpdyjxwqCXe8qhk/L2YMy+3qEHJHI8tZI8AlTYDlpXbQ9mSqnWuANas2bcBdGLmcrlNky8YAhXlAe2yCbXSnh96Rlapctvzn3MshjsPVf5l/+LR+nE+HlFYZrthdlggOnc+VvGU8JN/A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5139.namprd10.prod.outlook.com (2603:10b6:208:307::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 18:40:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 18:40:58 +0000
Message-ID: <9fdf92e9-ad77-4184-9418-8a209e24ec20@oracle.com>
Date: Wed, 13 Mar 2024 18:40:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] ext4: Add support for ext4_map_blocks_atomic()
Content-Language: en-US
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Luis Chamberlain
 <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>
References: <e4bd58d4-723f-4c94-bf46-826bceeb6a8d@oracle.com>
 <3a417188e5abe3048afac3d31ebbf11588b6d68d.1709927824.git.ritesh.list@gmail.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <3a417188e5abe3048afac3d31ebbf11588b6d68d.1709927824.git.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0223.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cd0f647-77a3-47c8-b682-08dc438d1f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	q9WEEfRZ/JpJ6e1DIvTkG9E3KJFCd0WPpl3U/k6axKC8wFoGFrgeefEKv9MwvTi0xKkmwxquZ3XvPOl1jHtO664TUi3o1zGATm7Q+Eb0ARuCiq7LVFO6ckvfnEWWZO0hyIEci/20cJ3i+dC4m+Igb4DjFx9xtW+D74ZnXsqWJsQaFfXQP+K/zkeEEKEZBzezsd4rMktGBKPdzNYoYqzW1cJUFisWsJ0+QWGZylOWOg1OMsQ+1rHO4jkMSQoJy61TOQG26wMvyLk68e3qe/GJ9GMC8wYNDPlXwhR5jBPZB7KTrLDBA2aBNHdh6NARLKczjOCyi9ZlcgKFVkYU0jzz5WtuYu+auoMkqGA6MxzLfLdNDlIuG9HU9LQtuih1kmxupw6mD6DpgR5JkMnHQScmmpEy3bKeYV9NSpArwcn6qVfWLxfc4YSkBKHvr9UOqIff30BpFyOl+gv7OJweg7kkKP8WsWWKuOXARMF28826Qc23+AUClcRHKHyDufMJxnBs4HETRPw/xUe+cCW0FGFnuXyfMEOTfyh3gfrNGQpvH+hgjll0tM18YGlLV+bBA26hsMC7TAxQInypqJRmbPhAk7JGyXSWblEy29bz9ci+LvtHBxqUjztdvu8BvcJDNMPb
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QTR0ZjRrN1djM256RDRpT0UrdzlTOUVnTmNhVkZ1c0pNQjUxVTZWYndBZXJk?=
 =?utf-8?B?OWpCNGIxY0VLNUhYSXk5RDM4UlBsM1BMVTJIK2xlbFA4Ky9ZUlkrWjkyY1Ir?=
 =?utf-8?B?WTd0ZTBCVmtScXpRWXYxOXBwTkFKZEVGWnlGNVVsQ0Y2eWwwNWRrR2wvVkcr?=
 =?utf-8?B?N1VvcFQyL3l0MGY5YXFaaFBQYTJSdURCZ1QzRFpBODNBcW9TOVViQUYrT1Az?=
 =?utf-8?B?NUJ5cUxzN2ZZYzJXcG9NaFdxWDBjZG5rdGJQUjdEb3hGY2JNMzlyeS9qRFFF?=
 =?utf-8?B?Y1h6OUlIRm42NThTOHJYR1FnSEwyRlVtei8zNWlxSjZJUW4xRDRxK1lRNzE1?=
 =?utf-8?B?N1dkdlE0Uis4cjN5ZHh1QnpkemlEU2hZKzNLclpGb0Q3OGVKMDgwL1Bud29a?=
 =?utf-8?B?R0ZtNzAvL0d1ZXVoYlFRRFJQZEdzMnJWSkpaRWR1YTNOdkttRjNJQzBySU9L?=
 =?utf-8?B?TGZ1VTZ6V2JBQXVtSUxXM21mSVh6dlpNbC9TWmpvWm95SEpmWnRkS0kwVlEw?=
 =?utf-8?B?dHhna1JNVEpUcGpyODZDNlpaU0lYK3djSlA2QlRrbHNRUGNkZnpNMmh1VUJI?=
 =?utf-8?B?bzdRd0orWFk4d2h5NWQ2UVc4cmFnVExaY1gydDJKV3ZjNmM3aVB4dUZQblFv?=
 =?utf-8?B?bFZ3WkJIMmYvL1lVM0xoeUQ0clU0UGphTVI2cDdxSnNGMFhxMnVlOGtJNG43?=
 =?utf-8?B?U3RTTUw5VXdXMUo3SGZ6QWdmcDMxcGNVbjNIT2VzZTdWOWZhR0FPQnBTdlJq?=
 =?utf-8?B?a0FwVzZ5Ti9HVUxIMU1XUWxUWWZMWGxES1FKM1RYenJzejVSUm9LNVJXNjB6?=
 =?utf-8?B?NmQwZTNEd0d4VmhHcVY0WGVrNzY3UzdiY3B4c1ZPTnhiZlhVeEhPc25MQm1o?=
 =?utf-8?B?UThkZ0pDMkNKVUVFeXZTMGYybS82bVhrVmV2Nml6Y3dvcGRrRzVkSGNxVThq?=
 =?utf-8?B?eU9jQnVPckNCZnh2ZHJiZ1JQbksrbU9zM2luRGFIbm0vSGdQY3JpMzd6ZFh0?=
 =?utf-8?B?cWxWYndKUlZLQ05XSEkzVGlCNld5bGpBRlFQVUtTOFlEWmdrZzFGbmhVSTlh?=
 =?utf-8?B?QUsydnlqNStvQWRyOEM1Wkxhb0U4SzVBbHhvL2ozVVlIY3ZVa1k4Q2t3RERI?=
 =?utf-8?B?QTd3NDJUc3FmZDBHaTROUTNVREc1R1duRTFyRU1oTGMxQnozRlprMWNUS3Ey?=
 =?utf-8?B?MXdHSGJWa1lUeVdFQng4UXRZMHpxVXlkaGxYaWxZcWZvYUQ5UklDU3pTamZI?=
 =?utf-8?B?NzlBV2xOS1hIM21RN2pwTElFZmJrWU5WSWNQdnJoTW5ndXVOOTJVYUs2REU1?=
 =?utf-8?B?S2MxRWNObTRSNGNRZzRyVnd4bTNyWDIvTjcrZ3pVQUs3ZjdsWTFidmlZZVI3?=
 =?utf-8?B?UkZiMkNHQTI5ekYvSldGOW53RzBZeXd6LzJDQzgvVnVEeDRnZ3hFMFEvb29O?=
 =?utf-8?B?Zkh0VHY2QjFoZmdZUzVhdUFFak9tVUdjZzdFR05lRlRmL0FBWjVMUVc2OEoz?=
 =?utf-8?B?YVkwZmdpYUpLd00vNWNmQSt3Zmo1bVVnMFVRVVBUaTVWWkRjbW55aisrT2Zk?=
 =?utf-8?B?T05INnUyQ2hQVUZoUHFhMGRxcnBvaXQ4MVNGNzZnL0NiemtXWHdtcmp1bXl5?=
 =?utf-8?B?VDRYZkN4WlZyVjM1Rnp0ZXhPcUJUZUxSdlU5V1ZiaE1KWGNNU0F6T0t6VG5k?=
 =?utf-8?B?cE9IQ0NlMkhERHB6cGdlNVJjWGNrU2xvdTF2Z2Q4aGNCM2laVURUYVd6Rk4w?=
 =?utf-8?B?Y2lNVlhDblNSSWlGdUxNdG50ekNSblNIUmhyZmlsQTh0TjNnVEtRdnAyZjI2?=
 =?utf-8?B?UVRiT09wbkFpZXdJUWVqSHd3T1NTekpVKzVZYTJFVTV6b0dqRXI0RkdFcmlO?=
 =?utf-8?B?bXlOZFhHaWlzN0k0S0dEU0NXSkRDZjFXS1FCV0l0b3B5OTNRcjQ4Qm1VS0g3?=
 =?utf-8?B?SklTenZpMUVuZXRKbTA1Q3lTRnZmMlVvckFCY0l5eEtLdlNHaGVTbnRDbk9J?=
 =?utf-8?B?bXhBcmg4SitrSFR0S0dYb3c0N0ZIRUF0WHFPZGkyQnJ1TnpPUVVRV2EyeUgx?=
 =?utf-8?B?b3o1QUQ3TmZ3N2E2STFDOFhhR1A2MHZwZTQ2QTNpb29MWWo3SHJvN1RPdEx5?=
 =?utf-8?B?NG8xNEQ0MGNoVjA1RWh6Wk43Z2tCTVBSdG5hMTQvU2dBQzNtWlVaSXE0dHVH?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	f9Y4crBH3OjBspOIv82bY4SdR5iqb2QlLBvQD1F5P7F5pqGtqEsVojP0rjYl4/ZnX6glURO7eUL+XelIYmFezrxJ1lZtBLCDXldFr9bBjOR3M4QsbOXcQ3iUSSifINO9RUG+mEHQW3SC7ldv04boE/hQGQHDHBP4S1WC59IHPfIsc47Be7e4VDDxnByc3vvD341Q3dGO4omL1LcUXDNHnRkOkDpzwZLgf6aGy+OcbMlpHW/CvOFfyrEpd1xm0LAioQNNtl92548b3NAeuBREI6RQq3KozAyrSLrQapF+9jIqqxcBng/sF3Tlgq+ANH75W4Bt+HlzF3mdzeu7LOBOtF/yrDpReigklbZ964QdTHYlKguYiYv9rs4fGybEAixJfxMOS/xpeUnw+K2iA+dSmMeXPbmWSZVBMXuIuinUV2DzP+7lW1VD/0ty/5BltXg6hOJerzJtG7iTNlNJFvIXra+OebivYe2GvN9CPeWhAH2moJFsdAGRb/o+8kKCWSaEnjUF6TxnassmUV9D5uQggg/KIO14AF/86HOlKXRi3atIV+KuiLtwd4EttLTldAh0a17xpOIUlCnnH7TMOOBRHI4HbDqjr5KnnGomDHhF9G4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cd0f647-77a3-47c8-b682-08dc438d1f72
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 18:40:57.9966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IT9aGkXAkvoJEiejJjCanUOURo/waghsV+emYmX5HnHKwwYVsJO78kavDzSQf2FrUheUA77tD8cbA6/A+v3qKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-13_09,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403130143
X-Proofpoint-ORIG-GUID: GRwdCk6eRfdZCC-IUFDrl4KfNjT7CSXL
X-Proofpoint-GUID: GRwdCk6eRfdZCC-IUFDrl4KfNjT7CSXL

On 08/03/2024 20:25, Ritesh Harjani (IBM) wrote:

Hi Ritesh,

> Currently ext4 exposes [fsawu_min, fsawu_max] size as
> [blocksize, clustersize] (given the hw block device constraints are
> larger than FS atomic write units).
> 
> That means a user should be allowed to -
> 1. pwrite 0 4k /mnt/test/f1
> 2. pwrite 0 16k /mnt/test/f1
> 

Previously you have mentioned 2 or 3 methods in which ext4 could support 
atomic writes. To avoid doubt, is this patch for the "Add intelligence 
in multi-block allocator of ext4 to provide aligned allocations (this 
option won't require any formatting)" method mentioned at 
https://lore.kernel.org/linux-fsdevel/8734tb0xx7.fsf@doe.com/

and same as method 3 at 
https://lore.kernel.org/linux-fsdevel/cover.1709356594.git.ritesh.list@gmail.com/? 


Thanks,
John

