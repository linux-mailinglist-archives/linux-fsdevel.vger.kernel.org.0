Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF70449D76
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Nov 2021 22:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238912AbhKHVDc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Nov 2021 16:03:32 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:8204 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238853AbhKHVDa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Nov 2021 16:03:30 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A8JxrYv020128;
        Mon, 8 Nov 2021 21:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Dznb0ZS36cO0KceDPbWaXzcV/MB9k1PzOU5VbOnVFEM=;
 b=e4a3eTKRJIAlVJ6ARYTb6cqVIWOjuhz5iv9jq2xBFbxe7FJoC2NX9oQAIJ3EbuPVrZke
 G83+Ej5XnGu93dctulWdW4OXb2b8wozIfWqMYrTfUblZXUEvzw0Td36gxdJ2PtNqOWua
 WQdQESSVrwKJNy5STNY6G657kBTTPkQ1lhHG9jHbmeXeLxpmfRdbrs+Ygart5Ae2uKG1
 Gwy9CH/05fjP2Et5P2VxXbQ1pFDwYL30SerhBezVnPIcH1kS7aT1eZrymZ1ag5Yut8QC
 MbduO3avDUqecAcJ1Cn/fLe5oF/fS37e0gysd5AwW0jCsDjrTFas4vpAVzFb2A1Lopna dA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6t705vx1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 21:00:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A8KqEFV117699;
        Mon, 8 Nov 2021 21:00:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3020.oracle.com with ESMTP id 3c5hh2kwae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Nov 2021 21:00:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzmQj9uSgdEFMZDF/CsvpbmEB8d/y3BkJ8jeqVVm5VpAQ9hnV8KaXosrD13T9XxwoLLx5i/KOPJRWYLaK9uNhw/J4SzyBi1VdWVx6pr2CcNQP3McFgaUyvIDFVexv9Lyo6pztne0mICoxTUvyVr+wzMb7dyNDoNRZwOLrmXaom3KdJlXmWALY0YlmOl5jFwNdPKBonBcjTISvJ2TRh/Z9MWEMGpsfyR/bBu2Ok5QbvGdMLk5/qy8dArSQX8/r+pCRFty/MI2GnKPHBbGDyhgSSdaiavPLjRsiFFx8nPp1iXKoncb0tIQ2jYofUPOAuj9ONhtEBsvcacrrMnNo7UhLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dznb0ZS36cO0KceDPbWaXzcV/MB9k1PzOU5VbOnVFEM=;
 b=gcb0aYnOtoVeX5pusIVaSkLZ/aPAJQSPSnvlOT0T/so1mfI+MrYqtil/TXUxTGEec3NhGnAEmyle39ulAjK67VXybKLL1lHFjdk7t7zDGnCgWWOe08lwsoNcluQQyv9MeIfSmi+IVfBESk25JUm6BCruzA8OKsGg5Ytjnyz5qBPVoWNVBThIgieJ1V/0wwNXB2BrNMj0am5CF6yY67J5om1Wig8XeVGDid8pny4kEJCd1nG+NSNW1pJon6q17xukS9Ka6MzIR3dshGQ1Gejxnnmuumbo+iz0NVYN1UMxItSxlK4MFWYJ4K8UPJuzFcpqoJebA9R383fyOk2RFriQAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dznb0ZS36cO0KceDPbWaXzcV/MB9k1PzOU5VbOnVFEM=;
 b=bDmeVeHba38bWntXpzFhUoOvDlbPl8F8R5SdNZaydTsvisxqj0SMWpdoHTgRaHkrA8r30z0MoMTPEAC55Cw3+0gF9Foc1AaqFAHRYYC2wk+LESkONfWi7kVZO6QB5U2XOIOumzzB7njVKRL0niO76vwbOeVOGxRTkTGgUaf6vEE=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ0PR10MB5568.namprd10.prod.outlook.com (2603:10b6:a03:3d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Mon, 8 Nov
 2021 21:00:27 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::418c:dfe4:f3ee:feaa%6]) with mapi id 15.20.4669.016; Mon, 8 Nov 2021
 21:00:27 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dax,pmem: Implement pmem based dax data recovery
