Return-Path: <linux-fsdevel+bounces-48602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979F1AB14D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A8B1C477A8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C33D293442;
	Fri,  9 May 2025 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q8j5lcN5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2083.outbound.protection.outlook.com [40.107.102.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005A5292908;
	Fri,  9 May 2025 13:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746796465; cv=fail; b=pLLp6PJ+nvx0YhtLCyjjwSTOwEEeihYabf7+qMsCbwvj2ldFgqm0o1uLBOb73nPG6Rp6rEhE7gsr+9n2uSEehjRubwgkec5PWQnLNNTPHMV8g5Kelt2cVs5Gt3TSdEAz8UYE6LasvpV+Lxq7hyY+pJSrx3Ka6GWhMa/HWLltR5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746796465; c=relaxed/simple;
	bh=nxm42HnMd/COW5ZdphSZvsKM3XIz3AD+yxhD/8FGN9w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eL+E4iMhmYzPQPYJfqtRolKM1sdIw5NtqPfObKrXSzKTz9kcTqSJHLPfJgJAFAwsu7751LLHbL9hJOtNGkn2ws6GXOn1hYZ1eswPCZPzAQde74tqzPPv8SmHtsqGu7F0Njw8ZZzbmtSW+ouIrVFtANsjCjWBb4FGw7cXxbh3Aco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q8j5lcN5; arc=fail smtp.client-ip=40.107.102.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITyZB0Pom6uGVxqym70euGulzoWPcvE4yCykSxfl7SsMgGlI14QX21pV4Dl2v425O3L5rQegXcW7u9B7f3qNIZXrWLvAaRCTTVaTAkmjp4wOmxI82POc879Mx0X6VoIR3CK8AGd26GHtKlCsJ0YLPlALXceOlhMBmQcU5o9DmUenSXZoOKyKEk21VFdLl1Z/81m14CLVYP/UC34Xgji9nAwm0qhep7IhstnpIDMu5JUzpC9M8h3oT54LDjo9fKjZbT+a2ixlhsu0rVbxNpPnYeaytiZE36di0KIEy4e/nVEGlyGd37GaZqMm0h6UYhU7BV3S9o8tmfQdvP7gmm8L0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dqzi8EJce2EXB9YnvstO2aG4VKkZmzfJMc/DY4sCsVQ=;
 b=yvooheFOppXwtGwxYIPIXcwvOMMOdniY9ObJ6XAeiTzHlYXkESi6woQqmJTfLbOPyZ3pPF8iaKy2R64R/TTrvq6Xy9w5XuMxx8Ke0ljYxtRvwcv9odPH3w8PKk9pVihdT72Hc+xlbBlYwVDHCZfcKsdqOHsltOCyI37msJijtBJpUHSSom9dwwgkvLCoGXACJv/fObyiGE1ns57gHVyyRGiHZn7MpwupxtGd6mArkkMOZhs1zvl3yquwXsAesOpb+6p0gI8rY3CoSeoLU+agMXc4wu0iP8FtwDsZ3vzq8SM8Iyw0VBUlfLVnH+hT1NCRSvoxR8x1W9pBwReGXqWPPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dqzi8EJce2EXB9YnvstO2aG4VKkZmzfJMc/DY4sCsVQ=;
 b=q8j5lcN5Xu871aqfSzVTSROY1AKnNVZvSgdipkldRwQpb5tXj4CBvd/LqGzqjacBabV/HWnlKmGshC+V+uxkLMK8PRhZF6rQWiKAx9BhicEmFrkWX5Solydr2DO7c7h1IMWTUjHaVuOHQZpLsnbkRu4QUbLXpTx9N/BRv/sZ/p987rophV98Ehukz57ZBkwovfTvXSHMW+c5T9k/BQM1q2InfllWjzxetlcp6JghtQfIKz2jFHpFxClvMw+emFUDVQnLaMK/Gu0sncDu7yaDaN9WPP8wW2l4oDXdnI5b8sOmxFqRg1oXWnCaVX+hrcGyEmfsRsF+K5hIylf+yUwWUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by SA3PR12MB8764.namprd12.prod.outlook.com (2603:10b6:806:317::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 9 May
 2025 13:14:20 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.8699.035; Fri, 9 May 2025
 13:14:20 +0000
Message-ID: <e5bc1b9c-2a57-4cf5-8c00-9e2abd67a4b6@nvidia.com>
Date: Fri, 9 May 2025 09:14:13 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] rcu: Move rcu_stall related sysctls into
 rcu/tree_stall.h
To: Joel Granados <joel.granados@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Waiman Long <longman@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org,
 linux-parisc@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-3-d0ad83f5f4c3@kernel.org>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <20250509-jag-mv_ctltables_iter2-v1-3-d0ad83f5f4c3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0015.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::28) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|SA3PR12MB8764:EE_
