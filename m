Return-Path: <linux-fsdevel+bounces-17570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C558AFCE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 01:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1182284E18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 23:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4603944C86;
	Tue, 23 Apr 2024 23:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VZY5QuLd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eOet/Q6F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF72367;
	Tue, 23 Apr 2024 23:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713916358; cv=fail; b=AfIm+mtq7aL8Y2RIZyR54PC9X9M0C0wUfTROz9BchhtuJZnJJhzpIluMObyUxmqhpNlm5cueqULuJjTttqWTGxUSGpLRmToTzExvXjZQ+GBAXYmBCmWOW+wTuCKhPWazZFA32z7wRcLUREtaPeJaFxDHhFJaVFkdmEvuYz3gzRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713916358; c=relaxed/simple;
	bh=eDJ3zGi4p80m6lDffW4Nwh7aB649aBF/2upUpkK/zt8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ci4HXDtktMULjVamnSZhW/GK7bEdAtPaLnigNHwnsVCCPZLWm7m5q+DmFOQ2XWWY1ZEjyiiXGNIk9HufcI/6NapkVlz7RXzNqvMlfHSKZkFXXezSxb0+YWWL25hpsikUPes7p0lXQjDb5Cxa6RFmui4qhu8Z7p8rl22UxjItmYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VZY5QuLd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eOet/Q6F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43NJcl8e026197;
	Tue, 23 Apr 2024 23:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=To0DoxAVvcUrJgaT3bDaqOLXy9nVLxGonXhMeVq35oI=;
 b=VZY5QuLdSNFywwz8Zy7SoUlQ7/MO6Zw60A6++OVwu3NIcyzZAGFG6Dmazpp/11V5WkAJ
 f5j+YoSvC7bEDA9gB1gAyFSn2oo5N1pITl9wFIn8QOvRuE4z8zeEGBne43W/G4ZFaDVI
 HJaOtMxmD8t1nCTz08MT2w+Lgn38Jkt7/73A9FME0ZBNW5w4ApOSrDKz9Rp9ePtgzmy+
 l8JTYVsanOKcA+A/unyVaMJ/coBXbic0VE8Sd31UF1ip5ayywlJ+KB8nssbk5JBjPyjD
 meRee7u3grnXNHSWaCcJqjmqf68SOaWXAm5sI+5yddZB7BWQvpqu2122Elc7Ty9NX8A+ ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm5kbq6k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 23:52:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43NLZpjA006559;
	Tue, 23 Apr 2024 23:52:10 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm4581aru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Apr 2024 23:52:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpmpghoNlvq+EQNw6pvKkEcsLkIfW4sGQW/6SnOJia5pKvte5NGgX0VHnrsgdbE8nZcQ8Kw4yZHq3m7SaYKWoitQX3glU1ALFoF6wG1lOXDu72XPbSmQaZLlZXEvUiwT9Gl+Qmf5ULzsIwA4DUFYwXd3xqKhfFvQuD0DbLKg+7EJHN05XRSctV29vun5s7U9qQASWNW0+ZfZqlwrmRjqsSZHhFcsvD2BYYshXPmSsQme79Xzew66AC01p/74i9BJQwiDlbtDCvXSDGUz6jnG9j/gzEWYpsVDbLIwPAZZvVg2jN4QlDvf7xiuMFq3vHeKjsvL6MsIt264HqavgVoERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=To0DoxAVvcUrJgaT3bDaqOLXy9nVLxGonXhMeVq35oI=;
 b=XAziIebuSuc7XmeMJmCpJKytqGs7stx+c9/K7SDSnXAGSZcE5NXN2reIHQKbMhwSc9iMvCYO0o7bl5ukrn53mzWaLhX2YosB7IhBzCL60pbiZdsGvjvqgERrPBdteLPIi6+3N0QN0sticym6VGDdYuO1FhD+OqqC7xYiqw2nfsZiiaB9kFZ3eEXuAW5EknG+T1vCkbGkwq26Y5iipqfodENESn7D6QVJIzR33ognvE14cKr/UuycbU7nC0dvOXx+Krla0MuEAwwStnnvgDGxYUk+bjEpfIRgQRvJ8l6TvdIUtemgAzV9h3Qb5EEdKCPBFeevWG5C0cOaGUQprv3Rzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=To0DoxAVvcUrJgaT3bDaqOLXy9nVLxGonXhMeVq35oI=;
 b=eOet/Q6FmdS32RZrZYwP5KhEuufsr6LGpgX9KDsfF8colE7Fpc4HTJfDfdquWUxYS9JQx1xGUp73jbTsqp8L/w41UOgFj8+jX7rHnYiTZ0JntDCYDJkoSpHDYrn0bj4nwacuI0GsTkPGJcoCqSeiAuxHpMi93JzL6jyEkcdHAcQ=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ0PR10MB4478.namprd10.prod.outlook.com (2603:10b6:a03:2d4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Tue, 23 Apr
 2024 23:52:08 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6573:ea04:fecc:cc68]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::6573:ea04:fecc:cc68%5]) with mapi id 15.20.7472.045; Tue, 23 Apr 2024
 23:52:07 +0000
