Return-Path: <linux-fsdevel+bounces-49991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 945BEAC6EB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 19:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F16C13A31C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 17:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87D128DF04;
	Wed, 28 May 2025 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hn5+DW+n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BCA1F461A;
	Wed, 28 May 2025 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748451885; cv=fail; b=QZrJ9b8BH8H5zs/0oB/yuUM+Tuj050hugAMM2WaKLzGIqzUUapoP3JTk6aKif9PMSDeb1qbv9Elbj2hFDdrkeHHoAMxfo2VZSFl6qTNwGXaZDhV3meamiaB5EMzxkI7E/mHScjH2Wt0nuGGDMkHF4O8ZuMODhQuEogrWybj/+yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748451885; c=relaxed/simple;
	bh=AIpLBs7TUzWksov+qS2puAPm+v7oBI1RSSh7QCysf90=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=g7c7P1fjdEnoowlM4p+LK7G2zr8KEbc5n7yiIs6E8dQf+RBVZALE9O8osh818JyohkphTs4HkLnP/c8+CWhiHHOnKHtDBJzznYA/9N2Oi1rejuFkB2pAIXws2+oBx0sp7Mx+gXcb/21sMl6WhAWT9dUB/AV/qkU95PC3poWqlk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hn5+DW+n; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SE9gtu022594;
	Wed, 28 May 2025 17:04:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=AIpLBs7TUzWksov+qS2puAPm+v7oBI1RSSh7QCysf90=; b=Hn5+DW+n
	YPkoXG70n59BG4ZjIoanaLM506tgD3XzhIgjcfg2iny4bubaKdf6OgnjgwRg7gYJ
	EoHzqEHA1e+EZ8iXDAzNIQXFbOGdN/Fc0e5eaFBJhwl0Y3bOMPVCJws7yb3evoIn
	3niLFwoRDiBrL29F8lPpkPYImyaF5uzSFKpFxNZubQqv5qOTKyPyZL1c4bfdDi5H
	nendXnsjF2EDbEU9ypdu5999sZ2eaFUkiGK3/8/PrerSX9sdxwv+mBRCPVnmK5DU
	PGHF9DqViMDiClUPouqBKzKWGmFt170HWYbi6vBY8xP6qyhEEc3ew/O2k2cJcdwv
	dWC319qC6dGOVA==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46x40h0xbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 May 2025 17:04:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FssW7OhB/LozmgFPWX3VWV1c4b9K0/xDQ5ksaS4BSF8F3D+c35bhd9Ye88NsVlsDCrT6qC8FDEsOm05Rc8qcMiyS4fsTPj4yIA9P2FWvdrMQZ3XBFd+JnJ6hOFargqiKFyz8xU5j12xKZVQeFowCNRzuuIO19Q+6EMIUW1tDxgyn6JFU+Ge0gMINnhssVjunAB7X94sFxVmANXMW+Cz+qXXCuGx+WJF/3phoCI3K1NFWO5qNsmCYDZ4mx1UJC7j6ydTxOkjbqOXSVTkN8Mai9UB/YkgzwDJgVoHFPBY4F3iY/8HzwONfcnPpvYkusfqa0mDHgzf8NwkStbaor8mwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AIpLBs7TUzWksov+qS2puAPm+v7oBI1RSSh7QCysf90=;
 b=XuA0ryv3Jm7oE5tCj7HwBBqX4hdxmHocze8WmA0NHBGhh9R5A7unpxGvWvRc6u7UKhw2ZzcfrJPJVh4HD/PA5K2kKqrkIUkwqLnB7qdw/O3DgXORJZ5ZeyHTFThw+rAoa0dUq6dI52yRt2xRV0eVbTA6GxxNtCbwNZfNFf2j8JlcM1TmJHz1Uerh89f+E4/HQBSMdFKVxuBRrntE/mgUkKt28A20OyskHpsRIspL/ow/DYgsg4xjVkPbZplgdVn6JOo55gHF8aeaxbjzIxeqdPlL7N7XIeRfO2al45mI2jpU/2YvyA5ndrVPJ3IGDl1b4olg6WEqC+wVMVyzRWtefg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by IA1PR15MB6292.namprd15.prod.outlook.com (2603:10b6:208:444::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 17:04:36 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%6]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 17:04:36 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "frank.li@vivo.com" <frank.li@vivo.com>,
        "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>,
        "slava@dubeyko.com" <slava@dubeyko.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Thread-Topic:
 =?utf-8?B?W0VYVEVSTkFMXSDlm57lpI06IFtQQVRDSCB2MiAyLzNdIGhmczogY29ycmVj?=
 =?utf-8?Q?t_superblock_flags?=
