Return-Path: <linux-fsdevel+bounces-73480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC17D1AAC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 18:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB5683040656
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA3E37FF7C;
	Tue, 13 Jan 2026 17:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QAmP2qKs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197727E07A;
	Tue, 13 Jan 2026 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325788; cv=fail; b=d6PcgPmdl7dFw97DyJehAEvyEuGxFOxOmsX1qY1gOVPUNlRT9gxk+kWiTL9xeZdeTE455O0v8z3IeRmaToBYxslWBmytwwDj1qcEAtFpqVqujeij5asPTZN5FWwveShQnWtcHD7LDoqZSUw4WZE/TCfkZAD8n4REHy8uoQ+6y+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325788; c=relaxed/simple;
	bh=iZEUpwtaXEQN7VDpEKw8kIes1QluY11RiwoEHeYJtq8=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=sVUXLdEUZHBrKGguaMfU5ZeMPZyivnxSkN7b898oQZ54XrLi0sz2s2O5G7tZ/d5sYRosK48qmg1yQgY1WCF3f9O7JuvKcPvaVccYAVrIOgUkURA2GvI1J/6es3qkuQSrJpuhMfcUaMy1lnowl88B7N4+IhDw3kpFWpp4bPawdzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QAmP2qKs; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60DGQsQG028413;
	Tue, 13 Jan 2026 17:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=iZEUpwtaXEQN7VDpEKw8kIes1QluY11RiwoEHeYJtq8=; b=QAmP2qKs
	Zhn9kQwDU0SRdJTZyEGfX6tBN+vzkVaZXej6mBnsNBbwiZj1v3l2AYVUDD7jiyCF
	jL0qf8ic/bLhCl+WcfH37gLWez1CbL83EruHcLOeHUl6G1hxZvGxjEbNcjJTkdwF
	fhlVHtljtOHCJ9L+6XzWG+N+eh0WY/rLO5YjHQnJ4Atoeloq8H7KEBl3Cz3TcK+o
	7o4l8MiThNix0HNJpaaajRwKGYyy3u9jX5ubICvWH6HYIuybiEEAAFkQ5VPQJ3H+
	dTUZCBQeTuYrq6zZ1qRkDQ2HnXMQwpeK2swmoQ4sRFfQ36rzQw7lplm4+1MUdDIc
	3L/CprS15UCRbA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedswcqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 17:35:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60DHLSsk007794;
	Tue, 13 Jan 2026 17:35:27 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedswcqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 17:35:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGXK0cvktTluud5J2QCOEoeKYYgp14IZzIpsShcTkbdvtz68EsIEgU920+HiYYRXcJLlfwiXJ6mAyi5Q1Bh0GKXkboYrJ6dkXeNFB2Fehh6gpO7TGmHAbvTtqiph4f9qLq2TBKhTpju2stXaGVosm8QsiUJKfYRqdSNKThic5FFRrPUEQLJJ7tyYn9Vp+QtRv6NsMF5/cEmlaNz5H6dmRFofIjEMsdfHQioFYakaHAABg0xdoYfjocfX18mDmY5AiQH49venIRzUK/Bvdw/nUNs2Tj52zJsb8+q6zghZvo0PNhyQ0EAnptB9pdDriwzPkn6cUZabVMVz0q82ifrDjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZEUpwtaXEQN7VDpEKw8kIes1QluY11RiwoEHeYJtq8=;
 b=mUG7kSKL0ujQDBFH7Y1WhU5w4p/t4CC9Yme2LIId99+Zd/hrCb54QS+n52JJLbw+4KcrsqfjxXEPpcmkRsE+UdWayNUpKcfgchHOFSEcYfP8N4qu2KswdFEN+bK4YResjkUEI4YkSGnTsiuRZ8Gg5crmfIW1i5r+e3BN9KwIkO9rQm4TjwJnu+7yVABGNyGTu6cx/a38ZSSPCBTuZrkm34x0BJJmRpI7M6uJrd6Swm5DmPYB+/geJLUgsuusMZUxuX3Chnldjg4SQwZy/IU1pr5pUuSAUJ4dAjFbEzTclvPItkw5uBx9hGrkH3gLoJtZ8IfyVQywlDr6TB7aJmV5ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DSWPR15MB7111.namprd15.prod.outlook.com (2603:10b6:8:35f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 17:35:25 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 17:35:25 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "cel@kernel.org" <cel@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "vira@web.codeaurora.org"
	<vira@web.codeaurora.org>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "chao@kernel.org"
	<chao@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>,
        "pc@manguebit.org" <pc@manguebit.org>,
        "yuezhang.mo@sony.com" <yuezhang.mo@sony.com>,
        "almaz.alexandrovich@paragon-software.com"
	<almaz.alexandrovich@paragon-software.com>,
        "hirofumi@mail.parknet.co.jp"
	<hirofumi@mail.parknet.co.jp>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>,
        "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "trondmy@kernel.org"
	<trondmy@kernel.org>,
        "cem@kernel.org" <cem@kernel.org>,
        "ronniesahlberg@gmail.com" <ronniesahlberg@gmail.com>,
        "jaegeuk@kernel.org"
	<jaegeuk@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "adilger.kernel@dilger.ca"
	<adilger.kernel@dilger.ca>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "sprasad@microsoft.com"
	<sprasad@microsoft.com>,
        "hansg@kernel.org" <hansg@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>
Thread-Topic: [EXTERNAL] [PATCH v3 05/16] hfs: Implement fileattr_get for case
 sensitivity
Thread-Index: AQHcg+0IgRrKj/Abv0iKtm6PB9Dwb7VQXhWA
Date: Tue, 13 Jan 2026 17:35:25 +0000
Message-ID: <45b21443e42ac3fd009c8e6ab2caf5b02d815c72.camel@ibm.com>
References: <20260112174629.3729358-1-cel@kernel.org>
	 <20260112174629.3729358-6-cel@kernel.org>
In-Reply-To: <20260112174629.3729358-6-cel@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DSWPR15MB7111:EE_
x-ms-office365-filtering-correlation-id: 36f395a0-e249-4a88-3b7b-08de52ca22e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q1lhUXBZQU1RbmFXWE1CWXg1UWhRQlcvUTBhSFl3SDEwODJVTWNFSjNYK2Vs?=
 =?utf-8?B?QnVjWkVpcGg2NFA3SDM1ZStNYzN5bEFhOFFHNC9uYzZBZXlxb0tieU1GNTI0?=
 =?utf-8?B?Sm5JMVpjbXFYY09uNFUrTHhFYkUvbTFnUENiNTYvVjd2R2FUWWU4cmZrVHpw?=
 =?utf-8?B?SHljU1ZSdlV5aElOQ2xLU2NNMnNFVFV5THdyc0IrTWFKcXkwTkEzK0ZPMm9a?=
 =?utf-8?B?UkJWdjJZZGpobTRhYVJXVkZGSU9wN1FvZENwRWNaam54ZHRzTnRJaFVnTStH?=
 =?utf-8?B?RzhsWEx1TTJ3bGNJRGpldzZLaGZwWXYrUEo2NVZOZW1KKzJOZnVKYzBGejJu?=
 =?utf-8?B?QVNxdC9YL2RPb24zRnRmR21YQkQ1R3RROGdOOTI2KzI2eHJyK2JESFpJczJa?=
 =?utf-8?B?YmYrR0toZVBISTlJY1p2eVp2SE90TXlqLzNma0wwZXlZRVlhdjEyckoxdGtY?=
 =?utf-8?B?b2FOQWlXQjZqTVJzcU45UDhBWGlkd0lNMlFmYVdWVXRhS2k1djAzazlZYmVz?=
 =?utf-8?B?dG1nQU5ZRnlDQWRHeWhRdEhyWDJCQmt4anRsRTBDNk16VjFzRENkZFBsY3pJ?=
 =?utf-8?B?cWJMa29xM1BrTVB3Q1AzbzJTUjkwd3FNSnllRjJ0QzFVSkxjTEtSVmNSQlYw?=
 =?utf-8?B?bXlXVGNuQkFHMG1ZVWxxNmU0eExIaUYrRHZpVEhYbk1mMW81K1djQkYrOVc1?=
 =?utf-8?B?REVJYzhNcC81dnNNblZqZG5YRnR0azFtN1R3VTM5V2dlMGlQNm5DM2wxd2Nu?=
 =?utf-8?B?ZDV4RjdXNXBwSEtjOGlLK0RScDRlMElTV2dnK0Y0b3lQeGVjVkVuNS9CVWhj?=
 =?utf-8?B?Y3Jvbnpmb1BKL0hGZGpCMHUxOG1xTm9hNjJUQXBrbzUzY0VkZ1BiTExQTDVT?=
 =?utf-8?B?RFlzWGFrc2p3Ly82V1dDRDVaVXVYYjlyV0xRZTd4SFc3Zy9tam1lem5BZUw3?=
 =?utf-8?B?QTlwbzhVZ2dSeWl6Nmp6cTVRSzdBSGUxM2dLWEduUGp0NFJFZTB3VUhCRWdi?=
 =?utf-8?B?TVIwWkZRaHl5Z0M1V3RIL1BpOUhCVzRURUh5djJtcUs0K21KVEgyUWVsS0lr?=
 =?utf-8?B?dHdydFAyWnphUmZZS05hTS9zZ01ueFhRRC85b0d1MFVZWUxkWFR6WWhTZW5J?=
 =?utf-8?B?U0VrcUZ1N1o4eVc0blgxUDBBaklscFBwR0lNMWlFbUd5T3h0WFJTemRpNVVW?=
 =?utf-8?B?RmIyUjkrYzdVTTA3QkRXQUlxU05aRFlkRXdhK1hMMnBlZjJHajFxUjBnazJS?=
 =?utf-8?B?TE1zT3Yvc0RzZW5LVlFTYytoTVBUVUcrbHhuZktncjZoRzM1OGJMVVVCZ1Rh?=
 =?utf-8?B?bHBwNGgvQkxnaW1pWjhzZUpIVm0zRmRydy9STDBvUENaMFRZYkxuTGthQk1p?=
 =?utf-8?B?QnhSTmpyU2ZreC85cG1iN2JMaWdJNDZub1ZFZmtvU3VjVzlOZVdnejg4cWlo?=
 =?utf-8?B?Mlh0WGhzOWc1cUo4bExQc1BQK1FnM1pvOXdkWVZKWlRJb1NiNUkwV0ZpWjRP?=
 =?utf-8?B?ZzEvZU8rUy8yZmxJbE9VRjJtTWdjSmxCdXVvRzVVSlVKUTQrSkE2SGZJcjdE?=
 =?utf-8?B?ZThvcWNqMUNJdHloSG5oY0NwZmV1SGoxVUNTSDBFK2ZBaG9MNTlxNm5kcFVs?=
 =?utf-8?B?MEZpZTdjWnpad3I2dVlRQ2pKdnZhTnI3RG9NY1k5QnZWbHNKQThaOFBEeHVT?=
 =?utf-8?B?bWhHeFpIeFFLaHlQY2E1R1VFVk1hRlNTR1c0NFB5c3k0Tk9WdS9ocVBRNXJC?=
 =?utf-8?B?R0Y3QS9iSThFc1VYblBmOTM1Y1k3WDJSQlhVcXNsN3RJV25MR3ZXbHdHeFJp?=
 =?utf-8?B?WGNzVEZpdFdZYW5NcXk0N1NvVURMZ05vbitDcWtQNWhzV1FScFVpUFJKM1dX?=
 =?utf-8?B?YlJZaVh3Zkt5WXFpV1dOb3hjZ081WW1wcWlVWDJmV21xWFRWQlJ3Tm02VkQz?=
 =?utf-8?B?L2tMZEpWVjd5ZE5rS0Rtazg4TDdOQ2IyQ3F2OXlMMWxKNFRMTzNJVlBSRElw?=
 =?utf-8?B?K204YTMrRndFelE5b3l2SGlCYUg1NW5PQjZQYkZYd214QVJDcGpMMlI5ZE1Y?=
 =?utf-8?Q?XrDxVV?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0JWa09aNGJNdTdNR2hTWjNMRXlKQ2hSRHM1ZEdDUFBkOGVlc3Z6Z2Z2TWlw?=
 =?utf-8?B?VlF6L2VYV3BIUU9tYzNSYnM1MnZ0MmoycFNDYzhGZTZmU3pMZ3ZhdVRwMUJa?=
 =?utf-8?B?RUllbHBnMXdGR3pWTEJ3RCswOUlVT0lBM2FvNTFLbmtaQUYwaFRSdFdZUmov?=
 =?utf-8?B?NzNZOUlJWnlrUnJWU2xpa3djVmJmQTJxdjZjVkpMSkNoYWE5bm8xUEFxODRz?=
 =?utf-8?B?Q3h2dHJ3dEtPU2E5WWRVNTFBaEtpanB4NUlaZFgrdWxKYy8zbkpNK2tRdkN0?=
 =?utf-8?B?NUdkVVdUSXduTkpPNnVFazFqTGlZL2JzZGcvTVY3NTRkRXBDcENIN0MzcWEy?=
 =?utf-8?B?QnhXa0dpNENrM3lMVE81ZnZ6OFRNRnkydXZZZ095RVdYU3FQeXNCbVZSN3BT?=
 =?utf-8?B?TWJNN3QvMXlENHdQcVFZYlhPWTJRcUJDb29iMU9Qa2dNdzVPZTYyY21jWmU5?=
 =?utf-8?B?QlRhWi9iQmhpMmk4bjhlSFNVSTlONHJUZ2lVVFAwZFZERDk4WG94WjF5Vkl3?=
 =?utf-8?B?UmR6ejBsTytwNWNGSmV6cTNPUHp4enhjWkxaK0Q4QitES28rY0luU1VjRFUx?=
 =?utf-8?B?eUZBaW1kQlI4K0N1ak5Oc3Y1cGJuTU9JS2IxQjhFRWRSQlJPNG5oaVdoenkw?=
 =?utf-8?B?cE9IWEJEVzJHeVZ5Q1JnU0d3VEJUcVk5aVh1U1NvK3NRbUNCU3daQ3BRMUgw?=
 =?utf-8?B?clY2NUI4SS9oZll6ckorWlAxZ21kcy9vZ1dIbENYbnNuVlhTZUJDM1pBWmth?=
 =?utf-8?B?amdJWHpFZXNyanhlVklBZ3RaTHBJSlBpWGdnVmI2eHEyamtQMEcrNzg3R3l6?=
 =?utf-8?B?MWt6SXYyaDJNVG9QREE4bjlnNGRrcG9mVERkeEtIUm1DTXhnTi91WnZEeFRS?=
 =?utf-8?B?dURtcGFPR2ZsWFZvdjNKVVhiWDVSSVNGc0NhWFdGb0gwZERiZXY5ZFUzQ0lY?=
 =?utf-8?B?aGpuNHA2WWVLTjlpdmk1U0FRd0hWcFhXWnQ1ZFlqUm54eWtEZHV3Wk5BWG9P?=
 =?utf-8?B?Ui96NjN6Q1Y3MDVVRXlRTytDVzJrVlJiVmdrVmlMcXZTZHNWTlNNOFhJcng0?=
 =?utf-8?B?UDFaNTV2aUFnQ3FJM0JaazVIVTczeFA2bzM1M05jK1JwWSsyV3l0OGJ1T1I3?=
 =?utf-8?B?VmtrVmpOckdBVG1wcEdldFZVWjAycUIybGs0am9uZTRqTUVzUlNCTEtZbTlO?=
 =?utf-8?B?TEwrWWJxc0VZMm9JMDRVY2VFVndienNuNkJZRVhSdFhTV0F2SDFsVjhlb0Rp?=
 =?utf-8?B?dk1SMTBFd0NubFdoeGszTmxrUFE1azVUWldxeXgySkpxeS9CemcrR2RtSldD?=
 =?utf-8?B?bW5LTS9qUjFEeHc1V091c2J4c3JDQlNXWGVnVGd2L1cvZjFGQWNUSWhZbnBL?=
 =?utf-8?B?K2c4b04wakVBZHBBTytxWFdob2w3MEtaMlVlblpjS2t4NnFvMWU0SXR0RGd1?=
 =?utf-8?B?QkxkbVh2bndweVBQamZNZnZxcjdxcVNyTWpHSmdCSXptYTd1Yjd6cktsRmxR?=
 =?utf-8?B?ZUNSTXhKZ2psTHkwRFR3V25jdHlrd1pOakRRdVFWaklKdGx5VGdtRGVKTURk?=
 =?utf-8?B?YThIcGFmSi9NWmkzQkQ2NEVPaXJGQmpDMFVJTUNGaW5icW1MQXRiNFRESG1j?=
 =?utf-8?B?K1ZaSzdIU205ZlYybHNBSHErTUZ4RE44MVNtUnJUb0YrR1M0eVJCOVQ2aWxq?=
 =?utf-8?B?VnVqT1pKcUFrdyszNDNnZlh5cTFIQkNLQVBrM3gvQnF3T0FTVlZESjFqWEY0?=
 =?utf-8?B?SXFNZHdIVmorQzh5bzdIWDRSTWtSUnFuR2JnVng0YXB1RlFzRUczSWtTbDY5?=
 =?utf-8?B?TDhKSWM0MHJNdmxyZTVkVXR1UmNsQW9EZ2tJTVhLNjBIWmVMc2FGL1ZTTU12?=
 =?utf-8?B?UGN3RHMzM0UzTmJIS05vWE0yczB5ZGNGSDdPOStZOEhhM3JlZDVMWEY2eHYv?=
 =?utf-8?B?RXdwM2ZhMldDa3JNYnh5TU9iNmFnOG5KcDhBaG1EKytyOGI4Ri9RQ21qeitO?=
 =?utf-8?B?TXdvTm9uVUtRSHhjRWY1ZlpFVk1WckVkN0ZSbitJTHNNdWZONnJmaHEwYTZU?=
 =?utf-8?B?MWxuOU8xd3FvdHd5YnV5WnkrUk8zWjJSZGVRYVZ1ZmRKN0FWUUFNejdFVHZn?=
 =?utf-8?B?Y2s0K3lZVkJvWHMyeUp3b1hFMUtCQWcxVXVvZnVTckxmdE9jS3llSlJnMWtV?=
 =?utf-8?B?NHlvSzh0RDJlUGlmTGtMdyszNTNuZ3NQU1A3YlZjTDBMZTM3MW9jeWZSalRk?=
 =?utf-8?B?Qzd6VUJvODNLRmVkSlNxZGFsMWk2UmhvZkRraFZ1SDFOeWFsTmk2UDFLdGNU?=
 =?utf-8?B?bzFRaTU4ZUcwL3Jhb3dGRmpPYVJUbDlxN2lqRjJ6aG1wMmViU1pGaGRRN3hi?=
 =?utf-8?Q?/b+yQqOW4X5fQ6MjWLquA0iW+y7iRgfbs0FOt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1126D21D7A9934C96B15943F960AD5E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f395a0-e249-4a88-3b7b-08de52ca22e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 17:35:25.4863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /TiVS2F06MbjaVGEeBBO226V+3Q/3R9e06sPAjNZlIZWmQh6UfXHZsxjc9cRhzesbahlNTjGp7dVscFh8aVWiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR15MB7111
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE0NCBTYWx0ZWRfX5M/iFL+zJ7ZK
 BujNO5gqjO49eDU7yg3/YCR9JeyQejqgbdyltd9kgLdGDrqHIN4+q4HyaDsvlMFdjEzseANX7sk
 bkWAM4sE2tAOTMLu+QYxKWpT76AORh4yRKIhXN/+1IXu6KFOGijU4gCbcADBRpIN5PtVNM4EGae
 LMNzZTfukDdJGMWbFoIQHKNLl39EVh0mLBo2psPuczZQBFBgfPadPlhZRQphy/G7/7N1Q3MQItL
 eDPP77yT6lNZeaVQdxGpgcqUyUwR8NWbh01Tw5fztpJBicpMKkcUdgUy6fPXQ0fdpWHgSek5SKP
 A41IV35o6Cw0Bt2FGimL+mLptw50cIiX0eZjJEnargwU21F3L66o/j3rozUYoVg/F8+1iNdbv3e
 1cK3Den000/GFiUBOpf6CVksWisieSpWpo4ddpOLRoPSoOE2UJStH2n7c8UfdVcyoJcDQbYOX0v
 IrJ/3PmL2TC6fTvzsRQ==
X-Proofpoint-GUID: Z-7BusmsTkJgXLEFNWl6JD12l4F9PQoq
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=69668260 cx=c_pps
 a=ggyiYYPOIDPuJa++h0h3+w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=wCmvBT1CAAAA:8
 a=tLsQUzVSC0ZAzv3t7DcA:9 a=QEXdDO2ut3YA:10 a=6z96SAwNL0f8klobD5od:22
X-Proofpoint-ORIG-GUID: jqhDSxE9V8sAfBdPT_1UWngFRoCD5ipD
Subject: Re:  [PATCH v3 05/16] hfs: Implement fileattr_get for case
 sensitivity
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601130144

T24gTW9uLCAyMDI2LTAxLTEyIGF0IDEyOjQ2IC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
RnJvbTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+DQo+IA0KPiBSZXBvcnQg
SEZTIGNhc2Ugc2Vuc2l0aXZpdHkgYmVoYXZpb3IgdmlhIHRoZSBmaWxlX2thdHRyIGJvb2xlYW4N
Cj4gZmllbGRzLiBIRlMgaXMgYWx3YXlzIGNhc2UtaW5zZW5zaXRpdmUgKHVzaW5nIE1hYyBPUyBS
b21hbiBjYXNlDQo+IGZvbGRpbmcpIGFuZCBhbHdheXMgcHJlc2VydmVzIGNhc2UgYXQgcmVzdC4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29t
Pg0KPiAtLS0NCj4gIGZzL2hmcy9kaXIuYyAgICB8ICAxICsNCj4gIGZzL2hmcy9oZnNfZnMuaCB8
ICAyICsrDQo+ICBmcy9oZnMvaW5vZGUuYyAgfCAxMyArKysrKysrKysrKysrDQo+ICAzIGZpbGVz
IGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9oZnMvZGly
LmMgYi9mcy9oZnMvZGlyLmMNCj4gaW5kZXggODZhNmIzMTdiNDc0Li41NTIxNTY4OTYxMDUgMTAw
NjQ0DQo+IC0tLSBhL2ZzL2hmcy9kaXIuYw0KPiArKysgYi9mcy9oZnMvZGlyLmMNCj4gQEAgLTMy
MSw0ICszMjEsNSBAQCBjb25zdCBzdHJ1Y3QgaW5vZGVfb3BlcmF0aW9ucyBoZnNfZGlyX2lub2Rl
X29wZXJhdGlvbnMgPSB7DQo+ICAJLnJtZGlyCQk9IGhmc19yZW1vdmUsDQo+ICAJLnJlbmFtZQkJ
PSBoZnNfcmVuYW1lLA0KPiAgCS5zZXRhdHRyCT0gaGZzX2lub2RlX3NldGF0dHIsDQo+ICsJLmZp
bGVhdHRyX2dldAk9IGhmc19maWxlYXR0cl9nZXQsDQo+ICB9Ow0KPiBkaWZmIC0tZ2l0IGEvZnMv
aGZzL2hmc19mcy5oIGIvZnMvaGZzL2hmc19mcy5oDQo+IGluZGV4IGU5NGRiYzA0YTFlNC4uYTI1
Y2RkYThhYjM0IDEwMDY0NA0KPiAtLS0gYS9mcy9oZnMvaGZzX2ZzLmgNCj4gKysrIGIvZnMvaGZz
L2hmc19mcy5oDQo+IEBAIC0xNzcsNiArMTc3LDggQEAgZXh0ZXJuIGludCBoZnNfZ2V0X2Jsb2Nr
KHN0cnVjdCBpbm9kZSAqaW5vZGUsIHNlY3Rvcl90IGJsb2NrLA0KPiAgZXh0ZXJuIGNvbnN0IHN0
cnVjdCBhZGRyZXNzX3NwYWNlX29wZXJhdGlvbnMgaGZzX2FvcHM7DQo+ICBleHRlcm4gY29uc3Qg
c3RydWN0IGFkZHJlc3Nfc3BhY2Vfb3BlcmF0aW9ucyBoZnNfYnRyZWVfYW9wczsNCj4gIA0KPiAr
c3RydWN0IGZpbGVfa2F0dHI7DQo+ICtpbnQgaGZzX2ZpbGVhdHRyX2dldChzdHJ1Y3QgZGVudHJ5
ICpkZW50cnksIHN0cnVjdCBmaWxlX2thdHRyICpmYSk7DQo+ICBpbnQgaGZzX3dyaXRlX2JlZ2lu
KGNvbnN0IHN0cnVjdCBraW9jYiAqaW9jYiwgc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcs
DQo+ICAJCSAgICBsb2ZmX3QgcG9zLCB1bnNpZ25lZCBpbnQgbGVuLCBzdHJ1Y3QgZm9saW8gKipm
b2xpb3AsDQo+ICAJCSAgICB2b2lkICoqZnNkYXRhKTsNCj4gZGlmZiAtLWdpdCBhL2ZzL2hmcy9p
bm9kZS5jIGIvZnMvaGZzL2lub2RlLmMNCj4gaW5kZXggNTI0ZGIxMzg5NzM3Li4wNjQyOWRlY2Mx
ZDggMTAwNjQ0DQo+IC0tLSBhL2ZzL2hmcy9pbm9kZS5jDQo+ICsrKyBiL2ZzL2hmcy9pbm9kZS5j
DQo+IEBAIC0xOCw2ICsxOCw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvdWlvLmg+DQo+ICAjaW5j
bHVkZSA8bGludXgveGF0dHIuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9ibGtkZXYuaD4NCj4gKyNp
bmNsdWRlIDxsaW51eC9maWxlYXR0ci5oPg0KPiAgDQo+ICAjaW5jbHVkZSAiaGZzX2ZzLmgiDQo+
ICAjaW5jbHVkZSAiYnRyZWUuaCINCj4gQEAgLTY5OCw2ICs2OTksMTcgQEAgc3RhdGljIGludCBo
ZnNfZmlsZV9mc3luYyhzdHJ1Y3QgZmlsZSAqZmlscCwgbG9mZl90IHN0YXJ0LCBsb2ZmX3QgZW5k
LA0KPiAgCXJldHVybiByZXQ7DQo+ICB9DQo+ICANCj4gK2ludCBoZnNfZmlsZWF0dHJfZ2V0KHN0
cnVjdCBkZW50cnkgKmRlbnRyeSwgc3RydWN0IGZpbGVfa2F0dHIgKmZhKQ0KPiArew0KPiArCS8q
DQo+ICsJICogSEZTIGlzIGFsd2F5cyBjYXNlLWluc2Vuc2l0aXZlICh1c2luZyBNYWMgT1MgUm9t
YW4gY2FzZQ0KPiArCSAqIGZvbGRpbmcpIGFuZCBhbHdheXMgcHJlc2VydmVzIGNhc2UgYXQgcmVz
dC4NCj4gKwkgKi8NCj4gKwlmYS0+Y2FzZV9pbnNlbnNpdGl2ZSA9IHRydWU7DQo+ICsJZmEtPmNh
c2VfcHJlc2VydmluZyA9IHRydWU7DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gIHN0YXRp
YyBjb25zdCBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIGhmc19maWxlX29wZXJhdGlvbnMgPSB7DQo+
ICAJLmxsc2VlawkJPSBnZW5lcmljX2ZpbGVfbGxzZWVrLA0KPiAgCS5yZWFkX2l0ZXIJPSBnZW5l
cmljX2ZpbGVfcmVhZF9pdGVyLA0KPiBAQCAtNzE0LDQgKzcyNiw1IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgaW5vZGVfb3BlcmF0aW9ucyBoZnNfZmlsZV9pbm9kZV9vcGVyYXRpb25zID0gew0KPiAg
CS5sb29rdXAJCT0gaGZzX2ZpbGVfbG9va3VwLA0KPiAgCS5zZXRhdHRyCT0gaGZzX2lub2RlX3Nl
dGF0dHIsDQo+ICAJLmxpc3R4YXR0cgk9IGdlbmVyaWNfbGlzdHhhdHRyLA0KPiArCS5maWxlYXR0
cl9nZXQJPSBoZnNfZmlsZWF0dHJfZ2V0LA0KPiAgfTsNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3
ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8c2xhdmFAZHViZXlrby5jb20+DQoNClRoYW5rcywN
ClNsYXZhLg0K

