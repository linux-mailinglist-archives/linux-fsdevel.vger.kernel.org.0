Return-Path: <linux-fsdevel+bounces-30016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEDD984ED4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 01:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CF24283680
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 23:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53311155733;
	Tue, 24 Sep 2024 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwwtog0D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE5E1C32
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 23:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727219985; cv=none; b=bgBrRAyDKqdrZc/FdmvT5saqOXAOmVfNra6BFgLkCnL5Wx/HpBSd5L9x23i058JJ3c9pRe3M+476FSq9xQHaWzK726cMyzcEC9qBwIvS+1QemftpJydEAs3ca2xY9vq/NY0yJV4oTAgc46Giv//rCQBYOR+6jVPa977Dn6V847U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727219985; c=relaxed/simple;
	bh=D0J4El+jf0Gg3JAGsNbKAHpgLLeU9H2tpzo8EArf3cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3r+NM1z8wfYOwAeOzwAN7i/vNxOmANDnlV5YiR6Px1VpECpux4qohlKibz7IvayPBLelp0VprMK6hwipUkJHjgUAd0a9DKG/tfL4P07FTg4vk5b3VYcngQq2qZ1Mci9UgZc6KGN1jyOhT2hzi5s71ecX+bPmsaQrXflAflWz/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwwtog0D; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5365aec6fc1so6706926e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Sep 2024 16:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727219981; x=1727824781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqgkO9umAcljezxbBhTinw4cVNyUsl7JtTdhMvNKcDM=;
        b=lwwtog0Dnab1BZF+CtdPQj2IlSm3nZCJyQ4asaY+kT78lDnTMqRUNpHkePXj+KRSOz
         hjL+mh+6B1q2CQ4uVLrA+EaidXjrGM5P+GXyP1qDfz18xS0MXQpEFaS+KrDTl8OBEX7K
         iQZoyLT/4kWR93RLNXUIPQ1X7TpJoKsMxtGqoRWM2JGr+AABTdqm7oMYjoUH8IK+tLur
         NcYj79sJBlVDUnl03Rg1ShSVQWBQBkItlcXrGV2+/8ZyvEF0tKmFYfg82A9LBu3tSxIk
         t4MBEG/zF5S7UfURqC4rubBW9Yt8MvrAdhq9slr4gZBq83HYw0hrs9Wcb7gvqxd12p+D
         V1qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727219981; x=1727824781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqgkO9umAcljezxbBhTinw4cVNyUsl7JtTdhMvNKcDM=;
        b=RaEobk870hnVMALQci6Et5d7rZIU0P7U4t+DS2fbLcok6WZdqWWGsu6EgXIhrKAzb+
         XJbCNaSFEGVtvwTykhWpZQs6l0lbhAmm7mUzFiKKVDhDbrpckhQ+SRrkk3RiPuH6w89T
         8NxsrFc2kmNGq1nuK+IJks5AUZ31WIOXTTFl+1Cf3d5CjFvLESYtz8RjAb4rIRLvhgRD
         YBXtXnZKKwYNPb9bNcdZX+gX0MG9CtqXsZHyButeMzcCmV8q3igdrIq1dTup7VPhzPgw
         Cq0X39s5AOc6wMkEoJB7wIF1IObTCNEm88z/FPT6sXPwPcGX6rzWbPy7ekM6AV03/SWs
         P1yg==
X-Forwarded-Encrypted: i=1; AJvYcCW77BRb8ctRsPs8thgQA1p7HUHJMOE9xDPBvUSObtsrMQClm+JLBZ5qx8nAi5XousLgjraKN1IviSbzOrTR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz33/evfW6xpZUyHPO8strPbf7ioOx8ISjgWp0xuHymjn90EpY2
	43ERVmFW7coMIWYC3e5kBrizy0rAivbVaku0UOCdGYycKk10GsOkDbligIUVvIrn3XF0a82EC5t
	4ig4SZXrHsZArpRQ+tC1t+luRUlk=
X-Google-Smtp-Source: AGHT+IEs6SrkoESjM16ll3jZm1hG9iEgirZxprDayiTWCubQB6bBwgWo565ZxYCvymE4dc3N9ZbWjILkkC0/lhIUGyI=
X-Received: by 2002:a05:6512:114b:b0:531:4c6d:b8ef with SMTP id
 2adb3069b0e04-5387048b8e9mr332583e87.6.1727219981129; Tue, 24 Sep 2024
 16:19:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202409131438.3f225fbf-oliver.sang@intel.com> <1191933.1727214450@warthog.procyon.org.uk>
