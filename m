Return-Path: <linux-fsdevel+bounces-39608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A64EA16244
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 15:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3B33A59FC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jan 2025 14:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243681DEFCD;
	Sun, 19 Jan 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZV4lVS2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E6E63CB;
	Sun, 19 Jan 2025 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737298222; cv=none; b=nuQRtcy/sfhPsAS2I7a+7ZtMNsQvH0Qa6cJ2SJwHtz0M+RUCZ0XzaCr9mL07cyYV49xq/j109cTiLkSLtUYhLm9Qx3zZHdLWGQif2Qn+jm7zSHL5f3BSESbo7P9tJ0nwelOZsCCaw3Yt+r93DxcMyF7fT5Y1lYCiHzn3uLCdB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737298222; c=relaxed/simple;
	bh=EHb/NdrmA03zfMVHcshNAP2tqT3ZmMEvJiHEg+o5pwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmtN4NxEJWquJyDANoqAfr/jLtJPzzEgseZK+a+GoEcP8MWDJEOzFoihFlfdl9GTwdISs+tGuncQZs8CLtmTQfy7A5sgp9f+ofGMEMJp3Zc2yHK7T8Jo0aiSZdMgm6bVVMB+BZM/uSxT9rkYCjlJ2CgrO9mO5OjPMxnbHWS9k5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZV4lVS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2C0C4CEE3;
	Sun, 19 Jan 2025 14:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737298221;
	bh=EHb/NdrmA03zfMVHcshNAP2tqT3ZmMEvJiHEg+o5pwM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RZV4lVS2T88c6DQFJEERKVieWHupJo3yc9VXhfoTKcO0lhHoTMUglTwM6CdfHhFZu
	 QYXd4I+bfxYdgDEASN/msZI1pOONMK8h4FqtjqK88XMw2m3wLXek3yDZqmmqfbaH4D
	 Jz+pb4F9KTf+XtZ6FRuYJnCctKaXLy6Ayb4Aro+zlcf/E52OIbEv6nkm6ZIy2sOO2s
	 8ZiRxn0dF7LpD+Qpi7J7gDHdEtayOnsdqCCNn63pKfkGxfnc8vrLjeAfr1CFyhaEqf
	 wJXJXkOXjkfkABjXXHExvrpEeQ1hySdjKU9FEWrrLa2FRSshX6OLCLN3zgmsTiE43E
	 WpelCTKSeAfQg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-304d757a9c1so35819041fa.0;
        Sun, 19 Jan 2025 06:50:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTVMFsrm1HxZpB/A9nTegZf5fw1JQICwmwV7hKOYmeOuefVyZvhBjvmEWVQnC3G2BL2GYjZ2KONEc=@vger.kernel.org, AJvYcCW1YFgsuw1ObrecsPQ3BX9V4/Y07r8CdByZviP8BIIATNr7H4c6ojbyrz3PlUvkmprwGZs7trAg2E3ro1JqeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxks3/TTSRCSNWaUsupFlTTGOGRy995cvf/hUWcEOhdBAUK6Fou
	6BcirMYFziEUS/aYpbV+J3uTSQEuOaDbAuCHy8yrLKUF4Qd3ax7V7sgaK1gROk4mFAaWTm46Vml
	qwIiM85CbirhpKC3pxS2Rg2Nh+Rw=
X-Google-Smtp-Source: AGHT+IFtyudpG81inZycnx8V5mvBlshhYpDHE+QDZZi70adGL9s6gIemWa6GkmrgmV6JiY8FJGWhSv0t6aAuONFjuZo=
X-Received: by 2002:a05:651c:118d:b0:302:23a7:1ee8 with SMTP id
 38308e7fff4ca-3063057702fmr55657461fa.3.1737298220158; Sun, 19 Jan 2025
 06:50:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
 <20250107023525.11466-5-James.Bottomley@HansenPartnership.com>
 <20250116183643.GI1977892@ZenIV> <0b770a342780510f1cd82a506bc67124752b170c.camel@HansenPartnership.com>
 <ae267db4fe60f564c6aa0400dd2a7eef4fe9db18.camel@HansenPartnership.com>
