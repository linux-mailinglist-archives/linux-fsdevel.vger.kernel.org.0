Return-Path: <linux-fsdevel+bounces-67226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B869C383F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 23:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01DD734FC7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 22:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3320F2D2388;
	Wed,  5 Nov 2025 22:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="GrwuqB74"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180F57260F;
	Wed,  5 Nov 2025 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382923; cv=fail; b=r/8Cb9FkMW5iBG6XlDRiBtujyTbY3HlWd8TllhOUGWKItGV4laaGzIvDVHUcMwbdycwL4PbV4Cc0W6XENJw4mvw3Nff4kx56FfkqOOBgooqzufdubuQ8QkauoWDEl8T3JEBpjVsvME8vLVjZyhEfkrZ2myc8JaTrrmKRTVh0VCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382923; c=relaxed/simple;
	bh=7+jHbegVudRcVCdIHHmIUpT70TpRZmeZWLzgLRGW1sk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=INscUPx3czekBKDrG0yiAUV5buI7gxXRqRSDInHuVFFOKsuNT9rVmj5dYZD93RkiMWMZc/0trWKrrR2FslENLKl838b+/jV+QptsipxoDdiNDYFubu5Ksp0JddLMYQ29s707662rBZ83BOe/r4794U/0nkUHMQiJYX+YmUdrSV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=GrwuqB74; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020079.outbound.protection.outlook.com [52.101.85.79]) by mx-outbound44-249.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 05 Nov 2025 22:48:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNPqAP9wnFOvfUoAFrgdyp7SExetjqENuBwmUE0LqMPywe+8zpqDVFoYZM3tc/1x6/0mPK0+ZvWNlERG7JsqIeX6JhmXeRRe1xERWEspXigqEKRBkFsq3UtnVL6cZfJ4ZAjxi24zdy4uOa8eomOA29WN8eKO/t1CYGRVzttrvYl+2lmN+DzOUnqKbbShugAyBubQd2fiLjesFf9FX76xEjioVWZRRTOKw7Wha2lATsv4YTaxM6jXbwhcLF+uEFtqyBMZmpISTUY2oLd548HvPw5XVXvACK1fJvMRVDT8+/9AejV5/pAabsC4jTX5unGUdQFFSSDu0plHoppmUxyu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZRkipX0mbchPU6uCKoRNeYZxhUsC8JSIpmybtMH1Fk=;
 b=P1YZFtmvVl12Z2rhna0/egmhJ/dlw19sl7HBDDCGH3XMQiWXiaJACT5l0RdGcty9VceAc9YJ0xuIZNkCySHX2YPBHbFByqN6ybJfKXCY+UjdHOCnt+IeXSWqnjX8givrPlG+u+rMe+R0QHuQsip0/wQ0AcUkRo8xUUF6dbNpO/71KQV2nHuEHU7zvNuKJLYXTIFCBLYhXOD6AdFsx9Z0jY9qrDaG5Q/XBwIB1muCoCsrjJaGZ+BMHDdh+MrHW/H/8ojGve7BgsFlhoHKRVActiNQuBsa+TtJHN+fJ1Uarg1s6h1krLu8oZv4QNRN08iOcyWWigT7E35cjlW4djqFkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZRkipX0mbchPU6uCKoRNeYZxhUsC8JSIpmybtMH1Fk=;
 b=GrwuqB74zvNZZHFAmDPB1jxSQMj2lYVLKUlM1m8Y0e4o3/7sPJUho4Xb0DFuwvcojXhsegzd2XWN1SFO9dOqNCnEnSYsNZQ59xzJEQ2hSSb83TFE7GmOkbZKovb0BkUH7kNKRLkGa7qHijMKfrSOV3+3HN7CesKRV2BK4pMzako=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by MW4PR19MB7175.namprd19.prod.outlook.com (2603:10b6:303:224::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 22:48:25 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%5]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 22:48:25 +0000
Message-ID: <d57bcfc5-fc3d-4635-ab46-0b9038fb7039@ddn.com>
Date: Wed, 5 Nov 2025 23:48:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Another take at restarting FUSE servers
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>,
 Bernd Schubert <bernd@bsbernd.com>, Theodore Ts'o <tytso@mit.edu>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>
