Return-Path: <linux-fsdevel+bounces-42201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5ECA3E9D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 02:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428DA3BABFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 01:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731924207F;
	Fri, 21 Feb 2025 01:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VjvO2rdb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4013127726;
	Fri, 21 Feb 2025 01:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740100910; cv=fail; b=VveTYjdsaHUf3IA3khxRlU3J8f9CS/zsLvfHrLuSUNvh+WE7hRQbYkHtcCjuRMgJ88BnWZoCTsOtFmYbF5UWn1JCVVki8Rn/mVS2jMI9GkDzPXPEuTsrdCAcQB44erALYYoofgSf/0S06QeYavFmxcCaBSDWP86SNYbElA37I58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740100910; c=relaxed/simple;
	bh=0o84wgMczG2Ne2YK5TePNmdVnw28ycCv5EW54qC3Udg=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=ERkaoIYovllXDaBC0j54n1yNqQxVWFFfqPzt6+SSB9MsOzmaN9Hk6LltKbES9+7rCxiUp7ww+QP8ZlugTd19qM74Uq9y8PwDd9FdOwyzJ6sQsxDqhisHm9a0hW0zyYLJ3ObK/RZvLEIjBFAVQLd/6PWneRhXImxr1iQ8L573zQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VjvO2rdb; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH25qO011118;
	Fri, 21 Feb 2025 01:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=0o84wgMczG2Ne2YK5TePNmdVnw28ycCv5EW54qC3Udg=; b=VjvO2rdb
	JRD40R87P9p3TV6255W2JvtrgWA7k7kSGD5Yllqr9rEYOzxbNh5IA2A3sFCIwyXZ
	Fq+eTrLqOhQor8IFRb0uKJq05PG8qPn/mDidzSjizhIkIpDqDw1CPA7u0WSxEc8S
	NPvoE3vz0hDzXF/xAe7YIvhQH4C4nx2Wpgrtrf3maE5f6d8O8sLPzOmCjT+ReVj6
	PAovnY7AX+hijqA1up4WkTInk0m4z4HHyDUdS2nCtvmwADqGLO5wS8P3T7gjwyjE
	1tDfxti0vz5SaeO+DxvIhboXdTrWysO8lIUxFJxiwTMfk4odlbbemN6Y6ms+rT5D
	sX0cHve6NUqTlg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44x03qvw3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 01:21:37 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51L1K3CF022410;
	Fri, 21 Feb 2025 01:21:37 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44x03qvw39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Feb 2025 01:21:36 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bulCAhXJy46V2yvf77cYWNwQsHMxGQg/Itbdm7qcEymKs5wCNYCa8yQOIlW5yMhxT1ttcTOCbFjCZoyxeSLae/MaJja4A6dTePUp4ARjNoPdC1xhCqQKwgPcArlqLbl74Vg1ynlpYALNIaq0sDdDVzAAofNznQ6RhL0/m5uf4D7Ekx9818oot/xnpDT77IxZ+CYBWsCFpfb69NllhYSA5F6lzDYgAddoTmbWno/11C3hcib6Mg2DnJ3L+H9VpvvifvZ8+1K6Yog0WR17il9QplgGG3Myx/2aGtfoT2ZBxZkROuXSDsDaaqESrvdRhFpzRoRrHhosNTceP7U+gHrJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0o84wgMczG2Ne2YK5TePNmdVnw28ycCv5EW54qC3Udg=;
 b=kXb4hXPVnk4Y/gSkRpj9mlRmkK48MPvJrcimlEMLIHg2x38k11jme25RroRqFS/sWXw1m7gKSIEtyi+CGg7VVix2T6rGBPJi5mQbQDjWuQHpkHdIPAJuUQNGbBLs7kOo9R4BjOkgrfyvvA4M43T2GkRFiDsJIB1EoZEc8glWEYA/y1OsFB+5U6udEWdd71gKXD+sc22lMOu/CsQyt6yWPXq03pE4v3EvJDAwMLYb7Eprhl5I7EBdqd41dN9VF2q+nS9SpqXnxigU53fBUHdwLbypz/CbgJkxj8IRGpJmokeQZyTmDdaEodBctjFEEloUpx0VWrji3N3Sqlls/izflQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by SA3PR15MB6145.namprd15.prod.outlook.com (2603:10b6:806:2fc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 01:21:34 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::6fd6:67be:7178:d89b%4]) with mapi id 15.20.8445.017; Fri, 21 Feb 2025
 01:21:34 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC: "luis@igalia.com" <luis@igalia.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>
