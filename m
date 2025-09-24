Return-Path: <linux-fsdevel+bounces-62612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A600B9AEE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 18:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D9D174402
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 16:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68195314A9E;
	Wed, 24 Sep 2025 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=infradead.org header.i=@infradead.org header.b="ADQuNtgD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB461A254E;
	Wed, 24 Sep 2025 16:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733008; cv=none; b=aSUiDncyEy3DBZM4Dl1zw6CDu7VGSJMNa+FaJJ22hF6pr+ecbvVYfstXibadMP1MHqnTXtSQn4Vh//7+rgaDBquAmp8mKZcAh9o0mf0kIFCaze9CCIKQTqvW83s7OW/kPWiuy7t9QX205FoCECtAgTjucejHoNdog82HFA7WT0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733008; c=relaxed/simple;
	bh=MTtS4DGnmn/dmi9j0JsSf5aBSRH5Nl/ESP4A4KaeUNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwpLaExYknqTk+1UFwzEDKuh8h8WnJ2mGBTY4UttE3+zjdPvA2kEFqSH2ZxfoTSEMd4QVVrAEMidhtGj5UsUvLEboAeR6cfCdvkTpWRopf38pEmHTsSxOskxiKbdr/vedUOtiWjHDo39r9+NFuZfhTRbIOyp7YmNHhCAo/+o2rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=fail (0-bit key) header.d=infradead.org header.i=@infradead.org header.b=ADQuNtgD reason="key not found in DNS"; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wItarYwJVipfmi89AjibX164xiYQ1sw1xgqIMHATn9c=; b=ADQuNtgDqCh42nShQdrRdwoDNL
	naHjDqhRxe/feBE3gx7YI+GF3SiATwjEKGTxF5HTe/Rd8zeJIPmiziHcLoJCArwg1LMjkST8yjMX2
	ICMQXn/VCEHj9XYcI5uyQ+z2vU1vDXRjgolv9kx1bsRE24R9kbKPxdEuZwyofsQb1h+8kmqDxmSvE
	RFGVyb/ITBh0FNHHuxEIh9mQxZOJejY+vTU5rnl3xDxkQaIqjkZC/dq692Uo/WRCE5uDVByN675eh
	qEjeBUgMKKK9qemuFENVjEtRnyWVd9FbPVfb+wYmBC8z4RcHVsS9yZrtq+r6BEE1D0owQ3AOE/asm
	tCqspHew==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1SnC-00000008hCv-35Ks;
	Wed, 24 Sep 2025 16:56:34 +0000
Date: Wed, 24 Sep 2025 09:56:30 -0700
From: Joel Becker <jlbec@evilplan.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, paul@paul-moore.com,
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org,
	borntraeger@linux.ibm.com
Subject: Re: [PATCH 08/39] configfs, securityfs: kill_litter_super() not
 needed
Message-ID: <aNQivg5O_Rx3WxlG@google.com>
Mail-Followup-To: Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, a.hindborg@kernel.org, linux-mm@kvack.org,
	linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org, paul@paul-moore.com,
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org,
	borntraeger@linux.ibm.com
References: <20250920074156.GK39973@ZenIV>
 <20250920074759.3564072-1-viro@zeniv.linux.org.uk>
 <20250920074759.3564072-8-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920074759.3564072-8-viro@zeniv.linux.org.uk>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>

Reviewed-by: Joel Becker <jlbec@evilplan.org>

On Sat, Sep 20, 2025 at 08:47:27AM +0100, Al Viro wrote:
> These are guaranteed to be empty by the time they are shut down;
> both are single-instance and there is an internal mount maintained
> for as long as there is any contents.
> 
> Both have that internal mount pinned by every object in root.
> 
> In other words, kill_litter_super() boils down to kill_anon_super()
> for those.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/configfs/mount.c | 2 +-
>  security/inode.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/configfs/mount.c b/fs/configfs/mount.c
> index 740f18b60c9d..fa66e25f0d75 100644
> --- a/fs/configfs/mount.c
> +++ b/fs/configfs/mount.c
> @@ -116,7 +116,7 @@ static struct file_system_type configfs_fs_type = {
>  	.owner		= THIS_MODULE,
>  	.name		= "configfs",
>  	.init_fs_context = configfs_init_fs_context,
> -	.kill_sb	= kill_litter_super,
> +	.kill_sb	= kill_anon_super,
>  };
>  MODULE_ALIAS_FS("configfs");
>  
> diff --git a/security/inode.c b/security/inode.c
> index 43382ef8896e..bf7b5e2e6955 100644
> --- a/security/inode.c
> +++ b/security/inode.c
> @@ -70,7 +70,7 @@ static struct file_system_type fs_type = {
>  	.owner =	THIS_MODULE,
>  	.name =		"securityfs",
>  	.init_fs_context = securityfs_init_fs_context,
> -	.kill_sb =	kill_litter_super,
> +	.kill_sb =	kill_anon_super,
>  };
>  
>  /**
> -- 
> 2.47.3
> 
> 

-- 

The Graham Corollary:

	The longer a socially-moderated news website exists, the
	probability of an old Paul Graham link appearing at the top
	approaches certainty.

			http://www.jlbec.org/
			jlbec@evilplan.org

