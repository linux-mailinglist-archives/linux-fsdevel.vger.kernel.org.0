Return-Path: <linux-fsdevel+bounces-62791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D23FBBA1003
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 20:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3043B43F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 18:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92E4314B7A;
	Thu, 25 Sep 2025 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Okp/5x/F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10E530CB20
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824743; cv=fail; b=nZmyuO+QXZr4ExCb8lkxHJTVr3lKAfQqLq6LIqZMfZvxuE/VTkymVoyBVz0eGq45IbtC4lXQFC6NUJWdQaTEBMdy22d7t2OAaX0Yrn7MC/dtcXXNSWqwbziokSz4LBSXxi3oMpS8Z+T8h5cis7MxAsx89yujJwkUBR19SMeUv3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824743; c=relaxed/simple;
	bh=4Psnlaxx8b5Ga21Jtbb9kEd1UrRnLN+FgrWqBXGvtR0=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=qn+fc6OWu2ipUpLqmnzdsZPE0iT7IiYIwL9S/QPiLFSpurXpxPb2hMd54mBp8ikdsYnQ05fF3zeATDOwxOTLRAgNJ9Cwr0b2DL3gU/uasRBPwTok+Nlx9ZqozV5QTqndtpLgmLXOBTKmFA02P3E1J3ecQkCXo8UDH2knzaMOgug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Okp/5x/F; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PGYkkR010289;
	Thu, 25 Sep 2025 18:25:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=4Psnlaxx8b5Ga21Jtbb9kEd1UrRnLN+FgrWqBXGvtR0=; b=Okp/5x/F
	eNwE365JxCu682oHD0mAOw/v0B0AJC8XARHmyzek6swuj+OejFR+hbIH3ai7bjrD
	O6qGIaasPAxaK25yAUwYryyTk2Q6PSZioOJysGBpNCb1xJlVUNLZrD+1RIFWk1+G
	XwGuKqQn7GfJSfHXanT4cDluVeFtztCVLQGed6BqA3uwYVXX55KHGyNqaFAIaQDY
	dqczOl0qIu5r1J8WYT6Wq5xILDGOrN4nWn4nnNmoSbTf3AmkGX5vmAfEacesejoI
	vyVGwi78IBdtS5BbG+eEvRxXOpovwNSr3z65D6Wq9kGlpMANb3MkTwxdItktZDO8
	YoDiodBJ2fci3A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky6fpqa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 18:25:23 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PIPMc9031312;
	Thu, 25 Sep 2025 18:25:22 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ky6fpq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Sep 2025 18:25:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1X1842TA6SBW5QaVIKNlG5EgEOkeoDuZn6DAqT1rR2ZJNhGbAsU0BP2rGL1dQWTQvsMxocOebJmCqS8iATDgB6wNyxsCD0j/ojsmFOeCojtvawallnZas8yKjt0p9kOlCJ6m+IGymohPYT95S3AelZ9zWwogeGrrcGNVmIMWnL93isd7WmqyiobaHsHpGo3HO7bHaxfw35KU4fsalW47YQeXaWh9VJDWPKWcMucW8TWqpg8n3ZhaEGrsuChnmBh5YCmK/gM4n2KPKbzU6zlWWFDATNB1Tbj6p/EZdV7bIQ6o4kv+LK49OVIiFw7eb9YnIA+R0xGBMYUpDpyQ7m+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Psnlaxx8b5Ga21Jtbb9kEd1UrRnLN+FgrWqBXGvtR0=;
 b=ecxzU8uZ40YMjYzHbaiL8uNgGPE14svGWHyxck5rBBG5eFkjLsEL6VjI8p9RgfA/Pz5dalAp86jYPfk39i37FLTfdJE4uTsOq54hckbKCzIsiU0IfhaBaydLnLq4EP5PICKPY5ckNAyJYP7Wzsy2vza2NO34YxDXnHgZScxmnH6e8issQNaC5SYYeT/6gaFUJqqMGR3YjuBkXU1rcZgyCJxUtGGjEtEu8nZF9Vaup0l1r7mcyA9FXExjspSk1uUMWbXHAT730SZFKB10aQZTIHxGqqrtimN7JAayXj97JjnO8QUtzA0tT8Hais0M9mAv7iQZFBfHTkiCju5S3/p4VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB4702.namprd15.prod.outlook.com (2603:10b6:510:8c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 18:25:20 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%4]) with mapi id 15.20.9137.017; Thu, 25 Sep 2025
 18:25:19 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "idryomov@gmail.com" <idryomov@gmail.com>,
        "simon.buttgereit@tu-ilmenau.de" <simon.buttgereit@tu-ilmenau.de>
