Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C8E78BD99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 06:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjH2Evb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 00:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234840AbjH2EvE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 00:51:04 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019311B6
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Aug 2023 21:50:50 -0700 (PDT)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T2CthE004986;
        Tue, 29 Aug 2023 04:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=dnoL8fw4gbNSdVCT6FzfvAWl9JhHVkgeA7esLoe8fpA=;
 b=cc6hbJtIL7sHhIRef9cuVv9ZA36pXAL00ErCKHDxdGc5iT+gEYfYw51msPh6qffcB4ch
 mcY738rQL9OBdKFqKKVGlEOmIxZg5iu/lHHitqoNfb5sXmp6YrJQepXZJyO392zz53Zk
 YJxWz09ccnT951tjkOeGY+t1Cc2PWQB9daI+1WgDmnpsB7TIO/zhvzX00Cx+isTpR4ZO
 zunzjqLwaJeL548gDoSQ9YD4myRLIJHBL6zYQxSfNqOF1yg3YOHe0ylKQi1ulqdbpXNS
 ODhNVajbUDIPMZQ/qma5XhVPQO40TGbaxagkf93Ajc6W4RPDJEy3Lg+Z7uoJ8duaHKPx Rg== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2104.outbound.protection.outlook.com [104.47.26.104])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3sq9eq27vh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 04:50:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ryy6hSpCtS15W03C7tXqnJG7x3A++7YfHQK40WKMTMhkYuC+s3OA3YDV/S+FkQjvCH88pr2+uN5VVrbUNSpeGARBYvGzuRPrB3az8GNbN05qWtN+EZP0sjCDe1ucbGiZUpXveVWpzhNpUAidl4n606wtfL22FIlCwpE+wcsi2ZtbRXv4KpK5FXSvnBysLJoKVP353bFGAgdWM5rXQiJWVmYMV/8bysZ3bN2bmiumUCmGAxfeNjFq0NCsKQh3dEK+zN+0CqaTJL9xYBCTZr6qc6RGvbIqFuCHt0v9gy57XUmZTTI4jdwJA6CQAuXi1fadSGVTBlto4zA5WWJQ3/BzHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnoL8fw4gbNSdVCT6FzfvAWl9JhHVkgeA7esLoe8fpA=;
 b=KdlmjjO6tM7qvKv2HopVncsuUPMT6e+RwGCLGQDkSh5zuHEtVv7TZsEmXDW7OhJoBgYg1VAiA0nvscbbOMUF+zlvaSiYVnxsaPgc17CQpLQhWLtpFx14ZjoHr1YK/OyGkO7Y2fzah9tS9VvIwtetdYS77TtuVNRHVEQDbBVjsn1cycMldDbQp70Omlh7n6q2yEgECroV055W5YyB0lIqXbxrXIjpr4gawZdnOjiGmAWzw6pjynim2aGKb9EKJUlUli8ZfcfUBbVmw/agrPSz9DOpXcBBvvcrcz5tO1ubQHLH4H7gf4vv2Ax4pGQhliMTQQ8wb/9ADAVgl0uUMBYiLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB4340.apcprd04.prod.outlook.com (2603:1096:820:24::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Tue, 29 Aug
 2023 04:50:25 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::9391:4226:3529:ac7c]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::9391:4226:3529:ac7c%7]) with mapi id 15.20.6699.035; Tue, 29 Aug 2023
 04:50:25 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 1/2] exfat: support handle zero-size directory
