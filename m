Return-Path: <linux-fsdevel+bounces-13185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2599986C707
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 11:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496A51C214B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 10:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8646179B96;
	Thu, 29 Feb 2024 10:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="V8R9p7az"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D5B111E
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709202956; cv=fail; b=mqyd7xBrH0lr2k8Hen5R1F/bmQIKiCbsKVCYxnWSUWcpB4QF97eccnb9YqM6ezXkbmbrzLcpb7oyzWXJ3LPlZHtsbYjtYLBLNC6U2mg/WaDnQJ7scEa5ATcQWI/K81x0U8RC/vXkIGDobFiqza7x89L1M2NJQy+0bfqN6L5kcsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709202956; c=relaxed/simple;
	bh=xSeW4CBxdm9pZzpf7DSgdDmL2fK0ZleGpNyVCTE0IZ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=WCW4E91ojBZ6Ehj1CJt0wx0mqw65VRuNMocpuFoBsUOsXIGoK1snJbjsXveEPE6I0fxjxl3zh4mUX6Q5/6h52/V9qwsVhAnB7XXBhxj/1CGkyZaRk5T3eLPMlOx6pkHjtkYdCWbXBvO2TTECEL9Ts6bhkmuxHqHLFPmsucEd+/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=V8R9p7az; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41T3tI6J030854;
	Thu, 29 Feb 2024 09:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=xSeW4CBxdm9pZzpf7DSgdDmL2fK0ZleGpNyVCTE0IZ8=;
 b=V8R9p7azSc6JPiga3Lir51TyYoAGKgSEKYx/OQk1y8Nu1UaSJBvOvBhF9nUH4d+dENoD
 7GRGJzg9w/1w1W6jKdHbNipPp2Jy/PcvSFOVB4D9HK6cciO3ZSLA15ty7ig5Yma3qtlO
 OLjoc7oS85QHPA1k870lLnczLYGvsIAGtiWmKa2mZt2O4ltNj73DZPDRmSMM/3KB5nJ9
 zJXu/Sy/bHr8dL1aXqYUkY8jXjvl/YTdmygxuYcXpmAEG88//lhznWAIlDpgqBlCFfmQ
 quRQKqjDa546CW55/rx5nrOp2t7gh9GTJ20E2NHJ8heKWiKigHNjfWxV/3tGL9MvAVp/ 2A== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3wf6njdm7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 09:37:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e93iVjrWFj0fOq0UoP2TXQcAM4xHj5UuCzApT85oF8JViUdkeBIXgGkgIBxk/371+K1cjYwqz3Dva7xmZU42uZ0RnGzOzpR3WqOIsHw9bej58KlDaKa9e1bW2urM18/Jzf8YhpTrgVAwP3ogTNVQYonsiEFNpFdJ/ZtZbcBfi0GwBKZEmbe8uHccOUjgRcq86VAjApXkdaI64b7LrakVMxOccbmQoSjsScj60BD243EkRgb0dP1WNVuovUBivTT1ezoB1LQpWH7B4BLVecSCetAQDby1kgeU8qa14Yu2kanH4xoPXFHIOxeY4wCmckIjNti/pfxY9COVfv/L/PqGhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSeW4CBxdm9pZzpf7DSgdDmL2fK0ZleGpNyVCTE0IZ8=;
 b=ab5bxGECTUeMrba/GqFJXGmWGTmt+yGRFB4zCjHxdtQA2Tzq1vBNI9a3CQR5GipJDxBkk6wNFAvRnG3uU51ncEDl0hxCIiIKFDu9ERlwvBd3pRKSeZdjY309g/m/voUX5nJ7XCtE+4Y1aZdAvyO4x1FSvm6CRvGbL8dQ9UQ5aGi+WL206B2sXW/7hIjl0X+pXhc+BLKz5UJyfwlHzZjI79TffstzoV922Ob53kSHi99+ako2yMzavXLWS44hmcMz0ODC2FigfrettoDyROEtGygnNs/PDCvV+uLCyVXqmyP2+glz+TMamv2ngNSOUBNuM1AmrFE3QApmVC2xuETRXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by JH0PR04MB7843.apcprd04.prod.outlook.com (2603:1096:990:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Thu, 29 Feb
 2024 09:37:04 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f0fc:7116:6105:88b2]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::f0fc:7116:6105:88b2%7]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 09:37:04 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: Sungjong Seo <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org"
	<linkinjeon@kernel.org>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: RE: [PATCH v2 02/10] exfat: add exfat_get_empty_dentry_set() helper
