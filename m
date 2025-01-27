Return-Path: <linux-fsdevel+bounces-40151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E73A1DC2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 19:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 643CA1882DEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 18:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1832E190472;
	Mon, 27 Jan 2025 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A0Ig+Rrc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282518FDA5;
	Mon, 27 Jan 2025 18:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738003232; cv=fail; b=YdSuSePTW3YJMtm3Ciw6DUDr8zxjtc3onvLVnOLKjWGx4vr8mZHe/agIZWDditcd4paP7bAjCnDtz+oALSKlKzXbCkaoVpY4ZR1+qibawULDBMAIQgNUJhRBXYqgX6KvFAXTUN+HrMTfLPMpal5y6WvwU8QQk52p02QujP7k30w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738003232; c=relaxed/simple;
	bh=xbvBMRVEIagKkXwTs5Dlurkj4gOvSVFkQ4iwcm02tgg=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=riWhzwbwCofZGE44tkZ5uHghGlVCRPqtaLXLdSt85lV8aHRSxNdp1EvPyJkmlM6DER2Iui1nQTFG8IuRLvec4oe5mi0G4Sogz8n+UGwZ8ShGOvy4zVsDPZeVayjfsiwNAkL/s1Fptdcr7QBMjUjeSqt62XCjdPSVgx6nQVnOhAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A0Ig+Rrc; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50RFuvep004989;
	Mon, 27 Jan 2025 18:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=xbvBMRVEIagKkXwTs5Dlurkj4gOvSVFkQ4iwcm02tgg=; b=A0Ig+Rrc
	uVALBTe3OBbysCCvtzqwj2TJElri0y15XwZ4s7Ye7J6IC/QCtJ8GXZ6h63xJrYkH
	j98AwRGtst6EGGZa6GMYfiqmJRK2MzBkFLmIaPyp5Y7FB1cC3uWAVDRIeL2mis3W
	3Oij2hgQVisyijrJDE4jtCU4tOjbJJEtX2B/EQnpxNIPXutCerQDTorbtyQr2GTn
	xuvgebuWh4F6JX1X6/7eYVMkyIU59v+vfXDazB4cQrhE2Bf7VBzBxjgNRQvIKt8L
	+nKuq2DKGL2v4JCiiqhEdeW4b5r/zbx+it5lyTu1VA6xE+W27NlWhsdgTqwH463Y
	v7l5iXHmxErgIA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44e5unb3k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 18:40:26 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50RIePcq014316;
	Mon, 27 Jan 2025 18:40:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44e5unb3k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 18:40:25 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlz6AlnHy7oRYnNV8LqvHwINQ+U72QBG9jIuxbCR/cVh1v+8MXqfXrsaizT50yxR+p99R+JyjdHzXo/4yxXTvaspYLnPJXPy34zUabXAhVAEcIkkZAgEPswGNkApjUjB3uYz6RnSncP2TxBClYoQ/0ks9lTonfMT7dbl0tBHf2v4581qYb4RPtCPZ802KFV4IJc0+nIexQVecvcMR0Ax+whyL9VJdREsj6p3O8u8o43iu+RsXgKf6NyGXrvDraJUJQEdsNnblN+GH60OOw6aB3cgqmplWgPJJMxXXF17+ObUrUgY8qy2rBtMU+Mqa3o9eZ1ZhWqOL3RiJGu2TZlK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbvBMRVEIagKkXwTs5Dlurkj4gOvSVFkQ4iwcm02tgg=;
 b=LPipCe8X6MPhCR4z/KeWt/lWD4yTZLeWvQngnsUNkBOAobPitjVCQIq6YU5S2rFp50prL6ilN89YtVGEU+84s925pbT/iiJQlNu2j1OUwLkoFeNbadJrBfqB5w4tUKdcUARtVvirSyo3H9d7qb5TRXKhtdL6p/wJx7/ir2p85ri9FAPSjb4FASyM9P7DkDGffRQ8pLoqlBaSikXDOax0u2l6Mvuv2FxmdKZ0a0ozPN9gqCLUIEuj1WEQhi2s7JQRUKReeA0avn/hU3xmmz4hVlcvm7xC8h8CF5uNCjl0W/yegN/TjdBqhjPyh3HUDSf7ENNaTwvmKmON/Lucr2F56w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by DS0PR15MB6230.namprd15.prod.outlook.com (2603:10b6:8:166::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 18:40:23 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%7]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 18:40:23 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: David Howells <dhowells@redhat.com>
