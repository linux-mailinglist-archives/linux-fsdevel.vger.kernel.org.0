Return-Path: <linux-fsdevel+bounces-66667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E3BC280A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 15:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471B03B3D6A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 14:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6AFA2F6917;
	Sat,  1 Nov 2025 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eq4WZit7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013016.outbound.protection.outlook.com [40.93.196.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3F72F6576;
	Sat,  1 Nov 2025 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762006614; cv=fail; b=axf+2hy+RGfccc9rbwvErabNj0/ucCDgb0TBY1A89huIyl1XFHr387Bipmbt3FgMAXL9cXKEjOxDvoZavt/qjvzHKbNhlYq9nMXwlALaUR/2tMeinFKk3Q4GFVQWiz/c33Bynb6wXF03nvs1qY1sYXayXBkA3DoOq7gpID6A2L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762006614; c=relaxed/simple;
	bh=BInAm+kOH6O2EV27wjtVCDEqHUJt/CHvFH6uND292zI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=O2oEuwg/vx3MaXLly1ucU20f25Vj1i2ytSASdC83FFY4ccng1z1EpWvCEsrg2OCFbuEdhx3c46Oj2dcIepHOXmRcMH5XDc8O+NWFg5rxTvOJIJPeMlljcpO6stasvTcDJ2QF+G7C7J6p21KdJkVrbxF9JKNhapewGN8xx29YgfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eq4WZit7; arc=fail smtp.client-ip=40.93.196.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iv6tKylqzZ+uOPxZ4NY9YQipYBnZazn/11+j6YOY1AFBa3CAxM3VkS+y2bivfw775p3DMirkC/eILGJsonKPvpwe7ANGrB+Cn4LFmT88nKpsD8FyGkRsWn55yD7DiHeV6gWck0okb2jBevzwnq0tNfS/LxyevaCvstXp7di/atmX9dHmdQq8/SjCojqoaLeHK8gClOv4NCHFsn9EHchDIsP8UocLHBzMsexO5FSbTDD60Qoctldxea0HjWsNG2IonFVPA7TTF2ag/uhHqBnj4I4vQnxMlqyEirj+G7KTOMFkNbBFWUCJnM1MVPbn5oxXKi/xzz96X+HIbIl47l/uSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okO+ug9yebCruz75afvQ7mFaFjUrk+gRtbQKycMKN7s=;
 b=X0jXHt+GFvO6WL1Fvmteiej6s8wjClRKd9m6hXSSy+DWjrtkIFHDEbzbAhWC0/cu5TL0ZuAQE2pQGgW02rwAqNWTwjn5nci0FBnuj9rnsgekV0CfeGbzuMl5Ee8xRFVD81Zp5JxTZRXcVuovJf2moY+fHlu5OFXbPWeWSqE+2RpLvsaftzSq431mbwwQu/me6RpTKuylU4zUp5XEHBUjfqWdZp1dxw4WLVEVvjiWIo/ZodXK8du64arDW8/0uexoZQ6P6xErTZ1Jvt2uG9O74PuGMPeS2GZL49pNmziyq+eE4+oLwoA9K3pslBu7qmZoW6t4YEuQNhf+zKbkDQIBVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okO+ug9yebCruz75afvQ7mFaFjUrk+gRtbQKycMKN7s=;
 b=eq4WZit7gEDVYVXNZp36LJMKeX8tPpOVr/MfFMbkGaPFyTutiDFxu3hBPP2mY6IEmF2fl0vSctrCQnWa//8qICT5tKhXIYRP3mgA0OJK0TczNz5oKux/aymNOKyHqUd6UgjrLZip2rAKxiuyGPNbNefIpAPteJWk+JBda8nLz+ydgZGbNO6QFIQk/9TywdBttjyV/Tq4w3Kjgoi1uwMpHumNAqj2nHSHu1Q9IxCcM5ZTxAWOE03VJu+OUMDt+IW0CXzIV/YoN8geol6uVbsDM7fWNQ+QnzXVCpmTy/mhSG5aCn/Sks0jC6g/aqJ9WGMFhMsidDuuZn0U9qe6dUcg+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB6740.namprd12.prod.outlook.com (2603:10b6:510:1ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 14:16:50 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 14:16:50 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Nov 2025 23:16:46 +0900
Message-Id: <DDXF7OC6245W.20JRVUD4LCPFP@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 02/10] rust: uaccess: add
 UserSliceReader::read_slice_partial()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <mmaurer@google.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251022143158.64475-1-dakr@kernel.org>
 <20251022143158.64475-3-dakr@kernel.org>
