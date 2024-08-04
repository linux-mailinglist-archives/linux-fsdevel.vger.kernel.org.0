Return-Path: <linux-fsdevel+bounces-24961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C29B49471BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 01:22:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC3BB20B3F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 23:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F48513C67E;
	Sun,  4 Aug 2024 23:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="PAICr7wX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2135.outbound.protection.outlook.com [40.107.220.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2811755C;
	Sun,  4 Aug 2024 23:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722813731; cv=fail; b=lkyuzpzFXTSkyw4PRkyZFK5AFW1ReLd4oxzi9BZziQ3LN6ISnc+X9IVGbT3ormTn9h2Hi/qzgGeX+d0mYoQlCRdXlEC7UStL+mUyUPXcS5eih98w9yZ+vOuXU3DxngMOvcSxceKLKIJrBT4vdZaD4sS09ecrylOnjP3VTQYYmm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722813731; c=relaxed/simple;
	bh=gbqWVtVtEVI3F+OI8tRieFYtXUdC+vTs5CNttn7U7Uc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c6C+1Myl8GuzjlOS4ZBTbfcKq34fVvL4KF8VI46MtxBQzKjm+3q3g7rgBHX8qJ3Ah3DD/UR0G3+ZMMNBKdOvaZtr9gwyvozhKYJdWdM7I0i9eSCRoRIwMJ4IeAj8F9xdsD9tYkh6bL0avWi4PoUAVGNE7C6FQk6aOVn1uVPGHlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=PAICr7wX; arc=fail smtp.client-ip=40.107.220.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4S3o2Ee0zZqXUHiJFi+XZuYfhmo9nKI7hcoFqB0cVdp5C6ulH+gQwbM7YovEcfKuYxgc2Zpw3xWC5ykPDX1Tg99dw1zBns6QMGtKdLGRbk9YOqSkPMoFFLIcTLoRQXcR5MKS8/x/UW54c4eH15ONB4FGjQLqYJJM86qdLE8aDD+F+nMYYRAUXp2h47Zzay4ukQd4ekcLauZZsN83Y2OXvYeaRlAbngDjMwgFUvV8crRbNoBRbieugCoFB4WHGSWSlbiwCk0oHPac/RTFpv2R1axHYi/VGyIbap3juQhPz+LuCYt0DQBCn+BCbdQ1aNATMUgGXyycJX662F3TjSrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbqWVtVtEVI3F+OI8tRieFYtXUdC+vTs5CNttn7U7Uc=;
 b=eG0NNDSmT7QskE/b/96ndMk3xS0i/AkQ4NU8XO7Rch553N3F9BGdz4FbfwR11892S2K6vQ/4sguWeqVaUa7Pr3o9dSBvIFQIGErlwYPMtoOXhAQsN0hVgBK8WFy41Ub0/9oivQdvDFkHMtjsj2eOxT9jGCnssO97lRnNBys8PuExOjva0b4KMrs00tWQxpjwrt4dtzD1G9dz/8D5VByaexflrTYJM1mwd8sqNL3NVOCvjfzlz/Q2Y9uK+plmc8jGud7pKbWZuGFTr+/07434h9FSR4TBfwvSbaG6E2pglc0MAVc0TAMGeRtxFW5IBocbylwcK59N4nUGIY5/SasR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbqWVtVtEVI3F+OI8tRieFYtXUdC+vTs5CNttn7U7Uc=;
 b=PAICr7wXYqND9ZtC+pfaIj9GXN8DVyXyaJiZKzH75jWYIPcZfeeAoR7B4yIPy33uIUflfY/0y53+Cvbyb1ih3cUT4s+QxwpqO8ncQzmfGNT1+46JCqIVXd8+2w67qHd8gFHUknezKNfzJ0Jfc4b94UoY4KOveJqxYdq7u9+1Vmg=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by MW4PR13MB5625.namprd13.prod.outlook.com (2603:10b6:303:180::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Sun, 4 Aug
 2024 23:22:06 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::67bb:bacd:2321:1ecb%4]) with mapi id 15.20.7828.023; Sun, 4 Aug 2024
 23:22:04 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "max.kellermann@ionos.com" <max.kellermann@ionos.com>, "hristo@venev.name"
	<hristo@venev.name>, "dhowells@redhat.com" <dhowells@redhat.com>
