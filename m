Return-Path: <linux-fsdevel+bounces-71015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA65CAFEDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 13:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 717B73015AF5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 12:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF363246EA;
	Tue,  9 Dec 2025 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FLRSCzPJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hbf8qhkj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VJlXEdXF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7U2McOFD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572963246EB
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 12:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765283352; cv=none; b=niA5NJO7M5Bc/JaAFvog1MMD1zRSdlhJfEes+kVCyDBtxL/pexDyK/ysRaOuz6yFy1M6BXloMDoT/Byz1RhOrTjPyxfqKMrELCExwd6IMNaMo5Y9i1WSDX5xrFCwOxySMSl4rhpfZCNgwa4NANHyd8hKpxl2TZrvPQ2m9+9Ncw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765283352; c=relaxed/simple;
	bh=1zv96AQDDBhIUB4SFjGPpc0lMwQj0fEVtOdQfSFFiS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8b93XuGCRh1ikTYFu5XdBRGoYT4y+6OwQ1QVpj0mJt1yYl05fbSefHGh68dE/DQs9fLXLfyH5rdE8GgJqVNqlifK4dlXJvjtDczrXTSC50kfutvlo8243mSOUI0AVmkGS+xY+TDThKt6TaCb6NFRCx52tUcQF+Pl5K7BZe3amU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FLRSCzPJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hbf8qhkj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VJlXEdXF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7U2McOFD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DBDDC3376A;
	Tue,  9 Dec 2025 12:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765283333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ygaHW8o5EWTBSXhXnK7ekdPvbFwd/VSzrB9zkhVTLRQ=;
	b=FLRSCzPJDhDdvQBy6p9ZobCmyv/OBX5mdkpgv9YpCqbX4VYeXoLguaXTTt/4hB56KyccR3
	nf6j3BOH3yRK5qh3cMAhUeYflgxmzqZIAAWr7UEx2q9QNXPIkryChFyALpi19LajiUsYK/
	w54xqTZihwFGArwdrmUESFAEfw7lRhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765283333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ygaHW8o5EWTBSXhXnK7ekdPvbFwd/VSzrB9zkhVTLRQ=;
	b=hbf8qhkj9AN8CNYDunpaBDH5eRvnqnbwWvSf1aitvsKjxZvZHQuV3PFneX2ZGBk18Krav0
	lfB9W/ldGjK5+6DA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VJlXEdXF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7U2McOFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765283332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ygaHW8o5EWTBSXhXnK7ekdPvbFwd/VSzrB9zkhVTLRQ=;
	b=VJlXEdXFL5fd4Sem3MzdBi6M+Hr11U7VtVbf3ME1dk5aSuhjv3O/iSL8Yd/XI8EpEFKwGn
	qt5OE3BhUWleFUONVE7NBCIrv8ySHriCLSY0zQvS97diMAG7hRy1P55heddbwQqqP5orwx
	zke8vzmd4c6IaLFBZbk/OIH2tq5XjmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765283332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ygaHW8o5EWTBSXhXnK7ekdPvbFwd/VSzrB9zkhVTLRQ=;
	b=7U2McOFDYb7YMgNpJuCJtvWZaYZMflyH94JOMxO/WJFjXPjjRW/ONo04eFBGZ6oK+Zhnh3
	bJ4+1uZfHqHgl3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA4F63EA65;
	Tue,  9 Dec 2025 12:28:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 09RfMQQWOGn0YgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 09 Dec 2025 12:28:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4850FA08E4; Tue,  9 Dec 2025 13:28:48 +0100 (CET)
Date: Tue, 9 Dec 2025 13:28:48 +0100
From: Jan Kara <jack@suse.cz>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Michal Hocko <mhocko@suse.com>, Serge Hallyn <serge@hallyn.com>, 
	James Morris <jamorris@linux.microsoft.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Suren Baghdasaryan <surenb@google.com>, Yafang Shao <laoar.shao@gmail.com>, Helge Deller <deller@gmx.de>, 
	Adrian Reber <areber@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Jens Axboe <axboe@kernel.dk>, Alexei Starovoitov <ast@kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	tiozhang <tiozhang@didiglobal.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Frederic Weisbecker <frederic@kernel.org>, YueHaibing <yuehaibing@huawei.com>, 
	Paul Moore <paul@paul-moore.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Stefan Roesch <shr@devkernel.io>, Chao Yu <chao@kernel.org>, xu xin <xu.xin16@zte.com.cn>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>, 
	Dave Chinner <dchinner@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Elena Reshetova <elena.reshetova@intel.com>, David Windsor <dwindsor@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, Ard Biesheuvel <ardb@kernel.org>, 
	"Joel Fernandes (Google)" <joel@joelfernandes.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Hans Liljestrand <ishkamiel@gmail.com>, Penglei Jiang <superman.xpt@gmail.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Adrian Ratiu <adrian.ratiu@collabora.com>, 
	Ingo Molnar <mingo@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Cyrill Gorcunov <gorcunov@gmail.com>, Eric Dumazet <edumazet@google.com>, zohar@linux.ibm.com, 
	linux-integrity@vger.kernel.org, Ryan Lee <ryan.lee@canonical.com>, 
	apparmor <apparmor@lists.ubuntu.com>