In-Reply-To: <20251022143158.64475-3-dakr@kernel.org>
X-ClientProxiedBy: OS7PR01CA0293.jpnprd01.prod.outlook.com
 (2603:1096:604:25a::16) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: c23e5530-d0fe-4ae2-5a1f-08de19514c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVR3TXRKdjVaSm9uQjVLRHBPa3FVRzg2QXdvL3QyNlhoSzlzc3E5aEN3Rmg4?=
 =?utf-8?B?dDN4ZFFpcDZsQTFwMkpEQlBZaVNUZzBZRlJJcWJCU1RUOHlCeTBpeG9QbUZY?=
 =?utf-8?B?QzAxaXFpbGlGdU1RTW5DVm1rZWY5aUNxTjVQQzNjN3ZZU002a2xFckV6MU9I?=
 =?utf-8?B?RjJzM2c4KytodmF2U3EvemgrOU9SWUNCYVZrTmM1bGp2OXJIWklra3huM2dr?=
 =?utf-8?B?Z1BJbm00R1drbW9GVnNGYXhDRkxEL21QTHRSei8zbE9JR1MzSnZiUWlIYng5?=
 =?utf-8?B?OURQdHRjYjdZeURHOXZqbHVIZ2JxZjJseDRrV3greXNxbjIrZ0hxNXYyYStX?=
 =?utf-8?B?S2d3eU9rcHl6M3pNOHgwQmVIZ2dvL3BOb1UxZ0ZrZU9yN21ZblN4L29KZ01V?=
 =?utf-8?B?bmJSVlVnMi90OHZTLzRpZFB0dHJzdmVxRDFJNW1JOVhSYnlRcWJ4RlFUc0hm?=
 =?utf-8?B?QkxaMHE2R2ZoMWhCcDJjekdVSTZKU2w2d1FQNVdYMHVWUjNQZUNoMVFZTm9P?=
 =?utf-8?B?VFZJbjEvTHh5NmtYb3pkMXBNajhELzhlbU1STlp3WHV4VkFRM2VVMDFqVVJ6?=
 =?utf-8?B?enJJZGVaVmwxbTV1L2liOEYxWU52VTZCYUFnR2ZFWXB6ZmRwelpXNkZXc3dU?=
 =?utf-8?B?cUtzaldJMWdCNmpIc1d2TEk2dGlOckFEMTVrVExxTC9PZkxrSnE1ejVsVENX?=
 =?utf-8?B?bDlqYnovQUhLam1DYU56ZFI4YTNFN2hyakJMK0FQZm1pdFZrZFFudXNMSEJN?=
 =?utf-8?B?SXlCc3Y1SkJ6OU04MXZUUzRLdnlWODVrM3lreWFtR1VBa252WFZhSk5XbG1t?=
 =?utf-8?B?cktkcmpRSUF5cDE4dEx1ZVJ3UGFLREgrQUlaYnhDQjhPOGlQVVlEVzJ6eUc2?=
 =?utf-8?B?UnhaVE10Z3psMElMVEVqc1NSeExkbitYQ2JPTVJPRmtTd1JTRlZyMWhSV09k?=
 =?utf-8?B?OC9IN3hwVHZpR3JrZ3RyOWV1Tk93ZWF5TmdyNGpVTnlYeGxBN2hBcjRicXIx?=
 =?utf-8?B?TEROWS9uUkFkVFdYYXplSWRBOHFxK0RhVTd1aVRoYWZKdHlnd1FUK0xxOW42?=
 =?utf-8?B?ZEV5cmFRU0dsY2psd1JLK1FxNkxPQ21adFE0RTJVby9qMGtrN2d4amg4V3hS?=
 =?utf-8?B?aG9XRWhMcjhKQUV5a29DRzZlb0dIOU1MMUhENTkrNzAvc2c3MW5nRVcrenpo?=
 =?utf-8?B?Ymh6WndLM2gzN3JOK3NwZ2MrbDhuZG40VjZLQ0dCTnkzVkpjTGR4S0I2RlZN?=
 =?utf-8?B?eXFIbWl4MWUyOXpYTi9qYlFBSHhZVWFqK3l6alJSdms2blVlU0V2emNNdTRO?=
 =?utf-8?B?enArYzF4WUE0eEMxYTNCVDNxWEs4QUdSSXE3ODN1L1Jia2dONDVRdFJaSTVJ?=
 =?utf-8?B?KzhzRWhoTEl4QXRkcjlaenNBQTJuOU5vUk80SEhGdjM4cGZTYnA4c3RrUEtm?=
 =?utf-8?B?ZEdpWkNsSS8rUzQ2cjVsTTNlY1dvUndQL0NmcitpSU9IbGFxeXkyVDZHeVlK?=
 =?utf-8?B?bnNMUHQ2Y0hVMDBhOGRSVWowdGtKZGMzbGk4SFBHaEpCb3diRXJYNi9VUXAy?=
 =?utf-8?B?NGFOUEhRS2VmK0JPZ3ZYUkdVZ0d6OWdib1AyOE0zSGJBT3luSnIzRjh2Y3hQ?=
 =?utf-8?B?VE9QUzZ1ZUxQNEhSSE5tOVB2T0JjZm5BbzBTcTVuMEJRU0NkME1XcnhtZERm?=
 =?utf-8?B?WkJsY211VEx3WXpDUTRpc0ZOWENBQ3YvVXpXcFNMY0NCMk1zY3JCdlpSR3Qy?=
 =?utf-8?B?RnZMVnlRNVYzc3NhcXY2UlVEVlNiVUI2RklJQ2JVN29WWEExcDNrcWZGdmFC?=
 =?utf-8?B?RnQxMjFoRmpqRzNIUkVjR0FaWTJ5TTFtY0NiMFRaaWlpNnp6MStaVWl5dXdn?=
 =?utf-8?B?Q1EzbFhScCthUmtKQ05JaHJZSHl5clFQOStrK2dCK2M3emZZQXZNYmZGcXRQ?=
 =?utf-8?B?MXpLeDhuNWY0M3dxazkzQ0Y2NEhGaWFoRkMxYStNR1FGYlF2YUpMc2N3Nlhj?=
 =?utf-8?Q?2dr1WchwcV+TbwLAnsnMxepnXIzcqA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlBoUnA4OW0vWUZkbk5lSmQyVkhRdzdxd2Y3aTdqZGZLV3gxejVWc3B6RG8x?=
 =?utf-8?B?STBiVVRzMW0rZjZ1dTBPSFBTUnd6UDhjeEtkS2haem52SStNQVlwaDJ6NWdJ?=
 =?utf-8?B?U2JNOGNRZWJ0aEdlUVNVeUlHWWhKYkV5ZVQrMksyaVFYUjVRTmhhdHQ1MWE0?=
 =?utf-8?B?VmNoRS9GOVl3c1Y3TnUzZ29CZk52SlFVeXFjL3RqSXBKRUpLMGl5cjlxZldj?=
 =?utf-8?B?bmdaa3pUTGhlVDUwVGJqeUh0UG5LSWNIN2VpWVdPTjFhUkwwRzE1Mkw0Zm5t?=
 =?utf-8?B?b1Z1dmtQUnk4Zk4vQUVkNDMvWWVuTHl5blNvRCs2MFJtSWY2SFNxdFFRUFBq?=
 =?utf-8?B?L1BaU0I3RHdnSERlWWljZ1FjVTZqZlJENTlsWVVmUDZia3BBU1NKWEVHRS82?=
 =?utf-8?B?NzdYUDErc0VqUG5lSit1djBQS1ZWVVVFZE44cmxkMXZVOFByOTNQaU9HTHhS?=
 =?utf-8?B?SkVaanFhWGFvQnZKQXNvdUg0Q1lZbmtWRkxLZnBOam80YTBGSDZINmsvT0Rl?=
 =?utf-8?B?ZmErT0JZL0p3WVVlSUhLdmthZzc5dmFTL0lNNEQvYmpRNlJsOE4xUFBJVFNB?=
 =?utf-8?B?T21UNlN6citVbEFJUzhudFBkQllub3VTTmdjZnBHVUdVdkxHRlpwbzBCZlJG?=
 =?utf-8?B?Z1dxNlJxM1c1SjRBWkJLcUpSMzFnSXN0V3lNNko5VW8yaitrOUxMZ1drdmE5?=
 =?utf-8?B?MUxPWVkrMkdzR0IxZmN3cEtzcnd4K0lSMzRMZzEydFpBK21Lcnd6U0hkT0pn?=
 =?utf-8?B?c1VvbkpXT3VXalJxSU80VGxSVVVzMENOSjE5U2VoemZ4TGpTUXZHUGRtOEtC?=
 =?utf-8?B?eFdNVzNkb1pKNkRISXU1WEdldDZjSEl2SzlsRXdLWEdyUXJqR09Gc1h4bzUy?=
 =?utf-8?B?OVN2RXF5dks5bStuMi9sNHg3TC9OQTVndG8rRTU1SXZ6aGpBaFEwQUdQTjE2?=
 =?utf-8?B?RW1GbVRFVnJQTnNBMnhvVDJkV1l5R3pwWWhtYmdXR3hLMjNGYWNQNXp4Q2Np?=
 =?utf-8?B?SFBCa3kzREg3MkpqNVRsS0pEK2lqOW9OTVlLWVVvbmlTNlc2N2tPeGVpY1VR?=
 =?utf-8?B?Z01GN2JzUWEwc0VmZjQrSTRRaldHKzR0RjFiUTh5UVluV0FLZk02MmU1Qnpo?=
 =?utf-8?B?djR2S0lMOXA0SWVyQmhCWVFqZC83d0V6VHFtbUZ2cWN4cnVBa0JDdzBkV3dY?=
 =?utf-8?B?REtXYTJwcXBlNDN0WlM1cTZobFBvY1ExbTlSay9DRzFMMzc2aUt5MUtycUtH?=
 =?utf-8?B?YnJkNXBjbVh5VzJ2MTlwUENRWXpyNmVEMFdoMDlWeVZXQzBrdStwVlJobjIv?=
 =?utf-8?B?NzIzeitJZHZUQ3ZHZEdwU3ZpOWEraG5BaFFsL0ZPSHdPUE5xWEVmekgweC9N?=
 =?utf-8?B?bEU1UGwzcDNIdGY5ajR3Zlg2dm5udldaMklrRXppMmJBSnNsZEFwdU5LNmo3?=
 =?utf-8?B?OXp4clN4azNvaXJ6MGxxdndMSUl4Sm14YkxCdkJQdnk5cHc1aXd3aGJpTzZq?=
 =?utf-8?B?OU9iRm44WEtINFRjajBjb2NLYXBUR1Z0WEh3clZTVzN4anFnWUVCbFgvNjhJ?=
 =?utf-8?B?UjFlZjlTYm9qclFaL3dSRHdPaXlTWmNJSFVzUXdSYjU2WGI1eUxVbk5ab3Jy?=
 =?utf-8?B?NEw1K3duOG9ia2FIWUxPY3dIMzRraGFoK3VTdlVoNWJGbTc1OWZ5dUFDc2Ru?=
 =?utf-8?B?TG9ubXBPbUd4NGhpeFpvRmpudHpKdmppaHJHL1AxRVBaUmJmNUVEd3UvWEJi?=
 =?utf-8?B?L2sydUNlLzEweHhlQ1YrNmNuUnV2VVVGSHZGWWRFSFRyZGsxeVhmdTlwL0FR?=
 =?utf-8?B?QThzcmFqWHpWYmUrU3JOczhyc2dPSWdlcnVFZDErWkdTQTdVQjFIS3h4djVJ?=
 =?utf-8?B?ZkZUejlkdzlKNExqb2FkK1ZuWVYzSEYvNCtYRks0V3BqaGZMQXBHNWgwUURm?=
 =?utf-8?B?bVdGMS9IYkRDZkwwWTUvUHF2dUIrUkJ2bHNqcHBDQ0lQdWlNSWdIVHNiSE5F?=
 =?utf-8?B?NGp0blJYSGJJdnpramRGcGw1YU9uMGlCN1YwZUJTQXhWTytDdmRaREVmUUJx?=
 =?utf-8?B?WTFYSGRQbUg1SzBvaWp5WGhiWjNiOUMxaitNajMyaENOT1lpN042ZDM2Y2w4?=
 =?utf-8?B?T3U2WGZVVE9LbytkZytyeVNVNW10WFQ5RTNsci9IRGxOMnRWS3RsSGpZRTEz?=
 =?utf-8?Q?ki5Lu1aM8DkD8CGc+8mAGOkNmqIHA6LWHQvJ26sNnspH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23e5530-d0fe-4ae2-5a1f-08de19514c61
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 14:16:49.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzJN/vLeKu85pm6bQBp/L75Px+ikd9ZhBZp3rjTSv/waQbZTuyShaXwHv/pq1y7bo9WCXx6hxkiqPlrtYUMQ9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6740

