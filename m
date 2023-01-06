Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6E465FAFA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 06:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjAFFqa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 00:46:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjAFFq2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 00:46:28 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C927D3E842;
        Thu,  5 Jan 2023 21:46:26 -0800 (PST)
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3064gDjZ025234;
        Fri, 6 Jan 2023 05:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=5YJ5kMK5pyZMZgjgHylPOxjOKuXW/t4yQe4ybOFyZsc=;
 b=VRdAvW5Lx+8bk5ecVZEEbRWg9wbC4aUt52ppPeDPxVLrSRElO8O5tr2fVAVGSimTXomZ
 my5Yqu8lHGQ+w+jeDmTZHntdyPABSfC/jd1raomEfmWg4djeuPy5APztEEczQufIZOKk
 dfCpz2g9dHEnHBOk7X8HHdg81zE1yjDS+i6MO4Zs69Hcwc/hQpqQsS9O19yTFqjtC8Q5
 XRGQk6EiOLQ/Sm41nwC/Xy/aCYqqLcyvrhja8psSKt+MmBDMgnByW4A3OwKCVvNH9ZNp
 X0QMoSmFQHXjsdLFmfC3zg56a+q7EAktATUrfQfGFxsNw5Eq3bERyW5rvVw3PO5wjFs5 Kw== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2042.outbound.protection.outlook.com [104.47.26.42])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3mtbn6ncxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Jan 2023 05:46:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYAMMnA3NKo8DAVWYuNX1P/RRkTZom76HNZFOjM/WRK1QpIanOmpWhYQtBwQSuyLg6vWrMz22csehJQvl1kGX/iOhFOg7lDFonJOQXjIEk0S7KpzUiDm1Cky/gDy8S9DCqDJsn1rrXcnIjaj9qPUDSnwhSbd4xDju6Ty5k/3kzBA7lYT46jd5/qWRDfe4DmbCZ5ikjnhaHyY9VLgDNYnGKlzqMFwuPt0AeU/cB+fQMXElTcHFNetP8XVjWpKfcAHXxV24UHDtEU+9HWOCQzoorKHFsTM8AVsRy3vjpwtOxVY3Kl9L2+7OGFPz5AhQw1o3hQe3I44vg+dcCtneknSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YJ5kMK5pyZMZgjgHylPOxjOKuXW/t4yQe4ybOFyZsc=;
 b=B+jTabIOWEp+Ve+Kzgx70PJXHnG3yoWIydsG8b1F91nqXFOzPOIUskisSGe4ZQOTeUPTPiyr1dC2zI8Xn8L3AFQR3qhiACqri09/wxLpHTuyXLeEYlZZ7nqAcInq+lthV2lD1p0dr05JFYK0+M0DgB3J++J/3ias5ozRnF5NLD0Xhlh60NgXP8HEnJJUzMSYkOPnmU/zkeUFp7KeVD1vCUneasy0fgzc3Zmv65Cv2GcKs57FCWEOGw9BDJ8vE1KZulgolrP6uHQ48QFTbbBft210VkpgZO/tiBtOoFGcItnBzTLEbDv2tdV2L/sFmmZje94m8mjcOjaeSctz8mPslQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB5680.apcprd04.prod.outlook.com (2603:1096:400:1c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14; Fri, 6 Jan
 2023 05:45:19 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::1cb5:18cc:712d:1f13]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::1cb5:18cc:712d:1f13%7]) with mapi id 15.20.5986.009; Fri, 6 Jan 2023
 05:45:19 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>
Subject: [PATCH v2] exfat: fix inode->i_blocks for non-512 byte sector size
 device
Thread-Topic: [PATCH v2] exfat: fix inode->i_blocks for non-512 byte sector
 size device
