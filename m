Return-Path: <linux-fsdevel+bounces-252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFF47C831B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 12:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59E1B282D01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 10:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DA5125AF;
	Fri, 13 Oct 2023 10:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GzPUTXkK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KRkE/GJn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9465C134AD;
	Fri, 13 Oct 2023 10:32:13 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DB5B7;
	Fri, 13 Oct 2023 03:32:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CB4991F37E;
	Fri, 13 Oct 2023 10:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697193128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=66B4eH+VSglevS0FFJUbqlfaivXzDyXujiWgnWbKsn0=;
	b=GzPUTXkKn6AZFQGjDKin2eF0ALSipmF8QhOq+wKShSHdUM4pyXff0HoSjkzHgl0ILNFnrt
	0ylBSy+c5OBebJmS00aKBcPckR149JRtqf9c9TX9zNeQyq4jsUE/T28W8luwYtTibxbeoT
	EYRQYFZNGWnmOg5BXIVewxMraQ3BLSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697193128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=66B4eH+VSglevS0FFJUbqlfaivXzDyXujiWgnWbKsn0=;
	b=KRkE/GJnaQzE12WFx22/2vpu1a25IfI/GaPJQa5Awjb4ic5Jm4rBt153Td8maYEyerLFyK
	ohh3fn+NvA+bPYAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA3B7138EF;
	Fri, 13 Oct 2023 10:32:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id cRFxLagcKWU2NAAAMHmgww
	(envelope-from <jack@suse.cz>); Fri, 13 Oct 2023 10:32:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 54305A05C4; Fri, 13 Oct 2023 12:32:08 +0200 (CEST)
Date: Fri, 13 Oct 2023 12:32:08 +0200
From: Jan Kara <jack@suse.cz>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>, Andy Lutomirski <luto@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH v4 2/3] mm: update memfd seal write check to include
 F_SEAL_WRITE
Message-ID: <20231013103208.kdffpyerufr4ygnw@quack3>
References: <cover.1697116581.git.lstoakes@gmail.com>
 <913628168ce6cce77df7d13a63970bae06a526e0.1697116581.git.lstoakes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <913628168ce6cce77df7d13a63970bae06a526e0.1697116581.git.lstoakes@gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -10.60
X-Spamd-Result: default: False [-10.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu 12-10-23 18:04:29, Lorenzo Stoakes wrote:
> The seal_check_future_write() function is called by shmem_mmap() or
> hugetlbfs_file_mmap() to disallow any future writable mappings of an memfd
> sealed this way.
> 
> The F_SEAL_WRITE flag is not checked here, as that is handled via the
> mapping->i_mmap_writable mechanism and so any attempt at a mapping would
> fail before this could be run.
> 
> However we intend to change this, meaning this check can be performed for
> F_SEAL_WRITE mappings also.
> 
> The logic here is equally applicable to both flags, so update this function
> to accommodate both and rename it accordingly.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

For some reason only this one patch landed in my inbox but I've checked all
three on lore and they look good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

to all of them. Thanks!

								Honza

> ---
>  fs/hugetlbfs/inode.c |  2 +-
>  include/linux/mm.h   | 15 ++++++++-------
>  mm/shmem.c           |  2 +-
>  3 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 06693bb1153d..5c333373dcc9 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -112,7 +112,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>  	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
>  	vma->vm_ops = &hugetlb_vm_ops;
>  
> -	ret = seal_check_future_write(info->seals, vma);
> +	ret = seal_check_write(info->seals, vma);
>  	if (ret)
>  		return ret;
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index bae234d18d81..26d7dc3b342b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4078,25 +4078,26 @@ static inline void mem_dump_obj(void *object) {}
>  #endif
>  
>  /**
> - * seal_check_future_write - Check for F_SEAL_FUTURE_WRITE flag and handle it
> + * seal_check_write - Check for F_SEAL_WRITE or F_SEAL_FUTURE_WRITE flags and
> + *                    handle them.
>   * @seals: the seals to check
>   * @vma: the vma to operate on
>   *
> - * Check whether F_SEAL_FUTURE_WRITE is set; if so, do proper check/handling on
> - * the vma flags.  Return 0 if check pass, or <0 for errors.
> + * Check whether F_SEAL_WRITE or F_SEAL_FUTURE_WRITE are set; if so, do proper
> + * check/handling on the vma flags.  Return 0 if check pass, or <0 for errors.
>   */
> -static inline int seal_check_future_write(int seals, struct vm_area_struct *vma)
> +static inline int seal_check_write(int seals, struct vm_area_struct *vma)
>  {
> -	if (seals & F_SEAL_FUTURE_WRITE) {
> +	if (seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
>  		/*
>  		 * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
> -		 * "future write" seal active.
> +		 * write seals are active.
>  		 */
>  		if ((vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_WRITE))
>  			return -EPERM;
>  
>  		/*
> -		 * Since an F_SEAL_FUTURE_WRITE sealed memfd can be mapped as
> +		 * Since an F_SEAL_[FUTURE_]WRITE sealed memfd can be mapped as
>  		 * MAP_SHARED and read-only, take care to not allow mprotect to
>  		 * revert protections on such mappings. Do this only for shared
>  		 * mappings. For private mappings, don't need to mask
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 6503910b0f54..cab053831fea 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2405,7 +2405,7 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	int ret;
>  
> -	ret = seal_check_future_write(info->seals, vma);
> +	ret = seal_check_write(info->seals, vma);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.42.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

