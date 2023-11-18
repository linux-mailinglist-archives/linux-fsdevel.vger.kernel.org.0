Return-Path: <linux-fsdevel+bounces-3119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C237F012A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 17:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5C71C2093E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 16:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CCC12B6A;
	Sat, 18 Nov 2023 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MboeJrXc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gNm2w3cC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3045DC1
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Nov 2023 08:40:37 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AIGbJWx026736;
	Sat, 18 Nov 2023 16:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=S4eIuDYjJ2zwxmhwet0ZaqNu8xhmx5JizNGqLw99U0Y=;
 b=MboeJrXc8Ua7EW5DuDVmQ6w62fBH6gjdGzqqtWh/AVnbt5o38yzJYfVwR+/mJiuLYgoK
 6E9Fc5X4DHKyT15xpoLAD3NVK/p5d8TIq6qaCBDRwn2Q88atixIjTVp/Upz34vBrpSr1
 jCycmSmdzLbZSZMuLjHyyR3WmFEWg3SqPUbaf/RITu4OzL7jJZqs57pFXi3OnkA2UVeG
 cirqW2qx3wH8Q1+OPQtbfgNJi0e6T1EQnFezU/Q4YF8Xi3zdDkBeb6lw6M+wBTOnpAR9
 KS4kCB13hw6Zwd3puRT8OXXjj3tunsin90AgYk7HRGECmFCJQ+wEwYVDvWx0eirA/CEz Gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uekv2rhmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Nov 2023 16:40:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AICNwQK037512;
	Sat, 18 Nov 2023 16:40:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uekq3kf5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 18 Nov 2023 16:40:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HssZLKJCCeT1U5EN+6fu27sEXS3ukecQEJP/kSM7SsTKf0+pC3vvkU3+RPfTapojnM3D3SntZEerEFrHMYvRxp2gM4YmmbsDszxyK6vV5r2GET03wHY8oNlS6h7Qgt6/x3omTJzt/UiPdymFIewOU2OEmQCQrKtHoApKCNk2PUI3KIC6OrDL6CPqvXTz7AsF97kRAO6inFV7fjXlaM/lgp5CDhLsxsjJ93Y4XusKcYG61z6MvrCUc0PEgiV+uobiq7WbKkp3mKDnYpvy0p4fbCZ7ZOWJfRb32XrhaYXWkmX+ZoUrY6Hsb3XwhyRgpvw0AaEQboO6hBhd7HLbORecJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4eIuDYjJ2zwxmhwet0ZaqNu8xhmx5JizNGqLw99U0Y=;
 b=KkJ8cQUJw2BG6YlFr7YLWgosuex/JumUwT3Tp+Sj+BFPrz72uYK/DrbsXa500JW6V4e3FilqqZv16s82EeBb387ghY6YPR/FlroPp9tgyLL6UESNE9bC7ggCoKp5XMnXMngL9K/twXuhpEns8nM3SSjUTA31vgmmi9dnUWRUlwLZkn2mUnRuIdlWGsYqf8wSIqb7z9EjBXULX8AGUJcXXRfawNxBj1DVb91/azP5xid2RUnke1phrIz48mdaY/ObQuVax6JicF+CR0e6ZLPHEDKJeMKv5UFwRHj2Gvkv0J+7iVR3+5h4lCZ6mQVlzaGE4NS29tce1p3OxzAqe9ZnJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4eIuDYjJ2zwxmhwet0ZaqNu8xhmx5JizNGqLw99U0Y=;
 b=gNm2w3cCPegUNdDtaibv1XjkQ7wXuenoumWYAophLV4H9QpdFMTqMzE3V6VVEp7qsydrqp8t14UeIdGmw24axB4yWeJCDCEERu4eXufh6d7rNCtWke9BpPhyZFQ2f3hGL9WuIOiZv4KZ7CuWyhoVOQ5GhUY37UgTwkf7dayxSe4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB6714.namprd10.prod.outlook.com (2603:10b6:610:142::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.25; Sat, 18 Nov
 2023 16:40:09 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::360b:b3c0:c5a9:3b3c%4]) with mapi id 15.20.7002.026; Sat, 18 Nov 2023
 16:40:09 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: Chuck Lever <cel@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Hugh Dickins <hughd@google.com>, Jeff
 Layton <jlayton@redhat.com>,
        Tavian Barnes <tavianator@tavianator.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org"
	<linux-mm@kvack.org>
