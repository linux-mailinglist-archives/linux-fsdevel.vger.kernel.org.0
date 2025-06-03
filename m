Return-Path: <linux-fsdevel+bounces-50489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F24EACC889
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABC33A4612
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F087B23875D;
	Tue,  3 Jun 2025 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NRvQ4ROZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBDD3B19A;
	Tue,  3 Jun 2025 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959047; cv=fail; b=gGSjjWL2h+97dz1uLTmtHcosAYSuQtj7ej/Zo/Vv/cumZUbl3zbw3zj7gubdRK707qbqD2WVijvnmjYwltBABVP7JRT6EA2lE/s/SwMg9rdefJQU5JzHMIPJaSiuTqde7ESpq7QBXKvpdeobY7T87nf68fTEkSzQnv5exKMou7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959047; c=relaxed/simple;
	bh=/Cc+hy0mACqAk2rTNhRiuUQufe/wxlTRwY/TG1iqX7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pCFVwdn4l4/Wth1Rja4OwACa745gmK9agStWS3Cd8NPTf4ptB148H9sfsN3oY9hIG4lU4+hzibH10DnPnIQiBWWa36i4oj55LITK/TFip2aMWRUKGlZrYKVbhkEBIrSua2DQWWPoSP7Wa/JTU7iPACdU1eRiFeeEJwVgivNAM/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NRvQ4ROZ; arc=fail smtp.client-ip=40.107.220.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wfi5CtXCBN8zQgltWB4rkO6aR9w+OFMU0TGNnNyHU/W42pQD+ctZEBaeeBK79YVAdRbyJL17zJiJMFtZVEx4qQNDvOl0H8xzjhKmg5ezA7pB+gmVGqilO05uqTJNWuDQ9vNgiwwmUi0+pKtqYSS5GUcY6C785PFVquMCNSdQ8/g+IfALdkw244ZFM+ry8CtZGVmprf9iBY3aP7sz9r2+Wr1kl+pfPF3zN/HNL9jr+JKTH5H6UTB7KulvMrhwpGPvrNWI3zJSSSkLusr2LfxWA3Ud1SMjMoIApo+XqH37ajtdQFkxseFq9qIRIRAt41e9KUeGYR3VvTzrunw0xkouWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Cc+hy0mACqAk2rTNhRiuUQufe/wxlTRwY/TG1iqX7w=;
 b=uaSndOPtEij6i/LPgJvLOqqz5FpbIyQ3vBTlMjnP+rpyrg1DdUPk7BEOvCT4bmAZ9NtRwAlBfolKxo0RycqUBUqGgdy1oGY+TZkfa+lQpy7iplR9BhsPVUMCinXLEXd4xGaoLa6ICwKv9zDC9Bd7QHtmoZRZFg/h0unJ57Tkq43a+I8hwKVFC8eJz0nyw65qQFZvLDzC5Z8mNLmFYBjjcIQar1Iu52Y8QUpfP4iMGYoBWPJqptNtp6xE1GFpi563+OIN9IcX/DIlAnTRujVZl98HSctAI6woAKJeQ3OJSDVn654EGDWcQqnILJbiqSX9KQyxfxex1g8s/0zPdWgx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Cc+hy0mACqAk2rTNhRiuUQufe/wxlTRwY/TG1iqX7w=;
 b=NRvQ4ROZijKYy9P364dS3gFHT1KpY3NrXZrCLlzgY9QXS/i3hXwc0xvDOl80vKZVwM9J7sO+MBvj36O6qj4AFpvHAgsj2Fz1FffxbAWeBX4VgU/1uLpP1Li4C22uav5oyM0dq2F/SlTDiXhFX+LMrWwlT/d1IRv5jGi2jF2UB82SxfiKZXT+NyHkfMONEcPkOT6NNd8+WfFWQuVTJwaI/wCxVXOtekB2//19N4yjm5X3RTvuSPw+ltMY9GXrvp0ZCOzbGyyxXPIVHCUpAHUpusslvjLLQIUywvbsu9pQMYikT6GynmpAN1dJFqJdRLlzkUu83L7Xe2LtVjHMaweMbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Tue, 3 Jun
 2025 13:57:21 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8792.034; Tue, 3 Jun 2025
 13:57:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dev Jain <dev.jain@arm.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, anshuman.khandual@arm.com, ryan.roberts@arm.com
