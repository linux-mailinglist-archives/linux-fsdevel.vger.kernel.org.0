Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06878518BC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 18:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfFXQe1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 12:34:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:1248 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727953AbfFXQe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 12:34:27 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5OGELJS007215;
        Mon, 24 Jun 2019 09:33:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Ff85BVXHKyiWhomRfjKhokfcqFEBMPFU3gwxDsVvmMM=;
 b=fQ3y6GYYTMXvrX0E6N0I21K4A8h3sAtq5hHELBf7WrD1kjJye8Kol0zD1eHNhZe8U7cb
 Bc241dnGBe4J1y43IQMzXd8/U6PqYrP20uUXrXLQC2f5G6lidXt7RTnWB5clm8td+6T6
 LISdmDZ/GOpjlImcBFsnXOX0aw1j3JE+QCw= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2tapd5jb0c-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 24 Jun 2019 09:33:44 -0700
Received: from prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 24 Jun 2019 09:33:27 -0700
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx03.TheFacebook.com (2620:10d:c081:6::17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 24 Jun 2019 09:33:21 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 24 Jun 2019 09:33:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ff85BVXHKyiWhomRfjKhokfcqFEBMPFU3gwxDsVvmMM=;
 b=ipKkWXY7ab78aX5YvwN3nNbNFR/amArHFDxHHtmt43EKwKAE8oxSnNLoUhlNt8i3Eu8wUOZEHnr0G8Sm/LlQoyb76JypOm4HORtzK76zuK0pprybYXFTCCfYqYm5f8NJzoU0E9NaICLN1RztmphtnT1csE0O+B5XzQo9VjbuxRA=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1615.namprd15.prod.outlook.com (10.175.135.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 16:33:20 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::400e:e329:ea98:aa0d%6]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 16:33:20 +0000
From:   Song Liu <songliubraving@fb.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "matthew.wilcox@oracle.com" <matthew.wilcox@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Kernel Team <Kernel-team@fb.com>,
        "william.kucharski@oracle.com" <william.kucharski@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hdanton@sina.com" <hdanton@sina.com>
Subject: Re: [PATCH v7 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Thread-Topic: [PATCH v7 5/6] mm,thp: add read-only THP support for (non-shmem)
 FS
Thread-Index: AQHVKYdGAmz09KUZ80Kts9GVGsmXGaaqwvwAgAAUeoCAAAd4gIAABAcAgAADi4CAAAKkAIAAAxwAgAAVwYA=
Date:   Mon, 24 Jun 2019 16:33:20 +0000
Message-ID: <59707C4A-8C5C-42DA-80C7-35ABE3D2BBF9@fb.com>
References: <20190623054749.4016638-1-songliubraving@fb.com>
 <20190623054749.4016638-6-songliubraving@fb.com>
 <20190624124746.7evd2hmbn3qg3tfs@box>
 <52BDA50B-7CBF-4333-9D15-0C17FD04F6ED@fb.com>
 <20190624142747.chy5s3nendxktm3l@box>
 <C3161C66-5044-44E6-92F4-BBAD42EDF4E2@fb.com>
 <20190624145453.u4ej3e4ktyyqjite@box>
 <5BE23F34-B611-496B-9277-A09C9CC784B1@fb.com>
 <20190624151528.fnz3hvlnyvea3ytn@box>
In-Reply-To: <20190624151528.fnz3hvlnyvea3ytn@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [2620:10d:c090:200::2:78ae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66884793-4140-4bb5-04c8-08d6f8c1ab47
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1615;
x-ms-traffictypediagnostic: MWHPR15MB1615:
x-microsoft-antispam-prvs: <MWHPR15MB16156F322E2AFC6B17D39283B3E00@MWHPR15MB1615.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(396003)(376002)(366004)(199004)(189003)(53936002)(6512007)(256004)(14444005)(71190400001)(305945005)(71200400001)(6246003)(46003)(50226002)(57306001)(8936002)(486006)(478600001)(476003)(2616005)(11346002)(6116002)(446003)(8676002)(81156014)(81166006)(6916009)(316002)(2906002)(229853002)(14454004)(99286004)(6486002)(6436002)(33656002)(36756003)(68736007)(54906003)(7736002)(66476007)(66556008)(64756008)(76116006)(53546011)(102836004)(6506007)(86362001)(4326008)(25786009)(186003)(5660300002)(66946007)(73956011)(76176011)(66446008)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1615;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y0II3nRyq7rtnDjyjLRVeiP0ugtKko4OCoCf7p9iadLDFoieMaSwuFqlE0wHKffayFuzuyVVMFVNLMS2FSo2zJOjC14itfURDP3gLiY6wcN3S7GdVHX83DPKfvVecqZOlKHjZ84P7ep2uG3GroN0U3krllv5zkbLxPxu6V7j/VgqIuWtcdIhwy8qEEiJCTi4Jnt4/9oTIaTu/mR8Z3geL01jZzm1ZbTTdwIU7BRnsrHrdJyZMDqo+sH0HkcK8SeX0uDlCJejqd8+INBftz70cXhGbJnKr/7hq5ocYJWFBEAsj+gHJNAV5jmWckJj5+f+66YImI5bz3p7kf3ku3EudkT4x8pmJ017oK+QrDoQXk3gma8kMTUts7HUCcKAJkrcVMG037qYTzuuz6/CHGbh1sekrDLPjvQ9NnQ3gDrCRTw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <134F80DA4AD2794F9C8FD4E3E86C271F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 66884793-4140-4bb5-04c8-08d6f8c1ab47
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 16:33:20.3707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: songliubraving@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1615
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240130
X-FB-Internal: deliver
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jun 24, 2019, at 8:15 AM, Kirill A. Shutemov <kirill@shutemov.name> wr=
ote:
>=20
> On Mon, Jun 24, 2019 at 03:04:21PM +0000, Song Liu wrote:
>>=20
>>=20
>>> On Jun 24, 2019, at 7:54 AM, Kirill A. Shutemov <kirill@shutemov.name> =
wrote:
>>>=20
>>> On Mon, Jun 24, 2019 at 02:42:13PM +0000, Song Liu wrote:
>>>>=20
>>>>=20
>>>>> On Jun 24, 2019, at 7:27 AM, Kirill A. Shutemov <kirill@shutemov.name=
> wrote:
>>>>>=20
>>>>> On Mon, Jun 24, 2019 at 02:01:05PM +0000, Song Liu wrote:
>>>>>>>> @@ -1392,6 +1403,23 @@ static void collapse_file(struct mm_struct =
*mm,
>>>>>>>> 				result =3D SCAN_FAIL;
>>>>>>>> 				goto xa_unlocked;
>>>>>>>> 			}
>>>>>>>> +		} else if (!page || xa_is_value(page)) {
>>>>>>>> +			xas_unlock_irq(&xas);
>>>>>>>> +			page_cache_sync_readahead(mapping, &file->f_ra, file,
>>>>>>>> +						  index, PAGE_SIZE);
>>>>>>>> +			lru_add_drain();
>>>>>>>=20
>>>>>>> Why?
>>>>>>=20
>>>>>> isolate_lru_page() is likely to fail if we don't drain the pagevecs.=
=20
>>>>>=20
>>>>> Please add a comment.
>>>>=20
>>>> Will do.=20
>>>>=20
>>>>>=20
>>>>>>>> +			page =3D find_lock_page(mapping, index);
>>>>>>>> +			if (unlikely(page =3D=3D NULL)) {
>>>>>>>> +				result =3D SCAN_FAIL;
>>>>>>>> +				goto xa_unlocked;
>>>>>>>> +			}
>>>>>>>> +		} else if (!PageUptodate(page)) {
>>>>>>>=20
>>>>>>> Maybe we should try wait_on_page_locked() here before give up?
>>>>>>=20
>>>>>> Are you referring to the "if (!PageUptodate(page))" case?=20
>>>>>=20
>>>>> Yes.
>>>>=20
>>>> I think this case happens when another thread is reading the page in.=
=20
>>>> I could not think of a way to trigger this condition for testing.=20
>>>>=20
>>>> On the other hand, with current logic, we will retry the page on the=20
>>>> next scan, so I guess this is OK.=20
>>>=20
>>> What I meant that calling wait_on_page_locked() on !PageUptodate() page
>>> will likely make it up-to-date and we don't need to SCAN_FAIL the attem=
pt.
>>>=20
>>=20
>> Yeah, I got the point. My only concern is that I don't know how to=20
>> reliably trigger this case for testing. I can try to trigger it. But I=20
>> don't know whether it will happen easily.=20
>=20
> Atrifically slowing down IO should do the trick.
>=20

Let me try that.=20

Thanks,
Song