In-Reply-To: <ae267db4fe60f564c6aa0400dd2a7eef4fe9db18.camel@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 19 Jan 2025 15:50:09 +0100
X-Gmail-Original-Message-ID: <CAMj1kXGH4o50xfb_Rv3-gHxq_s2OeSWOpa9CaSf7v5vSrC9eDg@mail.gmail.com>
X-Gm-Features: AbW1kvbGAIxk94OOWHDnRRdq_UH81vtgyAgG3l_t2QrcqX8f7zjL5tIMGhntBjg
Message-ID: <CAMj1kXGH4o50xfb_Rv3-gHxq_s2OeSWOpa9CaSf7v5vSrC9eDg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] efivarfs: move freeing of variable entry into evict_inode
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-efi@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jan 2025 at 23:13, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Thu, 2025-01-16 at 14:05 -0500, James Bottomley wrote:
> > On Thu, 2025-01-16 at 18:36 +0000, Al Viro wrote:
> > > On Mon, Jan 06, 2025 at 06:35:23PM -0800, James Bottomley wrote:
> > > > Make the inodes the default management vehicle for struct
> > > > efivar_entry, so they are now all freed automatically if the file
> > > > is removed and on unmount in kill_litter_super().  Remove the now
> > > > superfluous iterator to free the entries after
> > > > kill_litter_super().
> > > >
> > > > Also fixes a bug where some entry freeing was missing causing
> > > > efivarfs to leak memory.
> > >
> > > Umm...  I'd rather coallocate struct inode and struct efivar_entry;
> > > that way once you get rid of the list you don't need -
> > > >evict_inode()
> > > anymore.
> > >
> > > It's pretty easy - see e.g.
> > > https://lore.kernel.org/all/20250112080705.141166-1-viro@zeniv.linux.org.uk/
> > > for recent example of such conversion.
> >
> > OK, I can do that.  Although I think since the number of variables is
> > usually around 150, it would probably be overkill to give it its own
> > inode cache allocator.
>
> OK, this is what I've got.  As you can see from the diffstat it's about
> 10 lines more than the previous; mostly because of the new allocation
> routine, the fact that the root inode has to be special cased for the
> list and the guid has to be parsed in efivarfs_create before we have
> the inode.
>

That looks straight-forward enough.

Can you send this as a proper patch? Or would you prefer me to squash
this into the one that is already queued up?

I'm fine with either, but note that I'd still like to target v6.14 with this.



