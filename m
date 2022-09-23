Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFFE5E7293
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 05:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiIWDxE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 23:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbiIWDxB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 23:53:01 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDD529826;
        Thu, 22 Sep 2022 20:52:59 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id p4so12426488vsa.9;
        Thu, 22 Sep 2022 20:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=55SCMFMSY1DHCvBKJ1pssv9Ql1LiiNbVXO7Tl8th1U8=;
        b=h4JuouXqIGZ7y7B89N1ZD0UaWwJPcFWBiu6bAE8EnrbSniRvk9z7wa8O0j5l1QS0fH
         J+Pkn+qeNgcHHj0G2Li+EBNCZUo53LE/rAlw+GZ13/wNuaaFCEcogrjZ2CEE8nP2m8mR
         6PL21CwU8byLS30N7CZ602pyCN4Wwkrbu1D0mr7mOFirFK4LUJxKKR1p1F2vDVii1mdu
         qYi/00dSkGuLUBpa3RUuDMHXBZYTCb2betAOeCXc9n/rpwN1mQF/jzUbKLimxcN8N3PA
         XAXuWcYxg2hTD+v2ozrsJAMbYR7qxLsJzzuliibovKEnWT/hpXi1asTMDNaQhtEL6psw
         U23A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=55SCMFMSY1DHCvBKJ1pssv9Ql1LiiNbVXO7Tl8th1U8=;
        b=ilsysixLx7gIOYkTltY22Ckt3vvHNV/MmNer6JeUilvU+hbR7dYD9HKU+gnck/+e7/
         KYSvNXQ4Gk1RbW6QDdPYRvDbrpaV99HYjRhy3G+NTwQ3oftuHTsJdyWFcQgBEdBXKxsT
         4s3shbSQ/PL3q/uyS2cAiWdJtb1FUXOh5JCfmvymdaM0PBd2OMaTy7YGBhMIuGcdwfia
         aFpaskc8ndaJOJM3q67tnrxCk1v4pnJKD91Kw2uAy4OY0TBPJLc7pgVkQ5kK7i69xIXv
         vV+MBptovZ0RRbtA6WbEBaud4Lq3CZ0LAioZtaEpWCylsszCCENCCdz6fW1qyUYPrwv1
         QdyQ==
X-Gm-Message-State: ACrzQf3xbpin1HzEPgPO0XE/9N6sBeT/zPrTi5OIpPpWJg9QYRdBm7Gr
        aWGGDsWXcj9NDvM3SMvO077/PvLwdgBwsu/BwY9tZEmGAC0=
X-Google-Smtp-Source: AMsMyM5KEpJPS3JLhhvQp1h5nvMmJ74B+weWV0Eh2+2Ckv2yoo4wFL1DzPvCXHf716RAa6gxw6E7BljYbQ3QleQvQv4=
X-Received: by 2002:a67:f705:0:b0:39b:ff07:108d with SMTP id
 m5-20020a67f705000000b0039bff07108dmr2595739vso.60.1663905178064; Thu, 22 Sep
 2022 20:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220922151728.1557914-1-brauner@kernel.org> <20220922151728.1557914-5-brauner@kernel.org>
In-Reply-To: <20220922151728.1557914-5-brauner@kernel.org>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 22 Sep 2022 22:52:43 -0500
Message-ID: <CAH2r5mvkSW1FY2tP87mKGrOMkoN8tbOP9r=xJ4XnVbkcrE9guA@mail.gmail.com>
Subject: Re: [PATCH 04/29] cifs: implement get acl method
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks like the SMB1 Protocol operations for get/set posix ACL were
removed in the companion patch (in SMB3, POSIX ACLs have to be handled
by mapping from rich acls).  Was this intentional or did I miss
something? I didn't see the functions for sending these over the wire
for SMB1 (which does support POSIX ACLs, not just RichACLs (SMB/NTFS
ACLs))

        pSMB->SubCommand = cpu_to_le16(TRANS2_SET_PATH_INFORMATION);
        pSMB->InformationLevel = cpu_to_le16(SMB_SET_POSIX_ACL);

