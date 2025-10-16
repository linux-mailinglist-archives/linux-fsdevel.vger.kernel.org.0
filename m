Return-Path: <linux-fsdevel+bounces-64362-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B659BE31A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 13:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C41E4588C42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 11:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECE031A55A;
	Thu, 16 Oct 2025 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="Fv3dbG4M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191a.ess.barracuda.com (outbound-ip191a.ess.barracuda.com [209.222.82.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CE0328602
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614426; cv=fail; b=YWK2FsxjbHV3d2fKWgc1r8hbcwm24f77igbw1AXALUWeaE1LK3NWSEFqli1zPzfCIXfEVj9GIOmezZZUiu1f1hanmMU4W7rfh5Ce0OJKgZBpyv9+GVECrIAlTW3ONMLo1J2MmVWfAZAFnFylHP92pvBgPSAFFKvBUXuse/Xazmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614426; c=relaxed/simple;
	bh=wcMLs3xTR7dxqGKyfCE6tuf9Pj6eHuz47/pYgebZi+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JE7+ZaX0z2widnQnrtBclBsvZHi/eU35Lw25kDJ73AMQz1pH78nCcBg38uHLkRTWkduA/V3BKBpzBc+ulSF5ZNaFx5mrkHftxaXGobhlzM18pEirxvpJYSD2kZJs/Q2V+PCuOC1oPXzLwg97OQzcdE3wEQuhUT8vSyK5iKrE3Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=Fv3dbG4M; arc=fail smtp.client-ip=209.222.82.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022137.outbound.protection.outlook.com [52.101.48.137]) by mx-outbound12-167.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 16 Oct 2025 11:33:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lf+yqIgXmh7XTIBBIBChaf1ndStb0WuY1FmTNAczr589E08D9QVqJEWQH3PaXaGIkAbXxbvn65BR78DkNCiZayrwrUQZ4oeOxIyUJQpq3wH8yow2pLPw/2hEiR9sSV8UAGqK+XIVkZ8AShmFp7QVZwKzeKmoG4lGYMHMzwFhs4TOTOOqAddFLjlYcWUtrHUGPYl2BXl+7EQGcNb1ObTQkTRNT1R/FAAaTdoyqSQGhe6UczyN3mol3GOA5vm/C/qus9+X6YOFB3L1gsSH8uZq6bidbBuayo89rweKvoxx+KW6VoFLvy6+Bhwkwan5as5t6+6+kUkoe+pcoPfUDKykIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcMLs3xTR7dxqGKyfCE6tuf9Pj6eHuz47/pYgebZi+E=;
 b=uQw7WONxu0CGMsMg9KnGR45qpWHrrtqHiPoNNmo2eBe+u384nOMEkdK2MHN3aJR+FR1ww19QMwa5mOi+HDQ9m0uPdX3TYEwXDm88hmRFtlZhXvy1VXB4qbuqdVadUgznffS5gGqeQch45mR7zhe/1fk7UXdLJywyvYQCNK00GkQR3844uNlRmy7APA2dYSOPWBf4emfIhYyXSinioSsZ/vp2gBEtWbqnguEilcd97bCZgQM96A7IPsgM50ccFzp/rAcM4YvmCleLR2jSx6X6Ybc3iGt7BWkN7aKScpnNYRnF+oMzxacAJe04rm74OXidOAarwM+xsj6X/eiuhzfB2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcMLs3xTR7dxqGKyfCE6tuf9Pj6eHuz47/pYgebZi+E=;
 b=Fv3dbG4Mwo8XDqt1dPe7Td1hX630MZmzbaStUIvdFL9kZw8UgtQsMHgWW8tQvmJUyk+5jCXpxxLCrL+sjrjU2Z1IL+I9FHimfL+Y63d4vO+Y7XjRcsJ7xIZym9qOnTC+Pmo+2nAgM0kT4MyPqOdiheUQIK96XM0wxvcFd+yavzg=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by BL1PR19MB5746.namprd19.prod.outlook.com (2603:10b6:208:391::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Thu, 16 Oct
 2025 11:33:29 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 11:33:29 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Joanne Koong <joannelkoong@gmail.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, Luis Henriques <luis@igalia.com>, Gang He
	<dchg2000@gmail.com>
Subject: Re: [PATCH v3 3/6] fuse: {io-uring} Use bitmaps to track registered
 queues
Thread-Topic: [PATCH v3 3/6] fuse: {io-uring} Use bitmaps to track registered
 queues
Thread-Index: AQHcPGQ8+3J4QFncpk6WivFvWcNLB7TD48gAgADE0QA=
Date: Thu, 16 Oct 2025 11:33:28 +0000
Message-ID: <23182e9f-0007-46c2-b799-3b808c02d5bb@ddn.com>
References: <20251013-reduced-nr-ring-queues_3-v3-0-6d87c8aa31ae@ddn.com>
 <20251013-reduced-nr-ring-queues_3-v3-3-6d87c8aa31ae@ddn.com>
 <CAJnrk1aaVa4hc_VC4G1axT1_=b6eyRW01KVczhvitCcsN7cACw@mail.gmail.com>
In-Reply-To:
 <CAJnrk1aaVa4hc_VC4G1axT1_=b6eyRW01KVczhvitCcsN7cACw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|BL1PR19MB5746:EE_
x-ms-office365-filtering-correlation-id: 509b036e-ff63-4337-285c-08de0ca7d40b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|10070799003|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MW1JSElxZFJ2dUNNakJaSzJmd0pPK3hUOHA1djhpWnpwVHBYNkdWS3hEZURI?=
 =?utf-8?B?elFtRzhUME1SeU9KOG4ySTNwd0xVQW1odFRaVHM1RlVVVjQ2SkxkRWFrUkdM?=
 =?utf-8?B?aTd3YnB6bVBFVG9VT0t0UGE2WmhFV0hQMk52TDR1VGRGc25xN20xZTdZV1BT?=
 =?utf-8?B?WXJSaENMVGVXaDFOc3VPL1RvZDgrbTVwVTYvcnZFS2dVTmZ6a2dmajFmNnFm?=
 =?utf-8?B?VEhzOC9DSnorK3ZEemJyMkN1QTFMM3ZNRnhnTDcraCswZjIreVlDalFud0Js?=
 =?utf-8?B?M1JvVzcwTFRHN0ZwTnk2a1dGK2wrVUNoNFVTd2J2R2VZR0xVN3A3NkRUWVRw?=
 =?utf-8?B?R0xrT0p0NWFjajRlTEs3NDFiMGxNZHl6Y0dTOXdhVStmYjdNREZZVENxMlM0?=
 =?utf-8?B?MzF5c2krUldQd0taTFdhMlZCUVlncm0xcGRxem8zQTdPckZqWGk1NkhybnJk?=
 =?utf-8?B?OGlZRDZlL0JsM3Z5Sk4rMkMrV05DRjdrbGtNS2Q4NUZrWHNvNWxLOVluY1Ry?=
 =?utf-8?B?T0tOMy9JZUprNDFxWVR4cXlERTVkNXAzelluTWdBczJTaFhlVDF1YiswOWg2?=
 =?utf-8?B?NHROQUQrVXBsTkp1ckpjb3BLMUsvbWtnL1NXSnFWcVI3U3Z5STMzdldhajJY?=
 =?utf-8?B?cEUzcUJPR1ZHTzY1Nzk5alRUbWV2V0NsdHNaM1kwb0ZibW1NcUl1QnJpTHps?=
 =?utf-8?B?aVVTTFArd1BSR3B0UjdZZHVGdzFMRjdBcTlGYTRqeUZaTnJwZkxaR1U5SkN6?=
 =?utf-8?B?cHEzK3RRV3N6ckRuVFZROVhzeWsvYlJlY0NaVCtlbStiZ0g1VENiYU1sQjVp?=
 =?utf-8?B?Q1A3WG16T2k5bHNGYTI4K0lCU1ljM1ZYVTVkWFZDR0Q3TlZjLzZuSlFDOUUr?=
 =?utf-8?B?VXdvaXFxNGR2MEhOQzY4SG5oaEE3dnBMR0VUSXNxWkZCN1VuZnc5WFJkQlNL?=
 =?utf-8?B?dVl0OS9ReWZncUh0b0wyV1dySjdJanYyRGN5Mm5BYU5BQi9OQ2xwOWZ6WVdO?=
 =?utf-8?B?eFZOeSs4R2MyVEVMdEJ5eDY2eC91ZVpxT0JpT2dyYXZkbHdKRllBK1pHNFJN?=
 =?utf-8?B?UHVXK215Y25CZGZJUjFoWHRPdmM1aWRWRWRpbDNYajdvVGVlcTNlcmpManEw?=
 =?utf-8?B?L2wzK2xteXZCZm9pT214V2UxRHIrT0NNOHQ5cm5MMVFQUkU5UC9UU1czTHpn?=
 =?utf-8?B?OExEdnk0TVlGRnhTQUNjZjA5eGUvREMwY3l3UU1odlVDMGwvajZyQ0JIOThu?=
 =?utf-8?B?UGV1SmZxa3RrVk9LQmFGajY4eDNmYzFVbitWVmRRc284Nkw0Y1NlVXFreGJo?=
 =?utf-8?B?TWtyd3dlbk5yRXJGRTNTQUhTZFcrMUZHcUhjNVdWcndPTU8zajBnZ0M5aHh2?=
 =?utf-8?B?MDZXV244b1VEZXNRV0JiODFOQzM2a0pFdTc4Kzg0dDBJRXRwVkpMVVh6MkY0?=
 =?utf-8?B?ZlNkYkZHRzRqTFBXVGNVZ2xoTUloeCtUb1VEQXowb1FqbVNGdUxKOFZRdjl3?=
 =?utf-8?B?d29uNmpjZENTN21aN2tRcysrVlFlTHdLdHYwZHhERDM3Mk9ld2pMTzA1SDV0?=
 =?utf-8?B?Qy9WY05mN2M4aXQ1ZUZqZVlrNXRBYXUzQ3VVUHB4VjlzendNMld4SlduNTRr?=
 =?utf-8?B?TXhkWFdMRVhwOFVaMnlZRThHT0UyaWFsM01BV2syNHZ5eVA2WG9QMS93N2hS?=
 =?utf-8?B?cWhBUEx0czdzL0Y2OGhWYlh5cmdnMWp1UEVlSVlEckRDTFoySi9aU01xK211?=
 =?utf-8?B?d08vTC85OUdTT0cwQU9wQlJrMEpVR3ZBVWZWOWhCLzZSclRuM0RPNFBHOTVo?=
 =?utf-8?B?eTRTWnVDeU5NTFF5ek1sNk5mL0xVUC9NK1NnSGt4SnlFSGxSM2xtSjM5T2tD?=
 =?utf-8?B?RzFWTWxqR0FxbVk4bGlwWGlNME9lb21Ta2NXWkpicDZBT0FqU3ViYW5Ebmk1?=
 =?utf-8?B?MTdFUjZTUVE2Y1Bvem1BR2w1Qk5xbHIzdi9MTTVkZkNqZDI3VlRQNGhxVU5M?=
 =?utf-8?B?dDlxSS9pbDhyOU5LWHVvL1ZrYmYxNUJSalR2MDRBRi8yYlhudDdVZkFRMXZL?=
 =?utf-8?Q?7PJNwH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(10070799003)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0dWNE8rc2J3RG5ZUU1XbXNBVkdyWUJzN2dUeGdRMmx5Sndqd3hrM0JXM0dr?=
 =?utf-8?B?eDhJOS9sbWxVWEcxNGhTYTBiSjZYdXVnNjBra0V0SWZXY29rczRjNE9rQy9G?=
 =?utf-8?B?eDQ3VjkvdGo0dDArQUl3QTlUYk1jejBTTEZvZ2VDR2IvdEdIblBwSnVqZjVK?=
 =?utf-8?B?QmFpWUJrTGsxRGkyTzBoWVRDTm5mWHpEUGNuSlpwTE5oOEdiT2Njd3VRSG5N?=
 =?utf-8?B?d01oWmRlSWtkemNVMFhHb25MR001NEJobzVPVEp1d1lyRXg1MlphWnRnMGRy?=
 =?utf-8?B?VXVORkp4WUxiSHNqbkNvNDh6ekRGaU56TUxkbjZ2dHk3R3c3MnlPVlBpSHlH?=
 =?utf-8?B?Z1ZtajMxZVptWG5KMEtENFV4bTBjSERtK1FxaXBid2dCYjhFcmpFV1ZnbDV5?=
 =?utf-8?B?NDZ3cDdsWXJqWGpGMU5uemI3UVZIclhSeEVJb282UjRYVDhtRVNRMnhxaEYv?=
 =?utf-8?B?Z3VQQ0RBUXVNc0VWbEVxLzBXRDlrNDVZckFTd1dNcVAwU3gvclZ4c2hsOTkx?=
 =?utf-8?B?T0RZR2FoOU5tb2I1YVM2bndHL3U5c2h6UUZjSXcrM1hmZEJpOHB6SHBmeDY2?=
 =?utf-8?B?VlkwUEk2dFdGNno3SElMVGNuMFA1WGZmQWo1eWMrMGRrQU5xRjZDYjRhQ1Fv?=
 =?utf-8?B?Z1d1dm9rT3dOZWRwby9mMVhyOW5taVpyUFgrSTQreEJzQ1o4c2RMN2VOSE1C?=
 =?utf-8?B?cS9wazFaamNvZnpFNG84YXRGUW1JWmVFUWowMXI4WmszLzVjZmI4c3lmalhR?=
 =?utf-8?B?UWJMaXA4bUh5K2IvaWlwdHpyMmR0RUhSY3RLMzhkSUxtNG5iMDdId2s2ZW5l?=
 =?utf-8?B?ZFliRkoxOUdrTWJQVDVpNXREYm9SV2tMWmdUSTNsZFhTSjA3SmpLR1RTTWFv?=
 =?utf-8?B?aEhodlpEamhmU1ViVjVSNnREU3lGVDNXaVo3QlliN0FCQXN6aWNaeUVYcDhr?=
 =?utf-8?B?R2R0R1RuNDVHTTFBMXlya3Nac0xoY0cxSFJpc2N3SldDSTBWY2VXbXQvTElC?=
 =?utf-8?B?MFoyZ2k2cGQzRFJ1MU9BOVNEbGowdjNzM2VndkhVdGd2bk9ZUmdFaVpFR2tI?=
 =?utf-8?B?K0t1M3VLRjFSczF2RWNKVGNPbVlMeUhmQ2hKdlc0SHR0ZGFobTJHeXBTSU9W?=
 =?utf-8?B?RVdISm50K3EwbjVsTTV5aEdYUmhPWDVTVnZnaW5aRE1Cd2c3ZnVzQTJvQVBu?=
 =?utf-8?B?dWY4TzlCbkFaQnUzTmJuSGxHZm9LM3NMcnFPRUlOOGQxay9ZMVlXajdjVGNB?=
 =?utf-8?B?MXNzWEF0YjFPcEFHdWpYUnU1cXp1bGI5NzV0YjRsOFVuTWN4K1FpWDJYdlpU?=
 =?utf-8?B?UU1oTGp1clM0T0VpbGZpQnpFblh4OWVtTmNicnZiKzNMdVdaeFNaQ3JOMFpT?=
 =?utf-8?B?Z2MyOVVxVVlCNTRMUG1EZU9mdjhrU1dLRTN6Qk9pVDFRS3c2QytZSlNSNlZ3?=
 =?utf-8?B?Njd4MWF2eHMrdldkQ1NEeE5vb2FaUHA1VEpSTXkrbFcxWGRQTVlMbjFKRTR1?=
 =?utf-8?B?ZHJnMEF5R05WcXBNU0d3ak9NWnkwdXd2TEd3UC9ldkRrNmpmdnc0dVlVaWFw?=
 =?utf-8?B?N24zeGVQbjh6bXozWFVsWUs3WGptaWpHSytndGNSZGM0RWlxZDFLTFo0QVhz?=
 =?utf-8?B?SFpqbGszYWNnMmY4bGR1UEI5SFpBakRLL0VvTVBURlp5Tk1qWjQ1MldHVXVp?=
 =?utf-8?B?TExkUStiWW1vSU1TRldVZ2ZBdHF3THl2U1JoWGZNRDFtajlueTZsR2tSaC9s?=
 =?utf-8?B?bHhtTnhkMjZISm1KQlJmQWUyZGRWTFg2azAwV1pWREMvVEJEWGx1WEJwSlBH?=
 =?utf-8?B?YTAzRllISmg1dGxWNXo4ZVVyenI0bHUvUjUxZHpwc2pGUGVLU21HSmNCekU5?=
 =?utf-8?B?TWw2MFFCL2tGN0d0eWtRbmwwQlE5dmVRblFoZllvSVdzdXMxUzRob2NTMVd0?=
 =?utf-8?B?RW5iVEZuSnk4amtocUJZNXFOOVZXV1EzaXArY0VpSkRGaUlvQXJibldaUWhH?=
 =?utf-8?B?Q0w3SDBUd3dEcDF2S1BPQm9JWDMySXFXMmNva1FCaHFTVUtTc0k1b2lKaWRn?=
 =?utf-8?B?R0tSZWptZGJYRko5cWE2LzZqc0ZqZkpYQy9LdHl3amY0eWtueU83SjgrTjhR?=
 =?utf-8?B?SG5zdVArTUtkMTY4V0txT3lkNzJHVmNTV2x3blMvVTdkbTZFZUhwNzltQVQy?=
 =?utf-8?Q?5M++tqPW+dLSax5YgV1s58w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41DCB2808EF32C42AC4D45278E750D23@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oU0j4T/r+J8zv3qNt4qBKWsDOR23MJwIufHTf70aFdV+CVM0kR1sKg8JvxvBH1FsklOurqnYFA9s6hgtzxHKBQzjRlARtGx/KfnJvShPMpHe7A7feUfRiFDwd5yYjvpXp0dAip2mwL77O2xIIXXjBLzgfgjefqphWoaiMYZc3BbslMCsvh8+eQmuh7s4ATNAqWbUCR6hH1a1MFOfFtd/JUES8SaJUB40uOfG2/WSgRz2YREFk6a8mNNzrghNaPiMK/qpnnAvglS7eW9crT/RoOLiaeI/hcHhAD/2AR7gzUYllCSFdbPujDTftaPKnyfUM4EMcVfSIkCSjcneUAiuV/5rVQ1tP3VolXBNZZnUQBn50M9hPRzT5nzJ8tKAn1u93uuhZtEzsEMz1PFgA8+3aOvfq8yfcBJ3TUG6Wbv3Lv3GfGzMNRW40o6RvPvj4YO400oFpohATIII60ZvvdaUdM3EtWAZhzqAHkbkgPdUz3CrMjsYz3nYl5Gfr4lK0TgpGTt4/2Md/Q0X4mYaFZrtsfkuL6O01KZCq3CaSjMBT1cHVZjVbsLwf9As5o8Wsr7yMqLdeUCHkk3qqg7oIYJ9YZ2ag5XRYYGRvRR0wrwvgesrkyyLYy/FQ90XkBvFhv61naaZiCpURxePeFRyJIA/QA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509b036e-ff63-4337-285c-08de0ca7d40b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 11:33:28.9701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Gk0CmWFLUEny8nqGZvkCFI5LmEmOek8pjqKXL/dZs9wB/cTvIiqLpygQC0K8SbXnzW6r8akBJT/iOpXaP/nqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR19MB5746
X-BESS-ID: 1760614411-103239-8510-1488-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.48.137
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobG5qZAVgZQ0CDZ0DLVMjHJIC
	k5KckyJdncJNnMPNUy1TDFxNLMxDBVqTYWAPwdCR1BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268248 [from 
	cloudscan8-84.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gMTAvMTYvMjUgMDE6NDksIEpvYW5uZSBLb29uZyB3cm90ZToNCj4+IEBAIC05ODMsNiArMTAz
MSwxMCBAQCBzdGF0aWMgdm9pZCBmdXNlX3VyaW5nX2RvX3JlZ2lzdGVyKHN0cnVjdCBmdXNlX3Jp
bmdfZW50ICplbnQsDQo+PiAgICAgICAgIHN0cnVjdCBmdXNlX3JpbmcgKnJpbmcgPSBxdWV1ZS0+
cmluZzsNCj4+ICAgICAgICAgc3RydWN0IGZ1c2VfY29ubiAqZmMgPSByaW5nLT5mYzsNCj4+ICAg
ICAgICAgc3RydWN0IGZ1c2VfaXF1ZXVlICpmaXEgPSAmZmMtPmlxOw0KPj4gKyAgICAgICBpbnQg
bm9kZSA9IGNwdV90b19ub2RlKHF1ZXVlLT5xaWQpOw0KPiANCj4gQW0gSSByZWFkaW5nIHRoZSBj
b3JyZWN0IHZlcnNpb24gb2YgdGhlIGxpYmZ1c2UgaW1wbGVtZW50YXRpb24gaW4gWzFdPw0KPiBB
cyBJIHVuZGVyc3RhbmQgaXQsIHRoZSBsaWJmdXNlIGltcGxlbWVudGF0aW9uIHNldHMgcXVldWUt
PnFpZA0KPiBzZXF1ZW50aWFsbHkgbm8gbWF0dGVyIHRoZSB1c2VyLXNwZWNpZmllZCBjcHUtc2V0
IFsyXSwgYnV0IHRoZSBxaWQgaXMNCj4gdXNlZCBhcyB0aGUgY3B1IGlkLCBhbmQgd2UgZ2V0IHRo
ZSBudW1hIG5vZGUgZnJvbSB0aGF0LiBNeQ0KPiB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgaW4gcHJh
Y3RpY2UsIHNlcXVlbnRpYWwgQ1BVIG51bWJlcmluZyBvZnRlbg0KPiBmb2xsb3dzIE5VTUEgdG9w
b2xvZ3kgKGVnIE5VTUEgbm9kZTAgY3B1czogMC0xNSwgMzItNDc7IE5VTUEgbm9kZTENCj4gY3B1
czogMTYtMzEpLCBzbyBpdCBzZWVtcyBsaWtlIHRoaXMgaGFzIGEgaGlnaCBjaGFuY2Ugb2YgYmVp
bmcgYWxsIG9uDQo+IHRoZSBzYW1lIG51bWEgbm9kZT8gT3IgYW0gSSBtaXNzaW5nIHNvbWV0aGlu
ZyBoZXJlPw0KDQpZZWFoLCBzb3JyeSBhYm91dCB0aGlzLiBUaGUgdGVzdHMgaGFkbid0IGJlZW4g
YnVzdGVkLCBidXQgSSBoYWQganVzdA0KZm9yZ290dGVuIHRvIHB1c2ggdGhlIGJyYW5jaCB1cGRh
dGUgSSBoYWQgbG9jYWxseS4gV2VsbCwgYWN0dWFsbHkgdGhlcmUNCndhcyBhbm90aGVyIGlzc3Vl
IGluIGZ1c2VfY3JlYXRlX2NwdV9zZXQoKSwgaS5lLiB3aGVuIGdpdmluZyBzb21ldGhpbmcNCmxp
a2UgJy1vIGlvX3VyaW5nX25yX3FzPTgnIGl0IHdhcyBub3QgY29ycmVjdGx5IGRpc3RyaWJ1dGlu
ZyBhY3Jvc3MgbnVtYQ0Kbm9kZXMsIHdoaWNoIGlzIHdoeSBJIGhhZCB0byBzZWxlY3QgY3B1cyBt
YW51YWxseSBmb3Igc29tZSB0ZXN0cy4gVGhhdA0KMm5kIGlzc3VlIGhhZCBob2xkIG1lIG9mZiB0
byBwdWJsaXNoIHRoZSBjaGFuZ2VzLiBTaG91bGQgYmUgYWxsIGZpeGVkDQpub3cgYW5kIGl0IHB1
c2hlZC4NCg0KaHR0cHM6Ly9naXRodWIuY29tL2JzYmVybmQvbGliZnVzZS90cmVlL3VyaW5nLXJl
ZHVjZS1uci1xdWV1ZXMNCg0KDQpUaGFua3MsDQpCZXJuZA0K

