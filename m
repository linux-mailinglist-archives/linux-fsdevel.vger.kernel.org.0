Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDC971509C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 May 2023 22:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjE2Uie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 May 2023 16:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjE2Uic (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 May 2023 16:38:32 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2092.outbound.protection.outlook.com [40.107.220.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45285C9
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 May 2023 13:38:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y37iMyn6skenY7xbpC8cZwZs500fxMekUKGeUbx+5BgIbjCX3+hLwlc5biYw+KNJI75E3oZUaHtqJCw8G3Eq1uBQ3lBDAspTN4tFn7UHGOsJwtKFoVHZcGrDLfVaPpE9yqDk6XF0zjrxgD91LK1Rh8C2XFGHJQ9vBzVK+MK+ooLCTBD8XGNia859t/WxUZfSiUTdqOPnGu9BEBdLHER/1EDi9Qk81GoN0gx6PbcLaBWk4FTC6R8vEPkemtDBqkysbwStCLz/YQkTIy/vSFrWab8a9smAzZaYHk4DH8DkGBMLBwRA4ah8OjVj8UWq+2OCZic22n7j4yQ/fPl0yV+lGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdoJdnLKEVMeQFIxNJ1YpC816/bgEi89w6rTc3lI1hs=;
 b=OBY8wuCJWVSr0/RjQxrJz9IlpVPTTzHyOrZMyqjtqrVnuM5OgebLS45qaZfDqDD3obqJBdHmrzYPheqRTkGKRgGDM+DCNnIGYg8ETyb6ujcKO/GX+0+Ti21+ONf0GUcnrMUpbdnM2KtOTcfiwL/QRmPHZ5CVxEbAC8dnd8GBeMgQOEKcoo1AQRrLGvprHtZ1qJZdUxPNgYXpAJXHcaaDMmwCUNMkLG+EKHV6aW3tmv9nKpNye+52PHQlzuOwyiFQQFjKPl6QQr7bdwNItVZFQxq4M+x77hjf6cXCUkKRcQe7tWT4mCoSA5dDZNz1ddFugBJOTY97ynhTeoK8UhYTkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdoJdnLKEVMeQFIxNJ1YpC816/bgEi89w6rTc3lI1hs=;
 b=ctk6A3QHkjNr9zKDd3FhE9zWyJe9bbg+zHAfUJBt3OMVun5qXIWgk5vnx68r5QoRvZ3UNVdRv+xDKjI2y7Ddy2QrlWkhsQI+wLDlw0M6HWPb26TxD0PP2Kq9nKR7/0MhxwANPKR2rsnae96jtj/VtTibIjKwX81157mH64zk8VY=
Received: from SA1PR22MB3124.namprd22.prod.outlook.com (2603:10b6:806:23c::12)
 by PH0PR22MB3498.namprd22.prod.outlook.com (2603:10b6:510:169::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.21; Mon, 29 May
 2023 20:38:29 +0000
Received: from SA1PR22MB3124.namprd22.prod.outlook.com
 ([fe80::647d:bdd1:e07f:42e1]) by SA1PR22MB3124.namprd22.prod.outlook.com
 ([fe80::647d:bdd1:e07f:42e1%4]) with mapi id 15.20.6455.020; Mon, 29 May 2023
 20:38:28 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: A data race on mnt->mnt.mnt_flags
Thread-Topic: A data race on mnt->mnt.mnt_flags
Thread-Index: AQHZkm2GlZRqkKm/bUu1fNeL67eZrg==
Date:   Mon, 29 May 2023 20:38:28 +0000
Message-ID: <BE49328F-DC47-4509-AC7E-6DD6FEC2FF83@purdue.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=purdue.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR22MB3124:EE_|PH0PR22MB3498:EE_
x-ms-office365-filtering-correlation-id: 128277cd-664f-4b24-630f-08db6084a8e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 494bOblciIfzOnAhI/S+bT/MoX2UJdXzehvu6JJTQnlHjek9AxpZec2rzjg9PjLbFVZg+Ve5ft0tB/XZZnGZRyJM4DtXuUU58iTWFLqiQ/hvtkO7Gw2e5d3wTR62Q0tocwF9GeAvh5f5Txw+sx1+kz8Dq65Jlfp6k2/WrIeHW/KFdl9YrgeVTLdDOeRv1QeH2/++vFC9J+Z/actJmQEP+yv/NlXuYiERmgnViKuvN+qWIgiOdxXYi/JONFWMV17ykiKBfGIToEtn6+POtcKHcyZ7oh7mb2961UnEbORbdNbKUC7VWdF1LiOYy1yrK20SGZRG1IPVWMMPCe9Ah1BeVwNZWegsnH6goNUNfh+6B3Q9vuYg0UxTmVQbRrGCsNb6zbKWWvdoV5C3XBfrqBx2/RyAYxz0+H2R6y1SvWqKAYXf8L6Jbqg7GBsXtuy0ls1tR7hFNg2CAk+HNnYS/Gbe7TQSBTFvMXdfSXAsXlprAj9Z7YgOSu7WuOpvlvZhcPSXeUIqD87uqclfersgKcPQwZ9IvgOfc6Wyu2TURWZJYTJQ+BzsKB59m5R1C3eKGItpPpVDxUBWeusleD6VPxh05yFn1Qs+eIRFx/XF51sZ6Ib+mNPSLSFF7kSlfudph4IZAVI/fLRyXsrBkiNEdBM0qQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB3124.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(122000001)(478600001)(38100700002)(76116006)(2616005)(83380400001)(66446008)(66556008)(66476007)(64756008)(38070700005)(91956017)(66946007)(86362001)(4326008)(6916009)(4744005)(71200400001)(2906002)(6512007)(6486002)(186003)(26005)(33656002)(316002)(786003)(41320700001)(6506007)(41300700001)(36756003)(5660300002)(75432002)(8936002)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Orz4DOnCbXU1vH6woFeRopthOlqP1bEE1aoP3NVGG5u5XCS7PIxbtqswwf8K?=
 =?us-ascii?Q?YMmNGT0oaQ2dx7gOWNC5OwaGOs/VRNBulnTw8t+/AxYgCJ0OuH/v8WoO/y5x?=
 =?us-ascii?Q?/jSrUHI9E8iXxtc/vrxTbtKEe/OBQYX9bcwsBxlowKb3yvuG/i77kLyV9rIR?=
 =?us-ascii?Q?VV6ISLKPb5j5tS5j31IbOmpEjoj1iqSEqVdnwqu6BjDFbudefFLmlVDVQBXK?=
 =?us-ascii?Q?/2VwciJVNazvByZTW7MD8DgePxwVIRf2JHn54cv3b4LnbkWZkDO1Chgip150?=
 =?us-ascii?Q?ysysY17XCjh54UzFRyIKzMxLkTQmA0vJLtqVG7J39g9gPY1pUDfYiPM7YRnF?=
 =?us-ascii?Q?uYeyUCbF+UVjEIE5DJyiwpFCjkzP2N4/v/zPLlnNQRFAR/2ohTWqvcRw7kef?=
 =?us-ascii?Q?YqoQLEJNVDoInWbu+R0vMMyHn7qYBBCC/ONcWpWmpT5ryW3g/1dEuuJu1D5L?=
 =?us-ascii?Q?lhDZTKEhvYXS64LcVl6IpvpuZHSyEVzAj5hshYkT3708P7R0r06OliKfn44B?=
 =?us-ascii?Q?Sbl/TI/9xnGlFG9dRdRuaFxxHc8xcbY2J2ZE8DZ8HID7o7zJaY0LW+6S2H5O?=
 =?us-ascii?Q?JJBRymUsW2cNyg/JsPxv7z1IOpDmpEA2m+pm2oeSCSJ2DE412VINtH367F4m?=
 =?us-ascii?Q?kJcw50+wk21ktUQtqMFHHVrhhBEoQJL6+S6sBwoKfnYdGmqNVgbaFu3dC6fm?=
 =?us-ascii?Q?0WLbl5kUK2uYoEJqizv52Jv5+oiIy1NvTzUBlPNmKrXtVwGK+nCExYu0C/3F?=
 =?us-ascii?Q?GYRe/8WjKG5eWTbF1J23q0kZA5r/0I8vjlT8pezrE4k1yQgWvfoReYrf0h9L?=
 =?us-ascii?Q?oaCkGFeqAptkysiVt9UNJjT1YtagDGpR+mQWU9h9aoQIvAVlGMzZqV8vRiaQ?=
 =?us-ascii?Q?Ch2iEm8XpmitM/ZVCIn94uLiHjtLMScbgMhmFoI/jF+f37iW4O7nem2lKXXn?=
 =?us-ascii?Q?hbOlLi+MsmJqof6cTVOf1755JMBhvU3hKUOTbIDEvrZA4Pm0YG7UYD5fTKh2?=
 =?us-ascii?Q?bSmHLFauh+xMBJytNIJmGSVHuzhh2CbIYdP4ELELikr0bksGFSENiAywWcIN?=
 =?us-ascii?Q?v67WbHsD4fOA/3jYDdxkV7cOkoymanb/R4X1ih3CNUNHB08aHU/BTZ+nAC7D?=
 =?us-ascii?Q?8YeZfu2isVlhDfn5upkuC8S80O01AXmQ2+50fDUXBAfHd5jCZuWBxtahFSu3?=
 =?us-ascii?Q?FUd9g/5UqQSzRR22sSvp2gzXbqvqbtm5gIJm/jVxfJwiM0OmVubscAUbRGNf?=
 =?us-ascii?Q?V5bHnI3q99JhzzvAHNAZZrfrg2z9D2YLpLlEiXV/+xBRsa+p5FeWNET1953W?=
 =?us-ascii?Q?//E/rqDzs0Kk9ND/yFIbj1qQGk6sQmkKQ0iKSqAbZtGluG1Tydt6ZBpSyPHw?=
 =?us-ascii?Q?im6rF174gk2rf+YBVTilK9lBmC8Eu8sYtKQCnDgy3xiiqMaFkJz1SQ5LdCo+?=
 =?us-ascii?Q?L/vtA6qpi+eJ8oQpvcvIxy/jUPOk0zKB6CQiUemQABY89Jvs++6QEAhmoxuK?=
 =?us-ascii?Q?y84QNY10cI87BWYlfkH3pUDcg4W55RjRPsADNBx7bZw6tXRZeo/B6+3w8/2E?=
 =?us-ascii?Q?GYYK/Hw/ddcMdFLp+nycR+fTu0WIM0p5PmXgviWq?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <67192B0E98E7004C9042A25ECEDAA685@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB3124.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128277cd-664f-4b24-630f-08db6084a8e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 20:38:28.8235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJ/97Vb+sgD2Sl6X1TdZLYE2gODaUavZljRsmJv2fwkRbt03hiMJqX5gSU5hFsaEy0/2yyKkmXDEo+DISB6nNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR22MB3498
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

We found a data race that could happen between clone_mnt() and
mnt_hold_writers() over mnt->mnt.mnt_flags.

The two functions can write to mnt->mnt.mnt_flags concurrently.
Although mnt_hold_writers() holds the lock_mount_hash(), clone_mnt() does n=
ot
respect this lock at this moment (it will apply for this lock later).

Thread-1					Thread-2
// clone_mnt()				// mnt_hold_writers() holding lock_mount_hash()
mnt->mnt.mnt_flags &=3D ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL);
						mnt->mnt.mnt_flags |=3D MNT_WRITE_HOLD;

It is not clear whether this is a serious problem but we would like to repo=
rt it
just in case.

Thanks,
Sishuai=
