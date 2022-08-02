Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF5B5880FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 19:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiHBR1m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 13:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiHBR1k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:27:40 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB63E2C663;
        Tue,  2 Aug 2022 10:27:37 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id x2-20020a17090ab00200b001f4da5cdc9cso9046241pjq.0;
        Tue, 02 Aug 2022 10:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UD93ulFy/PKutUGbZePPGVNtMYIWBzezAUK0opMtBAw=;
        b=QiUCagWtS+9yqh3/BOzkkI+NOueNq1AqmpiCzRh8ovLUOX8FKRTYohlUNAm/zebf1T
         NCXX3MX7EDY2286Mk0anhHfkiMbrB0CPJiK1LQckVTsOdRaZZlBI0/3TjOTvfnLtlQzz
         sKmgYhzmvZYopBLcoqldpFVZbLy8CMz/tB3zQCxem9M/aL3kfraI4RIpWW5JHbzej/iG
         SlLr0ACrzCFEVMpjjpq842aV0dm+ZCYEcfE2Y7Qc38Xmgd39jPJNfzr7r2ebpree/M2e
         m1Te+Yptwq/LxkWniCJnTehTmn3OkmNdzp3OjrOe+pjeiamQxBXyPqKA7Hx2NmfuwDe1
         shoQ==
X-Gm-Message-State: ACgBeo0pBPddVdGEC3vFN6CGbE7tr3rWDetTG2K8VzLQIZDcdpbh0/+t
        WDYBfWTi9ShhJQ0oGU2Yt5gx+jdLPiivYg==
X-Google-Smtp-Source: AA6agR6FulQkk45kUs0adyteNnHJ2CERqOK9fzfK4RHzEggnvI96bc1MIKTegPOVM9h9Uj/4x5hi2g==
X-Received: by 2002:a17:903:18a:b0:16f:e43:efdf with SMTP id z10-20020a170903018a00b0016f0e43efdfmr1611125plg.157.1659461257160;
        Tue, 02 Aug 2022 10:27:37 -0700 (PDT)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com. [209.85.215.177])
        by smtp.gmail.com with ESMTPSA id x190-20020a6263c7000000b0052ac99c2c1csm11075105pfb.83.2022.08.02.10.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 10:27:36 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id bh13so12914340pgb.4;
        Tue, 02 Aug 2022 10:27:36 -0700 (PDT)
X-Received: by 2002:a62:7bd6:0:b0:52d:4773:a3de with SMTP id
 w205-20020a627bd6000000b0052d4773a3demr12785774pfc.70.1659461251723; Tue, 02
 Aug 2022 10:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <165911277121.3745403.18238096564862303683.stgit@warthog.procyon.org.uk>
 <165911278430.3745403.16526310736054780645.stgit@warthog.procyon.org.uk>
 <CAB9dFdsSHwVo6j=+z=4yiTRSJiOeKpFB4QHf6fqrLRuuAa3+JQ@mail.gmail.com> <3733972.1659460456@warthog.procyon.org.uk>
In-Reply-To: <3733972.1659460456@warthog.procyon.org.uk>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Tue, 2 Aug 2022 14:27:20 -0300
X-Gmail-Original-Message-ID: <CAB9dFdu2WpTf47V1HvvcU7Yhtfy4+-niQrEx1GQ2ptD5T+dmWg@mail.gmail.com>
Message-ID: <CAB9dFdu2WpTf47V1HvvcU7Yhtfy4+-niQrEx1GQ2ptD5T+dmWg@mail.gmail.com>
Subject: Re: [PATCH 2/2] afs: Fix access after dec in put functions
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 2, 2022 at 2:15 PM David Howells <dhowells@redhat.com> wrote:
>
> Marc Dionne <marc.dionne@auristor.com> wrote:
>
> > > -       trace_afs_server(server, r - 1, atomic_read(&server->active), reason);
> > > +       trace_afs_server(server->debug_id, r - 1, a, reason);
> >
> > Don't you also want to copy server->debug_id into a local variable here?
>
> Okay, how about the attached change?
>
> David
> ---
> diff --git a/fs/afs/server.c b/fs/afs/server.c
> index bca4b4c55c14..4981baf97835 100644
> --- a/fs/afs/server.c
> +++ b/fs/afs/server.c
> @@ -399,7 +399,7 @@ struct afs_server *afs_use_server(struct afs_server *server, enum afs_server_tra
>  void afs_put_server(struct afs_net *net, struct afs_server *server,
>                     enum afs_server_trace reason)
>  {
> -       unsigned int a;
> +       unsigned int a, debug_id = server->debug_id;
>         bool zero;
>         int r;
>
> @@ -408,7 +408,7 @@ void afs_put_server(struct afs_net *net, struct afs_server *server,
>
>         a = atomic_inc_return(&server->active);
>         zero = __refcount_dec_and_test(&server->ref, &r);
> -       trace_afs_server(server->debug_id, r - 1, a, reason);
> +       trace_afs_server(debug_id, r - 1, a, reason);
>         if (unlikely(zero))
>                 __afs_put_server(net, server);
>  }

Looks fine with that change.

Marc