Thread-Topic: [EXTERNAL] Re: [RFC] odd check in ceph_encode_encrypted_dname()
Thread-Index:
 AQHbfpCIos2EbKYFiUGV+rHGHxWwQbNG8KKAgAAHCy2AANRJAIAAtn1ygANLFYCAAA6HuYAANr0AgAA29QCAAXmIAIAAEnmAgAAWVwCAAxSpAA==
Date: Fri, 21 Feb 2025 01:21:34 +0000
Message-ID: <92deae26f56f47237fdf96eb4131a8b24ca2dc1f.camel@ibm.com>
References: <bbc3361f9c241942f44298286ba09b087a10b78b.camel@kernel.org>
	 <87frkg7bqh.fsf@igalia.com> <20250215044616.GF1977892@ZenIV>
	 <877c5rxlng.fsf@igalia.com>
	 <4ac938a32997798a0b76189b33d6e4d65c23a32f.camel@ibm.com>
	 <87cyfgwgok.fsf@igalia.com>
	 <2e026bd7688e95440771b7ad4b44b57ab82535f6.camel@ibm.com>
	 <20250218012132.GJ1977892@ZenIV> <20250218235246.GA191109@ZenIV>
	 <4a704933b76aa4db0572646008e929d41dd96d6e.camel@ibm.com>
	 <20250219021850.GK1977892@ZenIV>
