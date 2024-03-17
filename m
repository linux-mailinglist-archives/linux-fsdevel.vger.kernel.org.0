Return-Path: <linux-fsdevel+bounces-14573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB6687DE3C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 17:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C590A1C21057
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 16:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705E11CD18;
	Sun, 17 Mar 2024 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b="S4ZzJhpM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2131.outbound.protection.outlook.com [40.107.237.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5291C696;
	Sun, 17 Mar 2024 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710691404; cv=fail; b=qolowXA+gSCbGmrrAFPk2U3jBwcdmRvBegbVmvQYDsxVi3yx0x9xnryB4C9EHDk6jTo/dpEFzzt58fLvn8ZBd5sFfRV4kPC3Bt+CZ2zpDwffsLsNcWCDoOYsqjGBu453mVzl+gCqfSQfn0QVxLipVA5JfCIWV6u2b4C0ZGfDv6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710691404; c=relaxed/simple;
	bh=9vVIBBtYx1iNH+ousdJatJnjNOS5Mzg9ruM1RLualmo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wvkk7f8gY/sQQIU+3U/Q7taqjOLx5QW1h671qixCum/0+k37hHX0U2PPMCjwoTtr6l89LWvZKk3GUVG5OmtRYrHtS1FZ0/sgI769gsqrmFZJJEreuHxQlmAmbDASiRYlg9nA4s8NxevNI2XLVFboZzjle41Jy/O5SEioEwGNCPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (1024-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=S4ZzJhpM; arc=fail smtp.client-ip=40.107.237.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hammerspace.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hammerspace.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1ovw5TQkCov11a3qS3iok0kjSEOcnzqsc+bnNghjs4soDV/8qfGAt+0wIlhujrAQuACMmCGaMVnvqTq961RpPal+jkbTMP//g9gZNzfz6UmI9O5lQVr2ucELDmeKMhI9MoZv3S6kYABAtR6VIxe+lpzy82hHtc2RFcCr/xvC4/swB9+x0jn8eLSg/esTC1P3Dsm9UHrdmalFlSr3q1gaL1aJ79rmg3Qf94OszpWi1VLAntNZ/nJ5CvnPlV/yKaeXFUb7ET77NhAQTX9qWH4T1v3OQjkGZRFBU15PykkNzhjJ0STrC3ZXmhou64b//H09HnPA8fa4q6uGvAQjFuzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vVIBBtYx1iNH+ousdJatJnjNOS5Mzg9ruM1RLualmo=;
 b=SIlz64GiUPbtufEB25mmTYpAzpHRwyuGvtLkVVgNG53240lF3Ar9/9DIDLJHoezal2zb9jcl2vbpiIH6yJ6+zi9nDPzKkHU2E6lfnJzbrW//rRHiK1YjOL0GZ1wslHOnpBmDLB4zQtKidDTPyFfvGSq7038mFX6urlZ1dWqS7OJH7Q+K4vkKYP6hMcSvU9TPLtV+qvocdZqmgmiLbMjbk+Tfw1VrOtHrhYX/g6/gpDc7UgXSA7jY2bGRq+uZ2TeVgSfY3DE4uNZ/no6fedkN4aqTpv+o+btFE0eUI+M3bIzKyKJzC9UHus9f4MGiWWTAC1zVDTUFlbF0r3Z+MVoQHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hammerspace.com; dmarc=pass action=none
 header.from=hammerspace.com; dkim=pass header.d=hammerspace.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hammerspace.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vVIBBtYx1iNH+ousdJatJnjNOS5Mzg9ruM1RLualmo=;
 b=S4ZzJhpM3mwd/g2xkIZopr7vpPQ9cGXcMzzEtOdM8VQozb1asKQ+3SvteNCH3ms9vTG6WXJJ4h8NpEjESY8NtzQPVYKv6If5uSUeprjuf/+MyXGR4EF50bmxFvG4ckEDP6JA4uIVwLXmydWjWrI/yHAbHfN5iGmxH6tRB4O9FLU=
Received: from CH0PR13MB5084.namprd13.prod.outlook.com (2603:10b6:610:111::7)
 by BY1PR13MB6309.namprd13.prod.outlook.com (2603:10b6:a03:528::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Sun, 17 Mar
 2024 16:03:16 +0000
Received: from CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057]) by CH0PR13MB5084.namprd13.prod.outlook.com
 ([fe80::5bb5:501a:fb40:5057%6]) with mapi id 15.20.7386.023; Sun, 17 Mar 2024
 16:03:16 +0000
