Return-Path: <linux-fsdevel+bounces-53053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E17AE9564
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 07:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A89F17A58B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 05:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29F4221555;
	Thu, 26 Jun 2025 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Xa45d0Ij"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC8715A864;
	Thu, 26 Jun 2025 05:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750917177; cv=fail; b=M2Izw337CnUKQAoiQF5uIrgsIm2/tqWFX53OJHGMsxhegnaVbgRzKyFkdBFyPJ/+X9jRqC95oD3Cj7mMchb7G0f8/Eb73cY9Ei/a9Wp2hfV6vjOJZN7iQ0gZygx+/l6D6cvFWy/l9lonDxnznReXbsaKzrV3uCmE37NLvuI3LAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750917177; c=relaxed/simple;
	bh=mnNQtMlkL4H4qXTgqgL1MAswOsfWl0Ts5x/xdHFHio4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i5U7QjfwLm20wpX2y4RXiwx2uYPdVenTITXS10ar+qwGywvaY+zxPY8nE+yiyBiyHaFjAx2k5W2ajeCcr5RPH3pFq9IA/HoY6qNWiDr8Ji8Xe015zgNpMJhy7veQXrBtF645ZYPzglZgv0iAZoPsIYjeQXbsH6YLWAbLmasxKkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Xa45d0Ij; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q2gYHr020155;
	Wed, 25 Jun 2025 22:52:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=mnNQtMlkL4H4qXTgqgL1MAswOsfWl0Ts5x/xdHFHio4=; b=
	Xa45d0IjVG5e0rdSklMfY3GKHmnwwl1Rc2xiTXSkFL7srsCh+XHbV5O0sTuz782+
	dVm0GS1wSs8pd1/MwbbUmV1bSc2uFX0WOPrWTCIuW3pLp6AZrutyRLKrHHX4kXl/
	Ks/F8qSARysyz3UDXrxQhkoZUCSkx7KWG4VBm8e9By8/NxeTI8PMoQVvxWfJlGuq
	0tyWmSkUAFDcWpyQyt71eaagCgX8N6y/IqntLTVht8cPTzyex6qX+JiPa2AjoEzi
	4efWLveKfFP8rBDMQ4W/W1QRTBnm29S7gh3auvxOlW9lDG8vJkkvGMTwAAEukxN9
	xAw6eq27ysbndWxbzeoDWg==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47gcgjynm1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 22:52:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jb4nVjlmhPKjh/x2SYIgbU0JS79zjlwmPuKH6tRrEOFKn/g3lpys6udnUa4n9j206rlYGwam++k/+iSYPf3f8HJXaiA5gThy3N3tZM3NVoDjH788LhELj23lH/5tnVddUuOp+dolwJ8nl0yscZ7pUgh8WU+GSTITlw7NbAKtSJpbPDnkvpOuTCZ1gzs3Jclo2sQUzdHjtpm8EtCuH0BnUVxaApeSIIal6WlMuA/+TC40WaLcDBPGXOXg8X/BOezWv3tfSWWjqwa9T/zgZfrPLGvtzVC1VDngZ4gN0sH6A3OLCO7AM8bfRWdvVTdYSCg4oU69qCD7sM37WOY5uZCECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnNQtMlkL4H4qXTgqgL1MAswOsfWl0Ts5x/xdHFHio4=;
 b=FqqoXZDYqYxnkVSb+Tf3QxXn+y950kFlUk3jsvlT0MtujWdnsiyLZxnzE8S1lIzZpl7sQuN9MZOz8hPM3jCQ3H6eoyMSEqvwcr71NJmQVWBagapQwDBbUJ7PrzFjqnrtKU8RgM1cEaxC4fQuRSTqV+9K2khngaiqMKtu3uvbx5dxpjCTmOVYLChww19X54O/q4NuuJWr952TFV/fMtda347j7+fYNfh7y3A4OKJxZoKx5ubAa2i3+/D5fX6tq1j3fLkWpgei+s/3syD/9nXDTmlBLM+ZdpcEPkvC3nWEin3VH1PAc8X3wYGQ7qqz7QVmi2l9eSyphRJ6o6vk4q8daw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by PH0PR15MB5710.namprd15.prod.outlook.com (2603:10b6:510:288::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 26 Jun
 2025 05:52:51 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::662b:d7bd:ab1b:2610%6]) with mapi id 15.20.8880.015; Thu, 26 Jun 2025
 05:52:50 +0000
