Return-Path: <linux-fsdevel+bounces-72598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9370CCFCC16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 10:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 327BD30373A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 09:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27F02F5485;
	Wed,  7 Jan 2026 09:11:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp04-ext3.udag.de (smtp04-ext3.udag.de [62.146.106.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06DC78F59;
	Wed,  7 Jan 2026 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777111; cv=none; b=hw/gwLtdQJXzSs7ZETzsplABwUbtaED88I1Nbh+dzEJAixhM/o/yuXbq/im5bC2W1HkGx3cXbqWvO4Ze2/Gn7BAyLc9e12b73TvBXQ01/xwcowu1MuXDM4XfzqGmqHourgp8LqzOVoei0TlJnTz3yW7lW3XrmuVJTaZSB+PMw50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777111; c=relaxed/simple;
	bh=w2+7gdoIAdhGlURpMQctDeYr+bYNA9O/r0UEdE+qg9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdXQrfU+W3qGvjAvxxcRjysoowKVtxxZGXtrlnFv0x6kC338zkXuu3VQd6GuCp2G5vqifkW9D7376tHiVw1BEzSUyPgb60jhQO4aO+cQ6lpe1lbI31X62fwCoIqRIc/U4Sn5gxcfiIlskfm+0JGq+dAAyV0jKFY6o8Es1QDhG94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (049-102-000-128.ip-addr.inexio.net [128.0.102.49])
	by smtp04-ext3.udag.de (Postfix) with ESMTPA id 6559DE0245;
	Wed,  7 Jan 2026 10:03:54 +0100 (CET)
Authentication-Results: smtp04-ext3.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 7 Jan 2026 10:03:53 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Horst Birthelmer <hbirthelmer@googlemail.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH RFC v2 2/2] fuse: add an implementation of
 open+getattr
Message-ID: <aV4g3dMyVcCzrI5Q@fedora.fritz.box>
References: <20251223-fuse-compounds-upstream-v2-0-0f7b4451c85e@ddn.com>
 <20251223-fuse-compounds-upstream-v2-2-0f7b4451c85e@ddn.com>
 <CAJnrk1bCenZHzPSrdjxzUMY4ekKhtAJ74Dg1QhUs77A1qEDu3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bCenZHzPSrdjxzUMY4ekKhtAJ74Dg1QhUs77A1qEDu3A@mail.gmail.com>

On Tue, Jan 06, 2026 at 05:46:09PM -0800, Joanne Koong wrote:
> On Tue, Dec 23, 2025 at 2:13 PM Horst Birthelmer
> <hbirthelmer@googlemail.com> wrote:
> >
> > +       open_args.opcode = opcode;
> > +       open_args.nodeid = nodeid;
> > +       open_args.in_numargs = 1;
> > +       open_args.in_args[0].size = sizeof(open_in);
> > +       open_args.in_args[0].value = &open_in;
> > +       open_args.out_numargs = 1;
> > +       open_args.out_args[0].size = sizeof(struct fuse_open_out);
> > +       open_args.out_args[0].value = outopenp;
> > +
> > +       err = fuse_compound_add(compound, &open_args);
> > +       if (err)
> > +               goto out;
> > +
> > +       /* Add GETATTR */
> > +       getattr_args.opcode = FUSE_GETATTR;
> > +       getattr_args.nodeid = nodeid;
> > +       getattr_args.in_numargs = 1;
> > +       getattr_args.in_args[0].size = sizeof(getattr_in);
> > +       getattr_args.in_args[0].value = &getattr_in;
> > +       getattr_args.out_numargs = 1;
> > +       getattr_args.out_args[0].size = sizeof(struct fuse_attr_out);
> > +       getattr_args.out_args[0].value = outattrp;
> 
> I think things end up looking cleaner here (and above for the open
> args) if the arg initialization logic gets abstracted into helper
> functions, as fuse_do_getattr() and fuse_send_open() have pretty much
> the exact same logic.
> 
> Thanks,
> Joanne
> 
You are completely right.
Will change that in the next version,

Thanks,
Horst

