Return-Path: <linux-fsdevel+bounces-70364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B18BC98BD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 19:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43E834E2014
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 18:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68BA2236E5;
	Mon,  1 Dec 2025 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vnazu73P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC721B9DA
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764614382; cv=none; b=JVRJT5CGyewSv3MBj9tUg5gnzHU+2iZAgTDK0CpaDea2olbbCdCectZ+3IrnOXJJt/Dn+msXk1rm3IDza41VRF/buAvQz7/3tltyttS0jrmYYXij4CWGxYNRqpuU1efKK21VYr3Jb1JVmqzzantKKyEe8hSh9y7uZPI3HM2aqSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764614382; c=relaxed/simple;
	bh=JEK4rWXmeLOMzqHXezya4k0b1uXStfI5E9wXzvATZ+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oq77hv8WoUs5v4/aHZ7WVq2caeVxzpAjnJjR8agqPR4Pcj2lOFtp0cBzCOsOSb/A8NDo7tmS5CscmGh/hG8RYYmQjJ83LFQ1zWp6bQWYNDQwu3kWGSlKozZxDLpzk/nTH8hvNTWfaP7EKLRCrLCHtMNkl5TzoyvVIyRSUmKsmYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vnazu73P; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-880576ebe38so48105126d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 10:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764614375; x=1765219175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07Dt9KxsgXMXo7ZEj1zUtztbavVLJJqJmuPQ4AkL9A0=;
        b=Vnazu73P+Vw8WDXp1T9WM9D2/WvNws8xyOSGwMKiYSYfIC0woNM9bBdFodqqh3kmdK
         PeCvGj0b/dMzk4vXaSWqTDS8FwzHnVlGOw0nbfn4VbcrbbM/hrmEns5ORSd/hgcArTGY
         8SvsbHltZO55cqWCuaEPBXCa3sFBp+mnIyVC7v9kzQeopWTzwgNJfC5ZiLbM/w7AmWcL
         MvBqZOx9VCXMYcd51CHfGEk8i1TBE2pLayKpGy0Z9JGIT9v8Lk9MsOGlH43a6aB10WaT
         H/fgdBF8R9c+Et2ym4mQQbus04m8+il0DPAw774ZLSmV8s9zdjnNpnk8F1NQFvYG07de
         n3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764614375; x=1765219175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=07Dt9KxsgXMXo7ZEj1zUtztbavVLJJqJmuPQ4AkL9A0=;
        b=bVMZkL//hGPO2buSI2UlwZ8aMb0Xkh4INx8fbr3DNL8ZMBWTFxWHsl7lLuarcbJtmo
         Dw/ZU6t2TEkFT/ZxlDW6g6P4GPpoCC2fht7GTVPPGSg2V/IUGb+k/Nn52nqCGXqCqbQd
         l9AtcuKqJTuJ1mT1WEhe/FIois2fqx+ADZXCs1RhbnTYD5srHdqK6jgjWwSHxoDEAHIC
         A6gdRhYkSUxcMqym3pdHtQ06AZ2sj5WHG1lOMZOhyMPaYWer+1Z/7r20H8dOjqsoSsvO
         R8ir+58a/ARGSBbg6VQznkN8jkibfbigJrL3FE+IRxeRGnKKzU+D4gbbP9YEhPFUBwvd
         1RBA==
X-Forwarded-Encrypted: i=1; AJvYcCUpl5wDo7dlU56Mr2XgyfWMGm7wwvlrWq6Co6cIONg/sPqlR9VmUfuzPW/7FqbATiD8rTBAfe2sYNre6N5g@vger.kernel.org
X-Gm-Message-State: AOJu0YzJxJXkH5OWDxrkA26xv3q3XwtWjE72uZ2xY54MzbJALxTNiUsL
	BVEvYLL0bS08BJO0frIkddD4eDaf/175DqrwGGTI//LRnL7g2oAn/Lue8KMpK7Izp0A6E9J0Zbc
	hzcz3RXaAzNHBiZGyIZDZTaHpdCkGQv0=
X-Gm-Gg: ASbGncueOeqV6M7R2/W8CochP9++KZEQdlyMTX+BVP0jF2vChtKZlVXU2csr7w/GiNQ
	cZMnVlg0diMH/k3TcMAlZbEqh/DsxTaFLe8NhyltXDOV8ifJm/wuqC0r/+Dz4OcJMT4gwuNEN96
	8KAfwolg9UZT/s1SpJ9EwDlq2vlHVsSAU0Q3NpoOP05mYDP0VMmpapB9BRfZNtBPu3A1VyM99Zm
	hfzk3gNboEPulRcSFkfy91n1DOZi8vcRKFGIcylWO2gpxK2zir/m6WtlWZy22uIdEIbGC20VHPK
	+kjEe8PYBO5hdhdf+9S7i3ipygcEAVVXYMVbyyHDtFwammX1hRRO/RBSPRkP6kCSYv7zjZIt7UB
	65QiekfGIzKSRNvshSsOQLdhEGgxE2SCM3jq101CdFtNN/YGA8zDK0d1tACPVCUIAGDSz2BB5Kv
	mY5K2vjv0/
X-Google-Smtp-Source: AGHT+IErQzyoDOpyvZ4Au2+NqEHwcI3PIO61E2ASt60ABgjHj0YC/HkApU+3ladkMxtVybAYF+GDzxC3tyBte9zON7E=
X-Received: by 2002:ad4:5f8a:0:b0:882:3781:e29d with SMTP id
 6a1803df08f44-8863ae6198bmr401523816d6.10.1764614374943; Mon, 01 Dec 2025
 10:39:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201094916.1418415-1-dhowells@redhat.com> <20251201094916.1418415-2-dhowells@redhat.com>
