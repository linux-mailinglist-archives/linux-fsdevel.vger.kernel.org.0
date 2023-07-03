Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE91745584
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 08:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjGCGgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 02:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGCGgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 02:36:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE94BA;
        Sun,  2 Jul 2023 23:36:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF9B660D57;
        Mon,  3 Jul 2023 06:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7DFC433C7;
        Mon,  3 Jul 2023 06:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688366202;
        bh=UBJc1auuOFFqvw5warnQODe8BuMVkWvGCoyhmOm3m2o=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hUWZeNfBu6atkNDe2zOlByfT5AtCmGTcbwIOBL1Cb61CjjOUhLRbMuIxdtRrukK2K
         ROIL+eJjO6UIT4CJWK3q8QjnFx1uk2L1Y+12iW+3bR67o1+7r5LzLqnFJANJLmm1Xe
         fPPml0S3pekKtrd7TRD93WSRJPvhchW8DDVdFonnEljD8IdeIekNdQyqMslu0Vp2x/
         Dy25yWrRRzSY6DaPtQgDKFNtj+3GSIoJWKf+MB50tJ0zSYnqcyQADNg038pKlT1plC
         +x6d60jfXuksl9MN+le6Fume9/5l/UBMv2jLaiAZApG7zMwoTF8Tx5tD0YulNcj7hK
         QG71EKMY/JcFQ==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 0/2] Two cross-compilation kselftest fixes
In-Reply-To: <20230629162301.1234157-1-bjorn@kernel.org>
References: <20230629162301.1234157-1-bjorn@kernel.org>
Date:   Mon, 03 Jul 2023 08:36:38 +0200
Message-ID: <87ilb11oy1.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> When you're cross-building kselftest, in this case RISC-V:
>
>   | make ARCH=3Driscv CROSS_COMPILE=3Driscv64-linux-gnu- O=3D/tmp/kselfte=
st \
>   |   HOSTCC=3Dgcc FORMAT=3D SKIP_TARGETS=3D"arm64 ia64 powerpc sparc64 x=
86 \
>   |   sgx" -C tools/testing/selftests gen_tar
>
> the components (paths) that fail to build are skipped. In this case,
> openat2 failed due to missing library support, and proc due to an
> x86-64 only test.
>
> This tiny series addresses the problems above.

Shuah,

Alexey submitted a series [1] that makes the 2nd patch of this series
unnecessary . It's on Andrew's -mm tree.

Patch 1 is still relevant. I guess it can go via your tree, or the
RISC-V tree.


Bj=C3=B6rn

[1] https://lore.kernel.org/all/20230630183434.17434-2-adobriyan@gmail.com/
