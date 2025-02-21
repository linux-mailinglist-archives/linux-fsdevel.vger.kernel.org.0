Return-Path: <linux-fsdevel+bounces-42202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B8EA3EA5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 02:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33FA14229A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 01:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A131D63DD;
	Fri, 21 Feb 2025 01:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gHCQ38DF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B78A13B787;
	Fri, 21 Feb 2025 01:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102541; cv=fail; b=NnCbZieShUCrD8ndNjtgGeNBkKGyv9OAAcO9dX0G1Is9s9JmoECGwRlprZmPe5oeN8AsEPzTA41uV+EA8/WpTeeM1Fa/Cd+5u03vxkYsrqK6fMWr7vgnl2h16nXNOSmgBpoaLpUjq5yLFIagP74D5RHUQk7zatT1fYvrX3u9AXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102541; c=relaxed/simple;
	bh=lyiHo+tHRivm40MHI4KBMoIaROnrt045MscDv9HeUP0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=mVVQ5kw3V+406D2+9nXvCOzpejSWkkiaN2jd/kvyOkZdNahDQdXKSN5ciQwRQX2MftEDIU9LvWCdJO1VUBYalExadDjA1rlH9OvU43Azy8N18Hux2l0daafs2jWXMSg/iGFcRLHkz1bfka3O9q/xNIAkZZvszjDRthEJhm4Waxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gHCQ38DF; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KMncqC030914;
	Fri, 21 Feb 2025 01:48:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=lyiHo+tHRivm40MHI4KBMoIaROnrt045MscDv9HeUP0=; b=gHCQ38DF
	hlZX+wMsORq3z1OjLyUQmV+RjbTeCk9N/8Q0jfIap/x6LHkP00LFVAeADB2+ORBU
	YRcvDCwni0zXqsA0sZHMCJ5rIRxRY2PmrTPFmLCgJE/nk3sJgvkgNy98w+Er2nPE
	aepuPGAqofk17c1f4O+hqEgkK6jyludHzTPsOW40XYd0sgix7yezwLSQmECtM/By
	1033K3+zWyMyRdBvJqeO2SH9KHyby4l/MgXh0+Gxn273Vd4gjzT3trr+4hUtNEPi
	BqVYG6cj7BQY8iq0N4oMXQQ0QC2t+IEtVhKbWXuz1tCN0j23ULRntRvCRSYjegUU
	1YMcJ1OgXW75KA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xdharkm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 01:48:13 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51L1jAto014081;
	Fri, 21 Feb 2025 01:48:13 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44xdharkm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 01:48:13 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a58HdehFcepZSJ+PnLB9jVuSiX0GDRzVnmJizKRK5levVg+q88JFGNq40MQyUXfsMrMbq7nvS9T/BHNsWPABlJ0iR8fcEmY7aVs4j43vFZamV7J1HYCbr3nS2QSFlh3anIWXgQWlLUUwRiRkEqNgX/3k+MRimCHT4rza29pXbOi8KrZTg6yxdENk3ViEOXkbwpjNExWrOihmWu/l7//Wzt6pz0RRrZweVCE7OXDn+6wwBvxNi9SzbdHjnG72kbhEox/6pvD3RK5iJcz+HSg3S7q8TThZ3IfIaZLy3iBFuj/9xhPS2ZBjG1GiflfNdAdmL3uW8VmF0ck3QO7kWhs3NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyiHo+tHRivm40MHI4KBMoIaROnrt045MscDv9HeUP0=;
 b=CIRl26GGFvxMTQj6rCDiBvmW67dP7qGi/aXNfgvw0/yoO5mome0v71G5lqYO6iwjeP/TuVmBYcifTVZTCTP5IUjFOFgmtDore4Eu+54FGmrtw/vzYs/h2DqMW+8ND90M14UOnzp9hUNYqKq0DGijCUvCD+0zybPYEs+VyvH8+CnN/5Mdw4ToZ3VoTC5nDGjn7uqrfelbe75v0CR0UclKlaWWkzaT2ClHkaqphy2KayMkfbcnvq33kGlIl9+JjSkpvCGg/AKIV/yWjoybi2JQKdUIwxVxnPhNcKWuObes4KYdnsbqB+ZEPWxt11+NFCf67jNZ5riFPj0wXVSTR0WNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SN7PR15MB4190.namprd15.prod.outlook.com (2603:10b6:806:10c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 01:48:11 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 01:48:10 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "brauner@kernel.org" <brauner@kernel.org>,
        "neilb@suse.de"
	<neilb@suse.de>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        Xiubo Li
	<xiubli@redhat.com>, Olga Kornievskaia <okorniev@redhat.com>,
        "Dai.Ngo@oracle.com" <Dai.Ngo@oracle.com>,
        "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>,
        "chuck.lever@oracle.com"
	<chuck.lever@oracle.com>,
        "anna@kernel.org" <anna@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "miklos@szeredi.hu"
	<miklos@szeredi.hu>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
        "jack@suse.cz" <jack@suse.cz>, "richard@nod.at" <richard@nod.at>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "tom@talpey.com"
	<tom@talpey.com>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>
CC: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "netfs@lists.linux.dev" <netfs@lists.linux.dev>,
        "linux-nfs@vger.kernel.org"
	<linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-um@lists.infradead.org"
	<linux-um@lists.infradead.org>,
        "linux-cifs@vger.kernel.org"
	<linux-cifs@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH 3/6] ceph: return the correct dentry on mkdir