In-Reply-To: <20251201094916.1418415-2-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 1 Dec 2025 12:39:22 -0600
X-Gm-Features: AWmQ_bmqyDQHke4LBcCYKjTCEqj7XFOl7zZ-8E9QK4LwHPkjOCioTBHmmL8UQt0
Message-ID: <CAH2r5msqbTY71hLk-OE1YNc7OxGU8x0JuwM8z-uEN6Xpsbh2=Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] cifs: Rename mid_q_entry to smb_message
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Shyam Prasad N <sprasad@microsoft.com>, Stefan Metzmacher <metze@samba.org>, linux-cifs@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tom Talpey <tom@talpey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I lean against the rename of the struct if it is going to still
contain primarily the 'mid' (ie the 'multiplex identifier' - the thing
used to track a request in flight).  The rest of the patch seems fine
- but why do the extra rename of the struct if it is still primarily
"the struct that tracks the info on the request in flight by its
multiplex id" - wouldn't it be much smaller (and just as clear) if
only the other part of this patch were included?  No strong opinions
but could make the patch smaller and easier to review

   1684 struct smb_message {
   1685         struct list_head qhead; /* mids waiting on reply from
this server */
   1686         refcount_t refcount;
   1687         __u64 mid;              /* multiplex id */

On Mon, Dec 1, 2025 at 3:50=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Rename mid_q_entry to smb_message as future development that will allocat=
e
> it at a higher level in the marshalling code and then hand it down into t=
he
> transport layer.  It will also be used to pass parameters such as the sen=
d
> and receive data buffers, credits and other things.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Shyam Prasad N <sprasad@microsoft.com>
> cc: Tom Talpey <tom@talpey.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/smb/client/cifs_debug.c    |  43 +++---
>  fs/smb/client/cifsfs.c        |  31 +++--
>  fs/smb/client/cifsglob.h      |  70 +++++-----
>  fs/smb/client/cifsproto.h     |  39 +++---
>  fs/smb/client/cifssmb.c       |  82 ++++++------
>  fs/smb/client/cifstransport.c | 168 ++++++++++++------------
>  fs/smb/client/connect.c       | 152 +++++++++++-----------
>  fs/smb/client/netmisc.c       |  14 +-
>  fs/smb/client/smb1ops.c       |  46 +++----
>  fs/smb/client/smb2misc.c      |   8 +-
>  fs/smb/client/smb2ops.c       | 122 ++++++++---------
>  fs/smb/client/smb2pdu.c       |  47 ++++---
>  fs/smb/client/smb2proto.h     |  14 +-
>  fs/smb/client/smb2transport.c |  62 ++++-----
>  fs/smb/client/transport.c     | 238 +++++++++++++++++-----------------
>  15 files changed, 568 insertions(+), 568 deletions(-)
>
> diff --git a/fs/smb/client/cifs_debug.c b/fs/smb/client/cifs_debug.c
> index 7fdcaf9feb16..1dadbaba62b0 100644
> --- a/fs/smb/client/cifs_debug.c
> +++ b/fs/smb/client/cifs_debug.c
> @@ -55,33 +55,32 @@ void cifs_dump_detail(void *buf, struct TCP_Server_In=
fo *server)
>  void cifs_dump_mids(struct TCP_Server_Info *server)
>  {
>  #ifdef CONFIG_CIFS_DEBUG2
> -       struct mid_q_entry *mid_entry;
> +       struct smb_message *smb;
>
>         if (server =3D=3D NULL)
>                 return;
>
>         cifs_dbg(VFS, "Dump pending requests:\n");
>         spin_lock(&server->mid_queue_lock);
> -       list_for_each_entry(mid_entry, &server->pending_mid_q, qhead) {
> +       list_for_each_entry(smb, &server->pending_mid_q, qhead) {
>                 cifs_dbg(VFS, "State: %d Cmd: %d Pid: %d Cbdata: %p Mid %=
llu\n",
> -                        mid_entry->mid_state,
> -                        le16_to_cpu(mid_entry->command),
> -                        mid_entry->pid,
> -                        mid_entry->callback_data,
> -                        mid_entry->mid);
> +                        smb->mid_state,
> +                        le16_to_cpu(smb->command),
> +                        smb->pid,
> +                        smb->callback_data,
> +                        smb->mid);
>  #ifdef CONFIG_CIFS_STATS2
>                 cifs_dbg(VFS, "IsLarge: %d buf: %p time rcv: %ld now: %ld=
\n",
> -                        mid_entry->large_buf,
> -                        mid_entry->resp_buf,
> -                        mid_entry->when_received,
> +                        smb->large_buf,
> +                        smb->resp_buf,
> +                        smb->when_received,
>                          jiffies);
>  #endif /* STATS2 */
>                 cifs_dbg(VFS, "IsMult: %d IsEnd: %d\n",
> -                        mid_entry->multiRsp, mid_entry->multiEnd);
> -               if (mid_entry->resp_buf) {
> -                       cifs_dump_detail(mid_entry->resp_buf, server);
> -                       cifs_dump_mem("existing buf: ",
> -                               mid_entry->resp_buf, 62);
> +                        smb->multiRsp, smb->multiEnd);
> +               if (smb->resp_buf) {
> +                       cifs_dump_detail(smb->resp_buf, server);
> +                       cifs_dump_mem("existing buf: ", smb->resp_buf, 62=
);
>                 }
>         }
>         spin_unlock(&server->mid_queue_lock);
> @@ -406,7 +405,7 @@ static __always_inline const char *cipher_alg_str(__l=
e16 cipher)
>
>  static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
>  {
> -       struct mid_q_entry *mid_entry;
> +       struct smb_message *smb;
>         struct TCP_Server_Info *server;
>         struct TCP_Server_Info *chan_server;
>         struct cifs_ses *ses;
> @@ -727,13 +726,13 @@ static int cifs_debug_data_proc_show(struct seq_fil=
e *m, void *v)
>                                 seq_printf(m, "\n\tServer ConnectionId: 0=
x%llx",
>                                            chan_server->conn_id);
>                                 spin_lock(&chan_server->mid_queue_lock);
> -                               list_for_each_entry(mid_entry, &chan_serv=
er->pending_mid_q, qhead) {
> +                               list_for_each_entry(smb, &chan_server->pe=
nding_mid_q, qhead) {
>                                         seq_printf(m, "\n\t\tState: %d co=
m: %d pid: %d cbdata: %p mid %llu",
> -                                                  mid_entry->mid_state,
> -                                                  le16_to_cpu(mid_entry-=
>command),
> -                                                  mid_entry->pid,
> -                                                  mid_entry->callback_da=
ta,
> -                                                  mid_entry->mid);
> +                                                  smb->mid_state,
> +                                                  le16_to_cpu(smb->comma=
nd),
> +                                                  smb->pid,
> +                                                  smb->callback_data,
> +                                                  smb->mid);
>                                 }
>                                 spin_unlock(&chan_server->mid_queue_lock)=
;
>                         }
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index 185ac41bd7e9..1662fe2ee30e 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -436,13 +436,13 @@ static int cifs_permission(struct mnt_idmap *idmap,
>
>  static struct kmem_cache *cifs_inode_cachep;
>  static struct kmem_cache *cifs_req_cachep;
> -static struct kmem_cache *cifs_mid_cachep;
> +static struct kmem_cache *smb_message_cachep;
>  static struct kmem_cache *cifs_sm_req_cachep;
>  static struct kmem_cache *cifs_io_request_cachep;
>  static struct kmem_cache *cifs_io_subrequest_cachep;
>  mempool_t *cifs_sm_req_poolp;
>  mempool_t *cifs_req_poolp;
> -mempool_t *cifs_mid_poolp;
> +mempool_t smb_message_pool;
>  mempool_t cifs_io_request_pool;
>  mempool_t cifs_io_subrequest_pool;
>
> @@ -1835,28 +1835,27 @@ cifs_destroy_request_bufs(void)
>         kmem_cache_destroy(cifs_sm_req_cachep);
>  }
>
> -static int init_mids(void)
> +static int init_smb_message(void)
>  {
> -       cifs_mid_cachep =3D kmem_cache_create("cifs_mpx_ids",
> -                                           sizeof(struct mid_q_entry), 0=
,
> -                                           SLAB_HWCACHE_ALIGN, NULL);
> -       if (cifs_mid_cachep =3D=3D NULL)
> +       smb_message_cachep =3D kmem_cache_create("cifs_smb_message",
> +                                              sizeof(struct smb_message)=
, 0,
> +                                              SLAB_HWCACHE_ALIGN, NULL);
> +       if (smb_message_cachep =3D=3D NULL)
>                 return -ENOMEM;
>
>         /* 3 is a reasonable minimum number of simultaneous operations */
> -       cifs_mid_poolp =3D mempool_create_slab_pool(3, cifs_mid_cachep);
> -       if (cifs_mid_poolp =3D=3D NULL) {
> -               kmem_cache_destroy(cifs_mid_cachep);
> +       if (mempool_init_slab_pool(&smb_message_pool, 3, smb_message_cach=
ep) < 0) {
> +               kmem_cache_destroy(smb_message_cachep);
>                 return -ENOMEM;
>         }
>
>         return 0;
>  }
>
> -static void destroy_mids(void)
> +static void destroy_smb_message(void)
>  {
> -       mempool_destroy(cifs_mid_poolp);
> -       kmem_cache_destroy(cifs_mid_cachep);
> +       mempool_exit(&smb_message_pool);
> +       kmem_cache_destroy(smb_message_cachep);
>  }
>
>  static int cifs_init_netfs(void)
> @@ -2020,7 +2019,7 @@ init_cifs(void)
>         if (rc)
>                 goto out_destroy_inodecache;
>
> -       rc =3D init_mids();
> +       rc =3D init_smb_message();
>         if (rc)
>                 goto out_destroy_netfs;
>
> @@ -2077,7 +2076,7 @@ init_cifs(void)
>  #endif
>         cifs_destroy_request_bufs();
>  out_destroy_mids:
> -       destroy_mids();
> +       destroy_smb_message();
>  out_destroy_netfs:
>         cifs_destroy_netfs();
>  out_destroy_inodecache:
> @@ -2119,7 +2118,7 @@ exit_cifs(void)
>         dfs_cache_destroy();
>  #endif
>         cifs_destroy_request_bufs();
> -       destroy_mids();
> +       destroy_smb_message();
>         cifs_destroy_netfs();
>         cifs_destroy_inodecache();
>         destroy_workqueue(deferredclose_wq);
> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> index 0c76e0a31386..6e5c213e7b1e 100644
> --- a/fs/smb/client/cifsglob.h
> +++ b/fs/smb/client/cifsglob.h
> @@ -294,7 +294,7 @@ struct smb_rqst {
>         struct folio_queue *rq_buffer;  /* Buffer for encryption */
>  };
>
> -struct mid_q_entry;
> +struct smb_message;
>  struct TCP_Server_Info;
>  struct cifsFileInfo;
>  struct cifs_ses;
> @@ -312,24 +312,24 @@ struct cifs_credits;
>
>  struct smb_version_operations {
>         int (*send_cancel)(struct TCP_Server_Info *, struct smb_rqst *,
> -                          struct mid_q_entry *);
> +                          struct smb_message *smb);
>         bool (*compare_fids)(struct cifsFileInfo *, struct cifsFileInfo *=
);
>         /* setup request: allocate mid, sign message */
> -       struct mid_q_entry *(*setup_request)(struct cifs_ses *,
> -                                            struct TCP_Server_Info *,
> -                                            struct smb_rqst *);
> +       struct smb_message *(*setup_request)(struct cifs_ses *ses,
> +                                            struct TCP_Server_Info *serv=
er,
> +                                            struct smb_rqst *rqst);
>         /* setup async request: allocate mid, sign message */
> -       struct mid_q_entry *(*setup_async_request)(struct TCP_Server_Info=
 *,
> -                                               struct smb_rqst *);
> +       struct smb_message *(*setup_async_request)(struct TCP_Server_Info=
 *server,
> +                                                  struct smb_rqst *rqst)=
;
>         /* check response: verify signature, map error */
> -       int (*check_receive)(struct mid_q_entry *, struct TCP_Server_Info=
 *,
> -                            bool);
> +       int (*check_receive)(struct smb_message *mid, struct TCP_Server_I=
nfo *server,
> +                            bool log_error);
>         void (*add_credits)(struct TCP_Server_Info *server,
>                             struct cifs_credits *credits,
>                             const int optype);
>         void (*set_credits)(struct TCP_Server_Info *, const int);
>         int * (*get_credits_field)(struct TCP_Server_Info *, const int);
> -       unsigned int (*get_credits)(struct mid_q_entry *);
> +       unsigned int (*get_credits)(struct smb_message *smb);
>         __u64 (*get_next_mid)(struct TCP_Server_Info *);
>         void (*revert_current_mid)(struct TCP_Server_Info *server,
>                                    const unsigned int val);
> @@ -346,7 +346,7 @@ struct smb_version_operations {
>         /* map smb to linux error */
>         int (*map_error)(char *, bool);
>         /* find mid corresponding to the response message */
> -       struct mid_q_entry * (*find_mid)(struct TCP_Server_Info *, char *=
);
> +       struct smb_message * (*find_mid)(struct TCP_Server_Info *server, =
char *buf);
>         void (*dump_detail)(void *buf, struct TCP_Server_Info *ptcp_info)=
;
>         void (*clear_stats)(struct cifs_tcon *);
>         void (*print_stats)(struct seq_file *m, struct cifs_tcon *);
> @@ -354,13 +354,13 @@ struct smb_version_operations {
>         /* verify the message */
>         int (*check_message)(char *, unsigned int, struct TCP_Server_Info=
 *);
>         bool (*is_oplock_break)(char *, struct TCP_Server_Info *);
> -       int (*handle_cancelled_mid)(struct mid_q_entry *, struct TCP_Serv=
er_Info *);
> +       int (*handle_cancelled_mid)(struct smb_message *smb, struct TCP_S=
erver_Info *server);
>         void (*downgrade_oplock)(struct TCP_Server_Info *server,
>                                  struct cifsInodeInfo *cinode, __u32 oplo=
ck,
>                                  __u16 epoch, bool *purge_cache);
>         /* process transaction2 response */
> -       bool (*check_trans2)(struct mid_q_entry *, struct TCP_Server_Info=
 *,
> -                            char *, int);
> +       bool (*check_trans2)(struct smb_message *smb, struct TCP_Server_I=
nfo *server,
> +                            char *buf, int malformed);
>         /* check if we need to negotiate */
>         bool (*need_neg)(struct TCP_Server_Info *);
>         /* negotiate to the server */
> @@ -594,7 +594,7 @@ struct smb_version_operations {
>                                  struct smb_rqst *, struct smb_rqst *);
>         int (*is_transform_hdr)(void *buf);
>         int (*receive_transform)(struct TCP_Server_Info *,
> -                                struct mid_q_entry **, char **, int *);
> +                                struct smb_message **smb, char **, int *=
);
>         enum securityEnum (*select_sectype)(struct TCP_Server_Info *,
>                             enum securityEnum);
>         int (*next_header)(struct TCP_Server_Info *server, char *buf,
> @@ -1659,8 +1659,8 @@ static inline void cifs_stats_bytes_read(struct cif=
s_tcon *tcon,
>   * Returns zero on a successful receive, or an error. The receive state =
in
>   * the TCP_Server_Info will also be updated.
>   */
> -typedef int (mid_receive_t)(struct TCP_Server_Info *server,
> -                           struct mid_q_entry *mid);
> +typedef int (*mid_receive_t)(struct TCP_Server_Info *server,
> +                            struct smb_message *msg);
>
>  /*
>   * This is the prototype for the mid callback function. This is called o=
nce the
> @@ -1670,17 +1670,17 @@ typedef int (mid_receive_t)(struct TCP_Server_Inf=
o *server,
>   * - it will be called by cifsd, with no locks held
>   * - the mid will be removed from any lists
>   */
> -typedef void (mid_callback_t)(struct mid_q_entry *mid);
> +typedef void (*mid_callback_t)(struct smb_message *smb);
>
>  /*
>   * This is the protopyte for mid handle function. This is called once th=
e mid
>   * has been recognized after decryption of the message.
>   */
> -typedef int (mid_handle_t)(struct TCP_Server_Info *server,
> -                           struct mid_q_entry *mid);
> +typedef int (*mid_handle_t)(struct TCP_Server_Info *server,
> +                           struct smb_message *smb);
>
>  /* one of these for every pending CIFS request to the server */
> -struct mid_q_entry {
> +struct smb_message {
>         struct list_head qhead; /* mids waiting on reply from this server=
 */
>         struct kref refcount;
>         struct TCP_Server_Info *server; /* server corresponding to this m=
id */
> @@ -1694,9 +1694,9 @@ struct mid_q_entry {
>         unsigned long when_sent; /* time when smb send finished */
>         unsigned long when_received; /* when demux complete (taken off wi=
re) */
>  #endif
> -       mid_receive_t *receive; /* call receive callback */
> -       mid_callback_t *callback; /* call completion callback */
> -       mid_handle_t *handle; /* call handle mid callback */
> +       mid_receive_t receive; /* call receive callback */
> +       mid_callback_t callback; /* call completion callback */
> +       mid_handle_t handle; /* call handle mid callback */
>         void *callback_data;      /* general purpose pointer for callback=
 */
>         struct task_struct *creator;
>         void *resp_buf;         /* pointer to received SMB header */
> @@ -1745,12 +1745,12 @@ static inline void cifs_num_waiters_dec(struct TC=
P_Server_Info *server)
>  }
>
>  #ifdef CONFIG_CIFS_STATS2
> -static inline void cifs_save_when_sent(struct mid_q_entry *mid)
> +static inline void cifs_save_when_sent(struct smb_message *smb)
>  {
> -       mid->when_sent =3D jiffies;
> +       smb->when_sent =3D jiffies;
>  }
>  #else
> -static inline void cifs_save_when_sent(struct mid_q_entry *mid)
> +static inline void cifs_save_when_sent(struct smb_message *smb)
>  {
>  }
>  #endif
> @@ -2104,7 +2104,7 @@ extern __u32 cifs_lock_secret;
>
>  extern mempool_t *cifs_sm_req_poolp;
>  extern mempool_t *cifs_req_poolp;
> -extern mempool_t *cifs_mid_poolp;
> +extern mempool_t smb_message_pool;
>  extern mempool_t cifs_io_request_pool;
>  extern mempool_t cifs_io_subrequest_pool;
>
> @@ -2351,17 +2351,17 @@ static inline bool cifs_netbios_name(const char *=
name, size_t namelen)
>   * Execute mid callback atomically - ensures callback runs exactly once
>   * and prevents sleeping in atomic context.
>   */
> -static inline void mid_execute_callback(struct mid_q_entry *mid)
> +static inline void mid_execute_callback(struct smb_message *smb)
>  {
> -       void (*callback)(struct mid_q_entry *mid);
> +       mid_callback_t callback;
>
> -       spin_lock(&mid->mid_lock);
> -       callback =3D mid->callback;
> -       mid->callback =3D NULL;  /* Mark as executed, */
> -       spin_unlock(&mid->mid_lock);
> +       spin_lock(&smb->mid_lock);
> +       callback =3D smb->callback;
> +       smb->callback =3D NULL;  /* Mark as executed, */
> +       spin_unlock(&smb->mid_lock);
>
>         if (callback)
> -               callback(mid);
> +               callback(smb);
>  }
>
>  #define CIFS_REPARSE_SUPPORT(tcon) \
> diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
> index 3528c365a452..7e0b5fc99847 100644
> --- a/fs/smb/client/cifsproto.h
> +++ b/fs/smb/client/cifsproto.h
> @@ -84,11 +84,11 @@ extern char *cifs_build_path_to_root(struct smb3_fs_c=
ontext *ctx,
>                                      int add_treename);
>  extern char *build_wildcard_path_from_dentry(struct dentry *direntry);
>  char *cifs_build_devname(char *nodename, const char *prepath);
> -extern void delete_mid(struct mid_q_entry *mid);
> +extern void delete_mid(struct smb_message *smb);
>  void __release_mid(struct kref *refcount);
> -extern void cifs_wake_up_task(struct mid_q_entry *mid);
> +extern void cifs_wake_up_task(struct smb_message *smb);
>  extern int cifs_handle_standard(struct TCP_Server_Info *server,
> -                               struct mid_q_entry *mid);
> +                               struct smb_message *smb);
>  extern char *smb3_fs_context_fullpath(const struct smb3_fs_context *ctx,
>                                       char dirsep);
>  extern int smb3_parse_devname(const char *devname, struct smb3_fs_contex=
t *ctx);
> @@ -98,8 +98,8 @@ extern bool cifs_match_ipaddr(struct sockaddr *srcaddr,=
 struct sockaddr *rhs);
>  extern int cifs_discard_remaining_data(struct TCP_Server_Info *server);
>  extern int cifs_call_async(struct TCP_Server_Info *server,
>                         struct smb_rqst *rqst,
> -                       mid_receive_t *receive, mid_callback_t *callback,
> -                       mid_handle_t *handle, void *cbdata, const int fla=
gs,
> +                       mid_receive_t receive, mid_callback_t callback,
> +                       mid_handle_t handle, void *cbdata, const int flag=
s,
>                         const struct cifs_credits *exist_credits);
>  extern struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses);
>  extern int cifs_send_recv(const unsigned int xid, struct cifs_ses *ses,
> @@ -117,15 +117,14 @@ extern int SendReceive(const unsigned int /* xid */=
 , struct cifs_ses *,
>                         int * /* bytes returned */ , const int);
>  extern int SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses=
,
>                             char *in_buf, int flags);
> -int cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info=
 *server);
> -extern struct mid_q_entry *cifs_setup_request(struct cifs_ses *,
> -                               struct TCP_Server_Info *,
> -                               struct smb_rqst *);
> -extern struct mid_q_entry *cifs_setup_async_request(struct TCP_Server_In=
fo *,
> -                                               struct smb_rqst *);
> +int cifs_sync_mid_result(struct smb_message *smb, struct TCP_Server_Info=
 *server);
> +struct smb_message *cifs_setup_request(struct cifs_ses *ses, struct TCP_=
Server_Info *ignored,
> +                                      struct smb_rqst *rqst);
> +struct smb_message *cifs_setup_async_request(struct TCP_Server_Info *ser=
ver,
> +                                            struct smb_rqst *rqst);
>  int __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
>                     struct smb_rqst *rqst);
> -extern int cifs_check_receive(struct mid_q_entry *mid,
> +extern int cifs_check_receive(struct smb_message *msg,
>                         struct TCP_Server_Info *server, bool log_error);
>  int wait_for_free_request(struct TCP_Server_Info *server, const int flag=
s,
>                           unsigned int *instance);
> @@ -135,13 +134,13 @@ extern int cifs_wait_mtu_credits(struct TCP_Server_=
Info *server,
>
>  static inline int
>  send_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
> -           struct mid_q_entry *mid)
> +           struct smb_message *smb)
>  {
>         return server->ops->send_cancel ?
> -                               server->ops->send_cancel(server, rqst, mi=
d) : 0;
> +                               server->ops->send_cancel(server, rqst, sm=
b) : 0;
>  }
>
> -int wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry=
 *midQ);
> +int wait_for_response(struct TCP_Server_Info *server, struct smb_message=
 *smb);
>  extern int SendReceive2(const unsigned int /* xid */ , struct cifs_ses *=
,
>                         struct kvec *, int /* nvec to send */,
>                         int * /* type of buf returned */, const int flags=
,
> @@ -187,7 +186,7 @@ extern int decode_negTokenInit(unsigned char *securit=
y_blob, int length,
>  extern int cifs_convert_address(struct sockaddr *dst, const char *src, i=
nt len);
>  extern void cifs_set_port(struct sockaddr *addr, const unsigned short in=
t port);
>  extern int map_smb_to_linux_error(char *buf, bool logErr);
> -extern int map_and_check_smb_error(struct mid_q_entry *mid, bool logErr)=
;
> +extern int map_and_check_smb_error(struct smb_message *smb, bool logErr)=
;
>  extern void header_assemble(struct smb_hdr *, char /* command */ ,
>                             const struct cifs_tcon *, int /* length of
>                             fixed section (word count) in two byte units =
*/);
> @@ -270,7 +269,7 @@ extern unsigned int setup_special_mode_ACE(struct smb=
_ace *pace,
>                                            __u64 nmode);
>  extern unsigned int setup_special_user_owner_ACE(struct smb_ace *pace);
>
> -extern void dequeue_mid(struct mid_q_entry *mid, bool malformed);
> +extern void dequeue_mid(struct smb_message *smb, bool malformed);
>  extern int cifs_read_from_socket(struct TCP_Server_Info *server, char *b=
uf,
>                                  unsigned int to_read);
>  extern ssize_t cifs_discard_from_socket(struct TCP_Server_Info *server,
> @@ -624,7 +623,7 @@ extern struct cifs_ses *
>  cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context =
*ctx);
>
>  int cifs_async_readv(struct cifs_io_subrequest *rdata);
> -int cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entr=
y *mid);
> +int cifs_readv_receive(struct TCP_Server_Info *server, struct smb_messag=
e *smb);
>
>  void cifs_async_writev(struct cifs_io_subrequest *wdata);
>  int cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
> @@ -777,9 +776,9 @@ static inline bool dfs_src_pathname_equal(const char =
*s1, const char *s2)
>         return true;
>  }
>
> -static inline void release_mid(struct mid_q_entry *mid)
> +static inline void release_mid(struct smb_message *smb)
>  {
> -       kref_put(&mid->refcount, __release_mid);
> +       kref_put(&smb->refcount, __release_mid);
>  }
>
>  static inline void cifs_free_open_info(struct cifs_open_info_data *data)
> diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
> index 428e582e0414..b383046f8532 100644
> --- a/fs/smb/client/cifssmb.c
> +++ b/fs/smb/client/cifssmb.c
> @@ -577,12 +577,12 @@ CIFSSMBTDis(const unsigned int xid, struct cifs_tco=
n *tcon)
>   * FIXME: maybe we should consider checking that the reply matches reque=
st?
>   */
>  static void
> -cifs_echo_callback(struct mid_q_entry *mid)
> +cifs_echo_callback(struct smb_message *smb)
>  {
> -       struct TCP_Server_Info *server =3D mid->callback_data;
> +       struct TCP_Server_Info *server =3D smb->callback_data;
>         struct cifs_credits credits =3D { .value =3D 1, .instance =3D 0 }=
;
>
> -       release_mid(mid);
> +       release_mid(smb);
>         add_credits(server, &credits, CIFS_ECHO_OP);
>  }
>
> @@ -1296,9 +1296,9 @@ CIFS_open(const unsigned int xid, struct cifs_open_=
parms *oparms, int *oplock,
>  }
>
>  static void
> -cifs_readv_callback(struct mid_q_entry *mid)
> +cifs_readv_callback(struct smb_message *smb)
>  {
> -       struct cifs_io_subrequest *rdata =3D mid->callback_data;
> +       struct cifs_io_subrequest *rdata =3D smb->callback_data;
>         struct netfs_inode *ictx =3D netfs_inode(rdata->rreq->inode);
>         struct cifs_tcon *tcon =3D tlink_tcon(rdata->req->cfile->tlink);
>         struct TCP_Server_Info *server =3D tcon->ses->server;
> @@ -1315,10 +1315,10 @@ cifs_readv_callback(struct mid_q_entry *mid)
>         unsigned int subreq_debug_index =3D rdata->subreq.debug_index;
>
>         cifs_dbg(FYI, "%s: mid=3D%llu state=3D%d result=3D%d bytes=3D%zu\=
n",
> -                __func__, mid->mid, mid->mid_state, rdata->result,
> +                __func__, smb->mid, smb->mid_state, rdata->result,
>                  rdata->subreq.len);
>
> -       switch (mid->mid_state) {
> +       switch (smb->mid_state) {
>         case MID_RESPONSE_RECEIVED:
>                 /* result already set, check signature */
>                 if (server->sign) {
> @@ -1326,7 +1326,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
>
>                         iov_iter_truncate(&rqst.rq_iter, rdata->got_bytes=
);
>                         rc =3D cifs_verify_signature(&rqst, server,
> -                                                 mid->sequence_number);
> +                                                 smb->sequence_number);
>                         if (rc)
>                                 cifs_dbg(VFS, "SMB signature verification=
 returned error =3D %d\n",
>                                          rc);
> @@ -1399,7 +1399,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
>         rdata->subreq.transferred +=3D rdata->got_bytes;
>         trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
>         netfs_read_subreq_terminated(&rdata->subreq);
> -       release_mid(mid);
> +       release_mid(smb);
>         add_credits(server, &credits, 0);
>         trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
>                               server->credits, server->in_flight,
> @@ -1712,12 +1712,12 @@ CIFSSMBWrite(const unsigned int xid, struct cifs_=
io_parms *io_parms,
>   * workqueue completion task.
>   */
>  static void
> -cifs_writev_callback(struct mid_q_entry *mid)
> +cifs_writev_callback(struct smb_message *smb)
>  {
> -       struct cifs_io_subrequest *wdata =3D mid->callback_data;
> +       struct cifs_io_subrequest *wdata =3D smb->callback_data;
>         struct TCP_Server_Info *server =3D wdata->server;
>         struct cifs_tcon *tcon =3D tlink_tcon(wdata->req->cfile->tlink);
> -       WRITE_RSP *smb =3D (WRITE_RSP *)mid->resp_buf;
> +       WRITE_RSP *rsp =3D (WRITE_RSP *)smb->resp_buf;
>         struct cifs_credits credits =3D {
>                 .value =3D 1,
>                 .instance =3D 0,
> @@ -1727,15 +1727,15 @@ cifs_writev_callback(struct mid_q_entry *mid)
>         ssize_t result;
>         size_t written;
>
> -       switch (mid->mid_state) {
> +       switch (smb->mid_state) {
>         case MID_RESPONSE_RECEIVED:
> -               result =3D cifs_check_receive(mid, tcon->ses->server, 0);
> +               result =3D cifs_check_receive(smb, tcon->ses->server, 0);
>                 if (result !=3D 0)
>                         break;
>
> -               written =3D le16_to_cpu(smb->CountHigh);
> +               written =3D le16_to_cpu(rsp->CountHigh);
>                 written <<=3D 16;
> -               written +=3D le16_to_cpu(smb->Count);
> +               written +=3D le16_to_cpu(rsp->Count);
>                 /*
>                  * Mask off high 16 bits when bytes written as returned
>                  * by the server is greater than bytes requested by the
> @@ -1779,7 +1779,7 @@ cifs_writev_callback(struct mid_q_entry *mid)
>                               0, cifs_trace_rw_credits_write_response_cle=
ar);
>         wdata->credits.value =3D 0;
>         cifs_write_subrequest_terminated(wdata, result);
> -       release_mid(mid);
> +       release_mid(smb);
>         trace_smb3_rw_credits(credits.rreq_debug_id, credits.rreq_debug_i=
ndex, 0,
>                               server->credits, server->in_flight,
>                               credits.value, cifs_trace_rw_credits_write_=
response_add);
> @@ -1791,7 +1791,7 @@ void
>  cifs_async_writev(struct cifs_io_subrequest *wdata)
>  {
>         int rc =3D -EACCES;
> -       WRITE_REQ *smb =3D NULL;
> +       WRITE_REQ *req =3D NULL;
>         int wct;
>         struct cifs_tcon *tcon =3D tlink_tcon(wdata->req->cfile->tlink);
>         struct kvec iov[2];
> @@ -1808,30 +1808,30 @@ cifs_async_writev(struct cifs_io_subrequest *wdat=
a)
>                 }
>         }
>
> -       rc =3D small_smb_init(SMB_COM_WRITE_ANDX, wct, tcon, (void **)&sm=
b);
> +       rc =3D small_smb_init(SMB_COM_WRITE_ANDX, wct, tcon, (void **)&re=
q);
>         if (rc)
>                 goto async_writev_out;
>
> -       smb->hdr.Pid =3D cpu_to_le16((__u16)wdata->req->pid);
> -       smb->hdr.PidHigh =3D cpu_to_le16((__u16)(wdata->req->pid >> 16));
> +       req->hdr.Pid =3D cpu_to_le16((__u16)wdata->req->pid);
> +       req->hdr.PidHigh =3D cpu_to_le16((__u16)(wdata->req->pid >> 16));
>
> -       smb->AndXCommand =3D 0xFF;        /* none */
> -       smb->Fid =3D wdata->req->cfile->fid.netfid;
> -       smb->OffsetLow =3D cpu_to_le32(wdata->subreq.start & 0xFFFFFFFF);
> +       req->AndXCommand =3D 0xFF;        /* none */
> +       req->Fid =3D wdata->req->cfile->fid.netfid;
> +       req->OffsetLow =3D cpu_to_le32(wdata->subreq.start & 0xFFFFFFFF);
>         if (wct =3D=3D 14)
> -               smb->OffsetHigh =3D cpu_to_le32(wdata->subreq.start >> 32=
);
> -       smb->Reserved =3D 0xFFFFFFFF;
> -       smb->WriteMode =3D 0;
> -       smb->Remaining =3D 0;
> +               req->OffsetHigh =3D cpu_to_le32(wdata->subreq.start >> 32=
);
> +       req->Reserved =3D 0xFFFFFFFF;
> +       req->WriteMode =3D 0;
> +       req->Remaining =3D 0;
>
> -       smb->DataOffset =3D
> +       req->DataOffset =3D
>             cpu_to_le16(offsetof(struct smb_com_write_req, Data) - 4);
>
>         /* 4 for RFC1001 length + 1 for BCC */
>         iov[0].iov_len =3D 4;
> -       iov[0].iov_base =3D smb;
> -       iov[1].iov_len =3D get_rfc1002_len(smb) + 1;
> -       iov[1].iov_base =3D (char *)smb + 4;
> +       iov[0].iov_base =3D req;
> +       iov[1].iov_len =3D get_rfc1002_len(req) + 1;
> +       iov[1].iov_base =3D (char *)req + 4;
>
>         rqst.rq_iov =3D iov;
>         rqst.rq_nvec =3D 2;
> @@ -1840,18 +1840,18 @@ cifs_async_writev(struct cifs_io_subrequest *wdat=
a)
>         cifs_dbg(FYI, "async write at %llu %zu bytes\n",
>                  wdata->subreq.start, wdata->subreq.len);
>
> -       smb->DataLengthLow =3D cpu_to_le16(wdata->subreq.len & 0xFFFF);
> -       smb->DataLengthHigh =3D cpu_to_le16(wdata->subreq.len >> 16);
> +       req->DataLengthLow =3D cpu_to_le16(wdata->subreq.len & 0xFFFF);
> +       req->DataLengthHigh =3D cpu_to_le16(wdata->subreq.len >> 16);
>
>         if (wct =3D=3D 14) {
> -               inc_rfc1001_len(&smb->hdr, wdata->subreq.len + 1);
> -               put_bcc(wdata->subreq.len + 1, &smb->hdr);
> +               inc_rfc1001_len(&req->hdr, wdata->subreq.len + 1);
> +               put_bcc(wdata->subreq.len + 1, &req->hdr);
>         } else {
>                 /* wct =3D=3D 12 */
> -               struct smb_com_writex_req *smbw =3D
> -                               (struct smb_com_writex_req *)smb;
> -               inc_rfc1001_len(&smbw->hdr, wdata->subreq.len + 5);
> -               put_bcc(wdata->subreq.len + 5, &smbw->hdr);
> +               struct smb_com_writex_req *reqw =3D
> +                               (struct smb_com_writex_req *)req;
> +               inc_rfc1001_len(&reqw->hdr, wdata->subreq.len + 5);
> +               put_bcc(wdata->subreq.len + 5, &reqw->hdr);
>                 iov[1].iov_len +=3D 4; /* pad bigger by four bytes */
>         }
>
> @@ -1862,7 +1862,7 @@ cifs_async_writev(struct cifs_io_subrequest *wdata)
>                 cifs_stats_inc(&tcon->stats.cifs_stats.num_writes);
>
>  async_writev_out:
> -       cifs_small_buf_release(smb);
> +       cifs_small_buf_release(req);
>  out:
>         if (rc) {
>                 add_credits_and_wake_if(wdata->server, &wdata->credits, 0=
);
> diff --git a/fs/smb/client/cifstransport.c b/fs/smb/client/cifstransport.=
c
> index 4c4f5befb6d3..2f08fcad945e 100644
> --- a/fs/smb/client/cifstransport.c
> +++ b/fs/smb/client/cifstransport.c
> @@ -33,41 +33,41 @@
>  /* Max number of iovectors we can use off the stack when sending request=
s. */
>  #define CIFS_MAX_IOV_SIZE 8
>
> -static struct mid_q_entry *
> +static struct smb_message *
>  alloc_mid(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *serv=
er)
>  {
> -       struct mid_q_entry *temp;
> +       struct smb_message *smb;
>
>         if (server =3D=3D NULL) {
>                 cifs_dbg(VFS, "%s: null TCP session\n", __func__);
>                 return NULL;
>         }
>
> -       temp =3D mempool_alloc(cifs_mid_poolp, GFP_NOFS);
> -       memset(temp, 0, sizeof(struct mid_q_entry));
> -       kref_init(&temp->refcount);
> -       spin_lock_init(&temp->mid_lock);
> -       temp->mid =3D get_mid(smb_buffer);
> -       temp->pid =3D current->pid;
> -       temp->command =3D cpu_to_le16(smb_buffer->Command);
> +       smb =3D mempool_alloc(&smb_message_pool, GFP_NOFS);
> +       memset(smb, 0, sizeof(struct smb_message));
> +       kref_init(&smb->refcount);
> +       spin_lock_init(&smb->mid_lock);
> +       smb->mid =3D get_mid(smb_buffer);
> +       smb->pid =3D current->pid;
> +       smb->command =3D cpu_to_le16(smb_buffer->Command);
>         cifs_dbg(FYI, "For smb_command %d\n", smb_buffer->Command);
>         /* easier to use jiffies */
>         /* when mid allocated can be before when sent */
> -       temp->when_alloc =3D jiffies;
> -       temp->server =3D server;
> +       smb->when_alloc =3D jiffies;
> +       smb->server =3D server;
>
>         /*
>          * The default is for the mid to be synchronous, so the
>          * default callback just wakes up the current task.
>          */
>         get_task_struct(current);
> -       temp->creator =3D current;
> -       temp->callback =3D cifs_wake_up_task;
> -       temp->callback_data =3D current;
> +       smb->creator =3D current;
> +       smb->callback =3D cifs_wake_up_task;
> +       smb->callback_data =3D current;
>
>         atomic_inc(&mid_count);
> -       temp->mid_state =3D MID_REQUEST_ALLOCATED;
> -       return temp;
> +       smb->mid_state =3D MID_REQUEST_ALLOCATED;
> +       return smb;
>  }
>
>  int
> @@ -87,7 +87,7 @@ smb_send(struct TCP_Server_Info *server, struct smb_hdr=
 *smb_buffer,
>  }
>
>  static int allocate_mid(struct cifs_ses *ses, struct smb_hdr *in_buf,
> -                       struct mid_q_entry **ppmidQ)
> +                       struct smb_message **ppmidQ)
>  {
>         spin_lock(&ses->ses_lock);
>         if (ses->ses_status =3D=3D SES_NEW) {
> @@ -118,12 +118,12 @@ static int allocate_mid(struct cifs_ses *ses, struc=
t smb_hdr *in_buf,
>         return 0;
>  }
>
> -struct mid_q_entry *
> +struct smb_message *
>  cifs_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst=
 *rqst)
>  {
>         int rc;
>         struct smb_hdr *hdr =3D (struct smb_hdr *)rqst->rq_iov[0].iov_bas=
e;
> -       struct mid_q_entry *mid;
> +       struct smb_message *smb;
>
>         if (rqst->rq_iov[0].iov_len !=3D 4 ||
>             rqst->rq_iov[0].iov_base + 4 !=3D rqst->rq_iov[1].iov_base)
> @@ -133,17 +133,17 @@ cifs_setup_async_request(struct TCP_Server_Info *se=
rver, struct smb_rqst *rqst)
>         if (server->sign)
>                 hdr->Flags2 |=3D SMBFLG2_SECURITY_SIGNATURE;
>
> -       mid =3D alloc_mid(hdr, server);
> -       if (mid =3D=3D NULL)
> +       smb =3D alloc_mid(hdr, server);
> +       if (smb =3D=3D NULL)
>                 return ERR_PTR(-ENOMEM);
>
> -       rc =3D cifs_sign_rqst(rqst, server, &mid->sequence_number);
> +       rc =3D cifs_sign_rqst(rqst, server, &smb->sequence_number);
>         if (rc) {
> -               release_mid(mid);
> +               release_mid(smb);
>                 return ERR_PTR(rc);
>         }
>
> -       return mid;
> +       return smb;
>  }
>
>  /*
> @@ -174,12 +174,12 @@ SendReceiveNoRsp(const unsigned int xid, struct cif=
s_ses *ses,
>  }
>
>  int
> -cifs_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *serv=
er,
> +cifs_check_receive(struct smb_message *smb, struct TCP_Server_Info *serv=
er,
>                    bool log_error)
>  {
> -       unsigned int len =3D get_rfc1002_len(mid->resp_buf) + 4;
> +       unsigned int len =3D get_rfc1002_len(smb->resp_buf) + 4;
>
> -       dump_smb(mid->resp_buf, min_t(u32, 92, len));
> +       dump_smb(smb->resp_buf, min_t(u32, 92, len));
>
>         /* convert the length into a more usable form */
>         if (server->sign) {
> @@ -188,43 +188,43 @@ cifs_check_receive(struct mid_q_entry *mid, struct =
TCP_Server_Info *server,
>                 struct smb_rqst rqst =3D { .rq_iov =3D iov,
>                                          .rq_nvec =3D 2 };
>
> -               iov[0].iov_base =3D mid->resp_buf;
> +               iov[0].iov_base =3D smb->resp_buf;
>                 iov[0].iov_len =3D 4;
> -               iov[1].iov_base =3D (char *)mid->resp_buf + 4;
> +               iov[1].iov_base =3D (char *)smb->resp_buf + 4;
>                 iov[1].iov_len =3D len - 4;
>                 /* FIXME: add code to kill session */
>                 rc =3D cifs_verify_signature(&rqst, server,
> -                                          mid->sequence_number);
> +                                          smb->sequence_number);
>                 if (rc)
>                         cifs_server_dbg(VFS, "SMB signature verification =
returned error =3D %d\n",
>                                  rc);
>         }
>
>         /* BB special case reconnect tid and uid here? */
> -       return map_and_check_smb_error(mid, log_error);
> +       return map_and_check_smb_error(smb, log_error);
>  }
>
> -struct mid_q_entry *
> +struct smb_message *
>  cifs_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *ignored=
,
>                    struct smb_rqst *rqst)
>  {
>         int rc;
>         struct smb_hdr *hdr =3D (struct smb_hdr *)rqst->rq_iov[0].iov_bas=
e;
> -       struct mid_q_entry *mid;
> +       struct smb_message *smb;
>
>         if (rqst->rq_iov[0].iov_len !=3D 4 ||
>             rqst->rq_iov[0].iov_base + 4 !=3D rqst->rq_iov[1].iov_base)
>                 return ERR_PTR(-EIO);
>
> -       rc =3D allocate_mid(ses, hdr, &mid);
> +       rc =3D allocate_mid(ses, hdr, &smb);
>         if (rc)
>                 return ERR_PTR(rc);
> -       rc =3D cifs_sign_rqst(rqst, ses->server, &mid->sequence_number);
> +       rc =3D cifs_sign_rqst(rqst, ses->server, &smb->sequence_number);
>         if (rc) {
> -               delete_mid(mid);
> +               delete_mid(smb);
>                 return ERR_PTR(rc);
>         }
> -       return mid;
> +       return smb;
>  }
>
>  int
> @@ -272,7 +272,7 @@ SendReceive(const unsigned int xid, struct cifs_ses *=
ses,
>             int *pbytes_returned, const int flags)
>  {
>         int rc =3D 0;
> -       struct mid_q_entry *midQ;
> +       struct smb_message *smb;
>         unsigned int len =3D be32_to_cpu(in_buf->smb_buf_length);
>         struct kvec iov =3D { .iov_base =3D in_buf, .iov_len =3D len };
>         struct smb_rqst rqst =3D { .rq_iov =3D &iov, .rq_nvec =3D 1 };
> @@ -316,7 +316,7 @@ SendReceive(const unsigned int xid, struct cifs_ses *=
ses,
>
>         cifs_server_lock(server);
>
> -       rc =3D allocate_mid(ses, in_buf, &midQ);
> +       rc =3D allocate_mid(ses, in_buf, &smb);
>         if (rc) {
>                 cifs_server_unlock(server);
>                 /* Update # of requests on wire to server */
> @@ -324,16 +324,16 @@ SendReceive(const unsigned int xid, struct cifs_ses=
 *ses,
>                 return rc;
>         }
>
> -       rc =3D cifs_sign_smb(in_buf, server, &midQ->sequence_number);
> +       rc =3D cifs_sign_smb(in_buf, server, &smb->sequence_number);
>         if (rc) {
>                 cifs_server_unlock(server);
>                 goto out;
>         }
>
> -       midQ->mid_state =3D MID_REQUEST_SUBMITTED;
> +       smb->mid_state =3D MID_REQUEST_SUBMITTED;
>
>         rc =3D smb_send(server, in_buf, len);
> -       cifs_save_when_sent(midQ);
> +       cifs_save_when_sent(smb);
>
>         if (rc < 0)
>                 server->sequence_number -=3D 2;
> @@ -343,38 +343,39 @@ SendReceive(const unsigned int xid, struct cifs_ses=
 *ses,
>         if (rc < 0)
>                 goto out;
>
> -       rc =3D wait_for_response(server, midQ);
> +       rc =3D wait_for_response(server, smb);
>         if (rc !=3D 0) {
> -               send_cancel(server, &rqst, midQ);
> -               spin_lock(&midQ->mid_lock);
> -               if (midQ->callback) {
> +               send_cancel(server, &rqst, smb);
> +               spin_lock(&smb->mid_lock);
> +               if (smb->mid_state =3D=3D MID_REQUEST_SUBMITTED ||
> +                   smb->mid_state =3D=3D MID_RESPONSE_RECEIVED) {
>                         /* no longer considered to be "in-flight" */
> -                       midQ->callback =3D release_mid;
> -                       spin_unlock(&midQ->mid_lock);
> +                       smb->callback =3D release_mid;
> +                       spin_unlock(&smb->mid_lock);
>                         add_credits(server, &credits, 0);
>                         return rc;
>                 }
> -               spin_unlock(&midQ->mid_lock);
> +               spin_unlock(&smb->mid_lock);
>         }
>
> -       rc =3D cifs_sync_mid_result(midQ, server);
> +       rc =3D cifs_sync_mid_result(smb, server);
>         if (rc !=3D 0) {
>                 add_credits(server, &credits, 0);
>                 return rc;
>         }
>
> -       if (!midQ->resp_buf || !out_buf ||
> -           midQ->mid_state !=3D MID_RESPONSE_READY) {
> +       if (!smb->resp_buf || !out_buf ||
> +           smb->mid_state !=3D MID_RESPONSE_READY) {
>                 rc =3D -EIO;
>                 cifs_server_dbg(VFS, "Bad MID state?\n");
>                 goto out;
>         }
>
> -       *pbytes_returned =3D get_rfc1002_len(midQ->resp_buf);
> -       memcpy(out_buf, midQ->resp_buf, *pbytes_returned + 4);
> -       rc =3D cifs_check_receive(midQ, server, 0);
> +       *pbytes_returned =3D get_rfc1002_len(smb->resp_buf);
> +       memcpy(out_buf, smb->resp_buf, *pbytes_returned + 4);
> +       rc =3D cifs_check_receive(smb, server, 0);
>  out:
> -       delete_mid(midQ);
> +       delete_mid(smb);
>         add_credits(server, &credits, 0);
>
>         return rc;
> @@ -412,7 +413,7 @@ SendReceiveBlockingLock(const unsigned int xid, struc=
t cifs_tcon *tcon,
>  {
>         int rc =3D 0;
>         int rstart =3D 0;
> -       struct mid_q_entry *midQ;
> +       struct smb_message *smb;
>         struct cifs_ses *ses;
>         unsigned int len =3D be32_to_cpu(in_buf->smb_buf_length);
>         struct kvec iov =3D { .iov_base =3D in_buf, .iov_len =3D len };
> @@ -459,22 +460,22 @@ SendReceiveBlockingLock(const unsigned int xid, str=
uct cifs_tcon *tcon,
>
>         cifs_server_lock(server);
>
> -       rc =3D allocate_mid(ses, in_buf, &midQ);
> +       rc =3D allocate_mid(ses, in_buf, &smb);
>         if (rc) {
>                 cifs_server_unlock(server);
>                 return rc;
>         }
>
> -       rc =3D cifs_sign_smb(in_buf, server, &midQ->sequence_number);
> +       rc =3D cifs_sign_smb(in_buf, server, &smb->sequence_number);
>         if (rc) {
> -               delete_mid(midQ);
> +               delete_mid(smb);
>                 cifs_server_unlock(server);
>                 return rc;
>         }
>
> -       midQ->mid_state =3D MID_REQUEST_SUBMITTED;
> +       smb->mid_state =3D MID_REQUEST_SUBMITTED;
>         rc =3D smb_send(server, in_buf, len);
> -       cifs_save_when_sent(midQ);
> +       cifs_save_when_sent(smb);
>
>         if (rc < 0)
>                 server->sequence_number -=3D 2;
> @@ -482,22 +483,22 @@ SendReceiveBlockingLock(const unsigned int xid, str=
uct cifs_tcon *tcon,
>         cifs_server_unlock(server);
>
>         if (rc < 0) {
> -               delete_mid(midQ);
> +               delete_mid(smb);
>                 return rc;
>         }
>
>         /* Wait for a reply - allow signals to interrupt. */
>         rc =3D wait_event_interruptible(server->response_q,
> -               (!(midQ->mid_state =3D=3D MID_REQUEST_SUBMITTED ||
> -                  midQ->mid_state =3D=3D MID_RESPONSE_RECEIVED)) ||
> +               (!(smb->mid_state =3D=3D MID_REQUEST_SUBMITTED ||
> +                  smb->mid_state =3D=3D MID_RESPONSE_RECEIVED)) ||
>                 ((server->tcpStatus !=3D CifsGood) &&
>                  (server->tcpStatus !=3D CifsNew)));
>
>         /* Were we interrupted by a signal ? */
>         spin_lock(&server->srv_lock);
>         if ((rc =3D=3D -ERESTARTSYS) &&
> -               (midQ->mid_state =3D=3D MID_REQUEST_SUBMITTED ||
> -                midQ->mid_state =3D=3D MID_RESPONSE_RECEIVED) &&
> +               (smb->mid_state =3D=3D MID_REQUEST_SUBMITTED ||
> +                smb->mid_state =3D=3D MID_RESPONSE_RECEIVED) &&
>                 ((server->tcpStatus =3D=3D CifsGood) ||
>                  (server->tcpStatus =3D=3D CifsNew))) {
>                 spin_unlock(&server->srv_lock);
> @@ -505,9 +506,9 @@ SendReceiveBlockingLock(const unsigned int xid, struc=
t cifs_tcon *tcon,
>                 if (in_buf->Command =3D=3D SMB_COM_TRANSACTION2) {
>                         /* POSIX lock. We send a NT_CANCEL SMB to cause t=
he
>                            blocking lock to return. */
> -                       rc =3D send_cancel(server, &rqst, midQ);
> +                       rc =3D send_cancel(server, &rqst, smb);
>                         if (rc) {
> -                               delete_mid(midQ);
> +                               delete_mid(smb);
>                                 return rc;
>                         }
>                 } else {
> @@ -519,22 +520,23 @@ SendReceiveBlockingLock(const unsigned int xid, str=
uct cifs_tcon *tcon,
>                         /* If we get -ENOLCK back the lock may have
>                            already been removed. Don't exit in this case.=
 */
>                         if (rc && rc !=3D -ENOLCK) {
> -                               delete_mid(midQ);
> +                               delete_mid(smb);
>                                 return rc;
>                         }
>                 }
>
> -               rc =3D wait_for_response(server, midQ);
> +               rc =3D wait_for_response(server, smb);
>                 if (rc) {
> -                       send_cancel(server, &rqst, midQ);
> -                       spin_lock(&midQ->mid_lock);
> -                       if (midQ->callback) {
> +                       send_cancel(server, &rqst, smb);
> +                       spin_lock(&smb->mid_lock);
> +                       if (smb->mid_state =3D=3D MID_REQUEST_SUBMITTED |=
|
> +                           smb->mid_state =3D=3D MID_RESPONSE_RECEIVED) =
{
>                                 /* no longer considered to be "in-flight"=
 */
> -                               midQ->callback =3D release_mid;
> -                               spin_unlock(&midQ->mid_lock);
> +                               smb->callback =3D release_mid;
> +                               spin_unlock(&smb->mid_lock);
>                                 return rc;
>                         }
> -                       spin_unlock(&midQ->mid_lock);
> +                       spin_unlock(&smb->mid_lock);
>                 }
>
>                 /* We got the response - restart system call. */
> @@ -543,22 +545,22 @@ SendReceiveBlockingLock(const unsigned int xid, str=
uct cifs_tcon *tcon,
>         }
>         spin_unlock(&server->srv_lock);
>
> -       rc =3D cifs_sync_mid_result(midQ, server);
> +       rc =3D cifs_sync_mid_result(smb, server);
>         if (rc !=3D 0)
>                 return rc;
>
>         /* rcvd frame is ok */
> -       if (out_buf =3D=3D NULL || midQ->mid_state !=3D MID_RESPONSE_READ=
Y) {
> +       if (out_buf =3D=3D NULL || smb->mid_state !=3D MID_RESPONSE_READY=
) {
>                 rc =3D -EIO;
>                 cifs_tcon_dbg(VFS, "Bad MID state?\n");
>                 goto out;
>         }
>
> -       *pbytes_returned =3D get_rfc1002_len(midQ->resp_buf);
> -       memcpy(out_buf, midQ->resp_buf, *pbytes_returned + 4);
> -       rc =3D cifs_check_receive(midQ, server, 0);
> +       *pbytes_returned =3D get_rfc1002_len(smb->resp_buf);
> +       memcpy(out_buf, smb->resp_buf, *pbytes_returned + 4);
> +       rc =3D cifs_check_receive(smb, server, 0);
>  out:
> -       delete_mid(midQ);
> +       delete_mid(smb);
>         if (rstart && rc =3D=3D -EACCES)
>                 return -ERESTARTSYS;
>         return rc;
> diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> index ab42235b2955..25f321a7fabe 100644
> --- a/fs/smb/client/connect.c
> +++ b/fs/smb/client/connect.c
> @@ -293,7 +293,7 @@ cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Serv=
er_Info *server,
>  static void
>  cifs_abort_connection(struct TCP_Server_Info *server)
>  {
> -       struct mid_q_entry *mid, *nmid;
> +       struct smb_message *smb, *nsmb;
>         struct list_head retry_list;
>
>         server->maxBuf =3D 0;
> @@ -324,21 +324,21 @@ cifs_abort_connection(struct TCP_Server_Info *serve=
r)
>         INIT_LIST_HEAD(&retry_list);
>         cifs_dbg(FYI, "%s: moving mids to private list\n", __func__);
>         spin_lock(&server->mid_queue_lock);
> -       list_for_each_entry_safe(mid, nmid, &server->pending_mid_q, qhead=
) {
> -               kref_get(&mid->refcount);
> -               if (mid->mid_state =3D=3D MID_REQUEST_SUBMITTED)
> -                       mid->mid_state =3D MID_RETRY_NEEDED;
> -               list_move(&mid->qhead, &retry_list);
> -               mid->deleted_from_q =3D true;
> +       list_for_each_entry_safe(smb, nsmb, &server->pending_mid_q, qhead=
) {
> +               kref_get(&smb->refcount);
> +               if (smb->mid_state =3D=3D MID_REQUEST_SUBMITTED)
> +                       smb->mid_state =3D MID_RETRY_NEEDED;
> +               list_move(&smb->qhead, &retry_list);
> +               smb->deleted_from_q =3D true;
>         }
>         spin_unlock(&server->mid_queue_lock);
>         cifs_server_unlock(server);
>
>         cifs_dbg(FYI, "%s: issuing mid callbacks\n", __func__);
> -       list_for_each_entry_safe(mid, nmid, &retry_list, qhead) {
> -               list_del_init(&mid->qhead);
> -               mid_execute_callback(mid);
> -               release_mid(mid);
> +       list_for_each_entry_safe(smb, nsmb, &retry_list, qhead) {
> +               list_del_init(&smb->qhead);
> +               mid_execute_callback(smb);
> +               release_mid(smb);
>         }
>  }
>
> @@ -868,7 +868,7 @@ is_smb_response(struct TCP_Server_Info *server, unsig=
ned char type)
>                     !server->with_rfc1001 &&
>                     server->rfc1001_sessinit !=3D 0) {
>                         int rc, mid_rc;
> -                       struct mid_q_entry *mid, *nmid;
> +                       struct smb_message *smb, *nsmb;
>                         LIST_HEAD(dispose_list);
>
>                         cifs_dbg(FYI, "RFC 1002 negative session response=
 during SMB Negotiate, retrying with NetBIOS session\n");
> @@ -881,10 +881,10 @@ is_smb_response(struct TCP_Server_Info *server, uns=
igned char type)
>                          * corresponding to SMB1/SMB2 Negotiate packet.
>                          */
>                         spin_lock(&server->mid_queue_lock);
> -                       list_for_each_entry_safe(mid, nmid, &server->pend=
ing_mid_q, qhead) {
> -                               kref_get(&mid->refcount);
> -                               list_move(&mid->qhead, &dispose_list);
> -                               mid->deleted_from_q =3D true;
> +                       list_for_each_entry_safe(smb, nsmb, &server->pend=
ing_mid_q, qhead) {
> +                               kref_get(&smb->refcount);
> +                               list_move(&smb->qhead, &dispose_list);
> +                               smb->deleted_from_q =3D true;
>                         }
>                         spin_unlock(&server->mid_queue_lock);
>
> @@ -911,12 +911,12 @@ is_smb_response(struct TCP_Server_Info *server, uns=
igned char type)
>                          * callback. Use MID_RC state which indicates tha=
t the
>                          * return code should be read from mid_rc member.
>                          */
> -                       list_for_each_entry_safe(mid, nmid, &dispose_list=
, qhead) {
> -                               list_del_init(&mid->qhead);
> -                               mid->mid_rc =3D mid_rc;
> -                               mid->mid_state =3D MID_RC;
> -                               mid_execute_callback(mid);
> -                               release_mid(mid);
> +                       list_for_each_entry_safe(smb, nsmb, &dispose_list=
, qhead) {
> +                               list_del_init(&smb->qhead);
> +                               smb->mid_rc =3D mid_rc;
> +                               smb->mid_state =3D MID_RC;
> +                               mid_execute_callback(smb);
> +                               release_mid(smb);
>                         }
>
>                         /*
> @@ -948,27 +948,27 @@ is_smb_response(struct TCP_Server_Info *server, uns=
igned char type)
>  }
>
>  void
> -dequeue_mid(struct mid_q_entry *mid, bool malformed)
> +dequeue_mid(struct smb_message *smb, bool malformed)
>  {
>  #ifdef CONFIG_CIFS_STATS2
> -       mid->when_received =3D jiffies;
> +       smb->when_received =3D jiffies;
>  #endif
> -       spin_lock(&mid->server->mid_queue_lock);
> +       spin_lock(&smb->server->mid_queue_lock);
>         if (!malformed)
> -               mid->mid_state =3D MID_RESPONSE_RECEIVED;
> +               smb->mid_state =3D MID_RESPONSE_RECEIVED;
>         else
> -               mid->mid_state =3D MID_RESPONSE_MALFORMED;
> +               smb->mid_state =3D MID_RESPONSE_MALFORMED;
>         /*
>          * Trying to handle/dequeue a mid after the send_recv()
>          * function has finished processing it is a bug.
>          */
> -       if (mid->deleted_from_q =3D=3D true) {
> -               spin_unlock(&mid->server->mid_queue_lock);
> +       if (smb->deleted_from_q) {
> +               spin_unlock(&smb->server->mid_queue_lock);
>                 pr_warn_once("trying to dequeue a deleted mid\n");
>         } else {
> -               list_del_init(&mid->qhead);
> -               mid->deleted_from_q =3D true;
> -               spin_unlock(&mid->server->mid_queue_lock);
> +               list_del_init(&smb->qhead);
> +               smb->deleted_from_q =3D true;
> +               spin_unlock(&smb->server->mid_queue_lock);
>         }
>  }
>
> @@ -987,24 +987,24 @@ smb2_get_credits_from_hdr(char *buffer, struct TCP_=
Server_Info *server)
>  }
>
>  static void
> -handle_mid(struct mid_q_entry *mid, struct TCP_Server_Info *server,
> +handle_mid(struct smb_message *smb, struct TCP_Server_Info *server,
>            char *buf, int malformed)
>  {
>         if (server->ops->check_trans2 &&
> -           server->ops->check_trans2(mid, server, buf, malformed))
> +           server->ops->check_trans2(smb, server, buf, malformed))
>                 return;
> -       mid->credits_received =3D smb2_get_credits_from_hdr(buf, server);
> -       mid->resp_buf =3D buf;
> -       mid->large_buf =3D server->large_buf;
> +       smb->credits_received =3D smb2_get_credits_from_hdr(buf, server);
> +       smb->resp_buf =3D buf;
> +       smb->large_buf =3D server->large_buf;
>         /* Was previous buf put in mpx struct for multi-rsp? */
> -       if (!mid->multiRsp) {
> +       if (!smb->multiRsp) {
>                 /* smb buffer will be freed by user thread */
>                 if (server->large_buf)
>                         server->bigbuf =3D NULL;
>                 else
>                         server->smallbuf =3D NULL;
>         }
> -       dequeue_mid(mid, malformed);
> +       dequeue_mid(smb, malformed);
>  }
>
>  int
> @@ -1093,28 +1093,28 @@ clean_demultiplex_info(struct TCP_Server_Info *se=
rver)
>         }
>
>         if (!list_empty(&server->pending_mid_q)) {
> -               struct mid_q_entry *mid_entry;
> +               struct smb_message *smb;
>                 struct list_head *tmp, *tmp2;
>                 LIST_HEAD(dispose_list);
>
>                 spin_lock(&server->mid_queue_lock);
>                 list_for_each_safe(tmp, tmp2, &server->pending_mid_q) {
> -                       mid_entry =3D list_entry(tmp, struct mid_q_entry,=
 qhead);
> -                       cifs_dbg(FYI, "Clearing mid %llu\n", mid_entry->m=
id);
> -                       kref_get(&mid_entry->refcount);
> -                       mid_entry->mid_state =3D MID_SHUTDOWN;
> -                       list_move(&mid_entry->qhead, &dispose_list);
> -                       mid_entry->deleted_from_q =3D true;
> +                       smb =3D list_entry(tmp, struct smb_message, qhead=
);
> +                       cifs_dbg(FYI, "Clearing mid %llu\n", smb->mid);
> +                       kref_get(&smb->refcount);
> +                       smb->mid_state =3D MID_SHUTDOWN;
> +                       list_move(&smb->qhead, &dispose_list);
> +                       smb->deleted_from_q =3D true;
>                 }
>                 spin_unlock(&server->mid_queue_lock);
>
>                 /* now walk dispose list and issue callbacks */
>                 list_for_each_safe(tmp, tmp2, &dispose_list) {
> -                       mid_entry =3D list_entry(tmp, struct mid_q_entry,=
 qhead);
> -                       cifs_dbg(FYI, "Callback mid %llu\n", mid_entry->m=
id);
> -                       list_del_init(&mid_entry->qhead);
> -                       mid_execute_callback(mid_entry);
> -                       release_mid(mid_entry);
> +                       smb =3D list_entry(tmp, struct smb_message, qhead=
);
> +                       cifs_dbg(FYI, "Callback mid %llu\n", smb->mid);
> +                       list_del_init(&smb->qhead);
> +                       mid_execute_callback(smb);
> +                       release_mid(smb);
>                 }
>                 /* 1/8th of sec is more than enough time for them to exit=
 */
>                 msleep(125);
> @@ -1148,7 +1148,7 @@ clean_demultiplex_info(struct TCP_Server_Info *serv=
er)
>  }
>
>  static int
> -standard_receive3(struct TCP_Server_Info *server, struct mid_q_entry *mi=
d)
> +standard_receive3(struct TCP_Server_Info *server, struct smb_message *sm=
b)
>  {
>         int length;
>         char *buf =3D server->smallbuf;
> @@ -1179,11 +1179,11 @@ standard_receive3(struct TCP_Server_Info *server,=
 struct mid_q_entry *mid)
>
>         dump_smb(buf, server->total_read);
>
> -       return cifs_handle_standard(server, mid);
> +       return cifs_handle_standard(server, smb);
>  }
>
>  int
> -cifs_handle_standard(struct TCP_Server_Info *server, struct mid_q_entry =
*mid)
> +cifs_handle_standard(struct TCP_Server_Info *server, struct smb_message =
*smb)
>  {
>         char *buf =3D server->large_buf ? server->bigbuf : server->smallb=
uf;
>         int rc;
> @@ -1211,10 +1211,10 @@ cifs_handle_standard(struct TCP_Server_Info *serv=
er, struct mid_q_entry *mid)
>             server->ops->is_status_pending(buf, server))
>                 return -1;
>
> -       if (!mid)
> +       if (!smb)
>                 return rc;
>
> -       handle_mid(mid, server, buf, rc);
> +       handle_mid(smb, server, buf, rc);
>         return 0;
>  }
>
> @@ -1251,13 +1251,13 @@ smb2_add_credits_from_hdr(char *buffer, struct TC=
P_Server_Info *server)
>  static int
>  cifs_demultiplex_thread(void *p)
>  {
> -       int i, num_mids, length;
> +       int i, num_smbs, length;
>         struct TCP_Server_Info *server =3D p;
>         unsigned int pdu_length;
>         unsigned int next_offset;
>         char *buf =3D NULL;
>         struct task_struct *task_to_wake =3D NULL;
> -       struct mid_q_entry *mids[MAX_COMPOUND];
> +       struct smb_message *smbs[MAX_COMPOUND];
>         char *bufs[MAX_COMPOUND];
>         unsigned int noreclaim_flag, num_io_timeout =3D 0;
>         bool pending_reconnect =3D false;
> @@ -1332,32 +1332,32 @@ cifs_demultiplex_thread(void *p)
>                                 server->pdu_size =3D next_offset;
>                 }
>
> -               memset(mids, 0, sizeof(mids));
> +               memset(smbs, 0, sizeof(smbs));
>                 memset(bufs, 0, sizeof(bufs));
> -               num_mids =3D 0;
> +               num_smbs =3D 0;
>
>                 if (server->ops->is_transform_hdr &&
>                     server->ops->receive_transform &&
>                     server->ops->is_transform_hdr(buf)) {
>                         length =3D server->ops->receive_transform(server,
> -                                                               mids,
> +                                                               smbs,
>                                                                 bufs,
> -                                                               &num_mids=
);
> +                                                               &num_smbs=
);
>                 } else {
> -                       mids[0] =3D server->ops->find_mid(server, buf);
> +                       smbs[0] =3D server->ops->find_mid(server, buf);
>                         bufs[0] =3D buf;
> -                       num_mids =3D 1;
> +                       num_smbs =3D 1;
>
> -                       if (!mids[0] || !mids[0]->receive)
> -                               length =3D standard_receive3(server, mids=
[0]);
> +                       if (!smbs[0] || !smbs[0]->receive)
> +                               length =3D standard_receive3(server, smbs=
[0]);
>                         else
> -                               length =3D mids[0]->receive(server, mids[=
0]);
> +                               length =3D smbs[0]->receive(server, smbs[=
0]);
>                 }
>
>                 if (length < 0) {
> -                       for (i =3D 0; i < num_mids; i++)
> -                               if (mids[i])
> -                                       release_mid(mids[i]);
> +                       for (i =3D 0; i < num_smbs; i++)
> +                               if (smbs[i])
> +                                       release_mid(smbs[i]);
>                         continue;
>                 }
>
> @@ -1376,9 +1376,9 @@ cifs_demultiplex_thread(void *p)
>
>                 server->lstrp =3D jiffies;
>
> -               for (i =3D 0; i < num_mids; i++) {
> -                       if (mids[i] !=3D NULL) {
> -                               mids[i]->resp_buf_size =3D server->pdu_si=
ze;
> +               for (i =3D 0; i < num_smbs; i++) {
> +                       if (smbs[i] !=3D NULL) {
> +                               smbs[i]->resp_buf_size =3D server->pdu_si=
ze;
>
>                                 if (bufs[i] !=3D NULL) {
>                                         if (server->ops->is_network_name_=
deleted &&
> @@ -1389,10 +1389,10 @@ cifs_demultiplex_thread(void *p)
>                                         }
>                                 }
>
> -                               if (!mids[i]->multiRsp || mids[i]->multiE=
nd)
> -                                       mid_execute_callback(mids[i]);
> +                               if (!smbs[i]->multiRsp || smbs[i]->multiE=
nd)
> +                                       mid_execute_callback(smbs[i]);
>
> -                               release_mid(mids[i]);
> +                               release_mid(smbs[i]);
>                         } else if (server->ops->is_oplock_break &&
>                                    server->ops->is_oplock_break(bufs[i],
>                                                                 server)) =
{
> diff --git a/fs/smb/client/netmisc.c b/fs/smb/client/netmisc.c
> index 9ec20601cee2..b34d2b91cf5a 100644
> --- a/fs/smb/client/netmisc.c
> +++ b/fs/smb/client/netmisc.c
> @@ -889,22 +889,22 @@ map_smb_to_linux_error(char *buf, bool logErr)
>  }
>
>  int
> -map_and_check_smb_error(struct mid_q_entry *mid, bool logErr)
> +map_and_check_smb_error(struct smb_message *smb, bool logErr)
>  {
>         int rc;
> -       struct smb_hdr *smb =3D (struct smb_hdr *)mid->resp_buf;
> +       struct smb_hdr *rhdr =3D (struct smb_hdr *)smb->resp_buf;
>
> -       rc =3D map_smb_to_linux_error((char *)smb, logErr);
> -       if (rc =3D=3D -EACCES && !(smb->Flags2 & SMBFLG2_ERR_STATUS)) {
> +       rc =3D map_smb_to_linux_error((char *)rhdr, logErr);
> +       if (rc =3D=3D -EACCES && !(rhdr->Flags2 & SMBFLG2_ERR_STATUS)) {
>                 /* possible ERRBaduid */
> -               __u8 class =3D smb->Status.DosError.ErrorClass;
> -               __u16 code =3D le16_to_cpu(smb->Status.DosError.Error);
> +               __u8 class =3D rhdr->Status.DosError.ErrorClass;
> +               __u16 code =3D le16_to_cpu(rhdr->Status.DosError.Error);
>
>                 /* switch can be used to handle different errors */
>                 if (class =3D=3D ERRSRV && code =3D=3D ERRbaduid) {
>                         cifs_dbg(FYI, "Server returned 0x%x, reconnecting=
 session...\n",
>                                 code);
> -                       cifs_signal_cifsd_for_reconnect(mid->server, fals=
e);
> +                       cifs_signal_cifsd_for_reconnect(smb->server, fals=
e);
>                 }
>         }
>
> diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
> index a15ebd3f0d50..b652833f04d7 100644
> --- a/fs/smb/client/smb1ops.c
> +++ b/fs/smb/client/smb1ops.c
> @@ -30,7 +30,7 @@
>   */
>  static int
>  send_nt_cancel(struct TCP_Server_Info *server, struct smb_rqst *rqst,
> -              struct mid_q_entry *mid)
> +              struct smb_message *smb)
>  {
>         int rc =3D 0;
>         struct smb_hdr *in_buf =3D (struct smb_hdr *)rqst->rq_iov[0].iov_=
base;
> @@ -42,7 +42,7 @@ send_nt_cancel(struct TCP_Server_Info *server, struct s=
mb_rqst *rqst,
>         put_bcc(0, in_buf);
>
>         cifs_server_lock(server);
> -       rc =3D cifs_sign_smb(in_buf, server, &mid->sequence_number);
> +       rc =3D cifs_sign_smb(in_buf, server, &smb->sequence_number);
>         if (rc) {
>                 cifs_server_unlock(server);
>                 return rc;
> @@ -89,20 +89,20 @@ cifs_read_data_length(char *buf, bool in_remaining)
>                le16_to_cpu(rsp->DataLength);
>  }
>
> -static struct mid_q_entry *
> +static struct smb_message *
>  cifs_find_mid(struct TCP_Server_Info *server, char *buffer)
>  {
>         struct smb_hdr *buf =3D (struct smb_hdr *)buffer;
> -       struct mid_q_entry *mid;
> +       struct smb_message *smb;
>
>         spin_lock(&server->mid_queue_lock);
> -       list_for_each_entry(mid, &server->pending_mid_q, qhead) {
> -               if (compare_mid(mid->mid, buf) &&
> -                   mid->mid_state =3D=3D MID_REQUEST_SUBMITTED &&
> -                   le16_to_cpu(mid->command) =3D=3D buf->Command) {
> -                       kref_get(&mid->refcount);
> +       list_for_each_entry(smb, &server->pending_mid_q, qhead) {
> +               if (compare_mid(smb->mid, buf) &&
> +                   smb->mid_state =3D=3D MID_REQUEST_SUBMITTED &&
> +                   le16_to_cpu(smb->command) =3D=3D buf->Command) {
> +                       kref_get(&smb->refcount);
>                         spin_unlock(&server->mid_queue_lock);
> -                       return mid;
> +                       return smb;
>                 }
>         }
>         spin_unlock(&server->mid_queue_lock);
> @@ -136,7 +136,7 @@ cifs_get_credits_field(struct TCP_Server_Info *server=
, const int optype)
>  }
>
>  static unsigned int
> -cifs_get_credits(struct mid_q_entry *mid)
> +cifs_get_credits(struct smb_message *smb)
>  {
>         return 1;
>  }
> @@ -189,7 +189,7 @@ cifs_get_next_mid(struct TCP_Server_Info *server)
>          * did not time out).
>          */
>         while (cur_mid !=3D last_mid) {
> -               struct mid_q_entry *mid_entry;
> +               struct smb_message *smb;
>                 unsigned int num_mids;
>
>                 collision =3D false;
> @@ -198,10 +198,10 @@ cifs_get_next_mid(struct TCP_Server_Info *server)
>
>                 num_mids =3D 0;
>                 spin_lock(&server->mid_queue_lock);
> -               list_for_each_entry(mid_entry, &server->pending_mid_q, qh=
ead) {
> +               list_for_each_entry(smb, &server->pending_mid_q, qhead) {
>                         ++num_mids;
> -                       if (mid_entry->mid =3D=3D cur_mid &&
> -                           mid_entry->mid_state =3D=3D MID_REQUEST_SUBMI=
TTED) {
> +                       if (smb->mid =3D=3D cur_mid &&
> +                           smb->mid_state =3D=3D MID_REQUEST_SUBMITTED) =
{
>                                 /* This mid is in use, try a different on=
e */
>                                 collision =3D true;
>                                 break;
> @@ -387,22 +387,22 @@ cifs_downgrade_oplock(struct TCP_Server_Info *serve=
r,
>  }
>
>  static bool
> -cifs_check_trans2(struct mid_q_entry *mid, struct TCP_Server_Info *serve=
r,
> +cifs_check_trans2(struct smb_message *smb, struct TCP_Server_Info *serve=
r,
>                   char *buf, int malformed)
>  {
>         if (malformed)
>                 return false;
>         if (check2ndT2(buf) <=3D 0)
>                 return false;
> -       mid->multiRsp =3D true;
> -       if (mid->resp_buf) {
> +       smb->multiRsp =3D true;
> +       if (smb->resp_buf) {
>                 /* merge response - fix up 1st*/
> -               malformed =3D coalesce_t2(buf, mid->resp_buf);
> +               malformed =3D coalesce_t2(buf, smb->resp_buf);
>                 if (malformed > 0)
>                         return true;
>                 /* All parts received or packet is malformed. */
> -               mid->multiEnd =3D true;
> -               dequeue_mid(mid, malformed);
> +               smb->multiEnd =3D true;
> +               dequeue_mid(smb, malformed);
>                 return true;
>         }
>         if (!server->large_buf) {
> @@ -410,8 +410,8 @@ cifs_check_trans2(struct mid_q_entry *mid, struct TCP=
_Server_Info *server,
>                 cifs_dbg(VFS, "1st trans2 resp needs bigbuf\n");
>         } else {
>                 /* Have first buffer */
> -               mid->resp_buf =3D buf;
> -               mid->large_buf =3D true;
> +               smb->resp_buf =3D buf;
> +               smb->large_buf =3D true;
>                 server->bigbuf =3D NULL;
>         }
>         return true;
> diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
> index 96bfe4c63ccf..f0eb25033d72 100644
> --- a/fs/smb/client/smb2misc.c
> +++ b/fs/smb/client/smb2misc.c
> @@ -851,14 +851,14 @@ smb2_handle_cancelled_close(struct cifs_tcon *tcon,=
 __u64 persistent_fid,
>  }
>
>  int
> -smb2_handle_cancelled_mid(struct mid_q_entry *mid, struct TCP_Server_Inf=
o *server)
> +smb2_handle_cancelled_mid(struct smb_message *smb, struct TCP_Server_Inf=
o *server)
>  {
> -       struct smb2_hdr *hdr =3D mid->resp_buf;
> -       struct smb2_create_rsp *rsp =3D mid->resp_buf;
> +       struct smb2_hdr *hdr =3D smb->resp_buf;
> +       struct smb2_create_rsp *rsp =3D smb->resp_buf;
>         struct cifs_tcon *tcon;
>         int rc;
>
> -       if ((mid->optype & CIFS_CP_CREATE_CLOSE_OP) || hdr->Command !=3D =
SMB2_CREATE ||
> +       if ((smb->optype & CIFS_CP_CREATE_CLOSE_OP) || hdr->Command !=3D =
SMB2_CREATE ||
>             hdr->Status !=3D STATUS_SUCCESS)
>                 return 0;
>
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index 7ace6d4d305b..ba942beb2b56 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -226,9 +226,9 @@ smb2_get_credits_field(struct TCP_Server_Info *server=
, const int optype)
>  }
>
>  static unsigned int
> -smb2_get_credits(struct mid_q_entry *mid)
> +smb2_get_credits(struct smb_message *smb)
>  {
> -       return mid->credits_received;
> +       return smb->credits_received;
>  }
>
>  static int
> @@ -389,10 +389,10 @@ smb2_revert_current_mid(struct TCP_Server_Info *ser=
ver, const unsigned int val)
>         spin_unlock(&server->mid_counter_lock);
>  }
>
> -static struct mid_q_entry *
> +static struct smb_message *
>  __smb2_find_mid(struct TCP_Server_Info *server, char *buf, bool dequeue)
>  {
> -       struct mid_q_entry *mid;
> +       struct smb_message *smb;
>         struct smb2_hdr *shdr =3D (struct smb2_hdr *)buf;
>         __u64 wire_mid =3D le64_to_cpu(shdr->MessageId);
>
> @@ -402,30 +402,30 @@ __smb2_find_mid(struct TCP_Server_Info *server, cha=
r *buf, bool dequeue)
>         }
>
>         spin_lock(&server->mid_queue_lock);
> -       list_for_each_entry(mid, &server->pending_mid_q, qhead) {
> -               if ((mid->mid =3D=3D wire_mid) &&
> -                   (mid->mid_state =3D=3D MID_REQUEST_SUBMITTED) &&
> -                   (mid->command =3D=3D shdr->Command)) {
> -                       kref_get(&mid->refcount);
> +       list_for_each_entry(smb, &server->pending_mid_q, qhead) {
> +               if ((smb->mid =3D=3D wire_mid) &&
> +                   (smb->mid_state =3D=3D MID_REQUEST_SUBMITTED) &&
> +                   (smb->command =3D=3D shdr->Command)) {
> +                       kref_get(&smb->refcount);
>                         if (dequeue) {
> -                               list_del_init(&mid->qhead);
> -                               mid->deleted_from_q =3D true;
> +                               list_del_init(&smb->qhead);
> +                               smb->deleted_from_q =3D true;
>                         }
>                         spin_unlock(&server->mid_queue_lock);
> -                       return mid;
> +                       return smb;
>                 }
>         }
>         spin_unlock(&server->mid_queue_lock);
>         return NULL;
>  }
>
> -static struct mid_q_entry *
> +static struct smb_message *
>  smb2_find_mid(struct TCP_Server_Info *server, char *buf)
>  {
>         return __smb2_find_mid(server, buf, false);
>  }
>
> -static struct mid_q_entry *
> +static struct smb_message *
>  smb2_find_dequeue_mid(struct TCP_Server_Info *server, char *buf)
>  {
>         return __smb2_find_mid(server, buf, true);
> @@ -4667,7 +4667,7 @@ cifs_copy_folioq_to_iter(struct folio_queue *folioq=
, size_t data_size,
>  }
>
>  static int
> -handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid=
,
> +handle_read_data(struct TCP_Server_Info *server, struct smb_message *smb=
,
>                  char *buf, unsigned int buf_len, struct folio_queue *buf=
fer,
>                  unsigned int buffer_len, bool is_offloaded)
>  {
> @@ -4676,7 +4676,7 @@ handle_read_data(struct TCP_Server_Info *server, st=
ruct mid_q_entry *mid,
>         unsigned int cur_off;
>         unsigned int cur_page_idx;
>         unsigned int pad_len;
> -       struct cifs_io_subrequest *rdata =3D mid->callback_data;
> +       struct cifs_io_subrequest *rdata =3D smb->callback_data;
>         struct smb2_hdr *shdr =3D (struct smb2_hdr *)buf;
>         size_t copied;
>         bool use_rdma_mr =3D false;
> @@ -4714,9 +4714,9 @@ handle_read_data(struct TCP_Server_Info *server, st=
ruct mid_q_entry *mid,
>                          __func__, rdata->result);
>                 /* normal error on read response */
>                 if (is_offloaded)
> -                       mid->mid_state =3D MID_RESPONSE_RECEIVED;
> +                       smb->mid_state =3D MID_RESPONSE_RECEIVED;
>                 else
> -                       dequeue_mid(mid, false);
> +                       dequeue_mid(smb, false);
>                 return 0;
>         }
>
> @@ -4741,9 +4741,9 @@ handle_read_data(struct TCP_Server_Info *server, st=
ruct mid_q_entry *mid,
>                          __func__, data_offset);
>                 rdata->result =3D -EIO;
>                 if (is_offloaded)
> -                       mid->mid_state =3D MID_RESPONSE_MALFORMED;
> +                       smb->mid_state =3D MID_RESPONSE_MALFORMED;
>                 else
> -                       dequeue_mid(mid, rdata->result);
> +                       dequeue_mid(smb, rdata->result);
>                 return 0;
>         }
>
> @@ -4760,9 +4760,9 @@ handle_read_data(struct TCP_Server_Info *server, st=
ruct mid_q_entry *mid,
>                                  __func__, data_offset);
>                         rdata->result =3D -EIO;
>                         if (is_offloaded)
> -                               mid->mid_state =3D MID_RESPONSE_MALFORMED=
;
> +                               smb->mid_state =3D MID_RESPONSE_MALFORMED=
;
>                         else
> -                               dequeue_mid(mid, rdata->result);
> +                               dequeue_mid(smb, rdata->result);
>                         return 0;
>                 }
>
> @@ -4770,9 +4770,9 @@ handle_read_data(struct TCP_Server_Info *server, st=
ruct mid_q_entry *mid,
>                         /* data_len is corrupt -- discard frame */
>                         rdata->result =3D -EIO;
>                         if (is_offloaded)
> -                               mid->mid_state =3D MID_RESPONSE_MALFORMED=
;
> +                               smb->mid_state =3D MID_RESPONSE_MALFORMED=
;
>                         else
> -                               dequeue_mid(mid, rdata->result);
> +                               dequeue_mid(smb, rdata->result);
>                         return 0;
>                 }
>
> @@ -4781,9 +4781,9 @@ handle_read_data(struct TCP_Server_Info *server, st=
ruct mid_q_entry *mid,
>                                                          cur_off, &rdata-=
>subreq.io_iter);
>                 if (rdata->result !=3D 0) {
>                         if (is_offloaded)
> -                               mid->mid_state =3D MID_RESPONSE_MALFORMED=
;
> +                               smb->mid_state =3D MID_RESPONSE_MALFORMED=
;
>                         else
> -                               dequeue_mid(mid, rdata->result);
> +                               dequeue_mid(smb, rdata->result);
>                         return 0;
>                 }
>                 rdata->got_bytes =3D buffer_len;
> @@ -4800,16 +4800,16 @@ handle_read_data(struct TCP_Server_Info *server, =
struct mid_q_entry *mid,
>                 WARN_ONCE(1, "buf can not contain only a part of read dat=
a");
>                 rdata->result =3D -EIO;
>                 if (is_offloaded)
> -                       mid->mid_state =3D MID_RESPONSE_MALFORMED;
> +                       smb->mid_state =3D MID_RESPONSE_MALFORMED;
>                 else
> -                       dequeue_mid(mid, rdata->result);
> +                       dequeue_mid(smb, rdata->result);
>                 return 0;
>         }
>
>         if (is_offloaded)
> -               mid->mid_state =3D MID_RESPONSE_RECEIVED;
> +               smb->mid_state =3D MID_RESPONSE_RECEIVED;
>         else
> -               dequeue_mid(mid, false);
> +               dequeue_mid(smb, false);
>         return 0;
>  }
>
> @@ -4827,7 +4827,7 @@ static void smb2_decrypt_offload(struct work_struct=
 *work)
>         struct smb2_decrypt_work *dw =3D container_of(work,
>                                 struct smb2_decrypt_work, decrypt);
>         int rc;
> -       struct mid_q_entry *mid;
> +       struct smb_message *smb;
>         struct iov_iter iter;
>
>         iov_iter_folio_queue(&iter, ITER_DEST, dw->buffer, 0, 0, dw->len)=
;
> @@ -4839,43 +4839,43 @@ static void smb2_decrypt_offload(struct work_stru=
ct *work)
>         }
>
>         dw->server->lstrp =3D jiffies;
> -       mid =3D smb2_find_dequeue_mid(dw->server, dw->buf);
> -       if (mid =3D=3D NULL)
> +       smb =3D smb2_find_dequeue_mid(dw->server, dw->buf);
> +       if (smb =3D=3D NULL)
>                 cifs_dbg(FYI, "mid not found\n");
>         else {
> -               mid->decrypted =3D true;
> -               rc =3D handle_read_data(dw->server, mid, dw->buf,
> +               smb->decrypted =3D true;
> +               rc =3D handle_read_data(dw->server, smb, dw->buf,
>                                       dw->server->vals->read_rsp_size,
>                                       dw->buffer, dw->len,
>                                       true);
>                 if (rc >=3D 0) {
>  #ifdef CONFIG_CIFS_STATS2
> -                       mid->when_received =3D jiffies;
> +                       smb->when_received =3D jiffies;
>  #endif
>                         if (dw->server->ops->is_network_name_deleted)
>                                 dw->server->ops->is_network_name_deleted(=
dw->buf,
>                                                                          =
dw->server);
>
> -                       mid_execute_callback(mid);
> +                       mid_execute_callback(smb);
>                 } else {
>                         spin_lock(&dw->server->srv_lock);
>                         if (dw->server->tcpStatus =3D=3D CifsNeedReconnec=
t) {
>                                 spin_lock(&dw->server->mid_queue_lock);
> -                               mid->mid_state =3D MID_RETRY_NEEDED;
> +                               smb->mid_state =3D MID_RETRY_NEEDED;
>                                 spin_unlock(&dw->server->mid_queue_lock);
>                                 spin_unlock(&dw->server->srv_lock);
> -                               mid_execute_callback(mid);
> +                               mid_execute_callback(smb);
>                         } else {
>                                 spin_lock(&dw->server->mid_queue_lock);
> -                               mid->mid_state =3D MID_REQUEST_SUBMITTED;
> -                               mid->deleted_from_q =3D false;
> -                               list_add_tail(&mid->qhead,
> +                               smb->mid_state =3D MID_REQUEST_SUBMITTED;
> +                               smb->deleted_from_q =3D false;
> +                               list_add_tail(&smb->qhead,
>                                         &dw->server->pending_mid_q);
>                                 spin_unlock(&dw->server->mid_queue_lock);
>                                 spin_unlock(&dw->server->srv_lock);
>                         }
>                 }
> -               release_mid(mid);
> +               release_mid(smb);
>         }
>
>  free_pages:
> @@ -4886,7 +4886,7 @@ static void smb2_decrypt_offload(struct work_struct=
 *work)
>
>
>  static int
> -receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entr=
y **mid,
> +receive_encrypted_read(struct TCP_Server_Info *server, struct smb_messag=
e **smb,
>                        int *num_mids)
>  {
>         char *buf =3D server->smallbuf;
> @@ -4962,13 +4962,13 @@ receive_encrypted_read(struct TCP_Server_Info *se=
rver, struct mid_q_entry **mid,
>         if (rc)
>                 goto free_pages;
>
> -       *mid =3D smb2_find_mid(server, buf);
> -       if (*mid =3D=3D NULL) {
> +       *smb =3D smb2_find_mid(server, buf);
> +       if (*smb =3D=3D NULL) {
>                 cifs_dbg(FYI, "mid not found\n");
>         } else {
>                 cifs_dbg(FYI, "mid found\n");
> -               (*mid)->decrypted =3D true;
> -               rc =3D handle_read_data(server, *mid, buf,
> +               (*smb)->decrypted =3D true;
> +               rc =3D handle_read_data(server, *smb, buf,
>                                       server->vals->read_rsp_size,
>                                       dw->buffer, dw->len, false);
>                 if (rc >=3D 0) {
> @@ -4991,7 +4991,7 @@ receive_encrypted_read(struct TCP_Server_Info *serv=
er, struct mid_q_entry **mid,
>
>  static int
>  receive_encrypted_standard(struct TCP_Server_Info *server,
> -                          struct mid_q_entry **mids, char **bufs,
> +                          struct smb_message **mids, char **bufs,
>                            int *num_mids)
>  {
>         int ret, length;
> @@ -5000,7 +5000,7 @@ receive_encrypted_standard(struct TCP_Server_Info *=
server,
>         unsigned int pdu_length =3D server->pdu_size;
>         unsigned int buf_size;
>         unsigned int next_cmd;
> -       struct mid_q_entry *mid_entry;
> +       struct smb_message *smb;
>         int next_is_large;
>         char *next_buffer =3D NULL;
>
> @@ -5043,13 +5043,13 @@ receive_encrypted_standard(struct TCP_Server_Info=
 *server,
>                 memcpy(next_buffer, buf + next_cmd, pdu_length - next_cmd=
);
>         }
>
> -       mid_entry =3D smb2_find_mid(server, buf);
> -       if (mid_entry =3D=3D NULL)
> +       smb =3D smb2_find_mid(server, buf);
> +       if (smb =3D=3D NULL)
>                 cifs_dbg(FYI, "mid not found\n");
>         else {
>                 cifs_dbg(FYI, "mid found\n");
> -               mid_entry->decrypted =3D true;
> -               mid_entry->resp_buf_size =3D server->pdu_size;
> +               smb->decrypted =3D true;
> +               smb->resp_buf_size =3D server->pdu_size;
>         }
>
>         if (*num_mids >=3D MAX_COMPOUND) {
> @@ -5057,12 +5057,12 @@ receive_encrypted_standard(struct TCP_Server_Info=
 *server,
>                 return -1;
>         }
>         bufs[*num_mids] =3D buf;
> -       mids[(*num_mids)++] =3D mid_entry;
> +       mids[(*num_mids)++] =3D smb;
>
> -       if (mid_entry && mid_entry->handle)
> -               ret =3D mid_entry->handle(server, mid_entry);
> +       if (smb && smb->handle)
> +               ret =3D smb->handle(server, smb);
>         else
> -               ret =3D cifs_handle_standard(server, mid_entry);
> +               ret =3D cifs_handle_standard(server, smb);
>
>         if (ret =3D=3D 0 && next_cmd) {
>                 pdu_length -=3D next_cmd;
> @@ -5090,7 +5090,7 @@ receive_encrypted_standard(struct TCP_Server_Info *=
server,
>
>  static int
>  smb3_receive_transform(struct TCP_Server_Info *server,
> -                      struct mid_q_entry **mids, char **bufs, int *num_m=
ids)
> +                      struct smb_message **mids, char **bufs, int *num_m=
ids)
>  {
>         char *buf =3D server->smallbuf;
>         unsigned int pdu_length =3D server->pdu_size;
> @@ -5120,11 +5120,11 @@ smb3_receive_transform(struct TCP_Server_Info *se=
rver,
>  }
>
>  int
> -smb3_handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry=
 *mid)
> +smb3_handle_read_data(struct TCP_Server_Info *server, struct smb_message=
 *smb)
>  {
>         char *buf =3D server->large_buf ? server->bigbuf : server->smallb=
uf;
>
> -       return handle_read_data(server, mid, buf, server->pdu_size,
> +       return handle_read_data(server, smb, buf, server->pdu_size,
>                                 NULL, 0, false);
>  }
>
> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index ef2c6ac500f7..18c7f94d5c74 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -4091,19 +4091,19 @@ SMB2_change_notify(const unsigned int xid, struct=
 cifs_tcon *tcon,
>   * FIXME: maybe we should consider checking that the reply matches reque=
st?
>   */
>  static void
> -smb2_echo_callback(struct mid_q_entry *mid)
> +smb2_echo_callback(struct smb_message *smb)
>  {
> -       struct TCP_Server_Info *server =3D mid->callback_data;
> -       struct smb2_echo_rsp *rsp =3D (struct smb2_echo_rsp *)mid->resp_b=
uf;
> +       struct TCP_Server_Info *server =3D smb->callback_data;
> +       struct smb2_echo_rsp *rsp =3D (struct smb2_echo_rsp *)smb->resp_b=
uf;
>         struct cifs_credits credits =3D { .value =3D 0, .instance =3D 0 }=
;
>
> -       if (mid->mid_state =3D=3D MID_RESPONSE_RECEIVED
> -           || mid->mid_state =3D=3D MID_RESPONSE_MALFORMED) {
> +       if (smb->mid_state =3D=3D MID_RESPONSE_RECEIVED
> +           || smb->mid_state =3D=3D MID_RESPONSE_MALFORMED) {
>                 credits.value =3D le16_to_cpu(rsp->hdr.CreditRequest);
>                 credits.instance =3D server->reconnect_instance;
>         }
>
> -       release_mid(mid);
> +       release_mid(smb);
>         add_credits(server, &credits, CIFS_ECHO_OP);
>  }
>
> @@ -4518,14 +4518,13 @@ smb2_new_read_req(void **buf, unsigned int *total=
_len,
>  }
>
>  static void
> -smb2_readv_callback(struct mid_q_entry *mid)
> +smb2_readv_callback(struct smb_message *smb)
>  {
> -       struct cifs_io_subrequest *rdata =3D mid->callback_data;
> +       struct cifs_io_subrequest *rdata =3D smb->callback_data;
>         struct netfs_inode *ictx =3D netfs_inode(rdata->rreq->inode);
>         struct cifs_tcon *tcon =3D tlink_tcon(rdata->req->cfile->tlink);
>         struct TCP_Server_Info *server =3D rdata->server;
> -       struct smb2_hdr *shdr =3D
> -                               (struct smb2_hdr *)rdata->iov[0].iov_base=
;
> +       struct smb2_hdr *shdr =3D (struct smb2_hdr *)rdata->iov[0].iov_ba=
se;
>         struct cifs_credits credits =3D {
>                 .value =3D 0,
>                 .instance =3D 0,
> @@ -4540,20 +4539,20 @@ smb2_readv_callback(struct mid_q_entry *mid)
>                 rqst.rq_iter      =3D rdata->subreq.io_iter;
>         }
>
> -       WARN_ONCE(rdata->server !=3D mid->server,
> +       WARN_ONCE(rdata->server !=3D smb->server,
>                   "rdata server %p !=3D mid server %p",
> -                 rdata->server, mid->server);
> +                 rdata->server, smb->server);
>
>         cifs_dbg(FYI, "%s: mid=3D%llu state=3D%d result=3D%d bytes=3D%zu/=
%zu\n",
> -                __func__, mid->mid, mid->mid_state, rdata->result,
> +                __func__, smb->mid, smb->mid_state, rdata->result,
>                  rdata->got_bytes, rdata->subreq.len - rdata->subreq.tran=
sferred);
>
> -       switch (mid->mid_state) {
> +       switch (smb->mid_state) {
>         case MID_RESPONSE_RECEIVED:
>                 credits.value =3D le16_to_cpu(shdr->CreditRequest);
>                 credits.instance =3D server->reconnect_instance;
>                 /* result already set, check signature */
> -               if (server->sign && !mid->decrypted) {
> +               if (server->sign && !smb->decrypted) {
>                         int rc;
>
>                         iov_iter_truncate(&rqst.rq_iter, rdata->got_bytes=
);
> @@ -4643,7 +4642,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
>         rdata->subreq.transferred +=3D rdata->got_bytes;
>         trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
>         netfs_read_subreq_terminated(&rdata->subreq);
> -       release_mid(mid);
> +       release_mid(smb);
>         trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
>                               server->credits, server->in_flight,
>                               credits.value, cifs_trace_rw_credits_read_r=
esponse_add);
> @@ -4820,12 +4819,12 @@ SMB2_read(const unsigned int xid, struct cifs_io_=
parms *io_parms,
>   * workqueue completion task.
>   */
>  static void
> -smb2_writev_callback(struct mid_q_entry *mid)
> +smb2_writev_callback(struct smb_message *smb)
>  {
> -       struct cifs_io_subrequest *wdata =3D mid->callback_data;
> +       struct cifs_io_subrequest *wdata =3D smb->callback_data;
>         struct cifs_tcon *tcon =3D tlink_tcon(wdata->req->cfile->tlink);
>         struct TCP_Server_Info *server =3D wdata->server;
> -       struct smb2_write_rsp *rsp =3D (struct smb2_write_rsp *)mid->resp=
_buf;
> +       struct smb2_write_rsp *rsp =3D (struct smb2_write_rsp *)smb->resp=
_buf;
>         struct cifs_credits credits =3D {
>                 .value =3D 0,
>                 .instance =3D 0,
> @@ -4837,16 +4836,16 @@ smb2_writev_callback(struct mid_q_entry *mid)
>         ssize_t result =3D 0;
>         size_t written;
>
> -       WARN_ONCE(wdata->server !=3D mid->server,
> +       WARN_ONCE(wdata->server !=3D smb->server,
>                   "wdata server %p !=3D mid server %p",
> -                 wdata->server, mid->server);
> +                 wdata->server, smb->server);
>
> -       switch (mid->mid_state) {
> +       switch (smb->mid_state) {
>         case MID_RESPONSE_RECEIVED:
>                 trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace_io_prog=
ress);
>                 credits.value =3D le16_to_cpu(rsp->hdr.CreditRequest);
>                 credits.instance =3D server->reconnect_instance;
> -               result =3D smb2_check_receive(mid, server, 0);
> +               result =3D smb2_check_receive(smb, server, 0);
>                 if (result !=3D 0) {
>                         trace_netfs_sreq(&wdata->subreq, netfs_sreq_trace=
_io_bad);
>                         break;
> @@ -4929,7 +4928,7 @@ smb2_writev_callback(struct mid_q_entry *mid)
>                               0, cifs_trace_rw_credits_write_response_cle=
ar);
>         wdata->credits.value =3D 0;
>         cifs_write_subrequest_terminated(wdata, result ?: written);
> -       release_mid(mid);
> +       release_mid(smb);
>         trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
>                               server->credits, server->in_flight,
>                               credits.value, cifs_trace_rw_credits_write_=
response_add);
> diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
> index 5241daaae543..ed9ba137e832 100644
> --- a/fs/smb/client/smb2proto.h
> +++ b/fs/smb/client/smb2proto.h
> @@ -30,12 +30,12 @@ extern __le16 *cifs_convert_path_to_utf16(const char =
*from,
>                                           struct cifs_sb_info *cifs_sb);
>
>  extern int smb2_verify_signature(struct smb_rqst *, struct TCP_Server_In=
fo *);
> -extern int smb2_check_receive(struct mid_q_entry *mid,
> +extern int smb2_check_receive(struct smb_message *smb,
>                               struct TCP_Server_Info *server, bool log_er=
ror);
> -extern struct mid_q_entry *smb2_setup_request(struct cifs_ses *ses,
> -                                             struct TCP_Server_Info *,
> -                                             struct smb_rqst *rqst);
> -extern struct mid_q_entry *smb2_setup_async_request(
> +struct smb_message *smb2_setup_request(struct cifs_ses *ses,
> +                                      struct TCP_Server_Info *server,
> +                                      struct smb_rqst *rqst);
> +extern struct smb_message *smb2_setup_async_request(
>                         struct TCP_Server_Info *server, struct smb_rqst *=
rqst);
>  extern struct cifs_tcon *smb2_find_smb_tcon(struct TCP_Server_Info *serv=
er,
>                                                 __u64 ses_id, __u32  tid)=
;
> @@ -44,7 +44,7 @@ extern __le32 smb2_get_lease_state(struct cifsInodeInfo=
 *cinode);
>  extern bool smb2_is_valid_oplock_break(char *buffer,
>                                        struct TCP_Server_Info *srv);
>  extern int smb3_handle_read_data(struct TCP_Server_Info *server,
> -                                struct mid_q_entry *mid);
> +                                struct smb_message *smb);
>  extern int smb2_query_reparse_tag(const unsigned int xid, struct cifs_tc=
on *tcon,
>                                 struct cifs_sb_info *cifs_sb, const char =
*path,
>                                 __u32 *reparse_tag);
> @@ -251,7 +251,7 @@ extern int SMB2_oplock_break(const unsigned int xid, =
struct cifs_tcon *tcon,
>  extern int smb2_handle_cancelled_close(struct cifs_tcon *tcon,
>                                        __u64 persistent_fid,
>                                        __u64 volatile_fid);
> -extern int smb2_handle_cancelled_mid(struct mid_q_entry *mid, struct TCP=
_Server_Info *server);
> +extern int smb2_handle_cancelled_mid(struct smb_message *smb, struct TCP=
_Server_Info *server);
>  void smb2_cancelled_close_fid(struct work_struct *work);
>  extern int SMB311_posix_qfs_info(const unsigned int xid, struct cifs_tco=
n *tcon,
>                          u64 persistent_file_id, u64 volatile_file_id,
> diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.=
c
> index 6a9b80385b86..21b027040643 100644
> --- a/fs/smb/client/smb2transport.c
> +++ b/fs/smb/client/smb2transport.c
> @@ -641,11 +641,11 @@ smb2_seq_num_into_buf(struct TCP_Server_Info *serve=
r,
>                 get_next_mid(server);
>  }
>
> -static struct mid_q_entry *
> +static struct smb_message *
>  smb2_mid_entry_alloc(const struct smb2_hdr *shdr,
>                      struct TCP_Server_Info *server)
>  {
> -       struct mid_q_entry *temp;
> +       struct smb_message *smb;
>         unsigned int credits =3D le16_to_cpu(shdr->CreditCharge);
>
>         if (server =3D=3D NULL) {
> @@ -653,37 +653,37 @@ smb2_mid_entry_alloc(const struct smb2_hdr *shdr,
>                 return NULL;
>         }
>
> -       temp =3D mempool_alloc(cifs_mid_poolp, GFP_NOFS);
> -       memset(temp, 0, sizeof(struct mid_q_entry));
> -       kref_init(&temp->refcount);
> -       spin_lock_init(&temp->mid_lock);
> -       temp->mid =3D le64_to_cpu(shdr->MessageId);
> -       temp->credits =3D credits > 0 ? credits : 1;
> -       temp->pid =3D current->pid;
> -       temp->command =3D shdr->Command; /* Always LE */
> -       temp->when_alloc =3D jiffies;
> -       temp->server =3D server;
> +       smb =3D mempool_alloc(&smb_message_pool, GFP_NOFS);
> +       memset(smb, 0, sizeof(*smb));
> +       kref_init(&smb->refcount);
> +       spin_lock_init(&smb->mid_lock);
> +       smb->mid =3D le64_to_cpu(shdr->MessageId);
> +       smb->credits =3D credits > 0 ? credits : 1;
> +       smb->pid =3D current->pid;
> +       smb->command =3D shdr->Command; /* Always LE */
> +       smb->when_alloc =3D jiffies;
> +       smb->server =3D server;
>
>         /*
>          * The default is for the mid to be synchronous, so the
>          * default callback just wakes up the current task.
>          */
>         get_task_struct(current);
> -       temp->creator =3D current;
> -       temp->callback =3D cifs_wake_up_task;
> -       temp->callback_data =3D current;
> +       smb->creator =3D current;
> +       smb->callback =3D cifs_wake_up_task;
> +       smb->callback_data =3D current;
>
>         atomic_inc(&mid_count);
> -       temp->mid_state =3D MID_REQUEST_ALLOCATED;
> +       smb->mid_state =3D MID_REQUEST_ALLOCATED;
>         trace_smb3_cmd_enter(le32_to_cpu(shdr->Id.SyncId.TreeId),
>                              le64_to_cpu(shdr->SessionId),
> -                            le16_to_cpu(shdr->Command), temp->mid);
> -       return temp;
> +                            le16_to_cpu(shdr->Command), smb->mid);
> +       return smb;
>  }
>
>  static int
>  smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server,
> -                  struct smb2_hdr *shdr, struct mid_q_entry **mid)
> +                  struct smb2_hdr *shdr, struct smb_message **smb)
>  {
>         spin_lock(&server->srv_lock);
>         if (server->tcpStatus =3D=3D CifsExiting) {
> @@ -723,18 +723,18 @@ smb2_get_mid_entry(struct cifs_ses *ses, struct TCP=
_Server_Info *server,
>         }
>         spin_unlock(&ses->ses_lock);
>
> -       *mid =3D smb2_mid_entry_alloc(shdr, server);
> -       if (*mid =3D=3D NULL)
> +       *smb =3D smb2_mid_entry_alloc(shdr, server);
> +       if (*smb =3D=3D NULL)
>                 return -ENOMEM;
>         spin_lock(&server->mid_queue_lock);
> -       list_add_tail(&(*mid)->qhead, &server->pending_mid_q);
> +       list_add_tail(&(*smb)->qhead, &server->pending_mid_q);
>         spin_unlock(&server->mid_queue_lock);
>
>         return 0;
>  }
>
>  int
> -smb2_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *serv=
er,
> +smb2_check_receive(struct smb_message *mid, struct TCP_Server_Info *serv=
er,
>                    bool log_error)
>  {
>         unsigned int len =3D mid->resp_buf_size;
> @@ -759,14 +759,14 @@ smb2_check_receive(struct mid_q_entry *mid, struct =
TCP_Server_Info *server,
>         return map_smb2_to_linux_error(mid->resp_buf, log_error);
>  }
>
> -struct mid_q_entry *
> +struct smb_message *
>  smb2_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *server,
>                    struct smb_rqst *rqst)
>  {
>         int rc;
>         struct smb2_hdr *shdr =3D
>                         (struct smb2_hdr *)rqst->rq_iov[0].iov_base;
> -       struct mid_q_entry *mid;
> +       struct smb_message *mid;
>
>         smb2_seq_num_into_buf(server, shdr);
>
> @@ -786,13 +786,13 @@ smb2_setup_request(struct cifs_ses *ses, struct TCP=
_Server_Info *server,
>         return mid;
>  }
>
> -struct mid_q_entry *
> +struct smb_message *
>  smb2_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst=
 *rqst)
>  {
>         int rc;
>         struct smb2_hdr *shdr =3D
>                         (struct smb2_hdr *)rqst->rq_iov[0].iov_base;
> -       struct mid_q_entry *mid;
> +       struct smb_message *smb;
>
>         spin_lock(&server->srv_lock);
>         if (server->tcpStatus =3D=3D CifsNeedNegotiate &&
> @@ -804,8 +804,8 @@ smb2_setup_async_request(struct TCP_Server_Info *serv=
er, struct smb_rqst *rqst)
>
>         smb2_seq_num_into_buf(server, shdr);
>
> -       mid =3D smb2_mid_entry_alloc(shdr, server);
> -       if (mid =3D=3D NULL) {
> +       smb =3D smb2_mid_entry_alloc(shdr, server);
> +       if (smb =3D=3D NULL) {
>                 revert_current_mid_from_hdr(server, shdr);
>                 return ERR_PTR(-ENOMEM);
>         }
> @@ -813,11 +813,11 @@ smb2_setup_async_request(struct TCP_Server_Info *se=
rver, struct smb_rqst *rqst)
>         rc =3D smb2_sign_rqst(rqst, server);
>         if (rc) {
>                 revert_current_mid_from_hdr(server, shdr);
> -               release_mid(mid);
> +               release_mid(smb);
>                 return ERR_PTR(rc);
>         }
>
> -       return mid;
> +       return smb;
>  }
>
>  int
> diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
> index 915cedde5d66..52083b79609b 100644
> --- a/fs/smb/client/transport.c
> +++ b/fs/smb/client/transport.c
> @@ -32,42 +32,42 @@
>  #include "compress.h"
>
>  void
> -cifs_wake_up_task(struct mid_q_entry *mid)
> +cifs_wake_up_task(struct smb_message *smb)
>  {
> -       if (mid->mid_state =3D=3D MID_RESPONSE_RECEIVED)
> -               mid->mid_state =3D MID_RESPONSE_READY;
> -       wake_up_process(mid->callback_data);
> +       if (smb->mid_state =3D=3D MID_RESPONSE_RECEIVED)
> +               smb->mid_state =3D MID_RESPONSE_READY;
> +       wake_up_process(smb->callback_data);
>  }
>
>  void __release_mid(struct kref *refcount)
>  {
> -       struct mid_q_entry *midEntry =3D
> -                       container_of(refcount, struct mid_q_entry, refcou=
nt);
> +       struct smb_message *smb =3D
> +                       container_of(refcount, struct smb_message, refcou=
nt);
>  #ifdef CONFIG_CIFS_STATS2
> -       __le16 command =3D midEntry->server->vals->lock_cmd;
> -       __u16 smb_cmd =3D le16_to_cpu(midEntry->command);
> +       __le16 command =3D smb->server->vals->lock_cmd;
> +       __u16 smb_cmd =3D le16_to_cpu(smb->command);
>         unsigned long now;
>         unsigned long roundtrip_time;
>  #endif
> -       struct TCP_Server_Info *server =3D midEntry->server;
> +       struct TCP_Server_Info *server =3D smb->server;
>
> -       if (midEntry->resp_buf && (midEntry->wait_cancelled) &&
> -           (midEntry->mid_state =3D=3D MID_RESPONSE_RECEIVED ||
> -            midEntry->mid_state =3D=3D MID_RESPONSE_READY) &&
> +       if (smb->resp_buf && smb->wait_cancelled &&
> +           (smb->mid_state =3D=3D MID_RESPONSE_RECEIVED ||
> +            smb->mid_state =3D=3D MID_RESPONSE_READY) &&
>             server->ops->handle_cancelled_mid)
> -               server->ops->handle_cancelled_mid(midEntry, server);
> +               server->ops->handle_cancelled_mid(smb, server);
>
> -       midEntry->mid_state =3D MID_FREE;
> +       smb->mid_state =3D MID_FREE;
>         atomic_dec(&mid_count);
> -       if (midEntry->large_buf)
> -               cifs_buf_release(midEntry->resp_buf);
> +       if (smb->large_buf)
> +               cifs_buf_release(smb->resp_buf);
>         else
> -               cifs_small_buf_release(midEntry->resp_buf);
> +               cifs_small_buf_release(smb->resp_buf);
>  #ifdef CONFIG_CIFS_STATS2
>         now =3D jiffies;
> -       if (now < midEntry->when_alloc)
> +       if (now < smb->when_alloc)
>                 cifs_server_dbg(VFS, "Invalid mid allocation time\n");
> -       roundtrip_time =3D now - midEntry->when_alloc;
> +       roundtrip_time =3D now - smb->when_alloc;
>
>         if (smb_cmd < NUMBER_OF_SMB2_COMMANDS) {
>                 if (atomic_read(&server->num_cmds[smb_cmd]) =3D=3D 0) {
> @@ -93,8 +93,8 @@ void __release_mid(struct kref *refcount)
>          * checks
>          */
>         if ((slow_rsp_threshold !=3D 0) &&
> -           time_after(now, midEntry->when_alloc + (slow_rsp_threshold * =
HZ)) &&
> -           (midEntry->command !=3D command)) {
> +           time_after(now, smb->when_alloc + (slow_rsp_threshold * HZ)) =
&&
> +           (smb->command !=3D command)) {
>                 /*
>                  * smb2slowcmd[NUMBER_OF_SMB2_COMMANDS] counts by command
>                  * NB: le16_to_cpu returns unsigned so can not be negativ=
e below
> @@ -102,34 +102,35 @@ void __release_mid(struct kref *refcount)
>                 if (smb_cmd < NUMBER_OF_SMB2_COMMANDS)
>                         cifs_stats_inc(&server->smb2slowcmd[smb_cmd]);
>
> -               trace_smb3_slow_rsp(smb_cmd, midEntry->mid, midEntry->pid=
,
> -                              midEntry->when_sent, midEntry->when_receiv=
ed);
> +               trace_smb3_slow_rsp(smb_cmd, smb->mid, smb->pid,
> +                                   smb->when_sent, smb->when_received);
>                 if (cifsFYI & CIFS_TIMER) {
>                         pr_debug("slow rsp: cmd %d mid %llu",
> -                                midEntry->command, midEntry->mid);
> +                                smb->command, smb->mid);
>                         cifs_info("A: 0x%lx S: 0x%lx R: 0x%lx\n",
> -                                 now - midEntry->when_alloc,
> -                                 now - midEntry->when_sent,
> -                                 now - midEntry->when_received);
> +                                 now - smb->when_alloc,
> +                                 now - smb->when_sent,
> +                                 now - smb->when_received);
>                 }
>         }
>  #endif
> -       put_task_struct(midEntry->creator);
> +       put_task_struct(smb->creator);
>
> -       mempool_free(midEntry, cifs_mid_poolp);
> +       mempool_free(smb, &smb_message_pool);
>  }
>
>  void
> -delete_mid(struct mid_q_entry *mid)
> +delete_mid(struct smb_message *smb)
>  {
> -       spin_lock(&mid->server->mid_queue_lock);
> -       if (mid->deleted_from_q =3D=3D false) {
> -               list_del_init(&mid->qhead);
> -               mid->deleted_from_q =3D true;
> +       spin_lock(&smb->server->mid_queue_lock);
> +
> +       if (!smb->deleted_from_q) {
> +               list_del_init(&smb->qhead);
> +               smb->deleted_from_q =3D true;
>         }
> -       spin_unlock(&mid->server->mid_queue_lock);
> +       spin_unlock(&smb->server->mid_queue_lock);
>
> -       release_mid(mid);
> +       release_mid(smb);
>  }
>
>  /*
> @@ -640,13 +641,13 @@ cifs_wait_mtu_credits(struct TCP_Server_Info *serve=
r, size_t size,
>         return 0;
>  }
>
> -int wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry=
 *midQ)
> +int wait_for_response(struct TCP_Server_Info *server, struct smb_message=
 *smb)
>  {
>         int error;
>
>         error =3D wait_event_state(server->response_q,
> -                                midQ->mid_state !=3D MID_REQUEST_SUBMITT=
ED &&
> -                                midQ->mid_state !=3D MID_RESPONSE_RECEIV=
ED,
> +                                smb->mid_state !=3D MID_REQUEST_SUBMITTE=
D &&
> +                                smb->mid_state !=3D MID_RESPONSE_RECEIVE=
D,
>                                  (TASK_KILLABLE|TASK_FREEZABLE_UNSAFE));
>         if (error < 0)
>                 return -ERESTARTSYS;
> @@ -660,12 +661,12 @@ int wait_for_response(struct TCP_Server_Info *serve=
r, struct mid_q_entry *midQ)
>   */
>  int
>  cifs_call_async(struct TCP_Server_Info *server, struct smb_rqst *rqst,
> -               mid_receive_t *receive, mid_callback_t *callback,
> -               mid_handle_t *handle, void *cbdata, const int flags,
> +               mid_receive_t receive, mid_callback_t callback,
> +               mid_handle_t handle, void *cbdata, const int flags,
>                 const struct cifs_credits *exist_credits)
>  {
>         int rc;
> -       struct mid_q_entry *mid;
> +       struct smb_message *smb;
>         struct cifs_credits credits =3D { .value =3D 0, .instance =3D 0 }=
;
>         unsigned int instance;
>         int optype;
> @@ -694,35 +695,35 @@ cifs_call_async(struct TCP_Server_Info *server, str=
uct smb_rqst *rqst,
>                 return -EAGAIN;
>         }
>
> -       mid =3D server->ops->setup_async_request(server, rqst);
> -       if (IS_ERR(mid)) {
> +       smb =3D server->ops->setup_async_request(server, rqst);
> +       if (IS_ERR(smb)) {
>                 cifs_server_unlock(server);
>                 add_credits_and_wake_if(server, &credits, optype);
> -               return PTR_ERR(mid);
> +               return PTR_ERR(smb);
>         }
>
> -       mid->receive =3D receive;
> -       mid->callback =3D callback;
> -       mid->callback_data =3D cbdata;
> -       mid->handle =3D handle;
> -       mid->mid_state =3D MID_REQUEST_SUBMITTED;
> +       smb->receive =3D receive;
> +       smb->callback =3D callback;
> +       smb->callback_data =3D cbdata;
> +       smb->handle =3D handle;
> +       smb->mid_state =3D MID_REQUEST_SUBMITTED;
>
>         /* put it on the pending_mid_q */
>         spin_lock(&server->mid_queue_lock);
> -       list_add_tail(&mid->qhead, &server->pending_mid_q);
> +       list_add_tail(&smb->qhead, &server->pending_mid_q);
>         spin_unlock(&server->mid_queue_lock);
>
>         /*
>          * Need to store the time in mid before calling I/O. For call_asy=
nc,
>          * I/O response may come back and free the mid entry on another t=
hread.
>          */
> -       cifs_save_when_sent(mid);
> +       cifs_save_when_sent(smb);
>         rc =3D smb_send_rqst(server, 1, rqst, flags);
>
>         if (rc < 0) {
> -               revert_current_mid(server, mid->credits);
> +               revert_current_mid(server, smb->credits);
>                 server->sequence_number -=3D 2;
> -               delete_mid(mid);
> +               delete_mid(smb);
>         }
>
>         cifs_server_unlock(server);
> @@ -734,15 +735,15 @@ cifs_call_async(struct TCP_Server_Info *server, str=
uct smb_rqst *rqst,
>         return rc;
>  }
>
> -int cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info=
 *server)
> +int cifs_sync_mid_result(struct smb_message *smb, struct TCP_Server_Info=
 *server)
>  {
>         int rc =3D 0;
>
>         cifs_dbg(FYI, "%s: cmd=3D%d mid=3D%llu state=3D%d\n",
> -                __func__, le16_to_cpu(mid->command), mid->mid, mid->mid_=
state);
> +                __func__, le16_to_cpu(smb->command), smb->mid, smb->mid_=
state);
>
>         spin_lock(&server->mid_queue_lock);
> -       switch (mid->mid_state) {
> +       switch (smb->mid_state) {
>         case MID_RESPONSE_READY:
>                 spin_unlock(&server->mid_queue_lock);
>                 return rc;
> @@ -756,53 +757,53 @@ int cifs_sync_mid_result(struct mid_q_entry *mid, s=
truct TCP_Server_Info *server
>                 rc =3D -EHOSTDOWN;
>                 break;
>         case MID_RC:
> -               rc =3D mid->mid_rc;
> +               rc =3D smb->mid_rc;
>                 break;
>         default:
> -               if (mid->deleted_from_q =3D=3D false) {
> -                       list_del_init(&mid->qhead);
> -                       mid->deleted_from_q =3D true;
> +               if (smb->deleted_from_q =3D=3D false) {
> +                       list_del_init(&smb->qhead);
> +                       smb->deleted_from_q =3D true;
>                 }
>                 spin_unlock(&server->mid_queue_lock);
>                 cifs_server_dbg(VFS, "%s: invalid mid state mid=3D%llu st=
ate=3D%d\n",
> -                        __func__, mid->mid, mid->mid_state);
> +                        __func__, smb->mid, smb->mid_state);
>                 rc =3D -EIO;
>                 goto sync_mid_done;
>         }
>         spin_unlock(&server->mid_queue_lock);
>
>  sync_mid_done:
> -       release_mid(mid);
> +       release_mid(smb);
>         return rc;
>  }
>
>  static void
> -cifs_compound_callback(struct mid_q_entry *mid)
> +cifs_compound_callback(struct smb_message *smb)
>  {
> -       struct TCP_Server_Info *server =3D mid->server;
> +       struct TCP_Server_Info *server =3D smb->server;
>         struct cifs_credits credits =3D {
> -               .value =3D server->ops->get_credits(mid),
> +               .value =3D server->ops->get_credits(smb),
>                 .instance =3D server->reconnect_instance,
>         };
>
> -       add_credits(server, &credits, mid->optype);
> +       add_credits(server, &credits, smb->optype);
>
> -       if (mid->mid_state =3D=3D MID_RESPONSE_RECEIVED)
> -               mid->mid_state =3D MID_RESPONSE_READY;
> +       if (smb->mid_state =3D=3D MID_RESPONSE_RECEIVED)
> +               smb->mid_state =3D MID_RESPONSE_READY;
>  }
>
>  static void
> -cifs_compound_last_callback(struct mid_q_entry *mid)
> +cifs_compound_last_callback(struct smb_message *smb)
>  {
> -       cifs_compound_callback(mid);
> -       cifs_wake_up_task(mid);
> +       cifs_compound_callback(smb);
> +       cifs_wake_up_task(smb);
>  }
>
>  static void
> -cifs_cancelled_callback(struct mid_q_entry *mid)
> +cifs_cancelled_callback(struct smb_message *smb)
>  {
> -       cifs_compound_callback(mid);
> -       release_mid(mid);
> +       cifs_compound_callback(smb);
> +       release_mid(smb);
>  }
>
>  /*
> @@ -866,7 +867,7 @@ compound_send_recv(const unsigned int xid, struct cif=
s_ses *ses,
>                    int *resp_buf_type, struct kvec *resp_iov)
>  {
>         int i, j, optype, rc =3D 0;
> -       struct mid_q_entry *midQ[MAX_COMPOUND];
> +       struct smb_message *smb[MAX_COMPOUND];
>         bool cancelled_mid[MAX_COMPOUND] =3D {false};
>         struct cifs_credits credits[MAX_COMPOUND] =3D {
>                 { .value =3D 0, .instance =3D 0 }
> @@ -932,35 +933,35 @@ compound_send_recv(const unsigned int xid, struct c=
ifs_ses *ses,
>         }
>
>         for (i =3D 0; i < num_rqst; i++) {
> -               midQ[i] =3D server->ops->setup_request(ses, server, &rqst=
[i]);
> -               if (IS_ERR(midQ[i])) {
> +               smb[i] =3D server->ops->setup_request(ses, server, &rqst[=
i]);
> +               if (IS_ERR(smb[i])) {
>                         revert_current_mid(server, i);
>                         for (j =3D 0; j < i; j++)
> -                               delete_mid(midQ[j]);
> +                               delete_mid(smb[j]);
>                         cifs_server_unlock(server);
>
>                         /* Update # of requests on wire to server */
>                         for (j =3D 0; j < num_rqst; j++)
>                                 add_credits(server, &credits[j], optype);
> -                       return PTR_ERR(midQ[i]);
> +                       return PTR_ERR(smb[i]);
>                 }
>
> -               midQ[i]->mid_state =3D MID_REQUEST_SUBMITTED;
> -               midQ[i]->optype =3D optype;
> +               smb[i]->mid_state =3D MID_REQUEST_SUBMITTED;
> +               smb[i]->optype =3D optype;
>                 /*
>                  * Invoke callback for every part of the compound chain
>                  * to calculate credits properly. Wake up this thread onl=
y when
>                  * the last element is received.
>                  */
>                 if (i < num_rqst - 1)
> -                       midQ[i]->callback =3D cifs_compound_callback;
> +                       smb[i]->callback =3D cifs_compound_callback;
>                 else
> -                       midQ[i]->callback =3D cifs_compound_last_callback=
;
> +                       smb[i]->callback =3D cifs_compound_last_callback;
>         }
>         rc =3D smb_send_rqst(server, num_rqst, rqst, flags);
>
>         for (i =3D 0; i < num_rqst; i++)
> -               cifs_save_when_sent(midQ[i]);
> +               cifs_save_when_sent(smb[i]);
>
>         if (rc < 0) {
>                 revert_current_mid(server, num_rqst);
> @@ -1003,23 +1004,24 @@ compound_send_recv(const unsigned int xid, struct=
 cifs_ses *ses,
>         spin_unlock(&ses->ses_lock);
>
>         for (i =3D 0; i < num_rqst; i++) {
> -               rc =3D wait_for_response(server, midQ[i]);
> +               rc =3D wait_for_response(server, smb[i]);
>                 if (rc !=3D 0)
>                         break;
>         }
>         if (rc !=3D 0) {
>                 for (; i < num_rqst; i++) {
>                         cifs_server_dbg(FYI, "Cancelling wait for mid %ll=
u cmd: %d\n",
> -                                midQ[i]->mid, le16_to_cpu(midQ[i]->comma=
nd));
> -                       send_cancel(server, &rqst[i], midQ[i]);
> -                       spin_lock(&midQ[i]->mid_lock);
> -                       midQ[i]->wait_cancelled =3D true;
> -                       if (midQ[i]->callback) {
> -                               midQ[i]->callback =3D cifs_cancelled_call=
back;
> +                                smb[i]->mid, le16_to_cpu(smb[i]->command=
));
> +                       send_cancel(server, &rqst[i], smb[i]);
> +                       spin_lock(&smb[i]->mid_lock);
> +                       smb[i]->wait_cancelled =3D true;
> +                       if (smb[i]->mid_state =3D=3D MID_REQUEST_SUBMITTE=
D ||
> +                           smb[i]->mid_state =3D=3D MID_RESPONSE_RECEIVE=
D) {
> +                               smb[i]->callback =3D cifs_cancelled_callb=
ack;
>                                 cancelled_mid[i] =3D true;
>                                 credits[i].value =3D 0;
>                         }
> -                       spin_unlock(&midQ[i]->mid_lock);
> +                       spin_unlock(&smb[i]->mid_lock);
>                 }
>         }
>
> @@ -1027,36 +1029,36 @@ compound_send_recv(const unsigned int xid, struct=
 cifs_ses *ses,
>                 if (rc < 0)
>                         goto out;
>
> -               rc =3D cifs_sync_mid_result(midQ[i], server);
> +               rc =3D cifs_sync_mid_result(smb[i], server);
>                 if (rc !=3D 0) {
>                         /* mark this mid as cancelled to not free it belo=
w */
>                         cancelled_mid[i] =3D true;
>                         goto out;
>                 }
>
> -               if (!midQ[i]->resp_buf ||
> -                   midQ[i]->mid_state !=3D MID_RESPONSE_READY) {
> +               if (!smb[i]->resp_buf ||
> +                   smb[i]->mid_state !=3D MID_RESPONSE_READY) {
>                         rc =3D -EIO;
>                         cifs_dbg(FYI, "Bad MID state?\n");
>                         goto out;
>                 }
>
> -               buf =3D (char *)midQ[i]->resp_buf;
> +               buf =3D (char *)smb[i]->resp_buf;
>                 resp_iov[i].iov_base =3D buf;
> -               resp_iov[i].iov_len =3D midQ[i]->resp_buf_size +
> +               resp_iov[i].iov_len =3D smb[i]->resp_buf_size +
>                         HEADER_PREAMBLE_SIZE(server);
>
> -               if (midQ[i]->large_buf)
> +               if (smb[i]->large_buf)
>                         resp_buf_type[i] =3D CIFS_LARGE_BUFFER;
>                 else
>                         resp_buf_type[i] =3D CIFS_SMALL_BUFFER;
>
> -               rc =3D server->ops->check_receive(midQ[i], server,
> +               rc =3D server->ops->check_receive(smb[i], server,
>                                                      flags & CIFS_LOG_ERR=
OR);
>
>                 /* mark it so buf will not be freed by delete_mid */
>                 if ((flags & CIFS_NO_RSP_BUF) =3D=3D 0)
> -                       midQ[i]->resp_buf =3D NULL;
> +                       smb[i]->resp_buf =3D NULL;
>
>         }
>
> @@ -1086,7 +1088,7 @@ compound_send_recv(const unsigned int xid, struct c=
ifs_ses *ses,
>          */
>         for (i =3D 0; i < num_rqst; i++) {
>                 if (!cancelled_mid[i])
> -                       delete_mid(midQ[i]);
> +                       delete_mid(smb[i]);
>         }
>
>         return rc;
> @@ -1130,38 +1132,38 @@ cifs_discard_remaining_data(struct TCP_Server_Inf=
o *server)
>  }
>
>  static int
> -__cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry =
*mid,
> +__cifs_readv_discard(struct TCP_Server_Info *server, struct smb_message =
*smb,
>                      bool malformed)
>  {
>         int length;
>
>         length =3D cifs_discard_remaining_data(server);
> -       dequeue_mid(mid, malformed);
> -       mid->resp_buf =3D server->smallbuf;
> +       dequeue_mid(smb, malformed);
> +       smb->resp_buf =3D server->smallbuf;
>         server->smallbuf =3D NULL;
>         return length;
>  }
>
>  static int
> -cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry *m=
id)
> +cifs_readv_discard(struct TCP_Server_Info *server, struct smb_message *s=
mb)
>  {
> -       struct cifs_io_subrequest *rdata =3D mid->callback_data;
> +       struct cifs_io_subrequest *rdata =3D smb->callback_data;
>
> -       return  __cifs_readv_discard(server, mid, rdata->result);
> +       return  __cifs_readv_discard(server, smb, rdata->result);
>  }
>
>  int
> -cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *m=
id)
> +cifs_readv_receive(struct TCP_Server_Info *server, struct smb_message *s=
mb)
>  {
>         int length, len;
>         unsigned int data_offset, data_len;
> -       struct cifs_io_subrequest *rdata =3D mid->callback_data;
> +       struct cifs_io_subrequest *rdata =3D smb->callback_data;
>         char *buf =3D server->smallbuf;
>         unsigned int buflen =3D server->pdu_size + HEADER_PREAMBLE_SIZE(s=
erver);
>         bool use_rdma_mr =3D false;
>
>         cifs_dbg(FYI, "%s: mid=3D%llu offset=3D%llu bytes=3D%zu\n",
> -                __func__, mid->mid, rdata->subreq.start, rdata->subreq.l=
en);
> +                __func__, smb->mid, rdata->subreq.start, rdata->subreq.l=
en);
>
>         /*
>          * read the rest of READ_RSP header (sans Data array), or whateve=
r we
> @@ -1206,7 +1208,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, =
struct mid_q_entry *mid)
>                 cifs_dbg(FYI, "%s: server returned error %d\n",
>                          __func__, rdata->result);
>                 /* normal error on read response */
> -               return __cifs_readv_discard(server, mid, false);
> +               return __cifs_readv_discard(server, smb, false);
>         }
>
>         /* Is there enough to get to the rest of the READ_RSP header? */
> @@ -1215,7 +1217,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, =
struct mid_q_entry *mid)
>                          __func__, server->total_read,
>                          server->vals->read_rsp_size);
>                 rdata->result =3D -EIO;
> -               return cifs_readv_discard(server, mid);
> +               return cifs_readv_discard(server, smb);
>         }
>
>         data_offset =3D server->ops->read_data_offset(buf) +
> @@ -1234,7 +1236,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, =
struct mid_q_entry *mid)
>                 cifs_dbg(FYI, "%s: data offset (%u) beyond end of smallbu=
f\n",
>                          __func__, data_offset);
>                 rdata->result =3D -EIO;
> -               return cifs_readv_discard(server, mid);
> +               return cifs_readv_discard(server, smb);
>         }
>
>         cifs_dbg(FYI, "%s: total_read=3D%u data_offset=3D%u\n",
> @@ -1258,7 +1260,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, =
struct mid_q_entry *mid)
>         if (!use_rdma_mr && (data_offset + data_len > buflen)) {
>                 /* data_len is corrupt -- discard frame */
>                 rdata->result =3D -EIO;
> -               return cifs_readv_discard(server, mid);
> +               return cifs_readv_discard(server, smb);
>         }
>
>  #ifdef CONFIG_CIFS_SMB_DIRECT
> @@ -1277,10 +1279,10 @@ cifs_readv_receive(struct TCP_Server_Info *server=
, struct mid_q_entry *mid)
>
>         /* discard anything left over */
>         if (server->total_read < buflen)
> -               return cifs_readv_discard(server, mid);
> +               return cifs_readv_discard(server, smb);
>
> -       dequeue_mid(mid, false);
> -       mid->resp_buf =3D server->smallbuf;
> +       dequeue_mid(smb, false);
> +       smb->resp_buf =3D server->smallbuf;
>         server->smallbuf =3D NULL;
>         return length;
>  }
>
>


--=20
Thanks,

Steve

