Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5437782805
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 13:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbjHULfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 07:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjHULfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:35:30 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF480E1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 04:35:26 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7a02252eb5dso581791241.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Aug 2023 04:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692617726; x=1693222526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srbVbucEfZQXweGR9QuuaSfWvIF57fU894A4XoZstkA=;
        b=TGOgD2fT/IXQhll4lr1UVRYPa9H+5iLQfmJIjRfD/GgFL4GfasliFS0Wf0X6Cf7ha5
         YTPTxyuacBIKK/DtGLAPi3pujHI8rks4s5q1FAabMU+MYF6WKnvtcfMC/Kc1tMrftCeb
         PvBgMT+1QVwVIK1qwkCWZu+FfVhNlhXVPbsnW/EliQV2z2KQD5Wc8kYmcixftcRzGpsW
         LzsJI1Xjz+h3tbvsKzoVnPP+OoR8boH9vyzaBMjmEl4Y4mPPEh1czyX7TaEFJv8zx9N2
         Ao+Y8/llFz8l3UjmnlFRth75748Vhylv/u7/BMwEPEDUDCPE3DpNi+Ulus7jJCeXIlsF
         ScSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692617726; x=1693222526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=srbVbucEfZQXweGR9QuuaSfWvIF57fU894A4XoZstkA=;
        b=jepfq8/0yaoZSRGm1ZLIM/6b2RekbwfdYNZEozQtcIZmiv1QlbZBzQVjaK/gjmoQKW
         s2LyXRctktqhVogtfC7bMHWpWJgYvmEHZox16rJQ8k8VAzONAT4xDKCYv9hHhA/owAPd
         49eSy3fL2VmW8MIf6XsoK/tfHS2M7nFuhZaNXs/+JTwtyTJMkB+OAl7F35RyXbwbzaaP
         M1f59muTkRU1l4WP2vYjy/hsRERArzFo2cOVctwt+31KAhojaHfAvzi1UT4OggXC6S7E
         yVoOCNuOeUIKCnXCHnsxJKWt2AA3yapuhsdUnI6inwDrfutaLCVC2GKwDelmfOBpjSEb
         sBVQ==
X-Gm-Message-State: AOJu0YwoLdVkwanEEfUDxtc3FbAdXv1gD4LSpRj4JranNsi8XzwCrKys
        wpN24mhVXvqRGDW1JQ1RsoPM2etAqCCqNQH06vQ=
X-Google-Smtp-Source: AGHT+IFSbmNMcppRiwU2ce3zDrBufzvtW/pR/3PGkqUc4N5y5kwNA7ejkGUZ+29hIX1I03E19AfHEsj3AWapXHZpyBw=
X-Received: by 2002:a05:6102:354f:b0:443:621e:d138 with SMTP id
 e15-20020a056102354f00b00443621ed138mr2621866vss.5.1692617725437; Mon, 21 Aug
 2023 04:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230817141337.1025891-1-amir73il@gmail.com> <20230817-situiert-eisstadion-cdf3b6b69539@brauner>
In-Reply-To: <20230817-situiert-eisstadion-cdf3b6b69539@brauner>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 21 Aug 2023 14:35:14 +0300
Message-ID: <CAOQ4uxhzwON0hAjCPedTXm9E_iHp58Boy9XiXUtsQHY4uEJzKQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] kiocb_{start,end}_write() helpers
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 17, 2023 at 5:56=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Aug 17, 2023 at 05:13:30PM +0300, Amir Goldstein wrote:
> > Christian,
> >
> > This is an attempt to consolidate the open coded lockdep fooling in
> > all those async io submitters into a single helper.
> > The idea to do that consolidation was suggested by Jan.
> >
> > This re-factoring is part of a larger vfs cleanup I am doing for
> > fanotify permission events.  The complete series is not ready for
> > prime time yet, but this one patch is independent and I would love
> > to get it reviewed/merged a head of the rest.
> >
> > This v3 series addresses the review comments of Jens on v2 [1].
>
> I have neither quarrels nor strong opinions on this so if Jens tells me
> it looks fine to him I can take it.

That would be great.

Jens, do you approve of v3?

Jan, I see that you acked all patches except for 4/7 - I assume this
was an oversight?

Thanks,
Amir.
