Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071CD4A3D2B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 06:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357677AbiAaFGk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 00:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357671AbiAaFGg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 00:06:36 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED51C061714;
        Sun, 30 Jan 2022 21:06:35 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id a28so24370222lfl.7;
        Sun, 30 Jan 2022 21:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GSWyZlg3tzmrI8crvohO9yqt+/mDRjfIyMIybrB4zPs=;
        b=FsEnd338Bgsn+MZ6DlG6IOWZuBhP1v9/h/eeoANH3YRZ8LrYyoMX+XGZ1I9CY1fTr6
         g2Eq8rPaC+6LqDl9+Dn/5ThVbUxBbX1XMR2ejBaHO9ECXwKgWvSoSbx0nud6taLfqGhH
         A9YkIhANRUAAI3t30tIM+MY11Dq9S8fdbQzcDddNKK02aysfKH/bgP92c2vMAwT+1ZWB
         iyOvUW8kAbDT2XuYiLt1jkvR9GubDzo0Uc5yUHEyskankTDVM2SP5q+oYp63x3JCyYF+
         Tn+/W1r6w/snE8OPSsamx46DZu94qqcUfg6oFmpuGIVNFJnmQag4jL6WlmB69/3HRW1q
         +vlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GSWyZlg3tzmrI8crvohO9yqt+/mDRjfIyMIybrB4zPs=;
        b=4GHnWnx5o7ykPHqHmUGTcFsrG8Rx3LzUpUL+4OKp/KNLLc1ZqAmSZVh/ywv88/9flX
         7K4mD/jirmS3low7P9Y854gOxXeQqQ38JJ0bRFa8BJK5wU5yBjzFpR6i8Wtw7J27Iw/A
         XemBvHj5tqDGYP7EgsDn4VzhdD0D368ZkUlFOryuHSy+TVf6O5edQsRu836lE86v4B/0
         KwXD6AJGb90czOJqLqB0PFvopsURSvNu36YYUMrqTffiiFCx3jyIdFEEjhcqRzexT/ya
         I+8GADYPIYd22l80Y68xTRSGmdNnODTLNrSc+DzOX+GAMU5no9vvvAK0tj738hiwkbFp
         OfzA==
X-Gm-Message-State: AOAM533QoDp8rl4W+tUpGbr6UCNIxesDUH722HdWeCBYNxngprmLbTHn
        yOkW6u+Ljn2oapuFv82VUrXut7AnxGZoyiesVglYanESICE=
X-Google-Smtp-Source: ABdhPJyIZYPIy+BlHYuet7cfC/udZRLPWkRKgpry8M/cs3YfgUuwWFOkQnd4mc/nZebghh+QOuFmhKejCxR1jwbshLE=
X-Received: by 2002:ac2:4da8:: with SMTP id h8mr13818261lfe.323.1643605593153;
 Sun, 30 Jan 2022 21:06:33 -0800 (PST)
MIME-Version: 1.0
References: <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk>
 <164311907995.2806745.400147335497304099.stgit@warthog.procyon.org.uk>
In-Reply-To: <164311907995.2806745.400147335497304099.stgit@warthog.procyon.org.uk>
From:   Rohith Surabattula <rohiths.msft@gmail.com>
Date:   Mon, 31 Jan 2022 10:36:27 +0530
Message-ID: <CACdtm0bi4O36cif-iwarBb2oNOj-qjECr0iPAHK821E07u7p8A@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] cifs: Change the I/O paths to use an iterator
 rather than a page list
To:     David Howells <dhowells@redhat.com>
Cc:     smfrench@gmail.com, nspmangalore@gmail.com, jlayton@kernel.org,
        linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