From: Song Liu <songliubraving@meta.com>
To: NeilBrown <neil@brown.name>
CC: Tingmao Wang <m@maowtm.org>,
        =?utf-8?B?TWlja2HDq2wgU2FsYcO8bg==?=
	<mic@digikod.net>,
        Song Liu <song@kernel.org>,
        "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>,
        "brauner@kernel.org"
	<brauner@kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "andrii@kernel.org"
	<andrii@kernel.org>,
        "eddyz87@gmail.com" <eddyz87@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net"
	<daniel@iogearbox.net>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz"
	<jack@suse.cz>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "mattbobrowski@google.com" <mattbobrowski@google.com>,
        =?utf-8?B?R8O8bnRoZXIgTm9hY2s=?= <gnoack@google.com>
Subject: Re: [PATCH v5 bpf-next 0/5] bpf path iterator
Thread-Topic: [PATCH v5 bpf-next 0/5] bpf path iterator
Thread-Index:
 AQHb306ox9XN8K6VdkCbVuOe+nEEeLQMnoWAgAYTUACAADBQgIABBU4AgAClEQCAABGDAIAAECWAgABQToA=
Date: Thu, 26 Jun 2025 05:52:50 +0000
Message-ID: <9BD19ABC-08B8-4976-912D-DFCC06C29CAA@meta.com>
References: <4577db64-64f2-4102-b00e-2e7921638a7c@maowtm.org>
 <175089992300.2280845.10831299451925894203@noble.neil.brown.name>
