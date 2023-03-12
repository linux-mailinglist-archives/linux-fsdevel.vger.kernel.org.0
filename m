Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30636B640B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Mar 2023 10:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCLJZm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 Mar 2023 05:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCLJZl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 Mar 2023 05:25:41 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2053.outbound.protection.outlook.com [40.92.99.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6034338E96
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Mar 2023 01:25:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVek/OVmucRmuS5fRXXPfBy3LwNXuuOHpZmwFrZJyWxaz14wmfmMJ5gslqUwZ59pZl96TlqfUtWaqAS5PsOaSVrGCl636Whs/MYHCNA0En66LzfVSjoEkk3SX8WQT+Dkn60yUU3BY2xyMEWRaa5vmuIRiG69yR+rofp45pXImgGy9oe4/ikXQFgH7c+atCipjO1NU926S0rIdq7SJWob79RNrrU9Fcjs4CKjShSNYmwmkva3e/WL9wC8M0MCV8SYn7AowxYWTjMUr1FDnP3/p8vFZ4JjxIy/93KhyvsuXx+g8HRgt/Zv88CCZBg59eAYLEneuW2PybqRiUiZQZV0+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ni8405u452ydJJzRhUB1RK74a1ZBDcikSxGIXJUYXnI=;
 b=guvBM2PI5pRKjy5OJXTgbMbaMoImhKIYQnPgoksKOqJA4nNaJczkW0e5YFI9YPRNRWPK0xdBuctd1YLmxUKaiUW7p6uvikuibYpeUwmQpV461b5hY86uiZ5ZVECG295TFy4GBFKmdf5r8idcwxtD+j+PPfYvKLHxN0z8fx7P7gJUIrOXKzSDLv32nKBxYChD8yYvYG0U2Slyf6dtTvTGDquc0+x1ni5pVeSteCdCCZCnvhWNvM/p0tSOb1Cc/GV1EikmDdXzA1rvkKsJHRBmkXCzR34AiGYLplTFMYcqQAkfSy8ma4q+p1YFlPYFReE8tlJjJ6Ob8tr6xU+ztfHCog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ni8405u452ydJJzRhUB1RK74a1ZBDcikSxGIXJUYXnI=;
 b=R3VLnmQQxp1E3zYoKa7rpZlcnZ7zS+2CrnSA+u0v8vQ/AaW//WnHcisHBxJtxBz/mQ7TY1snSng2sQ0ptUwhWpubPKxcCSPlx5ut4/+2ozD1lbwwWbFJySmdWCE7DY1ObOUjY/zDMfdklkPNzuR82ACqZ3x0LqV5gl+/ytcjSedZd3IknVg7YEVrpNERbQ//BAFpARHSkrFOP4v6Hnifm+lDp2oRlfh6xsldbsYKTwZD/aR4jXk/a8uhS/63rJUoMV2kCTOAfDoMjasmIMzweHG0Yxp4kTZIyF1LlIy6lk8so2U7XCpxicJS4Z4OKxEIS40zKhbYfX/Q9obUAVwGvA==
Received: from OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b5::13)
 by TYWP286MB2299.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Sun, 12 Mar
 2023 09:25:33 +0000
Received: from OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7bf5:83ec:d81a:a321]) by OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM
 ([fe80::7bf5:83ec:d81a:a321%6]) with mapi id 15.20.6178.024; Sun, 12 Mar 2023
 09:25:33 +0000
