Return-Path: <linux-fsdevel+bounces-49132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E462AB8649
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 14:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95887A044B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 12:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5217298CBF;
	Thu, 15 May 2025 12:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="WrLkiSDI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011065.outbound.protection.outlook.com [40.107.74.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BC02253B5;
	Thu, 15 May 2025 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747311515; cv=fail; b=kRuHfqlBWENY4imUi7iUYVitpwyPx9c5iFTbfZoeVUeT4LsmuoOz7IILGSe+8ZYntgx74oDmID9zp2bvsgumpIcrm7tzqM74v96LP5y2/LlHtLaSj8AbRg+jTB1jdWY7cVwf/9dojrTRdKLsyQyU22rJp/6a7VKhwYd5JhXReHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747311515; c=relaxed/simple;
	bh=WvPVdK/PL0I2rpYecs6BPKejZN2KI1Y5AD8S56Yv7Xs=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mtv2cO9afypL5ClnxzzmX31f4e5UfrjsHTTJE++8AMQa6BMl3hYJEh3adaoZaS9JzI0Yv6x82Va02CCrT9EM0DJQa+he60nqiiYftPoyYXCQATxUj8n7OQU5WW4nG1D5Bbqb66SgaNEClGHA0mOGc6rGaVxeddaa+BLmJpmwWYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com; spf=pass smtp.mailfrom=nec.com; dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b=WrLkiSDI; arc=fail smtp.client-ip=40.107.74.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTSJ24gWp0D99zkgfdnuc5Yh/6oBvFXcxEVgN686I1VhOS0mAf+KryUPJ3Si6qTNbWaXbtyRhyCo+13gYDqBM908CUCo2ijCpvvlJIAFm834o39I+20osADRXD5Ibxd3fZ1AtMZo6VO8cKBgU0Bna2aGk79SGAMTzYAfdMWQK0X5CPgYgBmJbl+prYc1FDyvSgxFtwrHbk6Minqo0BqQrpvIYDWGqiQAiVwMPfNtntX32v2knrytUip6Bpir4Wv2CAgS7wiNgcZ7rhUxNWG5IPEACe3j/os/qcbtHzUcUgRgb/9ZMJ4Hh+pB27ETVju8vyluJamHCw3FrgCQ6e3l/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K3BJwYOlyZ00cybiIgm8zvEvDVlpQZu54rGmW+InvqU=;
 b=glZ+TGomdJyN3xL97hLaPCaxDwHn3lmdgGuokH+SjD+wh3VLB2ILTkWfXlm8I6pp1vaIkP7LDV78ATkP2Sz20a+TXeITjZVlZiCpdbmnHibkjvtr5W9R/0co4tKVg9CxkXG8Mnn00HyQkAfp3wPLfZzSdcilANnE2mAbrDKNnw1+OgsUxJTPwYT6wVnFyMCf2fG+dwhKj2eUGpXKCIGBHWF9pt/HcZwlJM2Dhf5eTYS5qtybdZOW2RcZxH7mS+wo71aMMoDEtBW/Ggmvzon4CS7ee6flvmwHWcYuuLijmGbMAwg4HhaeTph6V11HFly+Oht+z6bmw05pi0K0GJlHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K3BJwYOlyZ00cybiIgm8zvEvDVlpQZu54rGmW+InvqU=;
 b=WrLkiSDI1sWR1YNtdi5A+YqNIhBSBFS2oZEl5ja6LpNa0Sz6Rlg7J3QxWyISq07E3ilUcanfR+YZU4FvDsBclnp67Kx3jDOgHudD6dbA7kB5F7kVIsU61C2/FC7/jF1BqSuCeN8Cu6Keyfq0Ne9KxZbmA08Ejbdp7ueJjpLaY1KUfRKiywGDkyhnLLZSKnzIAnfCz2Fi2GilP9wHDKhAyu3GDIS/6o4BHeYnqcuSFIORuIQ/2HL4RdE5sbq1wJ19ZXyr6USrcjD6RzWeCq74VgChxtMbdPG8HuZZ781yIh2rP62BnBZQtcwrNJJclGVj4rqAxG97qHZ+qsZUYCXUGw==