In-Reply-To: <175089992300.2280845.10831299451925894203@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.600.51.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|PH0PR15MB5710:EE_
x-ms-office365-filtering-correlation-id: 1310bafd-f6c5-4a48-534b-08ddb475afc4
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?eXJnTXgrZVZ1OWpYM0IrT2dsYTFCNS9kS2VjTWx0SGdIS3p2WUk4djhuVkYz?=
 =?utf-8?B?UTZXV0pSdU1uMW5sNjNZNmR3dVBuQTFJeUFqYnhRZDE5TG8vK0dFS2JZWmt3?=
 =?utf-8?B?UkVBRDY1RFdOZWpFZjlzV1EzSnBwQzlDMjJBVW1nT2ovV3NHTC93RFNObWxi?=
 =?utf-8?B?bDZNY1RsUjcvNE9LZFljRjZQNnM3VWo4MkZyRGRwMzlhT1VpbC91NFlqSlR0?=
 =?utf-8?B?NE40dGJyaHd4NkNNeWF4bjNvODgwVU9pQlBhaVB5UG0rZmR6TjBEdDRVV0Zt?=
 =?utf-8?B?WHR0SVJIVVljN0pTcHh5Y2k2cTBJNHliSW5yeDFuMUdMSEMvcGgvcDViRmNm?=
 =?utf-8?B?YzZaRTZFbWU0K2pDUTlJR3ZpNy9FTnUxSE92QnhDaWY0WVYwaTZYUkFVUm54?=
 =?utf-8?B?SU84elNLelRrUktSSkhVS3JpUEpjYzNlUzQ3RW93eVRVZHova3R5RkZpYXNn?=
 =?utf-8?B?ZEw2QitIcmY1UjQxSW4va1paNlN6K3pZcDJ0bTBBcHEwdDJQcmttQXV5OWto?=
 =?utf-8?B?WHlMY2Z4MHlrN3FRTWlGb2xrQjdGL05oWlZHWVhkWUIzaHpZR01zeGpxNlps?=
 =?utf-8?B?bTUrRnI5K0g5TDFXVEdGeWZnMlc3S0JSaFptNndLVzJzR1RLR2VJVkE1RnBZ?=
 =?utf-8?B?YWRKV1lJNHJKTTNIaW93TFYzaDJxY21wSTg1MEZhbThzdkNlaThoWFIyeWpY?=
 =?utf-8?B?UG5QVVZ2c3VBdFNoZDEyc2pOR2s3eWgzZXl1cTB2UExnNWNrR1M4SG0wbFhn?=
 =?utf-8?B?RENxWWFxVElYcGV1MEJQUWE2UDZ0YkxiRUNsN0lBK3BkQyt2Vkx3S05Mc1Ir?=
 =?utf-8?B?NHAvNC93VHFiK1F2UC9vVWZ2eVhmMldjMWc5b3dhQjdJQmtmMnlMVWpwb3Vj?=
 =?utf-8?B?Z29LcEo5SExSTXpUK3ZWeVVKNHRoQWtZb3BuTEo1dUVZWUxZOVBjdGQ1akZ6?=
 =?utf-8?B?NlM5MUJqRjRTOU1zc25PMUExMFJGZmdUdHBpVEh6aCtwZDd6Vnk2NUdtYXBZ?=
 =?utf-8?B?bmtJTXdJR3hpWldHblFwZVlna0JuNGR5NXVhekpuVW44R0FtMTRxY1VubmJ2?=
 =?utf-8?B?RU1pN2JFSXE4enNMYzZwUTBXajFRbVVwK0lzY1krUFRyU0lsTUplZXJlVUNv?=
 =?utf-8?B?VmhINVVrTko3T0hLSEUyTytSQXNtak5DRndGbXRjYVpid1FPcjJ6dmRJcmFU?=
 =?utf-8?B?NkV1QkVUcGlUZFJYdmJ2QUJRQWExRkJIejlneUNMTTdMUml4NDdON2owVkRQ?=
 =?utf-8?B?S3ZJbkVQUkJ3WHViTnFFaWs0RUZCTXVSQ09RZW9FU3pNQnF0c1F2Q2dBUWJJ?=
 =?utf-8?B?aUVlWERvOEhncm03QzBmTi9SUnMrR3NVQ2lIV3ZzblVVYXRFeWNuZGYvVklV?=
 =?utf-8?B?bzdQdkQxWU5zK3RpN2RrS1kyVW1heXVtZzFMRzlTWklDMEFUT3doNkZQNXda?=
 =?utf-8?B?NEpHVy9XZFk1ZkdkQUdORStqZ0hxZ0lQNjFZMjU2NVBrYWR1UlJVUUpIN1Q3?=
 =?utf-8?B?VnM0Um1ab2hCV3JzeGRHbnBDUG4wa0s5ZlA4NWFWa252WWFjT3l4QURkRFJU?=
 =?utf-8?B?MkYxODJMNTBBODZiYk1STCtjak83bitLQWNzZGNLT1pXQmJPUWRQOFRyS1ZJ?=
 =?utf-8?B?aG13QkFTcWRqVXExbUFrS1JDQU9UTm1jcTBmd0E3a2QrRUhGMjJKY3c3TVJE?=
 =?utf-8?B?OGo5V28rSnphWTlqOFZHQ2JjUzQzc05HWkYyVDd3dUgyM1pGVHlPKzdsaDE5?=
 =?utf-8?B?czNTbUY2empVQTVqK3kvTHRnYW9mTWJxY0lTUHNJRHdEUXJMaEFPQ3ptODB3?=
 =?utf-8?B?UE94WXFNdzdjajVxTUtlMmVFdXFab1RzMFhtTEdQaXZGeDAxWGtXbXFqNURL?=
 =?utf-8?B?MCs3RXJxZDIzZkZBSk5XWGcwK241bG9MZW9qUlFNRlVjbTQyZ2tnTlZZRExS?=
 =?utf-8?B?NitYbnpYOUJjQk4xdWExR0dVRW1SME8zcHdDejFvczJzRHlTMDVVdUprbmVK?=
 =?utf-8?B?ZG1YeGk3QVdnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M05USUFod2FsbTg3SVJKaER4NURBQXhYMW45eitOTytXZStySmNrNkpZV1Jx?=
 =?utf-8?B?UXZFYzNRUGx0RlhPNmx5QzVlMUVmZjM4UkRaVHVZMHRxVFhlZmpJeWc2R1J0?=
 =?utf-8?B?UzJ4MlRSa28rQnpDQTZBTEtXZHQxNk04T0ZzMEpEMkpYelNsVWY5RkVxMGhZ?=
 =?utf-8?B?cWEvcXJqajNrOXZxcVRtemEvalRKdUhKZ0dCTzUrSWYrN0x6dUFsaFdDY2h0?=
 =?utf-8?B?amw1eEpSK3JURDJoMmFsODRRdVliYlRKd3hJMEw3VkpESkZRR2FCS0FmMVRX?=
 =?utf-8?B?SjdoNnprU0QyU3BmWGM5VHdKT1RvUVpVSVh0QTV5N0h0azlKRzl6R04wcjg2?=
 =?utf-8?B?aGk4b1k1citQWElpSGQvd1lkcXB2djg1RnJEUHBFRU1OZnlTakhJa2M0dTdH?=
 =?utf-8?B?SzF0ZFZJQ3lFbUNlTnJMZHZpeGVRNmRQVUJ2cHh4QnlTaHkzck53bTZvVUEw?=
 =?utf-8?B?TlRiQ0haOWhlK1ZyWCtYUlRKYW00YVk2dHp6NnNjWXdmaW0veVB2djF5am54?=
 =?utf-8?B?dUJSdnBDak5sMDRuR2plWlRWZnlrb3VXR2FEd2dGcTIybUF3czkwaWswekYz?=
 =?utf-8?B?ZzBmNzBDZ28wM25pQXZlQ1p3RFJmOW5Ielh2SFVaYlFjclVPK1lqaVVIZ2or?=
 =?utf-8?B?RkhUaGVjNGx6YjZhRTcxdHJmcG9xdXUxRUJQWklqTzBKVU03UllHR2JsWTlk?=
 =?utf-8?B?dHhwWEFzdERNanJoZ2ZmUXdzVURNZ0xHdkdpNWJHT1Y0c1lZbkIwOXpUQnl2?=
 =?utf-8?B?d1M4VEdsYjdTcW9OWWJCY2VDazJ6YkpITm0yemZYMVpJYmdNdlAyWXJVMjM5?=
 =?utf-8?B?dm5SSHBxTDh2NTVUWElUU1pjQTFRR1JrbGdZTXNGa1gxVTRoUFdOcEh4T0R4?=
 =?utf-8?B?UFdlREpQUExRYU42bWJ2ZzBjZzNoaGRqcXlQYVphWFlDVXkrL0lJcmsrdTYr?=
 =?utf-8?B?bktjTVZNYXFpN0FaMWpsUkFVTmVjdkp1SUVmTkJVaXIvajhEZ1NZaFcrdWpJ?=
 =?utf-8?B?ZUNYdHdYVGhpVHpYQU1uNnM3aGNOTytPZmtjdVRoV2dyNmpJWEo2a09rNVlh?=
 =?utf-8?B?cHo5UFVBdU1MU2kxUHJNMGtteStXQVVyMnEydzVSdVQxalNzWTRRY3RvRFVE?=
 =?utf-8?B?UnVEdDR0dUU4OTUyaDErOTFtQzBCaStKOWdVWUVWMFBROVloVlF0elFGZVlH?=
 =?utf-8?B?blc0WFh4OC9uMXg0c3pXU1UzNEY4LzF2L1MyT2Qvb0ZWTWVEb0libXVSOEh2?=
 =?utf-8?B?OUsybC9TQzlTRVhvRmEzNGg4Y2t0MWJ2TTI0VDdRdUl4dW80WEtYano3cnE3?=
 =?utf-8?B?N3NnanhmTE1xZGIyK3ZBVHQ3cEdoSWZCTWE5eWFmSFRackl5OE91TTlUeDNx?=
 =?utf-8?B?eXdtL3NVTE9WVzU0aVhvMEpjUWt2bkE5YlZQWnZha2ZYdG1ZNU4zbnVRQTdF?=
 =?utf-8?B?RUNybXVVbGZnT0hLamhzRFRuQ2IzTmRXdVJVV2tSei8rZEZDTkJwSnk3U1A2?=
 =?utf-8?B?RmQ5YVpGSGtWL2hwNi9PMEFGMGRDS3NnelBLeXRXOGs2UWVLTVpPUmNTbHRO?=
 =?utf-8?B?NmZkYWhuRkRTVEZVZmRkczJTdVNUWnd4b0FGUkhnVDRWMVU0VzFQaW1WMTNq?=
 =?utf-8?B?amlzYkVHNEtlbU54VGVHVWFjTlFPZE05cVVsanpHNjBlVFFFc3E5dExUWlFI?=
 =?utf-8?B?aHJVd21kZjJvQ1VwZkpabml5OFIrV2RlTS9hTTMzTHpGaTlqSUZvbmNYMXp2?=
 =?utf-8?B?VTNSSUU0b2k3MUl1YW9wdm9hSXMzSTJRZTRDcllFRjk5QkRNMVpBS3VPVnRT?=
 =?utf-8?B?ODJMSFEvTXhCYzlPanpUREtpQTlaWXIrZW9SZnZvSGtNMGVFS0ExV3h2ODds?=
 =?utf-8?B?SHRlY0l1M1lSb1M3cFp3ZnBwdjNEeW9LRXhaZ1RQVnZZY3JLWnRJcUdIalM5?=
 =?utf-8?B?TDU3QnArbUNTcmRWTUFWNk5mZ2pHZjBaSGZqZUhoNklLZmxCQklnZi9MdDNI?=
 =?utf-8?B?aHhUQ3VwU2hwQkJIV01qWlNYREVFSCttbzhiSEtuSzR0V2o3SFdtTGdldmRQ?=
 =?utf-8?B?MC9iOXFOd1l4RzNVZG0yM0RvbnpKVGxDTGRUQjJQdXE1bXh0VUtsOXF2UWJy?=
 =?utf-8?B?VHNtSVdFL1FwR0RXQ3Q4ZnpuM09mcEhOVkVGK1ZaTm9sbzdXdW45MkRjS0Ir?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17BB877B2A11D048B21835658214314E@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1310bafd-f6c5-4a48-534b-08ddb475afc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 05:52:50.9006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6LEcfTnO6U6Cp4CzzF+pDKLO9U5mWCHpmcFuLccO1evqM9YIJezhV/30PQJmm+7m1rGCc2Dt1kVKFk75mdkILA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5710
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA0NCBTYWx0ZWRfXzbc3rj/6wdti b60xLljQ8islvEzo6uYNmrLJl6lPWk/11I7bKPGi3Abnxog/yUM1N4Qhm+GZ4qfBJrfQ4D3InTg h8zFTj2tpBr6NcK+croWdIssu0bsTHWTlfcXHwosEr6BeTJlVOygIOoxOYY57Z4TnInJkJMryiw
 EBYnqMmVRuyWAlXM+O+dbbpODXBwnuiw2Xc+4g7E1vBY+X7WOSrjBSgfeidmYCXcEZMhmGSTRkm xmRU6xqGedi5F4e7VjvJ6uNnu0qvyaKN9A451q68VKjOEIIHCD77JVwMx7dPFTXikv90Jm1BLm/ L7zrZ2t5s1gej50Uk/Voouec9SUNHVsjx4iTWtDrud8Ycw1G4v+IluLOuZuJ8s2dnS7UcRhWZfS
 j2yytlCXoqiL+w87YqPZBHUN88nFkOQsnhpCPO1tks6oiUk6dImXG4HKhPUhsxNYhXs42Lxf
