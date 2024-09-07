Return-Path: <linux-fsdevel+bounces-28906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B413970427
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 23:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1231C20E92
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Sep 2024 21:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED9C1684B4;
	Sat,  7 Sep 2024 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O4bUHlSQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HCJVEF7o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DF512FB34;
	Sat,  7 Sep 2024 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725743565; cv=fail; b=GEZ5iGfI/OXlZUkbs44r6G+XDmJ2dvDNOrCDQ+FECRbTOTOcj7+NO+P5S0uc5HARbFof9iQqkEMDF1DOSuJiNCEC4Eit4bV52DV1Ua0PrcD1BZjUiuVtrQ7ghiyIW1Enou3ZolV8LiX3PTnZWi/SuIuFEt1ZoFR3fotiTTGlPn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725743565; c=relaxed/simple;
	bh=6AGPQ/cKJow901DuT6Xyd7DI4yDomWWJDhHN2AlpCbw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MUr4/mbEZ+Oe5sWgfMEsWg0K5Bc15m3onZ/gM12Y0uSGhMynv0FGgIRn5MPBtMBGt9CeA+lxW3YdaAY7LWBqRLCpjrQmRvayT2lx7N1qyxu+0vp+rGE2jEETKmim/lOaylVVAI7NYrNMdLP3ZN3k6TSN1ozyy2+9RZFuWRZgRus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O4bUHlSQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HCJVEF7o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4878fW9u029783;
	Sat, 7 Sep 2024 21:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=6AGPQ/cKJow901DuT6Xyd7DI4yDomWWJDhHN2AlpC
	bw=; b=O4bUHlSQoYxALEQrd9vdi+K/eJa15JGv/oFosMMuC9Z9uz0AdfvkSAOzX
	/K3Q8vPLELlMHvJC//uzYvbvpL9ZSh9HDs9And0nUphFSxKKF8PYhnF3j40i/8cw
	NtoXFJ+FDqs5fq5Breb9xpTvu3Mc1O6C0EzVB0r2jYyiSBwkoVwzmQjRdO5H3bgy
	9A6sEb9dn3QapmDvfmSzvj8FE1bFPXnW/e0WX0IcDL/toFj/KFJl7/nrr1ySqFbA
	okq+vzBRQ4CF4n2wXSofSK+b+IsNRjeum27nMRpQMEHV3oevmbw6W4rhSwq3Etlb
	kkRktMKXOaWdNiaxdDBb8aQklQykA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gfct8kd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Sep 2024 21:12:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 487J0BZm031611;
	Sat, 7 Sep 2024 21:12:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd96f461-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Sep 2024 21:12:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugJSCpRZoI1uAcuUbNeoGbgrmEMbbRCrp8F7i62tUOg+R8TrpE1qcWMi1J/0UdthDKCVx1UchxNRdfH08ICefRd6XGxaMnFRHFwPbtQE6tBSmwL35GC81HI0OMPdEtdtt5t1otvxS1KDhjSWxrgtafRHxIg6lbalNvYUp1zv/76DOBRzg3z3AJOTXRZ4zxJpaRlIr8JH/cP+wVZgafawQEFUUvwOPe2C6z/LT802tNtqukyTSwxvacS6RDhEZmLdZS8CCePh/G4K+OS00H1lneMzt1H9or2XBGXD9+pvUo+xApzVfp37nP2hu/VmGuOzgVVAtyhAPfclZV4RTQr5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AGPQ/cKJow901DuT6Xyd7DI4yDomWWJDhHN2AlpCbw=;
 b=A2YnmuuUB+uuixWS8glysX3IRbHdHCHkc2EbAMubgWMQbOyNSZMNp1UnWSJNPtHi+Y5cFoJCO82qFvcFaq9lPNHe9DhASBCWf0vK01rgXkL9rxQnRuvJUIrprjPZeANeLsIjinvogCnmge6wdBT60eYpC/UnI45oebiTspk1FzJGdCOWDAhIm6ydgKd1xzEZJEEVmCtCFWGyj7gosplb/VFundl1x74RcWMxUI9Ut2MVJ6Ti1xFyAMngP44X6sQwN2SZOoz7dRdjlnjDJgt3tn0RLQIjBJ+ymOyg8tV8mSz1t0pmVO5mCrUx04QtvxbbPSPLZrZoaBOAjqKZYya2lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AGPQ/cKJow901DuT6Xyd7DI4yDomWWJDhHN2AlpCbw=;
 b=HCJVEF7ol9I9+6WfnE+vrEMNq8hMhFWwYQCw5TA1fERhm7z03BgGRfPbltSy4mHzmFxiEaHZeBpj5CfppEdPAgFwXxcm9iaclmVWQviRxe0U4lTDOLn+c7DJt+bMi9xhTaHkkDFT//Mm/BYd6G7IdJR37IMAjuPWFtaKuUhm0CY=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4460.namprd10.prod.outlook.com (2603:10b6:806:118::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Sat, 7 Sep
 2024 21:12:20 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7939.010; Sat, 7 Sep 2024
 21:12:20 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
