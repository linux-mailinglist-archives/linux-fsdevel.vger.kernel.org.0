Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1364758C90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 06:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjGSESo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 00:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGSES3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 00:18:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B28C1BC8;
        Tue, 18 Jul 2023 21:18:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E43E7611E2;
        Wed, 19 Jul 2023 04:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC094C433C8;
        Wed, 19 Jul 2023 04:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689740290;
        bh=HzPGUGVVAnacWNd+eMF1RM8uJWsfGi1cr0osF3Y6ibQ=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=ueykUEPI4J01HDdtRaZSFPpw+gm5+XxSiWAoEDDhnUvggMHXzemAQZMG+/2BYynE8
         vZiBhhQWx5vpTEPzAiE+EyP+hFKZHb1gxplnter6GtCyhcY2AAhyeEBYPsXpfm0zxm
         UdaVFpT7LPfLpmgVXLSF1MT7Nrfp2mu9JigYsr4+to4u18sJHCF35zdJ/poSj2M0xp
         OTxEhWPj4QR/OJS1Y91pwNHaI2ccX6cDYhPafk8LVazjwkaznb2BAL+VK5iS2dHa33
         vxlKOcV3qN3dDhI5Pcbm19FJZ0ybqft22hMEvq6oMP6fP60jG70/TJDxJ94Avxjcsm
         U/LSi2czUmhvg==
Date:   Tue, 18 Jul 2023 21:18:05 -0700
From:   Kees Cook <kees@kernel.org>
To:     syzbot <syzbot+98d3ceb7e01269e7bf4f@syzkaller.appspotmail.com>,
        andriy.shevchenko@linux.intel.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] kernel BUG in hfsplus_show_options
User-Agent: K-9 Mail for Android
In-Reply-To: <0000000000000a88cb0600ccef54@google.com>
References: <0000000000000a88cb0600ccef54@google.com>
Message-ID: <4F5F9CC2-803C-4E18-968C-A46B32528F1F@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_PDS_SHORTFWD_URISHRT_QP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On July 18, 2023 6:27:23 PM PDT, syzbot <syzbot+98d3ceb7e01269e7bf4f@syzkal=
ler=2Eappspotmail=2Ecom> wrote:
>syzbot has bisected this issue to:
>
>commit c30417b20f4993e49406f3f6d986355c6e943aa2
>Author: Andy Shevchenko <andriy=2Eshevchenko@linux=2Eintel=2Ecom>
>Date:   Mon Jul 17 09:33:32 2023 +0000
>
>    seq_file: Replace strncpy()+nul by strscpy()

Uh=2E=2E=2E Wat=2E Is this a bug in strscpy fortification? It's copying ou=
t of a (recast) be32=2E=2E=2E It shouldn't expect to find a NUL because it =
hit the max copy size already=2E=2E=2E

Looking=2E=2E=2E

-Kees

>
>bisection log:  https://syzkaller=2Eappspot=2Ecom/x/bisect=2Etxt?x=3D1748=
8c1aa80000
>start commit:   aeba456828b4 Add linux-next specific files for 20230718
>git tree:       linux-next
>final oops:     https://syzkaller=2Eappspot=2Ecom/x/report=2Etxt?x=3D14c8=
8c1aa80000
>console output: https://syzkaller=2Eappspot=2Ecom/x/log=2Etxt?x=3D10c88c1=
aa80000
>kernel config:  https://syzkaller=2Eappspot=2Ecom/x/=2Econfig?x=3De7ec534=
f91cfce6c
>dashboard link: https://syzkaller=2Eappspot=2Ecom/bug?extid=3D98d3ceb7e01=
269e7bf4f
>syz repro:      https://syzkaller=2Eappspot=2Ecom/x/repro=2Esyz?x=3D15ecf=
646a80000
>C reproducer:   https://syzkaller=2Eappspot=2Ecom/x/repro=2Ec?x=3D1476f30=
aa80000
>
>Reported-by: syzbot+98d3ceb7e01269e7bf4f@syzkaller=2Eappspotmail=2Ecom
>Fixes: c30417b20f49 ("seq_file: Replace strncpy()+nul by strscpy()")
>
>For information about bisection process see: https://goo=2Egl/tpsmEJ#bise=
ction


--=20
Kees Cook
