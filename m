Return-Path: <linux-fsdevel+bounces-78604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK0MGEuNoGkNkwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 19:13:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EA31AD63B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 19:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F0A53220024
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 17:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E7A42849E;
	Thu, 26 Feb 2026 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="UCbyy8GE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020108.outbound.protection.outlook.com [52.101.189.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69881428482;
	Thu, 26 Feb 2026 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124509; cv=fail; b=d+BS3pn1fohp8aKUdIcwCNsvmURTJByznThlFFVrU+AFnnU/LkWm771ANYTOXFPJAlQbDGDyNcNEoTpPUgwIUoMiYezKqTz8afG3vGGX25FmyZMQ+Zd2NXzONhgUc5uxOF/lBnELyMqqbEoD9H5krp/K7DZMuweO8tS3N75yS7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124509; c=relaxed/simple;
	bh=1DUELVxTgRtUZSb6h4pUs1nGcEatjSf19GQiSrBt9pY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FH81+dEvGM9B40uCjBlXAB++6q3S+C6JKHS67f7yGWHvrC9I6n89gHyVtudifuML/CauzQPkyVNGV5DmXzcLj+6kZiyf2ueuZ1UA7fiNyLoLi+ZCteLGgxrhwMCIyH4EglPKUJJGhtIJ2ZDFwrx5sglkrl240uXZa6x21H6/CtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=UCbyy8GE; arc=fail smtp.client-ip=52.101.189.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prR4/osidBDY4d2itmu1MTbD8GTW6YDNcjeqRzV4E27hro5XrMypA4vPIwbGbAdJsUdRTG+pDw2QhWH6jSlD5BkT0wmHg/s8dTVSPY0AS/UzuKv93J8Cq5TGvJK2bkGwHZFLwUzdCP5BOcCfP6YlSHY+iYyGB+ldOvhmH821EPPrUJZfZyf8fVGs9n7BUsf0mIdBdortB0/hbhhUBE8mVIviP4Z9SVeP/qGtea0VG7LtQf5/FwPhj3MEfxOgEgaJSDlpZ/QNb/VGUBxCczF/tO0EpLcFGl+yZL/JFsI1UdLL64g5DMQv/ZfHkghyl4zitvhorx0t0VJuxBQuHidZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NRGxBD8iq24XqreHl+t3nB3D1EuotsdUCubRJOzDO8s=;
 b=D4NCmu7eamtd3s+2s8vb18F7D/e3JJwKzXte1YaOSjooLggqRjAwmUC//6EzIk1Ju8NIRvvZT/amb0AzoSACHo3aTuKxzmjxj0UuKst027/Wkm5pXOvXb4tTDMOUWBta1qYba7LHR/ZJDx9Vd55AceZfE+ZFNxeJIiTO7e8cTh30PAjL9KLlSKc/Nt4LgMGASwrd/1WqT4/q9BAiflfSbqNZ4DEbfJ4oOvaOhkmoiXB30eYsk79XAsyJPup9PUpM1Lvq5q4b9CYVWE3Q9uImooMMJZ9zFZ/jJ2aVAegEA8TTStlF17lvfrBf+4q7N+tHC1WWhj+/0lp+bESDNmoPGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NRGxBD8iq24XqreHl+t3nB3D1EuotsdUCubRJOzDO8s=;
 b=UCbyy8GEQvKFuNlzBT8Zw2A1p3+1WlrARop5CiA66I4t16ealZzUV4M/mgjq7FaK2j1Thj4wRPzQLbEyo2xEv9GOc1a1aWmoKmbcbXKVItI28M0QQOk8FtddWLwGr22HhtL41XlBGGdR8Q1f28aDuor7SQsWs9xxzF11Y1swbEaMR8L4Sr7V70rzDZ/mCYcXRuj5riX7jnkz5BOAJrCQl/P8E9Owwdn6hi+NbHO/0Be64dlFWNlnnjhoModfuM8lzyAZWa5350nf5nNUwT5/NCrnhnB9UDiiFDbiQmYm0cxi+lHtq0ni0MuGKbLsvqKlTBjalZQYKRxQlKmzlDIO/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by TO1PPFC7AAF0581.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::68d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Thu, 26 Feb
 2026 16:48:21 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 16:48:21 +0000
