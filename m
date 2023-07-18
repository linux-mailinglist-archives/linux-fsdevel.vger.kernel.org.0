Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1433E7583F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 19:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjGRR6B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 13:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbjGRR6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:58:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F352C0;
        Tue, 18 Jul 2023 10:57:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E84DC6150B;
        Tue, 18 Jul 2023 17:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FB0C433C7;
        Tue, 18 Jul 2023 17:57:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="kpxCgze3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1689703075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z3DDMndpyGQ9Js5DGZvxnMtOBjS6KRA0SgH3Yn0/Ifk=;
        b=kpxCgze3//UDLfXXgnuNrv610j7ULn8L+B+24oWcd835YN8n7rX6hFjjd24pY9PvFlifiM
        GEomOZNUeCUiuYbUEp1z3t7XGCUoO2PGOI/rccRKEORgBfRf+MCulHD2aPmRdvZO1U7yx7
        5rs9GGnKNHQtYn6kOwqa0FfqeAdzxMY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 54d611f7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 18 Jul 2023 17:57:55 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5217ad95029so4975091a12.2;
        Tue, 18 Jul 2023 10:57:55 -0700 (PDT)
X-Gm-Message-State: ABy/qLbpIPUmBGdPVREJdDb2S8xyD462a7debVsmW14UnCTeP5BPKZ69
        JBUwZ2ybpJJrmxjjHWtmRij3KU+tC/6RcDb+ohU=
X-Google-Smtp-Source: APBJJlEbE+jfEDYuzLdPmOtu5UXWbBGlbEEOaC0BX+lIg944+HdN56uIq7onSwd1wZz7Xep4OTrRvB60bolSKxN+89w=
X-Received: by 2002:aa7:c704:0:b0:51e:e67:df4d with SMTP id
 i4-20020aa7c704000000b0051e0e67df4dmr326904edq.38.1689703072538; Tue, 18 Jul
 2023 10:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002bfa570600c477b3@google.com>
In-Reply-To: <0000000000002bfa570600c477b3@google.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 18 Jul 2023 19:57:22 +0200
X-Gmail-Original-Message-ID: <CAHmME9reBny-ufJp58uOg+KdMptircBRhLFd-N2KwxNUp6myTA@mail.gmail.com>
Message-ID: <CAHmME9reBny-ufJp58uOg+KdMptircBRhLFd-N2KwxNUp6myTA@mail.gmail.com>
Subject: Re: [syzbot] [wireguard?] [jfs?] KASAN: slab-use-after-free Read in wg_noise_keypair_get
To:     syzbot <syzbot+96eb4e0d727f0ae998a6@syzkaller.appspotmail.com>
Cc:     broonie@kernel.org, davem@davemloft.net, edumazet@google.com,
        jfs-discussion@lists.sourceforge.net, kuba@kernel.org,
        kuninori.morimoto.gx@renesas.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, povik+lin@cutebit.org, shaggy@kernel.org,
        syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Freed in:

 diUnmount+0xf3/0x100 fs/jfs/jfs_imap.c:195
 jfs_umount+0x186/0x3a0 fs/jfs/jfs_umount.c:63
 jfs_put_super+0x8a/0x190 fs/jfs/super.c:194

So maybe not a wg issue?
