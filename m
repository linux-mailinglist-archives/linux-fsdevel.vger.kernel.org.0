Return-Path: <linux-fsdevel+bounces-47710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C21AA46EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 11:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16743188BF79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 09:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A68C231830;
	Wed, 30 Apr 2025 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="FiVD3LI3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9B51E834E
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746005015; cv=fail; b=rTvNxL5UdF0CvO6Jf9ggkvKVDNE8yjPQugFkXm8nV55njICn2Kks2pJBKyIlnsO8Dz6pLRawDrlo3CISsf4trs7poZRV+R0K4/W6FXmnEmOeTsVSDtJaqVLiPqmW68w+2GwZ017fZN2caS+Q17XmSmP7ZIaYsvPgE6S5T3OdVAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746005015; c=relaxed/simple;
	bh=DaQkzE9jdU0gNerbmd5uzdsqgJ3zQUlCufEGpBPqnic=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F3U3jEGqSN5EzmL28PECEiOvl4KpCQwIxIgM/bqSX9Fq6Wd5C9JGYt+2ItwAlHwRxO2wTHbi35CDL5CT5+/qk1xyt2FGOHecykw0zrxxgNtOBSbD8yMPdzmvasKULo55qMrnAkFOkRRDjFSlkf9lFzRh1oLr8Z3oLXSWMEJKRAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=FiVD3LI3; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168]) by mx-outbound23-128.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 30 Apr 2025 09:23:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9KOArbe2KghtmhuIVoaw5FKI5SecB55MDqRR7sELgpU9VhYEoaPz7jM0y98r5249D39YsfnMexGPRXZ97y7gjxb8NsJ4R7lsUbxYpZEmAGq+BxTKTeI6eWPAS7z7650ntPAuWVNZyGhJhIuRGGsfMDZMLFWoNTMpA9cgXnOuGwdSn1ne4yNaWw4LGvr12Z9Js6Y84UMmeglZFqtRcUdn4QLhy0i/Q82e08E/C/gAA0seE5+4i/pvUqB/FmcROvRxoL/Tit2k/kSd6suPcb2+mdzov3gKa7XFviUbj8A/5HyqmnpSCAf1ooBug66YLA5Zyv9oz1D8bg0OuLvyOiBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TC/Gm77Kxe1WQGE2Ehww3upIZXWlf63Onot1TDZDyQE=;
 b=Fwspn/j9nlnOBxgN7PjO0o34ujvHCu8GDpGMJ95af0nqr9YZBn8BQzjYoO0trkQJMqaj2UtrLrqRMdIM2zyGvqdLiqEcmoUY4U9nuOLELH7M2MI0pfAIxlgL0Y0A1U3DI3NAahByGUS0uXgHlVcKOlpDnaVlwdEkQAcLB6Nnej9YLu50SvPlmGIBLxQ2Hwixdypraq5JHbApNs0fYbLDqwCoRiRjxFOAWA36sKcCqj6hg0CQpq6Gtyhbo5aWOx6pIYUlu0PUXx5dueG/FLuZadNEcuVjSDjT4Eo9Bm3i6jn6LzMLhW/gQ8gCaF9Tt/bCFoJPYstGVTFxGjSUi94N8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TC/Gm77Kxe1WQGE2Ehww3upIZXWlf63Onot1TDZDyQE=;
 b=FiVD3LI3JNvs06yWcm8AKngP/xa+M79FJ35jScVo/UYg8pYOohuKypTzDNStN62ohdG6ThFYPMQYBXN2pS6Rw3dmpiX2RPH5myrWMox/GkmX0+o6dl8JoUwf6jekngN7jasoYoW2c3j5S6+m3k9eDDP3FEj5DsP7bTmZtH4T8Y0=
Received: from BN6PR19MB3187.namprd19.prod.outlook.com (2603:10b6:405:7d::33)
 by SJ0PR19MB4559.namprd19.prod.outlook.com (2603:10b6:a03:289::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.35; Wed, 30 Apr
 2025 08:49:29 +0000
Received: from BN6PR19MB3187.namprd19.prod.outlook.com
 ([fe80::c650:f908:78e0:fb00]) by BN6PR19MB3187.namprd19.prod.outlook.com
 ([fe80::c650:f908:78e0:fb00%5]) with mapi id 15.20.8678.025; Wed, 30 Apr 2025
 08:49:29 +0000
From: Guang Yuan Wu <gwu@ddn.com>
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC: Bernd Schubert <bschubert@ddn.com>, "mszeredi@redhat.com"
	<mszeredi@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH V3] fs/fuse: fix race between concurrent setattr from multiple
 nodes
