Return-Path: <linux-fsdevel+bounces-76686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNMwJpN/iWlx+AQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 07:32:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1038810C1DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 07:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9040130073DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 06:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D53428F50F;
	Mon,  9 Feb 2026 06:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FM7d8HgU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49251254B03
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Feb 2026 06:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770618767; cv=none; b=KhuFC+IaalPhI+NsTxQ0Pc9754xwk2lcgcG8NGO61ZEufL7v6RIRjp08O8Cfie7HleSgeoyehAjvN4Q3D0L/rPzegA8HIwbAjfcjsGHxsuZNzHs0gZ/5HczYLskNQ3bgLlbBG94RPLoCgq6HByY4tRPopBBJvVQaFDROk+2wPjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770618767; c=relaxed/simple;
	bh=K820D7yas0VOjLNWuXpKBGh7vXMJNClpZURwOjkw5Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1O40x4fUG1lmCK6y3MOiaRYIRIoNm4QWu6Wh4jBGKC5wkOKOr9UFLxKMzYE/g95L4E9d3BM5m6GOopPCaCHNoinHNA8zuMzA4quTtpfdDgbt5VTFSD/8Ibz64Jwjl5irFgVIO3yaWim4AGenbDOtvssYHaCLPoOdrUJoElVZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FM7d8HgU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ch2G3dOzouRVMPMI7++IlUbRwaigvMLMpGro2QTOfwQ=; b=FM7d8HgUnPKkSIXkSTTxD8EQMs
	BKbOAPyzM7XyTLW93kwlmhaiSwpUzHipEtPEMsdNmo0SR8/zslJ6m9BkmWnrCPqylBR+bv71Cs1vn
	yLYCcfjJI2goA10s5WO5pLIvYXsQV6vPEFlnuZ6EXG8gQQJuNdfqUKqFMCByVvgpXO1/zXqZiiZA3
	cpO7bZ/Vg8JVDGJAvxFQD2sQtBDYJ5iA4KP3e5M9tWUslX0SKNKFWFZrjAkybmbQPjVfLX5d8GpQD
	0NmXa3WVIruBy0OBnqBNDcVDhAgCfLeINaV2eSdy1+1VzRlBXvXSDiHM6ycbadYM2wInzKv6Z99jR
	uYPWKhpg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vpKrG-0000000AbmR-0Wdp;
	Mon, 09 Feb 2026 06:34:54 +0000
Date: Mon, 9 Feb 2026 06:34:54 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <christian@brauner.io>,
	Jan Kara <jack@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
	Werner Almesberger <werner@almesberger.net>
Subject: Re: [RFC] pivot_root(2) races
Message-ID: <20260209063454.GI3183987@ZenIV>
References: <20260209003437.GF3183987@ZenIV>
 <CAHk-=whoVEhWbBJK9SiA0XoUbyurn9gN8O0gUAne88a4gXDLyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whoVEhWbBJK9SiA0XoUbyurn9gN8O0gUAne88a4gXDLyQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76686-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.org.uk:email,linux.org.uk:dkim]
X-Rspamd-Queue-Id: 1038810C1DF
X-Rspamd-Action: no action

On Sun, Feb 08, 2026 at 09:49:40PM -0800, Linus Torvalds wrote:
> On Sun, 8 Feb 2026 at 16:32, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> >         AFAICS, the original rationale had been about the kernel threads
> > that would otherwise keep the old root busy.
> 
> I don't think it was even about just kernel threads, it was about the
> fact that pivot_root was done early, but after other user space things
> could have been started.
> 
> Of course, now it's used much more widely than the original "handle
> initial root switching in user space"
> 
> >         Unfortunately, the way it's been done (all the way since the
> > original posting) is racy.  If pivot_root() is called while another
> > thread is in the middle of fork(), it will not see the fs_struct of
> > the child to be.
> 
> I think that what is much more serious than races is the *non*racy behavior.
> 
> Maybe I'm missing something, but it looks like anybody can just switch
> things around for _other_ namespaces if they have CAP_SYS_ADMIN in
> _their_ namespace. It's just using may_mount()", which i sabout the
> permission to modify the locall namespace.
> 
> I probably am missing something, and just took a very quick look, and
> am missing some check for "only change processes we have permission to
> change".

Not really - look at those check_mnt() in pivot_root(2).
static inline int check_mnt(const struct mount *mnt)
{
        return mnt->mnt_ns == current->nsproxy->mnt_ns;
}

SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
                const char __user *, put_old)
{
	...
        if (!check_mnt(root_mnt) || !check_mnt(new_mnt))
		return -EINVAL;

IOW, try to do that to another namespace and you'll get -EINVAL,
no matter what permissions you might have in your namespace
(or globally, for that matter).

may_mount() check is "if you don't have CAP_SYS_ADMIN in your namespace,
you are not getting anywhere at all"; check_mount() ones - "... and
it would better be your namespace you are about to change"

