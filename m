Return-Path: <linux-fsdevel+bounces-22-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 716DA7C477F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 03:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BF31C20DA9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 01:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B391FB0;
	Wed, 11 Oct 2023 01:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X7msftgm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RB4io2zn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BAF1C2F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 01:52:10 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0865BA;
	Tue, 10 Oct 2023 18:52:08 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AJiXJa002251;
	Wed, 11 Oct 2023 01:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=VpdOsOeb2ZSsJ+7PXBLXlbvv3qU6F6AlXPirCmMARy4=;
 b=X7msftgmbnyEexmsph8NFuzLP3abGaUGoSf7j2tC/SOMqm83wNOcSeyMqeCV9kHnMX8W
 2Fcbpfq5hP6FWwh1kL0ixEkFtqthWLuvCGA4vW7J512GFS6p8Hm5VwWd/4fghI6Jcu3r
 GUtiA8txCZrnvkemRONatd+4G0wn9PcxTw/NI7OgFQwYA4cK7UTgCDA+Mz8Je3HKtZzl
 cXVjpN7sJrJrFmJAtCAvoHa3ylHSW1ohe0q28Oe5qUEExVWQNS+5okdaZL9gu2A/CyeG
 EQr2myqbkEPRfjRrkh0iCM2NyQqg8w8+sm2ngHnH+KFNFCzuxtJWg6RXu0tSn8RozKMM gA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjyvupr46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 01:51:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39ANiQRn014434;
	Wed, 11 Oct 2023 01:51:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsd5nwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 01:51:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWcsHm2yL1Db7YcDm1AFzzT8ToZhOHGWEmf6iGrYgWDed0ZP0BHBn2KHaFg9fByRxMWnxZR9BGKLnJa4k74C9qHes/aQ4vebbeU1778TYa1RugRXs79x2AfsyOkMXAiqfx1Il0C1rXFRdepgIyHn/APoUwc9hFy/tu3VDBbOiQDm34ch0W8lzxzndo1c2awIvb4RlpJsxT7ZAZ6nNUGLEedK8xgta5CSPwVV1xMTUzm/J4OWW2k75wW/cGhfytYQ1Lf9nU/NwjuLRxmKt1NzHe6x974htd18lnNDYYOdGYRfOq5N+wE62anCXUg9lFmVA/00K0JEqVwbn0xYfHXvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpdOsOeb2ZSsJ+7PXBLXlbvv3qU6F6AlXPirCmMARy4=;
 b=E58kvxHyvP0lnvBHjvUpt8WxODVq6edEAmJI5IpRX+FT4CHX1jyF46LjrPt6FNDWe333ugMSRUVeELuheOlc+4djpSqoVKRiYxQgL2N5G05XMaaZxJ8J87jC3Uw+O05pd3GKw/HQv3cmDsbNVqrKmP/ozAM2t4uErrQcubnVk4Cp+3NoVZ8QJw3dDwX2Y43h4dlF1+RZkwj1kXxM6XqzMTRh835eo+6fhhNEYqNglb2odehFQG5wVSoNvKYI9jM9qitPc8hU7Y2L0Z/mdYDqC0qSA5pvjESdOTFk4f4yPCBZyi5Y+pWWcZcFzufdjBBfGYUU4EuUugsKWXtccL2iiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpdOsOeb2ZSsJ+7PXBLXlbvv3qU6F6AlXPirCmMARy4=;
 b=RB4io2znruV1xug2hgFHP51NaVSQ58xiFu1q6rae0TWKlYyKjCrv6U5mxwq2ezO3np5QVaozIkilg4fMWomRppWevmtrW7TQfp+LxkD/6m94MlpwWZ4QAArsTHocwvoh4Qc8Fs7/iqfAELJAKpVrI9AJCKEjrnOZ6HuAUN6UAUY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6258.namprd10.prod.outlook.com (2603:10b6:208:38d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 01:51:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 01:51:43 +0000
Date: Tue, 10 Oct 2023 21:51:40 -0400
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mm: abstract merge for new VMAs into
 vma_merge_new_vma()
Message-ID: <20231011015140.arngzv47bdyyzfie@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, linux-fsdevel@vger.kernel.org
References: <cover.1696884493.git.lstoakes@gmail.com>
 <8525290591267805ffabf8a31b53f0290a6a4276.1696884493.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8525290591267805ffabf8a31b53f0290a6a4276.1696884493.git.lstoakes@gmail.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::19) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BL3PR10MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 008f7d50-e9c8-452d-10cf-08dbc9fc9ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	L13SocU06EfvFA2G8Vb9iNlggRpDRwHNVv2GAsNuCMzeYYh1QMpHx0wsmCseYYpEAivVKkATD655oUfl+EYp5O8qKowHx3cmHjhLb2aHq9WXC2C40rmXNVNQtg1fKxjFtfkOi00MU+9/tY8NHt5FSapQ8tUQp/+Evfi/ZU85p3hvtxHI8cvnCNc7cQ6Fko6ak+Ykzt4/DTyVAQTPVG6+F942POM++YauKzOIRItFQ+GrjXDrmqYoXLsavuSQdFL7MZkxbW3/J91kIl0ncw74TLD+si1HliiGr96mw2Aw7qYMeghDekP4+Qnu98+jMM1l8uZ/hJ7eGA0CLrrVBpTPhKI+TxZIoRxyyPEYpfEh7o82dacZAmKFB1ORsjRuvzJZsZGnpJUwj0QfBHbtWb32PgrKh+1lilVuP4a9IBaRup5HaQsaF2i7kkw7fNamxPLk2GJbeOIRb1ncA6B+9tml2tNUr0dNTTYxyiMlQjOcfIGuo4xhZFcDNVM67GIDYlxAsuY2PB4MaTrrBJhaFjn40xj38hnoGsY4eekJzq5lwJ9RVBjCX1MQ040yYzmCgO4/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(86362001)(33716001)(38100700002)(9686003)(2906002)(478600001)(6512007)(41300700001)(8676002)(6486002)(5660300002)(6506007)(4326008)(83380400001)(1076003)(8936002)(66556008)(66476007)(6916009)(316002)(54906003)(66946007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bGphTS94ZnN0aVZ0bFFSSGo5OEczQ2NabDBRTDZxQ3JWK0pEaDBucjhMeU9w?=
 =?utf-8?B?TnNTQW9zVThPNjdQTHAweERYNnltaUFPVktCTjhwMzF1VFhLM1BRN3RUUlV1?=
 =?utf-8?B?Yys5MHVHZHgwWXowYkQyU0RLdkVaWXViWkVycGRDdjBsemFqS21tYzVpQTVJ?=
 =?utf-8?B?ZjZhNC9qQTdmT0hOZllXY3VrbE1hMG4xSEY5L3VkTXNvWEFBNkMxS0krRDlR?=
 =?utf-8?B?ZUp0dk9TN3JZVmlva0xYZGdMZTdzMUhGMzhDZjNWWWZaREZhR2R0UlV2K1Mw?=
 =?utf-8?B?SmF4bnZxaWNMRmF1ZElXL3FrZktrbnIvaGNSRzNpS2hGOTlrUFZ0a1FOTkdo?=
 =?utf-8?B?TWlkMlR0d2dKdENzSmNYcmRGMXFHdk4yWHhISGhDeXp2OEFKOW4wZnlsZ3R3?=
 =?utf-8?B?SlJiZFRtVEVRdDExRURDQnBWa2pGRnhXY2RxVllOd0VQaUZGNnRHaU1tRGw1?=
 =?utf-8?B?TkdIRUloSXNsYm9GakxOcitrL3dISXJUZjNyUGxVYlQzM2VEc2Q3WE9odGZo?=
 =?utf-8?B?WkVrMzhscDZlR2JGejRIMkFKWWxCcjljZW1teG9Rc0dmMFYwWUZjdEpjSDMx?=
 =?utf-8?B?a2ZRdStMSHh1ZVFyaVN1S1hBNVRDbWFQZENPWWgwbWFBSVVmZnNuZ0VOY0tk?=
 =?utf-8?B?dXkxWDNlZnV3d0VyMmk5TzVNQmZEZmh0NVREVytNOEFEYTZFek9LN1NwSGtM?=
 =?utf-8?B?MVBRYTN1RDUyOVkrSjhqdUhKb3EycjZYTzdYY3NsR0RjUG9RKzQ5bFJnTUZv?=
 =?utf-8?B?WDhMM3pMaHNFTlpTbDJhUDM5WkV4NU1tQU43UUF0QWNNazNIKzV1Z0J3c2s2?=
 =?utf-8?B?Y282Wm5GWU9YWFc3SW56MTkyWjdlT284WDRFUC9KSjR6UVBrdm9IcUlrUkp0?=
 =?utf-8?B?QUg0MEFmdWlsMFVCVDZiOUZTNkJod2JKVW1VNXZhdHlKYVhTaGhubXNaWmhH?=
 =?utf-8?B?d2szWnQwbHl4MFd2ZGV6WENtYnRpY0ozZy9mZU5yblBaL1B4OElvOWdFMkxp?=
 =?utf-8?B?OUd3VXdDU2RJcGNsTzBYNTFneUMxUWNUWlphMkNCZjRZWUQvZnp6RnVUb1JY?=
 =?utf-8?B?QlZoa094NDZHUUgzcXRBalFWL0swMmZTV3M4NnpBd2doVm5YZnNzNUFiaTUx?=
 =?utf-8?B?bUxBUHBqOUQ3bW5sVW05YXh1UlBlWFo4d3lTT3p3cFp0NFZMdWlCYTBtdnM4?=
 =?utf-8?B?aUhDby9YMTZ5NmRQalIwN2ptbW5FU1JadlNzbFptSEp3WVgvR3lvaGtwUURE?=
 =?utf-8?B?TFQxVlU4eVhmTTB5dE1iSDRJdjU1Qnc0dllIMnFNd0xXTXJlMjlzWFowaS92?=
 =?utf-8?B?QzNsT0NQQWZiQVRYOEliOGRnemE3cmpNWElndnpnVzNTeGxUWlNtemx5UnpS?=
 =?utf-8?B?RU1EdExETEg2UXViZytsTVArT2JuQU1zVVVYOHdRWWd3akdrZFdMeENHckRz?=
 =?utf-8?B?OGRBbnZZMTNBYm1lY2ZBU2Z1QkUxU3hQNWk2RS9aQ3hEL1Y2WmcydENSSUtu?=
 =?utf-8?B?N3oreGZDN0I5aXllR3h3NU9mVlJXSVZraEtjeEtwS3AxVDBSb0w2U09RZHE0?=
 =?utf-8?B?K0gzNXJxNW9CeFkrUjV2YlozNjNFQVpEVXRTK3hFNThQVTlydnRzV3Uvajd5?=
 =?utf-8?B?OXhuaHpSTEx1MUF6K1JDUFQ2UnJOVlJKeUJiOVYzQVZtZEFVU2U4VFVaSVc1?=
 =?utf-8?B?em1DM2k4NE1ZYm1CUVhkbzN5TWk3MW5GbmVKVzVBdE82dWd5c2JwU1dyYng5?=
 =?utf-8?B?dWk5MlkxeE4yZGM3Wkoza0JhNkU3Z0s1amdneXhpNFJmY1dmNXBocHY0MFlP?=
 =?utf-8?B?cmQ0clprSjBnblVndG5ZVC9RNlowMTFwNFdqR05lN3pBcFJrVGQyNTJzcFhk?=
 =?utf-8?B?dXBJTVRZNDNtN3QrUU9lcDBQaUY1bm54d2lJcDF6MTRFVTJpemZ6Yzhmc1NY?=
 =?utf-8?B?S291ajZRQmh4Ukp0YjdHMXJjVE13OFZRVHhFUTJWRGhZOWViOHY1a2FoRTRi?=
 =?utf-8?B?RnlSMDlxT3lUZmxEOHNOaTRPeWY3M2t5S2xGZTJPRFNmMy9SL0lWTnVNbTBB?=
 =?utf-8?B?QTZhYUtLY0FiR3VoME5qaXJqSm5qL3gxNkFaZjlVWmZBaUVUcDZXWW5uTFpM?=
 =?utf-8?B?VlpieTh2bjNzdWt4bFdjcEMwZnplVWZ1UVRaV2NGTCtmaSs5OGdidHdwbXR6?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?QUFHRE5rQldKNHBQNC84L1RJZDd2NERPaldyTmFPYTFkNVpqRnJGSURKZTJz?=
 =?utf-8?B?TUdqeUd6WlJXQXpDZW9SekJURkNsTmdxWDRESjVSdDJmclJ3VDNSNjVQS3JN?=
 =?utf-8?B?OVlvTWJxRDB0UExJaVkveG1hR0FrSS9rVThaK0crWjJXRk9YaG5rdVE4ckFh?=
 =?utf-8?B?b1VTT3BNYzlNUVowRDN0NWJIckRhMThnTmowOUlTYnFaUTN5MUNlaE4zYzVw?=
 =?utf-8?B?Sk9WR2F6eHBIQnZMbER1LzEvWlE1RExXcElYQW5ncS9BQ1N2dExJd2FudDQ0?=
 =?utf-8?B?dWFXUkt6ZExtc1JDdng4YXJZUmM4bWhTa2cxMlRaS2loQmxQVVVkeGJvSUdV?=
 =?utf-8?B?aTJtOTRBRTlZZS9RL3NFQ2pXSFBETnpOV3hFUzZVd28vU2Q4TWVlTUtQSitr?=
 =?utf-8?B?bFpZSXFoVlljSUJQSTNrRWhrSGlQNTMyU3FCWk9OZ3pLak0rY2V3YjgweThn?=
 =?utf-8?B?NWFWSi9LaklSSGozb3lMTU1ySnlxbUhRY21kOThHem5FOG1NTmR5K2R3SDR2?=
 =?utf-8?B?RXFzcUFiVkZWY0htSitlOEZPeW9UcGZJSS9UYTNOVW9iYjY2ZzNvcUIxb1Jm?=
 =?utf-8?B?bWpUZ3NVTDBGMFJ3STVqdnlGR0pTK3AxSm1sejl0Rkt5UjdORmxLRldBQWNo?=
 =?utf-8?B?YU54K3p0VlhkOFgzT1hRL2hEOFpSa0VDNGU1b1JtZFhiOVNveDdVaG11Lzd2?=
 =?utf-8?B?bWM4d3dqZGsxOGlGWHQ0STFxbDRmbHd6c01BN3pHRXFycVkzZE1ZSE16bkZq?=
 =?utf-8?B?VVRzSEpSUVFQdjU3UllKUnhiYVd1RlMxNDlpR2llMkhnK2EwRHVlc1BWWjBD?=
 =?utf-8?B?Mk1JZmJ3Mk9mRWlkZXU3TzIxZEE2VThDLzlRZzJhTytjT1RncktvZzhHSm4z?=
 =?utf-8?B?cXFiMnhkYVllanM3eVk4dXpDWktRb3NpWXJ3UjFPWGhTaGtDcXZBUzdHS2VE?=
 =?utf-8?B?WHdsOUwvRkhJT3N0MmxHcVI0ZTJkM1hVYUFtQUxVVjcrMnA4bEJNRk5hMmE3?=
 =?utf-8?B?N1U2Nkk4ZHE4bGNjdjlmRkRUeDhURUNYUmtqWEdTUnIrYVN0dC9VYWFiS0VU?=
 =?utf-8?B?dHpvTzgvbHRSNktWV2wzdHgrb2dTaFhRbkpTMisrNUREZ0xTcnBjZEtxclRC?=
 =?utf-8?B?VEx2UG5GQW55U0tJdWN5MWRHWlN4QVJwdVFPU0xHQnpseTlCWjNXaWlrSVdT?=
 =?utf-8?B?R1ZSVC8zWEE2WVNoL0pyUVN6cStGV29DMFZiaFoxQnJrbnRsaVFra2o3K2dw?=
 =?utf-8?B?NVQ5WUNHZjhDRGJpdUJhOGJMaUVBUzBUeEFVQVhxTER3OFAyUjQ2RGREZFJK?=
 =?utf-8?Q?UY3s8b5UDcw1U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008f7d50-e9c8-452d-10cf-08dbc9fc9ec0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 01:51:43.7764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEsfbpM3ASkqBoSRiM56X3nlUkhl7DG26J2peVD5DtIVBjUGOS0UG/Lx3891uDJ8kwZWSVt1Vhna2hH0VQJLog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6258
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_19,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=926 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310110015
X-Proofpoint-ORIG-GUID: knl4WPuuBihT2ORrjrlMZp_F59lQTc5i
X-Proofpoint-GUID: knl4WPuuBihT2ORrjrlMZp_F59lQTc5i
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

* Lorenzo Stoakes <lstoakes@gmail.com> [231009 16:53]:
> Only in mmap_region() and copy_vma() do we attempt to merge VMAs which
> occupy entirely new regions of virtual memory.
>=20
> We can abstract this logic and make the intent of this invocations of it
> completely explicit, rather than invoking vma_merge() with an inscrutable
> wall of parameters.
>=20
> This also paves the way for a simplification of the core vma_merge()
> implementation, as we seek to make it entirely an implementation detail.
>=20
> Note that on mmap_region(), VMA fields are initialised to zero, so we can
> simply reference these rather than explicitly specifying NULL.

I don't think that's accurate.. mmap_region() sets the start, end,
offset, flags.  It also passes this vma into a driver, so I'm not sure
we can rely on them being anything after that?  The whole reason
vma_merge() is attempted in this case is because the driver may have
changed vma->vm_flags on us.  Your way may actually be better since the
driver may set something we assume is NULL today.

>=20
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  mm/mmap.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>=20
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 17c0dcfb1527..33aafd23823b 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2482,6 +2482,22 @@ struct vm_area_struct *vma_modify(struct vma_itera=
tor *vmi,
>  	return NULL;
>  }
> =20
> +/*
> + * Attempt to merge a newly mapped VMA with those adjacent to it. The ca=
ller
> + * must ensure that [start, end) does not overlap any existing VMA.
> + */
> +static struct vm_area_struct *vma_merge_new_vma(struct vma_iterator *vmi=
,
> +						struct vm_area_struct *prev,
> +						struct vm_area_struct *vma,
> +						unsigned long start,
> +						unsigned long end,
> +						pgoff_t pgoff)

It's not a coding style, but if you used two tabs here, it may make this
more condensed.

> +{
> +	return vma_merge(vmi, vma->vm_mm, prev, start, end, vma->vm_flags,
> +			 vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> +			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +}
> +
>  /*
>   * do_vmi_align_munmap() - munmap the aligned region from @start to @end=
.
>   * @vmi: The vma iterator
> @@ -2837,10 +2853,9 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
>  		 * vma again as we may succeed this time.
>  		 */
>  		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
> -			merge =3D vma_merge(&vmi, mm, prev, vma->vm_start,
> -				    vma->vm_end, vma->vm_flags, NULL,
> -				    vma->vm_file, vma->vm_pgoff, NULL,
> -				    NULL_VM_UFFD_CTX, NULL);
> +			merge =3D vma_merge_new_vma(&vmi, prev, vma,
> +						  vma->vm_start, vma->vm_end,
> +						  pgoff);
                                                   =E2=94=94 vma->vm_pgoff
>  			if (merge) {
>  				/*
>  				 * ->mmap() can change vma->vm_file and fput
> @@ -3382,9 +3397,7 @@ struct vm_area_struct *copy_vma(struct vm_area_stru=
ct **vmap,
>  	if (new_vma && new_vma->vm_start < addr + len)
>  		return NULL;	/* should never get here */
> =20
> -	new_vma =3D vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags,
> -			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
> -			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +	new_vma =3D vma_merge_new_vma(&vmi, prev, vma, addr, addr + len, pgoff)=
;
>  	if (new_vma) {
>  		/*
>  		 * Source vma may have been merged into new_vma
> --=20
> 2.42.0
>=20

