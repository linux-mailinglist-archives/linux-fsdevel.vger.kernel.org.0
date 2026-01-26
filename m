Return-Path: <linux-fsdevel+bounces-75532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFovEbbQd2mxlQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:38:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C42208D237
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 21:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E99C301CFAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 20:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDE32D7393;
	Mon, 26 Jan 2026 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pzAVbH35"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD22D6E75;
	Mon, 26 Jan 2026 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459855; cv=fail; b=YxYs1Hw/9pEqXgTi22c2zfbUMpiXdpW6GRYo4MuIpWTd+Nb3bL4cZaJYHzgzGE46h1zrcLMPfImDfwiuMoZcz2j3r7QCc5M3gkbJuPV+py9PA4zqIfK24TwqQ0ihTBoa2uLsazRWDMwrNNbFQO0Kon7b1slCY554ZOS1iVF8z/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459855; c=relaxed/simple;
	bh=lbeJktB2dgMHcCkea91nAhu46BsoZfTB0jOu/XxFg8s=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=KmCxPGnBqxU30xsUCinxcrA8QWnNENsnaKpXK+bXzVvD7+AAx/zFwI73VdboyWhy/KxG+O5NRx+VYmGp/RMug+Y5+ctnzmsotHIvDOW8HelfsHJgYmAmX2wLdjRYRW5sTygVfy4ESuW+9atfqjjBaa+OBVYD/bYCu/wR0MCY448=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pzAVbH35; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60QFbWEN011204;
	Mon, 26 Jan 2026 20:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=lbeJktB2dgMHcCkea91nAhu46BsoZfTB0jOu/XxFg8s=; b=pzAVbH35
	Lzy2Is2MZTI3Nn5GdPN30lVCUGNu9G08lB8H932asLQ2inYsJoL5p4fZ7lBP61mu
	vMdrtjwiKsG9YnJsFWJ9K3RPIzpiDRH6C9uCjyXruIYI7PqA/uspTFtLzBM37shj
	Y2W8NJI4DFLaUtEQWp4P+Xs23iSlJARGslvBIm7xcH0vswTxzX2uaqLEX/r1LDir
	wi5ISRAxMdvwYwYM8fC03zsxTlVvkJZi4din/wNCJsqvIAHhk7R2UHRNLvBzgeuR
	/xz7nM1fSwMzXF1cCemDasJyJLlRlYP6mwjLgawSmFXGvdfcOrWS0P2hAXoAtC5A
	FRwotgvg37LMoQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrt9wv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 20:37:27 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60QKX6Is000721;
	Mon, 26 Jan 2026 20:37:27 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnrt9wuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Jan 2026 20:37:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dajmzXvPCi16cBioeBDptP0bLfHB8PNkVz9owzEYV2ST0J1bho4Cb5pIkYv2UAO5d/XMa7B7OF968AzUM8o3AT5qCmeCj1qLF7l1Jp25yq5UuUJuiXWXDUPQ15QnlLsuOluzjzIVg9DyMtzHyQEa2H73NapZJlbvhZAFLrIV/N0DOye+BmkK9y8koD0OjUekFSCT2WARcSxuepwAf+Y30k1DbtxzxRyFaiogyDmGFjJ2yuPksmVmJjWGP6lRQYwZcESGjuI3S/ZeSl6REa5XYTjVc88uAxs1IhdWeLpZnyTgoALiR2mi4DAKqJt2dJI3gPym5sPclPjBABORU3H1xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbeJktB2dgMHcCkea91nAhu46BsoZfTB0jOu/XxFg8s=;
 b=t7ykkdrhmiob2qGfa0DrWw5XZgprLJS88743dhsW2ZQSuR6UygzPzCtGKcUKVqYfb+VHoiJz9TfHVLLT68IEucZmdQi09YfUfXDJapltgWJ+ovjscemTvwwvuJDfL5ziuhDqzOAIs/jHTFA2gybeFutjzxdB3M1fRfc2vhp38/jAvoHB2IRCe1NQ51zLg8ey4uygT7I9HBOQfB1spaF5aUQ0AsFD451YQVCnELoqwLr+9RaxcwTMFfSGG9LOsmbdb2GTp+/WzDZO55vk4z7bImrO8ZfUE6+HGQEnoLOryl92lmgyBwrGuNlRT2Rr91hrWpekktJJ5FLRE/CA8MkEng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA0PR15MB3856.namprd15.prod.outlook.com (2603:10b6:806:86::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Mon, 26 Jan
 2026 20:37:28 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 20:37:28 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "kartikey406@gmail.com" <kartikey406@gmail.com>
CC: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com"
	<syzbot+d80abb5b890d39261e72@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] Re: [PATCH] hfsplus: fix uninit-value in
 hfsplus_strcasecmp
