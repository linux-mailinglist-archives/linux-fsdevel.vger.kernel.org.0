Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F221360C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 20:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbgAITKf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 14:10:35 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39968 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732258AbgAITKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:10:35 -0500
Received: by mail-io1-f68.google.com with SMTP id x1so8327368iop.7;
        Thu, 09 Jan 2020 11:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0gkJ1wnhwsbLBidpLWzC0gqEsOEqRPxrWzwmo/jij60=;
        b=SbNoT3sPqXIeCVvOK3tZBEJiF6JBMsS0SnfuogHqNmzVWmNsbJpcRU/1mthcVl/Pea
         zY1P5sbNK+8rDyfyjn+ufLBPJ6dyj9K8FyqNc8bwC7uvUBADoiYT03LhMsv3KTgrKMQh
         mB/8JIY7vZAjcsxzRRm9ALS0iTmLvvLeSsrupCVcdJRD59Mf4OzaVz6Gv1q9rIvDVkq8
         SdQGQbOot9xgroTT27UJMWgZlrUZ1vxhLaCNKX6gcE7mQPYRscqP5mR/xzLIeu5NB2di
         K/4ZN/lW/knGPW/oo4DfNFynlpL9BlGHiYfvdf5TKfb9mQec1NtF+BvnyNyNCfv+QEPn
         YOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gkJ1wnhwsbLBidpLWzC0gqEsOEqRPxrWzwmo/jij60=;
        b=OHT2qM3s1s8K7fEUwcq0gCpNZx5hTxmId/JxIhx3G0C+beJZsLiCmU6sQu5R0f1XDr
         bOVHLIpPD9ohOPvqh9YhLUaEGfD82gr5GFSEfcPccIDACXDydzUIVn5ey5brTugEe+BZ
         c06iaFYN1QVBcghw1df3fXfQG+nelgMOzM00k6L4KdWIMyQkJHymNl9NK2oGJsVErHfI
         eH7U8WOVEllpJWITRXUGvE4qw2AoaDTYHB1rZ1pOVbmoHxundr6pDGo8I2kzlUXhbK4M
         ScuYwBjKDw85AcygPFSPf3duqjQCcoTrYBBLdiOeSAx79jqx1baQ4EYlFic3k5fpAAEs
         QY1Q==
X-Gm-Message-State: APjAAAVO/nV3LE12wZwELIyMN6SI+h5ZW3L8hgSQBRn9s5lgKTRDTnbk
        KjO6IUYtu0xBIDXIua2cVI1XPBFK32ATy3L0rbc=
X-Google-Smtp-Source: APXvYqw+BQZHUlgOmb6/E/rHDgfC3YhyI7dXQnzqMh5qh83xos4Eecke/yUUi15M16/RdkL76ez5tzRPdcKn9jNJONw=
X-Received: by 2002:a6b:c413:: with SMTP id y19mr8836903ioa.272.1578597033913;
 Thu, 09 Jan 2020 11:10:33 -0800 (PST)
MIME-Version: 1.0
References: <20191219165250.2875-1-bprotopopov@hotmail.com>
In-Reply-To: <20191219165250.2875-1-bprotopopov@hotmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 9 Jan 2020 13:10:23 -0600
Message-ID: <CAH2r5mu0Jd=MACMn6_KPvNWoAPVu+V_3FOnoEZxDWoy0x2qEzA@mail.gmail.com>
Subject: Re: [PATCH] Add support for setting owner info, dos attributes, and
 create time
To:     Boris Protopopov <boris.v.protopopov@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Pavel Shilovsky <piastryyy@gmail.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

One loosely related question ...

Your patch adds the ability to set creation time (birth time) which
can be useful for backup/restore cases, but doesn't address the other
hole in Linux (the inability to restore a files ctime).

In Linux the ability to set timestamps seems quite limited (utimes
only allows setting mtime and atime).

Since setting all 4 timestamps is allowed over SMB3 (and all older
dialects as well), should we extend this to allow setting ctime not
just creation time over SMB3/CIFS mounts?

