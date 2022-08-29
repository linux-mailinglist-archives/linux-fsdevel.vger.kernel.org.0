Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C8B5A52DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 19:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbiH2RND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 13:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiH2RMo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:12:44 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2126.outbound.protection.outlook.com [40.107.11.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8208C032;
        Mon, 29 Aug 2022 10:12:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFYlbqMdb9P94ANAkI5Dg1qUt3jtQ3UbCp1O0sNphaE9FHUk3LvcW2K4PgjsqYTT96glOxefpUFRx8mVKtGaRgYuF3YRAj2zdLj6hFeiQ22clC+UocP+TE55/i65DaveJwY/vSpj1xSkylTHO3L2fGTmPfW/zc22VkD/NZWUf0HpjPE8aFkmCAuWJeQ/zRXB79Thqbepv732CtcDc54zZsmDOubouFvaBGOQ3M8Ic7vqftPUZYBmvEluss3IU1tIoeNxfpwH0clYHPz30VGQWyWrKb2aPIMpKoFQyCU19woHOXMu++QSYv6a9LTsbkPyn67GCkAlL0RvXGRb2wgosg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ANPd6S9qgRXWvh9rOD3Cfgz6gPRsnp4F+cXcUMjZd+Q=;
 b=kGXPjVSOGs0LD4iYy5bsvXJgEne5k84tqAeeS6Qkfxl2Vvhavh0dcec0/KVy6XFoiaddcdaSDvS+xlZwapIPwElstgg9x1CrqO+vUYrnBJ6Y3YFd1cZmlMTB5ezGqD5Gg0ddcT3Lp2UmVmVT4GUQpyaw1GkJYg0JlI8i5oho5BRQ2F8BgsbCt+y8h7fOTeKqJyDRUeJkDOr/tmBScQ3ZjMcr2Rzt3qkTrEf8Ju0OJFS/dMHcny8XwkCOR21hb79gUDMJfQgEvfvG/aAnG0dnfwWuB+h/GUIcG/bxm70d1L5Q7eppS8mFLI7J8sHSt+6+5NJJL8RLxAgePVY2DGEDIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ANPd6S9qgRXWvh9rOD3Cfgz6gPRsnp4F+cXcUMjZd+Q=;
 b=N+50HEG7ieihluNJ/z/DfEZ4P/IodwDZda5XzVeYoeSFMxRr97IxCX7ZiQw0FU2Fc5mAcShRk8ZfzZTDYUZlvViLHmpQAXbUstPRnCkAaSLDKXXBxg/6dvfOS5qpq/n1I86E/GEInTA+c+FIAK7IYJH+swJiTOJulPsjLZYNiYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6683.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 17:11:36 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::d051:d2a2:4b47:f935]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::d051:d2a2:4b47:f935%5]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 17:11:36 +0000
Date:   Mon, 29 Aug 2022 18:11:33 +0100
From:   Gary Guo <gary@garyguo.net>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v9 09/27] rust: add `compiler_builtins` crate
Message-ID: <20220829181133.00005f01@garyguo.net>
In-Reply-To: <CAKwvOdkc0Qhwu=gfe1+H23TnAa6jnO6A3ZCO687dH6mSrATmDA@mail.gmail.com>
References: <20220805154231.31257-1-ojeda@kernel.org>
        <20220805154231.31257-10-ojeda@kernel.org>
        <CAKwvOd=q0uErrBVadCbVVLyTzvXxmgJSdOyRHqahO5at8enN6w@mail.gmail.com>
        <CAKwvOdkc0Qhwu=gfe1+H23TnAa6jnO6A3ZCO687dH6mSrATmDA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::13) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb047e3e-d8bd-4b01-6f78-08da89e187d1