Thread-Index: AQHcip7gBQv9tICp4U+VJX3elcUj9bVdDvkAgAHwkYCAAWlAgIAAOTuAgARP5AA=
Date: Mon, 26 Jan 2026 20:37:28 +0000
Message-ID: <31dcca48613697b220c92367723f16dad7b1b17a.camel@ibm.com>
References: <20260120051114.1281285-1-kartikey406@gmail.com>
	 <1bf327370c695a5ca6a56d287d75a19311246995.camel@ibm.com>
	 <CADhLXY5pVdqhY+cLze66UrZmy0saCro_mQR+APth+VC5tMEnjA@mail.gmail.com>
	 <88705e499034c736cc24321a8251354e29a049da.camel@ibm.com>
	 <CADhLXY6wFsspQMe0C4BNRsmKn2LaPaBFfOh1T+OBibuZVSo70g@mail.gmail.com>
	 <eefff28b927ccc20442063278e65155c1ed5acd8.camel@ibm.com>
	 <CADhLXY6fMO51pxc1P00F3g9PccNvXwOPd+g0FxeHq1FYGR3Xng@mail.gmail.com>
In-Reply-To:
 <CADhLXY6fMO51pxc1P00F3g9PccNvXwOPd+g0FxeHq1FYGR3Xng@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA0PR15MB3856:EE_
