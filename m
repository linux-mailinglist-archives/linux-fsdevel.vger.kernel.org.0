Return-Path: <linux-fsdevel+bounces-60598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 696B6B49A06
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 21:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248153BAD4C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 19:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0445298CAB;
	Mon,  8 Sep 2025 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VWfOn0tl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8A912CDA5
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757360013; cv=fail; b=jOdhuwNezLfBpzSf3R2QD3BifoTiGlC9Rj/W1sEbNYFMwjCMNSwNfKWQ96Etkuir0Mj/XJ8og75YhbxrNlUJW1g6yOE/LRZNOHfY2vWkcw+GpjLzqr1qBxVQ9FeO4edi6otwJpeEfW3peXYbU6vMJ7l+0vSD4GsvWo2EnNxeqW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757360013; c=relaxed/simple;
	bh=sAPkMde7XLHZtD7+qXtaPuz5Ule0JyoMyepveS0blsg=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=fR5qk/fOH8pVpXfanbK9BIE2gJbMW8U3tkbM2v3CRmz2cXe2Zqn39h6CnR7rc2xJDzASnok0YY3PdtyUu/3OPXWs8fIm+lgyxbTxx1l2YaRAZ5JfWJmZrEpoboKU4GjCX7N27XTxfudHdXpzV0GFoSndnMUNG2xmChGRrPj11wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VWfOn0tl; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588IbRjp010463;
	Mon, 8 Sep 2025 19:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=sAPkMde7XLHZtD7+qXtaPuz5Ule0JyoMyepveS0blsg=; b=VWfOn0tl
	5zHbmkNhAbhJANcMd7uTgn7HSgJ8Rf9ILafaQYjqjqTbd+VZMTOu0JJPm5coI7rB
	Dp4TQSq5br8LHUgZpDPx912Hij3FmrDDxwZPYrVHuefwp9mM8JqDh1HZsSZrvijZ
	FWo15vuN/i7+SscUbPhbYdi1umCXZtlaMe1CH8l23B4uuiZzzhhj5sDL2Z1HhJY4
	m2Jq3E1n9UrKjS5vdmxH63Fj6CYV2WTy8201rPDxwnsvTJDtp1lb95ySxX/AzkPa
	blHnuUJc3Jm6ZOjjZDEbpNX22LF2ilUUqrmqQywl1K6mEE1gC6V23ztZScCy8qaE
	odDYPcoXhllC+w==
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cmwkhu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Sep 2025 19:33:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiS/1TJGPEUk/4SJAtMzgX+0eQh6kCm1GopJny8VNark61ncp1gNIqG/jVkWX0sIAS/M+zScfIyvl83bPYX9zqOV0+AbyoBgANA9Jka6nJRlfNlaZBTMpvR2xfNkB6DmJT0OAf0tFSCkAg+S/GvcyAGE+2hEWXiFt8MNR3XykF85yxNRBWtNBpkp7Q40VjZKtl8V1q44e3XN1FkPaff6kEJwdj/y7qaelpdC7Ywf+9vuWgnaBvHoVjA8p20u3WF6xcSIKjDn17uTuAxIlu70IU1Ua3Rhvph2ZGiHwPCCO0SInu44vSS7nWPvvIL2rbia9z9UH35QOVsQH58kGLhvng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAPkMde7XLHZtD7+qXtaPuz5Ule0JyoMyepveS0blsg=;
 b=ASmcZsseoQ736lBKZfEbU4JUp+wIV6LDtoS/pAOOFfZPFgwzXp3i0kUePu2Q9ztyzbYn2V35zyi5s+gHd456VxcIRam5ZTAV+3FICrbbWQjpbciPWnGyF+kcJ+1u9fRtOvckV2aZCqAFFwRdwmNCeSaQMVT3Y2UJW60YieMtrDfGS8d2EvwX4tHzPHPzmYe/3IUgRMcX3SkPratn+38elYih1DhA+7uVx4wm3WO3L2nKuSegZE7i8smaClv8A3T5MdT/kCantu80W6b/gH6ryOT271pBV6cD8k+++MsSNAzkUNtQCUWzsG4fNaKA9KYLGdipRK4eIn6yfd4XPJo20w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by BY1PR15MB6151.namprd15.prod.outlook.com (2603:10b6:a03:533::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 19:33:03 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%3]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 19:33:02 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "security@kernel.org" <security@kernel.org>,
        "k.chen@smail.nju.edu.cn"
	<k.chen@smail.nju.edu.cn>