Thread-Topic: [PATCH v1 1/2] exfat: support handle zero-size directory
Thread-Index: AdnaM6+rTi+c67iESxawzowej0Gbfw==
Date:   Tue, 29 Aug 2023 04:50:25 +0000
Message-ID: <PUZPR04MB6316A877D5BB3D12DABB3A4A81E7A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB4340:EE_
x-ms-office365-filtering-correlation-id: e236c12f-1021-435f-e1d7-08dba84b75fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rOu22CMuEg+QEUwQ5SIgVUu6Z/nlvMyT3PHILVowWCtRcrFhnZ9q98CMPSDQCPeVJOm9r2Jcr/g4onWy8z2MNcXObQLn9hYL0uRTvLRNHBIzGcSJz42mJxzdxaoy8m+R2kZUzW+GN5di/n4YGAiIgCFL6pJAddXjyAb4EJsGzwtPnXS0vO1Dc7Lrriy4u5kGSlRPephc2r7KKL+QqStPFrzYfecGeDsoMWUyYdOWbR89mpFN/7vvw+Xe7vtG+a/QLtGkcHh5Uu8nYqLfJE5NB14FrajIENZZ3Txr+PJIQWCljvudotIdEbPXQcZR4u6S1Z5mWpspsRXrdZdY7BhVW1ESMHwSe4Q4tfRr9NYtKBe5F71gPa249rhUDj+YPnvyIZp5SWNP6nNkpTuO2uWOe6F+spCEvFSRZVviZVcQTYFhR5gN6tgj+0/k8CyxzCj9pCG2q4RQDB4zd5QipgcHZUM+fy3kSZ+EChGeHK3seaJvSQE2dNk631N4qZmHTMkibNrYMFk6/428Kj3U6R2HKlJ9+6q+fFTOhfu6rOiXScAM44otuSqBVfSQvziHJnoeTr+k/Jg0U7HL+3ByAPEmJeyxWBSQJ9NxqsLOqB5FiL494RDHbnVcDTvvcSGNcBdm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(186009)(451199024)(1800799009)(9686003)(7696005)(6506007)(71200400001)(478600001)(83380400001)(107886003)(76116006)(26005)(2906002)(54906003)(316002)(64756008)(66446008)(66476007)(66946007)(52536014)(66556008)(110136005)(41300700001)(8936002)(5660300002)(8676002)(4326008)(33656002)(55016003)(122000001)(82960400001)(38070700005)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZVFJL1JheEhhU2ZTL2F1RXFmOEc4d05DZEdMNEZOYXhhRlFBeDlnMUVCN2Vi?=
 =?utf-8?B?emgwdEFHY3lJaDdyY0h6cHhUYkJNRXQxTHFrcEErclVMTXJBOUJTTE1nckNP?=
 =?utf-8?B?RnBnYTNJZmt0cTNmM3RRZ3BIam85WFJRVWdrcW00OUFsZklpTnc2RUN5YVI1?=
 =?utf-8?B?Vk1SbHBjSXJ3ODNsMnNxSXVkQ3Z4eXVwUElZZnA5RkRnZmdDeDVjTG1tTmVi?=
 =?utf-8?B?UVE4VU95anE5UXloc1RFd2ZreVJXTnRDWFJRb3lMU04vTGNma0UwSFZ1Wm9i?=
 =?utf-8?B?L2JtSy80SFZKZzZZUml2b1hYK1owaThkcFNSYkJVVGdYWEFZdlBvc096VFpK?=
 =?utf-8?B?WldZQmdPdGltTFUvcytQbFVxRnk3WmpTTnRHUzltRC9XS2tmbnpPZ0dMZ0E4?=
 =?utf-8?B?OXVrRkJ5NjlpNEpVZVZzeU9sQ0gwMXhBSFZUQmJ5R3o4VXB3cjRMbW5Qd010?=
 =?utf-8?B?MEFyQnV1MDUrNmQvMWZqY3JscmFGN3JBaW80aW9wY3p2VWhzS1ExblZnSUd0?=
 =?utf-8?B?Q08yWXFvbjNlOVkvNjVFSWwyQkdRcGF3UjBLUTBzd0R5ZUNwOEw0ei9obVZI?=
 =?utf-8?B?YmNaSnQ0M2hnbTc4OWtuTU9YNkhnWUtZRVRaY1llNTdQZE1KTXFmMlo5MjBh?=
 =?utf-8?B?SW5MUzlNenNYcXN6WEtEQjNXTlNRa2NLV0tXTDZINFE0S3dsdERwT1lnY0Q3?=
 =?utf-8?B?QU55dS9HbVlMcGZkY0hibC9jazFhaDFHaUN0VlF2L2MvTVNlKzczQUFaWlRx?=
 =?utf-8?B?UUlENWRtVU5RT2J1Ujdrb2tqdFgyckRrRExXVng1Q1hkRDR4c2IwNHppMmpQ?=
 =?utf-8?B?UmFndVZxb2VhR1Z1SnBZcDBXYWhFZ3hVS0lwWEEvOUhTS2E1TG5aalA3WkRV?=
 =?utf-8?B?YWFEYjlJL2o3TzgveFlZSlRhRFkzZFFVdWVpZVovN0MyRFJlUWVjRFNsTnV4?=
 =?utf-8?B?WWEycU9RcVVLam9NVXZNTmFad1VXUmhjVTlZVGJ3YnFmUCtLcXNmN3AvRDJo?=
 =?utf-8?B?Vk1zeWlPckdkZmN2SDZjZ0VwZU03WHg3UjMwQmlFNmllQXFETjNhQUl2MWF2?=
 =?utf-8?B?aGxwS2tUckV1MGIwaFVocnFib3UvUXJYc2ZlVUJLckN4RVErMlF3ZnhOTCtx?=
 =?utf-8?B?N0ZXQ0JweTczTkRrcXc1NUVlLy9xRGxsemtUTW0wSmJnS0tUS2lMQVB0R3or?=
 =?utf-8?B?eGlNdVhNN2RQQXkzbGhzMUJYTUt2MU43RW91eTNnTWZJdm94Vk1vOWVUMHpo?=
 =?utf-8?B?Tjc3TG96dTU4U1N4bnR0VnJjeDE3Y1hxYkNseXNKUVpuY2NJeGs1KzM0cndo?=
 =?utf-8?B?aTZ3OUtETjlnZm04aU5tQ2wwTzJKbmJONnpXMW5ZSVRLVFoyYmFzWURBazBP?=
 =?utf-8?B?TFVvZXVwUWRET2pYc3BQMFZsbmM0U3V2NjFTU0w0Tno0ZzZzS01OSzhUS3ZG?=
 =?utf-8?B?a2k3V2ZrYm9iVVU5M29JMllHRFVkUE5vbWdrOUdXVjhSdEZPUDhOYk85SlZZ?=
 =?utf-8?B?ZGZmamE4aFFYbFFJNk9jcWxINkQ5T2E3ZGJTa2VIbFlZVUdtQzFQTUdaOStq?=
 =?utf-8?B?OVgza2wzazNuRDkvUnRBL3JzY081QmhOaHc3d0lCc1BEVTRQSnBkc0U0VGkx?=
 =?utf-8?B?OElUUlZZT3BnOVMwa2w3K2pSaUhYUVViWVhWZ0hqUDR2ZFNCbjdwNzYzaVF2?=
 =?utf-8?B?WGlVRDhieW5DSUlVRDFCU1Ztb2JEU0xKckI3VmZQN0d1OHlmVktIcTZXbG1m?=
 =?utf-8?B?V0VodTgzbVNXUzRuYjh3MDkvSjJDMURyOHowaFZ2QkRRWDdDZ1JnZVJOdGxP?=
 =?utf-8?B?YTFmc0RVd2hYNnpSd05oenBwK0RuM3lteUtDUjNpWk5sRzVmaDd0OXJtcGdq?=
 =?utf-8?B?MjhNekQ3Zjc3OFN2eWh4RlFDWEttSnBmZ2YzM0kzcDhWREJjd245ay9WdThu?=
 =?utf-8?B?Zkk0V1pleHd1LzJ0Q1RBWTJwL2VpbDZJUkxUN3dmQmRjZUZabHEvTnBhN0xK?=
 =?utf-8?B?RmpBdGVYbS9hVjhRblJicFplMzRnTHh3dFFtWlNvVE9rYzBaeENvQzlBNVd3?=
 =?utf-8?B?Nlp1UGJTT3BNQm83akhqN0RDaldhSFNLMnpNZndtbndlMmh0TFgxall5dTd0?=
 =?utf-8?Q?/p/rGSpzA5e61Sc9kKJjcuJn2?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /oEgdx/DX5K6WQpIIKg8lrwR0GnF0UB7+NHBqcgSYYlZ9bpnedimZsJZAMDE3Svsi6UU+NvLYVFxEGHfgfQi2OBi/3LuXNn0g8ZgENi6EPnZsK19XbXP2vVsG0ipOio5H8v9dDXDMJ4G3x7SOAgFq7VMrmyFS9b8t4h5TGPdg54RiMGfMilIDAKn+cj8RRLaTxri5H3YkugtWBNW0ikLfEtlVi3eR51SE5hhOXGCAu9TDiyGg9uhXVsIwx7UCR6MJ2/GL8x5UyEcKKy+x9Zq4xcqFKy0ovZ8kfMmuqTWt6Er63dS0kv/UsXllqV/8HXUtMgfcIIpulpQSibkVVDriqlS8XfQ24HCz/HxG+8a7Sate/SQnzpR3xj5PX2FnGHtty+SW5ClxMjTs7QHXegzpuJFPKSKQxJ0nKf/iryfV4kmJdSWiRCh+NRq2gvwQPl0s+O4u81tJkhQS8nmCEayDqD1ssKOEoNo2dqCGaF85wi+vhfIJXPSAqYXjnCQ/i4N7EFaPkI5rlO9EyhzP8MRJpLA1Ij4gMPhyPP3uwYGolx2pT+CtabRLpkH9Z+NKhplbJcg9uPyjtTLc/rTPQNMF+dvRZS+85P/MfFMZRn303J5/UeMlJP++sfXgEhZrNhErI4N9RSgrNFRCe/8gHxFDzKm6wffAmMPzLNJUQN8ceP2RBeXWou8KjcwNoJn5roiRrFRnt8QALzfgPaqb70Pi47TK5cPieXV1rbLtEy9DA3VeTZY+LP7ah5o1UILqYGrFLp2htnhAI6ErzDwv/FGLEaRlsGld1nc+PsYbm3XsOOJ1f7p6C07rD+JZDYt1JbL3AzJa+eVoNyhTGv5Si6uOQ==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e236c12f-1021-435f-e1d7-08dba84b75fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2023 04:50:25.8197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yM2yAIS/OdfvNVqF445AcqkvqZXXg10G9A+UWtXkydLSfVKyMWPz4gZutl42o6r/D6h7VD2GY07BCH9zwTUxDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4340
