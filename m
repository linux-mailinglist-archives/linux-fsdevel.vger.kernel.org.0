Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1935A4220
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Aug 2022 07:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiH2FGz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 01:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2FGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 01:06:54 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E9341D28;
        Sun, 28 Aug 2022 22:06:53 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id l20so940589vka.5;
        Sun, 28 Aug 2022 22:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qDOlBO8M3knCdtBqq7VFSNn3zWVTBCbhwMXpQDGbaKs=;
        b=JhSp8ZCo+u+70xYvY2SqqvQM3/P9g9rt/QRhkPlFs/LoMzTZCynWIQSkKKSukx0vS+
         GRRbeRKut0oQs3veOJ9ZvYaD2/0z8nHbTMGLsM1spGRgkrGsvEzQMTJm7UbZMbBiC7NO
         aSlQPpC8YxBzDTxy2ohnWGkVhuXfUgKEmhvBnzuRCgPOhTPG+cKlxuPjTEERIdy2E6xh
         mWa4VtkkKAQX4YRRvM4uCHHxUYEfELg4OJVh/b4s7Ga9eMhFLpyo+sfzZvf2R+1bkX0k
         SzYO8KJRiFHz8T1xe8kzKGSXeDQvVgDgpyhswzPB4pVCEq0N00Q5tFBnF9duLRMs0uDg
         hKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qDOlBO8M3knCdtBqq7VFSNn3zWVTBCbhwMXpQDGbaKs=;
        b=CyvX7SzJ6X86UmlLO7KO4a3qK6mUN/Fh2qtFhN9+LfGoaCQncxK80aW01hiDY8bSaR
         QpPio7ceKLFiA7jmH2qSoTnHx4hZGJKNVRizoge+Ap63uloHoAUtfn9y3CjmZqVfu7Qr
         EXCSQUqNhC93TQF8rw23YBkP/2vrf/kTI67bxpKNPccXlDPSsJNWXe1XwJmIme2krjqC
         XoOaeqVtwFgtj+2D3nbNMvA0pFlu9Hm1HyoE3bobqaMN4IhPnbsC6G2gny90J1y78RTt
         cxVKGkpi8vQmtypUopGdwQ2nouch49mwlPZrKByfKQ+jLwqYnCwKF4OAhbfseX5GLj9V
         kahA==
X-Gm-Message-State: ACgBeo0Ns/YvNN3kPdmnGZFZ7rfkygnVkalrrub46e77vBRphGI+KTj+
        M/gu5h7kzLH16XSKMaJsDFgh9xD61bMq9IpLV7S+OSW4it2+HQ==
X-Google-Smtp-Source: AA6agR6bESZQgt0/NGDHgpqg2YlxlXfqv9MlFaFbcYHqbBuUnSse2j2x0UU6+2ThpJ/ZPE4VL1/WDlmd8KxaNM/eqrk=
X-Received: by 2002:a1f:ab4e:0:b0:394:5af3:c490 with SMTP id
 u75-20020a1fab4e000000b003945af3c490mr938940vke.24.1661749612187; Sun, 28 Aug
 2022 22:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <166126004083.548536.11195647088995116235.stgit@warthog.procyon.org.uk>
 <166126004796.548536.8555773200873112505.stgit@warthog.procyon.org.uk>
In-Reply-To: <166126004796.548536.8555773200873112505.stgit@warthog.procyon.org.uk>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 29 Aug 2022 00:06:41 -0500
Message-ID: <CAH2r5mt5iXtarkUAY7PSMGOLhkQd5LFcEz-rAnTkayxQMq_ppA@mail.gmail.com>
Subject: Re: [PATCH 1/5] smb3: Move the flush out of smb2_copychunk_range()
 into its callers
To:     David Howells <dhowells@redhat.com>
Cc:     sfrench@samba.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, jlayton@kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        lsahlber@redhat.com, dchinner@redhat.com,
        linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000573bac05e75a3b91"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000573bac05e75a3b91
Content-Type: text/plain; charset="UTF-8"