CC: "dan.aloni@vastdata.com" <dan.aloni@vastdata.com>, "xiubli@redhat.com"
	<xiubli@redhat.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netfs@lists.linux.dev"
	<netfs@lists.linux.dev>, "jlayton@kernel.org" <jlayton@kernel.org>,
	"idryomov@gmail.com" <idryomov@gmail.com>, "willy@infradead.org"
	<willy@infradead.org>, "blokos@free.fr" <blokos@free.fr>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] netfs: Set NETFS_RREQ_WRITE_TO_CACHE when caching is
 possible
Thread-Topic: [PATCH] netfs: Set NETFS_RREQ_WRITE_TO_CACHE when caching is
 possible
Thread-Index: AQHa5nZeXxhhTSZSo0iyVLaKinBVZrIXvU2A
Date: Sun, 4 Aug 2024 23:22:04 +0000
Message-ID: <ba17aecba9615f85b7901ea96609abdad3c29db1.camel@hammerspace.com>
References: <20240729091532.855688-1-max.kellermann@ionos.com>
	 <3575457.1722355300@warthog.procyon.org.uk>
	 <CAKPOu+9_TQx8XaB2gDKzwN-YoN69uKoZGiCDPQjz5fO-2ztdFQ@mail.gmail.com>
	 <CAKPOu+-4C7qPrOEe=trhmpqoC-UhCLdHGmeyjzaUymg=k93NEA@mail.gmail.com>
	 <3717298.1722422465@warthog.procyon.org.uk>
	 <CAKPOu+-4LQM2-Ciro0LbbhVPa+YyHD3BnLL+drmG5Ca-b4wmLg@mail.gmail.com>
	 <845520c7e608c31751506f8162f994b48d235776.camel@venev.name>