In-Reply-To: <1191933.1727214450@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Tue, 24 Sep 2024 18:19:29 -0500
Message-ID: <CAH2r5msFnqU-wCn4QRv1Tjh4dtomA6QbtAGmONhx5C0mduxLVg@mail.gmail.com>
Subject: Re: [linux-next:master] [netfs] a05b682d49: BUG:KASAN:slab-use-after-free_in_copy_from_iter
To: David Howells <dhowells@redhat.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes - I can confirm that this fixes the recent netfs regression in generic/=
075

http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/3/=
builds/239

You can add:
Tested-by: Steve French <stfrench@microsoft.com>

On Tue, Sep 24, 2024 at 4:47=E2=80=AFPM David Howells <dhowells@redhat.com>=
 wrote:
>
> Does the attached fix the problem?
>
> David
> ---
> netfs: Fix write oops in generic/346 (9p) and maybe generic/074 (cifs)
>
> In netfslib, a buffered writeback operation has a 'write queue' of folios
> that are being written, held in a linear sequence of folio_queue structs.
> The 'issuer' adds new folio_queues on the leading edge of the queue and
> populates each one progressively; the 'collector' pops them off the
> trailing edge and discards them and the folios they point to as they are
> consumed.
>
> The queue is required to always retain at least one folio_queue structure=
.
> This allows the queue to be accessed without locking and with just a bit =
of
> barriering.
>
> When a new subrequest is prepared, its ->io_iter iterator is pointed at t=
he
> current end of the write queue and then the iterator is extended as more
> data is added to the queue until the subrequest is committed.
>
> Now, the problem is that the folio_queue at the leading edge of the write
> queue when a subrequest is prepared might have been entirely consumed - b=
ut
> not yet removed from the queue as it is the only remaining one and is
> preventing the queue from collapsing.
>
> So, what happens is that subreq->io_iter is pointed at the spent
> folio_queue, then a new folio_queue is added, and, at that point, the
> collector is at entirely at liberty to immediately delete the spent
> folio_queue.
>
> This leaves the subreq->io_iter pointing at a freed object.  If the syste=
m
> is lucky, iterate_folioq() sees ->io_iter, sees the as-yet uncorrupted
> freed object and advances to the next folio_queue in the queue.
>
> In the case seen, however, the freed object gets recycled and put back on=
to
> the queue at the tail and filled to the end.  This confuses
> iterate_folioq() and it tries to step ->next, which may be NULL - resulti=
ng
> in an oops.
>
> Fix this by the following means:
>
>  (1) When preparing a write subrequest, make sure there's a folio_queue
>      struct with space in it at the leading edge of the queue.  A functio=
n
>      to make space is split out of the function to append a folio so that
>      it can be called for this purpose.
>
>  (2) If the request struct iterator is pointing to a completely spent
>      folio_queue when we make space, then advance the iterator to the new=
ly
>      allocated folio_queue.  The subrequest's iterator will then be set
>      from this.
>
> Whilst we're at it, also split out the function to allocate a folio_queue=
,
> initialise it and do the accounting.
>
> The oops could be triggered using the generic/346 xfstest with a filesyst=
em
> on9P over TCP with cache=3Dloose.  The oops looked something like:
>
>  BUG: kernel NULL pointer dereference, address: 0000000000000008
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  ...
>  RIP: 0010:_copy_from_iter+0x2db/0x530
>  ...
>  Call Trace:
>   <TASK>
>  ...
>   p9pdu_vwritef+0x3d8/0x5d0
>   p9_client_prepare_req+0xa8/0x140
>   p9_client_rpc+0x81/0x280
>   p9_client_write+0xcf/0x1c0
>   v9fs_issue_write+0x87/0xc0
>   netfs_advance_write+0xa0/0xb0
>   netfs_write_folio.isra.0+0x42d/0x500
>   netfs_writepages+0x15a/0x1f0
>   do_writepages+0xd1/0x220
>   filemap_fdatawrite_wbc+0x5c/0x80
>   v9fs_mmap_vm_close+0x7d/0xb0
>   remove_vma+0x35/0x70
>   vms_complete_munmap_vmas+0x11a/0x170
>   do_vmi_align_munmap+0x17d/0x1c0
>   do_vmi_munmap+0x13e/0x150
>   __vm_munmap+0x92/0xd0
>   __x64_sys_munmap+0x17/0x20
>   do_syscall_64+0x80/0xe0
>   entry_SYSCALL_64_after_hwframe+0x71/0x79
>
> This may also fix a similar-looking issue with cifs and generic/074.
>
>   | Reported-by: kernel test robot <oliver.sang@intel.com>
>   | Closes: https://lore.kernel.org/oe-lkp/202409180928.f20b5a08-oliver.s=
ang@intel.com
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Eric Van Hensbergen <ericvh@kernel.org>
> cc: Latchesar Ionkov <lucho@ionkov.net>
> cc: Dominique Martinet <asmadeus@codewreck.org>
> cc: Christian Schoenebeck <linux_oss@crudebyte.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: v9fs@lists.linux.dev
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/netfs/internal.h    |    2 +
>  fs/netfs/misc.c        |   72 ++++++++++++++++++++++++++++++++++--------=
-------
>  fs/netfs/objects.c     |   12 ++++++++
>  fs/netfs/write_issue.c |   12 +++++++-
>  4 files changed, 76 insertions(+), 22 deletions(-)
>
> diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
> index c7f23dd3556a..79c0ad89affb 100644
> --- a/fs/netfs/internal.h
> +++ b/fs/netfs/internal.h
> @@ -58,6 +58,7 @@ static inline void netfs_proc_del_rreq(struct netfs_io_=
request *rreq) {}
>  /*
>   * misc.c
>   */
> +struct folio_queue *netfs_buffer_make_space(struct netfs_io_request *rre=
q);
>  int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct foli=
o *folio,
>                               bool needs_put);
>  struct folio_queue *netfs_delete_buffer_head(struct netfs_io_request *wr=
eq);
> @@ -76,6 +77,7 @@ void netfs_clear_subrequests(struct netfs_io_request *r=
req, bool was_async);
>  void netfs_put_request(struct netfs_io_request *rreq, bool was_async,
>                        enum netfs_rreq_ref_trace what);
>  struct netfs_io_subrequest *netfs_alloc_subrequest(struct netfs_io_reque=
st *rreq);
> +struct folio_queue *netfs_folioq_alloc(struct netfs_io_request *rreq, gf=
p_t gfp);
>
>  static inline void netfs_see_request(struct netfs_io_request *rreq,
>                                      enum netfs_rreq_ref_trace what)
> diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
> index 0ad0982ce0e2..a743e8963247 100644
> --- a/fs/netfs/misc.c
> +++ b/fs/netfs/misc.c
> @@ -9,34 +9,64 @@
>  #include "internal.h"
>
>  /*
> - * Append a folio to the rolling queue.
> + * Make sure there's space in the rolling queue.
>   */
> -int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct foli=
o *folio,
> -                             bool needs_put)
> +struct folio_queue *netfs_buffer_make_space(struct netfs_io_request *rre=
q)
>  {
> -       struct folio_queue *tail =3D rreq->buffer_tail;
> -       unsigned int slot, order =3D folio_order(folio);
> +       struct folio_queue *tail =3D rreq->buffer_tail, *prev;
> +       unsigned int prev_nr_slots =3D 0;
>
>         if (WARN_ON_ONCE(!rreq->buffer && tail) ||
>             WARN_ON_ONCE(rreq->buffer && !tail))
> -               return -EIO;
> -
> -       if (!tail || folioq_full(tail)) {
> -               tail =3D kmalloc(sizeof(*tail), GFP_NOFS);
> -               if (!tail)
> -                       return -ENOMEM;
> -               netfs_stat(&netfs_n_folioq);
> -               folioq_init(tail);
> -               tail->prev =3D rreq->buffer_tail;
> -               if (tail->prev)
> -                       tail->prev->next =3D tail;
> -               rreq->buffer_tail =3D tail;
> -               if (!rreq->buffer) {
> -                       rreq->buffer =3D tail;
> -                       iov_iter_folio_queue(&rreq->io_iter, ITER_SOURCE,=
 tail, 0, 0, 0);
> +               return ERR_PTR(-EIO);
> +
> +       prev =3D tail;
> +       if (prev) {
> +               if (!folioq_full(tail))
> +                       return tail;
> +               prev_nr_slots =3D folioq_nr_slots(tail);
> +       }
> +
> +       tail =3D netfs_folioq_alloc(rreq, GFP_NOFS);
> +       if (!tail)
> +               return ERR_PTR(-ENOMEM);
> +       tail->prev =3D prev;
> +       if (prev)
> +               /* [!] NOTE: After we set prev->next, the consumer is ent=
irely
> +                * at liberty to delete prev.
> +                */
> +               WRITE_ONCE(prev->next, tail);
> +
> +       rreq->buffer_tail =3D tail;
> +       if (!rreq->buffer) {
> +               rreq->buffer =3D tail;
> +               iov_iter_folio_queue(&rreq->io_iter, ITER_SOURCE, tail, 0=
, 0, 0);
> +       } else {
> +               /* Make sure we don't leave the master iterator pointing =
to a
> +                * block that might get immediately consumed.
> +                */
> +               if (rreq->io_iter.folioq =3D=3D prev &&
> +                   rreq->io_iter.folioq_slot =3D=3D prev_nr_slots) {
> +                       rreq->io_iter.folioq =3D tail;
> +                       rreq->io_iter.folioq_slot =3D 0;
>                 }
> -               rreq->buffer_tail_slot =3D 0;
>         }
> +       rreq->buffer_tail_slot =3D 0;
> +       return tail;
> +}
> +
> +/*
> + * Append a folio to the rolling queue.
> + */
> +int netfs_buffer_append_folio(struct netfs_io_request *rreq, struct foli=
o *folio,
> +                             bool needs_put)
> +{
> +       struct folio_queue *tail;
> +       unsigned int slot, order =3D folio_order(folio);
> +
> +       tail =3D netfs_buffer_make_space(rreq);
> +       if (IS_ERR(tail))
> +               return PTR_ERR(tail);
>
>         rreq->io_iter.count +=3D PAGE_SIZE << order;
>
> diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
> index d32964e8ca5d..dd8241bc996b 100644
> --- a/fs/netfs/objects.c
> +++ b/fs/netfs/objects.c
> @@ -250,3 +250,15 @@ void netfs_put_subrequest(struct netfs_io_subrequest=
 *subreq, bool was_async,
>         if (dead)
>                 netfs_free_subrequest(subreq, was_async);
>  }
> +
> +struct folio_queue *netfs_folioq_alloc(struct netfs_io_request *rreq, gf=
p_t gfp)
> +{
> +       struct folio_queue *fq;
> +
> +       fq =3D kmalloc(sizeof(*fq), gfp);
> +       if (fq) {
> +               netfs_stat(&netfs_n_folioq);
> +               folioq_init(fq);
> +       }
> +       return fq;
> +}
> diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
> index 04e66d587f77..0929d9fd4ce7 100644
> --- a/fs/netfs/write_issue.c
> +++ b/fs/netfs/write_issue.c
> @@ -153,12 +153,22 @@ static void netfs_prepare_write(struct netfs_io_req=
uest *wreq,
>                                 loff_t start)
>  {
>         struct netfs_io_subrequest *subreq;
> +       struct iov_iter *wreq_iter =3D &wreq->io_iter;
> +
> +       /* Make sure we don't point the iterator at a used-up folio_queue
> +        * struct being used as a placeholder to prevent the queue from
> +        * collapsing.  In such a case, extend the queue.
> +        */
> +       if (iov_iter_is_folioq(wreq_iter) &&
> +           wreq_iter->folioq_slot >=3D folioq_nr_slots(wreq_iter->folioq=
)) {
> +               netfs_buffer_make_space(wreq);
> +       }
>
>         subreq =3D netfs_alloc_subrequest(wreq);
>         subreq->source          =3D stream->source;
>         subreq->start           =3D start;
>         subreq->stream_nr       =3D stream->stream_nr;
> -       subreq->io_iter         =3D wreq->io_iter;
> +       subreq->io_iter         =3D *wreq_iter;
>
>         _enter("R=3D%x[%x]", wreq->debug_id, subreq->debug_index);
>
>


--=20
Thanks,

Steve

