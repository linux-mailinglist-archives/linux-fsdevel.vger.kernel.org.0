Return-Path: <linux-fsdevel+bounces-22766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A574491BE6C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 14:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D65111C234E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 12:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B057158862;
	Fri, 28 Jun 2024 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1vPWRJV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB991411EE;
	Fri, 28 Jun 2024 12:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719577422; cv=none; b=OcIE7l4BeVBDxW7dzlemHlozta4h1W+IUfdGm9J+iaF3LZifoueAfFzx4pZO6KhjOEHclrqYm88UL6qGH4FdlUj8tF38yX5bAeDLZ649di5694YXHqROsicWHDtiv/Id758UTjjPyRDMq1iGne0RyIGmCIpPhPOhfn+/IJlThaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719577422; c=relaxed/simple;
	bh=tyZqFLkUX46EtxQxpgFqQIPv61XudWLgX6qkok5gyLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGps9e+GQmXbLKCw29H/SZGJL5UWxPySGJmpHmUtuybM02efmTimxd6s2WgfWUzXIsbPGYRs3dJYNRi8hOSPb29felsCNL3QGWtM3HzA5/10F5GpgZY7yaeEyQyRTwNghek1+DcPNIIIMEFtkbKgjfEa7oAhrialvgZVcuM7XKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1vPWRJV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6B7C116B1;
	Fri, 28 Jun 2024 12:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719577421;
	bh=tyZqFLkUX46EtxQxpgFqQIPv61XudWLgX6qkok5gyLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I1vPWRJVMasvY4mSgOwL+L4R0Z01LXE3UFK7pYsVqQdVi4imj1q5a28q9BufwvqyD
	 pCGoelb66a/S5uh8EhKjanRQDQAx6QLWSnS8KqeGrxE2yi5WeWgeThSzaKLvt7h4TN
	 L5RQ7niVHIME7q0U2JSDXX6gtjGaHVAF7EBxt6NyS5W2e+49h33y7ryT2nRhbJDwIJ
	 1yggZDk953f2jU5O5oNWJQGkZROQETcf+b2Zql9WKFLFAWoq/Mo37IYBvIhGuR8Ppi
	 s5qpC69mAlvQCTXJxNgmDvZMM/9uE92gt+RIMJLAUihUgpq6OB0ccf8aSDgFW9OQDl
	 TSN2daGuoqk3A==
Date: Fri, 28 Jun 2024 14:23:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org, 
	autofs@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-efi@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>, linux-ext4@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-mm@kvack.org, ntfs3@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Hans Caniullan <hcaniull@redhat.com>
Subject: Re: [PATCH 01/14] fs_parse: add uid & gid option option parsing
 helpers
Message-ID: <20240628-fernfahrt-missverstanden-01543e7492b4@brauner>
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
 <de859d0a-feb9-473d-a5e2-c195a3d47abb@redhat.com>
 <20240628094517.ifs4bp73nlggsnxz@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240628094517.ifs4bp73nlggsnxz@quack3>

On Fri, Jun 28, 2024 at 11:45:17AM GMT, Jan Kara wrote:
> On Thu 27-06-24 19:26:24, Eric Sandeen wrote:
> > Multiple filesystems take uid and gid as options, and the code to
> > create the ID from an integer and validate it is standard boilerplate
> > that can be moved into common helper functions, so do that for
> > consistency and less cut&paste.
> > 
> > This also helps avoid the buggy pattern noted by Seth Jenkins at
> > https://lore.kernel.org/lkml/CALxfFW4BXhEwxR0Q5LSkg-8Vb4r2MONKCcUCVioehXQKr35eHg@mail.gmail.com/
> > because uid/gid parsing will fail before any assignment in most
> > filesystems.
> > 
> > Signed-off-by: Eric Sandeen <sandeen@sandeen.net>
> 
> I like the idea since this seems like a nobrainer but is actually
> surprisingly subtle...
> 
> > diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> > index a4d6ca0b8971..24727ec34e5a 100644
> > --- a/fs/fs_parser.c
> > +++ b/fs/fs_parser.c
> > @@ -308,6 +308,40 @@ int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
> >  }
> >  EXPORT_SYMBOL(fs_param_is_fd);
> >  
> > +int fs_param_is_uid(struct p_log *log, const struct fs_parameter_spec *p,
> > +		    struct fs_parameter *param, struct fs_parse_result *result)
> > +{
> > +	kuid_t uid;
> > +
> > +	if (fs_param_is_u32(log, p, param, result) != 0)
> > +		return fs_param_bad_value(log, param);
> > +
> > +	uid = make_kuid(current_user_ns(), result->uint_32);
> 
> But here is the problem: Filesystems mountable in user namespaces need to use
> fc->user_ns for resolving uids / gids (e.g. like fuse_parse_param()).
> Having helpers that work for some filesystems and are subtly broken for
> others is worse than no helpers... Or am I missing something?
> 
> And the problem with fc->user_ns is that currently __fs_parse() does not
> get fs_context as an argument... So that will need some larger work.

Not really. If someone does an fsopen() in a namespace but the process
that actually sets mount options is in another namespace then it's
completely intransparent what uid/gid this will resolve to if it's
resovled according to fsopen().

It's also a bit strange if someone ends up handing off a tmpfs fscontext
that was created in the initial namespace to some random namespace and
they now can set uid/gid options that aren't mapped according to their
namespace but instead are 1:1 resolved according to the intial
namespace. So this would hinder delegation.

The expectation is that uid/gid options are resolved in the caller's
namespace and that shouldn't be any different for fscontexts for
namespace mountable filesystems. The crucial point is to ensure that the
resulting kuid/kgid can be resolved in the namespace the filesystem is
mounted in at the end. That's what was lacking in e.g., tmpfs in commit
0200679fc795 ("tmpfs: verify {g,u}id mount options correctly")

The fuse conversion is the only inconsistency in that regard.