References: <2e57be4f-e61b-4a37-832d-14bdea315126@bsbernd.com>
 <20250912145857.GQ8117@frogsfrogsfrogs>
 <CAOQ4uxhm3=P-kJn3Liu67bhhMODZOM7AUSLFJRiy_neuz6g80g@mail.gmail.com>
 <2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com>
 <CAOQ4uxg8sFdFRxKUcAFoCPMXaNY18m4e1PfBXo+GdGxGcKDaFg@mail.gmail.com>
 <20250916025341.GO1587915@frogsfrogsfrogs>
 <CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
 <87ldkm6n5o.fsf@wotan.olymp>
 <CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
 <7ee1e308-c58c-45a0-8ded-6694feae097f@ddn.com>
 <20251105224245.GP196362@frogsfrogsfrogs>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20251105224245.GP196362@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0191.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:376::18) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|MW4PR19MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab8d8f7-8301-44d8-c48f-08de1cbd6dd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|19092799006|1800799024|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YmhtSSswTTcxYlJYdWxUMlRpbDdXL2d3YmxJKzdncnRNRy9FSzNsTkcwK2Zt?=
 =?utf-8?B?K0VPYzJwdUVwU0NtNjVpRU9GZ2k2T0V0aVV3N21OT0ZOYkY3dzNVVEdYNFlU?=
 =?utf-8?B?RGM2QVE5WnhnN2JXVDQ5dXdmUnl4a244ZS82RTJVTUl1K2wrNmVCRlhRV3FI?=
 =?utf-8?B?VEJoOUlxZmt6QTJWdnl1VkZuaGpIVWZ1My9JVC8vQUFIcHJZK09tN3hieTBV?=
 =?utf-8?B?S2w5T285dHhpYW1ySlRaY3VMTVpmSXBTWGZ5NTRUeFN6MEUxSTVURmxLWFZO?=
 =?utf-8?B?SlA2RXdaTW1id29aRnhBa3J4dkI0eHgzNnhDNVBMNVY4UnVCUGdrb2JiLzlM?=
 =?utf-8?B?NDFId21xalpENXNvdmd4TWMzZldmN0VTS29xYXNvYkh3UmlFUDFwdzJwVzk5?=
 =?utf-8?B?U3kramRKcVgxdGtEREVVbU0ybnpHR2tkc01LRUJIM2ZkUnUzWEd4VmZCMFg1?=
 =?utf-8?B?T2NGZGZwZDNKSC9QMkFuNkM1SXhVVUJTcGpveStLYWZDYnNnZlQxc3llSTdI?=
 =?utf-8?B?WHRmYkFyNHBZMGNQR0lHZHJxZTZTYnpnb082cGZCYUlLd3lOdFhSVGZlWEIr?=
 =?utf-8?B?WlFwUUVrdGU0T3FuNjN5OVBHaDM2dlozWmtUZWkwTWJrb0xMQ01PaS9ldDRI?=
 =?utf-8?B?dHZHS1dFUExtTm8rZ3ZoZEJ0dlorYldmZUJnRGtndFluT1A3c09TZHVXZjIr?=
 =?utf-8?B?T2dRa29oOUx2NURzM01sNDNmNWdmeFpVbkQ3M0lmdURaNVlaSEJtVlh5OHBn?=
 =?utf-8?B?YWdlYnBjNXNlYUJUVVZ0aklab0lsdndhQlhTR0wxcG5RM1FpMzU3dUE3eHI1?=
 =?utf-8?B?aXBLMnpMa1ZqQXJDcDRHMllqWGMvRStTY01Ud3ZrdGhFODRTY0JIRGJ1T3gy?=
 =?utf-8?B?cHRZbFg3R2xaNkkzTGpTY1oxZDFLdXNCQW1yY2lKeENhbTRYR05OT3UyYnNV?=
 =?utf-8?B?U1FaQk5BM2Fta2VCZVcvQmRSTGw4cEZ1ZlpEYlk5VmR1ZVVCd3FQWHZjUnI5?=
 =?utf-8?B?Q0NzNEtEa2hEcmswcnl5Q2hkdTlsdWhFb055R0hORXduQU5uTXJtd3orSmZG?=
 =?utf-8?B?QmJwdzFaSlEzZUZJL0lNN2hUMUdaK3FJUSt2SzlSM2VLUE9iWE9tUzROaVZX?=
 =?utf-8?B?bWVwY3hGUm1LTlJIU0xNcVFIMGdaaTBUaGlnb0p0Rjc1c29zTkdQWk53Mmpm?=
 =?utf-8?B?YUd4S21La0UxeFgxTmZud082NDBFcXl6NS84Ly96SXdFWE9jZGd3VUExcHBS?=
 =?utf-8?B?TjFKSXdZVkZ5dWhiVnVVUlczVXRpQnRLa0VUcEJqSWphdkwxaGtwa3V4VVZy?=
 =?utf-8?B?T0ZrVWdkb21rSTU0Y084TkppeVkzMnN4TnNmdnNZcXd3b2ptWnR0RnlPMW9l?=
 =?utf-8?B?S0t0YlB3WWE1RHpqNkhxcWpLZWFrOE91bmJhOWRmQlE5SStmRy9vRzFBcGpO?=
 =?utf-8?B?UzdueFB0RStxSzRsT2hEM01EMTZVK3ZhZExMR1JMbmNTV0Q2S0pOODRqSG9o?=
 =?utf-8?B?QkpCK1ZUUWNaMzhSU1J2d3Q2Rm05dUhER1Nid0lTU0ZyNmdLeXpuYnZLUkJm?=
 =?utf-8?B?SkMvajNsTUdPaUpSZlJsZU5TRlVxZVQ5enBFR0NCZTk3WmNRWTJ3bWJlS2pw?=
 =?utf-8?B?bXRsL1ZvWUZLODJvMnU5NlpMaldSRDRRQXd3MUQvV3NZNkN1bStjNkk4TzJ6?=
 =?utf-8?B?WmNNN1BCbXVjdFAwc2p4b1E3U0NSbTJtRWFPSlB4a1RyeFVTVlpJdlNKWm9s?=
 =?utf-8?B?QWlCTTA0SEc0UmloWVZHaHNuU0J0UWhnTVZ3QzZ5b01OQ3Z5d0RyaU00aDZs?=
 =?utf-8?B?WEJMTCtBOE5rcEFRSmtsRFNHK3BJemxoRlJobnlRNGJDdmNzeDR1VDFKWm0v?=
 =?utf-8?B?UzZPZGdUT0laQXlJNjYzVlovRzhkS09STjVHbWxpY3c5czd5MkhOSDJTdi9O?=
 =?utf-8?B?dGFYRVA1SHJsaXVqK1R4TC9NVW9BZ2dwUHJvQ0ltOVhCUDJDZTYvQkROVHBt?=
 =?utf-8?B?NWx4eEphVUJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(19092799006)(1800799024)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnVnT3QwWFJRY0pHTlpxOXorSXNtcllucVVZODZqa1Q0WmpHb0ZqazNYOU0y?=
 =?utf-8?B?S1o1NEVON0IrcHlhZnhXOFdUVmJ3NTAxQnVqbXd2Rm1aTXMrU1JCY2s5L1lN?=
 =?utf-8?B?ZGpqUUswM0VEVmdKaDk1MUZteitrTDFINktsV2NMRWpvNS8zbWx1bUo1R3Fp?=
 =?utf-8?B?ZkpYZGxFRnNZcnlqcklHZitnZkgyZGdUakJLT2J2UWEwQUZMZVdzc2tkYk0x?=
 =?utf-8?B?Z2Y4R0ZCb0lYOHBSc083MytURS92Y2Q4ejV0TVYxSFdtdDUzNTBlcHA1R2g0?=
 =?utf-8?B?bUE3YTdSTjZZeHgyNDVkektkRE9EWXBTY29BNkZrRnZSNVJ6L2hUUVNCUHFY?=
 =?utf-8?B?RVNXV0xoS2l3dU96R2l0TkY5MFhnYnNHUjNRNmY3RE1MaTFOSVNUVEd5R3VU?=
 =?utf-8?B?aFhQZVVKSnJQTlFRTVFUQXcwWDJucm5VM1VMM2FTR2VQZ3Z3b09EekdOa1l2?=
 =?utf-8?B?amNJQ0I2S29rNitWMVE5TUtTM0ZxblNsWWtoQkdTV3VlTng0S0FKdmNGZFpq?=
 =?utf-8?B?M01Jd216b3pLRmNlUlVFeFIzOTRqTTlaY2RuMEJFcUdHQUFSeUhIQy9PZ0tI?=
 =?utf-8?B?RDkvL0tnZ09wbFdtV2RCdlBXQ0U3ckt5UTRFaVZaeHNmYnhIYmkvTllMekVS?=
 =?utf-8?B?dFQ4cE41WlFnTEdwYjRGSisreVcrb3dTY2wxV0dRNzBjcnFDbzY4RmxaemR2?=
 =?utf-8?B?bXdad0V0UE5tdSttTk5OYlFTTGpsWkJuMFRnejZHS1VLVDBuK0orS3lCek9C?=
 =?utf-8?B?VTJkUzQxMGRINTBQUXliMnVqT0VPMlNMem1lek9MQi9laE96TFRRV1VWWm03?=
 =?utf-8?B?Wk5QMUkybkFjR0RHK0txSDVCUXcxRHBjWm1lZk91a2pseXF6QnBkTmNmWWti?=
 =?utf-8?B?TDk4SlZINkhXVktwbEdvcElhTEtZOUhtMXJlUHptZUVTZFJMTkJqY2pWZVhO?=
 =?utf-8?B?NG5TbGVENUorMnFUNHBoRWJwWnpIelY4N0I0OUpMazRERFR0Z0duZUpFYnJC?=
 =?utf-8?B?Wmd6QWNleTNUUG0rWU5DYS93SVd5N0ljdXF0Rmd2bzIvendtMThYM2NRckZL?=
 =?utf-8?B?UDFCUmx0ejE1ejlEVElITEphQkxWMTd2SHBBUHJYQXN1YmNwQy9ubE9PdXQv?=
 =?utf-8?B?emVxNlVydFFvdTFhbm5IMnR4T1c4WC9FbS9qK1Nzc2dIRjAzZVFMRFVTK256?=
 =?utf-8?B?a29jT0RXWUo4eFNGRGR6WFl3UTVDR2ZQdWtjNzMvcEMyc3ZkVjV0U2JIOGV6?=
 =?utf-8?B?SzJxZDdvNDc5eUpZeU9rS1N2NGlWR2ZSTG9CRXg3T3ExQmhTWTBRWlVFVWJl?=
 =?utf-8?B?U1VSL3JpbG5WUkV2ZFV2cmhnODRnT3p4TGJnYUpHNzZQaG1NYXBiVUNadjM0?=
 =?utf-8?B?cXpocWx6b0QvRndKUDJkZEE3SUZaUVNnR2Z5WXAzam5RamtHZEVhWVlVc0VB?=
 =?utf-8?B?akYraEtUdFNJQVZWZnluVk0zZDRYV2RlaGFzSTZ4bGlEWHNFMS9uQ2piaTFK?=
 =?utf-8?B?cG1wNDFvZ0pRd0xWREpzT242b3FYNlNGYXpzMWRYdTZOQnQ0Z1F6K1hnVjBp?=
 =?utf-8?B?Z2tJdDlqRlFKZDNlTEE3aklEbDJmeWhuVVY4V2NCd3NQTkpkOE1vZlZNQUJF?=
 =?utf-8?B?UDVqVjVJNU1mQ2J6ZDlGc3pVYnFTd2drZmJaUDkxUXZIZWpoZ0lpK1dGZi9n?=
 =?utf-8?B?aWxvRFUwV1dQTFNSUUd3ZTlPRy9FY1ZvSmRIVmlmVVVCdU5ERjJHNnBXOUpD?=
 =?utf-8?B?N21DQi9Ibi8rZWR3S0pYNm1wTDVESFBacmdoU28yK2gyYXc5WFlKU0lYYW96?=
 =?utf-8?B?TE5WOWR0V0lUdjU1MWpxODlBWURhcmNVQytHSEw3T1ZFWmJ5OHpBdk5JNHc4?=
 =?utf-8?B?UnErNkZzYlpWSTZTL1Jmc0FGRldqTXQ1dTVQem5YTzJQOFNtYXUrRWxOSWYx?=
 =?utf-8?B?Z1U0enhhWlE0TVphUmFyM0U2bjRPOUVlVnVYOEhKNmJNdXdzZXZzNGZNUmJV?=
 =?utf-8?B?UjJ6SUNjNkZFcXpwUUlrcUx0Q0JBakpJRjlDN3I3SzNzQmVRSVFHajZCbEw1?=
 =?utf-8?B?SWlYUUdwRmZ3ZUd3SFJaS3FLOUFWWmRNY3FiNTROS1FubVBUcVBQVmVFWmIw?=
 =?utf-8?B?ZXUwMFMxZzZicG8rRHRqRjBFcEk3SjhONjhRbGlUZFZuVytTMDJHYXZzTnRv?=
 =?utf-8?Q?tPa2AvfmTprfrD6V0uH95vYzcgVK7X2V97gEb4AlByNj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sJtb725C5ARA86JUZaNahTUyIbXdL/167rGyM3RmHfqgGsiL3ACoQn47AW0q1uKO5o06DuPrxLrR3KIY7SgrhCKYe6OCbKXDm2pQK/iTWaaQd880cVZ7eXFdO7w7yWrIrlLuQCld2Myyrc/txeLrofx7QS2JvyphntIT4kc9fJBOYt/3WHPMf4pyT1JFEb3wPPdkoTSPjNzrowLhZsfcIhKODBJJDklByL2LY0zqsT4IDfwRBs7eHafpffhkYZKxquz05/DtUTX4oa2Ev0txABWGzbRu159LyTG8P1U7tnnbixYZ5GeZxGd3TgZJuhWEevQ/vWLKbUODr94PGp/7BN4QAJoP47ZEylP0AIZoNR+2hc9V+WWx37ZYQV3hcN/Dm5P2RiERYWlJ0U/Q4R8X8X1b7ouGk+7wsAzCeQNEpzSwucZbd5dRotPP2Mtt728ByfLbFlkJ+pmiaG6FuFfoud0M2OTCLf6HldR37NnLmMoPWdUTE4qOpkEUbfs8ujUfZYqWB5c6p3p5eetMLR2CXcRYS6HHFyZkN7QJOKvLqU/f4gqwP0ki2QoDEjDq6QbWfC/Zk/LY+oH7rDEedEwItoSe9N8ODZ/1J6+Uzti55aYzsHbkb70rGsGpUNzWt4H5bllKbwiDSIt77iRhOTbUJw==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab8d8f7-8301-44d8-c48f-08de1cbd6dd6
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 22:48:25.2287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1tWjIExFcNvOmjKwDPyu3V67W1rixnddt57QhYLsJ/lAsLeZ8Ldhq/sOS2XTvygcrmIDAYxI4pDEe7EUuUhxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB7175
X-BESS-ID: 1762382907-111513-7683-17683-1
X-BESS-VER: 2019.1_20251103.1605
X-BESS-Apparent-Source-IP: 52.101.85.79
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZGxiYWQGYGUNTUIsnAwiAxzS
	TRxMTUItUgLdHE3NLUzDI50cDcKDHZWKk2FgCGVHWoQgAAAA==
