Return-Path: <linux-fsdevel+bounces-76073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oETsLs/kgGleCAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 18:54:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AC3CFCE3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 18:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CB283004D12
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 17:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39FC389473;
	Mon,  2 Feb 2026 17:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eJXuP/lm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59AB389469;
	Mon,  2 Feb 2026 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054855; cv=fail; b=kbwdmvPP4ZL11HDlsx8o2nsTa7BoxfiN+YlTgTNMQwbcPBeU1jchlxyM7W6SEBnfXOuqlZz8LHshSKROUaJLhxgxd+saRZJqUkFAyLrqs+2XYLnOqDk3Ufs+L7olCZYKCF6S8N093ZsB06vb+72ve+fXmgAfQjEs3tvZ5MkoOrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054855; c=relaxed/simple;
	bh=E3RTXjCNyby0i1akPw9hd2P6bjZwsv4fOcc4P0fzfkQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=WuOP+8DboVBvzXmpNRnL0xg1TC2n1TZ6RoLI1jUk8pTKfrJwLLBNPdHmwz2YpW0myfe2A7EMIrQHpZfVJAY/N5ayLF2Z4KJ/+a1GcnnCK/ozdsmgb/+xQh28lfaRygVsOd6ktXsuKMIesJBGyiTCthq3BX6E7ruyQ6o4HfzqEhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eJXuP/lm; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 612FRwim017607;
	Mon, 2 Feb 2026 17:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=E3RTXjCNyby0i1akPw9hd2P6bjZwsv4fOcc4P0fzfkQ=; b=eJXuP/lm
	FIsD8IJCV3GqT2V6iRd/aPGqoPSwDGF6EN4VM8QWn7NLqeiWME5dibpctP/rlcXE
	HY7Xffsx/5H6O10owBXbUG17nHhr9bwZjWXv9hsgmCXpZJTlhXiBZoFQnV1LXpL4
	+aLdisDsIUP1/Rs8jYvRfTIYyVyVlQ/K/O3ysbO3+4lZpWcDKEJ/8S7oBnAradi8
	bK37ocuzSe5KMWqEJdcp6fgzOcBl4pk6VU1erib+/8ccZCdUB62mkgqg0iz6Mer7
	JDE1dmCjQUHpgLufzlam3Tr93l/lta39B8WydNJ236NXvgk7EDNOGdbB7LJWZTUO
	1w2KZIjaaDCOFQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dt1me1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 17:54:01 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 612Hs0I0012051;
	Mon, 2 Feb 2026 17:54:00 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013012.outbound.protection.outlook.com [40.93.196.12])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19dt1mdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 17:54:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zn9/9eaQwKgtb1gtEyAkWkmxawswupqcwpsmjRlnzMI8lxtUuTtvaq/U3Uyu46rIWapbgqDPybQqK35UowkxexCs59Bhy17oEBSptYIYfBwrnHJyFECoopI5H3zFqqo3+WTMsUf5XTe9hyZao633AqTmSgCcdRWELAPykzwmHzVrAY9XqavkzWJSg+TzlpwGhP6BGTPY35qeKImUqdNJcHiz9y9DMZrAPYbwbxY5oKPt5glkyvimT2bY4v4RnXd5qqu9p1Tk+zEDNYtVR0Jnpxa0ulvVEQzuLyFP13CAb6mRq1AoPwckR7IpO0Py5+a91Xj88CJURgL6ap40A+RXYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3RTXjCNyby0i1akPw9hd2P6bjZwsv4fOcc4P0fzfkQ=;
 b=jfessVPtRkVPV0IQCxEws5Xv31onQVtZF4eMswKuWUDSV7PWayRKY6qBe+JF4kDdha+1PWS8iUn1/P/EOPydC59mcWVcWJhwDwu1fNaIJY++NH6BA7mc3Q6EuHRnbwSGuuE1j9r9RAVeWLu0uzqHK8FwwDT1UkqH9jYaE+5iB6+vgO2/Qwg5FxzpGjjMimHXeEVAfDlhV9i+w/9PFQwuOX0UQui2cYqBLFegc3yDuDKhWMCFxzDTSTyj5nT4jbM84BdyCHNrWLp+1FOkWqoL88wDOpJd6MfftHINOiDbEtjnslp1DrXjtRz4jO8ZTlut1NvIMF0E91SVvaGn7HUoZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB5069.namprd15.prod.outlook.com (2603:10b6:510:ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 17:53:57 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 17:53:57 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "shardulsb08@gmail.com" <shardulsb08@gmail.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        "frank.li@vivo.com" <frank.li@vivo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "shardul.b@mpiricsoftware.com" <shardul.b@mpiricsoftware.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "janak@mpiricsoftware.com"
	<janak@mpiricsoftware.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com"
	<syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com>
Thread-Topic: [EXTERNAL] [PATCH v2] hfsplus: fix s_fs_info leak on mount setup
 failure
Thread-Index: AQHck3x4kCToKlRGxUOa+AdRnD2h0LVvstQA
Date: Mon, 2 Feb 2026 17:53:57 +0000
Message-ID: <cace4df975e1ae6e31af0103efcbca9cdb8b8350.camel@ibm.com>
References: <20260201131229.4009115-1-shardul.b@mpiricsoftware.com>
In-Reply-To: <20260201131229.4009115-1-shardul.b@mpiricsoftware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB5069:EE_
x-ms-office365-filtering-correlation-id: 6a84c794-8768-4cdd-26f1-08de62840a06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RmtDTWxZeDRkcnFIUW5aK3doMXR1OGVqM21vNzZjYm96Mnd6NCtKQk9pU3B2?=
 =?utf-8?B?Y0FYcEthY3RRSm9KY1oyS0lrdWVTT1plVFpESzFNRFF2THY1WXpjNXlwQkZ4?=
 =?utf-8?B?Sm9QdGxPUjVjTlNuekRudFFiUzN0dFc0QUI5cmpEVUZneFgzeWs2ck12Y3dS?=
 =?utf-8?B?Qzk2cjVyWGJuZDlHREQ2Rm9SU3RzUzMvVFlZMkY1SmxXQjJHdUZOSWkzQ2x3?=
 =?utf-8?B?THZ5NE5iQlhON0dUY0FpUDZwZnJaUExkMDViWlFSdW9XWGlvWHBRTzBVZ2tz?=
 =?utf-8?B?NlMvKy9aSEtXYXNOM0l2MjhDZEg5ZnVhazlWNy9DbGhpWW8zODZvcFZRcndN?=
 =?utf-8?B?VVdGS253aVMvS3l0eDlnOHhiQ04yNXgzWnBmVlc0OWxBM1p6MnFvS3ZHUXhq?=
 =?utf-8?B?OEkxVkRySlNycE9saGhDUCtVUlliUWFMSW9HQ2dyVHZ4N1k3WjhTK1g0UlJ1?=
 =?utf-8?B?UTNsQlkxM1F1RXQ5OWcyM0o4NEhrT0RQcnNrc3JPbHpIY3hJdVU3aS9MTUhv?=
 =?utf-8?B?aGI3U0xiTGJId1llaDZjaGYzNmxEdGdUV0dHWGhPdDByRlBGM2VZc242Q1Za?=
 =?utf-8?B?L0NKaXNjWGlCMWMvVmpyeXd2TFREaUNsQkhrREtpcGFlNGlDd243eW1rSXFY?=
 =?utf-8?B?SlBBVG5TeUwyajM4cEFoVHRWL1ZHSUFYM2ZWbWxBU05YeHpjQ1lFUlRHMmYx?=
 =?utf-8?B?RTNnVkVWTHJURXdoOFJsdmlKM09ZY0lPNG1HeUZkQXZjNTEzck5ZTlY1cHo3?=
 =?utf-8?B?Qnl1cGorMldEMklpejhiNTIzcTBmdkhEUm1BcUJ5VGE1T094N0dOandRNHdQ?=
 =?utf-8?B?R1FmLzhxbnl4cnppRzRxRFg4Zzl4bVdQTnRvdHI5elFuSlE1VEdkdURWSVFn?=
 =?utf-8?B?VkR1UUZoMm56OGxmdHdSenU1MUlMMnZBcXh4cnd6TXd1Ti8wRTA5QklkTkVB?=
 =?utf-8?B?Qm5qazRITWlZQjlIRm9FZzQxR3RQNXhaRDYyK3Y1eHAra0ZiTE1UTzRucEwx?=
 =?utf-8?B?c1JLd2crK25vTGFKMEw3ZjEyOFp4cFNnZVFUWmZpMVRJckVzaEJoeTI0ZTNG?=
 =?utf-8?B?ZDI2cGxtQmVQM1JSbnhybjFtTjMvUm5JcVlnVzJEZzVRek8rY1BSbnNoQVNN?=
 =?utf-8?B?NjA1VE5ya2R4MzJGSys1cDhXbWpkbHJaTFRvQTAxdlI4MXZsTm9WVm9ueVhr?=
 =?utf-8?B?bDZ3N0gyK0pJUVF2VVJZcjFsNjNndWxlckdwbHZhS0FnbHRGQU1ycHl6RS9N?=
 =?utf-8?B?QlFyTHBuYVNYUnlmRG5BQkJwaEFkekVjZktZcGpEU2lpT2xhRVlJMHRNWnhU?=
 =?utf-8?B?MWJGLzJTbnN6T0ZNUHdza0FWcGhFaExQYUlGS2thckF3UmwvbjlNN05YS1h3?=
 =?utf-8?B?VCtYODliNmlteTNTb3dRY1hUQnJ1MFFGY3NHZDBKc29XajBYZnZWQjNTakNa?=
 =?utf-8?B?QVVLUVh0WEhnRk9HYlVJeklHYzVXRXZGTmRkaGpVMUIwZjNheG56Wk8zTXM3?=
 =?utf-8?B?Sy9LRDlOQ2FmbGpXY2lsaUY5T1BQcnVnbFJxRS9EVndSbnRYM1FPVWtxOFNG?=
 =?utf-8?B?eC8ybVZ2c3lYRFducCszd2habDByZyt5OG9lMjQvWjB6aEJHWnNFeEFuQVN0?=
 =?utf-8?B?bCs4ZXFKOHdCQlhMK2RIaENRVnVxVENBT0ptYVpaQkNuZWd5OXpWUHJnZGhz?=
 =?utf-8?B?cDhyb1VEc29hdjVQUlRQZUFCZTRzRDNXNzBCdldGRlB0V2hKeEJ0TGU3Yktz?=
 =?utf-8?B?QWxId3JGbkt1elRPaXgxNy90SEVZVzhWTWd2TGduMFhhWTd4L3VqSlAraita?=
 =?utf-8?B?Sk1CK0QxU3o0bnA0TmYwc2g2NWVKbnFGMUVBM1I2SzdYVmk1aitHSEhEK2xz?=
 =?utf-8?B?WnppZlo1a0EvZ3NqVHRDckVFR2VKc1d6cnYyNXBxQnJCRjMvL3ZVNzkvMmc3?=
 =?utf-8?B?NGt1bXY4UUM5U2NQS0NTd2tyZnU5TUVjbTY0c25XK2dVSTV1SVBqbGpFSVY3?=
 =?utf-8?B?eC9jamg5OHJCTld2L2JIaUJQdUUxcGJPUncvWk1EdWNoSTJFY2IwMCtrT3du?=
 =?utf-8?B?UzFDREJaWEFwS0xyWHFIeE5JSGcrcERmT3pzUDBVMHlnNkJ6aDc3MEdJL09v?=
 =?utf-8?Q?iryhZTq/v6D00ojvq14hJBiAp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGQwVWdGRDY1R0VIWWE3WWJyMkEwMVpuT3hIaTJYWlRqeVhYUnUzRnlVNnhN?=
 =?utf-8?B?Mk4zRm9YNDAzckVad3pzR3RMYlBBMWN2VFJmTVFITm1Tc1B2WVkveVNSTkhN?=
 =?utf-8?B?b3pjZS9pWnFLcFlKTzlrN2MxdTVGT2VuM3Fsb3NqQ20ybTNubWVsNXIzYlhv?=
 =?utf-8?B?b3pTMjM4M0hQRVpwTTRNT0oyUFFZL2ZrRXB0YlJoWjZnOURVZW1CRlRrV0Qr?=
 =?utf-8?B?OVl0emxoOXFwbWFlK1c0OWdvVktiMGdxM1I0SnRXQy9HVkFDZ2VrRzJTbUlz?=
 =?utf-8?B?Lzd2NkUrK0pnYnh3dkZSWEdBR0gxanhMNkVYVHRwdFNublhqSXZGUkVCS1dk?=
 =?utf-8?B?ZWNoSEdQNy9TY1ZDVVF4RkZNU1U4Y3cyQUZIYWdld3FrNUh0Z05OWDR5S3R3?=
 =?utf-8?B?b2tsbklyU3BoeUo0TFd3ZlJEOURNam1ZV1YzQ3VhQ3g2allZM0xaU3Q1YUEz?=
 =?utf-8?B?NnV3UDhYRVc0TTBlNlY3TlBEZzg1ZGVpZE1mWkphOXErdDFobm1iVFYva3pv?=
 =?utf-8?B?NG1SQi9VMndFZUZuaFdWZGliM0dmRWhqQTlqZ2lFY2FUdkxrVU40S0U2Nkpi?=
 =?utf-8?B?V2kvUHdtLzNUWDNFOUtHekVnMnV0QzRvVzlzSDArNC9aOE9neXhTWGsxWjdr?=
 =?utf-8?B?M2FLbEZWcTVOeFhSSFJ1cW8ySU5xcGNjeXd4OExTRGxiSDVQTS9vQVhIOVBX?=
 =?utf-8?B?QmVqWXJvS2dUSTFiOVk2eHZoTk95bTlleEM3cGN2cGROWW03UFFQdEo3YVcx?=
 =?utf-8?B?V3hBVmsxQjViTzVOZ1VxZ242dnNDRUtjcFRKKzVRU3BEMnJJQVNGeVVqUEto?=
 =?utf-8?B?cjBBVWsrYUcvYUtLdUZQWHNUV1d4ODlHU21FL0VuUzFJeGlVbWdZODNYNjhu?=
 =?utf-8?B?ZFUwdmRRamE2eWg1YjF1ZVJ4a25IWnNXNitPZWZOVEJvZkhIb1pKYWZIL0da?=
 =?utf-8?B?amNqRFhOTVVkeldEU0hpL1pGbkxQVHpNSjllbmVqNjdPVFRiRkV0VGI1WnV3?=
 =?utf-8?B?NGQ3eUZzbW1nTDZybTlrTFpQMlhjSVdUOFhVYjJpT011TG1WRG5ZUkRpeHFz?=
 =?utf-8?B?UjIydk9XQ01ZTGhWbkFGVUttT1RMclBTTm1OdlhuU2xRTnpiMndWczd6TC9C?=
 =?utf-8?B?M1A3V1NlRzloWExXV2o4UzZCVXdJaG54TWJuZG5xRDJ3bVdOd29iZE11VEF2?=
 =?utf-8?B?Y1JBTlhFZU5FZ0M3dFYwWHhXeG8xcmpIbW8zZ0ErK20vNjVZbGV2UlJCN2JR?=
 =?utf-8?B?eGthZWFkNk1zb1VzVm5YTlFQdVd4UGgrR0dYTng3RlhXRi9pS2xvTmtIS2tk?=
 =?utf-8?B?RjFjb1h4cEhWVTg2TEFYZ1Z3cFNOeThFc3d3MG5DSmMvTXluOTEwaEs1RVFY?=
 =?utf-8?B?aFFFd0I0MC9Od2FLcDhrM3lySWduTjRFcVRGQ1drVnN3Y0FERVo3VTEvUmxR?=
 =?utf-8?B?UVJvYVFjbEJXT2hnMi9aYkJYd21oRUF1U0hqaTAreElqbFV3ODY4ZjZoUGFV?=
 =?utf-8?B?TUN4UXFEWE1raGpTbElLaDR6LzduNmdEQVdNK3ByQ2hoL0RKTnlDV1pzZjdL?=
 =?utf-8?B?akJJN0FGQnA0dUp0aWxxbVgvVEM4RzlOdWtDQmZTcGhSUTJ1TmROck91clBy?=
 =?utf-8?B?akNRY1puSFdVbFJQZkdWMDZhMVowNTRsQmo5RnVrWnVRRENKT2pkcnk3cm5H?=
 =?utf-8?B?emhWcTA2L2R4QmJGUkdxa1liQi9ocnJtTUlBWVdrZ1ZxVzVWcE1qUFNmTzJD?=
 =?utf-8?B?Q2UyYVc4bnJsWG12MWhtZjJqemFyVnJuODczT3lHb09VSFRsOVNWWi9HdUxG?=
 =?utf-8?B?cWdGaXY2T3EzVDhGblRmMnQxQXV0eUZjcGR2K0lDTTF5bE9paUF5UWxFQUFD?=
 =?utf-8?B?TURSR2FSKzBDS1JWM1lOSUlKM1lSUVhRU2JBWjR5cTYrV3R5V0Y1SkhpTzFQ?=
 =?utf-8?B?WHRFcDRHSmM5Uk4rWkcrTXVOdU9HUHdmS0gzVFVVNXhTVFdFWkVrY3JlM2pn?=
 =?utf-8?B?NFdxNVNxUDdHamtYMExiUUNxQVBVaUYxYWRXYTBLbFBVMjJlcjN3eGs2M0RS?=
 =?utf-8?B?L3phVmVVUlhPeUlrTHNqcElqclFlakNaVmJ0dE5jZjNJdW1KajVyQWFrcVRF?=
 =?utf-8?B?V0NKNUhPV1MyRnJUNGVEOTdtWm1mTVRiR1dtZXIrSjNFYXhtSkxmckdPcUsw?=
 =?utf-8?B?dXc0N1RCL3hEYnNtY3NYcy9PNU0zNW5UL2w1RmwxRTQvRTRmdkZrY2I2eHM3?=
 =?utf-8?B?cnU3L3VpVll5OUVBR0NvOTJZOWw0dVJDWEpud0R5QXBZTUZ2aXFXcWFiaXZN?=
 =?utf-8?B?MjJjWDNlY0M5S05ZaWxPVFVvdUxsekNtbldiVjFNWnQvUHNVM2ZqdzhrK1c1?=
 =?utf-8?Q?PmR2HawxXlrHkO4DVriCW2x3EpfA1rRw3KTjC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F5A96DFBB9B1C4CB19EE81CCA3C318E@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a84c794-8768-4cdd-26f1-08de62840a06
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2026 17:53:57.6295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwxZe7wxK67vp6ygsUWKKqJ+NZ4cn1/rfVL788aAtwVU7bQ7FaAuoxuNVHV3hwgZVAdu1EWyNiXe5ar8LoUW+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDE0MCBTYWx0ZWRfX+cBxJZkChQVV
 QZO75yXKHjsK3mfxeZHVZnf44DZlcc+tGCTE9tgzLS01+PkQFeT75BWWlA73GHgfL5WBKvpJech
 z0mLJjRx+KrDwKyqcLSPxdaEU9Rurd9Mq1ukusxVvbsZyCpHI3f6NNZzwNeay1LouTkUnuch6d/
 R3tzucZ2XIey2q4PWOubSl17gmWj4FmZb4HC0AHpz4ARvLU8kbyVNx5mY6lF0wWEJTaMxbGRjHc
 fT920dl2nGWsNWBB8q6MZr8uI6ppGzLv6hd3Hdmq9sLNvyiOtVGJjEMnKVf4MGiAAa55VGRE5xm
 AS79jRDTRMM/i43raSwGGpkiWGQ5RyZbTrObtUEssw26HwYdiutHlkPp7xXlk++B7Onr3Ft+ply
 5AY+yw3FlT60VsVtoT6EdAU+GVkZm5hqX3NMn4B/fLyMOqIZSXWdnzJvYSVv0gNB+oIV9/eYHPm
 HEp84L5J4gi4sVlTaTw==
X-Proofpoint-GUID: 16KtfyAuXrS94F9Zim1sMnelL3PoD1-N
X-Proofpoint-ORIG-GUID: Qq_jaSgkRok6EhWK-ka9zbgC5pIL3Mkm
X-Authority-Analysis: v=2.4 cv=LesxKzfi c=1 sm=1 tr=0 ts=6980e4b9 cx=c_pps
 a=ck9HhUZGATh9INII0mabYg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=szKgq9aCAAAA:8 a=azfAmh-JuxBtLZloruMA:9
 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
 a=R_ZFHMB_yizOUweVQPrY:22
Subject: Re:  [PATCH v2] hfsplus: fix s_fs_info leak on mount setup failure
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011
 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2602020140
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76073-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[physik.fu-berlin.de,gmail.com,dubeyko.com,vivo.com,vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpiricsoftware.com:email,proofpoint.com:url,appspotmail.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,99f6ed51479b86ac4c41];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 00AC3CFCE3
X-Rspamd-Action: no action

T24gU3VuLCAyMDI2LTAyLTAxIGF0IDE4OjQyICswNTMwLCBTaGFyZHVsIEJhbmthciB3cm90ZToN
Cj4gU3l6a2FsbGVyIHJlcG9ydGVkIGEgbWVtb3J5IGxlYWsgaW4gaGZzcGx1cyB3aGVyZSBzX2Zz
X2luZm8gKHNiaSkgaXMNCj4gYWxsb2NhdGVkIGluIGhmc3BsdXNfaW5pdF9mc19jb250ZXh0KCkg
YnV0IG5ldmVyIGZyZWVkIGlmIHRoZSBtb3VudA0KPiBzZXR1cCBmYWlscyBkdXJpbmcgc2V0dXBf
YmRldl9zdXBlcigpLg0KPiANCj4gSW4gZ2V0X3RyZWVfYmRldl9mbGFncygpLCBpZiBzZXR1cF9i
ZGV2X3N1cGVyKCkgZmFpbHMsIHRoZSBzdXBlcmJsb2NrDQo+IGlzIHRvcm4gZG93biB2aWEgZGVh
Y3RpdmF0ZV9sb2NrZWRfc3VwZXIoKS4gU2luY2UgdGhpcyBmYWlsdXJlIG9jY3Vycw0KPiBiZWZv
cmUgZmlsbF9zdXBlcigpIGlzIGNhbGxlZCwgdGhlIHN1cGVyYmxvY2sncyBvcGVyYXRpb25zIChz
Yi0+c19vcCkNCj4gYXJlIG5vdCB5ZXQgc2V0LiBDb25zZXF1ZW50bHksIHRoZSBzdGFuZGFyZCAt
PnB1dF9zdXBlcigpIGNhbGxiYWNrDQo+IGNhbm5vdCBiZSBpbnZva2VkLCBhbmQgdGhlIGFsbG9j
YXRlZCBzX2ZzX2luZm8gcmVtYWlucyBsZWFrZWQuDQo+IA0KPiBGaXggdGhpcyBieSBpbXBsZW1l
bnRpbmcgYSBjdXN0b20gLT5raWxsX3NiKCkgaGFuZGxlciwNCj4gaGZzcGx1c19raWxsX3NiKCks
IHdoaWNoIGV4cGxpY2l0bHkgZnJlZXMgc19mc19pbmZvIHVzaW5nIFJDVQ0KPiBzeW5jaHJvbml6
YXRpb24uIFRoaXMgZW5zdXJlcyBjbGVhbnVwIGhhcHBlbnMgcmVnYXJkbGVzcyBvZiB3aGV0aGVy
DQo+IGZpbGxfc3VwZXIoKSBzdWNjZWVkZWQgb3IgLT5wdXRfc3VwZXIoKSB3YXMgY2FsbGVkLg0K
PiANCj4gVG8gc3VwcG9ydCB0aGlzIG5ldyBsaWZlY3ljbGU6DQo+IDEuIEluIGhmc3BsdXNfcHV0
X3N1cGVyKCksIHJlbW92ZSB0aGUgY2FsbF9yY3UoKSBjYWxsLiBUaGUgYWN0dWFsIGZyZWVpbmcN
Cj4gICAgb2Ygc19mc19pbmZvIGlzIGRlZmVycmVkIHRvIGhmc3BsdXNfa2lsbF9zYigpLg0KPiAy
LiBJbiBoZnNwbHVzX2ZpbGxfc3VwZXIoKSwgcmVtb3ZlIHRoZSBleHBsaWNpdCBjbGVhbnVwIG9m
IHNiaSAoYm90aCBrZnJlZQ0KPiAgICBhbmQgdW5sb2FkX25scykgaW4gdGhlIGVycm9yIHBhdGgu
IFRoZSBWRlMgd2lsbCBjYWxsIC0+a2lsbF9zYigpIG9uDQo+ICAgIGZhaWx1cmUsIHNvIHJldGFp
bmluZyB0aGVzZSB3b3VsZCByZXN1bHQgaW4gZG91YmxlLWZyZWVzIG9yIHJlZmNvdW50DQo+ICAg
IHVuZGVyZmxvd3MuDQo+IDMuIEltcGxlbWVudCBoZnNwbHVzX2tpbGxfc2IoKSB0byBpbnZva2Ug
a2lsbF9ibG9ja19zdXBlcigpIGFuZCB0aGVuIGZyZWUNCj4gICAgc19mc19pbmZvIHZpYSBSQ1Uu
DQo+IA0KPiBSZXBvcnRlZC1ieTogc3l6Ym90Kzk5ZjZlZDUxNDc5Yjg2YWM0YzQxQHN5emthbGxl
ci5hcHBzcG90bWFpbC5jb20NCj4gQ2xvc2VzOiBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2lu
dC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX3N5emthbGxlci5hcHBzcG90LmNvbV9idWctM0ZleHRp
ZC0zRDk5ZjZlZDUxNDc5Yjg2YWM0YzQxJmQ9RHdJREFnJmM9QlNEaWNxQlFCRGpESTlSa1Z5VGNI
USZyPXE1YkltNEFYTXpjOE5KdTFfUkdtblEyZk1XS3E0WTRSQWtFbHZVZ1NzMDAmbT1jZGZtSHZl
Q05CMDZlLVJDVENPOUthaUhQUHJoV2lGczFjUHpKekxqeTE4dldnM1hGaDhVY3RSdlFlVFRyM0NI
JnM9ZDVWQTM0SW5haGZMNGRrU1BEWHpKT3NYbm1nN05PX1NzWldUVlVzZDh3VSZlPSANCj4gU2ln
bmVkLW9mZi1ieTogU2hhcmR1bCBCYW5rYXIgPHNoYXJkdWwuYkBtcGlyaWNzb2Z0d2FyZS5jb20+
DQo+IC0tLQ0KPiB2MToNCj4gIC0gdHJpZWQgdG8gZml4IHRoZSBsZWFrIGluIGZzL3N1cGVyLmMg
KFZGUyBsYXllcikuDQo+ICAtIExpbms6IGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNv
bS92Mi91cmw/dT1odHRwcy0zQV9fbG9yZS5rZXJuZWwub3JnX2FsbF8yMDI2MDIwMTA4MjcyNC5H
QzMxODM5ODctNDBaZW5JVl8mZD1Ed0lEQWcmYz1CU0RpY3FCUUJEakRJOVJrVnlUY0hRJnI9cTVi
SW00QVhNemM4Tkp1MV9SR21uUTJmTVdLcTRZNFJBa0VsdlVnU3MwMCZtPWNkZm1IdmVDTkIwNmUt
UkNUQ085S2FpSFBQcmhXaUZzMWNQekp6TGp5MTh2V2czWEZoOFVjdFJ2UWVUVHIzQ0gmcz1xNlcy
MkxJckFJSENwN0xTeEFaSTAwZjR6OEZCcGdGRVlWbmJRa2xIOUtVJmU9IA0KPiB2MjoNCj4gIC0g
YWJhbmRvbnMgdGhlIFZGUyBjaGFuZ2VzIGluIGZhdm9yIG9mIGEgZHJpdmVyLXNwZWNpZmljIGZp
eCBpbg0KPiAgICBoZnNwbHVzLCBpbXBsZW1lbnRpbmcgYSBjdXN0b20gLT5raWxsX3NiKCkgdG8g
aGFuZGxlIHRoZSBjbGVhbnVwDQo+ICAgIGxpZmVjeWNsZSwgYXMgc3VnZ2VzdGVkIGJ5IEFsIFZp
cm8uDQo+IA0KPiAgZnMvaGZzcGx1cy9zdXBlci5jIHwgMzAgKysrKysrKysrKysrKysrKysrLS0t
LS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZnMvaGZzcGx1cy9zdXBlci5jIGIvZnMvaGZzcGx1
cy9zdXBlci5jDQo+IGluZGV4IGFhZmZhOWUwNjBhMC4uY2M4MGNkNTQ1YTNlIDEwMDY0NA0KPiAt
LS0gYS9mcy9oZnNwbHVzL3N1cGVyLmMNCj4gKysrIGIvZnMvaGZzcGx1cy9zdXBlci5jDQo+IEBA
IC0zMTEsMTQgKzMxMSw2IEBAIHZvaWQgaGZzcGx1c19tYXJrX21kYl9kaXJ0eShzdHJ1Y3Qgc3Vw
ZXJfYmxvY2sgKnNiKQ0KPiAgCXNwaW5fdW5sb2NrKCZzYmktPndvcmtfbG9jayk7DQo+ICB9DQo+
ICANCj4gLXN0YXRpYyB2b2lkIGRlbGF5ZWRfZnJlZShzdHJ1Y3QgcmN1X2hlYWQgKnApDQo+IC17
DQo+IC0Jc3RydWN0IGhmc3BsdXNfc2JfaW5mbyAqc2JpID0gY29udGFpbmVyX29mKHAsIHN0cnVj
dCBoZnNwbHVzX3NiX2luZm8sIHJjdSk7DQo+IC0NCj4gLQl1bmxvYWRfbmxzKHNiaS0+bmxzKTsN
Cj4gLQlrZnJlZShzYmkpOw0KPiAtfQ0KPiAtDQo+ICBzdGF0aWMgdm9pZCBoZnNwbHVzX3B1dF9z
dXBlcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQ0KPiAgew0KPiAgCXN0cnVjdCBoZnNwbHVzX3Ni
X2luZm8gKnNiaSA9IEhGU1BMVVNfU0Ioc2IpOw0KPiBAQCAtMzQ0LDcgKzMzNiw2IEBAIHN0YXRp
YyB2b2lkIGhmc3BsdXNfcHV0X3N1cGVyKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IpDQo+ICAJaGZz
X2J0cmVlX2Nsb3NlKHNiaS0+ZXh0X3RyZWUpOw0KPiAgCWtmcmVlKHNiaS0+c192aGRyX2J1Zik7
DQo+ICAJa2ZyZWUoc2JpLT5zX2JhY2t1cF92aGRyX2J1Zik7DQo+IC0JY2FsbF9yY3UoJnNiaS0+
cmN1LCBkZWxheWVkX2ZyZWUpOw0KPiAgDQo+ICAJaGZzX2RiZygiZmluaXNoZWRcbiIpOw0KPiAg
fQ0KPiBAQCAtNjQ4LDkgKzYzOSw3IEBAIHN0YXRpYyBpbnQgaGZzcGx1c19maWxsX3N1cGVyKHN0
cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBmc19jb250ZXh0ICpmYykNCj4gIAlrZnJlZShz
YmktPnNfdmhkcl9idWYpOw0KPiAgCWtmcmVlKHNiaS0+c19iYWNrdXBfdmhkcl9idWYpOw0KPiAg
b3V0X3VubG9hZF9ubHM6DQo+IC0JdW5sb2FkX25scyhzYmktPm5scyk7DQo+ICAJdW5sb2FkX25s
cyhubHMpOw0KPiAtCWtmcmVlKHNiaSk7DQo+ICAJcmV0dXJuIGVycjsNCj4gIH0NCj4gIA0KPiBA
QCAtNzA5LDEwICs2OTgsMjcgQEAgc3RhdGljIGludCBoZnNwbHVzX2luaXRfZnNfY29udGV4dChz
dHJ1Y3QgZnNfY29udGV4dCAqZmMpDQo+ICAJcmV0dXJuIDA7DQo+ICB9DQo+ICANCj4gK3N0YXRp
YyB2b2lkIGRlbGF5ZWRfZnJlZShzdHJ1Y3QgcmN1X2hlYWQgKnApDQo+ICt7DQo+ICsJc3RydWN0
IGhmc3BsdXNfc2JfaW5mbyAqc2JpID0gY29udGFpbmVyX29mKHAsIHN0cnVjdCBoZnNwbHVzX3Ni
X2luZm8sIHJjdSk7DQo+ICsNCj4gKwl1bmxvYWRfbmxzKHNiaS0+bmxzKTsNCj4gKwlrZnJlZShz
YmkpOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBoZnNwbHVzX2tpbGxfc2Ioc3RydWN0IHN1
cGVyX2Jsb2NrICpzYikNCj4gK3sNCj4gKwlzdHJ1Y3QgaGZzcGx1c19zYl9pbmZvICpzYmkgPSBz
Yi0+c19mc19pbmZvOw0KPiArDQo+ICsJa2lsbF9ibG9ja19zdXBlcihzYik7DQo+ICsJaWYgKHNi
aSkNCj4gKwkJY2FsbF9yY3UoJnNiaS0+cmN1LCBkZWxheWVkX2ZyZWUpOw0KPiArfQ0KPiArDQo+
ICBzdGF0aWMgc3RydWN0IGZpbGVfc3lzdGVtX3R5cGUgaGZzcGx1c19mc190eXBlID0gew0KPiAg
CS5vd25lcgkJPSBUSElTX01PRFVMRSwNCj4gIAkubmFtZQkJPSAiaGZzcGx1cyIsDQo+IC0JLmtp
bGxfc2IJPSBraWxsX2Jsb2NrX3N1cGVyLA0KPiArCS5raWxsX3NiCT0gaGZzcGx1c19raWxsX3Ni
LA0KPiAgCS5mc19mbGFncwk9IEZTX1JFUVVJUkVTX0RFViwNCj4gIAkuaW5pdF9mc19jb250ZXh0
ID0gaGZzcGx1c19pbml0X2ZzX2NvbnRleHQsDQo+ICB9Ow0KDQpUaGUgcGF0Y2ggWzFdIGZpeGVz
IHRoZSBpc3N1ZSBhbmQgaXQgaW4gSEZTL0hGUysgdHJlZSBhbHJlYWR5Lg0KDQpUaGFua3MsDQpT
bGF2YS4NCg0KWzFdDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1mc2RldmVsLzIwMjUx
MjAxMjIyODQzLjgyMzEwLTMtbWVoZGkuYmVuaGFkamtoZWxpZmFAZ21haWwuY29tLw0KDQo=

