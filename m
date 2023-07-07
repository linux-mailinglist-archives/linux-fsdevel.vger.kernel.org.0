Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFAA74B576
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 18:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjGGQzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 12:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjGGQzh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:55:37 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2059.outbound.protection.outlook.com [40.92.18.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42160B2
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 09:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDFAoasafgNmgQaJGRq5yQbm0Y1FU093XTYDqz8PoUA30BM+67F0BDHuPRq5XWt91QommgtfE5aYEdXb/VtGX5jJxZns1V8wGHZ0DDSjklR+qbYdqPoUZOKWB+KoW/5gc94QOG3g5o7K+7dmPDVtimrVjqVooOjpdie97OjAWihoJmDEvrgjpUH708+G8TaQnluaiTF9xDzn9xoyk21/dkVvk8ya56/SQNaFl0CX9fp8TXwjlQTA+pGqxfF4hRTwkgQ71z/yqQl+r/ncqqp4zO/KntqqHsqU4aIHc3okmQEFVmSnH/U71+i9hFmiax2VepjfE+twxEZ1LEGIhPpBAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAOjE7v2ptaf9BCkHLdIJ8VmLJNBQDEM1eP+AQNjW3Q=;
 b=NcnIrKeXPyInDThFXOmFJ4Gc20haSW+CCDn+EOPDEOerVnzPqoTG/IVXheiNpHFJWWJQsTTdCnAwbHqoVTNZEGQ4hrTLK4irWn3/zZho5A5wqID9szihcrwZEJYfMvM/dO81ZF2NXk6iBKtsn/9PDNsF63HbYhYeFLcC6JXJUeTZshu0kKxKbGACP0RdfN26NJoIjjprpccW3UKZd+CrAecyP+KH+dOm2wJSwBikUgu4l624zc9s9nDid+2UCxXHqmU1GrJXJNCVZ1TgeKpgl4lcJ/nSm4TQeCPZG3zgbZbhuo3z4OR8DXTYQY1O38Hk7FD5zsUZ0VG5s9lIEFg/Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAOjE7v2ptaf9BCkHLdIJ8VmLJNBQDEM1eP+AQNjW3Q=;
 b=qAJB2Pql/2nPSKqfn7ASxRFoUxi8epr4m/X48q+iMa7qC3fSK9OIFfDjujPnm1u+bp/CcsmNKdbA3LTFfUku01hptJB5OhgCMeRpwhG9rYjeDsrOBhdZVr9SsXdSKe13ghwMhPfvYc9MstH+9NHSfIUmQxXrTEM2+b89A2zN4AzGQrr1PTr9xV7twNzBlLifFIYL7DwiQ2vhNpIIk5vMW7nG0tbhZ5PV/YkzyTFBb5uYsGiD53AXPmZVUQyWbggTmHoH0YZW1MMH7S/Bt80v+CkeopX0hA+e98rIX3Mq86dsghbtH2b9qlXHbxdsMeusoNJo0l1idHn9UGtVqwO6IQ==
Received: from PH0P220MB0460.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:e8::5) by
 MN0P220MB0813.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:37f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.12; Fri, 7 Jul 2023 16:55:34 +0000
Received: from PH0P220MB0460.NAMP220.PROD.OUTLOOK.COM
 ([fe80::1780:aecc:39ef:3be3]) by PH0P220MB0460.NAMP220.PROD.OUTLOOK.COM
 ([fe80::1780:aecc:39ef:3be3%3]) with mapi id 15.20.6588.013; Fri, 7 Jul 2023
 16:55:34 +0000
