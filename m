Return-Path: <linux-fsdevel+bounces-37075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4228F9ED28F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 17:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF9E167022
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 16:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DDC1DE2D2;
	Wed, 11 Dec 2024 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="mh2M0lHF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4C6139CF2;
	Wed, 11 Dec 2024 16:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935698; cv=fail; b=IsmJ941gSSMtCbo3wU4rdd4Jla2YJdjww4wh4rMfYAdV+te1NvKvxuwNEdkoajb8uRH1cOJpfNPxQTDSxXCUhjCXDkprhGztqUPv5DEFgKJC3K7wqTnYxYox/pwxN3K3b/jymg3pq0iz6HMUaj3LR4BMEom87QgUlm9Uz8xd6XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935698; c=relaxed/simple;
	bh=Cgcd/w2eQfzvMVvalV3/OkWjfcTJ/Gps0zk8CSPlQZ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TiUdFIv8jnS0eq+3Wf+WvOrQjTsM0017ETnK0UGD5l6M08ldBKFlhzIF8lzLSlpg6QTj1Gh/XDfbxP3lfSMquW95DKznwp6wV864trKWeOgO6dgdNq7uASxQmDy7yicNYceiv90/yo4Nbnuh8ELgCE/S947LCMaO7HzjgDF3feI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=mh2M0lHF; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBFI5VC009880;
	Wed, 11 Dec 2024 08:48:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=Cgcd/w2eQfzvMVvalV3/OkWjfcTJ/Gps0zk8CSPlQZ0=; b=
	mh2M0lHFa0NEItnF3EUiYiQJ1wpqvs4HAFVgXG/lpvitke5GBRg3B+H0BCju1SRM
	5j2NB4S4kc1j+fCxD8czwzl7pf1j3Bu0ZunDfi7nVxdutjNbaf6ZSUD0zng/4jQZ
	wNyO66UEpHxQZ/YpR4kvn0M/tNudDCK0+zY4pBY5o9I4USHy4dAHLuhMYeNBuScv
	ulBxwzZg6jmKvNsG5uUxCTXWWOw0Gkedla5tLCPoytvl4+Blnb3veqqMwRN7QmTT
	UiKhLzaRdiC/8IvsvXrRwxBgYJgLTSqYHX9ewPXXJJPlORD7XKsrWZjn3/guV0u+
	aMXgWSpjC9yElcg/BkISTQ==
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43fcd115v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 08:48:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HI+NFDFsxSkNO0YdKgsTNDBQsP3LINm7SOGLXFfJpc2heu8hCnmIVzkaH27WIOj2PguXzFf9irFmYkTOyOwwG1XFRkRPh615z9RQRQM+21op6bDZV8Ax2tUjkGX9C1J1LWiISyaruNqQ/W2mC2/Wm8cWmHNAQN+1VArKIZl0WPCo85moAr5g4lq8bAxpw6hf6jExqQQzA/HAOHIU2HcwonOUHcw6t9D+0i86RU909Kgux24TRXoT4893KrhYC25ZkftqoLWo4PdJrMJ4pPYRbhbb/9GMMEN8bmNpjFERpSZkvTGHpAy/0CM9XXFqBOkrjHOf/m/z2BOJITSsLQ67Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cgcd/w2eQfzvMVvalV3/OkWjfcTJ/Gps0zk8CSPlQZ0=;
 b=oGk6n/YhsEduVee+rf/Sdx1aG518N/0YnKqTPgnyp3SgPJcfv4NhWTdD3fb4gSpCGVevCnZhrI4xGfkfKm8YWRsXtTfuPiSO8E1UlN9nwm8mddGWFus99FetrGRm/A5Yjf89DDml3nfH1zxCSjyUI1uEKkfRykf8R0ueG/csg4LxSvv7deEKx8HNpPSoZ8vLyBCvX2y/I1c+1lz0utHATmBYBKkYng0w38rxbpyWyU3BaXurdpGotgTbpTeW75nvCdOjxPe6pRXEpWoY7IkHO5045TXVgDI9swH5NE2BtvRcOOyi3mqvBKtL5Ixl82ngWTNUSE2IARZEwKpPP8i1Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW4PR15MB4522.namprd15.prod.outlook.com (2603:10b6:303:107::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Wed, 11 Dec
 2024 16:48:10 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%7]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 16:48:10 +0000