On Wed Oct 22, 2025 at 11:30 PM JST, Danilo Krummrich wrote:
> The existing read_slice() method is a wrapper around copy_from_user()
> and expects the user buffer to be larger than the destination buffer.
>
> However, userspace may split up writes in multiple partial operations
> providing an offset into the destination buffer and a smaller user
> buffer.
>
> In order to support this common case, provide a helper for partial
> reads.
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Matthew Maurer <mmaurer@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/uaccess.rs | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index a8fb4764185a..c1cd3a76cff8 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -287,6 +287,22 @@ pub fn read_slice(&mut self, out: &mut [u8]) -> Resu=
lt {
>          self.read_raw(out)
>      }
> =20
> +    /// Reads raw data from the user slice into a kernel buffer partiall=
y.
> +    ///
> +    /// This is the same as [`Self::read_slice`] but considers the given=
 `offset` into `out` and
> +    /// truncates the read to the boundaries of `self` and `out`.
> +    ///
> +    /// On success, returns the number of bytes read.
> +    pub fn read_slice_partial(&mut self, out: &mut [u8], offset: usize) =
-> Result<usize> {
> +        let end =3D offset
> +            .checked_add(self.len())
> +            .unwrap_or(out.len())
> +            .min(out.len());

IIUC you should be able to replace the `checked_add().unwrap_or()` with
`saturating_add()` and end up with the same result.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

