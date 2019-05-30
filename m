Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7826C303B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2019 23:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfE3VCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 17:02:03 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49436 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbfE3VCC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 17:02:02 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-109.corp.google.com [104.133.0.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4UL1uQF009574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 17:01:57 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7865B420481; Thu, 30 May 2019 17:01:56 -0400 (EDT)
Date:   Thu, 30 May 2019 17:01:56 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.orglinux-fscrypt
Subject: Re: [PATCH] ext4: Optimize case-insensitive lookups
Message-ID: <20190530210156.GI2998@mit.edu>
References: <20190529185446.22757-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529185446.22757-1-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 29, 2019 at 02:54:46PM -0400, Gabriel Krisman Bertazi wrote:
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index c18ab748d20d..e3809cfda9f4 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2078,6 +2078,10 @@ struct ext4_filename {
>  #ifdef CONFIG_FS_ENCRYPTION
>  	struct fscrypt_str crypto_buf;
>  #endif
> +#ifdef CONFIG_UNICODE
> +	int cf_len;
> +	unsigned char cf_name[EXT4_NAME_LEN];
> +#endif
>  };
>  
>  #define fname_name(p) ((p)->disk_name.name)

EXT4_NAME_LEN is 256, and struct ext4_filename is allocated on the
stack.  So this is going to increase the stack usage by 258 bytes.
Perhaps should we just kmalloc the temporary buffer when it's needed?

The other thing that this patch reminds me is that there is great
interest in supporting case folded directories and fscrypt at the same
time.  Today fscrypt works by encrypting the filename, and stashes it
in fname->crypto_buf, and this allows for a byte-for-byte comparison
of the encrypted name.  To support fscrypt && casefold, what we would
need to do is to change the htree hash so that the hash is caluclated
on the normalized form, and then we'll have to decrypt each filename
in the directory block and then compare it against the normalized form
that stashed in cf_name.  So that means we'll never need to allocate
memory for cf_name and crypto_buf at the same time.

We can also use struct fscrypt_str for cf_name; it's defined as a
combined unsighed char *name and u32 len.  We already use fscrypt_str
even the !CONFIG_FS_ENCRYPTION case, since it's a convenient way of
handling a non-NULL terminated filename blob.  And this will hopefully
make it simpler to deal with integrating casefolding and fscrypt in
the future.

Cheers,

					- Ted