In-Reply-To: <845520c7e608c31751506f8162f994b48d235776.camel@venev.name>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hammerspace.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|MW4PR13MB5625:EE_
x-ms-office365-filtering-correlation-id: 87a0b4a9-328e-448d-c23e-08dcb4dc405e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|15866825006|41080700001;
x-microsoft-antispam-message-info:
 =?utf-8?B?UEJmTXRBMWdaeEJCSGJxUElScGJlekhKR28rY1U0V2tyUnR3UlhZRktwT3B3?=
 =?utf-8?B?U1NuNi9uUjJlRUVsQ01KblgzZnBaNDZIN0FBS0E5eUZYUklDV3ArK2Mxb2Fl?=
 =?utf-8?B?aTJINjNxUjdwRnBQekk2REVLM2U3cEtHTUFIbXRBZlhuYzNlWkt0REZUdExH?=
 =?utf-8?B?R3BJYko0YWJSK1Z2RUtvU0VkeGJlamZQVmplVncyVGhFSHdZZk51cFUwT3Z2?=
 =?utf-8?B?N0l0MDBaNUNScEhOekhud0hkeXo0alExcDVWUmxHd1lvV0VodytRSjNiSktz?=
 =?utf-8?B?eGc0d3dBWlN4WmI5SWpFYW1HT2kzaUxrUUJVRkwyN21MQVFlSjUzOUZkcklH?=
 =?utf-8?B?NUs4Qko5Uy9oWXM3WFEreUNRUS90bkZFRWtXSS9xR0w3ZzBJNVBpeHpFOXhi?=
 =?utf-8?B?WG1yL1RhNUJYNVlqK0U3QWNrSHpNSVF4NkVEblAxZ3RWdVcrc2t5Q3hlN2c0?=
 =?utf-8?B?Z1p1Y2xXdEFjNHJmQzBXVjNVUWhTUHpRY21vRmM2RUwxMmI5SjVBZEZpMG5q?=
 =?utf-8?B?V2JGdkhETlFUbmRHUGtnSHFUUFhYdmQxTGFkbUFITWpCVHFQaEdMWGJRNmJt?=
 =?utf-8?B?RU44OGUwTzEwdVVnM3FPOW5UQXBCZHJQTGxFODZtUVZvRWt4MVIzSnhsNWNt?=
 =?utf-8?B?akZCNkE0VEpvYkMwSWtXN1g1bUxmZEtWajBZdXkwWmVaZE1QeWFBTWxOSjA0?=
 =?utf-8?B?UDIzTktPNkFyM2hHak9ZeHV6MlBjRzF5L2JJRk5IbjBlNXl5d3ZhMVlvTzhF?=
 =?utf-8?B?Yk8wZWZkMitZQVlCKy9xMTZNZno5NjZ0L2h4SngrOGFIcTR4M3hab1d4SVov?=
 =?utf-8?B?bnF5eC9RYUVFQUpyZHVqdkhBcWFJTGd2UzRQbHEyS3V2STl1MlJXODNuS2RG?=
 =?utf-8?B?UFlqWTdQMVRSa2g2UEt3L2xFbkNvMG9BUk9jTkYyK2lZWCtTN0FhRGxOaG1G?=
 =?utf-8?B?UjBPQWI0UitwZjdTRUpaOFdNdUFUcFl6YnY5dUJhaFI3YnpaNDRFdDBFaDNS?=
 =?utf-8?B?cllxaGZqRU5BQlBJVGt0VDNza3pucjlxOGhyQkRnKytLNFJsdGVCRWU1bm1o?=
 =?utf-8?B?QUtVbXhKNVEzVG5TU3h3UVZxSjM1dGFLd2NuWDJhWWJPYmQ1cElRNSs5MXhv?=
 =?utf-8?B?NGJ0OWNzMk5JSjhCalNxajNIVmxCamJCdStBd25MV2piTlNRcmE0MWg5TlhX?=
 =?utf-8?B?eTU1ZVBDc0VHdk5tVW9FTjV5QTBKYkI1YlBjTklXelpBcTVLWWhrTUM5VXVF?=
 =?utf-8?B?QitkYkxvMGNLY1VMbG5WdFBoZVRnZU5VS1l2K05FRnZveC9PNDhSV01Sakov?=
 =?utf-8?B?TjAwdk83T0ZiazJIempON2wzbmpMNEpDdXQwdGNuWHJoQzU3MWFjZEJkQUZH?=
 =?utf-8?B?eG1UMisrKytNUE9sYWpiaXNEVnoxOVNpallKci9wbEcrMFpBeXUxcjlXQnYw?=
 =?utf-8?B?ejRDd3RrWEcvWkUxMzFDMVo2c2JjVlhVdmdRSEFWSlZTbGR3TTkzUzArdytG?=
 =?utf-8?B?WlNKKzJxWmFoaUxZMTF2UnhHSFFHVWJUTm5JVFI5TG51K3kvQUgxY2RPRDRa?=
 =?utf-8?B?ZG90ekdnSCtqKzVreG4wQ09SVGRXeTFMSC8rUXpLenVCUVQrT01CbVJYSWxF?=
 =?utf-8?B?aDVqd2FSeHBFZ0p5T1p4aDlwaUw3d0czanpOT1UreSswdlpyYXA1b1g3SXRp?=
 =?utf-8?B?cE01TzI4TkUyOVBJTlR2Q1dVbDRPOWJXZ2I5MXpQUVhHd0tlMEZxTk5tZ29G?=
 =?utf-8?B?R2FHZnpXUUlUSmdlYmdrYkpPU1hTTGpZSjJVcXN0WHU0ck1kUndZUFJPcXpJ?=
 =?utf-8?B?TGtYM2Y0MHp0UVhORnB5b0VBVm51cWNBYXZIWkp4ZmdubTg2UTlWNk90ZHdD?=
 =?utf-8?B?bjlTZmtDeldyUUJXVExVRDl4L0hrNHdsN0Z2c3NzaXlyUzZxTjNjekI1dkNY?=
 =?utf-8?Q?okqSB2Y+E3s=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(15866825006)(41080700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3M4V0tobWQrWjh3OFIxRWlQdkRTQjJwQkthTUJwdkhNWllkTzFBQXNnNDRE?=
 =?utf-8?B?cVd2bENLeFU1SEJzbmllblRxSXZqYy8wQnlzaUdWVG9KRFcwRzA0Q2lVdVZE?=
 =?utf-8?B?a3dkVEVjenJCL3MvaUI2MWtoYXN6OGNWa25QZXZyNkxGUkE5Z1RvVUdyM3FK?=
 =?utf-8?B?MUx6VWxKZmNVYXQvQm13aEQ0Z09tVkhsUWJaOTA5SDVHK1FraCt0Qno1VW55?=
 =?utf-8?B?V3l2S3h1L0RXTENiUytMQVF4ZW1nQ3oyMGRRbmJ3QmFaeEJPb2VSbVNaa3kr?=
 =?utf-8?B?L2ZFRU5nM3RJd0R6TGIrVC9GS3ZmZUgrdS9maHJOWStlN01nelBKdXJhK24r?=
 =?utf-8?B?bjBrOXMvMTlCcmk5UDdoRUJOR2NYamtyZGg0NGVhYTVnNHM4Zjg2OXR2UzVt?=
 =?utf-8?B?RUpaUllLdUZWTUJuWFh0YURvK0NQb2dQOWE2RFI5ay95VHBlSGVUeUVYNFZG?=
 =?utf-8?B?NDdjWjlDeXMwd0ZvUVNrbW5raytpUUNydnd0R3dGU1dlNGw1UmJ5YUIrek1t?=
 =?utf-8?B?cmhTQmtPaFJnUHR0L1ZTOGJMU0lXWktadlMzRWVSdUVnUFcyb2QreXpHY2Jy?=
 =?utf-8?B?RU1EcTJ4eWUyQVZWazhwY0o4TUhGZDEyMWFRZExwSWxHckJCV2V2OXNjUjR0?=
 =?utf-8?B?TEhwUWJJTk1ZMTFnRVNlOW1iaHhxekdGcGJQeHdwMEpaTVN2d0RGRTl6dUZq?=
 =?utf-8?B?aGR4dklaTlpNTjEyNjVyMmZScjlBK2N6bkNmZnd0QzhLZEJzYSs4ditTdkNZ?=
 =?utf-8?B?SUpUR0p3aFJMaU8zZFFnSzd5cmhNdHltYmIxNlQ3U3dTOUtXRmdtWlM4Snhp?=
 =?utf-8?B?VlVwcVFrdUxSMnF1OGVEeFNlMkZuOXdZNUFHYjlnVWZlWVNMaFhWV3djeUtG?=
 =?utf-8?B?VlhGbXovbForRUVqVWtMWkc4RkorR2NNbktZRDZjS1J1N3J6YjZTanhLZFhF?=
 =?utf-8?B?aGU3REtKNDI1VTkrOVM5VXpBM1h4bkFraVNlT3VFU0RTcm5QVnZqTVhDRWVp?=
 =?utf-8?B?cy95VS9kUGY1ajRWSWV1dTZiWlhCdndaZ0wyMTlUZFB3TTRXV2dxQzdOSlBZ?=
 =?utf-8?B?TGJVdHpZbUhscHB1dW9rTXlQWWxaQ3hvVWZ4c290Z1BJODZkYXIraWlISmdu?=
 =?utf-8?B?eHU0cU5MZ053WkQ5aHp3ZGk5cDdMREsvQndLN0hqWHlJWWtrck9NN2JlV0w0?=
 =?utf-8?B?b3RpdjdOM2VVSlZHRjRIc3FjekZBNjhkR0hXQWhxMmEvYUx5OWN3ZHdhSnFa?=
 =?utf-8?B?MC9sWnJSQmZVMEdNYVZEdy9vUmN0YWFOUlRaRnlocmx0eTA5TjF4SXlyU2hj?=
 =?utf-8?B?SFFncU1mRkQ0Vnp3cG9KRFZPZ25FOEllSzNzU1BBZDNoYml2TFRmelJ0Z29s?=
 =?utf-8?B?MEJJWWxLNGliYnBqSXROQUp3SmVqTWgwK0FnMVYyT1hpZkhVUjdaQjFBQTln?=
 =?utf-8?B?WmtxYm5KNTAwMmNQS2pDY0hJdmltTWxtN0w5VVVHNWZxWU5lcmRHclZSNUxQ?=
 =?utf-8?B?c3FiQldqMG9FUnVWUFpvaWpwbFQ5NE9ybndaRHlxNVg5K3QyV0EzU0c3dWlC?=
 =?utf-8?B?TklSaFp6NlduZHpsOTJVZ2tOWGtMMUlnZTdoUkNRbFB5WlB3MldNUDdjZU5E?=
 =?utf-8?B?eDBSM2sxM1FnbHg5K2svMmxuaXdzTGpNVjNvRlA4OWQvV0Q5VGdSYmZOOGFk?=
 =?utf-8?B?eVBMbi9JVml4WU41cVVuQnlhNCtxTGs3a0ZZR2tRQlk3VG1GVVNMOWtwRnZr?=
 =?utf-8?B?Z2R1T0hpWlJWdHdUL0gyaS9jUG9BZmFsTGkyU016Z3pmK09zM2FSTXJ3UlZC?=
 =?utf-8?B?eVJoMTJpN2t3bEFKVDZYZW5UU2xDT1Q4eWJWRFZ6VXZKc3pOaytaWmljM2JS?=
 =?utf-8?B?Uk5QeWdFeVlIcSsyaU9MYjF4b2xIUHlxbW5rc2MrUmszSHc5RTQxNlErOXZt?=
 =?utf-8?B?SE5Zait0WW5FREExdVdDMGE2a09oMHVKcjlSUFpXRnpXeUhmUm8wYWl0KzVS?=
 =?utf-8?B?RXNjTExqeEY2cTJia0k2VFA5cXFCOHk3UTUvN3JGUUQreHA0Q1F6ZjBWZGZm?=
 =?utf-8?B?eEVvMk4rbkx6QVpJZFBucmlxaFV5d3RRaTBERERmMlM2TzBleEladG9sTkl2?=
 =?utf-8?B?RXN6SkNEVmFjSnFleUtqMGdwa0l0L0VkQlpoSC9BNW5VdkxLU1VPNkpXRkRp?=
 =?utf-8?B?TTVYSzJ5cGE4RjNRSWxFZHF1aGV4Zi8vNWErRGFIeXd6Z1M5MmdWeCtsYUdO?=
 =?utf-8?B?cUpCdHUyKzJQK1ZYY2F6aExVZjNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E9B0E6991ECDD4F8A6321C4BFEC3D75@namprd13.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hammerspace.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR13MB5084.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a0b4a9-328e-448d-c23e-08dcb4dc405e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2024 23:22:04.5302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: po9T2cbSOcJOTZXqvY9KvACTDFY+KtMrsTV8oHuJKrpN2mDWi94jZT0OccrQD6SP9ZwEx+Xu9KcQxh1wk3PSsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5625

T24gU3VuLCAyMDI0LTA4LTA0IGF0IDE2OjU3ICswMzAwLCBIcmlzdG8gVmVuZXYgd3JvdGU6DQo+
IEluIGFkZGl0aW9uIHRvIENlcGgsIGluIE5GUyB0aGVyZSBhcmUgYWxzbyBzb21lIGNyYXNoZXMg
cmVsYXRlZCB0bw0KPiB0aGUNCj4gdXNlIG9mIDB4MzU2IGFzIGEgcG9pbnRlci4NCj4gDQo+IGBu
ZXRmc19pc19jYWNoZV9lbmFibGVkKClgIG9ubHkgcmV0dXJucyB0cnVlIHdoZW4gdGhlIGZzY2Fj
aGUgY29va2llDQo+IGlzDQo+IGZ1bGx5IGluaXRpYWxpemVkLiBUaGlzIG1heSBoYXBwZW4gYWZ0
ZXIgdGhlIHJlcXVlc3QgaGFzIGJlZW4NCj4gY3JlYXRlZCwNCj4gc28gY2hlY2sgZm9yIHRoZSBj
b29raWUncyBleGlzdGVuY2UgaW5zdGVhZC4NCj4gDQo+IExpbms6DQo+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LW5mcy9iNzhjODhkYi04YjNhLTQwMDgtOTRjYi04MmFlMDhmMGUzN2JA
ZnJlZS5mci9ULw0KPiBGaXhlczogMmZmMWU5NzU4N2Y0ICgibmV0ZnM6IFJlcGxhY2UgUEdfZnNj
YWNoZSBieSBzZXR0aW5nIGZvbGlvLQ0KPiA+cHJpdmF0ZSBhbmQgbWFya2luZyBkaXJ0eSIpDQo+
IENjOiBsaW51eC1uZnNAdmdlci5rZXJuZWwub3JnwqA8bGludXgtbmZzQHZnZXIua2VybmVsLm9y
Zz4NCj4gQ2M6IGJsb2tvcyA8Ymxva29zQGZyZWUuZnI+DQo+IENjOiBUcm9uZCBNeWtsZWJ1c3Qg
PHRyb25kbXlAaGFtbWVyc3BhY2UuY29tPg0KPiBDYzogZGFuLmFsb25pQHZhc3RkYXRhLmNvbcKg
PGRhbi5hbG9uaUB2YXN0ZGF0YS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEhyaXN0byBWZW5ldiA8
aHJpc3RvQHZlbmV2Lm5hbWU+DQo+IC0tLQ0KPiDCoGZzL25ldGZzL29iamVjdHMuYyB8IDYgKysr
LS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9mcy9uZXRmcy9vYmplY3RzLmMgYi9mcy9uZXRmcy9vYmplY3Rz
LmMNCj4gaW5kZXggZjRhNjQyNzI3NDc5Mi4uYTc0Y2E5MGM4NmM5YiAxMDA2NDQNCj4gLS0tIGEv
ZnMvbmV0ZnMvb2JqZWN0cy5jDQo+ICsrKyBiL2ZzL25ldGZzL29iamVjdHMuYw0KPiBAQCAtMjcs
NyArMjcsNiBAQCBzdHJ1Y3QgbmV0ZnNfaW9fcmVxdWVzdCAqbmV0ZnNfYWxsb2NfcmVxdWVzdChz
dHJ1Y3QNCj4gYWRkcmVzc19zcGFjZSAqbWFwcGluZywNCj4gwqAJYm9vbCBpc191bmJ1ZmZlcmVk
ID0gKG9yaWdpbiA9PSBORVRGU19VTkJVRkZFUkVEX1dSSVRFIHx8DQo+IMKgCQkJwqDCoMKgwqDC
oCBvcmlnaW4gPT0gTkVURlNfRElPX1JFQUQgfHwNCj4gwqAJCQnCoMKgwqDCoMKgIG9yaWdpbiA9
PSBORVRGU19ESU9fV1JJVEUpOw0KPiAtCWJvb2wgY2FjaGVkID0gIWlzX3VuYnVmZmVyZWQgJiYg
bmV0ZnNfaXNfY2FjaGVfZW5hYmxlZChjdHgpOw0KPiDCoAlpbnQgcmV0Ow0KPiDCoA0KPiDCoAlm
b3IgKDs7KSB7DQo+IEBAIC01Niw4ICs1NSw5IEBAIHN0cnVjdCBuZXRmc19pb19yZXF1ZXN0ICpu
ZXRmc19hbGxvY19yZXF1ZXN0KHN0cnVjdA0KPiBhZGRyZXNzX3NwYWNlICptYXBwaW5nLA0KPiDC
oAlyZWZjb3VudF9zZXQoJnJyZXEtPnJlZiwgMSk7DQo+IMKgDQo+IMKgCV9fc2V0X2JpdChORVRG
U19SUkVRX0lOX1BST0dSRVNTLCAmcnJlcS0+ZmxhZ3MpOw0KPiAtCWlmIChjYWNoZWQpIHsNCj4g
LQkJX19zZXRfYml0KE5FVEZTX1JSRVFfV1JJVEVfVE9fQ0FDSEUsICZycmVxLT5mbGFncyk7DQo+
ICsJaWYgKCFpc191bmJ1ZmZlcmVkICYmDQo+IGZzY2FjaGVfY29va2llX3ZhbGlkKG5ldGZzX2lf
Y29va2llKGN0eCkpKSB7DQo+ICsJCWlmKG5ldGZzX2lzX2NhY2hlX2VuYWJsZWQoY3R4KSkNCj4g
KwkJCV9fc2V0X2JpdChORVRGU19SUkVRX1dSSVRFX1RPX0NBQ0hFLCAmcnJlcS0NCj4gPmZsYWdz
KTsNCj4gwqAJCWlmICh0ZXN0X2JpdChORVRGU19JQ1RYX1VTRV9QR1BSSVYyLCAmY3R4LT5mbGFn
cykpDQo+IMKgCQkJLyogRmlsZXN5c3RlbSB1c2VzIGRlcHJlY2F0ZWQgUEdfcHJpdmF0ZV8yDQo+
IG1hcmtpbmcuICovDQo+IMKgCQkJX19zZXRfYml0KE5FVEZTX1JSRVFfVVNFX1BHUFJJVjIsICZy
cmVxLQ0KPiA+ZmxhZ3MpOw0KDQpEb2VzIHRoaXMgbWVhbiB0aGF0IG5ldGZzIGNvdWxkIHN0aWxs
IGVuZCB1cCBzZXR0aW5nIGEgdmFsdWUgZm9yIGZvbGlvLQ0KPnByaXZhdGUgaW4gTkZTIGdpdmVu
IHNvbWUgb3RoZXIgc2V0IG9mIGNpcmN1bXN0YW5jZXM/DQoNCg0KLS0gDQpUcm9uZCBNeWtsZWJ1
c3QNCkxpbnV4IE5GUyBjbGllbnQgbWFpbnRhaW5lciwgSGFtbWVyc3BhY2UNCnRyb25kLm15a2xl
YnVzdEBoYW1tZXJzcGFjZS5jb20NCg0KDQo=

