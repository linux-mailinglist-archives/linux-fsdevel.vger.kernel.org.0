Return-Path: <linux-fsdevel+bounces-66669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0C2C280AB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 15:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4E73B7E1A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 14:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48E82F3614;
	Sat,  1 Nov 2025 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eMM94vaj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012044.outbound.protection.outlook.com [40.93.195.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A49D229B38;
	Sat,  1 Nov 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762006755; cv=fail; b=hay20p9ESDw0DsNVOKUYlWbSIwHYKEC/4oF/Cdc7rKC/mnHPqktjzMJEpY3kkFZdvN+QlnGcgfkH8XRLYK8F9yFip8R6M2hYdyuocghgtT4cX7mEL+4Tgl4PzGsZeTk71kTuYsRZQVegHvOg+7DUlrCeqq9aOyTThQ8n8JjSans=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762006755; c=relaxed/simple;
	bh=zQ+Pa6nuKMFwGM837Hxg3mt91H8lvVfKpU9aBOncRqQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=u8KAK0CdRPPDJulbAgLJfrY7XyOcya3rPTQ9R6Jf0MOisDtCnV9JNoPuBqVEWeWPLq8SrIriVWJqnsa4KeassBC8QQEPDYtrsqXmsueVnVLPQMLj+YZVfSH9eTb/dzw9Kp6h9RQOcpi3fjRTdxRo5ODrtESym8OlqoCvrtr6B+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eMM94vaj; arc=fail smtp.client-ip=40.93.195.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lyy3BAGaf0cpXrzQKsmyjCj1cxSONHO6zRfHs0cTiXoQ9v1ijC2nn0yt+ruvPEUmvBspILzEeh18v2KRJrvyvqb5lCgSbO9HlhwTqd4JsDnGY8wZZ5P1pOWEnFNB7EQd1WqDEqV2oqYlv54CmmiUa9EjNyemEu1XyaZZknwF5+ewfl5QAV9mH1d4TPvbFp9kDA/11wbtMbYH6YAbK1PpVG/3JUJDjK1krqwJh0R3o4YT4uMPna6QXvIo9wp6Lbli6GPyxFAy34g9X9yzIk9Y65cPVFrNdoyCD61q1ALi7VE0abSOdLx4Nrf4erJb6MpT/M00dZqbZpf/2uUqIyfoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpDpJFDUZV96JhY5OJFsySTmHPCrkGYOvC6kgAb2J1A=;
 b=q/bGHNUJd8HI30Abh79nqwsIKRSTdMuOjCbWZ5/MftxCZ/q5ClTwIFvDe0KlIDFpHnM/k1zCQ976uF3r7w2+k09KTba0p9OFS/W/6qWCoDUVUVpDyQCGvQA4fTaPW4phA+aGZkZtvaTXODMBoL7yBvqcX6nfapaLVptrkdBG7GF0vSADA89h78NiaOfnQ3wa5tPzKdda1OVAk/JelRoqwF6N5j2eJr9MzNFUv2SY8u/hjPTsZlVgVTf+F16brxgSSCu1XB4Do+O1uVS39zbdKK9IalqIIiQODnRNxn0PU1D7A6SxjEn0lub0A0GVtcaKcTuLN7RB9hvzRJm9xnQ8Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpDpJFDUZV96JhY5OJFsySTmHPCrkGYOvC6kgAb2J1A=;
 b=eMM94vajWbrKw/znXDwoNtGupxG+sqGAn4R51iA3yMgNkJD1m/MHoVfnFOjbYG19DPC3gJ8UJ5R1GE6k5jUkou7qoB0ck8uvRRb2ZLwD6cCO8o75b4BCvKmvuyrbVBNPmnUqihI5Ujx06nYH7yYQ3TDNtEBsCh/8OxoPc9gKRQtMf8933UiH6V1ihyDyvGrqsy9Ni9tmnaP3xN7kp7uLD7ek3ogfcE8RMuGGqqYSnG4o9OmY6cuFT5M7+UQK2/H0lz6UBqIsh/qXSFfOObNmVjMPqZF5spPnx/gv33xfsl5lRjX0Kr8Gc/HHMpWWaXVfktEHMI+dHSzkjuc/QGG9UQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB6740.namprd12.prod.outlook.com (2603:10b6:510:1ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 14:19:10 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 14:19:10 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Nov 2025 23:19:06 +0900
Message-Id: <DDXF9GTWLHAV.2XR669Q44I0NX@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 04/10] rust: uaccess: add
 UserSliceWriter::write_slice_partial()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <mmaurer@google.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251022143158.64475-1-dakr@kernel.org>
 <20251022143158.64475-5-dakr@kernel.org>
In-Reply-To: <20251022143158.64475-5-dakr@kernel.org>
X-ClientProxiedBy: OSTPR01CA0039.jpnprd01.prod.outlook.com
 (2603:1096:604:21b::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 25167742-2aaa-4ef3-d98e-08de1951a02a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXZmVkJlZUtjOHlwRDRrdVcyZEppUU53ZGpqN2FqQnBrQ2VQWGRYSjd0NWpy?=
 =?utf-8?B?ZHNjdytZSm9ybkRBdjdOUnNEa3h3RjRta3VBMXM3OURKbFQvckRXZ2N5NVJ0?=
 =?utf-8?B?NmpkNWNjNEZqVThzTXN0WTRVM3ErVHFla2I5dEZ0VEVwNGl6T2RQeUxVQmdH?=
 =?utf-8?B?djU1dSt4TTUreDBsWUNyMGl3bEVGUHhFdExKdCs0ZzhTWi9rcDVqemdMVU1T?=
 =?utf-8?B?ZW9DS01LN1ZpY3R0QlcyQ2E5bVBsK1F2U2E3TDB5dHpuYUFZZVhlNmRLcU10?=
 =?utf-8?B?Ukw4c25RRjcrTUFZNUc4d1VSa2lGNjNFUmNDRWw4M29ucS9wWlZ6b3kvVy9a?=
 =?utf-8?B?VWx5ZnF6cG9EZTNrVHVDN08yRis0SHNiNjVOT0t1QXRNV0pub2ZoSDRCa1lO?=
 =?utf-8?B?Kzl3UVcwZXVSaVByc3l5L2x4YTRaVkx1R1NqRzdyRkFsb2Y1UWxZRXVRek9m?=
 =?utf-8?B?TGdZVUs3LytnYkhvUXZWd29qMnNyQWVyVGhKUUhHdS9qQUtNanVLMmNMM2hh?=
 =?utf-8?B?VUo2MGpmUkNBcXZlQzZpY0NNVmJLWDFKZSsrY3pLNnIwcWJBbTI4WFNlRkxR?=
 =?utf-8?B?eVN6YjJxSmVBYXkyMXZDcjBEdVNmL083Zk00SkJaNFZUaTQ1YmJVVlRtOEhx?=
 =?utf-8?B?dEVpWnQ2RzRHSlpDOGlzR1JaZ2gwYkIzT2RsR01uaFhuZnVLRHluaUkwWDBz?=
 =?utf-8?B?Y09YZUp2ekN6WDNPeW5VNnRjczc0TnBqc1JXY0lyVVkyTmFPRXBjcDVkMzha?=
 =?utf-8?B?aU1iaGdLUVpXM1Z0ZzQydUE0ckZ3UjFlNk5xU2VabWdGYy83RENRdWx3Q2Q1?=
 =?utf-8?B?RE4zaUZ0dlRvbzBkSmxBcGdSOCtOZ0RMUUJ2cFdRY1VxQXFVeVlzOW1oQ0E2?=
 =?utf-8?B?RzdOY1lNeTlFdm9ldVUwK3ltTEhtNXdvalpFb2VzaUxnK1VDQ0pqVGRVWnpk?=
 =?utf-8?B?SXFRVzlyUGYzRW52cTYzQXcxUldJTXIwcTRtZUo4NVlTSjVyRFBpMVp5UWF3?=
 =?utf-8?B?UWw2NmxkWGh3UnhOeUNDUUEvSGVoelBOekVON3U3aXhsVnh0UDlZVkRQdm1j?=
 =?utf-8?B?T2J5anZ5L2haUHFCOENvNXJ3cGNSODEwZWdIenRETlpHVTZLSzRuSkVmZkNz?=
 =?utf-8?B?elk4MkwwZXpHWUN2OWFSQ2xBMzU0ckpsYU10Si83L2JBTjJVMWMvUTlvY1FS?=
 =?utf-8?B?M3lvT1psc2NEbnlJeUNBTjJsN000ajcvRWlEUEY4anJqdUtSb0JnOC9udnFE?=
 =?utf-8?B?ZGNjU240bHBWSXZxTGNydk1NNlhaWGdtVHRkay9YTmQ0cFcraHVmUlZqc1g4?=
 =?utf-8?B?OWdMZDJydGRVdXFVUnFQa0RET0Q2MXhobGlxSGxHVTMyMzc0b2Z1QzB4S0l0?=
 =?utf-8?B?emM4WDErNFVrZlM5STNMRXEwMUJFN3JVQkp5VEoyZG5OSFJyZmwzeUVzY3gy?=
 =?utf-8?B?S0w4VHBzdTBSTlQ3aWtadHh0cnJTcGpjajJ6aEM2Zmh4VTEvU2kxZEpRTWR2?=
 =?utf-8?B?N1lKTEdleVQ1alB6OXBoUXZMWTZ6T2pUUVdUYjd6UHR2ZWdpTDg3dkdLb2JC?=
 =?utf-8?B?RXE1aEU2OFY2TXlJNkltanhvT0d3UjNiK0wzOVcwRHoydHpUL2tqZlhqWDNZ?=
 =?utf-8?B?N1dXbEswVS9lTFZsT0tiZVh0VEYzbEFLMkI0Lzd1SFdDTlVXbnIyVDVMR2R1?=
 =?utf-8?B?aU5kbmtrZWtianVwNjk3eGpuWXIyV1MvRjhOd2EzZkxWeDEyOWt6Q1JFcldB?=
 =?utf-8?B?dzlzUWJ0TWY0YWk1dCtmQVd6TTM1Qmo4dTNITU5EaWFCc0xVNk44U3VwWjhH?=
 =?utf-8?B?Tm9NazJIOGhDcFJXdHl2N3dHcjZZaEdPcllYNUdEem5XYUxyYXFUMllnZTYy?=
 =?utf-8?B?dk1tKzhzR0xIdXRJaVU5Z05rb2txeXZudmtMSUhxODBxQ2RDVy93Q2tsVG9i?=
 =?utf-8?B?UzhCV1ZNVWVYY1pjUWE3Sk5SN1QzSlRCVUNERnFvV2VnSklDUVcwUXlsOEV4?=
 =?utf-8?Q?SSy2vS/GRRUTaNmnmL1gSWEwT6ak2E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0FWT0l6TldrMjczQ1FKREVqT2NveHNzbjdldzFlYlZMS0k2eXlXVHY3eFY0?=
 =?utf-8?B?YjNDdGM5d2dnSU92b0JpVHJ6ZlVVd2hmbjRZbUVkUHZsK1lVSFdhb3U5V0hj?=
 =?utf-8?B?aDhFQlRjVnRFVDRoUGdHbC9oSVRUdGhMTkxZWHdZeU5TWURFdFI4eU1PNVFv?=
 =?utf-8?B?aFpGc3dvajI2TnNxR1dBQ0UwMEFhQjc4WE01T1NZOXJYbStMS0pBWS9GRmlp?=
 =?utf-8?B?VSt1dGk4Z2NIa2VzV2d3TUM3VkxUK0p6OG50K3g3ZFRwWTA3K1kzbkZScldl?=
 =?utf-8?B?S3ZjTUcwY1FRdWM0ejM0M3ZRNS8xcU9wYjMzc0ZIbUowbTdvVW5OcWplQXVW?=
 =?utf-8?B?Y05XWFZCTkVKKzNsUk1JSUhnZ2FXSFliL1NRa3hERVNvU3hhZ2JrN1h0Mllp?=
 =?utf-8?B?YUZOdktkNnpVMDZUZWhkanMrTktBVko5TWFCTWVsaUhjSENlaUxSZEhNbThG?=
 =?utf-8?B?dU1JZWErNStEOGJTbm4yNnQ2YkhlWmhhY0lscUNqSHpvNkpuSE9BeVNKdVNm?=
 =?utf-8?B?Y2lYekVCcGlxdFNML0pmaUhZNmIxTi9JY05jbTNhQjByaThZUTdvc0dkYm1v?=
 =?utf-8?B?Z0MvT05pMmFQT2ZQKzJ3QmxhRkVuREhOU2ZpRjFXWmdldUhYRW02ekNENHhU?=
 =?utf-8?B?Mnp6a3ozamNEQlFJTG95SjVXQXVjN2Ric0M3bXIvanlrSm1jb0k4QVcwNWVw?=
 =?utf-8?B?SjFDa3BneGxSeDZDWk0zbzlzSlVvQ044SVNjL29Jc25oYUtFNnhRendVdXE4?=
 =?utf-8?B?V2l4MkxBdXZycldtdll0a2RJQkh6ZUcvZlIwSFNNTnFUSXhoMThla2hqNC83?=
 =?utf-8?B?NDJ0bFpGWmJuQ3JlYlpSNVk2RytueWIxcVRWOUVJdlFFWVZVZ1RkMDRyL3Nr?=
 =?utf-8?B?K29Kd0pmTDdNQnZxYnRkTWVJaWpSZ1Z6V3FpblBTYzl6S1FEMU9Tc0krcWVv?=
 =?utf-8?B?R0JFUmtrUTNhVzJ3SkV3dG1qTTlJOFI5dzV2bmVreFNnZ2ErVTRVNzZiaHdT?=
 =?utf-8?B?M21ETUIxaDhKV3VROUdUWTZ5RXU5aEViWkhlSDhIODRXNXBkd0l6VHI5VVpX?=
 =?utf-8?B?ZDg2WEdtcDdvaFB5N3RFKzdXRDBVUWxaaERrQXRMVmhuSlp6VEthZDM5a0xZ?=
 =?utf-8?B?WFhib1REcXFxRGRBK3NZVTVkMkpqOFpXaHJjck8vbndYUUo3TUdza1BNYksx?=
 =?utf-8?B?dkxlcElvUTZZdWdIc21va0ZqbzBLK29UWWR2ellQSUtaVDM3OGRIeklFZDJl?=
 =?utf-8?B?L0xvOGx5SDB5UGNEOFY3SWZhSkpCMkRaOUhHeE9UcXdSYU5UTUVrblRORmJH?=
 =?utf-8?B?N2NvTjV6RmswVkZvMU5nS1dtcXVOZFYxMzRBL2dqaWUrdllwcUhwMnNmVVpM?=
 =?utf-8?B?VzVqQ1JUa1JqbjhYeExhVzVqcThCMmFPNzg0MmJZaEg2ZXNBemZQSGx6clNn?=
 =?utf-8?B?ZXI3Z2FMbTN0Zkc0Yk1teWI1UzBkL0RFQ0dibUdVS29zUE5meEVFTDVPSk5M?=
 =?utf-8?B?eU5nUytpSkUrR1Fub2xBeWxPWVFNVHE2c0crTzYwcDZGSlV5TXFiQzRsaUhw?=
 =?utf-8?B?Z0pIb2ZCMXlhSzdHc2JhS0VZb3VuR1BhTkV5eEtqSlU1WmpPbHE0R0ZwbHJw?=
 =?utf-8?B?S2x1d3RuYkVDdHc1Ni9ZR3hyTUk0bVovblZBeVJBYjVoYzdFZFhhSmQvM3lU?=
 =?utf-8?B?K2V6Qm9laWlTQ1NmU3hyNFpScTZuZWhyM3hlQVYybEZoY00xOWRoWGVTRzd5?=
 =?utf-8?B?eWVoMjAwR3RLeGMyVVQ5cGhGMlVSTmdmWUg1UFhkQUFpZ1VCTkkvZnRKODRL?=
 =?utf-8?B?cjJFUVJyc1JuRi93VVhKNWMyRjhHNXRmZktOZGpjMC92Zm4vc2oxSWZ0ZkFo?=
 =?utf-8?B?RmZhS3p3T2ZMY1BGYndHWTR0WWZZWkttNGgzZ1oyMjlScWtpOUk2SFp0NVpy?=
 =?utf-8?B?L1VWU0N1cGJSOVUrbkNvdFJ5aHlMSUo3eW53czZDdzZwTkhxL3JuRHQ5eFZr?=
 =?utf-8?B?cS9ReTRXVlVRclY0VXZUUm5hTzJWMmxCcHI4M21uTEJSc2dYcGpDMGY1OThO?=
 =?utf-8?B?N2xKNFF3UEtyRUJaNUlVSVF0V2pVeEowWDZZcDkxNUlXWmVEREplVSszN2RX?=
 =?utf-8?B?Skp3cWJaVDhvRVNENHljbnhMdlVqbFgzU2JwMUJpL1Iwbmhqa0txaDBidmdF?=
 =?utf-8?Q?v1WSZbRA9ejF4OLSgXyEGpMNHtPputAlJb59x+IZ5qiH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25167742-2aaa-4ef3-d98e-08de1951a02a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 14:19:10.6144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1wFwvuv9S8s1UG0Ffer+jEqFG+g6J5OB70y2tNpa89YFBj6dzkPRYkLVhReiMc88c1fnzN8PLuqgvxBB5Ic/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6740

On Wed Oct 22, 2025 at 11:30 PM JST, Danilo Krummrich wrote:
> The existing write_slice() method is a wrapper around copy_to_user() and
> expects the user buffer to be larger than the source buffer.
>
> However, userspace may split up reads in multiple partial operations
> providing an offset into the source buffer and a smaller user buffer.
>
> In order to support this common case, provide a helper for partial
> writes.
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Matthew Maurer <mmaurer@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/uaccess.rs | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index c2d3dfee8934..539e77a09cbc 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -479,6 +479,22 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result=
 {
>          Ok(())
>      }
> =20
> +    /// Writes raw data to this user pointer from a kernel buffer partia=
lly.
> +    ///
> +    /// This is the same as [`Self::write_slice`] but considers the give=
n `offset` into `data` and
> +    /// truncates the write to the boundaries of `self` and `data`.
> +    ///
> +    /// On success, returns the number of bytes written.
> +    pub fn write_slice_partial(&mut self, data: &[u8], offset: usize) ->=
 Result<usize> {
> +        let end =3D offset
> +            .checked_add(self.len())
> +            .unwrap_or(data.len())
> +            .min(data.len());

Same suggestion as the read counterpart about `saturating_add`.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