In-Reply-To: <20250219021850.GK1977892@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|SA3PR15MB6145:EE_
x-ms-office365-filtering-correlation-id: 1965659e-459c-4641-1f32-08dd521614c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T080UGo3YmFtNXhNeEU5YUpoUnl1UEJvMFNibW5CQndINEkrNTVzRXJvL0Rh?=
 =?utf-8?B?LytxZHFlNVdBR1BHN2krd3pLRlhvOEZ5amRJcTJKeDV4SVBPcDhHRkE5K3M3?=
 =?utf-8?B?QzM0aGVXU3lZNGhXQWl4bUdNcS9qWEZxRWg2ZXV3bTFqSlVxbHVYUm13b0tD?=
 =?utf-8?B?ams0UVhTWUprYWg2d2F1MHJaaVIwa25VT2NYODVpQjVXK2hTUlI1TFhNQjNK?=
 =?utf-8?B?aFNPUFMwTTJqZlJjdnU1akdYTHlKM3o5M2lBbVB4WFpORWp1dVVqL01yU0Q5?=
 =?utf-8?B?TkRMSjNudDJVMlIzTkRZcU1jNTNSbStXcEVIUDRFQnVFWWtNUDFUbWU4WVc0?=
 =?utf-8?B?WCtXVnlYZTAzSnREWXorejhSOWE4cnlkTWJMbVZBTUpMbEx1K00vd0lIbG5a?=
 =?utf-8?B?WFl3RXVwK25DdmdGRkI4UElleDlQR2E0ZUdTWUNPdmNWNEdoaG41YWQ0dUJU?=
 =?utf-8?B?eWg3STNVRlZKbC90VlM0VUdWb2tmYlJHa3NtZjNQOHdXUVc0ZEt4dW00ZU9X?=
 =?utf-8?B?RWxHTDFkWnpMOUZYMVNnYkpweUFUQ29PVnpuc0pkVmhWdGdLeHo3REVkd0U3?=
 =?utf-8?B?azNsOEZ6ZTRKT2t4MzV3bkNmb2dsWTVhMDBBdzVkSHNSWk1FSVdyUC80RWRM?=
 =?utf-8?B?QlJEZzNmWEh4ZXJFeUNNWmdtM25ZUkRiTUpaL2lVM2hJMlJyb3BRcVJJcFZU?=
 =?utf-8?B?T09QcHk2UlJtVUtKc1h1Y3dMbDhodnRYMjFHMWVOWms5Q05OMjhUWk15Y1Mx?=
 =?utf-8?B?Mm9ndGtOSm0wK3R6bURKS284dXFpYjhEZzI3S2VZUWxqWlgvTEdLS1I3dUpi?=
 =?utf-8?B?RTRYUXhaT2pNREpDbnhaZW5icVltcVNDcUJpa2g1ZTRvZEdPVXNwQ3RTc3dl?=
 =?utf-8?B?UFRFNVIxL21GSzVvS3YrVnRBbVJlNUo0UWxNSHNWMGJEMld6Wno0azJUY1BZ?=
 =?utf-8?B?V0YxN1NQSFRkdVlyVk81ZE1IT1U1RHFwNmVIVEIwSkF2anUrSzBXYnJRV3dN?=
 =?utf-8?B?MU12Y2xBUk9tZFpIR0Z4ZlUyUGYvNzFraXJmb2M3eE5mSVNKMEdMdVdVV2Zz?=
 =?utf-8?B?R0pQamVzblE3UWp3OWhWWXBla0EzVGt4TWplV04xTHNVa0lDM09SNzJmS2x5?=
 =?utf-8?B?NGxwTVFBcVdHU3V3bUExZktieEx5Y2pYVFlOd1pNQUdhY0d4NEtjM1JEK1dl?=
 =?utf-8?B?NTBBVVVhcmtseWsrTXNQeVoyUWYwNXpRclZtTWM5NHlYMEFUcGllVXkyR2I2?=
 =?utf-8?B?Z0hrS3B1WmNNM1VaS1F6d3A1S1djQmcraUw3Z0NUSnFpU1c4VURiYU9aL2c2?=
 =?utf-8?B?bjhwZEZDSmlVUlh0RWNMWWFFbmhWa21JK0RBQkVYeVArOUJCOXhmY0dkT1Jr?=
 =?utf-8?B?NGhhNWlzK2NVV1ZhbTdJenk0bXVaVTAveWZVVHFHUVBCOVMvVk8rTzFQemZ1?=
 =?utf-8?B?eFFVN0dxU2NpUDh3c3lDTWV6MmNNdVcwV09weFJBYnQvdEc3VGRFQlovMUN4?=
 =?utf-8?B?Y2FDQWtHZUZPUjBZV3I5M0pyaHJJaG1PSCt6OGx0Wi9ZMDVoLzRxMG5sR0tn?=
 =?utf-8?B?OGJ6azl1MGU5TXR2UTNGY0hEc1QzV1VINlVVQ3pwUllaTUVnNHpVQ09sVDFF?=
 =?utf-8?B?RlFBanE1SS9MZlA4WThvK2R5Ujgwb0tBZldjN0hUS2Y2cklNbFdjR0RWRks5?=
 =?utf-8?B?dEMwZzhYZk1jbGJaL1E1K3lvWlkrb3lzWG5Ic0p0bllLSkFaNmJXaWxMemhW?=
 =?utf-8?B?KytucWNkVXlLVDFnZW9DV3RKNnd3bjVsdjZrY0ZmTDg5c21nNk9MZGRlcUpH?=
 =?utf-8?B?a3hmUDc3K2RUbzB4UjF2aHl5ODRaK1QwMkh0QjRYV290dVg5dTZUc05xZEV2?=
 =?utf-8?B?OStnaHJOeGdKOWpOaW9QUUtqMExuRWtzQmo5YVlyaWFDL2FXWG83ZWFuZXVW?=
 =?utf-8?Q?pKDwX/qF26Uyjm+j3pbvhnTtz3ULjAZt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?andtTitPWHBKMlNMd1RtbUZhRk4vcWNIRmlXMVZnNzl4ZWQ3RlZRMVFVQTl5?=
 =?utf-8?B?aUNBTXJ1WUdoUVpmdmwrcTk3TDdZcUZmSFl3S3hnSHYvOUd5Q1VLcHVKSkpu?=
 =?utf-8?B?WjZNV2prb0VsSjk5bnh3dFpMN01HYkg2Q3ZEMUZnaHB1SEU1U003SjFOVG9E?=
 =?utf-8?B?Y01nV2lsZmV1Nm9JK0FzWWJjVXd4c2JqMHlSRC8xRjg4S2I1QmtIZGxwemJz?=
 =?utf-8?B?dVU5RWJQVjZlVnhBeWFMMXBhSUVSWHk3VnM0aDFQUzBIck1DWlZZMG1OeEcw?=
 =?utf-8?B?QURZK09vV240cWFiakwvWEU5eThMSXBoS0FWR3M3MTh1dWpDdEx6MUFHaEpI?=
 =?utf-8?B?UjdORFdJSmJ1UmE2NlQ1NTV0OUxEaDFEb252Q2YwTW9NY2o2c3JkcWhiZXE0?=
 =?utf-8?B?VlpOZ1orOWxpV3Q2b1dkc1lnRXNOUlFEdjVldkU0dkovNVVwSDJpTmxzMngx?=
 =?utf-8?B?SmtDa2hlVnVIVzlJZUlieEt1U1VzZ0VUUDlIVGxCUnEwYzJuMnJESGZmY2sz?=
 =?utf-8?B?NTc1TVNPRUlzNHBDci9qT05VMVRCeVQwNUpHZEZadUU1V0J3NmJndDFyZS9U?=
 =?utf-8?B?NGVPdTJzUEp2SEp3OTNqRUYyOThGRS9CNmUwYXFyR2pRWmJUL3FSWlBrUVpD?=
 =?utf-8?B?YVZwdUdMSXJTaExIbWlvTzVLdVFpQytBN1pGc2tVZk1LN2d5a0tYZ3pEckEr?=
 =?utf-8?B?VzFDRzBGT1pnS1NJbVc3WE0xTDJjeXVVYVBFTlF6dVJ2ZzlGRSsrR29FYXlz?=
 =?utf-8?B?ejBpY1V6ckpMYmg2MGhtOHNYU0Job0xNRzZsRUMyd212ZGQxb0FMNDFTZCtH?=
 =?utf-8?B?cFNYNWY5OGlLYTVmVjA4TEk3bjdZZzZQWlFaNm9ueTJ1Tk8wSEZ5Z1hlbTEw?=
 =?utf-8?B?VGdBZGhvZzQ0dlVBTUpWcGdqbEMxS2w3SWVBNnVvLzN2NE85alR4Z2ZMNDVx?=
 =?utf-8?B?anUwQkVndHZoR1JTeUNtQVV5c0NmYmpQN242TVJCVlZ1dzhDREhPczE1dGlZ?=
 =?utf-8?B?S3JJN1JCS2U1NTlQYUtUZkxEN05lMXo4OCtjRTI3aSt1WUNFRFhTdmczL2sr?=
 =?utf-8?B?T2IyS2Z4M0ZRVmYrMXhFWXlDNWlsUFUwS2xmL0VDbFp0VVR2ZnQrL3Q5eWVa?=
 =?utf-8?B?dXBxaktpalZnU01Ncit0cXRaeW51RWNKN3pmTmZPbTE4ZHVJbEtkaHRqOEQ4?=
 =?utf-8?B?c1NqMHM2WGt1QlBmT3Z5TmljTTA1R0FPQ2tJZjBUT3M2eUdDdGdnVk9pSVAy?=
 =?utf-8?B?OGJ1VXBZYTlBcTV1bklNZHRxdmsyS3pqVHpRYlBKTWNGeS9QTlh4Ynh0WUxX?=
 =?utf-8?B?WXU1Z0JjM2x6N1AxSXpaelpVVEJSTGQxeFhhNkIvbU1sZjhGK1RsOFBNSlFp?=
 =?utf-8?B?T2p6VzVNM2JzUGpjWmthVXNZc1lBalpXQUdmckp2UDJMdVU3ZXZXS21iL3BJ?=
 =?utf-8?B?NWlUUVRqYUdycFdoZmpiQ2ZkUkNFTWtzTWZLT3NldGN4WmE5VVRMSS95OC9T?=
 =?utf-8?B?RnQwMUt6cXp1em1idjJiVmxQb1dXYmxINC91Rk1aODlzRHc0L3phanR1SXZz?=
 =?utf-8?B?QzNGWjNtQUpSMTFKY2crWVU2cW1yWVlHRFlFcjZhcG94USt0TEplTlR6YWVw?=
 =?utf-8?B?UElCYUxrWjU4V3pzd3EwMEducUFXV1lPcFFxeTZ2WEpLekRSZVlWZnFFelMx?=
 =?utf-8?B?ZEUrZC9SeXZoQVVqQVZKQy9UeW50cFBCR29FR2E5Y1M4OE1JaXdPNkp3b3Fa?=
 =?utf-8?B?bUJFWFVBUWRxdDRuY3F0bXpGbWEyNndEYi9HenhGVzVNNnZXSG5ZWXJsYW5J?=
 =?utf-8?B?b2V4aVhqcStQdEQwUldBL1pnY0JRVUtKUURmcVVUSzVWMDFuR284bkRhY0JI?=
 =?utf-8?B?ZGFBc0pYQlNOcENKU21EV1dBcWpDblp1SGVjdWlUeTczb0NhYWVSRUtIV3NY?=
 =?utf-8?B?bzZ6aVNRZWQ3SVBkVlVaVmNLY3JYU3lmYmVnWEV1MGNJam9MZWhxWkhLbGkz?=
 =?utf-8?B?U3FYRFJvbTFZSVNUMDNkdmRKZlJwakUrQTU5R3RGT0lUMkFzTEUvRHBveXlN?=
 =?utf-8?B?T1B1eGJZeFNrUEpSTm1vaGZaYjBDbGZ5cDFmL3hhYnpSeGlxcmVKTlNWamQv?=
 =?utf-8?B?Y3NRdVpFbVpVckdQQ21iR3JReENUZkE2TG1SVlcyYzBaTzNaNU1hKzB4MTZL?=
 =?utf-8?Q?9KIKBmaVicqkudkFu48lzQ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD7F9D3F3545F84990593EA648391250@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1965659e-459c-4641-1f32-08dd521614c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 01:21:34.7431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xG+ARyVY+wpRRyEG1vCRl4LJZP761bRwt2DmEOxz+w9p5r/gdhy2ISYfh+Vd0LwoWqHl1fhJ5lUM8yrbLS7HvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR15MB6145
