Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7264A6039
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 16:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiBAPfu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 10:35:50 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37530 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233563AbiBAPft (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:35:49 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211DO8Mp028096;
        Tue, 1 Feb 2022 15:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HKunuAL2qzoL43nEApUoCr6/dKfL7s83iL3qr1GziRE=;
 b=PDZmF45IHm9CwTIlRVtJTPtVvidm+U7otLPoAWGUjhIJ9rh5dAhllZIdovXmhhzr5PUg
 di4isynrv8ddYr6UqkEIqjorLZ5+oL4J89DS2KVReaeNjU/Hm4WzmF32TxEvr6rosGQD
 Agwhzp4SUQzHliIb+zgznkO+T+ymR/THytiyqfROAT6bQAO2GM36MOoyVQPLHEcckho5
 53rKikqoDqXazbiJ5Du7FkSjtzdit7dUvIJOKxwdgr4TokzJjgkJt5j7ZCXf0OxZ6bpi
 D0yi6a7q+uJYzHBWFHzAQKqM9h5pfrVUBjvhFf53EzXUIzkFpv8g2MoF2LuFm54Q2KbG Ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxj9vbanb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 15:35:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 211FLA0s179151;
        Tue, 1 Feb 2022 15:35:29 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3020.oracle.com with ESMTP id 3dvwd6edbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Feb 2022 15:35:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8ENQz/cAMI/tLMCd1aMBO5ar2XDYr8c7dh7ygGHEkhAGbmD9d4D5CbdVSab60trr7tq//K3AzJJVrGetpTceyYY4xuIo43TSZiTXwuJod4tGoygMFCHrwCFATrnuyYGjJjPGYHO65Z0V6Aihbj2DOc91/VAzS6s9WtSTuWyipTdI6ouCjPPnFW9dG+HCZzfV/3egqoZJ8OJO+bhFrWCUQX84q/wE5hJOKUzJlGzx/u/hs511kZtqq0nVgsHj0diHzkrelDD9HFHdtaCR8OXTWbQFpHyGhKbOjLR4wD82vjSL8QJSZWE2LGFgwcFpz2Qyb8QfV4D25usZbW43JsMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKunuAL2qzoL43nEApUoCr6/dKfL7s83iL3qr1GziRE=;
 b=dNH6tIRRevPc9n9EvN8b2jRN/l1p9gYQTBFk/+BX+SiKwFepa15aSFO16GTRKbpQXT10jMIyEYmsQOt/sGy8QdgUgrLLk5mjbqTZ9mCVHgjpXO6yVhirI1R0lTjOXcOa0hEYrYMmzejTmeCuqlPQkgt+YlyYwAVBqS/rZ/4Qnukkh0JrvufYqZmHzOOpN1W1LuKq1DopTfgD7Yth3f7fRKm+RYpSGAhy23ID8zpL6MWhzvc+nWjzzTiIVwgDI1SbMZ/maWt6zVNWvgSH+QK4DfIYGGytM5+kWClnCPrrQK8z1RL8n9h3HWiixlYXQSuFunx9kigx/iSaqELPIrdCcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKunuAL2qzoL43nEApUoCr6/dKfL7s83iL3qr1GziRE=;
 b=c+JCcuWahzsxuCDOuH4/G8GVEiWBrq5yAJoMB5PlijBq+EbT1ZHbzlOwoK0sQA7JPZOFpW0+0jTsHVa2kdWX+nukPRmE4eCJLOr7nJ0o8ERSAVIbS6JLHW0romn/QcY0gARTg9xZbahjOBXs89YQiBToWF7LbPkUx4M/gMAxdaE=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by SJ0PR10MB4510.namprd10.prod.outlook.com (2603:10b6:a03:2d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Tue, 1 Feb
 2022 15:35:26 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::1490:125c:62cd:6082%4]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 15:35:26 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     David Howells <dhowells@redhat.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Netfs support library
Thread-Topic: [LSF/MM/BPF TOPIC] Netfs support library
Thread-Index: AQHYFuZsVN49lu1TCki88X55Ds7H8ax99cIAgAAEYoCAANq6AA==
Date:   Tue, 1 Feb 2022 15:35:26 +0000
Message-ID: <8A4D94ED-BCF5-4EAC-BD9E-0525465B00AF@oracle.com>
References: <2571706.1643663173@warthog.procyon.org.uk>
 <1CAF5D33-E854-4B82-AC32-0FDCF1894253@oracle.com>
 <Yfibw2kWukCyfRIK@casper.infradead.org>
In-Reply-To: <Yfibw2kWukCyfRIK@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ef7fba6-d503-4911-72de-08d9e5987852
x-ms-traffictypediagnostic: SJ0PR10MB4510:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB4510E561B33FE1CFCC86FB4F93269@SJ0PR10MB4510.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F4eDEX9YhhFUoQo6NDR4OYWKriLEs/u5HLHgah+cE8983qsniQrfFaFzXIgSe1zty/Ndv/zX8V06iIu4MDxkxmsm4gNX6peHBlfygI753Cr0EqbU4PVKQq1QYG+peWQ05gWpOZEmw4u1CNer9mqKVxQvW+WAC8CarqucqqFKstsEt5OIYmgyJVhchq8RsocXuw5XmwIxZpCrqHsavNNW1TDtvwSh1x3FEuEC4kNjjk1sOUXZjhX6e/6U6+rUC4oSOfmBOb3pQKQbXg1P89DRX13j3CGQ6CU4Dz0tOZovWoAdIc73YtdFdBhHG/G1c8+jU+OAavSFdKz4pca2wITQrJhmmfvX56+/ueCxCZEuN57GUExQtrvfNo9rKKMxeLnoX7p0AmgvgEyW5iZq70JHpBkPR28p6UlTLr0qETq44pQ3n6gdnNlQUA/mDbAiYV+cf/Aj1rTenAnAIJpRGXWGtjjxwRhIDtf09Rnr5yBtgcxWsR9qKzTSxVTineAr0FsUDULxj4Vcx6GHLztwjgailH/4PpJDcRvkUpX2KePaLk/WfqpAiTnuNeuN4HiP6/uo6WXn4zNvSN2W7ZFUD1jktxn57XXuqdtaxveIFt8QshUoYuF2TIBBX0YD4FlxZWktD2oYxasAiO4equ+nyCKtgNCkPZg/7xLTFg7oOn7sb7QvfZoCf/WHpbr7Xvvxm/PEEpyvFs1yrAQEtBj5VTc7vDoXFU/mg+etIAgaaSIfRN4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(5660300002)(38100700002)(86362001)(36756003)(83380400001)(33656002)(71200400001)(66556008)(53546011)(6506007)(186003)(26005)(2616005)(6512007)(38070700005)(6486002)(76116006)(8676002)(66476007)(66446008)(54906003)(122000001)(64756008)(8936002)(316002)(2906002)(508600001)(66946007)(6916009)(45980500001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ztnXGgjb2bi+OQdkPJHBZU24LTCqnmc7Ih17XvAphs4gaL4T4pbJfa5+piFP?=
 =?us-ascii?Q?5RJyjNuTPT2V9H5SXFw5b+eamVQHSluotlwE4tHX7LiroLL/i9wckpGmYhWx?=
 =?us-ascii?Q?Qml6RpSSsin3pZj+EM0WvyGrqJ1H96jC4j+3sj2pSYqNP0eFSYlyIPyqTbUu?=
 =?us-ascii?Q?aXL4jcHW8EJcmPq3lHCGXKXoEqvjb+H8SShPd7mtcJ4hOt5xJEc8CXxL0NcA?=
 =?us-ascii?Q?lc2+CNEGyQzL9jRv9KpLKHpOhYk/tdi7YPYsNDRVhTnKFhBMuG/LbNlZf40/?=
 =?us-ascii?Q?np4I7zadTW58KAk9Pp5ZA4k2vlfjc0jZq4NZ+4eyTvD0fjPU7wCFwkwb0yGl?=
 =?us-ascii?Q?A/dGDxS+JQU4+K22hk5zebmTPHXLKNZP+eGQJirfTarCo5b4sExhviORvqen?=
 =?us-ascii?Q?oOuUjxSUnLBnxvg8v35RmWEgMAbbNLnDglDFVnB+2kKarhorUMtscWRRUc6i?=
 =?us-ascii?Q?88IvfPISKPicxhorIcpXrAqhraitzZxRKzvY3IigFsluRP4bEGcdx+fx8QEd?=
 =?us-ascii?Q?2pXpM5X5Oo+CwtRuAkPb/D2z0lej5a6Fp78CxGzgphFZhsppoXcthdLDD5oQ?=
 =?us-ascii?Q?7vMyDFXR8pesT/WE/9+plQ9S3hBnZCiZsIXbtu7Btz44ar9RKa3TAEUQcUp6?=
 =?us-ascii?Q?Ntx7LZZ3rp0A0GvcgIqRt+UaHeVc8lJ8o3I1t/C8p/GlGKdDVLKe6IIz3vHm?=
 =?us-ascii?Q?eofJ2ddoD19Zb9z0vJwmcCsdGxvP6iu2Lk3rn0eC+zaqGKp2b1JdJkgjGwcc?=
 =?us-ascii?Q?5aTs8AV5HlvRQ6uFCK93AAVmWtNwzvbnlDrIWs7YVGp/qzOZjJXLdqm3VpHo?=
 =?us-ascii?Q?s0ytAV4KUx937s8LXJfkFyDyPv1JfXkjFuFlTz0GS288uofqs4FPY9UwVrSN?=
 =?us-ascii?Q?aUW1bbVMTu4MdJuhBlboXOnXq777Teryr2GnibxNoLipdxlof73YbUSZ/CGl?=
 =?us-ascii?Q?PWJR8txtEkqsyeKaALnInIb+8Bxj6AGziYmMEDFUslRxS4VfKE1Ns54pF7qt?=
 =?us-ascii?Q?TWNNgT4fwnA8Fy27XYIuKxxZvJHpiLl8XwSzjCgn3ObN2ulpDltXNze6PGSG?=
 =?us-ascii?Q?s8beKS2c/SmHT2Cgx8/uvd4iX+dXT3RpGV+KqZD8ZrZ9ukDYkO4TNP+btwRN?=
 =?us-ascii?Q?4zmNQ9DXizu9RDDqm0sRPLpXqexTVexceW1jtPDm3UDyAU/QOrgncNpqHLHN?=
 =?us-ascii?Q?dyxW76/dN0UQN17Fyp3BHFOwoxtfMuvDMXi3Yu9UDNeW4rMHS9xPac+SDqDo?=
 =?us-ascii?Q?BghFJGoYNim4LSZi8Jqg+6s44O+Vk+C2vWmH8qGVLYWLmKJN34kA54Xx4Osx?=
 =?us-ascii?Q?ulZlOl28d18tdBbPPFQF0Ia1m5HTfZ2Mx6bcDCzvkr+Ac0hYBjyWKVJfI9Te?=
 =?us-ascii?Q?k0wVYCMMYm28+Hw5GRGFpI8fA19R9WKK7CuIIo2H+32KzHcQKAUeAJWrCD/t?=
 =?us-ascii?Q?aPFeMjtln47BASZ5/MmLebwhP5/u39LVfs9Z3fBEqNDm7c/2OgXD4+AQzjeM?=
 =?us-ascii?Q?YkT9vWAJtqfg/btxmLOg3sL7zZhVTxBqE9v+BmenD2CGZbQslSez6+IqTjfr?=
 =?us-ascii?Q?oYkjwf1dMhI+IoPk0qIjGxG3RllBM07PzM9bVzKMcdpe5wUVtjN4SJWQYX8e?=
 =?us-ascii?Q?YdNJLyfjAD8GMF3gQoMWjhw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <84D27740E6B82C4899976D54030958D0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ef7fba6-d503-4911-72de-08d9e5987852
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 15:35:26.5157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1/aKjniVRWtwRNkGDcm8L2UyEa24pdl3mwPjR78xHSesM4bN9RQmEp5YPsfyv8d1e+4BWBTHglKq8ls4wZ0EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4510
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10245 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=972 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010087
X-Proofpoint-ORIG-GUID: WNPYsswjXB2J3IblzFVJ6a1E_1ID_5NB
X-Proofpoint-GUID: WNPYsswjXB2J3IblzFVJ6a1E_1ID_5NB
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew-

> On Jan 31, 2022, at 9:32 PM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Tue, Feb 01, 2022 at 02:16:54AM +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Jan 31, 2022, at 4:06 PM, David Howells <dhowells@redhat.com> wrote:
>>>=20
>>> I've been working on a library (in fs/netfs/) to provide network filesy=
stem
>>> support services, with help particularly from Jeff Layton.  The idea is=
 to
>>> move the common features of the VM interface, including request splitti=
ng,
>>> operation retrying, local caching, content encryption, bounce buffering=
 and
>>> compression into one place so that various filesystems can share it.
>>=20
>> IIUC this suite of functions is beneficial mainly to clients,
>> is that correct? I'd like to be clear about that, this is not
>> an objection to the topic.
>>=20
>> I'm interested in discussing how folios might work for the
>> NFS _server_, perhaps as a separate or adjunct conversation.
>=20
> I'd be happy to have that discussion with you, possibly in advance of
> LSFMM.  I have a fortnightly Zoom call (which I put up on Youtube),
> and I'd be happy to have this as a topic one week if more people are
> interested than just you & I.  If it's just you & me, then we can chat
> any time ;-)

I suspect the set of interested parties is small, but is not
limited to just two. A separate Zoom discussion for NFS server
developers might be helpful. Let's co-ordinate offline.


--
Chuck Lever



