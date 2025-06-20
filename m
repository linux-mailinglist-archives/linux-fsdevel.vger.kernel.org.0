Return-Path: <linux-fsdevel+bounces-52343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6D8AE21C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 20:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E22B1C247DA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 18:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8A32E8E1D;
	Fri, 20 Jun 2025 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WKfyt295"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AB530E830
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750443028; cv=fail; b=TuUlQtgBq0p3xSBC5PPdahml9psz+NkD+3cqEyvPhBwTtvteAJkqYiNOaat4W1kpLRITshHyB0N1tsys7zuUcTCYKSNRK+rbcUJ61euudZAB9hRJ9zI9d8FzcDhUn7cCV0NSmu/mbGCz1KD3FE+tRyZV+smUFO/ihxd37WYkq2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750443028; c=relaxed/simple;
	bh=PuYy8wGywti/qsZl2vDugxvj/P+Xi4yPRHyKJqCm0fI=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=f70rDgjfvQFU77s19wfnW1dokXMNfBa9d88wWRmB0wUmvk4xq5Ipnvq1R+sJDAaIQfMxn4+SetSueEH1l2mPPpqT6HH7JRH6RnimQ3fMNgYlyHhxzyTLfeiWnd4NGoMlsrRJtVlDPC7D+5rmsShUD6qKP1QvqVFOPWW4IvoVjwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WKfyt295; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55KCAYfo004617
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 18:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=BX/WlEz6MiidoZKguILOtrhoJKciNIgprh331dPSohk=; b=WKfyt295
	BxZAYf4nBz85xTynVnybyrMf4h3yUKWZ+VzqLJCFFpqL420ll+IHqp0LYLDT+qTv
	OoFV84XGzSnVdh0wlS5mheNtGHSiiz/2xtfnCboItwz/hPA8v3OoKBzJXrRwGdH/
	3D+ITf4gzb0xU6Qx49Oo/Wm2gwsWrxc7hgxIx98+Rm1ASUjloFgK4bYnQy14K0La
	nhBGUIVPdu01dHXbfCDp06cuRIFoI+J8SfKyjtdtCFBWWwXv0bfyStDlwtLKYcMW
	4ezp9gDM81c8cJ+G/O+JPcJWQX0thhxvXXm5MW8R9PrkvdWxeQr1BdBofmtvKr+m
	RVRJEw0lV6gqFg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47cy4jvc8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 18:10:26 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55KHlrBL018923
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 18:10:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47cy4jvc8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 18:10:25 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55KI5cxj021690;
	Fri, 20 Jun 2025 18:10:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47cy4jvc8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 18:10:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nptk3o8My8P2l1QkZQE9HE0AJ0xjTxcEXyemgMkiD5tGGaL3adD7jp3EY0UdklpvqrWnFcyfALJhH4zoSsmL5vvs4Nhc06ZMi8FkIrrh3/uJYm3pS74sddIJG9aAqkKWaam5TF8fhipTpCNAEym/Ly5scJuiTzchNrmMJIrRjM8tyKcwmSDEW3hvicHFzFsdwTUFfE7zgkYFwk4zxROZIZ3KcZCqyru9XfzU+e0jncejbMh0Pb1ZhJgV1DBXO0ezq80TgKmvkQJjvRGrGwVAEpwmkh/EwJB5bvYm2Hq4ZI7v5V9fbQnIoYdBs6kJSMoTCY7lzezt0IMWKFQo3ERx2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKIeRNn7g801sWzWSjzXcZP6zMqgyH/epm7qp+grRXM=;
 b=wb/I+6NxuDr0GRBVoW8POlX5d3/U/zIxBcSB9dGeNZkRk+WfO/Cm8tARLK7Os4oDnP+OcgTnR7fLWNUEZddLcGghrTPQ2pb6iZCrilM9anvnRyre9V+sbt9cNvHjCm/NILxQd9SzjfpfaQUw2OLUYOJqmMTIiOOUvyTp6RkhioNI+istS9dQhF5SNUa+584T9SFbpDQ860uR4am04YzY6zQarsXPCQQU7H0XPWGU0uwMQ8XK2lwil1kz2PHaskG1uu0SCaN9Qe48mW2a26pXxWQYRWG7uo2fgwk+i0+70j3HQ7jNxn2xa4DYMZNiWAzAv3QI27g1Qgz2zQa1HnM1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA6PR15MB6738.namprd15.prod.outlook.com (2603:10b6:806:41c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Fri, 20 Jun
 2025 18:10:20 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8835.027; Fri, 20 Jun 2025
 18:10:20 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "miguel.ojeda.sandonis@gmail.com" <miguel.ojeda.sandonis@gmail.com>
CC: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "lossin@kernel.org" <lossin@kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC] Should we consider to re-write HFS/HFS+ in
 Rust?
