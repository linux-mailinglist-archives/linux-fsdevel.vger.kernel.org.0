Return-Path: <linux-fsdevel+bounces-13751-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C23873622
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 13:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69F891C2110B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89BB280044;
	Wed,  6 Mar 2024 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yFNVuJME";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jGyB478T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yFNVuJME";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jGyB478T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261041426B
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 12:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709727239; cv=none; b=C3TX+8GZVOrnbypFehDv/mO0fLe89E1PtF2AdP84NCgPsGHV5keN1ZxirFyz2xW3/PU6YDlf2GDez4g0toOIbS+Mumeqc96B+GVieRuIvH0eDy5h6VH6seGwTi43PSMywcMLT2b9pOw4U0/8NBCEU7bvM1Jznoc4Bn4pZXBbyVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709727239; c=relaxed/simple;
	bh=ZZIz2OPAsW8STiRAtthW6SngcHHVe4pIc9dNMXGN/Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tpk2xZlLOpCyrl7DgmWM8DLUkQhT/W7BAxXjDlBq9O5E9NlMH15geEspnwN4el+UdE2SuW0QhjMYEOkZFmNN0z04zldwy4VvGVGzF4QIhl+E6o6KH94JTLD6MauwttOKxDAmIbUorAFkuLZ2OPXvziJ56YgvKHcRfDw3FEz1RY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yFNVuJME; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jGyB478T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yFNVuJME; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jGyB478T; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E21F759F5;
	Wed,  6 Mar 2024 12:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709727235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=orjY+FsuMZ7eJ4TL7ZNYSfVbuHf4B4ti7fy8XMjMJ00=;
	b=yFNVuJMELfTe+4sSY9Fny87A7+mvGLzcQ3RnDi5FA01ia5gXxgDKpvNL6RK+uCi0L5JK/J
	KXk4cl7d9QKB5dkODTHKiGmeSGLL21KmcI6gxxAGVXUvVyQ+Bp2uRvLf5YtbE/OyW0K5Yj
	itbqin+JjSVBYDBNYZ8y45ysH8SrA+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709727235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=orjY+FsuMZ7eJ4TL7ZNYSfVbuHf4B4ti7fy8XMjMJ00=;
	b=jGyB478T7jsYE3ys+FmmGtUsG/yi1j1mf7PO4SY7p/Q4rAshbwOjdjJ1hCkFRe5zex9VQP
	lxgkH5HxIoRVRNCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709727235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=orjY+FsuMZ7eJ4TL7ZNYSfVbuHf4B4ti7fy8XMjMJ00=;
	b=yFNVuJMELfTe+4sSY9Fny87A7+mvGLzcQ3RnDi5FA01ia5gXxgDKpvNL6RK+uCi0L5JK/J
	KXk4cl7d9QKB5dkODTHKiGmeSGLL21KmcI6gxxAGVXUvVyQ+Bp2uRvLf5YtbE/OyW0K5Yj
	itbqin+JjSVBYDBNYZ8y45ysH8SrA+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709727235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=orjY+FsuMZ7eJ4TL7ZNYSfVbuHf4B4ti7fy8XMjMJ00=;
	b=jGyB478T7jsYE3ys+FmmGtUsG/yi1j1mf7PO4SY7p/Q4rAshbwOjdjJ1hCkFRe5zex9VQP
	lxgkH5HxIoRVRNCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 43F231377D;
	Wed,  6 Mar 2024 12:13:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id lY2NEANe6GUVSwAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 06 Mar 2024 12:13:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BAFC0A0803; Wed,  6 Mar 2024 13:13:46 +0100 (CET)
Date: Wed, 6 Mar 2024 13:13:46 +0100
From: Jan Kara <jack@suse.cz>
To: Vicki Pfau <vi@endrift.com>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] inotify: Fix misspelling of "writable"
Message-ID: <20240306121346.jgsxvzkwnbeamsux@quack3>
References: <20240306020831.1404033-1-vi@endrift.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306020831.1404033-1-vi@endrift.com>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yFNVuJME;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jGyB478T
X-Spamd-Result: default: False [0.15 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.04)[58.58%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.15
X-Rspamd-Queue-Id: 4E21F759F5
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Tue 05-03-24 18:08:26, Vicki Pfau wrote:
> Several file system notification system headers have "writable" misspelled as
> "writtable" in the comments. This patch fixes it in the inotify header.
> 
> Signed-off-by: Vicki Pfau <vi@endrift.com>

Thanks! I've added these patches to my tree.

								Honza

> ---
>  include/uapi/linux/inotify.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/inotify.h b/include/uapi/linux/inotify.h
> index b3e165853d5b..d94f20e38e5d 100644
> --- a/include/uapi/linux/inotify.h
> +++ b/include/uapi/linux/inotify.h
> @@ -30,8 +30,8 @@ struct inotify_event {
>  #define IN_ACCESS		0x00000001	/* File was accessed */
>  #define IN_MODIFY		0x00000002	/* File was modified */
>  #define IN_ATTRIB		0x00000004	/* Metadata changed */
> -#define IN_CLOSE_WRITE		0x00000008	/* Writtable file was closed */
> -#define IN_CLOSE_NOWRITE	0x00000010	/* Unwrittable file closed */
> +#define IN_CLOSE_WRITE		0x00000008	/* Writable file was closed */
> +#define IN_CLOSE_NOWRITE	0x00000010	/* Unwritable file closed */
>  #define IN_OPEN			0x00000020	/* File was opened */
>  #define IN_MOVED_FROM		0x00000040	/* File was moved from X */
>  #define IN_MOVED_TO		0x00000080	/* File was moved to Y */
> -- 
> 2.44.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

