Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2156A5549CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 14:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358196AbiFVMP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 08:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbiFVMP0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:15:26 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2100.outbound.protection.outlook.com [40.107.255.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1812F33EA8;
        Wed, 22 Jun 2022 05:15:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NveZQuCt3UMKrChfa8uGdmfCmOF80jNfrq8++KoOova0SLNFCN7MU718vX29tZ+7aBNMPIeDuEf2MoS94nOVne8hqaGB+vDiW2c90Lx5/v9fkxUQJ/lbdfKCAzTGNFWK92lk/CaBSPlkeQW0kqRJXCZ2O+f+tVTOA6JxqoSAJegDSOSlTPCREA81iDb7Hty6BxcBcmvfH0M/KZ6W1y4C1DOzdGM6hdQvdvQNyu0sPvekrFutBKU7+IMayyDUqMR+l0hU/A4KBd5iC4wtex5+iJyv4sTlNeymqVIktBB7IN3OBpkXNh09SlzAUzpwNJaZKvRL0GbuCNoitUxz7RstYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dG7+RKBF0BElCDMyDVP9v6ngXUoYoc0aOS0wDTbj9L8=;
 b=hd9817bBW3/78uRP8c1DYphFqvnMuzfsFsDOz7kWLvX+TvJXsK56I8sPvBMxNUU/E0UmrU+ZHce3IA0Bq22PnoUXmSjox+OE8ZXeYcmOSYvegTfc2uF22q6oiTR7thelqU//mg20jsN3AQVJSohAM0EW44M8RRq3B8Bsb+ootJoGNjiuJa7DLhYaFchVOF6KS0ssvYL6GC2g5FIgWdA2PjspSVw2HqkGUn8bD2l539fnPuAjwGFF7kwBKBgn/AnkXunisPxC3+m010UdIKgg0Ex4fWtV2Gmor8V0OLD9ASVRFGnC6TuMFP34XJhP3Pf2o4RRZPShYzQubqz0hDwUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dG7+RKBF0BElCDMyDVP9v6ngXUoYoc0aOS0wDTbj9L8=;
 b=P+L4zwx+aD7zwX4gXr7/wL1Lwmc35hXvqFRJRQcZ7auIu9LQj8RYONmrlQAjT+QWRqw3sdeZfPSRnlYtlXa9b+QSha5Sz0cBMxHKSKrfepR1vNKo6uj/0e1ZpOTkif/yVY14FfL+TQ6dq1h1BSQWFxSbSzrOfdRXGO/tnEOFZk0=
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by SI2PR06MB3900.apcprd06.prod.outlook.com (2603:1096:4:fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Wed, 22 Jun
 2022 12:15:19 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ac67:6f7c:3c88:eb8c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::ac67:6f7c:3c88:eb8c%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 12:15:19 +0000
From:   =?utf-8?B?5p2O5oms6Z+s?= <frank.li@vivo.com>
To:     Namjae Jeon <linkinjeon@kernel.org>
CC:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRDSF0gZXhmYXQ6IGludG9yZHVjZSBza2lw?=
 =?utf-8?B?X3N0cmVhbV9jaGVjayBtb3VudCBvcHQ=?=
Thread-Topic: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGV4ZmF0OiBpbnRvcmR1Y2Ugc2tpcF9zdHJlYW1f?=
 =?utf-8?Q?check_mount_opt?=
Thread-Index: AQHYehlC77zhZwGEZ0yT3MKGsxe3Ha1H180AgADJdPCACJ+NgIAKLV+g
Date:   Wed, 22 Jun 2022 12:15:19 +0000
Message-ID: <SEZPR06MB5269F0E9CC90B06793906458E8B29@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20220607024942.811-1-frank.li@vivo.com>
 <CAKYAXd99NAbQP6m93P3bcjvWTN-T8Qy59DHJyfyTHqdH-7aWBQ@mail.gmail.com>
 <SEZPR06MB526945BC172186A13FA60B11E8A69@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <CAKYAXd_j-MAYP_8a3xEi2MmxZ9Po8t2di5_yi+7V1xXJuD006A@mail.gmail.com>
In-Reply-To: <CAKYAXd_j-MAYP_8a3xEi2MmxZ9Po8t2di5_yi+7V1xXJuD006A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e5e60ca-5670-4c30-06bd-08da5448dfc8
x-ms-traffictypediagnostic: SI2PR06MB3900:EE_
x-microsoft-antispam-prvs: <SI2PR06MB39005AF93893D21B4FF64F37E8B29@SI2PR06MB3900.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y8SKB3qlSsShGpb7bCrvf7E0Qy18/G8pUk5huKPi5JZIcjCOICmE6gmx1/KWiHFD/+st6N1tYes8lDfvODcuhx98lFAoeadMxxcLSXjVvMZLWC+qmHP9+aMExDkA6VZ81V6gKTn1AxR+w8P/OSXaS5D1hS7LqXqOPDKzfwGBiR/bKNEmlhPAGYovIHrmS/FLVTyglgSzeoLtatBg2NqPNSUnSMTq/lqKFBBW6yYlMI1/8rFeTiGEE7jDDPa75Qh/IcjRcYWMo4ehulaNvaF3fm8QcrgrbK1AnVUVu+M8l7a8qiQCpQ9do/UhyswBQEgax6QgFvyvKER3azeP6nvt+8DrilqQAve2EM1EU4yjeN/l1ru/w0YREi8MLk8+H5+pYJaQn3xp1yqe8x4YaBfUh5/zWV9wWgiI0InsuvsYdaR+8ZeY22ar4hp+AfcduYikjV97apXkDTKSbWUtoneWbRgEZWs1VS2dAPAgOypHRSwxXi7j2T/2aLOfkOWxQ78QU5geD3l41qWwRATvetkbWuosotUtbnmREL5rlKcVnuZFhUi14h8/NVMfhtQf+RIWq3LV2cRB2MeBPg1k91wW8P0gkFTg+z5JtewG1BRUs95yp82wFoKNVYiaSjQKXkFWiwgMbQO5EQEbK6APEcEcbhG9u047L1yKYCXbzLjfyZOwUuT0lYAfOzVrS4cDezJtG8wUGTqjg1QPsqCp69izEu1pcBifz8WkgUCnodDx5ezkU/30YOEKX47nU5+QUiKPpmuH22KcnorqlRLvxH5wMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(66476007)(86362001)(52536014)(66556008)(33656002)(478600001)(4326008)(66446008)(66946007)(64756008)(5660300002)(122000001)(71200400001)(8936002)(224303003)(76116006)(6916009)(54906003)(85182001)(316002)(38070700005)(9686003)(6506007)(26005)(41300700001)(558084003)(2906002)(7696005)(186003)(55016003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTNCclU0MkgyQklMd0ZNT0lrYUVrNUFGaGJnUlg4TTJ3MENXS0N5Y2NwSDBF?=
 =?utf-8?B?eHBzKzY3amJYWGhma3RmdWNaV2twdHQ2QzMzdDhqQjdVMzFrdjFnYnNiM0Vi?=
 =?utf-8?B?Q2dKR2hMbzh2NUlOYTVZVzRJbHI2TXA0VGVsNTlHRmZMN0s1WjVyU2dpWWRI?=
 =?utf-8?B?RThiUE4za2hoRERRaXB0WFBKRW8rZWY0MU1oM08vcXRCNmRZbk1FWWFMOHZT?=
 =?utf-8?B?RDV2Vm9sS0NPS1p5WUFIZ1pkQkJOME1SNDcyUVRKN3FSWDZLNTR5Qi9Cc1Jq?=
 =?utf-8?B?NUFkdUFGbnVHUXNpWVlZVDJhaDJ6WFlPYmU5RTBTc3d1QS9aNkJSZkNJK0JM?=
 =?utf-8?B?WmpiaHJwRkhhQm5acVJoS0gvRHU5OTdyODh6aGIycm9EWmZ0LzZlOVBaY1hF?=
 =?utf-8?B?bCttTy92RW8yV3dBWDB3TGRKNzkvWFpjcWVTQkxWV0xwcUZyY1pncUFoeW5K?=
 =?utf-8?B?RTBOL3dWWmRwT3ZaemtmU1hBckJBR0QxTm40SFJCanlCS3U0MGthN3h3Rzg3?=
 =?utf-8?B?VGZXYXRGcGpxZk1pMnY1MjZPbEZwWGdUcy8zV2Y2YmR4RmRpenpwZ2FwWnpp?=
 =?utf-8?B?Z3NJaTBvWldkTFlFRUlPMk03bUpYQUFYY3JwZUhBaVBLVkJRYSt4cmlSK1hz?=
 =?utf-8?B?dHhFQStubis2ckpxK2tYdjNvUS9zSUhxQndLM1NCMGt0SEJ5QmhHOExmR2VR?=
 =?utf-8?B?NHdxWERRMnlRNW5qOEN1ejZwN25rVEY3Sk5xWGZiK0Fwa3psMGVwV2xhNzIz?=
 =?utf-8?B?SUJxTVNDcHFsODAzVEpoY3dWYTk1RVFnSGVhOVdZUXpJZmUvOVY1YlZQSEZO?=
 =?utf-8?B?YXZlWlFucm9pQURWN1hHWk45MzQ3aVQ2RnJJRDFUb1pIVWVlcWZGWks3dnM3?=
 =?utf-8?B?bFhPSjNnMnp1L3pmRms0MGlQSkhldHVkTjc0TzZRRWd1M0k5TndhL2wzNUdG?=
 =?utf-8?B?ZTQ2RUllaW10RWh5K2FkNnkrY1FtTENPWjk0Qm1QRzhwYjB6ZnVjcUdWSW9Q?=
 =?utf-8?B?SmFvZlJybThOaEMyOElQaERTb2F6RmpUcEZmcm9FYS9pMjJiUXhpKzZuUHBX?=
 =?utf-8?B?S0RHSE0wb1JQY29NQ3BKbEpGWEg1RjhXUWRiTk8rRFlGWGhZc2x2K0ttUENp?=
 =?utf-8?B?czZrOG5ZWlBVazN6U1Q4VkJ1VVNOSytQSzg2cmhzT1ZST3lsbFNPdkZUeURZ?=
 =?utf-8?B?T1Q1Z2ZZN0lTV051aWp6L1kxUWlvQ21IU0NzZVVmak41d0ZEZHRKMG40MmN3?=
 =?utf-8?B?VmU5d2FSTjQ2NnZVTEprbms4MVNJcFI2bzlOTE9Yc09Jbis5NTF6Mm45YkVn?=
 =?utf-8?B?YVlNNy9EMTFKbExoZE96QmgrbnVPOGE3emxiVXNNRWVrQXlPTkltcFNtRXhP?=
 =?utf-8?B?V29Td2lLM3BidldORFAxemJtZWxWZGlxOWZOZmhFSm9BNUtyT1M3WDF6NFE5?=
 =?utf-8?B?SldPaGxVSkpxY2hpWTNmZWlrejVzRVhRa0ZPampacER4TWRxalpuYVNpWVZx?=
 =?utf-8?B?MDhSVFNjUzMwcGhsSDRHRTg2YlJQMUhNMnFFem13Z3FLWmlOSUp3QlNLQWxp?=
 =?utf-8?B?Q1l4V3NSS3pmb3ZYaEhxSVE0T2xNR2FhbjBjREUxZTI3Vlh5YnBIdWNWUFFD?=
 =?utf-8?B?djBocmJHZUlDUVNjbHBBeGVxcWs3R3JPNjhtbkR2T29zNmNWSmoxTGxaZ3Vz?=
 =?utf-8?B?WlNXaEVRUjVtWlZ6TEhkN245djhHWVBSK2F4YXl0TjEwaDVNVzlkbXNLYkow?=
 =?utf-8?B?aG5odEMzbURPa1A3L0FKNnRXVkdML2Z2aWNQVkVTK25LM2s0ZHZjWW9KSVJS?=
 =?utf-8?B?Mk1hSHNXSWh2Q1FZYjhLdUJ2VTZxMDM5ZFNxNERhQVpXd1hJVWVvVStGR2VZ?=
 =?utf-8?B?M3dnS1J5Wk5ZS2I1Yzkray9RNkxYSmVEc0NpVWp3NmhmeTBYT1YySm92ZTl3?=
 =?utf-8?B?YXhheEI5dGljcGxuVUdUVUJ5NXA2d0EwSXp3TWR6NnJxcVh5N1BKOXlEajFq?=
 =?utf-8?B?RGFPUWluSnlYcy9NM3JlSDVZcC8xNE0vcXViRmxsNWhwR1BLVXZYeEJrWkhC?=
 =?utf-8?B?aXBWQVdZY0t5OWl0bzFpRTR4TyswSFNOcnRnNjdobjNGZStCVUE1RkhuQUlD?=
 =?utf-8?B?NkpQVCswL2gxWVE5UVZvYmczMmtGM1M4cEg3YlI0S1lyZFIvNXdHbDA0THdw?=
 =?utf-8?B?VWU3NlB0WTUxdXV0UHpxYkhrV2pQaE9IRW0rcWtKZ2RyUlg3WmNDbU1SRjRX?=
 =?utf-8?B?YjJXWGRySVYrSngrMlRMUk91TXJRK3A1OTladjEveXdVTXZ0TkQwUzJjRjBV?=
 =?utf-8?B?MEcrSzljU2xjUHI1aW1ZczU5V3pzWDhPd2d1Z3AxeWFKRUpLVDBYdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5e60ca-5670-4c30-06bd-08da5448dfc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 12:15:19.4997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iV6UFffSJL5pKVZnArqQsCzWiV+6mekaMWBIcdxZU5LHxrZtdEAmWl2R6l7+Wn3gylRa3EJRXJyxacQ4PyVtWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB3900
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBQcm9iYWJseSB5b3UgZG9uJ3Qgd2FudCB0aGUgb3ZlcmFsbCBwZXJmb3JtYW5jZSBkZWdyYWRl
IGZvciBhIGZldyBjb3JydXB0ZWQgZmlsZXMuIFRoYW5rcyENCg0KV2h5IGlzIHRoZSBwZXJmb3Jt
YW5jZSBkZWdyYWRlZCwgY2FuIHlvdSBkZXNjcmliZSB0aGUgcmVhc29ucyBhbmQgc2NlbmFyaW9z
IG1vcmUgY2xlYXJseS4NCklzIHRoZXJlIGFueSBhY3R1YWwgdGVzdCBkYXRhLCBtYXliZSB3ZSBj
YW4gYWN0dWFsbHkgdGVzdCB0aGUgaW1wYWN0Pw0KDQpUaHgsDQpZYW5ndGFvDQo=