Thread-Index:
 AQHbz2CpCY7FD08WfUuZLsiXLlP+iLPn/LoAgAA8YoCAIsotAIAADccAgAAYGYCAAK+hgIAApZ6A
Date: Fri, 20 Jun 2025 18:10:20 +0000
Message-ID: <dc52fb4df4f1a54ece43c27245606b80c2b75ded.camel@ibm.com>
References: <d5ea8adb198eb6b6d2f6accaf044b543631f7a72.camel@ibm.com>
	 <4fce1d92-4b49-413d-9ed1-c29eda0753fd@vivo.com>
	 <1ab023f2e9822926ed63f79c7ad4b0fed4b5a717.camel@ibm.com>
	 <DAQREKHTS45A.98MH00SWH3PU@kernel.org>
	 <CANiq72k5SensLERt3PkyDfDWiQsds_3GpS4nQqPPPMVSiWwSfg@mail.gmail.com>
	 <c212d2e1ca41fa0f2e4bc7c6d9fe0186ca5e839e.camel@ibm.com>
	 <CANiq72nF+Hn-vPttAYDEjRvKa+-C=pGkkAKjMQmWB78Afq4HBg@mail.gmail.com>
In-Reply-To:
 <CANiq72nF+Hn-vPttAYDEjRvKa+-C=pGkkAKjMQmWB78Afq4HBg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA6PR15MB6738:EE_
