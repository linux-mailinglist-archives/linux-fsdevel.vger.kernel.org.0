Return-Path: <linux-fsdevel+bounces-17714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6A98B1A70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 07:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D2F1C221BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 05:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AED43C08A;
	Thu, 25 Apr 2024 05:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="PfGwWw47"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8EF3A1AC
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Apr 2024 05:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714024245; cv=fail; b=ImaI9EsBi0hbDhPFmfLeGwLmi94/RE4NilfBjdibTb/vhM+Elm/xBygYlMOLmm5W/ZY0MZE+phcbZOHETSk8WFZKW+sh/L/tcHzPM/cKVEOHur52JKqRBsk5Pcr+AnnBBqGcI2wqtSKtNASTEqpx5T4gz03V6Kqb73STAMNRvKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714024245; c=relaxed/simple;
	bh=lD+w+nm/jOnG9Y+hzRhUj13uiHfv4WidGWk/4NGR8PU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cdD3PySR8JTJ3lL66iaU68QSpMvWXXIZ8VlUV/nutqCWkRe+95xYvn/u0yLwz9h255ya5+wbxRCNsQw+JbwqGtxZ7jBhStMLQbvErpEfX+zMV5Nfj7vV3XbjnYd6lR/5f7fR122ByTR/Q6ZcKnytH0FxG4cQoXjXuHEMudIX5qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=PfGwWw47; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43P4mo36008798;
	Thu, 25 Apr 2024 04:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=BPbpxvdPRvrBAr/HKixzehVt/vDLrf6OJ/tT2xB6XfE=;
 b=PfGwWw47Mf2mzMdPXvAznXhric7s5FF9amN7cSIA6I9nce9giaHyXt96ApsEBmsj/4xg
 iOzcGvkLtG0Y/LOTmht7HLhTSGOmh40XKumpdD7NdVa2ZgxdF19Q0CqyTgs25B6cyEae
 9x1w+5bSbZIvdi7CsmboQ6AM0yWQrB8puAOFN4kNGIaAlEY2GdPg13wzgaJt4ssL3y+5
 zGUcZyNGKCPvyU+DlSm8n+jINZjHus+xh15EWsbOQJS18l8KHZL+ipeU9OemKMT9G+X0
 +U8Z6urW4dIVNGEaEhEbRIiZ7qt/7EmfPkuWgtoj+Ao6xU8ILzysUjicGvsHxWqC4i88 Yw== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2040.outbound.protection.outlook.com [104.47.110.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3xqgf7g07e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 04:55:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS7nj6dBL/bLecb7oV3CK6nerrUa53dkO9e3ciH9v+eo6vf5kVdlxyqT14AYEplvHP5GWdQsm7plznaXoKXpzFG6+wcpxVLIP2lo3gSvue1snJwSCB8TpxBMiJI8b+d+wyJmmmMp36AgZwQf1/cuRaeP34Y7nJjS0A4XHy9nzPa00ZJjglRNOHClwhhgsYF4c7zBHWAmz5VPpPnk9o/Y+jRQ+2gshoknePizhnP/Kxg4HQuWP27WHrP8hKxtdQRaYxeZecXqfULEpyGFLvpwfJRJI/OY0kOZLdTnR0z5KU7VKfcsIv6M6gKhjV+ia9CzyEM81+epVk3OBxeDxdF+LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPbpxvdPRvrBAr/HKixzehVt/vDLrf6OJ/tT2xB6XfE=;
 b=ni9l4/3Mkh+gyp0/IMxPcahNANQ/U/8KLN9vI1Sd6eLO9SP8SD5elGjBY2XqkseAPxw75LgL1SLDh9ewDq3anAiPGcueIG3jbP9ztWU3PS2K5t4gF74+Y0IW7xDhnw4JWq9rlIXO55I6IWsBlHkmTS05Ww52jI9nBv32FyWBSMn98cu/4t4TEHR0zvyQHT3neIWDrs3Wh/RDm4GHLkOkC6IRQ6O5buWPC5OHVRkgDvtfo439wjH3WYBI2rxdFgR7FxGvoF9H/g3UBts5CQEocpvM/tzq6X48X+5r/qvQMSMT5xZDHZFRIV+SxGRTjsCw4RWfnSANAN7KtPwWpFdrIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB5757.apcprd04.prod.outlook.com (2603:1096:400:1fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Thu, 25 Apr
 2024 04:55:03 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%2]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 04:55:03 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>
Subject: [PATCH v2] exfat: zero the reserved fields of file and stream
 extension dentries
Thread-Topic: [PATCH v2] exfat: zero the reserved fields of file and stream
 extension dentries
Thread-Index: AQHalsxZETRKwuiwx0K/rOJfKZ+P5w==
Date: Thu, 25 Apr 2024 04:55:03 +0000
Message-ID: 
 <PUZPR04MB6316FDC76BB5D2818276D39581172@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB5757:EE_
x-ms-office365-filtering-correlation-id: 961b3642-0b25-4606-0836-08dc64e3deca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?B0NhHXjGCx0bhLsonybAEXYcgwYF3XOI5Os0t0A9CWmlnWaD8XRl2D2lQk?=
 =?iso-8859-1?Q?b+sBjFYUbOo/42iPw1NGPPVbXlszFcZVcuQ7/PtCk/vR7yVoYmiDXaKnc4?=
 =?iso-8859-1?Q?JikjUf0LYTYPAhL5aYgwRYtFHrZqgLp12geHe0ugKKrIiAoZ6l1g77Gyjq?=
 =?iso-8859-1?Q?maKKbYN08kETSpfXpawkgTNE7vFQFjgR4ZtnY95TJ07oa4139ekS+ocVmT?=
 =?iso-8859-1?Q?zkxekZ/LbzC5VQ21oeZEYjBmbj5hz8KJeAKTN3nGlCzgJZVPsVZJ/OEnLE?=
 =?iso-8859-1?Q?f2k6ymEmAX5+86nELdm+vhuakecS1TBG6vDGjKAN7KNU0ci2lnridrh56P?=
 =?iso-8859-1?Q?04XshYcI9Dj9R1xjyy99BTKqFSwpm41TygLYiovKCzMAYPkm730aH7mU9n?=
 =?iso-8859-1?Q?KDJgTj2cZqQeMs/stO6lTI7/lWctqxSAFbATp0/JzePr7tQqFChmatGDPj?=
 =?iso-8859-1?Q?SQvcWj1UXXO5HPEzfSyjr7R3jDe2NxMc9/LXlbEoAQWDEel3+5gJw+va9r?=
 =?iso-8859-1?Q?pYf+DAU98TsMUNI+NYtQTXZ0k6Zt9Y3ULLkibBKw/8sBqxGo8YZ7HsCkfO?=
 =?iso-8859-1?Q?WH6HYSXPO/aqg3ARvjgx1GDw3WBajbGZ4cCzg2JbWgmZnWO8tiHW160m8u?=
 =?iso-8859-1?Q?dKLo/dHTO1HecrAT87/6ZmOs+fV6CqJPU+k6fAlAYwyKDWZNUteRlj7CtC?=
 =?iso-8859-1?Q?l8SRcqZy9sx+9D2mjl+Iit4P3DHB/x2/ElH47sRb7Re4OVEgSBf85uB76R?=
 =?iso-8859-1?Q?W+eeKJHi7LbcwOqPbUd/zmmUAq8HrdY2vxNRXlCIsNi9IBzM0rPGBO334m?=
 =?iso-8859-1?Q?Lw8oPEmhkXLXEOGyYsAO9Yt4pVMiwD0Co097YE0w+7fKU7hEVJXsaTJS8I?=
 =?iso-8859-1?Q?ITvXnUqUPaaYH5VfxdIBMBgTuPzbSof97B9JXsNduGH4z13EnE9HQ95mMx?=
 =?iso-8859-1?Q?LTUS7YS3uJjc7Nn/+Ib/E7NYa6r0KLrbAZxcOL3Jcn0S73KhsXH5KGNZit?=
 =?iso-8859-1?Q?eJg8MqqoLfVewadBp42p/RtRPokQlrZFpDM8fwSmKiUVFdyyyzHvpUlS6f?=
 =?iso-8859-1?Q?IPHfvlu8SLpuQKRGauS0OxkkGFV7MAS/UVOwz7JFWHDR+Z0QsjJ/aNUNwB?=
 =?iso-8859-1?Q?1y80eByk0RXKWHsMdY3f8dMg4gJir5//PnNSEHtLiyiUeC2jQ599SDBetM?=
 =?iso-8859-1?Q?5jXrKRJAUQF1EWF380P6TGM5vLqBmCIyTWxxprlIlQaK7zVFRmHQ5zlm3t?=
 =?iso-8859-1?Q?sPrRyqEF48/m3iX+k0PfipkIOmkyOBaU9MY6b4sg5uNKDUYk69bePI8Z/M?=
 =?iso-8859-1?Q?aF8YGJ/B1OThSf+JGW17eO4uP5UdLv/I2LAGdQenWRntIktjEaIHbioXgB?=
 =?iso-8859-1?Q?BTfy2f7VHjqOzZ2J4A+RqvTYwsz88U/w=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?sWzQQJTq8p5daZVFXSyLo0qvrNF/LJ0rLS0f5usTnSQhHNJgjowgMoc8Od?=
 =?iso-8859-1?Q?3OW9gG/x6vhz+V11ze56mBdG8H3SSlJRBnzWVZ4jKlt1/iQjfPHMaDz59y?=
 =?iso-8859-1?Q?rEZsVCGY9gK4P3fA+rKvZ6Z3A8wpDbgn7SlJ30TgTyvrAF1Th3uy3TCBPU?=
 =?iso-8859-1?Q?lFxV6Zxr3UuxvLyQYsQJ67EB5kMaW8K9VJPVcw+xvDTNhZIB8+Mybjermq?=
 =?iso-8859-1?Q?bFjVeDAm1dcVIdGA7R3hgTqriQD1yOJwEtgd0N1HKp+39r2DAwriI8Y6sY?=
 =?iso-8859-1?Q?3UHrH9OtQdbMqgxBnvk//Ow46w6pYg8t4ysUuBoSNXUS8DxOi31atXt/kl?=
 =?iso-8859-1?Q?5QMgpPYsbfldnEumKVCXNaxY1ukzZ95SSTFE+NoPLUKjKVDeTbufsjnhdC?=
 =?iso-8859-1?Q?G22ba7pZRepasHqqREIZzatSm1ZCcmtx81Jl/ebCIMHKWXUVZqTyrDBXwk?=
 =?iso-8859-1?Q?rKaadJc1e9LS7cLGvrjTmwN5pXrcYXJYY+TmOOMlAvBrGkLFil5+lNYtz+?=
 =?iso-8859-1?Q?8sLIK5A7buLktMi+48dk1N8glEcHfyZgmxvGmTBfWPUtSOp17IYjnpSTlN?=
 =?iso-8859-1?Q?YdrIOolJU5N/y8eKmSs8c9uL1dYscmy5lQi9c36VG8LqG7bU5lkhpaCgBi?=
 =?iso-8859-1?Q?aDMboSkvmpwn990wT1IBlwVG7XJPccpVOs4s8ElARRHNP+EF3jXBi5AFH0?=
 =?iso-8859-1?Q?su7xg91D1x2zy2bJ2CfyNOuMwYEZXgunPzDqiwlKiZ5wv+arG4CMvrXUjZ?=
 =?iso-8859-1?Q?u7r1odmqBm3XgKP83etiiTDsY6QFj6AOC7iPmCVTNEE7AJN1Dhgkdvj9cW?=
 =?iso-8859-1?Q?wXBtKVmynE/Kzu6YJuu9wwQWdOPYis6KM3+kXOXkpaWkamzioOuKDRbpOD?=
 =?iso-8859-1?Q?UmPz7vVYVpzvp4QJ2BnIc49c/3lwTfLk59LlkbFnE98JMMoFrcRy1voju7?=
 =?iso-8859-1?Q?62Ku3NOOVXqTEDu4Y5ymSnhtKDwwd11pJxuyBseFBoyauXEeILVoIFgr54?=
 =?iso-8859-1?Q?vSmQbgjmBPHoj26nZIaEqeJGf3vu20uHt4vEaX08ECsMA/cbIDK6G84TDj?=
 =?iso-8859-1?Q?6MF/Ysl9fEA8KbZeDInc1uYWZ/XYUcVZPrzuUwFSJ9tEbiZKnUpitzKPEZ?=
 =?iso-8859-1?Q?UGPQM1lcP27glq88awDs6neSSvc80NMY70zSin/fccnt3Z5Bh22BMc0J9a?=
 =?iso-8859-1?Q?EWeVvJ5PAEXNOt9wCkCXlANFMDcjiugg7zQ3yAZwAv/JXN8zKjHPvNUnyu?=
 =?iso-8859-1?Q?6bO0H+54ncKuk/UEuXKf225+snczzJmrtOKCKwmrXFqjTV2qfb2YdhYRqo?=
 =?iso-8859-1?Q?vrBikrveNC3jxMwRL/DlwoqQq/FtMej8osu6zppkTp7dUhWb9a6dxTiR54?=
 =?iso-8859-1?Q?vMAPPPZCBk3/jmQIHzjy4zL9EtPe8CUHFgI7MK7ZzOaC/3CzJqemGdNyyf?=
 =?iso-8859-1?Q?5Ekih+iQ9xWQlUDqruwxXvBnpzRK/5AANwOhI+Y3aWEdsydkxoU0E8yUJH?=
 =?iso-8859-1?Q?+G4XaH57HQz2fn7cc7J4fIKHongurdEmXLJcDe5mzCZd3gHiBDRdat1N8M?=
 =?iso-8859-1?Q?2YpGtj6J/FRSS1T9CiGWxv991rOsLEixI9RstTh8nYrwSqHvsIdGb8deV9?=
 =?iso-8859-1?Q?hfjE4gX3jviUbZa4vUxjqtwlsqSvrvz61pTzukm+fSGQY3fnJ+nI5jv/Bv?=
 =?iso-8859-1?Q?YNKlmUxRBNVSk0mZWz0=3D?=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Y6PR9PARK60AbDc/zAaKVu+p81XMiYLxYpaTAkVyi0nG+v4xGBgvqut+0rzPpv91IAdKNDGRlNbRU7i5eNQePpXspwUI1mQSTPshsw/pZd0+elJj3RKo1KzYp0LkXgpAnQy/na1BnuBLDIETjVw0Z0ZakBLl2W5SI+3Ma/8Pqv90DDByfx528ZC8PhDqV9shm5IrdxGUWjqMpy/YBdTn2ctcROcp60vyElQ7vaPawhxhJXlSDmMpqFyTchszl8ltIYEju77b7MmFM2+uQrPEp4GvcynKudJDt6qfujNIdu4GKJxnrqqcEfcTNS//MQzn92CSqqxyZvgPPGvlrM5GtXf4OLU6+guzP1czji3IAVkaQTTjyZlHcKwq91uuhVReTWs4WgJscHNDg8qi+iO0jHnnkgyRTZCtIqKzjVhOshHyUVTcYotjDVlqF+Q6aofnkE+uyEI4zP+9PJaLbAWs2uV2uD3SkPWs4t44avDoXuSRPYp3eocOEvOHwHRLjPK9C7YxWushQR0DUC2T4Je+YnmJ5gXXi82q4p478nSLnPuZXu9WXewv8QpsgDRx/rVzgcXu4e5e0negMXQvS2ZweLWXi6zoFd+fEG1ZQMwQaYU0/UHVVwFW81DjO9vShvvk
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 961b3642-0b25-4606-0836-08dc64e3deca
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 04:55:03.7889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jDgXcdrUAsYzDMWDggpUypuzPzO+wG1E7110KvJylYYK0qGVqk/7aQ1yA0PfraTpFmxQx2KFEYv4tmKdGQZivA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5757
X-Proofpoint-GUID: T1vSWrSDMqkqz-U-9UUjBLucT8-u16G0
X-Proofpoint-ORIG-GUID: T1vSWrSDMqkqz-U-9UUjBLucT8-u16G0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Sony-Outbound-GUID: T1vSWrSDMqkqz-U-9UUjBLucT8-u16G0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_04,2024-04-24_01,2023-05-22_02

From exFAT specification, the reserved fields should initialize=0A=
to zero and should not use for any purpose.=0A=
=0A=
If create a new dentry set in the UNUSED dentries, all fields=0A=
had been zeroed when allocating cluster to parent directory.=0A=
=0A=
But if create a new dentry set in the DELETED dentries, the=0A=
reserved fields in file and stream extension dentries may be=0A=
non-zero. Because only the valid bit of the type field of the=0A=
dentry is cleared in exfat_remove_entries(), if the type of=0A=
dentry is different from the original(For example, a dentry that=0A=
was originally a file name dentry, then set to deleted dentry,=0A=
and then set as a file dentry), the reserved fields is non-zero.=0A=
=0A=
So this commit initializes the dentry to 0 before createing file=0A=
dentry and stream extension dentry.=0A=
=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
Reviewed-by: Andy Wu <Andy.Wu@sony.com>=0A=
Reviewed-by: Aoyama Wataru <wataru.aoyama@sony.com>=0A=
---=0A=
 fs/exfat/dir.c | 2 ++=0A=
 1 file changed, 2 insertions(+)=0A=
=0A=
diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c=0A=
index 077944d3c2c0..84572e11cc05 100644=0A=
--- a/fs/exfat/dir.c=0A=
+++ b/fs/exfat/dir.c=0A=
@@ -420,6 +420,7 @@ static void exfat_set_entry_type(struct exfat_dentry *e=
p, unsigned int type)=0A=
 static void exfat_init_stream_entry(struct exfat_dentry *ep,=0A=
 		unsigned int start_clu, unsigned long long size)=0A=
 {=0A=
+	memset(ep, 0, sizeof(*ep));=0A=
 	exfat_set_entry_type(ep, TYPE_STREAM);=0A=
 	if (size =3D=3D 0)=0A=
 		ep->dentry.stream.flags =3D ALLOC_FAT_CHAIN;=0A=
@@ -457,6 +458,7 @@ void exfat_init_dir_entry(struct exfat_entry_set_cache =
*es,=0A=
 	struct exfat_dentry *ep;=0A=
 =0A=
 	ep =3D exfat_get_dentry_cached(es, ES_IDX_FILE);=0A=
+	memset(ep, 0, sizeof(*ep));=0A=
 	exfat_set_entry_type(ep, type);=0A=
 	exfat_set_entry_time(sbi, ts,=0A=
 			&ep->dentry.file.create_tz,=0A=
-- =0A=
2.34.1=0A=

