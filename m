Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E584E49C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 00:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240644AbiCVXuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 19:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiCVXuA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:50:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948402FFFE;
        Tue, 22 Mar 2022 16:48:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22MKxe95019567;
        Tue, 22 Mar 2022 23:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=zhu1AbtKJHOFF+2CWLt7IaQXFdlOBC4GkEyGwMw0c5Q=;
 b=EzYYZkJWm0Yl1ckhwZ9PozXOqjVRD29TFZBmIAvPZCIGsK2sZ7+NNEEmLe+1XJK6G+gE
 Xobep8fr9ROd4LgKTNj5etMaPv+h6DUnyrX4gUVu+HsRatCVHGE6mTSul8t9u+7S4qvY
 bdZQCCkZi51U0ct+3uS290hgbWj4G7pv6nCZT1s4nwNe6Ig/jnTSMHFWjibFu7kPca6U
 nZBOMYjylrFv6qOcsSWT3yhqiloHqRS2jy/YiAoFPjIkSLuqPKvVefbrvUZluqSh/Oay
 RGkUeii/vI1PhJjVa8S31XouO02X34U5olfqILpuPy9Ib1ehL1pejKEuQfQuHKgnKlOW mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ew72aft08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 23:48:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22MNjUxt050840;
        Tue, 22 Mar 2022 23:48:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by userp3020.oracle.com with ESMTP id 3exawhwsw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Mar 2022 23:48:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doTvHZUZ+yFgbB3shSn5VsRbRwLMfZsfH1qNsoJw0vi2m2C4roUWIm+AGkEjpLLqVRod/JFBZuWWtyxw4CxcvrS8hoYpjUNfFC/c2CnzH7m56f8R6gB7gLekAE6qebVgeDrjJwDcwKs6xy8XWVeSGmJZY6ReUG3iqH1hve/0j50umU4qY3T6ybnlIaNleysLhrZSOQYhzSAgLuU/gkG+BbOvpEQl/lSOpc07wrJcGRwW2ArQtKDlCgnJJqNp5YDs9c//mXOjkHI7woSNjUjgPlAzKDJOKukaAuBqITR1s2R/mnFqvUYm4sc+TbJGNsyCUiOfG9Dm59A5bQaI3OeHCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhu1AbtKJHOFF+2CWLt7IaQXFdlOBC4GkEyGwMw0c5Q=;
 b=O+H66DWjELT41arcUwpMX1iDbbjWseRDuB7fpto/mB1VfwNfW7pD1clfBgkC4yQogyUjN5wfplGmd3A+rMS0FJJm+WGYInO63g5cZ1VWtey9Qas2cZ70WKgI4y/mrsELx7ovY36MW3m9NQZFTqRxYY45jDf6CiWbefx5FSjbaFjIKtdzc2psxmuYm9BbLjp4zXBx/Ms4bgPckkcHcy84ES8AVkABsmMAsKZdkiRHTkP6MBkOwwugOdVlqNrvZYb6/jJakwC/b5UgjJCKAizuoUh9vua1Oe8V6DFye6Yyzipl+9s0kAMcXr3MvqYAzXiy3PxC6R5SeoR+mh9O2tUQ2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhu1AbtKJHOFF+2CWLt7IaQXFdlOBC4GkEyGwMw0c5Q=;
 b=mDJNrZr5xrMYxJDrz71hfwi0GiQAL9WPgnNXWqIeOjVPZS04cFsPNAD1jF9QoCWcedRILspPectMK/BNK1RgZWLMFPmJBr+9ElmEdZauZa6DZsO2+R3BQh2jKlbRzTitr9uFHQV5zQisoJSUZdVqB4DG5qtpdaRdPGC42WiQ1QM=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BN7PR10MB2514.namprd10.prod.outlook.com (2603:10b6:406:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Tue, 22 Mar
 2022 23:48:12 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::2092:8e36:64c0:a336%7]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 23:48:12 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
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
Subject: Re: [PATCH v6 2/6] x86/mce: relocate set{clear}_mce_nospec()
 functions