Thread-Topic: [PATCH V3] fs/fuse: fix race between concurrent setattr from
 multiple nodes
Thread-Index: AQHbuas06fMTHB1Ja0SjB27BJHK1lg==
Date: Wed, 30 Apr 2025 08:49:29 +0000
Message-ID:
 <BN6PR19MB3187300E9AABB45A19FFC540BE832@BN6PR19MB3187.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR19MB3187:EE_|SJ0PR19MB4559:EE_
x-ms-office365-filtering-correlation-id: 06343e1e-b557-4b39-af82-08dd87c3eb7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?M3LF3BAMiBtMGAKqcJfgl0IU9+4svF8BmlKlI88EJwV1/CO9JM61XbfXEt?=
 =?iso-8859-1?Q?d1+DttrYWTuhv8fdjChWhm5vhnhqwkL0uJwEb9IkfvzRGTk2zOym8+Frqx?=
 =?iso-8859-1?Q?vqqrRel5WAH0iOLudcTV9U1ZTFP8Gkol7G1mG3exAVgX3yNQc/7jSS/SWy?=
 =?iso-8859-1?Q?sYVonrVLRBRbV2FZFG2n6lQURyMKV7Suk+5VG0Kj1bKvd+o0OYBH/OENxx?=
 =?iso-8859-1?Q?cznV8KDiFQa2sSBGvdoqRzUxrt7SudYY7sPcoLkKfGJQbCAH6iw9md67a6?=
 =?iso-8859-1?Q?s4GxcLYAbCQKDOOmjZI82PRBEvOrkV6mYObW6BFlskB9HkImb3iPNfB906?=
 =?iso-8859-1?Q?Dpff2ReO20uIqrCc+nmjF6Vj4Q8MnDdknxyNE4OUF4JLfjKFxkZDazqocC?=
 =?iso-8859-1?Q?TQ3lhX6PJfdw/Bw5rY5145ZVcr7l1MzsS4HgcfXLNDJ+DWahkmEC2LtQkR?=
 =?iso-8859-1?Q?tuYZVBjN7Hj6sLSB/2RKdM+ueJzovxkGfr0O24toRNmHEeaXmvV5d/20cJ?=
 =?iso-8859-1?Q?79kvTyaOFTV2AVZGvOrMS/uwWk24ByVxaHHfOC+bisRDkriCVoMZiv6qcp?=
 =?iso-8859-1?Q?9Xe5RElCE2/aBp4hFw40kMx8G2G9IgCWleVFsY8cvu3wwy7asFlwoKn/Af?=
 =?iso-8859-1?Q?JXZe10enlOKquwn7hLWt5PjMxciNLkol5/NtIw7pZBJrIGNIv3Asghydq+?=
 =?iso-8859-1?Q?r2dxySzP0bzhLqHbP3y4ggN7wUM9/CF6V30LukhdvnP6fGlz/esTBimEqg?=
 =?iso-8859-1?Q?yDTdYHdBXsLS2A1gwFrv8jhH9eQiXnqNATOrRnETgsr1Ty5QXtwPIPEvgj?=
 =?iso-8859-1?Q?85p5rRvDkUy/0g7bFK2EpYzFq4YjtuZyzmHgZGSSWwIjTGhrPOqLqYBn7/?=
 =?iso-8859-1?Q?CgESCdjQPKO4XPHw+2lh/o2+gfarx7i+ZQ0mG1UljMGWzgRNLtkf9DxsYP?=
 =?iso-8859-1?Q?raL19elrXwkLz3ng0PW29D07AWzojT8wD4r3qjJNFc3JK6/3C/6VTJBj06?=
 =?iso-8859-1?Q?tapjF4LalpdPUkKrj6ruHLi9TGHAsbggFxHu5jh5Q8MxWXhvs7Pa4Uvisa?=
 =?iso-8859-1?Q?L4+nxQdu3r+kiflHjVx2ESEsmEe1W65l4ifBVNNG3HJk51ZrJgH955EUyY?=
 =?iso-8859-1?Q?XMIoht4JrOgO52HlvPxF6f9tTq8FM17xCSnoZxlIcuJuen/adolFsmXqB7?=
 =?iso-8859-1?Q?ADh1t+LtT/k9kBW3G8i3LxieeP67GZNgqmvkR/vzAe1pZPJFYyybiDJJFd?=
 =?iso-8859-1?Q?4+yTLHtqBImNY6+Ywu7lUZerkK+NzRt0WGn/uA100KarJpDkYZmbH8758Y?=
 =?iso-8859-1?Q?/9mjwbGFiGY/iv2QwXNvqONZP+6ue127dCD536gvdk9eZoE36P6aK8NaCa?=
 =?iso-8859-1?Q?DKQSmUDtXvh4rg2oHV1BKeRIezBWUGfo4woDvDgllL9eg60S+xlMD4/yJy?=
 =?iso-8859-1?Q?DPl7TrqGD/iQqvP7NZeSWvLQHn56mF6j/pH5c3B02SxwdZqIAGJD0SNvSV?=
 =?iso-8859-1?Q?XjO8UpPe+Y3bBuE2pwP+MuBWUuJLwTikyauJcmfNZfFQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR19MB3187.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?OmO+KyvZZ4WNdY6TdTBpYS10jOVjTpTN7RbSNK36/5GMFrlHo0y+qJqljy?=
 =?iso-8859-1?Q?fLCsQGTXCvEECfzoX4ii+zzlvDbtuou64TVNTD2z1+fXBcOMWT5WzyWxdj?=
 =?iso-8859-1?Q?3FHuuZtg3w9PRbudbiGM+B07X+tYC+27UM4DFFLBwwiU9q+Q3AlLzG0kZJ?=
 =?iso-8859-1?Q?50YWF1HvTmAmcVhMcI581TkXY3OdRo3555mS3so6Js/9hH4JJ8L2KZSoC5?=
 =?iso-8859-1?Q?EC2sjcG25y0TJ5cwda6E5ZWy1Fie14Vog7DjyrlE3hxAfkTnhAXtdBQwG3?=
 =?iso-8859-1?Q?pTGus++r1f+ei5RDZj+/9qlaHadlV/A1xJsxohBleR4csgHCMGsrIoZbLF?=
 =?iso-8859-1?Q?lAxalkdrwdS/wfV0uJbyVgU1SAg+LodwaRTC3JUc4gwebs4sL2bG4nv3w0?=
 =?iso-8859-1?Q?q0rg6RsyHZPSb4vKvFqneRh+2Q2/G9C8RpmU6/dosVTeY3/JX/8yOLK/le?=
 =?iso-8859-1?Q?zR3P8R3dFUX1ZR+qOi9hn1lzNx9JaDOXsGKW1RzHhpYELqDsunqln58IvE?=
 =?iso-8859-1?Q?OT0MwXh4LoZsC1gqGiIb6Xwzb+Ewmoxc5G44iHcSWt0S70NRlRjP2z33e3?=
 =?iso-8859-1?Q?qSra71TnhD0skcD5gyeysj8vKiU5L5kHntz27VnhMQ+YhM+BH8HmeHDIcx?=
 =?iso-8859-1?Q?m3Tqi7C/NI3/WdEwvXHGCxZ/8dqeL8KXmMhCOaWZe86m5ZdwW5VzV6bteb?=
 =?iso-8859-1?Q?QPPOwtLryIqMzrFId95nDPq2x6hkDvdUQMnVBCDZKvo2ZRKpogAP6z7S1z?=
 =?iso-8859-1?Q?cpJb2QHihgcGLn1rZKpf3cnmQABCm+LwXH4BXxyNm29KUBAdS5MfjT5AdA?=
 =?iso-8859-1?Q?A2TwVjt2Q8tLuDgKeHWFA1Ayg46miIUYKX57pk+a7+Y03yz5XePbtm6Z/v?=
 =?iso-8859-1?Q?V5+2+HPJo32+BKL+gJUbg/GdeSqomI2syTYj938Di0xt4+dEkASIzVMbqJ?=
 =?iso-8859-1?Q?FIxn0S0fzs/4MnpBCP+Qe+YCQP+hiAm6D4VYMCwwmUSoUmi/yiD5Ysaat+?=
 =?iso-8859-1?Q?+P+CsCX5ej5pb1bFuzieUzgdnl+eEdHAWlCAuFPA+4plXWLljzY4oi/q3M?=
 =?iso-8859-1?Q?aARgEHUcMA/uAylVo2LK79BI6BU836UIpVUFAWFMxjJnnWRdcQnaCftgGc?=
 =?iso-8859-1?Q?N7w3fLwNXuXM/u13yq98Z7HRKXpTTzn/0yZbqo82cppX87A8hykv902t3J?=
 =?iso-8859-1?Q?/FYJYgmgm9hYdDOjFjbd9F7f5Vl0oFNBc1Y9nsH2BDFWzhFVEhLUySZDgC?=
 =?iso-8859-1?Q?6LHB6ERyUrWIofRMUn/d+U6hWRBAT3H/VfuBSEDB1XIf3tnHX95QRjUVpH?=
 =?iso-8859-1?Q?eSUh+R/LxNCYtFEDGX63tcv7Ih6PYTZ50QQRpSId1w/hDr1sQN56XrbzK6?=
 =?iso-8859-1?Q?kNagw5xyv93ZoAIDQd11PglSPGjreA98OVbyLA8bs+Bhwo1OLRWU998Y7G?=
 =?iso-8859-1?Q?yjocQ828gLAUmXptwFU9jA/pAak/l3N+MUMAInfgikVKEJGbJpa36DsoAA?=
 =?iso-8859-1?Q?ga2P5mkP3ntjEjMF5h4D0qBJEnwIPSPxPqxsXJghgCpXfEfGQ/KdDLqlmT?=
 =?iso-8859-1?Q?idUuQB6cKA2JdPkFzLbE7LcbAcyplTjcS2bHfn5djOZUFejS3A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8okaNmFlIuymOERv1rF0GOzUOUfb/J/mbd22hr/u5e9VBnZOFwAStT52PGNLP9eSz2PC3kZhOazYF3ox7Dz+t6WkU/Zvot4VDSTVgNVJ8Q8lgOt3rHlOqz8H+EcNpoLliYkphZ9OeMdDwoX/P9lMP4vQuMr5iVwDoRupOeKuOJV6aoGrJHZROEmomfRXSxakgydcqmVBO7Lf5rM9F2H2+0nY8uCXQYfU77VE3YGQEMbgEKVdwHhJVh30QqS1llrjr+surWHIrE+Vj12oZmF9b1OpL5/dCbI1WAfbKVHO475TNUw+VZyhO5Qraz1ES9nC4f91FGv7mrQuorE5vXXHMw8UQ5qpQWHNuVnGYPRhtrgk2gSIxQVgpMYkqOZZgNtZAkEvMzUbgFERkYxjGjEFK6xfN+nD+oETkTw5rdpE76N1T4aLDlSNSdTJkPrYVDs9I0Bn3dDJyuKesgh0AxQARfIarrcjeM46SPMn/3j9NvgSECyt5jKen6F2sCtbzoe2Txu7vAqJaVEfvpRESiS92hsmsZwblEvtIW5DTMhHWKp73l+ncDTQcBPh+1Hq5p4WCWZLtTaZm1qqglDElAtctkXIjyHhzVQtZ3PjTJlKVPR8/xXyz95h08bUyvuIHpZ+MExRYJH4+5hieHuIkjbTsA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR19MB3187.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06343e1e-b557-4b39-af82-08dd87c3eb7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2025 08:49:29.4981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vej0PSkwHF2uf9MdGbtVbY33E3QI4BYp+RmOEw1IG5A1LV1fZTwG9uDdD/s4it4d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4559
