Return-Path: <linux-fsdevel+bounces-16173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D4E899B78
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 13:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0253E1C2269F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 11:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6660A16ABFB;
	Fri,  5 Apr 2024 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DwFAuCt+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC7114F9D3;
	Fri,  5 Apr 2024 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314834; cv=none; b=qoc86RboIDKXOHzuFMIf7FC7JXN0zJOVsL54pl0mNBKGmSiphjMl2JK+njYUkDnHqSi7JeJ36MiHOaJ/U0Vb4HmgjCJv0cexJ+64/6Xvkxn2+3Mvw7jkLjq8VJ6m//ujADzD73t1j0uhbcXfcJFSqy3+jucU2Kziy0o2pKsNQtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314834; c=relaxed/simple;
	bh=eF7jpAy9GZ0Ge1VvTyCGRDBc6FYW1+QuIeeIvyaf4oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HoMgxKArEek+15Bid30pHDTG0ip49O8NjVM8vqwCM+hWQ7q/MD5QSoNPDQ4cP9noUcNfZlrhh/TGEV8cWlfQMgPBMreDFagEtexqfJ7UVtxTk/ULPOF26IfMnK1T/pEgJfPM+4sDLOsSS5PAWQNvuoEU/gOkLa7xU9VuFVQO3uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DwFAuCt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F99C433F1;
	Fri,  5 Apr 2024 11:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712314834;
	bh=eF7jpAy9GZ0Ge1VvTyCGRDBc6FYW1+QuIeeIvyaf4oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DwFAuCt+iEP71XmRAgqy8ngUebB6TZI9aukv4b/AnfdWB6M3YV1ahHS9wjayIl5Bm
	 8SUgIxb/xxItUN0/XfTc+ZzgjJmtG9Hg8bn4kSThQwaHfcBouhX6SzCqRIF2Vw10S8
	 EB18K2uXGKECrTF1DSM680aLqiI1mdNDKz/LzR1vYaAQY34aS9smMTAZm5yAZlgLb4
	 TZ+lQOatJYIkWHwhIlXnM2y4P3Y7Ke5sMhwM8hLXGOoLomSsWUQOiJ0z8ZER09uHe8
	 PnYvwEwORJ/tyhKCyutAhvSzPSHMXBDirMW2h/nBKkj9l2gBYIXpWc3sSJr5AqNHba
	 t6ZU5pNHlrUsw==
Date: Fri, 5 Apr 2024 13:00:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Kees Cook <keescook@chromium.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Set file_handle::handle_bytes before referencing
 file_handle::f_handle
Message-ID: <20240405-imponieren-scheppern-5e6b6842ccbf@brauner>
References: <20240403215358.work.365-kees@kernel.org>
 <20240404091900.woh6y2a52o7uo5vx@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240404091900.woh6y2a52o7uo5vx@quack3>

On Thu, Apr 04, 2024 at 11:19:00AM +0200, Jan Kara wrote:
> On Wed 03-04-24 14:54:03, Kees Cook wrote:
> > With adding __counted_by(handle_bytes) to struct file_handle, we need
> > to explicitly set it in the one place it wasn't yet happening prior to
> > accessing the flex array "f_handle".
> > 
> > Fixes: 1b43c4629756 ("fs: Annotate struct file_handle with __counted_by() and use struct_size()")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> OK, so this isn't really a functional bug AFAIU but the compiler will
> wrongly complain we are accessing handle->f_handle beyond claimed array
> size (because handle->handle_bytes == 0 at that point). Am I right? If

And really, this also needs to please be mentioned in the commit message
because from reading the commit message I'm not even sure what this
patch is trying to fix.

