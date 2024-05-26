Return-Path: <linux-fsdevel+bounces-20191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A31F8CF68A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 00:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31251F21772
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2024 22:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8838013A257;
	Sun, 26 May 2024 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="ZMCmjYmB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2117.outbound.protection.outlook.com [40.107.93.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC78333F6;
	Sun, 26 May 2024 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716762765; cv=fail; b=XklnbMxrAaLGEzZ+Z1783WSGBUxScUymXHjjUNPsyK0Sq/OrpuuuHt0pMKGySj/Qbkl0o/PYcJpyUApjvqF/qVtF80YryHkwNGSgyldcnYlQfeNHK+RK5d28dnhjbyfG3jVgL79uibb30C6cmxPeQSbegahouqp1oM1aFfjt094=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716762765; c=relaxed/simple;
	bh=Aj4+WHvXaoRjXkjD3gW/hS5lWO0CcvO0IM5jrY1vLp4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BQhR/42CJzv4Rv/bJO2MQqToDIxzQE9Wohl+r1Y6sj7VfQ+fP/oNCDBxz6FZC1pF6zMXdAjBZfBiO+H/3vEEtJMLXwikpUyxgJ+tTW71EjeUkA+pGEro8SzezPIRtHJuuu5Q2ufBFCQ1RwX69hbNDGt8rS7FA4vskIbHWhwb+Js=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=ZMCmjYmB; arc=fail smtp.client-ip=40.107.93.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PV6DPZPfkd8diOMbJbBVJJtQNQ8cN6579TyP8Ps4yQ1BSBTWc9Yb1/lUINwyCRXT5h/5iSLdXyMZ4wFuwEcZ7Pd9Napi0YexwsHjGg5GsjlL5Ksmg5TrMpLF3cpchR9ss7Et/2uRV3D7JX5ioeKOLtplrB6/EN9XMoN54CHiWndWOp8NxOlibwGZVIS5n9TvsiuCG935bTWZpLZkPD1lBTnL9M7QRrLngQQgT1lRSxNiaGvfoPc7N8sSrTzGCcF4mf/DjTKTk35I+IuKhlclR2hNVs3kORBlWKfpYkwKDePY4TnonBf0uNXHZpcmn+MWSuf6GOGnL07eo9DlXnLcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aj4+WHvXaoRjXkjD3gW/hS5lWO0CcvO0IM5jrY1vLp4=;
 b=MPkrjp3Ql2HpVbJuQsM7JPPGHxus0/cOfYE/8vLZx8YBcMTGNQJYe7Ak0VZNSye8fD1Sw8kdVRFL9UpuAdWv6GNKckNOqz6Cm15DHV72eYgowVme8/L+d0Q/zYYbvhCFFCm42fD+GeKI3xlfwXamu4xpbYIqV2k+5npYH5sM5c2KLySJN3LzBixX05KTfhykOJKgpJiSU9Vt3mapj+9+wrRpxNKImvd2RKhYcM9qnlxt0bJXnVRvOlrWKd7Jhk3pBYJY/A21j5j2XFANyOrGbx2Z4x3P9/YkrVPqE79zBI2BTukpDBXu9tJaFyf3jLFN9MTG0yA34l7kjVfXBlNaRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aj4+WHvXaoRjXkjD3gW/hS5lWO0CcvO0IM5jrY1vLp4=;
 b=ZMCmjYmBt8M9V71OUAVlLnwkwSeXGla4WZFlepCe5XWt3NbFqW799dM54iu6O1z1J4lE/idEv9D6YBjmCS4MZi9lSsS6/GZNDowdqYd7mAdAZLQY7V5pBmI3KOimehFNaGdDiiqQEOI2ddydPjhdX5dbrwYSwUjhVg9ex6sSNx4=