CC: "idryomov@gmail.com" <idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Thread-Topic: [EXTERNAL] Re: [PATCH v2] ceph: Fix kernel crash in generic/397
 test
Thread-Index: AQHbax51YyLDQhgFm02bhTgbrhqIz7MfakoAgAuVUoA=
Date: Mon, 27 Jan 2025 18:40:23 +0000
Message-ID: <c79589542404f2b73bcdbdc03d65aed0df17d799.camel@ibm.com>
References: <20250117035044.23309-1-slava@dubeyko.com>
		 <988267.1737365634@warthog.procyon.org.uk>
	 <CAO8a2SgkzNQN_S=nKO5QXLG=yQ=x-AaKpFvDoCKz3B_jwBuALQ@mail.gmail.com>
In-Reply-To:
 <CAO8a2SgkzNQN_S=nKO5QXLG=yQ=x-AaKpFvDoCKz3B_jwBuALQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|DS0PR15MB6230:EE_
x-ms-office365-filtering-correlation-id: 19115957-70ad-4d40-0c4e-08dd3f020f6e
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TGNaZzlORkN3amF0M1h2aTRwRGV1TGxWRXFkN0RuLzg2YVNWSzZvTDBKL2Zz?=
 =?utf-8?B?RWQ4R2pzUXJQQlpkMlZwVTBFdmhWRjlxOXhJZDg3VE1OdER2a283UGJ5ekdK?=
 =?utf-8?B?MmJrak1iWWJTWWlHN3hjek54NVFDenBZV3R0bzlUWmRRcG5MRENWUUVTVEFz?=
 =?utf-8?B?SjFnZnZiVDJMUTlDMDNSMlk2NDQ5VjZ6amNrOWJWUTNjZjlXd3F3cy9ublU1?=
 =?utf-8?B?RmRLY3NtOHF6YS9lU0gwV1RBN1NhOXhYRFVNbjEzdUVQaC8rQk80YjdtNVJh?=
 =?utf-8?B?ZHZMMnN4ZlY2MExSemFKSW0yVEJ6cnU0c21iTXQrRHJZL2k0eVdnTDlhZmhC?=
 =?utf-8?B?YzNvc1BpdC9JbGpEV3Y3UDQyMTNkZlUwemE5bG9PY3l0UCt4ZWpDWjRHN01p?=
 =?utf-8?B?b2pNRGNTWUFQeUh1cGtPTTJzT3ZrdndaaDR4eE1RcnpKZXhoR0FoVXNITExB?=
 =?utf-8?B?UWZvcVlkWUVHQ1ZoN0xmazBXUUFyRmVVZTkrZHd1RTRpejNTWEVRdmptTXJP?=
 =?utf-8?B?WVV3YU1RTzg3QllGcDRtUndvTVBqY01YR01XZ0xVRjYyTVpXOUtZdHIvNVRx?=
 =?utf-8?B?aVNCeGVydU5pTmlIQXRmYi9TZEtCamxlTktMVVdmNHR6TUFHWTJhSThIR3By?=
 =?utf-8?B?cCtsS1RMdlhGNXZMNWRlazdzNFREWS9QK2psUTBnZlZISC9CeENpbFd5a1R1?=
 =?utf-8?B?NjdoRnlqVFB1aS9SOEkzeVpOYWltQ3E4QU1KbS9RblBkUDcrZXkrS0tiWmxk?=
 =?utf-8?B?emVjWmc4Sm5wRWorb0dHdnBDVHg4UU1OYzJHdmJDOG9IejYrcGw1L3JOWjZQ?=
 =?utf-8?B?TWtXdDlCdjFHOThvUmROTUk0SDRKVk5DRGxtbC83SmJ3NFNLNmpRUDcxQ1ls?=
 =?utf-8?B?QTNweGViUjhsTlVHMWpLWHd5UmNqUEhtTnRiNENvOWJhVitDdldOV2RjYjl3?=
 =?utf-8?B?cEJ5aG1ueXZqQjM4UjBWdEJ5a1JSdjBHWVUwN0VXa1Z2cmp4SXRBaDBuSzBx?=
 =?utf-8?B?ZXY0NllSWlZWMHAvRWVOcHRqZUtSQ3FpcjNTVW1jSGNkUXVXNXd3cXNDRFkz?=
 =?utf-8?B?eHdmRUZJQTI4eE1uRnhFa01NWjEzM3h1TWhWVWFPRVlXdzJ1dFBtV3lDUU9t?=
 =?utf-8?B?WUpTT1BzN1pNRnJJb2g2bXV0aW5DNXdmTmpvS1RHSjlEejIxMnVBajZxWmND?=
 =?utf-8?B?cEhobm9CWkFJYWhrQ0xqNWVNQktVK05NY2d1ZTNOQmx6Z0d1VXdXT1daM2NJ?=
 =?utf-8?B?akRqeExqRnVzZk9XWGhOZDRZMVpwUVkwWXAxeDV5SFdJNm40YmxDZDhWWGln?=
 =?utf-8?B?QVN4MG9VSGJpbDNtdjltTFVpcE1wUjF0Rk9BUThtd1FrVkFrL3lZZENUNkdM?=
 =?utf-8?B?RjFpNW8rZjVSTG9pMXQrZEJtM1pPeVlIc2VDYTRWeEFHU0I0V1BxWEN3aUoz?=
 =?utf-8?B?WlgvOHpvMkxIeHBmM0U4MHFqTDRTS1F0ckw0aEpQcHZMa0p0Y09aZUhmdzJq?=
 =?utf-8?B?cDMxR3ZRU2VKK2p0K3c2MytIVHlMSVBVRlpGdlczOTdSZHE3MXJsbHRVaENj?=
 =?utf-8?B?WENkSDU2SjUzTENXZ21zUGVmWjBTeDlMdURQRGJ6NllaQUtabWhsN1NLZjZN?=
 =?utf-8?B?MmdmUCsxd3FsbEZqa3B2aDRrc0tqaVVzTkRxTnhZSzJmZEoxVDhmaVZwdXll?=
 =?utf-8?B?VnQzKzN3VWIzVnRWdzQwaXlSTnFNTUZKSlRpdmNPcG5reGFrZ29DM0J3dzhX?=
 =?utf-8?B?azh2T21qTmFMOEZrbDNoaWthN3A1THJDbVZacUVsYy83citMd0NzS3laSTU1?=
 =?utf-8?B?eFhGR1p3enNUdVJtWkNZb3ZDU3BCVldVbmZsTzVpc200cXZPS2JHT3BQZHRB?=
 =?utf-8?B?eEdla040WmFMeFdHUDlWUzRlL29NcjNiSC85QVBHNXptMjMwaDhzREpMTFRB?=
 =?utf-8?Q?TOW8Prkqj+4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RTRXQTUzdGRSTjFHdXlYMm5LbTlCOElrZmZkVUs2VUxoRjZxaUFWclJrUnZS?=
 =?utf-8?B?ajB0WE4rcFRxek9sSGhLSmNOQzNjKzJXbE1aQSswcUN3WndtczBpckpjMlNw?=
 =?utf-8?B?bnp5Y0x0Ym43VjFiZkJNd1k5bUgxWmw0RlcwMk5KSVdkUVozcWtmeXFpYkpX?=
 =?utf-8?B?azczNjBhMFUrU1Vrb2xPSnAvaFdzUGxmWWUzaDNTWWhkMlFNeFo5Y2loKzdx?=
 =?utf-8?B?dGhQMERuckpENzczR1JQME82dEVPcSs3WlR4SDA2WC9Sd3ZWZnhGUUNpc081?=
 =?utf-8?B?MkZMbWorUmRFbytpQ0I3NG5FMmpiZXY1NGp6Ymt0QUpUVllXa0d6cjJaRnlq?=
 =?utf-8?B?c1NjR29qR0RnbXNYTFZpVE5yQVZBeXpRM0s4OWdzOEdzUE0zUVBWVDR5bHdy?=
 =?utf-8?B?SVBIU1ArMytrVjJiTWJJV3RpYVVhZ2UvTWtiUGwvK2NrZFRHRnVveGx0UXJx?=
 =?utf-8?B?MEd3NVpmQ3JYZ24wZTJJNVNmRnhjbm5zU0w0YU9hV0NQWm9tRE5zeTQvMjQ5?=
 =?utf-8?B?dGtTUlpnU1FhelB2YnFaYVNRdGI1YVcyTzRicGZ3L3pJV3I5MGtsYmg4UU9K?=
 =?utf-8?B?RFc5RnJCQ2NhUmd2ZUdtSUEzMjJsbUl5aExGTk9oK0FPS2RGbHRxU0ZibHdZ?=
 =?utf-8?B?bnJKVEZBZ0ZabmQxMVE3T1FoeTZza3dRTFgyWGJ4aU9nS053M2pHMGtqK2Fh?=
 =?utf-8?B?L3ZqY2xzemg2L3BUVUsveEF1S2RHV1Z0R1ZNcEh6V3RvNnRPUUYrZDRxczV5?=
 =?utf-8?B?bjFxYUNXYnc3LzIxb0Fmc3k2dTdWQjlUUkplNVFMcmJiUUEyUDRFcDFiZ0Nw?=
 =?utf-8?B?cUtoaENjNGdEa3JiN2VXVVVrK2M1bGxYRURRUUxrMk5zMTV2ZHhRamRnVUky?=
 =?utf-8?B?YktBYnJnUjdHWnlaUTBWcjNDNHRMVUlMaTR0Q29Od3BYOHIvczRLSVVZVk5X?=
 =?utf-8?B?UlR3S0RLbytZblRZNkFLZk5hZnZVUmJySFlTY2tUS2YyWkJvSGhFSHRyaGJm?=
 =?utf-8?B?SWdadUd4NG90a1IwTWliVk1HMWcrMWF4MGl0TzJrYW9OaHpUdjRrZEJUbm16?=
 =?utf-8?B?djdQUmJtWGhpY2pTd3QzeUZ0RFRieU1SK1pkb01zNUh1SVY1Mm1KQmlTQlZH?=
 =?utf-8?B?V3B2ZDVXZzNFaTF5Mk5ya0JKVGpQaDhlV1FIRmVBd1dieWcvSkpuSGg1Y1B4?=
 =?utf-8?B?Y0R2VXI2b000YjUvZVRFMS8xU2p5U0tseGRHbWxEUkw3L0ZJajhqUERjN3J4?=
 =?utf-8?B?dDJkeGx3OHl3cVpZQzVucEZCTXNvZ3lJY1BrNGJaN3Q5aWcvd0FGSHd4TmI1?=
 =?utf-8?B?dFJ3UFUzN1pRbTRXZG9sMjh0Sno4M0xmYnBwZ1REcmFiY2JLK3htWVlUWlZR?=
 =?utf-8?B?bEtqYU1COUg5dUNtNkVsL2JNcE1wdmx0S2E0N2lKYjZnWFM5UmtHU1lZQnNR?=
 =?utf-8?B?RmxYNlV6dTg2Q2tyYzBWd1M2MllQTUdlNitBbVhNR0JsdzRPSUtqenB6OHhN?=
 =?utf-8?B?dEhNZklvaWllNWFmSWtFQ05USDMrVnNyYzhwZmV2QXJQdEdDQnNieFgrVWVj?=
 =?utf-8?B?QWU2NVBJOWtvUkk5TUJhZGhTaEVZYXQ3RXpxUWROemJ5WGEwMU1YSUhDcSsv?=
 =?utf-8?B?cHp0NVA1dzdGb2NITkYzVE1DMXBkZzJvMHduUklxdXd4bk5xWTRSeDQ4Y1hB?=
 =?utf-8?B?ZUwwUmtEUVFSVC9vNWpKSWtDYnZzYmdvMzZub3Rma3dpVVJsTTRQTUNqV29y?=
 =?utf-8?B?VUtXS1lTN3ZWT25WaXF6ZjlIK0tZOVdiUzhTbjE5L0pMOTcrVE56QVNTOTZY?=
 =?utf-8?B?N0RWMW1YdElaK3M2SDdHbUdFdmk4SmRKZWlyOGE0S1BBak5PTkN4c255Sktx?=
 =?utf-8?B?ajBMMS9rSnB0akNDeDhUNDJMZGxoNElPYk5aQ3hPeGI4Slo4OHVGZ1NrOGt5?=
 =?utf-8?B?WmJmU0IwMkdacVF3R0h3ZkZTRWpYakhsRzgvQjFjRjFJZDB5SjgxdXNMTEc0?=
 =?utf-8?B?WlhYd29yZDVpdlBHL3lpUTdUMmpXRlR5ZDdzY1psbXhqZFFndDk3UG1GdWxm?=
 =?utf-8?B?dHJ3VUQ1MExleXJ5MVNRV0xrOWYwZ0JSYzZOWm04OS9jS1JZOUNlcWpGWnBC?=
 =?utf-8?B?eXduWDdBdk95UHI1cEdURGdWaDBDT1FOZXVWWGNwV0hmRGgwOGU0Z2JUMHBX?=
 =?utf-8?Q?BO9A6GFPQnHjbJ2UXXd9pLE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <63F4548260162F49B497B763E24D409C@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 19115957-70ad-4d40-0c4e-08dd3f020f6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2025 18:40:23.7483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ImnRBUcWSW7WveFcWJEBBX6YW/y48zr+Y+K17j0Dud/MxKCddxAwC0U5GeeDYIoIv6Pq3zypPyGktNc48oA8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB6230
