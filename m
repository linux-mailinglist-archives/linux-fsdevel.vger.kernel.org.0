Return-Path: <linux-fsdevel+bounces-66666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E625C28093
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 15:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21D3188F995
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 14:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6F62E0922;
	Sat,  1 Nov 2025 14:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N8z0zQuY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011049.outbound.protection.outlook.com [40.107.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C4878F26;
	Sat,  1 Nov 2025 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762006607; cv=fail; b=N0nF5gPxQXBTQpUgxPCOh/hmSNu1x0QdMLC+YNvMVauZztHWgnXpdoFu6gsRZU1xtjM/3XwS+vAMx3UpmX4GzLHejN+YyOxS/AOIwxKLtMwpPwB1pX8dlX9GMG9drtcCDNYwTw0EnJiBA2pAkq8uwCq6RHK700UmCUs9Q7B/uGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762006607; c=relaxed/simple;
	bh=cDNZ4LNZ0s4+c37mu37AC6iUwSI+AWyyBQ/e/iMnOA4=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=DYlZUgL0s0/DqGO/eqnMrx/KboipZZo6uTfgRpmEnp5HxIQqUYZwhOmcfvTWBW++75QiDDeRW2lN29k6bb7y0X11uTPzwjoPi3AQg0l1w0hwrYEPIF2ToHC6klNDmymJLJMmmfk3MZ65cJmIOYFyWZcKofPSWCteLD+JlSJx8F0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N8z0zQuY; arc=fail smtp.client-ip=40.107.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTHk7XVYeAvFq8aaUkV8kUqUiUbvGZYqwfXMzxx6HItOKmOl7cmjAsr9MDOGq7LV9vJUEuo1gI3I1XhcvaX56H8GABmd1l2R11fcZd0QONtSw0Ilp1xFjx49AvhshDsE/WY01lVF6cCv3dfe+IZGxOP5cJSv2nTOLj2nNcFjPv0CplpahmZ0II7Mk+DKgBgmFBQdHMv72d3nJQ/9dPlQyucVu2LP6ZBV/mj81iXYigt6fA51Zn6Ik7EUvAva8qT5bDJPFCr+l07o9GVMGIlhv178PoPAabrA5iJyTUxHT6B2uDn4NiCpSxpdp58ByG9jnbWP46k6j+ZM+4pA/zD7AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kc1jwA60nxduJ3YTV6DFu24xa/6HeL32GMdjpG2hVRc=;
 b=yvymCOen91VwdF1wjG+Dt2DYf/NezKxAFttHXVbdz5hGm72LM2HqyQYDnBBOfsH/lX0PdZ00Cy+NCLI+ZcEPaw2IiIHUlW+Trr8L/g7M2BFpq3ucDIJt2Q7aJ2RZIRKPph2pzGwVN908MHvU39KFZ77w1+sSdnepSRXDuCukfnI13WCQrLvgbray34tUFrMdZMc920KSXkc1bhuq+7I7bRFu+IueTBax7oJdsH6er6X1pX9L3NSyApWmAH+Ki0NQ6vYib93Y/s98JY9kbQCp2qc8OpcT+H3weGZS8twK0Belc3W3/HwIY0gp+RsOmfNGe1/EDcjI0609F9NNbM7hjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kc1jwA60nxduJ3YTV6DFu24xa/6HeL32GMdjpG2hVRc=;
 b=N8z0zQuYZ+eJsjB3US6MUxdF9sTSeT4DAMu01CbHq5+5FCCXbNhIzW4nobqVdpcYnOJpP1v3Kmm0hrkwn4Yxjm/CsxPRHs5pKL/5DdR08x2C5GLGqxKbuYeW1TuDIG18xEyg3z5nd0RIRNJiWjtyqeoe4JiS4lo15OwWXkTE03yaixa5iYrP8P6stMj8AF5vgmX9+afOC82U1zIL24N+XgcQ7vp/o4+Bklw/ae2Jq13rBdoy5e2K2PliobA4PZtD+M8YCYbbwwhGK512pOEQGoNC1eACXNBNh/mFUAt01ulYWXxrqQaqY29avpvo8GQsHvCOKQiyR0/UR3HMOP1DWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB6740.namprd12.prod.outlook.com (2603:10b6:510:1ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sat, 1 Nov
 2025 14:16:40 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9275.013; Sat, 1 Nov 2025
 14:16:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 01 Nov 2025 23:16:33 +0900
Message-Id: <DDXF7IB7MZCV.9J6U7KTR5ZD0@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <mmaurer@google.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>
Subject: Re: [PATCH v3 01/10] rust: fs: add new type file::Offset
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251022143158.64475-1-dakr@kernel.org>
 <20251022143158.64475-2-dakr@kernel.org>
In-Reply-To: <20251022143158.64475-2-dakr@kernel.org>
X-ClientProxiedBy: OS3PR01CA0073.jpnprd01.prod.outlook.com
 (2603:1096:604:da::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d0b190-715c-421d-b270-08de1951460d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2x6WHRvV2I3RStXZkxzbFhKRUZJOXkwT0loQkRyQVV5N3hZeFdOYkpUNXg0?=
 =?utf-8?B?UllSd1JxdXZQL3dMQTZheUh3ZEdORFRld29vU05NQWxlK2EwbHI2OS9HVGFZ?=
 =?utf-8?B?VU9FTk5lSmtDOVlqc0dFYWgrd2E1bCs1MlJKVkFMemlNdmltL0MzSXByV09a?=
 =?utf-8?B?YkhIVmlUQlRNeTd2QUROMmk5SXNNYzJESkdGaVpScEM0SFpGd0RJUCtSOXBP?=
 =?utf-8?B?d0lOVjVOKzZpSUYvNVVpU1BYeEcyTjZVcE0rMjM2T0o5QW52aUV1dmxKZi9q?=
 =?utf-8?B?dTlpNEhBQnMrQVVieWg0OXBPbEF2QVJDWjgxaDFTeXd2azVBcE1BcGlmaVJ4?=
 =?utf-8?B?TSs2NzZzdDd4L09PcEM5WittZGtGQVJSN1lqbnJRQ2pWclpmYUJ3VHM3VmtF?=
 =?utf-8?B?b1pBZ2pGWjJOWWVQWWtPOENkNUkzeFZjWjJwZ21lZmppR0grWkVHV3J1dmJX?=
 =?utf-8?B?a0dkbTNSaUpRR2ZlRExhR3ZqVDI1LzVNd04zemJXa1BMR2RaM1JFNGhSbjQr?=
 =?utf-8?B?L0xUREQ5MjRMVkpSR2M1YUhndkdXMTE0YjFITzVMUEF5WjZ5eDhWZXlFZ0FI?=
 =?utf-8?B?endNb2htRkIxSUhLR0RGcXpjSTR5c3RjbGJJWUFtZVRTQWFBa3QzMmtsL3Zx?=
 =?utf-8?B?ZGZ1cDI0eFJJZ2pqbTNlb1RYSG0rQ1N6REE4cnRmaGpraTVYalVNcWliYlEw?=
 =?utf-8?B?S2Qzc3QrYWEzUmlUVEFVUW5ISnNoNzk1ZEk1VnVURHVhUXhaZFBPS2FTMUYz?=
 =?utf-8?B?N1Nvem9URmcvaHVZd0VVU1JnS2dWRnFuekl2cWFmWmUvZ2xta3NIZFZsOHRR?=
 =?utf-8?B?VXlhZmVuMDhDQ2ZOUUxiNU9TcmdyU1E1c3I5YnlTMHJIMG9vcFJpemgzdkJE?=
 =?utf-8?B?WmlFV0RzS1N4d3N3dldPdnVLSU5UV1lJTnZtbGJWV1prRFJJZGtWa0IxZU9w?=
 =?utf-8?B?NEZ3UzIwQzVFQ3BHQStoUDdURzZaM1g1WnB0dVc4MlN2TGs2NHpiVU1kbUxn?=
 =?utf-8?B?S1dpQUREcUFyamh0OWk4Y2FRMHF0UzQ0NTNDbXJNNUN5RWlBeWI4T3cycEZr?=
 =?utf-8?B?VWV3Mm9ENGVkcEFLSFJLc093aVNSNnhrUUlnNmpEaXV1amt5TWlhYmcxY0cy?=
 =?utf-8?B?ang4NjdDUHV1L0liYjRJQ2EzT3dFcm1WZFp0TWxOVlA1akZTMW5YS1VBSEts?=
 =?utf-8?B?NE1MaEg2aHdMN3pCWjNRY05XRndPQU1adDJReU1IbXA2N1NRN3ZzZjZOR2p4?=
 =?utf-8?B?Q0FUejJOaVV1Vk91V1dkbzhoSDJxTUltc3QyQ25hRmkyNjdnZnhqVkY2dVI4?=
 =?utf-8?B?YmlUQ1JwU3ljU1pkc21xamVHdldLcHRMcVFSRkdLWUtBck9FUGNSNnYxcWxx?=
 =?utf-8?B?Y3lNallsWWZBRFA1N0VmTzFvMGQ1dkVSNlBzOThxY0hXbFUrb1Q5T016Mk9Z?=
 =?utf-8?B?ZDNQT3ZHZWpqQ2xmKzBxWXJ3U0Y0Q1Y0c1hMMTdwVWQ5V2RZK0l3NkoweVlW?=
 =?utf-8?B?N0xUWEFIdjJ4MmRRYjJPUUJtWFNyZiszZVVTWGpkR2dhY1JWVUg2MkhwYmJn?=
 =?utf-8?B?NlBiTURoY2RRUmg1QThWMHpqek9NMVBqekhSZ0kvbHo3aFRNN3VhUk9XZDJm?=
 =?utf-8?B?N0dQS3Z0eTRHcjVJWEcrallWS2ozMURSZEoyUmwxRlRpalZaV0VqZ1JSNCtT?=
 =?utf-8?B?aWxtRWNrRTNWRmZITGpiY2FQejBXVUhOallUY25QZlNxeTFId0ltdlVoRlJt?=
 =?utf-8?B?MmxZL0tQL05NT0J3ZzhZbEFaN3BRWFpsNzBzNjhlWXFGSXFaRUtFd0Z6Z3M2?=
 =?utf-8?B?UHNXaWtPZUVFQVlZdjEyVEpsL1JGUG5LYnY3UUJHaDI4U1k0V1VlMWJDQXJR?=
 =?utf-8?B?elZ2MGVrUnp6Y1BzMXd2eHJVZ3g4Z1FHd2ZWai9Ga3hJM3piUFA2WXMxbndZ?=
 =?utf-8?B?ekkxczRKV0E4aEkwSGx5ZFlXbmcrQ2JnSDU2dFE2UlE4UFVlUFpmeExRMk8r?=
 =?utf-8?Q?8hTaXw62QFs7Et54R8+2OML62te+KI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVZYRVdMRVNzanEybmdnc0FwaXF6c3l1UDV6RVVEV005QWVkMHNuQXRha0Z0?=
 =?utf-8?B?WmZrQmROODNCR0FJNENDN3JIVWpSZlVuQXQ5SFhOZnNoYWlYMFVHa3hZaHYz?=
 =?utf-8?B?bTJuU1UyMzFoOURlUGJFamFmU1YrWmdMVVVGZXk0UWF1TVV0eGpxRUVtTG1P?=
 =?utf-8?B?dWtvQVJDQ0p5OHc0elpJV0FxM2pRK2RVV09Wa0diTkhwZVpjbHFQWHJhdVRH?=
 =?utf-8?B?eXBFbCt3YWNOSS9qYWkxN1gzVGJyaGFDMGNQZGhLRUJOUXRNY2J6WTJaa05Q?=
 =?utf-8?B?Q1Q0TWxKc1Q5SlRIVEMzRnEvSU5XdDRxbWZPQUJ0QlN4Z05rZTJveXpydnZW?=
 =?utf-8?B?Ui9MenY2QlBrRkVVZ0FkZXVlREdXSlkvalJuYVErSFhERGcyc3hWeHU0ZjB2?=
 =?utf-8?B?c2ZRTnhDNGRrYUZXeGt1WXIvWGpRMmxvQlViRDhBSXFUdEJzUGQ1SlhSWnBh?=
 =?utf-8?B?NDNsbmFORTFYZU1pUmtwQUNrSFREZ2VjTnN3OVhOa3ZDMkpvbGxVNWU0UXFP?=
 =?utf-8?B?VlVLSVhJQVI3aGh2UllIN1JUMVU5Zyt0TVNqUTJoUjRsOERXdGJ5Nk5pYVBB?=
 =?utf-8?B?dSsxcjZoc1RGVzBCaENXYyszWVZJV2lNSDFyVnVVcEQ2Tk5USkdwZkthRkt4?=
 =?utf-8?B?MnpwWDMyek1BQ2J0TmhweFZFcWdjcSsyVDdvSVFac3NyS3dPeFY4Q2lQYmNJ?=
 =?utf-8?B?aVhTZk1TRkkvZ2V4UFBpaGVBWjFTOTNOOEV3UmxqODJLRjNSbXl0dEtWZk01?=
 =?utf-8?B?MFBMb1lPeGhKMjdPOWYxbjhOcHIxbnNvaGpJdXlGSjM1NXZXTE5kc0lKbWhK?=
 =?utf-8?B?Zm5yRXBSQVBDOGsrZVY0SXNzcS9TbFpNK0hMUjF6TWxHZ0YvMFVyWjJEVXdD?=
 =?utf-8?B?WE9KZEVJVXBHb0dZcGJBSU5ma3ZpRFJxaU5oemlMZWZNZCtsVXJQdGRpRUFF?=
 =?utf-8?B?dEdJaGdBdERjQXpJWWtKNHdvb3laa25Jb0dacGJSRmhubklnc2NuemtJUTlQ?=
 =?utf-8?B?YXBuZE4vcENDWnZVQ3YrZzg3OEU1QmNZb0tDbXZMcEdFNXVRWHpiQlJROFRM?=
 =?utf-8?B?bVA1TlA3Zk9LTDRxYi9VL3IyK2ZURU9QL25rbXhXSDNhZFdMZ2VHSE94dEdB?=
 =?utf-8?B?TUZrcUVoRVRtSFg4N3RnS0NLb29xMTVpUHNJN0J3YnhoZnpqcXdkckdFcllF?=
 =?utf-8?B?OXVLbHRpanBXY1BhSHc4VGp3SGVMMmRESGE0UXZHWnI1TXV0NlJsSCtMeFlS?=
 =?utf-8?B?MXBldlFaY1pySlM4UmNwSkVtY054N1EveDVXQ1pyUHdPMGxJSHVjNnd3QWIx?=
 =?utf-8?B?a3lYT0twNEUrVnpOczJpR1RQK1pWZStqNXUyQytYajh0WHZZQ2Zxb3NnUVVm?=
 =?utf-8?B?NHVITk85M0ZuL2NKSUIvWjNYeHF1WlBocGQ1dU1KeEdOaGY2ZmgxalVhYWtG?=
 =?utf-8?B?NjJOUlJkTmhJOEZGN2NrZXB1cTBnMVZ6cUN0WFJrbUtiemNGc1lWbzQ4cit1?=
 =?utf-8?B?bGZZYUpPQ21FUktXcUlWOHZPWGJQbkNnTjNCcEVOcnJWUDJEZDVma3NNYnhN?=
 =?utf-8?B?Q2s1YkxZVDc3Rnh2dit5Kzhxc0pmYzVJcVpMbWRBMk9WeGRHK2hIZkZ1NTdI?=
 =?utf-8?B?S1NWellKYUludkNkTGt2MlErSDBReFA5U2JtV2l5SUljSDZYZGRWZWNia0E5?=
 =?utf-8?B?SVlXcVo2QW9WQlJwZjRnVktac1FETEQvUFNoUFZBMExLTDg1YnYvYkZ6N01L?=
 =?utf-8?B?TVhZMGpkRlBJVjFDZlE2d25YRHhJVURPTjRWbVhndGVVMnVuOFZ3V0grTmhH?=
 =?utf-8?B?OVArdjh0ZS9zcW43eW9wM2xQUDJTUHhTay9sbTZJU3ZNT0lyaDZndlhtbVpw?=
 =?utf-8?B?K3NaRGtHdTFHNGxWUjd0YU43NDlWc3U4MksveFNJMHJDc2RFUkF2V3d1R1J6?=
 =?utf-8?B?QXdiV1pCRnhPVnZZYXhyVWhvOWxUTlVzS0p6TTZQUi9ueHVTbG1JN3BhS0NV?=
 =?utf-8?B?V3FnbWZ3SGpIaTRYajZaTWFob1h3c3A2OThSSzczYllRQ0dvamt4WUhNZkcy?=
 =?utf-8?B?cHFQMTFpRmtZcGRibmtJMEtRaUFocnpRVXFxcWVkZmFQSlB2YTZPbUdxd0Qz?=
 =?utf-8?B?b1NTUlhGTklTemhxc0hIQmUyUitIUGQ1ZWhzOFYyRGJjNFMwVGFCaktEamp0?=
 =?utf-8?Q?3M8l9J1npJR/TAhxpDmxBAcbK32LEzwrDPNnVpT+fcaZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d0b190-715c-421d-b270-08de1951460d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2025 14:16:39.6790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xVZPOXFJ3VbiICjzh1jjg0sjrudUsDFyP+UYwxTvqoHJJYxIJPLK9mCDEtpgBi4ikB/EayUJ4CvUe3sEZ/6buw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6740

On Wed Oct 22, 2025 at 11:30 PM JST, Danilo Krummrich wrote:
> Add a new type for file offsets, i.e. bindings::loff_t. Trying to avoid
> using raw bindings types, this seems to be the better alternative
> compared to just using i64.
>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/fs/file.rs | 142 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 141 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> index cf06e73a6da0..681b8a9e5d52 100644
> --- a/rust/kernel/fs/file.rs
> +++ b/rust/kernel/fs/file.rs
> @@ -15,7 +15,147 @@
>      sync::aref::{ARef, AlwaysRefCounted},
>      types::{NotThreadSafe, Opaque},
>  };
> -use core::ptr;
> +use core::{num::TryFromIntError, ptr};
> +
> +/// Representation of an offset within a [`File`].
> +///
> +/// Transparent wrapper around `bindings::loff_t`.
> +#[repr(transparent)]
> +#[derive(Copy, Clone, Debug, PartialEq, Eq, PartialOrd, Ord, Default)]
> +pub struct Offset(bindings::loff_t);
> +
> +impl Offset {
> +    /// The largest value that can be represented by this type.
> +    pub const MAX: Self =3D Self(bindings::loff_t::MAX);
> +
> +    /// The smallest value that can be represented by this type.
> +    pub const MIN: Self =3D Self(bindings::loff_t::MIN);
> +
> +    /// Create a mutable [`Offset`] reference from the raw `*mut binding=
s::loff_t`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `offset` must be a valid pointer to a `bindings::loff_t`.
> +    /// - The caller must guarantee exclusive access to `offset`.
> +    #[inline]
> +    pub const unsafe fn from_raw<'a>(offset: *mut bindings::loff_t) -> &=
'a mut Self {
> +        // SAFETY: By the safety requirements of this function
> +        // - `offset` is a valid pointer to a `bindings::loff_t`,
> +        // - we have exclusive access to `offset`.
> +        unsafe { &mut *offset.cast() }
> +    }
> +
> +    /// Returns `true` if the [`Offset`] is negative.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::fs::file::Offset;
> +    ///
> +    /// let offset =3D Offset::from(1);
> +    /// assert!(!offset.is_negative());
> +    ///
> +    /// let offset =3D Offset::from(-1);
> +    /// assert!(offset.is_negative());
> +    /// ```
> +    #[inline]
> +    pub const fn is_negative(self) -> bool {
> +        self.0.is_negative()
> +    }

For symmetry with Rust's primitive types from which this method is
borrowed, do we want to also add `is_positive`?

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>


