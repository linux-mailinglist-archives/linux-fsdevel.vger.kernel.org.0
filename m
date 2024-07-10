Return-Path: <linux-fsdevel+bounces-23483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D0A92D39F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 15:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCBB1F232E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8AF194081;
	Wed, 10 Jul 2024 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="mTPUAsfr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2041.outbound.protection.outlook.com [40.107.215.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25BA193476;
	Wed, 10 Jul 2024 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619908; cv=fail; b=gbPxYbcm8fzsNQ6O6+mkI4zlrvJh3+oup5wGeqrqJ3ICU7+gFsKkyi8kMI6KKwoBOU3OCoDhZQEKjWZ7b481INhhk8AUZ61GmqT8LygvGYCF89VtLqgvT2lnyZsi9HXVD8wmqFSuH5krQDA4Bd1gfmi32nla3IjoXF+ORlX2xsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619908; c=relaxed/simple;
	bh=q8Wo6KGynKUWZFfQDCK9cidIfGYsf6rBybJ0RDFCO8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qzA6eRYvMpxNisl6qyl5QG9I7fPYLgaaTyh+ldq3VnQt5067AiTjZFnkMaQktuo9S5IcQ6E4JH5Bx5ZEICRRNMmiinZCwfW87PVhSJf4wW/TQbqNuEl+w/bF7RIOf3a6RFeW0U82RGQgWkyPBtOkYmrpFOS/xyJmzAOw7vCYQUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=mTPUAsfr; arc=fail smtp.client-ip=40.107.215.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GW81jQAaxrHpZi9AWeRlVApqaP/X/K1JfRDr15DCnremDir3x578v5nmdtxGtH/O/Gg1XDQp65A+hPVtObQo2rims3bqGcQMEemZsAWBr+lFf3lfh6BTqEyurvkvXONqNKLq7bnNnYnZ0w61oGQDhwrUP7f+2OF7j/KKAGOAMx/d8D39khpJ+Zd1fFW4S1ylK8tH1aa1FCvE9aEfxq5VQm43MrRQaw+vLRXb4L3r65I8Yjl7MP+t+cB58SPPF+8EpXB4fSicSJl0tkiaj86Yx8UaKl/wam3MltZASRRxwmu4/Kfxcsgua60tLZU+WXJIe5RfICl3Dkk6XeodchuZsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGQLyyp4O5Uf6YpKS7Lwp4qMYi9ESWvBfGifXLA6dNc=;
 b=RlF8iuJcNWsxA8J8Vm7tdyayeqbHSIbQB6Ed+3bN1UxCAsdLq6C0JrDIk83sfgAVPzH6/k5qSdTjP6GSUyoEf4L3Hz4/oDZtLUE3xr+TwDtlb7HEq0JF0Raf8reL0TMrH6SCcedxEt7+yUUYQCq73geOz/VKPYBFV7L2rYeJrTHy1qIrxvPNREzKYY1oSWgQ2M1QOR1xafs55DsPGJiRLkiG1KvJeVq5AsUO/CfN9+tGeDffUOcHfRkCEPtVcesQQb7Mvjggq5QEC/rgWkL/fOG92OmSqaifjsDMH0IBBBQuYtVmyufrSlLsCBScLJv97OC8mwxQWpRJ6FfkEoF8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGQLyyp4O5Uf6YpKS7Lwp4qMYi9ESWvBfGifXLA6dNc=;
 b=mTPUAsfrpjgNuRQpcjRx8U79YuHfpxnQDUdTEq5l1NSlVoau9/j33NbT0+KZMgwSDQZuZ8PDMqyic/bEDuxF0ONl2T4J9d3qcXQ5OAoxJI5m/W3GUPFBOp1XuAOfiweY5wx8I+ItnA6hzswKMlP7eFlBsfW1q6NBPQHEV6tkTzlGPKHIPii8BjYV0CtI3Z8dI5tE/MnkSLo7jGRABWLk736qtMQt/0DCltu0oaaSsjBa5PGp2OECcyZZHq1ZDyp0DgtGKuEah5NsMdtbmW1V0U5KKqixPsJKfO/5c6VQdQZAmMU3e3KWDsAWaztpAEV7OO5Xg8vFvH8Borp3dr4YPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by SEZPR06MB6383.apcprd06.prod.outlook.com (2603:1096:101:12c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 13:58:23 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 13:58:23 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Andrei Vagin <avagin@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH 1/2] mm: dmabuf_direct_io: Support direct_io for memory allocated by dmabuf
