Return-Path: <linux-fsdevel+bounces-20060-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8BE8CD605
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 16:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C532D2820B2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 14:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A09014B957;
	Thu, 23 May 2024 14:41:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2127.outbound.protection.outlook.com [40.107.102.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0BC13E032;
	Thu, 23 May 2024 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475311; cv=fail; b=PQQKvhjZZwie1jZb9gfe+RAYXyPDG7st4vTNT5D04yxSc/fDwr26DNMGsyArIfZ9+YthVD8XRWpno5aaSOJaPZN03/eGyRjSXxzvzvOijHcfSKZn8M6p/dAFcKGsWYuW34Tiy9UkJkbPuUA+DN4GdkIbBw23dIAAyUKgoMpykEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475311; c=relaxed/simple;
	bh=Oj7kN41vjPfc4JdsoH/ALbY0yL58cpk8841ZQzZqKY0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sOmSaLwRzKjfAGXtFut949XAtMhlmVfVtbU/2OT2ir8fVKTrkdSIIcVytHmn86x3titSkgWNFrO2wK5E2dHy+HAQPg0waryTZtbuo4LyjzTjKRg1V6oWn66zWnClpnsKiU/NVs/cngWT7lK7oR/qp38Y/I01rYyXWZ+nFg6r2FY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com; spf=pass smtp.mailfrom=talpey.com; arc=fail smtp.client-ip=40.107.102.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=talpey.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=talpey.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRfkDPhl9zoYz1YahOoJ7x0GkiFx+rLIuAGdiwanGHVtkRzXakYQrBVonYo2xaY37ZRgsnRSzVTY+xhI+Rwn+pnjR4fIBSQ845WtNKfPud5/+U7PxSCnoyo5TFsXTTgIGh4UFvZZf/vJR3RoZJ/N/ugQWej43Ar6VmuKK4Vwe1Q0nYDc6u0zwPqxT1rqm+7Spg2tn8dVOy4AzWnAufiTFFHAgXGNRuL9UL+y5MCcx0itqNkWDdOtpql0dG5m4QiH1+q/pXLuJQ9+hl78EJkLEaADf8nXO0wk5FZs/Aqc61oih3WP0qmWfMNJ7TMxCihu99kghRYKwaVE3vjGpPagLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfRBmtNwix1Hpx40bKuOsdHs8UfMJjXzZxejIhQ4Di0=;
 b=S5bO6UV8IHFSXHbpIWbQP/HXhsTG6QHDo61a00fEDsFoexDfnaEGrZCf7qZd9UfNXPb3e1oX/oKF33LqS0eubATbYZJbq1UYEOZArvE87xrsrFxdx/0yGX+748qF1JKUupc8k5XBQifnZCOCYbtQ24ukQZGa1NSy0YfEJ367kQmiUtrANEj3TQIQKf0NgViFnJLuF/ZgyUvW6X5GszcOHHV8IGQ/KEEoWeh6gg678sSe44G4RV6fk+v40PCg3CHYK3/vT5KcD2dqvMJnwhPQRY/8ewvyUvx+8kavcV5FQyV0j0RXdKMdcjYS4h8FuzixgvPSnNoAxmWLHE6glHstmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from CH0PR01MB7170.prod.exchangelabs.com (2603:10b6:610:f8::12) by
 PH7PR01MB8514.prod.exchangelabs.com (2603:10b6:510:2e6::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7611.22; Thu, 23 May 2024 14:41:45 +0000
Received: from CH0PR01MB7170.prod.exchangelabs.com
 ([fe80::97c:561d:465f:8511]) by CH0PR01MB7170.prod.exchangelabs.com
 ([fe80::97c:561d:465f:8511%4]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 14:41:45 +0000
Message-ID: <536b0f03-db96-49a3-93de-d9ea835e8785@talpey.com>
Date: Thu, 23 May 2024 10:41:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cifs: Fix credit handling in cifs_io_subrequest
 cleanup
To: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>,
 Paulo Alcantara <pc@manguebit.com>
Cc: Shyam Prasad N <nspmangalore@gmail.com>,
 Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton
 <jlayton@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <469451.1716418742@warthog.procyon.org.uk>
Content-Language: en-US
From: Tom Talpey <tom@talpey.com>
In-Reply-To: <469451.1716418742@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0128.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::13) To CH0PR01MB7170.prod.exchangelabs.com
 (2603:10b6:610:f8::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB7170:EE_|PH7PR01MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: f4373abb-58c0-42bd-45ea-08dc7b3677d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGxSSlBxdjR3aGxPa1QzTjVwOTA5RWptZEhxSEN1K1FmbnoxS1pELy9DUnBq?=
 =?utf-8?B?Z1B3bGtJY1hncUsxMHBoejJqeDJhZytMUFBhemttRkd3aXdmYU1mSmpnUWxR?=
 =?utf-8?B?RDArUHlnV2VvRWIvYjFhb2MvdDZjNjA0c0lYd01sSVpkaEVRdTdndGN1aWJo?=
 =?utf-8?B?UnE5UVkxVGZ1cVNuVGttYmlrbGo1NXhhamJPdDQzSGJBSGt2Z29ZY2laZFl5?=
 =?utf-8?B?NzgxNHZnbzdxcnQ5KzF3bnc1NmNiUWQzUWdKVUpzZUJnc016OFJhTi8xdUFB?=
 =?utf-8?B?TlN2OHBiSWhPaWxYM29zNEh1b1BBY1FKMGgwZlVYYWdzaCsvcHhyZ3c0a0h2?=
 =?utf-8?B?aHptY3JHUGNzenlRbTcvZ0owbVRWUi9XRCtGeFdhYnhXRzY3UnJ4VWt6YjV1?=
 =?utf-8?B?SlRUcFhsYTRZanZpNEhpanJFcTBVaHhISk1LT1gwRmFPSlpNWHVlZW1sSEpr?=
 =?utf-8?B?ZGtCeExZR2J0WlowTE1EVi9TWTg2K3lBMjFWbCtOODNQK3VlWUpOZzZCSGNM?=
 =?utf-8?B?MTlqQjN2KzJuNjR3dEtaZyt4eDNsY3MwRzkzZWhxQVFZaEN2RCtoRUU0M2lT?=
 =?utf-8?B?WVhjbUtVMzc5cFV5VGRROGJLUXFpNTVVMytmb1A1SGJPNitrYXZEZzBTNmJl?=
 =?utf-8?B?dDJGVElBdFFCNUp6aXdOMDdTTEdGbSthRkhybzJaZ3o2N0RJNXBHMU1haWds?=
 =?utf-8?B?WExPakRPSVpRU3d3eW1DY0xCKzh3QklEUzFHU0xKUndxUUQyMTcxNW81OW15?=
 =?utf-8?B?WWdadlJIU0dCVjJzWDltVFB1MWJRa0hJN1RlYTk1TGcrcC9PbUliUUFsbWlW?=
 =?utf-8?B?SWsvc3BWN0JSNW9CSEpKZzJ4TG15MHdmWlN5cE1MSjlFYlRCblVNS1FqQlZF?=
 =?utf-8?B?dlQwS3ZzbWNUdWNHdm9yaVoxQ0JEWGtuWjY4ZnhhbzI3aktWNThwSXMxM0dB?=
 =?utf-8?B?Ujlaa1hiMzY2NTdwcitTZ081SUF6UFZ0TmtMcmM2cTVvWjFJajI3SVJGRG1w?=
 =?utf-8?B?aFdoY21DcXZFbjZSbjd1VzVPa0ZqT0ExcitnNHdGeXZMMzkwL2F3d0xOR0Na?=
 =?utf-8?B?OTc4dEFteVcwNnlMdzB4VG9nTWZFeGMvQVIxUytqYzBQdUF5SzZXdDhpeDNG?=
 =?utf-8?B?d3huajdLWUpVRVJabEJ3ZFBtR3hHNnBPVE9raFEyWFA5dGdYQ0VrTFA1bXRB?=
 =?utf-8?B?aWFIOU9yWHRoUzlDUFlWRTVVeUdscTNyMzNhWWQ5V1BVU1RUUVBEaUN1Zmx6?=
 =?utf-8?B?ek8zdXgza05EcUVwNmNidDRvazNlTlFDWWduV1VNRFFnNjRYZHEzNURDY0dX?=
 =?utf-8?B?REw4dkIzWVgzQWxzNk00T0kvZUszWitxWWdJSlN5SlhQQjVDTHNFRlNWK1FG?=
 =?utf-8?B?R2dGZytqalRMSWM1L29nNXZzSDNhajQ2cTNWYkowdisvTTYzOVhNOTREQXNa?=
 =?utf-8?B?WHI0d0d2YUJmc0ZCTlRVK3YyS3ZNUjVDakxrUUNGVDJiazY4SzJLRVF0STM1?=
 =?utf-8?B?a0Y4eitUcGlwZThHRlZGS1praGl6ZEYrdWJCT1JxYnJFcDhwa1NjY3pDeVV1?=
 =?utf-8?B?T2ZvamQrTHE1bTFZZ0RUSEhwR3BXb1RyUFJLZUpyVHIvMmdoMG5PWEUrekFt?=
 =?utf-8?B?T1FYTjlFSkFQS2hFRHlKa1NQSkZETVQ4OGtpak9La0o5S0FlOHZnN25GL0NG?=
 =?utf-8?B?Q1BiRnlLRXZpQXZWR3daVG9PZXNqUkR6V1VZN0hRRHhGMUVkTnFGb0lRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7170.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmZlSVh2aTJWNCsybzVhb1BVY0kwYllqWDZZV2lHblNKN0ZzUCsrZVdvZ2NT?=
 =?utf-8?B?RzlQS0YxQlFoVUhaZndDWUJGQzNsZlFtYTkvSENtbjl4WE93OHkzT2FJSDMy?=
 =?utf-8?B?cGdkR25GV2crWi9uUlNpNkhlRk9kdHZDejVvTFVEUGx4cUI1Yno2N1FwS0lV?=
 =?utf-8?B?MkgraDNJS2tRQmljWCtXZFYzU0xZM3BkSjVTc3gvaG94VzVjVjFUWFdidEtv?=
 =?utf-8?B?K25UWXBuVEJhOTFxMjRPajVJdHhWWFEwV0pGV1R5Y0k3cS9paTl1cUxINXox?=
 =?utf-8?B?WlZCSkRTSzA1VHMwbTlHZ2h1NWg1UkdCTGdnNjZHN3hwK0dET1RPL0xzeTAv?=
 =?utf-8?B?RURRSEUybWNDZVlEVHh0MThRNjhEZmgvRmxpaXpVdXZXdUo1NlB6Rlp0ZmI5?=
 =?utf-8?B?dnZWWGd1SlVISlBTMklhQ2hYWnlDVm9DVWtWOXVDcFZyQ3FyUVhGTU1BdHk5?=
 =?utf-8?B?aTJHWXBNRWxpRW1vZTR1U09BSXZLY3FZNFFHM3ZwVWtINjROWGZ1TEk5NHFZ?=
 =?utf-8?B?S0ZPREx2UzNrblFjVVVVRGI1SHNldG5qd0lIcHIxYU5jamRaR2NCZUVQeWJx?=
 =?utf-8?B?b245Qnlpc1pUVHYzWSsweHFlbzMyeVltaSszZTVCYjd3ZFlxNGdCdmNoTU5P?=
 =?utf-8?B?djM5SWNLV3dEYk1Jejd2SktxVThXZ2xyMktkK01WQktkeU82bDh3MkhXRVNh?=
 =?utf-8?B?cFBycVJhVExDbnZtME1PQTFjT1d3QmZRRjJ0R2ZuYWJCVklFS1Vyc2J3VVNv?=
 =?utf-8?B?RU9Xa1pDcGVGK2pIRnEzTjJKTFhSMWV1VmY1cHFGUXhLbUl0R3V1dVlOZUg4?=
 =?utf-8?B?Qms3bDJpdUVLeDJNWncyY0JwQWtIZlRxOFBhUWt0TkdVMGVpT3ltVVFHdDAr?=
 =?utf-8?B?TVQ2aWZqNWhHSktEZzBQVEtXenRHUjBiRDN3L1JYQmhENWVmWjZqeTV2Tmp5?=
 =?utf-8?B?SHJLTmlmQXM3K240a3VWOWUxQ0hSTzFPbTBMWHJYTXU4dWNsTnp0R2F4czBF?=
 =?utf-8?B?MCtEWmgrRGdVbStUTTRDZUsrclJzOFQySTJSRUtadU5Kd0pjRmJHNTBheVRH?=
 =?utf-8?B?MzIzZWVtUlo1RmpwcnRHZVFnZEw4ZzBoMzR4Q01Ed1RGQ2ozYVd5bjNGenZE?=
 =?utf-8?B?d1BYK2JjYmpTQ0tJd0FXSFJVU0tsUkpkVE5FcDdPdWt1Y2doRHE3R2lMc1h4?=
 =?utf-8?B?c21xSExLM2p3N24yaXkxU0c4WFFIZWIzd1phaUtBemR2eXdYajl2bk5na1k5?=
 =?utf-8?B?d3k1UXN5T01yZDJDQk42YkF1M1NSajVJZ29vNHA5WEVvVlZxSzc1eStmQkJH?=
 =?utf-8?B?TzRWSW5mb1B4dkpScFU3NHp4by83VThSMlN4Smg5Q2ZhV0xja1MyV1JSZGUw?=
 =?utf-8?B?L29pUXNOS292VDhzYXd2N1REcUkyZXkwQTUrc0RhZUYvakQ2K2pXMmJxWG1H?=
 =?utf-8?B?QzdhNU1YVW9DazJOakNtRFJGazBDLzdsVmFSQ0JuQ2ttTndOcWgrVUlyNU1p?=
 =?utf-8?B?Rll3bUUzQlRxNjFIcmRBU2U0Zk8ySTc3aU5lb01paFMvcUQxb3MxQ2R0N3Jx?=
 =?utf-8?B?WkkrVkFMSWRud21QMU41ekFXSUgzdXJpQkhvcnhjYjZNaEdxWXRmd1dpV0px?=
 =?utf-8?B?Vkw0NVVYSDVuaXdKMXBxeTFocW5uZVZUY3pEbGc5aXc3UlFVWnFqOFlIOWtF?=
 =?utf-8?B?bHJ1Q1B6SklmR1dGQ3RMZkxqWnJ4NlFnR1hNdXlpRUZCV205SmFZSDl2cCto?=
 =?utf-8?B?U1QxZ0FmdzBlVklGWStvM1pWMkp6UXBJUTlITGVicHp3ZFdCRWM5ckN2RGty?=
 =?utf-8?B?cmkwNWJlREJCelllODJHQ00xa0VuMzlsOWV3L09aWjdFazVMS3pzVS95cEwz?=
 =?utf-8?B?dStXbnQydWxnN3JqL04zOUc1cmR2M3NDMkl4YzloUFM3WEoxcURJN1BCeVQw?=
 =?utf-8?B?bzRpQlEzQzdVZUl0ak11Sytsa3JJZGxvM3ZQVlFmdGNheDlTNUQ4U3NFWnFx?=
 =?utf-8?B?SVczL3lIdzRBZ1lqcjRweTZFMTZuOVoxbzBUK0dHdHF6eXdIaVRONjB1Y2Q1?=
 =?utf-8?B?Y2xhMnR2QkFGY2JaL0t3VTlNMXVCWlY0V0wyQ2xlTkZTUHpZRThEQ2x1MUlR?=
 =?utf-8?Q?tUVusMPLUwDG0x2MeJYU3iXeQ?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4373abb-58c0-42bd-45ea-08dc7b3677d1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7170.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 14:41:44.9479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xSh0BfbURbR4YfN8Uu0AqWYv2tJeWWmI0Off2LbhceLgXi1X21F7H6AYvgfHchKs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8514

On 5/22/2024 6:59 PM, David Howells wrote:
>      
> When a cifs_io_subrequest (wrapping a netfs_io_subrequest) is cleaned up in
> cifs_free_subrequest(), it releases any credits that are left in
> rdata->credits.  However, this is a problem because smb2_writev_callback()
> calls add_credits() to add the new credits from the response header
> CreditRequest to the available pool.
> 
> This can cause a warning to be emitted in smb2_add_credits() as
> server->in_flight gets doubly decremented and a later operation sees it
> having prematurely reached 0.
> 
> Fix this by clearing the credit count after actually issuing the request on
> the assumption that we've given the credits back to the server (it will
> give us new credits in the reply).

 From a protocol standpoint it's correct to reserve the credits while the
operation is in flight. But from a code standpoint it seems risky to
stop accounting for them. What if the operation is canceled, or times
out?

I'd quibble with the assertion that the server will "give us new credits
in the response". The number of granted credits is always the server's
decision, not guaranteed by the protocol (except for certain edge
conditions).

I guess I'd suggest a deeper review by someone familiar with the
mechanics of fs/smb/client credit accounting. It might be ok!

Tom.

> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>   fs/smb/client/file.c |    7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index 9d5c2440abfc..73e2765c4d2f 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -110,6 +110,7 @@ static void cifs_issue_write(struct netfs_io_subrequest *subreq)
>   		goto fail;
>   
>   	wdata->server->ops->async_writev(wdata);
> +	wdata->credits.value = 0;
>   out:
>   	return;
>   
> @@ -205,10 +206,12 @@ static void cifs_req_issue_read(struct netfs_io_subrequest *subreq)
>   
>   	rc = adjust_credits(rdata->server, &rdata->credits, rdata->subreq.len);
>   	if (!rc) {
> -		if (rdata->req->cfile->invalidHandle)
> +		if (rdata->req->cfile->invalidHandle) {
>   			rc = -EAGAIN;
> -		else
> +		} else {
>   			rc = rdata->server->ops->async_readv(rdata);
> +			rdata->credits.value = 0;
> +		}
>   	}
>   
>   out:
> 
> 
> 