Thread-Index: AQHbz/F0QV/lojOICEisO633A+iiirPoRUmA
Date: Wed, 28 May 2025 17:04:35 +0000
Message-ID: <f41ff81af6530ba26ac36e99b48b2f5c2bf0c1b2.camel@ibm.com>
References: <20250519165214.1181931-1-frank.li@vivo.com>
		 <20250519165214.1181931-2-frank.li@vivo.com>
	 <ca3b43ff02fd76ae4d2f2c2b422b550acadba614.camel@dubeyko.com>
	 <SEZPR06MB5269ED00C454799C7D32FF40E867A@SEZPR06MB5269.apcprd06.prod.outlook.com>
In-Reply-To:
 <SEZPR06MB5269ED00C454799C7D32FF40E867A@SEZPR06MB5269.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|IA1PR15MB6292:EE_
x-ms-office365-filtering-correlation-id: 7cab2560-2d69-455f-9ae8-08dd9e09b975
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S1drSXdVc3hZWVRrbXNrVlh6Uk5BdkFRLzl4WkVsVUdvL0U3cGc2N05zYWNx?=
 =?utf-8?B?U1BPbURVVDQ5TEVpNVExSENQbmJRUGtUS2s4QzF1aXhlaE1VY1d4WFlEYVhZ?=
 =?utf-8?B?c1JBZ2poZ2FVS2Z1R1pWMU1Gb1lhNlFEUURJSTNBajJxRmlVM1lTRWlXUkR3?=
 =?utf-8?B?UG1HT2t6N3ZZR3B1YzdrTmF4WUNHaDE1YmtIb2RFcUd0VE1LVGROc2pXQldv?=
 =?utf-8?B?RXErejlZL3VNV21HRHBoQmwyQ3hWUm1Pdy9TZFFFLzNWeXNZNzY3dnZTdWdw?=
 =?utf-8?B?VExObFdydVpkRDFyeXVjTldYd1FnMmhuL3VqT2g2ZkJ5YUM1U2JYaGs4OHlX?=
 =?utf-8?B?MWlsTEFPYmdaVGFjU2dJZ245TVhFS1J3dWVZQXhzOFREdGVIenpubzB6eElH?=
 =?utf-8?B?N1JlSU56OGc0b3hoOGwyQWh6YXo0RDN1L2t3YUV0OERBaE1FcVV6cHBrdkNl?=
 =?utf-8?B?bUNjeXRlMWdSVHB0bzBGb2NLZWx1OWhZMmlFNTk1amhpT3NIQUFweHlTcVJE?=
 =?utf-8?B?MnYvWFNuTkNGaTdPZWFwVWU4S1pnWTdEcTIzamFGUk1vRmF6VklRd3gvRjdW?=
 =?utf-8?B?Nkp6Mzg1Wk5pWDlHR2ZITmROaUFPdStnQVlzSTZ4aStWUS80NytyYkI0eE5j?=
 =?utf-8?B?RG1hdmZ0WXREVGhNUWp2S1h5OHM4Z0NXVFpvamdyL05vUTdVUElySSt1ZWlm?=
 =?utf-8?B?OEZFd1hDUVVlKzVkVldvMkRnS2V4eUNmZU9QclJlRkxzWURIZmJCb2E3T1dG?=
 =?utf-8?B?Mk9QeUZJVGl3RFQvdnpRN3FCQ3pHc0xBemw3NFl5RzZRSU5DUDBTTEl6NE5x?=
 =?utf-8?B?R2RLMTZlR3plZ1hYVjVvcGNEc1Z3cWhUTi9WSU10clp2U3NGYlhKcytML1Zl?=
 =?utf-8?B?WlFMV1NjVnZLcW5oeEJUMUR4Z24vcFBCV3RoYWZ2YkJXdVEwZmhEcmRJS3Jm?=
 =?utf-8?B?TFBUQTZVZFVXUHBXaTlrRVNrcDVNUXk2Mk9OTDZpMmlPNXlPejgrUEJJRzlN?=
 =?utf-8?B?Rmg2K2xaT2VHWVAvT05HYUpaSEcvVzdmQTl5ckhqdnF0QWxaZVpPallyZWp2?=
 =?utf-8?B?S0NMemtmYjFzdHhtcWExQklSTjZKQ0d5TEZ0SEtPVnhIZStRdkQrOUR4REo2?=
 =?utf-8?B?QS9GcmtWTGhMTndwbHQyV3paR0RYb3JHUVdudUJwbHNlNkkrbXNVMW94ZlNQ?=
 =?utf-8?B?QmZuekFyU1FMWDdtZklwbWhYM3V6em5VSVhoelVwdko4WlV5MHNyQ3lRMGsx?=
 =?utf-8?B?UVZ6aUs2S2J0M1JicGNIV1dTQlQzTFpRNVBrdjRTb1J4NXRNUmtJZ2JKZDJZ?=
 =?utf-8?B?eGtaYitTbUNtUEtzOFFhL1d5OUxsR0w0bWk3azdHWXExN0kremNoanpldHFW?=
 =?utf-8?B?ZERFQlIzckk2OXlkU2NyL29PR1BObWxXdGlIclFmY2x5WENJSEVPMWgrY3k5?=
 =?utf-8?B?RG1YZ1o5b3plTDdDSFJyN3g4MklkOHorY3AreVlodW9XZGNWZnpGKzh5blA4?=
 =?utf-8?B?ZmljUVNjR1FJekVMR3o5THFLMHFOSGJabWZMUUhLdnJjMURaVzhiaVBVY1Bs?=
 =?utf-8?B?RFJPZFdhVnpaMFN1V1c1N2pWbWNHSjBCZGlyMGpCdTlIa3FIOVYxV1VJWjNJ?=
 =?utf-8?B?TXlvSFJ2bFNIRUx1WkdKcnM5aGM0M2c4ZkFGRDMza014OSt6aEtHZk1ISTVq?=
 =?utf-8?B?bW5KeEx6eHJNY2NwdzhJbHNrVktzRFVSMXBGZjVPWFFSRHNyKzZjMTVIUXZO?=
 =?utf-8?B?TytVQVlFV0tYS2Z1Y05iTHFvM0xLaDF3cmdPazY2SGlHK2g5eE0vc0hnWkhz?=
 =?utf-8?B?dllrcGk0YjVWUDd0NE9EaGRTdktvdGRjUDBzVXNSNGRaSmgrWXFLRmZvWUw5?=
 =?utf-8?B?d2R3SVJEWVFZLzBWWU13bndPNVI5S2NFVWNEM1lHWFlNazEzcmpKWlFSVGhi?=
 =?utf-8?B?SGtOR2tBc0lUdlBwV1JXN2VFMW9KRFJjb1ZkcCtXTGp0MFA3NGprUkVQR3hq?=
 =?utf-8?Q?AKf7Yczr95QKDv7FMtMAS3lzevO2IA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWxRT1RrWHNiZUluWVBIZnNrSDlWTHhNYkh4czI0YWxDNzN4UDBsclcxQkov?=
 =?utf-8?B?dlhEZlFXeUdSRlFzNUpFSDFyQlYxeEtUOHFpYUpqMTA5UEZYbDViVUlMWEkw?=
 =?utf-8?B?R0M1ZGFPdkM5TGZTTHJZbzlvVlR5UkpnWW42MlNsRGZaQUc2NVV3RXFldUg0?=
 =?utf-8?B?dGs3VC9ZdC9sdE9FMHIxNUw1L3JjYXEzeTZJUkRoRzR5UXBQV2JtdTgxTkw0?=
 =?utf-8?B?QmtJdXdLUkp4bXVFOEVKbU44dFZNRzQvTjV4VE5pUDhzK3RvOU5rMHBhcUZt?=
 =?utf-8?B?S1YrQnA4RXVpUFJyUHNUOGJYTkJwU25waEJLMllaZ3lvOEJzMlUycGQ5blBV?=
 =?utf-8?B?b1FLa09kck1WdHBtREs4N04rMXd2YnY3aERma3NySUptNVRXaTg3WmNCcWZ2?=
 =?utf-8?B?aEp0bnpsOTduVkU0VUxnbDhJdTArS0d5emNnZjZCY29KWm1EOTdnUkpCRnR2?=
 =?utf-8?B?Umljb3FoTGo0ZDBxRmRablJFaTB2NXpkTVRwSStEQU1iamI1K0h5THFmMG95?=
 =?utf-8?B?Rnhyc1ZjOTJBUEpCSlNmbEFYYXVKa05tZWsyUWlNT2krY1RwdTF0eVhFdVlR?=
 =?utf-8?B?OUxUelF2N0kwd0pJYUNNREVuTGllaUdVZ2pWU2JLQ1Z2VFY0R0MrQjRSY2Nh?=
 =?utf-8?B?cDhFUHRDeUtHM3hlclRiOE5rclR6TDlGWGNiN0htMmtKVXhiekdjTU53eHUw?=
 =?utf-8?B?bTRkdE01RUd0eGM4MmUyNjNxWkk3d2FkQ3hFZU5YbzlNdFZiNWVTM0oxa241?=
 =?utf-8?B?L3RrOUM0V0RsNXdPZ0dMa2daOVB0N3dub3hORWFnRk1CbFh1K3MrbVRXU2ls?=
 =?utf-8?B?WjFsRitwRm9WM1JrOHBBMHpyWnJMaloyR2dsVVJxd3RrNWYyL3p0dHhYSUhu?=
 =?utf-8?B?WWlJZjFnUnNveGdjZFVnamhyVEdmVFV5amIvd0s1UmwzSjRJK3JGYUdPQndy?=
 =?utf-8?B?OXNjUi81UEF2ZW1jOHhpTzU5TzRuR3RHWHI2L0pxQTYvbEFjNlU4aDZzZ3NN?=
 =?utf-8?B?UWhzUlVCSmsyTGN2TVV1d3RtRVVGeVJNV2RRSkMzVGs1V1liODYwSkRKQ0pN?=
 =?utf-8?B?b3Y5MktNQWFSM0ZOeXVFaFA1TFlMeTJLU0dMY2ZaeXFsV2dCekt4ejNUaFVR?=
 =?utf-8?B?cTlsVzlUTHo4U0lnVUFOREJjQ3lacGhuaUthZFBHbFpPQlVzeFMyRTZkRFRB?=
 =?utf-8?B?b2MxckMzSGMwSGNEbHhLVFFscFFhTDdJTy9aMkZZUERpaDZqc3RWZG5MUUx6?=
 =?utf-8?B?M2dQTlNJMDlTclI2OHorek9hVTlQN0hOQzhsajhxYlNZRGIrV1pwWnJ6K2JP?=
 =?utf-8?B?UkFXMlYrclE1d2dXSk5XMi9ESmQxdXlaanZVbW04bitQTjZ6cXJWVW8wazcy?=
 =?utf-8?B?RWM2RXFQZm1NU09FUUQvRVkrOGhsWGNWV3QzcjVpN2pPSG9MT28zdFUybUJL?=
 =?utf-8?B?V0MvTzBpcTZuTGNkd2dPbzlTTXRBQ3VSMjNNa01FbjRUVlcwdlk0TFQxbkV3?=
 =?utf-8?B?ZEVlR01WSyswRG9SSytZQ29tWTFxRExWbmtDdXQ2dG5Uc1NoUHQxRlFSL2Rr?=
 =?utf-8?B?N2g0bzZCTjEzeFo2djJRU1VoM09ydU5Dc0t0TE1pQ3lncGFTaHRZNjVuNWRT?=
 =?utf-8?B?SXBBNUdIejI5cFlEdXdKL1ExeDZzV2pBUW9hUzNCY0Fnbmp5TUl6UGhXL24x?=
 =?utf-8?B?SzlId1lBMzYyWS9xSW12UHY2aWZqTkVBMUdBY0MxN1dKTDYxcnRKR1V2dk9N?=
 =?utf-8?B?NWFvM2ZmMjFCeXRJMEtZVll6R1FiZUxuZEk3SDR5TUxpcndFNTVkektycENS?=
 =?utf-8?B?Uy9kNW5zUmVSc0tPNGhHL1VoK0V0ZW1Db3VWcit6UGIzUjlEOUN5NGZFYVZn?=
 =?utf-8?B?WXo2OVVuQk1jRDRQUldUTEw4bTFPdlZJMENkeGRCbWd1d3dhRmd2azl3a2Nv?=
 =?utf-8?B?WVRmNjRwUlIzTy9EZVVmb3VpK2Uva3BPVm1rTDdmSGt5VFB0eE9Zc3dTdnBo?=
 =?utf-8?B?ZDVTekpBNUNLcDhPU3ZGZ212TGdzZjFwLzVMMjJQL0tQbU9oOGx4U1dIQ1pz?=
 =?utf-8?B?YU5NVTdmaG9MUlZ4dWlFNWFGZzRyS1NLMWRYaXlhaGlGem40dkl2YzZmcExY?=
 =?utf-8?B?TGlwUUlwK2JuS1ZzRFIzamJCZDZWb2lzNENPTUwyZFhHZHk0UkpMcXJoR2tO?=
 =?utf-8?Q?OTSIMbfJO/pp4caQn8T+PBY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <985AE6D7532E2044BCE29CF508E34039@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cab2560-2d69-455f-9ae8-08dd9e09b975
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 17:04:35.9722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +KdcEZk0scRf6vLxuIRFCTQhfIBnJB0hBRGfWzEaTDOWquRQ/BINMG+9T3Zf5SGOEOozHqKgPfUoRc0BhUvsdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6292
X-Proofpoint-GUID: Vzl4cBoiH2BtFvwIE3cQEN9EHlWja0d3
X-Proofpoint-ORIG-GUID: Vzl4cBoiH2BtFvwIE3cQEN9EHlWja0d3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0OCBTYWx0ZWRfX5FGRYv/Ggvpi JHLncMMsoVmiwXpjk1UpBjOj/bfcTvMSa7sH8eiUJTJy8EIWFlwu9I0GreBo+TFHhmc/aKWvc/J pCPDsrAu0shRCWb4v9VvRo7qu0BsZ7uGnERgta+aSjQtwrw0BdAoKHXzefdtSJ+5MrRwwytT6hw
 x4r7p9b0f6YETY8sScOv5qlkZqTNJguq4S3VrltUJL6K5xNU8oTzuPap+3bAx0d0+yKU2iTgVjP 5jEwQFeldNZlW9rCACkhGTIde3i3U9qGX+RKcaPa5fAYk9N2IdNohHJ1HXo5/uXzAFoZzfHWk7W r50TBl0Wbm5L7Goz4QvOr2noSCewikMjIxIOQa1fL7pz/sgpvb/nz6b1yq/OUddwnW1qS9vUr07
 6jlDkvTMrkAf7vZFsW4dYjE6ARoPv0rIlH+lhtPacDD39LtDLAftA8aHbBYAMRvKMDioBRxm