CC: "wenzhi.wang@uwaterloo.ca" <wenzhi.wang@uwaterloo.ca>,
        "frank.li@vivo.com"
	<frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "liushixin2@huawei.com" <liushixin2@huawei.com>
Thread-Topic: [EXTERNAL] [SECURITY] [PATCH V2] hfsplus: fix slab-out-of-bounds
 read in hfsplus_uni2asc()
Thread-Index: AQHcH5QyWrqD3oXG+UyZuJ6AzR5H4LSJr56A
Date: Mon, 8 Sep 2025 19:33:02 +0000
Message-ID: <a0e7e4375a1ffee6a25edc8ced939c8abe53c667.camel@ibm.com>
References: <20250907010826.597854-1-k.chen@smail.nju.edu.cn>
In-Reply-To: <20250907010826.597854-1-k.chen@smail.nju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|BY1PR15MB6151:EE_
x-ms-office365-filtering-correlation-id: ae727f5a-731d-4f19-d8ce-08ddef0e86d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dU43VHh3aCtLdUdrQTJlNkhWMldxZ0FGUWlYMkNNMDBwZktaRVlleFJDalJt?=
 =?utf-8?B?QnpobFVDZkEyZU45UVlFb0ZJRm9Fd2xwUXYrMThTY0RPdzJWcVBKODcvdVFL?=
 =?utf-8?B?YlpjUmNxNmVibVlKRjlzZmFEWXdiUGFSOVhmYlJPSE40eUdNQzVOSnVWckVu?=
 =?utf-8?B?eHlNUXlDV0xHUDhkRnlEQzBSbTJiYkdnOTMrdVc1ODZPYTV5a08rZGtWM2Fl?=
 =?utf-8?B?aWNoaXQ1Q1J5d2pyc1Fqa1BOREU5eFNQblNUQTNRVEs3VVh5OEpJb3RiWitx?=
 =?utf-8?B?M0YvMDRIUzJydUdrYnMxQnFBSDF6OHN1N0loYTNRQXlsOVJ1dDBmNnU1SVl1?=
 =?utf-8?B?N2JqSGRZcDRSemtyekxjaEx2WWF1dkZ6NkFpY1YvcjRSY2RFUVlkUGV1RVdz?=
 =?utf-8?B?eTlQcXc2QTk5ZWJ5RUJBSXpRTHNrZk83RUJqTmZpQUNDUmVRNnZiZFpoRHo2?=
 =?utf-8?B?ZUJwd3JnalRMQk9tVjV3QllRSGY2OWZqMysyaEgvSVI1T0cya1grOXBWSS9D?=
 =?utf-8?B?UkgzSy9QMEd4SGJZMjJLdU0xVVpCRDUzYXprNmJUdldHOE9UWUtkYllneFdw?=
 =?utf-8?B?M3VZSHN1WTcyQzQ5MmFxOGQ4aGpPa3RIZlpHMDUyZzkwV3FIeGdZNmxlNTh3?=
 =?utf-8?B?aFBCVjFpYjdweWZSSURKS0M4RzQxQ2d3bFlmK1A3S1RzcE1sYXVic0JBcGxs?=
 =?utf-8?B?Nk1od0Jpbm1iQXhGRHlLVUVYa1pRMGJkSWZOTDY1SHgxUHpSb2Z3TzA5MlVQ?=
 =?utf-8?B?L1ZNNjcyWVNzeXp5Wk1sUDZ2Mm9FWlorTlNuRjI3OS8vYWpGREJnMGxXVkhN?=
 =?utf-8?B?UjE1RXZUOGV0VmY1QWxNeVIwUG5yS0plZC9lU2dGWkMwVERsamM0TlFTUUJJ?=
 =?utf-8?B?THJNZURpb0lDMGs1Q1JzbTR5cUJsb0ZnbEJNRnRBWTE5MW5ZMXVMMVlkZ0pl?=
 =?utf-8?B?Z0dYR0o4TDdrZHZlSTY0aWdTUFNURU9iRzNqS2V6cTd4UTljY3UvNFZOeVd1?=
 =?utf-8?B?WDlCUW82cG5aOUUyNmxlUzg1N0lpTXFBTGRaYzgyenJweWNQTEF6UFJzdE42?=
 =?utf-8?B?SThNZmhVMzROKytYK3VEb3BKV1ViclQrbE5JWkFYZWZUUTdBSjNkTW50T1BS?=
 =?utf-8?B?T0RCcXZQZGZyeWpvYWpmUUxKQnpuU21xc0VLYXRPY001b29xeThBYTE0aG1I?=
 =?utf-8?B?YzRBaUhROE1qclhlZExDZVhCcDJFWmVMVVBmN1FGLzRpc0FqU290YUROeWcv?=
 =?utf-8?B?c0FJN3NBcjh0bEw2RzZJVEd3R0Myb1QrQ05PNHphTFpkTFF2UkxBdzhpUW1X?=
 =?utf-8?B?azhWN0x1VWd4N3pKNVhrbzF4Q2U0VklTRW9pVkZodGZQOVNrYS9aWnM2WnFW?=
 =?utf-8?B?TG1ZRHlGSHkxbzZnMUxUcFRRTUxOUmllRE1GYi9zMDMzd2NXNjFuTDFQaW0y?=
 =?utf-8?B?NTFHSFhPS2VWdkJUS3hBNXAzUkQzYWFyUTdheitGdGV4RDd1NkUwNUNqcHhl?=
 =?utf-8?B?a2N0bWdrUlJUUzJGSjV6VUtXckh4Y2hZb3lRZTlxQUY3RmFxUUhxRWFuUlE3?=
 =?utf-8?B?akdlS0hGMFVhdnFNS0F4Q0UyRXhnbGJNclduaE02dm5BcHNndTArT3h2WE1E?=
 =?utf-8?B?K2xwNHgzYjBwQkYxa0I5Ri82QkNjUm1Jb0ZLZnhyMmU0RlpVcy9TK0ZyeG5N?=
 =?utf-8?B?NmxXZmpiUlpGb1dnL0NRV1BSZStHeWwwV1VDcHFtL1FUTEphL0VrWHZhVVdB?=
 =?utf-8?B?NnF5cFVwUkFKQnIrMHZlY3R4RVNDQnpQM1MwWm1vNVAzbmU4dlllYSttQUZk?=
 =?utf-8?B?WGRhcEUxdnFoU2VTUGNBUzlXZzFHRVpwaE5rVFhNSEdHc0Z4TWRoRngwVjg4?=
 =?utf-8?B?bmFybVFmZGVQR0Q2ejkrekl2cmMvS1hVbmd2d3BGVmpucmVpTXpkMnB3Yno2?=
 =?utf-8?B?a0ZwWGcwT08wazlpQy9pU1NWaVlHSWx5WmFjNitaRDNTWVlUUnVraFRYNjhB?=
 =?utf-8?B?S0NlNG51WFp3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aXZoVmx3K0VhUko1M1JyYm9INjBPQWJkQ0k0SDNJLzU5UHg4ZkVGbVZpNld1?=
 =?utf-8?B?UXhGSlNpOUxoVjJSekdsWWRuSG93bWNwMjYvWkRKK2IxWFQ5YVV3eWhpMnQ4?=
 =?utf-8?B?VnJ6SHEyTDRGeHhXWG4rZHFydURYSlJ2SDNXZWZXN0p6ekgxZk91aXNEQWZ1?=
 =?utf-8?B?aGFML0FxWHpQWVBWQ1ErbTZ5c1BwNk5iWVIzMjVTYWhiVGtDaVBsem5BWXZt?=
 =?utf-8?B?MExCL3d2QzNsTmJzQmczUno2QkhrWDRiNFB2SnV6YitTNnZYb3RLOHBwdXJK?=
 =?utf-8?B?cjkzQnlYY0NGVHpIaGNVUUNVL3JBNXAzZ1NQMlBGR1I0L29xdXp0Q1JjR29s?=
 =?utf-8?B?ZFFpb2FtZjBqTDh2UlBmZi90VlVpR3dKeFpsMmp1QXU0dmdxTjVVNU9GV0dj?=
 =?utf-8?B?UG5qYkdOZUNyWVV6U1l4dWpMU3FuQUpJUzhBdG1rb3l4cVRNN2kvZmk4SVVm?=
 =?utf-8?B?MlRNSGttQ2hja3F2TDdNUjBtYXEwcHp2Y2I5TDY5SmZjRnVvWXFaR0sycnZp?=
 =?utf-8?B?bjNiUmozV1kzb21yNXFSek1NQXRialNqT0UyYTNsby8zRG14NlFHYnAzMDVa?=
 =?utf-8?B?RmUyT0hsZ3RTblRqeVhtcTFTTXdZb0E1dDRIbDZvVWRDQUVlZDNmOGlYVW1w?=
 =?utf-8?B?U21Mci9WS2ZLNSs3SXFjblZmVkhPanlYQXZnbnFQM05PcURxWGUyVmtaQ2Ez?=
 =?utf-8?B?cVIvVXk1TFRNcUFVVDhtT2xtNkpJbGEvNUNKQTg2RUk4TXB0ditDeS96SGtv?=
 =?utf-8?B?YW41QnY3MzdRc2Y5c1c3Z0NzaExUQU5nU2VWVTlyYmNicGl3VHd2RzlYU2hT?=
 =?utf-8?B?Zlh6UDZQM3hYOTd3eWxqc0tVUWtKQmYrcEFTZFpwSFNKa0hDYW1aWjRPT29i?=
 =?utf-8?B?S29xZnV1R055K2ZLL2hKaHBYUkZwYVZORGhxeE9mV1NHL2JWeXZnakQreW5T?=
 =?utf-8?B?eWJLakdaQjZGd1pDUDhGU3FXWTRWdzMrNTNpQytjNzkySmk5NVVzbGtxcHZH?=
 =?utf-8?B?aFNDNFhoUUVXbHZXeHIxalVIVlRyWWZiZzE5V3hrTW56eVJJcldXQmplRXVZ?=
 =?utf-8?B?TGd5Y0ZTd29MdXdsWHhCWFYwcHd5cjRmM2g2WWxPV1J0Sy9KLzExb0wvUU9Y?=
 =?utf-8?B?RWYvaFhkRzlLUWc4VEh6ZjFzaGNIZUtNeFdaQVBQOGZMUjZQa1N2bXJXOTR1?=
 =?utf-8?B?V0l4Si9LWmNKVm9SNG1sSEg1VDUzaERnQnNOZlhBd2xpeFZiQWtuNGZGQ2dE?=
 =?utf-8?B?SmZrQ3pMdzFIc1JDUUJFNERtSldVRWYrYmxKRGd1TnFNL2pidVUxUFczQ0J0?=
 =?utf-8?B?VmNEcDZYTUhKOHZPV1NWQUx6OFVvcVVlQzR0SjV6Zlo0aFAvb3N6TEhKajBm?=
 =?utf-8?B?V2NqTHE2WVdNckY4MExGanJNaUgvVWdhQ1hmL3NGaE1yemhJa2ZCWW95YnQy?=
 =?utf-8?B?WlQvdFJoZGxRMnQxcGRxOWJGeklLWXFIOWNoUCsvamtidVNjRFkxVUVrN1VI?=
 =?utf-8?B?dHRLYWtTK0l0bUFNNDk0ZmtkTDZ5MGdXSENSbTVTcWlyY05hK3Z5QmYwa1Q1?=
 =?utf-8?B?cVBOY01XcHhHcE1jOXlTSEhZczRtMkNJcEdjWWp1SVM2S0R6V2puVnNZbTFl?=
 =?utf-8?B?WVFRTUFYZCtrSVJ6M3FXT1hrRXdMYmFWd09lSlZQU0tjbFc1Sy9WM3FSQ2lo?=
 =?utf-8?B?SzFXMCt3QmlTV1BQOGtlek5UMFo2dUk3ZlJJSnRVcTdVaXp1dVUwVFJEYTFt?=
 =?utf-8?B?OFFhc2Y2Nk14Smh0enJHelRKN05zMUdUMGIxa2NreGNJNWlYam0zLzFYR0hi?=
 =?utf-8?B?N29EMFVuRVBaUTd5cnd1VEo4L1cvbXF0TGZDQ3p2aGdxY0JJVnkwMWVqMlo0?=
 =?utf-8?B?SSswVStGS25SSkcvK3lyNjBDRUw4Y1BZcWdYc25wWlNVa2tRZjQ3WEo0QVQz?=
 =?utf-8?B?dXBuclcyL05UajB2dUwyS2hqWlZUWTNTcGRqQlJJT2ZEVVY3elVWbjhmaEhG?=
 =?utf-8?B?cUgvM3pvUUM1SStrSmNKT0RjMmpzNFBnSjllUGJ0RXpxb2RramVkUjRHRkxL?=
 =?utf-8?B?TU5sV01WMVFkLzdtemFNVEdWVEtDQTI2VFNabm5RRjd0NFVKTjNjc1g5Wnhp?=
 =?utf-8?B?Q1dyZ3BjTjY4Y3kvZlp5WlJYMnAzVThlYWZYZnRpTVhXYWhJYnhIL3oxQnYz?=
 =?utf-8?Q?0TclENpDnwR9VIhbrPwbv48=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1915DCDB54959B4DB303DDC0EB00DAD1@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ae727f5a-731d-4f19-d8ce-08ddef0e86d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2025 19:33:02.6921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GlybTFlMskhEco7HJB3Xu2pObdX9LlmiLHY7/gSCjwspsWzFzq4r8dhrfHJuU0xhuRwL/RDYGN8IEyKsVuTLNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR15MB6151
