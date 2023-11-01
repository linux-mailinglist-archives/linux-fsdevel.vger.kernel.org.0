Return-Path: <linux-fsdevel+bounces-1762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 960F07DE5EF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 19:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BF6DB2110F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 18:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9399718E0D;
	Wed,  1 Nov 2023 18:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="J3lVdNXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC01A28
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 18:19:17 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD73DA
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 11:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JNVqajZE9s9Rjqc94EB9Bs1LpG80undJrQ0GNdUt8t4=; b=J3lVdNXSLaoU9sU8nyMAWx1+nB
	QSMw74tZq+5Ym1LavIO1fxWiGuqXwaeiF3lxB/+laHIk99hQjhECtrngrscTeOX77C3OaWUGfCwIt
	LZ8FNgItj0njeK1S+X3ZsKzGNbJVG3oUBMGnsGz8ZWvVxU8M7DYYR/miikfES3dkp7IEqpdG/8tQf
	EusdfqJwBJ+xkGEZefDyJQrrZnxSViSZ6nhwhmGu5gsxeKjPgp5sUyWU0DCWMzEWM+OvQLpZdRrNi
	OxWO2Ler0gGZtFjK1apULfiYvFsNst6yaus/iQ07X5+IZ9MfGFcbnMrTE5WvGddJtRmalwmy6DJS+
	YrmNY6yg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qyFo6-009Mwb-35;
	Wed, 01 Nov 2023 18:19:11 +0000
Date: Wed, 1 Nov 2023 18:19:10 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/15] fold the call of retain_dentry() into fast_dput()
Message-ID: <20231101181910.GH1957730@ZenIV>
References: <20231031061226.GC1957730@ZenIV>
 <20231101062104.2104951-1-viro@zeniv.linux.org.uk>
 <20231101062104.2104951-9-viro@zeniv.linux.org.uk>
 <20231101084535.GG1957730@ZenIV>
 <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgP27-D=2YvYNQd3OBfBDWK6sb_urYdt6xEPKiev6y_2Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 01, 2023 at 07:30:34AM -1000, Linus Torvalds wrote:
> On Tue, 31 Oct 2023 at 22:45, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Wed, Nov 01, 2023 at 06:20:58AM +0000, Al Viro wrote:
> > > Calls of retain_dentry() happen immediately after getting false
> > > from fast_dput() and getting true from retain_dentry() is
> > > treated the same way as non-zero refcount would be treated by
> > > fast_dput() - unlock dentry and bugger off.
> > >
> > > Doing that in fast_dput() itself is simpler.
> >
> > FWIW, I wonder if it would be better to reorganize it a bit -
> 
> Hmm. Yes. Except I don't love how the retaining logic is then duplicated.

Er...  That change would be an equivalent transformation - the same duplication
is there right now...

> Could we perhaps at least try to share the dentry flag tests between
> the "real" retain_dentry() code and the lockless version?

Umm...  There are 3 groups:

DONTCACHE, DISCONNECTED - hard false
!LRU_LIST, !REFERENCED - not an obstacle to true, but need to take locks
OP_DELETE - can't tell without asking filesystem, which would need ->d_lock.

gcc-12 on x86 turns the series of ifs into
        movl    %edi, %eax
	andl    $32832, %eax
	cmpl    $32832, %eax
	jne     .L17
	andl    $168, %edi
	jne     .L17
instead of combining that into
        andl    $33000, %edi
	cmpl    $32832, %edi
	jne     .L17

OTOH, that's not much of pessimization...  Up to you.


> > Another thing: would you mind
> >
> > #if USE_CMPXCHG_LOCKREF
> > extern int lockref_put_return(struct lockref *);
> > #else
> > static inline int lockref_put_return(struct lockref *l)
> > {
> >         return -1;
> > }
> > #endif
> >
> > in include/linux/lockref.h?  Would be useful on DEBUG_SPINLOCK configs...
> 
> The above sounds like a good idea, not only for better code generation
> for the debug case, but because it would have possibly made the erofs
> misuse more obvious to people.

To make it even more obvious, perhaps rename it as well?  I.e.

/*
 * unlike the rest of these primitives, the one below does *not* contain
 * a fallback; caller needs to take care of handling that.
 */
#if USE_CMPXCHG_LOCKREF
extern int __lockref_put_return(struct lockref *);
#else
static inline int __lockref_put_return(struct lockref *l)
{
	return -1;
}
#endif

