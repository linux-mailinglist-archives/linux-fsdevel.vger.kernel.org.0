Return-Path: <linux-fsdevel+bounces-31856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C89FB99C2F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 10:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D85B282C35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 08:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F39D154BE2;
	Mon, 14 Oct 2024 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npnaQRNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB480154439;
	Mon, 14 Oct 2024 08:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894033; cv=none; b=J3dBRnSFRSbpOWMvaxMnbpwIQ2UsogA7nBB8FgAS+WMgzIGiEwW7Mql2AYWnouyzqNiEX8w7EZysNj9Ozw5KmAvcuMrgXx7K2pyI6lgwYQbLLOuvRcLcTJ+4jy8YcAE5H7lrMtOfVIqy9/cSIov0LPutJmvRn9G9E7sRMXrUWd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894033; c=relaxed/simple;
	bh=PdNpW/6o7UMTz4MQUc4k27K4gNcTxk6VZ61sWOtaUqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPpPaMeqF3qVo2nqeRUKJbHUBHNPYZjcBghErg63ShVx+lTBmutDxWfLXCSqtikH4J7wggAaKrOev5vI4ebG2PQVUg3NrairiVmGU+ZvRWAqlm966fdhhvXLxuIgUollBepUyps8s7Y88pqoXrfR2VQcUYQxzOJuWyNghE9L7E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npnaQRNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10554C4CEC3;
	Mon, 14 Oct 2024 08:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728894033;
	bh=PdNpW/6o7UMTz4MQUc4k27K4gNcTxk6VZ61sWOtaUqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=npnaQRNXMow/G4Vc17OeNq1D2fom35MFYpyg/R0R/WFfW5u+KVrC3D7ccA6sZlzfV
	 4fbwa3D6mR1Ah+jEOrzhlkA4ep7d50DlHSPmih7h2XLw/qn083st/O5Vn9gCfOkDSA
	 o0n03MLtLKNAnCEnb9P99ki+0Q9kgkZ6ZkhbvyfS/gndJ8z2yHc3ITfP2+d3purEBy
	 XwPTMbl9uRZX7jeEON1A6tXihLKHhQASD+F1g7BRn5DGGyaT8/6fdsX++YcAw6lNgf
	 gH6/3u1bfCURLyFEvjmxEEUGznkop9nWJqnJS+xgXbAXZD3gxhFF4qIWYiJ6d1+52O
	 pfXA5QqG97swQ==
Date: Mon, 14 Oct 2024 10:20:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/4] fs: add helper to use mount option as path or
 fd
Message-ID: <20241014-hergibt-leidtragend-5ca0874ebe8f@brauner>
References: <20241011-work-overlayfs-v2-0-1b43328c5a31@kernel.org>
 <20241011-work-overlayfs-v2-1-1b43328c5a31@kernel.org>
 <CAOQ4uxgGiXN-X1KbZZT=pnbhRbUSPNUJscVHn9J=Fii6fZs-cw@mail.gmail.com>
 <CAOQ4uxi2K=RHBCv+f9B5M5=FjWkCOa1U5GKFCm8XVZpXkeP_UA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi2K=RHBCv+f9B5M5=FjWkCOa1U5GKFCm8XVZpXkeP_UA@mail.gmail.com>

On Sat, Oct 12, 2024 at 10:20:04AM +0200, Amir Goldstein wrote:
> On Sat, Oct 12, 2024 at 9:21 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Fri, Oct 11, 2024 at 11:46 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > Allow filesystems to use a mount option either as a
> > > path or a file descriptor.
> > >
> > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> >
> > Looks sane
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >
> > > ---
> > >  fs/fs_parser.c            | 19 +++++++++++++++++++
> > >  include/linux/fs_parser.h |  5 ++++-
> > >  2 files changed, 23 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> > > index 24727ec34e5aa434364e87879cccf9fe1ec19d37..a017415d8d6bc91608ece5d42fa4bea26e47456b 100644
> > > --- a/fs/fs_parser.c
> > > +++ b/fs/fs_parser.c
> > > @@ -308,6 +308,25 @@ int fs_param_is_fd(struct p_log *log, const struct fs_parameter_spec *p,
> > >  }
> > >  EXPORT_SYMBOL(fs_param_is_fd);
> > >
> > > +int fs_param_is_fd_or_path(struct p_log *log, const struct fs_parameter_spec *p,
> > > +                          struct fs_parameter *param,
> > > +                          struct fs_parse_result *result)
> > > +{
> > > +       switch (param->type) {
> > > +       case fs_value_is_string:
> > > +               return fs_param_is_string(log, p, param, result);
> > > +       case fs_value_is_file:
> > > +               result->uint_32 = param->dirfd;
> > > +               if (result->uint_32 <= INT_MAX)
> > > +                       return 0;
> > > +               break;
> > > +       default:
> > > +               break;
> > > +       }
> > > +       return fs_param_bad_value(log, param);
> > > +}
> > > +EXPORT_SYMBOL(fs_param_is_fd_or_path);
> > > +
> 
> I just noticed that it is a little weird that fsparam_is_fd() accepts a numeric
> string while fsparam_is_fd_or_path() does not.
> Not to mention that fsparam_is_fd_or_path does not accept type filename.
> 
> Obviously a helper name fs_param_is_file_or_string() wouldn't have

Yes, I'll use that. Thanks!