X-BESS-Outbound-Spam-Score: 0.90
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.268736 [from 
	cloudscan13-66.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.40 BSF_SC0_SA085b         META: Custom Rule SA085b 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.50 BSF_SC0_SA983          META: Custom Rule BSF_SC0_SA983 
X-BESS-Outbound-Spam-Status: SCORE=0.90 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_SA085b, BSF_BESS_OUTBOUND, BSF_SC0_SA983
X-BESS-BRTS-Status:1



On 11/5/25 23:42, Darrick J. Wong wrote:
> On Wed, Nov 05, 2025 at 11:24:01PM +0100, Bernd Schubert wrote:
>>
>>
>> On 11/4/25 14:10, Amir Goldstein wrote:
>>> On Tue, Nov 4, 2025 at 12:40 PM Luis Henriques <luis@igalia.com> wrote:
>>>>
>>>> On Tue, Sep 16 2025, Amir Goldstein wrote:
>>>>
>>>>> On Tue, Sep 16, 2025 at 4:53 AM Darrick J. Wong <djwong@kernel.org> wrote:
>>>>>>
>>>>>> On Mon, Sep 15, 2025 at 10:41:31AM +0200, Amir Goldstein wrote:
>>>>>>> On Mon, Sep 15, 2025 at 10:27 AM Bernd Schubert <bernd@bsbernd.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> On 9/15/25 09:07, Amir Goldstein wrote:
>>>>>>>>> On Fri, Sep 12, 2025 at 4:58 PM Darrick J. Wong <djwong@kernel.org> wrote:
>>>>>>>>>>
>>>>>>>>>> On Fri, Sep 12, 2025 at 02:29:03PM +0200, Bernd Schubert wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 9/12/25 13:41, Amir Goldstein wrote:
>>>>>>>>>>>> On Fri, Sep 12, 2025 at 12:31 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 8/1/25 12:15, Luis Henriques wrote:
>>>>>>>>>>>>>> On Thu, Jul 31 2025, Darrick J. Wong wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrote:
>>>>>>>>>>>>>>>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
>>>>>>>>>>>>>>>>> could restart itself.  It's unclear if doing so will actually enable us
>>>>>>>>>>>>>>>>> to clear the condition that caused the failure in the first place, but I
>>>>>>>>>>>>>>>>> suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
>>>>>>>>>>>>>>>>> aren't totally crazy.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I'm trying to understand what the failure scenario is here.  Is this
>>>>>>>>>>>>>>>> if the userspace fuse server (i.e., fuse2fs) has crashed?  If so, what
>>>>>>>>>>>>>>>> is supposed to happen with respect to open files, metadata and data
>>>>>>>>>>>>>>>> modifications which were in transit, etc.?  Sure, fuse2fs could run
>>>>>>>>>>>>>>>> e2fsck -fy, but if there are dirty inode on the system, that's going
>>>>>>>>>>>>>>>> potentally to be out of sync, right?
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> What are the recovery semantics that we hope to be able to provide?
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> <echoing what we said on the ext4 call this morning>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> With iomap, most of the dirty state is in the kernel, so I think the new
>>>>>>>>>>>>>>> fuse2fs instance would poke the kernel with FUSE_NOTIFY_RESTARTED, which
>>>>>>>>>>>>>>> would initiate GETATTR requests on all the cached inodes to validate
>>>>>>>>>>>>>>> that they still exist; and then resend all the unacknowledged requests
>>>>>>>>>>>>>>> that were pending at the time.  It might be the case that you have to
>>>>>>>>>>>>>>> that in the reverse order; I only know enough about the design of fuse
>>>>>>>>>>>>>>> to suspect that to be true.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Anyhow once those are complete, I think we can resume operations with
>>>>>>>>>>>>>>> the surviving inodes.  The ones that fail the GETATTR revalidation are
>>>>>>>>>>>>>>> fuse_make_bad'd, which effectively revokes them.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Ah! Interesting, I have been playing a bit with sending LOOKUP requests,
>>>>>>>>>>>>>> but probably GETATTR is a better option.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> So, are you currently working on any of this?  Are you implementing this
>>>>>>>>>>>>>> new NOTIFY_RESTARTED request?  I guess it's time for me to have a closer
>>>>>>>>>>>>>> look at fuse2fs too.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Sorry for joining the discussion late, I was totally occupied, day and
>>>>>>>>>>>>> night. Added Kevin to CC, who is going to work on recovery on our
>>>>>>>>>>>>> DDN side.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Issue with GETATTR and LOOKUP is that they need a path, but on fuse
>>>>>>>>>>>>> server restart we want kernel to recover inodes and their lookup count.
>>>>>>>>>>>>> Now inode recovery might be hard, because we currently only have a
>>>>>>>>>>>>> 64-bit node-id - which is used my most fuse application as memory
>>>>>>>>>>>>> pointer.
>>>>>>>>>>>>>
>>>>>>>>>>>>> As Luis wrote, my issue with FUSE_NOTIFY_RESEND is that it just re-sends
>>>>>>>>>>>>> outstanding requests. And that ends up in most cases in sending requests
>>>>>>>>>>>>> with invalid node-IDs, that are casted and might provoke random memory
>>>>>>>>>>>>> access on restart. Kind of the same issue why fuse nfs export or
>>>>>>>>>>>>> open_by_handle_at doesn't work well right now.
>>>>>>>>>>>>>
>>>>>>>>>>>>> So IMHO, what we really want is something like FUSE_LOOKUP_FH, which
>>>>>>>>>>>>> would not return a 64-bit node ID, but a max 128 byte file handle.
>>>>>>>>>>>>> And then FUSE_REVALIDATE_FH on server restart.
>>>>>>>>>>>>> The file handles could be stored into the fuse inode and also used for
>>>>>>>>>>>>> NFS export.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I *think* Amir had a similar idea, but I don't find the link quickly.
>>>>>>>>>>>>> Adding Amir to CC.
>>>>>>>>>>>>
>>>>>>>>>>>> Or maybe it was Miklos' idea. Hard to keep track of this rolling thread:
>>>>>>>>>>>> https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
>>>>>>>>>>>
>>>>>>>>>>> Thanks for the reference Amir! I even had been in that thread.
>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Our short term plan is to add something like FUSE_NOTIFY_RESTART, which
>>>>>>>>>>>>> will iterate over all superblock inodes and mark them with fuse_make_bad.
>>>>>>>>>>>>> Any objections against that?
>>>>>>>>>>
>>>>>>>>>> What if you actually /can/ reuse a nodeid after a restart?  Consider
>>>>>>>>>> fuse4fs, where the nodeid is the on-disk inode number.  After a restart,
>>>>>>>>>> you can reconnect the fuse_inode to the ondisk inode, assuming recovery
>>>>>>>>>> didn't delete it, obviously.
>>>>>>>>>
>>>>>>>>> FUSE_LOOKUP_HANDLE is a contract.
>>>>>>>>> If fuse4fs can reuse nodeid after restart then by all means, it should sign
>>>>>>>>> this contract, otherwise there is no way for client to know that the
>>>>>>>>> nodeids are persistent.
>>>>>>>>> If fuse4fs_handle := nodeid, that will make implementing the lookup_handle()
>>>>>>>>> API trivial.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I suppose you could just ask for refreshed stat information and either
>>>>>>>>>> the server gives it to you and the fuse_inode lives; or the server
>>>>>>>>>> returns ENOENT and then we mark it bad.  But I'd have to see code
>>>>>>>>>> patches to form a real opinion.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> You could make fuse4fs_handle := <nodeid:fuse_instance_id>
>>>>>>>>> where fuse_instance_id can be its start time or random number.
>>>>>>>>> for auto invalidate, or maybe the fuse_instance_id should be
>>>>>>>>> a native part of FUSE protocol so that client knows to only invalidate
>>>>>>>>> attr cache in case of fuse_instance_id change?
>>>>>>>>>
>>>>>>>>> In any case, instead of a storm of revalidate messages after
>>>>>>>>> server restart, do it lazily on demand.
>>>>>>>>
>>>>>>>> For a network file system, probably. For fuse4fs or other block
>>>>>>>> based file systems, not sure. Darrick has the example of fsck.
>>>>>>>> Let's assume fuse4fs runs with attribute and dentry timeouts > 0,
>>>>>>>> fuse-server gets restarted, fsck'ed and some files get removed.
>>>>>>>> Now reading these inodes would still work - wouldn't it
>>>>>>>> be better to invalidate the cache before going into operation
>>>>>>>> again?
>>>>>>>
>>>>>>> Forgive me, I was making a wrong assumption that fuse4fs
>>>>>>> was using ext4 filehandle as nodeid, but of course it does not.
>>>>>>
>>>>>> Well now that you mention it, there /is/ a risk of shenanigans like
>>>>>> that.  Consider:
>>>>>>
>>>>>> 1) fuse4fs mount an ext4 filesystem
>>>>>> 2) crash the fuse4fs server
>>>>>> <fuse4fs server restart stalls...>
>>>>>> 3) e2fsck -fy /dev/XXX deletes inode 17
>>>>>> 4) someone else mounts the fs, makes some changes that result in 17
>>>>>>    being reallocated, user says "OOOOOPS", unmounts it
>>>>>> 5) fuse4fs server finally restarts, and reconnects to the kernel
>>>>>>
>>>>>> Hey, inode 17 is now a different file!!
>>>>>>
>>>>>> So maybe the nodeid has to be an actual file handle.  Oh wait, no,
>>>>>> everything's (potentially) fine because fuse4fs supplied i_generation to
>>>>>> the kernel, and fuse_stale_inode will mark it bad if that happens.
>>>>>>
>>>>>> Hm ok then, at least there's a way out. :)
>>>>>>
>>>>>
>>>>> Right.
>>>>>
>>>>>>> The reason I made this wrong assumption is because fuse4fs *can*
>>>>>>> already use ext4 (64bit) file handle as nodeid, with existing FUSE protocol
>>>>>>> which is what my fuse passthough library [1] does.
>>>>>>>
>>>>>>> My claim was that although fuse4fs could support safe restart, which
>>>>>>> cannot read from recycled inode number with current FUSE protocol,
>>>>>>> doing so with FUSE_HANDLE protocol would express a commitment
>>>>>>
>>>>>> Pardon my naïvete, but what is FUSE_HANDLE?
>>>>>>
>>>>>> $ git grep -w FUSE_HANDLE fs
>>>>>> $
>>>>>
>>>>> Sorry, braino. I meant LOOKUP_HANDLE (or FUSE_LOOKUP_HANDLE):
>>>>> https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
>>>>>
>>>>> Which means to communicate a variable sized "nodeid"
>>>>> which can also be declared as an object id that survives server restart.
>>>>>
>>>>> Basically, the reason that I brought up LOOKUP_HANDLE is to
>>>>> properly support NFS export of fuse filesystems.
>>>>>
>>>>> My incentive was to support a proper fuse server restart/remount/re-export
>>>>> with the same fsid in /etc/exports, but this gives us a better starting point
>>>>> for fuse server restart/re-connect.
>>>>
>>>> Sorry for resurrecting (again!) this discussion.  I've been thinking about
>>>> this, and trying to get some initial RFC for this LOOKUP_HANDLE operation.
>>>> However, I feel there are other operations that will need to return this
>>>> new handle.
>>>>
>>>> For example, the FUSE_CREATE (for atomic_open) also returns a nodeid.
>>>> Doesn't this means that, if the user-space server supports the new
>>>> LOOKUP_HANDLE, it should also return an handle in reply to the CREATE
>>>> request?
>>>
>>> Yes, I think that's what it means.
>>>
>>>> The same question applies for TMPFILE, LINK, etc.  Or is there
>>>> something special about the LOOKUP operation that I'm missing?
>>>>
>>>
>>> Any command returning fuse_entry_out.
>>>
>>> READDIRPLUS, MKNOD, MKDIR, SYMLINK
>>
>> Btw, checkout out <libfuse>/doc/libfuse-operations.txt for these
>> things. With double checking, though, the file was mostly created by AI
>> (just added a correction today). With that easy to see the missing
>> FUSE_TMPFILE.
>>
>>
>>>
>>> fuse_entry_out was extended once and fuse_reply_entry()
>>> sends the size of the struct.
>>
>> Sorry, I'm confused. Where does fuse_reply_entry() send the size?
>>
>>> However fuse_reply_create() sends it with fuse_open_out
>>> appended and fuse_add_direntry_plus() does not seem to write
>>> record size at all, so server and client will need to agree on the
>>> size of fuse_entry_out and this would need to be backward compat.
>>> If both server and client declare support for FUSE_LOOKUP_HANDLE
>>> it should be fine (?).
>>
>> If max_handle size becomes a value in fuse_init_out, server and
>> client would use it? I think appended fuse_open_out could just
>> follow the dynamic actual size of the handle - code that
>> serializes/deserializes the response has to look up the actual
>> handle size then. For example I wouldn't know what to put in
>> for any of the example/passthrough* file systems as handle size - 
>> would need to be 128B, but the actual size will be typically
>> much smaller.
> 
> name_to_handle_at ?
> 
> I guess the problem here is that technically speaking filesystems could
> have variable sized handles depending on the file.  Sometimes you encode
> just the ino/gen of the child file, but other times you might know the
> parent and put that in the handle too.

Yeah, I don't think it would be reliable for *all* file systems to use
name_to_handle_at on startup on some example file/directory. At least
not without knowing all the details of the underlying passthrough file
system.


Thanks,
Bernd

