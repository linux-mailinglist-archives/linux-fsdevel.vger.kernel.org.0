Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD044629E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 02:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbhK3BqF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 20:46:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:35250 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229779AbhK3BqF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 20:46:05 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU0dunN025319;
        Tue, 30 Nov 2021 01:42:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GSZwckSjepKJ01CysezlmItPbmdcES0npIWsX/7aZxY=;
 b=jwNUaTNblReCCOuBbx0eAwDT6G/Sr8k3V3CrGVBGiBwG24Ul3sSAvkaj40VlJ4BK1uQW
 i2JejSWwHSXKheGbhy+ujObzDs7xWSiYF5byfUqNV6WoID8HKH/MjBaw7aF4M0CO8/8F
 QVoPqgUDqWTpvkhTA88F0NNysoWDDXts+W07FDHJ1AqstVeT/GGyGt5moyMDMgKRFRpu
 7zOZdvYpBQTNkmjmmrIk2z8j6aIsxpy5AqXTrRyPv40GLAjuJdgemcRVf8B1+h/vVRW6
 k07v3ddRcUS8viZjSq8w3zwjNIdRTywwgPvr0qH8ttLyDsNskqSQjh02zvFSp7Y96KQR PA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmueedsca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 01:42:45 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AU1a66i040199;
        Tue, 30 Nov 2021 01:42:44 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by userp3020.oracle.com with ESMTP id 3cke4nhbk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 01:42:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZM5WvMNqxwjvbNSweS0Df/LN5/G2bUg683Pp+GOBeM/6LOr+G4wp+fwP4FGUX5qnF2HilAbCBDIeDTGaIlxuRJtSkJQwgEgeFoNeFOcnZem4HLUagdJq+anRp4utOU6Dwd0L66lL7xFVgLa4K+sgEHKc3DMo5F6Yu4zISLhpP+QYL4UewEbXWoSf7ymI48YhjNvN10fKcIz+vkLzpQwnquRE005a66Ep/zEkpfaPlXfh3+Wf4XP5IaTFvh1Ox710ANh2PeW0jEZAjd/vqscs4pcVzgexyxS+3XKnKHTFbvRd4rC8ZoGydhdkYcUWPe8i2K8oCP2dYAknS9pt0SJnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSZwckSjepKJ01CysezlmItPbmdcES0npIWsX/7aZxY=;
 b=deD2EPZ2GZZENe5fh3re7yAzEyi0llR261c+LlGzbrsBJny+K7RqVoX61t2eD5yXHuOawJDd0rrz1Tz+ymuLyE0gdNqLzk0EmEjDs2JNQ1qn1qk7Xifbe3OOgEIBNhCslkufQjfWTCpkc2IsljeBBlu5bFscr8RVJvZt9owUL+OxOwrDuyLg0bCeh00cX4u6paDXxyAlKkbIsO4AOirpdREwIJFBhYCDuSUlAnoInytF2pUUrfjG7Qu28Q3Yy/FQkfCtfiFE4zTadxM5iJF8sIgLYfTJW8r8Z/vF/vNq/lld1SCJpphhzpKUx58Gl5K95MCEfIMHaaTjqStk5hMU9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSZwckSjepKJ01CysezlmItPbmdcES0npIWsX/7aZxY=;
 b=CCZsDEl2sfmc6FKE2j3DTHWzXJleIK8eOa9j0Zhtur8tWSBBP2LgUMbxaKjF/l9RMm/C9KtcLVidydY/1yaStEYK0KeHBACU2To667TFmoYDClbtN0Eabk+qn6DZLrdXaorjslSVCb9frNaVCdoEH6AnokeRWkIpGk5y9OGrP3o=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3607.namprd10.prod.outlook.com (2603:10b6:a03:121::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 01:42:41 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%8]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 01:42:41 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Dai Ngo <dai.ngo@oracle.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Topic: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Thread-Index: AQHXtMzhlpWZW1OG5ESdBSdOgoHETqu+oymAgAANi4CASGLiAIAA/bOAgAA+8oCAAD8yAIAALy8AgAZzIgCAC+1zAIAABPIAgAARGgCAAAipAIAACTgAgAAabACAADKYgIAAGWS/
Date:   Tue, 30 Nov 2021 01:42:41 +0000
Message-ID: <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
References: <20210929005641.60861-1-dai.ngo@oracle.com>
 <20211001205327.GN959@fieldses.org>
 <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
 <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
 <20211117141433.GB24762@fieldses.org>
 <400143c8-c12a-6224-1b36-3e19f20a7ee4@oracle.com>
 <908ded64-6412-66d3-6ad5-429700610660@oracle.com>
 <20211118003454.GA29787@fieldses.org>
 <bef516d0-19cf-3f30-00cd-8359daeff6ab@oracle.com>
 <b7e3aee5-9496-7ede-ca88-34287876e2f4@oracle.com>
 <20211129173058.GD24258@fieldses.org>
 <da7394e0-26f6-b243-ce9a-d669e51c1a5e@oracle.com>
 <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
 <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
 <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
 <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
