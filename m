Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EBB587E6E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 16:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbiHBOyV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 10:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237353AbiHBOyU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:54:20 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7998A1EEE7;
        Tue,  2 Aug 2022 07:54:18 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id v18so13655025plo.8;
        Tue, 02 Aug 2022 07:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLx8SzHFWTTUat6OFdHjj6UkAsRw6dsRNo+UV/N054Y=;
        b=8CVrdK8El2dXeUn+xsWuHGJumeuVw+utN1w4e8LkOix895ZuXUFUmxYJ6phcyH70D2
         L1RoxrO67i97innBXW6zQ6xR710KAXiLpZQpO3oJKC1UpKTbSHhY9+QCPJd1b+xHZYYK
         uxsUq9DtvZhxR1UHjQRyZIxOpJUBBvMr7w5Uk+39TWKhjS4qMFKoIZxCCYGDq1PzjANY
         KQAMfrH3sBzrB3+b9oaqgNRXcLJ4VXHqw08pCqL7abX62qxgoomCz94/iLt3yq93fv7P
         BPiss6fCzLummc0M7b3963rbRkRrRWgAP4ATruelY6si0C1kduRGXgDkH9CB112+9Bse
         4H+w==
X-Gm-Message-State: ACgBeo1rFeOZVqZ2lUk/jxmV91SsyTSHv10uM5pckPqwIkw6MUVDWZeZ
        J8aXq3xECTp8RDldZppMYY3A2oYychUMQsi1
X-Google-Smtp-Source: AA6agR5Y9wl9per5UnG0hnCqfq+ttaJXsO4022PfZIT/x6dD3IaUvmN4+K4yE82ACO1glRel0FKV1A==
X-Received: by 2002:a17:902:dac8:b0:16d:8605:6445 with SMTP id q8-20020a170902dac800b0016d86056445mr21049080plx.19.1659452057431;
        Tue, 02 Aug 2022 07:54:17 -0700 (PDT)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com. [209.85.214.174])
        by smtp.gmail.com with ESMTPSA id z9-20020a170903018900b0016d987d7f76sm12108118plg.11.2022.08.02.07.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 07:54:17 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id o3so13679049ple.5;
        Tue, 02 Aug 2022 07:54:16 -0700 (PDT)
X-Received: by 2002:a17:902:8c8a:b0:16e:ceb1:d90a with SMTP id
 t10-20020a1709028c8a00b0016eceb1d90amr15530845plo.170.1659452056479; Tue, 02
 Aug 2022 07:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <165911277121.3745403.18238096564862303683.stgit@warthog.procyon.org.uk>
 <165911278430.3745403.16526310736054780645.stgit@warthog.procyon.org.uk>
In-Reply-To: <165911278430.3745403.16526310736054780645.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Tue, 2 Aug 2022 11:54:04 -0300
X-Gmail-Original-Message-ID: <CAB9dFdsSHwVo6j=+z=4yiTRSJiOeKpFB4QHf6fqrLRuuAa3+JQ@mail.gmail.com>
Message-ID: <CAB9dFdsSHwVo6j=+z=4yiTRSJiOeKpFB4QHf6fqrLRuuAa3+JQ@mail.gmail.com>
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

