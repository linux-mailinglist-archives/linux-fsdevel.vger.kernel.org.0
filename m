Return-Path: <linux-fsdevel+bounces-73925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB5AD24C59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 14:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C941302B13C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 13:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E824E3A0E84;
	Thu, 15 Jan 2026 13:38:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1245B20C029;
	Thu, 15 Jan 2026 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768484309; cv=none; b=NRBdqrHGeF+1DYmQx7r+YUz6M4T83swzF6TeLJujgmigTXTpxaE2JtqgmPiFXL7AUEqVQEMfSAMvYYQjbKRX5kDgBZ3fyUpKlArZIWlFZn5zQxhid06bYWJQnZoX1vnDHUHRFccJMI8MYKdK07HTnk25pjVhQOvvOb5kVTePagU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768484309; c=relaxed/simple;
	bh=q3NAWJ07/6y+gOMssR9e3T5Wh9anZdBM7o4HUlQUtag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQPlptMcuWfvqUqxjFavjfW4IrDG+PSjX2DanUr2FA7UN2T88vEiV4zZShDDRNSXeppowkQ72L77UluyH32kJhwuMHKBMG+RUkShELKM3i261H5HOsV2v9Gbd9ZSh9A/0e8KGLwtqts8Dcc4ig+QTEI3d3Ct5MOot0BDzOgEEDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp06-ext.udag.de (Postfix) with ESMTPA id 7822FE0585;
	Thu, 15 Jan 2026 14:38:25 +0100 (CET)
Authentication-Results: smtp06-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Thu, 15 Jan 2026 14:38:24 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH v4 3/3] fuse: add an implementation of open+getattr
Message-ID: <aWjteRMwc_KIN4pt@fedora.fritz.box>
References: <20260109-fuse-compounds-upstream-v4-0-0d3b82a4666f@ddn.com>
 <20260109-fuse-compounds-upstream-v4-3-0d3b82a4666f@ddn.com>
 <CAJnrk1ZtS4VfYo03UFO_khcaA6ugHiwtWQqaObB5P_ozFtsCHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZtS4VfYo03UFO_khcaA6ugHiwtWQqaObB5P_ozFtsCHA@mail.gmail.com>

On Wed, Jan 14, 2026 at 06:29:26PM -0800, Joanne Koong wrote:
> On Fri, Jan 9, 2026 at 10:27 AM Horst Birthelmer <horst@birthelmer.com> wrote:
> >
> > +
> > +       err = fuse_compound_send(compound);
> > +       if (err)
> > +               goto out;
> > +
> > +       err = fuse_compound_get_error(compound, 0);
> > +       if (err)
> > +               goto out;
> > +
> > +       err = fuse_compound_get_error(compound, 1);
> > +       if (err)
> > +               goto out;
> 
> Hmm, if the open succeeds but the getattr fails, why not process it
> kernel-side as a success for the open? Especially since on the server
> side, libfuse will disassemble the compound request into separate
> ones, so the server has no idea the open is even part of a compound.
> 
> I haven't looked at the rest of the patch yet but this caught my
> attention when i was looking at how fuse_compound_get_error() gets
> used.
>
After looking at this again ...
Do you think it would make sense to add an example of lookup+create, or would that just convolute things?
 
> Thanks,
> Joanne
> 

Thanks,
Horst

