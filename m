Return-Path: <linux-fsdevel+bounces-48-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 186D27C4DAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 10:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299261C20D88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 08:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928E41A588;
	Wed, 11 Oct 2023 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dCscXelR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UeoeFs2q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A3519BAC
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 08:51:46 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3C89C
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 01:51:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6787E211F0;
	Wed, 11 Oct 2023 08:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1697014303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zomvkG92xF6pqN1cg5MZ9f9ccJtQB3cKBdjAKIIZNk=;
	b=dCscXelRVLV2JXw1d0syrLDcoA3acbZNR6zilkU2yjKPYoFJrTAXBXO4tGecSLX1OoXTM1
	iIpQGHge4As60XC+ylAoQVGyeYI2lyZnUHRi4MJYdZJt2oSKWYiEEaqdTUNVoRP/ERy6B8
	dqRFjXhCHyXQTe+eRV018fxu9MABwlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1697014303;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3zomvkG92xF6pqN1cg5MZ9f9ccJtQB3cKBdjAKIIZNk=;
	b=UeoeFs2q2evNxuwnhPk9EbQC/AQIZELAUVyn7J6RkfEBEoUXYgEXDx5SHW+0JZLLPbj1Hg
	gWvDYr/Jiz9QBADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52CD2134F5;
	Wed, 11 Oct 2023 08:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id NQytEx9iJmVYLQAAMHmgww
	(envelope-from <chrubis@suse.cz>); Wed, 11 Oct 2023 08:51:43 +0000
Date: Wed, 11 Oct 2023 10:52:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH 0/3] Add tst_iterate_fd()
Message-ID: <ZSZiScYnMIGtc4du@yuki>
References: <20231004124712.3833-1-chrubis@suse.cz>
 <87o7h6zsth.fsf@suse.de>
 <ZSVPpG4_ui4k5nES@yuki>
 <87fs2hzgr4.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs2hzgr4.fsf@suse.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi!
> This looks promising. I think it would be good to try this sooner rather
> than later.

Already rewriting the code...

-- 
Cyril Hrubis
chrubis@suse.cz

