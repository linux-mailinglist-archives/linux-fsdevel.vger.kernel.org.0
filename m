Return-Path: <linux-fsdevel+bounces-25005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAF1947A52
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 13:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19301C212A1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C391547E0;
	Mon,  5 Aug 2024 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EW/0dBXo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Ml6M8co";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EW/0dBXo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Ml6M8co"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833081311AC
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Aug 2024 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722856697; cv=none; b=VOPo80Yio+DDsr3iYIokyuFC0uzZ56ji4cHZOxUjXB5SpoqtlOlYUVyTAFbCKBZHRdF+K3UDMFFbSR8ehfXg1aRciy6qoAkcDqWq6K5vwVgrmjTF5+JvceeSjoUvw7m8hN+Fx1ZRlRsT4Fwj66jCnzN9x+ewZVyLt9Yu1nQrfsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722856697; c=relaxed/simple;
	bh=j9JlfeW3mf4kbUwRfi5AYhAOw3lqbMAgESUcmMzDtbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laUVM/J5X/wGq2tZFZmUdcDqw2tTyJTENdmydb0E34WcBi99oQNPabfxw+Dcj20AEdNn2uIYcBaWMy95HHFBVGiu8ym7x+2Nt2G1tgZD05OYtN1nQaEeW0hecMBqycpmdwe+Vof9m97q67UxGnu/XXBPTOWjQckFLL8hOlUjx/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EW/0dBXo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Ml6M8co; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EW/0dBXo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Ml6M8co; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4EE2D21B8A;
	Mon,  5 Aug 2024 11:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722856688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6k2joFYKRa/gs7qDLvXaeeNH2MsKSLKq+njolwM9kbw=;
	b=EW/0dBXotWWZ9oySM+Qp1uIsy5e8mrhhIzk7gc61Sm/DS1r9AKI0VLCvEVrXN4QwBukoaj
	uMnWkb5jO85JOrk3KTYuFtrZJaJTI9Fb3SUL0c8YNLrDtB63GN15GC3W/fpLvGrSzoZNF7
	pInhV5UgnU13mp/OmXWjlveDXMjjC9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722856688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6k2joFYKRa/gs7qDLvXaeeNH2MsKSLKq+njolwM9kbw=;
	b=5Ml6M8coIR1dXg8taJNoD3sAXYlxxjZelU9IKVUIQR28IkOJWQYZ37eZTMi9Mo3XB2ORyx
	X06B0HAD2RJKhaCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722856688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6k2joFYKRa/gs7qDLvXaeeNH2MsKSLKq+njolwM9kbw=;
	b=EW/0dBXotWWZ9oySM+Qp1uIsy5e8mrhhIzk7gc61Sm/DS1r9AKI0VLCvEVrXN4QwBukoaj
	uMnWkb5jO85JOrk3KTYuFtrZJaJTI9Fb3SUL0c8YNLrDtB63GN15GC3W/fpLvGrSzoZNF7
	pInhV5UgnU13mp/OmXWjlveDXMjjC9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722856688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6k2joFYKRa/gs7qDLvXaeeNH2MsKSLKq+njolwM9kbw=;
	b=5Ml6M8coIR1dXg8taJNoD3sAXYlxxjZelU9IKVUIQR28IkOJWQYZ37eZTMi9Mo3XB2ORyx
	X06B0HAD2RJKhaCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 450FB13ACF;
	Mon,  5 Aug 2024 11:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HuPYEPC0sGYkEQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Aug 2024 11:18:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DC3E4A0897; Mon,  5 Aug 2024 13:18:03 +0200 (CEST)
Date: Mon, 5 Aug 2024 13:18:03 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: Re: [PATCH 05/10] fanotify: introduce FAN_PRE_MODIFY permission event
Message-ID: <20240805111803.kgazhyywaysvukcg@quack3>
References: <cover.1721931241.git.josef@toxicpanda.com>
 <e58775009d8df15b5513fab5ac112f0dac53e427.1721931241.git.josef@toxicpanda.com>
 <20240801170933.yqabftb5qphscyol@quack3>
 <CAOQ4uxjFo3abddFVAtre9PE3X=HnvJU2kYhDzfnkt+ErMt4_3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjFo3abddFVAtre9PE3X=HnvJU2kYhDzfnkt+ErMt4_3Q@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.80 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -0.80

On Sat 03-08-24 18:55:42, Amir Goldstein wrote:
> On Thu, Aug 1, 2024 at 7:09 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 25-07-24 14:19:42, Josef Bacik wrote:
> > > From: Amir Goldstein <amir73il@gmail.com>
> > >
> > > Generate FAN_PRE_MODIFY permission event from fsnotify_file_perm()
> > > pre-write hook to notify fanotify listeners on an intent to make
> > > modification to a file.
> > >
> > > Like FAN_PRE_ACCESS, it is only allowed with FAN_CLASS_PRE_CONTENT
> > > and unlike FAN_MODIFY, it is only allowed on regular files.
> > >
> > > Like FAN_PRE_ACCESS, it is generated without sb_start_write() held,
> > > so it is safe for to perform filesystem modifications in the the
> >                 ^^^ seems superfluous                      ^^^ twice "the"
> >
> > > context of event handler.
> > ...
> > > diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> > > index 5c811baf44d2..ae6cb2688d52 100644
> > > --- a/include/linux/fanotify.h
> > > +++ b/include/linux/fanotify.h
> > > @@ -92,7 +92,8 @@
> > >  #define FANOTIFY_CONTENT_PERM_EVENTS (FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
> > >                                     FAN_ACCESS_PERM)
> > >  /* Pre-content events can be used to fill file content */
> > > -#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS)
> > > +#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS | FAN_PRE_MODIFY)
> > > +#define FANOTIFY_PRE_MODIFY_EVENTS   (FAN_PRE_MODIFY)
> >
> > I didn't find FANOTIFY_PRE_MODIFY_EVENTS used anywhere?
> 
> Right. It is used later in the sb_write_barrier patches.
> We can introduce it later if you prefer.

If you say it eventually gets used then I'm fine with this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