Subject: Re: [PATCH] xarray: Add a BUG_ON() to ensure caller is not sibling
Date: Tue, 03 Jun 2025 09:57:19 -0400
X-Mailer: MailMate (2.0r6255)
Message-ID: <49262EF1-2EB2-4136-A440-D3DEA8D1853A@nvidia.com>
In-Reply-To: <9878157c-07aa-4654-943f-444f5a2952d3@arm.com>
References: <20250528113124.87084-1-dev.jain@arm.com>
 <30EECA35-4622-46B5-857D-484282E92AAF@nvidia.com>
 <4fb15ee4-1049-4459-a10e-9f4544545a20@arm.com>
 <B3C9C9EA-2B76-4AE5-8F1F-425FEB8560FD@nvidia.com>
 <8fb366e2-cec2-42ba-97c4-2d927423a26e@arm.com>
 <EF500105-614C-4D06-BE7A-AFB8C855BC78@nvidia.com>
 <a3311974-30ae-42b6-9f26-45e769a67522@arm.com>
 <053ae9ec-1113-4ed8-9625-adf382070bc5@redhat.com>
 <D5EDD20A-03A2-4CEA-884F-D1E48875222B@nvidia.com>
 <9878157c-07aa-4654-943f-444f5a2952d3@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR01CA0025.prod.exchangelabs.com (2603:10b6:208:10c::38)
 To DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: fe3a14e7-336d-4371-87c6-08dda2a68fb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXNLREFGcFRDS0JxYjBKZlB6TjN1YTBKNmVES2VlYktOT1lSSDlYc1F2QlJB?=
 =?utf-8?B?WWtKTGhIR0dCSElRL1RoWkMybmdiTU01TGIwdW93OWRIMldHZDhDclBEajhF?=
 =?utf-8?B?K1dMV1dxZC9WSi9TYzdjUURQa2Rob294ZnBkSnBOVXFOY3dmRFBPRjhRWEg3?=
 =?utf-8?B?Yk44cG5TY2Mvc0ZtdzBqMGI3L0F5d0cyTmFnM2FyZGtoRmVDVEFTcU12RXpN?=
 =?utf-8?B?SXdVRjgzTzZ3MVdzNURWRmxBMDU3MGtTMDhzMGQ1ODdJUERudVp3ZXRKRzAw?=
 =?utf-8?B?RUlLajVvVGMwQ2NCOFVDMUNjUTJYT25uM3RZaDFiRHBZaS8yazZtdmpvZFdl?=
 =?utf-8?B?dm0xUjhrcTBSUk1YaGcwTmZsVmRvTk5QWmVDOVhVQlJON2E2a2tMekVwbHl3?=
 =?utf-8?B?SWpUSm1ialVSb1NDcG00S0VYSnZCSlA0WUVkRXdVUGN4aEMwTy9FL0t6YzdW?=
 =?utf-8?B?NEhZK0NDU2dxQWNkYnJqTnA3cXRtYXg2eVk5RjFXejBzMkNwZ2dGbDlFUVJx?=
 =?utf-8?B?cnZnZXp0UmNCNlVvc0tJYWtJeEpod0tOV3FkM1lORDNleGFJOHhlVHdFSnJH?=
 =?utf-8?B?dVFxcXZnSTZWcmppYko3WlhMMXRTUmZCTkF6SXNycGlITDhDS0VOZ1pFSWls?=
 =?utf-8?B?NGpMWmZnU04zTkxqMURaTGpjekRWeVhMb1lEZ3Y4UG0vQkhlcVoxU1dOckNS?=
 =?utf-8?B?c3NaZDkzSG5rRlB0UFd2ZEFnRG0xc0RTWUFIOFVBY2tPRFpFSEo4WlpJS2lK?=
 =?utf-8?B?TzB4c3ZnL0gxWElXSWNHWitCNHhwZEhkQ3IveVBtUThpY2RVaS82UWUxbGJx?=
 =?utf-8?B?R0ErZ29Wb1hDOXFYZjIzeUFDdGRjLzBGeGNncVY5dFNrNkZFSmt1a1M1TjVD?=
 =?utf-8?B?MmIxMzBYMTZjY3V5ZU1LckluZGZXVE8zSTJaV3Fvb0g2RS95MWQ5c2tmWVVx?=
 =?utf-8?B?T3FMWlNFMHRkMlRmNEVqcXBVYTJ1SEFmbGNKeFpQaFdkOHhsdkVJOTdlaGV3?=
 =?utf-8?B?cjY5Zmg5TXhkTXlMdFBPRnowR0pua3VaQnNCcDVQQmN1Tk9iSlFUTnNydXlQ?=
 =?utf-8?B?RWdlTm42ZVlpK1N6VzNHZ0hlN0ZMUWk2aHdXUmlhdzBlL3ZjTkFJaTVoZHJ5?=
 =?utf-8?B?ekxBTGUxLzBEYXYzdit1V05nb3JqMHdJaFlBY1lhZ1l1S2Q2eTk2MExOUzdS?=
 =?utf-8?B?T1R5S2RuTStrdW5zNHBLaEtjMVJyTFp2SmNUb2FHTm9ad0JVYTZ5Z3l5YU14?=
 =?utf-8?B?SWZGbTJmWTRGdzVLMjJVK3ZjWVZZOUg1WEorS1V1TkpxQ05lVGpHRjQ4d2pt?=
 =?utf-8?B?NHlwQWt1aE9SaXd0eE1KTHYzM1pWVlNxUGttRWdVZCtocWhBc1FSei96ckZt?=
 =?utf-8?B?c0xCSlJqV2JZZU9aQURYOGxUTUk1S3JyYlNWQXczaDl5SXI2MDEzdkluSC9L?=
 =?utf-8?B?TVdvTWZrL2Y5SWRPQzIwNVNSYW9pUW5BeURyVUszU3o0aWdnd1lFMXhFOUk4?=
 =?utf-8?B?dm5OR1FjRHRmSTJGWEtWSDlRMisrM05KWVFwZ2g2aWQ3Q0NPNm9QcXdwNVd5?=
 =?utf-8?B?eGpUY3JmVUtXN2Qvb3FxK0NNWTFwSHJRRFRzek8xU2x4Y0FZbW5uQTJtOC9i?=
 =?utf-8?B?YWJxZEkwRkpabjlvOHBiS3NBdEhlbEdxODQ3VFQ5d21sNTlNS29PNjlYWHRx?=
 =?utf-8?B?c2tzK09zcHEvOEcwUzNqd1VjSGFicWNyKzQ3NUUxY0ZGaEVVb3ozOVd6NVFs?=
 =?utf-8?B?UStoOS94bU5mRytVd0Z5aDI1WTE4OTVQT0ZWYUJhclY3N2Y2cEYyamN4MUdR?=
 =?utf-8?B?eWdQRHZBNVFEMUdFcU50OEVpd0pvVk5jODFHZ2pGbFE0QVhCclY0Kzh2V2NS?=
 =?utf-8?B?c0tTV21XdFpoZVZwMFM0dVgyU2t1Y3l3N2ZyeEFiMFVBSlFFWEdPeGYrckh4?=
 =?utf-8?Q?x6a5z+uMauw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bW5EYlVFbXV4blZRV0YzRk5xWnVNZ1llNWJlN0EzRTJsZXBwQ1IrVVY4ckM2?=
 =?utf-8?B?NUNwd0N5d3NLYnY4aE8yRzFEdGN1VzZDMjV4dnZRSERvWGdqcXYySEVra1Qr?=
 =?utf-8?B?bE0xM1V6ZjNTcWNUdzNCSWpuQUxod21vc05XTHR2Q0EvV0ZEZC8yVUN3REY3?=
 =?utf-8?B?SlZJUWE1aGJPWHFmaHQ3Uld5ZFdLanlLSGZwUGR4MmQ2cVNKVDhrMFZyb3cr?=
 =?utf-8?B?L2NzV2N3YkpQM0tlNXhDRnpWR0V1N0RDZjBTYUhYUTVxYytjVFNoMWhaU3hw?=
 =?utf-8?B?U00yd2x6K2ZJTk1mbFJkdnUweHMrdG5iZ0hBN2U1c2FtSDZzSFZmTm1BSFRl?=
 =?utf-8?B?N0lTWElqS2hWMzFsVVRQdFJWZ2hiWm1mU3ZCR3hDUVBaOFN2QXJRbEtrNnVT?=
 =?utf-8?B?RTArenhCSmVRY21ibDhBRjViZkhTSlVua2FHRnFzeTZ3dTVzNFpPNS9uenYx?=
 =?utf-8?B?Qm0yWVgwNGh2M1FjMVRPNDIxMm5xT25zZTVMZW1aRnJxTVRGUDJCVVRuN05V?=
 =?utf-8?B?NGFoK3JFQXFRTjRaaERpZHpFenJBQkhhMW9ITThBQzhCRWovU1RLWHVIY1R5?=
 =?utf-8?B?VHRqSWhOTCsxWnY1b1FQK1o4dmVqT3NTK0JhY09KLzZGbGladk93WFR2UGhp?=
 =?utf-8?B?MHFRSTVvbi85bzB2SG10ZjR3azV1K0RYbmE5SURUT0R3QWF2QzljSUdnZW8w?=
 =?utf-8?B?WlpxcnlHOVIxSFRLOVdWNGgwRUFTWHI1czM2NjNROWU5YzkvMDJpVlZySUcw?=
 =?utf-8?B?SWp2NVZtRGx5cDNNeUs1MFBWd2VKWXJENmYvNlp5Q1ZzKzArWHVJcWhsMjRy?=
 =?utf-8?B?UkUzVWVITXlhMGg4L0lndFgwcm5yU1JjTHBFMUEvRU83L3VMUFpUWGlha2dr?=
 =?utf-8?B?dmlMRUlFbDJ5YitNR3dTdm5lU0RGK3ZPN2grQXlkbHhjUTNWNDkyR051OC9n?=
 =?utf-8?B?bWVaYzdUdk5uVjZiZ3dVRjZyQVNRSFE5cUVkamQ3ODdnUXpWUHZhU1dVL0NO?=
 =?utf-8?B?NWRVTTd2VEFIdm9PeHR5ajRQQ3NCSUNpU0ZKMXBpV3pKb1NVRDc4Y2l1dHdD?=
 =?utf-8?B?czEzcEl1TGI4WGRsZTR2c3lZeDcvazE0c3QxZ25uZUlkTW4veVFYWUllbTJL?=
 =?utf-8?B?UzZNOHY4di93anY5OHFhZ1dGK1BrSi9WZjU2dFdUbGVyNDNPZTF1WFVKSmhD?=
 =?utf-8?B?UmViSWlWRHArY3EzRUIyWGNIMjZxaUZRZVZjNjAvVjhoNWtaSGp4a3drdjRG?=
 =?utf-8?B?RWtjUW41ZElJTGpNNnR6TU9yTktJUzAzUVFHV3ZsZzd4K2hmNWRra3VpdThI?=
 =?utf-8?B?YytUaFZtdlRBVlIybVJBUGdoZUpBNG1qKy9QL01ZMkYzSWUySG90U2xpOXZM?=
 =?utf-8?B?eko4cDNwd2ljMjFZU1B6T3hXR1haVjBiemVjTENHSmNoNU9hRHZOWjBmaU1N?=
 =?utf-8?B?VnljMTlyOGtsNmZjV053TngrajFzT3A2MGErcUZKMVkxcmwrR2NjMW5wM3ZE?=
 =?utf-8?B?UGlvU3NuT1NDNFgzbHdIMkdiWlZzTTVuVFlmU0hhRUdPZ1lxMURiN1NlaDZk?=
 =?utf-8?B?dXNqMDJUVUVNcWhxK3BWZnpxQkJ4a2ErSml5MkJVbWk3aGhlaGhOTllWNFRN?=
 =?utf-8?B?ckQxQ2lTZW90WHJyZ2o3UFIwWmE0QWhzTWtpWmpYY0wrYVRQK2R0eUtNWWh4?=
 =?utf-8?B?Z0hEZ21mTVhKVWpYVHRHWDNPeUVhOXdrM01vMmdZSVBwSCt5UWJUMmFXSURj?=
 =?utf-8?B?Qkk5SG85ZzZRVTRVQ3lEaGhQQjM3TGduUUhhc0prNzgrRnVRZE54NG1VSW9I?=
 =?utf-8?B?UzM2cldPMDBWUWZwL0k0QmczQ3MzM1Q2YW04NGFHT0RXL0hFdEVra3A5bENE?=
 =?utf-8?B?dU5DVUFkOHRTQk93dDJIeGpGaUlVTENmU3ZSL3JRUXNkN1c3SjJJcVY4dWQr?=
 =?utf-8?B?TkdZcWlPSDZpa1IyUERUc2JmTkFpbmNnWThxd0V3OC9wR05KMXJ0TjlvSkc4?=
 =?utf-8?B?QU11TVdMTVJKdllicDdrNnV5WlBray9CZ3hDWlNEbENzU1lQMFlEODVXUlFS?=
 =?utf-8?B?Qkh0VlBQYk1TVXhZM2pUY1MyUmlTeVF3YzNoczNSRnBKVkJCbmlBNkFGQmJv?=
 =?utf-8?Q?dApo43rVSfE9bXvKp9/O5r7QS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3a14e7-336d-4371-87c6-08dda2a68fb3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 13:57:21.7582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ba05bmzF+W+qbU5dcys0oSr2cILyAbHkxFdfaOH6TKW28KlDSrLz9oSWMMVZGfWw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218