CC: Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 16/26] nfsd: add LOCALIO support
Thread-Topic: [PATCH v15 16/26] nfsd: add LOCALIO support
Thread-Index:
 AQHa+/Z8NjJpiHCGJkyIBxPv6nO2sLJGJLQAgAABzwCAAAV7gIAABX6AgAACqoCAAAhmAIAAbZ+AgABs/QCAAJLIgIABm82AgACaigCAAQPhAIAAMy8AgABAEoCAAAoaAIAAC72AgAEM8ICAAA59AIAAMeyAgAAirgA=
Date: Sat, 7 Sep 2024 21:12:20 +0000
Message-ID: <0E0ECEE2-AAC5-414E-9C77-072A91A168CA@oracle.com>
References: <2D4C95CA-3398-4962-AF14-672DEBADD3EE@oracle.com>
 <172566449714.4433.8514131910352531236@noble.neil.brown.name>
 <Ztxui0j8-naLrbhV@kernel.org>
 <3862AF9C-0FCA-4B54-A911-8D211090E0B4@oracle.com>
 <Ztykk5A0DbN9KK-7@kernel.org>
In-Reply-To: <Ztykk5A0DbN9KK-7@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SA2PR10MB4460:EE_
x-ms-office365-filtering-correlation-id: 49a5667f-2b80-4526-7e52-08dccf81c2bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UlNSN2FNanhYRTNrTGRQajJFY2FVSGx0a2tkemdmc1U0U1RVMVV4a3AraTls?=
 =?utf-8?B?V1lUek5DeUFJeFRBWk8rRFFaSGxVakw2N1BZdkRiVFZlU2oxSWJjeWpJeGxt?=
 =?utf-8?B?THk1d1Q3QlZycEh1aDBqWVlkV3ZkazFJdUg1NFdUWktibGRjVSsvQU1tSmg4?=
 =?utf-8?B?UnUxT0k0a3lSUWNab2FVb1hFVTBOejk2Q0tLdEFHOHVWcnZYbkh3NXpkbk1E?=
 =?utf-8?B?ZzQ5SGRiSzZjOWxlaHJTUlBXQTRkSW1PdkN1bU9UNGJSZXFhTUFXZU1IWGx3?=
 =?utf-8?B?RnJDWHNPS09nVnVmVUVaTjMrQmltV0hKaVFrbVVRR0wzVmJjUWdWeEJCVUtX?=
 =?utf-8?B?Mm51ZUFLMDhmRnFocWlDZkNnTXdFZk5NQWozbHFUVGZwaDdmTDlMMWIxRVo1?=
 =?utf-8?B?TjIybzc5NzFWaTlMUXpYS25Wb3lEb28weCtWMTR4bzJmcnl1d3M1OHUwbFJP?=
 =?utf-8?B?VEVKc2tNZlVkelBXTzN1ak8vek1POEE1K2dhU05FaGsrVTRmTVhkTllmNWZk?=
 =?utf-8?B?UkZVcTFNQU5GOThrOGZjdjM3UTVoQVZTejlibDBDbUlPMER2aFFoWTR6RHpB?=
 =?utf-8?B?OEZQT0pOZ2wrckg0ZDgyMlJBQ2hEd2paUHNXMDE5eDh0VCszWEx6and3STVj?=
 =?utf-8?B?TUQvbmhXQldYMGVMb09ZZ2hUU3JTNXVyMkdzVTdCMndycG5DdFkraks2bTNY?=
 =?utf-8?B?MlVubkFPSUtEczdiU1hGT3p2RHJtNDdwNnJsNzJFcUZTZkp6NWIyODZ5TUg1?=
 =?utf-8?B?elB3b2VFcHFUb3psQ2FnTVpvU2xZazNSaUtaNUh2aWIwTTArSUVndjhvZERh?=
 =?utf-8?B?cHROckN5NzZkdXNkK0g2Q292SUJFYm9mclhweldaOE53WEhiQXpmaXNZYlZz?=
 =?utf-8?B?MDluTmYrUkZDQnFVaGM1UmpnNTFpd1NpNDZtN0JyUnN3SnJUTEVZeFRHaWtw?=
 =?utf-8?B?akZzQUNCMlQxNnd0a3R1SGdWMlh1ck02SkdaYjIvdmhZbDBDRzc4Yy9Gb3Vq?=
 =?utf-8?B?cHRGZVNIektzRUlEUHI5UElJZHVMYXcwVUZhTUlOaDJtb09lLzNoVm1MbWdq?=
 =?utf-8?B?VVRhTkFjNkVnV3BNdUprNjFocERXbUZwVUJmSWp1Zkh4c2o4cGRxZXlxaEEw?=
 =?utf-8?B?NG5kOVZBOTc1TnlMS2tSdmJBQ1doNElQcFJXMmVxbkovVTZGSUlnVWtXem1x?=
 =?utf-8?B?ZU1lTXZsVStJR2NuNVRITnJwQzJadTRmb3M0bW53VXFZUTV5WkdCSFA4Tm90?=
 =?utf-8?B?ZXdqZ1hnQm9WZWhMK3B6NjYwRUl0RGFqeUQwN1lXZGZtL2U3cHVkemFRZlZw?=
 =?utf-8?B?cHd5bGJLN3VqTGFwSEN2anpyYTREMDBSTjlKUmo1MTg1aFFsUXhwaEVzVG9n?=
 =?utf-8?B?M2ZlQjZLRDY2Z1YxR21zeTgrOERweGVwS3FrZ3F2aUVCWE1qTDArQ1c4RHZC?=
 =?utf-8?B?Zncwa0NPd2JkSWZDQ0I5UkNtcXFTUjR0K2xWdy9yTHpNdGw3RjN2UFoyOXND?=
 =?utf-8?B?ME85Q1UzeUpiSjBTUFpZeS9vRkJ3dUM1ZmNKSitkME5UeXQ1bm9TU1duNld6?=
 =?utf-8?B?MmEzUlpIUEJlQnRJYmVPUTJLTG5mL1FTV3BldTh4cW1MQTNWRDY2KzhUakl4?=
 =?utf-8?B?dUt6c1lQYW1CZVlKVWpwQ3Q4Znk5Mjc1Y3IvV0tBQ2RvWnJZZk9GWUZ4T3Rj?=
 =?utf-8?B?ZXR4RzBHa1dmN2VteU0yVThkNXBQRnhFNms0RTRKNVFlV1R5dW1WaXZCQ2t1?=
 =?utf-8?B?R1Fpd3hiSXE5RUJrWXRwL0Qwekk2bVhVSUxWQ1QzalI0MW4zWUJoNmJYclpJ?=
 =?utf-8?Q?aMyvmDju8Vb6QEKlQWaxkO47dGr4kp9ygLd+I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2o0eGlET2xab0R2QXRzNG91N1VNTnprazNHTFptekpJcXhuYkRkUmwzcy83?=
 =?utf-8?B?aEV1ZFpIcHdzdk11RWxpQzBwVkxKbFU2d3JjcGhNU253NUhxeXF0Zm9VdHVa?=
 =?utf-8?B?QVRjMllmWFRBWGVyNTlPU1hHS09VNEhaWGFMeVIzbUdTWFZ2ZGc0aVpPWGFy?=
 =?utf-8?B?a2YvMGlVVGY1RmtRdjE1eGlzVFJ3UHRwaGVGMGtjeTNWMktWdzQ1VWp1TW5m?=
 =?utf-8?B?azhBRXdtRGpmMDN0MG0vZ2VpaXNHVFhoYjErM3Vtelp2bmZPMHVXYjhnS0pD?=
 =?utf-8?B?cU40ekhhYStxWjByTFJMRVZWOWJJRnB5Y2NiNzkwMGN0dUNBZWNmdCtFZXA3?=
 =?utf-8?B?MHN6clJuc1Nid0VoNklkamEvUXFKQmhhTFA1ejdWMzI2VVRqcFF5V1RLTWRz?=
 =?utf-8?B?NTlKaGFVRC9EVGtlNDdPYW5FMHZUUnczVWNTTE9jM21uVDN6WiswNC83WmJS?=
 =?utf-8?B?RU5lMW04Rlg5YWJwcEZ3bytwOGkrYXhuN25ZVDBnQ1pIaHJZbW01cTBWWU4z?=
 =?utf-8?B?ZnZpeDNHZTJhY1VTdnVRaDRRUTNKSm1EOHhCRlBQZjg5eDB2bDkvT1hERGU3?=
 =?utf-8?B?QTBtNmNDK2t4cDRHMEkrSStFa3hEdHZIWG8xSTRqUTFPQ3g4SUwyODl2dlhC?=
 =?utf-8?B?TitTVGdSRzdLWmpNanBkM01mVUdSSzdHWEJRcFFkWDNZRE81NnhnZlpyMWkz?=
 =?utf-8?B?VDY4MFk2SVZHTnpZZ25ibjdNWERpQUpsL2Q4dHZXSkxFTFVML2ZtaktSRUM5?=
 =?utf-8?B?dW9Scm5EZXFjaDJXSERqMzl0Zi8vcGFEVW1kS2kxbFVUNFdnK2hDNmt1ekhC?=
 =?utf-8?B?bzFTMzM0K1QybEQ3dkNwUkdMdHcrelFaaGtFQWtkbHk5dEhCM2pUZHNvdERE?=
 =?utf-8?B?WnZtOGJFZ3p4TmpZWHduMjdpamcwaUFIQ1JlVHhXa1lRcFU1N0JPTWdldzFo?=
 =?utf-8?B?Zng0KzBDS2ZsbkUwMGJuTCtPQUxXNXQ2a3VYNkp2SE5VbWRRVlRQUzB2anI4?=
 =?utf-8?B?V2x4UDVaOWpNZmtWV0M3NWdPUE1FZjk5bXNUeXovUk5ZVzlMZlk5RzFjZzZW?=
 =?utf-8?B?dS9ZYy9iQnc4ZVhqYlNJeDBUazk0ZlVlK0dwcG0rRkVzeUMycmtidFNEeW8w?=
 =?utf-8?B?djBQNnZQZGJ6ekhLSU5FV1I4dUpCWWVtWWVhWm51OHdwWEZzK1JmZndjY1lh?=
 =?utf-8?B?WUh3T0F6TG9LVzhidW1VY25Zeng5YmJ0M2xhc1lQRXlJQVhKTVozUEM1VmZV?=
 =?utf-8?B?UVAwRXhmaGw0SGVDZUYrWnFpR2lkaEJpODB3TmpkbVN4TmJOT0RFa1BRa3dQ?=
 =?utf-8?B?clY2OWdOKzU1NW81Z0dnZXJVN1h2d3V4Z0VpMzBvcSt5QVVrNjQzSzVQaHds?=
 =?utf-8?B?TlF6b1RJa1RLWXFpU3pQdUxBVzJBME9hYlJLZ1BlZGF2aXR2ZWl4WnhETkxP?=
 =?utf-8?B?MmlIam9YZ0c2a05UcUZ5SWlHS1JLNDA2cUwrK0hwV3QwdjJHM01nRVV1MUUy?=
 =?utf-8?B?c0I3aDFnQUs4eEJYcWdvM1VDc1d6ajBLbng5eHRkVnUrREFCcW8zbnI1aG1J?=
 =?utf-8?B?eDFHUERPN1FpMGZneFd2UUE1Uy94bUt5V1hIbnhjZ2J2R1didHNzM0pCcm5h?=
 =?utf-8?B?NDg2eFVYamZtMTBlOVNIWVBOMzF5bERTejJGKzNBL3hsdWJsRzU3cTN3Lzho?=
 =?utf-8?B?NHEvVWtTTi9sOXgzdUwrdm1QT3BVZU1TVHc1L3VhUkVHRkxxc045MWtQUnRn?=
 =?utf-8?B?NVYreTI3Yk9NaytEZjdPc1JUd3FrblgxSDkwMUppODJHblNqL3JmOEtXNVNm?=
 =?utf-8?B?Y3dMT3NTWHNxZEQzS1B1dnFyZlZ4TFQ1T3NWUmo2ZFk4U3AzWlI0R3pkNVE2?=
 =?utf-8?B?eGJzSGpaTTV3YzZhZThabzBBZW15WUhFdFFwa04zNzhFaTF3MmlhSk51alVj?=
 =?utf-8?B?ZEw1WGl1SWkyRzkwR0JjNnlNL0NiL3BTbFp4UHFHaithN3VScGtKSkZjaHRs?=
 =?utf-8?B?ZTlvb3FmWm5hajdDQ3dSU0JsRDlnNThqbGpPMWhHOUxGSmFOOUgxc1FlTUND?=
 =?utf-8?B?bDBsV2lwaVZvOVRDWUVTNS9XZ2ZVSjhvK2xLaWJLWXk1ZXlqWGF1NTZ6Lys5?=
 =?utf-8?B?dC9kRjB4ODR4RVZKelZFbksxWWEvRHd4VHhyMkFXVUtBeUZjaXZHQUR3RW5x?=
 =?utf-8?B?MkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC45BE8D38DF664686A5A27195C7321C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZoLTT0aMTHRt2DC6S6OVlPrEXw+p/deSbB10SmCxU2DKQK2GbhUzrrXS31Ps8Bz1aiCcF61XuxP+8yN1m7ob/EHn260+UmyS8micZuTecDIj26qam8LPEF0yUx5Amo2Fnu0cvu8Hc0rOhh70JyGCMmvleBzghQZQ1npE+f96sT4zz6Ye/PwSrRCD5xuHhDC3p/msLLdVJM+XSh5knLSUe0E+e+4m1z4OqgPFOoVBtoLEMjl0XD+DHSZjn5gwhYAaqwlbJpvGZ7ZfY7iBt/z/LovWfS+x2V1F44sRT+lW5hGQJGzqSgnFW4w0pywHiFauWCnLqIoh6F1nrbdjFSC8aIb2ZO7zNXqkTv2s6aeN2prgefyYF9RKcWzKypgPLYkTh5+uuK37Lpso1A9CRVaurdQKGeIGiJJIAnAqWZ4D213RZBda4sS35mjrNISIbQYcIlhq9nvt65MdG93SiD8+cWrXel5X0TxIB2t8maVv4lvR8JP8ZUeYNYcdBMDbmkbT5cymgp1Dq3u+jwv6io+uYDhtmKEI0ojNifZ593G4ILTkLqwMA8PpWpnvmTJxLP3AHdxvYTbxi5RKA1sd0jA5f2T7K8XLgfBi65jyLOwyhHY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a5667f-2b80-4526-7e52-08dccf81c2bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2024 21:12:20.4444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wag0HOd3vzJq1ahdX6xvxxZaOXO3aMJo5/r8dVCxqBqB7SRzSf7rOH04TErl5LSvygu0BBnu6wIRfEbJxse7TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-07_11,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409070175
