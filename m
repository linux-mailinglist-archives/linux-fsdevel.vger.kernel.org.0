Return-Path: <linux-fsdevel+bounces-52432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05DDAE3421
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3524E7A510C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2169D1A23AD;
	Mon, 23 Jun 2025 04:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b="wSKP4T86"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-007b0c01.pphosted.com (mx0a-007b0c01.pphosted.com [205.220.165.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FED5442C;
	Mon, 23 Jun 2025 04:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750651323; cv=fail; b=g9bJcP/8xRzaGysF66SSWjrGfUSaC5cI31opN2z4vCWWkONMzMg/0nEUz33dJk4TPAE2KVJjpWNCfQX4MuCCofIQSJsYFFZRGEavz0NTj5OSbjjS4abrNXsHW7qdT5xcU0HQrD8JP7ynZGh9n4NAVHTb0qqpFuUexVZ1OVOFJnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750651323; c=relaxed/simple;
	bh=MfPm7FKZVWZ7gpdX+Pb0ps/hAti9PFlVemLD3VWDmZU=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=Dzf19E7gtXW90mRvws4/M5geK4Rv3H+5B51hm1vhLXCdDUtULODxv7mZV+qdyjg8VhOV3+ESqQ1uhGqpPpcSI7hhQ6eYiDpNw8vjftiipoZ7nL1PusIpOORET0jikn0xNw5HyOxV1k0dn0q0zRAqF631nhwH1eDrey7gC+aFsjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu; spf=pass smtp.mailfrom=cs.wisc.edu; dkim=pass (2048-bit key) header.d=cs.wisc.edu header.i=@cs.wisc.edu header.b=wSKP4T86; arc=fail smtp.client-ip=205.220.165.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.wisc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.wisc.edu
Received: from pps.filterd (m0316038.ppops.net [127.0.0.1])
	by mx0a-007b0c01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N3RTli031829;
	Sun, 22 Jun 2025 23:01:36 -0500
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	by mx0a-007b0c01.pphosted.com (PPS) with ESMTPS id 47ef8d326x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Jun 2025 23:01:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNO7Jl0Z8Gx4Hz/decikqMKLdN5MYWPqXmArGsXxfxd2WiA3Tm4xJCnF0VCTQBVcRQX38UemCMy0ObYMz3SXDI2c3i8+OYYT6o8GxkPO+sW/qX0ECRRC/PwwVMPyNDz2LQ5MLMnMFaRCAb7d0BaF8nGMf3kYLq0U4RoHCeloHOiELmDlhEd3G086AgDidF8XDm/AN8tZrZnZC+t4RnBrxqKQ9rd9y4tQO0sZlqmMHvf27MLzcXE4mH3okHeYDMlQwqGjz7A5GFcO1dftqR2ytXhe0HWnCXi1VTe6pLLZSXnybI7bT7xNNPmpgqtemP3IMh1QBNo+3l2xQOG2kaIz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rd9LPIYcXL1HFewyutz8ldaj8uiHFtIVmEVxAsT7zU=;
 b=R5sIrovAHzaZlSxL1QqvzKcMji6UVFuFZLau86ANcbKPMMwjmuzg7EU9TkaEMlcRGlRhvxAf/qBxkWtRWbgy/19DBFcfRfcwl0pB2asFA/Nyl91Hn8cIvOiQFz1hauTaR4ZLXhghNa5uhVXeE6+IiPkkbJSloEkUFkbBpDAJhcafXGprvFqkihby94cFIDF71donq5Dhf4ikFKAG9ZLtf0lfd03PcIqXfOYcAn/+g721UWA32p88Gqeyy63m3zcVoDR8ahK2vuEpnJGt7zJCYxHqXbfFK8oagJoFJqUC4Mu6nnV3YsVsBsgSIJ/FYwfLOdm3KBR7cxw7oPsF0jbNYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs.wisc.edu; dmarc=pass action=none header.from=cs.wisc.edu;
 dkim=pass header.d=cs.wisc.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.wisc.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rd9LPIYcXL1HFewyutz8ldaj8uiHFtIVmEVxAsT7zU=;
 b=wSKP4T86bor1uxqr6uGktFMpkmfVo04Wtz7BxRbLmd2A4ItFta1idivuE7SD6HaH/9O2Py+LXgCqfDuQ3CiylahJoAZUON8Eog8vNqx6jaxUiqpnmbzDPiqsdy5jfPjP+lF9AmWg5gDSxlVQfGZLNbo7/OhN+Se/XhO83xyei5O+lLwQgAoSSPerJ+Hlu3LueUNjQoCEGmN8v99nZzaVylnvZzx61H5fPTApVZHp7ZPc4z2MB1zDWoNworBvBcESHJSoMVUUjPPezYyavePQ0h+CkmeGw+/+z74kJ+hILZq+mI0jhPMwLJOsNE4j4JEzN3NEpnBJTyzVS1KQnPlfSQ==
Received: from DS7PR06MB6808.namprd06.prod.outlook.com (2603:10b6:5:2d2::10)
 by MW4PR06MB8442.namprd06.prod.outlook.com (2603:10b6:303:12d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 04:01:34 +0000
Received: from DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c]) by DS7PR06MB6808.namprd06.prod.outlook.com
 ([fe80::76b2:e1c8:9a15:7a1c%3]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 04:01:33 +0000
Message-ID: <72223729-5471-474a-af3c-f366691fba82@cs.wisc.edu>
Date: Sun, 22 Jun 2025 23:01:32 -0500
User-Agent: Mozilla Thunderbird
From: Junxuan Liao <ljx@cs.wisc.edu>
Subject: [PATCH v2] docs/vfs: update references to i_mutex to i_rwsem
To: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Language: en-US
Autocrypt: addr=ljx@cs.wisc.edu; keydata=
 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
 1LHI6us+ZjzkMldzphVeBsBvT0hcR7u3cA==
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0073.namprd04.prod.outlook.com
 (2603:10b6:610:74::18) To DS7PR06MB6808.namprd06.prod.outlook.com
 (2603:10b6:5:2d2::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR06MB6808:EE_|MW4PR06MB8442:EE_
X-MS-Office365-Filtering-Correlation-Id: 44cee0e3-94ed-4db9-48d4-08ddb20aa47d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|41320700013|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ui9kNzdGbjhVaC9UcXpPMWIxbnRBSzd6MWd6d2haSGFjbUYxRU1FbWdPUTVn?=
 =?utf-8?B?cll5Wi9OalhHVzVyRTM0UHNTVU9WQS92eUlOakdyMUpiVEVVVE1IdFNXeklJ?=
 =?utf-8?B?RGdaT09GUXhQckdvZkMxaUdmY095di9zVENDbkxsNVE0S20zTFhNNmtQekpZ?=
 =?utf-8?B?UFBsMVRQWU5vL0NIelBNa1U0RUhOU09uQmc3RVNONTU1OEJpenBsbVpmY0lo?=
 =?utf-8?B?aG1MMzd0QXVCajNMeU1KeVU2NnpVc0pXVWlndGkxQlhBUWkva3VlNC9mMXJM?=
 =?utf-8?B?UklTai84MWI1TUpiR2ZzY0xuTG1nZFlwdndGTXpNM09wVUhTTC8vdEtQc2Q3?=
 =?utf-8?B?VndSc0I0dnRwakxpOWRtY25ocGpLUVA5RGZqQzZ5U2xmUUNidlpKZmoySkVU?=
 =?utf-8?B?R3ZrSjUzb012Tm5CKzZOdVZLK3k0ZGJpMlpDenQ1ZjFFZTJrZGRwd1BuQnFi?=
 =?utf-8?B?NkdEZTZKenhtbXhWZmZTZ0RDVnNncWJaZ3gwMnJMTlU1L0ErbVZGamNTcTlE?=
 =?utf-8?B?ajF4TjhKOXhCUkVPMUFIOGlCTHprN3lKR2lBeUpZOCs4ajVXa1Z2QkRySjdt?=
 =?utf-8?B?Q0tMZmE3MWtLcnlOK0N3aXlYL0ZPbGtlK3RMb1p1RnZFV280RHl3bzgxU0xw?=
 =?utf-8?B?cm85SXV0N04vTFQ3MnNrNkNSZUhiZjdnWmhFSHFzNC83MU1OeEI2TGhyVGFB?=
 =?utf-8?B?Y1VjSHBpUGo5K2MycC9KVWZ0MlZpNkVqdS9sWTlNalJ1OTFWY2dGa053aDBG?=
 =?utf-8?B?S2RoWmNsUEJMOTZGNUNJRU5IdDVYT2dEQk9SRFFIcDgza1NEREhmRmlqM2tO?=
 =?utf-8?B?YkxDVkRENEgvNVUxdFJKZGhNR0JYYndBcit3NjNhRWhqLzdNSzNHYTF0bkpD?=
 =?utf-8?B?M08yQVhMbDBERE9VWEVnK1prdTF0dXVmWS9lclJXZ1djcy9LWTFjQ1FkWkNw?=
 =?utf-8?B?emNIT3RMTEhrdE5zeFhNdmcwQ2lOamRwdU43and5dHlXK1BNaGw0NXdOMTcx?=
 =?utf-8?B?VHI5b3hPRjZPNDlQdGN2bXl1bHFHZVVmRzZTeDZMYjF2K1pFMU9zRmowSlA1?=
 =?utf-8?B?UVlXMHlmZTNBS2htUEhoRkpqWkgrTExubGRPZTZjUnFSZTNvRmVDaWJtS1Nw?=
 =?utf-8?B?am9SRjlNU01UdFdIMmJkMlBFRmd5STVzYjlFWllzWmdycHJjdEtMOEYrWFJR?=
 =?utf-8?B?RXVKbmltYnZEcENrUzhPVFhBZUVtc2x5ZUJodGpPVi9OTVd1L3Nad2xKME9N?=
 =?utf-8?B?aFhoUDB6b3RpZWwzWC9JaDJkcXQ1aXBrMGlwclFURWhyMVRvNHRZNUJCczNH?=
 =?utf-8?B?eXUrYTk4UnJOckUwcmt6U21PaktjWFR3MG9MQ0h1ZkdBVUExVStXN01wbzJV?=
 =?utf-8?B?VVhqdnNSYnkzMFR2aGF4aFNxNjdlRlptTm5HZVd1Q1hXOHlmejlINkNZbnpP?=
 =?utf-8?B?aDl1Mm0wTWVIc3ZTdGhCNm51MkRsVjNCUEdYQ0Y2c0dkK3RUeTRGeGl1L2N5?=
 =?utf-8?B?N2FDelkwa3dRWTA4S1lyYXhzM0JQUU1WM0lDZFlzdzVpamlXU0R3cFlGZjkr?=
 =?utf-8?B?YUpFdEtmWnB2bHYwK2NQa2VrcDZhSFRlNkpPR09nKzhQQmo2c1VNcTBiRFli?=
 =?utf-8?B?S1UrejJrRE9tUE1uc0l6MG84RWxQU1ppbzBsRWdydExXWEVTS3J4Skx5OTRD?=
 =?utf-8?B?K2lWanFEK0loc0lQM3dNR2FVcHBScHROemZWUEFEbkFNL2YybHNLbjdlZWd1?=
 =?utf-8?B?WTlNaUw5Qkdac1Z6dmVKWDc4WHk4SjJYcTB0dzBLUlByYTRwclhFNmdIeXhN?=
 =?utf-8?B?OTdlaDkrdTdSbWcrTnE2c3VDYlZjT3grRmFRZFRDOCtpRjdCVDB3SW9yQ2Np?=
 =?utf-8?B?RDhPOG5pcWtILzlLTThvZlFkNU1QajV0S1B1Uml4bjFQVExVaDdES2l6MUwr?=
 =?utf-8?Q?Y02/XTo7XXA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR06MB6808.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(41320700013)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TDNqVGxMcS9xU3V0dkxHYmNpeHQ3TkQrM2VNVDRlQUE0aGgwdlJqQU8xaGxH?=
 =?utf-8?B?RnprVjB0WmQ2aVdzMWxLdFYwN21NZXdtWUFxNGZLT05lRVNITXlvZzdTQm5n?=
 =?utf-8?B?VlZuL3Roem9ZLzZ4UWhPRVlvcDZJU0dQLzBjTU9NanhwV0duNHJ0UTM2WlJM?=
 =?utf-8?B?Q3JJMG9wTnk3aStVV2dVMzl4eWY1UDNSNmFPcStJMWU2QUlHbW1uRHVYT04v?=
 =?utf-8?B?N1NsV3BSbkxLOWNUQTUxbmRvWkpSZk01WWJnK3NWZEI3STNDOUpVSUMzZWFP?=
 =?utf-8?B?NkkvRzE4T3BqdU16Vzd5OUtpMm9XeWhhOUpxM2dIYm80c2tLNmp6RGdTOUw5?=
 =?utf-8?B?Z3YwQkRDL3pldGwxY3l0ejlYVUtYTEtKQkJUQmR1TXlnWm8rUi8yR2lRcUwy?=
 =?utf-8?B?Um02ckk2U29IZy93cHdmSkVxZjMvRkYzRHRQaFJjeXZWV1g2VW1tVzdOMUx1?=
 =?utf-8?B?SDNhblB6NFpwRk00OEVZOGFFUlpOVVh0NWxaK2xaY0N3cnNobS9JcGdKMVB3?=
 =?utf-8?B?WUV0RnJsTHhCdS9wTTRQZEVvZWkrWEVBeE9PTGJVcDFqTmlZUktFY3M1Mito?=
 =?utf-8?B?SDBiV09vWW1wWEM5aURBZ1VYbUEybmlKWW5YUXRTZEdOMFd3OE5ZUUVoZmxx?=
 =?utf-8?B?b0gvNHA3NmNXSWVOemp2QnRyeEZtKzNFNk9DNFJMMTdaWkRTaE9qdzFGbDgz?=
 =?utf-8?B?THFRY1NuUGVSSjh1M1VhVGpUakdPTjNTQzMyaEQyNnNuOWgxM1drRDBMdnBq?=
 =?utf-8?B?TnZ2eG1ZRDJpZDY3aTUwekU0eitRandNbXFRQ2VPUEU0RjBsMjhVNUE1RUIr?=
 =?utf-8?B?QU9iRzdmWXdkSm9Zbkg3L21RejIrb3NDQWo4SHdYZG8wSlo0ZEdwb3Z2MThL?=
 =?utf-8?B?MzNLZnhxd3YrSmZQUmRlUVd3eUkyaW9mYjVoM1VXRXU3RzFnME9neDQvYUxj?=
 =?utf-8?B?dFBEMVpYSERURVUwZ3ZmYlJDVDArN3YwaUNJbmZsdEhDQnlNSS9QV1JPZ3ZD?=
 =?utf-8?B?K1lSeEhmeUNoS2xoUnh5bFNNM0w2Vkd3VnhtM3RSY3lwRkVoSzMwWU5wSHI1?=
 =?utf-8?B?cEFiRWVpbjBwd2tGM2VBUHB6Tm0vU2tsOHJGVkJ2a2lIaHJLNUkyNDBtYUJW?=
 =?utf-8?B?T2hsWXRDdk5IaVFydFBneVRQQTNJOUYyS0M1U1JBVXlodWFNdHVnc3F6U2tV?=
 =?utf-8?B?aWlDdjlTSHNtRytzQ1Jmd0JMclplY3h6N2cwRnZCRnlpVlBjL21USEpUSG5k?=
 =?utf-8?B?c0RzQVZXWTVaQkhIT3diUmZScEdydjFpV3JuUGdCcy84OHowbm9UU3V0dGI3?=
 =?utf-8?B?cUJycHpOaElsUHBVZjg5T09RMHdvMDJoS0FKcUU0Z1k5SGRMNVlqUERZMlJs?=
 =?utf-8?B?VWtaWFBEWXBuYStYL2NuQ25HRVVNU1FKcWNzS1hSNjZVU0NaWFpHM2ptUmFr?=
 =?utf-8?B?NEhuYk5PeHd5WW1WNDVPRzBKQlduTkdJRmg3aWdzRGM4UlVQTGdOZmVhek1l?=
 =?utf-8?B?MHVieFRuOFB5K2xBL0FEMHlHT0Q5cDRQdFAvNWN5VWxucmFFOWx5UWFUUUlK?=
 =?utf-8?B?UnNvQmxvdE4wZHdMTEVETWJzUnZxVzU4em9VNnFnUWhSbDFmL1Nqc2NyZVFi?=
 =?utf-8?B?RjRFeEpzN3hVQVBHbW80VHVWeW9ZS0phMkVDbytJeGt4M0RoUlZyMDRYQUFK?=
 =?utf-8?B?M2tjelBDeHl3QUh4UjNDUzIxWU80WFZIWVhYQWxxNDZZVGlOdi92akMyYS9E?=
 =?utf-8?B?dmo3N2NoMUg4dVd5SnpnZ25Yd1haR25GNHhnKzB0OU92d0tZdDVDR1pWbkxI?=
 =?utf-8?B?N1RyR0txMFdRU255TE5pbjAwN0pGUUVUYnB4RFRmQmVaWkp1cjh6Rksxemhj?=
 =?utf-8?B?dVA2bkw1YXRYT1VzZzlTTnF2dkFJWkZqL2JWZ0tiVTdTcWFpcUdnL05XaU5s?=
 =?utf-8?B?VTJHa0hmQ3lRZVoreVZLNlg1ZEp5N3BUQy9vclR1Y1ZGemhRV2h4RmxzcG03?=
 =?utf-8?B?UEU0TFpJdCs2Z2RlMzhYSXZ1Z2d1WFcvNXdMMUZ5T1JaOGZrS3QyTjgyRG1r?=
 =?utf-8?B?OHhFUzMrY0tzcTZReTBrZnpQbWJaemhlaGVxbHcyQkFBQUIyVzRERjBXWHJP?=
 =?utf-8?B?OTRzWFY2OTcwajRRT3B5YkI1OW81Mm5KTUcyMzY2RFpveFNvY1VFbFhSeG9K?=
 =?utf-8?Q?Yl4PfrRGaOntKJSxLWfWagvy0AHw3SdO5OJ5uos1OPgE?=
X-OriginatorOrg: cs.wisc.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cee0e3-94ed-4db9-48d4-08ddb20aa47d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR06MB6808.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 04:01:33.7809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2ca68321-0eda-4908-88b2-424a8cb4b0f9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QdIskaFKFq6C9btUdYEBw+nkOk9T94IVvXVcpEQPF3YolpEQP8MVXI3WcDH2c58yUB687dlKlhB6zlV5Aoiew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR06MB8442
X-Proofpoint-GUID: Ot6kM9pUBdFdbN2EWqRPOaV5O3gFwJmW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAyMSBTYWx0ZWRfX4JfaGFlkbeO/ gCpLXAmI3l7nsGJBeCZUnGV47g8rkb4MJNB5ozAiQwCPAEKljsqdOnjnUECoVcAgjBi5BlJ6e1w AJhUf/tHih2W9Srf8PSyv2rjrLZuQUSGNL84xMsqcH5I4Op0vTrrYFCH8OY5gszweCULomM1mt0
 PLlLax0nXszz6x+ZbsLgiNoNiwo2vzBLn9Ayyf5v/QlfVxIBKkqHyyNKnzuYaNdc1HZzm9ijJc9 kPbbvo092AGN+KIbWDb5LErSs02QYRikVoCk1kzS8/MIHb0joIRKU/O8gyJ/FyGmrHCEpwdme4t P+UeLWor2WsCc+gxH5qUC9YUi4WC9sheB+l1IEVajIxfshVHuaw0kLKY+sjD+EqM4MUEH+9Jv00
 o2du5x26a91xGWGma8fsSH9D3kBqhIP1GXAgDdrLrlOsNFEIFaXTNlEiIMhPqhwOkM8Jh1cF
X-Proofpoint-ORIG-GUID: Ot6kM9pUBdFdbN2EWqRPOaV5O3gFwJmW
X-Authority-Analysis: v=2.4 cv=IN4CChvG c=1 sm=1 tr=0 ts=6858d1a0 cx=c_pps a=00UAwjix3vm3VCpLsN/FZA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=3-xYBkHg-QkA:10 a=VwQbUJbxAAAA:8 a=TR-_ifM00AsWTP8PrrkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_01,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230021

VFS has switched to i_rwsem for ten years now (9902af79c01a: parallel
lookups actual switch to rwsem), but the VFS documentation and comments
still has references to i_mutex.

Signed-off-by: Junxuan Liao <ljx@cs.wisc.edu>
---

v1 -> v2: Fix errors Jan Kara mentioned.
v1: https://lore.kernel.org/all/666eabb6-6607-47f4-985a-0d25c764b172@cs.wisc.edu/

 Documentation/filesystems/vfs.rst |  5 +++--
 fs/attr.c                         | 10 +++++-----
 fs/buffer.c                       |  2 +-
 fs/dcache.c                       | 10 +++++-----
 fs/direct-io.c                    |  8 ++++----
 fs/inode.c                        |  9 ++++-----
 fs/libfs.c                        |  5 +++--
 fs/locks.c                        |  2 +-
 fs/namei.c                        | 22 +++++++++++-----------
 fs/namespace.c                    |  2 +-
 fs/stack.c                        |  4 ++--
 fs/xattr.c                        |  2 +-
 include/linux/exportfs.h          |  4 ++--
 include/linux/fs.h                |  6 +++---
 include/linux/fs_stack.h          |  2 +-
 include/linux/quotaops.h          |  2 +-
 16 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index fd32a9a17bfb..dd9da7e04a99 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -758,8 +758,9 @@ process is more complicated and uses write_begin/write_end or
 dirty_folio to write data into the address_space, and
 writepages to writeback data to storage.
 
-Adding and removing pages to/from an address_space is protected by the
-inode's i_mutex.
+Removing pages from an address_space requires holding the inode's i_rwsem
+exclusively, while adding pages to the address_space requires holding the
+inode's i_mapping->invalidate_lock exclusively.
 
 When data is written to a page, the PG_Dirty flag should be set.  It
 typically remains set until writepages asks for it to be written.  This
diff --git a/fs/attr.c b/fs/attr.c
index 9caf63d20d03..5425c1dbbff9 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -230,7 +230,7 @@ EXPORT_SYMBOL(setattr_prepare);
  * @inode:	the inode to be truncated
  * @offset:	the new size to assign to the inode
  *
- * inode_newsize_ok must be called with i_mutex held.
+ * inode_newsize_ok must be called with i_rwsem held exclusively.
  *
  * inode_newsize_ok will check filesystem limits and ulimits to check that the
  * new inode size is within limits. inode_newsize_ok will also send SIGXFSZ
@@ -318,7 +318,7 @@ static void setattr_copy_mgtime(struct inode *inode, const struct iattr *attr)
  * @inode:	the inode to be updated
  * @attr:	the new attributes
  *
- * setattr_copy must be called with i_mutex held.
+ * setattr_copy must be called with i_rwsem held exclusively.
  *
  * setattr_copy updates the inode's metadata with that specified
  * in attr on idmapped mounts. Necessary permission checks to determine
@@ -403,13 +403,13 @@ EXPORT_SYMBOL(may_setattr);
  * @attr:	new attributes
  * @delegated_inode: returns inode, if the inode is delegated
  *
- * The caller must hold the i_mutex on the affected object.
+ * The caller must hold the i_rwsem exclusively on the affected object.
  *
  * If notify_change discovers a delegation in need of breaking,
  * it will return -EWOULDBLOCK and return a reference to the inode in
  * delegated_inode.  The caller should then break the delegation and
  * retry.  Because breaking a delegation may take a long time, the
- * caller should drop the i_mutex before doing so.
+ * caller should drop the i_rwsem before doing so.
  *
  * Alternatively, a caller may pass NULL for delegated_inode.  This may
  * be appropriate for callers that expect the underlying filesystem not
@@ -456,7 +456,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (S_ISLNK(inode->i_mode))
 			return -EOPNOTSUPP;
 
-		/* Flag setting protected by i_mutex */
+		/* Flag setting protected by i_rwsem */
 		if (is_sxid(attr->ia_mode))
 			inode->i_flags &= ~S_NOSEC;
 	}
diff --git a/fs/buffer.c b/fs/buffer.c
index 8cf4a1dc481e..137a5d05238f 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2610,7 +2610,7 @@ EXPORT_SYMBOL(cont_write_begin);
  * holes and correct delalloc and unwritten extent mapping on filesystems that
  * support these features.
  *
- * We are not allowed to take the i_mutex here so we have to play games to
+ * We are not allowed to take the i_rwsem here so we have to play games to
  * protect against truncate races as the page could now be beyond EOF.  Because
  * truncate writes the inode size before removing pages, once we have the
  * page lock we can determine safely if the page is beyond EOF. If it is not
diff --git a/fs/dcache.c b/fs/dcache.c
index 03d58b2d4fa3..ab8465ae9cad 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2774,10 +2774,10 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
  * @target: new dentry
  * @exchange: exchange the two dentries
  *
- * Update the dcache to reflect the move of a file name. Negative
- * dcache entries should not be moved in this way. Caller must hold
- * rename_lock, the i_mutex of the source and target directories,
- * and the sb->s_vfs_rename_mutex if they differ. See lock_rename().
+ * Update the dcache to reflect the move of a file name. Negative dcache
+ * entries should not be moved in this way. Caller must hold rename_lock, the
+ * i_rwsem of the source and target directories (exclusively), and the sb->
+ * s_vfs_rename_mutex if they differ. See lock_rename().
  */
 static void __d_move(struct dentry *dentry, struct dentry *target,
 		     bool exchange)
@@ -2923,7 +2923,7 @@ struct dentry *d_ancestor(struct dentry *p1, struct dentry *p2)
  * This helper attempts to cope with remotely renamed directories
  *
  * It assumes that the caller is already holding
- * dentry->d_parent->d_inode->i_mutex, and rename_lock
+ * dentry->d_parent->d_inode->i_rwsem, and rename_lock
  *
  * Note: If ever the locking in lock_rename() changes, then please
  * remember to update this too...
diff --git a/fs/direct-io.c b/fs/direct-io.c
index bbd05f1a2145..1694ee9a9382 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1083,8 +1083,8 @@ static inline int drop_refcount(struct dio *dio)
  * The locking rules are governed by the flags parameter:
  *  - if the flags value contains DIO_LOCKING we use a fancy locking
  *    scheme for dumb filesystems.
- *    For writes this function is called under i_mutex and returns with
- *    i_mutex held, for reads, i_mutex is not held on entry, but it is
+ *    For writes this function is called under i_rwsem and returns with
+ *    i_rwsem held, for reads, i_rwsem is not held on entry, but it is
  *    taken and dropped again before returning.
  *  - if the flags value does NOT contain DIO_LOCKING we don't use any
  *    internal locking but rather rely on the filesystem to synchronize
@@ -1094,7 +1094,7 @@ static inline int drop_refcount(struct dio *dio)
  * counter before starting direct I/O, and decrement it once we are done.
  * Truncate can wait for it to reach zero to provide exclusion.  It is
  * expected that filesystem provide exclusion between new direct I/O
- * and truncates.  For DIO_LOCKING filesystems this is done by i_mutex,
+ * and truncates.  For DIO_LOCKING filesystems this is done by i_rwsem,
  * but other filesystems need to take care of this on their own.
  *
  * NOTE: if you pass "sdio" to anything by pointer make sure that function
@@ -1279,7 +1279,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 
 	/*
 	 * All block lookups have been performed. For READ requests
-	 * we can let i_mutex go now that its achieved its purpose
+	 * we can let i_rwsem go now that its achieved its purpose
 	 * of protecting us from looking up uninitialized blocks.
 	 */
 	if (iov_iter_rw(iter) == READ && (dio->flags & DIO_LOCKING))
diff --git a/fs/inode.c b/fs/inode.c
index 99318b157a9a..a0150e2ef22a 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1158,9 +1158,8 @@ void lockdep_annotate_inode_mutex_key(struct inode *inode)
 		/* Set new key only if filesystem hasn't already changed it */
 		if (lockdep_match_class(&inode->i_rwsem, &type->i_mutex_key)) {
 			/*
-			 * ensure nobody is actually holding i_mutex
+			 * ensure nobody is actually holding i_rwsem
 			 */
-			// mutex_destroy(&inode->i_mutex);
 			init_rwsem(&inode->i_rwsem);
 			lockdep_set_class(&inode->i_rwsem,
 					  &type->i_mutex_dir_key);
@@ -2615,7 +2614,7 @@ EXPORT_SYMBOL(inode_dio_finished);
  * proceed with a truncate or equivalent operation.
  *
  * Must be called under a lock that serializes taking new references
- * to i_dio_count, usually by inode->i_mutex.
+ * to i_dio_count, usually by inode->i_rwsem.
  */
 void inode_dio_wait(struct inode *inode)
 {
@@ -2633,7 +2632,7 @@ EXPORT_SYMBOL(inode_dio_wait_interruptible);
 /*
  * inode_set_flags - atomically set some inode flags
  *
- * Note: the caller should be holding i_mutex, or else be sure that
+ * Note: the caller should be holding i_rwsem exclusively, or else be sure that
  * they have exclusive access to the inode structure (i.e., while the
  * inode is being instantiated).  The reason for the cmpxchg() loop
  * --- which wouldn't be necessary if all code paths which modify
@@ -2641,7 +2640,7 @@ EXPORT_SYMBOL(inode_dio_wait_interruptible);
  * code path which doesn't today so we use cmpxchg() out of an abundance
  * of caution.
  *
- * In the long run, i_mutex is overkill, and we should probably look
+ * In the long run, i_rwsem is overkill, and we should probably look
  * at using the i_lock spinlock to protect i_flags, and then make sure
  * it is so documented in include/linux/fs.h and that all code follows
  * the locking convention!!
diff --git a/fs/libfs.c b/fs/libfs.c
index 9ea0ecc325a8..4d1862f589e8 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -946,7 +946,8 @@ EXPORT_SYMBOL(simple_write_begin);
  * simple_write_end does the minimum needed for updating a folio after
  * writing is done. It has the same API signature as the .write_end of
  * address_space_operations vector. So it can just be set onto .write_end for
- * FSes that don't need any other processing. i_mutex is assumed to be held.
+ * FSes that don't need any other processing. i_rwsem is assumed to be held
+ * exclusively.
  * Block based filesystems should use generic_write_end().
  * NOTE: Even though i_size might get updated by this function, mark_inode_dirty
  * is not called, so a filesystem that actually does store data in .write_inode
@@ -973,7 +974,7 @@ static int simple_write_end(struct file *file, struct address_space *mapping,
 	}
 	/*
 	 * No need to use i_size_read() here, the i_size
-	 * cannot change under us because we hold the i_mutex.
+	 * cannot change under us because we hold the i_rwsem.
 	 */
 	if (last_pos > inode->i_size)
 		i_size_write(inode, last_pos);
diff --git a/fs/locks.c b/fs/locks.c
index f96024feab17..559f02aa4172 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1794,7 +1794,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
 
 	/*
 	 * In the delegation case we need mutual exclusion with
-	 * a number of operations that take the i_mutex.  We trylock
+	 * a number of operations that take the i_rwsem.  We trylock
 	 * because delegations are an optional optimization, and if
 	 * there's some chance of a conflict--we'd rather not
 	 * bother, maybe that's a sign this just isn't a good file to
diff --git a/fs/namei.c b/fs/namei.c
index 019073162b8a..827f53b8f8cb 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1469,7 +1469,7 @@ static int __traverse_mounts(struct path *path, unsigned flags, bool *jumped,
 	int ret = 0;
 
 	while (flags & DCACHE_MANAGED_DENTRY) {
-		/* Allow the filesystem to manage the transit without i_mutex
+		/* Allow the filesystem to manage the transit without i_rwsem
 		 * being held. */
 		if (flags & DCACHE_MANAGE_TRANSIT) {
 			ret = path->dentry->d_op->d_manage(path, false);
@@ -2937,7 +2937,7 @@ EXPORT_SYMBOL(try_lookup_noperm);
  * Note that this routine is purely a helper for filesystem usage and should
  * not be called by generic code.  It does no permission checking.
  *
- * The caller must hold base->i_mutex.
+ * The caller must hold base->i_rwsem.
  */
 struct dentry *lookup_noperm(struct qstr *name, struct dentry *base)
 {
@@ -2963,7 +2963,7 @@ EXPORT_SYMBOL(lookup_noperm);
  *
  * This can be used for in-kernel filesystem clients such as file servers.
  *
- * The caller must hold base->i_mutex.
+ * The caller must hold base->i_rwsem.
  */
 struct dentry *lookup_one(struct mnt_idmap *idmap, struct qstr *name,
 			  struct dentry *base)
@@ -4542,13 +4542,13 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
  * @dentry:	victim
  * @delegated_inode: returns victim inode, if the inode is delegated.
  *
- * The caller must hold dir->i_mutex.
+ * The caller must hold dir->i_rwsem exclusively.
  *
  * If vfs_unlink discovers a delegation, it will return -EWOULDBLOCK and
  * return a reference to the inode in delegated_inode.  The caller
  * should then break the delegation on that inode and retry.  Because
  * breaking a delegation may take a long time, the caller should drop
- * dir->i_mutex before doing so.
+ * dir->i_rwsem before doing so.
  *
  * Alternatively, a caller may pass NULL for delegated_inode.  This may
  * be appropriate for callers that expect the underlying filesystem not
@@ -4607,7 +4607,7 @@ EXPORT_SYMBOL(vfs_unlink);
 
 /*
  * Make sure that the actual truncation of the file will occur outside its
- * directory's i_mutex.  Truncate can take a long time if there is a lot of
+ * directory's i_rwsem.  Truncate can take a long time if there is a lot of
  * writeout happening, and we don't want to prevent access to the directory
  * while waiting on the I/O.
  */
@@ -4785,13 +4785,13 @@ SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newn
  * @new_dentry:	where to create the new link
  * @delegated_inode: returns inode needing a delegation break
  *
- * The caller must hold dir->i_mutex
+ * The caller must hold dir->i_rwsem exclusively.
  *
  * If vfs_link discovers a delegation on the to-be-linked file in need
  * of breaking, it will return -EWOULDBLOCK and return a reference to the
  * inode in delegated_inode.  The caller should then break the delegation
  * and retry.  Because breaking a delegation may take a long time, the
- * caller should drop the i_mutex before doing so.
+ * caller should drop the i_rwsem before doing so.
  *
  * Alternatively, a caller may pass NULL for delegated_inode.  This may
  * be appropriate for callers that expect the underlying filesystem not
@@ -4987,7 +4987,7 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
  *	c) we may have to lock up to _four_ objects - parents and victim (if it exists),
  *	   and source (if it's a non-directory or a subdirectory that moves to
  *	   different parent).
- *	   And that - after we got ->i_mutex on parents (until then we don't know
+ *	   And that - after we got ->i_rwsem on parents (until then we don't know
  *	   whether the target exists).  Solution: try to be smart with locking
  *	   order for inodes.  We rely on the fact that tree topology may change
  *	   only under ->s_vfs_rename_mutex _and_ that parent of the object we
@@ -4999,9 +4999,9 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
  *	   has no more than 1 dentry.  If "hybrid" objects will ever appear,
  *	   we'd better make sure that there's no link(2) for them.
  *	d) conversion from fhandle to dentry may come in the wrong moment - when
- *	   we are removing the target. Solution: we will have to grab ->i_mutex
+ *	   we are removing the target. Solution: we will have to grab ->i_rwsem
  *	   in the fhandle_to_dentry code. [FIXME - current nfsfh.c relies on
- *	   ->i_mutex on parents, which works but leads to some truly excessive
+ *	   ->i_rwsem on parents, which works but leads to some truly excessive
  *	   locking].
  */
 int vfs_rename(struct renamedata *rd)
diff --git a/fs/namespace.c b/fs/namespace.c
index e13d9ab4f564..8a1bfdf862f8 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2053,7 +2053,7 @@ static int do_umount(struct mount *mnt, int flags)
  * detach_mounts allows lazily unmounting those mounts instead of
  * leaking them.
  *
- * The caller may hold dentry->d_inode->i_mutex.
+ * The caller may hold dentry->d_inode->i_rwsem.
  */
 void __detach_mounts(struct dentry *dentry)
 {
diff --git a/fs/stack.c b/fs/stack.c
index f18920119944..d8c782e064e3 100644
--- a/fs/stack.c
+++ b/fs/stack.c
@@ -3,7 +3,7 @@
 #include <linux/fs.h>
 #include <linux/fs_stack.h>
 
-/* does _NOT_ require i_mutex to be held.
+/* does _NOT_ require i_rwsem to be held.
  *
  * This function cannot be inlined since i_size_{read,write} is rather
  * heavy-weight on 32-bit systems
@@ -41,7 +41,7 @@ void fsstack_copy_inode_size(struct inode *dst, struct inode *src)
 	 * If CONFIG_SMP or CONFIG_PREEMPTION on 32-bit, it's vital for
 	 * fsstack_copy_inode_size() to hold some lock around
 	 * i_size_write(), otherwise i_size_read() may spin forever (see
-	 * include/linux/fs.h).  We don't necessarily hold i_mutex when this
+	 * include/linux/fs.h).  We don't necessarily hold i_rwsem when this
 	 * is called, so take i_lock for that case.
 	 *
 	 * And if on 32-bit, continue our effort to keep the two halves of
diff --git a/fs/xattr.c b/fs/xattr.c
index 600ae97969cf..8851a5ef34f5 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -215,7 +215,7 @@ EXPORT_SYMBOL(__vfs_setxattr);
  *
  *  returns the result of the internal setxattr or setsecurity operations.
  *
- *  This function requires the caller to lock the inode's i_mutex before it
+ *  This function requires the caller to lock the inode's i_rwsem before it
  *  is executed. It also assumes that the caller will make the appropriate
  *  permission checks.
  */
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 25c4a5afbd44..cfb0dd1ea49c 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -230,7 +230,7 @@ struct handle_to_path_ctx {
  *    directory.  The name should be stored in the @name (with the
  *    understanding that it is already pointing to a %NAME_MAX+1 sized
  *    buffer.   get_name() should return %0 on success, a negative error code
- *    or error.  @get_name will be called without @parent->i_mutex held.
+ *    or error.  @get_name will be called without @parent->i_rwsem held.
  *
  * get_parent:
  *    @get_parent should find the parent directory for the given @child which
@@ -247,7 +247,7 @@ struct handle_to_path_ctx {
  *    @commit_metadata should commit metadata changes to stable storage.
  *
  * Locking rules:
- *    get_parent is called with child->d_inode->i_mutex down
+ *    get_parent is called with child->d_inode->i_rwsem down
  *    get_name is not (which is possibly inconsistent)
  */
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 16f40a6f8264..84475c75c9e6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -839,7 +839,7 @@ static inline void inode_fake_hash(struct inode *inode)
 }
 
 /*
- * inode->i_mutex nesting subclasses for the lock validator:
+ * inode->i_rwsem nesting subclasses for the lock validator:
  *
  * 0: the object of the current VFS operation
  * 1: parent
@@ -991,7 +991,7 @@ static inline loff_t i_size_read(const struct inode *inode)
 
 /*
  * NOTE: unlike i_size_read(), i_size_write() does need locking around it
- * (normally i_mutex), otherwise on 32bit/SMP an update of i_size_seqcount
+ * (normally i_rwsem), otherwise on 32bit/SMP an update of i_size_seqcount
  * can be lost, resulting in subsequent i_size_read() calls spinning forever.
  */
 static inline void i_size_write(struct inode *inode, loff_t i_size)
@@ -1923,7 +1923,7 @@ static inline void sb_end_intwrite(struct super_block *sb)
  * freeze protection should be the outermost lock. In particular, we have:
  *
  * sb_start_write
- *   -> i_mutex			(write path, truncate, directory ops, ...)
+ *   -> i_rwsem			(write path, truncate, directory ops, ...)
  *   -> s_umount		(freeze_super, thaw_super)
  */
 static inline void sb_start_write(struct super_block *sb)
diff --git a/include/linux/fs_stack.h b/include/linux/fs_stack.h
index 2b1f74b24070..0cc2fa283305 100644
--- a/include/linux/fs_stack.h
+++ b/include/linux/fs_stack.h
@@ -3,7 +3,7 @@
 #define _LINUX_FS_STACK_H
 
 /* This file defines generic functions used primarily by stackable
- * filesystems; none of these functions require i_mutex to be held.
+ * filesystems; none of these functions require i_rwsem to be held.
  */
 
 #include <linux/fs.h>
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 06cc8888199e..c334f82ed385 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -19,7 +19,7 @@ static inline struct quota_info *sb_dqopt(struct super_block *sb)
 	return &sb->s_dquot;
 }
 
-/* i_mutex must being held */
+/* i_rwsem must being held */
 static inline bool is_quota_modification(struct mnt_idmap *idmap,
 					 struct inode *inode, struct iattr *ia)
 {

base-commit: 381011d6ae29857c35cbcd8a4ec6594484ecfc84
-- 
2.49.0