Message-ID: <e5d9d0a6-ef5f-4861-a75b-6bb8e403a4d7@oracle.com>
Date: Tue, 23 Apr 2024 16:52:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] memory-failure: Remove calls to page_mapping()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20240423225552.4113447-1-willy@infradead.org>
 <20240423225552.4113447-4-willy@infradead.org>
Content-Language: en-US
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20240423225552.4113447-4-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::21) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ0PR10MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad3ddc7-f1f4-4961-7dc4-08dc63f0624a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OXZ3eFNCUmh1aGNvaDV6REdCVDdmeXEvOHFCMjVPeWl6QlRwWE8wSjQ1clBL?=
 =?utf-8?B?MENWMVdac080a2M4aHNRN0RrQ3NUcHNhV2s4NGhscE9ZQ0RodFc1a0NlRnFa?=
 =?utf-8?B?T0hLMmFzRzd5eTROanRZQXBFSzFrbEVEbjFNNGtmYTR2Q3pubWJoQkRLS0FM?=
 =?utf-8?B?ZEVRd1ZXaWNOSUgwYkYvL2E1bFA1Y0MzTGErQUdlRlRKS0ZjREdFTDEvRVBY?=
 =?utf-8?B?dUpCWEdPUXJ0aFpBeHpPcWRsQVVYR0RTSDc3WFJObEhrRjFrSVZhZkxPTmpj?=
 =?utf-8?B?UDNOaHFoV0d1aFdDdFZZYzIvU1Y4bVIyZ3lvd0tmUGxTVXVYSzRaVTFIbk5q?=
 =?utf-8?B?dUVURkJ6NzVUOTR1Mi9QM1RWbjZuMkpMbkNYalpmcFB4WVRwTG9nNVMzaERC?=
 =?utf-8?B?SWNEN3FLUGhyazdDTkllWXlkOTFpc01MbXJlYTdkYTl3b1NoR0RJcE8vZzU0?=
 =?utf-8?B?ak9CMnZJVnVSL1B6ZVZ6UmpOZmc5MnRndi9pSmZwQkNTdisyZlo4ai8yOHZq?=
 =?utf-8?B?LzJDR003ek8wbXdDb1B4dnBnOVNDVkQvM05SektXZmxTTEpQZ1EwUzRPbjBs?=
 =?utf-8?B?T0I4WllFZU9lQVBxNk8zcXBwcUhYeWR2VEJGWHZQTkp1cVIvc1d3Y1VZK1VR?=
 =?utf-8?B?cWxkWlFsQmlpTnA0eU9NYzc2Vm5weTN4eHowa1JwbGVIVFNRTVhtNWJreHRr?=
 =?utf-8?B?Tjdwd1kvbkt1Ty8xTkVRd3JxeVh4cklhVDZPbEpZOXhWb1RuZkowVWZRbi9j?=
 =?utf-8?B?ZkpKSmNQSkdGQksreHBEVmZraG5ZTEoydjduYmZMQWlJZlBTL2M5dmcxazRt?=
 =?utf-8?B?eXJKQjdxaFkrNVZPVUM3VWFnbU5hZ3dPQVdCN1dDSDlzL2djalhEa3ViR2R1?=
 =?utf-8?B?RU5yNWdLUFFIOENZSmxmYTl4elBiYW8xY2V0N1Z2V3MwdFpuNVdIUTEvTHA3?=
 =?utf-8?B?MlBNeVRMM0xuN3h0QVE4cUhnYzVpUVI1MVVDaVIzcnlGM1laY1ZOTG5TdHhm?=
 =?utf-8?B?MTZiM0VpcDlyTVQwNEN3YmpidWVKZFR2ZGo1c3h3TmlhaTBFQ2VsNE85Rjls?=
 =?utf-8?B?UlkrUHg0TDdwUzNvU0xwZ1dzOUZiVS8rSFUzYXl6ZDdGaWwyMUJGVkgrRlZP?=
 =?utf-8?B?cUZhbG90SC9EZnNRUFpZb0xpd3BHemFWc2ozMzFFTE0xWkl3Y2VBUFFlYVB3?=
 =?utf-8?B?T0NrWTJ5cDVpZ05lVkFIbnJaZlphZ0J1ZTVFZkNWQ1AvWnR0WjBXTjliODdz?=
 =?utf-8?B?UmpKQnp1RCtmUk92ZVJoeFVVTkc0OFJjVmROZzFacDlhMTNTMjZGODN3ZVA2?=
 =?utf-8?B?WGkzeDVPWlFJdEI0eEMwdHFyWEp3eGRnVnlJaG52LzZYLy84V0NwV0ZQREdw?=
 =?utf-8?B?NUJibDBkWWxyNzlsaG1VblcyMzlNUm9BZEs3VGpBM3R1RVZuM0hEYmh2WGlj?=
 =?utf-8?B?UC94cEdqWGNtTHZCYTdTSVZwR0YxMGJWM20vOW51Wm5nRU81ODNqWlM4UVVR?=
 =?utf-8?B?RVNRSlQ5dElraDNpaGZBMGltbmFUbTBEb3BNSmJFUGpBdWdHVmc4cGNHN1VB?=
 =?utf-8?B?R2xwK1JZaWYzaS9lQXZNdElRN1U2dGI3YnN5blBQQkhoOVRaeHFDVUlWQkY2?=
 =?utf-8?B?UjV5K2t2V2NlMzZFSnBKWnhUT3pSWlh2UjMrcDZPbVV6NzJDMlNJTzVnK3Nx?=
 =?utf-8?B?Tml0K2ZraXhFczFwWk1ycWpJbHQrQzVPbW9Mb0oyS2lqTXdHU1luZTN3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QUlHNy8rcFJWWmdEVnV6K3ZLVTd1bGY0TWRMZ3VwL1lwVGpRV0NoQWU2TXdz?=
 =?utf-8?B?dkwvQ29FODVKcHFSV3JXMzB2UXNjOXpvUEdnNm9zdC9kaUxDUkh3WkM1NEJC?=
 =?utf-8?B?bzdPcmlNbkxhejVqNHZ0OCt2VEZrTWx3aUxkekFEbURXVjFwei9pMWpuK1RJ?=
 =?utf-8?B?dkNxT3FnOStDWS9mR2ZGLythUzNrWTVGUXBGamdESjlNUnhoczRjMGVwZkp4?=
 =?utf-8?B?ZzFNMU1Sek5QS0lsYlZ2WUpLNUMrdHhEQ0FiZzE1ZGgwMjJCNnloak5ZTEJI?=
 =?utf-8?B?bHBvYXQ5U05sbHNZSzJuejQ1cnYySjJrNmorbUVGYU81cUZFOW1iRnFXRzE5?=
 =?utf-8?B?cnpYYUYrSWZubDF6eEQ5ays2bWpwV0wvRjhkcmdyVzdaUUpVRXlLd0hTdTFD?=
 =?utf-8?B?TFkzWlZTL080M09RVERmd3ZjY2NxOThncnBSZ1U3VlZxSmhvbldxUk81VHF4?=
 =?utf-8?B?SVpFelpnaWQrKzFHRFBJVi9BLzNJZXFSTUxHZ1dYRm0vdkc0d1RZZlFZdm9y?=
 =?utf-8?B?UEMvT2JRcG5GN3VNdHlQeGMrWWhxOW5Teng5RnFXSEluMTNRNjFRQ0U1VGhp?=
 =?utf-8?B?em41L2NqdlVQajR5S3c3Nmp6SERNb3F2SXNSVGdFT2hJMzlwVmt2VVNHOEpy?=
 =?utf-8?B?V1o5UVBxM0hlWVZ6clVaRkVyeGtnbGkrUjM4S0FrUEhYcmRRTHFPaDJMbzRo?=
 =?utf-8?B?N0ZSejBEMkM0NW5seEp1clhWM2pISHFOc1AvK0w3TGVkVmYxc2dRcHVJcTJn?=
 =?utf-8?B?RmNJMFRqR3RRd0grOCthSFpleVludU5XaDNYcEtaL3lSZFI4WHViMk13V3M0?=
 =?utf-8?B?dkpRVmZnS0RmRUtpSVE2d1JubkcrWHJ5RWF1TUpSekNXNzlwMDlZVHEyaUtk?=
 =?utf-8?B?U3Nzeno2eXMvK3kwdnc5SFBPOE0xc2ZUdHZoSCt4N1d3T3R1OUk4VE5lV3hB?=
 =?utf-8?B?MzI0YWhjMFNDbktQL2Q5ZDl3bFFHNXhwYXJVeGlUeVZmZUpSOEx1eTJKRmx1?=
 =?utf-8?B?RUxTQ0t1SkduNXhvb1U3a3l5ZlRWSG00YXNJN2F3bGZjanlDb1hvbGFwQnQ2?=
 =?utf-8?B?SXoxUm1tYUt5NDVlQ3pMeUpQdzkxRDM4Y2xYYWh2bWhXOHFVNWViUjBheEFQ?=
 =?utf-8?B?eWU1c2ppYTJkT1VUMTdXSnRNTGEzUzQzUldRZEsrYlN2ckRmd21NSEM2VnAv?=
 =?utf-8?B?U2pOam1ZNUlSR1NrREtZTGhuM21JTXZUQ1hENVRyRUFjVHJpVmNBREdtaVha?=
 =?utf-8?B?M0dEUzJOOEtBMzNYUlkzL25SYldoV2ZsVU1VRUlOL3FCZHJLYWwvN0Zac0tD?=
 =?utf-8?B?QUZubmsyOGZROEd0bXNZZTA4dkVzR3k5cUFPME9PVEpmTlNwY1B3RGxlL1J4?=
 =?utf-8?B?Rm1QTmV6OHRQVXNFYUhXTXJiQmNNQm0wM0swYUtnTnhRVEhpb2hqSjFUNGhQ?=
 =?utf-8?B?bXRqUG1yRGV5ZE1iVitqbmR1NEZBVG5zWUxyVmlQNVVxbk91SEdlY250OW9T?=
 =?utf-8?B?VlhOMXc2eUdmNnlaNHhMVkY5MDc1MlFjajZuWHpGYjBoZHp2M3hITnRyakx4?=
 =?utf-8?B?WS9kVjhyelp5SUZQc1BQUEpId2ZsdUorSlJ6YlZQZW1sTWVmQ3E4SFBoVjhX?=
 =?utf-8?B?aHNpTnZtWFZ6amo0ME1XZE9ZMm1UWGFNNld3MnhOdlVtS3c5VkdCNUIvN2Nr?=
 =?utf-8?B?MWM3VVFWL2lyZEhScGtubTVZeDZ1OHVsTGdGUUM5RU9lMVBCTCthNXhobU1V?=
 =?utf-8?B?ckY3NXMxYlJHOGM5WUdEUWZnSllLcVVYWlRtRkcxd3Nralc5TE14cFlocXJY?=
 =?utf-8?B?bmxDdnRPN3ZoaThDdVVQbnUyUkFxOU1QY0ZPOVU4c3NGcXF4bHZJQTcrTjdo?=
 =?utf-8?B?K0ZJYjlOdWg0bmlmK1VFZzFhOCtLdlFYRjUwVUloQ0NGbEM1WHhqaUhQL2l3?=
 =?utf-8?B?VlJDQ0F6QTNNeGliTFpIQWw2Z2JnZzBKL1JaNmJkN0pDQ3pBM0xlUXg1NWYw?=
 =?utf-8?B?TlVoa0s3bW1PTXZOclZ3Y3k2WkpHVUc4UVpWekdLVDVRb2FlL3Z1Q2xPM0w4?=
 =?utf-8?B?aUtkSk1CWU55VGhxaUIwZUhWejhHYjludkJKcFdpZ211dTFjenlIU2NTUEkw?=
 =?utf-8?B?NnpleU5mRThKb2hJZGxEc1RGdmwzQmFIRXNpTG91MnVvT3dVSkNKR2ZORzhu?=
 =?utf-8?Q?9ww192xYzV+Hh+nTw4Vx5tY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ccIpIfSz9LlZiE/mqIFqyn8NoHok6RQeyobVDzBxGcGpnzHlnLuC33xjvO2s54oHJCuyGf79bI6uOB52nldboHl6ySh+6KL5N2YECm2qRQQfvcI2zmIy5oXAmdYVDrLStLIeBwnE0+PjgEkphn/EfcnLYiat1LyZAqLUjfjiworz88EuLOT5gyj6uQuIT7n5xRSZkZZkS0DhtTe6WZzkVOMaTZ1EJQGaJUUMleN7lVpz987w8mk/JmIPX38UHz8/qOVGlgRl484vuSt24I1kkKJJS3Ra1bn+/dPzPGcZtIVy/xftIj8ux3xXwnoqMg/PZIzEGN+e9IjBYbtZPAYt8b+mA4hon0B9SvC/Vcxuncrxs084KAMaAnOXLrtOmSqAGK/aZzLOTH/2XLPoCvg6CCwToKjTieS8LBjYXzhKb/PE0YRmzT14bz30nuQt4L2NuB7pq6QDdnPDlRXpQRGHo5ncvsg+ax0GGuIC/5ZAkgi2rcdGfHElcn8K1o2YhyEDOOtTPUDqiwsvIL1h5Wcr4fAzT2xgIPLmfrsLDnenX3WFR2vpZglP/DhQwwlM++zTVRIjJ/bgH/twp5RhPyGGumRklhjh1lEYtzw2SGG0YbY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad3ddc7-f1f4-4961-7dc4-08dc63f0624a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 23:52:07.4723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRcjiM1CTavGV1amJ000d2yFrKoseNQ4PhFBDR80NisUcIMPMPXjcCFvg1il24XauCKzOWfb9H82ZdwRyFh4aJ9hZOcVno/WoalX9w4pCUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4478
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_18,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404230065
X-Proofpoint-GUID: 5QCvqQeCPi4lmrPwmsw7R3PABF1Lkj_j
X-Proofpoint-ORIG-GUID: 5QCvqQeCPi4lmrPwmsw7R3PABF1Lkj_j

