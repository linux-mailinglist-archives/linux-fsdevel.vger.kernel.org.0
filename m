Return-Path: <linux-fsdevel+bounces-55617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F26B0CB2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 21:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0DE6177951
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 19:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F28A238C29;
	Mon, 21 Jul 2025 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NqqKaLGV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4223770D
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753127502; cv=none; b=rF2bRmvDh6SDRvM7ArpNDANg0BGB5ornUEEjY93Cjx4VzhEfXDFpYnz9Ek6bJe6BjupnCt3/m09OPvkC5+jHPb8sC8btut3JB4r7to8rwSiErDqIUv5JL+2DmY7WWqneyGTXbuNGbRo3tNmPjFtWnM7bUbi+m7sTkb/WZEvFXic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753127502; c=relaxed/simple;
	bh=FSkb//Un9XYOBLbpZuVIKlWqK+ESfLKx8dGomUzDgw8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Dgrwqz3g5FuAHJy4EI4aSE1hz9yMhEo5531iBN3OsmpQ3Lt6tjpcEQEC01kUGe7Gd13NNYvrvkfCpS+8BY2qB9NjRZTpFWFXOQN3rt4XOey0wRJxpVUZf5QFa/fH1/uDzApnQKvfr/ekSIL4usayLC053ETeK5WImBLlSAphijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NqqKaLGV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753127496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bUkM9bKpl7dkgWKCxuTwvfTXC4FOX6e2F+2YtIt3kYI=;
	b=NqqKaLGVc/86eUgLF6gLC/3NCXPJ6x2h6BE1ACX8xUMigN7G2bR+g3N+MfCFAy3xArMRE2
	9PZGO8RBcKws3hEyGdhg/ZLGZ7Jx8WFb3Nq37nq9PfIROzbmNZDbpDninTsJ4Dhj7rWUG5
	PZcK/5zGfcmQzNUgZov2PVCWAtBZ+8o=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-C2Uutw5IPIutBAyRTG451Q-1; Mon,
 21 Jul 2025 15:51:32 -0400
X-MC-Unique: C2Uutw5IPIutBAyRTG451Q-1
X-Mimecast-MFC-AGG-ID: C2Uutw5IPIutBAyRTG451Q_1753127491
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83BC919560AA;
	Mon, 21 Jul 2025 19:51:31 +0000 (UTC)
Received: from [10.22.80.24] (unknown [10.22.80.24])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34D3D19560A3;
	Mon, 21 Jul 2025 19:51:30 +0000 (UTC)
Date: Mon, 21 Jul 2025 21:51:22 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
    syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
Subject: Re: [PATCH] hpfs: add checks for ea addresses
In-Reply-To: <20250720142218.145320-1-apokusinski01@gmail.com>
Message-ID: <784a100e-c848-3a9c-74ef-439fa12df53c@redhat.com>
References: <20250720142218.145320-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi

I've got an email that shows these syslog lines:

hpfs: filesystem error: warning: spare dnodes used, try chkdsk
hpfs: You really don't want any checks? You are crazy...
hpfs: hpfs_map_sector(): read error
hpfs: code page support is disabled
==================================================================
BUG: KASAN: use-after-free in strcmp+0x6f/0xc0 lib/string.c:283
Read of size 1 at addr ffff8880116728a6 by task syz-executor411/6741


It seems that you deliberately turned off checking by using the parameter 
check=none.

The HPFS driver will not check metadata for corruption if "check=none" is 
used, you should use the default "check=normal" or enable extra 
time-consuming checks using "check=strict".

