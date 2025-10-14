Return-Path: <linux-fsdevel+bounces-64092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 552E4BD7CBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 09:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEF4C4F90A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 07:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80C530CD8C;
	Tue, 14 Oct 2025 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ERe/IzN5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="wH9oOAVJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302182D131A;
	Tue, 14 Oct 2025 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760425348; cv=fail; b=st9B1bSIaZb60uQXVGpppURreabLtJ256eWUKrRwwrVUDws+mFxnouhVRLjLpwcaHWJcZaEacoLXCcNnToaTGhePVMDvQNn7IDs3nTtTwidJnjkLmFXKpxFJFOs98QY4coNuOrWUaN/Mc5nTNfvLYa4nV2H/X8rcFvkB3MERaPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760425348; c=relaxed/simple;
	bh=OL2jzfFbm9aLpz9/a1Gy45qPV4o8zoNtQfEqa+1rOmQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V8KNZ520iUHCzmJknycPdABbhdyWQWAQdhpLahJY5ZLQISf+9Gt09YZOJf4q4QIDQCGjd6hrL68Dd90HIWXXMdL1/4m4ai8j2WipLJT+0LHZf8EH+UE4eTjy9wBVe2fqcU0d9uK29CZweSWb51Omw+vKtReUwK0+zPW5rQvljzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ERe/IzN5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=wH9oOAVJ; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760425345; x=1791961345;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OL2jzfFbm9aLpz9/a1Gy45qPV4o8zoNtQfEqa+1rOmQ=;
  b=ERe/IzN5geVQ4g+XUCY49Tts82B/Mu862RRVX2Dvd/zyF10p2ds6Wf6y
   rVk+3P/W+refKPkN/tuPikM2wReTSKdwEtxy39lTzHPqd2tQtYwxVBsU/
   Ndw4XU7b17OiCI/SN0t0zLqJGbmW8ZXZfP2Hv3bYAXAIBIqqQy+njRJte
   Y82Qhgq/og612ZYnOWx9NGRPEYn+7vBNLETaydZ+/mwFcsqUTYGQPDIKZ
   CseHjd7hGPSouaIt1HRzN1X88K/sRAybeV2QrleIFa7BJR5on8uNJ63Ge
   ZNPoh4Z5Do8aXSJRHtK9upnaWHXgznB/QS5J3X0uoUfKA6K5l3sNZ/LfI
   Q==;
X-CSE-ConnectionGUID: B3yKB4h+T8OfuASEhwGVdg==
X-CSE-MsgGUID: vp/iWCYQQ3CbbUctwmJg2g==
X-IronPort-AV: E=Sophos;i="6.19,227,1754928000"; 
   d="scan'208";a="133063769"
Received: from mail-eastus2azon11010013.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.13])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2025 15:02:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AS8SF2q2Nv4xPYa9+No9T9cySSePdPPeLJL96qtH/QHdLqFxkbkV0J4rV7xeUfMxRMd74uOQ9Tayy0IUjVm89VT6edySPa5uAxxFkXErMUswfkZiP9BB7gz6yZtTcYgqLLgZFGUSZOsCquRNxNEpG8TvdKym0kTokBYQquWFCrfp37uFNF0hshN86/5YVkHv30UBjI6wvkoekiYTq2wm4PSKtjZUk6fRyymlYTRaeMV64f5eqr1ANXvdpm6kh2S0TyV7qM5u+WgmKexEHjSFoA+c6VHd5RiueazcDX7pyxv8D3eEEdZEr6uSb4hPO6p2hRWp4+JOKwAi0wiH0EFxiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OL2jzfFbm9aLpz9/a1Gy45qPV4o8zoNtQfEqa+1rOmQ=;
 b=eRu5ZHzpL9UAzJnZGHziE+UOAJ4J2hIPsTE3Gv2u+cv2MAyDfe6VWHd95w0qc6KAxl4uZgPYmExJ8X1AooR15bII5fs8dIAXeqQPI7UtYL6CVN9Xre8K5/UpwyUPJMCokorOo0icLQpR6dndO/1Dtz6SasZzMltPcsDltevot8+ypbB0z8rIZAOD+EkMWZqMWT6JOFg+s2HloAaZujUozEtDs+/zuQa5hv7HXa9h/OX4qSm7qhVk0anAm09BEWTXZZUrPfDhchlGPgAJ7ivyc7M5DJR1kEwYy+FPTxQehEgdyZd1Zw8qBVUe9r6Np32iw+e95XGEthbILYsxZJcU8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OL2jzfFbm9aLpz9/a1Gy45qPV4o8zoNtQfEqa+1rOmQ=;
 b=wH9oOAVJszS3YqJ34TEz9mbiEzE2QjFIEdoDcvOSHHEQPuKmAByDRen+aj0Xdh9WR0bYE3uWOGPx5EZdoOwbUv1zQC5AeqV+VcWuKZH2p026uOdv1hhOEmRSL473rl1eUuJ4gtUBZyxQXUVHBXjhk9tnYU4VAtaY6D782lQkaAA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH8PR04MB8687.namprd04.prod.outlook.com (2603:10b6:510:250::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 07:02:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 07:02:11 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, David Sterba <dsterba@suse.com>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Eric Van Hensbergen
	<ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet
	<asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>,
	Chris Mason <clm@fb.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker
	<jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Josef
 Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"v9fs@lists.linux.dev" <v9fs@lists.linux.dev>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-ext4@vger.kernel.org"
	<linux-ext4@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "jfs-discussion@lists.sourceforge.net"
	<jfs-discussion@lists.sourceforge.net>, "ocfs2-devel@lists.linux.dev"
	<ocfs2-devel@lists.linux.dev>, "linux-xfs@vger.kernel.org"
	<linux-xfs@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 04/10] btrfs: use the local tmp_inode variable in
 start_delalloc_inodes
Thread-Topic: [PATCH 04/10] btrfs: use the local tmp_inode variable in
 start_delalloc_inodes
Thread-Index: AQHcO+1dZVuRfbvE/kmu3xObSWGqYLS/uh8AgAFYcICAACaCgA==
Date: Tue, 14 Oct 2025 07:02:11 +0000
Message-ID: <57d7136c-b209-4f8f-bb6f-8ced354d205a@wdc.com>
References: <20251013025808.4111128-1-hch@lst.de>
 <20251013025808.4111128-5-hch@lst.de>
 <aae79ea0-f056-4da7-8a87-4d4fd6aea85f@wdc.com>
 <20251014044421.GA30920@lst.de>
In-Reply-To: <20251014044421.GA30920@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH8PR04MB8687:EE_
x-ms-office365-filtering-correlation-id: 6e206cdf-12dc-4fba-57d1-08de0aef9950
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|10070799003|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MitJeHdSWTFDUG5ucHZoUlFEQ0VwS0gxRnN0L1BxRnpXaE9lNm0rVktoaFFN?=
 =?utf-8?B?RklrZW45UXI2UitUNDg5RGtCQk1CaDk3MjVJV0N1OGk1TWxiVVVVeUZzWUZ2?=
 =?utf-8?B?Sk1WVW1HKys3cURSUDJyRTAzNEl0YW1CZHVPZXlTSjl1T1lXeUdaa0tETDUw?=
 =?utf-8?B?aFRDRWlQdDRpb2hVNmgyQ3dUSzBBWjBWajZqTVBHNW5Ga0MxUTN5TWhIZzgv?=
 =?utf-8?B?cVNwTllQR05MMmVKOWErT2Fjd0ZyOE53SlpCQUJiR0k5M0d1bC9vOVFFS2li?=
 =?utf-8?B?ek8rcTl3eEhaaEtQT1Viak4rVGg2UXFteXlVQUdXSWwvVDE4QkpmWFN5SzJT?=
 =?utf-8?B?R29uUjV0dEpLWFd3R3dGZDhabCs1YTMvOVpiSm91TUVRMVg2d1FOSGs5bkUy?=
 =?utf-8?B?bHBEV3VMWGNRL3o5VUJFSTdSVncyemV6RXJNYjY4a2huT0RvTGFNM1hmdWtG?=
 =?utf-8?B?SWtXMUJHVTNDWEZ4K2U1cnNSZGhXS2JRMk5qVnJib2w2V25zUnBXV2xDbkFX?=
 =?utf-8?B?RHlyQnNDZDRGc29iSGV6cFVhbFNTeTRnODN6dUF0TjBmdy9wV0dka0lRL2Fw?=
 =?utf-8?B?NFZsbVRsOXVoL0xpcEJ5d05SWWRWNXpFZis5S1k1SkNBV3lHcXg0azNaeWF0?=
 =?utf-8?B?STN0TWY0Q3ZybmsyaFM5QU8ydjlSN1EvK2xiWDRObXJydzdqWmRkR0QyMmVY?=
 =?utf-8?B?SmJrYUpXQXNjTm0rTmdpZ0t0U0dZTzhkdG10bGVYT1NIL0hGajVtQ0FOMlFL?=
 =?utf-8?B?WjRVdjRtRFhpZzBNN2lHaEFzK2hTWVYvM2lhalpkY09kU3hlL3dpY3FqRUho?=
 =?utf-8?B?aTR4QXFKU2ttQ0JOTFpKbDlYOFhTbXhyekg2b1hvUS9Bak1GOENsRWFXbHpG?=
 =?utf-8?B?RHRydWRmQWUzcVNUeTdUOGc0U2poU2pmT3MwQ1FRNmdGRWlIQUE2Wnl0OVBI?=
 =?utf-8?B?cll3MkxBQ2x2ZTVQL0N2Z2FkeFhnL1Rya3BveklEaGk1Y0puQjZHSmFVMDND?=
 =?utf-8?B?NkJYRnpxWmJoOGdiV3RYRHFwSVpjejhnVDdGR3BLblZ0cG43SnNTL1pic0dw?=
 =?utf-8?B?REk4dHZZWWE4d29tQU53MWhNVHk3Yk1HM2FpWkpqZW1iQ0hlUW42S2tEa1cy?=
 =?utf-8?B?NG9kRnYzdGdXaURDUi8xc01yS0ovbzJvdHlRYjlFOVB5NE9naElxWkNKaEpO?=
 =?utf-8?B?T3lKNG5lYXZmTjlrZG5jZHRhS1kzZGRCUnEvVDd5S0lyK08zd3lvS0N5WlBh?=
 =?utf-8?B?dXE1Y2JOUzZLR3hYSEJqQmtDUmJBK3J2KzdMK21WZi9MYlE2eGc2WStXdEYr?=
 =?utf-8?B?UWxhVjYzVTFKSklPaGJ6V3VYa0xsdW9EQnZlY01rT1gxMUtZanlmYjgwRW1w?=
 =?utf-8?B?cldUQThoRDhVUzJGVE05M0ZBWklOOEorTExRcGUxYW1mSktZUko5OXhKTHFM?=
 =?utf-8?B?REQ5VUxKLzVvUUdKdGRmTzUzQ05EZ0tyVHZ2UGREYTU3ZVozUzJTOEc1K042?=
 =?utf-8?B?c0pqNVlveVVQMGk5T0J6V1NMZjVWOWtvUVViQ0g5b0FMVnliZWk0RmQrU2c0?=
 =?utf-8?B?dFlERkxNNUgxQkhRUHVrMmdMQ0VtZ0Y3LzY4RGRrNlYzUlY4V2ZhUGFoY1c4?=
 =?utf-8?B?STFWVG93U2lIWGY5TVRQanNhQzNDZllKRHhXdkg2aG9vc3B5dFlJVU92NEtx?=
 =?utf-8?B?OTBsTklWU1VRTVN6UWE3RUtxcWhiczZpU1JYVXJxSDRzWXlZV05MWjE3S0Ri?=
 =?utf-8?B?KytrcldSN2N4Vlp3VGJKemE3eE5kLy9uZ0VBcFRVQzJXOTdQVm5pcitpVExO?=
 =?utf-8?B?S2JIQnFydldyRFUzeVNkdTAza3h5Z1grNkd0Vm1KOGxFQTNQRS8rNy9UZEZV?=
 =?utf-8?B?L1h0UWFHazh0eXFCdW9JMnY0d1kxQktrdU50UEdtQUNaQXRYYUJ5UzV2VDh5?=
 =?utf-8?B?eVFRei8xTC9LenZxQlVqY2phU0gyMHh1SWtNZE1yb1lQM2tjekJrSzRwQnk3?=
 =?utf-8?B?RUNHQ21aUUdTTGZqTEhPL1E0YjhkNCtQeHVNaFZhUHZ5d2poajAxaXBJUC81?=
 =?utf-8?Q?d8ULBV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(10070799003)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0tjUFh3bFpWNENxaEVyelk5VUpFR1FMQTYzcmc4Z0hGdmNMSm9WL1BlLzc1?=
 =?utf-8?B?dmF1eHdENFBSVnlxZmxIMHRsLzExRWd1UVRlZ2xCZXhURnlhU1VWSmtYcEw2?=
 =?utf-8?B?OGU1YmFqaVBEclQrU1hoREVhV3ZsL0JBWVh4OEJQYjVISW9WMWlLOE5lenVq?=
 =?utf-8?B?U3hVQ3RrTnRNQWJqbVU5NDd5d29CTU5jYXc2eVdLcHoyemhWeWwzWUd6NEs3?=
 =?utf-8?B?OVVwU3phWVBiU2lPcUlvVmhUdCtmOWkrcGFXK1JOV0ZOdEhnKzBZMEhiNldK?=
 =?utf-8?B?NFp4SlZMRmdyV09PWUN1M25DUVhzcTVVbE00MUkxZ1ZEV3ZuMGJ6QU9yMTNt?=
 =?utf-8?B?cEZpK1FDb1FyUHc3MGovK2dvSUJSdmVYc2ZkNG92MHM3OVRyT29oOTFSVHlK?=
 =?utf-8?B?N25ERHc5TFhRdmJza0IxQlZ1cVg4UlNDaGF6YXlOamJYWW54eUlBaDVVTVIz?=
 =?utf-8?B?cGNOUTg2YXQwbjJSWE16aGtOeFE3eGc2dzFCd1F6SVZleis2MTlpZ0pCcEJJ?=
 =?utf-8?B?T1ZoZUZmTklBWHhlMHUzK2wxempETkplNVB6QmQ1NmRzNEt5VDFTUzBsbkdI?=
 =?utf-8?B?b0phcnYva1pFTHdrajZFV1VMVzM5Mi9PcUo1SENrVTZyWlpyMmQ3M3pCbmlt?=
 =?utf-8?B?dmVqS1BobVNQY3NqNmRocHl5bVJvMlRXdjUyZHhpVk1nWk1SMk1GRGtHMnVB?=
 =?utf-8?B?NzczUEJQQlhCWElGK3hqRGFaOEtSNVNZRjl4MG1QMVVFZVFoRWVaQ0Q2UWJE?=
 =?utf-8?B?QmFkWnJBVSsrdFJQanBVS3BJR2llLzl1cTFCTnVDTnZhMkFvZVVUL1BhUVVB?=
 =?utf-8?B?NHoxYnUvTjdXdHZHdE5MQlZlb1lXaHVxU0E3Qng3OERGb2x5YlpEYksvOFo3?=
 =?utf-8?B?OVE0cVo2MFJYd083N2NibUlBbjB3bm8wWDZSR3VQUlVqdk8yenRXSW13WWxN?=
 =?utf-8?B?S3gvdVBhcm1HYyszc05jSW10RExsM0hEL2FXemxnRzBrMzN5ZHczek1xOVV1?=
 =?utf-8?B?cHprMHlMOG4rTWM1VVhHREt1QUwzUEt6T0Mwc0l3eXdYUlBRbkhEL255aVUw?=
 =?utf-8?B?RjBVbWV1WkVzbjYyZVJ3bUVxc2ZWeXA1TXROOUI0VnFvcXRIZXBOZ0FNL2JD?=
 =?utf-8?B?SmQvMTZmM0ZjUTJJM2duTElEbHFlakdMWWZMZVRwQ1hTeS9maGxtMUpuZURL?=
 =?utf-8?B?THF5VVJQcm9EVHgyQldOM2VGQWFPRStFVG1nbHFPRWhSM0xyL2dsc1UxbzJw?=
 =?utf-8?B?OUEwMjFXZ2NndkJNUW1tbUxvTHdiQlN0bTRhWEx6MUttNlAwS1loTWozakds?=
 =?utf-8?B?S0hLekNOVHIrd1k2WnV2L2M5bUJ5TGJNampQU255R0E4UXZtOU5iRk91dkM0?=
 =?utf-8?B?RUJXQ1hnYVFwYTlYL1htNkEvL1dXbnhxVUh0RHRhbVgwejZ5Nk1obHRxSWNT?=
 =?utf-8?B?WVFCbkxNLzdiVFlJa3d0QVIyaHdVU3BPeWxoQW4vQllzMWZ5UnE0SGtDeUtO?=
 =?utf-8?B?alF0bzdLcHREcUQ1cFE0WngwckQ1UUNSUWJLU1FTVjFlVW5Rc1hGY0k0S01P?=
 =?utf-8?B?dE1lVU03aTZISjRKeVJ3SWxvRG9DVExNQUk3T09rN1R6T0ZBUjFKTjRNaDUz?=
 =?utf-8?B?UnBIWTBYMzlJUEhqYkNNcGJvZ0NCMlo2Z1I4RFltVW9VMFZYQmFtK1Rvc1RQ?=
 =?utf-8?B?M1FBWEdza0xnaVV6ZXRqWm9JeXdBMld2OE56NEZkVEVhRWQrUm5yWEx3aEhj?=
 =?utf-8?B?VTRRMmNHSDlXUjZkdVZyZ2MwVXZwZUxTbjIySmp2S1B2VlU2c0J1MXJHdDBt?=
 =?utf-8?B?c1RTMCtVNEVYZGMzWXJTUFZNTWJRU1NpSUlUTXZwb3lGM05UVytrQzVOQ3lh?=
 =?utf-8?B?Q2p1Zkh6dXRGS0V3dHFMYm5Kc1RlNlc2d2NzeHBGUlAxdFlpWS9uQ0N1R3U2?=
 =?utf-8?B?R3hKbnhBYnlCdm1LN1p4Vk91UUJ6ckE4U2FMOW1uZkxzOE5qWWNSRmJ6dzN5?=
 =?utf-8?B?QlRacTZWZHZDWEpMT2VIRGJ3Rmt5cm1Ha3pSTVZlQWZlT1Q0T001dmFiUVpF?=
 =?utf-8?B?QmM2cENjeDNlZGZ6aDNZU0hUZmlycWlpN2JDRkp6TnZOTG5BK2VSMG5aRjJ3?=
 =?utf-8?B?bXhHZm1NZVpWSzhHMVhuR2lFRkttazg0RGdlWHNBY2E4bmRMN0xKRWZEaVZE?=
 =?utf-8?B?bGRJZHU2NmNTSVNMNFhJK242eHNUcStaSUo4KzNkcGkyZS9xaHhxQ3lLdVBa?=
 =?utf-8?B?bFNTOExtTE1lV3AzTUdlTUtUWWF3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C024664BD4F81B4080AC6150FD6F2CFF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/LiUgvXqGDN6bF/SFKncCg13nW8nNDh1rzO/ceQUKK9xoLzuczWVsjI9WsS6GFpV8FEo/ldVT/lSPq9zoXMBYWZHzZRjC530Xxm6Waz4P4EqRjYrMVD/K03PkFqm1HTxV9QEzDNoHogCW+Rs2vGhQxjEspZA36xPCWOMlWaaTlzXlRKTJHsd9J1vQCToixOyMdCXtdFjKWT27pGK6L/8CRFI0NKD40p4fDOX2Bq07hcY2tR2NxemqBJIwcCWdHsekkWV0BFfN14c0UF1dudv7upI7g/Zo7Mr1czr6nY4R3uznF60QZFEOYb94UvHju8Ehg8PE2Fi/bazvtL7m9pUlkHrAwA5leixj8aE9c+xLue1S3k7NaFAjcSti9XtKhrW50TBNrF47W2hwUhtxv2yV3ze/g/lQ4frmLgce6sCXZRvfQ7PfEqpgxMvw7CSMYqhxfT/0N6RSlVL6VVxauTKL2aZsD+z0O/MCTkGb2i5YbcNzb5rBuFgF9FEwuWfoNaq9slHo3mNwmMFIZePgxkMj6cf0WJG7XBQwzXzgtysAZ2Z/UWpcPf3URiEshUWAaFQ0QZD2GC7ad/zFLubVoTFaFdx6PS5GixQV7Ft4PEgMSbWpK15Vix9GWC6YcmVOL/u
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e206cdf-12dc-4fba-57d1-08de0aef9950
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 07:02:11.8593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TYpZBdOX+8pxlfG615kEMT1ZPMsBgvEo5DSrQXyz0DpuVxde4oaaxCY0LssIleyBctiWj5MPlnQ9JRPGbzIr7s30XKf6YKrf28vzm4MgCwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8687

