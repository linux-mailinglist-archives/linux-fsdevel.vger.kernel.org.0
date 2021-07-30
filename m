Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B19D3DB498
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 09:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbhG3Hkd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 03:40:33 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:28205 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237667AbhG3Hkc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:40:32 -0400
Received: from [10.0.2.15] ([86.243.172.93])
        by mwinf5d81 with ME
        id bKgS2500121Fzsu03KgSa2; Fri, 30 Jul 2021 09:40:26 +0200
X-ME-Helo: [10.0.2.15]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 30 Jul 2021 09:40:26 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH v27 04/10] fs/ntfs3: Add file operations and
 implementation
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        pali@kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, kari.argillander@gmail.com,
        oleksandr@natalenko.name
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729134943.778917-5-almaz.alexandrovich@paragon-software.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <27fe7136-c929-a1a1-9ec6-20c051a34b3b@wanadoo.fr>
Date:   Fri, 30 Jul 2021 09:40:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210729134943.778917-5-almaz.alexandrovich@paragon-software.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Le 29/07/2021 à 15:49, Konstantin Komarov a écrit :
> This adds file operations and implementation
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>   fs/ntfs3/dir.c     |  594 +++++++++
>   fs/ntfs3/file.c    | 1130 ++++++++++++++++
>   fs/ntfs3/frecord.c | 3071 ++++++++++++++++++++++++++++++++++++++++++++
>   fs/ntfs3/namei.c   |  578 +++++++++
>   fs/ntfs3/record.c  |  609 +++++++++
>   fs/ntfs3/run.c     | 1111 ++++++++++++++++
>   6 files changed, 7093 insertions(+)
>   create mode 100644 fs/ntfs3/dir.c
>   create mode 100644 fs/ntfs3/file.c
>   create mode 100644 fs/ntfs3/frecord.c
>   create mode 100644 fs/ntfs3/namei.c
>   create mode 100644 fs/ntfs3/record.c
>   create mode 100644 fs/ntfs3/run.c
> 

[...]

> diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
> new file mode 100644
> index 000000000..f5db12cd3
> --- /dev/null
> +++ b/fs/ntfs3/namei.c

[...]