From: Trond Myklebust <trondmy@hammerspace.com>
To: "jlayton@kernel.org" <jlayton@kernel.org>, "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>
CC: "senozhatsky@chromium.org" <senozhatsky@chromium.org>, "sfrench@samba.org"
	<sfrench@samba.org>, "ecryptfs@vger.kernel.org" <ecryptfs@vger.kernel.org>,
	"linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "viro@zeniv.linux.org.uk"
	<viro@zeniv.linux.org.uk>, "anna@kernel.org" <anna@kernel.org>,
	"jack@suse.cz" <jack@suse.cz>, "tom@talpey.com" <tom@talpey.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ronniesahlberg@gmail.com"
	<ronniesahlberg@gmail.com>, "samba-technical@lists.samba.org"
	<samba-technical@lists.samba.org>, "dhowells@redhat.com"
	<dhowells@redhat.com>, "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"alex.aring@gmail.com" <alex.aring@gmail.com>, "pc@manguebit.com"
	<pc@manguebit.com>, "amir73il@gmail.com" <amir73il@gmail.com>,
	"kolga@netapp.com" <kolga@netapp.com>, "sprasad@microsoft.com"
	<sprasad@microsoft.com>, "code@tyhicks.com" <code@tyhicks.com>,
	"brauner@kernel.org" <brauner@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "edumazet@google.com" <edumazet@google.com>,
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
	"linkinjeon@kernel.org" <linkinjeon@kernel.org>, "neilb@suse.de"
	<neilb@suse.de>, "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"netfs@lists.linux.dev" <netfs@lists.linux.dev>, "miklos@szeredi.hu"
	<miklos@szeredi.hu>
Subject: Re: [PATCH RFC 11/24] nfsd: allow DELEGRETURN on directories
Thread-Topic: [PATCH RFC 11/24] nfsd: allow DELEGRETURN on directories
Thread-Index: AQHadvlYXRORW6h36kiQmS22ZF4V9LE8DFyAgAAO7AA=
Date: Sun, 17 Mar 2024 16:03:16 +0000
Message-ID: <d3d8483b1248e4bccadb8591019dbe7c4aeb3d1c.camel@hammerspace.com>
References: <20240315-dir-deleg-v1-0-a1d6209a3654@kernel.org>
	 <20240315-dir-deleg-v1-11-a1d6209a3654@kernel.org>
	 <ZfcHvSEkwIS8-Ytj@manet.1015granger.net>