Received: from OS3PR01MB9659.jpnprd01.prod.outlook.com (2603:1096:604:1e9::7)
 by TYAPR01MB6091.jpnprd01.prod.outlook.com (2603:1096:402:34::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 12:18:30 +0000
Received: from OS3PR01MB9659.jpnprd01.prod.outlook.com
 ([fe80::9458:e2d1:f571:4676]) by OS3PR01MB9659.jpnprd01.prod.outlook.com
 ([fe80::9458:e2d1:f571:4676%7]) with mapi id 15.20.8722.027; Thu, 15 May 2025
 12:18:30 +0000
From: =?iso-2022-jp?B?S09ORE8gS0FaVU1BKBskQjZhRiMhIU9CPz8bKEIp?=
	<kazuma-kondo@nec.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>
CC: "mike@mbaynton.com" <mike@mbaynton.com>, "miklos@szeredi.hu"
	<miklos@szeredi.hu>, "amir73il@gmail.com" <amir73il@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?iso-2022-jp?B?S09ORE8gS0FaVU1BKBskQjZhRiMhIU9CPz8bKEIp?=
	<kazuma-kondo@nec.com>
Subject: [PATCH v2] fs: allow clone_private_mount() for a path on real rootfs
Thread-Topic: [PATCH v2] fs: allow clone_private_mount() for a path on real
 rootfs
Thread-Index: AQHbxZN4xoBvq1+jxUOzQn1rRYIf8w==
Date: Thu, 15 May 2025 12:18:30 +0000
Message-ID: <20250515122057.159582-1-kazuma-kondo@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.49.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB9659:EE_|TYAPR01MB6091:EE_
x-ms-office365-filtering-correlation-id: 1d588995-5839-42db-0335-08dd93aa9a8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?bEVjZTFhalJXRDJYclFRNWFVNFQ2N0FNQ295R2NzL1ZmeWNKTEtzcStJ?=
 =?iso-2022-jp?B?RW9tdE8xL29ETUplWXNEQno4MVZDeG1VR1B4OXhIUnZUSlBCbU0xa1hs?=
 =?iso-2022-jp?B?bEl5bmlaV3o0clRTS0FoTFF4Vyt5NE9hUmowb0orUXdtK3NLK1BlOW9F?=
 =?iso-2022-jp?B?b0F5Rk9GaG0xWCtEVS9JS29SamdBZ2pjbm0zMGZzZm5iVXlIWkg2S21F?=
 =?iso-2022-jp?B?QmpUQTBJOEVwdDEzdDZoSnE3U0tVWEZRbGlEYU1NQkZ2dC9Va05OYTFG?=
 =?iso-2022-jp?B?TmNGRldVVjV3QStYMHNielExUmVWU2RURyt0M00vVWtONnhNYllONUQv?=
 =?iso-2022-jp?B?Ymc3VzBjV0ZIR3RoNGhwSkVyQ0VMdER3ZzZnUWFzMGFEdHhoNWp5aDZi?=
 =?iso-2022-jp?B?V1Z2V2JsYWxQeHRJb1pnQjRFRUszSFVBVisycHZpdFI0TTFjcklGeFFv?=
 =?iso-2022-jp?B?OVpibHhWV2RyODQwSVdUdkxpU3p1Um4wazlEMUx4eVhPZ1Q1MllkMmZK?=
 =?iso-2022-jp?B?VG9SenNhZy9QZEZUblhLREJoQWl2RzA1TVl3OVF1VTFRbUVLTjVDUzJW?=
 =?iso-2022-jp?B?SEpTUVh3Y0VTZUlYbzZIMm1oS1oyY1piQU1zWWxQMEJtV0E3KzFCWGpm?=
 =?iso-2022-jp?B?SkJVMGVMbU5GRVNSNFV4U2tBc2dzRGZ4ZVpJQnppdlVtRlllS1lWbE1O?=
 =?iso-2022-jp?B?YzlEMHdvRENYSGtEZnNJQ2IxdURjVDQvc1FYeWpnVFMySCtxYktjSm4x?=
 =?iso-2022-jp?B?TzhCb3JMdjAySUdTUzFkeGpnVkJGRTgxMHhGNWR0Tkl0bW8yRlNrdlJQ?=
 =?iso-2022-jp?B?dE5yZ0hSc2NuYm1OaVVkMmNRbHFXOHJJaHpSS1U5a2tuenBBeFJIb0tQ?=
 =?iso-2022-jp?B?eW5ITVI5SEZReGxCcURLMUhxaDlFZHNlNk1vaFI3bEpEaU5xVXlxQXVs?=
 =?iso-2022-jp?B?QTNjOVEyV0FjTTV5emZWUi9LWnVDdmVtWVpLZzJOQnZpRmNpRTlVd1RV?=
 =?iso-2022-jp?B?Tys3Y3c5Z0JOemRIaHhmVWFMaFA0ZjhXZnhhNUR0a2JGWDhMUnl4SEkw?=
 =?iso-2022-jp?B?NDNXVGR0NTRMMWFOdGRRRzFEbzQzUFBCMUxSaG9HOVRTOGxSL2I4NUJE?=
 =?iso-2022-jp?B?Z3QzQTdBcHpCbHpZUWpzQnJ0SzZJemhRS3NzaGlpbmQzYmlleE4yeXdx?=
 =?iso-2022-jp?B?dngrZlBERDNJMzQ0VFNMT29UdG1RY0dZRStHeXlRaUhJRjMyVE5ocFJk?=
 =?iso-2022-jp?B?UDlCb3duOHVUNEl6RVY0c0pIQStMdURpRTJvNFExNjlWZE51dGtaOFJD?=
 =?iso-2022-jp?B?aUR3anVCUXg0ZEI4U2hncWlHZ0svTDRFclJyYVZIeUJKZHNzMldpekJ6?=
 =?iso-2022-jp?B?Sjhzc21OckRkbEowSThTUnQ4dUdpNEg5N0ZKaG81Vnl1VWhVRDhVRHJv?=
 =?iso-2022-jp?B?R3VZUm9mVDhJUnZRR1pHU2xRbFMzMG9FUmtYU2VDb1RYUmxaTDV1S2pO?=
 =?iso-2022-jp?B?Wjl3SWZZQUp5NzJkMlU0ZW8zZzEybURWYno2cW9HVWFGeG1raUVCRS81?=
 =?iso-2022-jp?B?aDVYb0M3OUNrN2pTaW50YUo0ajNxeVU3L2kxMkpGZC85MmFDcUppdGtB?=
 =?iso-2022-jp?B?aHRUUjA2Q0NpRmNzL3R1Ni9oQ2NkYXhQRlh1MEFscjNobGtKYURuRDNW?=
 =?iso-2022-jp?B?UHgvT0NtS1RQUUFxRGsrNWg5RFFqM0hUSkNCUG9wUHJMcFBaRXZHSy9V?=
 =?iso-2022-jp?B?MVhyV3dNODZZUmdOdTIrWkc5Rk9HdUtGZ2FZM2U5Uld0ZXYyNUNzVEZ0?=
 =?iso-2022-jp?B?YjI1Z2FuZkpQc3RFem1vZnVoUGpEZi8rekg3dGVkNnBkVW9uOGJzY3RX?=
 =?iso-2022-jp?B?YVlsSnhYOG9aSmIzTG1ENEJGWG1pL2E2SHlnK3NlR25JaDRRVS83U2tG?=
 =?iso-2022-jp?B?VklMQkFaQnVvcmFpT2gwQndCWExJM2k2eiszdXYzaXVWQ2RFdVEwY0Vn?=
 =?iso-2022-jp?B?SHRkTVF1aktFa2FtU205OS90YXNwcWZ6a1VWTVhnUzYxREFwMzJ6cTcv?=
 =?iso-2022-jp?B?SysxSk5MQXZzcThRVEpuQithRWJVbVE3QWs3UXFUdk1Yb2hCYUY2Wm1k?=
 =?iso-2022-jp?B?MzZ1WWUrQnNVT0tIR1NFM0QvY005dHVkU1V4QUN2Y0Q3RTdiTmZkb2p5?=
 =?iso-2022-jp?B?TVVjPQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB9659.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?cmZKTkRaNnJqKzdST1hJcWsvbyttR0wxUk1tMXlTWlRpSFNmYytWVXhw?=
 =?iso-2022-jp?B?SzBIUlVXUGJDY3EwbUVUcWVpdk5ZQ0pKVXNlNlJUOGNQbVZselBkQVY0?=
 =?iso-2022-jp?B?NDh2ODB0R1hjcHF4NVY0a1Y2azY4Tm9PMWhkeGZRTEJWdVoraktUQkl2?=
 =?iso-2022-jp?B?eElpUCtXdmZDNFo2UGlndVU4UGk5bmNFTXEvWW5YM3ZHSzlONlVmQmd3?=
 =?iso-2022-jp?B?KzdUZmJxaFNDbnl1QXNzRUViemhhVUhJZHhkM0paMDZsaEh2dm1Hd1I1?=
 =?iso-2022-jp?B?NEg2VGNPVVFLbE83V3RvSGVFemdzK2Q1Wnk1MHVVSlJCYk5qWTYyTTZ4?=
 =?iso-2022-jp?B?YmtaMWs1OVh3d2ZqSElLUVJ1dWpNZEpZUjVXTmdlWEZHN3ZPdlNhc082?=
 =?iso-2022-jp?B?dU91OGpMLzlxTzV3TEVjTHVXc3ZEUURHeG9DZjVSVGtucFZDanhCY0dG?=
 =?iso-2022-jp?B?ZDI3YVNrSjdiTjQxSGsyNHpKcVc0REZyZm00bEdEc1FOSG15Y0h2bG9t?=
 =?iso-2022-jp?B?R0VXdThVb3ZOY1VMMVpVZi9kQ1FRN1Fqa1V4VjllWE9POUhucmZBdDQ4?=
 =?iso-2022-jp?B?OHQvblBvNk5Uclg5aUVPSzM4MmpZRGM3YlpJZzFUd3dodnJmWXFuQUlt?=
 =?iso-2022-jp?B?T3FUNkpBblE3MmxvYnBTUWh2QlR3YkJsYytaVTdpY2VpbDdQRmRwOWx2?=
 =?iso-2022-jp?B?U1Q0a2Z2Qkl2Vzd0czY3S3l3aEo1UnNqT05zWkxvMHpoY2VrZTJ5MzY4?=
 =?iso-2022-jp?B?dEM1K3NvUWJtdWNtM2pLOG5EOEliSlJMaGdyM3FIMXEyOHM2cEFwajBx?=
 =?iso-2022-jp?B?TWtYNngwbmpvdFF1Q0twSExNaW1qNSt3ZUREbXVjYjJiSm5oQzZwTm5Y?=
 =?iso-2022-jp?B?TjlwZFRoTXdTaGFGSE5qd2x0MENxQldqY05Kdy92VXJMKzNlWmZVYmxY?=
 =?iso-2022-jp?B?VVVPZjl5ckpOc01RSXhnLzJKTkFPWjY5dUJJTlVzelQvS0lta1RNVjhr?=
 =?iso-2022-jp?B?ZldVUG15ckVTTDMxNUhUNHhPWHllNkg0d1FNKy9RZUsyb0NoRjJReWNv?=
 =?iso-2022-jp?B?STVETzVuNG1WYzZVZkJrS1c2NXRoclZCbUdGWW9scDVSaWsvMFpYb2hp?=
 =?iso-2022-jp?B?bkQxb0t4STQ3TEhvRzlZZFJqWFF2UmxIYnFDTTRzbGJuSlZoSW9Wbm9O?=
 =?iso-2022-jp?B?ZUR6Z0tKckJHMzU4L09YQSsxdTFlUnNVY0dsWXVZOEZoS2s5NCtYWVpm?=
 =?iso-2022-jp?B?SFNDV1d0Tk1abXc1UmUreTdVV0JPS1RkZVNPZy9QSWsrenpJWkdIUHNY?=
 =?iso-2022-jp?B?Y0x4eGlyT0hnUk1RWTJHWU9DRng5YWFWcDB4TUZUY1F6cXBvSkF2b2VW?=
 =?iso-2022-jp?B?M0hPSDFLMTlFS0p6eXBBUTVEa0ZqQjRrOWpUUy9QRTdIK2RYa2ZCMFpv?=
 =?iso-2022-jp?B?OVZHRC9iQldTUnlVVGI2eVRRZnlnWSsyUWV2Nzl1TFcwZVJhQ1Z2enNh?=
 =?iso-2022-jp?B?Sldwd2R5N1hJODVYL2VMaSszOVpDOWJ3ZDRYbkZrTzVIZzZVdWRhaitY?=
 =?iso-2022-jp?B?UG5FaktnR0tqRXlNbEZHTktZOEI4Y05OaUlzcVJHLzkrdkM3am4xaGhn?=
 =?iso-2022-jp?B?UnhPV2FxUy9LdmppdWR0aFVMWEVXcUd6M3IvQkJ1TjlzbFdwMnZzcjhM?=
 =?iso-2022-jp?B?V1drc1dlN3JiK2RGdlV5a2JxaWhxOTkvYjBuWmhYTE1CUG0zUSsyRVdS?=
 =?iso-2022-jp?B?WEx0Z0krc1JFWnV5SHZJcnJUSitiVHVVTTRuMWdHTHZZYU1mMmp5eUhQ?=
 =?iso-2022-jp?B?Y2lPSzM5OWZHaVM2eXBpOVFrbWRDRldmMVVndkk2MGlKM1ZTMllzUlAy?=
 =?iso-2022-jp?B?QXpycUNPY1Rqd2ZSU0d0T1JHcDRPdU5reGZJeXRwWTlsbkdKUjZZV3pH?=
 =?iso-2022-jp?B?UUl2YnR0NGtreUVCcHBiaFFYc0FjTTRNMlZRUk1HSFR5YXc0MVdBVEhX?=
 =?iso-2022-jp?B?eDFBL2VxNExQOE1WMWFVWXFvemdPdVpGSUxReTdFeVdSMmZId0xhNHdh?=
 =?iso-2022-jp?B?RVN5UndaTjAveWJZc3FaK3B1SllqRGpLd2JvMUtJcFdwUWpYYzhVZjFB?=
 =?iso-2022-jp?B?dzNXSzI4TzdScnhYcHdDaWFsTjFkanFFZjhDS1huaUo2UUY1UW9HMGt0?=
 =?iso-2022-jp?B?bWlkcTZPazBMSEwxM01lbStuQlRuRG1UZ1EraTk1bkVmUExzR3l0c1Bj?=
 =?iso-2022-jp?B?VlltS25Mb3BOdzZCM3NUbERSTWNQZ2R1V2UyUEtjT2U2T2o1YisxNXV2?=
 =?iso-2022-jp?B?US9DLzhqSm5EZlR5cy81N1JXalhuWXhQTHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB9659.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d588995-5839-42db-0335-08dd93aa9a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2025 12:18:30.2643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r3qyD5qpLjiEOHWEFBjMYZqvXh1FmEZ/wroac/gMRx/1jt3XAy8cSl6fS2du2jJNvC6BXVwCfivy17BUtvj51g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6091

Mounting overlayfs with a directory on real rootfs (initramfs)
as upperdir has failed with following message since commit
db04662e2f4f ("fs: allow detached mounts in clone_private_mount()").

  [    4.080134] overlayfs: failed to clone upperpath

Overlayfs mount uses clone_private_mount() to create internal mount
for the underlying layers.

The commit made clone_private_mount() reject real rootfs because
it does not have a parent mount and is in the initial mount namespace,
that is not an anonymous mount namespace.

This issue can be fixed by modifying the permission check
of clone_private_mount() following [1].

Fixes: db04662e2f4f ("fs: allow detached mounts in clone_private_mount()")
Link: https://lore.kernel.org/all/20250514190252.GQ2023217@ZenIV/ [1]
Link: https://lore.kernel.org/all/20250506194849.GT2023217@ZenIV/
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Kazuma Kondo <kazuma-kondo@nec.com>
---
Changes in v2:
- Rewrite a code following [1].
- Add a comment for a condition.
- Link to v1: https://lore.kernel.org/all/20250514002650.118278-1-kazuma-ko=
ndo@nec.com/
---
 fs/namespace.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 1b466c54a357..306d144d691b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2482,18 +2482,19 @@ struct vfsmount *clone_private_mount(const struct p=
ath *path)
 	if (IS_MNT_UNBINDABLE(old_mnt))
 		return ERR_PTR(-EINVAL);
=20
-	if (mnt_has_parent(old_mnt)) {
-		if (!check_mnt(old_mnt))
-			return ERR_PTR(-EINVAL);
-	} else {
-		if (!is_mounted(&old_mnt->mnt))
-			return ERR_PTR(-EINVAL);
-
-		/* Make sure this isn't something purely kernel internal. */
-		if (!is_anon_ns(old_mnt->mnt_ns))
+	/*
+	 * Make sure the source mount is acceptable.
+	 * Anything mounted in our mount namespace is allowed.
+	 * Otherwise, it must be the root of an anonymous mount
+	 * namespace, and we need to make sure no namespace
+	 * loops get created.
+	 */
+	if (!check_mnt(old_mnt)) {
+		if (!is_mounted(&old_mnt->mnt) ||
+			!is_anon_ns(old_mnt->mnt_ns) ||
+			mnt_has_parent(old_mnt))
 			return ERR_PTR(-EINVAL);
=20
-		/* Make sure we don't create mount namespace loops. */
 		if (!check_for_nsfs_mounts(old_mnt))
 			return ERR_PTR(-EINVAL);
 	}
--=20
2.49.0