x-ms-office365-filtering-correlation-id: 9e6c36b7-1983-48c0-3616-08ddb025b7e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WXdIUnVobkFra2RiZkZpYk0xMmVPVzBUdTlzT2NaR3VrY1hHWUcwa1ZiUmVV?=
 =?utf-8?B?M25qTHNxZGNEQjVZcWFFNnM3RzFqRk4rSTB6bEVQVGt0S0plcWFIcFRETUgz?=
 =?utf-8?B?c1hUZytuRktaUHFjOGVwbXd2NnBSVmtIelRqVTRiaUxHZkNFb04xZGhBRXRT?=
 =?utf-8?B?VlJ5VTE0b2c3RTl2bjlxY3EvL0pXazVVVzFZTXk2WGlHblc5R01KbGVzVzBq?=
 =?utf-8?B?STNrMmluaWlFMFdsRVpGQlNTeEw1NG16eWJFSDRPWnV5dVNTMHRWSjFlTGZl?=
 =?utf-8?B?Q2dsV2d2cTJwYXl4NDd2Qk43MnhhZlVsVEtHNHBnL3V2VFpLc0FZQWJhdWtD?=
 =?utf-8?B?eGZaZGhiNXZwMDRTTlRHTE5WeU9uYkFvT2h4UUpuanlTQ1BvVzhwZzRQTkFS?=
 =?utf-8?B?WGVONjl1dmNZUVFiM1o5MVhOdVdpQkQxa085R2tueFQ2OGVjNTQ3T3U5UkF5?=
 =?utf-8?B?Z1g2elhsck9IcDQ4ekE4TnhmVFlzaFIwVUxwRzdBMm9UL1B0cGZwTFF3NHdp?=
 =?utf-8?B?OG16OHRsWU1xMjJUdENSeGtkdnYvZHhYWVJCVHZwUTN3N2QwYXlkQ0Y5MFlZ?=
 =?utf-8?B?N2pVT0JubHF0NXhZQUtIODZFQU5QWjg3ZWtZN1cyNDVHbHFDaytXS21qM3Bx?=
 =?utf-8?B?RGJSUExVOTBVR1MyajIrRjc5RmorRXo4TDBMbzBqMWRMWVkvRHNVdmhXMmV3?=
 =?utf-8?B?ZzB5eEU5WEJ5T2xGakhsUUR5ZGM0T1RENzRKS212d3d2ZmtHU2luR2R6UlJE?=
 =?utf-8?B?d2tFdFNndU11d2h3aXhHMXFSYUdLd2t4SzFQalNPaHJGa3YyYWlHbXpMeHRM?=
 =?utf-8?B?R3hHNkF5VlNXUThXK3h1WUtKM1lFc1Y2NS9XVk1yMUtXK2pubFlWR2N4MURW?=
 =?utf-8?B?NnJYTE9CVEVKRGVtVnp3cUN2RVBaZmk1eUM5QitQS1hEc0RGK0R0aVRJeWw5?=
 =?utf-8?B?N1BVRkJtM2Vxd3hTMTdPb3Y2K3Y0SEpjNWhxYjkyUW1KM0d4VHRHKythWmpw?=
 =?utf-8?B?Y3ZGVUc5c0JnVS9qSW5zMXJPNEFSR3I5U09KQ0hHMkMrc2dmVGFYSVhBMTMr?=
 =?utf-8?B?VktJbTFZVEVVWkdyd3o3SVF2SGpMWERJOGZjYnQ4bVNvRjk0eGpWSmhzM3Rt?=
 =?utf-8?B?cC9TUkJyOUhjLzR4M0F6N04xdmZjVy9GK2pjOEgvMVlCa2RYR2dCenk4V3lC?=
 =?utf-8?B?TGdlMmg5Vzg0WFBlMlU1d3hxeFNLN3piUW9zZUJFd2VyYU5KWUxrdXk3dzB0?=
 =?utf-8?B?VmxOeFphNHRhSnUyaUxjMW0vWlFXVGJHQVQya3dhRXpYbEVqcWN4YlVBanMv?=
 =?utf-8?B?YnVqdHB6ZEFGdUhoQTh4Wi9DbmFXVUNtRmZOaUg2ZmJjeTRNOFdSeUV5NlpH?=
 =?utf-8?B?bE5SV0hoN2QxNkxwZ0ZqQTJaN1lMQ0xoNUlYRGJmRkYwY3AzZ2dXQXhOVWpW?=
 =?utf-8?B?OGxUS3RrVzBvNDFPWGg1RDFBOXVvL1VGOGJQaDZqektmbjliR1Y0SFhjRW0r?=
 =?utf-8?B?UXRSbE5PR1dsZEhwQjFyYUJza0IvaXJ2M1c1WDREaUljVElLNXNVRGp1Vlpl?=
 =?utf-8?B?cC9sUDduUVBwVW40cmljSlBHYzlkWlh6dWx4NTQxYmJWcDE1YVY1V1p2UVhU?=
 =?utf-8?B?K1BydWk1cGdjdGxHSDRYdlV2b2VRdXVyQWNDZjR3ejhEVkJhcWZBUFNwMVZ3?=
 =?utf-8?B?OHNCdEFhSXQ2cTJJWXUwcnVPTC8wcENXeXJmSUl0NXFoQW9sM0tuQXJKVUxr?=
 =?utf-8?B?VDcyLzhUbHNlMkxKRDhMdktMK2ZpWVBDdUVaQkVPV05YVm5sWU9wRHpqZ2FM?=
 =?utf-8?B?RzJFMG9xZ2NTdjU5b1VxM2E1QklwUS9QeFRHRUhML2s2dTJTd2l5d29MUldm?=
 =?utf-8?B?eVRONDJCY0tHL2FMSTZRZXlrUitUVWlWNGdQcUZPemMvaUxRZFFWKzJ5emE0?=
 =?utf-8?B?SnFvQUE4L3pRczE4ZVlWTHJUZlJPc1g5YlVBU2xKbndqQjJmYUt6Y1R6Z3BS?=
 =?utf-8?Q?z216dU43rLCnEAXrAuXO7YZrYCF55M=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?anpMNFZjeklCR0VneXZXdzdHTmdENE14NEpiRU83aDMvenZ2YjkyMzg5WXFJ?=
 =?utf-8?B?OEQ4d1ROQTN5c29IQmF1VVhlcHFzOXN3TFJFTTFJVkxQTUdva0JQczB0WUtN?=
 =?utf-8?B?dXlnSkxNS0ZkSTFoaUN6ZGdiQmFKK2ZZdWFGL0JnTTRtZjB6RUFqRDlyWFhN?=
 =?utf-8?B?Z0pwTEJra1pVV1I2c2NUTTlPNURTZnQ5VzBWQWhSM0QwM0w0Q2RMSU5KSTJO?=
 =?utf-8?B?cFdQMkRQdmJRNHhwaldpd1dUTUxsWTMxZjhqWVQwaEFRd3JEMFBBVy9MU01M?=
 =?utf-8?B?UTV4N0hnUDNmTDNlaE03NzdCcytSSUkzV0phVnRvRm44WFMvQnJGZWhLQWYr?=
 =?utf-8?B?NUszajcvMnNxTjV2emhndFhSQ0RMdXM2aVBTRzRBOHZCV0UwMWovOEZjR2Q0?=
 =?utf-8?B?M0hpdWl2NjRjRXlTaFBvZ09HV1dSUFVOTm8wVTZrTndCRWFWdTFJOUF3UzVu?=
 =?utf-8?B?Rm9NU3cyenhkZmQvQ3ZyNlVrOWhnT255ODQwZGJsTFRFZ1BuL2FFZ1pFcXla?=
 =?utf-8?B?WitmMS9hUlJrS2dGY3VQTERUdlRGUUJUZmxDUjVQR1MyWXNOMzBtZHJld1FW?=
 =?utf-8?B?TVFrV3VHbGVlNER4REtXaUJwMHFhMFd6Q2FMRC9VRUVEYnZsTUFrcmJ3bVdW?=
 =?utf-8?B?NWZmRTFGcVRqVThLeUlJRjJEcDlsYlFRY1krU3NhcERxUDRzTlIvMFEvbFJw?=
 =?utf-8?B?aXViMEc2anJna1R2VFNkVkhaUHhZRUk0eGJGK21mVkJaZHBLWkdPOTEySkpJ?=
 =?utf-8?B?TU1GYTloRU1wblZ6SGNNWDdmZUQyQVJpbnZQMksyZ1V6aHhjcHByZDdxSUJn?=
 =?utf-8?B?Y0Vvd2NmU21FZlpJRWlzT2ZMZXU3MkZCUHdSUW9DSUhQTjkzUDJ1Z0Z3MWIv?=
 =?utf-8?B?ZWZiVGsveU1nRW5HWjJIM25sRk90dHZVNW1Oa1Frb09pNGM0RVR5UFpoT2pF?=
 =?utf-8?B?SW5DMC9wYVU3SHRLMmtHejdZS1B5YkRuK0pGQStLakVUUERSR1NiRU1ROEl2?=
 =?utf-8?B?YVdrYUE2Umt6cVBCL2tNM1pmVlE5WnhFN0xiWFh5c0lUTmxQcVk5ZlgvWHlp?=
 =?utf-8?B?R2plU2N6elZ4WjNhVEZ5RW8rK2lGeGREaUdqTVMxMUVMSWJwNlA1MWhldHpy?=
 =?utf-8?B?Z3VoTThSVXR3VGpvcDhhVGgvaHp0Ym5vM3FvNGcrRGJCWmdYa1NUSHhFdkJa?=
 =?utf-8?B?cjR2M3hORTVTdUFPUHdDS01VaStpbnQ4SzQvb09Yd0dhdEszK3ZDMTllbTRM?=
 =?utf-8?B?c0dFODNnOUV3M0tVQjlKSk1SQjgwNlJVMFR5QmZZR3J0eXlEQUpGZTB3Ukp4?=
 =?utf-8?B?d2NDeWZtem5XakhpRXBtV3BLbGRvZ3AwbEczVVB5eFNwWjBNK1cxV00vSi9I?=
 =?utf-8?B?TXdxUldCTXI2TGpuMkx0T284a2xORGpleGs1Z1VQYUJSZjFiblRqVThSb1hC?=
 =?utf-8?B?S1lOTW41cXpKZXJxU2RNNks0Y2NvRDJUNVo5MWc4cVRodE5kUVlmYWR3NStF?=
 =?utf-8?B?bDJxQ3FQakpvdVVVVGFQTEplUGJuakNzdC9CLy9UemMvVUFXRE1jZzZCcWdw?=
 =?utf-8?B?b0RFZytjdTVoSGs1cDJJcmtiVTV5K1JXZTVuT0FhM0JDaE1rNGFrWU1INExz?=
 =?utf-8?B?NmVPRlh3UXVxWVl1TVN0NDFKaVhxTkM4b1plc0FodDRvQ1pycElGaW9hZktB?=
 =?utf-8?B?RzJWYzFrWFl5cUwyYk9yUnRubEJ0LzZOQyt5ZkptUnl5Rm9LZkY3TVA1am5k?=
 =?utf-8?B?RTdEdE45OUswRUs0V3cxVjQ0WTFCOUQ2Ui92cXZtOUp4aUx1OHZCdjV1SkUv?=
 =?utf-8?B?bEY5VTljalVoTjB3aDhwYU1oNnRTU29PTUtFZ01FVUxTT1ljOVFVM3YrbjNy?=
 =?utf-8?B?ZzhSVGJvZ1FPenFvbjQzbnNvNXo5Y3VSTkYxS2VLc0tpc0xoVVlWTWhaSzFI?=
 =?utf-8?B?OU9XMm91RnR2SU92VHhQUXFWYUNLQytpV0tKbXFveG1YWFFlbkNiQ1dYZFM3?=
 =?utf-8?B?Z09hR2VrUkNhZlJxSDB0OW5laE93RXc2UFNybjlvVEFYSlZxWXlmc0hjV0VH?=
 =?utf-8?B?bkEwT0szTHRPakFUaEZ4aGVRRTFDYmlCS0kwbTBlMHRxeWdLNlhDdGJHQ1Bo?=
 =?utf-8?B?Rm4rQk1TVDNZTDI1dUswZW9tVUx2K21iREU3bWxHbm56ZXhkcTVNRDdjanp6?=
 =?utf-8?Q?Z4xhyJP9bDRmUZJNkap7+Qw=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6c36b7-1983-48c0-3616-08ddb025b7e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 18:10:20.1508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pqmRGgWZu7gf/Vbew1sYd1jzz4bjQK7jZNPoqVceusMI7Cs1ELyUmE7v1hww6odUSD/TIAKj/9AEbX7ZhNwKHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR15MB6738
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDEyNSBTYWx0ZWRfXz7MfIOYvbp4j RyA4ebkuYbZlRvnAaRwYdU+GnRttvA1G+nHYDwGo1UF6ZzBdp+wkRIQm67qxcOmwzwdGk2bbzBS WswyFlHkscmYTkyyfZopn6HhwK3soIRR7YslZWV3/c/gOZMvFJJlZqc9ATJJBtuHBB9a+H/fyK+
 81CgMredbVpHhK+8ob2tUnF/YP+sq1nAXPeLVapfbYCrrvxoRb4bE9UAPHN0/qtWcE5GannIvH4 N0hjO8nLKg5eXO9AtakuQhKM/Xp7c1WM/0UEyRWvO3iIXmi0wdkfhFjLsxt9wDv07jTyPYE8l7F lLXzip0rDLDudgJx9aSgoiAz6C1KhO3Xc85eS8zEWBFkNUGdxQmV4/QyVpJXobQxP1OlTQ6/R1w
 wlfORLlFXweOJN43E8YON+bWuy1b3Z+oRrgCSAjXMAvkmteAMlGFf+VBMECs0dd3jSdnhFR0