Subject: Re: [PATCH v2] libfs: getdents() should return 0 after reaching EOD
Thread-Topic: [PATCH v2] libfs: getdents() should return 0 after reaching EOD
Thread-Index: AQHaGAGG5PIaD3egr0mYt1u0s1gK+LCASI4AgAADKgA=
Date: Sat, 18 Nov 2023 16:40:08 +0000
Message-ID: <FAD60EE2-83B6-4005-8173-AD6A11AC8D8E@oracle.com>
References: 
 <170007970281.4975.12356401645395490640.stgit@bazille.1015granger.net>
 <20231118162838.GE1957730@ZenIV>
In-Reply-To: <20231118162838.GE1957730@ZenIV>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.200.91.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH3PR10MB6714:EE_
x-ms-office365-filtering-correlation-id: 7db91087-0e77-47dd-d573-08dbe85506f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 zLv/Ht+CpTDxmBho7D0L7O/93G1NoqgnunCwjKjFvhdxotGOkffw07hj4mxmJn6tX2y8jxFEJBYyDMM81lzrMU3hatjcGdxpXiZ9naITUIS7dfqr2fRFYrSuCSOxXusOIfwgKhRz1pGdUM9TFBI38pb5rw1GSDtcDbRnq9aKwxdAUFta0wEKTBxEUo4IaK1sbrY7MI323o8is/ObqDFKxBBAYGNYUWg+M9TgHPNiESunNloy4l51NgFp30qCeaJBUWOsQedSaMWGm4R49kb+pkiz4nlPykP8/VT/ho3EJF80CvUSx3S6wn+PozIFYZYinJr+iMkTN8RykDlDRGK+XXA5zcFDPyShZpdFiDs18WHddd4xrM1jdkHnL1FfQh3X6xVcRAofVYa4oapO7yKD+B+yraLbdaEbYUHAw340A/p+/YvWFEVkuEjFCVXwouSABL1CIuMz+0Bai5g65xSJXE+Ai9H9tfhd4kV6zPPGRzCleOk2SITR0rDae279TiJu/LK1q1R2rC/Mi1MSq/n/Zq6rsQKfJAKTAHAuVDM0aaNm+ujGO2f3kIGbJt4XMtscGmB0Iz5L0ncqeKfdDlePnkSFXwLZHbuZY8D0W1Rpuz4eg/mcjz4ue5ESFlZ3hNiOlM2o+bcOGDJ3jX8UbiXvoA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(2906002)(122000001)(6486002)(38100700002)(38070700009)(86362001)(33656002)(36756003)(83380400001)(6512007)(53546011)(6506007)(26005)(2616005)(478600001)(71200400001)(41300700001)(8676002)(8936002)(4326008)(76116006)(66556008)(66946007)(91956017)(316002)(64756008)(66476007)(66446008)(6916009)(54906003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NlB5TlI0QTM5emRpNTIwYnlQSkZhbTV4U1NIMDZtdnBXQjNwOWRVNWJkRlE0?=
 =?utf-8?B?WjJkVkU1WE82ZkpQVDBWSmIwc1BoSEdWZjAvUTNsZi9HY0l1U3J1S0NvUEJB?=
 =?utf-8?B?aU1qYnltQkY1bmJNWm5ZTERmQ1c5WS9OY1Y5cEIxbVpsSlAzS0RKNC9TWGFZ?=
 =?utf-8?B?aWZOenZoN2w0dk5SaDRLNzVnUkh2UkV2NmE4TlJKMEVQdEo1cmJYaHRpQ2VM?=
 =?utf-8?B?aG5qQ3BLSkIyZnRkZWFraXlQT1FCQnpaKzMyMXFFM2c5c01Kb3lINWhQVkZK?=
 =?utf-8?B?N2kwV0JxNkpsbi9kOERGakQxZkF6Vk05ZkJuT0VzQTBVallSWnVUbjJsWWR1?=
 =?utf-8?B?bG0yeGlqc0ZEZ1NMYmwzWXBoMjBLQnp5UGZ2aFo5Wlk5OVAzd3ozbURuWm1x?=
 =?utf-8?B?MGNFbjdxY3hRdm5BMGtlRXN6dW9TWFVGQzJQbjUzeXA2dkdoTWRBSVVzbEJJ?=
 =?utf-8?B?ZTNqSnZCdDVYbGFnS2VzWXhiczJPWlpFNytub1lBQWZuSXg5c0N5RklvMjQ3?=
 =?utf-8?B?M09Ualk4TUxMVUF2Z2ZyT1lvYnpMd2Q5bTRqRW5RY0ZlelpiWnpyQlo1RFhn?=
 =?utf-8?B?NEVFZ1hLRUNUcFlRRUZDNXJ3WXZTQzg3SGJETG04bG9YbGZMZmQzc2U3cWlJ?=
 =?utf-8?B?c3I0MTJ4WEh4dWh1S0w4M1ZLbzhNekh3RThBVGJac0UzL3dPc2UvNkN6d2pL?=
 =?utf-8?B?K0ZDcGtsNFNjcHdXdGllc2JwUmNkWUN4UW82V2RGRmRia05kbnlCWS9ocVB5?=
 =?utf-8?B?VmR3bjFqT1doTThxSGhaVjgvQlp5Y0M4MnVXZmIrUkZtUlJKZURlNzZ5cVR5?=
 =?utf-8?B?a1pPOXRKdkNrVENvaHJKY0Urc0FSNEtNbFNDcVVSdFpVZzVYcEJHcFlpc0Rz?=
 =?utf-8?B?dHd5T0gwMm9VcWFYMnkrdDRXTzR2UjBlaDRlMGN1bUJaZmVSY2dzL0s2a3Rv?=
 =?utf-8?B?MktiTFc0N0QzNEhIdUZudzVJRDV3MHNFRXhlTlpYZEk5SUczd2hyRnZHOXVu?=
 =?utf-8?B?ZExIdGgzNXVmcis4M3JRS3d3a3Jpci82dHAvVElwbVdIS2JPeVNJQnBFRlcw?=
 =?utf-8?B?aHViQVNSZVJTZDZVTXdpeVlNNTdtQXF6K1BFU0Q1ZmpxU3ZXMjRjeHVjNCtu?=
 =?utf-8?B?NmZjaEtycUdMV1J0MU5DeGJKOTVNQ2NHYmpuZDNnVFhPem1oc1lhM3hRbVBC?=
 =?utf-8?B?d1RrN0hqTjRJV1ZDc2l6L0ZlL1pvZklXS1I0d1FVS0E5YVVaU1pSZVZRWEt6?=
 =?utf-8?B?UGVKQXQ0cGwvU2lQK0lKWHVZSnp1dnRQc09Vc09rdVg2eUdzZDQxTkx0d3Ro?=
 =?utf-8?B?ZFllU2FUazhJWnBZTi9yOVBlYXBGYzM3Nkhlc2Q0TmpUYVdmekVtR2JtSEtS?=
 =?utf-8?B?aldNdU85Q1cybzBBamNFQnJBeE15aStLSGpaNkptR1ZUazI2Y2d2OW9UMmZZ?=
 =?utf-8?B?R0dRMFkrTHhtMTY4VkU0emlaWkhqd050T2lyVmtLZUxQRUc2eVZlN01DN3Fx?=
 =?utf-8?B?d25BbXBmTDB2ZCt2MGtsYmQxUUxSTjFsTFlKQy9uNDN6eS9SSFZDUGhncjNn?=
 =?utf-8?B?OXVVWFhKU2VxUmNFRldQWEgxbFNsblRIcjhVa2dPelNSSWhsVkxxV1pnY0ty?=
 =?utf-8?B?WTZCakZDcldqSGI2RDVxUjhWakJnRHdSeWx1NDA3NWdOOXFYYmxoM3VYekhv?=
 =?utf-8?B?NjBGR01wT0JrREQ5eU54Y25QaGhGVFFLa0IyQ296UVNwOThEQ3RVL2tiNlly?=
 =?utf-8?B?YW5ZYldNQ296MkQ5WVZHWTNiSmcreVM3MWYzNjl1WFZCeGdncCt0Y054b3BF?=
 =?utf-8?B?Q0JNK2o2blZkYnhidlNiRlk0dFlXdFZWWHREbHVIWlU1UThNcHQwckpFazNR?=
 =?utf-8?B?VE8rSExNeVBBMDJhdXVFRi9qMERnTnU1dWNERWw3NDV1bmJvU0RpQ29tOFA0?=
 =?utf-8?B?RVpvM1k5ZWlkdTVXUmJGQmVWL0UrdE55RVRIRU83VytwRnVDYWNNSHFxZWNS?=
 =?utf-8?B?SGlOU05GSUlXWFErRTQrcGZGZzVzcXJnOEtEVkh6UzZUWkxsZzFtVGk3ZC9r?=
 =?utf-8?B?cDk0eFhWOC9kb2ZwMkZkZm5nbG0yWG5DYmpnUHVIMlp2cFhqbTBVYUFLYSs0?=
 =?utf-8?B?ZGQwNUZNdHZJV0VSQ3FwdjRpY20rQlhmYjRMS3ppU3pETmZqZk5xRVNLMkdW?=
 =?utf-8?B?enc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C87FA534F073C4587AB82333F9E7630@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?dXh3Q3lyejJHMEN6L2RpaU00K29ERlBGZ2d0UDd1RUFFeFlGSlhvYmFObUtF?=
 =?utf-8?B?Qnd2R0xCQi9Lb0kyNmVKajFTOS9NdFphWW5vcDM1UzFKbkVhSDNCQlBmenVt?=
 =?utf-8?B?Unp6QldSTVpRbVBEem9Ba0ZQZFVlNXJiK3l1WUdSK3VpbFpuK3N0VUtmUllW?=
 =?utf-8?B?akkzdFJiSU03b3plbzRqQ3FtVDZSdFhpQmVlRVRCQ2dpVTgxUkViL0o5V3FF?=
 =?utf-8?B?Rnk2SUp1MjFFSnpDaDU5Y0hoUTIwSW9XZFhvRUNGVkZQQXpJV3h4bURJU2w5?=
 =?utf-8?B?UWNDZ2hDMTMzWHdlRm9uQWVMeStDazExMGtVMk9aZlJibHpkK1VKbXkwQ0lC?=
 =?utf-8?B?QWgrL1o2UlNKdlJEU21aNEpnVjFqNW9BVC9TVnFKRXhvNjZZUi9BcWNLL2tO?=
 =?utf-8?B?WlFjd3NrczZCa1pPSWdORlIwbWIwNWV1QUljZG51VVNyYWM1T0RneFRhS3Uw?=
 =?utf-8?B?TURBVHljK0pMaTg3NmZjcXcxL0JzUHE2MVB0eDk4dlFOYmhQalN6WDBDSUty?=
 =?utf-8?B?VUt2L1A5WkE3Y2szZy9qajN3VWdJSjFvdFROZjcxTzUxajNTazdYTi9aNkNL?=
 =?utf-8?B?WG5BL0MrRzhQdWlXUnRtamM3Z0FFOFVSNjkweDczRVpMbmtJRHdjQ0l4Z3RF?=
 =?utf-8?B?RWZNbjBzUlFIUjdSWlJmRkdDNmdwZ295YXVZSXZwSnh4ZlBWNXdsOWtZR3FI?=
 =?utf-8?B?anZVeGlGSDhCVVVCL3A1S1U1WUpLOFB5cGF0Z0d1cG5oZHlxdTA5KzZvb1dJ?=
 =?utf-8?B?a1M0TWRlbVJLS2ttenRSUzlZUGV1SjBDcWdGUW1DVXJOYnJsOFk4dVk5czVw?=
 =?utf-8?B?UHVWNVpjYnBBN0E5cjRBbGxtRkhMTDJKTU9MZU5QUUNodUNzVXp5bzIwV2Rk?=
 =?utf-8?B?bTBGUFBwRDF3cW84UEdoaTIzcUZUNFhZRFpaS3kwazhVaERIbHcwR0ZCdk1o?=
 =?utf-8?B?cnZOaFBNdjhpemhsTjdUNWxKbkN0T2IyK3A1TGMyelYzb1ZzejcxaDhhUHN0?=
 =?utf-8?B?bmZ2UWo1NzI3bWx1cE1IMWFwcGpPMFVPTmJqN3VmaU1DUEUzTUJhMVVnZm9m?=
 =?utf-8?B?YkluOThMajBvcW5MdjVYNFo1ZHlON2hiU1Mva3hWSVRPSm80OUp2Mkdxdm9L?=
 =?utf-8?B?SUFHUWxhaXpwL0dVQVRJSjVmS0xhbzFXT1FPbFJCeHpkQUcza1FIamVtQkZx?=
 =?utf-8?B?SXQzcGxBa1VIWTFYeHkzeGN4U0hjelM5WHJSR21pNTRtWXlqOURxVVUySHF2?=
 =?utf-8?B?VUZnRUc4M2ZOVW03cWp3Rm8xT1BSTFdHNG1KaE9WVXNsdmhSbXZiWWJmaDJk?=
 =?utf-8?B?T0owcm1TYWNKSDJsOEhDMWk3eGszVVlJbWdUMnJ4WGhNdzVZaVZsbE1FcXlj?=
 =?utf-8?B?V3ZMMTJFSmFNRFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db91087-0e77-47dd-d573-08dbe85506f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2023 16:40:08.8938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RKeD2D1TyA1EE+2xZsPfgGjssKkVPDVCxAGMRFS9nJJz/n23C1EuczW1lB+v+i7xhwNcrm7+wOTRrT5fzLkLmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6714
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_13,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=931 adultscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311180127
X-Proofpoint-GUID: 5NFekNh84PvrZ8cHqOxN5dHmT2wJIWXm
X-Proofpoint-ORIG-GUID: 5NFekNh84PvrZ8cHqOxN5dHmT2wJIWXm

DQoNCj4gT24gTm92IDE4LCAyMDIzLCBhdCAxMToyOOKAr0FNLCBBbCBWaXJvIDx2aXJvQHplbml2
LmxpbnV4Lm9yZy51az4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIE5vdiAxNSwgMjAyMyBhdCAwMzoy
Mjo1MlBNIC0wNTAwLCBDaHVjayBMZXZlciB3cm90ZToNCj4gDQo+PiBzdGF0aWMgaW50IG9mZnNl
dF9yZWFkZGlyKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1Y3QgZGlyX2NvbnRleHQgKmN0eCkNCj4+
IHsNCj4+ICsgc3RydWN0IGRlbnRyeSAqY3Vyc29yID0gZmlsZS0+cHJpdmF0ZV9kYXRhOw0KPj4g
c3RydWN0IGRlbnRyeSAqZGlyID0gZmlsZS0+Zl9wYXRoLmRlbnRyeTsNCj4+IA0KPj4gbG9ja2Rl
cF9hc3NlcnRfaGVsZCgmZF9pbm9kZShkaXIpLT5pX3J3c2VtKTsNCj4+IEBAIC00NzksMTEgKzQ4
MSwxOSBAQCBzdGF0aWMgaW50IG9mZnNldF9yZWFkZGlyKHN0cnVjdCBmaWxlICpmaWxlLCBzdHJ1
Y3QgZGlyX2NvbnRleHQgKmN0eCkNCj4+IGlmICghZGlyX2VtaXRfZG90cyhmaWxlLCBjdHgpKQ0K
Pj4gcmV0dXJuIDA7DQo+PiANCj4+IC0gb2Zmc2V0X2l0ZXJhdGVfZGlyKGRfaW5vZGUoZGlyKSwg
Y3R4KTsNCj4+ICsgaWYgKGN0eC0+cG9zID09IDIpDQo+PiArIGN1cnNvci0+ZF9mbGFncyAmPSB+
RENBQ0hFX0VPRDsNCj4+ICsgZWxzZSBpZiAoY3Vyc29yLT5kX2ZsYWdzICYgRENBQ0hFX0VPRCkN
Cj4+ICsgcmV0dXJuIDA7DQo+PiArDQo+PiArIGlmIChvZmZzZXRfaXRlcmF0ZV9kaXIoZF9pbm9k
ZShkaXIpLCBjdHgpKQ0KPj4gKyBjdXJzb3ItPmRfZmxhZ3MgfD0gRENBQ0hFX0VPRDsNCj4gDQo+
IFRoaXMgaXMgc2ltcGx5IGdyb3Rlc3F1ZSAtICJpdCdzIGJldHRlciB0byBrZWVwIC0+cHJpdmF0
ZV9kYXRhIGNvbnN0YW50LA0KPiBzbyB3ZSB3aWxsIGFsbG9jYXRlIGEgZGVudHJ5LCBqdXN0IHRv
IHN0b3JlIHRoZSBvbmUgYml0IG9mIGRhdGEgd2UgbmVlZCB0bw0KPiBrZWVwIHRyYWNrIG9mOyBv
aCwgYW5kIGxldCdzIGdyYWIgYSBiaXQgb3V0IG9mIC0+ZF9mbGFncywgd2hpbGUgd2UgYXJlIGF0
IGl0Ow0KPiB3ZSB3aWxsIGlnbm9yZSB0aGUgdXN1YWwgbG9ja2luZyBydWxlcyBmb3IgLT5kX2Zs
YWdzIG1vZGlmaWNhdGlvbnMsICdjYXVzZQ0KPiBpdCdzIGFsbCBzZXJpYWxpemVkIG9uIC0+Zl9w
b3NfbG9jayIuDQo+IA0KPiBOby4gIElmIG5vdGhpbmcgZWxzZSwgdGhpcyBpcyBoYXJkZXIgdG8g
Zm9sbG93IHRoYW4gdGhlIG9yaWdpbmFsLg0KDQpObyBhcmd1bWVudCBmcm9tIG1lLg0KDQoNCj4g
SXQncw0KPiBmYXIgZWFzaWVyIHRvIHZlcmlmeSB0aGF0IHRoZXNlIHN0cnVjdCBmaWxlIGluc3Rh
bmNlcyBvbmx5IHVzZSAtPnByaXZhdGVfZGF0YQ0KPiBhcyBhIGZsYWcgYW5kIHRoZXNlIGFjY2Vz
c2VzIGFyZSBzZXJpYWxpemVkIG9uIC0+Zl9wb3NfbG9jayBhcyBjbGFpbWVkDQo+IHRoYW4gZ28g
dGhyb3VnaCB0aGUgYWNjZXNzZXMgdG8gLT5kX2ZsYWdzLCBwcm92ZSB0aGF0IHRoZSBvbmUgYWJv
dmUgaXMNCj4gdGhlIG9ubHkgb25lIHRoYXQgY2FuIGhhcHBlbiB0byBzdWNoIGRlbnRyaWVzICh3
aGlsZSB0aGV5IGFyZSBsaXZlLCB0aGF0DQo+IGlzIC0gb25jZSB0aGV5IGFyZSBpbiBfX2RlbnRy
eV9raWxsKCksIHRoZXJlIHdpbGwgYmUgbW9kaWZpY2F0aW9ucyBvZiAtPmRfZmxhZ3MpDQo+IGFu
ZCB0aGF0IGl0IGNhbid0IGhhcHBlbiB0byBhbnkgb3RoZXIgaW5zdGFuY2VzLg0KPiANCj4gTkFL
ZWQtYnk6IEFsIFZpcm8gPHZpcm9AemVuaXYubGludXgub3JnLnVrPg0KDQpGYWlyIGVub3VnaC4g
QXJlIHlvdSBjb21mb3J0YWJsZSBlbm91Z2ggd2l0aCB2MSB0byBBY2sgaXQsIG9yIGRvDQp5b3Ug
d2FudCBtZSB0byBjb250aW51ZSBsb29raW5nIGZvciBhbm90aGVyIG1lY2hhbmlzbSBmb3IgbWFy
a2luZw0KdGhlIGVuZC1vZi1kaXJlY3Rvcnkgc3RyZWFtPw0KDQoNCi0tDQpDaHVjayBMZXZlcg0K
DQoNCg==