x-ms-office365-filtering-correlation-id: daea9955-77d7-4bc0-1691-08de5d1ab8b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bXBLRmxBbm44UjBYT1lzR3h2L29TMUlnNW5Mbm5OZE53R3FlSG9hNEJuZTlJ?=
 =?utf-8?B?ei9uZTRQZEJVRmZ2ZmhJSHVmeDdBVjdQUERUNStWNGlDYWZ5elRJQUxLT1VF?=
 =?utf-8?B?RXc5YjJJT2ZuVTNIWmE2K1dCbWtDT0lCbW9SN3EyR0VyWXNOajZJY0RWdnRl?=
 =?utf-8?B?VnlPczlNZzM4MVFESWhLYnFZeG9zTVR5Um4zZWlSY2FOcVVCTis5aGdVRXh6?=
 =?utf-8?B?V2laU1lYcDlXQlJrU2Zudzc3alhJUXlZaUtwaXRSeFFMbXQwRHhBU3BEREdF?=
 =?utf-8?B?TGY3ckVqRUZVWHJmQU9OR1RtYVA5M1p5SnFBb1BRbmdERmVWR292SHRYemhq?=
 =?utf-8?B?OUhLUFRVS1o3Rkg1aVJJTXZ4MGV5ZkF0SGZLMi9PMC9vTzdvbWtDR3g2WlBP?=
 =?utf-8?B?cmZLN3l6azNqbW4ybTAwdkw1S0Z5UHVpTWlncUF4bEw1R0VSUDlYTThuUHZS?=
 =?utf-8?B?UjkyQS8yT1hvSS8rM0lkTWh3U2ZOVVRURmloSVZnV09sdzl4bHZiY0ZqQU9T?=
 =?utf-8?B?bDY1QnVld3ZVTDdoUVU1NEkxaUQwUDBQSmFBMi96WmNoR1ErR1lFWjhKSDVE?=
 =?utf-8?B?ZTZtMVM0Tis5aVVsNlZ3WndIMjEvNGRPdHBOUS8wdi8zT1B4SjNnK1g1N2VY?=
 =?utf-8?B?WjlxNTgwK2ZLaml5K0VQM0FXQkQ3OUVGR1o0Q2lQSVJ4cytEcm1mUDd1NndC?=
 =?utf-8?B?eUJKY203RjJZVFIxTWdUZHhpdGxKZW9pc3M4S0MyZ0lHWEoxV0JGR2N5Njdo?=
 =?utf-8?B?ZjA1QmpGcjBES3Y4bTJpSEFha1IxNkp1cXVnSzNRNkZCbG82cGl2NlNUR1dJ?=
 =?utf-8?B?UGNVOFZNRWs5RTVLWnk0aG56cUgveFhJZ3ZSaGh1cE4vNGhsMW5TaS9ldXRr?=
 =?utf-8?B?V284dDBxTXhmZU5zWnlxRkZqbENzK050MVNlaXJtVGZQVHBvVUlUYkpLQ3V4?=
 =?utf-8?B?UWlEUjBydWRtOG56VTZ1cmFqN3h0eU1EdXNFcVdMYkJkUXBJNHl3NVloSUg2?=
 =?utf-8?B?WE5qN3FBeWZvNU9GU1Fya1dmWmJ5ZFlFWDVTT0YyMnlhYWRSUTlhN25qQlAv?=
 =?utf-8?B?VkpCUkpmaWw3ME4rQ0hQbm5oRU4rYndJbGZ5QVFOSGQ2WC9ISEZWakJlUnZo?=
 =?utf-8?B?UWZ6bXNwVmNLeFRaTkJ4UjVkQ0NKUHNyLzhxcWNzU1R3WWRpemRnQnlNUEZn?=
 =?utf-8?B?QVArczJuZitEVXhMSjF4NXVmTENGTGk0U2I4aFNRb2xzcXhLaVExbGhWZmQr?=
 =?utf-8?B?YW5uUXNmVGRSQ21ISGR5RnFIM0dVVldFOTllTW1mMlhZWXA3MHBQUjF1YUhz?=
 =?utf-8?B?bE4wVi9peFUxaExTRzRXRlhNZXZJVDZhQm1zYkQvbkd1SHVVTHhHVnlsWjh5?=
 =?utf-8?B?TkhqZTE0c0Zmdnh1dWE1cHgyb0lRRHFyeERLcERqS1BHUnVROFhIQjJhTURZ?=
 =?utf-8?B?TUZUNnNzWHVFMlFTUGQ5MmJYRENnVDdaNGdNK05GZGI2cklLQkZWeWh5UVFH?=
 =?utf-8?B?cVJ2azJoK1BPVHdDL3dSYStBeFhsWHcwRmduUlovcHFkOFdzekxEU09MaHN1?=
 =?utf-8?B?b203V0pwQWZxZHlYSVplaTR0eUVKRk9RQTU1Q2JTWFF0YTRTVnA3R3AzZzZ0?=
 =?utf-8?B?VTdEU09rWmdMMGtmVTlIQ1h3ZVFFVy9VMTNRaHBsSlY5bkNjYkZYeDVET2Zu?=
 =?utf-8?B?THRySWVGcUZvYVdmZXJHWVYrdkFYWmRlanUra1NXTEZhdmZkTWNQUUszcENz?=
 =?utf-8?B?Zi9xZ1RjbWcyNy9IeCtqbm4zeUNYWVdSYTJvY01ncGprOUVZWXY5TVVvUFhk?=
 =?utf-8?B?eGhJb2gvaTdGaVRPM3duTVo1bWZoUjU2dW1aVHRLUDAvK0xJTXZ6N21JMk5u?=
 =?utf-8?B?SG90dHUxOHdpMnVnTDZjd3pYbXBYSmhHNDJVMXFLSmFwTlo5ZjluYUx0SGtu?=
 =?utf-8?B?Mnl3VU5Bam1jOTdxMEFadFlTd2NLYVhaUG50U2JkeGUvVlY4OTlzalF1UVI4?=
 =?utf-8?B?WmNOSVFYOVgrKy9IYmk4UEgzNmx5RzlYN3ZIOHhFd0l2anJTdkVjM1ZsY1Fn?=
 =?utf-8?B?YTdRdWpDalZNUXF2RlFjcFh2dFhjTDRTQmxhSm9LcTF0a1lmb2VDUEJIbVZU?=
 =?utf-8?Q?QQnwrrRkhWKt8U6QoZAan1K2r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SUFOK01IVitwVzlhRzFLeGYvc0xJblpwZE02ZENXVlRvN3RWN3g1SnZwZE9Z?=
 =?utf-8?B?KzhSN0lNcFlaVFJpb1QvWXVYN2FyV0diOUNRdVE3UDZXLzVKU2VTZzZPN2dt?=
 =?utf-8?B?ZFBZbTJvdE05WURndklQM01hZlROSlR1NnhBeGpBM0FjbWRRTHRxaFpUOEhz?=
 =?utf-8?B?VXprU0NFZ3dpR2F2Q0gvWXJpK29vUmlpODFUMEtLRWsxWVJZN3ZqbWRWa3lt?=
 =?utf-8?B?bC8rdktYWWxya1FlOVl3RWVZcWRONk5Dc25Yc1F5UGFic3pvYytVTHl0RU9G?=
 =?utf-8?B?NVl1YlFybTd0SDB3YWJxb29NTDNPYXBxa1E5cXJYOFF1dnJDTTRldFJIQ0Qy?=
 =?utf-8?B?ZDNUNEgwUXY0ZDZZdzR4T2svWldOU2tGSGYzSm5KS2hkV2tDaDUvMmppWmxo?=
 =?utf-8?B?L2FFdTk2ZDNtT000dGN2UXpHbUV4bUlIUFdDLzNWcURVVkN6eis1dld3bjc0?=
 =?utf-8?B?bm1EZXdCbkxaOVR3ZXdKMW5zTGxRNmFpY1hjWUZpWlB1UXNjZm5NV3ZjdHFY?=
 =?utf-8?B?bHlZaGt5c051dnFyZTl5YzdvYUNEVEFnMFJoakZmckUxaDZDbnZMTDNNMFRs?=
 =?utf-8?B?a1MyVllXcXlhTmpxN3I5cTB0NWs3QXBKTkNHbUxTbEJXTUlPYUxpeUJwZjBJ?=
 =?utf-8?B?amdxUTNzdzJBbUdlajlHWnZiYjFqd0Rta0ZaNm4yamR6bVNPUnBUNkNVbThM?=
 =?utf-8?B?bUlrWWxubkMrK1o4ZzRJMUp1UjRHTUlsK2NMV2NtaFBxNHprYzlPdnJna0VV?=
 =?utf-8?B?Z3JhZkVNMlI2Z041WWFXTXQyYkZJb21QU0dDaXRyc3pVMkhwZkRtRGlhZ3NF?=
 =?utf-8?B?YmxZUVhveTRkMDRaNENxZWJCMFpLM2dpSDFueHdJalpsK09BRmhaRC95c1Ju?=
 =?utf-8?B?c2RSbC9LRndNSkQ0dkNmTndlQTg3ZG1rb21kS1BjRDBXM1pKYkVhRHRmN3JC?=
 =?utf-8?B?cHRiWW1zWUZERnFyNEs5V1pYMzhjekZuOS9iS3pJMW5zbHkyNE9HOW5QeVJk?=
 =?utf-8?B?dnRRKzhHQmJNR3JoM1lJNkhPTzdFaXBVeGtXZEMybUZSMHBBRWlNMXlCWUZK?=
 =?utf-8?B?dzlWWlFkTVl1K1ZSMU1kOFhvcXhRVVdvZlBnRVVkbFp1TnR6OVljenpldUc1?=
 =?utf-8?B?Z3h3d3dxNWdubVZocnFWT0RMMHRweUZZckc2VDV6UVB2dDNIUzRXRWUvM0VN?=
 =?utf-8?B?aVNoN24zc1J0K3c1emptOHl2QzN3SE1XZzhTcWxsc3prYlM3M3RMU0ovcHRp?=
 =?utf-8?B?TmxaSGxsbytNaEY0VE9Oa2lWTjI2UmFrK1JpT1RQRUFlUE40OVVPY1NWOWRZ?=
 =?utf-8?B?eldwS0Nhc3dtYVA5bmZBTUZnYTR1c1NiYnZMWlYvc0xHL3lZZ2I3Y2lzUGFC?=
 =?utf-8?B?aW4vaE8zcnNKSHhOTHRCUHRkakh1UndYN0dWZlRJcktlUmVhM0RRMFdkL2Zw?=
 =?utf-8?B?d3NrNHpadjJjZ0kyZDZuK2RrNzhQdW9aWXpqMlZ4VFJ4RzRlU1NaSDRyUGJH?=
 =?utf-8?B?eTlPMUlXRHM3NGFhaCtiSmlsSHBaTGR1ZFVMUndWc2g4WWlWUGdGZWZQdi9E?=
 =?utf-8?B?MkVVVFVkQ090c0dOWHIrSU5Mc05SUUM2SkhnTTYzNENGWW0raFZSSkM4MDF0?=
 =?utf-8?B?WWZzOFQzRUVkUG9wOFhheUdYZVRBUmhTbW9CYjNOTUl1R2tnSDVyTWkrT0J4?=
 =?utf-8?B?K1hYVkVjOWVYVytPb0k5cWZQc2d0OG9PSWVnWEVsL1p2R0U2NjVSN29EakFY?=
 =?utf-8?B?eUNLNkM2UWJXT2w2QlRzVDczY2xvNjlWL0FidWdNSjRqWTdPK1NxS0dGTDZo?=
 =?utf-8?B?Q0FQbUFoYUNlSjJ3alVMT29BRVJvN2tTNkcvaWROOGFnckRrSFRjTHJSNHh0?=
 =?utf-8?B?OEkrV3lqUnRDS3FyaWlMd3A2NEdHdTVlNW9CREQvK1JxZ0JmRyt4YkZzNUE1?=
 =?utf-8?B?YStrZVlQTlVWSkZwTG43ZXNIVUdldFYyVDYycVRmTXhtVUUrWkxzSGdzcjF6?=
 =?utf-8?B?TTJXTXBsK2c3N09mTlJTYVRGY2dWZUtyQ1BUMmo3TnEwZHpVTkpUdSt2OXh4?=
 =?utf-8?B?MmYxT3hwWktZMVZjZzRocUNpd1dFeEdXMkV1TUROVE9MdU5HaVJjeE1HemZZ?=
 =?utf-8?B?MitOb2lYdFArNGlNM3hMeUZHbnphK29Jd216THg0Y0d0aXJrUVIrQnVUbWU0?=
 =?utf-8?B?VWpVYkJrb0prOFgwT3plQzlwc0piV1pTYWZ2NnczQW0xMUZ2dGorSzNwNDZq?=
 =?utf-8?B?aVpqd0F3Y0xWbStkRTEwb0Z1Y1A0dit4d2VwSGE0WmJIUXJ3RTJXZ2xBb3BO?=
 =?utf-8?B?TlBraFN2NkNTdnl6RGgzVTVTQklwd21MNEY1VTFkMXRteklYd09iZERGL1kz?=
 =?utf-8?Q?kVNMOxq2k49B9ljTIj7mTqFBPgrckuhIgFpOx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FA8B94DD660B746AC9632C9E5701C7B@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: daea9955-77d7-4bc0-1691-08de5d1ab8b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 20:37:28.2562
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpSRKz2j3UMwQ/nC11d/x+teoPRPEE531C6OlFq/4WJLOwXCts8/EMkWQWQX88fXRLPo6Sm1AvGeb0J/lq8zlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3856
X-Proofpoint-GUID: iuhLexwv1j2WKmVgPkWHlR4VtwnRnute
X-Authority-Analysis: v=2.4 cv=Uptu9uwB c=1 sm=1 tr=0 ts=6977d087 cx=c_pps
 a=DYOzx0NG23oKzpQZkEOi/Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=P-IC7800AAAA:8 a=VnNF1IyMAAAA:8
 a=nkVWHd_Aaa1t0xRSmE4A:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: emnYgs5PxNerhMzkQ-WFzvUjZ1ZmifIB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE3MyBTYWx0ZWRfX9d/DuxU3gWmi
 tw90/6iP9anpd1jYRB20uDfNiPEZ6xpyszerlBehM/xb957JZN1Um4SgeqJ5/g0QzHFrBRo4grl
 XGYF3bSkrBPMmwcJSjHf/xYZkPIJ96XEMcMCKxof4ZMx8WxoGBNvuyEJ9cn3OruoYna9ok055KI
 i4wZq57NvjGj5drfQ4Ago/+e/YmuMKkaXeGZqG/wNI7JJa7q8BzTl3xEXUj8+P6RdWc1joW4jix
 PhMPZeNmkrFw3isVBlsIcF+J+0YPKYWxtdHOGwm8SiCWVygJH3yPPqWv+IdyXzU6vdJazsyxHu8
 W6A9t+UD9sDARjkUbtLdvTpqCGXuajtMXpRu/+isg8dYad+gPejGcewT9ANDoQXBLEAViHb/hT+
 DppR+2sAr6Pl0f/tAQAlEIAP9GYdogDjgV8q1dbW4wKMvhXDTpO/CfzVGTFbusNq7/LshvSQav3
 PADUqWnuqzkH1o3PkIQ==
