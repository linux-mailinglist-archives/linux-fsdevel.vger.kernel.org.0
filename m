Return-Path: <linux-fsdevel+bounces-4019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9B67FB631
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 10:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E59B1C20F02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Nov 2023 09:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18CF4AF61;
	Tue, 28 Nov 2023 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="S6QcIWw/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CE21B9;
	Tue, 28 Nov 2023 01:45:08 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F8582195A;
	Tue, 28 Nov 2023 09:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1701164707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PjmgV8c/dSvki9BoDbxFb8rn9kuThbhs3kZKihqd5Ms=;
	b=S6QcIWw/2fwQUd4Pv6miut4WGF6hKhISBRs6Ksh/ByqrsatBI0+AGVKiQCo+GH2AOSdThy
	zFkQGmtFlU1Kut3woNmZDBEzD3VrwXnCutMD+gJ5wUyKVJeKq5s0IUuHBoJYtZWcF5x+76
	XLaCQfYWFWo/VV4/ze4WLkQNNINejQg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B83E1343E;
	Tue, 28 Nov 2023 09:45:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jw6vA6O2ZWVrZAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 28 Nov 2023 09:45:07 +0000
Date: Tue, 28 Nov 2023 10:45:02 +0100
From: Michal Hocko <mhocko@suse.com>
To: Gregory Price <gregory.price@memverge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, arnd@arndb.de, tglx@linutronix.de,
	luto@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	tj@kernel.org, ying.huang@intel.com
Subject: Re: [RFC PATCH 00/11] mm/mempolicy: Make task->mempolicy externally
 modifiable via syscall and procfs
Message-ID: <ZWW2ngGhM9af5qJW@tiehlicka>
References: <20231122211200.31620-1-gregory.price@memverge.com>
 <20231122133348.d27c09a90bce755dc1c0f251@linux-foundation.org>
 <ZV5/ilfUoqC2PW0D@memverge.com>
 <ZWS19JFHm_LFSsFd@tiehlicka>
 <ZWTAdKnBVO0+5bbR@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWTAdKnBVO0+5bbR@memverge.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -6.10
X-Spamd-Result: default: False [-6.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kvack.org,vger.kernel.org,arndb.de,linutronix.de,kernel.org,redhat.com,alien8.de,linux.intel.com,zytor.com,intel.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On Mon 27-11-23 11:14:44, Gregory Price wrote:
> On Mon, Nov 27, 2023 at 04:29:56PM +0100, Michal Hocko wrote:
> > Sorry, didn't have much time to do a proper review. Couple of points
> > here at least.
> > 
> > > 
> > > So... yeah... the is one area I think the community very much needs to
> > > comment:  set/get_mempolicy2, many new mempolicy syscalls, procfs? All
> > > of the above?
> > 
> > I think we should actively avoid using proc interface. The most
> > reasonable way would be to add get_mempolicy2 interface that would allow
> > extensions and then create a pidfd counterpart to allow acting on a
> > remote task. The latter would require some changes to make mempolicy
> > code less current oriented.
> 
> Sounds good, I'll pull my get/set_mempolicy2 RFC on top of this.
> 
> Just context: patches 1-6 refactor mempolicy to allow remote task
> twiddling (fixing the current-oriented issues), and patch 7 adds the pidfd
> interfaces you describe above.
> 
> 
> Couple Questions
> 
> 1) Should we consider simply adding a pidfd arg to set/get_mempolicy2,
>    where if (pidfd == 0), then it operates on current, otherwise it
>    operates on the target task?  That would mitigate the need for what
>    amounts to the exact same interface.

This wouldn't fit into existing pidfd interfaces I am aware of. We
assume pidfd to be real fd, no special cases.

> 2) Should we combine all the existing operations into set_mempolicy2 and
>    add an operation arg.
> 
>    set_mempolicy2(pidfd, arg_struct, len)
> 
>    struct {
>      int pidfd; /* optional */
>      int operation; /* describe which op_args to use */
>      union {
>        struct {
>        } set_mempolicy;
>        struct {
>        } set_vma_home_node;
>        struct {
>        } mbind;
>        ...
>      } op_args;
>    } args;
> 
>    capturing:
>      sys_set_mempolicy
>      sys_set_mempolicy_home_node
>      sys_mbind
> 
>    or should we just make a separate interface for mbind/home_node to
>    limit complexity of the single syscall?

My preference would be to go with specific syscalls. Multiplexing
syscalls have turned much more complex and less flexible over time.
Just have a look at futex.
-- 
Michal Hocko
SUSE Labs