In-Reply-To: <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 913646ba-8c08-4763-5aa5-08d9b3a2b2c1
x-ms-traffictypediagnostic: BYAPR10MB3607:
x-microsoft-antispam-prvs: <BYAPR10MB3607CA04FF6F0F48A2D85B8793679@BYAPR10MB3607.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V1dq1uLlDSjxVg5cxvubHG10wGtKJdXALWHuoaAoN4w1nvICI+Tfjfkx0ufC7E0Ooj/UE9O60Whyvrs6CQCj8Jn0UpWHt54OfeGrVlK+CMiqDKnr2PdM/i7DIGfd9VeEQYtXU2bK7RqKw9jgbta2MsMZpG0fermPJ9T0140/Ndn0J4aN39rfcS8KJC8QI8NDHzY+1X+Pcmx0a+r8cNAfhElmh+L06W3gUqgVDOt2nhIYotnn5pyFCA87xy1qGYLA/QojYZlC+hTAFwtzIwJLCS0mZBwl1EN9RL9uhfliMBaBnV53IUIVUVzfPfMslGjZjQ1LbSbgAr5RIA9ikif3u1Lv8yPVsDrO6ThUXodxIEcMoKresbW/KR36P2cY6B5YxxxCJaOz/RXFBytW3hMqSSQICq6n6KiogvAsZQGvmIeWtjbjSKjFSnprReyYiWFNHW5z8OcxvFdFaduyhA0LimagDNBYVcSS9BjOwEy/NvspEME1GEgc6wKwFRcN2+bG1HzE0nVmLCH/l1L0B30mtEChkear1OsF+UnxA8eeExrUlU2kBFADJpj8x+ijvWmaFFPmtoRRltEBnuO5v+md9+l4jyRhBQebmSKKrIbwAy2xv/hRRMMVU6Aq34DhKx0zW47otXsESTZ6GTKyf9yDjMBXkVDAYBohSnGIUgUn+y/z9NuGukrKJCrCSC/39RnFIXI1+XcMm8+1e171Ae2pblcY+fTAlOVEVIwVfxYEQIdh9n55cmVA5yNGza7N2qIK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(64756008)(86362001)(66446008)(5660300002)(71200400001)(66556008)(2616005)(66946007)(91956017)(26005)(76116006)(37006003)(66476007)(186003)(36756003)(38100700002)(122000001)(53546011)(316002)(6486002)(8936002)(6862004)(4326008)(6506007)(8676002)(6636002)(2906002)(33656002)(54906003)(38070700005)(508600001)(6512007)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmVTSGl0azZjM0U4WGFyM1orcU5wd3QrWkRXL3J0TEpWUG1uSjBTVmYrQVcv?=
 =?utf-8?B?YjZIYTJ3NGNJUFdQbkpTR3VxZ09qSy9zaU1PNXVJbDY0V1oxQ2wrVHhGTTBm?=
 =?utf-8?B?Zkl1MkRob1RySHB2YWcvMW9JUFdXL2tBN1UyNVVQOFF6SUExRFhFYnN4TUhC?=
 =?utf-8?B?cm1rMlUwMzZkYnlsSkhtSjEyZGRvK1NpVzNnU1ROUXRSbDZPMk5LNnZ4aTF0?=
 =?utf-8?B?dzNVRU5Wd0FYQ2M2ZUJYSVJLQkpyV2twUlIzWCtWTG1QNklYT05abmU5Sk5X?=
 =?utf-8?B?OVh0dFJxMzZ4cXlsL1JML3cyRmE0Ukdzdm1FdVdnRUZNUnFBL25wZ1grT3FI?=
 =?utf-8?B?Q2xsU0NzbGxNN0FZQlgzbzQvUCtJb01zTWRnN0Rja2N5Y1NaYi9JanlKenVr?=
 =?utf-8?B?K0NpNVNJWkF0ZVU0WnUvYXZWMDVpc2s2RnN0Z25SU2k0NUlRY1AvR2k1ZnBE?=
 =?utf-8?B?MUJzcHZmWUZIa0Qzd01zRW9rMUZOSGRJSC9IVkhYYllxZnZUTWQ0WDByODht?=
 =?utf-8?B?OWN2cDhwZEVabVJwU2FYTUp2cGpuK0xqS2xnQmxuR3pjeDVVbTIwcWltRlpk?=
 =?utf-8?B?b2ZRUjlBMGt2V24wU0RFbU9kVjdFdFNRUDhRM1RscFR6SElYSktFY0UrdTV4?=
 =?utf-8?B?TWlVVkxSTHQvSklhSlN3NUh6R2piWGR3ZG9XNUk5ZUNTUjh4NXg1c3BNWmM2?=
 =?utf-8?B?TnkrQmQzMFBHVVlTdjMwdS9nN05NSVErbHFCZmNCczBUMzJybUE1SlRZaS9H?=
 =?utf-8?B?U2JMZFFQOC9XMG5ONVRDOC93aU5LdnFCRFkrTURvVHVPdWhTMHdwZWI1YnNs?=
 =?utf-8?B?ZW1ER1B3cnFrNjZpcEtuOEUySEN4YTZiL2ZFRU5PNmd5Q08ySWdSNW5UVEZC?=
 =?utf-8?B?VE5EaTA4TkRxNitCMnA2WTJ5TE1ySUpIbTdwRFFHZHV3SzVRZG41TUJ5YlhX?=
 =?utf-8?B?M3lVazM2L3RDNE1xWUh2Mzl1Z2FFcHdHQkhMTk8xYVliREE2U2ZZWmVoV0lo?=
 =?utf-8?B?Ny9YTHVkTmNSTE5pUGlzMkNTbzRwb1R5NGpZUURCai9PZDBFT0lYV2dtZlNt?=
 =?utf-8?B?ZTdtSUJLY01DblN0cU95WExHYTV2VTUxTHJRWXdQVEU3OVZKWmFPOHF3dldx?=
 =?utf-8?B?TDZsdkt5a1FMOVV1SnJaZTBpL3gwSDJrU2NvVXc0bXdQdDZiTGUzSUdjWjFk?=
 =?utf-8?B?Sys0cHUyQm5XVmtjVE1HcHM4VFlRcmJCM3pLanRDQ1JxTHhiS1JpaXZrOWJi?=
 =?utf-8?B?MGFDUFNoSUtJcmhoYjhrMGwwVFpkTW5pTzNUWHpRQTB0NEhPa1JRRUN2WlQv?=
 =?utf-8?B?bC8rOTg5K3hVM0VFYVFyMEFUWVFqTmwvWDhLZWNVdm9rVlJaeVV0VUd2dUQ4?=
 =?utf-8?B?MUN3LzF2blY4ckJDWHJXMi85enBSbW1zbGV4eUx5YThxTDdjOWtTZGY5MU9E?=
 =?utf-8?B?MFl0dDlKbVgvV1RkNTlBT1d3blJmc01PL3hxU0FKMHl5NmNpM3dwOEtMakc5?=
 =?utf-8?B?UnJ4SGFISFZuUkVGcXZHVzlINHFXd2NMakx0RXJpSHdBdGlPQXdRSmppSHJP?=
 =?utf-8?B?QnlKSG1saWI2Rms4enhIQ0RMYWdIdGlkKzlUT2NIY2VoZG9WT0JMa1duSjVY?=
 =?utf-8?B?QTUvcnJ5c0VLYWs3UGJlZ0ttUjBwbHNmR0RUWjRXTWRWYzYxSzJ1ZUhzU3E4?=
 =?utf-8?B?bDBXT040elBFOEdHalRWdjEydGRYQnJtUW5ZQWg1UVQ0OG5KR3VtZlMwTDR3?=
 =?utf-8?B?dVV2NDFVc1FBOHMwSHlxSlR4eHZNYzNmNHJkd1R0UUJuOXZMMEtKc1dIZmJ3?=
 =?utf-8?B?Vm5xK0pLQzZZNnoxY2MvQ0NaNDZOUGtZSzFaUmpzclZjZE82d2REVFZPMHpW?=
 =?utf-8?B?dTBVbldyME5YZTk0ZTRqWUtSWGw3RmR1NmpIZFJHR0RldXhwTk40VjdIaXd2?=
 =?utf-8?B?WmVpaUdyYlNpUEt5TGlBNEQ5UzdjL2FqQU1XMXdPNFhHWEd1eExiK2FNZkVw?=
 =?utf-8?B?U0ZSWHZOM2g0eHVIWVYvR29Ob1h2bXpIcFBQaWJtREsvd1diWk1NSjZQT09G?=
 =?utf-8?B?SW9TUVExQlVkUDcwbkVIK1BHbCtvdHoxTWc4cDRwV3hsYXlOcEdMeGlwdi82?=
 =?utf-8?B?Q2REVjd1MTh5cEdTUmxHSHJCVFk3YnFJL3ZFbURQNVRZK1c5SnI3a0o0MWQ1?=
 =?utf-8?Q?1BrdD4mI5GdKJnmmvfz4LZk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 913646ba-8c08-4763-5aa5-08d9b3a2b2c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 01:42:41.3521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4AYCzeJ4emBO6EEPWaomUr0PbRyWAAHIuqEYm35ljcw2vEZoGhTLSDYpXri4NalX91VM6vUSijVXLLwx195Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3607
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300007
X-Proofpoint-ORIG-GUID: 0fgqpOzfXHrt07UbqnirgvVqEeGTW2Or
X-Proofpoint-GUID: 0fgqpOzfXHrt07UbqnirgvVqEeGTW2Or
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIE5vdiAyOSwgMjAyMSwgYXQgNzoxMSBQTSwgRGFpIE5nbyA8ZGFpLm5nb0BvcmFjbGUu
Y29tPiB3cm90ZToNCj4gDQo+IO+7vw0KPj4gT24gMTEvMjkvMjEgMToxMCBQTSwgQ2h1Y2sgTGV2
ZXIgSUlJIHdyb3RlOg0KPj4gDQo+Pj4+IE9uIE5vdiAyOSwgMjAyMSwgYXQgMjozNiBQTSwgRGFp
IE5nbyA8ZGFpLm5nb0BvcmFjbGUuY29tPiB3cm90ZToNCj4+PiANCj4+PiANCj4+PiBPbiAxMS8y
OS8yMSAxMTowMyBBTSwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOg0KPj4+PiBIZWxsbyBEYWkhDQo+
Pj4+IA0KPj4+PiANCj4+Pj4+IE9uIE5vdiAyOSwgMjAyMSwgYXQgMTozMiBQTSwgRGFpIE5nbyA8
ZGFpLm5nb0BvcmFjbGUuY29tPiB3cm90ZToNCj4+Pj4+IA0KPj4+Pj4gDQo+Pj4+PiBPbiAxMS8y
OS8yMSA5OjMwIEFNLCBKLiBCcnVjZSBGaWVsZHMgd3JvdGU6DQo+Pj4+Pj4gT24gTW9uLCBOb3Yg
MjksIDIwMjEgYXQgMDk6MTM6MTZBTSAtMDgwMCwgZGFpLm5nb0BvcmFjbGUuY29tIHdyb3RlOg0K
Pj4+Pj4+PiBIaSBCcnVjZSwNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IE9uIDExLzIxLzIxIDc6MDQgUE0s
IGRhaS5uZ29Ab3JhY2xlLmNvbSB3cm90ZToNCj4+Pj4+Pj4+IE9uIDExLzE3LzIxIDQ6MzQgUE0s
IEouIEJydWNlIEZpZWxkcyB3cm90ZToNCj4+Pj4+Pj4+PiBPbiBXZWQsIE5vdiAxNywgMjAyMSBh
dCAwMTo0NjowMlBNIC0wODAwLCBkYWkubmdvQG9yYWNsZS5jb20gd3JvdGU6DQo+Pj4+Pj4+Pj4+
IE9uIDExLzE3LzIxIDk6NTkgQU0sIGRhaS5uZ29Ab3JhY2xlLmNvbSB3cm90ZToNCj4+Pj4+Pj4+
Pj4+IE9uIDExLzE3LzIxIDY6MTQgQU0sIEouIEJydWNlIEZpZWxkcyB3cm90ZToNCj4+Pj4+Pj4+
Pj4+PiBPbiBUdWUsIE5vdiAxNiwgMjAyMSBhdCAwMzowNjozMlBNIC0wODAwLCBkYWkubmdvQG9y
YWNsZS5jb20gd3JvdGU6DQo+Pj4+Pj4+Pj4+Pj4+IEp1c3QgYSByZW1pbmRlciB0aGF0IHRoaXMg
cGF0Y2ggaXMgc3RpbGwgd2FpdGluZyBmb3IgeW91ciByZXZpZXcuDQo+Pj4+Pj4+Pj4+Pj4gWWVh
aCwgSSB3YXMgcHJvY3Jhc3RpbmF0aW5nIGFuZCBob3BpbmcgeW8ndWQgZmlndXJlIG91dCB0aGUg
cHluZnMNCj4+Pj4+Pj4+Pj4+PiBmYWlsdXJlIGZvciBtZS4uLi4NCj4+Pj4+Pj4+Pj4+IExhc3Qg
dGltZSBJIHJhbiA0LjAgT1BFTjE4IHRlc3QgYnkgaXRzZWxmIGFuZCBpdCBwYXNzZWQuIEkgd2ls
bCBydW4NCj4+Pj4+Pj4+Pj4+IGFsbCBPUEVOIHRlc3RzIHRvZ2V0aGVyIHdpdGggNS4xNS1yYzcg
dG8gc2VlIGlmIHRoZSBwcm9ibGVtIHlvdSd2ZQ0KPj4+Pj4+Pj4+Pj4gc2VlbiBzdGlsbCB0aGVy
ZS4NCj4+Pj4+Pj4+Pj4gSSByYW4gYWxsIHRlc3RzIGluIG5mc3Y0LjEgYW5kIG5mc3Y0LjAgd2l0
aCBjb3VydGVvdXMgYW5kIG5vbi1jb3VydGVvdXMNCj4+Pj4+Pj4+Pj4gNS4xNS1yYzcgc2VydmVy
Lg0KPj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4gTmZzNC4xIHJlc3VsdHMgYXJlIHRoZSBzYW1lIGZv
ciBib3RoIGNvdXJ0ZW91cyBhbmQNCj4+Pj4+Pj4+Pj4gbm9uLWNvdXJ0ZW91cyBzZXJ2ZXI6DQo+
Pj4+Pj4+Pj4+PiBPZiB0aG9zZTogMCBTa2lwcGVkLCAwIEZhaWxlZCwgMCBXYXJuZWQsIDE2OSBQ
YXNzZWQNCj4+Pj4+Pj4+Pj4gUmVzdWx0cyBvZiBuZnM0LjAgd2l0aCBub24tY291cnRlb3VzIHNl
cnZlcjoNCj4+Pj4+Pj4+Pj4+IE9mIHRob3NlOiA4IFNraXBwZWQsIDEgRmFpbGVkLCAwIFdhcm5l
ZCwgNTc3IFBhc3NlZA0KPj4+Pj4+Pj4+PiB0ZXN0IGZhaWxlZDogTE9DSzI0DQo+Pj4+Pj4+Pj4+
IA0KPj4+Pj4+Pj4+PiBSZXN1bHRzIG9mIG5mczQuMCB3aXRoIGNvdXJ0ZW91cyBzZXJ2ZXI6DQo+
Pj4+Pj4+Pj4+PiBPZiB0aG9zZTogOCBTa2lwcGVkLCAzIEZhaWxlZCwgMCBXYXJuZWQsIDU3NSBQ
YXNzZWQNCj4+Pj4+Pj4+Pj4gdGVzdHMgZmFpbGVkOiBMT0NLMjQsIE9QRU4xOCwgT1BFTjMwDQo+
Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+PiBPUEVOMTggYW5kIE9QRU4zMCB0ZXN0IHBhc3MgaWYgZWFj
aCBpcyBydW4gYnkgaXRzZWxmLg0KPj4+Pj4+Pj4+IENvdWxkIHdlbGwgYmUgYSBidWcgaW4gdGhl
IHRlc3RzLCBJIGRvbid0IGtub3cuDQo+Pj4+Pj4+PiBUaGUgcmVhc29uIE9QRU4xOCBmYWlsZWQg
d2FzIGJlY2F1c2UgdGhlIHRlc3QgdGltZWQgb3V0IHdhaXRpbmcgZm9yDQo+Pj4+Pj4+PiB0aGUg
cmVwbHkgb2YgYW4gT1BFTiBjYWxsLiBUaGUgUlBDIGNvbm5lY3Rpb24gdXNlZCBmb3IgdGhlIHRl
c3Qgd2FzDQo+Pj4+Pj4+PiBjb25maWd1cmVkIHdpdGggMTUgc2VjcyB0aW1lb3V0LiBOb3RlIHRo
YXQgT1BFTjE4IG9ubHkgZmFpbHMgd2hlbg0KPj4+Pj4+Pj4gdGhlIHRlc3RzIHdlcmUgcnVuIHdp
dGggJ2FsbCcgb3B0aW9uLCB0aGlzIHRlc3QgcGFzc2VzIGlmIGl0J3MgcnVuDQo+Pj4+Pj4+PiBi
eSBpdHNlbGYuDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+IFdpdGggY291cnRlb3VzIHNlcnZlciwgYnkg
dGhlIHRpbWUgT1BFTjE4IHJ1bnMsIHRoZXJlIGFyZSBhYm91dCAxMDI2DQo+Pj4+Pj4+PiBjb3Vy
dGVzeSA0LjAgY2xpZW50cyBvbiB0aGUgc2VydmVyIGFuZCBhbGwgb2YgdGhlc2UgY2xpZW50cyBo
YXZlIG9wZW5lZA0KPj4+Pj4+Pj4gdGhlIHNhbWUgZmlsZSBYIHdpdGggV1JJVEUgYWNjZXNzLiBU
aGVzZSBjbGllbnRzIHdlcmUgY3JlYXRlZCBieSB0aGUNCj4+Pj4+Pj4+IHByZXZpb3VzIHRlc3Rz
LiBBZnRlciBlYWNoIHRlc3QgY29tcGxldGVkLCBzaW5jZSA0LjAgZG9lcyBub3QgaGF2ZQ0KPj4+
Pj4+Pj4gc2Vzc2lvbiwgdGhlIGNsaWVudCBzdGF0ZXMgYXJlIG5vdCBjbGVhbmVkIHVwIGltbWVk
aWF0ZWx5IG9uIHRoZQ0KPj4+Pj4+Pj4gc2VydmVyIGFuZCBhcmUgYWxsb3dlZCB0byBiZWNvbWUg
Y291cnRlc3kgY2xpZW50cy4NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gV2hlbiBPUEVOMTggcnVucyAo
YWJvdXQgMjAgbWludXRlcyBhZnRlciB0aGUgMXN0IHRlc3Qgc3RhcnRlZCksIGl0DQo+Pj4+Pj4+
PiBzZW5kcyBPUEVOIG9mIGZpbGUgWCB3aXRoIE9QRU40X1NIQVJFX0RFTllfV1JJVEUgd2hpY2gg
Y2F1c2VzIHRoZQ0KPj4+Pj4+Pj4gc2VydmVyIHRvIGNoZWNrIGZvciBjb25mbGljdHMgd2l0aCBj
b3VydGVzeSBjbGllbnRzLiBUaGUgbG9vcCB0aGF0DQo+Pj4+Pj4+PiBjaGVja3MgMTAyNiBjb3Vy
dGVzeSBjbGllbnRzIGZvciBzaGFyZS9hY2Nlc3MgY29uZmxpY3QgdG9vayBsZXNzDQo+Pj4+Pj4+
PiB0aGFuIDEgc2VjLiBCdXQgaXQgdG9vayBhYm91dCA1NSBzZWNzLCBvbiBteSBWTSwgZm9yIHRo
ZSBzZXJ2ZXINCj4+Pj4+Pj4+IHRvIGV4cGlyZSBhbGwgMTAyNiBjb3VydGVzeSBjbGllbnRzLg0K
Pj4+Pj4+Pj4gDQo+Pj4+Pj4+PiBJIG1vZGlmaWVkIHB5bmZzIHRvIGNvbmZpZ3VyZSB0aGUgNC4w
IFJQQyBjb25uZWN0aW9uIHdpdGggNjAgc2Vjb25kcw0KPj4+Pj4+Pj4gdGltZW91dCBhbmQgT1BF
TjE4IG5vdyBjb25zaXN0ZW50bHkgcGFzc2VkLiBUaGUgNC4wIHRlc3QgcmVzdWx0cyBhcmUNCj4+
Pj4+Pj4+IG5vdyB0aGUgc2FtZSBmb3IgY291cnRlb3VzIGFuZCBub24tY291cnRlb3VzIHNlcnZl
cjoNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gOCBTa2lwcGVkLCAxIEZhaWxlZCwgMCBXYXJuZWQsIDU3
NyBQYXNzZWQNCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gTm90ZSB0aGF0IDQuMSB0ZXN0cyBkbyBub3Qg
c3VmZmVyIHRoaXMgdGltZW91dCBwcm9ibGVtIGJlY2F1c2UgdGhlDQo+Pj4+Pj4+PiA0LjEgY2xp
ZW50cyBhbmQgc2Vzc2lvbnMgYXJlIGRlc3Ryb3llZCBhZnRlciBlYWNoIHRlc3QgY29tcGxldGVz
Lg0KPj4+Pj4+PiBEbyB5b3Ugd2FudCBtZSB0byBzZW5kIHRoZSBwYXRjaCB0byBpbmNyZWFzZSB0
aGUgdGltZW91dCBmb3IgcHluZnM/DQo+Pj4+Pj4+IG9yIGlzIHRoZXJlIGFueSBvdGhlciB0aGlu
Z3MgeW91IHRoaW5rIHdlIHNob3VsZCBkbz8NCj4+Pj4+PiBJIGRvbid0IGtub3cuDQo+Pj4+Pj4g
DQo+Pj4+Pj4gNTUgc2Vjb25kcyB0byBjbGVhbiB1cCAxMDI2IGNsaWVudHMgaXMgYWJvdXQgNTBt
cyBwZXIgY2xpZW50LCB3aGljaCBpcw0KPj4+Pj4+IHByZXR0eSBzbG93LiAgSSB3b25kZXIgd2h5
LiAgSSBndWVzcyBpdCdzIHByb2JhYmx5IHVwZGF0aW5nIHRoZSBzdGFibGUNCj4+Pj4+PiBzdG9y
YWdlIGluZm9ybWF0aW9uLiAgSXMgL3Zhci9saWIvbmZzLyBvbiB5b3VyIHNlcnZlciBiYWNrZWQg
YnkgYSBoYXJkDQo+Pj4+Pj4gZHJpdmUgb3IgYW4gU1NEIG9yIHNvbWV0aGluZyBlbHNlPw0KPj4+
Pj4gTXkgc2VydmVyIGlzIGEgdmlydHVhbGJveCBWTSB0aGF0IGhhcyAxIENQVSwgNEdCIFJBTSBh
bmQgNjRHQiBvZiBoYXJkDQo+Pj4+PiBkaXNrLiBJIHRoaW5rIGEgcHJvZHVjdGlvbiBzeXN0ZW0g
dGhhdCBzdXBwb3J0cyB0aGlzIG1hbnkgY2xpZW50cyBzaG91bGQNCj4+Pj4+IGhhdmUgZmFzdGVy
IENQVXMsIGZhc3RlciBzdG9yYWdlLg0KPj4+Pj4gDQo+Pj4+Pj4gSSB3b25kZXIgaWYgdGhhdCdz
IGFuIGFyZ3VtZW50IGZvciBsaW1pdGluZyB0aGUgbnVtYmVyIG9mIGNvdXJ0ZXN5DQo+Pj4+Pj4g
Y2xpZW50cy4NCj4+Pj4+IEkgdGhpbmsgd2UgbWlnaHQgd2FudCB0byB0cmVhdCA0LjAgY2xpZW50
cyBhIGJpdCBkaWZmZXJlbnQgZnJvbSA0LjENCj4+Pj4+IGNsaWVudHMuIFdpdGggNC4wLCBldmVy
eSBjbGllbnQgd2lsbCBiZWNvbWUgYSBjb3VydGVzeSBjbGllbnQgYWZ0ZXINCj4+Pj4+IHRoZSBj
bGllbnQgaXMgZG9uZSB3aXRoIHRoZSBleHBvcnQgYW5kIHVubW91bnRzIGl0Lg0KPj4+PiBJdCBz
aG91bGQgYmUgc2FmZSBmb3IgYSBzZXJ2ZXIgdG8gcHVyZ2UgYSBjbGllbnQncyBsZWFzZSBpbW1l
ZGlhdGVseQ0KPj4+PiBpZiB0aGVyZSBpcyBubyBvcGVuIG9yIGxvY2sgc3RhdGUgYXNzb2NpYXRl
ZCB3aXRoIGl0Lg0KPj4+IEluIHRoaXMgY2FzZSwgZWFjaCBjbGllbnQgaGFzIG9wZW5lZCBmaWxl
cyBzbyB0aGVyZSBhcmUgb3BlbiBzdGF0ZXMNCj4+PiBhc3NvY2lhdGVkIHdpdGggdGhlbS4NCj4+
PiANCj4+Pj4gV2hlbiBhbiBORlN2NC4wIGNsaWVudCB1bm1vdW50cywgYWxsIGZpbGVzIHNob3Vs
ZCBiZSBjbG9zZWQgYXQgdGhhdA0KPj4+PiBwb2ludCwNCj4+PiBJJ20gbm90IHN1cmUgcHluZnMg
ZG9lcyBwcm9wZXIgY2xlYW4gdXAgYWZ0ZXIgZWFjaCBzdWJ0ZXN0LCBJIHdpbGwNCj4+PiBjaGVj
ay4gVGhlcmUgbXVzdCBiZSBzdGF0ZSBhc3NvY2lhdGVkIHdpdGggdGhlIGNsaWVudCBpbiBvcmRl
ciBmb3INCj4+PiBpdCB0byBiZWNvbWUgY291cnRlc3kgY2xpZW50Lg0KPj4gTWFrZXMgc2Vuc2Uu
IFRoZW4gYSBzeW50aGV0aWMgY2xpZW50IGxpa2UgcHluZnMgY2FuIERvUyBhIGNvdXJ0ZW91cw0K
Pj4gc2VydmVyLg0KPj4gDQo+PiANCj4+Pj4gc28gdGhlIHNlcnZlciBjYW4gd2FpdCBmb3IgdGhl
IGxlYXNlIHRvIGV4cGlyZSBhbmQgcHVyZ2UgaXQNCj4+Pj4gbm9ybWFsbHkuIE9yIGFtIEkgbWlz
c2luZyBzb21ldGhpbmc/DQo+Pj4gV2hlbiA0LjAgY2xpZW50IGxlYXNlIGV4cGlyZXMgYW5kIHRo
ZXJlIGFyZSBzdGlsbCBzdGF0ZXMgYXNzb2NpYXRlZA0KPj4+IHdpdGggdGhlIGNsaWVudCB0aGVu
IHRoZSBzZXJ2ZXIgYWxsb3dzIHRoaXMgY2xpZW50IHRvIGJlY29tZSBjb3VydGVzeQ0KPj4+IGNs
aWVudC4NCj4+IEkgdGhpbmsgdGhlIHNhbWUgdGhpbmcgaGFwcGVucyBpZiBhbiBORlN2NC4xIGNs
aWVudCBuZWdsZWN0cyB0byBzZW5kDQo+PiBERVNUUk9ZX1NFU1NJT04gLyBERVNUUk9ZX0NMSUVO
VElELiBFaXRoZXIgc3VjaCBhIGNsaWVudCBpcyBicm9rZW4NCj4+IG9yIG1hbGljaW91cywgYnV0
IHRoZSBzZXJ2ZXIgZmFjZXMgdGhlIHNhbWUgaXNzdWUgb2YgcHJvdGVjdGluZw0KPj4gaXRzZWxm
IGZyb20gYSBEb1MgYXR0YWNrLg0KPj4gDQo+PiBJTU8geW91IHNob3VsZCBjb25zaWRlciBsaW1p
dGluZyB0aGUgbnVtYmVyIG9mIGNvdXJ0ZW91cyBjbGllbnRzDQo+PiB0aGUgc2VydmVyIGNhbiBo
b2xkIG9udG8uIExldCdzIHNheSB0aGF0IG51bWJlciBpcyAxMDAwLiBXaGVuIHRoZQ0KPj4gc2Vy
dmVyIHdhbnRzIHRvIHR1cm4gYSAxMDAxc3QgY2xpZW50IGludG8gYSBjb3VydGVvdXMgY2xpZW50
LCBpdA0KPj4gY2FuIHNpbXBseSBleHBpcmUgYW5kIHB1cmdlIHRoZSBvbGRlc3QgY291cnRlb3Vz
IGNsaWVudCBvbiBpdHMNCj4+IGxpc3QuIE90aGVyd2lzZSwgb3ZlciB0aW1lLCB0aGUgMjQtaG91
ciBleHBpcnkgd2lsbCByZWR1Y2UgdGhlDQo+PiBzZXQgb2YgY291cnRlb3VzIGNsaWVudHMgYmFj
ayB0byB6ZXJvLg0KPj4gDQo+PiBXaGF0IGRvIHlvdSB0aGluaz8NCj4gDQo+IExpbWl0aW5nIHRo
ZSBudW1iZXIgb2YgY291cnRlb3VzIGNsaWVudHMgdG8gaGFuZGxlIHRoZSBjYXNlcyBvZg0KPiBi
cm9rZW4vbWFsaWNpb3VzIDQuMSBjbGllbnRzIHNlZW1zIHJlYXNvbmFibGUgYXMgdGhlIGxhc3Qg
cmVzb3J0Lg0KPiANCj4gSSB0aGluayBpZiBhIG1hbGljaW91cyA0LjEgY2xpZW50cyBjb3VsZCBt
b3VudCB0aGUgc2VydmVyJ3MgZXhwb3J0LA0KPiBvcGVucyBhIGZpbGUgKHRvIGNyZWF0ZSBzdGF0
ZSkgYW5kIHJlcGVhdHMgdGhlIHNhbWUgd2l0aCBhIGRpZmZlcmVudA0KPiBjbGllbnQgaWQgdGhl
biBpdCBzZWVtcyBsaWtlIHNvbWUgYmFzaWMgc2VjdXJpdHkgd2FzIGFscmVhZHkgYnJva2VuOw0K
PiBhbGxvd2luZyB1bmF1dGhvcml6ZWQgY2xpZW50cyB0byBtb3VudCBzZXJ2ZXIncyBleHBvcnRz
Lg0KDQpZb3UgY2FuIGRvIHRoaXMgdG9kYXkgd2l0aCBBVVRIX1NZUy4gSSBjb25zaWRlciBpdCBh
IGdlbnVpbmUgYXR0YWNrIHN1cmZhY2UuDQoNCg0KPiBJIHRoaW5rIGlmIHdlIGhhdmUgdG8gZW5m
b3JjZSBhIGxpbWl0LCB0aGVuIGl0J3Mgb25seSBmb3IgaGFuZGxpbmcNCj4gb2Ygc2VyaW91c2x5
IGJ1Z2d5IDQuMSBjbGllbnRzIHdoaWNoIHNob3VsZCBub3QgYmUgdGhlIG5vcm0uIFRoZQ0KPiBp
c3N1ZSB3aXRoIHRoaXMgaXMgaG93IHRvIHBpY2sgYW4gb3B0aW1hbCBudW1iZXIgdGhhdCBpcyBz
dWl0YWJsZQ0KPiBmb3IgdGhlIHJ1bm5pbmcgc2VydmVyIHdoaWNoIGNhbiBiZSBhIHZlcnkgc2xv
dyBvciBhIHZlcnkgZmFzdCBzZXJ2ZXIuDQo+IA0KPiBOb3RlIHRoYXQgZXZlbiBpZiB3ZSBpbXBv
c2UgYW4gbGltaXQsIHRoYXQgZG9lcyBub3QgY29tcGxldGVseSBzb2x2ZQ0KPiB0aGUgcHJvYmxl
bSB3aXRoIHB5bmZzIDQuMCB0ZXN0IHNpbmNlIGl0cyBSUEMgdGltZW91dCBpcyBjb25maWd1cmVk
DQo+IHdpdGggMTUgc2VjcyB3aGljaCBqdXN0IGVub3VnaCB0byBleHBpcmUgMjc3IGNsaWVudHMg
YmFzZWQgb24gNTNtcw0KPiBmb3IgZWFjaCBjbGllbnQsIHVubGVzcyB3ZSBsaW1pdCBpdCB+Mjcw
IGNsaWVudHMgd2hpY2ggSSB0aGluayBpdCdzDQo+IHRvbyBsb3cuDQo+IA0KPiBUaGlzIGlzIHdo
YXQgSSBwbGFuIHRvIGRvOg0KPiANCj4gMS4gZG8gbm90IHN1cHBvcnQgNC4wIGNvdXJ0ZW91cyBj
bGllbnRzLCBmb3Igc3VyZS4NCg0KTm90IHN1cHBvcnRpbmcgNC4wIGlzbuKAmXQgYW4gb3B0aW9u
LCBJTUhPLiBJdCBpcyBhIGZ1bGx5IHN1cHBvcnRlZCBwcm90b2NvbCBhdCB0aGlzIHRpbWUsIGFu
ZCB0aGUgc2FtZSBleHBvc3VyZSBleGlzdHMgZm9yIDQuMSwgaXTigJlzIGp1c3QgYSBsaXR0bGUg
aGFyZGVyIHRvIGV4cGxvaXQuDQoNCklmIHlvdSBzdWJtaXQgdGhlIGNvdXJ0ZW91cyBzZXJ2ZXIg
cGF0Y2ggd2l0aG91dCBzdXBwb3J0IGZvciA0LjAsIEkgdGhpbmsgaXQgbmVlZHMgdG8gaW5jbHVk
ZSBhIHBsYW4gZm9yIGhvdyA0LjAgd2lsbCBiZSBhZGRlZCBsYXRlci4NCg0KDQo+IDIuIGxpbWl0
IHRoZSBudW1iZXIgb2YgY291cnRlb3VzIGNsaWVudHMgdG8gMTAwMCAoPyksIGlmIHlvdSBzdGls
bA0KPiB0aGluayB3ZSBuZWVkIGl0Lg0KDQogSSB0aGluayB0aGlzIGxpbWl0IGlzIG5lY2Vzc2Fy
eS4gSXQgY2FuIGJlIHNldCBiYXNlZCBvbiB0aGUgc2VydmVy4oCZcyBwaHlzaWNhbCBtZW1vcnkg
c2l6ZSBpZiBhIGR5bmFtaWMgbGltaXQgaXMgZGVzaXJlZC4NCg0KDQo+IFBscyBsZXQgbWUga25v
dyB3aGF0IHlvdSB0aGluay4NCj4gDQo+IFRoYW5rcywNCj4gLURhaQ0KPiANCj4+IA0KPj4gDQo+
Pj4+PiBTaW5jZSB0aGVyZSBpcw0KPj4+Pj4gbm8gZGVzdHJveSBzZXNzaW9uL2NsaWVudCB3aXRo
IDQuMCwgdGhlIGNvdXJ0ZW91cyBzZXJ2ZXIgYWxsb3dzIHRoZQ0KPj4+Pj4gY2xpZW50IHRvIGJl
IGFyb3VuZCBhbmQgYmVjb21lcyBhIGNvdXJ0ZXN5IGNsaWVudC4gU28gYWZ0ZXIgYXdoaWxlLA0K
Pj4+Pj4gZXZlbiB3aXRoIG5vcm1hbCB1c2FnZSwgdGhlcmUgd2lsbCBiZSBsb3RzIDQuMCBjb3Vy
dGVzeSBjbGllbnRzDQo+Pj4+PiBoYW5naW5nIGFyb3VuZCBhbmQgdGhlc2UgY2xpZW50cyB3b24n
dCBiZSBkZXN0cm95ZWQgdW50aWwgMjRocnMNCj4+Pj4+IGxhdGVyLCBvciB1bnRpbCB0aGV5IGNh
dXNlIGNvbmZsaWN0cyB3aXRoIG90aGVyIGNsaWVudHMuDQo+Pj4+PiANCj4+Pj4+IFdlIGNhbiBy
ZWR1Y2UgdGhlIGNvdXJ0ZXN5X2NsaWVudF9leHBpcnkgdGltZSBmb3IgNC4wIGNsaWVudHMgZnJv
bQ0KPj4+Pj4gMjRocnMgdG8gMTUvMjAgbWlucywgZW5vdWdoIGZvciBtb3N0IG5ldHdvcmsgcGFy
dGl0aW9uIHRvIGhlYWw/LA0KPj4+Pj4gb3IgbGltaXQgdGhlIG51bWJlciBvZiA0LjAgY291cnRl
c3kgY2xpZW50cy4gT3IgZG9uJ3Qgc3VwcG9ydCA0LjANCj4+Pj4+IGNsaWVudHMgYXQgYWxsIHdo
aWNoIGlzIG15IHByZWZlcmVuY2Ugc2luY2UgSSB0aGluayBpbiBnZW5lcmFsIHVzZXJzDQo+Pj4+
PiBzaG91bGQgc2tpcCA0LjAgYW5kIHVzZSA0LjEgaW5zdGVhZC4NCj4+Pj4+IA0KPj4+Pj4gLURh
aQ0KPj4+PiAtLQ0KPj4+PiBDaHVjayBMZXZlcg0KPj4+PiANCj4+Pj4gDQo+Pj4+IA0KPj4gLS0N
Cj4+IENodWNrIExldmVyDQo+PiANCj4+IA0KPj4gDQo=