On Thu, Dec 19, 2019 at 10:53 AM Boris Protopopov
<boris.v.protopopov@gmail.com> wrote:
>
> Add extended attribute "system.cifs_ntsd" (and alias "system.smb3_ntsd")
> to allow for setting owner and DACL in the security descriptor. This is in
> addition to the existing "system.cifs_acl" and "system.smb3_acl" attributes
> that allow for setting DACL only. Add support for setting creation time and
> dos attributes using set_file_info() calls to complement the existing
> support for getting these attributes via query_path_info() calls.
>
> Signed-off-by: Boris Protopopov <bprotopopov@hotmail.com>
> ---
>  fs/cifs/xattr.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 117 insertions(+), 11 deletions(-)
>
> diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
> index 9076150758d8..c41856e6fa22 100644
> --- a/fs/cifs/xattr.c
> +++ b/fs/cifs/xattr.c
> @@ -32,7 +32,8 @@
>  #include "cifs_unicode.h"
>
>  #define MAX_EA_VALUE_SIZE CIFSMaxBufSize
> -#define CIFS_XATTR_CIFS_ACL "system.cifs_acl"
> +#define CIFS_XATTR_CIFS_ACL "system.cifs_acl" /* DACL only */
> +#define CIFS_XATTR_CIFS_NTSD "system.cifs_ntsd" /* owner plus DACL */
>  #define CIFS_XATTR_ATTRIB "cifs.dosattrib"  /* full name: user.cifs.dosattrib */
>  #define CIFS_XATTR_CREATETIME "cifs.creationtime"  /* user.cifs.creationtime */
>  /*
> @@ -40,12 +41,62 @@
>   * confusing users and using the 20+ year old term 'cifs' when it is no longer
>   * secure, replaced by SMB2 (then even more highly secure SMB3) many years ago
>   */
> -#define SMB3_XATTR_CIFS_ACL "system.smb3_acl"
> +#define SMB3_XATTR_CIFS_ACL "system.smb3_acl" /* DACL only */
> +#define SMB3_XATTR_CIFS_NTSD "system.smb3_ntsd" /* owner plus DACL */
>  #define SMB3_XATTR_ATTRIB "smb3.dosattrib"  /* full name: user.smb3.dosattrib */
>  #define SMB3_XATTR_CREATETIME "smb3.creationtime"  /* user.smb3.creationtime */
>  /* BB need to add server (Samba e.g) support for security and trusted prefix */
>
> -enum { XATTR_USER, XATTR_CIFS_ACL, XATTR_ACL_ACCESS, XATTR_ACL_DEFAULT };
> +enum { XATTR_USER, XATTR_CIFS_ACL, XATTR_ACL_ACCESS, XATTR_ACL_DEFAULT,
> +       XATTR_CIFS_NTSD };
> +
> +static int cifs_attrib_set(unsigned int xid, struct cifs_tcon *pTcon,
> +                          struct inode *inode, char *full_path,
> +                          const void *value, size_t size)
> +{
> +       ssize_t rc = -EOPNOTSUPP;
> +       __u32 *pattrib = (__u32 *)value;
> +       __u32 attrib;
> +       FILE_BASIC_INFO info_buf;
> +
> +       if ((value == NULL) || (size != sizeof(__u32)))
> +               return -ERANGE;
> +
> +       memset(&info_buf, 0, sizeof(info_buf));
> +       info_buf.Attributes = attrib = cpu_to_le32(*pattrib);
> +
> +       if (pTcon->ses->server->ops->set_file_info)
> +               rc = pTcon->ses->server->ops->set_file_info(inode, full_path,
> +                               &info_buf, xid);
> +       if (rc == 0)
> +               CIFS_I(inode)->cifsAttrs = attrib;
> +
> +       return rc;
> +}
> +
> +static int cifs_creation_time_set(unsigned int xid, struct cifs_tcon *pTcon,
> +                                 struct inode *inode, char *full_path,
> +                                 const void *value, size_t size)
> +{
> +       ssize_t rc = -EOPNOTSUPP;
> +       __u64 *pcreation_time = (__u64 *)value;
> +       __u64 creation_time;
> +       FILE_BASIC_INFO info_buf;
> +
> +       if ((value == NULL) || (size != sizeof(__u64)))
> +               return -ERANGE;
> +
> +       memset(&info_buf, 0, sizeof(info_buf));
> +       info_buf.CreationTime = creation_time = cpu_to_le64(*pcreation_time);
> +
> +       if (pTcon->ses->server->ops->set_file_info)
> +               rc = pTcon->ses->server->ops->set_file_info(inode, full_path,
> +                               &info_buf, xid);
> +       if (rc == 0)
> +               CIFS_I(inode)->createtime = creation_time;
> +
> +       return rc;
> +}
>
>  static int cifs_xattr_set(const struct xattr_handler *handler,
>                           struct dentry *dentry, struct inode *inode,
> @@ -86,6 +137,23 @@ static int cifs_xattr_set(const struct xattr_handler *handler,
>
>         switch (handler->flags) {
>         case XATTR_USER:
> +               cifs_dbg(FYI, "%s:setting user xattr %s\n", __func__, name);
> +               if ((strcmp(name, CIFS_XATTR_ATTRIB) == 0) ||
> +                   (strcmp(name, SMB3_XATTR_ATTRIB) == 0)) {
> +                       rc = cifs_attrib_set(xid, pTcon, inode, full_path,
> +                                       value, size);
> +                       if (rc == 0) /* force revalidate of the inode */
> +                               CIFS_I(inode)->time = 0;
> +                       break;
> +               } else if ((strcmp(name, CIFS_XATTR_CREATETIME) == 0) ||
> +                          (strcmp(name, SMB3_XATTR_CREATETIME) == 0)) {
> +                       rc = cifs_creation_time_set(xid, pTcon, inode,
> +                                       full_path, value, size);
> +                       if (rc == 0) /* force revalidate of the inode */
> +                               CIFS_I(inode)->time = 0;
> +                       break;
> +               }
> +
>                 if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_XATTR)
>                         goto out;
>
> @@ -95,7 +163,8 @@ static int cifs_xattr_set(const struct xattr_handler *handler,
>                                 cifs_sb->local_nls, cifs_sb);
>                 break;
>
> -       case XATTR_CIFS_ACL: {
> +       case XATTR_CIFS_ACL:
> +       case XATTR_CIFS_NTSD: {
>                 struct cifs_ntsd *pacl;
>
>                 if (!value)
> @@ -106,12 +175,25 @@ static int cifs_xattr_set(const struct xattr_handler *handler,
>                 } else {
>                         memcpy(pacl, value, size);
>                         if (value &&
> -                           pTcon->ses->server->ops->set_acl)
> -                               rc = pTcon->ses->server->ops->set_acl(pacl,
> -                                               size, inode,
> -                                               full_path, CIFS_ACL_DACL);
> -                       else
> +                           pTcon->ses->server->ops->set_acl) {
> +                               rc = 0;
> +                               if (handler->flags == XATTR_CIFS_NTSD) {
> +                                       /* set owner and DACL */
> +                                       rc = pTcon->ses->server->ops->set_acl(
> +                                                       pacl, size, inode,
> +                                                       full_path,
> +                                                       CIFS_ACL_OWNER);
> +                               }
> +                               if (rc == 0) {
> +                                       /* set DACL */
> +                                       rc = pTcon->ses->server->ops->set_acl(
> +                                                       pacl, size, inode,
> +                                                       full_path,
> +                                                       CIFS_ACL_DACL);
> +                               }
> +                       } else {
>                                 rc = -EOPNOTSUPP;
> +                       }
>                         if (rc == 0) /* force revalidate of the inode */
>                                 CIFS_I(inode)->time = 0;
>                         kfree(pacl);
> @@ -179,7 +261,7 @@ static int cifs_creation_time_get(struct dentry *dentry, struct inode *inode,
>                                   void *value, size_t size)
>  {
>         ssize_t rc;
> -       __u64 * pcreatetime;
> +       __u64 *pcreatetime;
>
>         rc = cifs_revalidate_dentry_attr(dentry);
>         if (rc)
> @@ -244,7 +326,9 @@ static int cifs_xattr_get(const struct xattr_handler *handler,
>                                 full_path, name, value, size, cifs_sb);
>                 break;
>
> -       case XATTR_CIFS_ACL: {
> +       case XATTR_CIFS_ACL:
> +       case XATTR_CIFS_NTSD: {
> +               /* the whole ntsd is fetched regardless */
>                 u32 acllen;
>                 struct cifs_ntsd *pacl;
>
> @@ -382,6 +466,26 @@ static const struct xattr_handler smb3_acl_xattr_handler = {
>         .set = cifs_xattr_set,
>  };
>
> +static const struct xattr_handler cifs_cifs_ntsd_xattr_handler = {
> +       .name = CIFS_XATTR_CIFS_NTSD,
> +       .flags = XATTR_CIFS_NTSD,
> +       .get = cifs_xattr_get,
> +       .set = cifs_xattr_set,
> +};
> +
> +/*
> + * Although this is just an alias for the above, need to move away from
> + * confusing users and using the 20 year old term 'cifs' when it is no
> + * longer secure and was replaced by SMB2/SMB3 a long time ago, and
> + * SMB3 and later are highly secure.
> + */
> +static const struct xattr_handler smb3_ntsd_xattr_handler = {
> +       .name = SMB3_XATTR_CIFS_NTSD,
> +       .flags = XATTR_CIFS_NTSD,
> +       .get = cifs_xattr_get,
> +       .set = cifs_xattr_set,
> +};
> +
>  static const struct xattr_handler cifs_posix_acl_access_xattr_handler = {
>         .name = XATTR_NAME_POSIX_ACL_ACCESS,
>         .flags = XATTR_ACL_ACCESS,
> @@ -401,6 +505,8 @@ const struct xattr_handler *cifs_xattr_handlers[] = {
>         &cifs_os2_xattr_handler,
>         &cifs_cifs_acl_xattr_handler,
>         &smb3_acl_xattr_handler, /* alias for above since avoiding "cifs" */
> +       &cifs_cifs_ntsd_xattr_handler,
> +       &smb3_ntsd_xattr_handler, /* alias for above since avoiding "cifs" */
>         &cifs_posix_acl_access_xattr_handler,
>         &cifs_posix_acl_default_xattr_handler,
>         NULL
> --
> 2.14.5
>


-- 
Thanks,

Steve