Thread-Topic: [PATCH v2 2/2] dax,pmem: Implement pmem based dax data recovery
Thread-Index: AQHX0qwHA1irfgJJPUKt0/SD8Ofb86v1wA+AgARh6IA=
Date:   Mon, 8 Nov 2021 21:00:27 +0000
Message-ID: <400cb29d-4354-054e-9a3d-15cb57342340@oracle.com>
References: <20211106011638.2613039-1-jane.chu@oracle.com>
 <20211106011638.2613039-3-jane.chu@oracle.com>
 <20211106020459.GL2237511@magnolia>
In-Reply-To: <20211106020459.GL2237511@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6e5e55a-2a71-4db1-159d-08d9a2facab3
x-ms-traffictypediagnostic: SJ0PR10MB5568:
x-microsoft-antispam-prvs: <SJ0PR10MB55683544B8DDA8FC989CADD9F3919@SJ0PR10MB5568.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dkcar1Nw5D/5+6CZ68NZrULIbfGImE9aO/g4nUGloS89ClbwPhnJlEzil89uDrENHgd52UCa9VIU4ia0Tq/DrhYJqmaEPpnK8Dflj1TwdmBocEeR9D9aD4m1jZM+2rDAAA2xH4mZyJgprE3Gl/qk7Ag5ce/IVrAbZqPk0H3YB5k/3CxnhfqwOoVbB2/8GUotf4waqQYexNV0Rv/dKC5UMZifdH08cJZ8AUIt0qD8TRCD3JaIxr7W7sry+NSCbKA0AcUSaxevFRPzCPrGvnCOFxw6jxkiIkuOOP2nLW1KsZMdNteXheyMLE33BvA5K3n76Vq0Q3LO8we/Mq5r/8iPD2mohGRcPDXc7dlkVJ2mr8BRj0XM66JCb5r26mcX98VzjQ7jx/hzOJGnXGUkwaUggMhqoIfDouiuOd7F6L/lWC3NXpm+QPpQZJs+I4+/fKqomr6oZKf5dZULkZcjSFaRc9ZpNDfxuDznewIhEanKJWrNiUjAMUpy84ZvMtNL95mLKr0Yis11AuhfJAK8oFafN7VuqcWKjUj0k8zKdqWLCOMpWZ9Ker2aaoYuwv/sV/6vftbs69+byRJBDQ7meC1OmFpAcmLb4uvQtvAzA2VSmifVUQE3g/FOxbXU3hmIc8tavgr+2+klRicJt7nah/vr1BvWDryVPkmKru5d9wrninuiip/B/UgYmbORzSz4sAmVMhKBTEtuFbpLXe7oIlnlIzSRFjVEZ4y0RRmdG5WtdUWrC1ITI8sOiDtyww0ljSVzjJ1w+BqZHNwkcePKWSCURLuer1qZH300sZlkixIEijM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(83380400001)(86362001)(186003)(6512007)(7416002)(91956017)(66446008)(66556008)(64756008)(38070700005)(2906002)(31696002)(5660300002)(316002)(66946007)(8936002)(4326008)(122000001)(31686004)(38100700002)(76116006)(66476007)(54906003)(6486002)(53546011)(36756003)(44832011)(508600001)(6916009)(71200400001)(6506007)(2616005)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkcrWmNlU2xmcHNwcFVzUlhYU20zWm5iVngvS2RXYSt3dUxxMVRXWDBCSGRt?=
 =?utf-8?B?eTZJS2xKY1MxSWoxU0ZtZk82T3lpWlRXdDRZc1o3NGUvL1V3ZXRGbzlrVFRw?=
 =?utf-8?B?Y2RiS3RQamZuTklPQXR4NXIvNGxvUDd1YXNlWnhJY2NtSW44WUlvVllmUDNT?=
 =?utf-8?B?ZmFaYjRxUUxabEZiemZEU1cxamk5L3UrZmpHSStTREkvbkl2MldCMGlyWGV3?=
 =?utf-8?B?TitpV2xRYWJqeUdoS1ExOVhob05kQ3I0NmFOWW9zT2RXYnlFR2pJaFBNL3U4?=
 =?utf-8?B?N2FqZ3FPdG1NNDZQV3ZtRnRseEFWRENVNTd2R29TcjBHRE41OHc1bFhIUW9U?=
 =?utf-8?B?cGFlbmYyYTNiK0pDSituNlQxVVJRRkl1VWR1SUt0aVB6aUZ2UkFVbFB1OUh5?=
 =?utf-8?B?YVFxWkxxYlFEbkZnQXNRaVpSK29ZQzVMWTh4eVpDa2xDQUVPNDg0MXhtd3Fu?=
 =?utf-8?B?QnZ3ZS8ySzIwU2xKMm5xQkRld1VUd0x2YnFXV25RLytvQWl4MGIxV3RqZlhs?=
 =?utf-8?B?Yk1GMzE4aFdYcHNvZHhITE4xSlZHNmduaEdyVWV3NnlOTVphVTZSQ0FkT213?=
 =?utf-8?B?a0k3amlQbHpVK00rZDlMRXkvUGVHNjlIdGhOVWtHM1hXTFVJcGlHMmRWVzFD?=
 =?utf-8?B?ZXU2QVNjazhzeXlEK2tnR0hNdTNkT29WczVLbjJmRmtkOG11UDNBVEdvN1Ex?=
 =?utf-8?B?QVFpNXFjQzZ6SllsWEZCaEVaOUJWa2QreUpnSEJiZHMyQ3BPOHJadE1XVjJk?=
 =?utf-8?B?T0x3cy9zOGFoSThVV011QTNhaGljRzhmSmMvV1hmMUpqZTVPZjNqRzJIQ3Bi?=
 =?utf-8?B?dDJzdzhuaXh4WmYwbk9QL3VlV3RoelNmT3V6NnF1RnAyRVlWTmZtcmRYRkJp?=
 =?utf-8?B?K3NjbWlyMm5JU3Z6dFNNY1lxV1o0UWJ5Uk92NXM0cFFXTzNhQkg4OWxQUlNX?=
 =?utf-8?B?a0ExVHRRaGErbHhRSkd1MzVEaTVwdEpCcHV6YW8raTg0L2hVMkx0Z1h3Z2o4?=
 =?utf-8?B?Q2pUUG1ETExxWHdZZTZNYlEvTGRDWWJCMEx5SmJXV2hnRVpQZkhxV0dsOTI4?=
 =?utf-8?B?cm9EMFJjWWhyMEE5eDBWc1ZqSGV5QlJuSkNUTHA1K1pSNThsbS9EVS9QRjdK?=
 =?utf-8?B?MUJyUGs0QXpUSEcxYURUU1pObFlFYVZNM0o2TmxUSjVyamhjU2FBQTVQTFFo?=
 =?utf-8?B?Nkw1eXFqM2JjK09HdjAxMjlBbVNWb0VZdWhQZkc4bmh2Ylpac1VLK1RzWitN?=
 =?utf-8?B?RmdiUVdQZXlGYkFBZE9rc05pWlRSeW5CclVhOFpTeDNvbFlUZHI0QXB2OXFH?=
 =?utf-8?B?SjREZGVacElxMjB0UHY1RG5tOEdWL3B3Sk1PaDdodEJ1ZFNRZnpRY0tZcExn?=
 =?utf-8?B?dVgweE1lank0NTZHSnk4VEVSTUljektGenV2R3IyUTZJWlNDWjU2aE9qbFM1?=
 =?utf-8?B?Q3RyaXo0bjRkRWpIRys2Tzk4amIvcHlvcVVzMmhtWjRKeWM5NkVZajF0eFha?=
 =?utf-8?B?MVRib2RVamllbDZ3UHk2bjh1ZVNUSjErVzFkVzd3bW5oSm9sR2l2RFZBUzYr?=
 =?utf-8?B?VXdYWUY1SkpkYkF0TDlFQkE1QmpEVnFSUFUrZXptYmp2RmV0dG4xZE5XSmNY?=
 =?utf-8?B?M1RNME5nUWl4RDdzUEpISjVrSC9uU1RRTlA4UXk5eWZ0WWFyR1FuOEVjemVp?=
 =?utf-8?B?NFBnclRKU3pRQk1QWUZxcnRraCtNZGozSVpVQ2NOTjBld1c0b0d0Z08rS2dM?=
 =?utf-8?B?clFsSWt4MWZ5bjR6ZmNrSHhSeHBGeVlyVy9wQlI4M25aYXk1U3g0aU1mSGR0?=
 =?utf-8?B?RkJ2STVvU3VvaElmcTNQT0FFMVlzM2RaSk9LUTJlVmk5K3hTQXpqVmp1U2x5?=
 =?utf-8?B?WGtkVzlvdEpSQTI3cWowL0poWGxGbXYxZ0xmMlJMMGgzei9RSnp2bDV6cGFy?=
 =?utf-8?B?QWZkSUlZSWtKenA4T1RHblhnbHUxZXNtODlQZFdqZ0RUdFZpdXY3a083VUUv?=
 =?utf-8?B?SGMyNnV3U2tzUFF5Q1dCN080WEg2SW9FNUd5V3FKcUxZNStjL3hValo5SzlU?=
 =?utf-8?B?OC8vWVJrNWV1R1BOYUxibjhWUHp4TTdVM3ZGT3JsN2ZtbnB1YUZzNmgrZ2RQ?=
 =?utf-8?B?aDNhcGJzZEZ2MFlBc1FFSTE0UDRKSk1Oa0JtckI3Nm4zamRjcVJXVzhoVG15?=
 =?utf-8?Q?EZNOHs6Hyx7kVpGkCoJYZVL8vyi25e7ZtzBxKy4E8HSl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A9AA737C8863A4D948D359C635A5B75@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e5e55a-2a71-4db1-159d-08d9a2facab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2021 21:00:27.5077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3x9c8KvXTgSjLiESDgYqwBOL0YwhuhYLQAsXzBVSrhFvTh9AQTXbThx4Z6ATa9m2bm5NRwSnzww705QegVaU3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5568
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111080123
X-Proofpoint-GUID: McGJYmpb_3F7avUiLMPAOzmuWkSWLqC2
X-Proofpoint-ORIG-GUID: McGJYmpb_3F7avUiLMPAOzmuWkSWLqC2
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvNS8yMDIxIDc6MDQgUE0sIERhcnJpY2sgSi4gV29uZyB3cm90ZToNCjxzbmlwPg0KPj4g
QEAgLTMwMywyMCArMzAzLDg1IEBAIHN0YXRpYyBsb25nIHBtZW1fZGF4X2RpcmVjdF9hY2Nlc3Mo
c3RydWN0IGRheF9kZXZpY2UgKmRheF9kZXYsDQo+PiAgIH0NCj4+ICAgDQo+PiAgIC8qDQo+PiAt
ICogVXNlIHRoZSAnbm8gY2hlY2snIHZlcnNpb25zIG9mIGNvcHlfZnJvbV9pdGVyX2ZsdXNoY2Fj
aGUoKSBhbmQNCj4+IC0gKiBjb3B5X21jX3RvX2l0ZXIoKSB0byBieXBhc3MgSEFSREVORURfVVNF
UkNPUFkgb3ZlcmhlYWQuIEJvdW5kcw0KPj4gLSAqIGNoZWNraW5nLCBib3RoIGZpbGUgb2Zmc2V0
IGFuZCBkZXZpY2Ugb2Zmc2V0LCBpcyBoYW5kbGVkIGJ5DQo+PiAtICogZGF4X2lvbWFwX2FjdG9y
KCkNCj4+ICsgKiBFdmVuIHRob3VnaCB0aGUgJ25vIGNoZWNrJyB2ZXJzaW9ucyBvZiBjb3B5X2Zy
b21faXRlcl9mbHVzaGNhY2hlKCkNCj4+ICsgKiBhbmQgY29weV9tY190b19pdGVyKCkgYXJlIHVz
ZWQgdG8gYnlwYXNzIEhBUkRFTkVEX1VTRVJDT1BZIG92ZXJoZWFkLA0KPj4gKyAqICdyZWFkJy8n
d3JpdGUnIGFyZW4ndCBhbHdheXMgc2FmZSB3aGVuIHBvaXNvbiBpcyBjb25zdW1lZC4gVGhleSBo
YXBwZW4NCj4+ICsgKiB0byBiZSBzYWZlIGJlY2F1c2UgdGhlICdyZWFkJy8nd3JpdGUnIHJhbmdl
IGhhcyBiZWVuIGd1YXJhbnRlZWQNCj4+ICsgKiBiZSBmcmVlIG9mIHBvaXNvbihzKSBieSBhIHBy
aW9yIGNhbGwgdG8gZGF4X2RpcmVjdF9hY2Nlc3MoKSBvbiB0aGUNCj4+ICsgKiBjYWxsZXIgc3Rh
Y2suDQo+PiArICogQnV0IG9uIGEgZGF0YSByZWNvdmVyeSBjb2RlIHBhdGgsIHRoZSAncmVhZCcv
J3dyaXRlJyByYW5nZSBpcyBleHBlY3RlZA0KPj4gKyAqIHRvIGNvbnRhaW4gcG9pc29uKHMpLCBh
bmQgc28gcG9pc29uKHMpIGlzIGV4cGxpY2l0IGNoZWNrZWQsIHN1Y2ggdGhhdA0KPj4gKyAqICdy
ZWFkJyBjYW4gZmV0Y2ggZGF0YSBmcm9tIGNsZWFuIHBhZ2UocykgdXAgdGlsbCB0aGUgZmlyc3Qg
cG9pc29uIGlzDQo+PiArICogZW5jb3VudGVyZWQsIGFuZCAnd3JpdGUnIHJlcXVpcmVzIHRoZSBy
YW5nZSBiZSBwYWdlIGFsaWduZWQgaW4gb3JkZXINCj4+ICsgKiB0byByZXN0b3JlIHRoZSBwb2lz
b25lZCBwYWdlJ3MgbWVtb3J5IHR5cGUgYmFjayB0byAicnciIGFmdGVyIGNsZWFyaW5nDQo+PiAr
ICogdGhlIHBvaXNvbihzKS4NCj4+ICsgKiBJbiB0aGUgZXZlbnQgb2YgcG9pc29uIHJlbGF0ZWQg
ZmFpbHVyZSwgKHNpemVfdCkgLUVJTyBpcyByZXR1cm5lZCBhbmQNCj4+ICsgKiBjYWxsZXIgbWF5
IGNoZWNrIHRoZSByZXR1cm4gdmFsdWUgYWZ0ZXIgY2FzdGluZyBpdCB0byAoc3NpemVfdCkuDQo+
PiArICoNCj4+ICsgKiBUT0RPOiBhZGQgc3VwcG9ydCBmb3IgQ1BVcyB0aGF0IHN1cHBvcnQgTU9W
RElSNjRCIGluc3RydWN0aW9uIGZvcg0KPj4gKyAqIGZhc3RlciBwb2lzb24gY2xlYXJpbmcsIGFu
ZCBwb3NzaWJseSBzbWFsbGVyIGVycm9yIGJsYXN0IHJhZGl1cy4NCj4gDQo+IEkgZ2V0IHRoYXQg
aXQncyBzdGlsbCBlYXJseSBkYXlzIHlldCBmb3Igd2hhdGV2ZXIgcG1lbSBzdHVmZiBpcyBnb2lu
ZyBvbg0KPiBmb3IgNS4xNywgYnV0IEkgZmVlbCBsaWtlIHRoaXMgb3VnaHQgdG8gYmUgYSBzZXBh
cmF0ZSBmdW5jdGlvbiBjYWxsZWQgYnkNCj4gcG1lbV9jb3B5X2Zyb21faXRlciwgd2l0aCB0aGlz
IGh1Z2UgY29tbWVudCBhdHRhY2hlZCB0byB0aGF0IHJlY292ZXJ5DQo+IGZ1bmN0aW9uLg0KDQpU
aGFua3MsIHdpbGwgcmVmYWN0b3IgYm90aCBmdW5jdGlvbnMuDQoNCj4gDQo+PiAgICAqLw0KPj4g
ICBzdGF0aWMgc2l6ZV90IHBtZW1fY29weV9mcm9tX2l0ZXIoc3RydWN0IGRheF9kZXZpY2UgKmRh
eF9kZXYsIHBnb2ZmX3QgcGdvZmYsDQo+PiAgIAkJdm9pZCAqYWRkciwgc2l6ZV90IGJ5dGVzLCBz
dHJ1Y3QgaW92X2l0ZXIgKmksIGludCBtb2RlKQ0KPj4gICB7DQo+PiArCXBoeXNfYWRkcl90IHBt
ZW1fb2ZmOw0KPj4gKwlzaXplX3QgbGVuLCBsZWFkX29mZjsNCj4+ICsJc3RydWN0IHBtZW1fZGV2
aWNlICpwbWVtID0gZGF4X2dldF9wcml2YXRlKGRheF9kZXYpOw0KPj4gKwlzdHJ1Y3QgZGV2aWNl
ICpkZXYgPSBwbWVtLT5iYi5kZXY7DQo+PiArDQo+PiArCWlmICh1bmxpa2VseShtb2RlID09IERB
WF9PUF9SRUNPVkVSWSkpIHsNCj4+ICsJCWxlYWRfb2ZmID0gKHVuc2lnbmVkIGxvbmcpYWRkciAm
IH5QQUdFX01BU0s7DQo+PiArCQlsZW4gPSBQRk5fUEhZUyhQRk5fVVAobGVhZF9vZmYgKyBieXRl
cykpOw0KPj4gKwkJaWYgKGlzX2JhZF9wbWVtKCZwbWVtLT5iYiwgUEZOX1BIWVMocGdvZmYpIC8g
NTEyLCBsZW4pKSB7DQo+PiArCQkJaWYgKGxlYWRfb2ZmIHx8ICEoUEFHRV9BTElHTkVEKGJ5dGVz
KSkpIHsNCj4+ICsJCQkJZGV2X3dhcm4oZGV2LCAiRm91bmQgcG9pc29uLCBidXQgYWRkciglcCkg
YW5kL29yIGJ5dGVzKCUjbHgpIG5vdCBwYWdlIGFsaWduZWRcbiIsDQo+PiArCQkJCQlhZGRyLCBi
eXRlcyk7DQo+PiArCQkJCXJldHVybiAoc2l6ZV90KSAtRUlPOw0KPj4gKwkJCX0NCj4+ICsJCQlw
bWVtX29mZiA9IFBGTl9QSFlTKHBnb2ZmKSArIHBtZW0tPmRhdGFfb2Zmc2V0Ow0KPj4gKwkJCWlm
IChwbWVtX2NsZWFyX3BvaXNvbihwbWVtLCBwbWVtX29mZiwgYnl0ZXMpICE9DQo+PiArCQkJCQkJ
QkxLX1NUU19PSykNCj4+ICsJCQkJcmV0dXJuIChzaXplX3QpIC1FSU87DQo+IA0KPiBMb29rcyBy
ZWFzb25hYmxlIGVub3VnaCB0byBtZSwgdGhvdWdoIHlvdSBtaWdodCB3YW50IHRvIHJlc3RydWN0
dXJlIHRoaXMNCj4gdG8gcmVkdWNlIHRoZSBhbW91bnQgb2YgaW5kZW50Lg0KDQpBZ3JlZWQuDQoN
Cj4gDQo+IEZXSVcgSSBkaXNsaWtlIGhvdyBpc19iYWRfcG1lbSBtaXhlcyB1bml0cyAoc2VjdG9y
X3QgdnMuIGJ5dGVzKSwgdGhhdA0KPiB3YXMgc2VyaW91c2x5IGNvbmZ1c2luZy4gIEJ1dCBJIGd1
ZXNzIHRoYXQncyBhIHdlaXJkIHF1aXJrIG9mIHRoZQ0KPiBiYWRibG9ja3MgQVBJIGFuZCAuLi4u
IHVnaC4NCj4gDQo+IChJIGR1bm5vLCBjYW4gd2UgYXQgbGVhc3QgY2xlYW4gdXAgdGhlIG52ZGlt
bSBwYXJ0cyBhbmQgc29tZSBkYXkgcmVwbGFjZQ0KPiB0aGUgYmFkYmxvY2tzIGJhY2tlbmQgd2l0
aCBzb21ldGhpbmcgdGhhdCBjYW4gaGFuZGxlIG1vcmUgdGhhbiAxNg0KPiByZWNvcmRzPyAgaW50
ZXJ2YWxfdHJlZSBpcyBtb3JlIHRoYW4gdXAgdG8gdGhhdCB0YXNrLCBJIGtub3csIEkgdXNlIGl0
DQo+IGZvciB4ZnMgb25saW5lIGZzY2suLi4pDQoNCkxldCBtZSBsb29rIGludG8gdGhpcyBhbmQg
Z2V0IGJhY2sgdG8geW91Lg0KDQo+IA0KPj4gKwkJfQ0KPj4gKwl9DQo+PiArDQo+PiAgIAlyZXR1
cm4gX2NvcHlfZnJvbV9pdGVyX2ZsdXNoY2FjaGUoYWRkciwgYnl0ZXMsIGkpOw0KPj4gICB9DQo+
PiAgIA0KPj4gICBzdGF0aWMgc2l6ZV90IHBtZW1fY29weV90b19pdGVyKHN0cnVjdCBkYXhfZGV2
aWNlICpkYXhfZGV2LCBwZ29mZl90IHBnb2ZmLA0KPj4gICAJCXZvaWQgKmFkZHIsIHNpemVfdCBi
eXRlcywgc3RydWN0IGlvdl9pdGVyICppLCBpbnQgbW9kZSkNCj4+ICAgew0KPj4gKwlpbnQgbnVt
X2JhZDsNCj4+ICsJc2l6ZV90IGxlbiwgbGVhZF9vZmY7DQo+PiArCXVuc2lnbmVkIGxvbmcgYmFk
X3BmbjsNCj4+ICsJYm9vbCBiYWRfcG1lbSA9IGZhbHNlOw0KPj4gKwlzaXplX3QgYWRqX2xlbiA9
IGJ5dGVzOw0KPj4gKwlzZWN0b3JfdCBzZWN0b3IsIGZpcnN0X2JhZDsNCj4+ICsJc3RydWN0IHBt
ZW1fZGV2aWNlICpwbWVtID0gZGF4X2dldF9wcml2YXRlKGRheF9kZXYpOw0KPj4gKwlzdHJ1Y3Qg
ZGV2aWNlICpkZXYgPSBwbWVtLT5iYi5kZXY7DQo+PiArDQo+PiArCWlmICh1bmxpa2VseShtb2Rl
ID09IERBWF9PUF9SRUNPVkVSWSkpIHsNCj4+ICsJCXNlY3RvciA9IFBGTl9QSFlTKHBnb2ZmKSAv
IDUxMjsNCj4+ICsJCWxlYWRfb2ZmID0gKHVuc2lnbmVkIGxvbmcpYWRkciAmIH5QQUdFX01BU0s7
DQo+PiArCQlsZW4gPSBQRk5fUEhZUyhQRk5fVVAobGVhZF9vZmYgKyBieXRlcykpOw0KPj4gKwkJ
aWYgKHBtZW0tPmJiLmNvdW50KQ0KPj4gKwkJCWJhZF9wbWVtID0gISFiYWRibG9ja3NfY2hlY2so
JnBtZW0tPmJiLCBzZWN0b3IsDQo+PiArCQkJCQlsZW4gLyA1MTIsICZmaXJzdF9iYWQsICZudW1f
YmFkKTsNCj4+ICsJCWlmIChiYWRfcG1lbSkgew0KPj4gKwkJCWJhZF9wZm4gPSBQSFlTX1BGTihm
aXJzdF9iYWQgKiA1MTIpOw0KPj4gKwkJCWlmIChiYWRfcGZuID09IHBnb2ZmKSB7DQo+PiArCQkJ
CWRldl93YXJuKGRldiwgIkZvdW5kIHBvaXNvbiBpbiBwYWdlOiBwZ29mZiglI2x4KVxuIiwNCj4+
ICsJCQkJCXBnb2ZmKTsNCj4+ICsJCQkJcmV0dXJuIC1FSU87DQo+PiArCQkJfQ0KPj4gKwkJCWFk
al9sZW4gPSBQRk5fUEhZUyhiYWRfcGZuIC0gcGdvZmYpIC0gbGVhZF9vZmY7DQo+PiArCQkJZGV2
X1dBUk5fT05DRShkZXYsIChhZGpfbGVuID4gYnl0ZXMpLA0KPj4gKwkJCQkJIm91dC1vZi1yYW5n
ZSBmaXJzdF9iYWQ/Iik7DQo+PiArCQl9DQo+PiArCQlpZiAoYWRqX2xlbiA9PSAwKQ0KPj4gKwkJ
CXJldHVybiAoc2l6ZV90KSAtRUlPOw0KPiANCj4gVWgsIGFyZSB3ZSBzdXBwb3NlZCB0byBhZGp1
c3QgYnl0ZXMgaGVyZSBvciBzb21ldGhpbmc/DQoNCkJlY2F1c2Ugd2UncmUgdHJ5aW5nIHRvIHJl
YWQgYXMgbXVjaCBkYXRhIGFzIHBvc3NpYmxlLi4uDQpXaGF0IGlzIHlvdXIgY29uY2VybiBoZXJl
Pw0KDQp0aGFua3MhDQotamFuZQ0KDQo+IA0KPiAtLUQNCj4gDQo+PiArCX0NCj4+ICsNCj4+ICAg
CXJldHVybiBfY29weV9tY190b19pdGVyKGFkZHIsIGJ5dGVzLCBpKTsNCj4+ICAgfQ0KPj4gICAN
Cg0KDQo=