Thread-Index: AQHbg/I/TGRU/I626EOmbg/i5ntYvrNQ/W0A
Date: Fri, 21 Feb 2025 01:48:10 +0000
Message-ID: <e77d268e129b8002e894fc7c16ae0e2faa1cd8dd.camel@ibm.com>
References: <20250220234630.983190-1-neilb@suse.de>
	 <20250220234630.983190-4-neilb@suse.de>
In-Reply-To: <20250220234630.983190-4-neilb@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SN7PR15MB4190:EE_
x-ms-office365-filtering-correlation-id: ee79b235-1888-4359-8870-08dd5219cc12
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?YkdVS0xlblFnS1lXcnpwOUFBQWg1M2lwelJrRjNqL0Foak0ydmUwZnhmcGRC?=
 =?utf-8?B?UGZORy9RR2tLTmpYQ3dmUndEcVFIV3hBbzVsTzhRNGdVV0hmMnJncG9sQVV6?=
 =?utf-8?B?SGw5TlVRcWUwdkZaSFlsT0ZNdFB2M3VxYnlwNWtTeEpnSTlFYWtpZUFsZVBr?=
 =?utf-8?B?T3RtM3V3eUpXcXR1ajhwemNqTnRha2RRcHlnQmVvdmJ4UmNoZGhhQkdVWmY3?=
 =?utf-8?B?eVMrVDFCQ1dzRVlsUkZSTjAvaUo3YXd2Sk9Ceko3RVkxRklBQjJoeXg1a2ZW?=
 =?utf-8?B?cnYzamlpWVVwRmF0TnhUNFdWUEJnRzNseHRONjhjdEI3dW1lZGw0bjN4ZEIr?=
 =?utf-8?B?UjRqdU0rVEhSUGh4bVFPUmFWZHRUQ1Z1MjFWalVsSzA0MHhYRzJkV3FkeVU5?=
 =?utf-8?B?Z1FkekdrenZQV00vcUNRR2JOa3pCdXF4cDdpVUFIaENvVmx1Mk13Tk0xbUdj?=
 =?utf-8?B?VGE2elVBRXRWYXdRN3djaklKQVFvN0xwcE9EVkZnWUR2SlNKVHNaeTdFZ2ZN?=
 =?utf-8?B?RHRDVVlWY3JSZ3Z6dzlqNE85cmU4OFRVZmNQRTlvV2I1emdlZ2lKeCthM29Q?=
 =?utf-8?B?WDdHVUVWdEpGY0VXMlZOSWU2YTN0SE1KWXIyR0cwNlJ6RTQ4RHR6aEllMVIz?=
 =?utf-8?B?MkFBYzYrWjB3WEtvZ0lqVVNVVndKNWV6SE16aE82ZVR0WG00cS9iRkNLRHRT?=
 =?utf-8?B?eFRwM3BqQ2k3cklSWGNPMkYvL2k3Uk9LK2p4V3BUWTNzNis2VkRMZDQybGZq?=
 =?utf-8?B?NVhhNExrMk8vYW9mZkswUDUyQlZ2T0F0dlNUU3lsOG10NGhUNUFaUmZxUEVT?=
 =?utf-8?B?aEx3Nmt5bm1CbXp5OGpjL084VFZGM1R1ZThYaUN3WE5kNldYeE9aeGw0bmUz?=
 =?utf-8?B?a3JKWkM5UDVFSzNlcm9ibno2QVkzNWhtYWpyQ2NDVGtEbHdIZytqSTY0ZEY5?=
 =?utf-8?B?OHV2Wm0ydHNKNFViaW5HYmxmWSs1MWw5MTk5UlcybGRucmM3ZHJrYWkvZ3o0?=
 =?utf-8?B?OEJzdjRTZHBzMXdDZmNydDluVXh4UUt1YzRMa2pZVTFZVS9hNC9xcGVzT0oy?=
 =?utf-8?B?OEpiMGlBbE9qamErcHdDdUFWdWM2dXNCT2JSbjJEbUNNZ3VSOHdBSTZWODcw?=
 =?utf-8?B?NFhYK3VRdEFBVGFsTG51RmZEdWRjQ1BsYjFBb1d3cWI3TWhuQ09lL0tDNXBH?=
 =?utf-8?B?Mk4vMWlSSXpmdUpQeGJLRTlpdGNCTmZNZ21HaVhkSnNzdGJGRDZkaDN5ZE9H?=
 =?utf-8?B?c0xIN0ZNc2VUcEZ3cXJKUEZnZi9USVliZUlIR1FrTmxuUU1kL3ViNDlVL2Y2?=
 =?utf-8?B?UGY2ZEpiYnVLdmNtNmlHNjF0cm1NbGpsN2NtaEZCbmkyZXFTTDB4R3psK01C?=
 =?utf-8?B?YndVSUVhbVZzeUdCLy9ZNGpQK0J4RUx4VjlrQm9Ua043aFRIMGhhb0RsSWx5?=
 =?utf-8?B?WGhuazhEajMyZG9YTzdmUy83SzZYZDcxbHpYend3RHRCYmlLd3JWWTZWSE1S?=
 =?utf-8?B?VlF5Z1BaRjQ2MS9YYUhyenBRcDFwOEZmVHluMis3MDNUZHprUnFRRnFYWVlI?=
 =?utf-8?B?UFZtaE51c2hvWlVoeHd4ZGhMaFNEdlhEcVNpaktsZVdpY2ViajJEdlp0eXo2?=
 =?utf-8?B?d3AzOTJYT2lqS1dvQ1g1MHpNUGI5dHNrbko0b2EyZHRNOXVvcmcwZUpycVEr?=
 =?utf-8?B?Qkhaa2Q4YjZaZ0lHUUxsNXVxRkhJcEJVV0VCN29Sa09ZVldxWStRc0ZJVWJh?=
 =?utf-8?B?K1kxUnloMSt3NUpqc0cvdVNPMUVCSkJkRy9Gd1Z5eXJjSU1IRzdYTTVUblRk?=
 =?utf-8?B?cmFQNU5HaGtNdlM0YU9wMzhFWlZSRmNNU3BaOG5LMk8wNlYvdGFSNXR4aUEw?=
 =?utf-8?B?bVVKVzZyMURoMTlUWTRYQ0E3enlha3JZNDFKRVcrYkhoNzhWSEtaTi81VjNP?=
 =?utf-8?B?MHBWaGxlUngxb0s1VWRlcFgxb21KNzV6Y0F4OHJlUWMwb0FSNC9BL1pyeHhp?=
 =?utf-8?B?TUxnTGdiUnRBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFhiRDBVOGVrNTdocVA2bnNPYUFKWTJyRjB3em1Da0JZbWN0Y1B4MHFMYmFh?=
 =?utf-8?B?TzZ0bTI3Tkc4RmMxdmdmd1RPS1ZVYlYwZ1N3Nm5LL1dvdUdYL240YjRlMktV?=
 =?utf-8?B?OXM3bFJjQ2UvUTE3WTlpaHRKcHVUek9NRm1hMW4ySHdCMUdxT1VHQWcyTGd2?=
 =?utf-8?B?WEZlREZpSnVHTkVEWDNobXBVN1ovRlpwTDJ1bEpNVHVMWjFtdEVaVjcwNWpM?=
 =?utf-8?B?OFNwZXZSWklzYUtwaG5Jb1hoQ0pzRWpxbHpzaDA2elJxWDY1SWk2OU9UQkww?=
 =?utf-8?B?S0JQUmMzUVNLUGxnaUw5ZHR5SjJMak1PY0ZzN3J1NGFnM0xOSXcvWFVBMFQ0?=
 =?utf-8?B?N1A0RlhqYjlXWFlncUxzeDdQOFJGbmRMQWx2Q3hDcERTZm11NVVzNG90MHdV?=
 =?utf-8?B?eUp3azVsTUh3ZlE4ZFNJa21KTiszRkROVEtvVzVRQmdZK3Rsak5tSER6bVdx?=
 =?utf-8?B?dlQrNUs5cWlQY3J4TFFyU3RvV2wxTVFrc1hNZFJFNlV5UHhFQzJnT1lTQlZ4?=
 =?utf-8?B?OU1oZHp1bmFDNWNpNzRKNFBES1ZBcWdlOGIxN2U1WjVzSmlrZkhDYnZLakFZ?=
 =?utf-8?B?VW5XUEI4UXJobTNROXJPMFJBckZkanJVemdEWFpnWUIwdzhZZjIranFWV0Np?=
 =?utf-8?B?MGtXNFEyQmdVOEY1R0FKUm83N1hnV2hSMUtMamVWU3JJMHp1YkowWjdacUhG?=
 =?utf-8?B?Zlc5eUNvODYvMlcxcEFtVFV3L0QrS2h4V1k2M0x6QUVrL1piRVFMekJLeHd4?=
 =?utf-8?B?SUJtWmZuQXBmaDdtQngwTEMwRmtCbStWU1pQQUlFdW9hZXQ1bllHeUltWUtB?=
 =?utf-8?B?ZW10VHRsOWdDcUlDMUh4cEtVaGRmRkVUaWR4cENHMWRUY2MzUU9NYTRqRXhI?=
 =?utf-8?B?MnFWVDR2U0JXSlovNHR5NGxLenFHRXlZV2dXOG9OVzRZUWlmSm9aZ21XOU9D?=
 =?utf-8?B?TW1TWGt3aDcrWkFNc1dUWkdWV3ZpWkRGaWhZNkhpSG9zY2dpMHZBWWQrUU9R?=
 =?utf-8?B?MEpubVBlc3U2M3huOC9taWJjditGOUcrM2ZRWXFnQUFITmNCQWdSbXYvK0h4?=
 =?utf-8?B?bmVMYUxzcGMvUkFTV2hmazZob3JjOEVKVzVXcFhWU3ZKY3E5S0Rqc09Ia2lr?=
 =?utf-8?B?UXk1M094aVlHNXlzNXRGQlZ6YWJmelMrZXdjWkdDWUhIV1NhaFV2M1EwRGJK?=
 =?utf-8?B?cU1OUzJqSVkrUkNKc1JobmdrTnMyRDNaZysxc2JvbXRMcjlrNkRpS2JLTXpq?=
 =?utf-8?B?ZGVHZTl1dFJhSG0yTWVBUjFKUURQYU5vanRyQm9xc3ZSV0ZVYW5KUkhnNkg1?=
 =?utf-8?B?Rkoyc0laS0xWTHdnZ0VranpEaHlkS2FhUnd3ZGNhYXJlcEVocGsyaFBITzJK?=
 =?utf-8?B?VEIwQVpucVZVQmgwNU5WOUJCZjk1VERMdTltaEFQN1FubDZreVdiY1lVc2dU?=
 =?utf-8?B?OWc5YlhITTU5ZWdiUXpWSVFGdkJCaHNZTEhzV3lFRGJMSktRMXRsYzE5Zkh6?=
 =?utf-8?B?UXpjcFFGUWl2ZkVoK1lMRmhVU2tkVlFvL3BhMU9uRU4xWEJoeTFPZ2FSQ1lH?=
 =?utf-8?B?M1BoMWFnRk82KzBhbEtIYy9WWktUQ1ZrYStoVUhmRzFjaldTZ3NOcFFZRlQz?=
 =?utf-8?B?dDVmYnp1b3d4SmovZ1dlK2Z4T2kySDkrMm03SEl2Wi9PbDJPSmZqTWhONlRv?=
 =?utf-8?B?SVVnUmh4VTI3WE5USzdHVTNwczdyRk5VUlJjdE5KQU9NcTFtdGN1TGdkQ2do?=
 =?utf-8?B?OWVIaHRONFd6TU5wSkFuVGVMemxHOWtYd0NLWExtNDlPa3JCamJnWVR0Z2py?=
 =?utf-8?B?d1NWZDZudE5hangyeVpUU2YybGFjdTM3WVpjcUkxYzdxZDlPdzRGTDJmTEpD?=
 =?utf-8?B?aGdweENYK2tzbGwvdmhBTFl4MXRJVnFMdWw5TXIwTXJQTG90b0xxcnFaMUpm?=
 =?utf-8?B?T1h4NlcwQmYrTGorcDN4SW9BaTcveEU4K1JvRU1DVVpZOVUvT1UyTE16SUpa?=
 =?utf-8?B?V0ZHMHdoV3poM1pRSjQ2TXdQZE5YV1FORTVTOSt0TFpDOFBpSGtONG9BU3NF?=
 =?utf-8?B?V1M3V0ZEalFPVWJTOTdMeHljR2k1ZXpZY2dzN1Y2d3kzYVpWcGhJWlU2Wlpy?=
 =?utf-8?B?b09pQnpxTU9uWnR1UDBIYU1RR0xXeVV6c3loUEZ2Tk1iZUNSY0FFS1krNXdI?=
 =?utf-8?Q?td4SMAHDx6T/DfDVput7YTA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E12F2875D19DD44B449FCA104D33FCA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee79b235-1888-4359-8870-08dd5219cc12
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 01:48:10.7547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bkOj8sggCxQTUADJ9Ck/ygko1uSSNwgt6I94fo7mGGbaq5m30utxAjpg7IfrLe5rl52uHuWzAthA/S3ZP35tug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4190
X-Proofpoint-GUID: s1Di8n9oBEODf2o588TAtgcuh3LT8jIL
X-Proofpoint-ORIG-GUID: Dcjnl5vKU05pfbDBs5bYlX_R0Fw4KbIK
Subject: Re:  [PATCH 3/6] ceph: return the correct dentry on mkdir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 suspectscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210009