X-Proofpoint-GUID: RqaMjw7YNQhex6UYTTf769JHT5SNElSW
X-Proofpoint-ORIG-GUID: RqaMjw7YNQhex6UYTTf769JHT5SNElSW
X-Authority-Analysis: v=2.4 cv=J52q7BnS c=1 sm=1 tr=0 ts=68bf2f72 cx=c_pps
 a=rktla+E3bJZWaxI4NRrvhQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=je2pBUoAVm5VoedKxYgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyNSBTYWx0ZWRfX8Bioi+TblgVy
 cc7RONybEzphlgUZDSuLjZtaNwmDYIW2yB3/YKMJJvtEaLBuyulQjQ6IMaRmH2a1KIKC6mnmnWH
 Xl98g9DOoPar7ugK/KZNcj40Jd8YdnFXNBVfcjgwmJQ+DIbCHnuvBfqX1opK1u2k8x7J+RRRvon
 KAqwa+eYmltfq0ipTSKKxfmg95MxhYFsxN/8g0rq1bjYIn3XE9NrLPhUhpsB7bfQ0ylmyBR477A
 g9HDQDpdSGrcMZKew1gZmVbb2REWqiNwMduyofJHO4Zd/jNgMjgCaNGbkSYBQv4IY6LfMPXgQ6V
 SK1T2pL9YPkSacRB+53HOF5qusO6gCXmz697phNXtuZIC9u6oCbzVz9dxPQM/QdqMK/TN5hl5c8
 jwnzFtdq