X-Authority-Analysis: v=2.4 cv=L8MdQ/T8 c=1 sm=1 tr=0 ts=68374227 cx=c_pps a=xvwQcxOyB39F00Ilg3n1Ug==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=5KLPUuaC_9wA:10 a=mxRWM2kP1ny3ewtGScQA:9 a=QEXdDO2ut3YA:10
Subject: =?UTF-8?Q?Re:__=E5=9B=9E=E5=A4=8D:_[PATCH_v2_2/3]_hfs:_correct_superblock?=
 =?UTF-8?Q?_flags?=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280148

T24gV2VkLCAyMDI1LTA1LTI4IGF0IDE2OjU2ICswMDAwLCDmnY7miazpn6wgd3JvdGU6DQo+IEhp
IFNsYXZhLA0KPiANCj4gPiBJIGFtIHNsaWdodGx5IGNvbmZ1c2VkIGJ5IGNvbW1lbnQuIERvZXMg
aXQgbWVhbiB0aGF0IHRoZSBmaXggaW50cm9kdWNlcyBtb3JlIGVycm9ycz8gSXQgbG9va3MgbGlr
ZSB3ZSBuZWVkIHRvIGhhdmUgbW9yZSBjbGVhciBleHBsYW5hdGlvbiBvZiB0aGUgZml4IGhlcmUu
DQo+IA0KPiBIb3cgYWJvdXQgYmVsb3cgY29tbWl0IG1zZy4NCj4gDQo+IFdlIGRvbid0IHN1cHBv
cnQgYXRpbWUgdXBkYXRlcyBvZiBhbnkga2luZCwNCj4gYmVjYXVzZSBoZnMgYWN0dWFsbHkgZG9l
cyBub3QgaGF2ZSBhdGltZS4NCj4gDQo+ICAgIGRpckNyRGF0OiAgICAgIExvbmdJbnQ7ICAgIHtk
YXRlIGFuZCB0aW1lIG9mIGNyZWF0aW9ufQ0KPiAgICBkaXJNZERhdDogICAgICBMb25nSW50OyAg
ICB7ZGF0ZSBhbmQgdGltZSBvZiBsYXN0IG1vZGlmaWNhdGlvbn0NCj4gICAgZGlyQmtEYXQ6ICAg
ICAgTG9uZ0ludDsgICAge2RhdGUgYW5kIHRpbWUgb2YgbGFzdCBiYWNrdXB9DQo+IA0KPiAgICBm
aWxDckRhdDogICAgICBMb25nSW50OyAgICB7ZGF0ZSBhbmQgdGltZSBvZiBjcmVhdGlvbn0NCj4g
ICAgZmlsTWREYXQ6ICAgICAgTG9uZ0ludDsgICAge2RhdGUgYW5kIHRpbWUgb2YgbGFzdCBtb2Rp
ZmljYXRpb259DQo+ICAgIGZpbEJrRGF0OiAgICAgIExvbmdJbnQ7ICAgIHtkYXRlIGFuZCB0aW1l
IG9mIGxhc3QgYmFja3VwfQ0KPiANCj4gVy9PIHBhdGNoKHhmc3Rlc3QgZ2VuZXJpYy8wMDMpOg0K
PiANCj4gICtFUlJPUjogYWNjZXNzIHRpbWUgaGFzIGNoYW5nZWQgZm9yIGZpbGUxIGFmdGVyIHJl
bW91bnQNCj4gICtFUlJPUjogYWNjZXNzIHRpbWUgaGFzIGNoYW5nZWQgYWZ0ZXIgbW9kaWZ5aW5n
IGZpbGUxDQo+ICArRVJST1I6IGNoYW5nZSB0aW1lIGhhcyBub3QgYmVlbiB1cGRhdGVkIGFmdGVy
IGNoYW5naW5nIGZpbGUxDQo+ICArRVJST1I6IGFjY2VzcyB0aW1lIGhhcyBjaGFuZ2VkIGZvciBm
aWxlIGluIHJlYWQtb25seSBmaWxlc3lzdGVtDQo+IA0KPiBXLyBwYXRjaCh4ZnN0ZXN0IGdlbmVy
aWMvMDAzKToNCj4gDQo+ICArRVJST1I6IGFjY2VzcyB0aW1lIGhhcyBub3QgYmVlbiB1cGRhdGVk
IGFmdGVyIGFjY2Vzc2luZyBmaWxlMSBmaXJzdCB0aW1lDQoNClRoZSArRVJST1Igc291bmRzIGZv
ciBtZSB0aGF0IGdlbmVyaWMvMDAzIGVuZHMgd2l0aCBlcnJvciBvciBmYWlsZWQuIFNvLCB3aGF0
DQphcmUgd2UgdHJ5aW5nIHRvIHNheSBoZXJlPw0KDQpUaGUgY29tbWVudCBsb29rcyBsaWtlIHRo
YXQgd2UgaGFkIDQgZXJyb3JzIGJlZm9yZSB0aGUgZml4IGFuZCB3ZSBoYXZlIDYgZXJyb3JzDQph
ZnRlciB0aGUgZml4LiBJdCBzb3VuZHMgc3RyYW5nZS4gOikNCg0KVGhhbmtzLA0KU2xhdmEuIA0K
DQo+ICArRVJST1I6IGFjY2VzcyB0aW1lIGhhcyBub3QgYmVlbiB1cGRhdGVkIGFmdGVyIGFjY2Vz
c2luZyBmaWxlMg0KPiAgK0VSUk9SOiBhY2Nlc3MgdGltZSBoYXMgY2hhbmdlZCBhZnRlciBtb2Rp
ZnlpbmcgZmlsZTENCj4gICtFUlJPUjogY2hhbmdlIHRpbWUgaGFzIG5vdCBiZWVuIHVwZGF0ZWQg
YWZ0ZXIgY2hhbmdpbmcgZmlsZTENCj4gICtFUlJPUjogYWNjZXNzIHRpbWUgaGFzIG5vdCBiZWVu
IHVwZGF0ZWQgYWZ0ZXIgYWNjZXNzaW5nIGZpbGUzIHNlY29uZCB0aW1lDQo+ICArRVJST1I6IGFj
Y2VzcyB0aW1lIGhhcyBub3QgYmVlbiB1cGRhdGVkIGFmdGVyIGFjY2Vzc2luZyBmaWxlMyB0aGly
ZCB0aW1lDQo+IA0KPiBXaXRoIHRoaXMgcGF0Y2gsIHdlIGRvIG5vdCBhY2NlcHQgY2hhbmdlcyB0
byBhdGltZSB1bmRlciBhbnkgY2lyY3Vtc3RhbmNlcy4NCg==

