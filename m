Return-Path: <linux-fsdevel+bounces-6208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1274815038
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 20:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21F75B238CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Dec 2023 19:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E854184C;
	Fri, 15 Dec 2023 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dlA0ITHw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F8xceStn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AC83010B;
	Fri, 15 Dec 2023 19:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFI40qY006478;
	Fri, 15 Dec 2023 19:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=OVLNTw11b7xygZS/4hTA5h17ovmKt3SgaP1oSwPzr0E=;
 b=dlA0ITHwFbUPTcwYIjlwqneAPSbwVlEE03XcHkoJUrxrNL9NTs3hxWh7onUUGfWR35Gw
 8sYYe6POvlPcBctiRu/b/OJnjh8i6PsSlfDlTnYG2Ixv43d/6kpyp2J6rNernn6LQSZ7
 PMofNVttzbeLN4KDsxhU9pAZdLJhhXBzTUOScpTZuc6hOwKGwal5L1p9PfQxRr/BNn3J
 sHc9prEouB0CXTqvRGUE+5tAvQwPVyw6AE324s8GSa9sylE94zugHnfzTgom2MxlPs8Q
 IAUWqHqD0oxj6izgf4jrUvTbRnXS1dj9P4UR4Eynf6v4oT2ayxZeymqG93MD5mLYh8rq jg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uwfrrvhp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 19:36:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFIIRLu024873;
	Fri, 15 Dec 2023 19:35:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvepc9dvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 19:35:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeLZwfi4rXOGgFqE82Q5HrMtHIGNOK3DmDTBCa4MOIwBAwLGpi/mGPR6lXvQ5rmEOf/LaFKnZyPrrOPilIs2hs4G2DcA3s53RZE2FiTNgvzLYh5ouZkUfxnG5Jh2CEAt7K0JrLcrEC+FCXxrf4Ni64aIKMFdDhPZ772L66X2wF7kLi2Ss60KxQUf4/XB0L7X9xNtw+iMYjgKIuPgGYiJNBhC+6SvXzr+6HFzM0Y2nJ4KFle8IZ8oFqtIZYaUVIoNzbJDjDO4S1rR8vVj69Yca6pojFnROT/570BCvWLXC8DDBwp18UjsnZQFdSbPTpOrHjYBpKPei5qs5Su6fYc/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVLNTw11b7xygZS/4hTA5h17ovmKt3SgaP1oSwPzr0E=;
 b=BDFy5usradLZPQhBPmU0dHbZw8cyWfXHdHOTaJJZn2ma0DJu52arNigq5gb76aGKGh+1v704bLe9LMUvuqsQKBo4hONu7WaPmSB2Kn+Hdx/LpCkQWiOsgoStxtdB/SbeofYlcWsUMe8PQuwuUdCxUCNyMND8xeFFyNYv3CARcXwTvAvuem5TFlO+5vBygTGR7XLeqvrwuBXaUiCKjDxB1DfSb7+jY9dGmHJbLA+fSsd7s9NrrIhjxMrvSNdQURvoXK8i+iHhCHYBAeJPKMSbGjUsoqGlKKNnc30lfJv52dqBVtzGp8BYvf1dNZhHLchjLRUoLthKOp/UfQk24qeLQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVLNTw11b7xygZS/4hTA5h17ovmKt3SgaP1oSwPzr0E=;
 b=F8xceStnKVZxsSvmBaowTY2kHC8wwUwiXEMj/jlq36R+n016kEaCpEZ6ZwG2eSOOh+oQvZCOc34tlA8cAZUJEan+R6i0Jx+Xvmd2twZ3ozluoFU73+Y4BC+mHF0I1g1oNN+27lZZtapqf4ku5YjQyccKHbxsdx2OMkjPfdZYS6s=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CY8PR10MB6539.namprd10.prod.outlook.com (2603:10b6:930:59::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 19:35:57 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 19:35:57 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: David Laight <David.Laight@ACULAB.COM>
CC: Neil Brown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian
 Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Oleg Nesterov
	<oleg@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux NFS
 Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of
 files.
Thread-Topic: [PATCH 1/3] nfsd: use __fput_sync() to avoid delayed closing of
 files.
Thread-Index: 
 AQHaKYg6Xsdfrw6D/0iqk7wx2wl73LCfe+UAgAOmxoCAAVXmgIAANc2AgAAN4ACAAAJCgIABpOgAgARSNwCAABMcAA==
Date: Fri, 15 Dec 2023 19:35:57 +0000
Message-ID: <92D12632-34EB-4EC9-AD3B-FD23D8E0C7F1@oracle.com>
References: <20231208033006.5546-1-neilb@suse.de>
 <20231208033006.5546-2-neilb@suse.de>
 <ZXMv4psmTWw4mlCd@tissot.1015granger.net>
 <170224845504.12910.16483736613606611138@noble.neil.brown.name>
 <20231211191117.GD1674809@ZenIV>
 <170233343177.12910.2316815312951521227@noble.neil.brown.name>
 <20231211231330.GE1674809@ZenIV> <20231211232135.GF1674809@ZenIV>
 <170242728484.12910.12134295135043081177@noble.neil.brown.name>
 <ac74bdb82e114d71b26864fe51f6433b@AcuMS.aculab.com>
In-Reply-To: <ac74bdb82e114d71b26864fe51f6433b@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CY8PR10MB6539:EE_
x-ms-office365-filtering-correlation-id: d401ac8b-9bec-4188-124e-08dbfda50f58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 +bFY6YcEgadvHTQ4gAV2WqBuW9HHLD65cfgkrMx81yUL7KGO05/QEyAeH56YMDvzIuE6TIBMMtdeYZ1/ZEogAvQUZDQxad3IERYSH25uJWvSFe57xMJJ2Bo+Cs2e72JW4qK4jnYYoJTETKNcxwZVRXaVYEO5+RPB69fzF+KMoIaXZUcXKARLvQGcEmY3ZvhdSAQyDpl+xaOy+JBwjcXLbnVfIQxVo8r/e+gG8lRGBHCYeuOWrayQuwb3sMuLCXbUJD7iwJySeE7Fw0JuV1TJwn492iexly+/y5bPwsair8Q0w6OkDg07y2mGIQY76AkG1wMZej7T/XgZN/PI+QgZmY7MCfz4rTKT0mSslc/GROnbIKOJRl+eUejxqtrOLW/NfcJio0TjqxqHGLgztLGqhrRXOprg9AbeBXAsqXNfQc745aGaUnnBb7DPAdEvKYNKXM30gno7p2sjxKgKbEtwwSM+uBuQXXE568JzcUhhchfyce/d4ZK8h+WJRsODmN/d1OKtUl6pNolZwqvw+iOEKD4ppddjHFftuJM0xIPKDjVnAYmnl/iN4acv3k79PrDKSPuPaeB/mYi92IySKJqM1heDFMbyFCXdIYRc39hh8QxkTCYa1YdjsBqGBz5+31kwaHZdwjlD8xZArix+mpv4CA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(136003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(26005)(6506007)(2616005)(36756003)(33656002)(38070700009)(86362001)(38100700002)(122000001)(4326008)(5660300002)(7416002)(6512007)(53546011)(71200400001)(76116006)(6916009)(316002)(66946007)(91956017)(8676002)(6486002)(8936002)(54906003)(66556008)(66476007)(66446008)(64756008)(2906002)(4744005)(41300700001)(478600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eTdrdUhWZDRXV0lOd1NzMWdWUXhmeHJMNGNGSzVabEJHRENVZVdpakNUTVdl?=
 =?utf-8?B?QmthZVlOa0dYUzl4SnFoYmFRR0l4MTZGMFlINktPeFFKQVFNZ05DclorZjE3?=
 =?utf-8?B?WEw4dXg2NGtyZnEyZWRoakxMSU1wdURCMmNpZWR2SjhHemVwN3lWb0loOGpm?=
 =?utf-8?B?UnkxUW5aeGFsbTJoaGV1aVVQd29qUGhrQjRibUxxc0M3dlZNdTd4R1gzTWJs?=
 =?utf-8?B?Z1Y4aHNjSEN2T0FKdUNUblNZMS9qV205QmlDS0R2alkyS1VUSmhwR1BxTGZn?=
 =?utf-8?B?WlA4QXVOeGNDRmI0OG1paTNoYzBZY1hRY3piZncxSGRxbDBQWDdTSmJmdU0v?=
 =?utf-8?B?azZQaUJNdDRYWE1pYyt4V0xoOXRSbG50NlRrYXIzYy9LQ1RpYjhjSklIMGU0?=
 =?utf-8?B?dXMvSVpVYTNWY0ptL0xmQ1pBcjJGeElKZndRNXlCc28yVUgyeWZ6aFUrVDJ1?=
 =?utf-8?B?cEVhTTZsbk9rNTVXSXFCQUFHQWNTcHZSVWQ4cDlCWlF1RHgzbHMyaDl1QTJT?=
 =?utf-8?B?YThBYlJpRmIwTWtxM1hFVkY1bGhVcFNXWFdXTUtCZWJDc21CY0VYejIyK0Jo?=
 =?utf-8?B?UkRHRm5vRnJCVUdUbXNaVmJwQjJFOHBIc0dnVGpkZ0tBa2d1YnRZMkxudGs0?=
 =?utf-8?B?WUk2aTBFdnF5bDc1WnRuYVNUWGZudkVuTkhoMDlsRGxDUDFTMmtiekNiZDdP?=
 =?utf-8?B?QktYT0ZBZEFGWlRhRy9ldmNDNTFybmV4YWhPN3VPUlJTbG1Ya1RyYUZaUlU5?=
 =?utf-8?B?cjdlQzE0aDZqQTFveGNxYjNTMVlwcUUxUnQ2bUJRVnVFY0daWmdaV0Yrc3la?=
 =?utf-8?B?ajdZaXlIdkJtbXRPK0tya0J5MXZmMncvVzVHZ2MzaFl5TWZON1ExWDhNRkRy?=
 =?utf-8?B?VkRIVjVJVDdIOGtYSkp5cWdnL1BWQko0d3ExYVRDMW5IV1RMZlArRlVjdlB5?=
 =?utf-8?B?L0ExT1dRbkNsK0k4Ykh6SCtJY3BPc1c2RkRya3hzcVRtTm9rNTI1d2doeFpq?=
 =?utf-8?B?WWE0dW5VUHBjaGJDa2lpcVRvYkRDcHFCeUdiUjh1WnZ1dEtxc0psakhQSUJJ?=
 =?utf-8?B?UG1sWHJmL3k2V005UEtKN2JkU1JEM0l5ZEtzT24wNXBCeGlMMG5ZQ2NlRGJI?=
 =?utf-8?B?Zm94UzJaWCtPcVpYSjJNSEEvclJZTkFEQll4aFFDUGMveDhXRzdmbTJDUmlH?=
 =?utf-8?B?RW42cjBzMm5zcHVMZnphbDhxZ3RZdFYvTHhSWnYvMXhDZitxUUY3M1FhbDZR?=
 =?utf-8?B?UmEzSnBZdnRiL290M01hMkJDMHpOelAwZXVuWExNYXY2L2pDbUI4Nm9UUzVU?=
 =?utf-8?B?ZDEzWnZEU2JheDVodU9KeTRZNUdiTmxzeGRyb3BQMnQzSWQ0TEhMQTFCWXZm?=
 =?utf-8?B?Z1NhR1dUdnJlVytKYjFuaVUyam0xdi9hWFFTbXNLU2RySDF0TXNQcVRTbHBX?=
 =?utf-8?B?U1g4R0VaRC9OdXQrSklpU1RHcmJFSWhrZFdBb3BQRDVmWlVyU2V0WW1ONHBH?=
 =?utf-8?B?NlJjODZXdnZLQTMxZy9tLzRlUzB5c0FjaWtxK2hYV0JBNDVQOHF5K2tnVWxk?=
 =?utf-8?B?MjNlOWc4aGt5dkF0dmx0SUc4dEREZUR2eU9EQmpJRzZhTDd0bXpkN1N0eHdi?=
 =?utf-8?B?Vm1HZDhrS2tCWDI0eW8yeHRzWnR2Qmx5b1hCOWxkK2ltNi9lU05ySkpPK0xa?=
 =?utf-8?B?ZHhmN1BkZW9oNkNlaEMyUXQzdGgydThySy9Pckt6d1d3TFhsQis5aHAwRXhC?=
 =?utf-8?B?ekFLUmtoTkJTejBsTmpmdjZpSmhSYzJ1b1NDQ2hkTlh6eHhLZlFaMm5xdVd5?=
 =?utf-8?B?RUpqQUh5V3NCMzZXdU1LUVozbTRneGN5RFB6K3ZiaWg2Rk12ekdPSDd2Uytk?=
 =?utf-8?B?VFl4VDdDVzZkeXM4MzlUV0dpQ1Q0ZlZ1NlNKcitvOEdkMFh5UFFFdWwyeFhH?=
 =?utf-8?B?Ukd5d2FRRGxwWWp0ZjBvb3dXSXkzMFdmOW1NRjVzRDVjWWNjdXRqM2FLZXRp?=
 =?utf-8?B?SWRIUG5SaDhFMkxydUczQjNVNXJrU3B5cjh6NGJzRnZ6MHJPTC9od3hSdVBw?=
 =?utf-8?B?VTJ6dkZsbUtpOEZWWENlNU1tVzRzdE5CMXhzOFpIa1VRdUVDYzF5dDdQcFVa?=
 =?utf-8?B?TmowblorMFZkMnA2VXVOVUV6TXE1N0ZhZG5FemtOMnNyY3pOM1RxVnkrbDIr?=
 =?utf-8?B?UEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9976A45D2251434EAC91F9F1DC15378B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OPR4/KgrQ8r+lIszhKuOd59U7xLKAuou4syhClbsHsoduWZw7zFuC+ZJLPKeVm9zXPBB+8DocwJvHpwgJ7lArRefwyatxxQsudtxndUCvbJDF8E29HSsGoqh+pwl998H0F6kHDmAtQSy502/YVTltFjsDygiom+x9NZqhxRYnq0xWZQ6O5e6Ik5Dk4e3GO2Vjmxr2WHFnxtiQfrfDIc0UpjgoNRbXnHrD6rX67BQqTqaB42tVRv1BWuAG2MA+jYWdJI4Is6VxPZMW/5uyjsA+Chgaa+mod5bOTBsck6sovFZ3v3P/IIOmpq4lffkxLlvonOxBx+Xjm6Cac4HRDBlAniqIGDmX8Bv8fumxX+j74to4TzIXtDyposB/W0f6hrQvBiiupbR2x5DWZ5Ps6gGwlhmYLyd4nvKmtAFLp4arcN4yy7D6O9Np9nqcXCcsKP9TyPc9JMsZ1NhfMSXc7l8oiI7IBnFqAE+s+x7qm1sh/DTCwmmf34efSJsW7F18WG7v2ighcd3tp5WgrRTmkfpI66t+q0l9AoF+hK0aSicFZFqXY1QwWPQJQ9DtrvDlDSVYls7MyvXUvL1jqi4+Z5neqCo+YGZFMviuU4BRjwBeMQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d401ac8b-9bec-4188-124e-08dbfda50f58
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 19:35:57.1331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tMjR2exU8GpnxG2uM6GbkkttLzG2h2hpxl8uNS7GRcXTI4N6H135TQA6XRVS9JOoIo74jbTs9r+7LVpXeBmAPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6539
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_10,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=745 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312150136
X-Proofpoint-GUID: gWf4pyK3G5JeuRZprPsXM1xL7ra9Q8H7
X-Proofpoint-ORIG-GUID: gWf4pyK3G5JeuRZprPsXM1xL7ra9Q8H7

DQoNCj4gT24gRGVjIDE1LCAyMDIzLCBhdCAxOjI34oCvUE0sIERhdmlkIExhaWdodCA8RGF2aWQu
TGFpZ2h0QEFDVUxBQi5DT00+IHdyb3RlOg0KPiANCj4gLi4uDQo+IA0KPiBJJ20gYWxzbyBzdXJl
IEkgcmVtZW1iZXIgdGhhdCBuZnMgd2Fzbid0IHN1cHBvc2VkIHRvIHJlc3BvbmQgdG8gYSB3cml0
ZQ0KPiB1bnRpbCBpdCBoYWQgaXNzdWVkIHRoZSBhY3R1YWwgZGlzayB3cml0ZSAtIGJ1dCBtYXli
ZSBubyBvbmUgZG8gdGhhdA0KPiBhbnkgbW9yZSBiZWNhdXNlIGl0IHJlYWxseSBpcyB0b28gc2xv
dy4NCj4gKEVzcGVjaWFsbHkgaWYgdGhlICdkaXNrJyBpcyBhIFVTQiBzdGljay4pDQoNClRoYXQg
cnVsZSBhcHBsaWVzIG9ubHkgdG8gTkZTdjIsIHdoaWNoIG5vLW9uZSBzaG91bGQgdXNlIGFueSBt
b3JlLg0KDQpORlN2MyBhbmQgbGF0ZXIgdXNlIGEgdHdvLXBoYXNlIHdyaXRlLiBDbGllbnRzIHNl
bmQgYSBDT01NSVQgYWZ0ZXINCmFuIFVOU1RBQkxFIFdSSVRFIHRvIGdldCB0aGUgcGVyc2lzdGVu
Y2UgZ3VhcmFudGVlLg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=

