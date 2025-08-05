Return-Path: <linux-fsdevel+bounces-56738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFBBB1B2DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 13:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E37622481
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 11:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08DB25C816;
	Tue,  5 Aug 2025 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7rOJmqu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FCA2561D9;
	Tue,  5 Aug 2025 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754394965; cv=none; b=NWGHAmsospnF0Jq2/+JWzATjB9qKuO9VMjwq+IeDI/j0XJxG18O7VKIBiJDGkUexcRtNhpflTZd79a92m0ELwCJDMyewpCfj21JLxlfy3n43QXx+zC1V25VIYOZKLfQY6ncw23itEnr3DLwynLqX9D69c4YwH4sT0KplW1eidKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754394965; c=relaxed/simple;
	bh=mATDsrAm9vzhIGNQjXENcZIQA2buSRv+w6a0YBZLdFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBhgUG3/MwWz4WoZx6XkTmC6ApTsWAFqSlgxx/VOh2eF/+n0X++Klqp78XkUtOOGGtJ/0BI7MnJyfBv5thGl2hEi+/4d58tKuCjlBj9FpnpZDHokeGIim3aA3MzGFZ6q4126M3sqvRfaK4xRIDOy5BLvRqhcskgybgDJFCXjk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7rOJmqu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1A8C4CEF0;
	Tue,  5 Aug 2025 11:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754394964;
	bh=mATDsrAm9vzhIGNQjXENcZIQA2buSRv+w6a0YBZLdFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7rOJmquxX+VUoOIm2qULVSsJX6lzmxMJ/r1v6kCtyySlv9pp43+HEu2Wgm4HuZz3
	 ET/H0YyVBkZZOnpukmQhG/4O4S6zNXBsYSFgUl1zChSj0oU3+xEI7DVoZUb+2gDDk6
	 IYZw3yXG7Hgq4p9dLbPIVw3OFLOvDDlw3qsxru2Iz/Xp7+7hXwjdAxNNmU51uZFMZj
	 ru98DP99A7+6oPLzqVnIW+Am3ekh1/u6JdadmRFO13sqzxpyKCeS1IlLEcuBLqSBuV
	 Hd9XseM3MP0gbGmKZpZ9a+modwf/fU1P38CqIRsoLsNmE25N6EL/WQY2goGZeQrLd6
	 AFxuQuYP4ENag==
Date: Tue, 5 Aug 2025 13:55:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Jan Kara <jack@suse.cz>, Sargun Dhillon <sargun@sargun.me>, Kees Cook <kees@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] fs: always return zero on success from replace_fd()
Message-ID: <20250805-beleidigen-klugheit-c19b1657674a@brauner>
References: <20250804-fix-receive_fd_replace-v2-1-ecb28c7b9129@linutronix.de>
 <20250804-rundum-anwalt-10c3b9c11f8e@brauner>
 <20250804155229.GY222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804155229.GY222315@ZenIV>

On Mon, Aug 04, 2025 at 04:52:29PM +0100, Al Viro wrote:
> On Mon, Aug 04, 2025 at 02:33:13PM +0200, Christian Brauner wrote:
> 
> > +       guard(spinlock)(&files->file_lock);
> >         err = expand_files(files, fd);
> >         if (unlikely(err < 0))
> > -               goto out_unlock;
> > -       return do_dup2(files, file, fd, flags);
> > +               return err;
> > +       err = do_dup2(files, file, fd, flags);
> > +       if (err < 0)
> > +               return err;
> > 
> > -out_unlock:
> > -       spin_unlock(&files->file_lock);
> > -       return err;
> > +       return 0;
> >  }
> 
> NAK.  This is broken - do_dup2() drops ->file_lock.  And that's why I

Right, I missed that. Just say it's broken. You don't need to throw
around NAKs pointlessly. It's pretty clear when to drop ptaches without
throwing the meat cleaver through the room.

> loathe the guard() - it's too easy to get confused *and* assume that

The calling conventions of do_dup2() are terrible. The only reason it
drops file_lock itself instead of leaving it to the two callers that
have to acquire it anyway is because it wants to call filp_close() if
there's already a file on that fd.

And really the side-effect of dropping a lock implicitly is nasty
especially when the function doesn't even indicate that it does that in
it's name.

And guards are great.

