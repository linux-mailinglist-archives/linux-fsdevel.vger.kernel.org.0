Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7FA587E1B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Aug 2022 16:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbiHBO1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 10:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiHBO1r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:27:47 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3301706A;
        Tue,  2 Aug 2022 07:27:45 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id 12so12508252pga.1;
        Tue, 02 Aug 2022 07:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mdcw+41mnYFsvJnny8gKGUdIlVrqKP0prJEwFAXqmz8=;
        b=OqdY+xNNa+zjYQWCCHw3foZrYEMqbqO/MH8qgISdZy+WJI+/DZj84n1RKDNwq29OP7
         PMVfvRU/rmONJwOx8GrBN2lEBXFsUnGOFDm7Qw3cdglqopzWtfP51k2RzdmAPqBDvFQ+
         3hb0Kw9p2BipkbeslgAZk/51duN8/Bd2H3tA4apyTMUCQd92TUd+Ka3mTbYZRLJY89J6
         csm4Na8D5C1jRe7a3DRRUIiQ7L9dV3zcTnBT6PkgF8IAqu6HlqUznSIoph8cGqpzzVMV
         2ra0SO/RdlbIYg6gElO0Oeo95kcKTNSL4Fr3fcOglp/n8hNKgWxlMb1OcN1zL/HcsWNn
         RObA==
X-Gm-Message-State: ACgBeo070fL6gv/mzx8jf8Qy8YRuC6sEswmpwDkv4xvKMXUW5LxsQycz
        btgk8FDkRGJ+D7XXX6E+yy2lCT+sZd3WJ66Q
X-Google-Smtp-Source: AA6agR7Cq+oi0m+1yE6QMAIe1I9+pOFwQ4i5/Wo7iz/sPNfjD33a2dS1f9ZYd641m8/fToJHN8TO6Q==
X-Received: by 2002:a65:5503:0:b0:41b:bbdc:9a5d with SMTP id f3-20020a655503000000b0041bbbdc9a5dmr13301973pgr.587.1659450464624;
        Tue, 02 Aug 2022 07:27:44 -0700 (PDT)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com. [209.85.210.180])
        by smtp.gmail.com with ESMTPSA id p185-20020a6229c2000000b005251f4596f0sm10944521pfp.107.2022.08.02.07.27.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 07:27:44 -0700 (PDT)
Received: by mail-pf1-f180.google.com with SMTP id y141so13711924pfb.7;
        Tue, 02 Aug 2022 07:27:44 -0700 (PDT)
X-Received: by 2002:a62:52c3:0:b0:52d:c062:27d2 with SMTP id
 g186-20020a6252c3000000b0052dc06227d2mr6058037pfb.53.1659450463658; Tue, 02
 Aug 2022 07:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <165911277121.3745403.18238096564862303683.stgit@warthog.procyon.org.uk>
 <165911277768.3745403.423349776836296452.stgit@warthog.procyon.org.uk>
