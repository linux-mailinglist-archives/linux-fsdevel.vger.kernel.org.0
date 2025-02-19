Return-Path: <linux-fsdevel+bounces-42045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CC3A3B1BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 07:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7504416635A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 06:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D148B1B6D17;
	Wed, 19 Feb 2025 06:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h6zVg+0b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDB71B4247;
	Wed, 19 Feb 2025 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739947549; cv=fail; b=pv3+IMA/pbJMhW7uT3e0Tkb8tzUt/XMIWzpG8SSBiz3/jXf7pnCYD5MBdLx/Bu0LAH2vy3jdpPFyK+3pirvJMHQv9PQfm7W0JlbY/fB74vnM30gtFeroAe2zxQRXL8w23zsB8hD6LXQz785NpTAX+mX8A0lR7VntRntoFTCs4Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739947549; c=relaxed/simple;
	bh=t4N2STudXwN2nK3+UoidgItc1vAL3UxxdLuGYKFEfcU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o6181eAzVs2qvquSPHhshYu+6VGydRDcPwKDNMQ3AfnbhxOJBKx/96WepS0fBri7R9IFTwDG8FuOKQVE73IXYhrGwNzzBuFV1i7XsO2NmKTDrGHPV/C0QBIXCpHN4RhqiD9RQIe79WKL1uzOWINwjs15/Si044tsFhTw/Y4eJGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h6zVg+0b; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FmsVOr5mDYS+TEGhdoFmpZV5VpCu3seH3TtorYsfO5s5NIu37a9R1c/DEQRdmBilcU+5im9VaFkdtlAEJHBlyfBlS3OXNZ6oINoOFqlNhqMkMbwcp6ns9SpglYBd5dLubD6j+WUg095QKEHajOrHUEDtOjF5gky7FJY2pXFaolwJD38km7XLUhWJHzyhvVlua6zIgZI+OOG0NTzr9yURfE+zVjtaEYHkLwlYN5YMjz6AqKkQsybPaowpQRil5v/ix8nzn3NKs1kzJwOo/uNl8UebjldVLkjQ1sBMDB43rme2sktvMxEwHVP40CAmxevWOoglQDhnQsV6/hPm81WY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJgH4rhyr1yG8nVlIIAmvIJgVx9r/MsdeMOmZyVNLA8=;
 b=gZTkw3hqsX5mhJ9SHlczKqVg6E4b/UCE0ugxnkk9gQmDrEBvpWo94apKWRgVatbWXS/Rrx2fMHvoV9iQkmwtdBCikIenwDWCsTiYvfUSs8U3/nXZESNFudUm9Sk/UqJKGu6BUT6czlGFS04ECGwH2EPNIPrqFJ60EItKq8DluLcr30aJ/YGd+6Rt7FEOKmL8qn+2m2xMfA1ZuHD7DWyct4cFvUnja5yWhhX16VlNDGQq6oxADUtRhfB1Ey8x4vx0I+HJIA3oGLVL8OhFMUH7kEkYqbl7igoEPVF21Rukwr9fPZyz+W5i9MNHlz0dhDlm/fxQLzJKF19uOC6uVRlbpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJgH4rhyr1yG8nVlIIAmvIJgVx9r/MsdeMOmZyVNLA8=;
 b=h6zVg+0bfoTnHd2NvhrHGRCwMK9XhW+pwOzu/8gDk1xYxDSakBmRypF5I0rrawWHrzAmARbTlQJujuZnk/0RvTswO/mS9vGbUtawd8jqLmbASTQSzQUiyMz0FP58SOgeQsDD61Bufj8XLeWBNKO9QEigtJZPNXsGTAKBAisSekM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 06:45:44 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 06:45:44 +0000
Message-ID: <23487b60-eb7a-4b11-ab34-ab21e3efc335@amd.com>
Date: Wed, 19 Feb 2025 12:15:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 2/3] mm/mempolicy: export memory policy symbols
To: Sean Christopherson <seanjc@google.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, willy@infradead.org, pbonzini@redhat.com,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 linux-coco@lists.linux.dev, chao.gao@intel.com, ackerleytng@google.com,
 david@redhat.com, bharata@amd.com, nikunj@amd.com, michael.day@amd.com,
 Neeraj.Upadhyay@amd.com, thomas.lendacky@amd.com, michael.roth@amd.com