Shouldn't this be using filemap_write_and_wait_range() not
filemap_write_and_wait as we see in similar code in ext4 (and
shouldn't it check rc in some of these cases)?   For example for the
copychunk_range example shouldn't the patch be modified similar to the
following:

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index e9fb338b8e7e..51963e83daf7 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1219,8 +1219,6 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,

        cifs_dbg(FYI, "copychunk range\n");

-       filemap_write_and_wait(src_inode->i_mapping);
-
        if (!src_file->private_data || !dst_file->private_data) {
                rc = -EBADF;
                cifs_dbg(VFS, "missing cifsFileInfo on copy range src file\n");
@@ -1250,6 +1248,12 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
        lock_two_nondirectories(target_inode, src_inode);

        cifs_dbg(FYI, "about to flush pages\n");
+
+       rc = filemap_write_and_wait_range(src_inode->i_mapping, off,
+                                         off + len - 1);
+        if (rc)
+               goto out;
+
        /* should we flush first and last page first */
        truncate_inode_pages(&target_inode->i_data, 0);

On Tue, Aug 23, 2022 at 8:09 AM David Howells via samba-technical
<samba-technical@lists.samba.org> wrote:
>
> Move the flush out of smb2_copychunk_range() into its callers.  This will
> allow the pagecache to be invalidated between the flush and the operation
> in smb3_collapse_range() and smb3_insert_range().
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <stfrench@microsoft.com>
> cc: Ronnie Sahlberg <lsahlber@redhat.com>
> ---
>
>  fs/cifs/cifsfs.c  |    2 ++
>  fs/cifs/smb2ops.c |   20 ++++++++------------
>  2 files changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index f54d8bf2732a..e9fb338b8e7e 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -1219,6 +1219,8 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
>
>         cifs_dbg(FYI, "copychunk range\n");
>
> +       filemap_write_and_wait(src_inode->i_mapping);
> +
>         if (!src_file->private_data || !dst_file->private_data) {
>                 rc = -EBADF;
>                 cifs_dbg(VFS, "missing cifsFileInfo on copy range src file\n");
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index 96f3b0573606..7e3de6a0e1dc 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -1600,17 +1600,8 @@ smb2_copychunk_range(const unsigned int xid,
>         int chunks_copied = 0;
>         bool chunk_sizes_updated = false;
>         ssize_t bytes_written, total_bytes_written = 0;
> -       struct inode *inode;
>
>         pcchunk = kmalloc(sizeof(struct copychunk_ioctl), GFP_KERNEL);
> -
> -       /*
> -        * We need to flush all unwritten data before we can send the
> -        * copychunk ioctl to the server.
> -        */
> -       inode = d_inode(trgtfile->dentry);
> -       filemap_write_and_wait(inode->i_mapping);
> -
>         if (pcchunk == NULL)
>                 return -ENOMEM;
>
> @@ -3689,6 +3680,8 @@ static long smb3_collapse_range(struct file *file, struct cifs_tcon *tcon,
>                 goto out;
>         }
>
> +       filemap_write_and_wait(inode->i_mapping);
> +
>         rc = smb2_copychunk_range(xid, cfile, cfile, off + len,
>                                   i_size_read(inode) - off - len, off);
>         if (rc < 0)
> @@ -3716,18 +3709,21 @@ static long smb3_insert_range(struct file *file, struct cifs_tcon *tcon,
>         int rc;
>         unsigned int xid;
>         struct cifsFileInfo *cfile = file->private_data;
> +       struct inode *inode = file_inode(file);
>         __le64 eof;
>         __u64  count;
>
>         xid = get_xid();
>
> -       if (off >= i_size_read(file->f_inode)) {
> +       if (off >= i_size_read(inode)) {
>                 rc = -EINVAL;
>                 goto out;
>         }
>
> -       count = i_size_read(file->f_inode) - off;
> -       eof = cpu_to_le64(i_size_read(file->f_inode) + len);
> +       count = i_size_read(inode) - off;
> +       eof = cpu_to_le64(i_size_read(inode) + len);
> +
> +       filemap_write_and_wait(inode->i_mapping);
>
>         rc = SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
>                           cfile->fid.volatile_fid, cfile->pid, &eof);
>
>
>


-- 
Thanks,

Steve

--000000000000573bac05e75a3b91
Content-Type: text/x-patch; charset="US-ASCII"; name="use-filemap_write_and_wait_range.patch"
Content-Disposition: attachment; 
	filename="use-filemap_write_and_wait_range.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l7easojh0>
X-Attachment-Id: f_l7easojh0

ZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY2lmc2ZzLmMgYi9mcy9jaWZzL2NpZnNmcy5jCmluZGV4IGU5
ZmIzMzhiOGU3ZS4uNTE5NjNlODNkYWY3IDEwMDY0NAotLS0gYS9mcy9jaWZzL2NpZnNmcy5jCisr
KyBiL2ZzL2NpZnMvY2lmc2ZzLmMKQEAgLTEyMTksOCArMTIxOSw2IEBAIHNzaXplX3QgY2lmc19m
aWxlX2NvcHljaHVua19yYW5nZSh1bnNpZ25lZCBpbnQgeGlkLAogCiAJY2lmc19kYmcoRllJLCAi
Y29weWNodW5rIHJhbmdlXG4iKTsKIAotCWZpbGVtYXBfd3JpdGVfYW5kX3dhaXQoc3JjX2lub2Rl
LT5pX21hcHBpbmcpOwotCiAJaWYgKCFzcmNfZmlsZS0+cHJpdmF0ZV9kYXRhIHx8ICFkc3RfZmls
ZS0+cHJpdmF0ZV9kYXRhKSB7CiAJCXJjID0gLUVCQURGOwogCQljaWZzX2RiZyhWRlMsICJtaXNz
aW5nIGNpZnNGaWxlSW5mbyBvbiBjb3B5IHJhbmdlIHNyYyBmaWxlXG4iKTsKQEAgLTEyNTAsNiAr
MTI0OCwxMiBAQCBzc2l6ZV90IGNpZnNfZmlsZV9jb3B5Y2h1bmtfcmFuZ2UodW5zaWduZWQgaW50
IHhpZCwKIAlsb2NrX3R3b19ub25kaXJlY3Rvcmllcyh0YXJnZXRfaW5vZGUsIHNyY19pbm9kZSk7
CiAKIAljaWZzX2RiZyhGWUksICJhYm91dCB0byBmbHVzaCBwYWdlc1xuIik7CisKKwlyYyA9IGZp
bGVtYXBfd3JpdGVfYW5kX3dhaXRfcmFuZ2Uoc3JjX2lub2RlLT5pX21hcHBpbmcsIG9mZiwKKwkJ
CQkJICBvZmYgKyBsZW4gLSAxKTsKKyAgICAgICAgaWYgKHJjKQorCQlnb3RvIG91dDsKKwogCS8q
IHNob3VsZCB3ZSBmbHVzaCBmaXJzdCBhbmQgbGFzdCBwYWdlIGZpcnN0ICovCiAJdHJ1bmNhdGVf
aW5vZGVfcGFnZXMoJnRhcmdldF9pbm9kZS0+aV9kYXRhLCAwKTsKIAo=
--000000000000573bac05e75a3b91--
