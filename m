Return-Path: <linux-fsdevel+bounces-11531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE8C8546DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 11:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10EB28744A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 10:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AD01756F;
	Wed, 14 Feb 2024 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CTUpYihE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V0OZZc3R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6010171CC;
	Wed, 14 Feb 2024 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707905439; cv=fail; b=KTw8j1gBe0kt2/FkP+D1BRsjTAuXqYZ6gJrx935+YCmlg1FzaXeKAUmbQ8yXUWNVaTkFy5ej6sd4IDlKJts4rzOQxr+XNyRDqvSOsLSvF3qVcTWBEoWHocCRUuF71x2Ji3Nijy6BIXkwdUTymTq0lSz7yZlaJy4j5NAZcrwQTlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707905439; c=relaxed/simple;
	bh=hMEaye55uzkhl0ySD4ysYmfq6ODgafd1Wh7T+/rIgpk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NePKuliYGlHtNltX1Hu/GdP45Jva4mNT0ifZlhRU3apwyD//YkXchh6CZ7RLSVQZ/QPoqbBDu2cewLDJuktsI4c/TFcwtte0CmlCoUJuVaVERyEUhcyJbG+nidKQM3Wesl0Am/MKCbuyCp4tljBQQtEBaZnQr3Wz3Zrz6qpZ7PU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CTUpYihE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V0OZZc3R; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41E8hgFH026569;
	Wed, 14 Feb 2024 10:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=TeeNR+mLAmN0ngp6nDkDWos5PF8HtQsviCiQem0is3g=;
 b=CTUpYihEHKeTCaRUsV2xU3XhDmnWnsQtXF1JEeNcm3GwbL8o0l4bWyVqKMDOYsfr2Qnr
 NTqnE5cRV+nEcDvHUs/uwjZFrvVDBHDY0UzJ9O/CwvU5JaL6ZKzmqjWqFMW4oJjncCQF
 2CTk5ASHUGodeHYGKwSdIQiutqAoXNYTKVf3u0l4Lt3R4ABKc20GUzm/lhEndxOLJerV
 YCoDmYgqr2o2v5lAMW3JveBca2JulGSgr1uULZibAEf3tKLAyWLeLb90I05WHi0qK3t4
 nYvPqLTxZPw5fzCV1w4S+HQGjj40wqKXDV2pP/MmgHjMvgfTTatdRG7spS7jZpgVtBuH qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w8scx0b2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 10:10:22 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41E9qNUD031672;
	Wed, 14 Feb 2024 10:10:22 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5yk8qg8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 10:10:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqbCcDzXozk+MRF/ZTEeYizptyNOFuf5UIY1Tlvl7f9f0nXEk2YTNg8D8WxtgqS7r5NES02PdSSx6q0pXxetxnzNexddRfEXR95BPFjUrGTsKxMjZNsftub/teuPbiGHjH0jtwTJE6gHam7Pad6wbZijtRJ078naP+MC9yHrHgZ+K+Fys80UbBZQDzE/0qA4n4Zh1/H1waQxyuKHjT8Js+Ot7FUJgGr7jjjF5hhbfFW8PczcUtOXzfX6grAiZb+VBDYAnu3+T52HDb1cT0Nb19eKvobJ5bYz/qZN4fhno2WwFpk+qHdAXbL+p1WubyWSALdXu8HHGWzYVLbgIpeyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeeNR+mLAmN0ngp6nDkDWos5PF8HtQsviCiQem0is3g=;
 b=fEZPvqLPZmQRFcsUanHKK5Mx4fsz0goHNxxKuqaP6nAREmJd+wpoIWRQnAXilnLqZ2jBXP0YeJ2Fxp5f5MvUPYrc2qZ8KCTOMBQt9GN79YO+z/MN7wjvf0B8j/DNHWEvk9pO+Ukt4K7aZ4gNToo14ykN9MPCnH2BCWQ5Gn2Le+8zhzVkCV/SoE3OEnry/s9xi20u0AMwkewYN9+eqsxp7k6AvwftDpqDptIbg52mkr4F3mHsjtwR5XdrzyMZeQ/Ntk+dkbW/A0qLDJOEpJdjbe14skbnRLmGMsKNVNVShPK92MqI3VoRYrWzOGcczim/6AtRn1nh+IKrzMqK885FNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeeNR+mLAmN0ngp6nDkDWos5PF8HtQsviCiQem0is3g=;
 b=V0OZZc3RrVn1LdgaAqUnKvKjUm+B6y528hXcf8mI7+G+cFvJJCaZ8qmLVYyll/wMLdq90rzh1Fk6UPnruXio9zOU3IDRaZ3b4vWtkMjThR1f5jH4gwnJlgyHmz3tncL/lLOMWUMlCJ0mGfbfTaw1vFxyWRvxcePbtV6UaJPDndw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB7499.namprd10.prod.outlook.com (2603:10b6:610:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.41; Wed, 14 Feb
 2024 10:10:20 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 10:10:20 +0000
Message-ID: <f7d8dd6d-3c7a-404c-9ccc-1f9904447667@oracle.com>
Date: Wed, 14 Feb 2024 10:10:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] block atomic writes for XFS
To: Dave Chinner <david@fromorbit.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, hch@lst.de,
        djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
