Return-Path: <linux-fsdevel+bounces-54179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DE5AFBCD2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 22:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C098016ED8A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCC421FF53;
	Mon,  7 Jul 2025 20:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sLWivd0q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mpRK+4mE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sLWivd0q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mpRK+4mE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7401F3BB5
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 20:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751921493; cv=none; b=czTDFZPvpukHxDgZDkaRg6lj9jx0h+XV0/9+YhhM1ioNS2yAQgOh13ppkCb7y1AsoMYRi4jCBngwMES1EaK5nGnW+owa99O1PbKhjuLdqFjLCxVpzooChBTO07H7M0GSRztqB4LZbT2MCODaQyIItLjXqlpUZMO931iK6zzTtos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751921493; c=relaxed/simple;
	bh=1yUz1IZbwCWSLVw8uE+AkQXLbxkCX0n8DamyeD87+Yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+EO6zAYgumAfiPssZ5917mIKtabbFZQjas44hYVmdCMpo1m6bA0EUUC4lIWhWQAti4amisEsAjW0+v8EuKJEtF72G0mbqfrcmY7s3dCcey5pVbfLTIuS+fq13LvC+fKGaKgg6E/Blwer/eTS2FFKcEt0CS5nYvlFezrkqGfCGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sLWivd0q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mpRK+4mE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sLWivd0q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mpRK+4mE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9E28E1F390;
	Mon,  7 Jul 2025 20:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751921490;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcipaQzwdaPp/YWmiL2/ORmkl7+h0mq8D8PPxQ9zMi8=;
	b=sLWivd0qvmSmoeG/jp52UKr40rUglTLzkL4ZuT4e5SlV2in/UiW9Z9EjotHbeSbKz5pfXM
	Z2nmeXjH3C7WBjSGfxRf9Nxk/RZX0zBwf977kD3gxceOyP2IYIwX2ezFcQKijDPYluGSVw
	reSpkYdFTpEy1o1tiPyFfLvP0Q/sATs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751921490;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcipaQzwdaPp/YWmiL2/ORmkl7+h0mq8D8PPxQ9zMi8=;
	b=mpRK+4mEtto+eImBbboqSLA8VkrmSMk2vCVK8Yy8UhLFLBHNGsDtANKNdg1GLne5LR9bDU
	z+oxiyxBibYY8uDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751921490;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcipaQzwdaPp/YWmiL2/ORmkl7+h0mq8D8PPxQ9zMi8=;
	b=sLWivd0qvmSmoeG/jp52UKr40rUglTLzkL4ZuT4e5SlV2in/UiW9Z9EjotHbeSbKz5pfXM
	Z2nmeXjH3C7WBjSGfxRf9Nxk/RZX0zBwf977kD3gxceOyP2IYIwX2ezFcQKijDPYluGSVw
	reSpkYdFTpEy1o1tiPyFfLvP0Q/sATs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751921490;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AcipaQzwdaPp/YWmiL2/ORmkl7+h0mq8D8PPxQ9zMi8=;
	b=mpRK+4mEtto+eImBbboqSLA8VkrmSMk2vCVK8Yy8UhLFLBHNGsDtANKNdg1GLne5LR9bDU
	z+oxiyxBibYY8uDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8549813757;
	Mon,  7 Jul 2025 20:51:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DiBQIFIzbGiLIAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 07 Jul 2025 20:51:30 +0000
Date: Mon, 7 Jul 2025 22:51:25 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH v4 5/6] btrfs: implement shutdown ioctl
Message-ID: <20250707205125.GI4453@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1751589725.git.wqu@suse.com>
 <5ff44de2d9d7f8c2e59fa3a5fe68d5bb4c71a111.1751589725.git.wqu@suse.com>
 <20250705142230.GC4453@twin.jikos.cz>
 <6642f8b5-d357-4fb6-a295-906178a633f9@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6642f8b5-d357-4fb6-a295-906178a633f9@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Sun, Jul 06, 2025 at 01:07:19PM +0930, Qu Wenruo wrote:
> 在 2025/7/5 23:52, David Sterba 写道:
> >> +static int btrfs_emergency_shutdown(struct btrfs_fs_info *fs_info, u32 flags)
> >> +{
> >> +	int ret = 0;
> >> +
> >> +	if (flags >= BTRFS_SHUTDOWN_FLAGS_LAST)
> >> +		return -EINVAL;
> >> +
> >> +	if (btrfs_is_shutdown(fs_info))
> >> +		return 0;
> >> +
> >> +	switch (flags) {
> >> +	case BTRFS_SHUTDOWN_FLAGS_LOGFLUSH:
> >> +	case BTRFS_SHUTDOWN_FLAGS_DEFAULT:
> >> +		ret = freeze_super(fs_info->sb, FREEZE_HOLDER_KERNEL, NULL);
> > 
> > Recently I've looked at scrub blocking filesystem freezing and it does
> > not work because it blocks on the semaphore taken in mnt_want_write,
> > also taken in freeze_super().
> > 
> > I have an idea for fix, basically pause scrub, undo mnt_want_write
> > and then call freeze_super. So we'll need that too for shutdown. Once
> > implemented the fixup would be to use btrfs_freeze_super callback here.
> 
> It may not be that simple.
> 
> freeze_super() itself is doing extra works related to the 
> stage/freeze_owner/etc.
> 
> I'm not sure if it's a good idea to completely skip that part.
> 
> I'd prefer scrub to check the frozen stage, and if it's already in any 
> FREEZE stages, exit early.

I have working prototype for pausing scrub that does not need to exit,
so far I've tested it with fsfreeze in a VM, I still need to test actual
freezing for suspend purposes.