X-OriginatorOrg: ddn.com
X-BESS-ID: 1746005011-106016-7608-6033-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.55.168
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbG5qZAVgZQ0CQtzcLSwtDUwt
	jc3MTEyNIoxcjE1MzSyNzcNMXUMs1CqTYWAFRhhoJBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.264256 [from 
	cloudscan20-61.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Hi, all,=0A=
Here is the updated V3 patch to address Bernd's comments:=0A=
 - fix format issue (keep original tab/space style)=0A=
 - remove "Reviewed-by:..." lines=0A=
 - invalidate attr by timeout of i_time, instead of inval_mask=0A=
=0A=
=0A=
V3: =0A=
=0A=
    fuse: fix race between concurrent setattrs from multiple nodes=0A=
    =0A=
    When mounting a user-space filesystem on multiple clients, after=0A=
    concurrent ->setattr() calls from different node, stale inode=0A=
    attributes may be cached in some node.=0A=
    =0A=
    This is caused by fuse_setattr() racing with=0A=
    fuse_reverse_inval_inode().=0A=
    =0A=
    When filesystem server receives setattr request, the client node=0A=
    with valid iattr cached will be required to update the fuse_inode's=0A=
    attr_version and invalidate the cache by fuse_reverse_inval_inode(),=0A=
    and at the next call to ->getattr() they will be fetched from user=0A=
    space.=0A=
    =0A=
    The race scenario is:=0A=
    1. client-1 sends setattr (iattr-1) request to server=0A=
    2. client-1 receives the reply from server=0A=
    3. before client-1 updates iattr-1 to the cached attributes by=0A=
       fuse_change_attributes_common(), server receives another setattr=0A=
       (iattr-2) request from client-2=0A=
    4. server requests client-1 to update the inode attr_version and=0A=
       invalidate the cached iattr, and iattr-1 becomes staled=0A=
    5. client-2 receives the reply from server, and caches iattr-2=0A=
    6. continue with step 2, client-1 invokes=0A=
       fuse_change_attributes_common(), and caches iattr-1=0A=
    =0A=
    The issue has been observed from concurrent of chmod, chown, or=0A=
    truncate, which all invoke ->setattr() call.=0A=
    =0A=
    The solution is to use fuse_inode's attr_version to check whether=0A=
    the attributes have been modified during the setattr request's=0A=
    lifetime.  If so, mark the attributes as invalid in the function=0A=
    fuse_change_attributes_common().=0A=
    =0A=
Signed-off-by: Guang Yuan Wu <gwu@ddn.com>=0A=
=0A=
---=0A=
 fs/fuse/dir.c | 12 +++++++++++-=0A=
 1 file changed, 11 insertions(+), 1 deletion(-)=0A=
=0A=
=0A=
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c=0A=
index 83ac192e7fdd..a961c3ed7b26 100644=0A=
--- a/fs/fuse/dir.c=0A=
+++ b/fs/fuse/dir.c=0A=
@@ -1946,6 +1946,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct d=
entry *dentry,=0A=
 	int err;=0A=
 	bool trust_local_cmtime =3D is_wb;=0A=
 	bool fault_blocked =3D false;=0A=
+	bool invalid_attr =3D false;=0A=
+	u64 attr_version;=0A=
 =0A=
 	if (!fc->default_permissions)=0A=
 		attr->ia_valid |=3D ATTR_FORCE;=0A=
@@ -2030,6 +2032,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct d=
entry *dentry,=0A=
 		if (fc->handle_killpriv_v2 && !capable(CAP_FSETID))=0A=
 			inarg.valid |=3D FATTR_KILL_SUIDGID;=0A=
 	}=0A=
