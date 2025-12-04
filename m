Return-Path: <linux-fsdevel+bounces-70625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4B3CA26CB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 06:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 000CE304BDAD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 05:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469CB3043A5;
	Thu,  4 Dec 2025 05:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nXmoy3q7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEAE33EC;
	Thu,  4 Dec 2025 05:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764827382; cv=none; b=IsvmIOshhgREtyKjQAAVF00719pCsFYy5xZzpeI7cAIxTEQkxI//GfIUVmqo0cePydV6vteue+DqzjiVcHxn4kukIZfp7JzqsT9/arTmlU5JXD1uz9Jiqgh6JBLTVikeZ7EY3Dm70WzAf4jdbAkRVMas2uPipn8NWCRhS6bXpVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764827382; c=relaxed/simple;
	bh=1/qVzHTq0dl3bm/fJdmBkkGZRpToC5uG2LWdRmGkX5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQILZj2FaHCHYACJS8T9xmLrWbx0WlmKpkJhnneN01TKcAJ5Ut0AH73/FiK8+iGRsE8YOWY2MbCgQJKT8AkW+kizwfaNLS3lXEeBUPONRoX5CW71LVSsBGSP6DZ1btl18aHFiwvYLyB9jCvOG9d26RY5fKugts6tWe4GB6I3fGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nXmoy3q7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s6+X3uAjfnbMKEn6Xkh/hO+HnZ24JeUWApwybKJc010=; b=nXmoy3q7PEPpF5abxhwxO3qXvd
	TkOCDMpiiUph/GGfD1WSJSK6FPE7975gCK4ZlbwYerMAlQ+aDVWKI0+zdSP+F0KjPdtQh7MNS982p
	z3URRnIZyusnvBJZ0tu+Gk9YMZthTHw6do/oReTtyIYkuoIlZyFmFoCJSyIVZsPmb/mEgU5ADU4bK
	UpeFaQlqNn8cm5F7j27o7aJ9XMA+VckFrpslNClucgYUn+qf2Q0VjoEWhwaITyMRS1yfk5eRiK27k
	h1+uW0AsswtW89hBcY65p1OQhlSrI4BenMrX6NTWbeIfKYv8oym8o/6VjEDkCnb89R955AmHDd024
	le4n+XBg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vR2DL-00000008t6s-2eTQ;
	Thu, 04 Dec 2025 05:49:15 +0000
Date: Thu, 4 Dec 2025 05:49:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>, Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>, Serge Hallyn <serge@hallyn.com>,
	James Morris <jamorris@linux.microsoft.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Yafang Shao <laoar.shao@gmail.com>, Helge Deller <deller@gmx.de>,
	Adrian Reber <areber@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <ast@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	linux-security-module@vger.kernel.org,
	tiozhang <tiozhang@didiglobal.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Paulo Alcantara (SUSE)" <pc@manguebit.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	YueHaibing <yuehaibing@huawei.com>,
	Paul Moore <paul@paul-moore.com>, Aleksa Sarai <cyphar@cyphar.com>,
	Stefan Roesch <shr@devkernel.io>, Chao Yu <chao@kernel.org>,
	xu xin <xu.xin16@zte.com.cn>, Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>,
	Dave Chinner <dchinner@redhat.com>, Shuah Khan <shuah@kernel.org>,
	Elena Reshetova <elena.reshetova@intel.com>,
	David Windsor <dwindsor@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Ard Biesheuvel <ardb@kernel.org>,
	"Joel Fernandes (Google)" <joel@joelfernandes.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hans Liljestrand <ishkamiel@gmail.com>,
	Penglei Jiang <superman.xpt@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>,
	Eric Dumazet <edumazet@google.com>, zohar@linux.ibm.com,
	linux-integrity@vger.kernel.org, Ryan Lee <ryan.lee@canonical.com>,
	apparmor <apparmor@lists.ubuntu.com>
Subject: Re: Are setuid shell scripts safe? (Implied by
 security_bprm_creds_for_exec)
Message-ID: <20251204054915.GI1712166@ZenIV>
References: <GV2PPF74270EBEE9EF78827D73D3D7212F7E432A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <GV2PPF74270EBEEE807D016A79FE7A2F463E4D6A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
 <87tsyozqdu.fsf@email.froward.int.ebiederm.org>
 <87wm3ky5n9.fsf@email.froward.int.ebiederm.org>
 <87h5uoxw06.fsf_-_@email.froward.int.ebiederm.org>
 <6dc556a0a93c18fffec71322bf97441c74b3134e.camel@huaweicloud.com>
 <87v7iqtcev.fsf_-_@email.froward.int.ebiederm.org>
 <dca0f01500f9d6705dccf3b3ef616468b1f53f57.camel@huaweicloud.com>
 <87ms42rq3t.fsf@email.froward.int.ebiederm.org>
 <GV2PPF74270EBEE90CDCD964F69E806EF58E4D9A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV2PPF74270EBEE90CDCD964F69E806EF58E4D9A@GV2PPF74270EBEE.EURP195.PROD.OUTLOOK.COM>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 03, 2025 at 02:16:29PM +0100, Bernd Edlinger wrote:

> Hmm, yes, that looks like an issue.
> 
> I would have expected the security engine to look at bprm->filenanme
> especially in the case, when bprm->interp != bprm->filename,
> and check that it is not a sym-link with write-access for the
> current user and of course also that the bprm->file is not a regular file
> which is writable by the current user, if that is the case I would have expected
> the secuity engine to enforce non-new-privs on a SUID executable somehow.

Check that _what_ is not a symlink?  And while we are at it, what do write
permissions to any symlinks have to do with anything whatsoever?