X-Proofpoint-GUID: zfbWYtTGJBVKVqVJgZAC5YveUBwsfIsD
X-Proofpoint-ORIG-GUID: zfbWYtTGJBVKVqVJgZAC5YveUBwsfIsD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: zfbWYtTGJBVKVqVJgZAC5YveUBwsfIsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_01,2023-08-28_04,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

QWZ0ZXIgcmVwYWlyaW5nIGEgY29ycnVwdGVkIGZpbGUgc3lzdGVtIHdpdGggZXhmYXRwcm9ncycg
ZnNjay5leGZhdCwNCnplcm8tc2l6ZSBkaXJlY3RvcmllcyBtYXkgcmVzdWx0LiBJdCBpcyBhbHNv
IHBvc3NpYmxlIHRvIGNyZWF0ZQ0KemVyby1zaXplIGRpcmVjdG9yaWVzIGluIG90aGVyIGV4RkFU
IGltcGxlbWVudGF0aW9uLCBzdWNoIGFzIFBhcmFnb24NCnVmc2QgZGlydmVyLg0KDQpBcyBkZXNj
cmliZWQgaW4gdGhlIHNwZWNpZmljYXRpb24sIHRoZSBsb3dlciBkaXJlY3Rvcnkgc2l6ZSBsaW1p
dHMNCmlzIDAgYnl0ZXMuDQoNCldpdGhvdXQgdGhpcyBjb21taXQsIHN1Yi1kaXJlY3RvcmllcyBh
bmQgZmlsZXMgY2Fubm90IGJlIGNyZWF0ZWQNCnVuZGVyIGEgemVyby1zaXplIGRpcmVjdG9yeSwg
YW5kIGl0IGNhbm5vdCBiZSByZW1vdmVkLg0KDQpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8
WXVlemhhbmcuTW9Ac29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW5keSBXdSA8QW5keS5XdUBzb255
LmNvbT4NClJldmlld2VkLWJ5OiBBb3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29t
Pg0KLS0tDQogZnMvZXhmYXQvbmFtZWkuYyB8IDI5ICsrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tDQogMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9mcy9leGZhdC9uYW1laS5jIGIvZnMvZXhmYXQvbmFtZWkuYw0KaW5kZXgg
ZTBmZjlkMTU2ZjZmLi40Mzc3NDY5M2Y2NWYgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9uYW1laS5j
DQorKysgYi9mcy9leGZhdC9uYW1laS5jDQpAQCAtMzUxLDE0ICszNTEsMjAgQEAgc3RhdGljIGlu
dCBleGZhdF9maW5kX2VtcHR5X2VudHJ5KHN0cnVjdCBpbm9kZSAqaW5vZGUsDQogCQlpZiAoZXhm
YXRfY2hlY2tfbWF4X2RlbnRyaWVzKGlub2RlKSkNCiAJCQlyZXR1cm4gLUVOT1NQQzsNCiANCi0J
CS8qIHdlIHRydXN0IHBfZGlyLT5zaXplIHJlZ2FyZGxlc3Mgb2YgRkFUIHR5cGUgKi8NCi0JCWlm
IChleGZhdF9maW5kX2xhc3RfY2x1c3RlcihzYiwgcF9kaXIsICZsYXN0X2NsdSkpDQotCQkJcmV0
dXJuIC1FSU87DQotDQogCQkvKg0KIAkJICogQWxsb2NhdGUgbmV3IGNsdXN0ZXIgdG8gdGhpcyBk
aXJlY3RvcnkNCiAJCSAqLw0KLQkJZXhmYXRfY2hhaW5fc2V0KCZjbHUsIGxhc3RfY2x1ICsgMSwg
MCwgcF9kaXItPmZsYWdzKTsNCisJCWlmIChlaS0+c3RhcnRfY2x1ICE9IEVYRkFUX0VPRl9DTFVT
VEVSKSB7DQorCQkJLyogd2UgdHJ1c3QgcF9kaXItPnNpemUgcmVnYXJkbGVzcyBvZiBGQVQgdHlw
ZSAqLw0KKwkJCWlmIChleGZhdF9maW5kX2xhc3RfY2x1c3RlcihzYiwgcF9kaXIsICZsYXN0X2Ns
dSkpDQorCQkJCXJldHVybiAtRUlPOw0KKw0KKwkJCWV4ZmF0X2NoYWluX3NldCgmY2x1LCBsYXN0
X2NsdSArIDEsIDAsIHBfZGlyLT5mbGFncyk7DQorCQl9IGVsc2Ugew0KKwkJCS8qIFRoaXMgZGly
ZWN0b3J5IGlzIGVtcHR5ICovDQorCQkJZXhmYXRfY2hhaW5fc2V0KCZjbHUsIEVYRkFUX0VPRl9D
TFVTVEVSLCAwLA0KKwkJCQkJQUxMT0NfTk9fRkFUX0NIQUlOKTsNCisJCX0NCiANCiAJCS8qIGFs
bG9jYXRlIGEgY2x1c3RlciAqLw0KIAkJcmV0ID0gZXhmYXRfYWxsb2NfY2x1c3Rlcihpbm9kZSwg
MSwgJmNsdSwgSVNfRElSU1lOQyhpbm9kZSkpOw0KQEAgLTM2OCw2ICszNzQsMTEgQEAgc3RhdGlj
IGludCBleGZhdF9maW5kX2VtcHR5X2VudHJ5KHN0cnVjdCBpbm9kZSAqaW5vZGUsDQogCQlpZiAo
ZXhmYXRfemVyb2VkX2NsdXN0ZXIoaW5vZGUsIGNsdS5kaXIpKQ0KIAkJCXJldHVybiAtRUlPOw0K
IA0KKwkJaWYgKGVpLT5zdGFydF9jbHUgPT0gRVhGQVRfRU9GX0NMVVNURVIpIHsNCisJCQllaS0+
c3RhcnRfY2x1ID0gY2x1LmRpcjsNCisJCQlwX2Rpci0+ZGlyID0gY2x1LmRpcjsNCisJCX0NCisN
CiAJCS8qIGFwcGVuZCB0byB0aGUgRkFUIGNoYWluICovDQogCQlpZiAoY2x1LmZsYWdzICE9IHBf
ZGlyLT5mbGFncykgew0KIAkJCS8qIG5vLWZhdC1jaGFpbiBiaXQgaXMgZGlzYWJsZWQsDQpAQCAt
NjQ2LDcgKzY1Nyw3IEBAIHN0YXRpYyBpbnQgZXhmYXRfZmluZChzdHJ1Y3QgaW5vZGUgKmRpciwg
c3RydWN0IHFzdHIgKnFuYW1lLA0KIAlpbmZvLT50eXBlID0gZXhmYXRfZ2V0X2VudHJ5X3R5cGUo
ZXApOw0KIAlpbmZvLT5hdHRyID0gbGUxNl90b19jcHUoZXAtPmRlbnRyeS5maWxlLmF0dHIpOw0K
IAlpbmZvLT5zaXplID0gbGU2NF90b19jcHUoZXAyLT5kZW50cnkuc3RyZWFtLnZhbGlkX3NpemUp
Ow0KLQlpZiAoKGluZm8tPnR5cGUgPT0gVFlQRV9GSUxFKSAmJiAoaW5mby0+c2l6ZSA9PSAwKSkg
ew0KKwlpZiAoaW5mby0+c2l6ZSA9PSAwKSB7DQogCQlpbmZvLT5mbGFncyA9IEFMTE9DX05PX0ZB
VF9DSEFJTjsNCiAJCWluZm8tPnN0YXJ0X2NsdSA9IEVYRkFUX0VPRl9DTFVTVEVSOw0KIAl9IGVs
c2Ugew0KQEAgLTg5MCw2ICs5MDEsOSBAQCBzdGF0aWMgaW50IGV4ZmF0X2NoZWNrX2Rpcl9lbXB0
eShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLA0KIA0KIAlkZW50cmllc19wZXJfY2x1ID0gc2JpLT5k
ZW50cmllc19wZXJfY2x1Ow0KIA0KKwlpZiAocF9kaXItPmRpciA9PSBFWEZBVF9FT0ZfQ0xVU1RF
UikNCisJCXJldHVybiAwOw0KKw0KIAlleGZhdF9jaGFpbl9kdXAoJmNsdSwgcF9kaXIpOw0KIA0K
IAl3aGlsZSAoY2x1LmRpciAhPSBFWEZBVF9FT0ZfQ0xVU1RFUikgew0KQEAgLTEyNTcsNyArMTI3
MSw4IEBAIHN0YXRpYyBpbnQgX19leGZhdF9yZW5hbWUoc3RydWN0IGlub2RlICpvbGRfcGFyZW50
X2lub2RlLA0KIAkJfQ0KIA0KIAkJLyogRnJlZSB0aGUgY2x1c3RlcnMgaWYgbmV3X2lub2RlIGlz
IGEgZGlyKGFzIGlmIGV4ZmF0X3JtZGlyKSAqLw0KLQkJaWYgKG5ld19lbnRyeV90eXBlID09IFRZ
UEVfRElSKSB7DQorCQlpZiAobmV3X2VudHJ5X3R5cGUgPT0gVFlQRV9ESVIgJiYNCisJCSAgICBu
ZXdfZWktPnN0YXJ0X2NsdSAhPSBFWEZBVF9FT0ZfQ0xVU1RFUikgew0KIAkJCS8qIG5ld19laSwg
bmV3X2NsdV90b19mcmVlICovDQogCQkJc3RydWN0IGV4ZmF0X2NoYWluIG5ld19jbHVfdG9fZnJl
ZTsNCiANCi0tIA0KMi4yNS4xDQo=