From: Song Liu <songliubraving@meta.com>
To: Theodore Ts'o <tytso@mit.edu>
CC: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "eddyz87@gmail.com"
	<eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "martin.lau@linux.dev"
	<martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com"
	<mattbobrowski@google.com>,
        Liam Wisehart <liamwisehart@meta.com>,
        Shankaran
 Gnanashanmugam <shankaran@meta.com>
Subject: Re: [PATCH v3 bpf-next 0/6] Enable writing xattr from BPF programs
Thread-Topic: [PATCH v3 bpf-next 0/6] Enable writing xattr from BPF programs
Thread-Index: AQHbS0/TWovw/o4pI0quVN/ywUaUArLhB5gAgAA6qAA=
Date: Wed, 11 Dec 2024 16:48:10 +0000
Message-ID: <24F57160-0FCB-4505-A2D8-1AB0E07B46A9@fb.com>
References: <20241210220627.2800362-1-song@kernel.org>
 <20241211131804.GA1912640@mit.edu>
In-Reply-To: <20241211131804.GA1912640@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.200.121)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MW4PR15MB4522:EE_
x-ms-office365-filtering-correlation-id: 17e5f3f4-6243-471c-1024-08dd1a0398ac
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TVUxMTRjRlZMdkNvQ0hGTHZtOWxGeDhoQ1lXbGxzQndLR2paemdXazVaR3pO?=
 =?utf-8?B?aEkrNlFlRldOU1RiMGhrazE4SU04QVoyRDhxSTREQ21yRCtLWk1nN1ZLWStJ?=
 =?utf-8?B?Z0pPa2lQNVBXL2Y0cUlWZzNyTmVxYnluTDJ2dFNscjhHbUV1V1RuTk9tZXpG?=
 =?utf-8?B?VGV1akxsQkdTdEV2c1RmS29Cb3phN3pEdzlMMGVVR243ZVFyOHplVWZmSUp6?=
 =?utf-8?B?SHZ4elAvT01KS0VYSFFCTGJkdUdmRmRGSm52cFdvalNubDh5UW5zTVdDTGJu?=
 =?utf-8?B?UXJxbmFDOVFQblc3aGdabmJvMC9ONW9SZkdzN0pDQUJwdUxyMXZUaStzN2xv?=
 =?utf-8?B?a0V6RFdwUVJybDFrSHloKzdIc1I2ODZnNnV3a2d6T2VDZFFTUWdaNDVxYVRt?=
 =?utf-8?B?L3l6Vkl2d2gyWkhCcjhLOFcvUitsS3ZoREhsM3Z1VzAydk5yWmszUkVNc3Ri?=
 =?utf-8?B?d2tHYWlMQ2RodzFHRDBNMEdreGVtQkh0LzBqcnl0UW1UZkxaOWVtcWtTY1VG?=
 =?utf-8?B?aXR1YWlRZUx0YWxwNnRZTGZNMDZ5SThQL1dadVo0YUNMaDd3cnlaUjJPc1Jj?=
 =?utf-8?B?eTNzVUpTa1lCK3hlVXN6RHRoTDExTFlIdkFoanhNTUx0WEN5ZWhLelZxNXY2?=
 =?utf-8?B?UEJObTR1VXdPR2xTR1VZNUYwN05qdklza0V5QVpFOXJ0eXF1MmhhTWNtdk5w?=
 =?utf-8?B?TDQ3TVd0YkFoRlU5cjJkZzRjVjRIZTkwUVNMS1NhQUZWM3JYREtBUGNlaHVv?=
 =?utf-8?B?TnVJMXpXd1ZKODFoU00xZ3c2NHZROFE0M1VUTE5ZSkFSTVUzMDVwS1JqZ29r?=
 =?utf-8?B?YVNHMmNjSm1PYmd1SzJqalA5eWFPKzBWV056dFJ5Mkc4QlVZc0l1OUN5OXRU?=
 =?utf-8?B?Y3crNlRmMm5oVHo2K2x1WnVSZVE2MGxvY2ZHdWFralFBYlh2bXJHQnBpUGNO?=
 =?utf-8?B?QXJoajhKdlJNeDhGajg3bWFubnExZUdyaFFZaEp0ZDNPQXV4SlNGZFBHcjgy?=
 =?utf-8?B?V1d2dlhzTndtVTc4c1N5ZlRZZnVRQkxsTXpaRUdJa1ZxaVZrUm03NEcwaDdY?=
 =?utf-8?B?bzRTenJGeWg0dHZyNU1qK0swL3pUalc1OFMrc1U5S1JrWmpnajdMbjhBeHBq?=
 =?utf-8?B?SzJ1dFdWSGZQMWpjQnBFaXZNSUpXMWZpcmg1VVh6L01GM3duaXNselErd0th?=
 =?utf-8?B?bmo0MHl5WXRqeHVCa25NczNLUzQzbFZJTGtGZ0ZIWWVhQUNETnVUTGhQdm9s?=
 =?utf-8?B?ajNyclQzS2owVkpxQnRzTGJDekY3K1lUa3Yyend0RElobS9peitGYVpINWJK?=
 =?utf-8?B?RStsZXQ3a0t1TVl1eFl6azlrOGV3QmFEMFRibjJJZE83cGVuTlkwcGN6SWU0?=
 =?utf-8?B?djVhY3JvUmtvRytHQWpyZTVIRXdTTVY1Qm92Nk84dHYwcFRLU3pGWWduRzdq?=
 =?utf-8?B?RElxK1lacjNlQml5NTJZQlBTK3N3cTRGajl2NTJJTTJWT0ZkcjZwRm95clF1?=
 =?utf-8?B?a0JuRkszU05idSt1ejNmcFNPS0wxUk9zSGM5QytoYnI3VU1xYXB5LzJZTXQ3?=
 =?utf-8?B?cmxvUzFVc1krS01OV2pGMWwyWVdPL2xXdmtheU1nYXpXOE5XZkZLazdwazlR?=
 =?utf-8?B?K1FVMmJPLzN6QnBDcEJEZmYzT2JrZ00wZXpyQUgxNDNPZzRlbTNRVWhEd3Vw?=
 =?utf-8?B?YnNDV2R2WDBQejJoY09tWlZLRVZpSEI1dzg1TlhJMDNZbUZvUnlWMFN4NVpN?=
 =?utf-8?B?ekd2UzZDZEtSUXNyOHhhMUlQZ2RHVGtKbXBRK25tSUQzTUxGRmMvSzJSUFM5?=
 =?utf-8?B?c3lqaEFXdUNwY0twVjJvRkxEdmZUN3VQZ0cvRlF2Uk1oYXhiYmk3OEE4Qng4?=
 =?utf-8?B?TDlZSU1JbjNSbllzOTlLMHFNcTBYMXJJWnRFQ0xDZTZBemc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aHI3d3BINXRHTElvU0hxaFZxK2pyOWdlZVUxRW9uNlphWEVnWXJmMk1TeVdE?=
 =?utf-8?B?OUhBam5vS1BvT2F4UDNJR3RvTTBuYXYzeDBjUUxhTFNSbzhBODZTb1RYcjVr?=
 =?utf-8?B?aTBydjIwUDhGRnQ1TnF4YlU4T1ZNVTV1RUQ4eVgvdmV6Y0lBRXU1S0JjUStS?=
 =?utf-8?B?cWVPUFBGWFAvNG05L3BLb2NOOHA0cUR6cHorTUJTV1ovbnlOWVdxbVZBNjMz?=
 =?utf-8?B?UjJZU1VoNDM1VGF6bjlSYjVvb1lQU0pUWXFSY0xtTzFpc0pDSHBhL3NCM1py?=
 =?utf-8?B?MitVTVJpYTNhWkVLTGJQSDMyS0lCQUZpUmVYckQ5eXZObHdUMzhaaTFWVzg2?=
 =?utf-8?B?YnpCWm1wWGFjSWtya0VDR2I3WUF2dk16eUhNcWpicEpiQ3pUM0RJVExVRWRS?=
 =?utf-8?B?MThvbXdrVWxmb2NVNTkzRWZ4K1Z4Z1ZLYmJPZTdVUjFLTlhFK1R5Zm5uak80?=
 =?utf-8?B?MDhQTXZmY1A4S3J1c2hTZ1ZPNG1GaVNCSTlqNE9XSlJMbkNZSlZxd2ZwTFJk?=
 =?utf-8?B?L3cwNERET0lWOTZLMWZ2TVVRUUoxSlMxSkxWWkNvSVBMZENMbEtPVGxtekJq?=
 =?utf-8?B?QTRsaHdYOUtVSkRaWHQ2WWFWTUhhaytqWmx4c2RyR01Db2ZGc042bFV0UGJv?=
 =?utf-8?B?V2FmQTNqdE5yVFJSRm85aTdSMTlsWDR2ZlhjYkQ5ZGpja0VCMmpmREVibGwz?=
 =?utf-8?B?cE05emxoUDgyNlVJVVpKd0lpMU9LZmtYRUFOcHZqV0d1UjRiSVhsbmR0Z2Qw?=
 =?utf-8?B?YWpnblhDS1JUOUhwek5YYm9jTGdDZ1UwT0s4ajBjQnMvVnNRbC92eXgyQlZ0?=
 =?utf-8?B?cFlHUzVFZWdnL21tNUh0cEQwT1VQMHFmVTZsd0J1U1Z0MU44Nkx3dWlkNWhN?=
 =?utf-8?B?VzlEZGM2VHVnbWNHa1V5N205Njl1dmI4V2pUWXl1QlVWKzNBdWs5dFNPeWlC?=
 =?utf-8?B?dzhmbThLK1F1VHdKUkd6Y09UWWxCQkhsdndIL0cyNU1iRThCT2k0K094VWZp?=
 =?utf-8?B?Y2xvYzNmSjd5MXlkOFlockkrclFjWFg2UzdPNlRSd2lFZE1MSWd0QWY0dmFQ?=
 =?utf-8?B?SmR2THdFcGYyUHpFMTBIWTdwS3dGczkyeE91Zi9IRFZWUTNrUWhocE5UYWl1?=
 =?utf-8?B?dHZ6WDRMWC96UzFCRWlSemU1djlaaTBLWEFoVEZvREZudytHZnRWcURQcFVr?=
 =?utf-8?B?NkhHS1lnM0FXa1ZkOE1QYnBuTWZoek9zVVBaVmN0dDREcHBzdWFwWTQ5YWRl?=
 =?utf-8?B?VWlEQ0R4WnE1RXpMNmZIbklyM2doN2w0ZTNBdzNlVW1UdnVrSjZUTE15d1Mx?=
 =?utf-8?B?bmlQY1ErZUlUdUtvOHpNUTlQbU5OZnhneENnaGIxYW1XNE9CV0oxRWQ5VGRs?=
 =?utf-8?B?eVVjQmd2aHd3dWdZY2dJaXBZKzJ1bmpteHAxRTVla2x1NkFwclZZQ3RBb2Ur?=
 =?utf-8?B?L0pyVDI0OE9FSzQzeTVUeS8vWWxhRytYdnZhdlJHVndNdkFTNnJBUlhvdE12?=
 =?utf-8?B?TjJPaDBmK1huRUJoUnUvK3VlZm90OGZpSWNuWTFTL3pRZHloQThKZTUzdi9Y?=
 =?utf-8?B?Q2MvOUFHeXc2eGRPZGF5VGpzdDZEVThoN0R4S3dTTER1SHUzamNCTkVpQ0lH?=
 =?utf-8?B?ZFVRVzU3blNUR2NGK2pNT0ZtQkVIcWtNanZyYzAyZnpmdXZobE84V3J1SVNI?=
 =?utf-8?B?aXBKOC9HNytUUWNQN3VmaWZGNUpORkRHby9jaC85UFlZaFVScU8yUTAyZHh0?=
 =?utf-8?B?d0xHQ1Z1aFMzbk44TjlFb3VDMXJZOGpGWXhXNjZZNUxMRnkvazA3R3pjQzhY?=
 =?utf-8?B?RlpMTDFnV0ZpRVZGbDlocVNvK3RVNUdWa2d3RC9CQm9zeS9nemczS3FoNTFP?=
 =?utf-8?B?K21hRlJ1NWVDcjZKNHo4SWxnV1lJR01sRm9tSXN4bGJBWU1pK20veVpIbGVH?=
 =?utf-8?B?K3B4SVVWdTRXUGNQb3hkanlUbm1IOHM0Rkl2TnJZeWx5QUxnbStDWjdiMkhW?=
 =?utf-8?B?S3Z6TlphbGN5Wk1Vb3g0eXFUODgvTTFQa0xrU09BdkdxNTU5UUQzbXBsS3VL?=
 =?utf-8?B?aEplVXRaQlF1bFZhYTQweDZsMkNpVGZEUTVJUVRyWlNRMEMyL2pUR0Nzd0hY?=
 =?utf-8?B?OVJHbzhFWXFaQmFOblFxNlFXSXBLbFJhSlU0N2pTTzlpeEVPZTdDc1dBZ1FB?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3A9BA06F4DFCB40ACD3F8C85BD21D2A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e5f3f4-6243-471c-1024-08dd1a0398ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 16:48:10.4685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KREfte43Fr2s2Q1Ch7BxHhAPCb0j1TfO2vOnqN6X/CUxsxTIicOl2+WogQnwJE3EhKdY/3LpTIsTW7ZM2MNRxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4522
