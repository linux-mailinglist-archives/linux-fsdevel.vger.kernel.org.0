Return-Path: <linux-fsdevel+bounces-71686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62486CCD50C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 20:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D17C301E17A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 19:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F30312825;
	Thu, 18 Dec 2025 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EymBSrRv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E28E2FBE0F
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 19:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766084528; cv=fail; b=lUA2a9jHtwpHint4VmmLWL3UQ5oVdcDlrR8aiGDqxKvjZEHkCzhqrGc7SSgDFMoLxk+oS29/XIkNqlpUmlLx6R+Z7ypiGwcSS20mhg1oZXWBi/aZiPN8AwMkMhu63ZVoCiXxW5OPIJTaMQLrhLFEmNxBAw55auC348WVFYaE040=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766084528; c=relaxed/simple;
	bh=ez8eEfEbmPeEnYM6hfvXGF/Z9QLghWXtx5PYQrjDFK0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=pN656VcJisHFpMFFhnPOvJtNgWOsZjOUh7XVoP4hF0fY9Qh7d7dc0sJqMpNdQczeQ6iSZoVe9vNXz71WP0vbik7w+c09v0nuA6SEeqP30iBX/lsTY585bVYYkIWShqSMVe9oMsFZpe8rU3bnbDpihyu7FgSdp49IWOk/PuCxLvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EymBSrRv; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BIARYwO026434
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 19:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=ckiZbPoZ9xucEYOMN+GOk9hFEbd2b8VYVJabeDnf9w0=; b=EymBSrRv
	JJz12qG9PgQMpFwgPoHUZpoqwXN0c1u5vIKLbXLjw8ECRdElH41Md/UZaLkuEffb
	A6moYtMF6wYm9s5qfYM39432decqNyJ/LBAzQcjHDaGSA+XP47/Fw7LVmcDNYDlB
	PEOtezrr0hLiaaP66jtYSlVZbWg7dYQeC+3h++B5mo7KTKtqGx8x7HLHf9ue7Kcx
	xEYclpQX08ZpLemKLVFs3KVP3/o2vwq3SKhuUjJkWuWFeKJ3+26+jbhD9iynXB/5
	g3ZuMqWCJs4ETPjidObW+bY6YYheJ+w6uQhspNcMtM0VtT827ry9hgsTeTxwDOQF
	Gm7rxaRalJcT1g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8vfey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 19:02:06 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BIJ1HHt016831
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 19:02:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8vfeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 19:02:05 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BIIwixK010450;
	Thu, 18 Dec 2025 19:02:04 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012023.outbound.protection.outlook.com [40.107.200.23])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0yn8vfeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Dec 2025 19:02:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fObBoUwWDt8G3OGbQ9JKQs0f83/S5NxiguBRn79zFcN01SMbjPeIB0VAuGD1olEhvvzrWTf85/Fu/5AywcimN6ZascZWCCjVavoejmHYwRYS/xYkJizixpxORO1HRa+dNLp1/yRpVj3iVZgGur9sEKNK511JndybE5wazD3VmAwu4WWQjkrg5ROnNmlwIHMQlP6BOI73UgnHA/VBIZCBWW0IF9J4BXAhKcdQGl8WC01+zyk3VkJ5B4ovE21hXU64GikJUlugb+93ycwxFQtW+uWgWsNak9Cp/JApDOvP2X7uD01z54r0Jyi5j5tWd2MjZhk2uBmP3n6A27udB5FBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCQj471fjnQwA3O78sCf9jYVSc9VBVuS/1YC9k6AXbo=;
 b=a1KfteWxjVNDc0cOD3EuFc6wlkkwZWK4JoRexwpSQfc2ikGiqnMZUJIhiJOnXyg41LshqakJl2Ql9oT2c4GoNfLwicAwnjr3TVpyqokcXnz7ntmJ72mMTa67Hp3rAzqVoQg09V5K88YLcOo2hMy4zpDCfNpW1u93vHD2+zJxkEw7y5DOe/M6j0mQRu7KKi2Wc1ndkCEdvvsgCb/lLlkSfsgqk1bHKxfWeC2TLRCN3LaKas37pG773z90tJ/LBgF2jb1Z2ltisxnjE+jQHSFgfteYNkOaXtbUKBtuE26BZVnCQCHEJrGQNxIyRtp4onIhmWGOzxrtlhA3oE7lNw0Rbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SJ2PR15MB5717.namprd15.prod.outlook.com (2603:10b6:a03:4c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 19:01:59 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 19:01:58 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: Patrick Donnelly <pdonnell@redhat.com>
CC: Viacheslav Dubeyko <vdubeyko@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        Kotresh Hiremath Ravishankar <khiremat@redhat.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Pavan
 Rallabhandi <Pavan.Rallabhandi@ibm.com>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ceph: fix kernel crash in ceph_open()
Thread-Index: AQHcb5TpmMeL+RYIakuRlVP/l+uM0bUmTK4AgAB3B4CAAP6yAA==
Date: Thu, 18 Dec 2025 19:01:58 +0000
Message-ID: <fd1e92b107d6c36f65ebc12e5aaa7fb773608c6f.camel@ibm.com>
References: <20251215215301.10433-2-slava@dubeyko.com>
	 <CA+2bHPbtGQwxT5AcEhF--AthRTzBS2aCb0mKvM_jCu_g+GM17g@mail.gmail.com>
	 <efbd55b968bdaaa89d3cf29a9e7f593aee9957e0.camel@ibm.com>
	 <CA+2bHPYRUycP0M5m6_XJiBXPEw0SyPCKJNk8P5-9uRSdtdFw4w@mail.gmail.com>
In-Reply-To:
 <CA+2bHPYRUycP0M5m6_XJiBXPEw0SyPCKJNk8P5-9uRSdtdFw4w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SJ2PR15MB5717:EE_
x-ms-office365-filtering-correlation-id: 9f6ad49e-1286-49c3-0fcd-08de3e67eba0
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U1lsU2JlOXV6VG1GQWZqQW9JZ2pIMUQwT0RpeWU3Y1FybTd3OE1mL2NMYTQ2?=
 =?utf-8?B?a0ZCR3c5K3QrQ2JpMDRxbjVWYXVOS2VlY0RDa2RVK3JEc2ExaTQ4QTBXajFT?=
 =?utf-8?B?VUJrMWVBZ25JUHUvVTdVOXlkMXBXbDJORzdIZ0tobkVTTEM1eWNVWU9GSlBo?=
 =?utf-8?B?VHlxVG5LckpCSXZrTUxWK0JSWlU2LzBlRnZhWGNYWUtkWm1oSUpXcFpGMUJC?=
 =?utf-8?B?RVJ1MDhNejFkdGtsSXpxL28veVkrSWN6dHB1QmY3SEFPVU5lSlo3UWNGYS94?=
 =?utf-8?B?K2drL3FReW9OUjhkbkVQR1FwWE1FTU1vdU42eUtjeHdzd3BlVnhPV1hZV0ox?=
 =?utf-8?B?Z3BRbytzOUVRZlJqM3U5dks0cXFKYStIUHBhZlo5RlZsOEtCSzQyNy9iVjVq?=
 =?utf-8?B?U3cyMjl0Mzdkejd6YUxLdjRGMlBxa2JyL3pUYWtHTFVhWFA5cU5MNTQ1QkU4?=
 =?utf-8?B?TlViUlZnZFNTNHB4VlJyT3duMWJrS1V4bXpuRzBMcmVFeDNkb1lzZENxN2I1?=
 =?utf-8?B?OFpRUFFrOU51NERGd0hjWlZiL3Q5RHJudGVJZlpKVTNSdGtUcnZ6YU03RTdj?=
 =?utf-8?B?bjRVeFBUQTBwZzJTTjlBbyswWHZVS0krNnV0em15bU1rQ3pUa24rTVQ3WktO?=
 =?utf-8?B?V2IySklIemt4d1NCVG5xMUVoQk80ZVpiV2doT3hJbkl4NmF0UlpDWkNEZGxs?=
 =?utf-8?B?cnBxS1ZTMTNqMkQxL1VoV3ZTWFBQNFNMY0NVMTdPWkpPSUNpaGorUXRTV2hO?=
 =?utf-8?B?cm5ocS9Ga3BmUzRjVXdJWFNpZ0VDa210U0pha0E0bDRNMUtpTWFCUU5hZFVJ?=
 =?utf-8?B?Tzlydk1FNy9aNEN4UnZ0NGdSUThOKzdpYUZZeVNNYnBTTmlWTkIyb1FUdklR?=
 =?utf-8?B?YzRjWi81YkNFNG81aEJVMnU4RzRCY0tCZ2wyc2RYcVBzRGpTckg2L3ZHODFR?=
 =?utf-8?B?ajYySldlNHJJZEkycnluWTFUZ2JVbmFRRXg3L0FZbXBaT1U4WG9nMFAwV3Qv?=
 =?utf-8?B?NEpKbFQyZXNwc3BGTHJTR3NsbldXTmdiNmVkWm8vQTBPNGRIanN2b2kwQSsr?=
 =?utf-8?B?SGsybjlwY2ZvODNlaUdaK0RkWGxMMmt6N2VuN00veXVqbGhWOXFQeFBHSG9K?=
 =?utf-8?B?ZFFTdXpGaVJueG51S0EyMC8xM1R0L2VXSzhSQ0RmK0lxT3RFZVBabGhsM2I1?=
 =?utf-8?B?UHFBWW9zQTBPcHVsTVBlTFRlU3ZpQ1ZsN085dmRzU0JXTDlWdURMZFpkV0xw?=
 =?utf-8?B?NDl3UlJXdkg1VDVoNlpJVWd3azY3ajhpVHBUVVRzQ3VxNmVSd1Q3NGFFUXls?=
 =?utf-8?B?YnVBbXpoZEFGZUdnRUVpYmVrMXJ3ZXZ3VWI5TU1nZWFtSDcyVmN6eTBpRVdE?=
 =?utf-8?B?NmlBbmhxcnpPcldyRVhLUVRQMGdpVkxPRjVCbVk3UEN2NXJneXRoRE10SW8v?=
 =?utf-8?B?ZU1MSTVIdWJOVHI5ZUZuUWs2d0VQdkJSci9lRVhZLzdqWHpoQkQrdmJ5MktS?=
 =?utf-8?B?YnV2Tmp2bnV5Z2FVcHpqOFlaVVdWYXRJWndiRDA1b0lRVlNZaStKVGN5ck9B?=
 =?utf-8?B?N1ZyeWNXTUgwMHdQejZGam1DM2Fqc1ZwM01RNzc4WU1VRVpPNVY3NjJJSmZ0?=
 =?utf-8?B?ZkhPYTRwY0VqamNXYmxtQVQzZnJnalFqcFBiSlFsV1NlQVVMdVpaaWpEamh6?=
 =?utf-8?B?ZXBZTWpMSGtTQ1loelB3eFIwQTJCVVcrS2hJZC8xOTE1UjJiTjBsZEpxQkdx?=
 =?utf-8?B?MDVLbTllaU5LR2ZZK2FsU3AwQ0lJSnlMTVAxZDFxMEF4dmltd3ZXYlJPZDdy?=
 =?utf-8?B?c3JzU3NCN1ZYaC82YWlGVVVvMUY4S2ZvNU5iSytkN3ZwcjJsRFJQclNBVVh5?=
 =?utf-8?B?S3cwdzdMU1Azd0dKNXRFZ1EzUjBsdTc4U3pXVElQTnVGN0kwNktmUDNVbTRC?=
 =?utf-8?B?NXp4cy9IMXczcDAxTjJFc0QreG5TMTUvNjg3WlNsOVBTYTdpS0tHWXlIT3k5?=
 =?utf-8?B?YUx6ZFR1M3grNjUwRFprdmhxT1cyaDF3TVZhaVJzYTRucVUramNrUTFIbkpa?=
 =?utf-8?Q?uv0yUH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmtGdXdwMDVXT0RJaHUwSi9wa3pWWXhtYzJ4MU9aTmZ2djJtWWlLck9HM3Fo?=
 =?utf-8?B?V2hORHQ5NW5sV28rdEpveEZiVUlrdXZjdXRGS01za093L2RMNnoxOU5QU3ZT?=
 =?utf-8?B?ZTZvUkJDdFlmampCWTBqMEhVUlJTT0NvWWllT0sxYnlTWFc5Um1pYkdyN1FC?=
 =?utf-8?B?dGFzRmNweUdJRE43U1Y4ZmFaYmpPWFh0T09hMWxMUmJCdldST1Y1UytNcTNQ?=
 =?utf-8?B?R2R1dy8wT2E1OEEzamxuKzEvVEpNVktDL051UjZVM1ZZb1hYU0FpSVVJNUth?=
 =?utf-8?B?dDBzdTRKcTJwNWZQYTkzZkE2dGhKaGZ4dWFjSEx0OTdBb25lMFdYMTZFdy90?=
 =?utf-8?B?Y3FjRTc4YVRZWGhuTlFwV0hLK2dySkNWZWVWbXUyVld0V3ZadXRJNitxbGVs?=
 =?utf-8?B?M0Y4R0ZSOTRXWnJ1WjBnMll0aXVOenJWWnVETGh2RTY4NStTU1FQclZHOHNE?=
 =?utf-8?B?WXV0ellWWExSdFFkMGhOSW1tc0NsTWlqanNLaEJPMjN2aytLalp4TDk0UUIy?=
 =?utf-8?B?NGU4Q1lGVER4dUFVWFVCZXRhWHMyWUMvRHo3ZjdweVJqaGlPRWdqeVFOTGta?=
 =?utf-8?B?MUFQajlNRTZGQzJrNUtyYnRBMnIrd0VFang2cVdqdUlRUWgvSjEyeXRaTGpC?=
 =?utf-8?B?N0t2Ly9WYjlvZWV6RldvTWVENm9ZYzRJMk5uS2NuUldCR1pDeWpacHRBNVl3?=
 =?utf-8?B?cThWd0NydXBkb2U3RDNQVlpUWkRQc3pUczBqOGtRdW1ma2l3WCtaNy90bmJW?=
 =?utf-8?B?UHB4ZlNEMEVpZGlNaXlnTVpQNzZ6S2lkdURFQTdQcEJmMmQvdFBYQngyYzFJ?=
 =?utf-8?B?V0I2SE9jVzBualVzeXlqbFIrRTFJS2RYc1lUekFNY3JZSmR0ZVdLa1ZmSXhC?=
 =?utf-8?B?NzlMNngva01wNmROZ0hiM1IrL0hOQUkxUWduSzVkRFRwWm1ydDdFSXZDa3Zr?=
 =?utf-8?B?a1I5V3RySjhReDkyZTdyRDVRU3ZSZlpRQnZsODdTK240QjduQXZUNjdKcDkz?=
 =?utf-8?B?N2JZNVAzVG5CLzVuSEJuaFljdU1EejloRFFqbWVTbHF3VktrOFczRzhjdjFt?=
 =?utf-8?B?UHpmb0YxQUFZMkgyL0E1TDN3cUpTWnE0cllRNXhNbUd4UHFlbndlT05MRklJ?=
 =?utf-8?B?eEp4cGlHL1R6VGg3c0U1SkZzbitlblRYNkdlQVdIV1c0S3E4V3pKMGVlVEJI?=
 =?utf-8?B?QjFuc2xraHdSQ0VVR3ZMazRuM1BBMDM1K1o1aTNxSmdEYVJyajcvbnZXcmM0?=
 =?utf-8?B?cG9HMWcxYnBjY0NGUlhmejE3ajdYWktoMGhhTlpsckRKb1VNdGRsemxKZkNh?=
 =?utf-8?B?VWlRb1ZpY2wxVllHbnQraWdVNEVQM3FLQjU2eFlwSjJsdmJ1SWlCdWJaVjQx?=
 =?utf-8?B?cy84YTFLZC85blhuaTJ4eFl5QXUyRWsxWllwS2FJVHZkQ0h2VldjajJoeFFW?=
 =?utf-8?B?WmkvL2ZoWFFHVFlOQ3ZwUUY3Y2I3aTBBN0luNWVoTGRVRTUxODNiVFQ3WHl5?=
 =?utf-8?B?K3FGTVdVNnMyVHpDTTc0OCs5RzFuaGhyWVVtaTBqUkpXM1BPd3NVeHdmQ2FX?=
 =?utf-8?B?ZzM3Y3dlVDViWW9WNDZGQ25SWkUwV0tzWVlwQzhIbHdndWhJeFhJNm9WUXZ0?=
 =?utf-8?B?UnQxNnE5UmV1Sm80YVRvcklEMEtLL2ZNTDhONWxuanhtUVQza2x1Q3c0ZjJT?=
 =?utf-8?B?ejhJa2JNNDA0THJha29KL0VOb1k0OWJCUmRPamVYU3V2cU1ZbnRZMm4waHd3?=
 =?utf-8?B?Mk9mcy9ua2pEa1BQTE9nM3o1d3daL2lKd0prR003WGpzTThSU2duSGhGczh5?=
 =?utf-8?B?NU9wQmlnNjAwY1RtWW93WTZUWmZJazhtUGo5S2ROcm1TQW5aWHNmOG1jL0tw?=
 =?utf-8?B?c2d5RDNlUFZXaGVOTGJaMFNiL1RGa2VWZGZsWnFUVVFQV2hZakJmYWVNMVYw?=
 =?utf-8?B?QWRqT1p1MzBEOXUyaEo3dlB0bVRzMzVtMjZDbnM1RThyUFllVjRyNy81Tmp3?=
 =?utf-8?B?bEowY0M4NFRxTjNSQXJMcTdIWGQzVlZDb2FUQWUxMG84MmF6YTVsTFdhUEJl?=
 =?utf-8?B?NHYrYktFbWdLN1JmdURpYWhFR0dHVGpTWE52dHViL2xPbkR6UFdUdTF0SDQ3?=
 =?utf-8?B?bmV1NGptYVFkU0V5K04ycnc4VU5iUXlpN2xScVI2Q01iVnB4bkE5T1MzRFgx?=
 =?utf-8?Q?RadBauTulkoXyH2gcdAMahE=3D?=
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f6ad49e-1286-49c3-0fcd-08de3e67eba0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 19:01:58.8282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kaPr4hT63a/FTfaB9yExZiL+TMoZ1S+QAn+FpONlfQef1z2TKNR3buqAYpsBfj+q0+QxeHDg+q0gTF9W6/VoOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5717
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAxOCBTYWx0ZWRfXzkPOPJCFfCKo
 BApSMBfcRcAYcGhbKy28stq5jJn/t34LRuyQev7IK5Do10jD5CRxiPqgXbsBsMgltCcvmTkrTCz
 jIRrxtu0jI6m34v9OrZ3Jnk6eslKGxKM1aPSMRj8DyoFC8mtZ8967OfNMFaGziB35cBQ+IAvStR
 aLYMfolz6BryDBzj/2VRJ+1U5zYaIZuT4HkbcYHhDTvT/HdsuMmwCO+ZgAIxe2E/gRBmaEFzI9C
 kUsY5FLoUao234k7hq4/qgsH7z1x8mZ9Auqe0Q8JX0dI8NE8LtUQiS9TYjW6Rb8ZTBvH5QvKJj0
 BAalRy1046DgToyqsbRF4AypOhAv1AsGvNfPIIL0xWmHiRSoFJNtWgtI6kjVxZdJdBoBAzfPSmh
 vh16DvkmPKumjsrk3/HBr4J6M6kFuQ==
X-Proofpoint-GUID: HMYaQvatyiKGzS-9DEMkkdkQQ2cwbNSD
X-Proofpoint-ORIG-GUID: -F9nzxe8KboSYU_AhOROj7QW9uabiViD
X-Authority-Analysis: v=2.4 cv=LbYxKzfi c=1 sm=1 tr=0 ts=69444fad cx=c_pps
 a=P2JTm3oOj23y55bZWJDDIw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=A2VhLGvBAAAA:20
 a=VnNF1IyMAAAA:8 a=mrvgKRKG01bre9UOao8A:9 a=QEXdDO2ut3YA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
Content-Type: text/plain; charset="utf-8"
Content-ID: <E423B1A78A9AD54EAD59FB922ECBD6CA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: RE: [PATCH v2] ceph: fix kernel crash in ceph_open()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-18_02,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=2 engine=8.19.0-2510240000
 definitions=main-2512130018

On Wed, 2025-12-17 at 22:50 -0500, Patrick Donnelly wrote:
> On Wed, Dec 17, 2025 at 3:44=E2=80=AFPM Viacheslav Dubeyko
> <Slava.Dubeyko@ibm.com> wrote:
> >=20
> > On Wed, 2025-12-17 at 15:36 -0500, Patrick Donnelly wrote:
> > > Hi Slava,
> > >=20
> > > A few things:
> > >=20
> > > * CEPH_NAMESPACE_WIDCARD -> CEPH_NAMESPACE_WILDCARD ?
> >=20
> > Yeah, sure :) My bad.
> >=20
> > > * The comment "name for "old" CephFS file systems," appears twice.
> > > Probably only necessary in the header.
> >=20
> > Makes sense.
> >=20
> > > * You also need to update ceph_mds_auth_match to call
> > > namespace_equals.
> > >=20
> >=20
> > Do you mean this code [1]?
>=20
> Yes, that's it.
>=20
> > >  Suggest documenting (in the man page) that
> > > mds_namespace mntopt can be "*" now.
> > >=20
> >=20
> > Agreed. Which man page do you mean? Because 'man mount' contains no inf=
o about
> > Ceph. And it is my worry that we have nothing there. We should do somet=
hing
> > about it. Do I miss something here?
>=20
> https://github.com/ceph/ceph/blob/2e87714b94a9e16c764ef6f97de50aecf1b0c41=
e/doc/man/8/mount.ceph.rst =20
>=20
> ^ that file. (There may be others but I think that's the main one
> users look at.)

So, should we consider to add CephFS mount options' details into
man page for generic mount command?

Thanks,
Slava.