The code that checks extended attributes in the fnode is in the function 
hpfs_map_fnode, the branch "if ((fnode = hpfs_map_sector(s, ino, bhp, 
FNODE_RD_AHEAD))) { if (hpfs_sb(s)->sb_chk) {" - fixes for checking 
extended attributes should go there.

If you get a KASAN warning when using "check=normal" or "check=strict", 
report it and I will fix it; with "check=none" it is not supposed to work.

Mikulas



On Sun, 20 Jul 2025, Antoni Pokusinski wrote:

> The addresses of the extended attributes are computed using the
> fnode_ea() and next_ea() functions which refer to the fields residing in
> a given fnode. There are no sanity checks for the returned values, so in
> the case of corrupted data in the fnode, the ea addresses are invalid.
> 
> Fix the bug by adding ea_valid_addr() function which checks if a given
> extended attribute resides within the range of the ea array of a given
> fnode.
> 
> Reported-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
> Tested-by: syzbot+fa88eb476e42878f2844@syzkaller.appspotmail.com
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> 
> ---
>  fs/hpfs/anode.c   | 2 +-
>  fs/hpfs/ea.c      | 6 +++---
>  fs/hpfs/hpfs_fn.h | 5 +++++
>  fs/hpfs/map.c     | 2 +-
>  4 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/hpfs/anode.c b/fs/hpfs/anode.c
> index c14c9a035ee0..f347cdd94a5c 100644
> --- a/fs/hpfs/anode.c
> +++ b/fs/hpfs/anode.c
> @@ -488,7 +488,7 @@ void hpfs_remove_fnode(struct super_block *s, fnode_secno fno)
>  	if (!fnode_is_dir(fnode)) hpfs_remove_btree(s, &fnode->btree);
>  	else hpfs_remove_dtree(s, le32_to_cpu(fnode->u.external[0].disk_secno));
>  	ea_end = fnode_end_ea(fnode);
> -	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
> +	for (ea = fnode_ea(fnode); ea < ea_end && ea_valid_addr(fnode, ea); ea = next_ea(ea))
>  		if (ea_indirect(ea))
>  			hpfs_ea_remove(s, ea_sec(ea), ea_in_anode(ea), ea_len(ea));
>  	hpfs_ea_ext_remove(s, le32_to_cpu(fnode->ea_secno), fnode_in_anode(fnode), le32_to_cpu(fnode->ea_size_l));
> diff --git a/fs/hpfs/ea.c b/fs/hpfs/ea.c
> index 102ba18e561f..d7ada7f5a7ae 100644
> --- a/fs/hpfs/ea.c
> +++ b/fs/hpfs/ea.c
> @@ -80,7 +80,7 @@ int hpfs_read_ea(struct super_block *s, struct fnode *fnode, char *key,
>  	char ex[4 + 255 + 1 + 8];
>  	struct extended_attribute *ea;
>  	struct extended_attribute *ea_end = fnode_end_ea(fnode);
> -	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
> +	for (ea = fnode_ea(fnode); ea < ea_end  && ea_valid_addr(fnode, ea); ea = next_ea(ea))
>  		if (!strcmp(ea->name, key)) {
>  			if (ea_indirect(ea))
>  				goto indirect;
> @@ -135,7 +135,7 @@ char *hpfs_get_ea(struct super_block *s, struct fnode *fnode, char *key, int *si
>  	secno a;
>  	struct extended_attribute *ea;
>  	struct extended_attribute *ea_end = fnode_end_ea(fnode);
> -	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
> +	for (ea = fnode_ea(fnode); ea < ea_end && ea_valid_addr(fnode, ea); ea = next_ea(ea))
>  		if (!strcmp(ea->name, key)) {
>  			if (ea_indirect(ea))
>  				return get_indirect_ea(s, ea_in_anode(ea), ea_sec(ea), *size = ea_len(ea));
> @@ -198,7 +198,7 @@ void hpfs_set_ea(struct inode *inode, struct fnode *fnode, const char *key,
>  	unsigned char h[4];
>  	struct extended_attribute *ea;
>  	struct extended_attribute *ea_end = fnode_end_ea(fnode);
> -	for (ea = fnode_ea(fnode); ea < ea_end; ea = next_ea(ea))
> +	for (ea = fnode_ea(fnode); ea < ea_end && ea_valid_addr(fnode, ea); ea = next_ea(ea))
>  		if (!strcmp(ea->name, key)) {
>  			if (ea_indirect(ea)) {
>  				if (ea_len(ea) == size)
> diff --git a/fs/hpfs/hpfs_fn.h b/fs/hpfs/hpfs_fn.h
> index 237c1c23e855..c65ce60d7d9a 100644
> --- a/fs/hpfs/hpfs_fn.h
> +++ b/fs/hpfs/hpfs_fn.h
> @@ -152,6 +152,11 @@ static inline struct extended_attribute *next_ea(struct extended_attribute *ea)
>  	return (struct extended_attribute *)((char *)ea + 5 + ea->namelen + ea_valuelen(ea));
>  }
>  
> +static inline bool ea_valid_addr(struct fnode *fnode, struct extended_attribute *ea)
> +{
> +	return ((char *)ea >= (char *)&fnode->ea) && ((char *)ea < (char *)&fnode->ea + sizeof(fnode->ea));
> +}
> +
>  static inline secno ea_sec(struct extended_attribute *ea)
>  {
>  	return le32_to_cpu(get_unaligned((__le32 *)((char *)ea + 9 + ea->namelen)));
> diff --git a/fs/hpfs/map.c b/fs/hpfs/map.c
> index ecd9fccd1663..0016dcbf1b1f 100644
> --- a/fs/hpfs/map.c
> +++ b/fs/hpfs/map.c
> @@ -202,7 +202,7 @@ struct fnode *hpfs_map_fnode(struct super_block *s, ino_t ino, struct buffer_hea
>  			}
>  			ea = fnode_ea(fnode);
>  			ea_end = fnode_end_ea(fnode);
> -			while (ea != ea_end) {
> +			while (ea != ea_end && ea_valid_addr(fnode, ea)) {
>  				if (ea > ea_end) {
>  					hpfs_error(s, "bad EA in fnode %08lx",
>  						(unsigned long)ino);
> -- 
> 2.25.1
> 