On Thu, Sep 22, 2022 at 10:20 AM Christian Brauner <brauner@kernel.org> wrote:
>
> The current way of setting and getting posix acls through the generic
> xattr interface is error prone and type unsafe. The vfs needs to
> interpret and fixup posix acls before storing or reporting it to
> userspace. Various hacks exist to make this work. The code is hard to
> understand and difficult to maintain in it's current form. Instead of
> making this work by hacking posix acls through xattr handlers we are
> building a dedicated posix acl api around the get and set inode
> operations. This removes a lot of hackiness and makes the codepaths
> easier to maintain. A lot of background can be found in [1].
>
> In order to build a type safe posix api around get and set acl we need
> all filesystem to implement get and set acl.
>
> So far cifs wasn't able to implement get and set acl inode operations
> because it needs access to the dentry. Now that we extended the set acl
> inode operation to take a dentry argument and added a new get acl inode
> operation that takes a dentry argument we can let cifs implement get and
> set acl inode operations.
>
> This is mostly a copy and paste of the codepaths currently used in cifs'
> posix acl xattr handler. After we have fully implemented the posix acl
> api and switched the vfs over to it, the cifs specific posix acl xattr
> handler and associated code will be removed and the code duplication
> will go away.
>
> Note, until the vfs has been switched to the new posix acl api this
> patch is a non-functional change.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>  fs/cifs/cifsacl.c   |  63 +++++++++++++++
>  fs/cifs/cifsfs.c    |   2 +
>  fs/cifs/cifsproto.h |   6 ++
>  fs/cifs/cifssmb.c   | 190 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 261 insertions(+)
>
> diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
> index fa480d62f313..06ae721ec1e7 100644
> --- a/fs/cifs/cifsacl.c
> +++ b/fs/cifs/cifsacl.c
> @@ -13,6 +13,7 @@
>  #include <linux/string.h>
>  #include <linux/keyctl.h>
>  #include <linux/key-type.h>
> +#include <uapi/linux/posix_acl.h>
>  #include <keys/user-type.h>
>  #include "cifspdu.h"
>  #include "cifsglob.h"
> @@ -20,6 +21,8 @@
>  #include "cifsproto.h"
>  #include "cifs_debug.h"
>  #include "fs_context.h"
> +#include "cifs_fs_sb.h"
> +#include "cifs_unicode.h"
>
>  /* security id for everyone/world system group */
>  static const struct cifs_sid sid_everyone = {
> @@ -1668,3 +1671,63 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
>         kfree(pntsd);
>         return rc;
>  }
> +
> +struct posix_acl *cifs_get_acl(struct user_namespace *mnt_userns,
> +                              struct dentry *dentry, int type)
> +{
> +#if defined(CONFIG_CIFS_ALLOW_INSECURE_LEGACY) && defined(CONFIG_CIFS_POSIX)
> +       struct posix_acl *acl = NULL;
> +       ssize_t rc = -EOPNOTSUPP;
> +       unsigned int xid;
> +       struct super_block *sb = dentry->d_sb;
> +       struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
> +       struct tcon_link *tlink;
> +       struct cifs_tcon *pTcon;
> +       const char *full_path;
> +       void *page;
> +
> +       tlink = cifs_sb_tlink(cifs_sb);
> +       if (IS_ERR(tlink))
> +               return ERR_CAST(tlink);
> +       pTcon = tlink_tcon(tlink);
> +
> +       xid = get_xid();
> +       page = alloc_dentry_path();
> +
> +       full_path = build_path_from_dentry(dentry, page);
> +       if (IS_ERR(full_path)) {
> +               acl = ERR_CAST(full_path);
> +               goto out;
> +       }
> +
> +       /* return alt name if available as pseudo attr */
> +       switch (type) {
> +       case ACL_TYPE_ACCESS:
> +               if (sb->s_flags & SB_POSIXACL)
> +                       rc = cifs_do_get_acl(xid, pTcon, full_path, &acl,
> +                                            ACL_TYPE_ACCESS,
> +                                            cifs_sb->local_nls,
> +                                            cifs_remap(cifs_sb));
> +               break;
> +
> +       case ACL_TYPE_DEFAULT:
> +               if (sb->s_flags & SB_POSIXACL)
> +                       rc = cifs_do_get_acl(xid, pTcon, full_path, &acl,
> +                                            ACL_TYPE_DEFAULT,
> +                                            cifs_sb->local_nls,
> +                                            cifs_remap(cifs_sb));
> +               break;
> +       }
> +
> +       if (rc == -EINVAL)
> +               acl = ERR_PTR(-EOPNOTSUPP);
> +
> +out:
> +       free_dentry_path(page);
> +       free_xid(xid);
> +       cifs_put_tlink(tlink);
> +       return acl;
> +#else
> +       return ERR_PTR(-EOPNOTSUPP);
> +#endif
> +}
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index f54d8bf2732a..5c00d79fda99 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -1128,6 +1128,7 @@ const struct inode_operations cifs_dir_inode_ops = {
>         .symlink = cifs_symlink,
>         .mknod   = cifs_mknod,
>         .listxattr = cifs_listxattr,
> +       .get_acl = cifs_get_acl,
>  };
>
>  const struct inode_operations cifs_file_inode_ops = {
> @@ -1136,6 +1137,7 @@ const struct inode_operations cifs_file_inode_ops = {
>         .permission = cifs_permission,
>         .listxattr = cifs_listxattr,
>         .fiemap = cifs_fiemap,
> +       .get_acl = cifs_get_acl,
>  };
>
>  const struct inode_operations cifs_symlink_inode_ops = {
> diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
> index 3bc94bcc7177..953fd910da70 100644
> --- a/fs/cifs/cifsproto.h
> +++ b/fs/cifs/cifsproto.h
> @@ -225,6 +225,8 @@ extern struct cifs_ntsd *get_cifs_acl(struct cifs_sb_info *, struct inode *,
>                                       const char *, u32 *, u32);
>  extern struct cifs_ntsd *get_cifs_acl_by_fid(struct cifs_sb_info *,
>                                 const struct cifs_fid *, u32 *, u32);
> +extern struct posix_acl *cifs_get_acl(struct user_namespace *mnt_userns,
> +                                     struct dentry *dentry, int type);
>  extern int set_cifs_acl(struct cifs_ntsd *, __u32, struct inode *,
>                                 const char *, int);
>  extern unsigned int setup_authusers_ACE(struct cifs_ace *pace);
> @@ -542,6 +544,10 @@ extern int CIFSSMBGetPosixACL(const unsigned int xid, struct cifs_tcon *tcon,
>                 const unsigned char *searchName,
>                 char *acl_inf, const int buflen, const int acl_type,
>                 const struct nls_table *nls_codepage, int remap_special_chars);
> +extern int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
> +                          const unsigned char *searchName,
> +                          struct posix_acl **acl, const int acl_type,
> +                          const struct nls_table *nls_codepage, int remap);
>  extern int CIFSSMBSetPosixACL(const unsigned int xid, struct cifs_tcon *tcon,
>                 const unsigned char *fileName,
>                 const char *local_acl, const int buflen, const int acl_type,
> diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> index 7aa91e272027..f53d2eb100ca 100644
> --- a/fs/cifs/cifssmb.c
> +++ b/fs/cifs/cifssmb.c
> @@ -3212,6 +3212,196 @@ CIFSSMBSetPosixACL(const unsigned int xid, struct cifs_tcon *tcon,
>         return rc;
>  }
>
> +/**
> + * cifs_init_posix_acl - convert ACL from cifs to POSIX ACL format
> + * @ace: POSIX ACL entry to store converted ACL into
> + * @cifs: ACL in cifs format
> + *
> + * Convert an Access Control Entry from wire format to local POSIX xattr
> + * format.
> + *
> + * Note that the @cifs_uid member is used to store both {g,u}id_t.
> + */
> +static void cifs_init_posix_acl(struct posix_acl_entry *ace,
> +                               struct cifs_posix_ace *cifs_ace)
> +{
> +       /* u8 cifs fields do not need le conversion */
> +       ace->e_perm = cpu_to_le16(cifs_ace->cifs_e_perm);
> +       ace->e_tag  = cpu_to_le16(cifs_ace->cifs_e_tag);
> +       switch (ace->e_tag) {
> +       case ACL_USER:
> +               ace->e_uid = make_kuid(&init_user_ns,
> +                                 cpu_to_le32(le64_to_cpu(cifs_ace->cifs_uid)));
> +               break;
> +       case ACL_GROUP:
> +               ace->e_gid = make_kgid(&init_user_ns,
> +                                 cpu_to_le32(le64_to_cpu(cifs_ace->cifs_uid)));
> +               break;
> +       }
> +/*
> +       cifs_dbg(FYI, "perm %d tag %d id %d\n",
> +                ace->e_perm, ace->e_tag, ace->e_id);
> +*/
> +
> +       return;
> +}
> +
> +/**
> + * cifs_to_posix_acl - copy cifs ACL format to POSIX ACL format
> + * @acl: ACLs returned in POSIX ACL format
> + * @src: ACLs in cifs format
> + * @acl_type: type of POSIX ACL requested
> + * @size_of_data_area: size of SMB we got
> + *
> + * This function converts ACLs from cifs format to POSIX ACL format.
> + * If @acl is NULL then the size of the buffer required to store POSIX ACLs in
> + * their uapi format is returned.
> + */
> +static int cifs_to_posix_acl(struct posix_acl **acl, char *src,
> +                            const int acl_type, const int size_of_data_area)
> +{
> +       int size =  0;
> +       __u16 count;
> +       struct cifs_posix_ace *pACE;
> +       struct cifs_posix_acl *cifs_acl = (struct cifs_posix_acl *)src;
> +       struct posix_acl *kacl = NULL;
> +       struct posix_acl_entry *pa, *pe;
> +
> +       if (le16_to_cpu(cifs_acl->version) != CIFS_ACL_VERSION)
> +               return -EOPNOTSUPP;
> +
> +       if (acl_type == ACL_TYPE_ACCESS) {
> +               count = le16_to_cpu(cifs_acl->access_entry_count);
> +               pACE = &cifs_acl->ace_array[0];
> +               size = sizeof(struct cifs_posix_acl);
> +               size += sizeof(struct cifs_posix_ace) * count;
> +               /* check if we would go beyond end of SMB */
> +               if (size_of_data_area < size) {
> +                       cifs_dbg(FYI, "bad CIFS POSIX ACL size %d vs. %d\n",
> +                                size_of_data_area, size);
> +                       return -EINVAL;
> +               }
> +       } else if (acl_type == ACL_TYPE_DEFAULT) {
> +               count = le16_to_cpu(cifs_acl->access_entry_count);
> +               size = sizeof(struct cifs_posix_acl);
> +               size += sizeof(struct cifs_posix_ace) * count;
> +/* skip past access ACEs to get to default ACEs */
> +               pACE = &cifs_acl->ace_array[count];
> +               count = le16_to_cpu(cifs_acl->default_entry_count);
> +               size += sizeof(struct cifs_posix_ace) * count;
> +               /* check if we would go beyond end of SMB */
> +               if (size_of_data_area < size)
> +                       return -EINVAL;
> +       } else {
> +               /* illegal type */
> +               return -EINVAL;
> +       }
> +
> +       /* Allocate number of POSIX ACLs to store in VFS format. */
> +       kacl = posix_acl_alloc(count, GFP_NOFS);
> +       if (!kacl)
> +               return -ENOMEM;
> +
> +       FOREACH_ACL_ENTRY(pa, kacl, pe) {
> +               cifs_init_posix_acl(pa, pACE);
> +               pACE++;
> +       }
> +
> +       *acl = kacl;
> +       return 0;
> +}
> +
> +int cifs_do_get_acl(const unsigned int xid, struct cifs_tcon *tcon,
> +                   const unsigned char *searchName, struct posix_acl **acl,
> +                   const int acl_type, const struct nls_table *nls_codepage,
> +                   int remap)
> +{
> +/* SMB_QUERY_POSIX_ACL */
> +       TRANSACTION2_QPI_REQ *pSMB = NULL;
> +       TRANSACTION2_QPI_RSP *pSMBr = NULL;
> +       int rc = 0;
> +       int bytes_returned;
> +       int name_len;
> +       __u16 params, byte_count;
> +
> +       cifs_dbg(FYI, "In GetPosixACL (Unix) for path %s\n", searchName);
> +
> +queryAclRetry:
> +       rc = smb_init(SMB_COM_TRANSACTION2, 15, tcon, (void **) &pSMB,
> +               (void **) &pSMBr);
> +       if (rc)
> +               return rc;
> +
> +       if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
> +               name_len =
> +                       cifsConvertToUTF16((__le16 *) pSMB->FileName,
> +                                          searchName, PATH_MAX, nls_codepage,
> +                                          remap);
> +               name_len++;     /* trailing null */
> +               name_len *= 2;
> +               pSMB->FileName[name_len] = 0;
> +               pSMB->FileName[name_len+1] = 0;
> +       } else {
> +               name_len = copy_path_name(pSMB->FileName, searchName);
> +       }
> +
> +       params = 2 /* level */  + 4 /* rsrvd */  + name_len /* incl null */ ;
> +       pSMB->TotalDataCount = 0;
> +       pSMB->MaxParameterCount = cpu_to_le16(2);
> +       /* BB find exact max data count below from sess structure BB */
> +       pSMB->MaxDataCount = cpu_to_le16(4000);
> +       pSMB->MaxSetupCount = 0;
> +       pSMB->Reserved = 0;
> +       pSMB->Flags = 0;
> +       pSMB->Timeout = 0;
> +       pSMB->Reserved2 = 0;
> +       pSMB->ParameterOffset = cpu_to_le16(
> +               offsetof(struct smb_com_transaction2_qpi_req,
> +                        InformationLevel) - 4);
> +       pSMB->DataCount = 0;
> +       pSMB->DataOffset = 0;
> +       pSMB->SetupCount = 1;
> +       pSMB->Reserved3 = 0;
> +       pSMB->SubCommand = cpu_to_le16(TRANS2_QUERY_PATH_INFORMATION);
> +       byte_count = params + 1 /* pad */ ;
> +       pSMB->TotalParameterCount = cpu_to_le16(params);
> +       pSMB->ParameterCount = pSMB->TotalParameterCount;
> +       pSMB->InformationLevel = cpu_to_le16(SMB_QUERY_POSIX_ACL);
> +       pSMB->Reserved4 = 0;
> +       inc_rfc1001_len(pSMB, byte_count);
> +       pSMB->ByteCount = cpu_to_le16(byte_count);
> +
> +       rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
> +               (struct smb_hdr *) pSMBr, &bytes_returned, 0);
> +       cifs_stats_inc(&tcon->stats.cifs_stats.num_acl_get);
> +       if (rc) {
> +               cifs_dbg(FYI, "Send error in Query POSIX ACL = %d\n", rc);
> +       } else {
> +               /* decode response */
> +
> +               rc = validate_t2((struct smb_t2_rsp *)pSMBr);
> +               /* BB also check enough total bytes returned */
> +               if (rc || get_bcc(&pSMBr->hdr) < 2)
> +                       rc = -EIO;      /* bad smb */
> +               else {
> +                       __u16 data_offset = le16_to_cpu(pSMBr->t2.DataOffset);
> +                       __u16 count = le16_to_cpu(pSMBr->t2.DataCount);
> +                       rc = cifs_to_posix_acl(acl,
> +                               (char *)&pSMBr->hdr.Protocol+data_offset,
> +                               acl_type, count);
> +               }
> +       }
> +       cifs_buf_release(pSMB);
> +       /*
> +        * The else branch after SendReceive() doesn't return EAGAIN so if we
> +        * allocated @acl in cifs_to_posix_acl() we are guaranteed to return
> +        * here and don't leak POSIX ACLs.
> +        */
> +       if (rc == -EAGAIN)
> +               goto queryAclRetry;
> +       return rc;
> +}
> +
>  int
>  CIFSGetExtAttr(const unsigned int xid, struct cifs_tcon *tcon,
>                const int netfid, __u64 *pExtAttrBits, __u64 *pMask)
> --
> 2.34.1
>


-- 
Thanks,

Steve