Thread-Topic: [PATCH v2 02/10] exfat: add exfat_get_empty_dentry_set() helper
Thread-Index: Ado5WSoMFJmHKVpOTLmXDrw3gU+2Cgxff+aAAAWDFiA=
Date: Thu, 29 Feb 2024 09:37:04 +0000
Message-ID: 
 <PUZPR04MB6316497F29CE003CF7AF63B1815F2@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: 
 <CGME20231228065938epcas1p3112d227f22639ca54849441146d9bdbf@epcas1p3.samsung.com>
	<PUZPR04MB6316C5AC606AABE0E08AC2A6819EA@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <1296674576.21709188382123.JavaMail.epsvc@epcpadp4>
In-Reply-To: <1296674576.21709188382123.JavaMail.epsvc@epcpadp4>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|JH0PR04MB7843:EE_
x-ms-office365-filtering-correlation-id: b7468392-f464-44bf-b309-08dc3909fd1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 YDBhVN3BhXBQfKxq4xVqe499OuJRXTDYQNKRDot5ijgnjyFryzeTnp/KDkndUOfZpje1Gly5vDZygFENlDcEVbob5+nN3aKQXifLMEpL+h1iUiAh9Y18D1SIDQijdahF1B2GxNhlQjSiWHZvSKiaqM7G5K8erMdJvjOGz4Naed19feXCn7JpFupUZ+F7kQCt38pk6SGGPDnVJW3kMZznXwzmnvb0Eecqf0RhfAefLAhe5KpRMGupvU0yzkDPMd9sEsx0L+B+4ND4qHWQVX0wB976Kx7WSHUwuOhBMVYGgBC3ad9ynr7jejq/wnV2floNRQKQnMKfPuO3WaoDDH+UhslLTIxFvLhcScSLzbikTXhOhx2xE586tMfI16eO6qS2wipkVdPebfH2YA6IGQx8oSKQ2BO7Jai05jq1stwDgg8BOkSkWPKPEyJ9xk9eS9JdWq8ZBe99dz6SRyt45X+C0dE0yfZ4y0f3xYyNryYxy2C+appu7NfXyMKj/wlnHsAoC0s61C43Rpw2VBo+fZcB6+OI1BUoLRmOvRPy4n/ekzRt6Njst+coTe6Dl4w4p92Z07GUoijRfiM8vmF54zDSnVL48V1gHOP9ueC+q2bn2vUaayhqGyo1b2KbjKuhXEaym4X8muXYQBzqYMdzZE5pHFUdxuQrsiy2ZzlzRw7ux07Om5kmfoFSMS/o8usldGy42JDRMO/+ydxOhFuSSfzM9Qvh4il73NjsvIrtZvnLpDg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?U0JOMGY1T1lVUUc0RmVYd3ZVUzhnWGNFM0lzaGNIMlkzMVRzUCtMSUJaZWNx?=
 =?utf-8?B?K3RqYlVmYzJFczhQQlVRTUw4RlJwdGZsbjVNZUROQXVBZSsrMFFQQlA5aTY0?=
 =?utf-8?B?T0Z0dkNLRFRLdUpwT21VMnA4T0JOdE5RbGNJdEhzNkx5YkUzZ0JlTDRGS0tK?=
 =?utf-8?B?Qmcza2pRY2dkaWtzNXoveU93RGE4M1pBeUt0OGdQVUkwdFBWRmpaTFZXZUlr?=
 =?utf-8?B?V0dBLzRKdnlOR0pWdTlib2NyUloyYVFyRG9FM3p3dHF1a0FpazhLYk1nYiti?=
 =?utf-8?B?S1MzWHluTVRmTUFncXdkR1FNaU80Vm01TExZdURtb2NBNFN6dm54Q0VqcXVF?=
 =?utf-8?B?cXRSY254M09waVlyNU1zaWR2dk1XbGdFRWVBRXJPbzdYcjlGTjFKc0w5aDd4?=
 =?utf-8?B?c0R6SnhvNVVlOUJmWkVUUStFc3F4Tk9iR0oxdmtZdktmOTRHd1h1TVgzcDhK?=
 =?utf-8?B?UkpRYUREcXpBaDlkU0M2dzYraWt4V1orcFZtVmowVFJIT2hJdGtSaGVvOWJl?=
 =?utf-8?B?TU16M1dEdkYzWnBrMzlTSnFFY1c0ZlBmZ1NuQUttYjY5djdCUkVoQ0szY0V3?=
 =?utf-8?B?eVo2ajFkaVNKYUU1Yk5SSXU1bjczTEdocVhWbjZic1ErM3pqMjZYc20vYmxF?=
 =?utf-8?B?cnE2bXVOMHF3RW5rQ0Y0R0NzdVJ2b0FKRGtNN2xGY2JNS3N2VGlLaTlxZTVi?=
 =?utf-8?B?N0xWemlubWthZ2tLaEJnSzV4TWdvTC82YVg3TlROZ29QM0thclptSHZXdUdV?=
 =?utf-8?B?eWhDdkV4cEdNSWo3RE5PR1M3bjNmcTZKWXQ3TWhuUFJwaHJqQWdYeUkvY2Ji?=
 =?utf-8?B?V3EzbzluK1RIUWRtbkZMRUc4bzFldm1KUXYrbHBtVHlWeTQrS0JBMTVFNEd2?=
 =?utf-8?B?UmRTbWJUSm9jb1VxbVBtbDVnbm1uVXAyQm50OXMwZmlhL3IzaVJpMjN4RmFH?=
 =?utf-8?B?SVhCVlZ1ZTlVVVNHUEsxNm4vWXJZYWdEb1BYOCtCVFRSaVhkb2p1anJ2TW9q?=
 =?utf-8?B?RXd6bGtsaVMvUkYyaUJUbTBuVXhtOFlDWG94NklteSt6cnkwTXJSMlMzRkpG?=
 =?utf-8?B?MnNXWDNmcUJsOWpUVUJZTFgwa3hCaVlkSTlnTjdPblhmVnFuSTZqTG1ZVG0v?=
 =?utf-8?B?cFhLdjFSRENuMG5vZlh3b1pqRThqRjJTeEZGaWdpZGFreUFmbk1qNlBiV2hz?=
 =?utf-8?B?bGxDK3czN0N4elFGOG9vazhGRHhCTS9jWGZZYVd0KzlwOWhYUXZDWWpCYU04?=
 =?utf-8?B?V2d3Ui9CRW1BY2JlOVljN0VJSjRzeU02dnZxakpvQnU5UWxsaFlocjhNU0ww?=
 =?utf-8?B?dGF1VUdOSFR0djFtNEcvVDhRbFZjZkZNQVU1Tzk1ZWdZMnVCWktPTi90dnox?=
 =?utf-8?B?Z1NFd1dRanBpcG1vMUdtc3VyWnk5VUdRYkw0SlVta3piRUxYVFJoSG1oSG9p?=
 =?utf-8?B?Z0NyaXl5aHlQbDgvZno0aEwwb2lBRW1lMWNOR3RRZXFVUFNkTmFjdWE0RzlH?=
 =?utf-8?B?TitDU3VQVk55Nmw3NDFoTTJyUkhHL2d5Qmd0d0pJdWpsbXlEZXdJYmUvZk5r?=
 =?utf-8?B?R1pQTHdkaktTd21CSnpRYkxVUXkwdHJBNmo5UDB3UVc1aDQ4TG9hbXVubXc4?=
 =?utf-8?B?ZitKd1MyRXA2VEJVS3prZVJjdkFtYlA2OFg1MmRGMEJXNWk2ODhPbUt0RE9Q?=
 =?utf-8?B?TUtNOC9NRDBMSytOZUY3UVNYeWdlbm9kZmpRYXJQaUdHdlFRekJlQW1wY0p1?=
 =?utf-8?B?bkUwdVRGTWZpWHJqanBzSGcvZWU0em1aaXFXcWxYNFVHeTBZc1pZNG0xeEZa?=
 =?utf-8?B?MEJ1VzZrTGF0Umo1NzM3Y094QUtKV0ZEbUl0bndaK2dGbER5SGd3U29ROU1W?=
 =?utf-8?B?YVBzdERmSE1yQzVWTDR0TFFRMmVwTHRjR2lyTjZYQUNWbjdraG1UeVdkRVF4?=
 =?utf-8?B?c1hsRUxURTdBaXNwdUR3VXI0YW0wWklvOTF2TnBIS0R3THlPMW9ML3lCOXpv?=
 =?utf-8?B?bTVmMEl3Nkw0citwaE9xemhVdlluMHRVdVhJbzgvRXVxWnFpb1RFdWlYSzQ5?=
 =?utf-8?B?emtjS29xZnJkUWkrOHJsNXVnMGVqMlVxMWgzZHBreEJFVWpVU2hZRko1UkY4?=
 =?utf-8?Q?B+ixRUdlV1LTuUFzG2kRH9xRn?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Qt3XiXKxP2RUyEzsm+0jrgpyms0AGHpkN3n3bPeGY5JXiwJITHCej/SOPFApdm5V9ehZfi8GP8tCthgidifczq0VvK7AIVYbfcJ5qgz9rPK4DQHWx4Ta+Mf4TxSuasAtipQXCBqaez1XxRes4vFQiO6g3K+56mwcpEvvtPiij26L35bbIdblv3b2OYqMAXdWUzYJoALI+QWepPVvOjeE2qRsehHW8tcDy9sPwldhX3NKsU3vr4LpkICIRlwHJbg5I8InmO2yX7vFrKq8pOiP9BDXSIz8mAjKB7uMscVRQBoeEM+rWngOb1zqfjLGJ2RSNJmmyxbo5qComqKCIAGwUg58+f+xrD7VenJ8Zf1n1zdT2k/EPMXHXOxXogFJgsxw7Zw7BIsNnD7u33jJpe2Y29zFjJszJgX2M7WV004ML1JAgrspcuPTjJDZXLfMO/BPVn4ATSKtejdG19x3OPp5Jij9SzTprbpjWsv2jZDzSn5CXnjDTMZ2i8O8XLVdphQ/nZPVrsl1T/b7VCYJRnGVrdctxgPwBytfPiBUnlJQBeGbbIRTGOH6J1IMd/qBXZWLhZTXrhsLARZjS2kEUIp0OVXDEUK5a8rBdAEAvcm9eTIBXf08TzrdTySRjN0s/Mxy
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7468392-f464-44bf-b309-08dc3909fd1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 09:37:04.3364
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AIbbsSUgB4tOELmSx727BGj5EIn5xaLuczjXiyajCz8HJkrqu3XR+EUjC7Zttb1j5+KeGXMcduvLAzXKqH8sGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7843
X-Proofpoint-GUID: czuY9N-jj-VWq8s4UXQRW3TgUcw8Cied
X-Proofpoint-ORIG-GUID: czuY9N-jj-VWq8s4UXQRW3TgUcw8Cied
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: czuY9N-jj-VWq8s4UXQRW3TgUcw8Cied
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-29_02,2024-02-27_01,2023-05-22_02

