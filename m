Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4156A1016
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Feb 2023 20:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBWTIR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Feb 2023 14:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjBWTIQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:08:16 -0500
Received: from CY4PR02CU008-vft-obe.outbound.protection.outlook.com (mail-westcentralusazon11012003.outbound.protection.outlook.com [40.93.200.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F982CFD1;
        Thu, 23 Feb 2023 11:08:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eTDgPiuNtt30HBf066E67NlCYu4E/uCG4cd5ZmU+UWRyJZXU/YB5BmLtnGAxMj/26FGNYp5VJ/LwLhbXnMkF8LsZYlYsWR+vsOxIOzoCVyihxioGN6zuWvvMHMHw9haGNvjJA24Y67I9UIbnPE87GScvxgvDHIQ9T219wTAjoJvD4yo/qZrEch1uRnzKDsbuc3XniLAB9hUyc7++cQPSyZqcwjusCitKYgysPmqPqFd1cA5Kx8zarvrY96qYsectEgsMnodFU4OJ0bcxws7h8486MaIyOja/c8UuYdrwzvJN2thDmUT0zZrJIPPu07uDCDvWzl6LR0HOvxGXrUDQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=En8jOnnzwMNikiRE6zJoRo+SMuZZjCngqxSHvs3RS2I=;
 b=WTuO7oVIUHWDS6oDCpCFPF/sS38m7RH72p3se7Dts+EnYrgER3K107dXSptvy51K8OAVYssDPZrNyVKyGN/3BZ/XFkWoUhYuvkm5qoUN36YJLSf5viwMch7uGQYXS1Bx4EYDfnK39Uq0SOgXyDHOFkPSM7tFAvtPk8iLASvCrNFTWieQDydl1bJkBitT1P6byYDXmfUmyqYPNUMn00BOYUZk2Od3V1l0RZoNzuHZWe3LcTgHFK0DaHgUG4McK3CQT57+uVKrmgpszsKk42VpCwjxzOyzKFpINwmtFFTz7shSZfmOKoNyKA/4yPQaJBSq74ozufy+7juJ4BsZcpOQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En8jOnnzwMNikiRE6zJoRo+SMuZZjCngqxSHvs3RS2I=;
 b=staJalvG3yfzzUE/7/NaZh2LzFVwjxtAJmXMUjxbaO6vr28mNhktlqCfZOI7496+tK1lcGjF0Vty9xKuIEx6/UEmtDd5N6Z3UuVEi5P3LmpCLN98R/8GDw2wFimpVpqE+Ah8w/R/UkNl/HauoqrjgCBThyNx/mGvGNT/u3/+PpM=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by IA1PR05MB9244.namprd05.prod.outlook.com (2603:10b6:208:3a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Thu, 23 Feb
 2023 19:08:08 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::e9bd:ef2f:b71:8084%9]) with mapi id 15.20.6134.021; Thu, 23 Feb 2023
 19:08:08 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        James Houghton <jthoughton@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] mm: userfaultfd: combine 'mode' and 'wp_copy'
 arguments
Thread-Topic: [PATCH v2 3/5] mm: userfaultfd: combine 'mode' and 'wp_copy'
 arguments
Thread-Index: AQHZRyHq5XmoYIOsjkuDkcqzrjwGLa7c4ToAgAADrACAAAEeAA==
Date:   Thu, 23 Feb 2023 19:08:08 +0000
Message-ID: <E559A848-37A9-41E1-88A5-2765EC166E5A@vmware.com>
References: <20230223005754.2700663-1-axelrasmussen@google.com>
 <20230223005754.2700663-4-axelrasmussen@google.com>
 <F3D3DA6C-0AEC-4947-9E2F-7A9773296A5D@vmware.com>
 <CAJHvVcj_NKp8wOUL5D2GX61xp0Rvzy6Z8gvL_G=qogsJreiGTQ@mail.gmail.com>
