Return-Path: <linux-fsdevel+bounces-59765-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A620CB3DF00
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03DD189D89C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 09:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B40B30C602;
	Mon,  1 Sep 2025 09:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cfSDfpQ7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vUoxLK2L";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cfSDfpQ7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vUoxLK2L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557E723E23C
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720206; cv=none; b=Kt4rcauWPouWPYmfKQi1/cBUzwuGMvyu++GDd+i3j8jg0GBvYlLhsYwi476eiTngDZwOIoXzAomCf6K2mX4aGil+k/d72z4oL41AlQVM3DERRry2cU43Bb2/ZhyDZhQwkVYxDtijpydsvnIKWaRl+8Rhbp1YYKpa5dRBuNe1Esw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720206; c=relaxed/simple;
	bh=dHDbZP2sj7jCTQ5hinMjTOyAGhAfa6rnpImzdZhe0vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eh5pIEa5rlEIpp9c98pJd0l4OhI1z3W4aEtGMn5rkB0QKYyVQbtL9b8SHc/NZn4ybZUWmg/TGAPInNb53Y11sdiMMMhhfhSE5ube7xKuQN1hW2xlsfXu+obwcoADQ+oiLSUmVK8SPnVkAOpjozDuSWsq+O1wEcXzu0QK8qJA7+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cfSDfpQ7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vUoxLK2L; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cfSDfpQ7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vUoxLK2L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CAEA1F387;
	Mon,  1 Sep 2025 09:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756720203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4BhaViFTj1EfSgmyJ/x96zZidf5Hn91zet8lsrdFyjw=;
	b=cfSDfpQ7TLUiY8tDXwJBXvERQa0VEFnDoEofkWiyMxjFrPlOsdrOjtmaELo9CgtIvU+jyV
	XKEXF4FodgER/szlrn1etZiIXeaiaCIdNHwPilyQ0Kb1zOKO2UW4yGetWrk416P/1QMU9K
	owlq5Sbxhow+/ZnEA62XaUsx4aGqqwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756720203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4BhaViFTj1EfSgmyJ/x96zZidf5Hn91zet8lsrdFyjw=;
	b=vUoxLK2Labk2pqA1Dmr4gfh9TPcUuuWZ0mJeLLdzOAhCcS7cVBcmBEmZVR7p3G935JaQd3
	/yr/8llbeqdBtWAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cfSDfpQ7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vUoxLK2L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756720203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4BhaViFTj1EfSgmyJ/x96zZidf5Hn91zet8lsrdFyjw=;
	b=cfSDfpQ7TLUiY8tDXwJBXvERQa0VEFnDoEofkWiyMxjFrPlOsdrOjtmaELo9CgtIvU+jyV
	XKEXF4FodgER/szlrn1etZiIXeaiaCIdNHwPilyQ0Kb1zOKO2UW4yGetWrk416P/1QMU9K
	owlq5Sbxhow+/ZnEA62XaUsx4aGqqwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756720203;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4BhaViFTj1EfSgmyJ/x96zZidf5Hn91zet8lsrdFyjw=;
	b=vUoxLK2Labk2pqA1Dmr4gfh9TPcUuuWZ0mJeLLdzOAhCcS7cVBcmBEmZVR7p3G935JaQd3
	/yr/8llbeqdBtWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51AE9136ED;
	Mon,  1 Sep 2025 09:50:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vTRrE0tstWhPdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Sep 2025 09:50:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E5F81A099B; Mon,  1 Sep 2025 11:50:02 +0200 (CEST)
Date: Mon, 1 Sep 2025 11:50:02 +0200
From: Jan Kara <jack@suse.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: remove vfs_ioctl export
Message-ID: <rqvb73ltssgkchzyhzblffovfsfbildkkgbo7nhtvgt5np5eo6@f27eomyazdup>
References: <2025083038-carving-amuck-a4ae@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025083038-carving-amuck-a4ae@gregkh>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6CAEA1F387
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Sat 30-08-25 12:55:39, Greg Kroah-Hartman wrote:
> vfs_ioctl() is no longer called by anything outside of fs/ioctl.c, so
> remove the global symbol and export as it is not needed.
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Indeed. Thanks for the cleanup. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  fs/ioctl.c         | 3 +--
>  include/linux/fs.h | 2 --
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 0248cb8db2d3..3ee1aaa46947 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -41,7 +41,7 @@
>   *
>   * Returns 0 on success, -errno on error.
>   */
> -int vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> +static int vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	int error = -ENOTTY;
>  
> @@ -54,7 +54,6 @@ int vfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   out:
>  	return error;
>  }
> -EXPORT_SYMBOL(vfs_ioctl);
>  
>  static int ioctl_fibmap(struct file *filp, int __user *p)
>  {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d7ab4f96d705..ccf482803525 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2052,8 +2052,6 @@ int vfs_fchown(struct file *file, uid_t user, gid_t group);
>  int vfs_fchmod(struct file *file, umode_t mode);
>  int vfs_utimes(const struct path *path, struct timespec64 *times);
>  
> -int vfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
> -
>  #ifdef CONFIG_COMPAT
>  extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
>  					unsigned long arg);
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