References: <20250210063227.41125-1-shivankg@amd.com>
 <20250210063227.41125-3-shivankg@amd.com>
 <469ee330-7736-4059-9e59-ec7b9a6d3c8b@suse.cz> <Z7Slzs_4jZ2qkPAi@google.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <Z7Slzs_4jZ2qkPAi@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::11) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c930789-4e7a-4947-b46d-08dd50b108a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1J0MzUwVU5vczVzNEJYcUQ3RzFSM3ZaQ2ZYRTBhYUc2eTFESUM2bUdFSThP?=
 =?utf-8?B?WHVJUmJGOFBKek9Ta1NuSmg5QnN2SWgza25qTis2aWFIZDdVMDdXMVQxVnV4?=
 =?utf-8?B?M0pHK29OaTkzZmZNU0duNjEwdkdwY3V6WTgxei9iaFVKTWM4Zi9tOXZ1SVMr?=
 =?utf-8?B?SlhvNEZRQnJFYVFTODlQRy85cjlwRGp6QytXWDJ0Q0xXQ05YYjlJdjA0V0Jx?=
 =?utf-8?B?SzcyYytyV3dHeXZySldEQTdKOFVUbjZvQXl6bjNvYW0rZXAyU3crNFpmZmU1?=
 =?utf-8?B?TVBDWE12b2N5anIxTUdzOUxucHZoVVR5dWlJWG0yN3Iwd2JzNk13MFh0OVhu?=
 =?utf-8?B?cGErMG1WSnJmMkFieDVwWDA4YjRnWUdsc0RsS05xMjdLZmtxK0drYythcFRk?=
 =?utf-8?B?WGhya2JlakNWamZHUldNdXp6b0tEVTZWYXhzM21ESGdSUXVTMlFJWDRTbEds?=
 =?utf-8?B?aHVVQXNkNzFiUHNWVDdhYVZmeVZ2Yll3WkNQNm1jcVVSOTRZaUhHREN1cVgz?=
 =?utf-8?B?M1lzZmFpbld0RFBjT3RzSVUrZ1BnRUpJdkdaN0RxVU5ucVViMXl2VjVLZDhh?=
 =?utf-8?B?Ty9ua2Q4d2djUWFVa3pEWFRFMUhjMVpzV2wwanVKMG9tK1FPc0o5MEpQK3Rk?=
 =?utf-8?B?bVRjaXplZFdOaUF2d1MvLzkyNWRhVkJmRUtLNEJUNThvVmZEZkZDQWR1d0Ex?=
 =?utf-8?B?QmZGWlVneDZja3NleFduZDhmN0d1Rjk4c2U0bDRHYVRsek9FNkJYU09JZUx5?=
 =?utf-8?B?cnMwVlBPV3lTNEtmSHgyaU9OWERRRlZMQWYybUVZMUtvYW5jRWVBQ25kQlEx?=
 =?utf-8?B?bm1JVG1iK244MHVtcWdDSGI5YVlXTUgyVEYrSUNkcWZTYjJ2dldVeWREUFdD?=
 =?utf-8?B?MjYyUkF5ZDF4c1djRkdVc0tVR1JWNTdlUG1GRUNzeDVheElLYzBCUzdkUUt5?=
 =?utf-8?B?V3cvdVpzZXg5Y0dOMUlOb1U0U3ltNWpaT3h4dzB1aFVzSERyZ1g5TFJOVWlL?=
 =?utf-8?B?Y1cwdTk0SStYYzJTQ0VQZ1dLM2F5SjdEWkpoV3VrbVd4Q2Q5Z3pNd29vUkZB?=
 =?utf-8?B?QmQ4c2hPdnhGNXh0SHU4ZEQvNmZabmsxaGNXbUNJeHhSajU5Z0kxcWlFVEFF?=
 =?utf-8?B?M0NaYnBLb0xnVkFUYkMrTlBLOWdDdXFCcUI1RU5VdHVtUStDTXAvUlVsWXVa?=
 =?utf-8?B?WC9HOTh0N29XMWlsS2ZEUDFNVWpPeTUxQllmSUpmTzkxVGYra1lSNGhCY1BF?=
 =?utf-8?B?bEVJYTMxNW11TUtlUVNtL0dHbStBbGRzQjFKVVhPd1Fmcys0dDBRRDNCYzlC?=
 =?utf-8?B?Vm1WckRNTVQvMWduNTc0ZFpGUlg1dHIraDhtbDVQOXJnN0FZSGgrNzVBRDQx?=
 =?utf-8?B?VDFXYTl5TXJZcXdRQUVkUkpOY0Y1dmpZWERBa01KMThwMURkanZIaFpaQk0z?=
 =?utf-8?B?TjdNdHVOcXlkTTR5SnhDTnBQVTVycmYrTGUvdG1wdWZLOGc0blFjZkF6TFVR?=
 =?utf-8?B?UzdnT3RsOGVNcmFHaVcwb2I1OGpvVzNpeDR1OU01bWJ0MERWd2ZpbDB5WDZ2?=
 =?utf-8?B?VGVFRVJ1R1hpOW9kQW5hbFFFaGlZSDBuWXBObFJKT2dPeXU1MVFFWFZJdkx1?=
 =?utf-8?B?Q2I4a2xPNkl6MjhXMXNiNmI0azRsMXpCRWRORS9qK3lMK3d4eWtxaDZFUURj?=
 =?utf-8?B?Z3JRQUNROWRsRUxhTEJzSTJFT1pXd0JYRHl0Szh3S0FTOG9kempqT2trWnpT?=
 =?utf-8?B?VVp1cm9uWEQ4TnJvSmQ5L29ORS9VTGdJU2UzMFBjK0VhbENKNXVrSldXVjM4?=
 =?utf-8?B?N253WG5XbWFnQW5nOVErTDl3VXNwakZETFpqODZHdnptMkxra0JsSjduVDRK?=
 =?utf-8?B?anB0bVlocm5QdmVFTTlqV2M0NmMrUmxkMnY5UWk2MGVYdWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODdxeHc1N2tyUk0yTVNRTE5UQktxVTFvcUNVUUZ6eEhyVjA2dDVzeDdZWURK?=
 =?utf-8?B?a1FoRVFNMVBtQjVXZ0N6a2hJdUduVFZGNmN3VUN2YTVlUmlTUUYwd1drVVl3?=
 =?utf-8?B?MkxHRy9HbmR6ZWVsUHlTZDQySCs0ZEtaSWZuMVJVbGZNZWRVaVVMT3d5OEli?=
 =?utf-8?B?Y2JvYSthU2o4WWM3blJ6Rzhpc1NFODh5bDUvWXRDVm9YbWU5eWdBTXprRUJG?=
 =?utf-8?B?N1E0aWZPWkovRm1EOWhTMGpDREtPNTk1SEpROU9qUi8yblM5aFFsOHpkc2ts?=
 =?utf-8?B?eUVKNDU5UlZ4VE1GanlrRzVzaDBnMUtUaVdHUkNlb0N0ZG55eFQ0WU5KL21E?=
 =?utf-8?B?bm5wZ3NRTnhoK2dxT1plZzErTDJ1WEtSZzg5ajk0dzYwaTRGVXRRYkpnMVdq?=
 =?utf-8?B?SVlhUzVMNUZ5dVByV04yRlhkZ1JjUFRnU1RUV0FxVWtiMEhwenMvVlRSQmd0?=
 =?utf-8?B?cGp1VGNsK0l1YURZVTlIODdCdVpQME1EcjJVN29XbFNPeEUwWkFsNU54SzZv?=
 =?utf-8?B?RUZsSlM0STJSaUsyYThISkZJeDJNQ3JUZitOUkFNWVlzVjRZZDBadEJTUTlx?=
 =?utf-8?B?a25OdWhYb3ZON2o0blpXUkZxNmJicVhxbnZFLzZaeXpHREdJcXVtbXN4VDhq?=
 =?utf-8?B?NXhOblYyNFd4N3RQOHdDQ0o4TWdxUThWb1hheEkzZUVYZEpyQjZSRlpPRkxF?=
 =?utf-8?B?YnNWYkhnOWREL09xd3dzbHpjM014SWYxdEtoaXpQZWk2SlpFRFY3RDgwVVlW?=
 =?utf-8?B?a3hFT0dGVWs3c3RPa3lBZGwzMUppNThCZEFmZHlENUpPUit1MEM4V1R2RUFB?=
 =?utf-8?B?Z2Z3MzBVM2c4aW5KeGFmQUdXS2V4UDNMMDEvUU5lOEQ0ODlDTm5QN29rdDFQ?=
 =?utf-8?B?a2h1cU4zZW5ocU4rSUZiMlpuK3JrV2pVdGtNZ0ZyNXhLTHIxYXBNblBQcTM2?=
 =?utf-8?B?WnJjVHFzYUZkRStqMEt4MGxuelo3OGNMU3hocy9uZURMLzZyR0FjWGJQTURu?=
 =?utf-8?B?VU5DRTZpUUp0TUErL1JNSGJPQmFlSmFJZ0E4aUxycTdwOS80dVlzNjFyQlZZ?=
 =?utf-8?B?Lyt1MWU4TVMrUXhuaENuS0xBL2Fyc295a2lrdkpnZ3VtMVZjaW9WdlRBSFh2?=
 =?utf-8?B?bUFLdTF0d0dlbENObG9BbzJ0c3Q2N2NmN2ZxME1NSHZBZDljRkxUT3hxOU9x?=
 =?utf-8?B?eks3MEdnNWt0SjlKeEpGQ3UwVDdja0kvRFQxUFpDVGJLV1hKR21JcThFODRp?=
 =?utf-8?B?ODFMZDh4b3hKZUpCdFJKQ2hKTWNnVElaUE42YVEreGtzdHU2Yi9OWXVmbGFU?=
 =?utf-8?B?ZWZ0Z29vK2Fsc1B3bmQ3ekl6WmZqZnQvbHp3ckVJbmk3N3ZNWENYRy9tUmpY?=
 =?utf-8?B?WlYrMUZtMkY0K3ZqeWxOM3V6V0xjdG1ZYjhQQTdyMkVTelhscklVbVBTRXBn?=
 =?utf-8?B?MFFTSDZPbCtvVGdsaUpFR2Nwb1FZa0Mza2FpSkhQSWptMmU1UGdUWDVGVjZt?=
 =?utf-8?B?WDRTYjZWY05MRmNacUdJK2EvaVltT1hXNFptSmsvVEVVbWt5eC9RNmYzOXBy?=
 =?utf-8?B?OGs4WmpCYUsvdU94b3BleVpGRHRFZGs3cjV2RlYycjh1Q1NaK2VnbEZuNXBX?=
 =?utf-8?B?bDg5d3pLc1JjaVhGajlWVHRiVDJ1LzNjdzF1VHM2bmtEaUFLQkJiSmtzNkNp?=
 =?utf-8?B?L1FBcGNYaHoxRlVPQVBQWjRwY0w3NWtPa1BLd0w5RllYZmdjWXZtZWxRMmY2?=
 =?utf-8?B?YnQ3a3F1cWpXZTY5ZTg4TnB3MkJVYmJrVzhoN04yN1dtMFdlMTNNZ2VqSk1W?=
 =?utf-8?B?dFdHUkR3RWlXV3RJL3hmNjFVWmFpaHpZakxYZWc1ZmdnWkF1NUdUNkRTelZk?=
 =?utf-8?B?SFJGb1pLYmdBRUJvd3gxbnZ5RXhYaFErTkYvcWNvV3h5enhGcnI1dEdMb1A3?=
 =?utf-8?B?VW50WFFaL1NsS09pVXgybDBqN0p2UHpkbWl2NTJKQmhRbHhvY3dnOTFqMWM5?=
 =?utf-8?B?ME55NUZ2NHJIZCtibXNLT1BMNnI3Sk9ibmIyY2ptcklITzJ2b2VTQk9zNWN3?=
 =?utf-8?B?Z3hLWVNPaDhJdC9xMFZ1ZzFFVVZFdlZiakVTVjVjc3ZsOWFjRG0xcGp5cjJX?=
 =?utf-8?Q?LCQLXzjTTuxNfF832/iOX+NIT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c930789-4e7a-4947-b46d-08dd50b108a7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 06:45:44.5618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvhlF92YiwTvA7Rlp3GGgrgpFI4i8JKi3kpjEel9sVRR7PEw/8QDie2gIBUnWknpbV1IvYGgxUnUAP+rCdmXLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416



On 2/18/2025 8:52 PM, Sean Christopherson wrote:
> On Mon, Feb 17, 2025, Vlastimil Babka wrote:
>> On 2/10/25 07:32, Shivank Garg wrote:
>>> Export memory policy related symbols needed by the KVM guest-memfd to
>>> implement NUMA policy support.
>>>
>>> These symbols are required to implement per-memory region NUMA policies
>>> for guest memory, allowing VMMs to control guest memory placement across
>>> NUMA nodes.
>>>
>>> Signed-off-by: Shivank Garg <shivankg@amd.com>
>>
>> I think we should use EXPORT_SYMBOL_GPL() these days.

Thanks Vlastimil, will use EXPORT_SYMBOL_GPL.

>>
>> Wasn't there also some way to limit the exports to KVM?
> 
> The infrastructure is still a WIP[1], though when that lands, I definitely plan
> on tightening down the KVM-induced exports[2].
> 
> [1] https://lore.kernel.org/all/20241202145946.108093528@infradead.org
> [2] https://lore.kernel.org/all/ZzJOoFFPjrzYzKir@google.com