X-Authority-Analysis: v=2.4 cv=NszRc9dJ c=1 sm=1 tr=0 ts=685ce036 cx=c_pps a=03dc8DiCQ5tutR5iy+e8mw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6IFa9wvqVegA:10 a=us-pL2fu8_Z2obc_QGQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: W9tkZDRwmUWBw5mht5B6b1kay5wDDAcK
X-Proofpoint-ORIG-GUID: W9tkZDRwmUWBw5mht5B6b1kay5wDDAcK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_02,2025-06-25_01,2025-03-28_01

DQoNCj4gT24gSnVuIDI1LCAyMDI1LCBhdCA2OjA14oCvUE0sIE5laWxCcm93biA8bmVpbEBicm93
bi5uYW1lPiB3cm90ZToNCg0KWy4uLl0NCg0KPj4gDQo+PiBJIGNhbid0IHNwZWFrIGZvciBNaWNr
YcOrbCwgYnV0IGEgY2FsbGJhY2stYmFzZWQgaW50ZXJmYWNlIGlzIGxlc3MgZmxleGlibGUNCj4+
IChhbmQgX21heWJlXyBsZXNzIHBlcmZvcm1hbnQ/KS4gIEFsc28sIHByb2JhYmx5IHdlIHdpbGwg
d2FudCB0byBmYWxsYmFjaw0KPj4gdG8gYSByZWZlcmVuY2UtdGFraW5nIHdhbGsgaWYgdGhlIHdh
bGsgZmFpbHMgKHJhdGhlciB0aGFuLCBzYXksIHJldHJ5DQo+PiBpbmZpbml0ZWx5KSwgYW5kIHRo
aXMgc2hvdWxkIHByb2JhYmx5IHVzZSBTb25nJ3MgcHJvcG9zZWQgaXRlcmF0b3IuICBJJ20NCj4+
IG5vdCBzdXJlIGlmIFNvbmcgd291bGQgYmUga2VlbiB0byByZXdyaXRlIHRoaXMgaXRlcmF0b3Ig
cGF0Y2ggc2VyaWVzIGluDQo+PiBjYWxsYmFjayBzdHlsZSAodG8gYmUgY2xlYXIsIGl0IGRvZXNu
J3QgbmVjZXNzYXJpbHkgc2VlbSBsaWtlIGEgZ29vZCBpZGVhDQo+PiB0byBtZSwgYW5kIEknbSBu
b3QgYXNraW5nIGhpbSB0byksIHdoaWNoIG1lYW5zIHRoYXQgd2Ugd2lsbCBlbmQgdXAgd2l0aA0K
Pj4gdGhlIHJlZmVyZW5jZSB3YWxrIEFQSSBiZWluZyBhICJjYWxsIHRoaXMgZnVuY3Rpb24gcmVw
ZWF0ZWRseSIsIGFuZCB0aGUNCj4+IHJjdSB3YWxrIEFQSSB0YWtpbmcgYSBjYWxsYmFjay4gIEkg
dGhpbmsgaXQgaXMgc3RpbGwgd29ya2FibGUgKGFmdGVyIGFsbCwNCj4+IGlmIExhbmRsb2NrIHdh
bnRzIHRvIHJldXNlIHRoZSBjb2RlIGluIHRoZSBjYWxsYmFjayBpdCBjYW4ganVzdCBjYWxsIHRo
ZQ0KPj4gY2FsbGJhY2sgZnVuY3Rpb24gaXRzZWxmIHdoZW4gZG9pbmcgdGhlIHJlZmVyZW5jZSB3
YWxrKSwgYnV0IGl0IHNlZW1zIGENCj4+IGJpdCAidWdseSIgdG8gbWUuDQo+IA0KPiBjYWxsLWJh
Y2sgY2FuIGhhdmUgYSBwZXJmb3JtYW5jZSBpbXBhY3QgKGxlc3Mgb3Bwb3J0dW5pdHkgZm9yIGNv
bXBpbGVyDQo+IG9wdGltaXNhdGlvbiBhbmQgQ1BVIHNwZWN1bGF0aW9uKSwgdGhvdWdoIGxlc3Mg
dGhhbiB0YWtpbmcgc3BpbmxvY2sgYW5kDQo+IHJlZmVyZW5jZXMuICBIb3dldmVyIEFsIGFuZCBD
aHJpc3RpYW4gaGF2ZSBkcmF3biBhIGhhcmQgbGluZSBhZ2FpbnN0DQo+IG1ha2luZyBzZXEgbnVt
YmVycyB2aXNpYmxlIG91dHNpZGUgVkZTIGNvZGUgc28gSSB0aGluayBpdCBpcyB0aGUNCj4gYXBw
cm9hY2ggbW9zdCBsaWtlbHkgdG8gYmUgYWNjZXB0ZWQuDQo+IA0KPiBDZXJ0YWlubHkgdmZzX3dh
bGtfYW5jZXN0b3JzKCkgd291bGQgZmFsbGJhY2sgdG8gcmVmLXdhbGsgaWYgcmN1LXdhbGsNCj4g
cmVzdWx0ZWQgaW4gLUVDSElMRCAtIGp1c3QgbGlrZSBhbGwgb3RoZXIgcGF0aCB3YWxraW5nIGNv
ZGUgaW4gbmFtZWkuYy4NCj4gVGhpcyB3b3VsZCBiZSBsYXJnZWx5IHRyYW5zcGFyZW50IHRvIHRo
ZSBjYWxsZXIgLSB0aGUgY2FsbGVyIHdvdWxkIG9ubHkNCj4gc2VlIHRoYXQgdGhlIGNhbGxiYWNr
IHJlY2VpdmVkIGEgTlVMTCBwYXRoIGluZGljYXRpbmcgYSByZXN0YXJ0LiAgSXQNCj4gd291bGRu
J3QgbmVlZCB0byBrbm93IHdoeS4NCg0KSSBndWVzcyBJIG1pc3VuZGVyc3Rvb2QgdGhlIHByb3Bv
c2FsIG9mIHZmc193YWxrX2FuY2VzdG9ycygpIA0KaW5pdGlhbGx5LCBzbyBzb21lIGNsYXJpZmlj
YXRpb246DQoNCkkgdGhpbmsgdmZzX3dhbGtfYW5jZXN0b3JzKCkgaXMgZ29vZCBmb3IgdGhlIHJj
dS13YWxrLCBhbmQgc29tZSANCnJjdS10aGVuLXJlZi13YWxrLiBIb3dldmVyLCBJIGRvbuKAmXQg
dGhpbmsgaXQgZml0cyBhbGwgdXNlIGNhc2VzLiANCkEgcmVsaWFibGUgc3RlcC1ieS1zdGVwIHJl
Zi13YWxrLCBsaWtlIHRoaXMgc2V0LCB3b3JrcyB3ZWxsIHdpdGggDQpCUEYsIGFuZCB3ZSB3YW50
IHRvIGtlZXAgaXQuIA0KDQpDYW4gd2Ugc2hpcCB0aGlzIHNldCBhcy1pcyAob3IgYWZ0ZXIgZml4
aW5nIHRoZSBjb21tZW50IHJlcG9ydGVkDQpieSBrZXJuZWwgdGVzdCByb2JvdCk/IEkgcmVhbGx5
IGRvbuKAmXQgdGhpbmsgd2UgbmVlZCBmaWd1cmUgb3V0IA0KYWxsIGRldGFpbHMgYWJvdXQgdGhl
IHJjdS13YWxrIGhlcmUuIA0KDQpPbmNlIHRoaXMgaXMgbGFuZGVkLCB3ZSBjYW4gdHJ5IGltcGxl
bWVudGluZyB0aGUgcmN1LXdhbGsNCih2ZnNfd2Fsa19hbmNlc3RvcnMgb3Igc29tZSB2YXJpYXRp
b24pLiBJZiBubyBvbmUgdm9sdW50ZWVycywgSQ0KY2FuIGdpdmUgaXQgYSB0cnkuIA0KDQpUaGFu
a3MsDQpTb25nDQoNCg==