> +/*
> + * ntfs_rename
> + *
> + * inode_operations::rename
> + */
> +static int ntfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
> +		       struct dentry *old_dentry, struct inode *new_dir,
> +		       struct dentry *new_dentry, u32 flags)
> +{
> +	int err;
> +	struct super_block *sb = old_dir->i_sb;
> +	struct ntfs_sb_info *sbi = sb->s_fs_info;
> +	struct ntfs_inode *old_dir_ni = ntfs_i(old_dir);
> +	struct ntfs_inode *new_dir_ni = ntfs_i(new_dir);
> +	struct ntfs_inode *old_ni;
> +	struct ATTR_FILE_NAME *old_name, *new_name, *fname;
> +	u8 name_type;
> +	bool is_same;
> +	struct inode *old_inode, *new_inode;
> +	struct NTFS_DE *old_de, *new_de;
> +	struct ATTRIB *attr;
> +	struct ATTR_LIST_ENTRY *le;
> +	u16 new_de_key_size;
> +
> +	static_assert(SIZEOF_ATTRIBUTE_FILENAME_MAX + SIZEOF_RESIDENT < 1024);
> +	static_assert(SIZEOF_ATTRIBUTE_FILENAME_MAX + sizeof(struct NTFS_DE) <
> +		      1024);
> +	static_assert(PATH_MAX >= 4 * 1024);
> +
> +	if (flags & ~RENAME_NOREPLACE)
> +		return -EINVAL;
> +
> +	old_inode = d_inode(old_dentry);
> +	new_inode = d_inode(new_dentry);
> +
> +	old_ni = ntfs_i(old_inode);
> +
> +	is_same = old_dentry->d_name.len == new_dentry->d_name.len &&
> +		  !memcmp(old_dentry->d_name.name, new_dentry->d_name.name,
> +			  old_dentry->d_name.len);
> +
> +	if (is_same && old_dir == new_dir) {
> +		/* Nothing to do */
> +		err = 0;
> +		goto out;
> +	}
> +
> +	if (ntfs_is_meta_file(sbi, old_inode->i_ino)) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (new_inode) {
> +		/*target name exists. unlink it*/
> +		dget(new_dentry);
> +		ni_lock_dir(new_dir_ni);
> +		err = ntfs_unlink_inode(new_dir, new_dentry);
> +		ni_unlock(new_dir_ni);
> +		dput(new_dentry);
> +		if (err)
> +			goto out;
> +	}
> +
> +	/* allocate PATH_MAX bytes */
> +	old_de = __getname();
> +	if (!old_de) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	err = fill_name_de(sbi, old_de, &old_dentry->d_name, NULL);
> +	if (err < 0)
> +		goto out1;
> +
> +	old_name = (struct ATTR_FILE_NAME *)(old_de + 1);
> +
> +	if (is_same) {
> +		new_de = old_de;
> +	} else {
> +		new_de = Add2Ptr(old_de, 1024);
> +		err = fill_name_de(sbi, new_de, &new_dentry->d_name, NULL);
> +		if (err < 0)
> +			goto out1;
> +	}
> +
> +	ni_lock_dir(old_dir_ni);
> +	ni_lock(old_ni);
> +
> +	mi_get_ref(&old_dir_ni->mi, &old_name->home);
> +
> +	/*get pointer to file_name in mft*/
> +	fname = ni_fname_name(old_ni, (struct cpu_str *)&old_name->name_len,
> +			      &old_name->home, &le);
> +	if (!fname) {
> +		err = -EINVAL;
> +		goto out2;
> +	}
> +
> +	/* Copy fname info from record into new fname */
> +	new_name = (struct ATTR_FILE_NAME *)(new_de + 1);
> +	memcpy(&new_name->dup, &fname->dup, sizeof(fname->dup));
> +
> +	name_type = paired_name(fname->type);
> +
> +	/* remove first name from directory */
> +	err = indx_delete_entry(&old_dir_ni->dir, old_dir_ni, old_de + 1,
> +				le16_to_cpu(old_de->key_size), sbi);
> +	if (err)
> +		goto out3;
> +
> +	/* remove first name from mft */
> +	err = ni_remove_attr_le(old_ni, attr_from_name(fname), le);
> +	if (err)
> +		goto out4;
> +
> +	le16_add_cpu(&old_ni->mi.mrec->hard_links, -1);
> +	old_ni->mi.dirty = true;
> +
> +	if (name_type != FILE_NAME_POSIX) {
> +		/* get paired name */
> +		fname = ni_fname_type(old_ni, name_type, &le);
> +		if (fname) {
> +			/* remove second name from directory */
> +			err = indx_delete_entry(&old_dir_ni->dir, old_dir_ni,
> +						fname, fname_full_size(fname),
> +						sbi);
> +			if (err)
> +				goto out5;
> +
> +			/* remove second name from mft */
> +			err = ni_remove_attr_le(old_ni, attr_from_name(fname),
> +						le);
> +			if (err)
> +				goto out6;
> +
> +			le16_add_cpu(&old_ni->mi.mrec->hard_links, -1);
> +			old_ni->mi.dirty = true;
> +		}
> +	}
> +
> +	/* Add new name */
> +	mi_get_ref(&old_ni->mi, &new_de->ref);
> +	mi_get_ref(&ntfs_i(new_dir)->mi, &new_name->home);
> +
> +	new_de_key_size = le16_to_cpu(new_de->key_size);
> +
> +	/* insert new name in mft */
> +	err = ni_insert_resident(old_ni, new_de_key_size, ATTR_NAME, NULL, 0,
> +				 &attr, NULL);
> +	if (err)
> +		goto out7;
> +
> +	attr->res.flags = RESIDENT_FLAG_INDEXED;
> +
> +	memcpy(Add2Ptr(attr, SIZEOF_RESIDENT), new_name, new_de_key_size);
> +
> +	le16_add_cpu(&old_ni->mi.mrec->hard_links, 1);
> +	old_ni->mi.dirty = true;
> +
> +	/* insert new name in directory */
> +	err = indx_insert_entry(&new_dir_ni->dir, new_dir_ni, new_de, sbi,
> +				NULL);
> +	if (err)
> +		goto out8;
> +
> +	if (IS_DIRSYNC(new_dir))
> +		err = ntfs_sync_inode(old_inode);

This value returned by 'ntfs_sync_inode()' is silenced below.
Maybe the same should be done here?
Anyway, this 'err' is never used and is forced to 0 below

> +	else
> +		mark_inode_dirty(old_inode);
> +
> +	old_dir->i_ctime = old_dir->i_mtime = current_time(old_dir);
> +	if (IS_DIRSYNC(old_dir))
> +		(void)ntfs_sync_inode(old_dir);

here

> +	else
> +		mark_inode_dirty(old_dir);
> +
> +	if (old_dir != new_dir) {
> +		new_dir->i_mtime = new_dir->i_ctime = old_dir->i_ctime;
> +		mark_inode_dirty(new_dir);
> +	}
> +
> +	if (old_inode) {
> +		old_inode->i_ctime = old_dir->i_ctime;
> +		mark_inode_dirty(old_inode);
> +	}
> +
> +	err = 0;

and here.

> +	/* normal way */
> +	goto out2;
> +
> +out8:
> +	/* undo
> +	 * ni_insert_resident(old_ni, new_de_key_size, ATTR_NAME, NULL, 0,
> +	 *			 &attr, NULL);
> +	 */
> +	mi_remove_attr(&old_ni->mi, attr);
> +out7:
> +	/* undo
> +	 * ni_remove_attr_le(old_ni, attr_from_name(fname), le);
> +	 */
> +out6:
> +	/* undo
> +	 * indx_delete_entry(&old_dir_ni->dir, old_dir_ni,
> +	 *					fname, fname_full_size(fname),
> +	 *					sbi);
> +	 */
> +out5:
> +	/* undo
> +	 * ni_remove_attr_le(old_ni, attr_from_name(fname), le);
> +	 */
> +out4:
> +	/* undo:
> +	 * indx_delete_entry(&old_dir_ni->dir, old_dir_ni, old_de + 1,
> +	 *			old_de->key_size, NULL);
> +	 */
> +out3:
> +out2:
> +	ni_unlock(old_ni);
> +	ni_unlock(old_dir_ni);
> +out1:
> +	__putname(old_de);
> +out:
> +	return err;
> +}

[...]