X-MS-Office365-Filtering-Correlation-Id: e6f9316a-c417-420e-eda3-08dd8efb6899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2pNWnp3ZmRZRjBZTlZUNWh6UlBuSnhuekdSSEtYRTZqV1BXbHJIUmJ4QjlC?=
 =?utf-8?B?OWNTbVBvdWFPc3l4STgzSkJFTW5pTTRHWEJLNlFlY3JwTEM5L0h3QnF4VmNK?=
 =?utf-8?B?N2cvODhucHc5cTRrQjJ0dFhTSjE2djh2akZJaldYM05kN2pQRVIybWhtM1cr?=
 =?utf-8?B?V3NkNzRRQWdUZitBa1ZEdEFrU0s5SUVtMkdscVdYQmtrcVd4RTM4ZE80aUxq?=
 =?utf-8?B?VHFpVDNtanYxQ2MzUFVVaHM4WmFUVm9XLzBJZ3J2czZvSUk3QTJsTHhibkQ5?=
 =?utf-8?B?MXp3YzhBQm1jdEdHeTJIUlkwRXNmN2hRRXNBbUhhNHdQZVJTdWVQMzhHOXkr?=
 =?utf-8?B?Z2lJdW5wYm5MYXJtQVlNbFRXcjJTVXNKVHRINXY0MlcwRFpGSDlsZzBQTHdD?=
 =?utf-8?B?c25neGN6cURaSHNmeTl6YVgycSs0aElxcTRpRDFIYXhZSW00Qk5rQXVFZG11?=
 =?utf-8?B?OC9YT0Q4K0RkTnUzVVlGUjRhTHJPbUhEMzFSb00zeGo1MFgzZFFiaVNCcGwv?=
 =?utf-8?B?QUdZTFJCSkhlNW90eWd0WEQwVHBjbnlHNHlRSHhZUWhMRzd5cytSZk53Rk1k?=
 =?utf-8?B?Yk9Bd3dlczFkYmQ4UWNDUWRkNnVNSXdubnQxa0NxQStzeW1LTUlOaFNGU0Jk?=
 =?utf-8?B?bGxudDRvWnJUa3FmaFpSZ08wWXpHMFNHdGM5UEJiL3RZK0pLd2dqNEtBemRQ?=
 =?utf-8?B?dklXWVI1Q3poVWdDbmNxRjZyWWg5amdzSGJqSGZXMkNpcG1jZjJHTEhhdXFX?=
 =?utf-8?B?N3dqN25BZDZHRXR2ay9zTjk3SzMvS1QxT01CdmtvVEU5S3FWZVROU2FUNU9Q?=
 =?utf-8?B?V1dwWlZNOG1vK0RDb0tySUhocytXQkF0RDVCSDBTazlIM09YQ3FvWWpIcWdY?=
 =?utf-8?B?WW9OM0FvbVp6c0RJWG10OUF1U2ZCeXg2Qk5wRUFKSy9EVUxCcHBoTmZIZy9Z?=
 =?utf-8?B?NzdwVkJncGtIMUVsS3RLZkN0dytXdVRsbjZXMzNlWk5RYzk0VnorRDVqRHV6?=
 =?utf-8?B?RjN4d2dqMWNrbTREeHBkaW1NT2lTWG5TYnBpTkwrblBXVXNkVkdWVmxPOWl1?=
 =?utf-8?B?VWZvVHV4M0ovRURFQll5SGNDSkRPcm1UMHoyM2c4MUlkSjYxaGIrTFp6bE1S?=
 =?utf-8?B?Ukoxc0dlem9vcEkxUTlLU1R4bk5TdGtKTEpBK3MwL1FDOUY2RTN6MHlkWDFI?=
 =?utf-8?B?YTFJSlN0em50dFQ1UHBGMVJhMWR3OWNMcWdlZEhwMXErTndUVlZsWVdlSGFO?=
 =?utf-8?B?cDhXa2ZGUEQyb3c2V3AyUCtpc1FOS0dONlJTOEtWdnNIVXBscTFPY0FoT3c5?=
 =?utf-8?B?NHN1ZFozM0dUd1hFbFBoLytPaFF1QWlsdlBMam1kMmd0b0tzOXVvcm9rQWM5?=
 =?utf-8?B?WCtWNjZrYXUvd293UzNJZDJRVHJhcHNLT1BBdmRkZGxMNXVXV2gvMmFzaVJX?=
 =?utf-8?B?OVpLMVhkRy9nMXNQeUFCaVd5bFdXRUs5ZmVhUXNtNTBnN3RRZkgvMk05eE5M?=
 =?utf-8?B?VmRPK25nN2hrYk9zVlJtaW5JMCtoRFFHdnVBZmozajE0UExpSmRSSXBRcXZt?=
 =?utf-8?B?Nzg3N0RIV3N0SlNWTDJhR1BEZEFUaUM5R3dJK1ZKYW1VL3NPU25MRWY5YjdU?=
 =?utf-8?B?bHhvc1FXZE4xOW9KZGFvcEROYXdFaEozdExvQ3YxYUZabUxJeHByZ3Mzc3Bs?=
 =?utf-8?B?L1N2bXE3SFBiSlUyQ2YrbkQ4NkJ4N09mNWhzQUFuRkl6aTZsQ1lQRjkxYXhC?=
 =?utf-8?B?cTZSSE80THBFaXRQWnU5T0dmZ1JpUEFSeVdCRFhLRUJYZDZQbUlCaXFOa3RK?=
 =?utf-8?B?VXE2dUEzMlRtTkxaWTdOcUE5czd3cHlMcjFQOEhhUXd0WDdFYXVyZDBTUDlH?=
 =?utf-8?B?NTdFVjNRNS9tOGtIYUFibU4xdzNRSmVNc3B0cFFNWHBQV0J3TEhqK29OT1o5?=
 =?utf-8?B?ZitNdG0vaDZEYm5GZHlJNkoyQTByREJLZkFJUkxteExwcEZWS2pmTnhNYUt0?=
 =?utf-8?B?OXF1aFprUG93PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlFSalo0cmFFZFRGTzA0cDdFWm96SmdZb3NPc0tzREpsaU44UkdIdDV4dm90?=
 =?utf-8?B?VzBscjFuNmVFRlBZbktFM1NMNUxPdmNuRmtyQ3d2MzhUamZmWmVqYnBBQlI1?=
 =?utf-8?B?b1hvaENTVkpTck02MFdWWlMwNVFEZ0lZcFh5c20xY1dBL0dFYzRwVWh5a3pu?=
 =?utf-8?B?M3NHUEw3UFhUWEVEeTBXbFZSMnNsR1cvNXNsMk50MjlGY1Yxd0JNc0pMUGUw?=
 =?utf-8?B?dFd3bURzVEErOFYxeUcwdXZvZjNEcEtCQW9xb1gvc0ZyeU1md3ZIdC9VOTBL?=
 =?utf-8?B?VjU4c1NaRmRzclB2bGp2NVZ6d25EU0h4SHlVMEQ3eUNHb3B4T3ZLMTNhYms3?=
 =?utf-8?B?aXVZRTBFeUh0QWNRUUthZ09WZWY1cER5TENNRDJFTVNkVWQ3bW5UeWtyV2lK?=
 =?utf-8?B?dlN3TzNaVWVNcDVUNHBtd3BrcmFhcGtXOUNjd2lrSTRnVHFhSmdwK24ydFNH?=
 =?utf-8?B?KzMrWFJTR0VQUThJVmlhTlJ4ZVNESTdzMDVNZmtmMDVvb1hMMmdYTkgxL1NL?=
 =?utf-8?B?eE05K0tIYU1kMSt3RzlBK2xHRHN6MG8xUFV4aGtqMVZDS3ErcTg5REc4Szd1?=
 =?utf-8?B?M2NTZ1d5bDd2V2tSdE1xVnJZU0p0eXl0NW53aGlrZTgwVEJUQzkxQnRnaE5k?=
 =?utf-8?B?TEFDVDVpcXA0ZVBwQWIxeTUwZzZwUlczdmZ1MCsyalBOTG56WlZtOW9oa2or?=
 =?utf-8?B?MW5EbzdLUXhMZGZMa25iNnZLS0x4Q3J5N29XQmJJNlNWUGhIM1d1VW5CNzhQ?=
 =?utf-8?B?b0hxMHgxeXFWYVcrR011aDJlZmJEWWQvVWRIZ0RPUm9MWDFqZ1lwdE5KRUZq?=
 =?utf-8?B?QXkwMVdaR1lDdlRwbVZuYzVMWXpZdGdJUGgvUmVWTk1QcFpjRWNkWHNUbExB?=
 =?utf-8?B?UUU1WkJMZ1Ayd1ZjSkZTUlV0Y1l1ZHBKL1BycXV3ZUt5b1JhYitrWXJNZGpw?=
 =?utf-8?B?UmZpZndlNlMrZTNLa3ozLy8wYTNCUFlCVU96bkFXRkwza0tIZGNrMVhPeTh3?=
 =?utf-8?B?QmJjek9KRW44UXJaNkh2SC9zLzhGZXNBZmNlMWppcnVvM1cxeFgwdmxISHJr?=
 =?utf-8?B?emlaMEt2QzRwaExlN01lamRTd2lKL052M0QrQlZKTUFrajRDYUtSU1hNQWZ6?=
 =?utf-8?B?RzZkcEdOTWJKR0V3N0h6c0VMWVlJL085V2dCN245clR1U0dXYThrY0pDejNE?=
 =?utf-8?B?U1NuZld5RzdVeC9acTNoNXJvNGhiOVZnb2lnWHhFeXR0d3NpS1Z1b2JQK2Vz?=
 =?utf-8?B?eE84ZWcyeFZQS2VuakhveTRQelEwUDdONHN5OUhtQ012dFNvL3NPaVhTZExN?=
 =?utf-8?B?eFJIZklPTWdyZnVZZEZ0TjBDN0Y1M0xnTTVCNXArbnVUL1o1ekFJSUZrMUtw?=
 =?utf-8?B?eWo2N1pERzhHVi9aTkpqd1MvVDdhaHhiTHJpWVlkK0g2TUc1SEUzUkpha29l?=
 =?utf-8?B?OTc2d2h2VzJTV2RYdkpHbnp2SHNGQzg0cHNSSXYrVzB0cXViUGlaZXJ6eHRY?=
 =?utf-8?B?anVhUGl3WkFGd2FieG9vUG5rczc3ekcyOGxQSzBJdVBKVjhRamNuR2x6ZG54?=
 =?utf-8?B?WE1rZzJQaStYRklwNDJKZGFxVnViNCtjTGh6VlhQbG9MZmN2dXlHUDA2S0Jy?=
 =?utf-8?B?YytBYzJOdkNrMGp1cWVOTzVKMjZMOVBBNEw4VjZvQW5nOFRsRXNkdjcyUmts?=
 =?utf-8?B?eFBpWm9Ud2xETjllTVp4OVlXQVh1cXgvVkcvc2t4KzBIeVNlSVZ5YUpyRElx?=
 =?utf-8?B?MWZRQVY1V1M5c3VHa2FuTnJZeXlVVUhLc1dNRVZ6YkhjcWdEM0dSOXpkeUdq?=
 =?utf-8?B?bHFDM3N1VnV5cjFNYUEzeWhaRWpUaVhhNzhmVUpXWHIrR2pEV2xZRjhYY29w?=
 =?utf-8?B?ZmVBdXVKMFM0WWxRNm41eW9NNnd0S3RWbHhKNFlnYzA2SjgzSFZ1dDh5bU5G?=
 =?utf-8?B?cFNXN2N4WitpSUZ5aSttZWJvN1ZkREtQUE9RQTB0cGRvTVhaVFk4TDhKN0hL?=
 =?utf-8?B?RnM0Z2V4YThia0s2M2QxSkc2NExzMTVMS3IvekRJUmJVSHp3dzU4Z1FEWC8z?=
 =?utf-8?B?VVhVMkR0S0d6NkQvUXhxa2JVYWhNQVo5U1dSd2hlWFV5dXdzajg3K1pQd3hi?=
 =?utf-8?B?SDZwdEc4M1FxVDNBaHhzUW13UjZaUlU5TWVCaGFzZ1F6alU0Z3phVnUzTkg0?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f9316a-c417-420e-eda3-08dd8efb6899
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 13:14:20.1370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+45N0SooMYy7f8vIVPEmtbkahRi6bhNBvLKcdFZJ76WzxFNty6iE4GKiqcxOExaf/aNJ/KopmGtKaFLwz9jvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8764