In-Reply-To: <ZfcHvSEkwIS8-Ytj@manet.1015granger.net>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR13MB5084:EE_|BY1PR13MB6309:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 T3q4TrzbZgCDGFzuBhq1lh1akTKN93ytoLuuP6qtk6SXUMhYFAITZGKrnzaI+O2a5XBC8Gd5B4OIFBJDQdF6E5ibAUKShYrbn6BA41uxmKR44v+CI49Npmr13zg7XsKuEJSIoa8U5Kd9DwWCEabYAjVeQMn4+6nVhy+jeYsFoON+VbhpudIobfRua6N4e7L4+OnfO/0aSrpWyA8W4aSWLpFsxHStiMhc5lJ4SEwpF/3VSTvN53oILVMHruwQttAWlk8gK67cUy75Au45W86QdtS8JTIsumYPz3UVHKnU76Sstu+ja/slqH0shQqBTgIO8Clx1egli8qIUT27XtxCPomzIaJwCSsgHjCKEYvrsLdYjM1qFKdcxKEcinB2MGPSmPdsqNK7rzcDwPVbInsEKv7Syv8hDXIfYZKUbtRS6WF77eUobC5RcPKqfbEOiMuNHBljC9U0Or8Sv3FhWb1k0KPvOche8ytk3uztOZm4B6aJxB8KHpOlQk4893wwcp2HDdR9vEoZpsQzw9sXq0QaL6sj8GeM5XvX8FoBgAhFlUS2dwiCCUbO7cYK9CSLKI/1W3mgByY5Mdxp48zL4MTCFZjCl9h3qfBnxXg8EL2ANPUNejGihZUCsdmzaYffPrSn8o4HY1vmWX4FvJXAmlMUjgJQxGR/0gmov9sMKrv61vY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR13MB5084.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ak1YcklNRG9hR28zbCtSMnN4L1F5aG9KZmdNTzZTSm5zalVnWCtSeTM3ZDRz?=
 =?utf-8?B?L1lFRkNjUlFvaEVxamZCVUhkbThMMHVDaFh3aXhybHNVaFBmU0RhazlPQ1pV?=
 =?utf-8?B?NHlYaUNiK2M5N0NvM1pMWElXeExVaThMUTBzV096blRMU1d4UjRZcUw2bTlE?=
 =?utf-8?B?SmVYZzJaZmpuSDNTYytEMkRkbktDTzN4Uk9UME5FVmdvVUZVY1AvcG5LcHlE?=
 =?utf-8?B?d3VwMnBlem5teHdpM3hmQVFWQUYrVitmU2VTZ1k5c3pZZm5mdzl0ODBxeERU?=
 =?utf-8?B?bVFRU2NMQ1RCL3BBc2VSS3hjVnBVZFM1VDlFaWY4aGVvSDZydkg1dFJ6QVpJ?=
 =?utf-8?B?RzBZdkVJNDUwR0lzSnFhQVA1ZlJoMkNxNXZ0R3NYMk1pYnpzekUwSDdQcHNQ?=
 =?utf-8?B?NHhwdnFMMXpaZFkwYnhJUzdOanZ4Rk1GQzZJdG9jVmNmQVVVdlRPb0o0Q2pY?=
 =?utf-8?B?ODRqQVhIQUhBNGRnRXMvaXFiclg1SDc2Um0yWnk5SXFHSy8rYVNzcFVCdFN1?=
 =?utf-8?B?ZUcwWW5wYVpmaHZmS045by9tQWxrRHE4WFhiYk1TNm1CL3E0b1lPeU1lSGRY?=
 =?utf-8?B?N3p6MmIvVTgxV2twRWpmcnFmQjdXNUsvNGltZW5MWDlyYVdESDI0ZEZsTnY2?=
 =?utf-8?B?VTJhREdWd29YblhrQ0l0STB2WFpoZDVLRTlqTHg2aytZVUkrTkR4WkhFalpj?=
 =?utf-8?B?ZmRON1RnRjdMa0NoMlJVRkxNRnR2dDNGaGZzZVNRMHJQd3dCT0FuYWdncWlq?=
 =?utf-8?B?M1VmL0s1YUhMcTVNNFdiRHZwa3hDVm9Zd3RmMy9BZFFlZlNSY1VuOUVmTnRE?=
 =?utf-8?B?SFRlSHVyaWY3V05NamNJalFxcWg1SmNZVmcraTJXRnlkUm1XdkMwODdDTllO?=
 =?utf-8?B?aW0wZkFJS05IcStJTVNsOFhsWUE4K1duUFpDVWE2eGxTc1oyTytic3pEQmJ1?=
 =?utf-8?B?YktSWHF1ekQ2UjgvYVF6YjZoSmJlMDRmQUxFYWxmZUNUcllzSHdSdVFaL3N3?=
 =?utf-8?B?OElzTTJnaTlGTmdTcG9SdmxydWwwcndWZlVLMUZwS3lwb3dFNk1EWmVXTzlI?=
 =?utf-8?B?Qm9NblErQW5xVkN0OGN6UkVhWStxMWU5NFdKZ1E3SGwwenZPdTIxUHBtRXZI?=
 =?utf-8?B?ZEdjc21UTWVpWmZzWEdzeklVR2lucVhiOWtFRkxQTDdJRmM3ZzREdUZsT1pZ?=
 =?utf-8?B?aCtqUTRLQ1FEL0t5RmlTK1JsSVZoS1hnT1pSM3hxbFpwTEowVmUxdjVycHkz?=
 =?utf-8?B?VDdDbWN5cEdhZ242Z2wwcDF4Y25WYVpjQ1QxTklNSGQ1eFhiR1p4ZUt2NUpS?=
 =?utf-8?B?enRkUWY5WVNmMXluamNxR1BPWFdaSjRnNmhvVW1sYWx2eVB3S281TmR6Snli?=
 =?utf-8?B?K2dCdllDTmdrUzVIbTBzdU1vVHFlSzNsVVFORlF0bkJ2MVloNG1sRGNnUkx6?=
 =?utf-8?B?VFRHZGFTVTcyVGJrS2twZmlRUWxNVDVNZ1RtWk8rSHJFR2U1c3lmYTBBVWwr?=
 =?utf-8?B?ZzBUVWVHd1VabEI5bnVBU0pNNFVEQ0UwREVGTFZsdXFaTUEySG1keHNlTmJY?=
 =?utf-8?B?Y1ZTZVpzSzhSVXJQVW1nMXB2SW00c3lQaWpoaG40SXAvK3haYWZ3a3luYkN3?=
 =?utf-8?B?VG4vaFgrOGF6QkJKNVNjL3VIM1ZHNFlxN0JWdU5MWkFuWnVSaTBsZUFFTDIw?=
 =?utf-8?B?TVZyazdpZ3JEeFJFdEhUSXZ4QUpnZjRsK3pQdy9NRS9aL1p4a1E4bFcyNDFt?=
 =?utf-8?B?cmRydWF5MWw4L3czbVA2dHRGSXdHcHFiMVVVUnR2WmU5a3VYajB0NUFSbnp5?=
 =?utf-8?B?UUtZQ2hGNzA4WjV1c2NWS2dWeHNmT0FZbEpRWHV3OUtpN0J5ajZrSGJUeGtN?=
 =?utf-8?B?Si9MVEd6Qkd4VmUyNzRSY2IzYXM1bVEvS0Y1ekVacUFkQ2g1aHZPUi9UNkM1?=
 =?utf-8?B?WlhDTDBqS2RvTXptVkp1UG55YUliWG4wUTVrVy9WdTg2QVZjQzVDZzBWWVo4?=
 =?utf-8?B?ajlkUzRtQ3VVTkJCSkRTQkhSeDM4UkRuelhoQVEzUmNXQmZNaG5EcTRXNDUr?=
 =?utf-8?B?dDRocFk4aUxWRUJ5bWZQcHFPQXB4VlF4czl1Q3liSTZFQklyekRXY1lhZGYv?=
 =?utf-8?B?U0JVdWZCWDN3OTJJdmhFQ1FLK2lBMk9zVDZuaTF0aXpkSmxXdXNKcmtwVjNP?=
 =?utf-8?B?OFZ3bDJQcXFoa1dvRmF1L0JQN0F5a3R6RzdaVVJ0R2VJVmZ1TzZySWUwUWUz?=
 =?utf-8?B?Yk5rdUo3dkN3RXJsenpHa3FmNnJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <076FC3505633E144B041AF8D1E414C86@namprd13.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f36475-ba0e-4986-05d9-08dc469bc1bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2024 16:03:16.3425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4fed5c-3a70-46fe-9430-ece41741f59e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zSl30pBk153mUD545stLiTJobjQQB+gY2LaMlsNbBJI2Ei0+oe4t/UoxGYgZ55N29Rt/Qfk63cKjr1Qe0XnH2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6309