References: <87cyt0vmcm.fsf@doe.com>
 <875feb7e-7e2e-4f91-9b9b-ce4f74854648@oracle.com>
 <ZcvyDnUoC3PvV+p8@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZcvyDnUoC3PvV+p8@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0528.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB7499:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf25e2b-e0d6-4682-f2dc-08dc2d45269d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VMboVpesB1lLiq0m8e0ZLAxaoDGWmPan8DZhjfIvKaO4HR5AIW/PFSfRZCr9q7fF2fDwe16jPq3gR77TA+luqSn493qXpK0zvGq5ydz7Kk/x6xhNOMy+XMN3A+zfekR5h5AYXG8GuulfW6ER/OETPhfabOKwN90+k/H/bntK+jR/UWDhQbxva0istDGmJ1wxxlMwfOIl2JLXoorzNhND7yLqQD8kOoXkIrExGS3HSBUb53LE5WnLfHqbTfsVjbgk7vLs2jGinqTc5zPcckGNPt1COxOwlHFXk4jJxKP7GqFRX/pVAknl6DHLlfC52zrllc0ZhMq8Aru060K5te5aULFJKWrye/KV3KwnhJCug20qu9FnMlUPtzxNjrqgX4tlqUEEJ8Wa6/fsJOAiLLuF0V6nqROUmIWFPQRTC7r95ZyIguPHotOXb7ttMvJIs4vafSsBHC2DU51CvoPvjFJQwJrx043l108P/TdgXErjFmbeZBb++9u/AsZraOwAd2nbd+EznRqJARjC6c0fH6V4GS597WF4dQtHVhM9fdXMF5K70239xYf1MCWVwbjGaHMl
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(41300700001)(7416002)(38100700002)(5660300002)(66946007)(2906002)(4744005)(36756003)(316002)(66476007)(26005)(6486002)(478600001)(66556008)(8676002)(4326008)(8936002)(31696002)(2616005)(6506007)(6666004)(86362001)(36916002)(6916009)(6512007)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aFFsdkN1NnpEbW9XMXlhdmZ0ZmZyT1RQZ2FJc1BFQWRlWW80QldIN2d3MVh3?=
 =?utf-8?B?dTZuYnhBOGx6YUFSa2xoOEJLVFkwU3pCREpnUzMwWXlNNVNBS3VuSFVzbzlC?=
 =?utf-8?B?NDN0WmJVdE9ta3Bzekp6SWZoQTZ4NkJBRDJpbHB2azBsRHpPNUU1YmZJTGtB?=
 =?utf-8?B?OFhqZC9venBlQ3EzQWp1dlRGTUlLMkxqVWNYWnR2UiszVkN1WnZ0aEt5enc0?=
 =?utf-8?B?TFgvd1MyODBrS2xQOWJBbStUYXR3Yk05eWlrZ1NpMThaYlVxaUlFdTJwcXF6?=
 =?utf-8?B?VXYzZjNCbXRuQVZ5WEFOb2g2Ynk2QVBVUmFRdS8rL3c2UzkxY1M5OFBZbU5j?=
 =?utf-8?B?SmZodXZtTlZtKzhFZUdWVnduWkZqQ3lkb2lYR1dMUTQvYVdOcC9yTnQzOXRJ?=
 =?utf-8?B?ZkQrSGFkazhTb0JTRXpka2FDSTNYZjZYNUpaRGxXVW9uVkkwb3h2Y25qelJo?=
 =?utf-8?B?MDd4MTd2UVpybzgyTEpQc0swV1VINnBsWDlXYkpDSS8rZEo2SUZDZHBsV0dQ?=
 =?utf-8?B?a2pkUFBtNHhXYkVrQTNhNVpETGh0MzZMU2ZZYVRQL3JSWVMwWGhtbnpvQ2c0?=
 =?utf-8?B?ZnpxaHBPUDQ1ZVdkN2VucjgxaHlmazZzSHhYc1Zna3Mra09XbUJzY3ltVGJi?=
 =?utf-8?B?dlczKy9TZUpwRlZLMGRpN3RZemw2QUh1WHlZbDVYVGREOXRLR28zL1hzRjdE?=
 =?utf-8?B?YnhSVC9iWGhCb25CTy9BdDByWm1waGh4Z0pmdXdYVFNJdFg3ZjA4ZnBjbnFE?=
 =?utf-8?B?WGg3QVBJVzVHTWc5aVVVaFJSdkh3aXZ6cGtkY3dLVG9DZXV5S0VOcHU1cG5z?=
 =?utf-8?B?eitlRmtHSys0RURNSGhVODZBbjVpYnBDcUZmR01ibDdGTlR1T2NQYTVUTE1i?=
 =?utf-8?B?MjhwTExrTlVEd3J2NDNYREplc2RqblNQcWZZWWZlTHZLNTlLemRES1FaVDNO?=
 =?utf-8?B?TDFQMnpoVndVaWRZUFJneGpDSWpYM3FUZzhaNDJEQzB4MDduTUlMRWhzcm1z?=
 =?utf-8?B?OUV1UUVuTWhhZ1VISk1xSldyNmFSOVB1UzBPWFZiUVpmRjJGeEVwVVp0cnZi?=
 =?utf-8?B?ZjB2UUJpNTlzOGx4RTVIOEJ5UzlTbnN4UFhFUzVndS9qckpweU5TbXJrUmxM?=
 =?utf-8?B?WmtIcXlDMnpXZG1lM2xWSjNKOExzbDZHdHZLU21JWmxNLy9aMXE5VWhBZmRE?=
 =?utf-8?B?TUJMRXA2N0owc1J4OWZRbU0zalBDdk0vNVoxN1pDV1E0OEJHakp5TlFYOU12?=
 =?utf-8?B?OFdiZWQyYU51a0RtRHNlUkxOejFNYi9sV3Q1WTAwZXU1Z0R4SG8xYldsYlA1?=
 =?utf-8?B?WC9CWEV6ZHYrZHAxcFJSZG1rUmh2WTQvclF4dTU1UTQ2U011MHlITzU0aXpC?=
 =?utf-8?B?OG9IcVpvSG5rNW5OZjlXWFZQQWFqbGg5bmJURHVFR2dRWmlWQ3JobWtmajZh?=
 =?utf-8?B?Vll3TWtnenNaazgwZDhOb2Q5a2FtZ0N0T3REYzhERjlkNHc4RTIxbnlucXdp?=
 =?utf-8?B?d2MxZjJjL3hPb3doOFkrKzFITUtzUzJlb0ZoTHhicTdTRWlPT3JWd0N3eUdt?=
 =?utf-8?B?K2krTlBWUEJFVWZuVU1NUkVrUzBSZVJlSUtTUG1MQXdlbVZnNTJWaUVXd2tJ?=
 =?utf-8?B?eUFkTTlUNkhHYWtlZXlOSU40YjEyTHZYeXU1M1RQemdFNW9nSnFCUWN1QmlD?=
 =?utf-8?B?OGM5VzI3aTc5ZjhKQjlGR0xaTDh4eGMvVlBBQklzUGxHdkViTE1Zbnpjclhy?=
 =?utf-8?B?M3JwNkZITUVWdiswZHY0MVJzbFhBa0hjaGNyTEJSZTNVZkZrSE5mR2tBbGZJ?=
 =?utf-8?B?Mms1RmFQYzhCa2svcEdVdkMweFhFMHY1dFFzUGJlVkxvU0xVWmFUT1VHUCtT?=
 =?utf-8?B?SXYrQTBJRkNaMHVkU1JuU3RISEJKUmNQWGIwTVYyMWxWN3JMQVM1cmZ6eVVI?=
 =?utf-8?B?RE51VlJreW94OGNBdEdpQ1ZOZWRvdzNVSnphVUgzcVJHVldMV091LytVVWFC?=
 =?utf-8?B?Q0FIMnJJdkNkVlk5MmtiUjE3V3pVTGxJZlFiQzRkcEZkZmRkdVgvdERQUG0v?=
 =?utf-8?B?VEtrcDlsT1pMbThGZkQwQ2wyZTcrRUZjdmJNTnM3bzZ2L0JjVTVnU2wwMlNO?=
 =?utf-8?Q?ZutUINlNQ29INv0s1GElmx64g?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+FzL8Ci/7vUCgSidhFHdeP4K0x848Zv7KcjxyAwwleYaiy5EbcTY2mUk+uPHM78By3EoJZTRMh5LMqY9YZc/ufs/KeeVvDd5CHHsDKJEbGVvCW9GmuXmsbi6oD6dDYnkWPEm+JlzSnkBNWt7lyeASwzXvsCInkJwu8su7OEg/Pr33j5QNAvdRRYN2gpcQ8x8f443fXCyUL2OcPy5Gh8szboDVL02MA7B82jktetOA4R2P8/xnw2JirLTQLtL5bNrHw4Jj/L66j2P0XUCggzaGOTUzqjAFEyIYA8gaU2mDFI7b0ZYjRi3rOBKvN9QFUISz8A7FNdK5+a1cTwmuKjV/0BU9/hcM+Zk0EceHo9NkK7wP955NMn2maUMqmOrwZ+lGNstU4qKjhD/owkNwBcfjP4XxVU8EN1YdwwIdU8yLsEXadqXXy45zW0fKpQeFDrWqGP6V9uBaA1WL+mUBWYItM3t7KT5wdP/fql9YH13abOw8v/gnl8XO3+Ti/KD90AedoNE8nMlAevZEhiWtyKYrnTM5fRwAyec+GKhfWu1w6OFS2bR9HICx6TAWYnemMPhBcoXdZYWwUgdsETfk0ZuKz6KcImzb4acKlmDdHPpOqM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf25e2b-e0d6-4682-f2dc-08dc2d45269d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 10:10:20.5596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0R0rv9bRbAcrIbDy+vyQEwqL5UmmRzRQfcS8zSVDmBeOhv/8y++c3qtbPKPD3L/haMthdt8oYMZgpMRA7h8uDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7499
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140079
X-Proofpoint-GUID: vllnYyUPJsSAr91tqMpYC9gJ6-aCuOmQ
X-Proofpoint-ORIG-GUID: vllnYyUPJsSAr91tqMpYC9gJ6-aCuOmQ

On 13/02/2024 22:49, Dave Chinner wrote:
>> Does xfs_io have a statx function?
> Yes, it's right there in the man page:
> 
> 	statx [ -v|-r ][ -m basic | -m all | -m <mask> ][ -FD ]
>                Selected statistics from stat(2) and the XFS_IOC_GETXATTR system call on the current file.
>                   -v  Show timestamps.
>                   -r  Dump raw statx structure values.
>                   -m basic
>                       Set the field mask for the statx call to STATX_BASIC_STATS.
>                   -m all
>                       Set the the field mask for the statx call to STATX_ALL (default).
>                   -m <mask>
>                       Specify a numeric field mask for the statx call.
>                   -F  Force the attributes to be synced with the server.
>                   -D  Don't sync attributes with the server.

ok, I can check that out and look to add any support required for atomic 
writes extension.

Thanks,
John