Thread-Topic: [PATCH v6 2/6] x86/mce: relocate set{clear}_mce_nospec()
 functions
Thread-Index: AQHYO1ql070j1sj5n0uvCqd0wwFVgKzMBTgAgAASpoA=
Date:   Tue, 22 Mar 2022 23:48:12 +0000
Message-ID: <1e3f07b6-921a-d901-f9bf-96a9628ba1e7@oracle.com>
References: <20220319062833.3136528-1-jane.chu@oracle.com>
 <20220319062833.3136528-3-jane.chu@oracle.com> <YjpQlmGCFFQueHS1@zn.tnic>
In-Reply-To: <YjpQlmGCFFQueHS1@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3472d944-1ccd-4ff2-6df2-08da0c5e6cf9
x-ms-traffictypediagnostic: BN7PR10MB2514:EE_
x-microsoft-antispam-prvs: <BN7PR10MB251419C3D85E71D18A5AEEC4F3179@BN7PR10MB2514.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M1ZDwHo1eu1ypKTnj/dO4oApbjyX0ukpEJKyYx7I0EQv5LZs4wo3PNi7Jf3ysZsmt7Uka8qaoFiHI6kwfUrHKrwZPw5OS+56k9YWgd3exHNVlY8sUi2Sds3fPsrcKoXsxj7GTna6C//w5WmCXWR6aA9BrjcPTiL491pj8FRPo0T4FtuACJw5HGb6qOTqu5l4QpF6X1+Gc8e9hyW0n1aEbHqdqHB2jM+Ta7cdpvxYDBjwD4u7I/JCzqna7vyk3oG6MuVuDgRUrApMwi9OPd+cxKZZZD5WVRA4TtyDOSFRmDAM5l3NZ/notufPouVgdyMisZt3RGWvqpZfXYMY0AX29TNy9krf/1ZM/xCZMk8vXSp4kaW88/SUXSkokeKNxDiQmr6d7Drvnb/YlAD2qCCNCj9xfew3cclaOFacMFgCzoXgOV7blS0CoRqc0g+qwG/cIlOZ7TXkFLO20R7bbtYlvTgrhJ/6B/jcqPSyzZQy3WA+hh+2aHlLlkWwG5rmZ0LbWYigRzClQNW0RmCsF9gTCFIjvxwU8BuV+H+PpbvU5O0dYm2er5Fh0+kRJ0RhQKwctsKifwtTUpWqUO1c8BFuAkh6s74ayM5zLy1VFbOVN1oAMyaX3prCu+AbgSbkCUX/WrUQ+vSY+jI7GSShfT2U+9tJd2OBZLyI9BaREp2E6zx3ZRfyc/ZfZcH5srbtkeVcsRL30jDn7NuFDEvnqAW9VutmrapN/etLbYss5QhJmBZ9c1cBoDbKwYqUJP/CthHE78JOa4V2qtNKQF0w2hmFQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6506007)(6916009)(186003)(54906003)(2616005)(6512007)(6486002)(71200400001)(36756003)(31686004)(66946007)(66556008)(76116006)(4326008)(66446008)(66476007)(8676002)(53546011)(64756008)(91956017)(508600001)(38070700005)(5660300002)(122000001)(31696002)(86362001)(7416002)(4744005)(44832011)(8936002)(316002)(83380400001)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUJuSlRNRDNNVlE1VEJjendLWTR3RmZqTjJ5S3dhM2JYL21jQndZV1cvM2da?=
 =?utf-8?B?M1Z0clNKOTU1YXEyR0dXK1RSQVQxd0ROVEhTRmNWYTF1dDc5c2ticW9hSHVi?=
 =?utf-8?B?aENuenFjOGhEamVMWmlQdlZWaWRCTDlIT3NhMlRyclJlbTZlVTQrV3B6bmRX?=
 =?utf-8?B?VGFJM1dmMmd2bFJzZkY2anNsZjRhZ3RsellIMXA0S2NZWHBuRkhGbG5CM2NB?=
 =?utf-8?B?b0d1TDRFR1E4c2VHV0h0TWY2MXE1N1JDWWx3ZlVQbzh3ZXMyU1haZy8ySXRY?=
 =?utf-8?B?ZGI3OUxoNDg5aXd2VWxFZG5pTUFXbU5sMnJhZWMzU0FUWFczMGtST1lEbVhF?=
 =?utf-8?B?cXdSVkNMN0NWMk5TdkNKNS9sSUlMeHVmaGJxa2lIMGpRQWdRTWwwQ3BZUGdS?=
 =?utf-8?B?TVJNZThtdnBsNGJQRjRhMEkrU1pNdVJDWjRYNENFZE5LNlJMUkN5d2ZDZXRq?=
 =?utf-8?B?a2xLUUhPeGdBQW1JdTlxbTBtTk5iYTB5WnFZbXRFRnZ4YzltMjlGK0tSY0Y0?=
 =?utf-8?B?aHR5NkZoN21JZ0ptK3Z6bDVsZ1R5Z1Y1d2dCMGhTS2dCRFJLeWdIeTMvQ3ht?=
 =?utf-8?B?YlJjNGIwUTNTY0psMWpVVHU0TXVCek8zaDRUeVN5L0luSzN4WGw4NmJpQ3la?=
 =?utf-8?B?UlpyQ2JWMHEvcmUrVFJmVy9teVJyZmRWVG43TmM3R1hCSHlpT2R3RzFMb012?=
 =?utf-8?B?YXRtV1NheXBPa2ZNOUxZNUVpYXIyMW1hMmx2R2J1YnhIakxoWEMxT2FkZkZt?=
 =?utf-8?B?MjY5b0hGUy9nNFVoM3IxeHpMQUxPb3BSamJJZCtoQUtwUmI1YmNOTHUySGJo?=
 =?utf-8?B?enUzOEtFdVNleVZYZTR0R0MrNXVCcm82Y1ViM0ViallYTUtUeENDclF2N1BR?=
 =?utf-8?B?RFhFT2t4MzlQaU1QakpoZHNoYnVyTjdhRUJGZ3pjWTZtRzF3RnRNYjZkSk4r?=
 =?utf-8?B?SkVMMGdWNXIydGt1VS9OcmtnNTdEMnhzcGo0NWRHTG1xcVNoejBwdHV2VWhL?=
 =?utf-8?B?dmFVa04xcFlUMXVaYlJTNFBxd0lkRDJWT2FaWGI5a0Zlb0RJQW4vTzBwL0xp?=
 =?utf-8?B?MndLMGRRSU1nN3RZSktsejNPZ0drMEVyV296ZFVRaWJ1NkNtNllwWTJHOU5u?=
 =?utf-8?B?cWVObENrWDN6NmZsZkVRQlhGeE91SWRQTmVUY3NhSkFESnBYWk54a01xeWI4?=
 =?utf-8?B?YXo4OGx5YWQzSTJyOWFvNUsrWktJZ3BobGp5d29qeC9zQ0I1SGF3S1JKcVZH?=
 =?utf-8?B?c0RmdlYwK0RnN1BKM0p1MURoN0hpU2hRQXJSQyt3SEtMSUZhWUMwOUlQbjg3?=
 =?utf-8?B?WktpWTVadW10NFI3cHpkbGVEMEZIeHpiTHM2aWNRa0JSejFTbTdRVi9maGx5?=
 =?utf-8?B?bGlheWN1UE5aa01iZWtFdWwxTE8wd0thaTBaOVJSU1FVZURoUDhsT25UQlJC?=
 =?utf-8?B?M2RvWWVZMlVrdFNTQVk0SVJWZmtGNFFzaHdMWGRvckZKL21qdFdkbkFiRUtn?=
 =?utf-8?B?Yk1lbG1KejRuWE5iZmp5QkxZRG5ESldPTG5Hcys5S0drcTNId01EZW1CTkZB?=
 =?utf-8?B?enQxb2g4VjZVUE5EaWNobG4wdXdqc2o2M0xHcjNIUnJkU3VyVjIwSSttajVo?=
 =?utf-8?B?bVhZd3oyNFJEZ2RpbWd6NzdHd2s3aGErdyt4SGdqTXpZVXJPWGxMdDdSVHlZ?=
 =?utf-8?B?ZUhlekhhRFM4cTBoL3hKKzhxUzJEaForMDd0SlAvbDh6WWVFWU5oZmxxMlRQ?=
 =?utf-8?B?NGlrNmd2dWw5Vk1DL1VuOU5hM25OTWt5Z3p5d0kzUENDYWZ4MGFXUXNVWEcw?=
 =?utf-8?B?MHJ5eFhlSUd4bERXSWdpUTNQNytvaCtBenhCeUxQZVYxUm9aT0lQRktsa3lN?=
 =?utf-8?B?WVFSaytSZjlsQjFXOHBhMkdYa3praUE1YmNjU0crRnBUNmpVMkl1SHFOR2F4?=
 =?utf-8?Q?MsNem2RglR/0RMabeZYvokYx4Jb5bWuc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D475B32BDF336B40A1E65B545A6751DA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3472d944-1ccd-4ff2-6df2-08da0c5e6cf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 23:48:12.0779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5VBmDgSaWsdtdRkxlDbDx9dDXGK46i2ofW0ei3flrcJWKetnu19288tMyEqO5w9KZGNbv/eSgYzlVLieF4mqKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2514
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10294 signatures=694350
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=891 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203220119
X-Proofpoint-GUID: wu0cdQmiCMZRB22hIRjakTZajdUVw11K
X-Proofpoint-ORIG-GUID: wu0cdQmiCMZRB22hIRjakTZajdUVw11K
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy8yMi8yMDIyIDM6NDEgUE0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gU2F0LCBN
YXIgMTksIDIwMjIgYXQgMTI6Mjg6MjlBTSAtMDYwMCwgSmFuZSBDaHUgd3JvdGU6DQo+PiBSZWxv
Y2F0ZSB0aGUgdHdpbiBtY2UgZnVuY3Rpb25zIHRvIGFyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5
LmMNCj4+IGZpbGUgd2hlcmUgdGhleSBiZWxvbmcuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSmFu
ZSBDaHUgPGphbmUuY2h1QG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+ICAgYXJjaC94ODYvaW5jbHVk
ZS9hc20vc2V0X21lbW9yeS5oIHwgNTIgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
Pj4gICBhcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9yeS5jICAgICAgfCA0OCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrDQo+PiAgIGluY2x1ZGUvbGludXgvc2V0X21lbW9yeS5oICAgICAgICB8
ICA5ICsrKy0tLQ0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDUzIGluc2VydGlvbnMoKyksIDU2IGRl
bGV0aW9ucygtKQ0KPiANCj4gRm9yIHRoZSBmdXR1cmUsIHBsZWFzZSB1c2UgZ2V0X21haW50YWlu
ZXJzLnBsIHNvIHRoYXQgeW91IGtub3cgd2hvIHRvIENjDQo+IG9uIHBhdGNoZXMuIEluIHRoaXMg
cGFydGljdWxhciBjYXNlLCBwYXRjaGVzIHRvdWNoaW5nIGFyY2gveDg2LyBzaG91bGQNCj4gQ2Mg
eDg2QGtlcm5lbC5vcmcNCg0KU3VyZSwgdGhhbmsgeW91IQ0KDQotamFuZQ0KDQo+IA0KPiBUaHgu
DQo+IA0KDQo=