After copying the buf to the XArray iterator, "got_bytes" field is not
updated. As a result, the read of data which is less than page size
failed.
Below is the patch to fix the above issue.

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index e1649ac194db..5faf45672891 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4917,6 +4917,7 @@ handle_read_data(struct TCP_Server_Info *server,
struct mid_q_entry *mid,
                length = copy_to_iter(buf + data_offset, data_len,
&rdata->iter);
                if (length < 0)
                        return length;
+               rdata->got_bytes = data_len;
        } else {
                /* read response payload cannot be in both buf and pages */
                WARN_ONCE(1, "buf can not contain only a part of read data");

Regards,
Rohith

On Wed, Jan 26, 2022 at 1:21 AM David Howells <dhowells@redhat.com> wrote:
>
>
> ---
>
>  fs/cifs/cifsencrypt.c |   40 +++--
>  fs/cifs/cifsfs.c      |    2
>  fs/cifs/cifsfs.h      |    3
>  fs/cifs/cifsglob.h    |   28 +---
>  fs/cifs/cifsproto.h   |   10 +
>  fs/cifs/cifssmb.c     |  224 +++++++++++++++++++-----------
>  fs/cifs/connect.c     |   16 ++
>  fs/cifs/misc.c        |   19 ---
>  fs/cifs/smb2ops.c     |  365 ++++++++++++++++++++++++-------------------------
>  fs/cifs/smb2pdu.c     |   12 --
>  fs/cifs/transport.c   |   37 +----
>  11 files changed, 379 insertions(+), 377 deletions(-)
>
> diff --git a/fs/cifs/cifsencrypt.c b/fs/cifs/cifsencrypt.c
> index 0912d8bbbac1..69bbf3d6c4d4 100644
> --- a/fs/cifs/cifsencrypt.c
> +++ b/fs/cifs/cifsencrypt.c
> @@ -24,12 +24,27 @@
>  #include "../smbfs_common/arc4.h"
>  #include <crypto/aead.h>
>
> +static ssize_t cifs_signature_scan(struct iov_iter *i, const void *p,
> +                                  size_t len, size_t off, void *priv)
> +{
> +       struct shash_desc *shash = priv;
> +       int rc;
> +
> +       rc = crypto_shash_update(shash, p, len);
> +       if (rc) {
> +               cifs_dbg(VFS, "%s: Could not update with payload\n", __func__);
> +               return rc;
> +       }
> +
> +       return len;
> +}
> +
>  int __cifs_calc_signature(struct smb_rqst *rqst,
>                         struct TCP_Server_Info *server, char *signature,
>                         struct shash_desc *shash)
>  {
>         int i;
> -       int rc;
> +       ssize_t rc;
>         struct kvec *iov = rqst->rq_iov;
>         int n_vec = rqst->rq_nvec;
>         int is_smb2 = server->vals->header_preamble_size == 0;
> @@ -62,25 +77,10 @@ int __cifs_calc_signature(struct smb_rqst *rqst,
>                 }
>         }
>
> -       /* now hash over the rq_pages array */
> -       for (i = 0; i < rqst->rq_npages; i++) {
> -               void *kaddr;
> -               unsigned int len, offset;
> -
> -               rqst_page_get_length(rqst, i, &len, &offset);
> -
> -               kaddr = (char *) kmap(rqst->rq_pages[i]) + offset;
> -
> -               rc = crypto_shash_update(shash, kaddr, len);
> -               if (rc) {
> -                       cifs_dbg(VFS, "%s: Could not update with payload\n",
> -                                __func__);
> -                       kunmap(rqst->rq_pages[i]);
> -                       return rc;
> -               }
> -
> -               kunmap(rqst->rq_pages[i]);
> -       }
> +       rc = iov_iter_scan(&rqst->rq_iter, iov_iter_count(&rqst->rq_iter),
> +                          cifs_signature_scan, shash);
> +       if (rc < 0)
> +               return rc;
>
>         rc = crypto_shash_final(shash, signature);
>         if (rc)
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index 199edac0cb59..a56cb9c8c5ff 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -935,7 +935,7 @@ cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>         ssize_t rc;
>         struct inode *inode = file_inode(iocb->ki_filp);
>
> -       if (iocb->ki_filp->f_flags & O_DIRECT)
> +       if (iocb->ki_flags & IOCB_DIRECT)
>                 return cifs_user_readv(iocb, iter);
>
>         rc = cifs_revalidate_mapping(inode);
> diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
> index 15a5c5db038b..1c77bbc0815f 100644
> --- a/fs/cifs/cifsfs.h
> +++ b/fs/cifs/cifsfs.h
> @@ -110,6 +110,9 @@ extern int cifs_file_strict_mmap(struct file * , struct vm_area_struct *);
>  extern const struct file_operations cifs_dir_ops;
>  extern int cifs_dir_open(struct inode *inode, struct file *file);
>  extern int cifs_readdir(struct file *file, struct dir_context *ctx);
> +extern void cifs_pages_written_back(struct inode *inode, loff_t start, unsigned int len);
> +extern void cifs_pages_write_failed(struct inode *inode, loff_t start, unsigned int len);
> +extern void cifs_pages_write_redirty(struct inode *inode, loff_t start, unsigned int len);
>
>  /* Functions related to dir entries */
>  extern const struct dentry_operations cifs_dentry_ops;
> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> index 0a4085ced40f..3a4fed645636 100644
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -191,11 +191,8 @@ struct cifs_cred {
>  struct smb_rqst {
>         struct kvec     *rq_iov;        /* array of kvecs */
>         unsigned int    rq_nvec;        /* number of kvecs in array */
> -       struct page     **rq_pages;     /* pointer to array of page ptrs */
> -       unsigned int    rq_offset;      /* the offset to the 1st page */
> -       unsigned int    rq_npages;      /* number pages in array */
> -       unsigned int    rq_pagesz;      /* page size to use */
> -       unsigned int    rq_tailsz;      /* length of last page */
> +       struct iov_iter rq_iter;        /* Data iterator */
> +       struct xarray   rq_buffer;      /* Page buffer for encryption */
>  };
>
>  struct mid_q_entry;
> @@ -1323,28 +1320,18 @@ struct cifs_readdata {
>         struct address_space            *mapping;
>         struct cifs_aio_ctx             *ctx;
>         __u64                           offset;
> +       ssize_t                         got_bytes;
>         unsigned int                    bytes;
> -       unsigned int                    got_bytes;
>         pid_t                           pid;
>         int                             result;
>         struct work_struct              work;
> -       int (*read_into_pages)(struct TCP_Server_Info *server,
> -                               struct cifs_readdata *rdata,
> -                               unsigned int len);
> -       int (*copy_into_pages)(struct TCP_Server_Info *server,
> -                               struct cifs_readdata *rdata,
> -                               struct iov_iter *iter);
> +       struct iov_iter                 iter;
>         struct kvec                     iov[2];
>         struct TCP_Server_Info          *server;
>  #ifdef CONFIG_CIFS_SMB_DIRECT
>         struct smbd_mr                  *mr;
>  #endif
> -       unsigned int                    pagesz;
> -       unsigned int                    page_offset;
> -       unsigned int                    tailsz;
>         struct cifs_credits             credits;
> -       unsigned int                    nr_pages;
> -       struct page                     **pages;
>  };
>
>  /* asynchronous write support */
> @@ -1356,6 +1343,8 @@ struct cifs_writedata {
>         struct work_struct              work;
>         struct cifsFileInfo             *cfile;
>         struct cifs_aio_ctx             *ctx;
> +       struct iov_iter                 iter;
> +       struct bio_vec                  *bv;
>         __u64                           offset;
>         pid_t                           pid;
>         unsigned int                    bytes;
> @@ -1364,12 +1353,7 @@ struct cifs_writedata {
>  #ifdef CONFIG_CIFS_SMB_DIRECT
>         struct smbd_mr                  *mr;
>  #endif
> -       unsigned int                    pagesz;
> -       unsigned int                    page_offset;
> -       unsigned int                    tailsz;
>         struct cifs_credits             credits;
> -       unsigned int                    nr_pages;
> -       struct page                     **pages;
>  };
>
>  /*
> diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
> index d3701295402d..1b143f0a03c0 100644
> --- a/fs/cifs/cifsproto.h
> +++ b/fs/cifs/cifsproto.h
> @@ -242,6 +242,9 @@ extern int cifs_read_page_from_socket(struct TCP_Server_Info *server,
>                                         unsigned int page_offset,
>                                         unsigned int to_read);
>  extern int cifs_setup_cifs_sb(struct cifs_sb_info *cifs_sb);
> +extern int cifs_read_iter_from_socket(struct TCP_Server_Info *server,
> +                                     struct iov_iter *iter,
> +                                     unsigned int to_read);
>  extern int cifs_match_super(struct super_block *, void *);
>  extern int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx);
>  extern void cifs_umount(struct cifs_sb_info *);
> @@ -575,10 +578,7 @@ int cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid);
>  int cifs_async_writev(struct cifs_writedata *wdata,
>                       void (*release)(struct kref *kref));
>  void cifs_writev_complete(struct work_struct *work);
> -struct cifs_writedata *cifs_writedata_alloc(unsigned int nr_pages,
> -                                               work_func_t complete);
> -struct cifs_writedata *cifs_writedata_direct_alloc(struct page **pages,
> -                                               work_func_t complete);
> +struct cifs_writedata *cifs_writedata_alloc(work_func_t complete);
>  void cifs_writedata_release(struct kref *refcount);
>  int cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
>                           struct cifs_sb_info *cifs_sb,
> @@ -602,8 +602,6 @@ int cifs_alloc_hash(const char *name, struct crypto_shash **shash,
>                     struct sdesc **sdesc);
>  void cifs_free_hash(struct crypto_shash **shash, struct sdesc **sdesc);
>
> -extern void rqst_page_get_length(struct smb_rqst *rqst, unsigned int page,
> -                               unsigned int *len, unsigned int *offset);
>  struct cifs_chan *
>  cifs_ses_find_chan(struct cifs_ses *ses, struct TCP_Server_Info *server);
>  int cifs_try_adding_channels(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses);
> diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> index 071e2f21a7db..38e7276352e2 100644
> --- a/fs/cifs/cifssmb.c
> +++ b/fs/cifs/cifssmb.c
> @@ -24,6 +24,7 @@
>  #include <linux/task_io_accounting_ops.h>
>  #include <linux/uaccess.h>
>  #include "cifspdu.h"
> +#include "cifsfs.h"
>  #include "cifsglob.h"
>  #include "cifsacl.h"
>  #include "cifsproto.h"
> @@ -1388,11 +1389,11 @@ int
>  cifs_discard_remaining_data(struct TCP_Server_Info *server)
>  {
>         unsigned int rfclen = server->pdu_size;
> -       int remaining = rfclen + server->vals->header_preamble_size -
> +       size_t remaining = rfclen + server->vals->header_preamble_size -
>                 server->total_read;
>
>         while (remaining > 0) {
> -               int length;
> +               ssize_t length;
>
>                 length = cifs_discard_from_socket(server,
>                                 min_t(size_t, remaining,
> @@ -1539,10 +1540,15 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
>                 return cifs_readv_discard(server, mid);
>         }
>
> -       length = rdata->read_into_pages(server, rdata, data_len);
> -       if (length < 0)
> -               return length;
> -
> +#ifdef CONFIG_CIFS_SMB_DIRECT
> +       if (rdata->mr)
> +               length = data_len; /* An RDMA read is already done. */
> +       else
> +#endif
> +               length = cifs_read_iter_from_socket(server, &rdata->iter,
> +                                                   data_len);
> +       if (length > 0)
> +               rdata->got_bytes += length;
>         server->total_read += length;
>
>         cifs_dbg(FYI, "total_read=%u buflen=%u remaining=%u\n",
> @@ -1566,11 +1572,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
>         struct TCP_Server_Info *server = tcon->ses->server;
>         struct smb_rqst rqst = { .rq_iov = rdata->iov,
>                                  .rq_nvec = 2,
> -                                .rq_pages = rdata->pages,
> -                                .rq_offset = rdata->page_offset,
> -                                .rq_npages = rdata->nr_pages,
> -                                .rq_pagesz = rdata->pagesz,
> -                                .rq_tailsz = rdata->tailsz };
> +                                .rq_iter = rdata->iter };
>         struct cifs_credits credits = { .value = 1, .instance = 0 };
>
>         cifs_dbg(FYI, "%s: mid=%llu state=%d result=%d bytes=%u\n",
> @@ -1925,10 +1927,93 @@ cifs_writedata_release(struct kref *refcount)
>         if (wdata->cfile)
>                 cifsFileInfo_put(wdata->cfile);
>
> -       kvfree(wdata->pages);
>         kfree(wdata);
>  }
>
> +/*
> + * Completion of write to server.
> + */
> +void cifs_pages_written_back(struct inode *inode, loff_t start, unsigned int len)
> +{
> +       struct address_space *mapping = inode->i_mapping;
> +       struct folio *folio;
> +       pgoff_t end;
> +
> +       XA_STATE(xas, &mapping->i_pages, start / PAGE_SIZE);
> +
> +       rcu_read_lock();
> +
> +       end = (start + len - 1) / PAGE_SIZE;
> +       xas_for_each(&xas, folio, end) {
> +               if (!folio_test_writeback(folio)) {
> +                       pr_err("bad %x @%llx page %lx %lx\n",
> +                              len, start, folio_index(folio), end);
> +                       BUG();
> +               }
> +
> +               folio_detach_private(folio);
> +               folio_end_writeback(folio);
> +       }
> +
> +       rcu_read_unlock();
> +}
> +
> +/*
> + * Failure of write to server.
> + */
> +void cifs_pages_write_failed(struct inode *inode, loff_t start, unsigned int len)
> +{
> +       struct address_space *mapping = inode->i_mapping;
> +       struct folio *folio;
> +       pgoff_t end;
> +
> +       XA_STATE(xas, &mapping->i_pages, start / PAGE_SIZE);
> +
> +       rcu_read_lock();
> +
> +       end = (start + len - 1) / PAGE_SIZE;
> +       xas_for_each(&xas, folio, end) {
> +               if (!folio_test_writeback(folio)) {
> +                       pr_err("bad %x @%llx page %lx %lx\n",
> +                              len, start, folio_index(folio), end);
> +                       BUG();
> +               }
> +
> +               folio_set_error(folio);
> +               folio_end_writeback(folio);
> +       }
> +
> +       rcu_read_unlock();
> +}
> +
> +/*
> + * Redirty pages after a temporary failure.
> + */
> +void cifs_pages_write_redirty(struct inode *inode, loff_t start, unsigned int len)
> +{
> +       struct address_space *mapping = inode->i_mapping;
> +       struct folio *folio;
> +       pgoff_t end;
> +
> +       XA_STATE(xas, &mapping->i_pages, start / PAGE_SIZE);
> +
> +       rcu_read_lock();
> +
> +       end = (start + len - 1) / PAGE_SIZE;
> +       xas_for_each(&xas, folio, end) {
> +               if (!folio_test_writeback(folio)) {
> +                       pr_err("bad %x @%llx page %lx %lx\n",
> +                              len, start, folio_index(folio), end);
> +                       BUG();
> +               }
> +
> +               filemap_dirty_folio(folio->mapping, folio);
> +               folio_end_writeback(folio);
> +       }
> +
> +       rcu_read_unlock();
> +}
> +
>  /*
>   * Write failed with a retryable error. Resend the write request. It's also
>   * possible that the page was redirtied so re-clean the page.
> @@ -1936,51 +2021,56 @@ cifs_writedata_release(struct kref *refcount)
>  static void
>  cifs_writev_requeue(struct cifs_writedata *wdata)
>  {
> -       int i, rc = 0;
> +       int rc = 0;
>         struct inode *inode = d_inode(wdata->cfile->dentry);
>         struct TCP_Server_Info *server;
> -       unsigned int rest_len;
> +       unsigned int rest_len = wdata->bytes;
> +       loff_t fpos = wdata->offset;
>
>         server = tlink_tcon(wdata->cfile->tlink)->ses->server;
> -       i = 0;
> -       rest_len = wdata->bytes;
>         do {
>                 struct cifs_writedata *wdata2;
> -               unsigned int j, nr_pages, wsize, tailsz, cur_len;
> +               unsigned int wsize, cur_len;
>
>                 wsize = server->ops->wp_retry_size(inode);
>                 if (wsize < rest_len) {
> -                       nr_pages = wsize / PAGE_SIZE;
> -                       if (!nr_pages) {
> +                       if (wsize < PAGE_SIZE) {
>                                 rc = -ENOTSUPP;
>                                 break;
>                         }
> -                       cur_len = nr_pages * PAGE_SIZE;
> -                       tailsz = PAGE_SIZE;
> +                       cur_len = min(round_down(wsize, PAGE_SIZE), rest_len);
>                 } else {
> -                       nr_pages = DIV_ROUND_UP(rest_len, PAGE_SIZE);
>                         cur_len = rest_len;
> -                       tailsz = rest_len - (nr_pages - 1) * PAGE_SIZE;
>                 }
>
> -               wdata2 = cifs_writedata_alloc(nr_pages, cifs_writev_complete);
> +               wdata2 = cifs_writedata_alloc(cifs_writev_complete);
>                 if (!wdata2) {
>                         rc = -ENOMEM;
>                         break;
>                 }
>
> -               for (j = 0; j < nr_pages; j++) {
> -                       wdata2->pages[j] = wdata->pages[i + j];
> -                       lock_page(wdata2->pages[j]);
> -                       clear_page_dirty_for_io(wdata2->pages[j]);
> -               }
> -
>                 wdata2->sync_mode = wdata->sync_mode;
> -               wdata2->nr_pages = nr_pages;
> -               wdata2->offset = page_offset(wdata2->pages[0]);
> -               wdata2->pagesz = PAGE_SIZE;
> -               wdata2->tailsz = tailsz;
> -               wdata2->bytes = cur_len;
> +               wdata2->offset  = fpos;
> +               wdata2->bytes   = cur_len;
> +               wdata2->iter    = wdata->iter;
> +
> +               iov_iter_advance(&wdata2->iter, fpos - wdata->offset);
> +               iov_iter_truncate(&wdata2->iter, wdata2->bytes);
> +
> +#if 0
> +               if (iov_iter_is_xarray(&wdata2->iter)) {
> +                       /* TODO: Check for pages having been redirtied and
> +                        * clean them.  We can do this by walking the xarray.
> +                        * If it's not an xarray, then it's a DIO and we
> +                        * shouldn't be mucking around with the page bits.
> +                        */
> +                       for (j = 0; j < nr_pages; j++) {
> +                               wdata2->pages[j] = wdata->pages[i + j];
> +                               lock_page(wdata2->pages[j]);
> +                               clear_page_dirty_for_io(wdata2->pages[j]);
> +                       }
> +               }
> +#endif
>
>                 rc = cifs_get_writable_file(CIFS_I(inode), FIND_WR_ANY,
>                                             &wdata2->cfile);
> @@ -1995,33 +2085,25 @@ cifs_writev_requeue(struct cifs_writedata *wdata)
>                                                        cifs_writedata_release);
>                 }
>
> -               for (j = 0; j < nr_pages; j++) {
> -                       unlock_page(wdata2->pages[j]);
> -                       if (rc != 0 && !is_retryable_error(rc)) {
> -                               SetPageError(wdata2->pages[j]);
> -                               end_page_writeback(wdata2->pages[j]);
> -                               put_page(wdata2->pages[j]);
> -                       }
> -               }
> +               if (iov_iter_is_xarray(&wdata2->iter))
> +                       cifs_pages_written_back(inode, wdata2->offset, wdata2->bytes);
>
>                 kref_put(&wdata2->refcount, cifs_writedata_release);
>                 if (rc) {
>                         if (is_retryable_error(rc))
>                                 continue;
> -                       i += nr_pages;
> +                       fpos += cur_len;
> +                       rest_len -= cur_len;
>                         break;
>                 }
>
> +               fpos += cur_len;
>                 rest_len -= cur_len;
> -               i += nr_pages;
> -       } while (i < wdata->nr_pages);
> +       } while (rest_len > 0);
>
> -       /* cleanup remaining pages from the original wdata */
> -       for (; i < wdata->nr_pages; i++) {
> -               SetPageError(wdata->pages[i]);
> -               end_page_writeback(wdata->pages[i]);
> -               put_page(wdata->pages[i]);
> -       }
> +       /* Clean up remaining pages from the original wdata */
> +       if (iov_iter_is_xarray(&wdata->iter))
> +               cifs_pages_written_back(inode, fpos, rest_len);
>
>         if (rc != 0 && !is_retryable_error(rc))
>                 mapping_set_error(inode->i_mapping, rc);
> @@ -2034,7 +2116,6 @@ cifs_writev_complete(struct work_struct *work)
>         struct cifs_writedata *wdata = container_of(work,
>                                                 struct cifs_writedata, work);
>         struct inode *inode = d_inode(wdata->cfile->dentry);
> -       int i = 0;
>
>         if (wdata->result == 0) {
>                 spin_lock(&inode->i_lock);
> @@ -2045,40 +2126,25 @@ cifs_writev_complete(struct work_struct *work)
>         } else if (wdata->sync_mode == WB_SYNC_ALL && wdata->result == -EAGAIN)
>                 return cifs_writev_requeue(wdata);
>
> -       for (i = 0; i < wdata->nr_pages; i++) {
> -               struct page *page = wdata->pages[i];
> -               if (wdata->result == -EAGAIN)
> -                       __set_page_dirty_nobuffers(page);
> -               else if (wdata->result < 0)
> -                       SetPageError(page);
> -               end_page_writeback(page);
> -               cifs_readpage_to_fscache(inode, page);
> -               put_page(page);
> -       }
> +       if (wdata->result == -EAGAIN)
> +               cifs_pages_write_redirty(inode, wdata->offset, wdata->bytes);
> +       else if (wdata->result < 0)
> +               cifs_pages_write_failed(inode, wdata->offset, wdata->bytes);
> +       else
> +               cifs_pages_written_back(inode, wdata->offset, wdata->bytes);
> +
>         if (wdata->result != -EAGAIN)
>                 mapping_set_error(inode->i_mapping, wdata->result);
>         kref_put(&wdata->refcount, cifs_writedata_release);
>  }
>
>  struct cifs_writedata *
> -cifs_writedata_alloc(unsigned int nr_pages, work_func_t complete)
> -{
> -       struct page **pages =
> -               kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
> -       if (pages)
> -               return cifs_writedata_direct_alloc(pages, complete);
> -
> -       return NULL;
> -}
> -
> -struct cifs_writedata *
> -cifs_writedata_direct_alloc(struct page **pages, work_func_t complete)
> +cifs_writedata_alloc(work_func_t complete)
>  {
>         struct cifs_writedata *wdata;
>
>         wdata = kzalloc(sizeof(*wdata), GFP_NOFS);
>         if (wdata != NULL) {
> -               wdata->pages = pages;
>                 kref_init(&wdata->refcount);
>                 INIT_LIST_HEAD(&wdata->list);
>                 init_completion(&wdata->done);
> @@ -2186,11 +2252,7 @@ cifs_async_writev(struct cifs_writedata *wdata,
>
>         rqst.rq_iov = iov;
>         rqst.rq_nvec = 2;
> -       rqst.rq_pages = wdata->pages;
> -       rqst.rq_offset = wdata->page_offset;
> -       rqst.rq_npages = wdata->nr_pages;
> -       rqst.rq_pagesz = wdata->pagesz;
> -       rqst.rq_tailsz = wdata->tailsz;
> +       rqst.rq_iter = wdata->iter;
>
>         cifs_dbg(FYI, "async write at %llu %u bytes\n",
>                  wdata->offset, wdata->bytes);
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index ed210d774a21..d0851c9881b3 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -704,6 +704,22 @@ cifs_read_page_from_socket(struct TCP_Server_Info *server, struct page *page,
>         return cifs_readv_from_socket(server, &smb_msg);
>  }
>
> +int
> +cifs_read_iter_from_socket(struct TCP_Server_Info *server, struct iov_iter *iter,
> +                          unsigned int to_read)
> +{
> +       struct msghdr smb_msg;
> +       int ret;
> +
> +       smb_msg.msg_iter = *iter;
> +       if (smb_msg.msg_iter.count > to_read)
> +               smb_msg.msg_iter.count = to_read;
> +       ret = cifs_readv_from_socket(server, &smb_msg);
> +       if (ret > 0)
> +               iov_iter_advance(iter, ret);
> +       return ret;
> +}
> +
>  static bool
>  is_smb_response(struct TCP_Server_Info *server, unsigned char type)
>  {
> diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
> index 56598f7dbe00..f5fe5720456a 100644
> --- a/fs/cifs/misc.c
> +++ b/fs/cifs/misc.c
> @@ -1122,25 +1122,6 @@ cifs_free_hash(struct crypto_shash **shash, struct sdesc **sdesc)
>         *shash = NULL;
>  }
>
> -/**
> - * rqst_page_get_length - obtain the length and offset for a page in smb_rqst
> - * @rqst: The request descriptor
> - * @page: The index of the page to query
> - * @len: Where to store the length for this page:
> - * @offset: Where to store the offset for this page
> - */
> -void rqst_page_get_length(struct smb_rqst *rqst, unsigned int page,
> -                               unsigned int *len, unsigned int *offset)
> -{
> -       *len = rqst->rq_pagesz;
> -       *offset = (page == 0) ? rqst->rq_offset : 0;
> -
> -       if (rqst->rq_npages == 1 || page == rqst->rq_npages-1)
> -               *len = rqst->rq_tailsz;
> -       else if (page == 0)
> -               *len = rqst->rq_pagesz - rqst->rq_offset;
> -}
> -
>  void extract_unc_hostname(const char *unc, const char **h, size_t *len)
>  {
>         const char *end;
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index af5d0830bc8a..e1649ac194db 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -4406,15 +4406,30 @@ fill_transform_hdr(struct smb2_transform_hdr *tr_hdr, unsigned int orig_len,
>  static inline void smb2_sg_set_buf(struct scatterlist *sg, const void *buf,
>                                    unsigned int buflen)
>  {
> -       void *addr;
> +       struct page *page;
> +
>         /*
>          * VMAP_STACK (at least) puts stack into the vmalloc address space
>          */
>         if (is_vmalloc_addr(buf))
> -               addr = vmalloc_to_page(buf);
> +               page = vmalloc_to_page(buf);
>         else
> -               addr = virt_to_page(buf);
> -       sg_set_page(sg, addr, buflen, offset_in_page(buf));
> +               page = virt_to_page(buf);
> +       sg_set_page(sg, page, buflen, offset_in_page(buf));
> +}
> +
> +struct cifs_init_sg_priv {
> +               struct scatterlist *sg;
> +               unsigned int idx;
> +};
> +
> +static ssize_t cifs_init_sg_scan(struct iov_iter *i, const void *p,
> +                                size_t len, size_t off, void *_priv)
> +{
> +       struct cifs_init_sg_priv *priv = _priv;
> +
> +       smb2_sg_set_buf(&priv->sg[priv->idx++], p, len);
> +       return len;
>  }
>
>  /* Assumes the first rqst has a transform header as the first iov.
> @@ -4426,43 +4441,46 @@ static inline void smb2_sg_set_buf(struct scatterlist *sg, const void *buf,
>  static struct scatterlist *
>  init_sg(int num_rqst, struct smb_rqst *rqst, u8 *sign)
>  {
> +       struct cifs_init_sg_priv priv;
>         unsigned int sg_len;
> -       struct scatterlist *sg;
>         unsigned int i;
>         unsigned int j;
> -       unsigned int idx = 0;
> +       ssize_t rc;
>         int skip;
>
>         sg_len = 1;
> -       for (i = 0; i < num_rqst; i++)
> -               sg_len += rqst[i].rq_nvec + rqst[i].rq_npages;
> +       for (i = 0; i < num_rqst; i++) {
> +               unsigned int np = iov_iter_npages(&rqst[i].rq_iter, INT_MAX);
> +               sg_len += rqst[i].rq_nvec + np;
> +       }
>
> -       sg = kmalloc_array(sg_len, sizeof(struct scatterlist), GFP_KERNEL);
> -       if (!sg)
> +       priv.idx = 0;
> +       priv.sg = kmalloc_array(sg_len, sizeof(struct scatterlist), GFP_KERNEL);
> +       if (!priv.sg)
>                 return NULL;
>
> -       sg_init_table(sg, sg_len);
> +       sg_init_table(priv.sg, sg_len);
>         for (i = 0; i < num_rqst; i++) {
> +               struct iov_iter *iter = &rqst[i].rq_iter;
> +               size_t count = iov_iter_count(iter);
> +
>                 for (j = 0; j < rqst[i].rq_nvec; j++) {
>                         /*
>                          * The first rqst has a transform header where the
>                          * first 20 bytes are not part of the encrypted blob
>                          */
>                         skip = (i == 0) && (j == 0) ? 20 : 0;
> -                       smb2_sg_set_buf(&sg[idx++],
> +                       smb2_sg_set_buf(&priv.sg[priv.idx++],
>                                         rqst[i].rq_iov[j].iov_base + skip,
>                                         rqst[i].rq_iov[j].iov_len - skip);
> -                       }
> -
> -               for (j = 0; j < rqst[i].rq_npages; j++) {
> -                       unsigned int len, offset;
> -
> -                       rqst_page_get_length(&rqst[i], j, &len, &offset);
> -                       sg_set_page(&sg[idx++], rqst[i].rq_pages[j], len, offset);
>                 }
> +
> +               rc = iov_iter_scan(iter, count, cifs_init_sg_scan, &priv);
> +               iov_iter_revert(iter, count);
> +               WARN_ON(rc < 0);
>         }
> -       smb2_sg_set_buf(&sg[idx], sign, SMB2_SIGNATURE_SIZE);
> -       return sg;
> +       smb2_sg_set_buf(&priv.sg[priv.idx], sign, SMB2_SIGNATURE_SIZE);
> +       return priv.sg;
>  }
>
>  static int
> @@ -4599,18 +4617,30 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
>         return rc;
>  }
>
> +/*
> + * Clear a read buffer, discarding the folios which have XA_MARK_0 set.
> + */
> +static void cifs_clear_xarray_buffer(struct xarray *buffer)
> +{
> +       struct folio *folio;
> +       XA_STATE(xas, buffer, 0);
> +
> +       rcu_read_lock();
> +       xas_for_each_marked(&xas, folio, ULONG_MAX, XA_MARK_0) {
> +               folio_put(folio);
> +       }
> +       rcu_read_unlock();
> +       xa_destroy(buffer);
> +}
> +
>  void
>  smb3_free_compound_rqst(int num_rqst, struct smb_rqst *rqst)
>  {
> -       int i, j;
> +       int i;
>
> -       for (i = 0; i < num_rqst; i++) {
> -               if (rqst[i].rq_pages) {
> -                       for (j = rqst[i].rq_npages - 1; j >= 0; j--)
> -                               put_page(rqst[i].rq_pages[j]);
> -                       kfree(rqst[i].rq_pages);
> -               }
> -       }
> +       for (i = 0; i < num_rqst; i++)
> +               if (!xa_empty(&rqst[i].rq_buffer))
> +                       cifs_clear_xarray_buffer(&rqst[i].rq_buffer);
>  }
>
>  /*
> @@ -4630,50 +4660,51 @@ static int
>  smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
>                        struct smb_rqst *new_rq, struct smb_rqst *old_rq)
>  {
> -       struct page **pages;
>         struct smb2_transform_hdr *tr_hdr = new_rq[0].rq_iov[0].iov_base;
> -       unsigned int npages;
> +       struct page *page;
>         unsigned int orig_len = 0;
>         int i, j;
>         int rc = -ENOMEM;
>
>         for (i = 1; i < num_rqst; i++) {
> -               npages = old_rq[i - 1].rq_npages;
> -               pages = kmalloc_array(npages, sizeof(struct page *),
> -                                     GFP_KERNEL);
> -               if (!pages)
> -                       goto err_free;
> -
> -               new_rq[i].rq_pages = pages;
> -               new_rq[i].rq_npages = npages;
> -               new_rq[i].rq_offset = old_rq[i - 1].rq_offset;
> -               new_rq[i].rq_pagesz = old_rq[i - 1].rq_pagesz;
> -               new_rq[i].rq_tailsz = old_rq[i - 1].rq_tailsz;
> -               new_rq[i].rq_iov = old_rq[i - 1].rq_iov;
> -               new_rq[i].rq_nvec = old_rq[i - 1].rq_nvec;
> -
> -               orig_len += smb_rqst_len(server, &old_rq[i - 1]);
> -
> -               for (j = 0; j < npages; j++) {
> -                       pages[j] = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
> -                       if (!pages[j])
> -                               goto err_free;
> -               }
> -
> -               /* copy pages form the old */
> -               for (j = 0; j < npages; j++) {
> -                       char *dst, *src;
> -                       unsigned int offset, len;
> -
> -                       rqst_page_get_length(&new_rq[i], j, &len, &offset);
> -
> -                       dst = (char *) kmap(new_rq[i].rq_pages[j]) + offset;
> -                       src = (char *) kmap(old_rq[i - 1].rq_pages[j]) + offset;
> +               struct smb_rqst *old = &old_rq[i - 1];
> +               struct smb_rqst *new = &new_rq[i];
> +               struct xarray *buffer = &new->rq_buffer;
> +               unsigned int npages;
> +               size_t size = iov_iter_count(&old->rq_iter), seg, copied = 0;
> +
> +               xa_init(buffer);
> +
> +               if (size > 0) {
> +                       npages = DIV_ROUND_UP(size, PAGE_SIZE);
> +                       for (j = 0; j < npages; j++) {
> +                               void *o;
> +
> +                               rc = -ENOMEM;
> +                               page = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
> +                               if (!page)
> +                                       goto err_free;
> +                               page->index = j;
> +                               o = xa_store(buffer, j, page, GFP_KERNEL);
> +                               if (xa_is_err(o)) {
> +                                       rc = xa_err(o);
> +                                       put_page(page);
> +                                       goto err_free;
> +                               }
>
> -                       memcpy(dst, src, len);
> -                       kunmap(new_rq[i].rq_pages[j]);
> -                       kunmap(old_rq[i - 1].rq_pages[j]);
> +                               seg = min(size - copied, PAGE_SIZE);
> +                               if (copy_page_from_iter(page, 0, seg, &old->rq_iter) != seg) {
> +                                       rc = -EFAULT;
> +                                       goto err_free;
> +                               }
> +                               copied += seg;
> +                       }
> +                       iov_iter_xarray(&new->rq_iter, iov_iter_rw(&old->rq_iter),
> +                                       buffer, 0, size);
>                 }
> +               new->rq_iov = old->rq_iov;
> +               new->rq_nvec = old->rq_nvec;
> +               orig_len += smb_rqst_len(server, new);
>         }
>
>         /* fill the 1st iov with a transform header */
> @@ -4701,12 +4732,12 @@ smb3_is_transform_hdr(void *buf)
>
>  static int
>  decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
> -                unsigned int buf_data_size, struct page **pages,
> -                unsigned int npages, unsigned int page_data_size,
> +                unsigned int buf_data_size, struct iov_iter *iter,
>                  bool is_offloaded)
>  {
>         struct kvec iov[2];
>         struct smb_rqst rqst = {NULL};
> +       size_t iter_size = 0;
>         int rc;
>
>         iov[0].iov_base = buf;
> @@ -4716,10 +4747,10 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
>
>         rqst.rq_iov = iov;
>         rqst.rq_nvec = 2;
> -       rqst.rq_pages = pages;
> -       rqst.rq_npages = npages;
> -       rqst.rq_pagesz = PAGE_SIZE;
> -       rqst.rq_tailsz = (page_data_size % PAGE_SIZE) ? : PAGE_SIZE;
> +       if (iter) {
> +               rqst.rq_iter = *iter;
> +               iter_size = iov_iter_count(iter);
> +       }
>
>         rc = crypt_message(server, 1, &rqst, 0);
>         cifs_dbg(FYI, "Decrypt message returned %d\n", rc);
> @@ -4730,73 +4761,37 @@ decrypt_raw_data(struct TCP_Server_Info *server, char *buf,
>         memmove(buf, iov[1].iov_base, buf_data_size);
>
>         if (!is_offloaded)
> -               server->total_read = buf_data_size + page_data_size;
> +               server->total_read = buf_data_size + iter_size;
>
>         return rc;
>  }
>
>  static int
> -read_data_into_pages(struct TCP_Server_Info *server, struct page **pages,
> -                    unsigned int npages, unsigned int len)
> +cifs_copy_pages_to_iter(struct xarray *pages, unsigned int data_size,
> +                       unsigned int skip, struct iov_iter *iter)
>  {
> -       int i;
> -       int length;
> +       struct page *page;
> +       unsigned long index;
>
> -       for (i = 0; i < npages; i++) {
> -               struct page *page = pages[i];
> -               size_t n;
> +       xa_for_each(pages, index, page) {
> +               size_t n, len = min_t(unsigned int, PAGE_SIZE - skip, data_size);
>
> -               n = len;
> -               if (len >= PAGE_SIZE) {
> -                       /* enough data to fill the page */
> -                       n = PAGE_SIZE;
> -                       len -= n;
> -               } else {
> -                       zero_user(page, len, PAGE_SIZE - len);
> -                       len = 0;
> +               n = copy_page_to_iter(page, skip, len, iter);
> +               if (n != len) {
> +                       cifs_dbg(VFS, "%s: something went wrong\n", __func__);
> +                       return -EIO;
>                 }
> -               length = cifs_read_page_from_socket(server, page, 0, n);
> -               if (length < 0)
> -                       return length;
> -               server->total_read += length;
> +               data_size -= n;
> +               skip = 0;
>         }
>
>         return 0;
>  }
>
> -static int
> -init_read_bvec(struct page **pages, unsigned int npages, unsigned int data_size,
> -              unsigned int cur_off, struct bio_vec **page_vec)
> -{
> -       struct bio_vec *bvec;
> -       int i;
> -
> -       bvec = kcalloc(npages, sizeof(struct bio_vec), GFP_KERNEL);
> -       if (!bvec)
> -               return -ENOMEM;
> -
> -       for (i = 0; i < npages; i++) {
> -               bvec[i].bv_page = pages[i];
> -               bvec[i].bv_offset = (i == 0) ? cur_off : 0;
> -               bvec[i].bv_len = min_t(unsigned int, PAGE_SIZE, data_size);
> -               data_size -= bvec[i].bv_len;
> -       }
> -
> -       if (data_size != 0) {
> -               cifs_dbg(VFS, "%s: something went wrong\n", __func__);
> -               kfree(bvec);
> -               return -EIO;
> -       }
> -
> -       *page_vec = bvec;
> -       return 0;
> -}
> -
>  static int
>  handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
> -                char *buf, unsigned int buf_len, struct page **pages,
> -                unsigned int npages, unsigned int page_data_size,
> -                bool is_offloaded)
> +                char *buf, unsigned int buf_len, struct xarray *pages,
> +                unsigned int pages_len, bool is_offloaded)
>  {
>         unsigned int data_offset;
>         unsigned int data_len;
> @@ -4805,9 +4800,6 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
>         unsigned int pad_len;
>         struct cifs_readdata *rdata = mid->callback_data;
>         struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
> -       struct bio_vec *bvec = NULL;
> -       struct iov_iter iter;
> -       struct kvec iov;
>         int length;
>         bool use_rdma_mr = false;
>
> @@ -4896,7 +4888,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
>                         return 0;
>                 }
>
> -               if (data_len > page_data_size - pad_len) {
> +               if (data_len > pages_len - pad_len) {
>                         /* data_len is corrupt -- discard frame */
>                         rdata->result = -EIO;
>                         if (is_offloaded)
> @@ -4906,8 +4898,9 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
>                         return 0;
>                 }
>
> -               rdata->result = init_read_bvec(pages, npages, page_data_size,
> -                                              cur_off, &bvec);
> +               /* Copy the data to the output I/O iterator. */
> +               rdata->result = cifs_copy_pages_to_iter(pages, pages_len,
> +                                                       cur_off, &rdata->iter);
>                 if (rdata->result != 0) {
>                         if (is_offloaded)
>                                 mid->mid_state = MID_RESPONSE_MALFORMED;
> @@ -4915,14 +4908,15 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
>                                 dequeue_mid(mid, rdata->result);
>                         return 0;
>                 }
> +               rdata->got_bytes = pages_len;
>
> -               iov_iter_bvec(&iter, WRITE, bvec, npages, data_len);
>         } else if (buf_len >= data_offset + data_len) {
>                 /* read response payload is in buf */
> -               WARN_ONCE(npages > 0, "read data can be either in buf or in pages");
> -               iov.iov_base = buf + data_offset;
> -               iov.iov_len = data_len;
> -               iov_iter_kvec(&iter, WRITE, &iov, 1, data_len);
> +               WARN_ONCE(pages && !xa_empty(pages),
> +                         "read data can be either in buf or in pages");
> +               length = copy_to_iter(buf + data_offset, data_len, &rdata->iter);
> +               if (length < 0)
> +                       return length;
>         } else {
>                 /* read response payload cannot be in both buf and pages */
>                 WARN_ONCE(1, "buf can not contain only a part of read data");
> @@ -4934,13 +4928,6 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
>                 return 0;
>         }
>
> -       length = rdata->copy_into_pages(server, rdata, &iter);
> -
> -       kfree(bvec);
> -
> -       if (length < 0)
> -               return length;
> -
>         if (is_offloaded)
>                 mid->mid_state = MID_RESPONSE_RECEIVED;
>         else
> @@ -4951,9 +4938,8 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
>  struct smb2_decrypt_work {
>         struct work_struct decrypt;
>         struct TCP_Server_Info *server;
> -       struct page **ppages;
> +       struct xarray buffer;
>         char *buf;
> -       unsigned int npages;
>         unsigned int len;
>  };
>
> @@ -4962,11 +4948,13 @@ static void smb2_decrypt_offload(struct work_struct *work)
>  {
>         struct smb2_decrypt_work *dw = container_of(work,
>                                 struct smb2_decrypt_work, decrypt);
> -       int i, rc;
> +       int rc;
>         struct mid_q_entry *mid;
> +       struct iov_iter iter;
>
> +       iov_iter_xarray(&iter, READ, &dw->buffer, 0, dw->len);
>         rc = decrypt_raw_data(dw->server, dw->buf, dw->server->vals->read_rsp_size,
> -                             dw->ppages, dw->npages, dw->len, true);
> +                             &iter, true);
>         if (rc) {
>                 cifs_dbg(VFS, "error decrypting rc=%d\n", rc);
>                 goto free_pages;
> @@ -4980,7 +4968,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
>                 mid->decrypted = true;
>                 rc = handle_read_data(dw->server, mid, dw->buf,
>                                       dw->server->vals->read_rsp_size,
> -                                     dw->ppages, dw->npages, dw->len,
> +                                     &dw->buffer, dw->len,
>                                       true);
>                 if (rc >= 0) {
>  #ifdef CONFIG_CIFS_STATS2
> @@ -5012,10 +5000,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
>         }
>
>  free_pages:
> -       for (i = dw->npages-1; i >= 0; i--)
> -               put_page(dw->ppages[i]);
> -
> -       kfree(dw->ppages);
> +       cifs_clear_xarray_buffer(&dw->buffer);
>         cifs_small_buf_release(dw->buf);
>         kfree(dw);
>  }
> @@ -5025,47 +5010,66 @@ static int
>  receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
>                        int *num_mids)
>  {
> +       struct page *page;
>         char *buf = server->smallbuf;
>         struct smb2_transform_hdr *tr_hdr = (struct smb2_transform_hdr *)buf;
> -       unsigned int npages;
> -       struct page **pages;
> -       unsigned int len;
> +       struct iov_iter iter;
> +       unsigned int len, npages;
>         unsigned int buflen = server->pdu_size;
>         int rc;
>         int i = 0;
>         struct smb2_decrypt_work *dw;
>
> +       dw = kzalloc(sizeof(struct smb2_decrypt_work), GFP_KERNEL);
> +       if (!dw)
> +               return -ENOMEM;
> +       xa_init(&dw->buffer);
> +       INIT_WORK(&dw->decrypt, smb2_decrypt_offload);
> +       dw->server = server;
> +
>         *num_mids = 1;
>         len = min_t(unsigned int, buflen, server->vals->read_rsp_size +
>                 sizeof(struct smb2_transform_hdr)) - HEADER_SIZE(server) + 1;
>
>         rc = cifs_read_from_socket(server, buf + HEADER_SIZE(server) - 1, len);
>         if (rc < 0)
> -               return rc;
> +               goto free_dw;
>         server->total_read += rc;
>
>         len = le32_to_cpu(tr_hdr->OriginalMessageSize) -
>                 server->vals->read_rsp_size;
> +       dw->len = len;
>         npages = DIV_ROUND_UP(len, PAGE_SIZE);
>
> -       pages = kmalloc_array(npages, sizeof(struct page *), GFP_KERNEL);
> -       if (!pages) {
> -               rc = -ENOMEM;
> -               goto discard_data;
> -       }
> -
> +       rc = -ENOMEM;
>         for (; i < npages; i++) {
> -               pages[i] = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
> -               if (!pages[i]) {
> -                       rc = -ENOMEM;
> +               void *old;
> +
> +               page = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
> +               if (!page) {
> +                       goto discard_data;
> +               }
> +               page->index = i;
> +               old = xa_store(&dw->buffer, i, page, GFP_KERNEL);
> +               if (xa_is_err(old)) {
> +                       rc = xa_err(old);
> +                       put_page(page);
>                         goto discard_data;
>                 }
>         }
>
> -       /* read read data into pages */
> -       rc = read_data_into_pages(server, pages, npages, len);
> -       if (rc)
> -               goto free_pages;
> +       iov_iter_xarray(&iter, READ, &dw->buffer, 0, npages * PAGE_SIZE);
> +
> +       /* Read the data into the buffer and clear excess bufferage. */
> +       rc = cifs_read_iter_from_socket(server, &iter, dw->len);
> +       if (rc < 0)
> +               goto discard_data;
> +
> +       server->total_read += rc;
> +       if (rc < npages * PAGE_SIZE)
> +               iov_iter_zero(npages * PAGE_SIZE - rc, &iter);
> +       iov_iter_revert(&iter, npages * PAGE_SIZE);
> +       iov_iter_truncate(&iter, dw->len);
>
>         rc = cifs_discard_remaining_data(server);
>         if (rc)
> @@ -5078,39 +5082,28 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
>
>         if ((server->min_offload) && (server->in_flight > 1) &&
>             (server->pdu_size >= server->min_offload)) {
> -               dw = kmalloc(sizeof(struct smb2_decrypt_work), GFP_KERNEL);
> -               if (dw == NULL)
> -                       goto non_offloaded_decrypt;
> -
>                 dw->buf = server->smallbuf;
>                 server->smallbuf = (char *)cifs_small_buf_get();
>
> -               INIT_WORK(&dw->decrypt, smb2_decrypt_offload);
> -
> -               dw->npages = npages;
> -               dw->server = server;
> -               dw->ppages = pages;
> -               dw->len = len;
>                 queue_work(decrypt_wq, &dw->decrypt);
>                 *num_mids = 0; /* worker thread takes care of finding mid */
>                 return -1;
>         }
>
> -non_offloaded_decrypt:
>         rc = decrypt_raw_data(server, buf, server->vals->read_rsp_size,
> -                             pages, npages, len, false);
> +                             &iter, false);
>         if (rc)
>                 goto free_pages;
>
>         *mid = smb2_find_mid(server, buf);
> -       if (*mid == NULL)
> +       if (*mid == NULL) {
>                 cifs_dbg(FYI, "mid not found\n");
> -       else {
> +       } else {
>                 cifs_dbg(FYI, "mid found\n");
>                 (*mid)->decrypted = true;
>                 rc = handle_read_data(server, *mid, buf,
>                                       server->vals->read_rsp_size,
> -                                     pages, npages, len, false);
> +                                     &dw->buffer, dw->len, false);
>                 if (rc >= 0) {
>                         if (server->ops->is_network_name_deleted) {
>                                 server->ops->is_network_name_deleted(buf,
> @@ -5120,9 +5113,9 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
>         }
>
>  free_pages:
> -       for (i = i - 1; i >= 0; i--)
> -               put_page(pages[i]);
> -       kfree(pages);
> +       cifs_clear_xarray_buffer(&dw->buffer);
> +free_dw:
> +       kfree(dw);
>         return rc;
>  discard_data:
>         cifs_discard_remaining_data(server);
> @@ -5160,7 +5153,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
>         server->total_read += length;
>
>         buf_size = pdu_length - sizeof(struct smb2_transform_hdr);
> -       length = decrypt_raw_data(server, buf, buf_size, NULL, 0, 0, false);
> +       length = decrypt_raw_data(server, buf, buf_size, NULL, false);
>         if (length)
>                 return length;
>
> @@ -5259,7 +5252,7 @@ smb3_handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid)
>         char *buf = server->large_buf ? server->bigbuf : server->smallbuf;
>
>         return handle_read_data(server, mid, buf, server->pdu_size,
> -                               NULL, 0, 0, false);
> +                               NULL, 0, false);
>  }
>
>  static int
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index 7e7909b1ae11..ebbea7526ee2 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -4118,11 +4118,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
>         struct cifs_credits credits = { .value = 0, .instance = 0 };
>         struct smb_rqst rqst = { .rq_iov = &rdata->iov[1],
>                                  .rq_nvec = 1,
> -                                .rq_pages = rdata->pages,
> -                                .rq_offset = rdata->page_offset,
> -                                .rq_npages = rdata->nr_pages,
> -                                .rq_pagesz = rdata->pagesz,
> -                                .rq_tailsz = rdata->tailsz };
> +                                .rq_iter = rdata->iter };
>
>         WARN_ONCE(rdata->server != mid->server,
>                   "rdata server %p != mid server %p",
> @@ -4522,11 +4518,7 @@ smb2_async_writev(struct cifs_writedata *wdata,
>
>         rqst.rq_iov = iov;
>         rqst.rq_nvec = 1;
> -       rqst.rq_pages = wdata->pages;
> -       rqst.rq_offset = wdata->page_offset;
> -       rqst.rq_npages = wdata->nr_pages;
> -       rqst.rq_pagesz = wdata->pagesz;
> -       rqst.rq_tailsz = wdata->tailsz;
> +       rqst.rq_iter = wdata->iter;
>  #ifdef CONFIG_CIFS_SMB_DIRECT
>         if (wdata->mr) {
>                 iov[0].iov_len += sizeof(struct smbd_buffer_descriptor_v1);
> diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
> index 8540f7c13eae..cb19c43c0009 100644
> --- a/fs/cifs/transport.c
> +++ b/fs/cifs/transport.c
> @@ -276,26 +276,7 @@ smb_rqst_len(struct TCP_Server_Info *server, struct smb_rqst *rqst)
>         for (i = 0; i < nvec; i++)
>                 buflen += iov[i].iov_len;
>
> -       /*
> -        * Add in the page array if there is one. The caller needs to make
> -        * sure rq_offset and rq_tailsz are set correctly. If a buffer of
> -        * multiple pages ends at page boundary, rq_tailsz needs to be set to
> -        * PAGE_SIZE.
> -        */
> -       if (rqst->rq_npages) {
> -               if (rqst->rq_npages == 1)
> -                       buflen += rqst->rq_tailsz;
> -               else {
> -                       /*
> -                        * If there is more than one page, calculate the
> -                        * buffer length based on rq_offset and rq_tailsz
> -                        */
> -                       buflen += rqst->rq_pagesz * (rqst->rq_npages - 1) -
> -                                       rqst->rq_offset;
> -                       buflen += rqst->rq_tailsz;
> -               }
> -       }
> -
> +       buflen += iov_iter_count(&rqst->rq_iter);
>         return buflen;
>  }
>
> @@ -382,23 +363,15 @@ __smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
>
>                 total_len += sent;
>
> -               /* now walk the page array and send each page in it */
> -               for (i = 0; i < rqst[j].rq_npages; i++) {
> -                       struct bio_vec bvec;
> -
> -                       bvec.bv_page = rqst[j].rq_pages[i];
> -                       rqst_page_get_length(&rqst[j], i, &bvec.bv_len,
> -                                            &bvec.bv_offset);
> -
> -                       iov_iter_bvec(&smb_msg.msg_iter, WRITE,
> -                                     &bvec, 1, bvec.bv_len);
> +               if (iov_iter_count(&rqst[j].rq_iter) > 0) {
> +                       smb_msg.msg_iter = rqst[j].rq_iter;
>                         rc = smb_send_kvec(server, &smb_msg, &sent);
>                         if (rc < 0)
>                                 break;
> -
>                         total_len += sent;
>                 }
> -       }
> +
> +}
>
>  unmask:
>         sigprocmask(SIG_SETMASK, &oldmask, NULL);
>
>
