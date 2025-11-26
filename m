Return-Path: <linux-fsdevel+bounces-69918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E0127C8BAA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 20:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8EE5F35824A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 19:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2610340A67;
	Wed, 26 Nov 2025 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="BAof0no/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E671340290
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186247; cv=fail; b=qMoygq6usYRRQBFv9oN81wLVZaa/0Ag3u+LCMgMzAgtmuYXJmL/9NpoAKbQd/+cBSbfMijYWD+Nx3D9+ubsmT+kAz/yUBeMZY7CjkdksXvIWKy3KTW+UzKhgYSeicrjUmhO4rYHDxJqA+I1sY9yyMQCR9WjO+DxnBBld1qnw5s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186247; c=relaxed/simple;
	bh=bu3EjEPVjO9loBiz4TRznC6JGvXXBRHbEQdDdJ57Iik=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YCxWFsN2dzZ/C9U/vGIND/dNhlTH3vYV+1x8Bo42MF0q9DnjXthiPhe/zVxSD5ecVVs1egg4qoyBA4PsNv4po3cThYHVtpT1e2jMSEkkYEKAQkvIhOQHwyULYLO+UirdBvbr2hDZOiBZecy+8KEMeuGYS2LEdh6RJHn8Kw5Vg4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=BAof0no/; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020098.outbound.protection.outlook.com [52.101.61.98]) by mx-outbound13-110.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 26 Nov 2025 19:43:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sySRoVh9kZyvc73NWSYesuSh/vz32N2uZs3yFT1UJrTFVwuqGwv00feqhu3G32yyKenVrHI/iZeMKUfDAksSLizkDWKERFWFLpmtXXkazislvgwdgjmjMMttwFjsMpgPrFxFYTSUVDvmHAn0iyIHnfsz4gfa44A0+CYGim9LdbdatzVblql5eegFY6G8mcwqlJgz8dgI/+0/6vVh3J2KnhEN53Dg94tChPfQqcPApWxpnGN6WoscKWXx874PrRJxJrVYOfEhW35KeVDOayfMWteskyWtjyFimxB6IGABdjEHnuyA5Oe42xfP+2M4hDl5QqfGzEhKW6xPnZ9QHsr9kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bu3EjEPVjO9loBiz4TRznC6JGvXXBRHbEQdDdJ57Iik=;
 b=lcbRyMCncGoi2CVjFHTXj2YwTvtvvnXOypikJXo2IuiDTmvsGYGoe2CoY2LydBt5JgjmXroZ4ZxSJNRxkGwnzG/BugF7t/46BIOY2CAt/ex0iivQk8jftFQO4j5JD8+xf8o4R6ArpGKLC38oXnaF1oatjr9PIlT+zQpgZgm02LxYqAHRqdIzCTugkHD3GHNcVFfNJoW/KJJnbIMLxPyoQjNNJTZWfwU/YUkKIjMaITIYazIPxXtf+ySxey7OvcsypGvbxhTQAp0zE4M8daA7qFf8tRD/fBW2q8HKV+eUE9lLvQs98SM44sFFkWnwVmCwjhPLk39sRcPpBrliwUjurA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bu3EjEPVjO9loBiz4TRznC6JGvXXBRHbEQdDdJ57Iik=;
 b=BAof0no/7ZuF1Ftxvbnvwul+YEEeTl4oICbx/6t/T69pxLruHIkfewozMgkMyDc1jBHws6hRGcoc/7vV8jHkvJBPY2+sh0XLtP33WuMf5HBIMAmLLO0bdYJXdBsYVKu/6um8gKdU3N0OuDVg0XKdTyit8yjVyCu+LU7cDU21Brc=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by PH8PR19MB6641.namprd19.prod.outlook.com (2603:10b6:510:1c0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Wed, 26 Nov
 2025 19:11:42 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9366.012; Wed, 26 Nov 2025
 19:11:41 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Abhishek Gupta <abhishekmgupta@google.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: "miklos@szeredi.hu" <miklos@szeredi.hu>, Swetha Vadlakonda
	<swethv@google.com>
Subject: Re: FUSE: [Regression] Fuse legacy path performance scaling lost in
 v6.14 vs v6.8/6.11 (iodepth scaling with io_uring)
Thread-Topic: FUSE: [Regression] Fuse legacy path performance scaling lost in
 v6.14 vs v6.8/6.11 (iodepth scaling with io_uring)
Thread-Index: AQHcXuZx9b5pWktoG0+UcBaSWX3FrbUFUzGA
Date: Wed, 26 Nov 2025 19:11:41 +0000
Message-ID: <e6a41630-c2e6-4bd9-aea9-df38238f6359@ddn.com>
References:
 <CAPr64AJFZVFTHnuY=AH3aMXb2-g1ypzheNbLtfu5RxyZztKFZg@mail.gmail.com>
In-Reply-To:
 <CAPr64AJFZVFTHnuY=AH3aMXb2-g1ypzheNbLtfu5RxyZztKFZg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|PH8PR19MB6641:EE_
x-ms-office365-filtering-correlation-id: 2f7956d3-f422-4560-a539-08de2d1fa1ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700021|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?NmI2QXJycG5aMGhFczRLQUo5MWJNL3BsQ21vZWlwTC9EUmYvZ0JHanVDODVB?=
 =?utf-8?B?dnp4Wk1QZlkzTElVblNNWmxkQjYweElLQW04Z3QwL1l1aVZkWVZuOGVCVFVx?=
 =?utf-8?B?bE1wVEI5cENyMGc5OWlwV3k2cUk0bHRybTkwMmx6ZU5pS3hwZGZFd3Q2S2NO?=
 =?utf-8?B?T25YOVlOMnNFSkEwRHpTam40a0RqSi9BdE5TY21UMWdEUTVFbFZOQjdlam5k?=
 =?utf-8?B?ZTcyeUM3NnNwU09yUVA0TG1wU2VZOTdtQ2VXSWt5RVV4K0Z5eEdYek1qbGNM?=
 =?utf-8?B?WHZXWXFFZFo5WDEzUjNBSUJMRldqUm45d3ViMCsxQ3JQckF6R1pCbytwOFcx?=
 =?utf-8?B?cVdJUFZjTDB3WTEwRUxjdHpIMGczTWlXK1FJVE9ycktLSWdTUHpZc291ZXdz?=
 =?utf-8?B?VUZTOTRYN0tUUHJEdk9BSy9qL09vL0lqamY2a0JNand5SjFiSGVqaVhzQlJx?=
 =?utf-8?B?VGR2eFNkU3Y5TU9KYVhDK1RmRGlscTVyUmZidks0RlBDUUVDV2JkUXh3VFI1?=
 =?utf-8?B?c3BRSkxCamxrWkc5d2x1bFg3bTBHUk5hMk5LN3lXM0ZvSGYwdjNDdzVVRWZq?=
 =?utf-8?B?aDgxcGlRdmcvNit1VWI1VHlLY3ZGaTc4Z3RVU3FRc01sZXdRQXBnNXU5dUJz?=
 =?utf-8?B?UU5kbFhhbUhHZlpDdXN2bVZiY2lEdEFYS3dKSnNOeFM5aTJIL0Rla21pcTJw?=
 =?utf-8?B?R2ozcCtLa3ZpdVY3dVl0Q2pZNjdNSmNzOHFoUGxXNWhoRFpEUWgybnlsNjZL?=
 =?utf-8?B?SGYvMElRajZVYlpHRUhJYVNwd045MHZ4emxYUnVhbGZHUkgzdks0TTE4a0l6?=
 =?utf-8?B?aUo1YkN1dkZrNUZUQlhQbUJLakRRMnBMYzZLRHNRVmhvUjNpWVFUUFpNY0dF?=
 =?utf-8?B?Y3JpYzFjQTJMbUp6M2t0QzkrQkRRUjZwOUNMNytuU21JZ1FZdnFKUmxRWG9J?=
 =?utf-8?B?OSt6VDkyb1RwUDhzMzhZQlhkajVicWxBaXBzYTlxbEFGZlFXUHAzZUorbVJR?=
 =?utf-8?B?UXppdGFvYnpYM3VUTTlubzdZNTVpVGx4MFUrTThTVWNrUWF0L1VOL1FGOHhR?=
 =?utf-8?B?Nk5NTTQ0NGwxWDNRQnZTMko4YlV4bitLOWJnMmxOVkN3UjR1WmNCMUJDRmJB?=
 =?utf-8?B?bndYQmQ3RzBlcGJaZ2pXN3AyRzY4QlRXWmQ1bEgzUHlxYTNwVmh1bUo1cDV4?=
 =?utf-8?B?M1cyZks3V0xETlZjNGp2NzVWM2o1RG5IcWNPVnVmbWtWbnc2UEU4NGVjZWE0?=
 =?utf-8?B?bEwwWFRia3VaQk1ZRUNOMlEwYnVETllHN0drRWNoc2NWMEhJWVZaKzdaaDRI?=
 =?utf-8?B?ZXRyc2M1T2x0SUVpcFQ3NWJiN1NiSjlNT05wY0g5NUx4YjV0bndGL0tVUkpI?=
 =?utf-8?B?K0NWdVdkTGNIbmhJMjY4eStxVVJKR05nNWEzMVdGQmNpajg5djAvc3JKZzBK?=
 =?utf-8?B?ZGdvUUgrWnFoc1gyT0EyU2FTZ1IyYmhmUVF1dHVuYWpJbjBmV0dJWFh4Yjd0?=
 =?utf-8?B?ZGNOMWJaY1R1Rk1QalI1TS82WkVwVE5KcGkzRlM3eHJHbDd3bEQvS3BwcXJ4?=
 =?utf-8?B?OCt3TkQ3bXVSaU42WGcrTkJUeVlkN3dFNmZpN3F1bGQxUTJpUm1JSzZ5cC9q?=
 =?utf-8?B?S1h6cjljMlVXMlM3WW5XcVJTUkdkMzVGSWJ3cWpWVGZNYVlXbGZwb3RuRkFh?=
 =?utf-8?B?TWJ2NHp4TDFBc2h3ZjNmMExmb1ZWQnFSMTRlQzMwd3Z0eFh2UHNyS1RHa2tG?=
 =?utf-8?B?TFRDZlg5c2RNalNST0UvMmdYc3RrWWJiTVAzdVYvMWNCUDdsdXhBUmdqZHEz?=
 =?utf-8?B?MmlVd3hxNkplYkpQZVNzaGpXb1p3M293QUl1V21uZ1RaNll6ZGhrTUp3d3kv?=
 =?utf-8?B?NGVuOW1lanN6T0w1SUY4d0c1S0Flb0F6RkpwQWxvRytVWW96MlZkSUxzK2NJ?=
 =?utf-8?B?K21DS2svZDNmQUwxUnhMb1YxU29IZ0FEZVlJUXFzMHBzWXBHWlMzQjZqbDY5?=
 =?utf-8?B?cTR5aHYwdEJnUVlhMGlGUnB2TFZIVEdJQzlmU3QyNXFHakpOQ01xaUJCL0lI?=
 =?utf-8?Q?BbWEcf?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021)(7053199007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cGhKTm9tVDJyZlBmNHQrd2xFQlBKSmZqUGhNdm5vbDNQTTFsbkZFbmtZb3E0?=
 =?utf-8?B?YVhqUHJhclFPU3Y1eVcwRzZrN0gzc21rYXpPc0dNRU1PUG15eHZ3Mk82c3pN?=
 =?utf-8?B?SFNyT0JXUUxLQ3hPT2xrSldLK1hHcW5SSUZVRm1wWWR6Z1oyMHp3c1RpbDdn?=
 =?utf-8?B?aCtvS0JTZDh6ZUV5QjRIamlqL0o3K08wVVpUenFVSkpjUWJ6TWpVSkd3d3Vm?=
 =?utf-8?B?cmM3QlpUdzhEdm5IemtmUjFLWXdiQlJmZUtiTFgyakdZZ3Zqc1pXQXRUaXhm?=
 =?utf-8?B?dkJhUi9zK3F5MWgyZHg4UnlpOEpBb3N3VEt2NFI5VEpvcHZybmV0TThaQ2cx?=
 =?utf-8?B?WTcvWWJ4VFFjN1h0azBjbTVjUEJEaGszQU9UV2FreFFUa0NRUW9TdEx1Ulg0?=
 =?utf-8?B?MFBWVG94RmFxdmJuNGJONUk3dDFJaHVpcnJQSUhmWDg2UDRJY21YNWxGb0Fi?=
 =?utf-8?B?cEIwU25HWE95NXVKRzNJdU1OWEdaM1MrRWpiaDduV2NWM3dkUDZSd2xQM0po?=
 =?utf-8?B?RUpRWHkvWFFUeXdESTdDQldXS1hRc2o3djhZR3Yzc3RBZXU0YTduUit2RTBP?=
 =?utf-8?B?NHJRMFRSYVRaY3hDYjFTZjhqeXNrczBSKzZocjUzSGxlN3ZMOFFsVm9yR2xj?=
 =?utf-8?B?bzZ3dGVXcnE0RFBDS0VEZzU4akdieVlNblVsb1NSZ0t2Tmg2ZFlMSGNRby83?=
 =?utf-8?B?UUptWVhzN0Voc0tmR1Z0K0NqK0p3a1I0SVlLbGlXOS9nd25TMGd5ZUtFU0pt?=
 =?utf-8?B?YW9VRFlOTE41TzZJeHk1NmgxQlpxSUJhcXRKb1k0YUVCVm9hbVJWckUxOXJI?=
 =?utf-8?B?VU84RVRpZVdCS2ZOS0FJMlNhSWZrWFYrNlQvSXZIUWFwM3kyNFdYckdWV2xX?=
 =?utf-8?B?UXVzSlViS1V5ZVFYRGhtdWNFRWl3QVRrNERuUlBZdm05SDg2TEI5bENWL290?=
 =?utf-8?B?RFVCaU13UC9pNnlMWkJxakMzOWZONWhmcUZFUThzTmpBUGp5Sis2a2sxMnA2?=
 =?utf-8?B?NXlxdTN6dnlFU2hFaWxybHQ2b1hUY3VDRkRXQVlzaGdQSlAxWFI0eWVPMU5D?=
 =?utf-8?B?TXliRkJwWWd2dmNBcTRsWTY0Z1FoU3NLSlpzbnBIRmpvdUtORjN3bSs1UFdz?=
 =?utf-8?B?bzBUaFZQUU03N2xtam54T1BDTUZ0T1lSY0EwK1FpODdLTW15YTdxZmhGVHZO?=
 =?utf-8?B?a3pMTjBkUVAzcVRLSENFSFBVcURPMVQ0eFZnWDZNVHlOd3VTbzhhQ0RnOFdP?=
 =?utf-8?B?cytvS0t4N0U3MzhZZUsvY2VGdzJ0L1NGN1VicnNPM2IzVTFyUCt0Mm9RRGhs?=
 =?utf-8?B?bW1oVE94bkNBajAxS2R1MVJURURjVkhRMkcrMTkwR1BkRkFSVkE4a3dCNTZk?=
 =?utf-8?B?Sml5TWFGamlsZW5wb25pK1ZoZ0RnNUJOSW5pYnFxUU9EOUdGUmhUN2dvRVBC?=
 =?utf-8?B?Y2U3UUtncUg1ckNWVXRNdk9oQzYzYnZwUDFlMUZEaE5JeFdQTVE0eWlnQXpI?=
 =?utf-8?B?NWNGUVVubXF3YlZZeWNXTis2ZHY4OWlvVGJVeTZTKzhXMXBxN2JvWjdnNUVR?=
 =?utf-8?B?UGRBT0VKamR4MU1yUFUySVpROGxLVktNcFpzT3JwKzR2ZW1PK0ZUNXVoSytK?=
 =?utf-8?B?MVpGSmp2RTNUMUxyOVZ1NTB6aHRwUEh3UTRKK1p3dHJBMmR0UFRra1FpblBl?=
 =?utf-8?B?RC84QzNNbXl0djZFZUg5YSsxSjRQUWszU0RneGs1UFQxT3lWZkJuNVpVRzl3?=
 =?utf-8?B?TjhsQ3k0STVnRzhLSWUwMUwzc0ZScjlEbWo4YnF0aThZK3lEOERzbW9xcEVR?=
 =?utf-8?B?VTNCdkVoODM3bERBNzFrQU5wVkd5Qk9ub0FwdkRiSm81V1A1ZmR3cm1WMmJN?=
 =?utf-8?B?L2l2cC9zcVdSKzdHbEg2RlF0alBZWXVkYkhaejhOdlZENmpKbmoxRXFOUENK?=
 =?utf-8?B?ZXpxM3NlTFM4MDR1anNoaDA2a0U4cUt1YUxzVVRiUWpXWEdoWnpRRlZhQVRY?=
 =?utf-8?B?U0h0NE1RbkQ2bXZHYXNyWmM2MG9rR0l2a2FzNVBGTzhEcnFXb29tUUpjYW9m?=
 =?utf-8?B?cEhYQmF2eXRwaS80Y3V3TWtmZ09IYXVjdVFJaGg2RjRqTmV6M1doMHE5NkNk?=
 =?utf-8?Q?hHIw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46EB610F3FA22B499429EB0534F2E37F@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 8yjRQck9Jt240qAsir3IGKauOedtX0LrsrtY17NCY9aHP5YkjirI1CuolzMun9Mqr8PBY5vSOykpk3PvXsxXsrfpjshcEJNik5SubZwhAuxiH9ncmxSArWZx8OXHbT+NfizlTk+Em6F5enynsSmzBfT1Sys4xKrAdtnwaYnCwsTLsymyOeiIwP91V6hkaSax1tc2zLnKwp0r2uAv5u4ZecCjQASaZXS7J1zmMtc2zqkFO21uWpw8ObGtAYaoNr3VnOI8u3UNkW7Wvw5Vv+8/ABJkiVfKktSD4z+H62Qu6DBc3gvb1hC3PXF7ENa9l6o6i4hAsDOnn+DYQw4zo1wGA5DKCpNsGGnmMaM/lhWFy1PJ0hfz2vpgl1pRWY8TbCJsdjNUu6NqvTyh2r9019oZWtECrS6WrmrO9RZo3R4xN0kwGVwukXlEP4tTo/RgqrHLQ+urSMU91HfcO413tlnP7t/tyx4X6PVWFyqnDnTwEj/6qxM9xEQUh/pDF0LcuIZOyllqDGK7MV4xX1HUulwSXVI7kx3XEuowahqN8n1OFE5WYBajR3sQxEafjT/V1UR2sbu5XGRrmWw8BJa6Z7hhaGb/5F+k9iL9zAS3kATDyMEYiB6LoYCFwaFp3OwnIFzND9d98SLrcwoeiWRzx3z32Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f7956d3-f422-4560-a539-08de2d1fa1ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 19:11:41.6587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+FjhCvaAj0hMsS9Vtv1aUawFMJYV+TswT7OxUc9HwdM0C+UnraUen0CASIylm0QUItrIzlu8MQaZyV+7zy/IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR19MB6641
X-OriginatorOrg: ddn.com
X-BESS-ID: 1764186237-103438-9001-22228-1
X-BESS-VER: 2019.1_20251124.2001
X-BESS-Apparent-Source-IP: 52.101.61.98
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYWxpZAVgZQ0DzFwjDJINE4OT
	XFPM3MyNjE0CLJOM3S0tw41cjcLNVUqTYWAHvesz9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.269235 [from 
	cloudscan22-212.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

SGkgQWJoaXNoZWssDQoNCk9uIDExLzI2LzI1IDE2OjA3LCBBYmhpc2hlayBHdXB0YSB3cm90ZToN
Cj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBhYmhpc2hla21ndXB0YUBnb29nbGUu
Y29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5B
Ym91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IEhlbGxvIFRlYW0sDQo+IA0KPiBJIGFt
IG9ic2VydmluZyBhIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24gaW4gdGhlIEZVU0Ugc3Vic3lzdGVt
IG9uDQo+IEtlcm5lbCA2LjE0IGNvbXBhcmVkIHRvIDYuOC82LjExIHdoZW4gdXNpbmcgdGhlIGxl
Z2FjeS9zdGFuZGFyZCBGVVNFDQo+IGludGVyZmFjZSAodXNlcnNwYWNlIGRhZW1vbiB1c2luZyBz
dGFuZGFyZCByZWFkIG9uIC9kZXYvZnVzZSkuDQo+IA0KPiBTdW1tYXJ5IG9mIElzc3VlOiBPbiBL
ZXJuZWwgNi44ICYgNi4xMSwgaW5jcmVhc2luZyBpb2RlcHRoIGluIGZpbw0KPiAodXNpbmcgaW9l
bmdpbmU9aW9fdXJpbmcpIHJlc3VsdHMgaW4gbmVhci1saW5lYXIgcGVyZm9ybWFuY2Ugc2NhbGlu
Zy4NCj4gT24gS2VybmVsIDYuMTQsIHVzaW5nIHRoZSBleGFjdCBzYW1lIHVzZXJzcGFjZSBiaW5h
cnksIGluY3JlYXNpbmcNCj4gaW9kZXB0aCB5aWVsZHMgbm8gcGVyZm9ybWFuY2UgaW1wcm92ZW1l
bnQgKGJlaGF2aW9yIHJlc2VtYmxlcw0KPiBpb2RlcHRoPTEpLg0KPiANCj4gRW52aXJvbm1lbnQ6
DQo+IC0gV29ya2xvYWQ6IEdDU0Z1c2UgKHVzZXJzcGFjZSBkYWVtb24pICsgRmlvDQo+IC0gRmlv
IENvbmZpZzogUmFuZG9tIFJlYWQsIGlvZW5naW5lPWlvX3VyaW5nLCBkaXJlY3Q9MSwgaW9kZXB0
aD00Lg0KPiAtIENQVTogSW50ZWwuDQo+IC0gRGFlbW9uOiBHby1iYXNlZC4gSXQgdXNlcyBhIHNl
cmlhbGl6ZWQgcmVhZGVyIGxvb3Agb24gL2Rldi9mdXNlIHRoYXQNCj4gaW1tZWRpYXRlbHkgc3Bh
d25zIGEgR28gcm91dGluZSBwZXIgcmVxdWVzdC4gU28sIGl0IGNhbiBzZXJ2ZSByZXF1ZXN0cw0K
PiBpbiBwYXJhbGxlbC4NCj4gLSBLZXJuZWwgQ29uZmlnOiBDT05GSUdfRlVTRV9JT19VUklORz15
IGlzIGVuYWJsZWQsIGJ1dCB0aGUgZGFlbW9uIGlzDQo+IG5vdCByZWdpc3RlcmluZyBmb3IgdGhl
IHJpbmcgKGxlZ2FjeSBtb2RlKS4NCj4gDQo+IEJlbmNobWFyayBPYnNlcnZhdGlvbnM6DQo+IC0g
S2VybmVsIDYuOC82LjExOiBXaXRoIGlvZGVwdGg9NCwgd2Ugb2JzZXJ2ZSB+My41LTR4IHRocm91
Z2hwdXQNCj4gY29tcGFyZWQgdG8gaW9kZXB0aD0xLg0KPiAtIEtlcm5lbCA2LjE0OiBXaXRoIGlv
ZGVwdGg9NCwgdGhyb3VnaHB1dCBpcyBpZGVudGljYWwgdG8gaW9kZXB0aD0xLg0KPiBQYXJhbGxl
bGlzbSBpcyBlZmZlY3RpdmVseSBsb3N0Lg0KPiANCj4gSXMgdGhpcyBhIGtub3duIGlzc3VlPyBJ
IHdvdWxkIGFwcHJlY2lhdGUgYW55IGluc2lnaHRzIG9yIHBvaW50ZXJzIG9uDQo+IHRoaXMgaXNz
dWUuDQoNCkNvdWxkIHlvdSBnaXZlIHlvdXIgZXhhY3QgZmlvIGxpbmU/IEknbSBub3QgYXdhcmUg
b2Ygc3VjaCBhIHJlZ3Jlc3Npb24uDQoNCmJzY2h1YmVydDJAaW1lc3J2MyB+PmZpbyAtLWRpcmVj
dG9yeT0vdG1wL2Rlc3QgLS1uYW1lPWlvcHMuXCRqb2JudW0gLS1ydz1yYW5kcmVhZCAtLWJzPTRr
IC0tc2l6ZT0xRyAtLW51bWpvYnM9MSAtLWlvZGVwdGg9MSAtLXRpbWVfYmFzZWQgLS1ydW50aW1l
PTMwcyAtLWdyb3VwX3JlcG9ydGluZyAtLWlvZW5naW5lPWlvX3VyaW5nICAtLWRpcmVjdD0xDQpp
b3BzLiRqb2JudW06IChnPTApOiBydz1yYW5kcmVhZCwgYnM9KFIpIDQwOTZCLTQwOTZCLCAoVykg
NDA5NkItNDA5NkIsIChUKSA0MDk2Qi00MDk2QiwgaW9lbmdpbmU9aW9fdXJpbmcsIGlvZGVwdGg9
MQ0KZmlvLTMuMzYNClN0YXJ0aW5nIDEgcHJvY2Vzcw0KaW9wcy4kam9ibnVtOiBMYXlpbmcgb3V0
IElPIGZpbGUgKDEgZmlsZSAvIDEwMjRNaUIpDQouLi4NClJ1biBzdGF0dXMgZ3JvdXAgMCAoYWxs
IGpvYnMpOg0KICAgIFJFQUQ6IGJ3PTE3OE1pQi9zICgxODZNQi9zKSwgMTc4TWlCL3MtMTc4TWlC
L3MgKDE4Nk1CL3MtMTg2TUIvcyksIGlvPTUzMzFNaUIgKDU1OTBNQiksIHJ1bj0zMDAwMS0zMDAw
MW1zZWMNCg0KYnNjaHViZXJ0MkBpbWVzcnYzIH4+ZmlvIC0tZGlyZWN0b3J5PS90bXAvZGVzdCAt
LW5hbWU9aW9wcy5cJGpvYm51bSAtLXJ3PXJhbmRyZWFkIC0tYnM9NGsgLS1zaXplPTFHIC0tbnVt
am9icz0xIC0taW9kZXB0aD00IC0tdGltZV9iYXNlZCAtLXJ1bnRpbWU9MzBzIC0tZ3JvdXBfcmVw
b3J0aW5nIC0taW9lbmdpbmU9aW9fdXJpbmcgIC0tZGlyZWN0PTENCmlvcHMuJGpvYm51bTogKGc9
MCk6IHJ3PXJhbmRyZWFkLCBicz0oUikgNDA5NkItNDA5NkIsIChXKSA0MDk2Qi00MDk2QiwgKFQp
IDQwOTZCLTQwOTZCLCBpb2VuZ2luZT1pb191cmluZywgaW9kZXB0aD00DQpmaW8tMy4zNg0KU3Rh
cnRpbmcgMSBwcm9jZXNzDQpKb2JzOiAxIChmPTEpOiBbcigxKV1bMTAwLjAlXVtyPTY3M01pQi9z
XVtyPTE3MmsgSU9QU11bZXRhIDAwbTowMHNdDQppb3BzLiRqb2JudW06IChncm91cGlkPTAsIGpv
YnM9MSk6IGVycj0gMDogcGlkPTUyMDEyOiBXZWQgTm92IDI2IDIwOjA4OjE3IDIwMjUNCi4uLg0K
UnVuIHN0YXR1cyBncm91cCAwIChhbGwgam9icyk6DQogICBSRUFEOiBidz02NzNNaUIvcyAoNzA2
TUIvcyksIDY3M01pQi9zLTY3M01pQi9zICg3MDZNQi9zLTcwNk1CL3MpLCBpbz0xOS43R2lCICgy
MS4yR0IpLCBydW49MzAwMDEtMzAwMDFtc2VjDQoNCg0KVGhpcyBpcyB3aXRoIGxpYmZ1c2UgYGV4
YW1wbGUvcGFzc3Rocm91Z2hfaHAgLW8gYWxsb3dfb3RoZXIgLS1ub3Bhc3N0aHJvdWdoIC0tZm9y
ZWdyb3VuZCAvdG1wL3NvdXJjZSAvdG1wL2Rlc3RgDQoNCg0KVGhhbmtzLA0KQmVybmQNCg==

