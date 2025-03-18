Return-Path: <linux-fsdevel+bounces-44360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D03A67DD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 21:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3A443BBE8F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 20:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BA82139B0;
	Tue, 18 Mar 2025 20:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VyDsBrTQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33AD1F3BBF;
	Tue, 18 Mar 2025 20:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328791; cv=fail; b=QxFw9jDFjERJlkZDWqcd04omJAZcgI64UI00RmVuaoHzaOxpXUpevmIjraSDn9Mh/ZRzV20iYvN/EoEd4p96EyudOHW0ClGzaI/hmhN1YA0JJLUaNbDnD45hITuslUF+IgDZIRPT1pC/MeVcuV4CE1FfB48Rly+sfV0TZWN/E9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328791; c=relaxed/simple;
	bh=/5BuWgyDac54ouL7TcTcH5Fo4ER2qsN7byb+EaqNgQQ=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=olUGUHWICSTD044D1tjDmk76ts7K7qyhNOBHwJO/RFSsyNwNMwPYrbTEeKtGYk/ddjqkoSUgSsGfeGna4IO6e7THV6libxUC4AOjg6t6j8c+SecNidtXTCQyVev9EEo8XIR5xbg7djUMZI/fToWRUiWqN9+qAnqIh6/XgUcEX9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VyDsBrTQ; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52II5SkC002930;
	Tue, 18 Mar 2025 20:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=/5BuWgyDac54ouL7TcTcH5Fo4ER2qsN7byb+EaqNgQQ=; b=VyDsBrTQ
	jeH2pNp0sd+U3i3n4nh0cLDO9UMnY13GcKlqJlIUkIlain8keQ9lrh6X3wfI0o23
	9YXbAqn0/w85eq9st0WXgV/ceb37mzJdru2cWihIGGGK50WCSaO3x7el6NXgS/Kh
	mYtCFpt4ZhBlHDHLAAS/LLjQHeM+obh+QT8080I41PnFjzOzPM4EE9rn6H/5cHxi
	AEkQMRz4XEI87eotyANCJd1DOD5xJCLd9vG1tDlFp7ZCfxPoijaTUHgD8I/mEkhs
	gb5mm62J97ndo4WOLjDaoUE3cirex1Hup2/XLhJT/tBX9QuirsIniY5ci0PsSwaA
	QBlkhad7RFx+JA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ety0p1x8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 20:12:54 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52IKCsrC021638;
	Tue, 18 Mar 2025 20:12:54 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ety0p1x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Mar 2025 20:12:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Be5vJizjgFRok1XLZvoq/vWNYbG4eHX77dwmVjJVHVrubN1oa3qUo/0zuADOQwm63nWkuPjVdvDyzZggTeOM4K71ZnQU3popysDUUrS8Ueay7x5bbVjivzgcS6iSS14Nthipa32fcbD45aN4ZTQqEFF42IUxN735zWZCiFd9Tn9vlcJAuauoL6zY0IQPzoS3U+LTe3UdkCj1tiY6+kGfkOUZGNvYKacoonS9eiYIiq2IVVuufRbu5U59pGOQCEZ4bYKAD1pGEdLVqN3WidldNlWw5MOz/J2ZVCKz6fk8MtKQNjE+Jv2N9Xo1Iq1YefZ8m1XCYfmVipa+/8OW/WScCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5BuWgyDac54ouL7TcTcH5Fo4ER2qsN7byb+EaqNgQQ=;
 b=JZdfBMprZM2F5BBBgeD68V3KMw14lZy4fwCV+HV7wOUelePpQQwwwgqxeqaJfcprLpdWYmbrLzXwROX3jvq1QfxToTn76sNyCEMnqe0QhX6K9yRsG68/HTslWNiVWUqNXSDVmu3EuF1szG13xoCbB9nbjvMNLr8zppMbfRvxFR+8MCm73yuYiFn0D3JpSlAK6E+O5g/2COJiWkNXzhm1/8SpjDDMdPs2bVSDk+c86U6CDTFVsx89i4GrazcBmm1hRf350bFOlBoZnmBqRGczUAhFQu6FYQafwOtYCyER9AXtvtRaBxyXEqZw3JnhGT03DOxEbtsyWl12fvCzyXpi6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA3PR15MB6171.namprd15.prod.outlook.com (2603:10b6:806:2f3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 20:12:52 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 20:12:52 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Alex Markuze <amarkuze@redhat.com>,
        "slava@dubeyko.com"
	<slava@dubeyko.com>,
        David Howells <dhowells@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "jlayton@kernel.org"
	<jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "dongsheng.yang@easystack.cn"
	<dongsheng.yang@easystack.cn>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Topic: [EXTERNAL] [RFC PATCH 21/35] libceph: Make notify code use
 ceph_databuf_enc_start/stop
Thread-Index: AQHblHFm+lr8kFJUekySH38xE55q4LN5W12A
Date: Tue, 18 Mar 2025 20:12:51 +0000
Message-ID: <229984a0b00679cc2f1bbfb42df4174c6c896fd2.camel@ibm.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
	 <20250313233341.1675324-22-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-22-dhowells@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA3PR15MB6171:EE_
x-ms-office365-filtering-correlation-id: 38d24e79-7aee-4b1d-4299-08dd66594317
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bXV5dTRoYnR2MGJveDEyNE1sUkVJTzlkczRWNUxiZkxCeHljWnlidGx5YTVR?=
 =?utf-8?B?V1MrY3ZsRlZOVXVZeWxJVUF3QnJkQWNQb20wZXlyUXpOSW1wUHkwMDBBTmVM?=
 =?utf-8?B?cTExVFgxMVUwdEliZzY5eTd3Q21YQUg2ODAxWUx1WGpTRlFPNUdndkozQUIr?=
 =?utf-8?B?TnNrT2Q1bHhET1N2MXREcy95WCt3OFZEVmZqeVp0b1hRRVdHckpVeFRxVmhx?=
 =?utf-8?B?MitDMFNDQy9DTzZZanlwWEVIZ0RQYy93dUh5cGkyRmJPUGdWZmE1d3AwRXBq?=
 =?utf-8?B?NkxlRHNSSzAwRWNhdDI4dXVGeWhPdVNpeEVZSlZDOFVLM1BxRHdjYkJDZTNZ?=
 =?utf-8?B?cUQxZ0liVU40NkN4bHlYRWFUczhnOGh3WU95dDdjc21UQnQ4bEd5akRtVFZW?=
 =?utf-8?B?VmxzNkVvU25JVzREd3pXaUxLMW00VHB6aFFXTDNqY2FDT1MvSVNuTk9HZzlK?=
 =?utf-8?B?OW5BZVRreFd0aVhicEhDQ0h4MmJMOW53YUJsd0RjODRjSDNEcUw1bG9xb0lk?=
 =?utf-8?B?bWFHSTdPbUlpZlVDTjltVTFEVWsvcEh5TWVoSE1tZlNmQU9mTDJWNUIxcmF0?=
 =?utf-8?B?KzMzVkhKR1BJcCs0eWoxdGFDQXd3WW9RQzVhUnhrMFFRRytGZ0NFeVJva1lh?=
 =?utf-8?B?QVh4ZE5qTXJhWmNaVFQza1A4MWtLZTJwVmltRGZvcDlUeU41SWF0bGx3N0dT?=
 =?utf-8?B?cVlTWjlHUDBkOVh5Qmt3dldIbDZmNlljUXIwUDNJdk93Y2gzMHNhSjZmV3ZK?=
 =?utf-8?B?b2JjKys1UHVZQ2QrUmRRVjdQd25LQTVKRUpBU1A1YVNGQjRFNWlFbzRRRGZD?=
 =?utf-8?B?bXU2YmNtYjM2dWZrYUtFSUNqcFZwL2hmaURFQTF6OTB3cDNLTEtsbjlvb1pJ?=
 =?utf-8?B?aTR4TlJGa2RZS2VDU0t5K25uTlpNS0Q5YmRGdi9CNCtKQmhlMVJsSzlnQjlF?=
 =?utf-8?B?RGhuMU0yY2Z6NUVzdXorSlh1Tk90Zy9xWE03SG10YjkxR3JvMFBQNUMvRFgv?=
 =?utf-8?B?d2hnMXpqeDdobDRySnBlUjc4NG1YSHdjWTNtdFNNVXVaYmVHVFFBNy9iaVI1?=
 =?utf-8?B?emR2VVp0WEpjRUV2bDFnQmN1bi9QNkx0NWMzKzZWSWxrRE5zTzdReXFUUTk1?=
 =?utf-8?B?Z0hmT0E5TW54M0g4SmdmaHRWWDlvOTVBRTRIWmJCQjFmUUpHR1RLNGZGTnEv?=
 =?utf-8?B?VlRJYkZINkMxSTN1NTZ4aUU1Z1RIUUgrNVl4QkxnT01jeDNLWFUvT2pybll0?=
 =?utf-8?B?N3FXNHFlUVVPaTlKM3cwc05mZll2K01VZCt3L3UxdXBETlk5OUVIWVI5cFhi?=
 =?utf-8?B?Ui9tTmlMemdvdkVhTjdXUm5jbGUwdllERWhBRzBNV1UvQ2F3cndOMVZ6UGRP?=
 =?utf-8?B?eVkrRk5oTjVFOE9rZEhuelpzOUoyOHVYV1FPMXcwVEdZLzVFN2pYb1Rya2hC?=
 =?utf-8?B?RlMrRXhmeVRjZVBIa1VDdVpiOWRCVjBBUysxSTlVQmxoQUZPelM0U0cwc09I?=
 =?utf-8?B?WmQ0TEZENmk5aXRPWE1lOW1mNXJkS3NIcnJHTGE3QTA4MzJVbk1hSDJuQndR?=
 =?utf-8?B?RitNNko1VGloOTZDZ0pjWHlHSXF0N0thYjUvdFlUVE85YXhKKzJhZXlHejZX?=
 =?utf-8?B?ejNaL0xBNHZuRm0xYWQ2KzFNYmxiVUg2cDVJQWFSbG9zemV1WSttaDlTdCtn?=
 =?utf-8?B?VmdOM0hVNTg4d3NoenFIazRLV0tBNHJjVHFTTnloN04zNkYvQmZCWU5FNjFj?=
 =?utf-8?B?RXdLVTNnOXltUFA5bU1TdHkvQVFhNER0WlR5VWppTEVNRmRNTXhTZ3Z0SnE5?=
 =?utf-8?B?bXFXN09kVG9pY2lWaGQ2ai9XZHRybUEwUHhQaExmVzltWm5iRy9TcHBJM09l?=
 =?utf-8?B?R3VCeDVGdmdUb1k0VUNCdFRMdDl3NGJ2Wk1tYnRyRytMeUVUNmpOeFY0bTZG?=
 =?utf-8?Q?A8o7jOxNe0k3zScfIEwxKfuwDDkcdMEm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWh3RWdsTXgzYm10c05BbElHL1BMYTI1NCt1NldCcTR2NkhSS0F6aDlKSWN1?=
 =?utf-8?B?N2o4V2RldjNtalBXWGR1ZElYNUNGSGh0blg0Q3RSRFZxVlhRMXgyeTFoT0w4?=
 =?utf-8?B?VWhUd0RNdjRBb3VSbU1ZczJ5NUJmVnNvTDU0djFpS2gyb2RkMGZjYjBMZlBk?=
 =?utf-8?B?RmJaVjBtVm9XL25TdUtobWJYekZNNHkxdndMalNLK1hlblk5ZkE1Y0tENGNP?=
 =?utf-8?B?dTE1RWZYRFdYdGRycFN3d0Mrc3RVYzhGOGpia0ZHM3lZSDFGaXRsRFNZa2tE?=
 =?utf-8?B?SDhHdTFYUzd6UUVhcjMwZ0VQNHpZK2ZCQnJ2Sy9NNlY1Syt2Q1kzcmlvTVFp?=
 =?utf-8?B?YWF5WjNwZ1dGQ3ErdENvQzhuSFUvLzVWQ1FTb25ySkhISzNaVEM4d3ExSmVY?=
 =?utf-8?B?bzVkSUlXcVNZRVlmVTRjWUJ0V0pUSW1UWFJuSzYyZnowV1l0ZnE4ZWlWeHd6?=
 =?utf-8?B?MmNxNWlLNkx3ZzlyeUxDQjIvS2s0NTdLYVkrMW5vMXhrS05takhCd1haSUFz?=
 =?utf-8?B?Rm9rRXQzSjNDYjNBSUtKVDF2Y0VWcW1YWXRQd0M5WWlNZndGa2RvS3dlQ0Jm?=
 =?utf-8?B?bWxPN25Rb0FBV0ZtY1NOVERqN1NEWE5TOVo4NXFndDVWalcxcHZ5NjRxcWhp?=
 =?utf-8?B?T2FGVnVoUCtKUzJxSjIwWkpldHp0WE9QQ1pXTnJIRnd5cVRlSzNndktmeEI0?=
 =?utf-8?B?OUpXZDU2QTVuOS9oaXh4a0JTSlR1dUkyaFJScVlWaUhwUVp5a091anNCeDVw?=
 =?utf-8?B?VGRJKzRiclJDeFJGalNZSm1Gd1hNL09aNFU0Y25yKzVHN2srcDNQcytvQVdt?=
 =?utf-8?B?Y0tZWUsvTnFaOG5ScElCQUk4T2QvK0dVNExZMjluT1lUYnB4cFdNQ2pRN01l?=
 =?utf-8?B?RHR5M0szZEZBWWNKUE9weEYxaWVaTXZQeGF1cFpmY0gzaDlYRFkxNGNwOFRD?=
 =?utf-8?B?b3owN282eTFlSmNycStDR2Y0dGJXVEoyMnRuWENxWDVobm56ajVhR1kvT01N?=
 =?utf-8?B?Nm1rRjg1LzNRaExvdWQ4NDJDcFF4WlErYlRDa0tIOTEvMWw5UXJRaDFFcFBw?=
 =?utf-8?B?eE0wNmxRNDB6YS92ZzcrNlpyWHkyeDVySm5mRS84T0pHV1pIeng1RFNRU2pR?=
 =?utf-8?B?YWJ6cjQwNEo3MFFlQUR2Q1ZoM1Y5OVZSRTdDSkVLNmdnNjQrNDRVOUtLWkNu?=
 =?utf-8?B?RUVYUHpVcldNT1pZSHVPSi93b2EwNjhMeTZoLzJlWHo2VEJqN1NtSUZKaTlu?=
 =?utf-8?B?VzFiOW5yTDZPSktpMDBpL1RxRFFKMVRuSmtZampBWk1HTDFwN2lhbUZOOW5L?=
 =?utf-8?B?NlRKeDlEVlU2QnZ6SkNHbG1ValJhcnVUVW91ODROTUpVRXovdTRnVWlMS3NH?=
 =?utf-8?B?K2V3aE9CR29WdXBOaUVzdC8wQkFvS214YXF0TXh3YXBOU0k0cU9ORUdHK28w?=
 =?utf-8?B?SEVEd1poenBoYWMrYWhURzVnUGV3VkdLeTV3b2JoS0pxNDYvMG5uODF1ZFkw?=
 =?utf-8?B?bWxuSFVyUkpSenNpaThWUDlxejJOWlFoRytCVFgySytkTy9aRkFJaTU2Tm0x?=
 =?utf-8?B?bWhMYlV4Q1JsZDd5b1ZRY1B3b1RqMVVONmVOUGMrOXZDNmpqOE1KUGg3RS9t?=
 =?utf-8?B?NXBDMEl4WUwrdUMyTWZDbnVkNkZkSStRNDNaLzJubnZwL29oMnNvcmhvU1Zr?=
 =?utf-8?B?eTYzaDZWcE5KQ3JmNHdjSk8rSWpVcko1WHRHUWVYanVleWQ3SkFQbFJReHVW?=
 =?utf-8?B?QXNDckxTQ1JEdFd6bjFWenpBUVZrMUQweG0xVTg4SHBONTIvTXkvc0d5ZWg3?=
 =?utf-8?B?SFRuTE9kS054QS83TVJtMGVGSnFhZ3RDeTQ5cDFYREF1cW9NK3BPa3dxMlVw?=
 =?utf-8?B?QzMrUy9PMStKNURYcUtINmhZdHZ3c0JndUNJdEw3MXlwTXBkcSsxTXdMdTFM?=
 =?utf-8?B?ZXZpa2lka29aNDMvUGJLTkZoWEw4TXlJZVI0OHlpVWIwOXZ1cjgyRUQ2ajVq?=
 =?utf-8?B?eEVETzlpSTJmTklqUm9FU0U3NE5PREZtT21jMlNCOWJyZFd2NDgyNjRXZ09o?=
 =?utf-8?B?ZnhPeHBOMGFyeHY3TExyQk9DblFyWW9UMElKWGtzZHl6Nzd2MHVmNWMxeUxG?=
 =?utf-8?B?bDZQRmEvV05tZG1MUmhXT3ZRdHR0U3hwMkNUZmwxU2N4czlMN3lONUFsLzVz?=
 =?utf-8?Q?GyVV+MgVlNOIWn+z5qlc/+A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F94ED4D308C34419EA1298F2BF6C308@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d24e79-7aee-4b1d-4299-08dd66594317
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 20:12:51.9978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gEZbwD2EBJ5Hl+56Ty9Ze/TLiPXBlpi7RmWehwA89gHBsHPE9RC3N/aztfqYpNseI7nEAoW3zs6f4BDcxLaTQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB6171
X-Proofpoint-GUID: rac4Z_GvYLT0lG_3NFSrJLP6bAnosyUo
X-Proofpoint-ORIG-GUID: ftQM96hR8MvHX6_CGDHLZsrnxqjTyySb
Subject: Re:  [RFC PATCH 21/35] libceph: Make notify code use
 ceph_databuf_enc_start/stop
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503180144

T24gVGh1LCAyMDI1LTAzLTEzIGF0IDIzOjMzICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBNYWtlIHRoZSBjZXBoX29zZGNfbm90aWZ5KigpIGZ1bmN0aW9ucyB1c2UgY2VwaF9kYXRhYnVm
X2VuY19zdGFydCgpIGFuZA0KPiBjZXBoX2RhdGFidWZfZW5jX3N0b3AoKSB3aGVuIGZpbGxpbmcg
b3V0IHRoZSByZXF1ZXN0IGRhdGEuICBBbHNvIHVzZQ0KPiBjZXBoX2VuY29kZV8qKCkgcmF0aGVy
IHRoYW4gY2VwaF9kYXRhYnVmX2VuY29kZV8qKCkgYXMgdGhlIGxhdHRlciB3aWxsIGRvDQo+IGFu
IGl0ZXJhdG9yIGNvcHkgdG8gZGVhbCB3aXRoIHBhZ2UgY3Jvc3NpbmcgYW5kIG1pc2FsaWdubWVu
dCAodGhlIGxhdHRlcg0KPiBiZWluZyBzb21ldGhpbmcgdGhhdCB0aGUgQ1BVIHdpbGwgaGFuZGxl
IG9uIHNvbWUgYXJjaGVzKS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIEhvd2VsbHMgPGRo
b3dlbGxzQHJlZGhhdC5jb20+DQo+IGNjOiBWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5
a28uY29tPg0KPiBjYzogQWxleCBNYXJrdXplIDxhbWFya3V6ZUByZWRoYXQuY29tPg0KPiBjYzog
SWx5YSBEcnlvbW92IDxpZHJ5b21vdkBnbWFpbC5jb20+DQo+IGNjOiBjZXBoLWRldmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBjYzogbGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmcNCj4gLS0tDQo+
ICBuZXQvY2VwaC9vc2RfY2xpZW50LmMgfCA1NSArKysrKysrKysrKysrKysrKysrKystLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwgMjgg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L2NlcGgvb3NkX2NsaWVudC5jIGIv
bmV0L2NlcGgvb3NkX2NsaWVudC5jDQo+IGluZGV4IDBhYzQzOWU3ZTczMC4uMWEwY2IyY2RjYzUy
IDEwMDY0NA0KPiAtLS0gYS9uZXQvY2VwaC9vc2RfY2xpZW50LmMNCj4gKysrIGIvbmV0L2NlcGgv
b3NkX2NsaWVudC5jDQo+IEBAIC00NzU5LDcgKzQ3NTksMTAgQEAgc3RhdGljIGludCBvc2RfcmVx
X29wX25vdGlmeV9hY2tfaW5pdChzdHJ1Y3QgY2VwaF9vc2RfcmVxdWVzdCAqcmVxLCBpbnQgd2hp
Y2gsDQo+ICB7DQo+ICAJc3RydWN0IGNlcGhfb3NkX3JlcV9vcCAqb3A7DQo+ICAJc3RydWN0IGNl
cGhfZGF0YWJ1ZiAqZGJ1ZjsNCj4gLQlpbnQgcmV0Ow0KPiArCXZvaWQgKnA7DQo+ICsNCj4gKwlp
ZiAoIXBheWxvYWQpDQo+ICsJCXBheWxvYWRfbGVuID0gMDsNCj4gIA0KPiAgCW9wID0gb3NkX3Jl
cV9vcF9pbml0KHJlcSwgd2hpY2gsIENFUEhfT1NEX09QX05PVElGWV9BQ0ssIDApOw0KPiAgDQo+
IEBAIC00NzY3LDE4ICs0NzcwLDEzIEBAIHN0YXRpYyBpbnQgb3NkX3JlcV9vcF9ub3RpZnlfYWNr
X2luaXQoc3RydWN0IGNlcGhfb3NkX3JlcXVlc3QgKnJlcSwgaW50IHdoaWNoLA0KPiAgCWlmICgh
ZGJ1ZikNCj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+ICANCj4gLQlyZXQgPSBjZXBoX2RhdGFidWZf
ZW5jb2RlXzY0KGRidWYsIG5vdGlmeV9pZCk7DQo+IC0JcmV0IHw9IGNlcGhfZGF0YWJ1Zl9lbmNv
ZGVfNjQoZGJ1ZiwgY29va2llKTsNCj4gLQlpZiAocGF5bG9hZCkgew0KPiAtCQlyZXQgfD0gY2Vw
aF9kYXRhYnVmX2VuY29kZV8zMihkYnVmLCBwYXlsb2FkX2xlbik7DQo+IC0JCXJldCB8PSBjZXBo
X2RhdGFidWZfYXBwZW5kKGRidWYsIHBheWxvYWQsIHBheWxvYWRfbGVuKTsNCj4gLQl9IGVsc2Ug
ew0KPiAtCQlyZXQgfD0gY2VwaF9kYXRhYnVmX2VuY29kZV8zMihkYnVmLCAwKTsNCj4gLQl9DQo+
IC0JaWYgKHJldCkgew0KPiAtCQljZXBoX2RhdGFidWZfcmVsZWFzZShkYnVmKTsNCj4gLQkJcmV0
dXJuIC1FTk9NRU07DQo+IC0JfQ0KPiArCXAgPSBjZXBoX2RhdGFidWZfZW5jX3N0YXJ0KGRidWYp
Ow0KPiArCWNlcGhfZW5jb2RlXzY0KCZwLCBub3RpZnlfaWQpOw0KPiArCWNlcGhfZW5jb2RlXzY0
KCZwLCBjb29raWUpOw0KPiArCWNlcGhfZW5jb2RlXzMyKCZwLCBwYXlsb2FkX2xlbik7DQo+ICsJ
aWYgKHBheWxvYWQpDQo+ICsJCWNlcGhfZW5jb2RlX2NvcHkoJnAsIHBheWxvYWQsIHBheWxvYWRf
bGVuKTsNCj4gKwljZXBoX2RhdGFidWZfZW5jX3N0b3AoZGJ1ZiwgcCk7DQo+ICANCj4gIAljZXBo
X29zZF9kYXRhYnVmX2luaXQoJm9wLT5ub3RpZnlfYWNrLnJlcXVlc3RfZGF0YSwgZGJ1Zik7DQo+
ICAJb3AtPmluZGF0YV9sZW4gPSBjZXBoX2RhdGFidWZfbGVuKGRidWYpOw0KPiBAQCAtNDg0MCw4
ICs0ODM4LDEyIEBAIGludCBjZXBoX29zZGNfbm90aWZ5KHN0cnVjdCBjZXBoX29zZF9jbGllbnQg
Km9zZGMsDQo+ICAJCSAgICAgc2l6ZV90ICpwcmVwbHlfbGVuKQ0KPiAgew0KPiAgCXN0cnVjdCBj
ZXBoX29zZF9saW5nZXJfcmVxdWVzdCAqbHJlcTsNCj4gKwl2b2lkICpwOw0KPiAgCWludCByZXQ7
DQo+ICANCj4gKwlpZiAoV0FSTl9PTl9PTkNFKHBheWxvYWRfbGVuID4gUEFHRV9TSVpFIC0gMyAq
IDQpKQ0KDQpXaHkgUEFHRV9TSVpFIC0gMyAqIDQ/IENvdWxkIG1ha2UgdGhpcyBtb3JlIGNsZWFy
IGhlcmU/DQoNCj4gKwkJcmV0dXJuIC1FSU87DQo+ICsNCj4gIAlXQVJOX09OKCF0aW1lb3V0KTsN
Cj4gIAlpZiAocHJlcGx5X3BhZ2VzKSB7DQo+ICAJCSpwcmVwbHlfcGFnZXMgPSBOVUxMOw0KPiBA
QCAtNDg1MiwyMCArNDg1NCwxOSBAQCBpbnQgY2VwaF9vc2RjX25vdGlmeShzdHJ1Y3QgY2VwaF9v
c2RfY2xpZW50ICpvc2RjLA0KPiAgCWlmICghbHJlcSkNCj4gIAkJcmV0dXJuIC1FTk9NRU07DQo+
ICANCj4gLQlscmVxLT5yZXF1ZXN0X3BsID0gY2VwaF9kYXRhYnVmX3JlcV9hbGxvYygxLCBQQUdF
X1NJWkUsIEdGUF9OT0lPKTsNCj4gKwlscmVxLT5yZXF1ZXN0X3BsID0gY2VwaF9kYXRhYnVmX3Jl
cV9hbGxvYygwLCAzICogNCArIHBheWxvYWRfbGVuLA0KDQpUaGUgc2FtZSBxdWVzdGlvbi4uLiA6
KQ0KDQpUaGFua3MsDQpTbGF2YS4NCg0KPiArCQkJCQkJICBHRlBfTk9JTyk7DQo+ICAJaWYgKCFs
cmVxLT5yZXF1ZXN0X3BsKSB7DQo+ICAJCXJldCA9IC1FTk9NRU07DQo+ICAJCWdvdG8gb3V0X3B1
dF9scmVxOw0KPiAgCX0NCj4gIA0KPiAtCXJldCA9IGNlcGhfZGF0YWJ1Zl9lbmNvZGVfMzIobHJl
cS0+cmVxdWVzdF9wbCwgMSk7IC8qIHByb3RfdmVyICovDQo+IC0JcmV0IHw9IGNlcGhfZGF0YWJ1
Zl9lbmNvZGVfMzIobHJlcS0+cmVxdWVzdF9wbCwgdGltZW91dCk7DQo+IC0JcmV0IHw9IGNlcGhf
ZGF0YWJ1Zl9lbmNvZGVfMzIobHJlcS0+cmVxdWVzdF9wbCwgcGF5bG9hZF9sZW4pOw0KPiAtCXJl
dCB8PSBjZXBoX2RhdGFidWZfYXBwZW5kKGxyZXEtPnJlcXVlc3RfcGwsIHBheWxvYWQsIHBheWxv
YWRfbGVuKTsNCj4gLQlpZiAocmV0KSB7DQo+IC0JCXJldCA9IC1FTk9NRU07DQo+IC0JCWdvdG8g
b3V0X3B1dF9scmVxOw0KPiAtCX0NCj4gKwlwID0gY2VwaF9kYXRhYnVmX2VuY19zdGFydChscmVx
LT5yZXF1ZXN0X3BsKTsNCj4gKwljZXBoX2VuY29kZV8zMigmcCwgMSk7IC8qIHByb3RfdmVyICov
DQo+ICsJY2VwaF9lbmNvZGVfMzIoJnAsIHRpbWVvdXQpOw0KPiArCWNlcGhfZW5jb2RlXzMyKCZw
LCBwYXlsb2FkX2xlbik7DQo+ICsJY2VwaF9lbmNvZGVfY29weSgmcCwgcGF5bG9hZCwgcGF5bG9h
ZF9sZW4pOw0KPiArCWNlcGhfZGF0YWJ1Zl9lbmNfc3RvcChscmVxLT5yZXF1ZXN0X3BsLCBwKTsN
Cj4gIA0KPiAgCS8qIGZvciBub3RpZnlfaWQgKi8NCj4gIAlscmVxLT5ub3RpZnlfaWRfYnVmID0g
Y2VwaF9kYXRhYnVmX3JlcGx5X2FsbG9jKDEsIFBBR0VfU0laRSwgR0ZQX05PSU8pOw0KPiBAQCAt
NTIxNyw3ICs1MjE4LDcgQEAgaW50IG9zZF9yZXFfb3BfY29weV9mcm9tX2luaXQoc3RydWN0IGNl
cGhfb3NkX3JlcXVlc3QgKnJlcSwNCj4gIHsNCj4gIAlzdHJ1Y3QgY2VwaF9vc2RfcmVxX29wICpv
cDsNCj4gIAlzdHJ1Y3QgY2VwaF9kYXRhYnVmICpkYnVmOw0KPiAtCXZvaWQgKnAsICplbmQ7DQo+
ICsJdm9pZCAqcDsNCj4gIA0KPiAgCWRidWYgPSBjZXBoX2RhdGFidWZfcmVxX2FsbG9jKDEsIFBB
R0VfU0laRSwgR0ZQX0tFUk5FTCk7DQo+ICAJaWYgKCFkYnVmKQ0KPiBAQCAtNTIzMCwxNSArNTIz
MSwxMyBAQCBpbnQgb3NkX3JlcV9vcF9jb3B5X2Zyb21faW5pdChzdHJ1Y3QgY2VwaF9vc2RfcmVx
dWVzdCAqcmVxLA0KPiAgCW9wLT5jb3B5X2Zyb20uZmxhZ3MgPSBjb3B5X2Zyb21fZmxhZ3M7DQo+
ICAJb3AtPmNvcHlfZnJvbS5zcmNfZmFkdmlzZV9mbGFncyA9IHNyY19mYWR2aXNlX2ZsYWdzOw0K
PiAgDQo+IC0JcCA9IGttYXBfY2VwaF9kYXRhYnVmX3BhZ2UoZGJ1ZiwgMCk7DQo+IC0JZW5kID0g
cCArIFBBR0VfU0laRTsNCj4gKwlwID0gY2VwaF9kYXRhYnVmX2VuY19zdGFydChkYnVmKTsNCj4g
IAljZXBoX2VuY29kZV9zdHJpbmcoJnAsIHNyY19vaWQtPm5hbWUsIHNyY19vaWQtPm5hbWVfbGVu
KTsNCj4gIAllbmNvZGVfb2xvYygmcCwgc3JjX29sb2MpOw0KPiAgCWNlcGhfZW5jb2RlXzMyKCZw
LCB0cnVuY2F0ZV9zZXEpOw0KPiAgCWNlcGhfZW5jb2RlXzY0KCZwLCB0cnVuY2F0ZV9zaXplKTsN
Cj4gLQlvcC0+aW5kYXRhX2xlbiA9IFBBR0VfU0laRSAtIChlbmQgLSBwKTsNCj4gLQljZXBoX2Rh
dGFidWZfYWRkZWRfZGF0YShkYnVmLCBvcC0+aW5kYXRhX2xlbik7DQo+IC0Ja3VubWFwX2xvY2Fs
KHApOw0KPiArCWNlcGhfZGF0YWJ1Zl9lbmNfc3RvcChkYnVmLCBwKTsNCj4gKwlvcC0+aW5kYXRh
X2xlbiA9IGNlcGhfZGF0YWJ1Zl9sZW4oZGJ1Zik7DQo+ICANCj4gIAljZXBoX29zZF9kYXRhYnVm
X2luaXQoJm9wLT5jb3B5X2Zyb20ub3NkX2RhdGEsIGRidWYpOw0KPiAgCXJldHVybiAwOw0KPiAN
Cg0K