On 4/23/24 3:55 PM, Matthew Wilcox (Oracle) wrote:
> This is mostly just inlining page_mapping() into the two callers.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/memory-failure.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index e065dd9be21e..62aa3db17854 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -216,6 +216,7 @@ EXPORT_SYMBOL_GPL(hwpoison_filter_flags_value);
>   
>   static int hwpoison_filter_dev(struct page *p)
>   {
> +	struct folio *folio = page_folio(p);
>   	struct address_space *mapping;
>   	dev_t dev;
>   
> @@ -223,7 +224,7 @@ static int hwpoison_filter_dev(struct page *p)
>   	    hwpoison_filter_dev_minor == ~0U)
>   		return 0;
>   
> -	mapping = page_mapping(p);
> +	mapping = folio_mapping(folio);
>   	if (mapping == NULL || mapping->host == NULL)
>   		return -EINVAL;
>   
> @@ -1090,7 +1091,8 @@ static int me_pagecache_clean(struct page_state *ps, struct page *p)
>    */
>   static int me_pagecache_dirty(struct page_state *ps, struct page *p)
>   {
> -	struct address_space *mapping = page_mapping(p);
> +	struct folio *folio = page_folio(p);
> +	struct address_space *mapping = folio_mapping(folio);
>   
>   	/* TBD: print more information about the file. */
>   	if (mapping) {
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>