X-Proofpoint-GUID: rLGsQS96mZQmrSHWlZ9L-ofjZcpnD_mD
X-Proofpoint-ORIG-GUID: rLGsQS96mZQmrSHWlZ9L-ofjZcpnD_mD

DQo+IE9uIFNlcCA3LCAyMDI0LCBhdCAzOjA44oCvUE0sIE1pa2UgU25pdHplciA8c25pdHplckBr
ZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFNhdCwgU2VwIDA3LCAyMDI0IGF0IDA0OjA5OjMz
UE0gKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90ZToNCj4+IA0KPj4+IE9uIFNlcCA3LCAyMDI0
LCBhdCAxMToxN+KAr0FNLCBNaWtlIFNuaXR6ZXIgPHNuaXR6ZXJAa2VybmVsLm9yZz4gd3JvdGU6
DQo+Pj4gDQo+Pj4gUmF0aGVyIHRoYW4gaGF2ZSBnZW5lcmFsIGNvbmNlcm4gZm9yIExPQ0FMSU8g
ZG9pbmcgc29tZXRoaW5nIHdyb25nLA0KPj4+IHdlJ2QgZG8gd2VsbCB0byBtYWtlIHN1cmUgdGhl
cmUgaXMgcHJvcGVyIHRlc3QgY292ZXJhZ2UgZm9yIHJlcXVpcmVkDQo+Pj4gc2h1dGRvd24gc2Vx
dWVuY2VzIChjb21wbGV0ZWx5IGluZGVwZW50IG9mIExPQ0FMSU8sIG1heWJlIHRoYXQgYWxyZWFk
eQ0KPj4+IGV4aXN0cz8pLg0KPj4gDQo+PiBUaGF0IGlzIG9uIHRoZSB0by1kbyBsaXN0IGZvciB0
aGUgTkZTRCBrZGV2b3BzIENJIGluZnJhc3RydWN0dXJlLA0KPj4gYnV0IHVuZm9ydHVuYXRlbHkg
aW1wbGVtZW50YXRpb24gaGFzIG5vdCBiZWVuIHN0YXJ0ZWQgeWV0Lg0KPiANCj4gQ291bGQgYmUg
YSBnb29kIHByb2plY3QgZm9yIG1lIHRvIGhlbHAgd2l0aC4gIEknbSBvbiB0aGUgZmVuY2UgYmV0
d2Vlbg0KPiBrZGV2b3BzIGFuZCBrdGVzdCwgaWRlYWxseSBJIGNvdWxkIGNvbWUgdXAgd2l0aCBz
b21ldGhpbmcgdGhhdCdkDQo+IGVhc2lseSBob29rIGludG8gYm90aCB0ZXN0IGhhcm5lc3Nlcy4N
Cj4gDQo+IFN1cHBvcnRpbmcgYm90aCB3b3VsZCBiZSBzaW1wbGUgaWYgdGhlIG5ldyB0ZXN0cyB3
ZXJlIGFkZGVkIHRvIGENCj4gcG9wdWxhciB0ZXN0c3VpdGUgdGhhdCBib3RoIGNhbiBydW4gKGUu
Zy4geGZzdGVzdHMsIG9yIGFueSBvdGhlcg0KPiBzZXBhcmF0ZSBuZnMvbmZzZCB0ZXN0c3VpdGUg
eW91IG1heSBoYXZlPykuICBPciBpcyAiTkZTRCBrZGV2b3BzIENJIg0KPiBpdHNlbGYgd2hhdCB5
b3VyIHRlc3RzIGJlIGVuZ2luZWVyZWQgd2l0aD8NCg0Ka2Rldm9wcyBpcyBhIENJIGZyYW1ld29y
azsgdGhlIGluZGl2aWR1YWwgdGVzdHMgYXJlDQoid29ya2Zsb3dzIiB0aGF0IHJ1biB1bmRlciB0
aGF0IGZyYW1ld29yay4NCg0KIFNvdXJjZTogaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LWtkZXZv
cHMva2Rldm9wcw0KDQpSaWdodCBub3cga2Rldm9wcyBjYW4gcnVuIHRoZXNlIHRlc3RzIChjcmVh
dGVkIGVsc2V3aGVyZSk6DQoNCi0gKHgpZnN0ZXN0cw0KLSB0aGUgZ2l0IHJlZ3Jlc3Npb24gc3Vp
dGUNCi0gbHRwDQotIG5mc3Rlc3RzIChmcm9tIEpvcmdlIEJvcmdlKQ0KLSBweW5mcw0KDQouLi4g
aW4gYWRkaXRpb24gdG8gdGhlIGtlcm5lbCBzZWxmLXRlc3RzLCBDWEwtcmVsYXRlZA0KdGVzdHMs
IGFuZCBhIHN5c3RlbSByZWJvb3QgdGVzdCwgYW1vbmcgb3RoZXJzLg0KDQpXZSB3aWxsIGhhdmUg
dG8gZGV2ZWxvcCBzb21ldGhpbmcgZnJvbSBzY3JhdGNoIHRoYXQgaXMNCmdlYXJlZCBzcGVjaWZp
Y2FsbHkgdG93YXJkcyBORlNEIG9uIExpbnV4LiBQcm9iYWJseSB0aGUNCmNsb3Nlc3QgZml0IGZv
ciB1bml0LXRlc3RpbmcgYWRtaW5pc3RyYXRpdmUgY29tbWFuZHMgb24NCkxpbnV4IGlzIGx0cDoN
Cg0KIFNvdXJjZTogaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHANCiBE
b2NzOiBodHRwczovL2xpbnV4LXRlc3QtcHJvamVjdC5yZWFkdGhlZG9jcy5pby9lbi9sYXRlc3Qv
DQoNCklmIGt0ZXN0IGNhbiBydW4gbHRwLCB0aGVuIG5ldyBsdHAgdGVzdHMgY291bGQgYmUgaW5z
ZXJ0ZWQNCmVhc2lseSBpbnRvIGJvdGgga2Rldm9wcyBvciBrdGVzdC4NCg0KT3IgdGhlIE5GU0Qg
YWRtaW5pc3RyYXRpdmUgdGVzdHMgbWlnaHQgYmUgYWRkZWQgdG8gdGhlDQprZXJuZWwncyBzZWxm
LXRlc3Qgc3VpdGUgb3IgdG8gS3VuaXQ7IHN1Y2ggdGVzdHMgd291bGQNCnJlc2lkZSB1bmRlciB0
b29scy8gaW4gdGhlIGtlcm5lbCBzb3VyY2UgdHJlZS4NCg0KQSB0aGlyZCBhbHRlcm5hdGl2ZSB3
b3VsZCBiZSB0byBhZGQgdGhlIHRlc3RzIHRvIHRoZQ0KbmZzLXV0aWxzIHBhY2thZ2UsIHdoZXJl
IExpbnV4IE5GUyB1c2VyIHNwYWNlIHRvb2xpbmcNCmxpdmVzIHRvZGF5OyBidXQgSSBkb24ndCB0
aGluayB0aGVyZSdzIGEgbG90IG9mIHRlc3QNCmZyYW1ld29yayBpbiB0aGF0IHBhY2thZ2Ugcmln
aHQgbm93Lg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