PiA+ICsJZm9yIChpID0gMDsgaSA8IGVzLT5udW1fZW50cmllczsgaSsrKSB7DQo+ID4gKwkJZXAg
PSBleGZhdF9nZXRfZGVudHJ5X2NhY2hlZChlcywgaSk7DQo+ID4gKwkJaWYgKGVwLT50eXBlID09
IEVYRkFUX1VOVVNFRCkNCj4gPiArCQkJdW51c2VkX2hpdCA9IHRydWU7DQo+ID4gKwkJZWxzZSBp
ZiAoSVNfRVhGQVRfREVMRVRFRChlcC0+dHlwZSkpIHsNCj4gDQo+IEFsdGhvdWdoIGl0IHZpb2xh
dGVzIHRoZSBzcGVjaWZpY2F0aW9uIGZvciBhIGRlbGV0ZWQgZW50cnkgdG8gZm9sbG93IGFuIHVu
dXNlZA0KPiBlbnRyeSwgc29tZSBleEZBVCBpbXBsZW1lbnRhdGlvbnMgY291bGQgd29yayBsaWtl
IHRoaXMuDQo+IA0KPiBUaGVyZWZvcmUsIHRvIGltcHJvdmUgY29tcGF0aWJpbGl0eSwgd2h5IGRv
bid0IHdlIGFsbG93IHRoaXM/DQo+IEkgYmVsaWV2ZSB0aGVyZSB3aWxsIGJlIG5vIGZ1bmN0aW9u
YWwgcHJvYmxlbSBldmVuIGlmIHRoaXMgaXMgYWxsb3dlZC4NCg0KVGhpcyBjaGVjayBleGlzdGVk
IGJlZm9yZSB0aGlzIHBhdGNoIHNldC4NCg0KVGhpcyBwYXRjaCBzZXQgaXMgaW50ZW5kZWQgdG8g
aW1wcm92ZSB0aGUgcGVyZm9ybWFuY2Ugb2Ygc3luYyBkZW50cnksIA0KSSBkb24ndCB0aGluayBp
dCBpcyBhIGdvb2QgaWRlYSB0byBjaGFuZ2Ugb3RoZXIgbG9naWMgaW4gdGhpcyBwYXRjaCBzZXQu
DQoNClBhdGNoIFs3LzEwXSBtb3ZlcyB0aGUgY2hlY2sgZnJvbSBleGZhdF9zZWFyY2hfZW1wdHlf
c2xvdCgpIHRvIGV4ZmF0X3ZhbGlkYXRlX2VtcHR5X2RlbnRyeV9zZXQoKS4NCg0KLQkJCQlpZiAo
aGludF9mZW1wLT5laWR4ICE9IEVYRkFUX0hJTlRfTk9ORSAmJg0KLQkJCQkgICAgaGludF9mZW1w
LT5jb3VudCA9PSBDTlRfVU5VU0VEX0hJVCkgew0KLQkJCQkJLyogdW51c2VkIGVtcHR5IGdyb3Vw
IG1lYW5zDQotCQkJCQkgKiBhbiBlbXB0eSBncm91cCB3aGljaCBpbmNsdWRlcw0KLQkJCQkJICog
dW51c2VkIGRlbnRyeQ0KLQkJCQkJICovDQotCQkJCQlleGZhdF9mc19lcnJvcihzYiwNCi0JCQkJ
CQkiZm91bmQgYm9ndXMgZGVudHJ5KCVkKSBiZXlvbmQgdW51c2VkIGVtcHR5IGdyb3VwKCVkKSAo
c3RhcnRfY2x1IDogJXUsIGN1cl9jbHUgOiAldSkiLA0KLQkJCQkJCWRlbnRyeSwgaGludF9mZW1w
LT5laWR4LA0KLQkJCQkJCXBfZGlyLT5kaXIsIGNsdS5kaXIpOw0KDQo+IA0KPiA+ICsJCQlpZiAo
dW51c2VkX2hpdCkNCj4gPiArCQkJCWdvdG8gb3V0Ow0KPiA+ICsJCX0gZWxzZSB7DQo+ID4gKwkJ
CWlmICh1bnVzZWRfaGl0KQ0KPiA+ICsJCQkJZ290byBvdXQ7DQo+IExhYmVsICJvdXQiIGRvZXMg
bm90IGxvb2sgbGlrZSBhbiBlcnJvciBzaXR1YXRpb24uDQo+IExldCdzIHVzZSAib3V0X2VyciIg
aW5zdGVhZCBvZiAib3V0Ii4NCg0KTWFrZXMgc2Vuc2UsIEkgd2lsbCByZW5hbWUgdGhlIGxhYmVs
IHRvICJlcnJfZGVsZXRlZF9hZnRlcl91bnVzZWQiLg0K