Subject: Re: Are setuid shell scripts safe? (Implied by
 security_bprm_creds_for_exec)
Message-ID: <722m42dxrfxao7y6ul5cb26orxoinsrozwqlf7ts52lpbfzgxs@gm6kakrzlhkz>
References: <87tsyozqdu.fsf@email.froward.int.ebiederm.org>
 <87wm3ky5n9.fsf@email.froward.int.ebiederm.org>
 <87h5uoxw06.fsf_-_@email.froward.int.ebiederm.org>
 <6dc556a0a93c18fffec71322bf97441c74b3134e.camel@huaweicloud.com>
 <87v7iqtcev.fsf_-_@email.froward.int.ebiederm.org>
 <dca0f01500f9d6705dccf3b3ef616468b1f53f57.camel@huaweicloud.com>
 <87ms42rq3t.fsf@email.froward.int.ebiederm.org>
 <GV2PPF74270EBEE90CDCD964F69E806EF58E4D9A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <20251204054915.GI1712166@ZenIV>
 <GV2PPF74270EBEE0AAAE2EB22B668EE21A7E4A6A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PPF74270EBEE0AAAE2EB22B668EE21A7E4A6A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: DBDDC3376A
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[hotmail.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,xmission.com,huaweicloud.com,gmail.com,redhat.com,kernel.org,amacapital.net,chromium.org,linux-foundation.org,suse.com,hallyn.com,linux.microsoft.com,infradead.org,google.com,gmx.de,linutronix.de,kernel.dk,vger.kernel.org,kvack.org,didiglobal.com,manguebit.com,huawei.com,paul-moore.com,cyphar.com,devkernel.io,zte.com.cn,suse.cz,intel.com,joelfernandes.org,oracle.com,collabora.com,linux.ibm.com,canonical.com,lists.ubuntu.com];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_GT_50(0.00)[61];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Thu 04-12-25 14:03:27, Bernd Edlinger wrote:
> On 12/4/25 06:49, Al Viro wrote:
> > On Wed, Dec 03, 2025 at 02:16:29PM +0100, Bernd Edlinger wrote:
> > 
> >> Hmm, yes, that looks like an issue.
> >>
> >> I would have expected the security engine to look at bprm->filenanme
> >> especially in the case, when bprm->interp != bprm->filename,
> >> and check that it is not a sym-link with write-access for the
> >> current user and of course also that the bprm->file is not a regular file
> >> which is writable by the current user, if that is the case I would have expected
> >> the secuity engine to enforce non-new-privs on a SUID executable somehow.
> > 
> > Check that _what_ is not a symlink?  And while we are at it, what do write
> > permissions to any symlinks have to do with anything whatsoever?
> 
> When we execve a normal executable, we do open the binary file with
> deny_write_access so this might allow the security engine to inspaect the
> binary, before it is used.

That would be seriously flawed IMO because there are lot of cases where
code is executed without deny_write_access() - like shared libraries, code
loaded by interpreter, and probably more.

> However this behavior has changed recently,
> now it has some exceptions, where even this behavior is no longer
> guaranteed for binary executables, due to commit
> 0357ef03c94ef835bd44a0658b8edb672a9dbf51, but why?  I have no idea...

Because for hierarchical storage implementation you may need to fill in the
executable data from remote storage on demand and the deny_write_access
logic was making this impossible. We even tried to completely remove the
deny_write_access logic exactly because it has very limited use and
complicates things (commit 2a010c412853 ("fs: don't block i_writecount
during exec")) but that had to be reverted because some userspace depends
on the ETXTBUSY behavior.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