T24gMTAvMTQvMjUgNjo0NCBBTSwgaGNoIHdyb3RlOg0KPiBPbiBNb24sIE9jdCAxMywgMjAyNSBh
dCAwODoxMTozNUFNICswMDAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBJZiB5b3Ug
aGF2ZSB0byByZXBvc3QgdGhpcyBmb3Igc29tZSByZWFzb24sIGNhbiB5b3UgcmVuYW1lIHRtcF9p
bm9kZSB0bw0KPj4gdmZzX2lub2RlIG9yIHN0aCBsaWtlIHRoYXQ/DQo+Pg0KPj4gVGhlIG5hbWUg
aXMgcmVhbGx5IGNvbmZ1c2luZyBhbmQgdGhlIGNvbW1pdCBpbnRyb2R1Y2luZyBpdCBkb2Vzbid0
DQo+PiBkZXNjcmliZSBpdCByZWFsbHkgZWl0aGVyLg0KPiBJdCBpcy4gIHZmc19pbm9kZSBpcyBr
aW5kYSB3ZWlyZCwgdG9vLiAgVGhlIHByb2JsZW0gaXMgdGhhdCBpbm9kZQ0KPiBpcyB1c2VkIGZv
ciB0aGUgYnRyZnNfaW5vZGUuICBCdXQgaWYgdGhlcmUncyBjb25zZW5zdXMgb24gYSBuYW1lDQo+
IEknbGwgaGFwcGlseSBjaGFuZ2UgaXQuDQo+DQpJIHVuZm9ydHVuYXRlbHkgZG9uJ3QgaGF2ZSBv
bmUgOiggRGF2aWQ/DQoNCg==