Subject: Re:  [SECURITY] [PATCH V2] hfsplus: fix slab-out-of-bounds read in
 hfsplus_uni2asc()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060025

T24gU3VuLCAyMDI1LTA5LTA3IGF0IDA5OjA4ICswODAwLCBrLmNoZW4gd3JvdGU6DQo+IFRoZSBw
cmV2aW91cyBmaXggKDk0NDU4NzgxYWVlNikgd2FzIGluc3VmZmljaWVudCwNCj4gYXMgaXQgZGlk
IG5vdCBjb25zaWRlciB0aGF0DQo+IHNpemVvZihzdHJ1Y3QgaGZzcGx1c19hdHRyX3VuaXN0cikg
IT0gc2l6ZW9mKHN0cnVjdCBoZnNwbHVzX3VuaXN0cikuDQoNCkNvdWxkIHlvdSBwbGVhc2UgZXhw
bGFpbiBpbiBtb3JlIGRldGFpbHMgd2hhdCBpcyBpc3N1ZSBoZXJlIGFuZCBob3cgaGF2ZSB5b3UN
CmZpeGVkIHRoZSBpc3N1ZT8NCg0KQ3VycmVudGx5LCBpdCBpcyByZWFsbHkgaGFyZCB0byBmb2xs
b3cgdG8gdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQo+IA0KPiBGaXhlczogOTQ0NTg3ODFhZWU2ICgi
aGZzcGx1czogZml4IHNsYWItb3V0LW9mLWJvdW5kcyByZWFkIGluIGhmc3BsdXNfdW5pMmFzYygp
IikNCj4gU2lnbmVkLW9mZi1ieTogay5jaGVuIDxrLmNoZW5Ac21haWwubmp1LmVkdS5jbj4NCg0K
SXQgd2lsbCBiZSByZWFsbHkgZ3JlYXQgaWYgeW91IGNhbiBzaGFyZSB5b3VyIGZ1bGwgbmFtZS4N
Cg0KPiAtLS0NCj4gVjIgLT4gVjE6IGNoYW5nZSBzdHJ1Y3QgcG9pbnRlciB0eXBlIHRvIHBhc3Mg
Y29tcGlsZXINCj4gDQo+ICBmcy9oZnNwbHVzL2Rpci5jICAgICAgICB8IDMgKystDQo+ICBmcy9o
ZnNwbHVzL2hmc3BsdXNfZnMuaCB8IDIgKy0NCj4gIGZzL2hmc3BsdXMvdW5pY29kZS5jICAgIHwg
OSArKysrLS0tLS0NCj4gIGZzL2hmc3BsdXMveGF0dHIuYyAgICAgIHwgNiArKysrLS0NCj4gIDQg
ZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9mcy9oZnNwbHVzL2Rpci5jIGIvZnMvaGZzcGx1cy9kaXIuYw0KPiBpbmRleCA4
NzZiYmI4MGZiNGQuLjc2NTYyN2ZjNWViZSAxMDA2NDQNCj4gLS0tIGEvZnMvaGZzcGx1cy9kaXIu
Yw0KPiArKysgYi9mcy9oZnNwbHVzL2Rpci5jDQo+IEBAIC0yMDQsNyArMjA0LDggQEAgc3RhdGlj
IGludCBoZnNwbHVzX3JlYWRkaXIoc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBkaXJfY29udGV4
dCAqY3R4KQ0KPiAgCQkJZmQuZW50cnlsZW5ndGgpOw0KPiAgCQl0eXBlID0gYmUxNl90b19jcHUo
ZW50cnkudHlwZSk7DQo+ICAJCWxlbiA9IE5MU19NQVhfQ0hBUlNFVF9TSVpFICogSEZTUExVU19N
QVhfU1RSTEVOOw0KPiAtCQllcnIgPSBoZnNwbHVzX3VuaTJhc2Moc2IsICZmZC5rZXktPmNhdC5u
YW1lLCBzdHJidWYsICZsZW4pOw0KPiArCQllcnIgPSBoZnNwbHVzX3VuaTJhc2Moc2IsICZmZC5r
ZXktPmNhdC5uYW1lLCBIRlNQTFVTX01BWF9TVFJMRU4sDQoNClByb2JhYmx5LCBpdCBtYWtlcyBz
ZW5zZSB0byBpbnRyb2R1Y2UgYSBjb25zdGFudCB0byBrZWVwIG9uZS1saW5lIGNhbGwuDQpXaHkg
bm90IGRlY2xhcmUgYWJvdmUgbGlrZXdpc2UgY29uc3RhbnQ/DQoNCmNvbnN0IHNpemVfdCBtYXhf
bGVuID0gSEZTUExVU19NQVhfU1RSTEVOOw0KDQo+ICsJCQkJICAgICAgc3RyYnVmLCAmbGVuKTsN
Cj4gIAkJaWYgKGVycikNCj4gIAkJCWdvdG8gb3V0Ow0KPiAgCQlpZiAodHlwZSA9PSBIRlNQTFVT
X0ZPTERFUikgew0KPiBkaWZmIC0tZ2l0IGEvZnMvaGZzcGx1cy9oZnNwbHVzX2ZzLmggYi9mcy9o
ZnNwbHVzL2hmc3BsdXNfZnMuaA0KPiBpbmRleCA5NmE1YzI0ODEzZGQuLjQ5ZDk3YzQ2ZmQwYSAx
MDA2NDQNCj4gLS0tIGEvZnMvaGZzcGx1cy9oZnNwbHVzX2ZzLmgNCj4gKysrIGIvZnMvaGZzcGx1
cy9oZnNwbHVzX2ZzLmgNCj4gQEAgLTUyMiw3ICs1MjIsNyBAQCBpbnQgaGZzcGx1c19zdHJjYXNl
Y21wKGNvbnN0IHN0cnVjdCBoZnNwbHVzX3VuaXN0ciAqczEsDQo+ICBpbnQgaGZzcGx1c19zdHJj
bXAoY29uc3Qgc3RydWN0IGhmc3BsdXNfdW5pc3RyICpzMSwNCj4gIAkJICAgY29uc3Qgc3RydWN0
IGhmc3BsdXNfdW5pc3RyICpzMik7DQo+ICBpbnQgaGZzcGx1c191bmkyYXNjKHN0cnVjdCBzdXBl
cl9ibG9jayAqc2IsIGNvbnN0IHN0cnVjdCBoZnNwbHVzX3VuaXN0ciAqdXN0ciwNCj4gLQkJICAg
IGNoYXIgKmFzdHIsIGludCAqbGVuX3ApOw0KPiArCQkgICAgaW50IG1heF91bmlzdHJfbGVuLCBj
aGFyICphc3RyLCBpbnQgKmxlbl9wKTsNCg0KbWF4X2xlbiBjb3VsZCBiZSBlbm91Z2gsIGZvciBt
eSB0YXN0ZS4NCg0KPiAgaW50IGhmc3BsdXNfYXNjMnVuaShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNi
LCBzdHJ1Y3QgaGZzcGx1c191bmlzdHIgKnVzdHIsDQo+ICAJCSAgICBpbnQgbWF4X3VuaXN0cl9s
ZW4sIGNvbnN0IGNoYXIgKmFzdHIsIGludCBsZW4pOw0KPiAgaW50IGhmc3BsdXNfaGFzaF9kZW50
cnkoY29uc3Qgc3RydWN0IGRlbnRyeSAqZGVudHJ5LCBzdHJ1Y3QgcXN0ciAqc3RyKTsNCj4gZGlm
ZiAtLWdpdCBhL2ZzL2hmc3BsdXMvdW5pY29kZS5jIGIvZnMvaGZzcGx1cy91bmljb2RlLmMNCj4g
aW5kZXggMzZiNmNmMmEzYWJiLi5iNDMwMzc4NWJhMWUgMTAwNjQ0DQo+IC0tLSBhL2ZzL2hmc3Bs
dXMvdW5pY29kZS5jDQo+ICsrKyBiL2ZzL2hmc3BsdXMvdW5pY29kZS5jDQo+IEBAIC0xMTksOSAr
MTE5LDggQEAgc3RhdGljIHUxNiAqaGZzcGx1c19jb21wb3NlX2xvb2t1cCh1MTYgKnAsIHUxNiBj
YykNCj4gIAlyZXR1cm4gTlVMTDsNCj4gIH0NCj4gIA0KPiAtaW50IGhmc3BsdXNfdW5pMmFzYyhz
dHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLA0KPiAtCQljb25zdCBzdHJ1Y3QgaGZzcGx1c191bmlzdHIg
KnVzdHIsDQo+IC0JCWNoYXIgKmFzdHIsIGludCAqbGVuX3ApDQo+ICtpbnQgaGZzcGx1c191bmky
YXNjKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIGNvbnN0IHN0cnVjdCBoZnNwbHVzX3VuaXN0ciAq
dXN0ciwNCj4gKwkJICAgIGludCBtYXhfdW5pc3RyX2xlbiwgY2hhciAqYXN0ciwgaW50ICpsZW5f
cCkNCg0KQW5vdGhlciBwb3NzaWJsZSB3YXkgaXMgdG8gbWFrZSBoZnNwbHVzX3VuaTJhc2MoKSBi
eSBzdGF0aWMgZnVuY3Rpb24gYW5kIHRvDQppbnRyb2R1Y2UgdHdvIGlubGluZSBmdW5jdGlvbnMg
aGZzcGx1c191bmkyYXNjX3N0cigpLA0KaGZzcGx1c191bmkyYXNjX3hhdHRyX3N0cigpLiBXaGF0
IGRvIHlvdSB0aGluaz8NCg0KPiAgew0KPiAgCWNvbnN0IGhmc3BsdXNfdW5pY2hyICppcDsNCj4g
IAlzdHJ1Y3QgbmxzX3RhYmxlICpubHMgPSBIRlNQTFVTX1NCKHNiKS0+bmxzOw0KPiBAQCAtMTM0
LDggKzEzMyw4IEBAIGludCBoZnNwbHVzX3VuaTJhc2Moc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwN
Cj4gIAlpcCA9IHVzdHItPnVuaWNvZGU7DQo+ICANCj4gIAl1c3RybGVuID0gYmUxNl90b19jcHUo
dXN0ci0+bGVuZ3RoKTsNCj4gLQlpZiAodXN0cmxlbiA+IEhGU1BMVVNfTUFYX1NUUkxFTikgew0K
PiAtCQl1c3RybGVuID0gSEZTUExVU19NQVhfU1RSTEVOOw0KPiArCWlmICh1c3RybGVuID4gbWF4
X3VuaXN0cl9sZW4pIHsNCj4gKwkJdXN0cmxlbiA9IG1heF91bmlzdHJfbGVuOw0KPiAgCQlwcl9l
cnIoImludmFsaWQgbGVuZ3RoICV1IGhhcyBiZWVuIGNvcnJlY3RlZCB0byAlZFxuIiwNCj4gIAkJ
CWJlMTZfdG9fY3B1KHVzdHItPmxlbmd0aCksIHVzdHJsZW4pOw0KPiAgCX0NCj4gZGlmZiAtLWdp
dCBhL2ZzL2hmc3BsdXMveGF0dHIuYyBiL2ZzL2hmc3BsdXMveGF0dHIuYw0KPiBpbmRleCAxOGRj
M2QyNTRkMjEuLjQ1NmM3ZDZiMjM1NiAxMDA2NDQNCj4gLS0tIGEvZnMvaGZzcGx1cy94YXR0ci5j
DQo+ICsrKyBiL2ZzL2hmc3BsdXMveGF0dHIuYw0KPiBAQCAtNzM2LDggKzczNiwxMCBAQCBzc2l6
ZV90IGhmc3BsdXNfbGlzdHhhdHRyKHN0cnVjdCBkZW50cnkgKmRlbnRyeSwgY2hhciAqYnVmZmVy
LCBzaXplX3Qgc2l6ZSkNCj4gIA0KPiAgCQl4YXR0cl9uYW1lX2xlbiA9IE5MU19NQVhfQ0hBUlNF
VF9TSVpFICogSEZTUExVU19BVFRSX01BWF9TVFJMRU47DQo+ICAJCWlmIChoZnNwbHVzX3VuaTJh
c2MoaW5vZGUtPmlfc2IsDQo+IC0JCQkoY29uc3Qgc3RydWN0IGhmc3BsdXNfdW5pc3RyICopJmZk
LmtleS0+YXR0ci5rZXlfbmFtZSwNCj4gLQkJCQkJc3RyYnVmLCAmeGF0dHJfbmFtZV9sZW4pKSB7
DQo+ICsJCQkJICAgIChjb25zdCBzdHJ1Y3QgaGZzcGx1c191bmlzdHIgKikmZmQua2V5LT5hdHRy
DQo+ICsJCQkJCSAgICAua2V5X25hbWUsDQo+ICsJCQkJICAgIEhGU1BMVVNfQVRUUl9NQVhfU1RS
TEVOLCBzdHJidWYsDQo+ICsJCQkJICAgICZ4YXR0cl9uYW1lX2xlbikpIHsNCg0KRnJhbmtseSBz
cGVha2luZywgaXQgbG9va3MgbGlrZSBhIG1lc3MuIENvdWxkIHdlIG1ha2UgaXQgbW9yZSBjb21w
YWN0IGFuZA0KY2xlYW5lcj8gQ291bGQgeW91IHBsZWFzZSByZXdvcmsgaXQ/DQoNClRoYW5rcywN
ClNsYXZhLg0KDQo+ICAJCQlwcl9lcnIoInVuaWNvZGUgY29udmVyc2lvbiBmYWlsZWRcbiIpOw0K
PiAgCQkJcmVzID0gLUVJTzsNCj4gIAkJCWdvdG8gZW5kX2xpc3R4YXR0cjsNCg==

