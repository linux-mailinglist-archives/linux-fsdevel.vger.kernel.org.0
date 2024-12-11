Return-Path: <linux-fsdevel+bounces-37051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9D29ECAF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 12:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897BD285523
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 11:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8894C204F86;
	Wed, 11 Dec 2024 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/AIR7OD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E6F239BBE;
	Wed, 11 Dec 2024 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733915977; cv=none; b=U1+d/rLNRgslifnUVL4Zowdwe1NqFpIPW/WzolN8o2HXfUYbpCY5IOM5xfYDYQ6N0j1dbV5Vf/aNDCB063/BqN7HMUHKD9TGSXlrdvYXT2fisILm3LIp424NLqBt0GDabIKSwjbOw8yQBnBGmqzNgLFKbOVZQqqU65hlI7L3HKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733915977; c=relaxed/simple;
	bh=EVb57XMlb/Lgk1t3Q0klEV1VUb7ld/Y5xaHnDAGpgcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHK43QXKVt7EyRV9kZmEHUy9Bc+cfAwefcdiz6UqNP9snlYuFhJ6LYKSR34sFr3xGAHGweJdNFwmORVIlp6k4556icFa+jdMm7UBIfObF3Z1d36U/KAdRjR2xGg15qCDV8wjWnWc1SwTzPk80X4S3t9LDzVLEBR0WFYtUf+IpKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/AIR7OD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B2DC4CED2;
	Wed, 11 Dec 2024 11:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733915976;
	bh=EVb57XMlb/Lgk1t3Q0klEV1VUb7ld/Y5xaHnDAGpgcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g/AIR7ODR+UsV7bk/Ej+MYMnZhZhGB1zNexy0qNcqB1CisbrZcVmDax6LRs4gXqhE
	 IN/ezE0jKcwFNJrtMw8WJu5kYMkRuwuOqisYTfZz5ZPUSRwgdC9bg0CWHbsuxBSod2
	 VK5XbTLyzKqbPE9FYyltISD1iQsxzhckkDOT0eAMjKHtQ7QxAhNG3Yu4avQw/0Onpm
	 F1BNUQczyjKDDazqlv6TGtLGAbGUn8Csz3e/0pgcDJpNxgmM2j1ykvn7DEMI4DhNKm
	 7WR3N/pH2FXpEg+8G7FM+OvmK/eNPOZUZBS8SO6j+KxwG5inwbAoAUgwRGR7E1MoJp
	 EOFQUBlN4qYfg==
Date: Wed, 11 Dec 2024 12:19:32 +0100
From: Christian Brauner <brauner@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 4/6] efivarfs: move freeing of variable entry into
 evict_inode
Message-ID: <20241211-mitmensch-worte-fda3fe1d7760@brauner>
References: <20241210170224.19159-1-James.Bottomley@HansenPartnership.com>
 <20241210170224.19159-5-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241210170224.19159-5-James.Bottomley@HansenPartnership.com>

On Tue, Dec 10, 2024 at 12:02:22PM -0500, James Bottomley wrote:
> Make the inodes the default management vehicle for struct
> efivar_entry, so they are now all freed automatically if the file is
> removed and on unmount in kill_litter_super().  Remove the now
> superfluous iterator to free the entries after kill_litter_super().
> 
> Also fixes a bug where some entry freeing was missing causing efivarfs
> to leak memory.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---

This looks like a good idea to me.

