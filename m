Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C4D5F8B2C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Oct 2022 14:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJIMYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Oct 2022 08:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiJIMYr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:24:47 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EC562CD
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 Oct 2022 05:24:45 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gf8so7833651pjb.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Oct 2022 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kERCXiIYQm7S1WbFxFb2Wj/hYe44aiyCtQNjQhPgXp4=;
        b=JtnVn1R4euZ8NjehEj9UnwDit7ccW40z63vRunjfHqnLFy17Kr77iK4GNqsXR1Y161
         C5h3t6Iv5eXS2pNE3pSarbaXWOYm5CgsOQU6G/2tBB7pVERkW326l1oLnhtrrkt/yKV+
         Bl3MHmr2t3PtX40zl7WccXzztSwgcrmDNBcgAMz5z1BA/2DRPTgCa7ECfENzY/q//SJq
         mBK+woBW1KZu5OShFTSF6MohepgoFL0qgUEGYRFfOD1i/VwsWkD6bce4wu4NwB4tZREF
         Rf1YwRYjU27s74eBBxjIxmkgeNAFGb6X06CE/QbmQ4eBPxyoPtS+e2lay+xrLJHPlZkp
         mQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kERCXiIYQm7S1WbFxFb2Wj/hYe44aiyCtQNjQhPgXp4=;
        b=RujuXs+iILqFyvU+WzSOx6LxuoLApPPccxl1OArqhMdL/eBvl6ua1gjeCPBEsSuWMR
         wWngMkvbp/pvgRMtZP2MPfBAayDvMI30kQZ6leI+Yl1CydhehO/EkzVpt2CIstozyqSe
         rwcZJXuQIh1FPIZ+ZNIX7YdbKfpnrYwDZSkIiL/psZgiAmx/+s1ZRdWDMLZIeaXU+fIW
         M8kyhWWx1sIwi6svbAig/ksGkx91HcZ7Decp+QLVGJyMaKtFDuVshwFm9QelbGf+sOZE
         +arvco9v/66QMyWJ8pO+WvNkkIu77zYlVbcPWtlvyyV6B/P0ScmkyS2KBZeCpejNfe7F
         bC+g==
X-Gm-Message-State: ACrzQf1N77Q2y7CHfhKo0kjZk2Uh2jxiJ37Ir9oILqc66c+XQCEIbev5
        jRAm4ytMc5J5ey1LeUkbTTr+5S2nk+RNKA==
X-Google-Smtp-Source: AMsMyM7Qp0/hhUaR/2o0nV/4ggFg2JIPESmxVXM+dGuZMxgz9+DVA5phNAROJ8j46Z0RXdNnVkA7fQ==
X-Received: by 2002:a17:90b:4c0b:b0:203:6d81:bb53 with SMTP id na11-20020a17090b4c0b00b002036d81bb53mr26160306pjb.3.1665318284747;
        Sun, 09 Oct 2022 05:24:44 -0700 (PDT)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com. [209.85.214.173])
        by smtp.gmail.com with ESMTPSA id w124-20020a626282000000b00562784609fbsm4826414pfb.209.2022.10.09.05.24.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 05:24:44 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id l1so8218133pld.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Oct 2022 05:24:43 -0700 (PDT)
X-Received: by 2002:a17:902:a70b:b0:181:d20e:6565 with SMTP id
 w11-20020a170902a70b00b00181d20e6565mr3201193plq.66.1665318283445; Sun, 09
 Oct 2022 05:24:43 -0700 (PDT)
MIME-Version: 1.0
References: <c7a64cb8-5b67-bb9f-01ef-65b655cb2a92@gmail.com>
In-Reply-To: <c7a64cb8-5b67-bb9f-01ef-65b655cb2a92@gmail.com>
From:   Kari Argillander <kari.argillander@gmail.com>
Date:   Sun, 9 Oct 2022 15:24:32 +0300
X-Gmail-Original-Message-ID: <CAKBF=pvOshMdk8PenuneNADQjbyz2CTP2H75kNCtw4X+vgVtvA@mail.gmail.com>
Message-ID: <CAKBF=pvOshMdk8PenuneNADQjbyz2CTP2H75kNCtw4X+vgVtvA@mail.gmail.com>
Subject: Re: [PATCH] fs/ntfs3: Add windows_names mount option
To:     Daniel Pinto <danielpinto52@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, 7 Oct 2022 at 14:55, Daniel Pinto <danielpinto52@gmail.com> wrote:
>
> When enabled, the windows_names mount option prevents the creation
> of files or directories with names not allowed by Windows. Use
> the same option name as NTFS-3G for compatibility.

Can you also add this mount option to documentation.

