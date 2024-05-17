Return-Path: <linux-fsdevel+bounces-19665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 209058C861F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 14:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4A11F27232
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 12:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740CC405FC;
	Fri, 17 May 2024 12:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PVOXGhc9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2110.outbound.protection.outlook.com [40.107.20.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB68168C4;
	Fri, 17 May 2024 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715947576; cv=fail; b=HDRRMysZ5G3sH3nSrOU4vtx6BAPupN0dwlm0haKBXIrqBzk25J1mb0cN/ZwuW6gQ7TDO+JrqnRSW7+TsfK2az8GJfmuIpRO913Y3RSytoOJfv/BiZ5Xex6t1xvG9xbd/LvGWLwNeqW2tc7HtakuCD89CS6vHoC01MpFxRyvRjCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715947576; c=relaxed/simple;
	bh=OWE/0Kp46jlqUNIBdCJbV9+cXvx+fLBqB3fl39Q6XUc=;
	h=From:Date:Subject:Message-Id:To:Cc:MIME-Version:Content-Type; b=GILGjnOirVb1AameHzY33lsw84xYHBKe+/0uGwH9A68/YYIGNpgEtYNqjVw7taOkSc11X22h3T7pwRFFdPYNDttwG4MYZ1v1mGVBDbzn8CzWXtS2MwNJwxY2/6XJ91J3ijjtIvcVn4SfYoEwCMwSl2yBro48FcIMUX7hIDDHFSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PVOXGhc9; arc=fail smtp.client-ip=40.107.20.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkCvqornph2uwSTkMYVOR98ypLeaWItuBbnspA+e4vPY7qTXW6sxnEb1OUWzJiJEhrYQ1/gW2ZnZxevy3j/BhbRFcBkr6d/GgpBI1NQ5gPU4GkYYKXEWJkTZEaieCD9NY/di9+D9kxV2E4X9s6B66i6yhFpV0sJnaogi9s+gu044KeIGac8AZI43uydXEJOwbgkMohFPENH7gVmSM86K+aGS/OUUevmyH+4uxgi3j+HOpON2jwDcslkTJnUiMVw9fHkJEUXfem/cSm0wmwLgX+6bKTqnonIAQ7Xt7oGJySHBwAy80BzfcqIvwKt7zfJDQFXF89yJd3DT4MtreGmH1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWE/0Kp46jlqUNIBdCJbV9+cXvx+fLBqB3fl39Q6XUc=;
 b=APdAevKzbzTXWkxeV4d0q51dfALSFcvrrNv5ESBELpS0FhexXL04ICsHNDJsVIr1UMvlr+e++D0SYQPtv96vx4I3ao6jnSPI2m7bFUBmwEvetoc+SlTWob26wdwZLHJswBVayItPngTZg+69X1CwL78dJDUP6hP3LXDOo2/Usqq0C+Sr1w/ZUJmIxOKdIgvYtFY+ohPrnf82EqRYvqyIaObJgBCTvz6+8h/FPIcBeFNcNE0jUWLuYUSpXv7RWGbLcK1vLjekW1jTwckeHjvRm2ZHjR6QQlfAT2KXqslIJFO846wffCYYOhhj+Nft1BscqZL6Q5ODPsNjES0/XzsnGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWE/0Kp46jlqUNIBdCJbV9+cXvx+fLBqB3fl39Q6XUc=;
 b=PVOXGhc9bisnVvFjK24jL/5VTF4S7yHdOL2KAMQvjPexEQhJ2FQbrvsMTnNLaZmaPAylbFEXzLFn4AueljMut1A7MKrQhWy1zLzDaPi8fLpQ0DFBHj3GshZ87Hz2+MzO1VKBfFAnOzka8foBZadrhw54HxgO0xHNHAFKEnUp7Bg=
Received: from substrate.office.com (2603:10a6:102:1ca::15) by
 PAXPR04MB8285.eurprd04.prod.outlook.com with HTTP via
 PA7P264CA0264.FRAP264.PROD.OUTLOOK.COM; Fri, 17 May 2024 12:06:12 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Fri, 17 May 2024 12:06:12 +0000
Subject: Recall: [PATCH] iomap: avoid redundant fault_in_iov_iter_readable()
 judgement when use larger chunks
Message-Id: <TN8WOD1U2NU4.OPKYOYERBNLP2@duzpr04mb9981>
To: brauner@kernel.org, djwong@kernel.org, willy@infradead.org, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, jun.li@nxp.com
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-MS-PublicTrafficType: Email
client-request-id: 9f7466ed-a623-db84-7d94-9177512e7338
request-id: 9f7466ed-a623-db84-7d94-9177512e7338
X-MS-TrafficTypeDiagnostic: PAXPR04MB8285:EE_MessageRecallEmail
X-MS-Exchange-RecallReportGenerated: true
X-MS-Exchange-RecallReportCfmGenerated: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0FXallPUDZyaUg3UHQ1TzBJV0hEbk1yV0Jzbk1Td2psT2lRL094U0hmK2NV?=
 =?utf-8?B?ODJzZ1dVY1FKQjh2dWpaYTVSUXJJL01NU1JuRklyb2FyekhNQ3JRTUFuWWZ4?=
 =?utf-8?B?K0FDamN6ckpJUGZkYzE0YTJkeERDdGxOTlJKZ3g5YkdadnR6NjBQUzdYK3d2?=
 =?utf-8?B?Q0NCUTB5Q3p2VGgwaENOWTdpRXNZM2hCb2xGT3B3LzdWN0NPR1g0emswbnZP?=
 =?utf-8?B?ZDh4Wm1pWUdxRkk3cUJaQzNBcGg0QmNhTFk5SWQ3dWtuZC9Ua00vUWJmOHNU?=
 =?utf-8?B?RHhQbWJOR0I3Smc4N3NjbTI2UkNWWGhJeS9uTmt4NTR1Njdwblc2TjAraWlG?=
 =?utf-8?B?ZDZZcHZ4TlZFdVY0YnlSTUV3ZXV3eDdvVmlUUHFXRkUrL21YdFNkVDl2ZGVE?=
 =?utf-8?B?OTI3c3VONURGZ09ZYUdKK3pJWlUwL25KZC9aczlsaEVXOWFLNGh1anQrRm0v?=
 =?utf-8?B?NUthY0I4L3phUmFpaFJiQU14TjExdUYvekRjRjRCUy9RYWpqU0hxZG1SU3U4?=
 =?utf-8?B?ZHV2WlBKVU0wNHU1M041NWR2bzdDNEM2ZjFtTStqMDBOOU5pcFFYd3FNWCt3?=
 =?utf-8?B?WC9MZm1wSXhXQzFWeGQzQlBmSm5ndWZwVDhmMXhUR3VMT2t4TzRZVWtOSTdG?=
 =?utf-8?B?SHE0eGVST0RIUEdMQTgwbXNOYTdtK280anNWSEtqZnJhYVBQbjhHWGF5VFNF?=
 =?utf-8?B?VHQ2UytrUmp3NTVvdUxnNXYwR3RvemhGTjdLMHM2SlVISVVlSEVWSkV4SWhx?=
 =?utf-8?B?OHRHK2ZETTZtYU41T0JSY0xDWGdYYVh2aCtSK2lVL3lwcnhCVndIMnBvZGVy?=
 =?utf-8?B?a3p5UTFHMGw4eThwc01RYUhVMnBSK2llRittcmhkZUxUQTFCTSsyQTdLcUFv?=
 =?utf-8?B?NXI3emx2L05ERE9aTXlNK09zUmhiZG9YNlRPNTdlWml4NjFMRmxDaEdOUWw3?=
 =?utf-8?B?ZVNrTi92WU8vVGVqV1VsWExRcDZGNWRDVFdTOFNrbHA0VDBubWJNZXJNajE4?=
 =?utf-8?B?eU94Z3BiMzRLZXVGSnA0aXlPRzlmalRZSnRZV21XdGtPK1hUMFhkTkp2TFd4?=
 =?utf-8?B?WGRTOCthVlkrTUEyRngvZGlLbmJudjQyTVJGNWx6YWZqTUwxbGV6V20yOWZM?=
 =?utf-8?B?WXJaMlhPYTc5QmxraVpoNFBjRzB2L3NQUlVoNG80cVVGYlVablBUcmIzNDI4?=
 =?utf-8?B?dGg2VmVRUlBtdjdtM28yTW94Y1NxWGhFTklOZm5GOGFQeHdOMEpaZDBLdGNC?=
 =?utf-8?B?bFVUM3pXeDZXT0VOcFBjYjdNUVI2d1NHNVphaUNzMVVrR1VNZjdwVDB2ZlVu?=
 =?utf-8?B?ME01T2VUR2ZRS0d1WEhheEFNdHpCd0pQYVl3WjJQY21TaDdjZzRzakVEVjJj?=
 =?utf-8?B?VmtoNnZnekpkWE5meWtMemhwVU10Nk5RY3NQaDFDc3k2RHhwVTdkOXl2MlU5?=
 =?utf-8?B?N3pXa3lSc2dNcU1zeHpGaUFtQkhtbGd4YitJMEVVVENYL1FYb2kzL3JEeWt3?=
 =?utf-8?B?TDlLV3BrWWhkc2N6QVIwWnhyK09VTHNzR1BYYnVaSlliSlIzd3JBTTlCR1pP?=
 =?utf-8?B?UkxJMHZDQjBBd1k5YW5OYlhEUU5GcTNZNTdTdk94VGplSGpHenZwR3RZb1lP?=
 =?utf-8?B?ZEhaNVhIV20yUmxTK3RwTzk1WEZpVTE1eTFvUEpUOWlVRE92OTFORXZZT2pL?=
 =?utf-8?B?eFp4UDRZeVJDdis2M3VkNmJHN2xjd0NWNWpKVkhRUnBxT09DNzl2Yml3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	9sNPGCmc3mdnNMTimZZ26vFoYlLh7DxrjCs/g2Y3My59KoGAI2aHlV0SEUTJj0LR8zLUc6oMzAF7OjU5cTPHnItcALVTZKwipXl7DyGYYzyIol3W65p6zrLNPMajzeGBClf+rc3AzOQMWolZYj3gH1sbkhnjOmuFagKcAT9QznuC0EAqosypmQzvn4XggZSMxxxSjbO1Aa1+14MrsMyvQS45dJElQfEW/WX2+dbVBKg+kb8VmioiAyNTPIyR+fwvdY3kVSepbw504NWn0SXuHmeebgyfVABoM11YN9xnQ4F9QA+Vshw4keMqA7ZmLWucGJoU2cyvoE+QJRoqtiwK9zCK/z6W8utoPhlkDerKJDTDVVAnJtUTpPfwlx2nU5N8itFratQCoaIrcm+elqVezFk8v7S1RdJMG1N5Vjhc5qA=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HttpSubmission-PAXPR04MB8285
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 12:06:12.3778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id:
	e2b13e83-ef53-44b2-0004-08dc7669beca
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8285

xu.yang_2@nxp.com would like to recall the message, "[PATCH] iomap: avoid redundant fault_in_iov_iter_readable() judgement when use larger chunks".

