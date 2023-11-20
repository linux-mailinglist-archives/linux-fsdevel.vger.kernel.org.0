Return-Path: <linux-fsdevel+bounces-3221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F88B7F1936
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 18:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666F9282746
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Nov 2023 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876561EA87;
	Mon, 20 Nov 2023 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PqcrmX/f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SbImRmN2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBB4BA;
	Mon, 20 Nov 2023 08:59:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1AC491F898;
	Mon, 20 Nov 2023 16:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1700499598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JIN3Szij9vng0Sn6tR16Xkp3K/Bfpt8xRLXw989J/84=;
	b=PqcrmX/fFWrnUfu7j8QajdkCGraLIKGobYYF67IGQ9Y3y8vj83MNVxSpcGtzztP0LeXfsx
	PsoU8Go3KoGMpG7KNfxG3PUmzDEzL/YeqZkLwmQo6UrYQ0FGPwBfRrPjv/firN7mibcXNC
	FvBuhe9HNSvRSP8YnZ4o6zQqbMh5mhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1700499598;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JIN3Szij9vng0Sn6tR16Xkp3K/Bfpt8xRLXw989J/84=;
	b=SbImRmN2wQzPTGfC64qqBKeQ3LvGvkLeHhLvv1WqkCjE8ccSwUdroTzQkEP5temN/x4G9Q
	jqF26BCAftTuwmDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC44B13499;
	Mon, 20 Nov 2023 16:59:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id fqoQMI2QW2VOAQAAMHmgww
	(envelope-from <krisman@suse.de>); Mon, 20 Nov 2023 16:59:57 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk,  Linus Torvalds
 <torvalds@linux-foundation.org>,  tytso@mit.edu,
  linux-f2fs-devel@lists.sourceforge.net,  ebiggers@kernel.org,
  linux-fsdevel@vger.kernel.org,  jaegeuk@kernel.org,
  linux-ext4@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
In-Reply-To: <20231120-nihilismus-verehren-f2b932b799e0@brauner> (Christian
	Brauner's message of "Mon, 20 Nov 2023 16:06:09 +0100")
Organization: SUSE
References: <20230816050803.15660-1-krisman@suse.de>
	<20231025-selektiert-leibarzt-5d0070d85d93@brauner>
	<655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
	<20231120-nihilismus-verehren-f2b932b799e0@brauner>
Date: Mon, 20 Nov 2023 11:59:56 -0500
Message-ID: <87il5w5pir.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.07
X-Spamd-Result: default: False [-2.07 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 HAS_ORG_HEADER(0.00)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.17)[-0.859];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 INVALID_MSGID(1.70)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

Christian Brauner <brauner@kernel.org> writes:

> On Sun, Nov 19, 2023 at 06:11:39PM -0500, Gabriel Krisman Bertazi wrote:
>> Christian Brauner <brauner@kernel.org> writes:
>> 
>> > On Wed, 16 Aug 2023 01:07:54 -0400, Gabriel Krisman Bertazi wrote:
>> >> This is v6 of the negative dentry on case-insensitive directories.
>> >> Thanks Eric for the review of the last iteration.  This version
>> >> drops the patch to expose the helper to check casefolding directories,
>> >> since it is not necessary in ecryptfs and it might be going away.  It
>> >> also addresses some documentation details, fix a build bot error and
>> >> simplifies the commit messages.  See the changelog in each patch for
>> >> more details.
>> >> 
>> >> [...]
>> >
>> > Ok, let's put it into -next so it sees some testing.
>> > So it's too late for v6.7. Seems we forgot about this series.
>> > Sorry about that.
>> 
>> Christian,
>> 
>> We are approaching -rc2 and, until last Friday, it didn't shown up in
>> linux-next. So, to avoid turning a 6 month delay into 9 months, I pushed
>> your signed tag to linux-next myself.
>> 
>> That obviously uncovered a merge conflict: in v6.6, ceph added fscrypt,
>> and the caller had to be updated.  I fixed it and pushed again to
>> linux-next to get more testing.
>> 
>> Now, I don't want to send it to Linus myself. This is 100% VFS/FS code,
>> I'm not the maintainer and it will definitely raise eyebrows.  Can you
>> please requeue and make sure it goes through this time?  I'm happy to
>
> My current understanding is that core dcache stuff is usually handled by
> Al. And he's got a dcache branches sitting in his tree.
>
> So this isn't me ignoring you in any way. My hands are tied and so I
> can't sort this out for you easily.

Please don't take it personally, but you surely see how frustrating this
is.

While I appreciate your very prompt answer, this is very different from:

  https://lore.kernel.org/linux-fsdevel/20230821-derart-serienweise-3506611e576d@brauner/
  https://lore.kernel.org/linux-fsdevel/20230822-denkmal-operette-f16d8bd815fc@brauner/
  https://lore.kernel.org/linux-fsdevel/20231025-selektiert-leibarzt-5d0070d85d93@brauner/

Perhaps it all has a vfs-specific meaning. But the following suggests it
was accepted and queued long ago:

> Thanks! We're a bit too late for v6.6 with this given that this hasn't
> even been in -next. So this will be up for v6.7.
[...]
> Ok, let's put it into -next so it sees some testing.
[...]
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied.
[...]
> Patches in the vfs.casefold branch should appear in linux-next soon.
[...]

Obviously, there are big issues with the process here. But I fail to see
how I could have communicated clearer or where I didn't follow the
process in this entire thread.

The branches you mentioned are 10 days old. This patchset was
"accepted" two months ago.

As one of the VFS maintainer, can you send an acked-by - or at least a
r-b in cases like this, if you agree with the patches?  Then it makes
more sense for me to send to Linus directly.

Viro,

You are CC'ed since early 2022.  Can you comment?  Ted and Eric
reviewed, Christian too.  there's been only small changes since the
first RFC.

I'll ask Linus to pull from the unicode tree in the next merge window
if I don't hear from you.

-- 
Gabriel Krisman Bertazi