Subject: RE: [PATCH] hfsplus: fix uninit-value in hfsplus_strcasecmp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601260173
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75532-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,d80abb5b890d39261e72];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C42208D237
X-Rspamd-Action: no action

T24gU2F0LCAyMDI2LTAxLTI0IGF0IDA4OjE2ICswNTMwLCBEZWVwYW5zaHUgS2FydGlrZXkgd3Jv
dGU6DQo+IE9uIFNhdCwgSmFuIDI0LCAyMDI2IGF0IDQ6NTHigK9BTSBWaWFjaGVzbGF2IER1YmV5
a28NCj4gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gDQo+ID4gSWYg
dGhlIHdob2xlIGZpeCB3aWxsIGJlIHNtYWxsLCB0aGVuIG9uZSBwYXRjaCBpcyBiZXR0ZXIgdG8g
aGF2ZS4gT3RoZXJ3aXNlLA0KPiA+IHBhdGNoc2V0IGNvdWxkIGJlIG1vcmUgYmV0dGVyIGZvciB0
aGUgcmV2aWV3Lg0KPiA+IA0KPiANCj4gSGkgU2xhdmEsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHRo
ZSBndWlkYW5jZSEgQmFzZWQgb24geW91ciBmZWVkYmFjayBhbmQgdGhlIGRlYnVnIG91dHB1dCBz
aG93aW5nDQo+IHRoZSBwYXJ0aWFsIHJlYWQgKDI2IGJ5dGVzIHJlYWQsIDUyMCBleHBlY3RlZCks
IGhlcmUncyBteSBwcm9wb3NlZCBmaXguDQo+IA0KPiBJJ2QgYXBwcmVjaWF0ZSB5b3VyIHJldmll
dyBiZWZvcmUgSSBzZW5kIHRoZSBmb3JtYWwgcGF0Y2guDQo+IA0KPiAtLS0NCj4gDQo+IFRoZSBm
aXggaW5jbHVkZXMgdHdvIGNoYW5nZXM6DQo+IA0KPiAxLiBBZGQgdmFsaWRhdGlvbiBpbiBoZnNf
YnJlY19yZWFkKCkgdG8gcmVqZWN0IHBhcnRpYWwgcmVhZHM6DQo+IA0KPiBpbnQgaGZzX2JyZWNf
cmVhZChzdHJ1Y3QgaGZzX2ZpbmRfZGF0YSAqZmQsIHZvaWQgKnJlYywgdTMyIHJlY19sZW4pDQo+
IHsNCj4gaW50IHJlczsNCj4gDQo+IHJlcyA9IGhmc19icmVjX2ZpbmQoZmQsIGhmc19maW5kX3Jl
Y19ieV9rZXkpOw0KPiBpZiAocmVzKQ0KPiByZXR1cm4gcmVzOw0KPiBpZiAoZmQtPmVudHJ5bGVu
Z3RoID4gcmVjX2xlbikNCj4gcmV0dXJuIC1FSU5WQUw7DQo+ICsrIGlmIChmZC0+ZW50cnlsZW5n
dGggPCByZWNfbGVuKSB7DQoNCkl0IGxvb2tzIGxpa2Ugd2UgY2FuIHNpbXBseSBjb21iaW5lZCB0
byBjaGVjayBpbnRvIG9uZToNCg0KaWYgKGZkLT5lbnRyeWxlbmd0aCAhPSByZWNfbGVuKQ0KDQpI
b3dldmVyLCBJIGFtIG5vdCBjb21wbGV0ZWx5IHN1cmUgdGhhdCBpdCdzIGNvbXBsZXRlbHkgY29y
cmVjdCBmaXguIEJlY2F1c2UsIGZvcg0KZXhhbXBsZSwgaGZzX2NhdF9maW5kX2JyZWMoKSB0cmll
cyB0byByZWFkIGhmc19jYXRfcmVjIHVuaW9uOg0KDQoJaGZzX2NhdF9idWlsZF9rZXkoc2IsIGZk
LT5zZWFyY2hfa2V5LCBjbmlkLCBOVUxMKTsNCglyZXMgPSBoZnNfYnJlY19yZWFkKGZkLCAmcmVj
LCBzaXplb2YocmVjKSk7DQoJaWYgKHJlcykNCgkJcmV0dXJuIHJlczsNCg0KSXQgbWVhbnMgdGhh
dCB3ZSBwcm92aWRlIHRoZSBiaWdnZXIgbGVuZ3RoIHRoYXQgaXQgaXMgcmVxdWlyZWQgZm9yIHN0
cnVjdA0KaGZzX2NhdF9maWxlIG9yIHN0cnVjdCBoZnNfY2F0X2Rpci4gSXQgc291bmRzIHRvIG1l
IHRoYXQgdGhlIHJlYWRpbmcgb2YgdGhlc2UNCnJlY29yZHMgd2lsbCBiZSByZWplY3RlZC4gQW0g
SSB3cm9uZyBoZXJlPyANCg0KPiArKyBwcl9lcnIoImhmc3BsdXM6IGluY29tcGxldGUgY2F0YWxv
ZyByZWNvcmQgKGdvdCAldSwgZXhwZWN0ZWQgJXUpXG4iLA0KPiArKyAgICAgICAgZmQtPmVudHJ5
bGVuZ3RoLCByZWNfbGVuKTsNCg0KSXQgZG9lc24ndCBuZWVkIHRvIG1lbnRpb24gImhmc3BsdXM6
IiBpbiBlcnJvciBtZXNzYWdlLg0KDQo+ICsrIHJldHVybiAtRUlOVkFMOw0KPiArKyB9DQo+IGhm
c19ibm9kZV9yZWFkKGZkLT5ibm9kZSwgcmVjLCBmZC0+ZW50cnlvZmZzZXQsIGZkLT5lbnRyeWxl
bmd0aCk7DQo+IHJldHVybiAwOw0KPiB9DQo+IA0KPiAyLiBJbml0aWFsaXplIHRtcCBpbiBoZnNw
bHVzX2ZpbmRfY2F0KCkgYXMgZGVmZW5zaXZlIHByb2dyYW1taW5nOg0KPiANCj4gaW50IGhmc3Bs
dXNfZmluZF9jYXQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdTMyIGNuaWQsDQo+ICAgICAgc3Ry
dWN0IGhmc19maW5kX2RhdGEgKmZkKQ0KPiB7DQo+IC0tIGhmc3BsdXNfY2F0X2VudHJ5IHRtcDsN
Cj4gKysgaGZzcGx1c19jYXRfZW50cnkgdG1wID0gezB9Ow0KPiBpbnQgZXJyOw0KPiB1MTYgdHlw
ZTsNCj4gLi4uDQo+IH0NCj4gDQo+IC0tLQ0KPiANCj4gRG9lcyB0aGlzIGxvb2sgY29ycmVjdCB0
byB5b3U/IFNob3VsZCBJIHByb2NlZWQgd2l0aCB0aGlzIGFwcHJvYWNoLCBvciB3b3VsZA0KPiB5
b3Ugc3VnZ2VzdCBhbnkgbW9kaWZpY2F0aW9ucz8NCj4gDQo+IA0KDQpQbGVhc2UsIHNlZSBteSBj
b21tZW50cyBhYm92ZS4NCg0KVGhhbmtzLA0KU2xhdmEuDQoNClsxXSBodHRwczovL2VsaXhpci5i
b290bGluLmNvbS9saW51eC92Ni4xOS1yYzUvc291cmNlL2ZzL2hmcy9jYXRhbG9nLmMjTDE5NA0K