X-Proofpoint-ORIG-GUID: p-O-z9oxChD-lZJsEGanTMITMECuwDYA
X-Proofpoint-GUID: p-O-z9oxChD-lZJsEGanTMITMECuwDYA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01

SGkgVGVkLCANCg0KPiBPbiBEZWMgMTEsIDIwMjQsIGF0IDU6MTjigK9BTSwgVGhlb2RvcmUgVHMn
byA8dHl0c29AbWl0LmVkdT4gd3JvdGU6DQo+IA0KPiBPbiBUdWUsIERlYyAxMCwgMjAyNCBhdCAw
MjowNjoyMVBNIC0wODAwLCBTb25nIExpdSB3cm90ZToNCj4+IEFkZCBzdXBwb3J0IHRvIHNldCBh
bmQgcmVtb3ZlIHhhdHRyIGZyb20gQlBGIHByb2dyYW0uIEFsc28gYWRkDQo+PiBzZWN1cml0eS5i
cGYuIHhhdHRyIG5hbWUgcHJlZml4Lg0KPiANCj4gSWYgdGhlIHN5c3RlbSBhbGxvd3MgZm9yIHRo
ZSBleGVjdXRpb24gb2YgdW5wcml2aWxlZ2VkIEJQRiBwcm9ncmFtcw0KPiAoZS5nLiwgb25lcyB3
aGVyZSBhIHJhbmRvbSB1c2VyIGNhbiBsb2FkIHRoZWlyIG93biBCUEYgcHJvZ3JhbXMpLCB3aWxs
DQo+IHRoZXkgaGF2ZSBodGUgYWJpbGl0eSB0byBzZXQgYW5kIHJlbW92ZSBzZWN1cml0eS5icGYu
KiB4YXR0cnM/ICBJZiB0aGUNCj4gYW5zd2VyIGlzIHllcywgc2hvdWxkIHRoaXMgYmUgZGlzYWxs
b3dlZD8NCj4gDQo+IEkgbm90ZSB0aGF0IG9uZSBvZiB0aGUgdXNlIGNhc2VzIHNlZW1zIHRvIGJl
IEJQRi1iYXNlZCBMU00ncywgc28gd2UNCj4gbWF5IHdhbnQgdG8gaGF2ZSBzb21ldGhpbmcgZXZl
biBtb3JlIHJlc3RyaWN0aXZlIHNpbmNlIG90aGVyd2lzZSBhbnkNCj4gQlBGIHByb2dyYW0gY291
bGQgcG90ZW50aWFsbHkgaGF2ZSB0aGUgc2FtZSBwb3dlciBhcyB0aGUgTFNNPw0KDQpUaGVzZSBr
ZnVuY3MgYXJlIG9ubHkgYWxsb3dlZCBpbiBCUEYgTFNNIHByb2dyYW1zLiBUaGVyZWZvcmUsIG90
aGVyDQpwcm9ncmFtIHR5cGVzICh0cmFjaW5nLCBYRFAsIGV0Yy4pIGNhbm5vdCB1c2UgdGhlc2Ug
a2Z1bmNzLiANCg0KVGhhbmtzLA0KU29uZw0KDQo=

