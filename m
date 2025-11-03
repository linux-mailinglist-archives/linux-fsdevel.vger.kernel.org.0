Return-Path: <linux-fsdevel+bounces-66710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EDFC2A091
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 05:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 724824EA6C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 04:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A346502BE;
	Mon,  3 Nov 2025 04:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AkFiOWiu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C61E33F3;
	Mon,  3 Nov 2025 04:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762145158; cv=none; b=kF7TmWvrv+Nve57MCZhILCDlWZuYTfzPReRnv+B3lc6VphdtNGRt70z7Ldlhl6w4fJd1QUOF6RGikYXuaVu/B5RbvWQ+SesnvDgUmbWZUQoPvN8GjdPn7ZeL6vEBNU7W0TuKY1rrmj0j9uhNFigkpKS2BvjPYxuuowFqbcxtLZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762145158; c=relaxed/simple;
	bh=BrxaAHcqR6T+eaK3F6c+swlP1+unyURDr55nnhidFjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkSIxfwgWI4JOtkm6R/IxdQyEBeVbm9Vds0IR+2X/IB6pnw3wp7PU7xg/wR/1/aUu//SeGX2hDBUGIFf4bXG6p95OUGQ7Sqg9t3lf1KxIEnHxzALPkH+NDJ2iJ3X6V0M2oetYL4iUuU6SpskR7CT7q7jKEU7bPVPt/qrJGr+65M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AkFiOWiu; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QUADFDv4ActFiyAXojXkc92OQd6pHGgvzY2aMQ+ZVog=; b=AkFiOWiuzdC8mCCG8B0qm6JAFi
	+1QKLyrd/jpq218sDy/4XpLbKTdrFojieSFpi3nEn7gk8QEBoDCWi+GCWmhv/rZSKWptvDkxCl+c4
	zrzhrXHd4OD9mKuu25cRrXM5ia/AmacVGeQmSApr83vLjQuzLIK3uYK8rMziibPHp2NUe2e3CWmT8
	LD3TL3Ed8ezN47RqPeBPxapLszeUnh7utU5OAfR7x0+KnDG1JAIC3tNrYMXaTksGC0/+GFiIwdpLL
	r6JKY7+qwptASQw8h4bC+EbqcBibKrxWMtcMQ74QSCK6M7QOKilUcruMtPUtMDNPwhAhGaF0HCnpQ
	F/kPrtlg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFmS1-0000000GFqL-1Ym8;
	Mon, 03 Nov 2025 04:45:53 +0000
Date: Mon, 3 Nov 2025 04:45:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: touch up predicts in putname()
Message-ID: <20251103044553.GF2441659@ZenIV>
References: <20251029134952.658450-1-mjguzik@gmail.com>
 <20251031201753.GD2441659@ZenIV>
 <20251101060556.GA1235503@ZenIV>
 <CAGudoHHno74hGjwu7rryrS4x2q2W8=SwMwT9Lohjr4mBbAg+LA@mail.gmail.com>
 <20251102061443.GE2441659@ZenIV>
 <CAGudoHFDAPEYoC8RAPuPVkcsHsgpdJtQh91=8wRgMAozJyYf2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHFDAPEYoC8RAPuPVkcsHsgpdJtQh91=8wRgMAozJyYf2w@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Nov 02, 2025 at 11:42:03PM +0100, Mateusz Guzik wrote:

> Even ignoring the fact that there is a refcount and people may be
> inclined to refname(name) + take_filename(name), the following already
> breaks:

Er...  refname() doesn't need to be seen for anyone other than auditsc.c
and core part of filename handling in fs/namei.c (I'd like to move it
to fs/filename.c someday)...

> foo() {
>     name = getname(...);
>     if (!IS_ERR_OR_NULL(name))
>         bar(name);
>     putname(name);
> }
> 
> bar(struct filename *name)
> {
>     baz(take_filename(&name));
> }
> 
> While the code as proposed in the branch does not do it, it is a
> matter of time before something which can be distilled to the above
> shows up.

Breaks in which case, exactly?  If baz() consumes its argument, we are
fine, if it does we have a leak...

I agree that 'take_filename' is inviting wrong connotations, though.

Hell knows - it might be worth thinking of that as claiming ownership.
Or, perhaps, transformation of the original object, if we separate
the notion of 'active filename' (absolutely tied to one thread, not
allowed to be reachable from any data structures shared with other
threads, etc.) from 'embryonic filename' (no refcounting whatsoever,
no copying of references, etc., consumed on transformation into
'active filename').  Then getname_alien() would create an embryo,
to be consumed before doing actual work.  That could be expressed
in C type system...  Need to think about that.

One possibility would be something like

struct alien_filename {
	struct filename *__dont_touch_that;
};

int getname_alien(struct alien_filename *v, const char __user *string)
{
	struct filename *res;
	if (WARN_ON(v->__dont_touch_that))
		return -EINVAL;
	res = getname_flags(string, GETNAME_NOAUDIT);
	if (IS_ERR(res))
		return PTR_ERR(res);
	v->__done_touch_that = res;
	return 0;
}

void destroy_alien_filename(struct alient_filename *v)
{
	putname(no_free_ptr(v->__dont_touch_that));
}

struct filename *claim_filename(struct alien_filename *v)
{
	struct filename *res = no_free_ptr(v->__dont_touch_that);
	if (!IS_ERR(res))
		audit_getname(res);
	return res;
}

and e.g.

struct io_rename {
        struct file                     *file;
	int                             old_dfd;
	int                             new_dfd;
	struct alien_filename           oldpath;
	struct alien_filename           newpath;
	int                             flags;
};

...
	err = getname_alien(&ren->oldpath);
	if (unlikely(err))
		return err;
	err = getname_alien(&ren->newpath);
	if (unlikely(err)) {
		destroy_alien_filename(&ren->oldpath);
		return err;
	}

...
	/* note that do_renameat2() consumes filename references */
        ret = do_renameat2(ren->old_dfd, claim_filename(&ren->oldpath),
			   ren->new_dfd, claim_filename(&ren->newpath),
			   ren->flags);
...

void io_renameat_cleanup(struct io_kiocb *req)
{
        struct io_rename *ren = io_kiocb_to_cmd(req, struct io_rename);
	 
	destroy_alien_filename(&ren->oldpath);
	destroy_alien_filename(&ren->newpath);
}

Might work...  Anyone found adding any instances of __dont_touch_that anywhere in
the kernel would be obviously doing something fishy (and if they are playing silly
buggers with obfuscating that, s/doing something fishy/malicious/), so C typechecking
+ git grep once in a while should suffice for safety.

