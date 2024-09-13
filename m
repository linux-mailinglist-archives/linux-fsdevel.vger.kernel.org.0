Return-Path: <linux-fsdevel+bounces-29346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31709785EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 18:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30CCFB228F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 16:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD1178C76;
	Fri, 13 Sep 2024 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="N4vcAlfG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7066BB5B;
	Fri, 13 Sep 2024 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726245505; cv=fail; b=XkT8+5jXDRiZhlEzIbCoELWbdCX9rVz5E/3BnjjNB9YEDgyeNXStJeHVrBgDxbRA2uzLPw6byJYH8xHjYoyHrnPmSOSuaQUE0m9dlVXmfFW8JkkylVqZp68PzXqY6QjoByuxGtg5grDWFZpJRKcoH1nAxIXt3m2550ZdrgeG2to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726245505; c=relaxed/simple;
	bh=oKT7GpW/qAvMSAC8i+DB+Qeqw+sGy2Qcg0zxxP6AJk8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CfJvoY6UVepmK15iONw/atK1YnUgygQCoigXGyZ8GcdWt4XjfVKs3yMHaGyTBvEvFAiRgMqZUSvf5SdUEzbSN3590l0QwqYttEjdRhTICNZqHVP5uTwI98/YWrHeT8iYuo38s1UpU0TnjgMbVnrSc4aH9nJi+oGwe0Oi/rHb8dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=N4vcAlfG; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48DG4vew024253;
	Fri, 13 Sep 2024 09:38:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	s2048-2021-q4; bh=6g4TNDvmemXLZWvUNjI9qQhr/3gV8bTsX2R9B3qhZsY=; b=
	N4vcAlfGuFOeq9w52p/OuE4Uct1Ofgla/xOUsKQAq6TygbDnheazLZtfWUy72rSJ
	7YvQqdkE8aZFf+HhXXYxC0KgzpNPxyZ0HIXVW6ZI+Sz5rqBicjBW4k0hYLs20B4/
	YxcEjGZZ/31uInepDyZOtztvKyUoABt5PDGc1zodFC+yokN+XR6sHHNUy4C+JxVa
	g3U+giuqShXKVmHjF+p19ND3gIsVjHnOWhEFlYgGzJEk8rSHNCit5gOXl0ECJR+B
	dsijI8JfU8++gLO8fxOJ4jqOUj/hZtKSgrqjTYpaIKXToJRmlQ7l3u5t8uwb8hby
	oPBxe82fe99sH87OiSd/sg==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41mgk3jq9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 09:38:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYrJ+Tc/jrndZP9KOHFrnQfpGQU9gHlDO5UdCfbr7dXGv+n3VjJ198ujO4A+SHK+YAaM/xlx9phNWWAhLEo0kIQCGybYHPQK8tSRM9C5iq6z+Rplt5h568d5f8r9AynNGhP8CtoY3X6TFglPxH/Yy1RCHfzO73vmAMGek4qbIIMqfXzcVa42zh9j3KMPPVPMLEmHfsjc/FE5E5/rY9BCqztFVGQ1iHwl40Dtl9LniNlXug34pkgFFGlwVvanj1IAebC4jPD8QXApMNp6Ll6D3/PsJQiSLI+w3gPRTWUyRbHgvet+rFoyd/+o6tHvLilqBljxz8r+vsAzormtP3iLEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6g4TNDvmemXLZWvUNjI9qQhr/3gV8bTsX2R9B3qhZsY=;
 b=CR8zBcHuZDMCqUeXqwOz6cduJRxuI+w7obu4cJZygEIn8XaOdBb0IWC3ov/RL6/7xxue8wc3ijECslRyV1KhK1OZt5QlOIEIB+8iNp+5k1bU4FqWuWSbs5183gzWi4RkRS0VzUgZuI5D1nza3AvaWvA/ULOePlSSImVwQ5jaKvme8P/wy2DlpocR0jVfSnaGCK6sr/KyBygKTIMN6dg+DKGBkNw4w21BexONW7aR/PvOxYX6MgY0+z1VChiAS4RvLrWmpFP0nDiDtjvTLhIsH4JVhFCIrk8QFqWC7n+yNQLSrTztEFTZvMsfGniSKCLoqXkOW+zjdDYBZiyVsNxQow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by BY3PR15MB4819.namprd15.prod.outlook.com (2603:10b6:a03:3b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 16:37:59 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::740a:ec4a:6e81:cf28]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::740a:ec4a:6e81:cf28%7]) with mapi id 15.20.7939.017; Fri, 13 Sep 2024
 16:37:59 +0000
