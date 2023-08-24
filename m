Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF47787432
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Aug 2023 17:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242176AbjHXP3V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Aug 2023 11:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242181AbjHXP3A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Aug 2023 11:29:00 -0400
Received: from BL0PR02CU006.outbound.protection.outlook.com (mail-eastusazon11013012.outbound.protection.outlook.com [52.101.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1809B19B7;
        Thu, 24 Aug 2023 08:28:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZNprtlm6e4+Cqk2nY+jp4CHeJb9ZCDC1LJJ4cWy+pGIB0em9QeiApvRiQvjQXBnNqGn6kmcagqtjWTGGvylTRb1bYQjg4B3xuKE3B4kgVJcR0MGJqM+9inHDmNwpOb0HT9qLk6lim6n1nLCUeY0k56lBPW+5/TVXNKHLwEUy0pQXCuBfIrczFmA6RSK9BlHc1DPM+wAYLZP0CZRdzm2zLrWuZzatP8/rpcpaDhuO6yd/oaCYtYXfSuZryYhxnstO9CqOa5AQ8SijFB7RMWyropPa8qcLoVA1nN9uq4nTsKHeIN/QNQXci/lrpkREVIjNXRXFyEmhaWw7toyfJEPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t6ZZJUk59K0TmsRKRVmxF5GYxO51qaUB/lM29kVzP9w=;
 b=GSSkvHoy3Y+9kkgAus+DKgXswP9Jwm4765gzfhv2kchQyP1SdWjQSu62AGeeEocFTRhgUzuX8LPs7/eOX3z6nD1W0cLxOWaAXNF08HVbmwQbTaZgLzvOcWoatdpIwgaBRXFkoxAD1Bc+h8TbDZrPRPlfwYd8Q/Fq79YmyaGpT+gne9GUiTonvE4ESi1+GLSsaNiHeYE1IC1JE8ZdKyvV/+HP9+eGSLWlRJMSjFfNbH6miNiNONgUvmjWbtIy+yjdz3Fz9sawXiSOfOfxVHOSs40RmSfUKh7N1VSt80PFb+ZSEZEIzVeENDj6yh9lb3imT6sCp53kplvqE/4ggr4pCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t6ZZJUk59K0TmsRKRVmxF5GYxO51qaUB/lM29kVzP9w=;
 b=sqDDI34Xf6D+TNcefuxk0abSIi/v/ggd9t2NnES6pf4kbDSfkP0H3TcEP7KWMJz9bl0RA9TpKRWzHN0MdOK1p3nIJrL+FNVGv67W/UQPiimfw8tEB4L86HY/v0KgU4fnKWzdnpUWbvexMCCkLQmWf/XWEBogVi4JVyQnj8/7AEU=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by SJ2PR05MB10355.namprd05.prod.outlook.com (2603:10b6:a03:55c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 15:28:54 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f967:2d39:e36d:d1fa]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::f967:2d39:e36d:d1fa%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 15:28:54 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "tkhai@ya.ru" <tkhai@ya.ru>, "vbabka@suse.cz" <vbabka@suse.cz>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "cel@kernel.org" <cel@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>,
        "yujie.liu@intel.com" <yujie.liu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Muchun Song <muchun.song@linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Pv-drivers <Pv-drivers@vmware.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 27/45] vmw_balloon: dynamically allocate the
 vmw-balloon shrinker
Thread-Topic: [PATCH v5 27/45] vmw_balloon: dynamically allocate the
 vmw-balloon shrinker
Thread-Index: AQHZ1j3DBP2XCIqsAUaSNzyK4XzAG6/5ktmA
Date:   Thu, 24 Aug 2023 15:28:54 +0000
Message-ID: <2E63E088-10D8-4343-BB78-27D2ABFB95E7@vmware.com>
References: <20230824034304.37411-1-zhengqi.arch@bytedance.com>
 <20230824034304.37411-28-zhengqi.arch@bytedance.com>
In-Reply-To: <20230824034304.37411-28-zhengqi.arch@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR05MB8531:EE_|SJ2PR05MB10355:EE_
x-ms-office365-filtering-correlation-id: 15abcf0f-43b0-4e37-9e65-08dba4b6d3b1
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WPKyeyEiNFh0jMCTedMguHKOtngRHY5wG3j6znrFTGV48pgdo45ulIoJ6gW65eaqHAtTQvN0Ah4fguFERxjGHD8cTYXw6qMoFG+nn2ACWU2Lo+PC+vBYxHX4D+OrWQ2jqhTuS11l78f761ymYE9Wauk1aZ6ty619hMZVl33y2kFMXhgLAQHnz7OYfFqQY7zZXfJlC98EjeZK8rAGbB6nJj5F+9wNa77KZ1O1KT8ZcmyIBSaxvmO4EyASMM43w/tLa9bzWcfNySeCPX40rRWONSvUSNAatuoobtgG3XgBmDCygvF9PEMNpFmqm3TIVn/Sdg2vZN1WzVtE2Rp3JMKqHZK1/+JqoLF3rtxnkOJp0C+8mREQUsjXud2OWQdupzzN2NJVdEv7YJkkJ99LMg3uJnzJSBHKWs0JpJkDEipOb64YUrT3F3ZCbQ2WiXXn+FUJHFAODmV9qsWuzNYUy7ZYivWyLzONgbp79SEZ52Y8XkuVShL4pC2XC37ox4pTiI+AixQUIPbS7Y1FyeQ4mqV2BTfTF5tiugQKuJzf+3/gp5U+CfyCQvJFxCL2jchDuZXCXo3y/fCBeABMAbBQBqINjcaO51Uv7pt+JUXV2KIZ4Id58PhDvaQTxoAXSBuxWpFTqqwypcFZasFCJJXGf9m4vFTasdxUWavfpUj8icQ7kdHveT3d02qxMBLaYtvxXPSHZYcAQ1zK5uEcmfaDBUNLnysL7Ar5I/6rncKV5Rt2r+0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(1800799009)(451199024)(186009)(12101799020)(7416002)(4326008)(8676002)(8936002)(2906002)(54906003)(6916009)(4744005)(316002)(41300700001)(64756008)(5660300002)(66556008)(66946007)(76116006)(66476007)(66446008)(83380400001)(38070700005)(38100700002)(122000001)(2616005)(6512007)(26005)(53546011)(86362001)(33656002)(478600001)(36756003)(71200400001)(6486002)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?q7LuTdaVR0GDCVA6IaL3qhkTSKDuEwFoKJYQc++FTGfb9VY2e6d9UXojd/Lc?=
 =?us-ascii?Q?k3iVOnEJgOXQlNRc93PxXN73czYikc7Hkvjjf+GuqP0e5n3cdT18Mw1O4WC7?=
 =?us-ascii?Q?LGpXUXTtEKtzm+NT7A8G0Vl/O3zN/3ZLx5fi6lQVLHnpbJwOoHZXdvkuDhHE?=
 =?us-ascii?Q?UwbUO0BUAdzqqDnvExxok1zFPzQrN8JYsUtN4fmwieyGiS3/f+4lx/mgJlR1?=
 =?us-ascii?Q?kMjEBtPmOvXmUTIXWKz2WjsM/7/un+9IOjIgKaW4mJdXgoBKy8mVH5mcY+jL?=
 =?us-ascii?Q?ZKSaCEIO5g5998qs+e8hwa8QNkyd1GT/PQv485FPpF78pwnzQynz5T/ODN4q?=
 =?us-ascii?Q?X9dvGnFSJdq/iaREOUK+CfXPasXH0UvSpJ4R+6Im291NMOf+kuE7dIoIt+ef?=
 =?us-ascii?Q?IbVPeRIiYSZP9NVcS6rWn+kCg3Z2mOYnaIIwI+D/fF0WNLd8LNEtnPAOLDxm?=
 =?us-ascii?Q?wdvcyI3OdyXeZF2stC9UaN+Jku8fR/isEUOy6EK04L1gisbACjIYeuVuAYPH?=
 =?us-ascii?Q?ugjoDydRUUxU2MKrA0HpPkgivd+usex9ITqktJ1LtbeS+JSBKsEELbvVPDzb?=
 =?us-ascii?Q?g5C6QZmE7pJrICV3FiSOOSwuO14Ealayo8GoHvMB2U6B5AGq1xuwgNW3L9Ur?=
 =?us-ascii?Q?D4+rgJzTDXlvBCdeUdepB6yV/wCiVcOewQH8BWgAJrbX8nYyOprs5WHYCisW?=
 =?us-ascii?Q?23SLqJqIPY6FyVchWat+3MqCKvV+Z9db4UlmlUyhVuSz/5xCNuKjJOuk3jiF?=
 =?us-ascii?Q?6uX+WdWYHc6UBLu+d56rPPannIZ5MFkvEU9rEFUp+2iDe3k8iacEj71jP7Bw?=
 =?us-ascii?Q?/KQ72ZlFBtdXHIWRmFWcxRD3WZQnjFFWr0+Sw7GqU1bwOJLwmvnaraXV6OLg?=
 =?us-ascii?Q?H1PC8Zl0KOmQmAeCpkDiDQ+//zKyja/IQeeTSoVAKTSKNKHmB5uW0f2HrCF8?=
 =?us-ascii?Q?854NL/W1VP+8FMQhlGX1GT/EW/IsbAgrtOh+13wLOqMELg0Oq+3hHEPZHw2Y?=
 =?us-ascii?Q?cOhaKGQSZ+nGJD5KVzKIwypVCIQpkV8P9LUSSd9wdFAh+UE6lUgxuXiUx+Hr?=
 =?us-ascii?Q?ScmIVPX1ElYG0ejSla12zCB2cZVagGOJUBUPj5tFhi0fH/OWNKf//0g/kFfE?=
 =?us-ascii?Q?IzKSe6xIWpIhzTwZVEe6q1OIbALQIiA0olG7Y+71AIiK0lr22pmd5EOlp2Z3?=
 =?us-ascii?Q?uN8qmhoGk50yf23SVTJTaRw+kRbVtgdZ/q5MSIZwZ1hDVZh4sMRneJf6wlcW?=
 =?us-ascii?Q?gfv14rsJRvFGz4XuZJaKOEia3/QlMKc87G+bdJwEoN1GQuV2L9yOZha2GMvJ?=
 =?us-ascii?Q?xs1b99Ctgflfv2nYZracZ9b2/lYpyfMsay+9rOlnyUtoqCKxm6x55kHso+w5?=
 =?us-ascii?Q?AAbdB/iK6ZJvllQq9Q1+MEDRbHqIyWndEbT167dnTFhpxWTbAkCCzw3dB6Dd?=
 =?us-ascii?Q?G6FccPvEA41V7gt7p/SGwiN4OWzKxKoqUIxYjg8u2Yud22hIWZ3VlkB1TSUA?=
 =?us-ascii?Q?icPyqmmnfdxlkvwE+9CYl/scpHCSMuWXG7DekfS/Lrt21lGmAFdeieB/yKqt?=
 =?us-ascii?Q?ixJl7W4lwZW6pjlKtyPpvMOwjRK0bTIh1phsSl4e?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE707D74E0E621428056A136706271F4@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15abcf0f-43b0-4e37-9e65-08dba4b6d3b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 15:28:54.5481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /j8yFkrOVOnFVQ7s04JYOEozCtqFI2D8AIKG4kcYPDaqkEdgig45PyucLrHtpG1NottR/7ZLxY4NniSatsxnHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR05MB10355
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Aug 23, 2023, at 8:42 PM, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>=20
> In preparation for implementing lockless slab shrink, use new APIs to
> dynamically allocate the vmw-balloon shrinker, so that it can be freed
> asynchronously via RCU. Then it doesn't need to wait for RCU read-side
> critical section when releasing the struct vmballoon.
>=20
> And we can simply exit vmballoon_init() when registering the shrinker
> fails. So the shrinker_registered indication is redundant, just remove it=
.

...

Ugh. We should have already moved to OOM notifier instead...

> static void vmballoon_unregister_shrinker(struct vmballoon *b)
> {
> -	if (b->shrinker_registered)
> -		unregister_shrinker(&b->shrinker);
> -	b->shrinker_registered =3D false;
> +	shrinker_free(b->shrinker);
> }

If the patch goes through another iteration, please add:

	b->shrinker =3D NULL;

Not that this is a real issue, but I prefer it so in order to more easily
identify UAF if the function is called elsewhere.

Otherwise, LGTM. Thanks.

