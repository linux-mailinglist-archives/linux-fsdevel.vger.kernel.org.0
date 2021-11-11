Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D85244D313
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Nov 2021 09:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbhKKIV2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Nov 2021 03:21:28 -0500
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:37697
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229674AbhKKIV1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Nov 2021 03:21:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZQUdf5nxgvDD4j368ktZWf3TfTknphGqoTpncLROPAu3vEkztJSQpOMHncb2ZBT0jqSVf7BHxCnGmVA7xzZzQp7ny6mOilFpXI2jBK1GbIlOOoEecBy9ygsmP/k1fQv8cEuakaTNh+bgTPLtwIpPf/9S6Pg52s8XvKBIQCjmRuMEZXSTUIfFWMmLx25kUEa8/HvrQhU7tcwfB23rfKTmNsqWega8s2e5wFgpmB+rcDJaHrlRzENiM2QDkn0z4doi0KwhCSHQSBbnKeif3XOCwCPpj3d9vDOgkD6u11WXCI2+c5PAD+LUS/u5osUq/fsnPiJAX24ykQfZoNd76kXqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VMY1kAsX31VODTUXEgsMfU+X7kkGqHl5MWXwdh/FW8=;
 b=lybI/be676wupu4njY66ZTDJLEiecjAggXi+rgRGFjvtPEQg44jIH0wv6h5vjhpEcF4HbJ0purFGkr1CQv6sBp3BCBdNs+BSBbfzPDMy1cpm9gRfG7i3Bi1uo4cikCr481/qhxlsnBHOgO827mGkpDUtxSTYyfHDscybwji+XlzJwYYS9ffEf2oQCSkcu2UQ3BdjsL41HFYK5grCrRCm8Ajr6I+HDnVXHVAHw7mmPqNWEAw77DgyyXtkWzXLl8TAK6oLZniJ0SVEn2AWo9U6HSWqgGhvw0oAlt8yDrFoGfER8O+pnNL0JAF4qbsmPUaZ0rtMIFBxTAKdRecFKFE1HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VMY1kAsX31VODTUXEgsMfU+X7kkGqHl5MWXwdh/FW8=;
 b=kHAfPLFPU19yc0rRPQeY99jKi3knAFnIHVXd71v2w+yo+bqmXRDIqZbwXZ76+I3vibeYNGdBXOu/cDV7SUhgSfymXDlkMmOLexIx/jompc7sCtuDUaDm4G3Wef0K9YD4tUMC1cYV/E7sCbFVYaQCAdlzRKAIt2uvE3VAtRmAxJ9TF825EyIAhmGMvOTiS6a5TS/GydX0tgCWPWjrkTvJgl8ELtRC7xtZorDNEQIpg/pVuMIrByLz+BesBYIb9Uq6rLJIwPPMoCPyyfQp/xXv6KOAVIxv1J0m55xkCR4ZZgnMyELjHa5OHJaGN0dwNiZpGiUh36OdLnh+P0O19z3LvA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1727.namprd12.prod.outlook.com (2603:10b6:300:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 11 Nov
 2021 08:18:32 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 08:18:32 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "song@kernel.org" <song@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "javier@javigon.com" <javier@javigon.com>,
        "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "jack@suse.com" <jack@suse.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [RFC PATCH 0/8] block: add support for REQ_OP_VERIFY
Thread-Topic: [RFC PATCH 0/8] block: add support for REQ_OP_VERIFY
Thread-Index: AQHX0UfJUBDssfv+ckmT1a3v6/33Gavy9LOAgAAlMQCAAId1gIAKZYUA
Date:   Thu, 11 Nov 2021 08:18:31 +0000
Message-ID: <1a4074a0-0826-1687-fe06-0f078b06aae0@nvidia.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
 <20211104071439.GA21927@lst.de>
 <661bcadd-a030-4a72-81ae-ef15080f0241@nvidia.com>
 <20211104173235.GI2237511@magnolia>
In-Reply-To: <20211104173235.GI2237511@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6b1a03d6-b77d-43dc-1ed1-08d9a4ebd956
x-ms-traffictypediagnostic: MWHPR12MB1727:
x-microsoft-antispam-prvs: <MWHPR12MB1727C03C36E54A9ECBC2E353A3949@MWHPR12MB1727.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zNIj3o2scKGCWxXb0yv63RL/IsdRZNWvMzm/Rdc35pixonlR9HhvXdl7V8cI1F7dA0vHnPEQtJeUHw+wt+25TF8BwKGONIdyZuWIRpfoglr/Emo0kP8v+71Ix+LnJCzWPqZ69Dco6cbPwZ6D7J5ubahH8oWfwzqBzztt22JNEqCpdv73oV3qB0FflfIwlzr7oAIa/qSt4JLH/Z2p5eaDBtXDZuwSQy1UNouPLu2kSqznQobrfo6Vk7fKiqXiUV5dmUaLk75fIAMobbzAD6lmNFKa9n9jKMiNAcOx6UYktO80fNhPBB2Hb0PORVfirDN0ndT9syWkorSSuTxF8xRYqTTAZdwCdPwkEVFWdV/m0Jv+soY2p5wijg+uzYnDHUidc0rgHXnfZgoQAQ9rN6JDR+JgjKaz44lv1ZpXmXQnMeFiKX6jxSE4eOLwlSRREHVqkwG+KojY/8DZievybzXml4J1yHeCRVUPAMKf3dCZJkRgmNjWTcxZ7+PfrcJCzBX0PT3eUW8I++hknIBTFLevG1tVzFuGSKPoIYMkBtOFgC/wu7/HErfr75wubl5MOiy+oprYC9k4WFtJVabp6KdbIjQFQ3Q+lMMUIKRaK6aY902dwlx7HxlPvwGnEiilzoJ/KnGkPwJaN2jFvw9tGxamGHszN1x+eEVcTm2mzL9c79tdc+keDD6hT0r3UuztPuFZS+EzpsZ7twlrwv6VZkiqekQl6COXqQGbLMZbEE6OOfkuD9CX2nRHIz0XfV2ojeqxENj70xS6CdUP/tJmFCrDwQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(53546011)(6916009)(36756003)(31686004)(6506007)(86362001)(122000001)(2616005)(4326008)(5660300002)(76116006)(6512007)(38100700002)(508600001)(316002)(54906003)(71200400001)(6486002)(31696002)(186003)(8676002)(64756008)(8936002)(83380400001)(66446008)(66556008)(7406005)(66476007)(7416002)(2906002)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L21wRm1WcVVaYm1nOHhIaHFwZHo5NHhyMlUyWjhGU2hzQmhidDlhMTVaV2xQ?=
 =?utf-8?B?QXpoYmNianJEdlpobUZxQ0JSWjIxeVVweWlIVVpFaEU1OEVZT0lIV3RBVmhx?=
 =?utf-8?B?VEwzMFJxOVlCZWVyd0FkbFpSODNueHduc3R4eTR1V1hJQUdua0xwekk2T0NE?=
 =?utf-8?B?S2x6SWhSU2hiU2xhMW9rR0QxZ2FsU2l4ZU9tczhXR0NzZHBaOHFkTmo4TG9k?=
 =?utf-8?B?aVR2Z1d5cXFyS1pEblJlK0hQN3NJYUpueU5iOEg2WHBSQ0VGVUY4NjdxTWJp?=
 =?utf-8?B?K0NLSDVPc0NEbWNBSTlXaU8vOG9PTkUyVGlwb0xmRy9LUm1paU9abFY1cDMx?=
 =?utf-8?B?OFJrbGhRSDBtS1hUTk5QYzF6VC81aWRwaGNhTjQ0VmNOOUxqMGVzMVZkenRF?=
 =?utf-8?B?OWxzQW9YRVdvUStTekFneVc2clQ3bmRtNGhhV3JQMVc1RE1tWTVWdkNwQk9K?=
 =?utf-8?B?TmdhNStGbFFzYmJ0S0h1MytTY0tZeDk2d3ZGUWJNaC8vbjZCVGY2b2pheXR3?=
 =?utf-8?B?Q3BQZHJubm9rdXFXc25DMzNZMTF4QnlGZE5IbG04eXZhSVRyK1lkUGlnRWxx?=
 =?utf-8?B?Q2NDOHd6TnRVSlVIY0VNUGRhOGxLZ25wRm5WMkVCb1g3UDhMSEcya2hMbjJC?=
 =?utf-8?B?dVFRdU85Ynlkc1JMUk9kMDFWVHhiYkVzcDNEbktVZzVuTnRON0hqMXRYQUs4?=
 =?utf-8?B?NS9hNTZZZlpqSFRBRjRkbUxBZHFKeSsyY2hzWEtoZ2d6bk9NeVRqUWJ2ZlFK?=
 =?utf-8?B?TEduejBkWHVBdWlFR3pEQVl5TEY0Sk5TMjhUNnNLVmNMNGY4M1QwMnNlSE93?=
 =?utf-8?B?enQ3VjllbzBLUnZUcmEydlNsSDU4cXNUanByYzl1TUtlcVJSemlvRExsUWdN?=
 =?utf-8?B?ZkpKb0JzN3cvU05Wd0YyenlQem1lYTJ6S21KOVdXclNCbmp1cDFNdi9hdC9P?=
 =?utf-8?B?N2lWWjQ4TnRYNVRMZGR3aTE4OTV5WVNUVldacXE3Rk14cjA0TzhyRFYyaHgr?=
 =?utf-8?B?WlU4NGlpN3BFeVZaamVrcDhZWksza3R2cnVNdWM1OGJTamRyVUkvSis5VHBW?=
 =?utf-8?B?eXpnb1RDaVdPZjRSUWNDOWlzS1hhQmRoRFJWc1MzYmJucHo1YVdWZTVxeXV6?=
 =?utf-8?B?THByN2lPdys4WkRsWnloeFVudm5UdW9QK2hCd1ZzUlgvbGYybjdaZW5MUU5B?=
 =?utf-8?B?YzNremlTMEppZmM2VnhWT1JUMzBsM3hrblZoTjd0NWZVUDNyMnRvMkY1cnY4?=
 =?utf-8?B?SHN5aFltdHRhSjdxaUFpUG5iVVc4UUh2RmtNNEU2VFdGcUxCanlBOXdwTEdZ?=
 =?utf-8?B?ME83ellTeURYNk1QU1FXUnp4YmJGOEJHUFZiMGdFSS9BV2NLTEwwTFhnR0pn?=
 =?utf-8?B?WVAwZXpIOVFWVFF4QWNwTU9XQVY5NExPRTFYVFFiUmN2MGQ4TWdWaldSL2hK?=
 =?utf-8?B?Tzg5TldTQkxhM0ZaYTE3NGQ1ZjhjSSt4RHc4cExia3ZZM0Y4dC85VVN4bGl3?=
 =?utf-8?B?NGlSVmNIK0V6d0Rub0kyTCs3amhiRVlGNitJWnJzRWU0OHZ6RDJscDVXQk5l?=
 =?utf-8?B?MlJWb1hYN3NTL2Rucmtsd3ViMVF0Y29JZ3F2Y3ZZSWtFWVQwamIyeDFFb3lE?=
 =?utf-8?B?Y1NXWDFzb1FqdzFreVljVFVLdU9uVS9SQ3g1dzgyaDY3K1lVb2lUZkMvdDBP?=
 =?utf-8?B?QmhLUFBxT243OHhpSmJib3hmNE9zUTNJSEVKK2kyNmFZTTE1NnFLdVVLV3pj?=
 =?utf-8?B?RHlTdUMrRDdFMzJtL2hJWU1Mc3lrWnFrbVk1Z2ZJWkRwZXFHUm54Si9lSDQ4?=
 =?utf-8?B?VVRobWZ6VEpNRG9EaTcrL0ZYTEgvc0YxVEJxemJVRk0zdi8yblNqWUJReFEv?=
 =?utf-8?B?ZDYxWVFQMXFFS3ZXcHloWS9YeC9QN1JBLzlCaWdFclRPcGxWMTIwdHg3a3Vi?=
 =?utf-8?B?VDRWYWdudFJra0VoTXRmeEZ0ZWdIV2c5VHlya1VJQ1pSQ2ZGaUVwbG1rRE10?=
 =?utf-8?B?ZUZyVTlkTGQ3VjBWbUxRWjYzS0N0Zm5nWHhRUVdiZEE1ano1S1B6YkVRZk9O?=
 =?utf-8?B?UnkrVzJVcVNMeS9sWVkyWXljWDQ1OEY4T045ekNUSmcvNFp0bEUyZlYyeFpr?=
 =?utf-8?B?ak5mWGlMdi9aR3JXNmQ2aHhZMWNDdEV6YUU3bnh1S2FzZ0owc29Wb2RTbnN4?=
 =?utf-8?B?Tk5mT3lQM2dHM2hUaE5nWG42WS83U2tZTFZUUlhIZ01vNW41ZC9kTy9tMGd6?=
 =?utf-8?Q?vHZKaRCKyTGlVZYFMsyr/H+bcwR0ZKEBRtqDort1HA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F32F88974F175047A4B3EDC7344C37C4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1a03d6-b77d-43dc-1ed1-08d9a4ebd956
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2021 08:18:31.8106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JJYBYnpOmdeZBVmOndnxVUpLWEMkwhVNpFJjkJA+Txu6rMcoYzesmwy8Mv90DUjgitRtJry8Bh6v9nGgmC/mGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1727
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMTEvNC8yMDIxIDEwOjMyIEFNLCBEYXJyaWNrIEouIFdvbmcgd3JvdGU6DQo+IEV4dGVybmFs
IGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0KPiAN
Cj4gT24gVGh1LCBOb3YgMDQsIDIwMjEgYXQgMDk6Mjc6NTBBTSArMDAwMCwgQ2hhaXRhbnlhIEt1
bGthcm5pIHdyb3RlOg0KPj4gT24gMTEvNC8yMDIxIDEyOjE0IEFNLCBDaHJpc3RvcGggSGVsbHdp
ZyB3cm90ZToNCj4+PiBFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBv
ciBhdHRhY2htZW50cw0KPj4+DQo+Pj4NCj4+PiBXaGF0IGlzIHRoZSBhY3R1YWwgdXNlIGNhc2Ug
aGVyZT8NCj4+Pg0KPj4NCj4+IE9uZSBvZiB0aGUgaW1tZWRpYXRlIHVzZS1jYXNlIGlzIHRvIHVz
ZSB0aGlzIGludGVyZmFjZSB3aXRoIFhGUw0KPj4gc2NydWJiaW5nIGluZnJhc3RydWN0dXJlIFsx
XSAoYnkgcmVwbGFjaW5nIGFueSBTQ1NJIGNhbGxzIGUuZy4gc2dfaW8oKQ0KPj4gd2l0aCBCTEtW
RVJJRlkgaW9jdGwoKSBjYWxscyBjb3JyZXNwb25kaW5nIHRvIFJFUV9PUF9WRVJJRlkpIGFuZA0K
Pj4gZXZlbnR1YWxseSBhbGxvdyBhbmQgZXh0ZW5kIG90aGVyIGZpbGUgc3lzdGVtcyB0byB1c2Ug
aXQgZm9yIHNjcnViYmluZy4NCj4gDQo+IEZXSVcgaXQgL3dvdWxkLyBiZSBhIHdpbiB0byBoYXZl
IGEgZ2VuZXJhbCBibGtkZXYgaW9jdGwgdG8gZG8gdGhpcywNCj4gcmF0aGVyIHRoYW4gc2hvdmlu
ZyBTQ1NJIGNvbW1hbmRzIHRocm91Z2ggL2Rldi9zZywgd2hpY2ggKG9idmlvdXNseSkNCj4gZG9l
c24ndCB3b3JrIHdoZW4gZG0gYW5kIGZyaWVuZHMgYXJlIGluIHVzZS4gIEkgaGFkbid0IGJvdGhl
cmVkIHRvIHdpcmUNCj4gdXAgeGZzX3NjcnViIHRvIE5WTUUgQ09NUEFSRSBiZWNhdXNlIG5vbmUg
b2YgbXkgZGV2aWNlcyBzdXBwb3J0IGl0IGFuZA0KPiB0YmggSSB3YXMgaG9sZGluZyBvdXQgZm9y
IHRoaXMga2luZCBvZiBpbnRlcmZhY2UgYW55d2F5LiA7KQ0KPiANCg0KWWVzLCBpdCBpcyBub3Qg
cG9zc2libGUgd2l0aG91dCBhIG5ldyBpbnRlcmZhY2UgYW5kIGltcG9zc2libGUgZm9yIGRtDQph
bmQgZnJpZW5kcy4NCg0KPiBJIGFsc28gd29uZGVyIGlmIGl0IHdvdWxkIGJlIHVzZWZ1bCAoc2lu
Y2Ugd2UncmUgYWxyZWFkeSBoYXZpbmcgYQ0KPiBkaXNjdXNzaW9uIGVsc2V3aGVyZSBhYm91dCBk
YXRhIGludGVncml0eSBzeXNjYWxscyBmb3IgcG1lbSkgdG8gYmUgYWJsZQ0KPiB0byBjYWxsIHRo
aXMgc29ydCBvZiB0aGluZyBhZ2FpbnN0IGZpbGVzPyAgSW4gd2hpY2ggY2FzZSB3ZSdkIHdhbnQN
Cj4gYW5vdGhlciBwcmVhZHYyIGZsYWcgb3Igc29tZXRoaW5nLCBhbmQgdGhlbiBwbHVtYiBhbGwg
dGhhdCB0aHJvdWdoIHRoZQ0KPiB2ZnMvaW9tYXAgYXMgbmVlZGVkPw0KPiANCj4gLS1EDQo+IA0K
DQpBcyBwYXJ0IG9mIGEgY29tcGxldGUgcGljdHVyZSB3ZSBvbmNlIHdlIGdldCB0aGUgYmxvY2sg
bGF5ZXIgcGFydCBzdGFibGUNCmluIHRoZSB1cHN0cmVhbSBob3cgYWJvdXQgaW1wbGVtZW50aW5n
IGZzdmVyaWZ5IGNvbW1hbmQgbGlrZSB1dGlsaXR5DQp0aGF0IHdpbGwgd29yayBzaW1pbGFyIHRv
IGZzdHJpbSBzbyB1c2VyIGNhbiB2ZXJpZnkgdGhlIGNyaXRpY2FsIGZpbGVzDQp3aXRoIHBsdW1i
aW5nIG9mIFZGUyBhbmQgaW9tYXAgPw0KDQpPciBpcyB0aGVyZSBvdGhlciB3YXkgdGhhdCBpcyBt
b3JlIHN1aXRhYmxlID8NCg0KPj4gWzFdIG1hbiB4ZnNfc2NydWIgOi0NCj4+IC14ICAgICBSZWFk
IGFsbCBmaWxlIGRhdGEgZXh0ZW50cyB0byBsb29rIGZvciBkaXNrIGVycm9ycy4NCj4+ICAgICAg
ICAgICAgICAgICB4ZnNfc2NydWIgd2lsbCBpc3N1ZSBPX0RJUkVDVCByZWFkcyB0byB0aGUgYmxv
Y2sgZGV2aWNlDQo+PiAgICAgICAgICAgICAgICAgZGlyZWN0bHkuICBJZiB0aGUgYmxvY2sgZGV2
aWNlIGlzIGEgU0NTSSBkaXNrLCBpdCB3aWxsDQo+PiAgICAgICAgICAgICAgICAgaW5zdGVhZCBp
c3N1ZSBSRUFEIFZFUklGWSBjb21tYW5kcyBkaXJlY3RseSB0byB0aGUgZGlzay4NCj4+ICAgICAg
ICAgICAgICAgICBJZiBtZWRpYSBlcnJvcnMgYXJlIGZvdW5kLCB0aGUgZXJyb3IgcmVwb3J0IHdp
bGwgaW5jbHVkZQ0KPj4gICAgICAgICAgICAgICAgIHRoZSBkaXNrIG9mZnNldCwgaW4gYnl0ZXMu
ICBJZiB0aGUgbWVkaWEgZXJyb3JzIGFmZmVjdCBhDQo+PiAgICAgICAgICAgICAgICAgZmlsZSwg
dGhlIHJlcG9ydCB3aWxsIGFsc28gaW5jbHVkZSB0aGUgaW5vZGUgbnVtYmVyIGFuZA0KPj4gICAg
ICAgICAgICAgICAgIGZpbGUgb2Zmc2V0LCBpbiBieXRlcy4gIFRoZXNlIGFjdGlvbnMgd2lsbCBj
b25maXJtIHRoYXQNCj4+ICAgICAgICAgICAgICAgICBhbGwgZmlsZSBkYXRhIGJsb2NrcyBjYW4g
YmUgcmVhZCBmcm9tIHN0b3JhZ2UuDQo+Pg0KPj4NCg==
