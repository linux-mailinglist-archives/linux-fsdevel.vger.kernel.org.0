Return-Path: <linux-fsdevel+bounces-14170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A63878AEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 23:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61220B20AB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 22:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189595822A;
	Mon, 11 Mar 2024 22:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2JMcx+Xw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F+g1Kpq1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2JMcx+Xw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="F+g1Kpq1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F758119;
	Mon, 11 Mar 2024 22:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197420; cv=none; b=SK3XbKGkStqy9qyjKbxekgWBxFG+ru0MqkyLTtE39NoaUKyI9jgbee24hoSebHVvZpvZ4xGMwlcB0Rd4Pa8+e+En45hPISoR98bIT/eJtYLRk8hApp6pcyuZtdxvKrIwMreAUmSmkOa3+gLuWtrAZTTSkU2Zl09p4iQWwfUyNDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197420; c=relaxed/simple;
	bh=6hEw/tubGvPxhFiRELWYV1/vJLyENcju0/g5UjQ5KqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLy0ZphqNqWOgjp3UGqfpVDUUem3DDNduK5gRlE+v0ryGKAqq+N/H14VPP5vLRaEvkBMd7SF8N1Fv43uHcAw/9ADMFIbgweCc3uig+i54/qMPYsWSlfBlmSJ2njjmOz6tjhGRkSyDMOpF/2tTqOg17Mmh2iVsEpSOxysY9GLUQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2JMcx+Xw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F+g1Kpq1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2JMcx+Xw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=F+g1Kpq1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 88B38351BF;
	Mon, 11 Mar 2024 22:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710197409;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZxUzTMlXn3tjcFXFnIZtmdtt4eI79Utif3t7gSNN5zI=;
	b=2JMcx+XwlcbtzsHasDWy6ZqzZxXsO3ioT+8RzDCQ0YvK0mSr6RGEEmrDkprLn9iu/wrFlb
	2nBv61lu5TWoLC+nmdgCMjeN3iwiOxMPT1xggX7YslQnNgaZkdTVnamLCxVzptOzNdUH+k
	gdB/u14tP/OhBm72q0zbrsymW1HQx5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710197409;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZxUzTMlXn3tjcFXFnIZtmdtt4eI79Utif3t7gSNN5zI=;
	b=F+g1Kpq1z//72iAQU0s5syM1OR3D2vd1+VUaZDH/4porC6DOlqeOzQCvwxbMLLcaGNGQzW
	MuVHYv5vFOygdiCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710197409;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZxUzTMlXn3tjcFXFnIZtmdtt4eI79Utif3t7gSNN5zI=;
	b=2JMcx+XwlcbtzsHasDWy6ZqzZxXsO3ioT+8RzDCQ0YvK0mSr6RGEEmrDkprLn9iu/wrFlb
	2nBv61lu5TWoLC+nmdgCMjeN3iwiOxMPT1xggX7YslQnNgaZkdTVnamLCxVzptOzNdUH+k
	gdB/u14tP/OhBm72q0zbrsymW1HQx5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710197409;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZxUzTMlXn3tjcFXFnIZtmdtt4eI79Utif3t7gSNN5zI=;
	b=F+g1Kpq1z//72iAQU0s5syM1OR3D2vd1+VUaZDH/4porC6DOlqeOzQCvwxbMLLcaGNGQzW
	MuVHYv5vFOygdiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6618113695;
	Mon, 11 Mar 2024 22:50:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QldwGKGK72XGBQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 11 Mar 2024 22:50:09 +0000
Date: Mon, 11 Mar 2024 23:43:00 +0100
From: David Sterba <dsterba@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] statx: stx_subvol
Message-ID: <20240311224259.GV2604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240308022914.196982-1-kent.overstreet@linux.dev>
 <2f598709-fccb-4364-bf15-f9c171b440aa@wdc.com>
 <20240311-zugeparkt-mulden-48b143bf51e0@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311-zugeparkt-mulden-48b143bf51e0@brauner>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.20 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[wdc.com:email];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[44.46%]
X-Spam-Score: 0.20
X-Spam-Flag: NO

On Mon, Mar 11, 2024 at 02:43:11PM +0100, Christian Brauner wrote:
> On Mon, Mar 11, 2024 at 08:12:33AM +0000, Johannes Thumshirn wrote:
> > On 08.03.24 03:29, Kent Overstreet wrote:
> > > Add a new statx field for (sub)volume identifiers, as implemented by
> > > btrfs and bcachefs.
> > > 
> > > This includes bcachefs support; we'll definitely want btrfs support as
> > > well.
> > 
> > For btrfs you can add the following:
> > 
> > 
> >  From 82343b7cb2a947bca43234c443b9c22339367f68 Mon Sep 17 00:00:00 2001
> > From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Date: Mon, 11 Mar 2024 09:09:36 +0100
> > Subject: [PATCH] btrfs: provide subvolume id for statx
> > 
> > Add the inode's subvolume id to the newly proposed statx subvol field.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---
> 
> Thanks, will fold, once I hear from Josef.

We're OK with it.

