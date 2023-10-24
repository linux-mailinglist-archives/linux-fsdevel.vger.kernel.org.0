Return-Path: <linux-fsdevel+bounces-1006-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255C97D4C84
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 11:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6FCB20F99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 09:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8175D2421E;
	Tue, 24 Oct 2023 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Taeu222U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6swiuuTu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39712224F7
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 09:34:05 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB51E10C0
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 02:34:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A6E762189E;
	Tue, 24 Oct 2023 09:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1698140041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jIHaUscQTq1/wxwXcDzx5FjA6aS8KhMLGKHlRvr84P4=;
	b=Taeu222UV9/DMDpx+957XHJpswK8QtqtYGHN1uLSpQ81q3ZbEI4u1QL0qU+C42fUn+sgDS
	i7FnNcPjV2ZfcE67admWeGxW/8bMz8+JkEm10iV1O2Y4Q/CHBhdBIMthFMLYJMlyEpGXqj
	rN37fr9zRKJ41rNYsYHsoR91TZqx8pA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1698140041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jIHaUscQTq1/wxwXcDzx5FjA6aS8KhMLGKHlRvr84P4=;
	b=6swiuuTumTS5psyi1mb8eNNLazSJ9YvK6C10hwZ0DfJG0JR6SkC0WoR3U+Me5UmGiot67X
	56CQibwllqrJMIBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CBF1134F5;
	Tue, 24 Oct 2023 09:34:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id sAkpIYmPN2XTCAAAMHmgww
	(envelope-from <chrubis@suse.cz>); Tue, 24 Oct 2023 09:34:01 +0000
Date: Tue, 24 Oct 2023 11:34:33 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v2 3/4] syscalls: accept: Add tst_fd test
Message-ID: <ZTePqRn48CjcZT1T@yuki>
References: <20231016123320.9865-1-chrubis@suse.cz>
 <20231016123320.9865-4-chrubis@suse.cz>
 <87fs20v07j.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs20v07j.fsf@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -7.60
X-Spamd-Result: default: False [-7.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[37.18%]

Hi!
> >  int invalid_socketfd = 400; /* anything that is not an open file */
> > -int devnull_fd;
> >  int socket_fd;
> >  int udp_fd;
> >  
> > @@ -45,10 +44,6 @@ static struct test_case {
> >  		(struct sockaddr *)&fsin1, sizeof(fsin1), EBADF,
> >  		"bad file descriptor"
> >  	},
> > -	{
> > -		PF_INET, SOCK_STREAM, 0, &devnull_fd, (struct sockaddr *)&fsin1,
> > -		sizeof(fsin1), ENOTSOCK, "fd is not socket"
> > -	},
> >  	{
> >  		PF_INET, SOCK_STREAM, 0, &socket_fd, (struct sockaddr *)3,
> >  		sizeof(fsin1), EINVAL, "invalid socket buffer"
> > @@ -73,8 +68,6 @@ static void test_setup(void)
> >  	sin0.sin_port = 0;
> >  	sin0.sin_addr.s_addr = INADDR_ANY;
> >  
> > -	devnull_fd = SAFE_OPEN("/dev/null", O_WRONLY);
> > -
> >  	socket_fd = SAFE_SOCKET(PF_INET, SOCK_STREAM, 0);
> >  	SAFE_BIND(socket_fd, (struct sockaddr *)&sin0, sizeof(sin0));
> >  
> > @@ -88,7 +81,6 @@ static void test_setup(void)
> >  
> >  static void test_cleanup(void)
> >  {
> > -	SAFE_CLOSE(devnull_fd);
> >  	SAFE_CLOSE(socket_fd);
> >  	SAFE_CLOSE(udp_fd);
> >  }
> 
> Is this supposed to be part of the patchset?
> 
> I don't mind, but if we are strict, it should be in another commit.

That removes ENOTSOCK test that is now handled in accept03, I suppose I
should have explained that better in the comit message.

-- 
Cyril Hrubis
chrubis@suse.cz

