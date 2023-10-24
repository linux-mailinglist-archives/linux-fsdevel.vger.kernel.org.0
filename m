Return-Path: <linux-fsdevel+bounces-1124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F28A7D5DFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 00:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8081C20D35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 22:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15543D386;
	Tue, 24 Oct 2023 22:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vBRHjWs+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="933tbh9j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A198638F96
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 22:20:27 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DC910C3;
	Tue, 24 Oct 2023 15:20:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 23F4521C7F;
	Tue, 24 Oct 2023 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698186021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CDeMMzqwERdWZxhGUFthQI91/gdqCAMKlu74LJU3/pc=;
	b=vBRHjWs+sgfl44CHFZ67PsaMWBbaUhtaEl5ETVD8Y0K0pcxZYwDcyKDSfVQ+0AXfiwf7pX
	tysZQkyaSTF165wNCkKoDUQBOtlPwXih0BBfQtH07RNP67rRqBicWF1gZnzlWiC5ftYa0z
	BGq4v9yZKpo3MpVDdjtrgn+w8gH7ox0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698186021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CDeMMzqwERdWZxhGUFthQI91/gdqCAMKlu74LJU3/pc=;
	b=933tbh9jJpH40D8bAgtuwIP3Oz7cqUkB+n7n5/w3vxtF14VC633YCAUySmXy/JoYWnrKhe
	85Ty07IujwoJWGBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E23631391C;
	Tue, 24 Oct 2023 22:20:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 4vKlMSRDOGXYBgAAMHmgww
	(envelope-from <krisman@suse.de>); Tue, 24 Oct 2023 22:20:20 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>,  viro@zeniv.linux.org.uk,
  tytso@mit.edu,  jaegeuk@kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-ext4@vger.kernel.org,  linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v6 0/9] Support negative dentries on case-insensitive
 ext4 and f2fs
In-Reply-To: <20230822-denkmal-operette-f16d8bd815fc@brauner> (Christian
	Brauner's message of "Tue, 22 Aug 2023 11:03:48 +0200")
Organization: SUSE
References: <20230816050803.15660-1-krisman@suse.de>
	<20230817170658.GD1483@sol.localdomain>
	<20230821-derart-serienweise-3506611e576d@brauner>
	<871qfwns61.fsf@suse.de>
	<20230822-denkmal-operette-f16d8bd815fc@brauner>
Date: Tue, 24 Oct 2023 18:20:19 -0400
Message-ID: <87pm138xy4.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.78
X-Spamd-Result: default: False [-3.78 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 HAS_ORG_HEADER(0.00)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 INVALID_MSGID(1.70)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.88)[94.35%]

Christian Brauner <brauner@kernel.org> writes:

>> Targeting 6.7 is fine by me. will you pick it up through the vfs tree? I
>> prefer it goes through there since it mostly touches vfs.
>
> Yes, I think that's what will end up happening.

Hi Christian,

Sorry for the ping again, but I got a question about your process.

I noticed this patchset did not make into linux-next in preparation for
the 6.7 merge request. It also doesn't show in your vfs.all, but an
older iteration (definitely not the v6 that Eric acked) exists in a
vfs.dcache.casefold branch.  Is this expected and I'm missing something?

I considered this applied but I might have misunderstood. Please let me
know if you need me to rebase.

-- 
Gabriel Krisman Bertazi