On 3 Jun 2025, at 8:59, Dev Jain wrote:

> On 03/06/25 5:47 pm, Zi Yan wrote:
>> On 3 Jun 2025, at 3:58, David Hildenbrand wrote:
>>
>>> On 03.06.25 07:23, Dev Jain wrote:
>>>> On 02/06/25 8:33 pm, Zi Yan wrote:
>>>>> On 29 May 2025, at 23:44, Dev Jain wrote:
>>>>>
>>>>>> On 30/05/25 4:17 am, Zi Yan wrote:
>>>>>>> On 28 May 2025, at 23:17, Dev Jain wrote:
>>>>>>>
>>>>>>>> On 28/05/25 10:42 pm, Zi Yan wrote:
>>>>>>>>> On 28 May 2025, at 7:31, Dev Jain wrote:
>>>>>>>>>
>>>>>>>>>> Suppose xas is pointing somewhere near the end of the multi-entr=
y batch.
>>>>>>>>>> Then it may happen that the computed slot already falls beyond t=
he batch,
>>>>>>>>>> thus breaking the loop due to !xa_is_sibling(), and computing th=
e wrong
>>>>>>>>>> order. Thus ensure that the caller is aware of this by triggerin=
g a BUG
>>>>>>>>>> when the entry is a sibling entry.
>>>>>>>>> Is it possible to add a test case in lib/test_xarray.c for this?
>>>>>>>>> You can compile the tests with =E2=80=9Cmake -C tools/testing/rad=
ix-tree=E2=80=9D
>>>>>>>>> and run =E2=80=9C./tools/testing/radix-tree/xarray=E2=80=9D.
>>>>>>>> Sorry forgot to Cc you.
>>>>>>>> I can surely do that later, but does this patch look fine?
>>>>>>> I am not sure the exact situation you are describing, so I asked yo=
u
>>>>>>> to write a test case to demonstrate the issue. :)
>>>>>> Suppose we have a shift-6 node having an order-9 entry =3D> 8 - 1 =
=3D 7 siblings,
>>>>>> so assume the slots are at offset 0 till 7 in this node. If xas->xa_=
offset is 6,
>>>>>> then the code will compute order as 1 + xas->xa_node->shift =3D 7. S=
o I mean to
>>>>>> say that the order computation must start from the beginning of the =
multi-slot
>>>>>> entries, that is, the non-sibling entry.
>>>>> Got it. Thanks for the explanation. It will be great to add this expl=
anation
>>>>> to the commit log.
>>>>>
>>>>> I also notice that in the comment of xas_get_order() it says
>>>>> =E2=80=9CCalled after xas_load()=E2=80=9D and xas_load() returns NULL=
 or an internal
