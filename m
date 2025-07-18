Return-Path: <linux-fsdevel+bounces-55441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2384B0A7E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 17:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1AB1887E62
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jul 2025 15:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EC82E54C7;
	Fri, 18 Jul 2025 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UA68D/B7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AAD2AF07
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jul 2025 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752853689; cv=none; b=s5janx6rpavqqyUSiUkLTGWeKjn5VEVgQk1eVPbaCwLmMiblBL0mwzHVJYwm91b6st5w7FTYP0cZMMmNE/20EHKtHiareGiropEfWwE5+mL2hRdOTQkRN9njgwrFmZ05fWg9L2p6vbOUlRxI3EdpNz/ypogWtbS0RvdpTDT0nVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752853689; c=relaxed/simple;
	bh=586d4JSE2ZJSLr4fGK3f9fKNJ6cBSxAIOvVFcnBZMXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLMBLAtsiE/UQwJCY3f2eiA9qW9L9rQ9BX71B4D8ltH8dyUq71Lwnh3Iel3YEXhlXB5er4uQgzk6HQCapgHQ2httB8ewqPEW3NYCbVSMgjs5DPFZmyZ7NoKmENkD1m56ek9YbC9LtBw6vpKl51+EmghVf6cDP0KU3BaGmOShiyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UA68D/B7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EAAC4CEEB;
	Fri, 18 Jul 2025 15:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752853688;
	bh=586d4JSE2ZJSLr4fGK3f9fKNJ6cBSxAIOvVFcnBZMXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UA68D/B7ycjfsCnDF6euGzhP4L85zU3QJ3vumKBC+Ndg0BljsSuGrvVcDMMqCffLa
	 X0ZMv2yzfT6pkmW2blU6OLKev4w/DKuADVsCrt08xF/e5oT/8bnjNBDVyz9eH8VyIQ
	 f7iHeEFcs/OfCXQHkaO5qCdV4xeCafm0Pp8BeQtmUesYEsDnL4Qa/RfiOdXZUpuz8s
	 LrVU0NK7352AXBckxnjIERYRPOdvTvozvPQgYqN9YAovebyG5J5UbwLxIQebH62FWq
	 BirrltmjmpJ6FzIot/kcAvqYQspqxsPjNMn8k4fhRmVKAnEnwDnpgt4cwwvbW4nUiR
	 /TqadrbdQb1dg==
Date: Fri, 18 Jul 2025 08:48:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: bschubert@ddn.com, John@groves.net, joannelkoong@gmail.com,
	linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, neal@gompa.dev,
	miklos@szeredi.hu
Subject: Re: [PATCH 07/14] libfuse: add a reply function to send FUSE_ATTR_*
 to the kernel
Message-ID: <20250718154808.GR2672029@frogsfrogsfrogs>
References: <175279459673.714161.10658209239262310420.stgit@frogsfrogsfrogs>
 <175279459857.714161.8213814053864249949.stgit@frogsfrogsfrogs>
 <CAOQ4uxjM6A1DpB+r+J6NU3Zj7zhGmh4138RFS8c3T6hL067fcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjM6A1DpB+r+J6NU3Zj7zhGmh4138RFS8c3T6hL067fcQ@mail.gmail.com>

On Fri, Jul 18, 2025 at 04:10:18PM +0200, Amir Goldstein wrote:
> On Fri, Jul 18, 2025 at 1:36 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > Create new fuse_reply_{attr,create,entry}_iflags functions so that we
> > can send FUSE_ATTR_* flags to the kernel when instantiating an inode.
> > Servers are expected to send FUSE_IFLAG_* values, which will be
> > translated into what the kernel can understand.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  include/fuse_common.h   |    3 ++
> >  include/fuse_lowlevel.h |   87 +++++++++++++++++++++++++++++++++++++++++++++--
> >  lib/fuse_lowlevel.c     |   69 ++++++++++++++++++++++++++++++-------
> >  lib/fuse_versionscript  |    4 ++
> >  4 files changed, 146 insertions(+), 17 deletions(-)

<snip for brevity>

> > diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> > index d26043fa54c036..568db13502a7d7 100644
> > --- a/lib/fuse_lowlevel.c
> > +++ b/lib/fuse_lowlevel.c
> > @@ -545,7 +573,22 @@ int fuse_reply_attr(fuse_req_t req, const struct stat *attr,
> >         memset(&arg, 0, sizeof(arg));
> >         arg.attr_valid = calc_timeout_sec(attr_timeout);
> >         arg.attr_valid_nsec = calc_timeout_nsec(attr_timeout);
> > -       convert_stat(attr, &arg.attr);
> > +       convert_stat(attr, &arg.attr, 0);
> > +
> > +       return send_reply_ok(req, &arg, size);
> > +}
> > +
> > +int fuse_reply_attr_iflags(fuse_req_t req, const struct stat *attr,
> > +                          unsigned int iflags, double attr_timeout)
> > +{
> > +       struct fuse_attr_out arg;
> > +       size_t size = req->se->conn.proto_minor < 9 ?
> > +               FUSE_COMPAT_ATTR_OUT_SIZE : sizeof(arg);
> > +
> > +       memset(&arg, 0, sizeof(arg));
> > +       arg.attr_valid = calc_timeout_sec(attr_timeout);
> > +       arg.attr_valid_nsec = calc_timeout_nsec(attr_timeout);
> > +       convert_stat(attr, &arg.attr, iflags);
> >
> >         return send_reply_ok(req, &arg, size);
> >  }
> 
> I wonder why fuse_reply_attr() is not implemented as a wrapper to
> fuse_reply_attr_iflags()?

oops.  I meant to convert this one, and apparently forgot. :(

> FWIW, the flags field was added in minor version 23 for
> FUSE_ATTR_SUBMOUNT, but I guess that doesn't matter here.

<nod> Hopefully nobody will call fuse_reply_attr_iflags when
proto_minor < 23.  Do I need to check for that explicitly in libfuse and
zero out iflags?  Or is it safe enough to assume that the os kernel
ignores flags bits that it doesn't understand and/or are not enabled on
the fuse_mount?

(I'm not sure if the lowlevel fuse library exists on mac/bsdfuse, though
afaict they ship the same source code so ... probably?)

Also: how aggressively do the syzbot people go after /dev/fuse?

--D

> Thanks,
> Amir.
> 

