Return-Path: <linux-fsdevel+bounces-31443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB72996D7D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 16:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278991F21F6B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 14:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2BA19AD71;
	Wed,  9 Oct 2024 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mo5EzMvt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB8224DC
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728483591; cv=none; b=dZydlUi+9UMpXLkAiPcERljpXsyLK1P8mJTKX6XzKs/Kd8mYg9spW3LqvqgXM7hlB2Y8WFf/hOLqfoDDDaSGbdnAFJePdWodBVZymiVUk5O7mGxYDfw3ah74b/vKKdmBatj8yC6YsBOhv16NkHfiB07SfjF9N/huVrkmEUHHTas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728483591; c=relaxed/simple;
	bh=ltBWibkLuRg6zTvpGbKAr+xVaenAR0TAmr27+Jv8Ehs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5nAcdwtuCp4IF3WDO85JyVpahl/R5bd8Zugm4Zp5avU5SEENAs4T6Apx596EZsWJwJ/3Q+mxTpCT8C/WoJKjRdZOhzC86OGRtgX/IinBG8+uBk3g1Bh1ni5DIgZOFNxt6ZL9GDV6SL47uKAC+VY6qxF/srGNA+MVyJD6NXrq64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mo5EzMvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE67C4CEC3;
	Wed,  9 Oct 2024 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728483590;
	bh=ltBWibkLuRg6zTvpGbKAr+xVaenAR0TAmr27+Jv8Ehs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mo5EzMvtZo1EQxGdtRd+70dZDrZx63f6It+QM00xTSKJxN1y9vUURMqOnB0sFDRE2
	 DTcD/K+9qKpYDnZNSuJhAdqngEjNnuKVrTTi3SgVsT42AqrXe341qaEH8U9NwQxsFd
	 wPn2ffCel1g8GY5w4xMkf4z4mQMsc/QGsvbXCfqDrwxDPZGQX87hOVr+Bo23hOlY2D
	 2BYQEdErQCAl/JfYHtK4OBt6uWmgwkfpfSa9peYm82VI/62fJ1ZTB8OPNXJdSSdHPp
	 FnpYt5ecOzGOt4D8evkK6A5EUDulibB7ChHNiNp4lb9ID0jDZ59TJOixm28zFHJQBQ
	 4Llpu/MXIdqdA==
Date: Wed, 9 Oct 2024 16:19:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: Steven Price <steven.price@arm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH v3 10/11] make __set_open_fd() set cloexec state as well
Message-ID: <20241009-unsachlich-otter-d17f60a780ba@brauner>
References: <20241007173912.GR4017910@ZenIV>
 <20241007174358.396114-1-viro@zeniv.linux.org.uk>
 <20241007174358.396114-10-viro@zeniv.linux.org.uk>
 <f042b2db-df1f-4dcb-8eab-44583d0da0f6@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f042b2db-df1f-4dcb-8eab-44583d0da0f6@arm.com>

On Wed, Oct 09, 2024 at 11:50:36AM GMT, Steven Price wrote:
> On 07/10/2024 18:43, Al Viro wrote:
> > ->close_on_exec[] state is maintained only for opened descriptors;
> > as the result, anything that marks a descriptor opened has to
> > set its cloexec state explicitly.
> > 
> > As the result, all calls of __set_open_fd() are followed by
> > __set_close_on_exec(); might as well fold it into __set_open_fd()
> > so that cloexec state is defined as soon as the descriptor is
> > marked opened.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >  fs/file.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/file.c b/fs/file.c
> > index d8fccd4796a9..b63294ed85ec 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -248,12 +248,13 @@ static inline void __set_close_on_exec(unsigned int fd, struct fdtable *fdt,
> >  	}
> >  }
> >  
> > -static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt)
> > +static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt, bool set)
> >  {
> >  	__set_bit(fd, fdt->open_fds);
> >  	fd /= BITS_PER_LONG;
> 
> Here fd is being modified...
> 
> >  	if (!~fdt->open_fds[fd])
> >  		__set_bit(fd, fdt->full_fds_bits);
> > +	__set_close_on_exec(fd, fdt, set);
> 
> ... which means fd here isn't the same as the passed in value. So this
> call to __set_close_on_exec affects a different fd to the expected one.

Good spot. Al, I folded the below fix so from my end you don't have to
do anything unless you want to nitpick how to fix it. Local variable
looked ugly to me.

Pushed and running through tests now.

diff --git a/fs/file.c b/fs/file.c
index c039e21c1cd1..52654415f17e 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -354,12 +354,17 @@ static inline void __set_close_on_exec(unsigned int fd, struct fdtable *fdt,
        }
 }

-static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt, bool set)
+static inline void __set_open(unsigned int fd, struct fdtable *fdt, bool set)
 {
        __set_bit(fd, fdt->open_fds);
        fd /= BITS_PER_LONG;
        if (!~fdt->open_fds[fd])
                __set_bit(fd, fdt->full_fds_bits);
+}
+
+static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt, bool set)
+{
+       __set_open(fd, fdt, set);
        __set_close_on_exec(fd, fdt, set);
 }