> ---
>
>  fs/efivarfs/file.c     |  6 +++---
>  fs/efivarfs/inode.c    | 27 +++++++++++----------------
>  fs/efivarfs/internal.h |  6 ++++++
>  fs/efivarfs/super.c    | 45 ++++++++++++++++++++++++++----------------
> ---
>  4 files changed, 46 insertions(+), 38 deletions(-)
>
> diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
> index 23c51d62f902..176362b73d38 100644
> --- a/fs/efivarfs/file.c
> +++ b/fs/efivarfs/file.c
> @@ -15,10 +15,10 @@
>  static ssize_t efivarfs_file_write(struct file *file,
>                 const char __user *userbuf, size_t count, loff_t
> *ppos)
>  {
> -       struct efivar_entry *var = file->private_data;
>         void *data;
>         u32 attributes;
>         struct inode *inode = file->f_mapping->host;
> +       struct efivar_entry *var = efivar_entry(inode);
>         unsigned long datasize = count - sizeof(attributes);
>         ssize_t bytes;
>         bool set = false;
> @@ -66,7 +66,8 @@ static ssize_t efivarfs_file_write(struct file *file,
>  static ssize_t efivarfs_file_read(struct file *file, char __user
> *userbuf,
>                 size_t count, loff_t *ppos)
>  {
> -       struct efivar_entry *var = file->private_data;
> +       struct inode *inode = file->f_mapping->host;
> +       struct efivar_entry *var = efivar_entry(inode);
>         unsigned long datasize = 0;
>         u32 attributes;
>         void *data;
> @@ -107,7 +108,6 @@ static ssize_t efivarfs_file_read(struct file
> *file, char __user *userbuf,
>  }
>
>  const struct file_operations efivarfs_file_operations = {
> -       .open   = simple_open,
>         .read   = efivarfs_file_read,
>         .write  = efivarfs_file_write,
>  };
> diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
> index ec23da8405ff..a13ffb01e149 100644
> --- a/fs/efivarfs/inode.c
> +++ b/fs/efivarfs/inode.c
> @@ -82,26 +82,23 @@ static int efivarfs_create(struct mnt_idmap *idmap,
> struct inode *dir,
>         struct efivar_entry *var;
>         int namelen, i = 0, err = 0;
>         bool is_removable = false;
> +       efi_guid_t vendor;
>
>         if (!efivarfs_valid_name(dentry->d_name.name, dentry-
> >d_name.len))
>                 return -EINVAL;
>
> -       var = kzalloc(sizeof(struct efivar_entry), GFP_KERNEL);
> -       if (!var)
> -               return -ENOMEM;
> -
>         /* length of the variable name itself: remove GUID and
> separator */
>         namelen = dentry->d_name.len - EFI_VARIABLE_GUID_LEN - 1;
>
> -       err = guid_parse(dentry->d_name.name + namelen + 1, &var-
> >var.VendorGuid);
> +       err = guid_parse(dentry->d_name.name + namelen + 1, &vendor);
>         if (err)
>                 goto out;
> -       if (guid_equal(&var->var.VendorGuid,
> &LINUX_EFI_RANDOM_SEED_TABLE_GUID)) {
> +       if (guid_equal(&vendor, &LINUX_EFI_RANDOM_SEED_TABLE_GUID)) {
>                 err = -EPERM;
>                 goto out;
>         }
>
> -       if (efivar_variable_is_removable(var->var.VendorGuid,
> +       if (efivar_variable_is_removable(vendor,
>                                          dentry->d_name.name,
> namelen))
>                 is_removable = true;
>
> @@ -110,15 +107,15 @@ static int efivarfs_create(struct mnt_idmap
> *idmap, struct inode *dir,
>                 err = -ENOMEM;
>                 goto out;
>         }
> +       var = efivar_entry(inode);
> +
> +       var->var.VendorGuid = vendor;
>
>         for (i = 0; i < namelen; i++)
>                 var->var.VariableName[i] = dentry->d_name.name[i];
>
>         var->var.VariableName[i] = '\0';
>
> -       inode->i_private = var;
> -       kmemleak_ignore(var);
> -
>         err = efivar_entry_add(var, &info->efivarfs_list);
>         if (err)
>                 goto out;
> @@ -126,17 +123,15 @@ static int efivarfs_create(struct mnt_idmap
> *idmap, struct inode *dir,
>         d_instantiate(dentry, inode);
>         dget(dentry);
>  out:
> -       if (err) {
> -               kfree(var);
> -               if (inode)
> -                       iput(inode);
> -       }
> +       if (err && inode)
> +               iput(inode);
> +
>         return err;
>  }
>
>  static int efivarfs_unlink(struct inode *dir, struct dentry *dentry)
>  {
> -       struct efivar_entry *var = d_inode(dentry)->i_private;
> +       struct efivar_entry *var = efivar_entry(d_inode(dentry));
>
>         if (efivar_entry_delete(var))
>                 return -EINVAL;
> diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
> index 8d82fc8bca31..fce7d5e5c763 100644
> --- a/fs/efivarfs/internal.h
> +++ b/fs/efivarfs/internal.h
> @@ -29,8 +29,14 @@ struct efi_variable {
>  struct efivar_entry {
>         struct efi_variable var;
>         struct list_head list;
> +       struct inode vfs_inode;
>  };
>
> +static inline struct efivar_entry *efivar_entry(struct inode *inode)
> +{
> +       return container_of(inode, struct efivar_entry, vfs_inode);
> +}
> +
>  int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long,
> void *,
>                             struct list_head *),
>                 void *data, struct list_head *head);
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index d7facc99b745..cfead280534c 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -39,15 +39,25 @@ static int efivarfs_ops_notifier(struct
> notifier_block *nb, unsigned long event,
>         return NOTIFY_OK;
>  }
>
> -static void efivarfs_evict_inode(struct inode *inode)
> +static struct inode *efivarfs_alloc_inode(struct super_block *sb)
>  {
> -       struct efivar_entry *entry = inode->i_private;
> +       struct efivar_entry *entry = kzalloc(sizeof(*entry),
> GFP_KERNEL);
>
> -       if (entry)  {
> +       if (!entry)
> +               return NULL;
> +
> +       inode_init_once(&entry->vfs_inode);
> +
> +       return &entry->vfs_inode;
> +}
> +
> +static void efivarfs_free_inode(struct inode *inode)
> +{
> +       struct efivar_entry *entry = efivar_entry(inode);
> +
> +       if (!is_root_inode(inode))
>                 list_del(&entry->list);
> -               kfree(entry);
> -       }
> -       clear_inode(inode);
> +       kfree(entry);
>  }
>
>  static int efivarfs_show_options(struct seq_file *m, struct dentry
> *root)
> @@ -112,7 +122,8 @@ static int efivarfs_statfs(struct dentry *dentry,
> struct kstatfs *buf)
>  static const struct super_operations efivarfs_ops = {
>         .statfs = efivarfs_statfs,
>         .drop_inode = generic_delete_inode,
> -       .evict_inode = efivarfs_evict_inode,
> +       .alloc_inode = efivarfs_alloc_inode,
> +       .free_inode = efivarfs_free_inode,
>         .show_options = efivarfs_show_options,
>  };
>
> @@ -233,21 +244,14 @@ static int efivarfs_callback(efi_char16_t
> *name16, efi_guid_t vendor,
>         if (guid_equal(&vendor, &LINUX_EFI_RANDOM_SEED_TABLE_GUID))
>                 return 0;
>
> -       entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> -       if (!entry)
> -               return err;
> -
> -       memcpy(entry->var.VariableName, name16, name_size);
> -       memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
> -
>         name = efivar_get_utf8name(name16, &vendor);
>         if (!name)
> -               goto fail;
> +               return err;
>
>         /* length of the variable name itself: remove GUID and
> separator */
>         len = strlen(name) - EFI_VARIABLE_GUID_LEN - 1;
>
> -       if (efivar_variable_is_removable(entry->var.VendorGuid, name,
> len))
> +       if (efivar_variable_is_removable(vendor, name, len))
>                 is_removable = true;
>
>         inode = efivarfs_get_inode(sb, d_inode(root), S_IFREG | 0644,
> 0,
> @@ -255,6 +259,11 @@ static int efivarfs_callback(efi_char16_t *name16,
> efi_guid_t vendor,
>         if (!inode)
>                 goto fail_name;
>
> +       entry = efivar_entry(inode);
> +
> +       memcpy(entry->var.VariableName, name16, name_size);
> +       memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
> +
>         dentry = efivarfs_alloc_dentry(root, name);
>         if (IS_ERR(dentry)) {
>                 err = PTR_ERR(dentry);
> @@ -268,7 +277,6 @@ static int efivarfs_callback(efi_char16_t *name16,
> efi_guid_t vendor,
>         kfree(name);
>
>         inode_lock(inode);
> -       inode->i_private = entry;
>         i_size_write(inode, size + sizeof(__u32)); /* attributes +
> data */
>         inode_unlock(inode);
>         d_add(dentry, inode);
> @@ -279,8 +287,7 @@ static int efivarfs_callback(efi_char16_t *name16,
> efi_guid_t vendor,
>         iput(inode);
>  fail_name:
>         kfree(name);
> -fail:
> -       kfree(entry);
> +
>         return err;
>  }
>
>