In-Reply-To: <CAJHvVcj_NKp8wOUL5D2GX61xp0Rvzy6Z8gvL_G=qogsJreiGTQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.400.51.1.1)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|IA1PR05MB9244:EE_
x-ms-office365-filtering-correlation-id: b51d8383-bb8d-4c68-af30-08db15d14cf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DV2+pDOMdVq6pbXGRXrfHS2NtPW3VYO0tYtOqGw6t1djbHKIvsd9DgrLW/2S8RERHBeWrAEj2sWYUCSsfVyUQF1Nz06XGllTGpvXnrVzmlS11WI396GxY+4g4jUMVjp60Znb6P4kKOuYrfIl5AsWCamom7/aI5rhshW+ODdO9QpZg4epMH5kcp+9yZ0VHeBx3hYDqPjRHHOq33+0LBUI0m/wK4+V5JmPYGtujRSorALUDXSsLfDAUwnaRgFGBoNZ+jxO7f/luP2opcMw80cga+Eg6EUdREDD3x/6OCnpY2NvJUrQwYALDLzjXq+PSC3CN1oQByF5g+xe5rOFDN0hmpKhnVlt55QS26SqU2MWZj/gpUMkXEJ3It0SxTb7lWX0gxSaOalwvXsFxaSJBLZ1dbE7ccIvXiinizsI4kwVR4lu+lgr6JbyUH3Ls18esvxNGTWu2ueb4e/hI8OY1HSSa0KAFLhh74dX/Si8ZAhzCDCrIuoUcode+lJ2yDzVPKlBnue5ghUDVR5BY00W+ukz1BSs+J32PijHaDWhFuKMQalmCrCNAMH6hm0tQ7s2AeiZffELjE39dfwezPYCnkZ3txfNNEHSlH1cptWilVuKFLFTYteu6Biks2snv5pnstF4xHTomkek3BH1fUw1nM4SAsyuVbV3Cj8w24PH+YY3avQIjA6ljJmeVH1wE4/szzatHWK9LWPQutwq46dwTC1lDuCXFP9NF01IPUU/KV6UF6M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199018)(38070700005)(33656002)(86362001)(36756003)(316002)(83380400001)(71200400001)(478600001)(6512007)(186003)(26005)(2616005)(6486002)(53546011)(6506007)(8936002)(7416002)(5660300002)(4744005)(54906003)(4326008)(66556008)(66476007)(76116006)(66946007)(66446008)(64756008)(8676002)(2906002)(6916009)(122000001)(41300700001)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?siNcr1AqVGnf5adIra/vDiGmeaZDX+3tqcMiIEqX7Wg6cgTZc2MBUKfQkdZw?=
 =?us-ascii?Q?JHNGxR+0qSF3lqzSa6h3JY2MYEP27SqRvvJi90A62nTuHlKwOHLHlrKdhlix?=
 =?us-ascii?Q?V2zXXcX2ssYZoN9b7sQx4B/IREpax1J9g+DhF4q9VGPoCgMSpkeWW4QMK8OM?=
 =?us-ascii?Q?6JnZAjfSbBkJ2b/iUfjc/1ztQ9JD3o2ae2MuBi58hW9Vs3+yAGJEDhBpk79h?=
 =?us-ascii?Q?d4ru9Zdt5nQmWsLr/qvefZnW4f5kiGwRqryGfIalZt6WGLkTpsZ601f3PNa0?=
 =?us-ascii?Q?nOr6YkD+rZwvHLU3NUWEgwzHP+h8+LTlwmK0o9qJMnhe92K3PAIuO47efWek?=
 =?us-ascii?Q?VgTZthqixkiYD8F6s935rxZoCo8dPJwqpMH5DpZ9Tq676vUddcWTFJSPWeIv?=
 =?us-ascii?Q?5LXkgYnWrfodaWUK/nM2wl8LlCpcidMRT30KDJhTQbnkmAos93hj7DcMkuhK?=
 =?us-ascii?Q?A1wOl71q6r5Mz21rKk4le2nv86duYccrA93gS7MjItGlSYcrPwt6nTG9JKYt?=
 =?us-ascii?Q?00fVCT7VNww2eq4EorMWfJ9qBG2ZHD8rMbEpobBVAlQLT3ykaLxC7VAA9XFf?=
 =?us-ascii?Q?zQSuvz5H4YaOPl9kWlIHHtPsz+LhUXG9MXLhttu+cG0wLSLvSnvrSkLLcXAf?=
 =?us-ascii?Q?SZMJCA4Mhtxd8/h9h/5n1p1zRZV2HFAVAWHkj4pyJ5FdITN23TQx209mi1gQ?=
 =?us-ascii?Q?dKUTE1YIIZvMfswmHhLRPUZ5hZ6f2+UHZcL6GwdqlJPI12h0ul4t+oQ2BcP7?=
 =?us-ascii?Q?9Df0Ol4/PBcdTv9PSkt7d4uI3Vzw5jf8NdGJRpCWgzSd/RCZu15j1Y5Tvdn/?=
 =?us-ascii?Q?3AhWL4KqBR7+KAztixUF+htE1FjgbMm2OXRi00Nsm9ChbV50BzG4c/T5XKID?=
 =?us-ascii?Q?s1O8D4RZ0hPHSj68MgroMCQspDPWDDXHfcfj2nowuiLqoRexcNyuaBzXqFjB?=
 =?us-ascii?Q?hpIskwGhNA0H1uxwKQ/fz6yuBn49qsMLQOw+CKEAakMXOOqiLCUNt8RHE3l0?=
 =?us-ascii?Q?0iYnuaRdlC7+uYnYG9K2dq+BH4CvTq9gSYngJhCvetauonqvMB7kZ7ms+ygy?=
 =?us-ascii?Q?Gx7aLgwyqvbMlwm93A/jD7PZXwepADNdNA9btQ2yJnZYJL6cz/sR3zrtb81s?=
 =?us-ascii?Q?3Y+wJKIylSbZ44+t8ypNIWXmuAQwYj1R0ZOKniaK3rXMhri7uBlWsKZnRC2x?=
 =?us-ascii?Q?SoYJrNSsUfbNSv3BKqWThxzOYwAjMK5aNLO3/gB5AWupoE4yfpD0JudzHe8P?=
 =?us-ascii?Q?z7Z31dmO55zc5X3/oKWHugaKvBGShHpm3QrYM+6Eprk4jdjjnwX8c5F/vgXT?=
 =?us-ascii?Q?+r3eteg/Hzd85zytfjG+gN244+YSjo89Zmcvt9iha+NTlXQ6QSGM8hrFKqOL?=
 =?us-ascii?Q?QTZkT71JQiwg11s5T/WS4UVadBXRD/upQnCH4qDF01DHLthRUwGxMIMYO92Q?=
 =?us-ascii?Q?9YUvsiCdsNkqOeAR1O048SLYOdoe+16k4obcTDzjQNstRqdW1UV6QFqc/WPH?=
 =?us-ascii?Q?hlluuSdYqWwjJkTDGEBdG/9jwhbTRx7QTFq2r7mNf72XIEnFzuHAkQ/CrJgS?=
 =?us-ascii?Q?fkR0nReMkIxDJ3Jkt/B/acRRtKfSzeN2+4wahtg9?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <33BAE4DB7E1E424EB2CEB6FAC1B06AB6@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b51d8383-bb8d-4c68-af30-08db15d14cf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2023 19:08:08.6237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUHpt7J99kmn4uvysI+yPH1Q2rT/8E3NsAiWRrUdZQU5+OgUw7XWf4AGad9vInAvP/IICqu1YOpDvCfHkUzpsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR05MB9244
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Feb 23, 2023, at 11:03 AM, Axel Rasmussen <axelrasmussen@google.com> w=
rote:
>=20
> Oh! I must have missed it, or just forgot. I'll take a look and see
> about making some improvements. I'll also be sure to credit you in the
> commit message.

It was not about credit. I just wanted to refer you to what I had in mind,
and David did spend some time on reviewing my patch...

;-)

