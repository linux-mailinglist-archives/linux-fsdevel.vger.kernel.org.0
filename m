Return-Path: <linux-fsdevel+bounces-32618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 633FB9AB786
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 22:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248F1284C12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 20:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05001CC14A;
	Tue, 22 Oct 2024 20:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="bZdmtKFp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37731A0BE0;
	Tue, 22 Oct 2024 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729628085; cv=none; b=HkxE+zJJ/QeM5li3K4CThJj+9JRVLk8FtavLGiaJ0K2lOAtyPeTMHl1aMtaz+JFE0bT6njmzB24HolrE6JaMtpCoXtCQT3mfOaHKqMLoiZj3cd/jDFcJC0gMp2AQZo9xcriW3i+rK18a7nKjszQMuRdF9jVEF/HZg72hYk41cjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729628085; c=relaxed/simple;
	bh=lV24AC0FIG+csJXLH/boGRNRTV8cTQO3c0cmYWdKs4g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=c7Qvd3/2xwlk4DXhKlKjAj0mhAVG4iHCuOZjKwD8uckk+nf7xBeMREllBdwFBbExdjR9otGF7vN/4uVxzVUEPcMv1/3gUOpk/mSb26R3MUjoV2E9XUEHgle5Vlt7eWhpHuJ/klTtym+Qn6JL4hHKiidp3l59z0xkZ9k3rh30Ykg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=bZdmtKFp; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JHiAfXulihULHCp2AWMygN+UygM9REk829usCvefi7o=;
  b=bZdmtKFpqWye9BjdbJPqTBSVryF4Dvv5SdXWyLHYb+XjNrGnSE32AotR
   DSq+qASk2fD2S8A85blGVSNKZJzEi4JURF8jkbd9UaqS3Vo9vXZ0r3Mtj
   iF4nURoBbnxUt6HvpHPTgsLsmAunuBunMM5QYr9GaDUt7GOmDTPKxmr3g
   w=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,223,1725314400"; 
   d="scan'208";a="99781479"
Received: from syn-071-095-008-132.biz.spectrum.com (HELO hadrien) ([71.95.8.132])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 22:13:28 +0200
Date: Tue, 22 Oct 2024 13:13:25 -0700 (PDT)
From: Julia Lawall <julia.lawall@inria.fr>
To: Joel Granados <joel.granados@kernel.org>
cc: Luis Chamberlain <mcgrof@kernel.org>, kernel-janitors@vger.kernel.org, 
    Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/35] sysctl: Reorganize kerneldoc parameter names
In-Reply-To: <nnbmui2ix23wjmfvxo2t3zd3tgymk77h765kyoc3pxu6wkhqxx@6qis4yyszkec>
Message-ID: <e6f7d5e-6f7e-ed6-a54a-2a5fd87b3d7f@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr> <20240930112121.95324-10-Julia.Lawall@inria.fr> <nnbmui2ix23wjmfvxo2t3zd3tgymk77h765kyoc3pxu6wkhqxx@6qis4yyszkec>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 22 Oct 2024, Joel Granados wrote:

> On Mon, Sep 30, 2024 at 01:20:55PM +0200, Julia Lawall wrote:
> > Reorganize kerneldoc parameter names to match the parameter
> > order in the function header.
> >
> > Problems identified using Coccinelle.
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> >
> > ---
> >  kernel/sysctl.c |    1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > index 79e6cb1d5c48..5c9202cb8f59 100644
> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -1305,7 +1305,6 @@ int proc_dointvec_userhz_jiffies(const struct ctl_table *table, int write,
> >   * @write: %TRUE if this is a write to the sysctl file
> >   * @buffer: the user buffer
> >   * @lenp: the size of the user buffer
> > - * @ppos: file position
> >   * @ppos: the current position in the file
> >   *
> >   * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
> >
> This looks good to me. Is it going to go into main line together with
> the other 35 or should I take this one through sysctl subsystem?

Please take it,

julia

>
> Best
>
> Signed-off-by: Joel Granados <joel.granados@kernel.com>
>
> --
>
> Joel Granados
>

