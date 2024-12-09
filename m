Return-Path: <linux-fsdevel+bounces-36865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958099EA11E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 22:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4614A282519
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 21:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C9019C56D;
	Mon,  9 Dec 2024 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lPh6b/iv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6133C19DF75
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 21:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733779033; cv=none; b=LbkfM6u2llqsp63PuYZrmOMbNg+/Y/d1TMHtmtX+L21OF3PjnmS/fIb8XSFvXWeKKa33ecSA7nfL3RX1gSSn8nbrJac10ZMsAXC3JXixeJ5Su6EGFkrOjIOC53zp2MyBhHLu7mGdy1XxFUIbmRWn5CmqkQkmHEB1jQdavx0EDpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733779033; c=relaxed/simple;
	bh=Ozg+RskCCpNP65ObVuKX/lN+hsQQuu7MqcjYE/G8aFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrZk25aSAEetwreQDe6dLNE0BxHyM4JkAEnHu6uI/yRA99DmP/ScWFqOObuTZ3CaVV5tNFcK98LsG6DBDLdFb7ZLnfbSjRnZmBYwH+9n/Ta9VZx7Pl4WHZaOk7enGDTiPmaeohLIUJOzzwIdQW66iRXnkwo0t4xoNIqasGB/6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lPh6b/iv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XOWZSmwzAXy9w2ZMUqF2uH+WA8nIvQgOKOq2p+T3Tmc=; b=lPh6b/ivcukvyH5B9Qak7CNui5
	+/DeabaLs7B8wE2lBNZf+Giroi8GRnN4Bo4Wt9e/afbY5RqnytMoWB8u9rBr3SkTuw66TpG/tpjrv
	ezM7LS0KdFaEojDMVpQ053jPxV4HNTMTZXBbRsCiVOyo4BnFH7gpocaXQ1TbTYyNy1U9bAFYdd1Th
	ZIUAF/zpdl8FjZ0TSf+wvrxeQYKBBrYQ176thHzheSbcERuGoi9jZMqlGqGqv4yXip1ZD/5gEHLO+
	puTMzJFcEmC4vxE/9uvYi9Ten9O5RmY+u6NBWzMDA8lLN00rKor77pT3oxRyFj6L1Sc/QaRGuz9eH
	ENehBuHQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKl7s-00000006fmm-0uYb;
	Mon, 09 Dec 2024 21:17:08 +0000
Date: Mon, 9 Dec 2024 21:17:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
Message-ID: <20241209211708.GA3387508@ZenIV>
References: <20241209035251.GV3387508@ZenIV>
 <CAHk-=wh4=95ainkHyi5n3nFCToNWhLcfQtziSp3jSFSQGzQUAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh4=95ainkHyi5n3nFCToNWhLcfQtziSp3jSFSQGzQUAw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Dec 09, 2024 at 10:27:04AM -0800, Linus Torvalds wrote:

> The name consistency issue is really annoying. Do we really need it
> here? Because honestly, what you actually *really* care about here is
> whether it's inline or not, and you do that test right afterwards:
> 
> > +       // ->name and ->len are at least consistent with each other, so if
> > +       // ->name points to dentry->d_iname, ->len is below DNAME_INLINE_LEN
> > +       if (likely(name->name.name == dentry->d_iname)) {
> > +               memcpy(name->inline_name, dentry->d_iname, name->name.len + 1);
> 
> and here it would actually be more efficient to just use a
> constant-sized memcpy with DNAME_INLINE_LEN, and never care about
> 'len' at all.

Actually, taking a look at what's generated for that memcpy()...  *ow*
amd64 is fine, but anything that doesn't like unaligned accesses is
ending up with really awful code.

gcc does not realize that pointers are word-aligned.  What's more,
even

unsigned long v[5];

void f(unsigned long *w)
{
	memcpu(v, w, sizeof(v));
}

is not enough to convince the damn thing - try it for e.g. alpha and you'll
see arseloads of extq/insq/mskq, all inlined.  

And yes, they are aligned - d_iname follows a pointer, inline_name follows
struct qstr, i.e. u64 + pointer.  How about we add struct inlined_name {
unsigned char name[DNAME_INLINE_LEN];}; and turn d_iname and inline_name
into anon unions with that?  Hell, might even make it an array of unsigned
long and use that to deal with this
                } else {
                        /*
                         * Both are internal.
                         */
                        unsigned int i;
                        BUILD_BUG_ON(!IS_ALIGNED(DNAME_INLINE_LEN, sizeof(long)));
                        for (i = 0; i < DNAME_INLINE_LEN / sizeof(long); i++) {
                                swap(((long *) &dentry->d_iname)[i],
                                     ((long *) &target->d_iname)[i]);
                        }
                }
in swap_names().  With struct assignment in the corresponding case in
copy_name() and in take_dentry_name_snapshot() - that does generate sane
code...