X-Proofpoint-GUID: YkgRB7j1w-WeqpdbNPZen6pysqsGc1el
X-Authority-Analysis: v=2.4 cv=a7ww9VSF c=1 sm=1 tr=0 ts=6855a411 cx=c_pps a=VBa9tr0pwzwl7iNjvTjIUw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=rIH98O22OktHME4k:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=PAqKgJLbblY-1ggnGfAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rfgyF5hor8ngQzAQV3yX_hbfYk408wIB
Content-Type: text/plain; charset="utf-8"
Content-ID: <6910E58D8DBA0C41B96B6889FD040FD5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [RFC] Should we consider to re-write HFS/HFS+ in Rust?
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_07,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 spamscore=0 mlxlogscore=796 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=2 engine=8.19.0-2505280000
 definitions=main-2506200125

On Fri, 2025-06-20 at 10:17 +0200, Miguel Ojeda wrote:
> On Thu, Jun 19, 2025 at 11:49=E2=80=AFPM Viacheslav Dubeyko
> <Slava.Dubeyko@ibm.com> wrote:
> >=20
> > But I would like to implement the step-by-step approach.
>=20
> Like Benno mentions, it is hard to say how it will look with your
> description, i.e. how you plan to "cut" things.
>=20
> On one hand, it sounds like you don't plan to write VFS abstractions
> -- did you check Wedson's work?
>=20