X-MS-TrafficTypeDiagnostic: LO4P265MB6683:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKx8q6da5N3mJIOp0TGecjUIFRHg6IYmUGfFE5kxYw8XEAEzZe1ZAtQyCcVVxC3iQm8BBmeSDsCbEZ6IltlyzeSIPQwmg6pjTl4Dmce2h+i0hYPQEqVMIBnOftG6SPlQ2bJNGcfTLP2Ib+Wi1CzzULcoCQolDbsWuami08dk7q1s+v5yqAijzkwfHOVhz8vIzn9RIHpQIDid7KCNNKgW9ulkBlubVDzXyzL4jJqq8N8gO+0Y5/u/xX9yKjYHeXpzCuO9T//2b+Krae+DYK90IMIRHHKxsfZY073zmPtAafon+vGi5UeP/3w4bOekDEYeAAdygBjWEGm5RM8gCTod7EgflH7JIBoDka6yGlDiEMy8UqmsTSdz1uYMNNRExC6piKhZi3f9lPl423srtD5lG81FyEhOxIwDFzJMgiYCj8TzsFWfv/4l52Tltb/3XbofX1w9mpQJK5/totBpkjAO06XW25cQMmHxeBl6cru8VRH0oXgep7yq2d+B2p7gUmh7W4hyJrJTLWIG2bC8h6svxTeKLdNgwoLm2PJLRWnYEJBqqIodMoxLE+7N79SP20reb7xgdo1OwIVixo4UoxLFEnBgADchArx2dsRo9wpS3pwieoZf6tFl8rQa16V+VYV/AKa5NQJbEGuHPGeV/dpyzETRqdl2Or8CXfOIJd41cNQaBmUMb4Z3iZ+imdbiy4uzVd97Z1ywuT+2qqKfbmfOVy/xd0gKZHtE8oTrVtXt++wtDpiP5yZviPKXLB6G9sjsQlRxVj686jUGsJ91m46OYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(136003)(39830400003)(366004)(6506007)(38100700002)(52116002)(2906002)(6666004)(2616005)(83380400001)(186003)(6512007)(6486002)(86362001)(4326008)(66946007)(66476007)(66556008)(8676002)(1076003)(54906003)(316002)(966005)(6916009)(36756003)(7416002)(41300700001)(8936002)(478600001)(5660300002)(81973001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aDjCXSSNDL954r/xcJbyCHUcOAn3AwYq0l2vrJhH2YJf+AVNFrA0NedmVD2l?=
 =?us-ascii?Q?DiImogIbMwaCdcGqqDrJBEjHQYpRhg4LPMy2FqbxDrf7oVtnMNJAtVuOxpyf?=
 =?us-ascii?Q?ScJL5FxiqVJ8WYcPng6QMQIqnxiQpOAhLP0jAyXd+yWLZxXb5dpwBU/90ezq?=
 =?us-ascii?Q?3LW7vaf2v2IOYAvSXz5YWhAMUqnM8MP6Ijmfl4VheLNia1oGvUbv4+/WP04j?=
 =?us-ascii?Q?vKAjjLivO5EvtXs8p6evipvpX7abPo4zy1lAkO/PNCU1TPZaRIMgu3/03GC8?=
 =?us-ascii?Q?OHkekQWpW3MohgPY7CtEgFzbRhS1kLYN0V5perSP+0Ki3sp25Ifgb9gns81i?=
 =?us-ascii?Q?nBoGn6GCCVMp/Zm9RvzOjaJuXpXJjY0m1Pm/O6jZ5N/3fJFj1tB875/BYBWw?=
 =?us-ascii?Q?k8mxLoBmS4h6W8991QFfdwKXyfHvWeqaA6fD3ly3JA+3nm/9lRl0lYrJXIM8?=
 =?us-ascii?Q?Piz6NkrEH0DQ7cKoMccdOPr4mWdl4e/tXEepImBYgBn9KH7roxTW0k4Dx1HO?=
 =?us-ascii?Q?Da4Hz4eNC6G0XGigpJewq5aZyXXZOFfI7QV3tsKWmsytaFcxtnut8iwJtUo8?=
 =?us-ascii?Q?PWNVtxKluL1BNpkN3xVzEr1JkcSN4d4SB9SgLVrfu+41sAopWRxQx4DYc12K?=
 =?us-ascii?Q?dD8+Xrp+Q/Ri2XsxOqMWF62MrvLjD0WFyQm9eAq3Bc1XlvHJPkiOqPMgdNrE?=
 =?us-ascii?Q?9dipOwPkK88pbrseBJuALpqDAUWb6NwgwYXR1y4U+ieMVZlX+j8vVnQ+fA0y?=
 =?us-ascii?Q?krqXiUz562gLyYH1WmbrMJJA6wrueUggBDeUQDwKC1dk/2+0At/QDXtxWzWU?=
 =?us-ascii?Q?KIJ3Dhs68He5pc9An0HLCgCynMeBO1+hSfPsni4Z+6Hy/87aFEP+YbfnvSAd?=
 =?us-ascii?Q?OBpbPj7nInu6i3ekaS3iv0tlpZbDLjteXyPuWIToS5NgGNkq7qGhV5MLshC3?=
 =?us-ascii?Q?WbPzFgbY6LvaOZp+dHsSSaaetP5BdyoUnyYuHiYBXePQDF8cOLY2Z1EP195L?=
 =?us-ascii?Q?1pXZNRJDE+/RXnjmc9zpmrAcJM6tHBIuUECj+gz020NnkvJq/xiQiQPlQdxa?=
 =?us-ascii?Q?7ifGAyC8OHtXTb76yO3wUURPojSxcfOJyR/kRv/Oyrat3+3rKXzEP2PlI+Bk?=
 =?us-ascii?Q?Qtsjzl/srgDGDpnSbbEnKHvy5eteTfOasBS/K0GH/7Jva75tYQK7uQOxdsS9?=
 =?us-ascii?Q?gQQmpvJGSltROTvDbAvndn11prtPvkIdaYI92a1CpHnsEzaMyE0zLx1quhzn?=
 =?us-ascii?Q?3KKe2LP8Pu/ipa6teWkXn/qSSgJuVIDoby+2aab6aUEb0xWPjw4Lkb6ntSRt?=
 =?us-ascii?Q?EuDvEa/Q3X0mhXY4/+/tFHzkg2RUfw4nyfwHPfuU3Hi+8ytaShyP4h8DUINX?=
 =?us-ascii?Q?z57g0A2Yyw1xDbBuW4MdUCE3VKeQMe+Y4owdRIuMs9tdlgftTGj8oxISEfX5?=
 =?us-ascii?Q?VZHlXjCvODrzqkxMQl2MF1XK8WyOMi4fy7EG2OyaEAbMxu42O0XqlXughxtI?=
 =?us-ascii?Q?XeXUuL4xfKDKZ9sDXA7HUCmL0WkSIeOeyj7yWi0dcQeLAEEOylcL5VT5qwo3?=
 =?us-ascii?Q?LdSAyKJznTETTQE8gv0WQ7pcRAN4lpv1UUqfUhnmTw9Sn7FOqBqR54NYrBTU?=
 =?us-ascii?Q?SEtBm4ANvrdKoowwBXwiwaceciTnKEEIojClPdQ2tQl/?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: eb047e3e-d8bd-4b01-6f78-08da89e187d1
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 17:11:36.6580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44UwLCZdVRShsHp8jfBgQn+0J0IDVP9911qxJRLTHmZaAeq2dsO3OJ3h/tYQszqesH0aFXX5/CJGxCHn2UqyUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6683
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 24 Aug 2022 11:38:46 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> Another idea I had, and Ard mentioned to me this morning that efistub
> does something similar:
> 
> I think objcopy can rename symbol references.  So instead of calling
> foo, I think you can use objcopy to call bar instead.
> 
> To avoid the case of Rust core refering to symbols typically provided
> by the --rtlib={libgcc|compiler-rt}, what if we:
> 1. build core.o (with reference to the unfavorable symbols)
> 2. use objcopy to rename references in core.o to the symbols listed in
> this file; maybe prepend them with `rust_core_` or something.
> 3. provide this crate with panic'ing definitions, but for the renamed
> symbols.
> 
> That way, enabling CONFIG_RUST=y won't hide the case where C code is
> triggering such libcalls from the C compiler?
> 
> To restate the concern, I don't want CONFIG_RUST=y to hide that fact
> that someone wrote `float x, y; if (x != y) ...` in C code, where the
> C compiler will likely lower that to a libcall to __nesf2 since with
> the current approach in this patch, linkage would proceed. The current
> behavior is to intentionally fail to link.  I think what I describe
> above may work to keep this intended behavior of the kernel's build
> system.
> 
> Ah, looks like there's objcopy flags:
>        --redefine-sym old=new
>            Change the name of a symbol old, to new.  This can be
> useful when one is trying link
>            two things together for which you have no source, and there
> are name collisions.
> 
>        --redefine-syms=filename
>            Apply --redefine-sym to each symbol pair "old new" listed
> in the file filename.
>            filename is simply a flat file, with one symbol pair per
> line.  Line comments may be
>            introduced by the hash character.  This option may be given
> more than once.
> 
> So probably could start with my diff from above, but use
> --redefine-syms=filename instead of --strip-symbols=.
> 
> --
> Thanks,
> ~Nick Desaulniers

This is the approach we are about to take, see
https://github.com/Rust-for-Linux/linux/pull/779.

It's easy for just one symbol that is known to be not defined, but it
can be more complex as some of these symbols can be defined on a
platform but not another, so we would have to generate a dynamic list
of what symbols to "hijack" depending on the config. Currently we
avoid this issue by having all symbols in compiler_builtins
crate weak, but we couldn't weakly redefine a symbol.

It's certainly doable, though, but it require some effort. I am
not quite available recently so hadn't further extend and polish my
patch.

Best,
Gary