Date: Wed, 10 Jul 2024 21:57:53 +0800
Message-Id: <20240710135757.25786-2-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710135757.25786-1-liulei.rjpt@vivo.com>
References: <20240710135757.25786-1-liulei.rjpt@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0073.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::18) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|SEZPR06MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d991f1c-b3fa-4f8e-f298-08dca0e85d2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CUiL/vFOpudpD205Hnjevd9c/PA5ALvPChPV4Y2ZEzJUXPPABS5S6UJxvYo7?=
 =?us-ascii?Q?S6tcFjDLWHn8P8iv/F512jv/W5QDmsYyAw86NNqxi6jY7MpZTo/z0YZWHrhz?=
 =?us-ascii?Q?VJQwoqMlLXqBTQlJc0iOLj4tfqkatx1hGuVq6NZPQso8A/SIfhgMJ566R//8?=
 =?us-ascii?Q?BwJNWtN0Q7AopCPQOs9sYjCvClALJkC2fZ3CTWmLX8NGp0JNvuJ8m9WrVFfQ?=
 =?us-ascii?Q?gCQwYQCQnMYjDXkc8QxbH4xKrOxsXORizWEhWivEcsmUtyODNSFDALvgYJCX?=
 =?us-ascii?Q?lOjdXtDqMg8hxxmj/5/QY3lo+sxD2o3kTdNJA4tN1pS4IANPPrSHzDB4dMUN?=
 =?us-ascii?Q?hDKs8MxlPbZqm0n7p37EGEs95a+m/6uaUnzKqHuL0kzLdSdGWrencZaLpJjC?=
 =?us-ascii?Q?DW5KgDOkWKUNgodcDFGsgI0XdpERItK0trH3Bo816TiYPgc2JJ2dkXdpCYMP?=
 =?us-ascii?Q?Ceo+nbvZAB1oG/i82/6AEAuwA+cUgHN+GL8iGXnRu3kuNelQrkdtTakpefbN?=
 =?us-ascii?Q?3X/cj8gx1CF1XAOHN212RxyEB11uyHQKvZpBq7b56CAvuNmRzCt1XBXBLj+q?=
 =?us-ascii?Q?JMcZm5rECvpqlOrVYqVHglxBcFMRPrPZioIScMxz0jp96bd8u2aaguwDyLvn?=
 =?us-ascii?Q?pQGdMBuDrDlJ2kIa8t7xnVJratLRxq4AsgK4JGS2pbVQk11d0IbJT3F9mcC5?=
 =?us-ascii?Q?/Uy4Uun83UoPLynhdkLOQ+xQTvoml04QAJxBGKQyl6AuOhzrizWy7wAL4cCh?=
 =?us-ascii?Q?KQrM+mcp/ddKfWPvvb9G/XjvaZMcMT0yLXdm4jym2P+cL31d5hPIHMoEFCHP?=
 =?us-ascii?Q?QTVwY+eFWF+bouEvSN+i6oeCUbt7K1/Zua1g/ZQArHvv2kVLJsw1eUP9WKBO?=
 =?us-ascii?Q?sWuRm/GAivzOVjWF/4kJORka9720Cbc0mvB6wFmsuJopFgbuKPA46GlK6YGW?=
 =?us-ascii?Q?Fip+xUnnWysJzHsE3/CjTrVISugQdxyR5CJFWfes88R+doTvO2QnX3aYGtab?=
 =?us-ascii?Q?LdtnpljQBzA62aJF0SktT2ql0Vw7xAGJvjjKWAGZzpxoiUp7WS4DbENr7sOS?=
 =?us-ascii?Q?IAXAuo3q3U+PjujZw7HsE+WlJSRY/JuVFgEjwc3BkjxUebVEWEmBPUbpnZU1?=
 =?us-ascii?Q?m0E6XyimDQRa1xLnrKibOL//kqdOmPS5mLoAE0+PQ0fRzo8niuZiviz/i6LN?=
 =?us-ascii?Q?Qj/pG0VqY2CZv1PKWnt159ERZDvPwC6bKatJyluxq8uFNCvudogbh1VTj8Um?=
 =?us-ascii?Q?xAnaQB+yUxoJOS6vXid9WWTtaJ6MUSdUb7EPF0RZFWfYOZpJt4iNBEAJBFHS?=
 =?us-ascii?Q?SH+msTnL7ajbmCz7Ie0hfyi1LepGi9l61XvlqoTPzJkq9NQPHoIZg76CmrjT?=
 =?us-ascii?Q?d+Cwlo9Iuz9OQP4cnORp4uztIXtNeUdw6NLwPu1C2PT4s8eWRupZviuhIvOp?=
 =?us-ascii?Q?FyxYlFXIadg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9PmS7ysRt6U9jzWZhSSeeW9cvf//T3WN7hdKNmv93cbUxX/bR5BGXn2UCZjM?=
 =?us-ascii?Q?+3o2AElqgibYVPWoCT8Ib66KSEwUhwlaZzwFcnZ8YM74ldGcuLsaNedpchSo?=
 =?us-ascii?Q?qizryGfFPjwCR9wE7Xdn1X91yn/E3dWeNiy/UW0qv+0EbHzOwwBt86bQsUaK?=
 =?us-ascii?Q?swmz+MjN5vOdvPacXEDauTD7myauGJrSME2MzJBkAZfhlx335+urxYbv58+7?=
 =?us-ascii?Q?UXqYxpofLKWaO2DsSJDr7nu3FrmbX0fqo3kgvllJhsxzE9OlyhyttHwGWOAR?=
 =?us-ascii?Q?xDgmTSbhH+htgQPcPK9LTRUlmMNPZNhRk4GRWjLM7eRZOLwZGz3jo2Z6QoPa?=
 =?us-ascii?Q?adh8ss6yQuuXPn58H/K2YNgoxuHbNGBXwCzjP/91TnveilXd+fCcH4ixfBTj?=
 =?us-ascii?Q?w2TccwB+n1amgX0u4pdqo1+JPr3Znn7cp9zxhguiz6zn1dU0mVkwbpZJN6Xz?=
 =?us-ascii?Q?wMohqEaz3TdlNN42UtSc3HVyzGAwa4H52Ez7Mz1t9LmBxpnRcIX45Uva6SXN?=
 =?us-ascii?Q?w/CNZXgae7K6PFZ5zDgJgPew1980L1sMmdG8pXvhVdrpNY5asmX6Q/5iE6/C?=
 =?us-ascii?Q?16JXp9QoyMLppstkHhljRrOREkhRXlkMGkk2PPKnFnI6g4a8tqAnbcU7gWN6?=
 =?us-ascii?Q?QjVoxpjcYwAJZoy8HkVWbffP9G01zhBh35OQ6gpnuKH5Jh6NtAezvgqXLSUd?=
 =?us-ascii?Q?GDWd9TgfIcq0F9QChhJsshUGsNsg4M8TLilP80KuDePay52CBV8H1DXdQ+dn?=
 =?us-ascii?Q?fbGpuDmbIQY/LTA8tj6rJ2oh7geLazpKPtpXnjzJnVcgGX1h0HwvNkJ2y17+?=
 =?us-ascii?Q?7+OQD5FG4iJeiVo1PbVDwILvim2CY8W4jyryuZdFiDWLudGDpEZd8be6hWbz?=
 =?us-ascii?Q?HrrENiCF7KJTetGwpD72kfpCnwCHG4VeLAOY+fyrqTMB/HSCHE8F+1rXwWND?=
 =?us-ascii?Q?oM779w3Xd4C3FnivuXqaHTkMWKqgxtEDXv0r1TW9VnlDwQmJ0ONwdzwVpnZA?=
 =?us-ascii?Q?oYcrysVNcyuzhtNjii0MW22j6MQozaXkK06233v7p06EgdvGv/GemYd44tRh?=
 =?us-ascii?Q?/XVDTSRUy528unREjcivg6857U2FkJlDgxEpi6sUtVfe8lzm/LVDn0Zr/O7o?=
 =?us-ascii?Q?7FTuYPb5K4DHdaPRLot7cKkt9BniVJGcWelcTdUf/c1AJjPc2KBD0e065A1J?=
 =?us-ascii?Q?uyvfqG77dokInBklXZdyl72/KdnGcF4qQLng/wnrJTgKvCcgAmyrFjf9Y2aS?=
 =?us-ascii?Q?uEJBotg91g+EGbKIF18pnWKoM3T6XIfvnFIh7197iB1WpPEmGGodoLuXUSAb?=
 =?us-ascii?Q?Hw4QalB8vypnq+O0twLpv++i0HZLYALLS5RS/h0wEwAIBkXeKQ2K15bmvqOz?=
 =?us-ascii?Q?C+FiuNTP0v34eU3f+CSCL4To99DTBSYNeOd9ny+0PF73f3T80CRGLCXx/4w1?=
 =?us-ascii?Q?eOtV6kVrzPVUlGn2oW8P/5/0AgltK7MjzMhuI90hxaE3gXzXCWMiagWmCM+w?=
 =?us-ascii?Q?KPx4YSOuPW7OySFS0TW7PPK87JSECrHOwgaLd7YA6h9BiCQSwf+Gaq9SoYp/?=
 =?us-ascii?Q?2VNbwq5AVq9tyTQF2s1B2F8J/mYf75YNm1depmVi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d991f1c-b3fa-4f8e-f298-08dca0e85d2d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 13:58:23.7854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQqWO4aQiglqE1OPHqkc2Rf9bjADycBt9TIf7PPbDTKA97+sjaaTC+LPydZMQcsC/dhxtCy92wlcw3G/zH+s2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6383