CC: Xiubo Li <xiubli@redhat.com>,
        "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>,
        Pavan Rallabhandi
	<Pavan.Rallabhandi@ibm.com>
Thread-Topic: [EXTERNAL] [PATCH v1 1/1] ceph: Fix log output race condition in
 osd client
Thread-Index: AQHcLfIbRzCcHTGG3EqhQ94h8/npD7SkN5qA
Date: Thu, 25 Sep 2025 18:25:19 +0000
Message-ID: <ddd82b5dfc5bcd6cc0a5a32144e59f088beb95cd.camel@ibm.com>
References: <20250925075726.670469-1-simon.buttgereit@tu-ilmenau.de>
	 <20250925075726.670469-2-simon.buttgereit@tu-ilmenau.de>
In-Reply-To: <20250925075726.670469-2-simon.buttgereit@tu-ilmenau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB4702:EE_
x-ms-office365-filtering-correlation-id: fa8b9c4a-a3ec-4d24-d8c9-08ddfc60e23b
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZVd1T2VKSkV0eUhiYWdwN2lId3BKY2lUTC9qaTFmMXhzWUl1NGVBdkRYd1FD?=
 =?utf-8?B?SVNLRHRYL1ZSSE1MWDNjZ2UzR2JGbGxpUll5WG4wMmt6SkNSZ09HU2pUc0Rl?=
 =?utf-8?B?cC9sUk55ZDlkcVdyQVNMeFZ4aC9zclUzWXh2UHprT3ErbUZXMXZZb2ViZWkr?=
 =?utf-8?B?TGdXMjFwUTQ3QXNTaGl6ejZZa3hNdW50b1ozTVQ3dERqcWhnU2NOR1Bncmlv?=
 =?utf-8?B?S1VNRWV2Rm1kMGVmRmNBRWQyOW1PV01Pdnk3clBJNWNkMkQ1NnJhVGtocHhx?=
 =?utf-8?B?ZTlqRFd4Z2NxN1dwSkM5b1FwMTFSUXhKaXJDckdpcjlzTExPT2svdFl5S2Fi?=
 =?utf-8?B?bm54T0hiTnVGV2lBRm5DVTk1aTB5MC9vVDFGZzRGY0xyaFJvNC9xbnJkUFBB?=
 =?utf-8?B?RDJEaHRQODRreER0QlZxQ1RVUytsMGJpbUtrOGhaUHNZaGNyT2p5QlU1VURh?=
 =?utf-8?B?T25ISW9WWEpOaE9tNCt4ZWI2M2VDdndSTTBrV3FRZlJIeEtuT2NWeFp3cWFK?=
 =?utf-8?B?UGNSa2xibWZXenR4Nk9tblVqODY1UmlDdFRQYkFUZHFEcXl1T0I5YkN4RGxX?=
 =?utf-8?B?YSswaUM4Yi8vK21FeFlRaVFkdWZHUEZlTkNpMHV6SENqN3hSd05oK1R1eXNM?=
 =?utf-8?B?OURCTVBNd0tuL0dOWldDOXd0bkdKcW1JTThnYUV6WG9MQ3gwZUN3bVhkZ1ZT?=
 =?utf-8?B?OVR6amhYT2R0ZDNTV3ZpUG1CNDFEZEdHdUFzTXNvd1lLQU4zdW82bjRNcGpV?=
 =?utf-8?B?S2VhaDBFQ3BUT2diZ3FJUU44cWZ5dEdiakJXTXU5TGhrNkZ3ZGFRUGVOK1dJ?=
 =?utf-8?B?Qlp0UVJxQ2pQOVJrejYzVG9relpmeVBVbmNvWWJmSjRlQTdFK2pFRlRudE5L?=
 =?utf-8?B?azhpMzhodzdic2J6MGtNVGRUbDhGWEZ3UmtNM0U3elFuYXNWRFVwSFpEc3U2?=
 =?utf-8?B?R25YdUlvNDR4Z3JnRWRGTVZlNk52Z01LNEI3dHA5MS9Ia1NocXhtSEdLMFdG?=
 =?utf-8?B?RUtpcVJhUFYzVlpUcklaUDYwR1h4Ky9VNVFsaVRBeWRJcGJmTXZZUzVuUTBR?=
 =?utf-8?B?WDVBRXhWZnhqS3pwT2NyVUg0TEVTaDkvU2dVWmhXMTZ6em44em4xUkhOY0R2?=
 =?utf-8?B?bEZWdXdaazhHN3FqbzlSTm1WY3BqazBicm9JT3N0cHAzMi96dDVCNGF3SVJN?=
 =?utf-8?B?Ni9jeCtkbXVjSkVUaVpFaWJkendhSEhWUWtsdlh3aXVkd1dTUmRBVUtrcXMr?=
 =?utf-8?B?YW52RnlzdlZrVHlBYW5IUkFEUzJaYllmc0V1TVF0MDZCcmhiR2U1cHZvZ20x?=
 =?utf-8?B?SXNaN2lVNHlsbzlNTlFLVFlqQWdaR05acTZJUWIwcnUvK1JacytnNjd5c0lj?=
 =?utf-8?B?UDdpaS9tbnFvL2xQdEhsdkVBRFByVFR0Yk02RTB3enJNS0RlT1BkbXJneU53?=
 =?utf-8?B?UVZKbjN3Qm1BVlN1TVpqbzJ1QjUxRkVTUVFvOFFtcnNsMkc0U0VoTU5iMUIx?=
 =?utf-8?B?TmRFQ0d4N1lsRDl4Sk15c0dncFZpaTJmOVZFaUk3NWphMjBueEJBVkdqOHYv?=
 =?utf-8?B?aTd1VWVad3FRY2pVNXlQVUZQN2N1YVVuSGFnS2RNb1E1aldwRnlCdXVINW81?=
 =?utf-8?B?QlNzaWdIK1UybmRLalpEVUtLMEg2VGM1SWN5aGorT28yYklDUkFScGxscjlZ?=
 =?utf-8?B?Ykh6L3dnTTFVSWs0S0dNOTMzcmZtOFk5Z0RtQWd0anErWUJFRHErc1RGb2FW?=
 =?utf-8?B?Mm0zQ3hySVhPNVJ1ZVlIN2MvSUNGcis0Sm5leXh6V2FQVkpBQ0dnNjdST3FB?=
 =?utf-8?B?dGRJNnB0V2ZsWFdZMDU3Z3hQMm5Nc3kwQ1dMOUg2azZKdnJaeGRKTFdXUWcw?=
 =?utf-8?B?NDAzQnRZWWFBM2FtZFdwMjVpYU1KOHFiZ21oSllKbXJsaE5Jcm9FbnA3VEN2?=
 =?utf-8?B?Zk95NzZUWWl1QnFIT2lBVmJqZkVuSy9XMU9ZR1IvcEhpVmR3WUhWdCt2bVB3?=
 =?utf-8?B?cXlGdDFkUXhLM2NCTUpCSHN5eDl3cHZtS1dwd0dlamNuMjRNOG9mZXVFakZh?=
 =?utf-8?Q?942DHr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alluWXlLc2FhaEZhWm9CSFBscGVTdkd1cmhiVHhCbWI2SEdkVi9Ja0xPQm1T?=
 =?utf-8?B?SmFQd0R2RTFNaXdHM2p3NUxEdmdTcVp4SFhQTUpNNTNGUHJCejBGdmtjVkhL?=
 =?utf-8?B?cDN0VjdUUzZpSE4rbTBLTVpJSTZNZGVHVU9kTmFsaGRXWnB0SnU0R3VZNW04?=
 =?utf-8?B?cXoyTk5OWHFqb2NDZVMvRDA5Y3dnZC9ONE4yY2VtT1ZrRGxWVDROWFNuZk1I?=
 =?utf-8?B?VFZ4dlh6aUUyYVgrUm1BYU9sNnpHOFQyeXRna0dMSGJPZUR3NWFOaUduOERX?=
 =?utf-8?B?YWtHbUhMbm1Xektib1gyMW9aRlBHMGQ4bzNRM1FuVEVKU01yV3lkYlZtcUMw?=
 =?utf-8?B?Q2FHUkJkS2JRYzd5YUpLN2Y4dHE0clBaV3FvcmFvUWpUL2pRQ1N0alNMamZt?=
 =?utf-8?B?RnhmalRyYllpY1dEMGZIOGpOSUVmbFZ0UXRjSzZyRW1jWEsvaDBVZzJONXc0?=
 =?utf-8?B?Y0l4MHI4T3Rtb25pdWs0VnVFSFNhS2taZ0Y4YlVpSmdGQzdYbjI1S3ZMKzE1?=
 =?utf-8?B?N24zbzZmeGRhaTJ6TDJaRE9DbDAxNkRaY3p5OEVNTnlGZjJwWkVtbDg2emJL?=
 =?utf-8?B?b0JyY09xcDVDVkduK1NmQUpONzlRa09VR0NZL0JkQzJKZUxaVHV6cys0ZXpj?=
 =?utf-8?B?T1FudjVpdVpyaUhreW9MajdsMXBpdXhZamd0cldzZ00wTVRKWUNvTWhnOWdi?=
 =?utf-8?B?SittdWVFTFdUczlnVWNndVhLN3J0cW80ZHNESS84T1VzdjZ4RHlMUGQrcW9h?=
 =?utf-8?B?Z0h4a1ZZRFNMaG9Tc29vUjYvTHJPN0RPZDQrZW9GMXpZVWNlL1MvdzRSRHBQ?=
 =?utf-8?B?YWVuVWVKZTJmMTl1b1dWT2gwT3Ztdk9VenJmcEdOc2NacFo4TXNnWEdTeUlm?=
 =?utf-8?B?ZTBRNzRzQnM3TVBMV2l1dEorVkZrcnQwaGlxVG5USDBWUGtaY1FwY2N1TjY0?=
 =?utf-8?B?TWRCRUVKdDI2T3RvWW02MVVkVWhEUTJsRy83MjhEc0ViVnQyVGxjcXozb1Q4?=
 =?utf-8?B?elNFRllYNElxTEM0cmdQVnpwOE5Mc3MreFRsTHZ0TzZlVFdBSG1vSkxNdVhq?=
 =?utf-8?B?YUIwR3RlRzRKNmNKT2M2T1d6V2h5RVBHSHhxOVVydjErNjRMODdEcXlZSTFu?=
 =?utf-8?B?cXZvMDk0Nkg2cnQxS3BHWFNGaWtzVlJpUFhPUytSK2lxVGpOK0NZRWpoSkFu?=
 =?utf-8?B?Q1l6R3lxZFpxNE9SazZRQS9ReEZTLzZXcVRnazBNL3dKNjBKQ0NiVlJ3bUw0?=
 =?utf-8?B?Y216V0ZjOFRYNFVHUWVhK0EvY1FiK0FabUlhdFBRSkdPUzMwS0ZTN3NjMmhi?=
 =?utf-8?B?ZHZPV0FYUUZKTTlKSHl6SU5mdWljMjFvZzV5NEhtcGx5dmI3dHlTNHVIbE1r?=
 =?utf-8?B?VVZRR1hFY3UyandKbWZNZFNzYUt0b1VIcjRhWk1SWkJSTG52VWU0R2t6Witu?=
 =?utf-8?B?UnRON1hTK0pVQWR0SDh0WHJrQ1NCczhteVZLSElxOGdhK2liYmR1QTJDbXBP?=
 =?utf-8?B?d1pXM0VBU0VYcTF4bUtlNm5PQStxY1BmbnJwVVkrY21CVG9XL2REVFcySXZj?=
 =?utf-8?B?T3ZqUk50MThkeDE0c2REWnlyYnc4bWtIL1ZRcUFYak5kSXNocUY1TGU2YzJX?=
 =?utf-8?B?WWtNVlBMbGh5eUpNRkp5RlVPa1VSMEJVZUNma05ORUJVV2l2NkM3RXpWR0pW?=
 =?utf-8?B?TUFVLzEvanJwWXpJdVdXU2lJR2dSeHNqWlNZTG9IYzVPZE9CWXg3NjM1R1Iv?=
 =?utf-8?B?OE43bThGamswdmw1dnJyaHYvSS9rcEhTSVJLVlpDcjRwZ3phRlI4cEJZczB6?=
 =?utf-8?B?clhON3Joa2hTcm53NXpFays3UkU1aVlYY0I5QjNaQUptVDJZQ2xYNVlhaGlH?=
 =?utf-8?B?ejB3bWo3NHVxeW13cVZ4ZXc0TFdnYVhUSmovbnpENFVjaVdqa0ZWU1h5MTlt?=
 =?utf-8?B?TnQ1TjYwK0Z1SWNsYW00Q0VUbVZPZXN4VElQSHV0bTlGWHBhZWxZVDdoaGI3?=
 =?utf-8?B?Q1Q2MlZRdGNQQjN5VTMrRHo3R3lwaDBDK1d3WStVUzdRTzdxYk9lVm14YjdB?=
 =?utf-8?B?NXJRckFSYm8rdkxoNkwxRkpNSk9EZW55bHI1RWdHZk8rK1kwdXc2SERUQ2NM?=
 =?utf-8?B?RVQ1a29jRS9QYWZMd3RGQzdWWEE2NXBSanpBV1RQNkJRM2w5QXkzWENIcG5W?=
 =?utf-8?Q?RhLKta0x9BR2JWOaINYciho=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A56024338666A940992D954C882B9A98@namprd15.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fa8b9c4a-a3ec-4d24-d8c9-08ddfc60e23b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 18:25:19.8964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rG5Yv3Yb6nfMTZ43BD4O1MTiOzXs58t64eEgSZ5Kwe9EHAkQ3Dg+6jLgnym44kI+/1M9oPFNUjxFdN+ZoMZfSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4702
