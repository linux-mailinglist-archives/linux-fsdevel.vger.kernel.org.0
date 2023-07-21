Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EC175C6A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jul 2023 14:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjGUMLO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jul 2023 08:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjGUMLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jul 2023 08:11:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FAF1701;
        Fri, 21 Jul 2023 05:11:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 202F961A39;
        Fri, 21 Jul 2023 12:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6E9C433C9;
        Fri, 21 Jul 2023 12:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689941472;
        bh=hJ2M7oZy09pQU7Rc+HwKVL3JXlQRCY+27o6eYDiCBOw=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Bnt+PIbFNxpV9C1kCW/sa0AyI247EFlRDV6Wp3WTDuw6HrumMJB9BVFASXgvL8k3m
         yrF+mzba68CyW9YdLn3EowdoqSdHsViSyDHuJu3+M40mRMkyOZ9MYsL1k48aLHbbvj
         tSm77yZxLhEp3t+9vrmSSrB10SXdeRXwOJQJwfZtf4BSCLJ7YMrWEEcdOmtjGFuw8O
         g3gbg3b4jvRFLHF1a4T5VegTOZYPN52jDF+5Gnf2tjKg8VVCvRj9Zb8aZktxG78mvl
         mKgueMBoZjkffwTjsSW9soJTLDuI6m4r1r4LPhkmJwqc70Rje4oOM//PNfO6zjYJk9
         uMRFQcPILmSgw==
Message-ID: <d0b24d6d5dd15d80be5b1dcd724560bc5a016c08.camel@kernel.org>
Subject: Re: [PATCH] Fix BUG: KASAN: use-after-free in
 trace_event_raw_event_filelock_lock
From:   Jeff Layton <jlayton@kernel.org>
To:     Will Shiu <Will.Shiu@mediatek.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Date:   Fri, 21 Jul 2023 08:11:10 -0400
In-Reply-To: <d50c6c34035f1a0b143507d9ab9fcf0d27a5dc86.camel@kernel.org>
References: <20230721051904.9317-1-Will.Shiu@mediatek.com>
         <d50c6c34035f1a0b143507d9ab9fcf0d27a5dc86.camel@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2023-07-21 at 06:34 -0400, Jeff Layton wrote:
>=20
> Could you send along the entire KASAN log message? I'm not sure I see
> how this is being tripped. The lock we're passing in here is "request"
> and that shouldn't be freed since it's allocated and owned by the
> caller.
>=20

Nevermind. I see how this could happen, and have gone ahead and merged
the patch. It should make v6.6.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