X-Proofpoint-GUID: Y02Pz8O7no-o54wBdmnH_zovQtSg6UiE
X-Proofpoint-ORIG-GUID: fVHaEYbjraIKUVYKGd0v4G87Fb-mHMrT
Subject: RE: [PATCH v2] ceph: Fix kernel crash in generic/397 test
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_09,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270146

SGkgRGF2aWQsDQoNCk9uIE1vbiwgMjAyNS0wMS0yMCBhdCAxMTo0NyArMDIwMCwgQWxleCBNYXJr
dXplIHdyb3RlOg0KPiBFYXNpZXN0IGlzIHRvIHJ1biB4ZnN0ZXRzLiBQaW5nIG1lIG9uIHNsYWNr
IEkgY2FuIHNob3cgeW91LCBpdHMgc2ltcGxlLg0KPiANCj4gT24gTW9uLCBKYW4gMjAsIDIwMjUg
YXQgMTE6MzTigK9BTSBEYXZpZCBIb3dlbGxzIDxkaG93ZWxsc0ByZWRoYXQuY29tPiB3cm90ZToN
Cj4gPiANCj4gPiBJcyB0aGVyZSBhIHdheSBmb3IgbWUgdG8gdGVzdCB0aGlzPyAgSSBoYXZlIGEg
Y2VwaCBzZXJ2ZXIgc2V0IHVwIGFuZCBjYW4gbW91bnQNCj4gPiBhIGZpbGVzeXN0ZW0gZnJvbSBp
dC4gIEhvdyBkbyBhIG1ha2UgYSBmaWxlIGNvbnRlbnQtZW5jcnlwdGVkIG9uIGNlcGg/DQo+ID4g
DQo+ID4gRGF2aWQNCj4gPiANCj4gDQoNClNvLCBpcyBzdWdnZXN0ZWQgZml4IGNvcnJlY3Qgb3Ig
bm90PyBJZiBpdCBpcyBub3QsIHRoZW4gd2hpY2ggc29sdXRpb24NCmNvdWxkIGJlIHRoZSByaWdo
dCBmaXggaGVyZT8NCg0KVGhhbmtzLA0KU2xhdmEuDQoNCg==