On Fri, Jul 29, 2022 at 1:40 PM David Howells <dhowells@redhat.com> wrote:
>
> Reference-putting functions should not access the object being put after
> decrementing the refcount unless they reduce the refcount to zero.
>
> Fix a couple of instances of this in afs by copying the information to be
> logged by tracepoint to local variables before doing the decrement.
>
> Fixes: 341f741f04be ("afs: Refcount the afs_call struct")
> Fixes: 452181936931 ("afs: Trace afs_server usage")
> Fixes: 977e5f8ed0ab ("afs: Split the usage count on struct afs_server")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>
>  fs/afs/cmservice.c         |    2 +-
>  fs/afs/rxrpc.c             |   11 ++++++-----
>  fs/afs/server.c            |   22 +++++++++++++---------
>  include/trace/events/afs.h |   12 ++++++------
>  4 files changed, 26 insertions(+), 21 deletions(-)
>
> diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
> index cedd627e1fae..0a090d614e76 100644
> --- a/fs/afs/cmservice.c
> +++ b/fs/afs/cmservice.c
> @@ -212,7 +212,7 @@ static void SRXAFSCB_CallBack(struct work_struct *work)
>          * to maintain cache coherency.
>          */
>         if (call->server) {
> -               trace_afs_server(call->server,
> +               trace_afs_server(call->server->debug_id,
>                                  refcount_read(&call->server->ref),
>                                  atomic_read(&call->server->active),
>                                  afs_server_trace_callback);
> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index d9acc43cb6f0..d5c4785c862d 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c
> @@ -152,7 +152,7 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
>         call->iter = &call->def_iter;
>
>         o = atomic_inc_return(&net->nr_outstanding_calls);
> -       trace_afs_call(call, afs_call_trace_alloc, 1, o,
> +       trace_afs_call(call->debug_id, afs_call_trace_alloc, 1, o,
>                        __builtin_return_address(0));
>         return call;
>  }
> @@ -163,12 +163,13 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
>  void afs_put_call(struct afs_call *call)
>  {
>         struct afs_net *net = call->net;
> +       unsigned int debug_id = call->debug_id;
>         bool zero;
>         int r, o;
>
>         zero = __refcount_dec_and_test(&call->ref, &r);
>         o = atomic_read(&net->nr_outstanding_calls);
> -       trace_afs_call(call, afs_call_trace_put, r - 1, o,
> +       trace_afs_call(debug_id, afs_call_trace_put, r - 1, o,
>                        __builtin_return_address(0));
>
>         if (zero) {
> @@ -186,7 +187,7 @@ void afs_put_call(struct afs_call *call)
>                 afs_put_addrlist(call->alist);
>                 kfree(call->request);
>
> -               trace_afs_call(call, afs_call_trace_free, 0, o,
> +               trace_afs_call(call->debug_id, afs_call_trace_free, 0, o,
>                                __builtin_return_address(0));
>                 kfree(call);
>
> @@ -203,7 +204,7 @@ static struct afs_call *afs_get_call(struct afs_call *call,
>
>         __refcount_inc(&call->ref, &r);
>
> -       trace_afs_call(call, why, r + 1,
> +       trace_afs_call(call->debug_id, why, r + 1,
>                        atomic_read(&call->net->nr_outstanding_calls),
>                        __builtin_return_address(0));
>         return call;
> @@ -677,7 +678,7 @@ static void afs_wake_up_async_call(struct sock *sk, struct rxrpc_call *rxcall,
>         call->need_attention = true;
>
>         if (__refcount_inc_not_zero(&call->ref, &r)) {
> -               trace_afs_call(call, afs_call_trace_wake, r + 1,
> +               trace_afs_call(call->debug_id, afs_call_trace_wake, r + 1,
>                                atomic_read(&call->net->nr_outstanding_calls),
>                                __builtin_return_address(0));
>
> diff --git a/fs/afs/server.c b/fs/afs/server.c
> index ffed828622b6..bca4b4c55c14 100644
> --- a/fs/afs/server.c
> +++ b/fs/afs/server.c
> @@ -243,7 +243,7 @@ static struct afs_server *afs_alloc_server(struct afs_cell *cell,
>         server->rtt = UINT_MAX;
>
>         afs_inc_servers_outstanding(net);
> -       trace_afs_server(server, 1, 1, afs_server_trace_alloc);
> +       trace_afs_server(server->debug_id, 1, 1, afs_server_trace_alloc);
>         _leave(" = %p", server);
>         return server;
>
> @@ -352,10 +352,12 @@ void afs_servers_timer(struct timer_list *timer)
>  struct afs_server *afs_get_server(struct afs_server *server,
>                                   enum afs_server_trace reason)
>  {
> +       unsigned int a;
>         int r;
>
>         __refcount_inc(&server->ref, &r);
> -       trace_afs_server(server, r + 1, atomic_read(&server->active), reason);
> +       a = atomic_read(&server->active);
> +       trace_afs_server(server->debug_id, r + 1, a, reason);
>         return server;
>  }
>
> @@ -372,7 +374,7 @@ static struct afs_server *afs_maybe_use_server(struct afs_server *server,
>                 return NULL;
>
>         a = atomic_inc_return(&server->active);
> -       trace_afs_server(server, r + 1, a, reason);
> +       trace_afs_server(server->debug_id, r + 1, a, reason);
>         return server;
>  }
>
> @@ -387,7 +389,7 @@ struct afs_server *afs_use_server(struct afs_server *server, enum afs_server_tra
>         __refcount_inc(&server->ref, &r);
>         a = atomic_inc_return(&server->active);
>
> -       trace_afs_server(server, r + 1, a, reason);
> +       trace_afs_server(server->debug_id, r + 1, a, reason);
>         return server;
>  }
>
> @@ -397,14 +399,16 @@ struct afs_server *afs_use_server(struct afs_server *server, enum afs_server_tra
>  void afs_put_server(struct afs_net *net, struct afs_server *server,
>                     enum afs_server_trace reason)
>  {
> +       unsigned int a;
>         bool zero;
>         int r;
>
>         if (!server)
>                 return;
>
> +       a = atomic_inc_return(&server->active);
>         zero = __refcount_dec_and_test(&server->ref, &r);
> -       trace_afs_server(server, r - 1, atomic_read(&server->active), reason);
> +       trace_afs_server(server->debug_id, r - 1, a, reason);

Don't you also want to copy server->debug_id into a local variable here?


>         if (unlikely(zero))
>                 __afs_put_server(net, server);
>  }
> @@ -441,7 +445,7 @@ static void afs_server_rcu(struct rcu_head *rcu)
>  {
>         struct afs_server *server = container_of(rcu, struct afs_server, rcu);
>
> -       trace_afs_server(server, refcount_read(&server->ref),
> +       trace_afs_server(server->debug_id, refcount_read(&server->ref),
>                          atomic_read(&server->active), afs_server_trace_free);
>         afs_put_addrlist(rcu_access_pointer(server->addresses));
>         kfree(server);
> @@ -492,7 +496,7 @@ static void afs_gc_servers(struct afs_net *net, struct afs_server *gc_list)
>
>                 active = atomic_read(&server->active);
>                 if (active == 0) {
> -                       trace_afs_server(server, refcount_read(&server->ref),
> +                       trace_afs_server(server->debug_id, refcount_read(&server->ref),
>                                          active, afs_server_trace_gc);
>                         next = rcu_dereference_protected(
>                                 server->uuid_next, lockdep_is_held(&net->fs_lock.lock));
> @@ -558,7 +562,7 @@ void afs_manage_servers(struct work_struct *work)
>                 _debug("manage %pU %u", &server->uuid, active);
>
>                 if (purging) {
> -                       trace_afs_server(server, refcount_read(&server->ref),
> +                       trace_afs_server(server->debug_id, refcount_read(&server->ref),
>                                          active, afs_server_trace_purging);
>                         if (active != 0)
>                                 pr_notice("Can't purge s=%08x\n", server->debug_id);
> @@ -638,7 +642,7 @@ static noinline bool afs_update_server_record(struct afs_operation *op,
>
>         _enter("");
>
> -       trace_afs_server(server, refcount_read(&server->ref),
> +       trace_afs_server(server->debug_id, refcount_read(&server->ref),
>                          atomic_read(&server->active),
>                          afs_server_trace_update);
>
> diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
> index aa60f42a9763..e9d412d19dbb 100644
> --- a/include/trace/events/afs.h
> +++ b/include/trace/events/afs.h
> @@ -727,10 +727,10 @@ TRACE_EVENT(afs_cb_call,
>             );
>
>  TRACE_EVENT(afs_call,
> -           TP_PROTO(struct afs_call *call, enum afs_call_trace op,
> +           TP_PROTO(unsigned int call_debug_id, enum afs_call_trace op,
>                      int ref, int outstanding, const void *where),
>
> -           TP_ARGS(call, op, ref, outstanding, where),
> +           TP_ARGS(call_debug_id, op, ref, outstanding, where),
>
>             TP_STRUCT__entry(
>                     __field(unsigned int,               call            )
> @@ -741,7 +741,7 @@ TRACE_EVENT(afs_call,
>                              ),
>
>             TP_fast_assign(
> -                   __entry->call = call->debug_id;
> +                   __entry->call = call_debug_id;
>                     __entry->op = op;
>                     __entry->ref = ref;
>                     __entry->outstanding = outstanding;
> @@ -1433,10 +1433,10 @@ TRACE_EVENT(afs_cb_miss,
>             );
>
>  TRACE_EVENT(afs_server,
> -           TP_PROTO(struct afs_server *server, int ref, int active,
> +           TP_PROTO(unsigned int server_debug_id, int ref, int active,
>                      enum afs_server_trace reason),
>
> -           TP_ARGS(server, ref, active, reason),
> +           TP_ARGS(server_debug_id, ref, active, reason),
>
>             TP_STRUCT__entry(
>                     __field(unsigned int,               server          )
> @@ -1446,7 +1446,7 @@ TRACE_EVENT(afs_server,
>                              ),
>
>             TP_fast_assign(
> -                   __entry->server = server->debug_id;
> +                   __entry->server = server_debug_id;
>                     __entry->ref = ref;
>                     __entry->active = active;
>                     __entry->reason = reason;
>
>
>