+=0A=
+	attr_version =3D fuse_get_attr_version(fm->fc);=0A=
 	fuse_setattr_fill(fc, &args, inode, &inarg, &outarg);=0A=
 	err =3D fuse_simple_request(fm, &args);=0A=
 	if (err) {=0A=
@@ -2055,8 +2059,14 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct =
dentry *dentry,=0A=
 		/* FIXME: clear I_DIRTY_SYNC? */=0A=
 	}=0A=
 =0A=
+	if (attr_version !=3D 0 && fi->attr_version > attr_version)=0A=
+		/* Applying attributes, for example for fsnotify_change(), and=0A=
+		 * set i_time with 0 as attributes timeout value.=0A=
+		 */=0A=
+		invalid_attr =3D true;=0A=
+=0A=
 	fuse_change_attributes_common(inode, &outarg.attr, NULL,=0A=
-				      ATTR_TIMEOUT(&outarg),=0A=
+				      invalid_attr ? 0 : ATTR_TIMEOUT(&outarg),=0A=
 				      fuse_get_cache_mask(inode), 0);=0A=
 	oldsize =3D inode->i_size;=0A=
 	/* see the comment in fuse_change_attributes() */=0A=
=0A=
=0A=
Regards=0A=
Guang Yuan Wu=0A=