Message-ID: <d01da4a9-58ba-4ae2-ae5e-48b5e66db578@efficios.com>
Date: Thu, 26 Feb 2026 11:48:18 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/61] vfs: change i_ino from unsigned long to u64
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
 <20260226-iino-u64-v1-2-ccceff366db9@kernel.org>
 <06c94e29-32d8-4753-a78c-8f5497680cf4@efficios.com>
 <df0b9e26fca0dc56a10e2f6792892c7b5f23c84b.camel@kernel.org>
 <540a4fa6-40fc-4302-aaef-3df5fb3a8cef@efficios.com>
 <e0759209c02d81b877b136f1e2b9500ba69b4f35.camel@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <e0759209c02d81b877b136f1e2b9500ba69b4f35.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0004.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::22) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|TO1PPFC7AAF0581:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc82436-c520-4a2f-d8ec-08de7556d951
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	OibdODFT1Ms35k+l7QJ3X1OOGCD10tlD0inZogpAzpq++n0UkILt8ia8nppETREooVgu9XqKH9N2cLPW6idOgePFXSJHGblKlNfA3N+/2UjSqLD7RYxcylmAnufZteid+00Htta3O8uNdM5HjsmjWkD98Q0ZygD7jbXRNP9KpVro1GPMVLFqCAC9dK1qeikKjHprnTQ4/hKtYyT/wJcKYk1pqrcWK7dNLKZ1vMxueym3Tr2O7/upI3LcuRKKBG2XwUY18sDLjRLKcQbax+UVVuMPZjRH15M9yYZGjtKuvc48oGm0GAB/tKLrrIWCw2S3G4JaGn+2YV1ZyUG347g/xPKMC40ADSnT6rah1LeNSvBcjV7fGqW25LK207GA0f2EkX3qLBXD2qh3W6FzD3GQ4iGn8mRrw72tKFlnMAQkCXz0rk3CqV3lqaaSYVzwt/+7n7IuPclPKbuyEwQYVrc+8S9Xd4RvqIPCLaCCsm2Rp1nLLYc7tmJ7AQEWJ3L13hBHHU9Ai5f7LDj9apBs9RYvaLnx513w9yUEALE6qV6TfcMc/Qlp//DHg9iCBHt+nAnCkqFtyDNOd4+YCOprjjiyrBJiMB+/LZEXS6nOzjrKdpsRDDVMavqgiJztY+6vdxuC6QCoYfUeu+o5w2jjxcHAIvPotttgJbXmXEbKXsNOy2xzOybBHSeIwQbbJP+3Texc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjE5REkzZUVRNWVPZjBURmV3N2xZMmpHWTNUSVBxMExFdnZFd1FWdEhjNTNI?=
 =?utf-8?B?MUpXOHd4TXBvdTBMZ0c3allUV1pYVU9yVHE2RExsWE82NDRYWVpYb2dhT2lK?=
 =?utf-8?B?RkhlYWVuYy9YbjR3ekFLT2dkWnUxaDBieS9hRThMZzhJUkdTckR4WWl4dDJU?=
 =?utf-8?B?Q2wwU2dYNDVlU1ptMndkZ1R4dVMyZ21HZ28zb3pLRXhHUzk4MDNmczlnekxC?=
 =?utf-8?B?QU9MU3kyU1R5MUk2dFNYbnFNUUlZRFlnVFpaUllBcHF0dFB1RFphVTV5SUdT?=
 =?utf-8?B?R3l1TXpHUW5hQkdaNEZhTk9HRGoveVNhK2NWc25LeElDNE4zZmxBTEwwTE9r?=
 =?utf-8?B?c1NrQmwvWFNIMjZaZ2tYbWZ2U0E0UjNXd3pSNnpNdWpGa1RZd0VRT2hBRkVE?=
 =?utf-8?B?T0N1dGNLVmNHQUJwd3UzU05CeDVJeW91b0E1YjlkU0NPOWlZck1CeWZPUi9U?=
 =?utf-8?B?NFl3Tml3WlpEZ2htYnMwdFJVVEJ0dTJDMUFNRTRxaHB2VlYydTh0YnA0dCtR?=
 =?utf-8?B?TCs0QWhhUGhHUkJzdi9xdXEyaktSRWc1NGhuYkJnWG9TeGdjVVhiYS9Yd1ZK?=
 =?utf-8?B?Nmxwdzk1RG9hNHBzVmhqWUZaTkVzNjF5NkJOZmZXdTE2Sk13MHhDaE9LREd2?=
 =?utf-8?B?dnZ4WldyZ2JKRmszdUVHbURIZmJkeXZ4b1lzR2s0V0J5UmE5elk1VEdYUTNp?=
 =?utf-8?B?aE5DWWRGWXdGWkhoVWJjZ2dZUk9ENUk3VklSWmJEWFdnUXQyUlozNnJJWDhV?=
 =?utf-8?B?cWxaRWpvYzBFbXpOd3puTjlnVlhyT3l3cnM5VkJCMmVXNlFSeXVYZGtiMndQ?=
 =?utf-8?B?OWkrQzJaZkZ1enEvM2ZjanZRZzF6Z1RGc0V6bmRtbGVucVBqc25UWUFpSXZL?=
 =?utf-8?B?WXNMQjh0dWVUbUVaLzBScG1ZcG1aVnltMmJ1Sys4enlKUVp3RGhpNE1ZL09i?=
 =?utf-8?B?L3dNSk5wZTJiNkhZYTZYUEUrdFJDOWRmUFphSlE0bG4xQUxHZnFGMmYvcnk0?=
 =?utf-8?B?Nkd6TzFGR0N0aXFyZ2Z2ZU9QekFobWtoUzl6TDZsMVBQY0tpdXZ1enpmUnJs?=
 =?utf-8?B?WjVLcWsvZndaSDVQWGhJQ1hNTGRqTk1GWUhIdXBReEwrc2NNV01IeTI2elE0?=
 =?utf-8?B?bnRUT3FJTi93c0ZUUEFSU2YrUjFKbkhuQmtNa0tCbGxuYzNwYTVHaU5tOW1Z?=
 =?utf-8?B?NXBud3NqTVhVSnlNYWk3QUhLUk9GM3pHeGYrOEdjM3BsTTB5WFFhZHgxMm1Q?=
 =?utf-8?B?SVVSNWxBOHdTU3BiV050YWh5dnpZSkY4VldqVFUvS3AwK0QwazJUcVZqbkkw?=
 =?utf-8?B?VEozeEY2YVNFUEZGME9XM3J5Y3M2V2cvWW1jMERldEJHRnZqR3FhQlY5cW96?=
 =?utf-8?B?OEUxT3MzRk12TWU2bnRyQVNsSUZvKzR4VmJyNDg1bkhadzJqK1Byb1grbUxI?=
 =?utf-8?B?S09ZWmZ3WXcwZlRKZjJXQTVxVUVPL3U3NkVVZHdJRzh3bTZlbi9TcXFRdFpj?=
 =?utf-8?B?cmpGOE1YV0ZOVjRiOS9mbExZQUpIWHptZGU2d0l2akMva3oxMmZZNXF3MTUr?=
 =?utf-8?B?ME1IQnFmam4wMFhjeWhVNmlLUVZEbERvL1pLWk8zU3lGdzMwc1lwcnI3YUVq?=
 =?utf-8?B?amFTeDFoMjVMTHVLeHE2UE1ZSzNsbFNhMGNFSC96cUYwOWgvSVNaZWdQYlhX?=
 =?utf-8?B?cnNwc2Z6ZG5Xc2tuaHNJM29Zb0xwdUJYL2IwWXdINmgzdG9sRFBObVBpYUFa?=
 =?utf-8?B?VDdtM2tyamVRRUlrNU1IWlYrUTRHZXU1RnRPNXBnSnNDd21Wc1lVU3F4SU5n?=
 =?utf-8?B?VmhZSDlMMFhvRWViLzJKcUNrZyt0UHMwMmFUV1VmTm84SE5nRFFoOGZQSWtN?=
 =?utf-8?B?Y3pNcVpaL2pORitybUFsYndrbFlnNVo0QzFuUXpnVndIRmtPRGdwaXB6RDRu?=
 =?utf-8?B?ck5NWkpVNUc5ZnVJUmExdWJvQXV2a0lNZkd6dlA2RHZzTEF0WldUcG4zbVhZ?=
 =?utf-8?B?M3RNRFFRY3FtVTlHZ3lFSWQ3YjdRT20yaEZTSDY5RHBzQWlJUFJpWFJUUmtR?=
 =?utf-8?B?alBKNmF3dmZ6MlgvbHNseUxhL21meTRmZmhFT3RPdVJvUHdtcWtuRHRVaEVq?=
 =?utf-8?B?K1UrbDZ6aTlqaFAwdVgrdVUxSER0R1BPcFJKcnFmOUdYR3A0UXo5K09nc3k1?=
 =?utf-8?B?UFU0QVFKdU9RUERMdXlQWmpQT3dmbVNQZ1l0OG1wT1RIS0lWYmZJZXlUdHBt?=
 =?utf-8?B?Rjd4ZjhmZURvdXhwSHh0U095NEtqc1g1dDhvTm5RczV4clZyNXA3TldpZDN6?=
 =?utf-8?B?ZTBUcnZiclNiek0zUmxtYVBJUzVTMjl3Uzl6UEJ0cXZFaU5uYnB1Rktma2li?=
 =?utf-8?Q?mgkMoh+L5bJf32m809hB4rjMdtHFsseMyr49P?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc82436-c520-4a2f-d8ec-08de7556d951
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:48:20.9340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIr+jNfLqFGLFoMyJ3mBCF7mf/vGKxwR6G3htA0Tw64hE0yVG6+46Ra5uU5ivbB1bZz9T1Be4T+4cW5f7ktLbY9Hudq+qOx61OLjQN1hRsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TO1PPFC7AAF0581
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[efficios.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[efficios.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78604-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[efficios.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.desnoyers@efficios.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,efficios.com:mid,efficios.com:url,efficios.com:dkim]
X-Rspamd-Queue-Id: D9EA31AD63B
X-Rspamd-Action: no action

On 2026-02-26 11:45, Jeff Layton wrote:
> On Thu, 2026-02-26 at 11:40 -0500, Mathieu Desnoyers wrote:
>> On 2026-02-26 11:35, Jeff Layton wrote:
>>> On Thu, 2026-02-26 at 11:16 -0500, Mathieu Desnoyers wrote:
>>>> On 2026-02-26 10:55, Jeff Layton wrote:
>>>>> Change the type of i_ino in struct inode from unsigned long to u64.
>>>>>
>>>>> On 64-bit architectures, unsigned long is already 64 bits, so this is
>>>>> effectively a type alias change with no runtime impact. On 32-bit
>>>>> architectures, this widens i_ino from 32 to 64 bits, allowing
>>>>> filesystems like NFS, CIFS, XFS, Ceph, and FUSE to store their native
>>>>> 64-bit inode numbers without folding/hashing.
>>>>>
>>>>> The VFS already handles 64-bit inode numbers in kstat.ino (u64) and
>>>>> statx.stx_ino (__u64). The existing overflow checks in cp_new_stat(),
>>>>> cp_old_stat(), and cp_compat_stat() handle narrowing to 32-bit st_ino
>>>>> with -EOVERFLOW, so userspace ABI is preserved.
>>>>>
>>>>> struct inode will grow by 4 bytes on 32-bit architectures.
>>>>
>>>> Changing this type first without changing its associated format strings
>>>> breaks git bisect.
>>>>
>>>> One alternative would be to introduce something like the PRIu64 macro
>>>> but for printing inode values. This would allow gradually introducing
>>>> the change without breaking the world as you do so.
>>>>
>>>>
>>>
>>> True, but it makes all of the format strings even harder to read. After
>>> the conversion, we could go back and eliminate the macro though and it
>>> would keep things more bisectable. I'm not sure what to do about
>>> tracepoints though. I guess we could declare a new typedef and change
>>> its definition when i_ino's type changes?
>>
>> For tracepoints there are two things: a TP_printk format string (which
>> would be handled by a new pretty printing macro similar to PRIu64), and
>> the type used within TP_STRUCT__entry. I don't see why you'd need to
>> change from ino_t to u64 there. The conversion will happen when you flip
>> the ino_t typedef from unsigned long to u64.
>>
> 
> My worry here is that ino_t is a UAPI type, and I don't think we can
> change it there. I think we'll need a new (kernel-internal) typedef
> just for this.

If ino_t is UAPI then it cannot be changed, but you can introduce a new
kino_t or whatever naming is appropriate.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