X-Proofpoint-ORIG-GUID: Y1B0wCyIbnDCn5ujWDWSymoRxZN36TAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfXwUtp2D8bx2oC
 7ODBVZB6q/BvYcbdqg7gKZo+JiGXV3c4q2tOo0xLR77+sDZ2cwnCXcpqDISOURp9RvYtRCeb7tH
 qAc0beOwEqFtfi7FXySzeLh5lRMXjvsToi+BLDaVe7WgnxGA8I0n82v4lO4uCpe/cWoqAfTrdjV
 PToSNwBB2QvNw6sf4K+eUgkAiWTs+zsyEGndzXDJ612OZgkCyMRX/Rv73GsVLWs5Yt+vDCkXIGM
 OR+VJ/XgdKQCmjqrkW5RpL6Ck9RBA71rkPOOPzULw//1zPxK1BiZU5JLBSpa54UNZsFtCUthl7x
 pGi4LCY65di0QW51yJDkdHbkLtJ6LaHI87q+vduiTI1qNY1J1d4rIdZ57HC5ha6/ur9ckdQvklg
 vCrUjO86
X-Authority-Analysis: v=2.4 cv=XYGJzJ55 c=1 sm=1 tr=0 ts=68d58913 cx=c_pps
 a=NwWuzY5ekLRC++Nx77IK4w==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=BawmRijRzyKGBbuHyaIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: H6Bj_1sC0ncn-RB1WxJKu1q_xUb7mbXG
