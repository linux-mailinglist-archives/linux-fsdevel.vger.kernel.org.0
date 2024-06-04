Return-Path: <linux-fsdevel+bounces-20934-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBF38FAEF4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 11:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038811F2609A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 09:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E29614375D;
	Tue,  4 Jun 2024 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="0hNkSLJV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C89350A93
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493788; cv=fail; b=m5LxpmJG5XiH0fFv6X+YoB5l+q3fZBjr24xGXTJ9BYpmw/4aXAViZIv+bT2q4ypWqXKUeXz47KbF2nv38hmu354cBfwQG5k383OxHLWjqC9Z5zqtQrZY0ihW+rfBH6P/PuriBV6Uv1tDE1eoD9q8oRKFjkp7W04lc93uODHerFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493788; c=relaxed/simple;
	bh=LoKeBuFXTWaryeJuEiMrQ8zqQ/+6zuGdOXB3SPPnn2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P/55gbMiqLtw1VqRS0+yYDHK3TnWRIZr72kut+oXM2Biaiy82mf/grGPu58dh8arCd4PVv07eNlGL+e+xaZGG3JMahnjcEpo1v/ZOBKNzduEAH/8im4qeTTduGgUdtuIesHhEECd7lA25AA/GaVs0U5/z/qfG8jGqYQSqTB2+FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=0hNkSLJV; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169]) by mx-outbound17-103.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 04 Jun 2024 09:36:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a64GtmpIMjIb7jYTxaCJxAMwjOJKaFxZdMDjfU3qKdDa0aGcwI/w098xHWTYofgWv3wBCi2zyUCDrOhPZHbulTewImcJjHRpWDb9+av9ylpH8JGefjXky2nDx4VYxX1HwgnOO8A/ubcb9WExKvxTwM4krogxPHy5Lu9jMEdeYNaC5sOC7BuuBO8wRFZW1FkkIEreebcbjjOqFBt6gheOUmyGet7keHsbas9IlNu87z7pSjIdXcTAeuktunNT9gfoioHrROPRCLl7EU3si1R/DOgs0YFYUKFIe7ldbZ+H1HsV1NEXYr4SqMAundmElMcyir8V/Gsp5OLgw88IJ2eIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoKeBuFXTWaryeJuEiMrQ8zqQ/+6zuGdOXB3SPPnn2s=;
 b=niA2M95NJ39iidXhBjThinlm6i5QllGrYRIenAUokIfGHXY0mtxFlo9xITnEKQeBG5wf/EcRTldygcE0a0fzWrsekSB5TiwqT9vsDNbJoGMNaxLNiVMJCHwEDgbC2+vEz1+oZzAMv4WJEmSDV5xtEj87fiIi7nyQ+YEeO/1ao+PV3z3HatR3MEu6hFQH1sR7tZOqoY4/0k8A17NP/v1TWWgNCr+k13D7PUjzxeB7rBmMDw99wRMWDkdsjrCnaWB9EGvFRxv9IalzyCRg+u0Zl1MV3JCJwqjWTGBbcDUc0wwbUBkmO0SIPoNz/3mP0LrALvc8bHYZ3HGWS1EcEAt8hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoKeBuFXTWaryeJuEiMrQ8zqQ/+6zuGdOXB3SPPnn2s=;
 b=0hNkSLJVdWX1e2mQ5r9owr8eDQvZ1CyktM+QDYB9Av80/3kmnzsP+i1Kx/H8k6AJQ0+e0RaWZYYszhPuAItubb60umqQh/Gu8NmQM//tG7KBn6nxc7m5LZl908V0iG4EXJWLDQonfY3U93cF+YwEjbOILzBDjsRjkwNIodrhXbQ=
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by SJ1PR19MB6281.namprd19.prod.outlook.com (2603:10b6:a03:45c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Tue, 4 Jun
 2024 09:36:09 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 09:36:08 +0000
From: Bernd Schubert <bschubert@ddn.com>
To: Peter Zijlstra <peterz@infradead.org>, Josef Bacik <josef@toxicpanda.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bernd.schubert@fastmail.fm" <bernd.schubert@fastmail.fm>, Ingo Molnar
	<mingo@redhat.com>, Andrei Vagin <avagin@google.com>
Subject: Re: [PATCH RFC v2 15/19] export __wake_on_current_cpu
Thread-Topic: [PATCH RFC v2 15/19] export __wake_on_current_cpu
Thread-Index: AQHasfIu+s8hW+E+1UqKRtyYkUB7HLGwPnyAgAcgNYCAAAKsAA==
Date: Tue, 4 Jun 2024 09:36:08 +0000
Message-ID: <f1989554-35f2-4f42-af98-69521f620143@ddn.com>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-15-d149476b1d65@ddn.com>
 <20240530203729.GG2210558@perftesting>
 <20240604092635.GN26599@noisy.programming.kicks-ass.net>
In-Reply-To: <20240604092635.GN26599@noisy.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR19MB3864:EE_|SJ1PR19MB6281:EE_
x-ms-office365-filtering-correlation-id: 1879ba80-9db8-4b3f-fdce-08dc8479c3b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?QkN0UTNEd0xNRS9HS21oNkFyMmdFQkFSMDVBMkgzQkk3WGVraUVrMHZkSFhS?=
 =?utf-8?B?UzVqS08wVzZ3RnZ0bHV6b0FlaW1DV1VXMmtLaWlRcXVSYkJ5UW5ldms3YlJq?=
 =?utf-8?B?THdFMGNQbDBac2pwSnhMOTNGWjFsMnhXbGtna0pMVVpGNjhtalZjR3UzOVFX?=
 =?utf-8?B?NGxKRnRBekJnWWJiQTk4bUV6bjl2NzBNc0pJMzF0UzNxNERlTnI0YnFzZDMw?=
 =?utf-8?B?a1ZTWTZOWThhNTY1UmdZc09HczZCZFpVT2RNVVExVkFzb1krbndzN3A0b1Za?=
 =?utf-8?B?WHg2OTNWNDRaWUFwUHBOL1I4UGRPMzBETmppVEVXS0ZVQnhvZ3NrWE10SzBP?=
 =?utf-8?B?RzNpSU55RzM4V203NWh6aHo4K3loaVdQZ04yRXVNaEdzOVFSdDhRKzYxMEVW?=
 =?utf-8?B?YzBsME5sbnFqTnZmbkRqVENXUVVBemxNQlNGZVRoTlM1QkFtcnBySE1ubzJr?=
 =?utf-8?B?a0FZbm5sMHJyN0hsQjlUWHRKT09NZERxazFQWmZCa1hrbm00ZjVYSU1xenNu?=
 =?utf-8?B?ZUtDVEw0MHdGZXVXcTNyQTBHMk9jQ1RmU1FySnpCUEFvZDhMTjFkV3lhbktY?=
 =?utf-8?B?SHVWMmVSMW1qQVlVbFpGQyt6aVRpbUl6K3pDZnNvVWZJV1g1bm5Jdk11R0xR?=
 =?utf-8?B?WmdkNnBaSXpQMytKYzZCUStjTkM2UjlXUk1KbzZwR28rcnVjWTdsSDlVajdG?=
 =?utf-8?B?SFJ2SUo1akRNdG5QU2lhMVRxYVhOMTYxQjgzNlVCaFpTL3FmZ2llajBVeHMw?=
 =?utf-8?B?SnovRzI1a29kVUVSTFBnY0Uyd0tHRjMxOWJFRzJVa3l6alpVT2xiV3psbUVB?=
 =?utf-8?B?WFVCOVdCekF1M2M1N2lwMEhTRVlZbExINVV6S3pEcTZSbGNHdWpXTWlWSnkz?=
 =?utf-8?B?NVZMOUxMOEVqSmczTUpnNVhBYks3Ti9BbStFS0FVbzdQSkoyS3g1U0t5VFVE?=
 =?utf-8?B?bkVicnloeHZvNy9zdmZPN2ltNjdIMW1RTFdCYW1BeExrODVWZkpVVHFzMHcy?=
 =?utf-8?B?a2E1TmNtTXU3VnhFRjBmWFpMT1lTT3dLanJmL0hhZ1pZaHNlV0J5cEtNZ25r?=
 =?utf-8?B?ak1sWWdPSi8zaHZHR1hHMExKWXQ5MUVGcU1XaDBoWXNXVWlEU1JPYzdvN2RD?=
 =?utf-8?B?UDBRZExlcWw4Y0h4Q0pqM01PWTdDYng1TEVaR2Z1OFdERlM0WUprdG82eU1o?=
 =?utf-8?B?UGhHSGJNMUpYenJvcUtGVG5kQ2h6RGFGT0wxcC9GQ2dnN1Jzdnd5TTd3Ri9p?=
 =?utf-8?B?R1NaYndndXBXVktIQW0yODZMeExCbS9QZHgxVU52NE83elRUVENzUFZFM0hZ?=
 =?utf-8?B?aTkxWFd5T2RjNWZOTGVDNTdldzlzSjVQcEllOUlkZUVHSjIwWkNodm9OdElt?=
 =?utf-8?B?Ym5oNG8rTitwbHJobStIN0JlSGRSa0IwNGRSVHVzaUt5bFcyQ215MGF3KzBE?=
 =?utf-8?B?S0I3TkFPZGROSUI2OFQ0U1RHME84US9jRGNFcTI3NisrQ3hSMHVzV3NUdklF?=
 =?utf-8?B?czA4T0FZWFRleEpqRVpwNkVmR3E2YllKWExJOUNiUHBCdmdIVENmbHR6NUlL?=
 =?utf-8?B?WnJLWkRqZlZkL1FJWWkzUzN5MTNHbU13VHF3WFhhbUEycUExQW00cmNXdjRP?=
 =?utf-8?B?MUxaU2tOWStpMjVRRnJjK2swcisxOFgzUitJRE03M1lLQ1Myb3A3UHcrR21W?=
 =?utf-8?B?OWhDTDg0bXhVK2srR1FVM29JWGZZZ1BrTUh4S2oxUERMek5Qd3hnWlNZb0xv?=
 =?utf-8?B?RWkxLytuWnhaYkJ6Q2V1ZUpmdlljSVZ4cTl6K0NlYUZGQmNUaE1IUWwrdk5y?=
 =?utf-8?B?dFpKZGd3dFl2RVYzOXdmdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFlmVEhqTUhuOWRwYlhucVNXbXkySytKNHc2eWdDcFhEMXZqN3Q3Y3Z2Z2cv?=
 =?utf-8?B?MnpOMWR0bGNBRVZuYkI3ZitxWmhCRUJVN2tCUHNucGhOMUJ6TklIVWJlNHM0?=
 =?utf-8?B?c2hiRURNUnFSVWQ0RFE1RVN0ZWhjTkFFSUdDYUU4c2lTbzlCYUowQ2NhZWVN?=
 =?utf-8?B?VXZKSUU4V0ZRVVdrTlNOa3k5T2ZCb2wxZHh4WjlTd3VEWGdhNGhHYjFBUmNI?=
 =?utf-8?B?Ump1M1c3VFN4ZDJBVkRlRTgyVHNRYzA2TmVOemEvVlJOZU5xZVZjRWlXcUhO?=
 =?utf-8?B?REk0ejdQMzlHYitnbmNISXdMYWFFUFo5S251Z3hhYVhRZlNqNUY1UjhZazVQ?=
 =?utf-8?B?WjI5ZVN1RExlMThCM0xmaUdxNUxIeng1QWhucHI5bWpDeGZ4eTR5T21saUQ5?=
 =?utf-8?B?bzVXRmx4RzBLVnl2ZUpsOW95b093SUxUQ1VydEswR1paQ2dsM0dQa1JvbHY5?=
 =?utf-8?B?Wkl4cG5lbXBEMXpaMXZ6TmZYdkRZR1pYdFRrZVRraHJnLzlQYlZBRlRYNG9y?=
 =?utf-8?B?TklueE92eVNlckVleHRxa3pPM2NTYVBVZENIOGw4WDlEZ1lJM3JBMkQwUkhS?=
 =?utf-8?B?YTlTTE5raUZBWnc1WS9EUVpqMWp4YWluOGgyUEZJc3NudlJwcTh6c3M1RTND?=
 =?utf-8?B?TEVmc3Boc253aHRXQzhDK2MrQTFldW9GODdyenJSM2R6QnY4Wk5iOUd2UVVQ?=
 =?utf-8?B?cWxFRlFSclBSU3FaeGUvTUQ5ZnhGTUdISWxBVU1VR2UzSEhKRkkvWGREakxL?=
 =?utf-8?B?ZktHcDVKTHI5eEFjTEtoK2ZqTW9DZUE2LzQ1VDB2UmpXdXBmN3lwWEwzc1JK?=
 =?utf-8?B?dC9ITXNsK3JHQzZhaFVnODJQRzhjN0pmM0luRko2b082N05oZE5FZWk5T2k0?=
 =?utf-8?B?WXh4T3l5UjZFSDdWVUNQRWUvMGs2a1d4cXYyM1RhOXJwTlkzKzlvaW1ubTd6?=
 =?utf-8?B?U3dLMlJodnpZRWFVeGx2MGRqYTZMQlBZbWc0MEFRdE8zSmEzcVlicjhLOFpZ?=
 =?utf-8?B?Y0F3clNNZjgwNTRsVEM4UWtNSDdGT0lnd2R1azJQeXdDM1BpcHhOUFROL0Nq?=
 =?utf-8?B?YVVrUm5iTm5sM2FCYnFwbW51QWdKUXl3cCticVpJaWJSbEhxVzYxeTIrL3pB?=
 =?utf-8?B?bVZBc1ZVOEtyZWRkSnBwM2NRWDk2N1E2dDRQc2V6MlFNWjhIVnEya0FYVTNa?=
 =?utf-8?B?NTVTMmk5NmRJdGVPUzdkTjdVZVl2WlJIMVV0cTJidC9VRmlRUmxrZHZkWkJG?=
 =?utf-8?B?dHZ3OVZWVnp3MG02Nnp1L001bGlRemU5c3hyWXFKWTlLZzJxUkExQk04VUhh?=
 =?utf-8?B?aGRkZjQrWldnM3oyeGEzbW9HeGI3TjhRZUlUaEJwQkRWTzd3VnFBNWdGaXNo?=
 =?utf-8?B?MnRPdCttSkxmVk13ZGt0aURMdHp4cFRTMFo0YTJoMm9wQk5FV0xxZ1Q0cVhS?=
 =?utf-8?B?bktzc0pyZVIxRzlhaXViaFkzZ3hiVG5hWWFSMzUyYWNML256SzhDbDZZcWVr?=
 =?utf-8?B?MlArY1NoT25NajZTQ050ZXlLSkVLZnBkbkNlc1IxYnVYOE5rWUNSNEFUWGk3?=
 =?utf-8?B?NWcxd1Q4a0xFL3YyVkRLWk9scjRlZmxMTi9yajlzSE9LNWVQc0tzcFhPVWd5?=
 =?utf-8?B?c29lWFpsTkdNVlRORHhaMnJpNzc0UFk2cmJlbllqcllvTVBvbWhsNXlvZjhP?=
 =?utf-8?B?Vk1wVUs2YW9QTTE5Qm9pcytPUkR0Q3R1SkV5SkZjbmZMMUM2Tlo0dEMwc0Yy?=
 =?utf-8?B?U1F0QTFGTkc0ajMvRWhtcmIyaFhWY2FFMmdOSmlObnpxWEZOQUJFa1E4K01X?=
 =?utf-8?B?SDREdm9IaWFjOHdPQzdrTU11YW1nSFpuZVd5cTdsV2NYTE5nTVlvVnppUVNJ?=
 =?utf-8?B?enYvQnNIeExwVlZLZjk1WnFxZFEvNDMreGJxSnZTaU5FeERPTURJelVjYU80?=
 =?utf-8?B?RXZMMTJ2eEZ4WW5LNVhLM3FOQzFUNkpsUUtHdmcrMVZ0eVkwby9FdUk2anp3?=
 =?utf-8?B?MTZBZTR6WC9WeDVqc09BNmlXc0VOTHhKQW4zSTFqQ2p4TndhRnpsLzVRNHBI?=
 =?utf-8?B?M1BUSjhuSjkxSTk1T2FQSzVGNlZPZlRFNkJDNEMrK0ZmT2dLUlVrRmZxSEN5?=
 =?utf-8?B?VGFQc0hTRWR3eVBZSzlYV1VtdFRxSVJ0QUZJbitlL081d0ZuRHNkbTQ4eHE1?=
 =?utf-8?Q?7jSBC3SJ5GPjeRmczs/CqBU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD895DB1528B704AA27084C52318AA53@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O7xbh4270QuORxYeaFwqBb3/FBNaR8j1U85gTiqwUB66BDWKopdAM4n8eqlGcyxRTrDG5tcsLweOoyuRqmr9eCYieP8CTzaHk5rwO/J5QzuiPO+V55cRGz0B+gz7zmCLXvOdlgda6Nh2fvPnnNsbuNCIs+2MIPvW3EPC2ADLIWpoB3qcWzchO1564NdCizbwYiEcxiaTc+SgPoCmJas/zhTjL52owQMEJ1797uyIX3nE1i++w4Zf0krbh/87bQ0BPV6ynLPEvhw2pIO/J7uHP2HaJWNXaXTPf/lFzuz0Vk06Aw8ngwypnoFi8Yfc5NYYvTwwVzP3kUNKqlqx29QM9ipmyz7J8kSnIpRM72IiUvkQtUfcMbolFxR71l9xn+xVAlEjEjkkCAyKIrln71Jgjfc4XiIAOUMMqDhWKg4Fd+GRC3/ki0fBT6aIB/jldUZjiTL87DovwplMEeL1lRoJjxma0fpfrORv/eoASzO4Cj0dXe8eZqy5hAJ0AmQbCb/+DLxCsNdVl252GetMRCP+SXWhAUJdq6S4mwqeqDQWmCkgPZs6wTSIDFpgPjesTQLE9svl+VRk+i5r+pvo5ZGnKSscldyvWO0l1sXTwSZ7K4FXPmuCJytXvbrBvbykJxzP7hLRwYwGW8Jb4TDbPLMT9A==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1879ba80-9db8-4b3f-fdce-08dc8479c3b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 09:36:08.8905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cFJKVh3E4jGttpp+L3G5+gKUMtutDn9OErYga4/PKLLqPOw48chnbEuLa0ogZl1H3dsK+WUO88MNle/AxK4sxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR19MB6281
X-BESS-ID: 1717493770-104455-14476-64689-1
X-BESS-VER: 2019.1_20240530.1612
X-BESS-Apparent-Source-IP: 104.47.57.169
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYGBqZAVgZQ0MjMPMXMwNjCwt
	TS3CLNNCnR3MAy0TzNxDDJ0NzYwDRFqTYWAHazsDJBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.256716 [from 
	cloudscan10-154.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

T24gNi80LzI0IDExOjI2LCBQZXRlciBaaWpsc3RyYSB3cm90ZToNCj4gT24gVGh1LCBNYXkgMzAs
IDIwMjQgYXQgMDQ6Mzc6MjlQTSAtMDQwMCwgSm9zZWYgQmFjaWsgd3JvdGU6DQo+PiBPbiBXZWQs
IE1heSAyOSwgMjAyNCBhdCAwODowMDo1MFBNICswMjAwLCBCZXJuZCBTY2h1YmVydCB3cm90ZToN
Cj4+PiBUaGlzIGlzIG5lZWRlZCBieSBmdXNlLW92ZXItaW8tdXJpbmcgdG8gd2FrZSB1cCB0aGUg
d2FpdGluZw0KPj4+IGFwcGxpY2F0aW9uIHRocmVhZCBvbiB0aGUgY29yZSBpdCB3YXMgc3VibWl0
dGVkIGZyb20uDQo+Pj4gQXZvaWRpbmcgY29yZSBzd2l0Y2hpbmcgaXMgYWN0dWFsbHkgYSBtYWpv
ciBmYWN0b3IgZm9yDQo+Pj4gZnVzZSBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudHMgb2YgZnVzZS1v
dmVyLWlvLXVyaW5nLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogQmVybmQgU2NodWJlcnQgPGJz
Y2h1YmVydEBkZG4uY29tPg0KPj4+IENjOiBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT4N
Cj4+PiBDYzogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPg0KPj4+IENjOiBB
bmRyZWkgVmFnaW4gPGF2YWdpbkBnb29nbGUuY29tPg0KPj4NCj4+IFJldmlld2VkLWJ5OiBKb3Nl
ZiBCYWNpayA8am9zZWZAdG94aWNwYW5kYS5jb20+DQo+Pg0KPj4gUHJvYmFibHkgYmVzdCB0byBz
dWJtaXQgdGhpcyBhcyBhIG9uZS1vZmYgc28gdGhlIHNjaGVkIGd1eXMgY2FuIHRha2UgaXQgYW5k
IGl0J3MNCj4+IG5vdCBpbiB0aGUgbWlkZGxlIG9mIGEgZnVzZSBwYXRjaHNldCB0aGV5IG1heSBi
ZSBpZ25vcmluZy4gIFRoYW5rcywNCj4gDQo+IE9uIGl0cyBvd24gaXRzIGdvaW5nIHRvIG5vdCBi
ZSBhcHBsaWVkLiBOZXZlciBtZXJnZSBhbiBFWFBPUlQgd2l0aG91dCBhDQo+IHVzZXIuDQo+IA0K
PiBBcyBpcywgSSBkb24ndCBoYXZlIGVub3VnaCBvZiB0aGUgc2VyaWVzIHRvIGV2ZW4gc2VlIHRo
ZSB1c2VyLCBzbyB5ZWFoLA0KPiBub3QgaGFwcHkgOi8NCj4gDQo+IEFuZCBhcyBoY2ggc2FpZCwg
dGhpcyB2ZXJ5IG11Y2ggbmVlZHMgdG8gYmUgYSBHUEwgZXhwb3J0Lg0KDQpTb3JyeSwgYWNjaWRl
bnRhbGx5IGRvbmUgd2l0aG91dCB0aGUgX0dQTC4gV2hhdCBpcyB0aGUgcmlnaHQgd2F5IHRvIGdl
dCB0aGlzIG1lcmdlZD8gDQpGaXJzdCBtZXJnZSB0aGUgZW50aXJlIGZ1c2UtaW8tdXJpbmcgc2Vy
aWVzIGFuZCB0aGVuIGFkZCBvbiB0aGlzPyBJIGFscmVhZHkgaGF2ZSB0aGVzZSANCm9wdGltaXph
dGlvbiBwYXRjaGVzIGF0IHRoZSBlbmQgb2YgdGhlIHNlcmllcy4uLiBUaGUgdXNlciBmb3IgdGhp
cyBpcyBpbiB0aGUgbmV4dCBwYXRjaA0KDQpbUEFUQ0ggUkZDIHYyIDE2LzE5XSBmdXNlOiB7dXJp
bmd9IFdha2UgcmVxdWVzdHMgb24gdGhlIHRoZSBjdXJyZW50IGNwdQ0KDQpkaWZmIC0tZ2l0IGEv
ZnMvZnVzZS9kZXYuYyBiL2ZzL2Z1c2UvZGV2LmMNCmluZGV4IGM3ZmQzODQ5YTEwNS4uODUxYzVm
YTk5OTQ2IDEwMDY0NA0KLS0tIGEvZnMvZnVzZS9kZXYuYw0KKysrIGIvZnMvZnVzZS9kZXYuYw0K
QEAgLTMzMyw3ICszMzMsMTAgQEAgdm9pZCBmdXNlX3JlcXVlc3RfZW5kKHN0cnVjdCBmdXNlX3Jl
cSAqcmVxKQ0KICAgICAgICAgICAgICAgIHNwaW5fdW5sb2NrKCZmYy0+YmdfbG9jayk7DQogICAg
ICAgIH0gZWxzZSB7DQogICAgICAgICAgICAgICAgLyogV2FrZSB1cCB3YWl0ZXIgc2xlZXBpbmcg
aW4gcmVxdWVzdF93YWl0X2Fuc3dlcigpICovDQotICAgICAgICAgICAgICAgd2FrZV91cCgmcmVx
LT53YWl0cSk7DQorICAgICAgICAgICAgICAgaWYgKGZ1c2VfcGVyX2NvcmVfcXVldWUoZmMpKQ0K
KyAgICAgICAgICAgICAgICAgICAgICAgX193YWtlX3VwX29uX2N1cnJlbnRfY3B1KCZyZXEtPndh
aXRxLCBUQVNLX05PUk1BTCwgTlVMTCk7DQorICAgICAgICAgICAgICAgZWxzZQ0KKyAgICAgICAg
ICAgICAgICAgICAgICAgd2FrZV91cCgmcmVxLT53YWl0cSk7DQogICAgICAgIH0NCg0KICAgICAg
ICBpZiAodGVzdF9iaXQoRlJfQVNZTkMsICZyZXEtPmZsYWdzKSkNCg0KDQoNCg0KVGhhbmssDQpC
ZXJuZA0KDQo=