Thread-Index: AdkhkSpzW+Z4xVa9TL695QpkCntjkg==
Date:   Fri, 6 Jan 2023 05:45:19 +0000
Message-ID: <PUZPR04MB6316CA04EFB01F79FD026F9181FB9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB5680:EE_
x-ms-office365-filtering-correlation-id: c96e237a-a844-46a6-e79e-08daefa93240
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uTtEZnyohjVJ+4JgzoGpCAjmE1979aOcOmK1tWATHdOXUKSfOFGnVk78+Xq3MKFindT6bcgPkVBYEg3AglR/lW0srlh7UDy3u3H+eh+l3FzXa8pB5fGwKUjuLD2X+lmoP4Rxl07STNKmDfvF6ENH4uRYUp0hvmDIrufV56JvhTTVtXY1EG3jugMh5fy2p2taptOnXRPygYPfMRSr88WMrmnyEXbU1nOxhdcJYiscju7YQ61wNbXFYtdvO1RcLEzReeZQcAQBVB78WAY7TwM+7pKlSNBBZvkUn4PA6aqrPlhBjinuNFbsDmygqVANTp4/bwJcNb95j3YFH7IXm3/vNu4gS0VXJsyjp+BKC4BsxmUtvsZ25yEM8g4EPLCvs+4wMdFIP8lMjBptmdAlhFseY3g/CKWUS6ruUhm72y1dJugPEXu9BrE6tyMIXLzQhoTfwt3538Zmp9/edZL7LZllv9BiPT4BZ9KUkjDzYE874zXKPJGRaGZ3l4uzvY6kDZ2wCOHnPr3LkLgg9ZXDiRht5p3VYYxwEe18kEfUBGuC7ON0ERtqwnA4mgx77nx96fGwu0grAZ8b3ewBt9+QQoEzZ9drbE5jFYLcPFPKu37tsuF/zag+HoihS7LxtATdrREqIKgr9doJXzRYGG4BCqyy01CX8vVQ6UX7QD/Awv0hLHAZwkIx/CghBx3S07EyUC7jbelM3Pguv2hs3RIhnO315Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199015)(38100700002)(33656002)(71200400001)(122000001)(83380400001)(8936002)(41300700001)(66476007)(66556008)(64756008)(52536014)(66446008)(5660300002)(107886003)(38070700005)(2906002)(66946007)(4326008)(76116006)(26005)(478600001)(86362001)(6506007)(8676002)(7696005)(9686003)(186003)(110136005)(54906003)(82960400001)(316002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmtSWHpkVmJMT0xaV0xienBhcTAxM1U2TG9MZkpEdkVEdVFpV0RJVktmQW1B?=
 =?utf-8?B?UE80YVM2NG9WcERHeFAwYmFxNWt6VWoxKzN5SlRtVmFPcUQ4S0s2M3VJTXhp?=
 =?utf-8?B?MU5MRlBoZUZLZWtac3BMbUVLeXhnSk1lUUU5dHR3QzUwc0pKLzhEU25PMDYw?=
 =?utf-8?B?KzRyQmpOMzN6SFJvK0lNUWlSNEFiKzdDMGZ4VzVNVkh4ZDNxVWxmL2lTL2hR?=
 =?utf-8?B?bGlvelR2MFUwb2l0NUpLa3RMaWN0NzFPWk12NCtJRWx3VEJRcGIyOWg1V25z?=
 =?utf-8?B?b1JmOG5sT0wyYzV4WlM0YW5WUmplNVdOdmFPRVdZaFQ0UXVoaHA2dlR5cndk?=
 =?utf-8?B?Ykt1dEhsaGpOcnliVVhJNkVQSUJTSEQrZ1puYXVSV1ZramtiQ3Jlb25jaWdl?=
 =?utf-8?B?aUpRZEJOR0RKcFhPbzBzS2FVaWNad0Q0K09HTWVPalJQSDhnM0x6YTljWkoz?=
 =?utf-8?B?cGlpSHcrdEM2VjROOU1ENXZENUVwTXhSWldiMThoVXVwTlpWTjZodHNaNG5F?=
 =?utf-8?B?UTBtYnJ2S2ZUKzFmWkxRWXlnYSsxcXZKc0ozNW5IQTYySEZpT3B4T24xVVE3?=
 =?utf-8?B?bTdtcEtDQlJhV2V5eUdmSmE5bkM3bW1ZaHg5RWxrZTZ0U2w1bFoyQTUyL0RW?=
 =?utf-8?B?Vzg0WEZNS3h3RVk0SWsxaHNYc1VWRHpVZ1pIemd3YVdNK0tNNHk5KzVZSHd0?=
 =?utf-8?B?cC9NOC9XYU1VM1FSRWpaazRmcU5DWHFZck5ReXZ0OU1McWdTa3AxcDZxRmRq?=
 =?utf-8?B?d1Nld1k1TE45S0k4ZnpIbE5CU2plT1cwNzZpTkZTMVpGOHIzQWxyeXlCK3VN?=
 =?utf-8?B?WVlzbG50c1BFbkp3SEhQc2MxakNpdUVEUHNSZ0hIZDFpaE85S1FLZERHNUFL?=
 =?utf-8?B?M0lQUGRUR0dUNmgvRnh0bG41VWljMXI1K05VQ1ZpVFRYU0h6VDFYeGZIUER2?=
 =?utf-8?B?NnBsSTg1NnNiUW8xOEVTS1F3a0NPZnREUFBQZ1h5c2hBcUcrR1JhNGxncGZm?=
 =?utf-8?B?RUZkQ01Xb2NtcmthNE1ZRzZWc0w5Q0ZrQXVKZnhOZXRPd0p0WmtqU0lKK0NG?=
 =?utf-8?B?bUVJQlVVVUR3MXk1TVlkZW1PdGhxaXoxN2o0YVBNNHdRak5EajVGalRHTjhL?=
 =?utf-8?B?UzlNM3J3Nk1OSzBPQlJaZDZpWDRRWU9GN3Y4SXh1SU5rek5UaHgzaWpvcDlH?=
 =?utf-8?B?L3IraU5KWXlRWHd4MkFmV25vU1Q4bWFiZXF0K1p3VmVtRmFUK2ZLNDRkRG41?=
 =?utf-8?B?bktqZzJ1WjJDRTJFeVpsSFliS2d5ZzlBYzY4cjczMjFzNWJwUTBQQnpKNHZF?=
 =?utf-8?B?cHhXYVFUcWxGeEhGdzlMK2hZR1BCRmVvNmN4MDdnaW1SYjFKV3J4Wk9ic3Jk?=
 =?utf-8?B?Nlh5V2dOWFpTWkM5Rk1IS3NWWDM4Z08wZFVjRFZESm5jN3ZDSUNUSDVBMmdZ?=
 =?utf-8?B?VjVwcjcwbjZWT2p1eDlEcEtQeVFyZHpjeHZnSXVjd2JSR3pSb0pZV0R1MENq?=
 =?utf-8?B?aXZ1a28vd1RFZ1FlWFFGdndrR3ZkejJtNW1GVDBtbUpUSnJLQjBlbmx1cHdX?=
 =?utf-8?B?cjdjejFxZ3BrQUFDeDAzQkI4bWlxSElrN0ZQNnJzSWR1Z1h4akd4ZjZLRnho?=
 =?utf-8?B?QnM5dTVTSzVQZ2dIVE8wMHMyTk1hUFhtSXc5U25QcGtLOFhjSmRGeTl6ZEZ2?=
 =?utf-8?B?amNwcDhLKzRXWGsxM3VERVlRUDMxbUo3bktDczhkUG5SQmJaWXluS0FiNktk?=
 =?utf-8?B?STJROHB1OTRXbzNzU1YwaGtKTjlYbUFWV3JlU1FBbEhZZ1BtTkdDYzFVYyt5?=
 =?utf-8?B?bHJKMEZzdVVUZ2pzdzNBK2htR3FXdnU2bVhBZVcvRTcrUUFtZ092enBWTW1p?=
 =?utf-8?B?S2JJRkRYcmVIckNINmd2ZElseFl3MWwrVFRpY1JzRDJzcjVGeGFGZUJMZEFj?=
 =?utf-8?B?d1ByZzZMckJ4TitQRi9OTjBsUnp6R01DTEJKSWNPdm1qbDFPd2NIbzBicTJ6?=
 =?utf-8?B?eXBPV3JVS0M4aEFlYU54bzB3elNMS2tSZ1Fjckhzb2hQdFJ0RjBmOEJML0ZN?=
 =?utf-8?B?T0ttbmduaGdXNnVOeVpGdUVBcUxZbUpxMXRtY2JGOXlPT3dJQ0RjUFRpMlZq?=
 =?utf-8?Q?GVK1G4fGQopqy0bo2hH3RwtbC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7/UcECzZB9kWiugmzn8TndAIuSPGmXy9DuLKXjqw5vg0wMF1MwgJyn/mgn9lkdCx14Dl3skj1PISOjnEqzQwSWMk71cnZeElMmg8+4IcFnUIrZqszR2DVf1UBxCqXCmzULvfqi/eAou+oXnMjVZCltTfZA8Lnaxdtyt5jblZ6bVsQWtGigN6lYWCeRbj1kSdtFm7RXJn/Iuij+HmPfltt+hKW7NLKOXUhDzEVvDix7LEQSZPQGxYj6aGvmPC6avcbACGliMnku9jSilr19RN2IL3Z5jKptN9LydOHMlp1nGQO7bXqCVYTPr/MdXJhBbaERA/PtLxsE4twFqIUxxGOMrRHNhQDk7nwGc/x0dYRiclJ239WqYsLD/SRT83r2bY2SlLsaHCgrV1/jJ1DfL+cIXjX1ZXkSbPJo8BVnWJ6I8k1cC6MJV23ku1YBcEmHj8rf+Kh+yjseZWuBO/dav+EF7dQJIYnFBirHELzcKs9ZpKkPjPGld58uSiC7ypDoJnMyYuGKnzgqTdy8rW15PpKhBdvQVgKIBzaJPNcTfalBY/5WT9EStFwTlAb/HELivAKtjMk6rywJk1M4Eaz4FssRK/20Cw0/+wM4CAQ6Uk5ZLVxUBUQNsi7uKSfVqpCqole7fPmCsIhopumwL78GiYsjmoDqtzd+P1mLoB5dovr46MTSw5Qwz8PiR6x0zrSB2563ejzvXxaxLBhvZCZhJcM6AIIM1avmTcoDJ6u5up/YwhQsOXk+eY1RiYrDaoPC8HLasjfebdzc+pmB6RpsQfPXPjBXK4zddZ354EttFtVLM5zDy+kAUolSdMKCiFL62EEUVchvGFTT8xOeT7hZUnOb7gXM+uyyUsYaS+G91WRAy/kKixF7afzlUuRVmeNxzV
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96e237a-a844-46a6-e79e-08daefa93240
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2023 05:45:19.7816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: prNCg2kqDSMZa22qo2Zjlz8/aaD0NLyB3fMsyBBSUtt/ujRnvHWOoUBeHbFoFgfFB5zHo4fWAsdsleEPNWmVYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5680
X-Proofpoint-ORIG-GUID: 5TgLCvXEqhm8AFNA0BTeXh-H_C5pqPkn
X-Proofpoint-GUID: 5TgLCvXEqhm8AFNA0BTeXh-H_C5pqPkn
X-Sony-Outbound-GUID: 5TgLCvXEqhm8AFNA0BTeXh-H_C5pqPkn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_01,2023-01-05_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

aW5vZGUtPmlfYmxvY2tzIGlzIG5vdCByZWFsIG51bWJlciBvZiBibG9ja3MsIGJ1dCA1MTIgYnl0
ZSBvbmVzLg0KDQpGaXhlczogOThkOTE3MDQ3ZThiICgiZXhmYXQ6IGFkZCBmaWxlIG9wZXJhdGlv
bnMiKQ0KRml4ZXM6IDVmMmFhMDc1MDcwYyAoImV4ZmF0OiBhZGQgaW5vZGUgb3BlcmF0aW9ucyIp
DQpGaXhlczogNzE5YzFlMTgyOTE2ICgiZXhmYXQ6IGFkZCBzdXBlciBibG9jayBvcGVyYXRpb25z
IikNCg0KUmVwb3J0ZWQtYnk6IFdhbmcgWXVndWkgPHdhbmd5dWd1aUBlMTYtdGVjaC5jb20+DQpT
aWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+DQpSZXZpZXdl
ZC1ieTogQW5keSBXdSA8QW5keS5XdUBzb255LmNvbT4NCi0tLQ0KDQpDaGFuZ2VzIGZvciB2MjoN
CiAgLSBkb24ndCBjYWxsIGlub2RlX2FkZF9ieXRlcygpL2lub2RlX3NldF9ieXRlcygpLCBqdXN0
IHVzZSA+PiA5Lg0KDQogZnMvZXhmYXQvZmlsZS5jICB8IDMgKy0tDQogZnMvZXhmYXQvaW5vZGUu
YyB8IDYgKystLS0tDQogZnMvZXhmYXQvbmFtZWkuYyB8IDIgKy0NCiBmcy9leGZhdC9zdXBlci5j
IHwgMyArLS0NCiA0IGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMo
LSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2ZpbGUuYyBiL2ZzL2V4ZmF0L2ZpbGUuYw0KaW5k
ZXggZjViMjkwNzI3NzVkLi5iMzM0MzFjNzRjOGEgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9maWxl
LmMNCisrKyBiL2ZzL2V4ZmF0L2ZpbGUuYw0KQEAgLTIwOSw4ICsyMDksNyBAQCB2b2lkIGV4ZmF0
X3RydW5jYXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQogCWlmIChlcnIpDQogCQlnb3RvIHdyaXRl
X3NpemU7DQogDQotCWlub2RlLT5pX2Jsb2NrcyA9IHJvdW5kX3VwKGlfc2l6ZV9yZWFkKGlub2Rl
KSwgc2JpLT5jbHVzdGVyX3NpemUpID4+DQotCQkJCWlub2RlLT5pX2Jsa2JpdHM7DQorCWlub2Rl
LT5pX2Jsb2NrcyA9IHJvdW5kX3VwKGlfc2l6ZV9yZWFkKGlub2RlKSwgc2JpLT5jbHVzdGVyX3Np
emUpID4+IDk7DQogd3JpdGVfc2l6ZToNCiAJYWxpZ25lZF9zaXplID0gaV9zaXplX3JlYWQoaW5v
ZGUpOw0KIAlpZiAoYWxpZ25lZF9zaXplICYgKGJsb2Nrc2l6ZSAtIDEpKSB7DQpkaWZmIC0tZ2l0
IGEvZnMvZXhmYXQvaW5vZGUuYyBiL2ZzL2V4ZmF0L2lub2RlLmMNCmluZGV4IDViNjQ0Y2IwNTdm
YS4uNDgxZGQzMzhmMmI4IDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvaW5vZGUuYw0KKysrIGIvZnMv
ZXhmYXQvaW5vZGUuYw0KQEAgLTIyMCw4ICsyMjAsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X21hcF9j
bHVzdGVyKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHVuc2lnbmVkIGludCBjbHVfb2Zmc2V0LA0KIAkJ
bnVtX2NsdXN0ZXJzICs9IG51bV90b19iZV9hbGxvY2F0ZWQ7DQogCQkqY2x1ID0gbmV3X2NsdS5k
aXI7DQogDQotCQlpbm9kZS0+aV9ibG9ja3MgKz0NCi0JCQludW1fdG9fYmVfYWxsb2NhdGVkIDw8
IHNiaS0+c2VjdF9wZXJfY2x1c19iaXRzOw0KKwkJaW5vZGUtPmlfYmxvY2tzICs9IEVYRkFUX0NM
VV9UT19CKG51bV90b19iZV9hbGxvY2F0ZWQsIHNiaSkgPj4gOTsNCiANCiAJCS8qDQogCQkgKiBN
b3ZlICpjbHUgcG9pbnRlciBhbG9uZyBGQVQgY2hhaW5zIChob2xlIGNhcmUpIGJlY2F1c2UgdGhl
DQpAQCAtNTc2LDggKzU3NSw3IEBAIHN0YXRpYyBpbnQgZXhmYXRfZmlsbF9pbm9kZShzdHJ1Y3Qg
aW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfZGlyX2VudHJ5ICppbmZvKQ0KIA0KIAlleGZhdF9z
YXZlX2F0dHIoaW5vZGUsIGluZm8tPmF0dHIpOw0KIA0KLQlpbm9kZS0+aV9ibG9ja3MgPSByb3Vu
ZF91cChpX3NpemVfcmVhZChpbm9kZSksIHNiaS0+Y2x1c3Rlcl9zaXplKSA+Pg0KLQkJCQlpbm9k
ZS0+aV9ibGtiaXRzOw0KKwlpbm9kZS0+aV9ibG9ja3MgPSByb3VuZF91cChpX3NpemVfcmVhZChp
bm9kZSksIHNiaS0+Y2x1c3Rlcl9zaXplKSA+PiA5Ow0KIAlpbm9kZS0+aV9tdGltZSA9IGluZm8t
Pm10aW1lOw0KIAlpbm9kZS0+aV9jdGltZSA9IGluZm8tPm10aW1lOw0KIAllaS0+aV9jcnRpbWUg
PSBpbmZvLT5jcnRpbWU7DQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvbmFtZWkuYyBiL2ZzL2V4ZmF0
L25hbWVpLmMNCmluZGV4IDVmOTk1ZWJhNWRiYi4uNzQ0MmZlYWQwMjc5IDEwMDY0NA0KLS0tIGEv
ZnMvZXhmYXQvbmFtZWkuYw0KKysrIGIvZnMvZXhmYXQvbmFtZWkuYw0KQEAgLTM5Niw3ICszOTYs
NyBAQCBzdGF0aWMgaW50IGV4ZmF0X2ZpbmRfZW1wdHlfZW50cnkoc3RydWN0IGlub2RlICppbm9k
ZSwNCiAJCWVpLT5pX3NpemVfb25kaXNrICs9IHNiaS0+Y2x1c3Rlcl9zaXplOw0KIAkJZWktPmlf
c2l6ZV9hbGlnbmVkICs9IHNiaS0+Y2x1c3Rlcl9zaXplOw0KIAkJZWktPmZsYWdzID0gcF9kaXIt
PmZsYWdzOw0KLQkJaW5vZGUtPmlfYmxvY2tzICs9IDEgPDwgc2JpLT5zZWN0X3Blcl9jbHVzX2Jp
dHM7DQorCQlpbm9kZS0+aV9ibG9ja3MgKz0gc2JpLT5jbHVzdGVyX3NpemUgPj4gOTsNCiAJfQ0K
IA0KIAlyZXR1cm4gZGVudHJ5Ow0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L3N1cGVyLmMgYi9mcy9l
eGZhdC9zdXBlci5jDQppbmRleCAzNWYwMzA1Y2Q0OTMuLjhjMzI0NjBlMDMxZSAxMDA2NDQNCi0t
LSBhL2ZzL2V4ZmF0L3N1cGVyLmMNCisrKyBiL2ZzL2V4ZmF0L3N1cGVyLmMNCkBAIC0zNzMsOCAr
MzczLDcgQEAgc3RhdGljIGludCBleGZhdF9yZWFkX3Jvb3Qoc3RydWN0IGlub2RlICppbm9kZSkN
CiAJaW5vZGUtPmlfb3AgPSAmZXhmYXRfZGlyX2lub2RlX29wZXJhdGlvbnM7DQogCWlub2RlLT5p
X2ZvcCA9ICZleGZhdF9kaXJfb3BlcmF0aW9uczsNCiANCi0JaW5vZGUtPmlfYmxvY2tzID0gcm91
bmRfdXAoaV9zaXplX3JlYWQoaW5vZGUpLCBzYmktPmNsdXN0ZXJfc2l6ZSkgPj4NCi0JCQkJaW5v
ZGUtPmlfYmxrYml0czsNCisJaW5vZGUtPmlfYmxvY2tzID0gcm91bmRfdXAoaV9zaXplX3JlYWQo
aW5vZGUpLCBzYmktPmNsdXN0ZXJfc2l6ZSkgPj4gOTsNCiAJZWktPmlfcG9zID0gKChsb2ZmX3Qp
c2JpLT5yb290X2RpciA8PCAzMikgfCAweGZmZmZmZmZmOw0KIAllaS0+aV9zaXplX2FsaWduZWQg
PSBpX3NpemVfcmVhZChpbm9kZSk7DQogCWVpLT5pX3NpemVfb25kaXNrID0gaV9zaXplX3JlYWQo
aW5vZGUpOw0KLS0gDQoyLjI1LjENCg0K