> Signed-off-by: Daniel Pinto <danielpinto52@gmail.com>
> ---
>  fs/ntfs3/frecord.c |   7 ++-
>  fs/ntfs3/fsntfs.c  | 104 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/ntfs3/inode.c   |   7 +++
>  fs/ntfs3/ntfs_fs.h |   2 +
>  fs/ntfs3/super.c   |   7 +++
>  5 files changed, 126 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index 70a80f9412f7..ce5e8f3b1aca 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -3011,6 +3011,7 @@ int ni_add_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
>                 struct NTFS_DE *de)
>  {
>         int err;
> +       struct ntfs_sb_info *sbi = ni->mi.sbi;
>         struct ATTRIB *attr;
>         struct ATTR_LIST_ENTRY *le;
>         struct mft_inode *mi;
> @@ -3018,6 +3019,10 @@ int ni_add_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
>         struct ATTR_FILE_NAME *de_name = (struct ATTR_FILE_NAME *)(de + 1);
>         u16 de_key_size = le16_to_cpu(de->key_size);
>
> +       if (sbi->options->windows_names &&
> +           !valid_windows_name(sbi, (struct le_str *)&de_name->name_len))
> +               return -EINVAL;
> +
>         mi_get_ref(&ni->mi, &de->ref);
>         mi_get_ref(&dir_ni->mi, &de_name->home);
>
> @@ -3036,7 +3041,7 @@ int ni_add_name(struct ntfs_inode *dir_ni, struct ntfs_inode *ni,
>         memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), de_name, de_key_size);
>
>         /* Insert new name into directory. */
> -       err = indx_insert_entry(&dir_ni->dir, dir_ni, de, ni->mi.sbi, NULL, 0);
> +       err = indx_insert_entry(&dir_ni->dir, dir_ni, de, sbi, NULL, 0);
>         if (err)
>                 ni_remove_attr_le(ni, attr, mi, le);
>
> diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
> index 4ed15f64b17f..674b644e1070 100644
> --- a/fs/ntfs3/fsntfs.c
> +++ b/fs/ntfs3/fsntfs.c
> @@ -98,6 +98,30 @@ const __le16 WOF_NAME[17] = {
>  };
>  #endif
>
> +static const __le16 CON_NAME[3] = {
> +       cpu_to_le16('C'), cpu_to_le16('O'), cpu_to_le16('N'),
> +};
> +
> +static const __le16 NUL_NAME[3] = {
> +       cpu_to_le16('N'), cpu_to_le16('U'), cpu_to_le16('L'),
> +};
> +
> +static const __le16 AUX_NAME[3] = {
> +       cpu_to_le16('A'), cpu_to_le16('U'), cpu_to_le16('X'),
> +};
> +
> +static const __le16 PRN_NAME[3] = {
> +       cpu_to_le16('P'), cpu_to_le16('R'), cpu_to_le16('N'),
> +};
> +
> +static const __le16 COM_NAME[3] = {
> +       cpu_to_le16('C'), cpu_to_le16('O'), cpu_to_le16('M'),
> +};
> +
> +static const __le16 LPT_NAME[3] = {
> +       cpu_to_le16('L'), cpu_to_le16('P'), cpu_to_le16('T'),
> +};
> +
>  // clang-format on
>
>  /*
> @@ -2502,3 +2526,83 @@ int run_deallocate(struct ntfs_sb_info *sbi, struct runs_tree *run, bool trim)
>
>         return 0;
>  }
> +
> +static inline bool name_has_forbidden_chars(const struct le_str *fname)
> +{
> +       int i, ch;
> +
> +       /* check for forbidden chars */
> +       for (i = 0; i < fname->len; ++i) {
> +               ch = le16_to_cpu(fname->name[i]);
> +
> +               /* control chars */
> +               if (ch < 0x20)
> +                       return true;
> +
> +               switch (ch) {
> +               /* disallowed by Windows */
> +               case '\\':
> +               case '/':
> +               case ':':
> +               case '*':
> +               case '?':
> +               case '<':
> +               case '>':
> +               case '|':
> +               case '\"':
> +                       return true;
> +
> +               default:
> +                       /* allowed char */
> +                       break;
> +               }
> +       }
> +
> +       /* file names cannot end with space or . */
> +       if (fname->len > 0) {
> +               ch = le16_to_cpu(fname->name[fname->len - 1]);
> +               if (ch == ' ' || ch == '.')
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +static inline bool is_reserved_name(struct ntfs_sb_info *sbi,
> +                                   const struct le_str *fname)
> +{
> +       int port_digit;
> +       const __le16 *name = fname->name;
> +       int len = fname->len;
> +       u16 *upcase = sbi->upcase;
> +
> +       /* check for 3 chars reserved names (device names) */
> +       /* name by itself or with any extension is forbidden */
> +       if (len == 3 || (len > 3 && le16_to_cpu(name[3]) == '.'))
> +               if (!ntfs_cmp_names(name, 3, CON_NAME, 3, upcase, false) ||
> +                   !ntfs_cmp_names(name, 3, NUL_NAME, 3, upcase, false) ||
> +                   !ntfs_cmp_names(name, 3, AUX_NAME, 3, upcase, false) ||
> +                   !ntfs_cmp_names(name, 3, PRN_NAME, 3, upcase, false))
> +                       return true;
> +
> +       /* check for 4 chars reserved names (port name followed by 1..9) */
> +       /* name by itself or with any extension is forbidden */
> +       if (len == 4 || (len > 4 && le16_to_cpu(name[4]) == '.')) {
> +               port_digit = le16_to_cpu(name[3]);
> +               if (port_digit >= '1' && port_digit <= '9')
> +                       if (!ntfs_cmp_names(name, 3, COM_NAME, 3, upcase, false) ||
> +                           !ntfs_cmp_names(name, 3, LPT_NAME, 3, upcase, false))
> +                               return true;
> +       }
> +
> +       return false;
> +}
> +
> +/*
> + * valid_windows_name - Check if a file name is valid in Windows.
> + */
> +bool valid_windows_name(struct ntfs_sb_info *sbi, const struct le_str *fname)
> +{
> +       return !name_has_forbidden_chars(fname) &&
> +              !is_reserved_name(sbi, fname);
> +}
> diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
> index e9cf00d14733..4eb298e2ee98 100644
> --- a/fs/ntfs3/inode.c
> +++ b/fs/ntfs3/inode.c
> @@ -1361,6 +1361,13 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
>         mi_get_ref(&ni->mi, &new_de->ref);
>
>         fname = (struct ATTR_FILE_NAME *)(new_de + 1);
> +
> +       if (sbi->options->windows_names &&
> +           !valid_windows_name(sbi, (struct le_str *)&fname->name_len)) {
> +               err = -EINVAL;
> +               goto out4;
> +       }
> +
>         mi_get_ref(&dir_ni->mi, &fname->home);
>         fname->dup.cr_time = fname->dup.m_time = fname->dup.c_time =
>                 fname->dup.a_time = std5->cr_time;
> diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
> index 6c1c7ef3b2d6..ebfb720fc4fd 100644
> --- a/fs/ntfs3/ntfs_fs.h
> +++ b/fs/ntfs3/ntfs_fs.h
> @@ -98,6 +98,7 @@ struct ntfs_mount_options {
>         unsigned showmeta : 1; /* Show meta files. */
>         unsigned nohidden : 1; /* Do not show hidden files. */
>         unsigned hide_dot_files : 1; /* Set hidden flag on dot files. */
> +       unsigned windows_names : 1; /* Disallow names forbidden by Windows. */
>         unsigned force : 1; /* RW mount dirty volume. */
>         unsigned noacsrules : 1; /* Exclude acs rules. */
>         unsigned prealloc : 1; /* Preallocate space when file is growing. */
> @@ -645,6 +646,7 @@ int ntfs_remove_reparse(struct ntfs_sb_info *sbi, __le32 rtag,
>                         const struct MFT_REF *ref);
>  void mark_as_free_ex(struct ntfs_sb_info *sbi, CLST lcn, CLST len, bool trim);
>  int run_deallocate(struct ntfs_sb_info *sbi, struct runs_tree *run, bool trim);
> +bool valid_windows_name(struct ntfs_sb_info *sbi, const struct le_str *name);
>
>  /* Globals from index.c */
>  int indx_used_bit(struct ntfs_index *indx, struct ntfs_inode *ni, size_t *bit);
> diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
> index 1e2c04e48f98..6f3485fad417 100644
> --- a/fs/ntfs3/super.c
> +++ b/fs/ntfs3/super.c
> @@ -248,6 +248,7 @@ enum Opt {
>         Opt_sparse,
>         Opt_nohidden,
>         Opt_hide_dot_files,
> +       Opt_windows_names,
>         Opt_showmeta,
>         Opt_acl,
>         Opt_iocharset,
> @@ -269,6 +270,7 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
>         fsparam_flag_no("sparse",               Opt_sparse),
>         fsparam_flag_no("hidden",               Opt_nohidden),
>         fsparam_flag_no("hidedotfiles",         Opt_hide_dot_files),
> +       fsparam_flag_no("windows_names",        Opt_windows_names),
>         fsparam_flag_no("acl",                  Opt_acl),
>         fsparam_flag_no("showmeta",             Opt_showmeta),
>         fsparam_flag_no("prealloc",             Opt_prealloc),
> @@ -361,6 +363,9 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
>         case Opt_hide_dot_files:
>                 opts->hide_dot_files = result.negated ? 1 : 0;
>                 break;
> +       case Opt_windows_names:
> +               opts->windows_names = result.negated ? 0 : 1;
> +               break;
>         case Opt_acl:
>                 if (!result.negated)
>  #ifdef CONFIG_NTFS3_FS_POSIX_ACL
> @@ -561,6 +566,8 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
>                 seq_puts(m, ",showmeta");
>         if (opts->nohidden)
>                 seq_puts(m, ",nohidden");
> +       if (opts->windows_names)
> +               seq_puts(m, ",windows_names");
>         if (opts->force)
>                 seq_puts(m, ",force");
>         if (opts->noacsrules)
>