1.Effects and reasons for lack of support:

Currently, memory allocated by dmabuf cannot be read from files using
direct_io. With the increasing use of AI models in mobile applications,
there is a growing need to load large model files occupying up to 3-4GB
into mobile memory. Presently, the only way to read is through
buffer_io, which limits performance. In low memory scenarios on 12GB RAM
smartphones, buffer_io requires additional memory, leading to a 3-4
times degradation in read performance with significant fluctuations.

The reason for the lack of support for direct_io reading is that the
current system establishes mappings for memory allocated by dmabuf using
remap_pfn_range, which includes the VM_PFN_MAP flag. When attempting
direct_io reads, the get_user_page process intercepts the VM_PFN_MAP
flag, preventing the page from being returned and resulting in read
failures.

2.Proposed solution:
  (1) Establish mmap mappings for memory allocated by dmabuf using the
vm_insert_page method to support direct_io read and write.

3.Advantages and benefits:
  (1) Faster and more stable reading speed.
  (2) Reduced pagecache memory usage.
  (3) Reduction in CPU data copying and unnecessary power consumption.

4.In a clean and stressapptest(a 16GB memory phone consumed 4GB of
  memory). A comparison of the time taken to read a 3.2GB large AI model
file using buffer_io and direct_io.

Read 3.21G AI large model file on mobilephone
Memstress  Rounds    DIO-Time/ms   BIO-Time/ms
             01        1432          2034
Clean        02        1406          2225
             03        1476          2097
           average     1438          2118
Memstress  Rounds    DIO-Time/ms   BIO-Time/ms
             01        1585          4821
Eat 4GB      02        1560          4957
             03        1519          4936
           average     1554          4905

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/dma-buf/heaps/system_heap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/system_heap.c
index 9076d47ed2ef..87547791f9e1 100644
--- a/drivers/dma-buf/heaps/system_heap.c
+++ b/drivers/dma-buf/heaps/system_heap.c
@@ -203,8 +203,7 @@ static int system_heap_mmap(struct dma_buf *dmabuf, struct vm_area_struct *vma)
 	for_each_sgtable_page(table, &piter, vma->vm_pgoff) {
 		struct page *page = sg_page_iter_page(&piter);
 
-		ret = remap_pfn_range(vma, addr, page_to_pfn(page), PAGE_SIZE,
-				      vma->vm_page_prot);
+		ret = vm_insert_page(vma, addr, page);
 		if (ret)
 			return ret;
 		addr += PAGE_SIZE;
-- 
2.34.1


