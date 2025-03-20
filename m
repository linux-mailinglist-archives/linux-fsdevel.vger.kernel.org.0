Return-Path: <linux-fsdevel+bounces-44652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 466A9A6B01C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 22:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CE6884423
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 21:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85F622A7EC;
	Thu, 20 Mar 2025 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P48u6W6d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D831227EA1;
	Thu, 20 Mar 2025 21:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742507156; cv=fail; b=LLtGMlQAjnZ6EyoQqqgEkyZ8LO6xJrDIP/+CfvGONxnuRORkB87/lrFq58v7jG4RzcJ44HPmcmAF5pCZy84NQT4Mq1LQUr0fzS1175esi+RcKCchMyICUqyhmPXsamJVY08F71D+VZfqEw/LHKjbdMrfjsZn7/ROr27tnS5ZBek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742507156; c=relaxed/simple;
	bh=v1Es4ZD7she4mODzJ2hyiNs8WFadoFyyXgawmFU+nPk=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=dxuTm528jWe3Kx4afvAOCq075Kr/hmV10yLdCeu7+fH8aoHGftvOiyLlQjovy7Q3mQeZGqpJOcvAa2YpWet0mhK46z8krP0t/8Cv+1Yig5OXcjhJOsUEklEfoMAZnVFl2rYNPPxnVWGiggTapunfI/1MfTBCRObLYslYojOoFM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P48u6W6d; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52KKcb7G014122;
	Thu, 20 Mar 2025 21:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=v1Es4ZD7she4mODzJ2hyiNs8WFadoFyyXgawmFU+nPk=; b=P48u6W6d
	jyeFCaW4c6ElmtEluDg+N9bSgXNbDqpdjV7jRbvhvK3XmuozaZkQOopdTTzxEON+
	EiZO855vKbtp/aaKoaL/RMG92l67mLEMzb8NB1ttG9X98tXT/ESNh9kZDUkyvwxJ
	wvOYHFLD7OwXlxtBfhltD02anYnUlYaE7Ks9Hw5oBJYfUPFr6w7xBCZQi/qIMiz0
	7hNuuU8oiq5sB6nmWHYy4bV4UB5A7hussYVpnlrmTmrA09a+nsnSdbo+w9tztdkf
	CoiHbFNPZxL3IaIuG78blGYN7YI7Hinyeh+MoeqqwqIXqD1pYuCvIO1MzrFyxXH4
	/UWc4gX/vlc+kg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gt80r7y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 21:45:40 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52KLin9K017898;
	Thu, 20 Mar 2025 21:45:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45gt80r7y4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 21:45:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bwzff3+ciltAq8iwE1PSCk/raQ8/s54fj1kqfahZn4UhoZ6Sl7NiR31njgWrLLKdcu5MlTYX3gUb/tj89OzX+wnKCXO81tmNOLbMJQJzfMfgG1S25zr9Zbf31wn3fSoy66LGUDdsND9aglBauUm073fdjT/p4UCgNMfTr7IyBw2oesVoaCLY9XrpkZNBS+7WGeCZ0zaurXMDU24p1KSpwVuMT4pvHdt/Ba/eOVO+FkhR0+NHRD8iwGtO3Ueu1eG0Pc4DDcomeQDxIKMXDySiilozev35hWDDJqmOzZNn5rmHCvJUM7SipHBWDqrD4rtqq+OrSeWqxhtuFfvIOEcgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1Es4ZD7she4mODzJ2hyiNs8WFadoFyyXgawmFU+nPk=;
 b=WfvFFNECvWCmCQ5hQF9pMkq8lGr81GsrpoM2yMx5QAQ0WPcbD6eyXp8+CALyOE5oW4XtNbznwYXhpenX5iwS0VY/6vpT30sjzaMZsSXjGEyRTSyXOjvKuObdO0EN8+TQEqem4UhkQ8gq0n7Od2+OQbZtVek3siQ6j9cGfNSTXDISqxusDsRVFkmZn3HOiDyYkc3jlOK3FVtA+544kHV2Ls/hVA7BEaHV1/0sLAVyeFlrJq5c0McJRtgzE23gaP8+0jj1hysTCuRi5KpqnEHxUSYi7iCqHdoMCYslpm7d9MzFdbXYtcOpOYz2BE7wukTBsjUYlxJfMRhgjxKMEKbZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ0PR15MB4358.namprd15.prod.outlook.com (2603:10b6:a03:335::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 21:45:37 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8534.036; Thu, 20 Mar 2025
 21:45:37 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: David Howells <dhowells@redhat.com>
CC: "dongsheng.yang@easystack.cn" <dongsheng.yang@easystack.cn>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Alex Markuze <amarkuze@redhat.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com"
	<idryomov@gmail.com>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [RFC PATCH 17/35] libceph, rbd: Use ceph_databuf
 encoding start/stop
Thread-Index: AQHbmFPsUfyWUOJucUecOo1k64+4fLN8ki2A
Date: Thu, 20 Mar 2025 21:45:37 +0000
Message-ID: <8c5c734ee133a1a7cb5a3fcaa11db0e8614cae20.camel@ibm.com>
References: <794de36bce4867d8cd39dd0ed2bfc70b96ec07ce.camel@ibm.com>
		 <20250313233341.1675324-1-dhowells@redhat.com>
		 <20250313233341.1675324-18-dhowells@redhat.com>
	 <2680646.1742336396@warthog.procyon.org.uk>
In-Reply-To: <2680646.1742336396@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ0PR15MB4358:EE_
x-ms-office365-filtering-correlation-id: ce5d430e-8ff3-42e6-4ab2-08dd67f88d6c
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cWRESlBTMzMwaE95bXNqQ0dyQnQzLy9vWkxnTE5CWXVBZ0RPT3Jzbjk5R1FT?=
 =?utf-8?B?b01DMkdiZWdlQnZ1VFQySWEvSkpCNFhUMmhJRlVLWUdKUVRWeGlVOEY5WXVm?=
 =?utf-8?B?bWNMY25KYWs0dzNjL0hVYVhIZm5EVDNRMUU3bTkxZ0E3RmRyN2NSR0dIRlBP?=
 =?utf-8?B?VlZvUC8xWlNDL3hwUzZEdjJ4Y1AwUmdjRTY2M0xnV3RtdCtkOVEzekF5UVFn?=
 =?utf-8?B?MVhScGlQU1BmY0NobCtYZHJIVVVEKzlxUlQrZUxCY2FTMkZodnNoaFM0WFFB?=
 =?utf-8?B?OXJlWlFxVHViR1Fodk9QYjQrdTloRTFScWd1Y2RlK0h3NnlSQjFOdWxtT1gy?=
 =?utf-8?B?UDZkY2RtbHcxWmEyd25uUlJnZ1Q3WEUwaFZIOGNFSlJrSXhmay9RRDZ6WUdy?=
 =?utf-8?B?OHhYSHArZTBCQy9pUXNBYmNmSUxUL2xrZkp2dDhzcHc0NGJpM2MyTlZlaTlM?=
 =?utf-8?B?a1c5UDNMTko0QWxhZ2NQQVg2MjNEeUVpUTZjb2NLeWJsU05oZVRnZ1ZxWDc5?=
 =?utf-8?B?dEZKdGpZLzdqNGRDUjhpNnVORmhpdDdpd0xSVUZoUzNoS2lQR0NQanhOaVNK?=
 =?utf-8?B?Z2w3MFRTOXkwVkw0Y3Z6U3VVU2xRS0Y2ckpLK0dSdzAxQzNBZmFQVjBPQUFk?=
 =?utf-8?B?TmhUdFllVk5ody92dVQzcHVqRk9iQVAzc0RBcWhFU2Z3cTJ3Smc1MWNHTlBr?=
 =?utf-8?B?N21hdVFIUW8xc3JFdDgwcktSclJYSzQ3d3FNRVlwcUZDVjdEOUsyT0RJU3lT?=
 =?utf-8?B?cGhvYjVEdUh6Tk1sbjg5NllBUFhuOGx1QUY2Z1ljNlV5WjFFc2cwcmVGOWlq?=
 =?utf-8?B?Q0xwSFVxeXNyam4wYnpZNitIWlRSOXJJTXluc1V1SGV6VXpJSUwxVFR0ZWF2?=
 =?utf-8?B?RXEvTE52MVhNOVpBRmpGWENXMGRxL1hNdEozWW9rU3Z1NVFOU2dEMlg1S0Fy?=
 =?utf-8?B?SFBtSW5BUHJyRFNWQ3FoSWgrTlArRlhHOC85WGNpZ3l3dlk0ZHdhUU5CV1Zy?=
 =?utf-8?B?SExPdjRFN08vQ0pwOTQvbnlxMjY0azUxOHpsQURQc0s1bzNUYk0ycnR1S1VI?=
 =?utf-8?B?SWZ1TUNjYVFrN0NQcDA5Yk41ek1XeU5XV1lsSkRBa1U5V1pUcHVKcHpreGww?=
 =?utf-8?B?M1c5N05qZnFNSVoyd2dRM25oRXIrOVVmYUJpZlFZc2Q2end6MWdBZ2MzaFpJ?=
 =?utf-8?B?SVZBcms1d09yUk5UTk1nc2w1QlorUkpOd3BSa2R3bUxXcmkyS3libFo0anRu?=
 =?utf-8?B?NFpFTTF6Nlo0SDMrOXRFaEJLT3BzdWJFWjc1VHF2OUcxdXI2dStLL3NKbnlo?=
 =?utf-8?B?UXlPdzFKQXdwQnA3Q1MyTk1XeGJEOHpPYUs4amRTREVCTURVb0xDdHk1Q0hr?=
 =?utf-8?B?QmpzdENLVnUzcFBkOXNMTTNmZzlkU0ZBQ09CUlVYUGMzQUVCbFJ6eG1STkZZ?=
 =?utf-8?B?YWxaZ3FvTjd6L2EvTVovWG9ldmRpa2dKbTJrUWhrTG9qWU9ZSlB0UXV0S2RK?=
 =?utf-8?B?cVFDaGxWMVljaW91T3ptWTFYRjg4YzBreVNIbGZPSVJHanVlSXhsc05qN1dU?=
 =?utf-8?B?TU5PWUlnckdEQkM0VERSRjhzZEc1ekRnUjBaaDdzTHRzTVhaS1BJVmlCZVZ3?=
 =?utf-8?B?dWJLcHNPL00xeDluUW0vVHdkZzEwNVJzdno5WjdHS0FiR29lNjFVU2N6eE9V?=
 =?utf-8?B?VC85SWVQSXMyTi9NOFFUWTRRZXR0WmtEUXZaV3l2K0VDU1RzZ0F3RVllVlRn?=
 =?utf-8?B?R3NYK3UxOElXcnpuUE5pNmNtWFJyanJpU2Uza1NndThiSWlvK3hEVGI2VXpE?=
 =?utf-8?B?ajJvQzlkcWpyMVorY3RjOElGZUtWa2EzbXozeGcyVGRPb2xtMERobDRSQjVR?=
 =?utf-8?B?d1ZlWTVuNVJtT2JqNCszUkJna1AyU1B4akVlbTBwcjdQTG9hOVBzRzBGT2ZE?=
 =?utf-8?Q?523yA/G6x2sAuoJV54V/5nELezE8GIiD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmFJaXFBQit3aGhkZUlLK0JBUlg2UTNCbVBhdGVYOUFCRlFlRXB6ZmVpREFu?=
 =?utf-8?B?N0ZOdFQxSlkzUi9UcjhBMk9qNVcyUERlbE9zRFVxcUphbytydVFOQTNFK0V5?=
 =?utf-8?B?Y1FCajE1U0YzSkVXak1lN1J6Tk1KaG1lVEo3QllTaVhkb3YrMUI0VFJTQ3N0?=
 =?utf-8?B?N0VDeG54cFgzdjdLdGFXaTE2cllNMHI2UGwramMvOHc1Y2V4bzFBb0ExSDFW?=
 =?utf-8?B?Nyt0b1lLcjB1NTM5NUZweWM5SzNPdWxLSlJBc3dQM2poZFJmbGtJZXBhcVE3?=
 =?utf-8?B?RkF5YXBvZWwrMVRZRXhqR3VxcU5NOTdZN09qVDlyQXlhb0JyZHE4cG9aMlo3?=
 =?utf-8?B?Z1JGK1ZtWC9zMDkwSXJ1c1FTbFVycDZRYk9hSG9zcjFtTU83SFdaTEF5d2RD?=
 =?utf-8?B?MFlsb05laVV5NTc1YXhXaWtkNWtwRDUvbnpTZk5uUzZ3UEovT3dzSFlXK2RM?=
 =?utf-8?B?V3gyN0xqZjlDcmtDaCtyRDFVbTZFTjFFS2V5YnY2OUdOK1RHYVhKREcyNUxG?=
 =?utf-8?B?bUhNc0dWQ25vLzN2d2xJc1I5UTI4K2JFTkpscWkwbEl4eDRVQ2QzWk9YOW80?=
 =?utf-8?B?aWNubzZMNU51ZVBzWUg4b0lhLzJBUjlmSzBwTSt3UTkwR1o2Q3lwSERGUzY3?=
 =?utf-8?B?WEh3N3d1dkQrZnpVekswL25NQnltOUQybDdFcnNRWVBsQVdmVW9rVEdHQk9Q?=
 =?utf-8?B?VnVCUWgwanVnbHFFRUNqNWRyV0dTd0luSVdCbVdrK09MSi9SMWhqRDhNL1NM?=
 =?utf-8?B?L1dTbEhQWE1FQ1U1VGMxYjZmU3ZTaE1Jckxib1NvVVFHblZ1S2I4VDdPdTA4?=
 =?utf-8?B?elhscHl5b1hod2pKaDBxNHRSZWlRSkJTQ0V2bEhnamx4b245ZCttcHQ2Rjk0?=
 =?utf-8?B?d0xsSUlNUGhvMHNtSmFaMmRmU2pxK1VOK0ttWTVBaXk1aEtzQVovaUJHM1Zm?=
 =?utf-8?B?VURkSVp1NVVRWC9iY0g1VXY2YkhYOHpwVUlOaU9lRW5Wcm5EK2dySjh1R3FY?=
 =?utf-8?B?aGQrUktjTGYyOTVOMm55NTJUYmorTHRWcUZOa205NThNRndDc2NQYU4vdkRn?=
 =?utf-8?B?ZU5DOFQ3eDFNeVR6cUlCZEtmSlhTRHBsSjcwdE5rUDcwVmYvWDBTNEk1OFRM?=
 =?utf-8?B?RWswZENPWDh3VkFKSkY0ZmhrTzFJc0d4Qnl0N2pvODkrRUxEQTFCOWVoR2NJ?=
 =?utf-8?B?Y3BnUDJzRFZFekNuZlg0djZucFlOaEVJZWc3dmwxQjkyZ0NCVEhBb0xTdzFw?=
 =?utf-8?B?aURSdk53WGdqYlZiOUdMeThBZ2o3dDJYNGtUUHhHSjV0RElyQ1ZZVTZjSFdF?=
 =?utf-8?B?VFFKZ01EcTVvV25IODZweFBDdmFmY0QrOTZjVi84VG1MaUQxYm5FYWdka0c0?=
 =?utf-8?B?YWNYdWYrMmhiTm9RMjhsM05tekxwcXBkcWRjZENuTFM3TGVyY1lUV01uUi9L?=
 =?utf-8?B?VURLYklBV01LWk5mOVhUSitqcXJVVXlBcXU0ZzBlWmluakNvclg5Y2MrakJ5?=
 =?utf-8?B?b3B5enl2a1JXVll0ODRkS0NVOERaYklOcFdyaW0vRXVQcFI4d0orbkxJTG9h?=
 =?utf-8?B?dU1QQzhLTGZRaTRGNm9XaVNjMVhQSVNLa3JHb3hvdGpMSk1nNmg5VW5xR3FX?=
 =?utf-8?B?bXAvTjE1bXZGOU0xNi8zMTF3KzFxT1dCbHA3ZzdaajRsalJiUDNkL3BJYUNS?=
 =?utf-8?B?SWZSQUtkOWxlY3dqKy8wdlRmQnU4TU5Ba3RhYWw5V1hHRWl0SUNxWmhISnN4?=
 =?utf-8?B?em1iem1XQkQyYzgydFdKQlJHQUt1NnlnYkdHRVJNVXpXWnltRitvbUdqVWsy?=
 =?utf-8?B?M29kY0UwblFrRzhzN3R4VXpVczZoQzFTZUlxOFBvY05YalpzS0FSRnkwWHNN?=
 =?utf-8?B?dTAzbTI2UGtyZVZMZXdTZXhOaldtYmxBVUZIdVAvdG54ZUlFVWVwbUE2RTZh?=
 =?utf-8?B?Tm4ya1VsSzlQTDVUeVhiakc0bzRoMDZ5Z085cFdHVDc1ZjkwcXVmRTFXRUJW?=
 =?utf-8?B?VnhVWHRDeGN4QXg3U0ZTQ2pSb2k2N2lVRWpzNzdWYnhoQlowNDN4YzZzeUNh?=
 =?utf-8?B?TUgrUUN1aVJrR0t5UGMrNjcxdmg3R0t6N1pXc3BWUzA2a3dVZVF0dzlWaC81?=
 =?utf-8?B?V0QvTFVuaEYxbnQrNjdoUjdCbWV1a0kzQXNGbzNTbC9YWU5WYmh5WFhVRU5s?=
 =?utf-8?Q?28F1JoA0YR89MbydXryedeo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7CA4F459779F04A8BCBE12255251FC4@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5d430e-8ff3-42e6-4ab2-08dd67f88d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 21:45:37.8132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //E00CF9TQ0D5N1W87O/MJi/MTOEfiwffmsIjjyslD7zw6AZGcCPzdBjB+obXyX016Q2BQsnZcRzPzTfwvZOCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4358
X-Proofpoint-ORIG-GUID: KhQtHKIzpfhaOvfrOMuIMfoB00DkHzbs
X-Proofpoint-GUID: 8mQVQc01xiK4Ac_Rst907a7zRSEEZXRc
Subject: RE: [RFC PATCH 17/35] libceph, rbd: Use ceph_databuf encoding start/stop
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_07,2025-03-20_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=522 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503200139

T24gVHVlLCAyMDI1LTAzLTE4IGF0IDIyOjE5ICswMDAwLCBEYXZpZCBIb3dlbGxzIHdyb3RlOg0K
PiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4gd3JvdGU6DQo+IA0K
PiA+ID4gLQkJY2VwaF9lbmNvZGVfc3RyaW5nKCZwLCBlbmQsIGJ1ZiwgbGVuKTsNCj4gPiA+ICsJ
CUJVR19PTihwICsgc2l6ZW9mKF9fbGUzMikgKyBsZW4gPiBlbmQpOw0KPiA+IA0KPiA+IEZyYW5r
bHkgc3BlYWtpbmcsIGl0J3MgaGFyZCB0byBmb2xsb3cgd2h5IHNpemVvZihfX2xlMzIpIHNob3Vs
ZCBiZSBpbiB0aGUNCj4gPiBlcXVhdGlvbi4gTWF5YmUsIGl0IG1ha2Ugc2Vuc2UgdG8gaW50cm9k
dWNlIHNvbWUgY29uc3RhbnQ/IFRoZSBuYW1lIG9mDQo+ID4gY29uc3RhbnQgbWFrZXMgdW5kZXJz
dGFuZGluZyBvZiB0aGlzIGNhbGN1bGF0aW9uIG1vcmUgY2xlYXIuDQo+IA0KPiBMb29rIHRocm91
Z2ggdGhlIHBhdGNoLiAgSXQncyBkb25lIGFsbCBvdmVyIHRoZSBwbGFjZSwgZXZlbiBvbiBwYXJ0
cyBJIGhhdmVuJ3QNCj4gdG91Y2hlZC4gIEhvd2V2ZXIsIGl0J3MgcHJvYmFibHkgYmVjYXVzZSBv
ZiB0aGUgd2F5IHRoZSBzdHJpbmcgaXMgZW5jb2RlZA0KPiAoNC1ieXRlIExFIGxlbmd0aCBmb2xs
b3dlZCBieSB0aGUgY2hhcmFjdGVycykuDQo+IA0KPiBJdCBwcm9iYWJseSB3b3VsZCBtYWtlIHNl
bnNlIHRvIHVzZSBhIGNhbGN1bGF0aW9uIHdyYXBwZXIgZm9yIHRoaXMuICBJIGhhdmUNCj4gdGhp
cyBpbiBmcy9hZnMveWZzY2xpZW50LmMgZm9yIGV4YW1wbGU6DQo+IA0KPiAJc3RhdGljIHNpemVf
dCB4ZHJfc3RybGVuKHVuc2lnbmVkIGludCBsZW4pDQo+IAl7DQo+IAkJcmV0dXJuIHNpemVvZihf
X2JlMzIpICsgcm91bmRfdXAobGVuLCBzaXplb2YoX19iZTMyKSk7DQo+IAl9DQo+IA0KPiA+ID4g
KwlCVUdfT04oc2l6ZW9mKF9fbGU2NCkgKyBzaXplb2YoX19sZTMyKSArIHdzaXplID4gcmVxLT5y
ZXF1ZXN0LT5mcm9udF9hbGxvY19sZW4pOw0KPiA+IA0KPiA+IFRoZSBzYW1lIHByb2JsZW0gaXMg
aGVyZS4gSXQncyBoYXJkIHRvIGZvbGxvdyB0byB0aGlzIGNoZWNrIGJ5IGludm9sdmluZw0KPiA+
IHNpemVvZihfX2xlNjQpIGFuZCBzaXplb2YoX19sZTMyKSBpbiBjYWxjdWxhdGlvbi4gV2hhdCB0
aGVzZSBudW1iZXJzIG1lYW4gaGVyZT8NCj4gDQo+IFByZXN1bWFibHkgdGhlIHNpemVzIG9mIHRo
ZSBwcm90b2NvbCBlbGVtZW50cyBpbiB0aGUgbWFyc2hhbGxlZCBkYXRhLiAgSWYgeW91DQo+IHdh
bnQgdG8gY2xlYW4gYWxsIHRob3NlIHVwIGluIHNvbWUgd2F5LCBJIGNhbiBhZGQgeW91ciBwYXRj
aCBpbnRvIG15DQo+IHNlcmllczstKS4NCj4gDQoNClllYWgsIEkgYW0gY29uc2lkZXJpbmcgdG8g
bWFrZSB0aGUgbGlrZXdpc2UgY2xlYW51cC4gOikNCg0KVGhhbmtzLA0KU2xhdmEuDQoNCg0K

