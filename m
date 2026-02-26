Return-Path: <linux-fsdevel+bounces-78657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGrvGo7ToGmrnAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 00:13:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C47441B0CEC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 00:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 588B830ECBFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 23:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB98477E33;
	Thu, 26 Feb 2026 23:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YcZ++918"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4AC466B51;
	Thu, 26 Feb 2026 23:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772147488; cv=fail; b=tbdyYZvuW9pxBFv5BlPOW1mClGDYZac+zJ8mkWxAiX1vLVbxldD5ta1FKl5j0HhH0fvRUsSV/cYK8rNuvspLRrX5MTf5h1HL2lkCZLxAMgpDRxT02T666A8Hq3I4vHNt+Htk/+ZDssAhA+gT04ihGgUy/rqFuK22z0ow2IfO05U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772147488; c=relaxed/simple;
	bh=HHahNPlq0bersGJ5l+rQYYDJgN0DTRMCeAh5pCqs0Jo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=loITE46rL2q1B4Rxz+znYhmT6pP5iIyp/B2gUnms9TANoF+8ni5Y0z3ndtkLsKr7A27yCTW6tQ9/xMP+vnE0Ukl9pSmMvFKS2S7Vz+fltOwC4hyqhXzyVVH6f0jThzHFDQFKrcT6tcednpfT8emxv93vAxUJ2Y6GRsVDq9n6uTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YcZ++918; arc=fail smtp.client-ip=52.101.56.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFkzf65M7qEUDTLymtKVuA1A2gBy4p8dLgKZTjJEQltAq4b6ntwJ0E9WEcXqI76HKJDT4BqQKwkIT3+lPyw8XI7Dn/EZwyPCaAA8cfRyhfRExBC0r2lpkUxNhUMu6IfQUvsvXII757HCqWhzg+n1FsApf1WMWBPbTlR1IGOIP0XoztgPankWVSAh0UxzfRgaqGkLD5SOX7c8gl6UjRPdb4JNjuYQr/yf9OUIiCJgdUPuiHb5MeuhG/q/Ul5UQvOCrjn0oRyodmdQgcDKRPJKayMz141z+Z6zQNZdxAYtb5CMSkzx+Sid2hL6AUMRzJbTlQ4ewIniDgdlPsNa8HNtUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHahNPlq0bersGJ5l+rQYYDJgN0DTRMCeAh5pCqs0Jo=;
 b=St83R2MVeeNkXpHOJ/r7RYeAMA4PAxqmn7Y+326+sxxwSznsuTyA+Wdit4q8M6UemiqD0J8ImRq+riOqbB3VTbo5MBZFQ/hhqekqyC/dZW4P/QDGnJyfE51je1w84huWC3OhiM5O3nbjwSmOux1pFFlYCQmoOIAZjXOyYfaB0UPOARgPPcqS5mJUiRBJbSp9qhXHoAOdEBNR+Yz29wk9Eyew8ZZV2ujX93N1YuFNhUBHoHTjqNmXB9veZLiwuvGJ6BegI2Sd02Hjum7yThzX3TQI1sRO+rxZgVXnr8sN8SBqjwwnpYTpNM+o3MNL0l4o81tClBA/srOxYFbshxtyJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHahNPlq0bersGJ5l+rQYYDJgN0DTRMCeAh5pCqs0Jo=;
 b=YcZ++918iiGwBloX1CQ84MIqNXFXSAQks1K2wcL73y2ohnCEyBiAf3wnsBwuN3LboWf265H+umUlUqVCd3sgTu2puJJUV9vLP51U9oGQ2rWaWuSDcnbioTSooAvpuC+J91RugrDZG6r/X9H0srqYMKcLtq1GT5B9pj/e9oLMDKWgu+Fn3T+JNhgk6IpPaHWpRcDUK1FWLw8Pf4A7uX/yBpP6HZvoi93x37XT3YyK3zoOor0J59Wz3+fKqA7nSp9WgwVD/JFZwThI3J5KK/HSAbPq2GWsCqC7fDVAVWmSqCb7a9GuIZg04umLz1ee9Nh/4cO9I7W2RrGa7wGQhojuxg==