In-Reply-To: <165911277768.3745403.423349776836296452.stgit@warthog.procyon.org.uk>
From:   Marc Dionne <marc.dionne@auristor.com>
Date:   Tue, 2 Aug 2022 11:27:31 -0300
X-Gmail-Original-Message-ID: <CAB9dFduJEXYhoFuT5PKrhibTZPTyUpSswk9tTiOnu4CLzBmO4Q@mail.gmail.com>
Message-ID: <CAB9dFduJEXYhoFuT5PKrhibTZPTyUpSswk9tTiOnu4CLzBmO4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] afs: Use refcount_t rather than atomic_t
To:     David Howells <dhowells@redhat.com>
Cc:     linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 29, 2022 at 1:40 PM David Howells <dhowells@redhat.com> wrote:
>
> Use refcount_t rather than atomic_t in afs to make use of the count
> checking facilities provided.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> ---
>
>  fs/afs/cell.c              |   61 +++++++++++++++++++++-----------------------
>  fs/afs/cmservice.c         |    2 +
>  fs/afs/internal.h          |   16 ++++++------
>  fs/afs/proc.c              |    6 ++--
>  fs/afs/rxrpc.c             |   26 ++++++++++---------
>  fs/afs/server.c            |   40 +++++++++++++++++------------
>  fs/afs/vl_list.c           |   19 ++++----------
>  fs/afs/volume.c            |   21 +++++++++------
>  include/trace/events/afs.h |   26 +++++++++----------
>  9 files changed, 110 insertions(+), 107 deletions(-)
>
> diff --git a/fs/afs/cell.c b/fs/afs/cell.c
> index 07ad744eef77..988c2ac7cece 100644
> --- a/fs/afs/cell.c
> +++ b/fs/afs/cell.c
> @@ -158,7 +158,7 @@ static struct afs_cell *afs_alloc_cell(struct afs_net *net,
>                 cell->name[i] = tolower(name[i]);
>         cell->name[i] = 0;
>
> -       atomic_set(&cell->ref, 1);
> +       refcount_set(&cell->ref, 1);
>         atomic_set(&cell->active, 0);
>         INIT_WORK(&cell->manager, afs_manage_cell_work);
>         cell->volumes = RB_ROOT;
> @@ -287,7 +287,7 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
>         cell = candidate;
>         candidate = NULL;
>         atomic_set(&cell->active, 2);
> -       trace_afs_cell(cell->debug_id, atomic_read(&cell->ref), 2, afs_cell_trace_insert);
> +       trace_afs_cell(cell->debug_id, refcount_read(&cell->ref), 2, afs_cell_trace_insert);
>         rb_link_node_rcu(&cell->net_node, parent, pp);
>         rb_insert_color(&cell->net_node, &net->cells);
>         up_write(&net->cells_lock);
> @@ -295,7 +295,7 @@ struct afs_cell *afs_lookup_cell(struct afs_net *net,
>         afs_queue_cell(cell, afs_cell_trace_get_queue_new);
>
>  wait_for_cell:
> -       trace_afs_cell(cell->debug_id, atomic_read(&cell->ref), atomic_read(&cell->active),
> +       trace_afs_cell(cell->debug_id, refcount_read(&cell->ref), atomic_read(&cell->active),
>                        afs_cell_trace_wait);
>         _debug("wait_for_cell");
>         wait_var_event(&cell->state,
> @@ -490,13 +490,13 @@ static void afs_cell_destroy(struct rcu_head *rcu)
>  {
>         struct afs_cell *cell = container_of(rcu, struct afs_cell, rcu);
>         struct afs_net *net = cell->net;
> -       int u;
> +       int r;
>
>         _enter("%p{%s}", cell, cell->name);
>
> -       u = atomic_read(&cell->ref);
> -       ASSERTCMP(u, ==, 0);
> -       trace_afs_cell(cell->debug_id, u, atomic_read(&cell->active), afs_cell_trace_free);
> +       r = refcount_read(&cell->ref);
> +       ASSERTCMP(r, ==, 0);
> +       trace_afs_cell(cell->debug_id, r, atomic_read(&cell->active), afs_cell_trace_free);
>
>         afs_put_vlserverlist(net, rcu_access_pointer(cell->vl_servers));
>         afs_unuse_cell(net, cell->alias_of, afs_cell_trace_unuse_alias);
> @@ -539,13 +539,10 @@ void afs_cells_timer(struct timer_list *timer)
>   */
>  struct afs_cell *afs_get_cell(struct afs_cell *cell, enum afs_cell_trace reason)
>  {
> -       int u;
> +       int r;
>
> -       if (atomic_read(&cell->ref) <= 0)
> -               BUG();
> -
> -       u = atomic_inc_return(&cell->ref);
> -       trace_afs_cell(cell->debug_id, u, atomic_read(&cell->active), reason);
> +       __refcount_inc(&cell->ref, &r);
> +       trace_afs_cell(cell->debug_id, r + 1, atomic_read(&cell->active), reason);
>         return cell;
>  }
>
> @@ -556,12 +553,14 @@ void afs_put_cell(struct afs_cell *cell, enum afs_cell_trace reason)
>  {
>         if (cell) {
>                 unsigned int debug_id = cell->debug_id;
> -               unsigned int u, a;
> +               unsigned int a;
> +               bool zero;
> +               int r;
>
>                 a = atomic_read(&cell->active);
> -               u = atomic_dec_return(&cell->ref);
> -               trace_afs_cell(debug_id, u, a, reason);
> -               if (u == 0) {
> +               zero = __refcount_dec_and_test(&cell->ref, &r);
> +               trace_afs_cell(debug_id, r - 1, a, reason);
> +               if (zero) {
>                         a = atomic_read(&cell->active);
>                         WARN(a != 0, "Cell active count %u > 0\n", a);
>                         call_rcu(&cell->rcu, afs_cell_destroy);
> @@ -574,14 +573,12 @@ void afs_put_cell(struct afs_cell *cell, enum afs_cell_trace reason)
>   */
>  struct afs_cell *afs_use_cell(struct afs_cell *cell, enum afs_cell_trace reason)
>  {
> -       int u, a;
> -
> -       if (atomic_read(&cell->ref) <= 0)
> -               BUG();
> +       int r, a;
>
> -       u = atomic_read(&cell->ref);
> +       r = refcount_read(&cell->ref);
> +       WARN_ON(r == 0);
>         a = atomic_inc_return(&cell->active);
> -       trace_afs_cell(cell->debug_id, u, a, reason);
> +       trace_afs_cell(cell->debug_id, r, a, reason);
>         return cell;
>  }
>
> @@ -593,7 +590,7 @@ void afs_unuse_cell(struct afs_net *net, struct afs_cell *cell, enum afs_cell_tr
>  {
>         unsigned int debug_id;
>         time64_t now, expire_delay;
> -       int u, a;
> +       int r, a;
>
>         if (!cell)
>                 return;
> @@ -607,9 +604,9 @@ void afs_unuse_cell(struct afs_net *net, struct afs_cell *cell, enum afs_cell_tr
>                 expire_delay = afs_cell_gc_delay;
>
>         debug_id = cell->debug_id;
> -       u = atomic_read(&cell->ref);
> +       r = refcount_read(&cell->ref);
>         a = atomic_dec_return(&cell->active);
> -       trace_afs_cell(debug_id, u, a, reason);
> +       trace_afs_cell(debug_id, r, a, reason);
>         WARN_ON(a == 0);
>         if (a == 1)
>                 /* 'cell' may now be garbage collected. */
> @@ -621,11 +618,11 @@ void afs_unuse_cell(struct afs_net *net, struct afs_cell *cell, enum afs_cell_tr
>   */
>  void afs_see_cell(struct afs_cell *cell, enum afs_cell_trace reason)
>  {
> -       int u, a;
> +       int r, a;
>
> -       u = atomic_read(&cell->ref);
> +       r = refcount_read(&cell->ref);
>         a = atomic_read(&cell->active);
> -       trace_afs_cell(cell->debug_id, u, a, reason);
> +       trace_afs_cell(cell->debug_id, r, a, reason);
>  }
>
>  /*
> @@ -739,7 +736,7 @@ static void afs_manage_cell(struct afs_cell *cell)
>                 active = 1;
>                 if (atomic_try_cmpxchg_relaxed(&cell->active, &active, 0)) {
>                         rb_erase(&cell->net_node, &net->cells);
> -                       trace_afs_cell(cell->debug_id, atomic_read(&cell->ref), 0,
> +                       trace_afs_cell(cell->debug_id, refcount_read(&cell->ref), 0,
>                                        afs_cell_trace_unuse_delete);
>                         smp_store_release(&cell->state, AFS_CELL_REMOVED);
>                 }
> @@ -866,7 +863,7 @@ void afs_manage_cells(struct work_struct *work)
>                 bool sched_cell = false;
>
>                 active = atomic_read(&cell->active);
> -               trace_afs_cell(cell->debug_id, atomic_read(&cell->ref),
> +               trace_afs_cell(cell->debug_id, refcount_read(&cell->ref),
>                                active, afs_cell_trace_manage);
>
>                 ASSERTCMP(active, >=, 1);
> @@ -874,7 +871,7 @@ void afs_manage_cells(struct work_struct *work)
>                 if (purging) {
>                         if (test_and_clear_bit(AFS_CELL_FL_NO_GC, &cell->flags)) {
>                                 active = atomic_dec_return(&cell->active);
> -                               trace_afs_cell(cell->debug_id, atomic_read(&cell->ref),
> +                               trace_afs_cell(cell->debug_id, refcount_read(&cell->ref),
>                                                active, afs_cell_trace_unuse_pin);
>                         }
>                 }
> diff --git a/fs/afs/cmservice.c b/fs/afs/cmservice.c
> index a3f5de28be79..cedd627e1fae 100644
> --- a/fs/afs/cmservice.c
> +++ b/fs/afs/cmservice.c
> @@ -213,7 +213,7 @@ static void SRXAFSCB_CallBack(struct work_struct *work)
>          */
>         if (call->server) {
>                 trace_afs_server(call->server,
> -                                atomic_read(&call->server->ref),
> +                                refcount_read(&call->server->ref),
>                                  atomic_read(&call->server->active),
>                                  afs_server_trace_callback);
>                 afs_break_callbacks(call->server, call->count, call->request);
> diff --git a/fs/afs/internal.h b/fs/afs/internal.h
> index a6f25d9e75b5..64ad55494349 100644
> --- a/fs/afs/internal.h
> +++ b/fs/afs/internal.h
> @@ -122,7 +122,7 @@ struct afs_call {
>         };
>         struct afs_operation    *op;
>         unsigned int            server_index;
> -       atomic_t                usage;
> +       refcount_t              ref;
>         enum afs_call_state     state;
>         spinlock_t              state_lock;
>         int                     error;          /* error code */
> @@ -365,7 +365,7 @@ struct afs_cell {
>         struct hlist_node       proc_link;      /* /proc cell list link */
>         time64_t                dns_expiry;     /* Time AFSDB/SRV record expires */
>         time64_t                last_inactive;  /* Time of last drop of usage count */
> -       atomic_t                ref;            /* Struct refcount */
> +       refcount_t              ref;            /* Struct refcount */
>         atomic_t                active;         /* Active usage counter */
>         unsigned long           flags;
>  #define AFS_CELL_FL_NO_GC      0               /* The cell was added manually, don't auto-gc */
> @@ -410,7 +410,7 @@ struct afs_vlserver {
>  #define AFS_VLSERVER_FL_IS_YFS 2               /* Server is YFS not AFS */
>  #define AFS_VLSERVER_FL_RESPONDING 3           /* VL server is responding */
>         rwlock_t                lock;           /* Lock on addresses */
> -       atomic_t                usage;
> +       refcount_t              ref;
>         unsigned int            rtt;            /* Server's current RTT in uS */
>
>         /* Probe state */
> @@ -446,7 +446,7 @@ struct afs_vlserver_entry {
>
>  struct afs_vlserver_list {
>         struct rcu_head         rcu;
> -       atomic_t                usage;
> +       refcount_t              ref;
>         u8                      nr_servers;
>         u8                      index;          /* Server currently in use */
>         u8                      preferred;      /* Preferred server */
> @@ -517,7 +517,7 @@ struct afs_server {
>  #define AFS_SERVER_FL_NO_IBULK 17              /* Fileserver doesn't support FS.InlineBulkStatus */
>  #define AFS_SERVER_FL_NO_RM2   18              /* Fileserver doesn't support YFS.RemoveFile2 */
>  #define AFS_SERVER_FL_HAS_FS64 19              /* Fileserver supports FS.{Fetch,Store}Data64 */
> -       atomic_t                ref;            /* Object refcount */
> +       refcount_t              ref;            /* Object refcount */
>         atomic_t                active;         /* Active user count */
>         u32                     addr_version;   /* Address list version */
>         unsigned int            rtt;            /* Server's current RTT in uS */
> @@ -571,7 +571,7 @@ struct afs_volume {
>                 struct rcu_head rcu;
>                 afs_volid_t     vid;            /* volume ID */
>         };
> -       atomic_t                usage;
> +       refcount_t              ref;
>         time64_t                update_at;      /* Time at which to next update */
>         struct afs_cell         *cell;          /* Cell to which belongs (pins ref) */
>         struct rb_node          cell_node;      /* Link in cell->volumes */
> @@ -1493,14 +1493,14 @@ extern int afs_end_vlserver_operation(struct afs_vl_cursor *);
>   */
>  static inline struct afs_vlserver *afs_get_vlserver(struct afs_vlserver *vlserver)
>  {
> -       atomic_inc(&vlserver->usage);
> +       refcount_inc(&vlserver->ref);
>         return vlserver;
>  }
>
>  static inline struct afs_vlserver_list *afs_get_vlserverlist(struct afs_vlserver_list *vllist)
>  {
>         if (vllist)
> -               atomic_inc(&vllist->usage);
> +               refcount_inc(&vllist->ref);
>         return vllist;
>  }
>
> diff --git a/fs/afs/proc.c b/fs/afs/proc.c
> index e1b863449296..2a0c83d71565 100644
> --- a/fs/afs/proc.c
> +++ b/fs/afs/proc.c
> @@ -47,7 +47,7 @@ static int afs_proc_cells_show(struct seq_file *m, void *v)
>
>         /* display one cell per line on subsequent lines */
>         seq_printf(m, "%3u %3u %6lld %2u %2u %s\n",
> -                  atomic_read(&cell->ref),
> +                  refcount_read(&cell->ref),
>                    atomic_read(&cell->active),
>                    cell->dns_expiry - ktime_get_real_seconds(),
>                    vllist ? vllist->nr_servers : 0,
> @@ -217,7 +217,7 @@ static int afs_proc_cell_volumes_show(struct seq_file *m, void *v)
>         }
>
>         seq_printf(m, "%3d %08llx %s %s\n",
> -                  atomic_read(&vol->usage), vol->vid,
> +                  refcount_read(&vol->ref), vol->vid,
>                    afs_vol_types[vol->type],
>                    vol->name);
>
> @@ -388,7 +388,7 @@ static int afs_proc_servers_show(struct seq_file *m, void *v)
>         alist = rcu_dereference(server->addresses);
>         seq_printf(m, "%pU %3d %3d\n",
>                    &server->uuid,
> -                  atomic_read(&server->ref),
> +                  refcount_read(&server->ref),
>                    atomic_read(&server->active));
>         seq_printf(m, "  - info: fl=%lx rtt=%u brk=%x\n",
>                    server->flags, server->rtt, server->cb_s_break);
> diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
> index a5434f3e57c6..d9acc43cb6f0 100644
> --- a/fs/afs/rxrpc.c
> +++ b/fs/afs/rxrpc.c
> @@ -145,7 +145,7 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
>         call->type = type;
>         call->net = net;
>         call->debug_id = atomic_inc_return(&rxrpc_debug_id);
> -       atomic_set(&call->usage, 1);
> +       refcount_set(&call->ref, 1);
>         INIT_WORK(&call->async_work, afs_process_async_call);
>         init_waitqueue_head(&call->waitq);
>         spin_lock_init(&call->state_lock);
> @@ -163,14 +163,15 @@ static struct afs_call *afs_alloc_call(struct afs_net *net,
>  void afs_put_call(struct afs_call *call)
>  {
>         struct afs_net *net = call->net;
> -       int n = atomic_dec_return(&call->usage);
> -       int o = atomic_read(&net->nr_outstanding_calls);
> +       bool zero;
> +       int r, o;
>
> -       trace_afs_call(call, afs_call_trace_put, n, o,
> +       zero = __refcount_dec_and_test(&call->ref, &r);
> +       o = atomic_read(&net->nr_outstanding_calls);
> +       trace_afs_call(call, afs_call_trace_put, r - 1, o,
>                        __builtin_return_address(0));
>
> -       ASSERTCMP(n, >=, 0);
> -       if (n == 0) {
> +       if (zero) {
>                 ASSERT(!work_pending(&call->async_work));
>                 ASSERT(call->type->name != NULL);
>
> @@ -198,9 +199,11 @@ void afs_put_call(struct afs_call *call)
>  static struct afs_call *afs_get_call(struct afs_call *call,
>                                      enum afs_call_trace why)
>  {
> -       int u = atomic_inc_return(&call->usage);
> +       int r;
>
> -       trace_afs_call(call, why, u,
> +       __refcount_inc(&call->ref, &r);
> +
> +       trace_afs_call(call, why, r + 1,
>                        atomic_read(&call->net->nr_outstanding_calls),
>                        __builtin_return_address(0));
>         return call;
> @@ -668,14 +671,13 @@ static void afs_wake_up_async_call(struct sock *sk, struct rxrpc_call *rxcall,
>                                    unsigned long call_user_ID)
>  {
>         struct afs_call *call = (struct afs_call *)call_user_ID;
> -       int u;
> +       int r;
>
>         trace_afs_notify_call(rxcall, call);
>         call->need_attention = true;
>
> -       u = atomic_fetch_add_unless(&call->usage, 1, 0);
> -       if (u != 0) {
> -               trace_afs_call(call, afs_call_trace_wake, u + 1,
> +       if (__refcount_inc_not_zero(&call->ref, &r)) {
> +               trace_afs_call(call, afs_call_trace_wake, r + 1,
>                                atomic_read(&call->net->nr_outstanding_calls),
>                                __builtin_return_address(0));
>
> diff --git a/fs/afs/server.c b/fs/afs/server.c
> index 6e5b9a19b234..ffed828622b6 100644
> --- a/fs/afs/server.c
> +++ b/fs/afs/server.c
> @@ -228,7 +228,7 @@ static struct afs_server *afs_alloc_server(struct afs_cell *cell,
>         if (!server)
>                 goto enomem;
>
> -       atomic_set(&server->ref, 1);
> +       refcount_set(&server->ref, 1);
>         atomic_set(&server->active, 1);
>         server->debug_id = atomic_inc_return(&afs_server_debug_id);
>         RCU_INIT_POINTER(server->addresses, alist);
> @@ -352,9 +352,10 @@ void afs_servers_timer(struct timer_list *timer)
>  struct afs_server *afs_get_server(struct afs_server *server,
>                                   enum afs_server_trace reason)
>  {
> -       unsigned int u = atomic_inc_return(&server->ref);
> +       int r;
>
> -       trace_afs_server(server, u, atomic_read(&server->active), reason);
> +       __refcount_inc(&server->ref, &r);
> +       trace_afs_server(server, r + 1, atomic_read(&server->active), reason);
>         return server;
>  }
>
> @@ -364,14 +365,14 @@ struct afs_server *afs_get_server(struct afs_server *server,
>  static struct afs_server *afs_maybe_use_server(struct afs_server *server,
>                                                enum afs_server_trace reason)
>  {
> -       unsigned int r = atomic_fetch_add_unless(&server->ref, 1, 0);
>         unsigned int a;
> +       int r;
>
> -       if (r == 0)
> +       if (!__refcount_inc_not_zero(&server->ref, &r))
>                 return NULL;
>
>         a = atomic_inc_return(&server->active);
> -       trace_afs_server(server, r, a, reason);
> +       trace_afs_server(server, r + 1, a, reason);
>         return server;
>  }
>
> @@ -380,10 +381,13 @@ static struct afs_server *afs_maybe_use_server(struct afs_server *server,
>   */
>  struct afs_server *afs_use_server(struct afs_server *server, enum afs_server_trace reason)
>  {
> -       unsigned int r = atomic_inc_return(&server->ref);
> -       unsigned int a = atomic_inc_return(&server->active);
> +       unsigned int a;
> +       int r;
> +
> +       __refcount_inc(&server->ref, &r);
> +       a = atomic_inc_return(&server->active);
>
> -       trace_afs_server(server, r, a, reason);
> +       trace_afs_server(server, r + 1, a, reason);
>         return server;
>  }
>
> @@ -393,14 +397,15 @@ struct afs_server *afs_use_server(struct afs_server *server, enum afs_server_tra
>  void afs_put_server(struct afs_net *net, struct afs_server *server,
>                     enum afs_server_trace reason)
>  {
> -       unsigned int usage;
> +       bool zero;
> +       int r;
>
>         if (!server)
>                 return;
>
> -       usage = atomic_dec_return(&server->ref);
> -       trace_afs_server(server, usage, atomic_read(&server->active), reason);
> -       if (unlikely(usage == 0))
> +       zero = __refcount_dec_and_test(&server->ref, &r);
> +       trace_afs_server(server, r - 1, atomic_read(&server->active), reason);
> +       if (unlikely(zero))
>                 __afs_put_server(net, server);
>  }
>
> @@ -436,7 +441,7 @@ static void afs_server_rcu(struct rcu_head *rcu)
>  {
>         struct afs_server *server = container_of(rcu, struct afs_server, rcu);
>
> -       trace_afs_server(server, atomic_read(&server->ref),
> +       trace_afs_server(server, refcount_read(&server->ref),
>                          atomic_read(&server->active), afs_server_trace_free);
>         afs_put_addrlist(rcu_access_pointer(server->addresses));
>         kfree(server);
> @@ -487,7 +492,7 @@ static void afs_gc_servers(struct afs_net *net, struct afs_server *gc_list)
>
>                 active = atomic_read(&server->active);
>                 if (active == 0) {
> -                       trace_afs_server(server, atomic_read(&server->ref),
> +                       trace_afs_server(server, refcount_read(&server->ref),
>                                          active, afs_server_trace_gc);
>                         next = rcu_dereference_protected(
>                                 server->uuid_next, lockdep_is_held(&net->fs_lock.lock));
> @@ -553,7 +558,7 @@ void afs_manage_servers(struct work_struct *work)
>                 _debug("manage %pU %u", &server->uuid, active);
>
>                 if (purging) {
> -                       trace_afs_server(server, atomic_read(&server->ref),
> +                       trace_afs_server(server, refcount_read(&server->ref),
>                                          active, afs_server_trace_purging);
>                         if (active != 0)
>                                 pr_notice("Can't purge s=%08x\n", server->debug_id);
> @@ -633,7 +638,8 @@ static noinline bool afs_update_server_record(struct afs_operation *op,
>
>         _enter("");
>
> -       trace_afs_server(server, atomic_read(&server->ref), atomic_read(&server->active),
> +       trace_afs_server(server, refcount_read(&server->ref),
> +                        atomic_read(&server->active),
>                          afs_server_trace_update);
>
>         alist = afs_vl_lookup_addrs(op->volume->cell, op->key, &server->uuid);
> diff --git a/fs/afs/vl_list.c b/fs/afs/vl_list.c
> index 38b2ba1d9ec0..acc48216136a 100644
> --- a/fs/afs/vl_list.c
> +++ b/fs/afs/vl_list.c
> @@ -17,7 +17,7 @@ struct afs_vlserver *afs_alloc_vlserver(const char *name, size_t name_len,
>         vlserver = kzalloc(struct_size(vlserver, name, name_len + 1),
>                            GFP_KERNEL);
>         if (vlserver) {
> -               atomic_set(&vlserver->usage, 1);
> +               refcount_set(&vlserver->ref, 1);
>                 rwlock_init(&vlserver->lock);
>                 init_waitqueue_head(&vlserver->probe_wq);
>                 spin_lock_init(&vlserver->probe_lock);
> @@ -39,13 +39,9 @@ static void afs_vlserver_rcu(struct rcu_head *rcu)
>
>  void afs_put_vlserver(struct afs_net *net, struct afs_vlserver *vlserver)
>  {
> -       if (vlserver) {
> -               unsigned int u = atomic_dec_return(&vlserver->usage);
> -               //_debug("VL PUT %p{%u}", vlserver, u);
> -
> -               if (u == 0)
> -                       call_rcu(&vlserver->rcu, afs_vlserver_rcu);
> -       }
> +       if (vlserver &&
> +           refcount_dec_and_test(&vlserver->ref))
> +               call_rcu(&vlserver->rcu, afs_vlserver_rcu);
>  }
>
>  struct afs_vlserver_list *afs_alloc_vlserver_list(unsigned int nr_servers)
> @@ -54,7 +50,7 @@ struct afs_vlserver_list *afs_alloc_vlserver_list(unsigned int nr_servers)
>
>         vllist = kzalloc(struct_size(vllist, servers, nr_servers), GFP_KERNEL);
>         if (vllist) {
> -               atomic_set(&vllist->usage, 1);
> +               refcount_set(&vllist->ref, 1);
>                 rwlock_init(&vllist->lock);
>         }
>
> @@ -64,10 +60,7 @@ struct afs_vlserver_list *afs_alloc_vlserver_list(unsigned int nr_servers)
>  void afs_put_vlserverlist(struct afs_net *net, struct afs_vlserver_list *vllist)
>  {
>         if (vllist) {
> -               unsigned int u = atomic_dec_return(&vllist->usage);
> -
> -               //_debug("VLLS PUT %p{%u}", vllist, u);
> -               if (u == 0) {
> +               if (refcount_dec_and_test(&vllist->ref)) {
>                         int i;
>
>                         for (i = 0; i < vllist->nr_servers; i++) {
> diff --git a/fs/afs/volume.c b/fs/afs/volume.c
> index cc665cef0abe..f4937029dcd7 100644
> --- a/fs/afs/volume.c
> +++ b/fs/afs/volume.c
> @@ -52,7 +52,7 @@ static void afs_remove_volume_from_cell(struct afs_volume *volume)
>         struct afs_cell *cell = volume->cell;
>
>         if (!hlist_unhashed(&volume->proc_link)) {
> -               trace_afs_volume(volume->vid, atomic_read(&volume->usage),
> +               trace_afs_volume(volume->vid, refcount_read(&cell->ref),
>                                  afs_volume_trace_remove);
>                 write_seqlock(&cell->volume_lock);
>                 hlist_del_rcu(&volume->proc_link);
> @@ -87,7 +87,7 @@ static struct afs_volume *afs_alloc_volume(struct afs_fs_context *params,
>         volume->type_force      = params->force;
>         volume->name_len        = vldb->name_len;
>
> -       atomic_set(&volume->usage, 1);
> +       refcount_set(&volume->ref, 1);
>         INIT_HLIST_NODE(&volume->proc_link);
>         rwlock_init(&volume->servers_lock);
>         rwlock_init(&volume->cb_v_break_lock);
> @@ -228,7 +228,7 @@ static void afs_destroy_volume(struct afs_net *net, struct afs_volume *volume)
>         afs_remove_volume_from_cell(volume);
>         afs_put_serverlist(net, rcu_access_pointer(volume->servers));
>         afs_put_cell(volume->cell, afs_cell_trace_put_vol);
> -       trace_afs_volume(volume->vid, atomic_read(&volume->usage),
> +       trace_afs_volume(volume->vid, refcount_read(&volume->ref),
>                          afs_volume_trace_free);
>         kfree_rcu(volume, rcu);
>
> @@ -242,8 +242,10 @@ struct afs_volume *afs_get_volume(struct afs_volume *volume,
>                                   enum afs_volume_trace reason)
>  {
>         if (volume) {
> -               int u = atomic_inc_return(&volume->usage);
> -               trace_afs_volume(volume->vid, u, reason);
> +               int r;
> +
> +               __refcount_inc(&volume->ref, &r);
> +               trace_afs_volume(volume->vid, r + 1, reason);
>         }
>         return volume;
>  }
> @@ -257,9 +259,12 @@ void afs_put_volume(struct afs_net *net, struct afs_volume *volume,
>  {
>         if (volume) {
>                 afs_volid_t vid = volume->vid;
> -               int u = atomic_dec_return(&volume->usage);
> -               trace_afs_volume(vid, u, reason);
> -               if (u == 0)
> +               bool zero;
> +               int r;
> +
> +               zero = __refcount_dec_and_test(&volume->ref, &r);
> +               trace_afs_volume(vid, r - 1, reason);
> +               if (zero)
>                         afs_destroy_volume(net, volume);
>         }
>  }
> diff --git a/include/trace/events/afs.h b/include/trace/events/afs.h
> index 499f5fabd20f..aa60f42a9763 100644
> --- a/include/trace/events/afs.h
> +++ b/include/trace/events/afs.h
> @@ -728,14 +728,14 @@ TRACE_EVENT(afs_cb_call,
>
>  TRACE_EVENT(afs_call,
>             TP_PROTO(struct afs_call *call, enum afs_call_trace op,
> -                    int usage, int outstanding, const void *where),
> +                    int ref, int outstanding, const void *where),
>
> -           TP_ARGS(call, op, usage, outstanding, where),
> +           TP_ARGS(call, op, ref, outstanding, where),
>
>             TP_STRUCT__entry(
>                     __field(unsigned int,               call            )
>                     __field(int,                        op              )
> -                   __field(int,                        usage           )
> +                   __field(int,                        ref             )
>                     __field(int,                        outstanding     )
>                     __field(const void *,               where           )
>                              ),
> @@ -743,15 +743,15 @@ TRACE_EVENT(afs_call,
>             TP_fast_assign(
>                     __entry->call = call->debug_id;
>                     __entry->op = op;
> -                   __entry->usage = usage;
> +                   __entry->ref = ref;
>                     __entry->outstanding = outstanding;
>                     __entry->where = where;
>                            ),
>
> -           TP_printk("c=%08x %s u=%d o=%d sp=%pSR",
> +           TP_printk("c=%08x %s r=%d o=%d sp=%pSR",
>                       __entry->call,
>                       __print_symbolic(__entry->op, afs_call_traces),
> -                     __entry->usage,
> +                     __entry->ref,
>                       __entry->outstanding,
>                       __entry->where)
>             );
> @@ -1476,36 +1476,36 @@ TRACE_EVENT(afs_volume,
>                     __entry->reason = reason;
>                            ),
>
> -           TP_printk("V=%llx %s u=%d",
> +           TP_printk("V=%llx %s ur=%d",
>                       __entry->vid,
>                       __print_symbolic(__entry->reason, afs_volume_traces),
>                       __entry->ref)
>             );
>
>  TRACE_EVENT(afs_cell,
> -           TP_PROTO(unsigned int cell_debug_id, int usage, int active,
> +           TP_PROTO(unsigned int cell_debug_id, int ref, int active,
>                      enum afs_cell_trace reason),
>
> -           TP_ARGS(cell_debug_id, usage, active, reason),
> +           TP_ARGS(cell_debug_id, ref, active, reason),
>
>             TP_STRUCT__entry(
>                     __field(unsigned int,               cell            )
> -                   __field(int,                        usage           )
> +                   __field(int,                        ref             )
>                     __field(int,                        active          )
>                     __field(int,                        reason          )
>                              ),
>
>             TP_fast_assign(
>                     __entry->cell = cell_debug_id;
> -                   __entry->usage = usage;
> +                   __entry->ref = ref;
>                     __entry->active = active;
>                     __entry->reason = reason;
>                            ),
>
> -           TP_printk("L=%08x %s u=%d a=%d",
> +           TP_printk("L=%08x %s r=%d a=%d",
>                       __entry->cell,
>                       __print_symbolic(__entry->reason, afs_cell_traces),
> -                     __entry->usage,
> +                     __entry->ref,
>                       __entry->active)
>             );

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc
