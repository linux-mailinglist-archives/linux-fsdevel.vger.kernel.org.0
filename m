Return-Path: <linux-fsdevel+bounces-12622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BFE861C3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 20:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685E4287A77
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 19:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F418143C45;
	Fri, 23 Feb 2024 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvW/KuiE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4940313BAC2;
	Fri, 23 Feb 2024 19:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708715071; cv=none; b=mSmw7tF5lMDTxPc5EdrSu0TMOiaDFVC4qQlITPM4vAMjF25MC3U3z7xSNQZtTogNb6A46MYVMTaUPe9ryVMWgT8s3xB7aGy4FETr2/DfsdlMcw1nsYsXkUeQzAN232TkdQ4InrsJv965EV2YZ8ZQuxAmL4hQYdU8yG2BKotfypU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708715071; c=relaxed/simple;
	bh=8ADDstHVumIlW/HKFQmphRTto9H5pLC/Zfr5+gq0nsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9jDyPwW0prkK0Gb7Bf8xWkB2BJkNMl3L8adrYkMku63T1TdAIgExOzBAA02hpBQ8iWy3cbTYbRl1V3ueq57pq0xf2gGIhOacIadyFVZKnlqdZs37nodH1P1DQkcGj/cMdPvYLcMahnyj8JFWjfxAa48qhZNpZQKHUO151yXJuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvW/KuiE; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512cc3ea7a5so789360e87.3;
        Fri, 23 Feb 2024 11:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708715067; x=1709319867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vijFnIPIDRK0WerPjeRaOiPFj7TwHQttM28/ZM6+S9k=;
        b=OvW/KuiERN6h6sELwnWBk3c8H/yNov3iN49hrc92noBhRY3YtkltGNuNwaZDJBNR+Q
         fpmfhV/0KM/st+9Ul9nJ08tewwdDW09J1IWjCsmaaLdpQ04SJpbjwuxEj06NH4+B0tod
         YY10hH+EolHrmFlwec/0T3AXOHs6Q+IIDT6iaYaTAlk2ag+Xn66INMSxKNMKdMohGVep
         yEov/SPdJwmlwlZY9vOMmKahv8+D4YCK38c/0spQfLsGq2OeyJhIxkN0WQ/UXJfaSccz
         yY7hdaK/fILci5Y/RWe4ZGFkiSsTbpjxjoTg0MG+/wfHKN1dHu6Lo0yNQJtruZxPGaTF
         X2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708715067; x=1709319867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vijFnIPIDRK0WerPjeRaOiPFj7TwHQttM28/ZM6+S9k=;
        b=tDb9tA1Ou5XEDiqLbCjXoB9LH8c6ROMwzwTUuYpyi/IRww8Et+MtIRaxg1FvoDitMg
         KSjWt8oXeHykraAMrVE9q+RhXWd1u9MwYk42Ejhy7Hx9egFHu5hY8Lv2vgASddzo94zc
         7l/662tav7tMrxMvpU96QZm51iB3XkepODAvqfck603BaBZ06+Lbg1YpvA0lmxj00YjL
         GaF4DDJIDwkCMqZO5l3LXqLDQ8AmVTwB2xDosm36/NRqASY3lLfnsVLYCaaK5hB8xD1b
         0mKW6Tw28s81Xr8yxkXY+TddSe3iA72MzZihqNs2aHBp0D5rZqjxyLvcUSUw4neOl9he
         Cj8g==
X-Forwarded-Encrypted: i=1; AJvYcCVSR0gcaY901WeG0/HCBjuk+OlC9L9EloBbH8q49fRZr3ZwwCMpcWfjnZVo+7hGP32pK8VfC7omxkFCVLs+VjYyyYavPPRY64F4M57MWK6ed7ysDoJaIeq7SIz8QZbgZjdk3wdElLarHllCz68/oaUM77/uaOUvNzxLKA+l15mX6oMBg2oJ7js=
X-Gm-Message-State: AOJu0YwAo/CDgG5yzv7H6VcJghoKCglrSOjYhAZrcuNBvWCCX6ltKY0k
	4bgpaAOGUYC1hZp4Mt7mrzzKqEYRi3gqUd7FPRgwaJ9AA7Vi+ZqKDhAzf+XYhgjKwpRiBJOkrBt
	3OGxAXKuSJfEucoAr93+ytPrjNM8=
X-Google-Smtp-Source: AGHT+IGqUi6hXsymR+VR2nIl/wZyRnRk85g/HFBOXchC9LXe+4eFIilo9k104KSns7k2tZLNZsWtMgPspe6T0WRLQvE=
X-Received: by 2002:a19:6553:0:b0:512:ab58:3807 with SMTP id
 c19-20020a196553000000b00512ab583807mr411745lfj.9.1708715067035; Fri, 23 Feb
 2024 11:04:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <652317.1708600826@warthog.procyon.org.uk>
In-Reply-To: <652317.1708600826@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Fri, 23 Feb 2024 13:04:15 -0600
Message-ID: <CAH2r5msXug-fDa22mqEkrpgx=bYG_h3Z674PkUGssH0aG4bGXg@mail.gmail.com>
Subject: Re: [RFC PATCH] cifs: Fix writeback data corruption
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Jeff Layton <jlayton@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Should the BUG() be changed to a WARN() or warn once?

./scripts/checkpatch.pl
fs/smb/client/0001-cifs-Fix-writeback-data-corruption.patch WARNING:
Do not crash the kernel unless it is absolutely unavoidable--use
WARN_ON_ONCE() plus recovery code (if feasible) instead of BUG() or
variants
#205: FILE: fs/smb/client/file.c:2758:
+ BUG();

total: 0 errors, 1 warnings, 439 lines checked

On Thu, Feb 22, 2024 at 5:20=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> cifs writeback doesn't correctly handle the case where
> cifs_extend_writeback() hits a point where it is considering an additiona=
l
> folio, but this would overrun the wsize - at which point it drops out of
> the xarray scanning loop and calls xas_pause().  The problem is that
> xas_pause() advances the loop counter - thereby skipping that page.
>
> What needs to happen is for xas_reset() to be called any time we decide w=
e
> don't want to process the page we're looking at, but rather send the
> request we are building and start a new one.
>
> Fix this by copying and adapting the netfslib writepages code as a
> temporary measure, with cifs writeback intending to be offloaded to
> netfslib in the near future.
>
> This also fixes the issue with the use of filemap_get_folios_tag() causin=
g
> retry of a bunch of pages which the extender already dealt with.
>
> This can be tested by creating, say, a 64K file somewhere not on cifs
> (otherwise copy-offload may get underfoot), mounting a cifs share with a
> wsize of 64000, copying the file to it and then comparing the original fi=
le
> and the copy:
>
>         dd if=3D/dev/urandom of=3D/tmp/64K bs=3D64k count=3D1
>         mount //192.168.6.1/test /mnt -o user=3D...,pass=3D...,wsize=3D64=
000
>         cp /tmp/64K /mnt/64K
>         cmp /tmp/64K /mnt/64K
>
> Without the fix, the cmp fails at position 64000 (or shortly thereafter).
>
> Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rathe=
r than a page list")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.com>
> cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> cc: Shyam Prasad N <sprasad@microsoft.com>
> cc: Tom Talpey <tom@talpey.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: samba-technical@lists.samba.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/smb/client/file.c |  284 ++++++++++++++++++++++++++++----------------=
-------
>  1 file changed, 158 insertions(+), 126 deletions(-)
>
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index f391c9b803d8..671ce6ebd203 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -2624,20 +2624,20 @@ static int cifs_partialpagewrite(struct page *pag=
e, unsigned from, unsigned to)
>   * dirty pages if possible, but don't sleep while doing so.
>   */
>  static void cifs_extend_writeback(struct address_space *mapping,
> +                                 struct xa_state *xas,
>                                   long *_count,
>                                   loff_t start,
>                                   int max_pages,
> -                                 size_t max_len,
> -                                 unsigned int *_len)
> +                                 loff_t max_len,
> +                                 size_t *_len)
>  {
>         struct folio_batch batch;
>         struct folio *folio;
> -       unsigned int psize, nr_pages;
> -       size_t len =3D *_len;
> -       pgoff_t index =3D (start + len) / PAGE_SIZE;
> +       unsigned int nr_pages;
> +       pgoff_t index =3D (start + *_len) / PAGE_SIZE;
> +       size_t len;
>         bool stop =3D true;
>         unsigned int i;
> -       XA_STATE(xas, &mapping->i_pages, index);
>
>         folio_batch_init(&batch);
>
> @@ -2648,54 +2648,64 @@ static void cifs_extend_writeback(struct address_=
space *mapping,
>                  */
>                 rcu_read_lock();
>
> -               xas_for_each(&xas, folio, ULONG_MAX) {
> +               xas_for_each(xas, folio, ULONG_MAX) {
>                         stop =3D true;
> -                       if (xas_retry(&xas, folio))
> +                       if (xas_retry(xas, folio))
>                                 continue;
>                         if (xa_is_value(folio))
>                                 break;
> -                       if (folio->index !=3D index)
> +                       if (folio->index !=3D index) {
> +                               xas_reset(xas);
>                                 break;
> +                       }
> +
>                         if (!folio_try_get_rcu(folio)) {
> -                               xas_reset(&xas);
> +                               xas_reset(xas);
>                                 continue;
>                         }
>                         nr_pages =3D folio_nr_pages(folio);
> -                       if (nr_pages > max_pages)
> +                       if (nr_pages > max_pages) {
> +                               xas_reset(xas);
>                                 break;
> +                       }
>
>                         /* Has the page moved or been split? */
> -                       if (unlikely(folio !=3D xas_reload(&xas))) {
> +                       if (unlikely(folio !=3D xas_reload(xas))) {
>                                 folio_put(folio);
> +                               xas_reset(xas);
>                                 break;
>                         }
>
>                         if (!folio_trylock(folio)) {
>                                 folio_put(folio);
> +                               xas_reset(xas);
>                                 break;
>                         }
> -                       if (!folio_test_dirty(folio) || folio_test_writeb=
ack(folio)) {
> +                       if (!folio_test_dirty(folio) ||
> +                           folio_test_writeback(folio)) {
>                                 folio_unlock(folio);
>                                 folio_put(folio);
> +                               xas_reset(xas);
>                                 break;
>                         }
>
>                         max_pages -=3D nr_pages;
> -                       psize =3D folio_size(folio);
> -                       len +=3D psize;
> +                       len =3D folio_size(folio);
>                         stop =3D false;
> -                       if (max_pages <=3D 0 || len >=3D max_len || *_cou=
nt <=3D 0)
> -                               stop =3D true;
>
>                         index +=3D nr_pages;
> +                       *_count -=3D nr_pages;
> +                       *_len +=3D len;
> +                       if (max_pages <=3D 0 || *_len >=3D max_len || *_c=
ount <=3D 0)
> +                               stop =3D true;
> +
>                         if (!folio_batch_add(&batch, folio))
>                                 break;
>                         if (stop)
>                                 break;
>                 }
>
> -               if (!stop)
> -                       xas_pause(&xas);
> +               xas_pause(xas);
>                 rcu_read_unlock();
>
>                 /* Now, if we obtained any pages, we can shift them to be=
ing
> @@ -2712,16 +2722,12 @@ static void cifs_extend_writeback(struct address_=
space *mapping,
>                         if (!folio_clear_dirty_for_io(folio))
>                                 WARN_ON(1);
>                         folio_start_writeback(folio);
> -
> -                       *_count -=3D folio_nr_pages(folio);
>                         folio_unlock(folio);
>                 }
>
>                 folio_batch_release(&batch);
>                 cond_resched();
>         } while (!stop);
> -
> -       *_len =3D len;
>  }
>
>  /*
> @@ -2729,8 +2735,10 @@ static void cifs_extend_writeback(struct address_s=
pace *mapping,
>   */
>  static ssize_t cifs_write_back_from_locked_folio(struct address_space *m=
apping,
>                                                  struct writeback_control=
 *wbc,
> +                                                struct xa_state *xas,
>                                                  struct folio *folio,
> -                                                loff_t start, loff_t end=
)
> +                                                unsigned long long start=
,
> +                                                unsigned long long end)
>  {
>         struct inode *inode =3D mapping->host;
>         struct TCP_Server_Info *server;
> @@ -2739,17 +2747,18 @@ static ssize_t cifs_write_back_from_locked_folio(=
struct address_space *mapping,
>         struct cifs_credits credits_on_stack;
>         struct cifs_credits *credits =3D &credits_on_stack;
>         struct cifsFileInfo *cfile =3D NULL;
> -       unsigned int xid, wsize, len;
> -       loff_t i_size =3D i_size_read(inode);
> -       size_t max_len;
> +       unsigned long long i_size =3D i_size_read(inode), max_len;
> +       unsigned int xid, wsize;
> +       size_t len;
>         long count =3D wbc->nr_to_write;
>         int rc;
>
>         /* The folio should be locked, dirty and not undergoing writeback=
. */
> +       if (!folio_clear_dirty_for_io(folio))
> +               BUG();
>         folio_start_writeback(folio);
>
>         count -=3D folio_nr_pages(folio);
> -       len =3D folio_size(folio);
>
>         xid =3D get_xid();
>         server =3D cifs_pick_channel(cifs_sb_master_tcon(cifs_sb)->ses);
> @@ -2779,10 +2788,12 @@ static ssize_t cifs_write_back_from_locked_folio(=
struct address_space *mapping,
>         wdata->server =3D server;
>         cfile =3D NULL;
>
> -       /* Find all consecutive lockable dirty pages, stopping when we fi=
nd a
> -        * page that is not immediately lockable, is not dirty or is miss=
ing,
> -        * or we reach the end of the range.
> +       /* Find all consecutive lockable dirty pages that have contiguous
> +        * written regions, stopping when we find a page that is not
> +        * immediately lockable, is not dirty or is missing, or we reach =
the
> +        * end of the range.
>          */
> +       len =3D folio_size(folio);
>         if (start < i_size) {
>                 /* Trim the write to the EOF; the extra data is ignored. =
 Also
>                  * put an upper limit on the size of a single storedata o=
p.
> @@ -2801,19 +2812,18 @@ static ssize_t cifs_write_back_from_locked_folio(=
struct address_space *mapping,
>                         max_pages -=3D folio_nr_pages(folio);
>
>                         if (max_pages > 0)
> -                               cifs_extend_writeback(mapping, &count, st=
art,
> +                               cifs_extend_writeback(mapping, xas, &coun=
t, start,
>                                                       max_pages, max_len,=
 &len);
>                 }
> -               len =3D min_t(loff_t, len, max_len);
>         }
> -
> -       wdata->bytes =3D len;
> +       len =3D min_t(unsigned long long, len, i_size - start);
>
>         /* We now have a contiguous set of dirty pages, each with writeba=
ck
>          * set; the first page is still locked at this point, but all the=
 rest
>          * have been unlocked.
>          */
>         folio_unlock(folio);
> +       wdata->bytes =3D len;
>
>         if (start < i_size) {
>                 iov_iter_xarray(&wdata->iter, ITER_SOURCE, &mapping->i_pa=
ges,
> @@ -2864,102 +2874,118 @@ static ssize_t cifs_write_back_from_locked_foli=
o(struct address_space *mapping,
>  /*
>   * write a region of pages back to the server
>   */
> -static int cifs_writepages_region(struct address_space *mapping,
> -                                 struct writeback_control *wbc,
> -                                 loff_t start, loff_t end, loff_t *_next=
)
> +static ssize_t cifs_writepages_begin(struct address_space *mapping,
> +                                    struct writeback_control *wbc,
> +                                    struct xa_state *xas,
> +                                    unsigned long long *_start,
> +                                    unsigned long long end)
>  {
> -       struct folio_batch fbatch;
> +       struct folio *folio;
> +       unsigned long long start =3D *_start;
> +       ssize_t ret;
>         int skips =3D 0;
>
> -       folio_batch_init(&fbatch);
> -       do {
> -               int nr;
> -               pgoff_t index =3D start / PAGE_SIZE;
> +search_again:
> +       /* Find the first dirty page. */
> +       rcu_read_lock();
>
> -               nr =3D filemap_get_folios_tag(mapping, &index, end / PAGE=
_SIZE,
> -                                           PAGECACHE_TAG_DIRTY, &fbatch)=
;
> -               if (!nr)
> +       for (;;) {
> +               folio =3D xas_find_marked(xas, end / PAGE_SIZE, PAGECACHE=
_TAG_DIRTY);
> +               if (xas_retry(xas, folio) || xa_is_value(folio))
> +                       continue;
> +               if (!folio)
>                         break;
>
> -               for (int i =3D 0; i < nr; i++) {
> -                       ssize_t ret;
> -                       struct folio *folio =3D fbatch.folios[i];
> +               if (!folio_try_get_rcu(folio)) {
> +                       xas_reset(xas);
> +                       continue;
> +               }
>
> -redo_folio:
> -                       start =3D folio_pos(folio); /* May regress with T=
HPs */
> +               if (unlikely(folio !=3D xas_reload(xas))) {
> +                       folio_put(folio);
> +                       xas_reset(xas);
> +                       continue;
> +               }
>
> -                       /* At this point we hold neither the i_pages lock=
 nor the
> -                        * page lock: the page may be truncated or invali=
dated
> -                        * (changing page->mapping to NULL), or even swiz=
zled
> -                        * back from swapper_space to tmpfs file mapping
> -                        */
> -                       if (wbc->sync_mode !=3D WB_SYNC_NONE) {
> -                               ret =3D folio_lock_killable(folio);
> -                               if (ret < 0)
> -                                       goto write_error;
> -                       } else {
> -                               if (!folio_trylock(folio))
> -                                       goto skip_write;
> -                       }
> +               xas_pause(xas);
> +               break;
> +       }
> +       rcu_read_unlock();
> +       if (!folio)
> +               return 0;
>
> -                       if (folio->mapping !=3D mapping ||
> -                           !folio_test_dirty(folio)) {
> -                               start +=3D folio_size(folio);
> -                               folio_unlock(folio);
> -                               continue;
> -                       }
> +       start =3D folio_pos(folio); /* May regress with THPs */
>
> -                       if (folio_test_writeback(folio) ||
> -                           folio_test_fscache(folio)) {
> -                               folio_unlock(folio);
> -                               if (wbc->sync_mode =3D=3D WB_SYNC_NONE)
> -                                       goto skip_write;
> +       /* At this point we hold neither the i_pages lock nor the page lo=
ck:
> +        * the page may be truncated or invalidated (changing page->mappi=
ng to
> +        * NULL), or even swizzled back from swapper_space to tmpfs file
> +        * mapping
> +        */
> +lock_again:
> +       if (wbc->sync_mode !=3D WB_SYNC_NONE) {
> +               ret =3D folio_lock_killable(folio);
> +               if (ret < 0)
> +                       return ret;
> +       } else {
> +               if (!folio_trylock(folio))
> +                       goto search_again;
> +       }
>
> -                               folio_wait_writeback(folio);
> +       if (folio->mapping !=3D mapping ||
> +           !folio_test_dirty(folio)) {
> +               start +=3D folio_size(folio);
> +               folio_unlock(folio);
> +               goto search_again;
> +       }
> +
> +       if (folio_test_writeback(folio) ||
> +           folio_test_fscache(folio)) {
> +               folio_unlock(folio);
> +               if (wbc->sync_mode !=3D WB_SYNC_NONE) {
> +                       folio_wait_writeback(folio);
>  #ifdef CONFIG_CIFS_FSCACHE
> -                               folio_wait_fscache(folio);
> +                       folio_wait_fscache(folio);
>  #endif
> -                               goto redo_folio;
> -                       }
> -
> -                       if (!folio_clear_dirty_for_io(folio))
> -                               /* We hold the page lock - it should've b=
een dirty. */
> -                               WARN_ON(1);
> -
> -                       ret =3D cifs_write_back_from_locked_folio(mapping=
, wbc, folio, start, end);
> -                       if (ret < 0)
> -                               goto write_error;
> -
> -                       start +=3D ret;
> -                       continue;
> -
> -write_error:
> -                       folio_batch_release(&fbatch);
> -                       *_next =3D start;
> -                       return ret;
> +                       goto lock_again;
> +               }
>
> -skip_write:
> -                       /*
> -                        * Too many skipped writes, or need to reschedule=
?
> -                        * Treat it as a write error without an error cod=
e.
> -                        */
> +               start +=3D folio_size(folio);
> +               if (wbc->sync_mode =3D=3D WB_SYNC_NONE) {
>                         if (skips >=3D 5 || need_resched()) {
>                                 ret =3D 0;
> -                               goto write_error;
> +                               goto out;
>                         }
> -
> -                       /* Otherwise, just skip that folio and go on to t=
he next */
>                         skips++;
> -                       start +=3D folio_size(folio);
> -                       continue;
>                 }
> +               goto search_again;
> +       }
>
> -               folio_batch_release(&fbatch);
> -               cond_resched();
> -       } while (wbc->nr_to_write > 0);
> +       ret =3D cifs_write_back_from_locked_folio(mapping, wbc, xas, foli=
o, start, end);
> +out:
> +       if (ret > 0)
> +               *_start =3D start + ret;
> +       return ret;
> +}
>
> -       *_next =3D start;
> -       return 0;
> +/*
> + * Write a region of pages back to the server
> + */
> +static int cifs_writepages_region(struct address_space *mapping,
> +                                 struct writeback_control *wbc,
> +                                 unsigned long long *_start,
> +                                 unsigned long long end)
> +{
> +       ssize_t ret;
> +
> +       XA_STATE(xas, &mapping->i_pages, *_start / PAGE_SIZE);
> +
> +       do {
> +               ret =3D cifs_writepages_begin(mapping, wbc, &xas, _start,=
 end);
> +               if (ret > 0 && wbc->nr_to_write > 0)
> +                       cond_resched();
> +       } while (ret > 0 && wbc->nr_to_write > 0);
> +
> +       return ret > 0 ? 0 : ret;
>  }
>
>  /*
> @@ -2968,7 +2994,7 @@ static int cifs_writepages_region(struct address_sp=
ace *mapping,
>  static int cifs_writepages(struct address_space *mapping,
>                            struct writeback_control *wbc)
>  {
> -       loff_t start, next;
> +       loff_t start, end;
>         int ret;
>
>         /* We have to be careful as we can end up racing with setattr()
> @@ -2976,28 +3002,34 @@ static int cifs_writepages(struct address_space *=
mapping,
>          * to prevent it.
>          */
>
> -       if (wbc->range_cyclic) {
> +       if (wbc->range_cyclic && mapping->writeback_index) {
>                 start =3D mapping->writeback_index * PAGE_SIZE;
> -               ret =3D cifs_writepages_region(mapping, wbc, start, LLONG=
_MAX, &next);
> -               if (ret =3D=3D 0) {
> -                       mapping->writeback_index =3D next / PAGE_SIZE;
> -                       if (start > 0 && wbc->nr_to_write > 0) {
> -                               ret =3D cifs_writepages_region(mapping, w=
bc, 0,
> -                                                            start, &next=
);
> -                               if (ret =3D=3D 0)
> -                                       mapping->writeback_index =3D
> -                                               next / PAGE_SIZE;
> -                       }
> +               ret =3D cifs_writepages_region(mapping, wbc, &start, LLON=
G_MAX);
> +               if (ret < 0)
> +                       goto out;
> +
> +               if (wbc->nr_to_write <=3D 0) {
> +                       mapping->writeback_index =3D start / PAGE_SIZE;
> +                       goto out;
>                 }
> +
> +               start =3D 0;
> +               end =3D mapping->writeback_index * PAGE_SIZE;
> +               mapping->writeback_index =3D 0;
> +               ret =3D cifs_writepages_region(mapping, wbc, &start, end)=
;
> +               if (ret =3D=3D 0)
> +                       mapping->writeback_index =3D start / PAGE_SIZE;
>         } else if (wbc->range_start =3D=3D 0 && wbc->range_end =3D=3D LLO=
NG_MAX) {
> -               ret =3D cifs_writepages_region(mapping, wbc, 0, LLONG_MAX=
, &next);
> +               start =3D 0;
> +               ret =3D cifs_writepages_region(mapping, wbc, &start, LLON=
G_MAX);
>                 if (wbc->nr_to_write > 0 && ret =3D=3D 0)
> -                       mapping->writeback_index =3D next / PAGE_SIZE;
> +                       mapping->writeback_index =3D start / PAGE_SIZE;
>         } else {
> -               ret =3D cifs_writepages_region(mapping, wbc,
> -                                            wbc->range_start, wbc->range=
_end, &next);
> +               start =3D wbc->range_start;
> +               ret =3D cifs_writepages_region(mapping, wbc, &start, wbc-=
>range_end);
>         }
>
> +out:
>         return ret;
>  }
>
>


--=20
Thanks,

Steve