Received: from DM8PR13MB5079.namprd13.prod.outlook.com (2603:10b6:8:22::9) by
 DM6PR13MB3772.namprd13.prod.outlook.com (2603:10b6:5:248::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.16; Sun, 26 May 2024 22:32:39 +0000
Received: from DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871]) by DM8PR13MB5079.namprd13.prod.outlook.com
 ([fe80::3312:9d7:60a8:e871%6]) with mapi id 15.20.7633.001; Sun, 26 May 2024
 22:32:39 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "cyphar@cyphar.com" <cyphar@cyphar.com>, "hch@infradead.org"
	<hch@infradead.org>
CC: "jack@suse.cz" <jack@suse.cz>, "brauner@kernel.org" <brauner@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>, "alex.aring@gmail.com"
	<alex.aring@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"amir73il@gmail.com" <amir73il@gmail.com>, "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Thread-Topic: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Thread-Index: AQHarVPtSe6qdv/lgk2vl1eWJoqLMLGpQqoAgADb5wA=
Date: Sun, 26 May 2024 22:32:39 +0000
Message-ID: <30137c868039a3ae17f4ae74d07383099bfa4db8.camel@hammerspace.com>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
	 <ZlMADupKkN0ITgG5@infradead.org>
In-Reply-To: <ZlMADupKkN0ITgG5@infradead.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR13MB5079:EE_|DM6PR13MB3772:EE_
x-ms-office365-filtering-correlation-id: 5d3a1fbf-daf8-472d-4476-08dc7dd3c05e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|7416005|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?UStPbzlWRmhZMFZmdkZiaFcyY0haZStSUjFjRGRyY2NBN3drdVFuUGlSckxj?=
 =?utf-8?B?eisrWmE5amNMcnBxeDdzNERXcEc0VHIvSjVGNlFvckx0NXRhVGdyOXF3QXUw?=
 =?utf-8?B?QjgzR1l1eUh1NVZvczhpVEcvamttall3QUZFQk5NRSttNUFNUUpUUG9VSnlX?=
 =?utf-8?B?bEFmeTVlZG8vSVI1TDdBRG50SjVRQTNmY1gzQnQ5TzMya1NCS2t6ZGhreW8y?=
 =?utf-8?B?Z0ZTS3QzZzZXRTQybk5YU0R1RmdRdjhEOUh3Q3ZHUWQ5bS9JYVJMNDFaRDFK?=
 =?utf-8?B?RDhNV0l1VnlTbzlTdjI2OHNGY0twSSszS0YrbGppeVk1NFV0eXhCOExJK2ts?=
 =?utf-8?B?SWRzN1hidS9xSGhTcjB6RFQzTStNOENUTnBrT2ZFYjl5SWFiMk80WGhOV01r?=
 =?utf-8?B?bmErWkx0Rk4rNWdXY2xCNHowN25idERUb3UzRHZUc1Nnc3Z1cHFCTVEwYkRB?=
 =?utf-8?B?Z2xaNk92cEFpSHZ0aG02Qm1jUW11Sy9zRDhCU0J0clo1UFJ6TVVwYXU0NnNt?=
 =?utf-8?B?ZzV5R053MFNhdmhtQ3lxZlpIblNMY0ZqWTRpTjc4d2FmTVo1aVNIdHR6blRP?=
 =?utf-8?B?bzhuR0ZIZ2VSMW5xbXFHYzBndUNOcVNaVjdOWEswTDJnbGVwNTRHK2xkUjNn?=
 =?utf-8?B?bzRaRGE1cE12cDNJU3BKbDRCRG43cFpIYkl6VW5Yd2xVWUFadGpSeWpnbnFO?=
 =?utf-8?B?QTBxOW12SE0rKzJ6WXZLaDNZYTQvVHdDVUluR3dLRm5kRDFqMTlMN2t6TWJ0?=
 =?utf-8?B?K2ZHTmlHN2hpTi9TNEFRUjJYRDFDOFM5MnllVFV3dmpDM01vTGJEVzNYZHA0?=
 =?utf-8?B?ZlZ6b3ZwQ2hlbTF6eFpJQnNrbEJFelJQdS9tQUR1V3hxQzRLdnZacC9LNlBR?=
 =?utf-8?B?aXhhWnZ6NEJFUDl6ejRJK1RLWUJoVXR3RUFVUGVHVmFqVDNGNml0WjFmd3NX?=
 =?utf-8?B?TE5TZE16SjZBNTVhS09NVkw0MnFaTGNmblJmelg3RFM0ZXRyN2s0ZDhFSmRX?=
 =?utf-8?B?aVpIb1dyZUZDTUcybGNMMDFOM1JnYWFvMkNrNEVwRXRNNlZnWStaQzNsSUt5?=
 =?utf-8?B?Slh5aGVPWjhrWmNPZEFSTG40b0t3Z1VBYnpGUmVEYVBwWUo1NFlLVmtUM3o4?=
 =?utf-8?B?dndqK3c3b015bFNUOFJPSFJlSEVCOFJhQmg0emxMSjd1UzZhaFlaQm8raEpH?=
 =?utf-8?B?WXVkSkxBVEZWVmVQaHU5a1VaN3UwaGFkV1JzNkVsRHlRWWtoOFdIdG5kcG9O?=
 =?utf-8?B?bjBUUnlKekZZNGErcDRxRlJlSGxoSVNTOHVEOFFFcEM3TnVPM1pKWEpTTWg1?=
 =?utf-8?B?U0JYNGkyY0h1UFpmemdXMktPWnJNUTEvb0l1czMveHRFZ1dpTDMxRUNFTFJw?=
 =?utf-8?B?RVZKZTAwMkdySFppT0NXMDA2Y1RCM3d5VDZsLzNHY1FuQkZrcytYMDVkbGZG?=
 =?utf-8?B?QVo3dDlZOGNNa2g5dlJmWE40UTFDM3hac3ZzVjNjYXA2MVRIazNwRS95NkRK?=
 =?utf-8?B?L1ZlbFQzNkEzeHIrK2VYQ3RRQXBWdGJka09kemwwMk5sR3NQTVpNOU9nc01X?=
 =?utf-8?B?TjY0clJEalM1NWI0UzBVNENqckFsWHlsSWFpcUpXRWNGdjFGbkJ3eGZING5F?=
 =?utf-8?B?dWJoWC82N2daMm82TkV4dkdOWWJ2RnBuOEYrT0Z4a296ZnJhb2psQzQ0aGJT?=
 =?utf-8?B?aWlKdTRhditqT2pFR2dianhLdVRNTnRxbU9JcnpZMkJjZnhyWlA4SmpDK0hV?=
 =?utf-8?B?OXl3MXVOOUxWc1E4QTYxMkpwSjAyWW12eEVjWkplZUR3OU5hc1M4N0lYdDFJ?=
 =?utf-8?B?VTFaTk1KRExCb1YzSFN6UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR13MB5079.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWRPenFIblRuTDZvV1FOdlY5L3FwbVlXYjRBOSthcEJmU3ZmS011UHpTTTY3?=
 =?utf-8?B?VnJWdll6aGhGVFkyZzNmcHdoVGR6M0hPVk5CbjdONVp5bWl1aFVJNnc0QnN4?=
 =?utf-8?B?M3krUHduTEV0TUJFSmh4Mkh4alMvejlCNzdCR3k1eFZpYTAxKzFvOUNVc1pM?=
 =?utf-8?B?OER3YXZTeExZZ3VEMFhHMVFUSis1TG9sWU1GSmY0RXIxdnVQZlJsK3BuTzFj?=
 =?utf-8?B?bnY4eVdnUzE5ZFlGSklnU1Z4NVpWanJIdjROK0pHb0RCVWRvSjdya2Zwdjcw?=
 =?utf-8?B?UTY1ajgzRVpMRDAxME5PTlhabzlXWTJKVDFtQmNwakxBSHE0cVZNV0N0L1la?=
 =?utf-8?B?cUpZejR4MTE0WUNKWE5GQjVoVmFicnNnakFrYlpoeFN3cEVnaDQ1clYvQ1VC?=
 =?utf-8?B?RjRxODE5bUJGMlg0a3l1MjVpcUh5SFZha2ZmSHZoQzJSb0Z0L2NJTjVmNW11?=
 =?utf-8?B?cy9wZS9LVC96dm9LbkN4TkJNR2dLOW9kd042SElTaGhiYityOUFMTGE1Y0Ra?=
 =?utf-8?B?OWtTb3hXY2NNRzlQVTUvUjRCajYwbVJYZUI5UVdvVmhLN2hLMWtaaTFzWmNU?=
 =?utf-8?B?dkdiem9iWWd1M0JGM3V2MGN2NUNHYTdCVytOMVU2akZqM044OUFiajY2TkRU?=
 =?utf-8?B?Vk80c284Q3RSMEJ3YlF5bnptN1BTQXJUaXk5UzR3M1pkTS9yV3RackVtRjRw?=
 =?utf-8?B?OTZ1eUcwM2pISmJWU0ZVK1dwc3p1TUJwa0hEeThwQUJQMlA0azVpVXYvZ2FD?=
 =?utf-8?B?T2Q5MEJTbXZOWm5iblo3OVhBdXB1TEdtU1F0QVNIQjRnQ0YrNG5BOXBDZng4?=
 =?utf-8?B?NWZ6dEptQ0JTUlNVUWMrSnh3NkFjU0RLb25vaDJLZDRrQVJkSE9oY2FmcTg4?=
 =?utf-8?B?UVFuM3Mzam02ZjdRWUI0aWVETndzdFc5ZlErbmlzam9ZVDZGY3krQkRYcFcw?=
 =?utf-8?B?bG5XbmJXaUxmL2NoZThFYkRXMDRJWmFnRzFQSzkvQlVQVzF2K2tYaWlJVEcy?=
 =?utf-8?B?eTBVRUoydHBKUGlTUXcwVERpOVIveFlQVEM5WGNnd3Nwd1ZreWlHb3JxSTRq?=
 =?utf-8?B?N1ZWcC9selN1SDFuN1hKNkZBdi8xeHhzRGdVNk9ZM1l4VVA5YWxBbVpFenk1?=
 =?utf-8?B?UjN0L3Qzd1FhMzRXNDZrS2VsOTBwekU4UzVHSDYwL0d5VVczSlIweEczS0lO?=
 =?utf-8?B?OFFtYXlmTjRUQ1JFTXM1RjBYZnN1TFhXZTUzNE1lcGlSTEVRN3htbzlBNWha?=
 =?utf-8?B?TVYxaG5FWnhQTlNSMENUNTZ4L1hLK0U1QlBwV1JFSUx0amtTQlFCSlcrZWky?=
 =?utf-8?B?YjlnYWNEWjM3LzBKRmhQekUwWHZNdFplUTJ0T20zRkpHRWs1eEt6cVdCTElU?=
 =?utf-8?B?dkVOMTV2Y3FvVjhzMms4NEJkaDkwU0tmcnU1bmM2M3p2a3kvZXg1N1MraHhu?=
 =?utf-8?B?eCtEektLbHVGK29oZll4VXptRHNIa254RVNnaklJN1dSdlVnanozT2VtZlY3?=
 =?utf-8?B?WEdQWnVjRG5yMUZYdll4aHlpSFlQcWxpWkpqNEUyM3FZTlVDRWpnVHZSTXNa?=
 =?utf-8?B?Ykd4TFI0aGhBa3dhWHZBNE5Od3BEaDlUV3dsTGx3TitmYzNwNXlEVDk4Ly9n?=
 =?utf-8?B?b3ZucHpPN3d0TlV3WWJvMFRpcVd4bWVyTDhmbEZhMEtDSEdjaG5Rd1dVejNH?=
 =?utf-8?B?dmhRUXFKakdzb1NFTnhCSTYvbU5sY2tpc1kxTWdKS25waGM0L092cE1Qblhh?=
 =?utf-8?B?Qk9TeFU4SjJybjFoMTdvdlFRcUVYa3pJNHpYcmJpb2cwMWlTeUN3Y3UxOVNO?=
 =?utf-8?B?TUpXUTVSbEJtKzFya3dubXlwTlFmbGdOcVRxSE5Semh1TmQxK2lnV0xoSjJx?=
 =?utf-8?B?RFp2OFZnRkNhM0d0M1RpRGRjTEVZY3VjUThJQzl1Qmw5dnFPVFJoNFptQzlm?=
 =?utf-8?B?dnl6RkZnVGJkckgzQ0xRUHg1N3hNT212OC95Y0JXS2NteGdYMllSWXVoU0xT?=
 =?utf-8?B?RUF0RllzNVZGTWU2TFV1djZGdko3YVR0ZzF0Y1IxVWpPVGhzWWc5WDdBd1Uz?=
 =?utf-8?B?TjBJK1J0YVQ0ejQ2NlAxL25UTElIbXhXVXdIaVZ1OFozbzhlVGpKMUwxK3E2?=
 =?utf-8?B?OTlrUGd2M0phdWluV1FGaVhDU1Ezcjd6YkxOQUpqaHp1Ni81WTdWWGZDdHh0?=
 =?utf-8?B?VVNlVG43NWY3eUFVYlVwYTM4MnNKN0dOZ1JhME13UUtIMzMrZjBGVFlrdWZm?=
 =?utf-8?B?emFBM1pvYXFldjE0bG5yeWk5QzlRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8191549F3A7C3F45AA4DF3E9115ECC4D@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR13MB5079.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3a1fbf-daf8-472d-4476-08dc7dd3c05e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2024 22:32:39.8152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVp2TFvXloXmcqGVdPlU3YewXxwbJ0wWQWT0D2DmzjrHk/cndZp+j/BPEKu4CO8Xz9aFVkGUP0WfKBBQXwnRQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB3772