>>>>> entry for a sibling. So caller is responsible to make sure xas is not=
 pointing
>>>>> to a sibling entry. It is good to have a check here.
>>>>>
>>>>> In terms of the patch, we are moving away from BUG()/BUG_ON(), so I w=
onder
>>>>> if there is a less disruptive way of handling this. Something like re=
turn
>>>>> -EINVAL instead with modified function comments and adding a comment
>>>>> at the return -EIVAL saying something like caller needs to pass
>>>>> a non-sibling entry.
>>>> What's the reason for moving away from BUG_ON()?
>>> BUG_ON is in general a bad thing. See Documentation/process/coding-styl=
e.rst and the history on the related changes for details.
>>>
>>> Here, it is less critical than it looks.
>>>
>>> XA_NODE_BUG_ON is only active with XA_DEBUG.
>>>
>>> And XA_DEBUG is only defined in
>>>
>>> tools/testing/shared/xarray-shared.h:#define XA_DEBUG
>>>
>>> So IIUC, it's only active in selftests, and completely inactive in any =
kernel builds.
>> Oh, I missed that. But that also means this patch becomes a nop in kerne=
l
>
> Yes, but given other places are there with XA_NODE_BUG_ON(), I believe
> this patch has some value :)

Sure. Can you please also add something like below to the function comment?
=E2=80=9CThe xas cannot be a sibling entry, otherwise the result will be wr=
ong=E2=80=9D
It saves other=E2=80=99s time to infer it from the added XA_NODE_BUG_ON().

Thanks.

Best Regards,
Yan, Zi