T24gRnJpLCAyMDI1LTAyLTIxIGF0IDEwOjM2ICsxMTAwLCBOZWlsQnJvd24gd3JvdGU6DQo+IGNl
cGggYWxyZWFkeSBzcGxpY2VzIHRoZSBjb3JyZWN0IGRlbnRyeSAoaW4gc3BsaWNlX2RlbnRyeSgp
KSBmcm9tIHRoZQ0KPiByZXN1bHQgb2YgbWtkaXIgYnV0IGRvZXMgbm90aGluZyBtb3JlIHdpdGgg
aXQuDQo+IA0KPiBOb3cgdGhhdCAtPm1rZGlyIGNhbiByZXR1cm4gYSBkZW50cnksIHJldHVybiB0
aGUgY29ycmVjdCBkZW50cnkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBOZWlsQnJvd24gPG5laWxi
QHN1c2UuZGU+DQo+IC0tLQ0KPiAgZnMvY2VwaC9kaXIuYyB8IDkgKysrKysrKystDQo+ICAxIGZp
bGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZnMvY2VwaC9kaXIuYyBiL2ZzL2NlcGgvZGlyLmMNCj4gaW5kZXggMzllMGYyNDBkZTA2
Li5jMWExYzE2OGJiMjcgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvZGlyLmMNCj4gKysrIGIvZnMv
Y2VwaC9kaXIuYw0KPiBAQCAtMTA5OSw2ICsxMDk5LDcgQEAgc3RhdGljIHN0cnVjdCBkZW50cnkg
KmNlcGhfbWtkaXIoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsIHN0cnVjdCBpbm9kZSAqZGlyLA0K
PiAgCXN0cnVjdCBjZXBoX2NsaWVudCAqY2wgPSBtZHNjLT5mc2MtPmNsaWVudDsNCj4gIAlzdHJ1
Y3QgY2VwaF9tZHNfcmVxdWVzdCAqcmVxOw0KPiAgCXN0cnVjdCBjZXBoX2FjbF9zZWNfY3R4IGFz
X2N0eCA9IHt9Ow0KPiArCXN0cnVjdCBkZW50cnkgKnJldCA9IE5VTEw7DQoNCkkgYmVsaWV2ZSB0
aGF0IGl0IG1ha2VzIHNlbnNlIHRvIGluaXRpYWxpemUgcG9pbnRlciBieSBlcnJvciBoZXJlIGFu
ZCBhbHdheXMNCnJldHVybiByZXQgYXMgb3V0cHV0LiBJZiBzb21ldGhpbmcgZ29lcyB3cm9uZyBp
biB0aGUgbG9naWMsIHRoZW4gd2UgYWxyZWFkeSBoYXZlDQplcnJvci4NCg0KPiAgCWludCBlcnI7
DQo+ICAJaW50IG9wOw0KPiAgDQo+IEBAIC0xMTY2LDE0ICsxMTY3LDIwIEBAIHN0YXRpYyBzdHJ1
Y3QgZGVudHJ5ICpjZXBoX21rZGlyKHN0cnVjdCBtbnRfaWRtYXAgKmlkbWFwLCBzdHJ1Y3QgaW5v
ZGUgKmRpciwNCj4gIAkgICAgIXJlcS0+cl9yZXBseV9pbmZvLmhlYWQtPmlzX2RlbnRyeSkNCj4g
IAkJZXJyID0gY2VwaF9oYW5kbGVfbm90cmFjZV9jcmVhdGUoZGlyLCBkZW50cnkpOw0KPiAgb3V0
X3JlcToNCj4gKwlpZiAoIWVyciAmJiByZXEtPnJfZGVudHJ5ICE9IGRlbnRyeSkNCj4gKwkJLyog
U29tZSBvdGhlciBkZW50cnkgd2FzIHNwbGljZWQgaW4gKi8NCj4gKwkJcmV0ID0gZGdldChyZXEt
PnJfZGVudHJ5KTsNCj4gIAljZXBoX21kc2NfcHV0X3JlcXVlc3QocmVxKTsNCj4gIG91dDoNCj4g
IAlpZiAoIWVycikNCj4gKwkJLyogU2hvdWxkIHRoaXMgdXNlICdyZXQnID8/ICovDQoNCkNvdWxk
IHdlIG1ha2UgYSBkZWNpc2lvbiBzaG91bGQgb3Igc2hvdWxkbid0PyA6KQ0KSXQgbG9va3Mgbm90
IGdvb2QgdG8gbGVhdmUgdGhpcyBjb21tZW50IGluc3RlYWQgb2YgcHJvcGVyIGltcGxlbWVudGF0
aW9uLiBEbyB3ZQ0KaGF2ZSBzb21lIG9ic3RhY2xlcyB0byBtYWtlIHRoaXMgZGVjaXNpb24/DQoN
Cj4gIAkJY2VwaF9pbml0X2lub2RlX2FjbHMoZF9pbm9kZShkZW50cnkpLCAmYXNfY3R4KTsNCj4g
IAllbHNlDQo+ICAJCWRfZHJvcChkZW50cnkpOw0KPiAgCWNlcGhfcmVsZWFzZV9hY2xfc2VjX2N0
eCgmYXNfY3R4KTsNCj4gLQlyZXR1cm4gRVJSX1BUUihlcnIpOw0KPiArCWlmIChlcnIpDQo+ICsJ
CXJldHVybiBFUlJfUFRSKGVycik7DQo+ICsJcmV0dXJuIHJldDsNCg0KV2hhdCdzIGFib3V0IHRo
aXM/DQoNCnJldHVybiBlcnIgPyBFUlJfUFRSKGVycikgOiByZXQ7DQoNClRoYW5rcywNClNsYXZh
Lg0KDQo+ICB9DQo+ICANCj4gIHN0YXRpYyBpbnQgY2VwaF9saW5rKHN0cnVjdCBkZW50cnkgKm9s
ZF9kZW50cnksIHN0cnVjdCBpbm9kZSAqZGlyLA0KDQo=