T24gU3VuLCAyMDI0LTA1LTI2IGF0IDAyOjI1IC0wNzAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gVGh1LCBNYXkgMjMsIDIwMjQgYXQgMDE6NTc6MzJQTSAtMDcwMCwgQWxla3NhIFNh
cmFpIHdyb3RlOg0KPiA+IE5vdyB0aGF0IHdlIHByb3ZpZGUgYSB1bmlxdWUgNjQtYml0IG1vdW50
IElEIGludGVyZmFjZSBpbiBzdGF0eCwgd2UNCj4gPiBjYW4NCj4gPiBub3cgcHJvdmlkZSBhIHJh
Y2UtZnJlZSB3YXkgZm9yIG5hbWVfdG9faGFuZGxlX2F0KDIpIHRvIHByb3ZpZGUgYQ0KPiA+IGZp
bGUNCj4gPiBoYW5kbGUgYW5kIGNvcnJlc3BvbmRpbmcgbW91bnQgd2l0aG91dCBuZWVkaW5nIHRv
IHdvcnJ5IGFib3V0DQo+ID4gcmFjaW5nDQo+ID4gd2l0aCAvcHJvYy9tb3VudGluZm8gcGFyc2lu
Zy4NCj4gDQo+IGZpbGUgaGFuZGxlcyBhcmUgbm90IHRpZWQgdG8gbW91bnRzLCB0aGV5IGFyZSB0
aWVkIHRvIHN1cGVyX2Jsb2NrcywNCj4gYW5kIHRoZXkgY2FuIHN1cnZpdmUgcmVib290cyBvciAo
bGVzcyByZWxldmFudCkgcmVtb3VudHMuwqAgVGhpcyB0aHVzDQo+IHNlZW1zIGxpa2UgYSB2ZXJ5
IGNvbmZ1c2luZyBpZiBub3Qgd3JvbmcgaW50ZXJmYWNlcy4NCg0KSSBhc3N1bWUgdGhlIHJlYXNv
biBpcyB0byBnaXZlIHRoZSBjYWxsZXIgYSByYWNlIGZyZWUgd2F5IHRvIGZpZ3VyZSBvdXQNCndo
aWNoIHN1Ym1vdW50IHRoZSBwYXRoIHJlc29sdmVzIHRvLiBUaGUgcHJvYmxlbSBpcyB0aGF0IG5v
dGhpbmcgc3RvcHMNCmFub3RoZXIgcHJvY2VzcyBmcm9tIGNhbGxpbmcgdW1vdW50KCkgYmVmb3Jl
IHlvdSdyZSBkb25lIHBhcnNpbmcNCi9wcm9jL21vdW50aW5mbyBhbmQgaGF2ZSByZXNvbHZlZCB0
aGUgbW91bnQgaWQuDQoNCklmIHdlJ3JlIGxvb2tpbmcgdG8gY2hhbmdlIHRoZSBBUEksIHRoZW4g
cGVyaGFwcyByZXR1cm5pbmcgYSBmaWxlDQpkZXNjcmlwdG9yIG1pZ2h0IGJlIGEgYmV0dGVyIGFs
dGVybmF0aXZlPw0KTW9zdCB1c2VybGFuZCBORlMgc2VydmVycyBhcmUgaW4gYW55IGNhc2UgZ29p
bmcgdG8gZm9sbG93IHVwIG9idGFpbmluZw0KdGhlIGZpbGVoYW5kbGUgd2l0aCBhIHN0YXQoKSBv
ciBldmVuIGEgZnVsbCBibG93biBvcGVuKCkgaW4gb3JkZXIgdG8NCmdldCBmaWxlIGF0dHJpYnV0
ZXMsIHNldCB1cCBmaWxlIHN0YXRlLCBldGMuIEJ5IHJldHVybmluZyBhbiBvcGVuIGZpbGUNCmRl
c2NyaXB0b3IgdG8gdGhlIHJlc29sdmVkIGZpbGUgKGV2ZW4gaWYgaXQgaXMgb25seSBhbiBPX1BB
VEgNCmRlc2NyaXB0b3IpIHdlIGNvdWxkIGFjY2VsZXJhdGUgdGhvc2Ugb3BlcmF0aW9ucyBpbiBh
ZGRpdGlvbiB0byBzb2x2aW5nDQp0aGUgdW1vdW50KCkgcmFjZS4NCg0KQWx0ZXJuYXRpdmVseSwg
anVzdCByZW1vdmUgdGhlIHBhdGggYXJndW1lbnQgYWx0b2dldGhlciwgYW5kIHJlcXVpcmUNCnRo
ZSBkZXNjcmlwdG9yIGFyZ3VtZW50IHRvIGJlIGFuIE9fUEFUSCBvciByZWd1bGFyIG9wZW4gZmls
ZSBkZXNjcmlwdG9yDQp0aGF0IHJlc29sdmVzIHRvIHRoZSBmaWxlIHdlIHdhbnQgdG8gZ2V0IGEg
ZmlsZWhhbmRsZSBmb3IuIEhvd2V2ZXIgdGhpcw0Kd291bGQgcmVxdWlyZSBhIHVzZXJsYW5kIE5G
UyBzZXJ2ZXIgdG8gZ2VuZXJhbGx5IGRvIGENCm9wZW5fYnlfaGFuZGxlX2F0KCkgdG8gcmVzb2x2
ZSB0aGUgcGFyZW50IGRpcmVjdG9yeSBoYW5kbGUsIHRoZW4gZG8gYW4NCm9wZW5hdChPX1BBVEgp
IHRvIGdldCB0aGUgZmlsZSB0byBsb29rIHVwLCBiZWZvcmUgYmVpbmcgYWJsZSB0byBjYWxsDQp0
aGUgbmFtZV90b19oYW5kbGVfYXQoKSByZXBsYWNlbWVudC4NCmkuZS4gdGhlcmUgd291bGQgYmUg
MSBleHRyYSBzeXNjYWxsLg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVu
dCBtYWludGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNv
bQ0KDQoNCg==