Message-ID: <9e8f8872-f51b-4a09-a92c-49218748dd62@meta.com>
Date: Fri, 13 Sep 2024 12:37:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Dao <dqminh@cloudflare.com>, Dave Chinner <david@fromorbit.com>,
        regressions@lists.linux.dev, regressions@leemhuis.info
References: <d4a1cca4-96b8-4692-81f0-81c512f55ccf@meta.com>
 <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <1368975.1726243446@warthog.procyon.org.uk>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <1368975.1726243446@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR06CA0010.namprd06.prod.outlook.com
 (2603:10b6:208:23d::15) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|BY3PR15MB4819:EE_
X-MS-Office365-Filtering-Correlation-Id: fc4bbd90-639e-4615-baf9-08dcd4126dc1
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2F6cWtiUjBWS2hVMDhjZnhOZWRPTy9qNlFabVY0Z1FNYkVrM2VNMTVVOHdX?=
 =?utf-8?B?dTlXNll1VitISElsWmV0dGFXcjFsdmIxcmJSMUV0TEpxQkFNSG4ydThrRk1N?=
 =?utf-8?B?d1Erd2YvcVoxbXFSbFhZSTExWlZwbFZ5ZEtady9hVURoNlZ4dXdxMk14cjJm?=
 =?utf-8?B?QWdmcGgyaGJMRWo1dVVmaGQyU2xoRStwcWZIM0tzcmlQL2ZRQW1FaWo2T1VK?=
 =?utf-8?B?cjZYU04vSnd5T3pydmlTaFhHelM2N0NvS1h5T2JvUHJpR3Z1UzVjclRqUXV6?=
 =?utf-8?B?aFVSaU9oM2R3aVpheFd3aVVPdUdlTjNEL1BDdzd0VEZxZTV0ZWIrOEVPSVdp?=
 =?utf-8?B?N050OW10VEd3RDEremlwQkd1djd6b00zbkJnT0ZwMjRHOEVUVzVaTXc1alZt?=
 =?utf-8?B?RUlhZDliSFlhNFM2RUY4RjJ6aFNObFVTV0lrajFSRnBCZE1va240TmplekxX?=
 =?utf-8?B?eWMwblFZcmRMTmtkQ1pVQWFlaTBLalh0REY3MWVnblhlN2ZsdXplSUo4Y1l3?=
 =?utf-8?B?ZUNrQnRRK2NkTnFzTjdIa0cwQ3hzRnJIMkYzN3JVUUJhaXlhc3hKQzRlNzMz?=
 =?utf-8?B?NXJianR3OGh1alFrSm80dmUrTHZvbDB2d2F1TnNMVUZVdDBEZmt3dmU0dGRX?=
 =?utf-8?B?d2NSZ2x0UmxXSGo1SURpOS9ScnNYTTJSa0lVZGZUVGczWEpTeXNRNDJ3b1hO?=
 =?utf-8?B?UE5ENzVueEJrLzZCaDdZbzdtMTJnSERKYzRNVm9vMEJOcDRUaWhkKzJmVWdU?=
 =?utf-8?B?MWkyR1dQaU42djUzWm1NVW1kSDZ5QzhSNEJRMkJZRjVFT2FFM0ttRWJETTJU?=
 =?utf-8?B?cjIxdnA5aG9nV3E0S2IxdkhTbzJTQXZZMUtQSG5BS1h4SkJQWDVHYU5BN0R1?=
 =?utf-8?B?dTlCeWFFWGNWZGlQMTRyakZ3VWM5L3pBaDdDRUFTNHl0ZDlSbU5tVUIvSThO?=
 =?utf-8?B?R3dZOUpYNkN2MzVMWkVLOS94MEVYcXNhSXZXU09WOUFQWEhKQlczV0tDbjVa?=
 =?utf-8?B?Z1hEd3g3V2VLZkxKREI1U1JtdnVKTWk4QXIwM3dBOTBqREY4bTR1a0I0VGZV?=
 =?utf-8?B?ODZDVklveDlkTC9mUVBla2pMUmdpWTl4ZnBOeSttUkF1cTh1WWhxRXUrNUk1?=
 =?utf-8?B?c242ak9lQytDekNNQndrai9XeDdSUDdhMnJIZUtuWU4rNFZvb2xoRkozSXBI?=
 =?utf-8?B?Vm5ZbGJjM1hrVEdOODhLWlphQ0oyNGo3ZWlQMzd0SzF4c2FJLzJwQ016OGwv?=
 =?utf-8?B?ZHBUeXpMdGZ5cUZOclBRZXFUaTJIZDV4SVZmcmplbzhkVXB4YWdSS2gxaHVz?=
 =?utf-8?B?blRHeUV0bGlyV3ltcXc0V0ZMcnFVM1U0VXV2ei9YdDhDay96YUNhWnRraWJv?=
 =?utf-8?B?SDVENXc1bk54NDZtMFBPRExGQUowMlpINHc1elYyNUxpSGgyMWpxaHBMZ0tU?=
 =?utf-8?B?N3BVeHVrRzRxUk5MdzEwQnBGVDlEUGM5VFdWOGx0bWJ6anVvN2FPNnRoalk4?=
 =?utf-8?B?K1NxeiswR09EbkFnYUlaNjlMN2FwcUVBVXpxcS92aVpuWVFjc1ZobkhhdzRv?=
 =?utf-8?B?NVp1UlBWbW9oVHhBdFluMnVCeGtLM1k0azI5elNLTUVibjR6RlJyTlhleWQy?=
 =?utf-8?B?R1R0c3dEZWM0dlhKS2REODJGc1FSejVvT1NibjN5VHREK3N3MDBzRVFFY2RU?=
 =?utf-8?B?YTFaTTN2b0VmMFBJV1VzYmU2Rm1yU1hSYTZKWXFHR05lR2VJeFBXQXRIMlBv?=
 =?utf-8?B?N3dQOFZJRXdhYm9BZ0s2djdTVjZCOE1zQkdEZ3Y2ZEx5M3BlcjRXQ1NZd3J2?=
 =?utf-8?B?cUtLSk5kZ1lEKzQrTm1FUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW80ZFYyb0I3NDVHU3VmUUdWVnE0YTNSWGs1blptaGxWNWZLSFg3dGNKNmJU?=
 =?utf-8?B?TGF1am91RFZuMzhaaTlZKzZ0M3dYR3psZkozMGovT1Q1M3pzSzR6amlJajkw?=
 =?utf-8?B?ZFY3dEVtNmN0ZlhyMU1aT1RPbWYxa3FzaXM1ZFE0alNXeWE5aDgzcHlIVzhQ?=
 =?utf-8?B?NExVUkt5b3UrSXhldENzM2dCU2kzTTAvTEwzN3Z1YlNJeVNXdFJ0dkUzeitV?=
 =?utf-8?B?VDdtWCt1Zk0rSy9RN3VHbE5xMUg3M1lzODFtVThGYlJSM2tqdDZ4RjREalhT?=
 =?utf-8?B?M2RhbVZxaW55ZUphQ2V4VmFqNnl2NUR2NXZLVWpSSTR4ZnZwRXhzVTJ1SWhw?=
 =?utf-8?B?Z3JCQ2hGWE9mU25mNVpoVGVXcGQxVys0b0R1SDlsRjJHcmxwMmRnTmpLWHpQ?=
 =?utf-8?B?YVdRMnNhZk0yaEVET241TFQzSHhUTEdzeDZsa1BndEZGd3hvR0tDUk4yQXRM?=
 =?utf-8?B?RS9DeGhwZFRtdGhhRFcxeElRYzJRSld1NGxtS2hRU1RITFFiMFRYampCdGpJ?=
 =?utf-8?B?cWZkMldSd2xwTmE0ZmhYU21rT3FXYndXeG01eVRFMkFPZ01GMUM2ZmtiV3lK?=
 =?utf-8?B?TGFEeGxHblpnNkNwWXZ5Z3BJSHFnN3pubWVkUGU1NXZxNFJlY2krKzVpQ2Nx?=
 =?utf-8?B?ZjZiV2FURythM0hjNlNhcm12OCt3QXNucUZzTThWelNURHh2bHBRNHZMdFR6?=
 =?utf-8?B?SUVKWTl1QXM2Q1JmaFVwQ3dXbHBrVlZXSGs3RkI5aWhrUmg2R0lJekRpZTNu?=
 =?utf-8?B?Z3ZEU3RJOGRGYXpwSEYwMkRwL2tBUnZCbmFBSTdnaTgrd1EvQmlyc3JSNEhr?=
 =?utf-8?B?dENBN1RTRHdQK0RwSTB1V21DMjNDQVJJckk2RWF3ZGhWNFA3VlduTEhMT1pU?=
 =?utf-8?B?WVUrMjFXdGlLOXgybTYyYUl6elZnZDhsOXVxSXBDM2Z1RHlHbFNZYXduSGxy?=
 =?utf-8?B?VFZ2QU1LR0lNMnJNdFIra2QyQmsyb1YzbW94R2plU0ZvMEFDRVEvS2dNY1Jz?=
 =?utf-8?B?V21ja3MwWFZrdDBONU9RYjZGTlRoZE5rL3d4RXM0ek9xVHdhMk1waGZyS01R?=
 =?utf-8?B?VDU0RDVxYTNONjF1bFpjdHFlK1ZNelRxbEhQbGJTZnJGRTZoSHA4QmpKZGhx?=
 =?utf-8?B?VW9qNFRuMFowWS9tWStHbnBVdFBpY2c1MWJMd2plN3BoVVp2QU5YNlEyNVAr?=
 =?utf-8?B?UFl5RkI4aWVDZk9sb2IrREcrcUVweHNxcStwR2JKT3JvSzJzQWtQeFNyL2Rw?=
 =?utf-8?B?ZVJGby8rOGZabFgzWG5qeVZrWERsY0VEaXdDT05MWllvWnV1YXB4NEhocWRu?=
 =?utf-8?B?RlFuekNuanNNQzFUOHZldEdTQ1lEUm81VGQ2em0yT01DL1NBaFhjMmhaeVk0?=
 =?utf-8?B?REZ2YytiU2hoTUVmT2VxT0xVWktackpTQVpNNmE5WFhRZDBiUS9YdHZMUG4w?=
 =?utf-8?B?cEFIajFKV0xwTm1DSWRtRGtLRnJtTzRPSVVDZnVNUVZMcElZWHZ6UGpIeUNT?=
 =?utf-8?B?QnlDMjYrS25FWklGRDFxRno0TnNiM2FoT1lpVWpUWU5vRXFkRzJ6VE5Ncitq?=
 =?utf-8?B?Rnl4NmhUSWtQbGl5SUdDV2ErNUNTdHliK0VTR21MeVFndkRZZW5uUjN4cjN5?=
 =?utf-8?B?UWIwa1NCaExDZDg2cUlHTHlBVnUzRkN2TlVsMDhaaVFGVm1nYXZXWkJpLzEz?=
 =?utf-8?B?b1VIcDh0Vnc0TnFYbVVaU3FZc0Q3ajlxWVBwalFpZVNlb2NHR3UyNE9xYWpV?=
 =?utf-8?B?Y0tXeGhqT0pGT092WlZjZVRPcGdBa0o0d2h5SHBvSkRidHRIYzZvY1V6ZXVM?=
 =?utf-8?B?MkxvRkdjRElsenNjT3pqaVVvdGNwKzhHNXAvclVCbmJtcnlmQWpVY2ZIYi9U?=
 =?utf-8?B?VHIxYmVML2UwWVRFWjF0N21TLzhaaVpOalIzRlMvbkkydkJ1UmhCbzZDVVBM?=
 =?utf-8?B?MjFwK2E0L0ZWMkNUY3pMVVdqb2lzTWl2c2hKK0E1U3lQUzk2NWgyM29vMFpy?=
 =?utf-8?B?MDNDUldzeFFWY2pZYUpKUzdHYUl3YWlBVnNya1cvN2tUcUtlMzZOTVhPMnps?=
 =?utf-8?B?b2lQQ25jNklCU2pNQkN2NUlNR3hEVkdERVJRZEJVdERxYWtzOVl5ZFVoQ1lH?=
 =?utf-8?Q?qw08=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc4bbd90-639e-4615-baf9-08dcd4126dc1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 16:37:59.6721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gbwizDTKn3Og0rjhZA36Flzeh+uEN1nnpBq8ViJYNQ02A9ahTDPjnplxF41Wqnk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4819
X-Proofpoint-ORIG-GUID: hbb5Rda7b8UggOLD7NNt4e9CCuWBRZ7L
X-Proofpoint-GUID: hbb5Rda7b8UggOLD7NNt4e9CCuWBRZ7L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-13_11,2024-09-13_02,2024-09-02_01

On 9/13/24 12:04 PM, David Howells wrote:
> Chris Mason <clm@meta.com> wrote:
> 
>> I've mentioned this in the past to both Willy and Dave Chinner, but so
>> far all of my attempts to reproduce it on purpose have failed.
> 
> Could it be a splice bug?

I really wanted it to be a splice bug, but I believe the 6.9 workload I
mentioned isn't using splice.  I didn't 100% verify though.

-chris