Received: from CH0PR12MB5091.namprd12.prod.outlook.com (2603:10b6:610:be::10)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Thu, 26 Feb 2026 23:11:23 +0000
Received: from CH0PR12MB5091.namprd12.prod.outlook.com
 ([fe80::a070:cc2d:df74:1cd3]) by CH0PR12MB5091.namprd12.prod.outlook.com
 ([fe80::a070:cc2d:df74:1cd3%7]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 23:11:22 +0000
From: Jim Harris <jiharris@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: Horst Birthelmer <horst@birthelmer.de>, Bernd Schubert
	<bernd@bsbernd.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Konrad
 Sztyber <ksztyber@nvidia.com>, Luis Henriques <luis@igalia.com>
Subject: Re: [PATCH] fuse: skip lookup during atomic_open() when O_CREAT is
 set
Thread-Topic: [PATCH] fuse: skip lookup during atomic_open() when O_CREAT is
 set
Thread-Index: AQHcp3U5mxVoE+FJy0qINl4/+NYruQ==
Date: Thu, 26 Feb 2026 23:11:22 +0000
Message-ID: <6D884659-21B7-438D-8323-477EA22ACD43@nvidia.com>
References: <20260220204102.21317-1-jiharris@nvidia.com>
 <aZnLtrqN3u8N66GU@fedora-2.fritz.box>
 <CAJfpegstf_hPN2+jyO_vNfjSqZpUZPJqNg59hGSqTYqyWx1VVg@mail.gmail.com>
 <fa1b23a7-1dcb-4141-9334-8f9609bb13f7@bsbernd.com>
 <CAJfpeguoQ4qnvYvv2_-e7POXiPeBR2go_J68S2E6c-YW-1tYbA@mail.gmail.com>
 <aZyhkJSO7Ae7y1Pv@fedora.fritz.box>
 <CAJfpegvFhvbzTEjyPXP4jX26qPOVYCyvBmzrbkO3CWOmVCHhSw@mail.gmail.com>
In-Reply-To:
 <CAJfpegvFhvbzTEjyPXP4jX26qPOVYCyvBmzrbkO3CWOmVCHhSw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5091:EE_|DS7PR12MB5910:EE_
x-ms-office365-filtering-correlation-id: 76ed6ef5-4c69-4fae-d2d1-08de758c5ba2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 Sq5YokJcwcZzct2MmpOXQT3IrTLu0hXG/vP+N7NaPE6Ik+WZeLzr7L6uwSewI3RHcqwLQMLxFTr8O3GWjm5oR4NQlvqbRXCSFDDuYccmJXKyHARjpY9548OQZ0HZs9j598DNHWX8ZWzdRqymSmmIwuwy1/fobUtjuSC4sZEXSSJs33kcbf4E7qSSWM89Z/g/Isb8Ra68V8n5yIWJlB0NrFZrsm9RsxbAL97XFv+MRW2zfgr41jYynOP/q7p7I6npapYClK4CFn1hSpiZlGJcpwj8T0W13ykzppfwPIzgaXWcbGOsr9wZ6xHEp4Ex56joNHekmJjmtmQAHC/Odwyuqmhy1fI7kHuo0ACSF/vxh2UXGxC9fYo3Ds+vd2NfresBFLULsXNNY+zk5SvgPeg35HWrS7TgkPVgmarP1lzYZ7PHwdxcaDwjbJfIiwLAJrWwDrYJsdjWooUV4AOZeiXGyZ9o8nN2LXUgEshGbVf1/eaMIQTNPXdvEuMuX3bZF5oOjoDEVofMXEILqrjPBB3v/Tyl4gWMfzCKcFjR3g/dl7PHXkHJB3vFyTBtZJcaCNdphKynjH5qRRAQVUBv8hBGHaGKsMGzGUXu7l7JgIdpiSlmmz/Uq61SlpWmlhbj9L+Ku7FBwDpssdA6I707PYMucjwFPvrw+piCmMW3AvQJTh42zq0JyO8rZiiEqetBrTSVwlSch+9sEYYNpu5GW6RC1RY3DTqGectYqcR4j+ShW+UAs/d29xNJ09NkCOdqSRdiL2fJZ/pHYDU/GNQ7nI8GhOMl7O+YBEMbZw4Ajwlb1Yg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5091.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qm9DVU9QVUxVd1Fud0tBVzQxOXp4UHlRV2JHM0IvcWpOakJlZVRHSElnaXEr?=
 =?utf-8?B?U0RBYXd3RlFJd0QrcDFUNTRPVWtyNmZ5R3pBL2Q3N0J4eDRIa2VvSnhRL1BX?=
 =?utf-8?B?d0I1dHU2cmlCUFhjQXNoaUhYdENxS0prZ3NhaVkxb3lqZzhEQzB2Tjc4UXYw?=
 =?utf-8?B?Y0FLR2lML3VYVk9BZG5ic0dEcHhnc093SXU1UUozbVdLTGpqMWlaVWFWaFUz?=
 =?utf-8?B?endKRmpDOGRwZ3hHclhqZFEzL21NWjlUaUpOMjhJbnNZNzFKZXd1OE9QKzBN?=
 =?utf-8?B?dG5BQktiY1ZJWEFMUWJ6U1U0SmRyMHlPeEo1UGNBQkFLS3JxRWp3QldYM1Qz?=
 =?utf-8?B?RDJQVnl5bUI4NEk3NVJ4S0ZrYVFkb3hJMXQ1S2tWMnRhTmVFSHA2dVZXWWZT?=
 =?utf-8?B?b0dwRkhsMnJrRHRMOTM3aWRsZFVKRDR4aE5yTFBTQ0gvTm1mMFFLcnlRelpy?=
 =?utf-8?B?RnVuZUxkTWVtcERpOWhBY0YvdzJXYVllVDFWWEJJMS95ZXpZK1hiQmhwYlZG?=
 =?utf-8?B?Tmp4UmRJMVh5ZjZ6czYvNmZuQzBHYkdLZEUvb2lCMmVZY1VQcjhFV0VQN3RV?=
 =?utf-8?B?Y1dxUE9OZ3VmZ3B6bmNLcWJLdCtSY1NlSjdwS2p1UG5mTkNMZjJrUWwwNXhB?=
 =?utf-8?B?cTZmTWErVnZKOTdXb1hxNnpMOHkyMFNGeFhZbFdoczZjNUFXWWsxSXRwRWta?=
 =?utf-8?B?QnZUY3hoMllpelh2TGhDcjZLNHhIVWo2UERjWHZCeEMzdG1qcXplZ09nVUtM?=
 =?utf-8?B?UW5lSVZCbUlCckJxMFhNKzJjUmhLUDdyS3kwcTRXZHNkazUzd2xSMEFZaVlu?=
 =?utf-8?B?UERvRUJuSDExblFjVlVNQXhvVG5ab1JFUE9RbGRtRTEzUXkwZnlOZmJFTlcr?=
 =?utf-8?B?Sk1EZEJCSVMyZnRLQklrVTlOWW9KWUlOMHJEbG5Fcmc4d2xKdkNaK0k3TXVa?=
 =?utf-8?B?U1RVeWFSblRpOWp3dlcyRWpSbWQycmVNUmZDT3FYQzM0alk1KzRNdDVhaVVR?=
 =?utf-8?B?U1ZJaFFFazZEbm1jQUkzWEQvWnZYSGg3ZHJxSUVjemZhUmV0MEhIVzd4S0Ju?=
 =?utf-8?B?WWZZK0k2R21wNG1IczJKTVlsMXUyWk1uQm1vd1ZqdFM4SXIwUXhQQ1FJcldn?=
 =?utf-8?B?eXNKU251TEhJT3Fubi9PL2hvMGdwcW5GOUZERzYvbVY0cGp1Yk9VMmdDMjVv?=
 =?utf-8?B?ZEJ2b09GcEEwSFJJQjhyazVEY0tWYWp1MC82ekk5aU1oanpEVGRIbmJJVjRK?=
 =?utf-8?B?OW5sNE5mVmFoWW55eTVRYktPLzdxYmJSUk5jSTlRTGNhSWMyaHdDcXpuMVJ4?=
 =?utf-8?B?T3lkcEVHNHZUZ2RZT3dHZ3BpdWhtNTFqWTNvZEpPU1BrRzlQQVR5QVhEdUtl?=
 =?utf-8?B?Z0JqdnArTGZWZ2hxWkd2Mm9aUWFNaWVxRG5oQms2VHgwQmJYa1ZQV0FtcXVZ?=
 =?utf-8?B?SGY3Mm5lTlo2bG4rUkNhMjZHQ1FJNEk5NGVXTStJQ2g5SUpQWkZiajFwekFK?=
 =?utf-8?B?bVBDbytDRUp1TXFUaEd0aStGVGVrVnZpaVQ3ZDZwcitFSktHMHFmNEpSQkY3?=
 =?utf-8?B?NDBrdkxieDI0VlN5c1pxQ0NpTktYbDlFSmtvazJVUlRKT280RUc4cDNuY1Va?=
 =?utf-8?B?M1k2Ny9wY0RhSzhSeXFQMGxKVDQzSGVGUkRNRldWdXFTVmx2SmhTeVVqZDJ2?=
 =?utf-8?B?SFFhVzZ0d29ESHBReVRabHhoTzdxeVp1aEZtSHBGMWV4QzE0RmZFMHJqcSty?=
 =?utf-8?B?cEF3dUtwZC84UjF3ZWZMbnQxcE54K2E0OVFBeHpkRDNEcVFManRiM1BGTEhm?=
 =?utf-8?B?b3hieWJBaHlUWHYvVU1xczlnSWQvbnF6OC95dmhLSjB0S3dMeUw2OUVxdUhR?=
 =?utf-8?B?aDZnUCtuRm5zZ1Z2MjJFVkZjZ3RwemhjUEF3MDV2Q2p0VkhEVDh1d1orQTVV?=
 =?utf-8?B?MnVmb1czWFFMcFF3TmdNSzFyd0t3dUlDVkNsMUczTWRlTE5zSUdueFM5OXNs?=
 =?utf-8?B?Z1RFUzFSWi8yekdPdHY3YXEvdE5VTEdsTlo4WDh6N0pNaFRpU3pJMXVWd2Fm?=
 =?utf-8?B?Y0Fvams4UDl4TmhNcEdVelk5UENVSDh0RG00MHhKYlM4RFovNmVmalBSWXVO?=
 =?utf-8?B?NnFhZFZyQWIyY0pOeG1wbnErZis1a1ZHKzJPZXk0dnhsbVZLOXZ0Mldnc1JB?=
 =?utf-8?B?K1k4M2xramkzSWliWjdRY3I5djhvdGUzdTBHeHRrK29nY0JzYWM1Rkt1ZWFl?=
 =?utf-8?B?bjlYcXNyMy9jZG43WWRqU3ZZbzRqZDFzNmgzWGlLMjgrbnJYeUZYLzMrby9u?=
 =?utf-8?B?UDhOOW81UGlUN3dRaUlaUHp6bW9zS0VSckNsMHdoakdtY3dGWmhXUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8B381FB38C56344A779E13B16C24E32@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76ed6ef5-4c69-4fae-d2d1-08de758c5ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 23:11:22.6055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hQOt8bj8dk+VcsbDPtWPUPtdND5043e2dupViimHZdXvTkrVMQ6ifu4jDDB6n6vm0z2Nc25siCRuCFbh1AASAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78657-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiharris@nvidia.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim,szeredi.hu:email]