I don't have plans to re-write the whole Linux kernel. :) Because, any
particular file system driver needs to interact with VFS, memory subsystem =
and
block layer. So, pure Rust implementation means that everything should be r=
e-
written in Rust. But it's mission impossible any time soon. :)

>     https://lore.kernel.org/rust-for-linux/20240514131711.379322-1-wedson=
af@gmail.com/ =20
>=20
> i.e. it sounds like you want to replace parts of e.g. HFS with Rust
> code while still going through C interfaces at some places inside HFS,
> and that has downsides.

> On the other hand, you mention "abstractions" around VFS concepts too,
> so you may have something else in mind.
>=20

I am considering of re-writing HFS/HFS+ in Rust but still surviving in the C
implemented environment. I don't think that even VFS will be completely re-
written in Rust and adopted any time soon. So, I am talking only about HFS/=
HFS+
"abstractions" now.

> > Frankly speaking, I don't see how Read-Only version can be easier. :) B=
ecause,
> > even Read-Only version requires to operate by file system's metadata. A=
nd it's
> > around 80% - 90% of the whole file system driver functionality. From my=
 point of
> > view, it is much easier to convert every metadata structure implementat=
ion step
> > by step into Rust.
>=20
> Well, apart from having to write more operations/code, as soon as
> there may be writers, you have to take care of that possibility in
> everything you do, no?
>=20
> Worst of all, I imagine you have to test (and generally treat the
> project) way more carefully, because now your users could lose real
> data.
>=20
>=20

Even if you have bugs in read path only, then end user will not have access=
 to
data. As a result, end-user will think that data is lost anyway because the=
 data
cannot be accessed.

Any modification or bug fix in file system driver could result in real data=
 loss
even for C implementation. So, of course, we need to be really careful with=
 re-
writing file system driver in Rust. But if we have valid implementation in C
then we need to follow the functional logic and make the Rust implementation
consistent with logic in C. Also, we have xfstests that can help to check t=
hat
functionality works correctly. Of course, xfstests cannot guarantee 100%
correctness of file system operations.

So, frankly speaking, I don't see big difference between Read-Only or Read-=
Write
functionality. Because, both functionalities should be correct and could re=
sult
in inconsistent state of file system's in-core metadata or what end-user can
access or see, finally.

Also, anyway, C implementation and Rust implementation needs to co-exist, at
minimum, for some time, I assume.

Thanks,
Slava.