X-Proofpoint-GUID: HgCw6HGSTKcV5u6u6Mfv0zCfjjDc4UMD
X-Proofpoint-ORIG-GUID: 08yHP4V7Q-Etpe8ny7ZQ0ByUa4NUH22K
Subject: RE: [RFC] odd check in ceph_encode_encrypted_dname()
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=819 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502210005

T24gV2VkLCAyMDI1LTAyLTE5IGF0IDAyOjE4ICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBX
ZWQsIEZlYiAxOSwgMjAyNSBhdCAxMjo1ODo1NEFNICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28g
d3JvdGU6DQo+ID4gT24gVHVlLCAyMDI1LTAyLTE4IGF0IDIzOjUyICswMDAwLCBBbCBWaXJvIHdy
b3RlOg0KPiA+ID4gT24gVHVlLCBGZWIgMTgsIDIwMjUgYXQgMDE6MjE6MzJBTSArMDAwMCwgQWwg
VmlybyB3cm90ZToNCj4gPiA+IA0KPiA+ID4gPiBTZWUgdGhlIHByb2JsZW0/ICBzdHJyY2hyKCkg
ZXhwZWN0cyBhIE5VTC10ZXJtaW5hdGVkIHN0cmluZzsgZ2l2aW5nIGl0IGFuDQo+ID4gPiA+IGFy
cmF5IHRoYXQgaGFzIG5vIHplcm8gYnl0ZXMgaW4gaXQgaXMgYW4gVUIuDQo+ID4gPiA+IA0KPiA+
ID4gPiBUaGF0IG9uZSBpcyAtc3RhYmxlIGZvZGRlciBvbiBpdHMgb3duLCBJTU8uLi4NCj4gPiA+
IA0KPiA+ID4gRldJVywgaXQncyBtb3JlIHVucGxlYXNhbnQ7IHRoZXJlIGFyZSBvdGhlciBjYWxs
IGNoYWlucyBmb3IgcGFyc2VfbG9uZ25hbWUoKQ0KPiA+ID4gd2hlcmUgaXQncyBub3QgZmVhc2li
bGUgdG8gTlVMLXRlcm1pbmF0ZSBpbiBwbGFjZS4gIEkgc3VzcGVjdCB0aGF0IHRoZQ0KPiA+ID4g
cGF0Y2ggYmVsb3cgaXMgYSBiZXR0ZXIgd2F5IHRvIGhhbmRsZSB0aGF0LiAgQ29tbWVudHM/DQo+
ID4gPiANCj4gPiANCj4gPiBMZXQgbWUgdGVzdCB0aGUgcGF0Y2guDQo+IA0KPiBUaGF0IG9uZSBp
cyBvbiB0b3Agb2YgbWFpbmxpbmUgKC1yYzIpOyB0aGUgZW50aXJlIGJyYW5jaCBpcw0KPiANCj4g
Z2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3Zpcm8vdmZzLmdp
dCAjZF9uYW1lDQo+IA0KPiBUaGUgZmlyc3QgY29tbWl0IGluIHRoZXJlIGlzIHRoaXMgb25lLCB0
aGVuIHR3byBwb3N0ZWQgZWFybGllciByZWJhc2VkDQo+IG9uIHRvcCBvZiB0aGF0ICh3aXRob3V0
IHRoZSAiTlVMLXRlcm1pbmF0ZSBpbiBwbGFjZSIgaW4gdGhlIGxhc3Qgb25lLA0KPiB3aGljaCBp
cyB3aGF0IHRyaXBwZWQgS0FTQU4gYW5kIGlzIG5vIGxvbmdlciBuZWVkZWQgZHVlIHRvIHRoZSBm
aXJzdA0KPiBjb21taXQpLg0KDQpJIGhhdmUgdGVzdGVkIHBhdGNoc2V0IGJ5IHhmc3Rlc3RzIGFu
ZCBJIGhhdmUgcGxheWVkIHdpdGggc25hcHNob3RzIG1hbnVhbGx5LiBJDQpoYXZlbid0IGZvdW5k
IGFueSBuZXcgb3IgY3JpdGljYWwgaXNzdWVzLiBFdmVyeXRoaW5nIGxvb2tzIGdvb2QuDQoNClRl
c3RlZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2YS5EdWJleWtvQGlibS5jb20+DQoNClRo
YW5rcywNClNsYXZhLg0KDQo=