On 5/9/2025 8:54 AM, Joel Granados wrote:
> Move sysctl_panic_on_rcu_stall and sysctl_max_rcu_stall_to_panic into
> the kernel/rcu subdirectory. Make these static in tree_stall.h and
> removed them as extern from panic.h as their scope is now confined into
> one file.
> 
> This is part of a greater effort to move ctl tables into their
> respective subsystems which will reduce the merge conflicts in
> kernel/sysctl.c.
> 
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

For RCU:
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

 - Joel


> ---
>  include/linux/panic.h   |  2 --
>  kernel/rcu/tree_stall.h | 33 +++++++++++++++++++++++++++++++--
>  kernel/sysctl.c         | 20 --------------------
>  3 files changed, 31 insertions(+), 24 deletions(-)
> 
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index 2494d51707ef422dfe191e484c0676e428a2de09..33ecead16b7c1af46aac07fb10b88beed5074b18 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -27,8 +27,6 @@ extern int panic_on_warn;
>  extern unsigned long panic_on_taint;
>  extern bool panic_on_taint_nousertaint;
>  
> -extern int sysctl_panic_on_rcu_stall;
> -extern int sysctl_max_rcu_stall_to_panic;
>  extern int sysctl_panic_on_stackoverflow;
>  
>  extern bool crash_kexec_post_notifiers;
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 925fcdad5dea22cfc8b0648546b78870cee485a6..5a0009b7e30b5a057856a3544f841712625699ce 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -17,8 +17,37 @@
>  // Controlling CPU stall warnings, including delay calculation.
>  
>  /* panic() on RCU Stall sysctl. */
> -int sysctl_panic_on_rcu_stall __read_mostly;
> -int sysctl_max_rcu_stall_to_panic __read_mostly;
> +static int sysctl_panic_on_rcu_stall __read_mostly;
> +static int sysctl_max_rcu_stall_to_panic __read_mostly;
> +
> +static const struct ctl_table rcu_stall_sysctl_table[] = {
> +	{
> +		.procname	= "panic_on_rcu_stall",
> +		.data		= &sysctl_panic_on_rcu_stall,
> +		.maxlen		= sizeof(sysctl_panic_on_rcu_stall),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
> +	{
> +		.procname	= "max_rcu_stall_to_panic",
> +		.data		= &sysctl_max_rcu_stall_to_panic,
> +		.maxlen		= sizeof(sysctl_max_rcu_stall_to_panic),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ONE,
> +		.extra2		= SYSCTL_INT_MAX,
> +	},
> +};
> +
> +static int __init init_rcu_stall_sysctl(void)
> +{
> +	register_sysctl_init("kernel", rcu_stall_sysctl_table);
> +	return 0;
> +}
> +
> +subsys_initcall(init_rcu_stall_sysctl);
>  
>  #ifdef CONFIG_PROVE_RCU
>  #define RCU_STALL_DELAY_DELTA		(5 * HZ)
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index a22f35013da0d838ef421fc5d192f00d1e70fb0f..fd76f0e1d490940a67d72403d72d204ff13d888a 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1706,26 +1706,6 @@ static const struct ctl_table kern_table[] = {
>  		.proc_handler	= proc_dointvec,
>  	},
>  #endif
> -#ifdef CONFIG_TREE_RCU
> -	{
> -		.procname	= "panic_on_rcu_stall",
> -		.data		= &sysctl_panic_on_rcu_stall,
> -		.maxlen		= sizeof(sysctl_panic_on_rcu_stall),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ZERO,
> -		.extra2		= SYSCTL_ONE,
> -	},
> -	{
> -		.procname	= "max_rcu_stall_to_panic",
> -		.data		= &sysctl_max_rcu_stall_to_panic,
> -		.maxlen		= sizeof(sysctl_max_rcu_stall_to_panic),
> -		.mode		= 0644,
> -		.proc_handler	= proc_dointvec_minmax,
> -		.extra1		= SYSCTL_ONE,
> -		.extra2		= SYSCTL_INT_MAX,
> -	},
> -#endif
>  };
>  
>  int __init sysctl_init_bases(void)
> 