X-Rspamd-Queue-Id: C47441B0CEC
X-Rspamd-Action: no action

DQoNCj4gT24gRmViIDI0LCAyMDI2LCBhdCA4OjMz4oCvQU0sIE1pa2xvcyBTemVyZWRpIDxtaWts
b3NAc3plcmVkaS5odT4gd3JvdGU6DQo+IA0KPiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24g
b3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiANCj4gDQo+IE9uIE1vbiwgMjMgRmViIDIw
MjYgYXQgMTk6NTUsIEhvcnN0IEJpcnRoZWxtZXIgPGhvcnN0QGJpcnRoZWxtZXIuZGU+IHdyb3Rl
Og0KPiANCj4+IFdoYXQgaXMgd3Jvbmcgd2l0aCBhIGNvbXBvdW5kIGRvaW5nIExPT0tVUCArIE1L
Tk9EICsgT1BFTj8NCj4+IElmIHRoZSBmdXNlIHNlcnZlciBrbm93cyBob3cgdG8gcHJvY2VzcyB0
aGF0ICdncm91cCcgYXRvbWljYWxseQ0KPj4gaW4gb25lIGJpZyBzdGVwIGl0IHdpbGwgZG8gdGhl
IHJpZ2h0IHRoaW5nLA0KPj4gaWYgbm90LCB3ZSB3aWxsIGNhbGwgdGhvc2UgaW4gc2VyaWVzIGFu
ZCBzb3J0IG91dCB0aGUgZGF0YQ0KPj4gaW4ga2VybmVsIGFmdGVyd2FyZHMuDQo+PiANCj4+IElm
IHdlIHByZXNlcnZlIGFsbCBmbGFncyBhbmQgdGhlIHJlYWwgcmVzdWx0cyB3ZSBjYW4gZG8gcHJl
dHR5DQo+PiBtdWNoIGV4YWN0bHkgdGhlIHNhbWUgdGhpbmcgdGhhdCBpcyBkb25lIGF0IHRoZSBt
b21lbnQgd2l0aCBqdXN0DQo+PiBvbmUgY2FsbCB0byB1c2VyIHNwYWNlLg0KPj4gDQo+PiBUaGF0
IHdhcyBhY3R1YWxseSB3aGF0IEkgd2FzIGV4cGVyaW1lbnRpbmcgd2l0aC4NCj4+IA0KPj4gVGhl
IE1LTk9EIGluIHRoZSBtaWRkbGUgaXMgb3B0aW9uYWwgZGVwZW5kaW5nIG9uIHRoZSBPX0NSRUFU
IGZsYWcuDQo+IA0KPiBPa2F5LCBJIHdvbid0IHN0b3AgeW91IGV4cGVyaW1lbnRpbmcuDQo+IA0K
PiBNeSB0aGlua2luZyBpcyB0aGF0IGl0J3Mgc2ltcGxlciBhcyBhIHNlcGFyYXRlIG9wIChkaXIg
aGFuZGxlIGFuZCBuYW1lDQo+IGFyZSB0aGUgc2FtZSBmb3IgTE9PS1VQIGFuZCBNS05PRCkuICAg
QnV0IGFkZGluZyB0aGlzIHNwZWNpYWwgInN0b3AgaWYNCj4gZXJyb3Igb3Igbm9uLXJlZ3VsYXIs
IGVsc2Ugc2tpcCBjcmVhdGUgaWYgcG9zaXRpdmUiIGRlcGVuZGVuY3kgd291bGQNCj4gYWxzbyB3
b3JrLg0KPiANCj4gVGhhbmtzLA0KPiBNaWtsb3MNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2sg
ZXZlcnlvbmUuIFNvdW5kcyBsaWtlIGNvbXBvdW5kcyB3aWxsIGJlIHRoZSB3YXkgZm9yd2FyZCB0
byBvcHRpbWl6ZSB0aGlzIHBhdGgsIG9uY2UgdGhleSBhcmUgcmVhZHkuDQoNCkRvIHdlIHRoaW5r
IGNvbXBvdW5kcyB3aWxsIGJlIGxhbmQgZm9yIDcuMT8gT3IgbGF0ZXI/DQoNCkJlc3QgcmVnYXJk
cywNCg0KSmltDQoNCg0KDQoNCg==