>  fs/efivarfs/internal.h |  1 -
>  fs/efivarfs/super.c    | 15 +++++++--------
>  fs/efivarfs/vars.c     | 39 +++------------------------------------
>  3 files changed, 10 insertions(+), 45 deletions(-)
> 
> diff --git a/fs/efivarfs/internal.h b/fs/efivarfs/internal.h
> index 84a36e6fb653..d768bfa7f12b 100644
> --- a/fs/efivarfs/internal.h
> +++ b/fs/efivarfs/internal.h
> @@ -37,7 +37,6 @@ int efivar_init(int (*func)(efi_char16_t *, efi_guid_t, unsigned long, void *,
>  
>  int efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
>  void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head);
> -void efivar_entry_remove(struct efivar_entry *entry);
>  int efivar_entry_delete(struct efivar_entry *entry);
>  
>  int efivar_entry_size(struct efivar_entry *entry, unsigned long *size);
> diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> index dc3870ae784b..70b99f58c906 100644
> --- a/fs/efivarfs/super.c
> +++ b/fs/efivarfs/super.c
> @@ -41,6 +41,12 @@ static int efivarfs_ops_notifier(struct notifier_block *nb, unsigned long event,
>  
>  static void efivarfs_evict_inode(struct inode *inode)
>  {
> +	struct efivar_entry *entry = inode->i_private;
> +
> +	if (entry)  {
> +		list_del(&entry->list);
> +		kfree(entry);
> +	}
>  	clear_inode(inode);
>  }
>  
> @@ -269,13 +275,6 @@ static int efivarfs_callback(efi_char16_t *name16, efi_guid_t vendor,
>  	return err;
>  }
>  
> -static int efivarfs_destroy(struct efivar_entry *entry, void *data)
> -{
> -	efivar_entry_remove(entry);
> -	kfree(entry);
> -	return 0;
> -}
> -
>  enum {
>  	Opt_uid, Opt_gid,
>  };
> @@ -398,7 +397,7 @@ static void efivarfs_kill_sb(struct super_block *sb)
>  	kill_litter_super(sb);
>  
>  	/* Remove all entries and destroy */
> -	efivar_entry_iter(efivarfs_destroy, &sfi->efivarfs_list, NULL);
> +	WARN_ON(!list_empty(&sfi->efivarfs_list));
>  	kfree(sfi);
>  }
>  
> diff --git a/fs/efivarfs/vars.c b/fs/efivarfs/vars.c
> index f6380fdbe173..bda8e8b869e8 100644
> --- a/fs/efivarfs/vars.c
> +++ b/fs/efivarfs/vars.c
> @@ -485,34 +485,6 @@ void __efivar_entry_add(struct efivar_entry *entry, struct list_head *head)
>  	list_add(&entry->list, head);
>  }
>  
> -/**
> - * efivar_entry_remove - remove entry from variable list
> - * @entry: entry to remove from list
> - *
> - * Returns 0 on success, or a kernel error code on failure.
> - */
> -void efivar_entry_remove(struct efivar_entry *entry)
> -{
> -	list_del(&entry->list);
> -}
> -
> -/*
> - * efivar_entry_list_del_unlock - remove entry from variable list
> - * @entry: entry to remove
> - *
> - * Remove @entry from the variable list and release the list lock.
> - *
> - * NOTE: slightly weird locking semantics here - we expect to be
> - * called with the efivars lock already held, and we release it before
> - * returning. This is because this function is usually called after
> - * set_variable() while the lock is still held.
> - */
> -static void efivar_entry_list_del_unlock(struct efivar_entry *entry)
> -{
> -	list_del(&entry->list);
> -	efivar_unlock();
> -}
> -
>  /**
>   * efivar_entry_delete - delete variable and remove entry from list
>   * @entry: entry containing variable to delete
> @@ -536,12 +508,10 @@ int efivar_entry_delete(struct efivar_entry *entry)
>  	status = efivar_set_variable_locked(entry->var.VariableName,
>  					    &entry->var.VendorGuid,
>  					    0, 0, NULL, false);
> -	if (!(status == EFI_SUCCESS || status == EFI_NOT_FOUND)) {
> -		efivar_unlock();
> +	efivar_unlock();
> +	if (!(status == EFI_SUCCESS || status == EFI_NOT_FOUND))
>  		return efi_status_to_err(status);
> -	}
>  
> -	efivar_entry_list_del_unlock(entry);
>  	return 0;
>  }
>  
> @@ -679,10 +649,7 @@ int efivar_entry_set_get_size(struct efivar_entry *entry, u32 attributes,
>  				    &entry->var.VendorGuid,
>  				    NULL, size, NULL);
>  
> -	if (status == EFI_NOT_FOUND)
> -		efivar_entry_list_del_unlock(entry);
> -	else
> -		efivar_unlock();
> +	efivar_unlock();
>  
>  	if (status && status != EFI_BUFFER_TOO_SMALL)
>  		return efi_status_to_err(status);
> -- 
> 2.35.3
> 