Date:   Fri, 7 Jul 2023 19:55:28 +0300
From:   Roi L <roeilev321_@outlook.com>
To:     linux-fsdevel@vger.kernel.org
Subject: [char_dev] Invalid uses of cdev_add return value
Message-ID: <PH0P220MB0460FF96CAD7BE766E439DE8DD2DA@PH0P220MB0460.NAMP220.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [Rvqar/4heLz2+Nyl3iMacgSzMGpoeENX]
X-ClientProxiedBy: FR3P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::18) To PH0P220MB0460.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:e8::5)
X-Microsoft-Original-Message-ID: <ZKhDgJkgepdHkO94@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0P220MB0460:EE_|MN0P220MB0813:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c61a3b1-0b9c-455e-3e0c-08db7f0afb11
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //QKb0rPihniKYtF5mx3ImxhP9ZxdpyemDP0L3+k4XfDwmnaFzRU0GJgorpZG47YQGddPONaNPbxnfYrWKtWB3Jn7z+fDqQYkHtoNF76U7eh+6i6pGgLtMvUj75zKQ92VaARh5GFkUQW2PPvYHaZ+/0HgPi4/zEkRcMB5rA3LFv+/lzaiwYfi95NKs/qDP7m4rvQ/w3pJLuVuiwTUMnOOR7zP1NC2kfe2WcfHjABHdREXWdcbjrYjnqxMcbsKcQztQribFGM9ercYVoTLJ/2POh2++9GguwOU567jURFCtIi/unAg/4wnw6TIEm5PrOCdx5Ouh2bYd8Go9ssc9RltBuzSN7UQSl1UIioBPGDeVX3WKJgLdlzzLliqUC8d7DPUXAcEXsrlK+SAXdYbcTvsmmAMeEL315/1f1njK076Q6ijDO2bQHHMoiWOLrfLxhodJcivEKhjFg/jyFUdUdBTIyiYV8I99QR+02BAOj5CD7RJxqth5+A41pBrDsxwyB9QuwtKG/USA4PXvSC2BQgHMX/tp5dlicSktK3jQVZC9g8pCApZAKRdx5vaBqU9JK0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TlgkM+wrTfUda1fne0pti+GuYq7mygGXEXU+dJaV3PUvj3mShi8rm1V5tsxM?=
 =?us-ascii?Q?dMDvrQ3s8P7HmvUucUZTBQfK5m6Egjd+3WQwGXndA63RKwDvOV0TGIIfefjt?=
 =?us-ascii?Q?763LxbKBmYj5V9leyvdyYhMKViG3PxcGCoyoR9A2RdFhtme2DX0zeUpRRbfZ?=
 =?us-ascii?Q?ZZrUeKvqN+07Von21z9JlbfdAIGpQPo0Qo5eF7UMeopA1EPFuCgvwwNbglHy?=
 =?us-ascii?Q?cM1shH/dOAJmEth/NAlRwbfaoIqUvq7R9mCtjJYrfE6Qz5c3fpNZEkwKT8Jz?=
 =?us-ascii?Q?n0GC4s2xpiD/kT9SjtodlEFE/28EfCwMnqobAYbmg88yCBvhyuZbK0LA/QwF?=
 =?us-ascii?Q?hxTQMhZvV6B7PfIe2S4rWYOkX/FD1IWDdodw4Zt4Ef7NYCeg0RO6S7RwCNnt?=
 =?us-ascii?Q?weIhRoIQttF99esNM3bPatF/om3m1cY0pCicOkWrgS6e6hIhKcpvM8hy3FyV?=
 =?us-ascii?Q?Oqh/4jvnfq7AZu884sqCXIgAOCqT3+Am/TyBYlG92QKTIeqANLm+SiaH16HX?=
 =?us-ascii?Q?++/LIDYdV+8QJ0wljseV+Wj4OgR7l1M3y0PhzgTZG+I0airgNhC4j79ud2ly?=
 =?us-ascii?Q?aRybYLL2jWVCL+RP6LKT7SM37Crr10hczlIMaQpW1ms6Yo+f7YUi6RAyirtt?=
 =?us-ascii?Q?cBEiAf9c0SNQJe23RRFXaYCy07DHIVleufZixJ95Doz9JZyFysGilCT3orWy?=
 =?us-ascii?Q?0IJFlB8wYeMMJ2RwafQN3E/7qRpX/xMqf4KB2fInQQXS1aWPLUOVjftmm0Ye?=
 =?us-ascii?Q?aBTRExY7g8qpKwBZ+dWG011/UK2bN4dIN7oWQp07bJ0m1njwVGoiKNQbBmtP?=
 =?us-ascii?Q?iZ7TzK08qI9rtz2p8g1OJYD61Q350+TiBdQqvGtNxGEczwrECYnlS8QSc2mg?=
 =?us-ascii?Q?LxgDDYnoOiJvRD+4CgkQI4e/+0bTIjb1EaB5L7HAX4tN7C/0LkFeUeqXGahA?=
 =?us-ascii?Q?SW2jD48FMQ7KX8SirhjFd7MxpEfjqzj66U03Tvt2LHT3iT2LB83iJKYf6n5z?=
 =?us-ascii?Q?QQgr0z9lPzBtp1JNqvIOfzm1SWOo/xsae/I4nac+mku6MOiGpa4Ds/b4338m?=
 =?us-ascii?Q?CR7bMuK6j08XzrQOGXJ/y4n8O7rqqI3XQllqnOlfhZpJx/ac4fqC0EQBu7DD?=
 =?us-ascii?Q?ypXUejmcRCgiUwP4isFOVuyeIl0gR4dIaRuVDp2Un7OGNlfWLeftnqrmkmVL?=
 =?us-ascii?Q?VwqUz18O8ZCTV4Q+a9YvODq8OFn+Qct5oQoft/4uo3Y0by1LEuTc8Qew/ew?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c61a3b1-0b9c-455e-3e0c-08db7f0afb11
X-MS-Exchange-CrossTenant-AuthSource: PH0P220MB0460.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 16:55:34.3918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0P220MB0813
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I hope I'm emailing the right place. I have recently noticed that there
are many invalid uses of `cdev_add`'s return value in the kernel source.
While `cdev_add` clearly mentions that it returns a negative value on
failure, many calls to this function check the return value as a
positive value.

E.g. (/drivers/mtd/ubi/vmt.c:581)
```
err = cdev_add(&vol->cdev, dev, 1);
if (err) {
	ubi_err(ubi, "cannot add character device for volume %d, error %d",
		vol_id, err);
...
```

Also, there are a few sources who check for a negative value, `err < 0`. I
I suspect these are indeed invalid usages of the function, though I'm not sure that's why I'm contacting you.

-- 
Regards, Roi L (roeilev321_@outlook.com)