T24gU3VuLCAyMDI0LTAzLTE3IGF0IDExOjA5IC0wNDAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4g
T24gRnJpLCBNYXIgMTUsIDIwMjQgYXQgMTI6NTM6MDJQTSAtMDQwMCwgSmVmZiBMYXl0b24gd3Jv
dGU6DQo+ID4gZmhfdmVyaWZ5IG9ubHkgYWxsb3dzIHlvdSB0byBmaWx0ZXIgb24gYSBzaW5nbGUg
dHlwZSBvZiBpbm9kZSwgc28NCj4gPiBoYXZlDQo+ID4gbmZzZDRfZGVsZWdyZXR1cm4gbm90IGZp
bHRlciBieSB0eXBlLiBPbmNlIGZoX3ZlcmlmeSByZXR1cm5zLCBkbw0KPiA+IHRoZQ0KPiA+IGFw
cHJvcHJpYXRlIGNoZWNrIG9mIHRoZSB0eXBlIGFuZCByZXR1cm4gYW4gZXJyb3IgaWYgaXQncyBu
b3QgYQ0KPiA+IHJlZ3VsYXINCj4gPiBmaWxlIG9yIGRpcmVjdG9yeS4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPg0KPiA+IC0tLQ0KPiA+
IMKgZnMvbmZzZC9uZnM0c3RhdGUuYyB8IDE0ICsrKysrKysrKysrKystDQo+ID4gwqAxIGZpbGUg
Y2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9mcy9uZnNkL25mczRzdGF0ZS5jIGIvZnMvbmZzZC9uZnM0c3RhdGUuYw0KPiA+IGlu
ZGV4IDE3ZDA5ZDcyNjMyYi4uYzUyZTgwN2Y5NjcyIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL25mc2Qv
bmZzNHN0YXRlLmMNCj4gPiArKysgYi9mcy9uZnNkL25mczRzdGF0ZS5jDQo+ID4gQEAgLTc0MjUs
MTIgKzc0MjUsMjQgQEAgbmZzZDRfZGVsZWdyZXR1cm4oc3RydWN0IHN2Y19ycXN0ICpycXN0cCwN
Cj4gPiBzdHJ1Y3QgbmZzZDRfY29tcG91bmRfc3RhdGUgKmNzdGF0ZSwNCj4gPiDCoAlzdHJ1Y3Qg
bmZzNF9kZWxlZ2F0aW9uICpkcDsNCj4gPiDCoAlzdGF0ZWlkX3QgKnN0YXRlaWQgPSAmZHItPmRy
X3N0YXRlaWQ7DQo+ID4gwqAJc3RydWN0IG5mczRfc3RpZCAqczsNCj4gPiArCXVtb2RlX3QgbW9k
ZTsNCj4gPiDCoAlfX2JlMzIgc3RhdHVzOw0KPiA+IMKgCXN0cnVjdCBuZnNkX25ldCAqbm4gPSBu
ZXRfZ2VuZXJpYyhTVkNfTkVUKHJxc3RwKSwNCj4gPiBuZnNkX25ldF9pZCk7DQo+ID4gwqANCj4g
PiAtCWlmICgoc3RhdHVzID0gZmhfdmVyaWZ5KHJxc3RwLCAmY3N0YXRlLT5jdXJyZW50X2ZoLA0K
PiA+IFNfSUZSRUcsIDApKSkNCj4gPiArCWlmICgoc3RhdHVzID0gZmhfdmVyaWZ5KHJxc3RwLCAm
Y3N0YXRlLT5jdXJyZW50X2ZoLCAwLA0KPiA+IDApKSkNCj4gPiDCoAkJcmV0dXJuIHN0YXR1czsN
Cj4gPiDCoA0KPiA+ICsJbW9kZSA9IGRfaW5vZGUoY3N0YXRlLT5jdXJyZW50X2ZoLmZoX2RlbnRy
eSktPmlfbW9kZSAmDQo+ID4gU19JRk1UOw0KPiA+ICsJc3dpdGNoKG1vZGUpIHsNCj4gPiArCWNh
c2UgU19JRlJFRzoNCj4gPiArCWNhc2UgU19JRkRJUjoNCj4gPiArCQlicmVhazsNCj4gPiArCWNh
c2UgU19JRkxOSzoNCj4gPiArCQlyZXR1cm4gbmZzZXJyX3N5bWxpbms7DQo+ID4gKwlkZWZhdWx0
Og0KPiA+ICsJCXJldHVybiBuZnNlcnJfaW52YWw7DQo+ID4gKwl9DQo+ID4gKw0KPiANCj4gUkZD
IDg4ODEgU2VjdGlvbiAxNS4yIGRvZXMgbm90IGxpc3QgTkZTNEVSUl9TWU1MSU5LIGFtb25nIHRo
ZQ0KPiB2YWxpZCBzdGF0dXMgY29kZXMgZm9yIHRoZSBERUxFR1JFVFVSTiBvcGVyYXRpb24uIE1h
eWJlIHRoZSBuYWtlZA0KPiBmaF92ZXJpZnkoKSBjYWxsIGhhcyBnb3R0ZW4gaXQgd3JvbmcgYWxs
IHRoZXNlIHllYXJzLi4uPw0KDQpUaGUgV0FOVF9ERUxFR0FUSU9OIG9wZXJhdGlvbiBhbGxvd3Mg
dGhlIHNlcnZlciB0byBoYW5kIG91dCBkZWxlZ2F0aW9ucw0KZm9yIGFnZ3Jlc3NpdmUgY2FjaGlu
ZyBvZiBzeW1saW5rcy4gSXQgaXMgbm90IGFuIGVycm9yIHRvIHJldHVybiB0aGF0DQpkZWxlZ2F0
aW9uIHVzaW5nIERFTEVHUkVUVVJOLg0KDQpGdXJ0aGVybW9yZSwgcHJvdmlkZWQgdGhhdCB0aGUg
cHJlc2VudGVkIHN0YXRlaWQgaXMgYWN0dWFsbHkgdmFsaWQsIGl0DQppcyBhbHNvIHN1ZmZpY2ll
bnQgdG8gdW5pcXVlbHkgaWRlbnRpZnkgdGhlIGZpbGUgdG8gd2hpY2ggaXQgaXMNCmFzc29jaWF0
ZWQgKHNlZSBSRkM4ODgxIFNlY3Rpb24gOC4yLjQpLCBzbyB0aGUgZmlsZWhhbmRsZSBzaG91bGQg
YmUNCmNvbnNpZGVyZWQgbW9zdGx5IGlycmVsZXZhbnQgZm9yIG9wZXJhdGlvbnMgbGlrZSBERUxF
R1JFVFVSTi4NCg0KDQotLSANClRyb25kIE15a2xlYnVzdA0KTGludXggTkZTIGNsaWVudCBtYWlu
dGFpbmVyLCBIYW1tZXJzcGFjZQ0KdHJvbmQubXlrbGVidXN0QGhhbW1lcnNwYWNlLmNvbQ0KDQoN
Cg==