Date:   Sun, 12 Mar 2023 17:25:22 +0800
From:   Changcheng Liu <changchengx.liu@outlook.com>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, changchengx.liu@outlook.com
Subject: [PATCH] eventpoll: align comment with nested epoll limitation
Message-ID: <OSZP286MB162945062EEF86CA39230AE8FEB89@OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [+FnASFtm66wnkLLB+hBQDt9IGvyF803t]
X-ClientProxiedBy: FR0P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::13) To OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1b5::13)
X-Microsoft-Original-Message-ID: <ZA2agnmNS5Mxuf3V@gen-mtvr-09.mtvr.labs.mlnx>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSZP286MB1629:EE_|TYWP286MB2299:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df5790e-430a-44e7-924c-08db22dbbb10
X-MS-Exchange-SLBlob-MailProps: AZnQBsB9XmqlMnhDLfS9U1bXeHotjOuLsJq3ssS5o//yrrm2yVNUb10UI329/qfJp2FmERZBqn0nYr1hyzt/OuTWPN4kV/HS2pSiwRyCeVz/LVay17MhDQnWhuAJ0ZfxmoEGuP3AslJgtihCTyJCVBtMKlHlTdJ10m1nODsLpekwOpgNIjaTFf0Na4R8TRdDDd346hKOgVtorDxQaKkWmuJ9Ka1Rgw5j61L30MB1+hGcglRfJx+WZxE0BZqMOInShb4e3Ki5Mavpz0fHpP2T2nxuthTjMeqIwdoWi+s3PziEX07JGINuQirZuRo/5Sn/JHXzjwAtnzTeCdS8mc3Wjm4yIru0T1RroYA+sZ7S9DdY/R+MhB7oqd05AenDR71m27JWK/8sSKnzz9k8hJfFM2jrI8O+dCDfWHCJCJhSN6NvWxpueJOVPi7RpKySpLfD4OYo3l1hAPtPVjd6h2L0hI+MGzCkisK2AH503vXJy1pqKae1GIQxFc0k7p8b/XTNwEE+Q0Wj56d7t+FS9Yy5TNtnhoEB65h98Rt5BGCSER8E++0RG7OdqrYFs+EzMpHKgeTdQWJMI+O7N6molwfEPYID982HJbwJfHNWxLryhFCQf7XbfB0MjqJdhzj9do/eMfMPnqEGnPLFEwRNSih2GbZOfW5BoK+hPdbOaGg9Wh259l/xZs7kXKLp3TfLQ10i58sF4zACExkAFRr1gp5CKt/ivnnfhkgZSanRM6rAFXudLqU9z8rF4YX0iD25ZIJi0+Fv3rmAK7g=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJjg8d7xygj7/DDNCKoNJfM83dYIgcM1Da/As6FW6iuRaC3WIREhxvSgmAfD3L5qYu3fCHWQQ8GZKZnoJUlw+LBwpZGbJMCqatCvgJvjDCT0nE+gfNLqCxQHICsH1kkn3Ov5AHPzWpYnXx6X6m9GJuGgYs+U4duRM2X7m6YaFnAogeFdnSjlTZ8f0h+29r53V5o7xjzO6eM4y/W3TtgV2zD4Xhi19qFu78tjV4Hp8XdJcZcePiOTYsXyR/egYzM1dbsZv51be9NIKOGqBGf3B7rHiiImDJJ92+mqO6VBjqOyNtDkV+T89evj06DLlXFsB4+JjkYKzHoBUaCwzJFiaeIyl3SICSHFvHZxLO3StnXBdsLXtvBRUPK1CzNLNvcSM7FsKCA8YIuQ4yIVjDBFwRzJ3fRlnzOkhQ6uiUoTayNeZgGohZQrygaN2d2df8W9P0P2HvHddonZNk5Mi+/a+feGUxxAgsvDdLwCpK7pTQ6gEjf+fk0057zyrnG3egsRex5W/+g/k5tWUA/kcH0dhgNJ7vTOAx3GbHE8lTThvtuDjRwi6seqadbBqvwPu4W4ykF66vqWDe56+mOAie0LmI7ObT5NEiQD+oMW5vVHfrXrYiFcE2XUmSTqgnTxetSdCUX6L6BcMX2oT26z8OBHNw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?V8QR9nPC/bvnoYY0rEpU2rG8y+zWKkXBaU5QVMjwj+FPde0mpCU/9SnPwjML?=
 =?us-ascii?Q?Uk9utKU7IpJ9/VyBUSGEYSM7cVrqnoYusLXyvNfT9iIBct+X50P+rBXlaBlu?=
 =?us-ascii?Q?N38Fq6i87UYvLvHmz+4CdQm8CosY3oqJqTKt3zj7ZNkYKR+gi7Uibh225D6J?=
 =?us-ascii?Q?jRhbbNWJDs5kgXuCzdylhCIaWbanocw2q58U0mYySI3b6Fik9p1wQw9B2NOs?=
 =?us-ascii?Q?bEpozPuwL6/K9QwTLQm1eNRyXSpu1pCjdiBjWb+h32q6JX8SDEUFq77UwIT4?=
 =?us-ascii?Q?zFxqjd9SMFwvE4DjZ8VjVOZ5bqAtoQrhzweX0qnhVbDbQZsq1N8iZNJAhu2U?=
 =?us-ascii?Q?iYBGzCJCRqxgC42Piqzu/aIoKSKRlnn5x5g2Cg9bytg0LeYjz5luvde/kjnk?=
 =?us-ascii?Q?a5RzRmnMo+kvztrsFAG5X9ObyMy8H1uPMWEfKzxzpzyJm1WGFW3aYu7JFPG+?=
 =?us-ascii?Q?SmAYYLtWYdc2RZUPX8oFDcFkMFAOag8TLrUxcpzfixyFC5h29uauLqZQGSBE?=
 =?us-ascii?Q?KnhyTlv13AALui9E/oy7wrIYW9dalh8/L4SB1hAjvyAmXpiYuh82RB9l8hC2?=
 =?us-ascii?Q?AwVbWQJr8p8jTFrvjo4kdL5PE3qyo6HMX9Yc028OUbJFowu2nq9FBsxeP0NJ?=
 =?us-ascii?Q?hX2XASssOaLb8/DaBHSNYPnIVABQVjSlQj2FVA9ZZOIa/tQ2XBzyW9szHffT?=
 =?us-ascii?Q?ZphVaxFOzpf03+W8qEBhImEepxJVuhrCOfoMPeQGd1RuXDmFamUL+MLUDCLg?=
 =?us-ascii?Q?6yFpWj49vEQD0DAOva870WRUp0BtZBcYG3F83LfypxB3bh2xJMxDx1199gD4?=
 =?us-ascii?Q?6Owdm3N3Zym6/7Y9c9uPbYylQOE2xY9ZOLF/E6TJwUiC4UTOtqCvyEv5VFhw?=
 =?us-ascii?Q?0Gg55jGKoOPBRYXuPVOthvVWupzWj4yMHnhAGZSWrU/hMz5wEeRxbHYGsk/z?=
 =?us-ascii?Q?kHkO8K8obTLexgUFJj4oEheyWnNmGk7lfZa7Qqub7+smxHXDHZTs/CZo26xO?=
 =?us-ascii?Q?kXhzfhzNJOIFysncoNWzkBYRUv8mQyreZYduanzeTiPbAYYk76zaZXmbVxuo?=
 =?us-ascii?Q?Eya6POoEvTzhJh1cjWN1nfI66Nc7y7lcmVgOx8mWtHbC3Ayt8AxUlhtHDcHX?=
 =?us-ascii?Q?+Yv3V5sEXNKo9l41pc8hjtXpee4OMB6xargjMh4ZDTfhgVw6qtUzPGABcHcA?=
 =?us-ascii?Q?qQR3v/BSQMlv0ayBQ606W+C7QM1Q52FGpWlSIfuX5ullnm/Hs0rI8VHyBwuA?=
 =?us-ascii?Q?R5/VkUWrqARjU0zEQllIAPWYatwkJhVjZi603sCaF7jnUPvG91GsouAAuRCU?=
 =?us-ascii?Q?gY8=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df5790e-430a-44e7-924c-08db22dbbb10
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1629.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2023 09:25:33.6708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2299
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fix comment in commit 02edc6fc4d5f ("epoll: comment the funky #ifdef")

Signed-off-by: Liu, Changcheng <changchengx.liu@outlook.com>

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 64659b110973..f6d25050dd7a 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -483,8 +483,8 @@ static inline void ep_set_busy_poll_napi_id(struct epitem *epi)
  * (efd1) notices that it may have some event ready, so it needs to wake up
  * the waiters on its poll wait list (efd2). So it calls ep_poll_safewake()
  * that ends up in another wake_up(), after having checked about the
- * recursion constraints. That are, no more than EP_MAX_POLLWAKE_NESTS, to
- * avoid stack blasting.
+ * recursion constraints. That are, no more than EP_MAX_NESTS, to avoid
+ * stack blasting.
  *
  * When CONFIG_DEBUG_LOCK_ALLOC is enabled, make sure lockdep can handle
  * this special case of epoll.
-- 
2.27.0

