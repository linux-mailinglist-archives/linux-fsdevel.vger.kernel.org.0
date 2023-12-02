Return-Path: <linux-fsdevel+bounces-4700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A36801F10
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 23:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B720B20AAC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 22:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F66D224C9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Q66e2ozh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB64107;
	Sat,  2 Dec 2023 14:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NjbNFGRIsxm13NIq7QOlU0+7el0vqRk7wXDZtiulYNM=; b=Q66e2ozhslYFy6IZJBTKhUwLJD
	tUSedC7mVh5eeVXeJAW6cZJ3vDKnxWvy4q3BAanpfHjn8wGd2PlIuBQuYYB2WuffAqVmM81q8Bs4P
	QkNm9qT+mX8OzUw05W8kcWAOdjd23IDKPgXHC9y/Umuln0Z1DHUTR4cfjrlbRQc6dMEyU6DPTyp2O
	+V0yKhIDBxMfYGKOflC47npu6f4e7VRU0sGsjL+oWvImoAdz4hBbc0rVl+Ezb6eSftIPTPEsGNZF+
	hbsz2exqEUt2pgsT+p/eLnlIT0ROABgloY7FuIQQdiFW2riTh7hWpAIf0jpk4BdMepKByyb5Ajjkt
	NTE5TF1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r9YS2-006OsI-1h;
	Sat, 02 Dec 2023 22:27:06 +0000
Date: Sat, 2 Dec 2023 22:27:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Kees Cook <keescook@chromium.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Tony Luck <tony.luck@intel.com>, linux-hardening@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/5] pstore: inode: Use cleanup.h for struct
 pstore_private
Message-ID: <20231202222706.GT38156@ZenIV>
References: <20231202211535.work.571-kees@kernel.org>
 <20231202212217.243710-5-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202212217.243710-5-keescook@chromium.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Dec 02, 2023 at 01:22:15PM -0800, Kees Cook wrote:

>  static void *pstore_ftrace_seq_start(struct seq_file *s, loff_t *pos)
>  {
> @@ -338,9 +339,8 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>  {
>  	struct dentry		*dentry;
>  	struct inode		*inode __free(iput) = NULL;
> -	int			rc = 0;
>  	char			name[PSTORE_NAMELEN];
> -	struct pstore_private	*private, *pos;
> +	struct pstore_private	*private __free(pstore_private) = NULL, *pos;
>  	size_t			size = record->size + record->ecc_notice_size;
>  
>  	if (WARN_ON(!inode_is_locked(d_inode(root))))
> @@ -356,7 +356,6 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>  			return -EEXIST;
>  	}
>  
> -	rc = -ENOMEM;
>  	inode = pstore_get_inode(root->d_sb);
>  	if (!inode)
>  		return -ENOMEM;
> @@ -373,7 +372,7 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>  
>  	dentry = d_alloc_name(root, name);
>  	if (!dentry)
> -		goto fail_private;
> +		return -ENOMEM;
>  
>  	private->dentry = dentry;
>  	private->record = record;
> @@ -386,13 +385,9 @@ int pstore_mkfile(struct dentry *root, struct pstore_record *record)
>  
>  	d_add(dentry, no_free_ptr(inode));
>  
> -	list_add(&private->list, &records_list);
> +	list_add(&(no_free_ptr(private))->list, &records_list);

That's really brittle.  It critically depends upon having no failure
exits past the assignment to ->i_private; once you've done that,
you have transferred the ownership of that thing to the inode
(look at your ->evict_inode()).  But you can't say
        inode->i_private = no_free_ptr(private);
since you are using private past that point.