Subject: Re:  [PATCH v1 1/1] ceph: Fix log output race condition in osd client
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020

T24gVGh1LCAyMDI1LTA5LTI1IGF0IDA5OjU3ICswMjAwLCBTaW1vbiBCdXR0Z2VyZWl0IHdyb3Rl
Og0KPiBPU0QgY2xpZW50IGxvZ2dpbmcgaGFzIGEgcHJvYmxlbSBpbiBnZXRfb3NkKCkgYW5kIHB1
dF9vc2QoKS4NCj4gRm9yIG9uZSBsb2dnaW5nIG91dHB1dCByZWZjb3VudF9yZWFkKCkgaXMgY2Fs
bGVkIHR3aWNlLiBJZiByZWNvdW50DQo+IHZhbHVlIGNoYW5nZXMgYmV0d2VlbiBib3RoIGNhbGxz
IGxvZ2dpbmcgb3V0cHV0IGlzIG5vdCBjb25zaXN0ZW50Lg0KPiANCj4gVGhpcyBwYXRjaCBwcmlu
dHMgb3V0IG9ubHkgdGhlIHJlc3VsdGluZyB2YWx1ZSBhbmQgYWRkcyB0byB0aGUgdGV4dA0KPiB3
aGV0aGVyIGl0IHdhcyBpbmNyZW1lbnRlZCBvciBkZWNyZW1lbnRlZC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFNpbW9uIEJ1dHRnZXJlaXQgPHNpbW9uLmJ1dHRnZXJlaXRAdHUtaWxtZW5hdS5kZT4N
Cj4gLS0tDQo+ICBuZXQvY2VwaC9vc2RfY2xpZW50LmMgfCA2ICsrLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9uZXQvY2VwaC9vc2RfY2xpZW50LmMgYi9uZXQvY2VwaC9vc2RfY2xpZW50LmMNCj4gaW5kZXgg
NjY2NGVhNzNjY2Y4Li45Y2Y5MWVlZDgwMjAgMTAwNjQ0DQo+IC0tLSBhL25ldC9jZXBoL29zZF9j
bGllbnQuYw0KPiArKysgYi9uZXQvY2VwaC9vc2RfY2xpZW50LmMNCj4gQEAgLTEyODAsOCArMTI4
MCw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2VwaF9vc2QgKmNyZWF0ZV9vc2Qoc3RydWN0IGNlcGhfb3Nk
X2NsaWVudCAqb3NkYywgaW50IG9udW0pDQo+ICBzdGF0aWMgc3RydWN0IGNlcGhfb3NkICpnZXRf
b3NkKHN0cnVjdCBjZXBoX29zZCAqb3NkKQ0KPiAgew0KPiAgCWlmIChyZWZjb3VudF9pbmNfbm90
X3plcm8oJm9zZC0+b19yZWYpKSB7DQo+IC0JCWRvdXQoImdldF9vc2QgJXAgJWQgLT4gJWRcbiIs
IG9zZCwgcmVmY291bnRfcmVhZCgmb3NkLT5vX3JlZiktMSwNCj4gLQkJICAgICByZWZjb3VudF9y
ZWFkKCZvc2QtPm9fcmVmKSk7DQo+ICsJCWRvdXQoImdldF9vc2QgJXA7IGluY3JlbWVudCByZWZj
bnQgdG8gJWRcbiIsIG9zZCwgcmVmY291bnRfcmVhZCgmb3NkLT5vX3JlZikpOw0KPiAgCQlyZXR1
cm4gb3NkOw0KPiAgCX0gZWxzZSB7DQo+ICAJCWRvdXQoImdldF9vc2QgJXAgRkFJTFxuIiwgb3Nk
KTsNCj4gQEAgLTEyOTEsOCArMTI5MCw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2VwaF9vc2QgKmdldF9v
c2Qoc3RydWN0IGNlcGhfb3NkICpvc2QpDQo+ICANCj4gIHN0YXRpYyB2b2lkIHB1dF9vc2Qoc3Ry
dWN0IGNlcGhfb3NkICpvc2QpDQo+ICB7DQo+IC0JZG91dCgicHV0X29zZCAlcCAlZCAtPiAlZFxu
Iiwgb3NkLCByZWZjb3VudF9yZWFkKCZvc2QtPm9fcmVmKSwNCj4gLQkgICAgIHJlZmNvdW50X3Jl
YWQoJm9zZC0+b19yZWYpIC0gMSk7DQo+ICsJZG91dCgicHV0X29zZCAlcDsgZGVjcmVtZW50IHJl
ZmNudCB0byAlZFxuIiwgb3NkLCByZWZjb3VudF9yZWFkKCZvc2QtPm9fcmVmKSAtIDEpOw0KPiAg
CWlmIChyZWZjb3VudF9kZWNfYW5kX3Rlc3QoJm9zZC0+b19yZWYpKSB7DQo+ICAJCW9zZF9jbGVh
bnVwKG9zZCk7DQo+ICAJCWtmcmVlKG9zZCk7DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5
OiBWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT4NCg0KVGhhbmtzLA0K
U2xhdmEuDQo=

