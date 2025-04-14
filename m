Return-Path: <linux-fsdevel+bounces-46368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE4DA8811B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 15:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD2E7178B7D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 13:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669CA2BD5AB;
	Mon, 14 Apr 2025 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrMuFagc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE00346447;
	Mon, 14 Apr 2025 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744635874; cv=none; b=cF6Vx60sKV0NrlmwT5ko3CaCBl/kNk2MNYxu4F1zoiq6ohSwdRDnDucQtHX4jz+WVqsbnVLYJzcydX+SbKURTtvV54Y4diYOZl0S1WIyJK/++fGNxXrs9c8GN6VnZLBsWS/i+x0sAh1E+UiWCSAUi/hOud3o0vYWmwI82Ba5igI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744635874; c=relaxed/simple;
	bh=DltCmKURT/oevjkv1Fc7z4BFzx6wkjwe/xZEG7naEx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TjGFa+tWaZzISPlHApvggmHyElWvjyiTAytnEMUQ++AmiqvycURpXyEkfIlrl7I+idXSuHjL/DLpm3nmaneRG+yGTzzEvDcJ392Nu2/Vdh5MgarDrzAPVVWCl0U25k9lQF3WWFyRbqEG21eRkf+hjD+ZE2TgUsb833DIpwIQWEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrMuFagc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51FA6C4CEE2;
	Mon, 14 Apr 2025 13:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744635874;
	bh=DltCmKURT/oevjkv1Fc7z4BFzx6wkjwe/xZEG7naEx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BrMuFagcPhBKMnp4fB0T2XlcfwdoFT8VZhLsY6aVco18qsG8j2fmaFeYCbGLtzNPS
	 tuIbeLNRgQ+Y3i8lOpcUjHVfRtg4PFmV8pNRw+akuy6Z9242eIUqW1BBJHAfVjq31f
	 4dFg+UTe7DV5GAWA8rKgC8v1bC5j+Q6U3DF/RPg/jdwhK+xxMuITS0dDRc47PhGKQK
	 n7rEnz5YjlKuwvwsflCsGoZLIEZS0qGj/6zjQTNIFB1b/PW+epw1D3aW2KJ4cTLl77
	 tIj3Gn/hCiBmFpg0dVAKfIZf+Vg9PFqOaDTRNlPIN3bgGJcpQMwuyII+wxvEV8j4p5
	 52Zucse/YantA==
Date: Mon, 14 Apr 2025 15:04:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Luca Boccassi <luca.boccassi@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] coredump: fix error handling for replace_fd()
Message-ID: <20250414-vollrausch-adressieren-fe4afc00bacb@brauner>
References: <20250414-work-coredump-v1-0-6caebc807ff4@kernel.org>
 <20250414-work-coredump-v1-2-6caebc807ff4@kernel.org>
 <20250414121156.GA28345@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250414121156.GA28345@redhat.com>

On Mon, Apr 14, 2025 at 02:11:56PM +0200, Oleg Nesterov wrote:
> On 04/14, Christian Brauner wrote:
> >
> > The replace_fd() helper returns the file descriptor number on success
> > and a negative error code on failure. The current error handling in
> > umh_pipe_setup() only works because the file descriptor that is replaced
> > is zero but that's pretty volatile. Explicitly check for a negative
> > error code.
> 
> ...
> 
> > @@ -515,6 +517,9 @@ static int umh_pipe_setup(struct subprocess_info *info, struct cred *new)
> >  
> >  	err = replace_fd(0, files[0], 0);
> >  	fput(files[0]);
> > +	if (err < 0)
> > +		return err;
> > +
> >  	/* and disallow core files too */
> >  	current->signal->rlim[RLIMIT_CORE] = (struct rlimit){1, 1};
> 
> The patch looks trivial and correct, but if we do not want to rely on
> the fact that replace_fd(fd => 0) return 0 on sucess, then this patch
> should also do
> 
> 	-	return err;
> 	+	return 0;
> 
> ?
> 
> otherwise this cleanup looks "incomplete" to me.

Ok, done.

