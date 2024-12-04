Return-Path: <linux-fsdevel+bounces-36490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE679E4019
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 17:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C515FB3C96F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 16:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4C120CCC4;
	Wed,  4 Dec 2024 16:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XCVVLKK0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718181F16B;
	Wed,  4 Dec 2024 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330094; cv=none; b=qUCTXCJ/AUz8aic+hQxtxZYF3dYOuzY6jlmI+NBymYE6J4508+nue8z3nomkZ/vXu3UhHY54LbBC3LqdbnCfPuW6f2NMcTInaCVEBOAxh7jlvhZjIYpgfEJvmINCrtVq2bmwayaoTehMmdPRRqElHpSSfS4MWyvpuVrxF082cyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330094; c=relaxed/simple;
	bh=NZZO6eL7q4YMxahlCRwxMqBfM41DqBDT83ns2VDCXVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YhwBRxYCnXBRMHpuLUBSQQmZomYlvzPdyMB8XuDzsfEUUL47z9DERZ5BYsfiPNCFgVT2qNY72625Yavs4c6zELg/YaSk8pfUNyJGhO96by9/4M1HnJ5T/1lq5Byah9W76iMw21YzRWFAcsgojQwe/FT4z6YBMIJ8KR5Y7/ISt7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XCVVLKK0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BXeVMf7TisBcYMTsJIlRVGXec9/iHimih/bk5ZLjdsc=; b=XCVVLKK08G6encFtU49bhJjRUv
	Xj/aR/rfLgC56Zxru9wxRSW6SIgZR4CqBHu8bH0sLAiXV5jvHlBJX9IS6fE9ZRlU8evIPv2/4VDv4
	ehDbgJHwEtVN1ngFKjIULjjEXYwlYCMNlnZ+sZ082Ky2scUjdSFxENmclEoY1FCyFXnCCndrZOlyg
	84MKsUP8PwImB9zAiuQ7XzFrgPp/bLL+9OQWYztRkTqoib3dOyfsLrH0R7WBNoUCeAAD9d29v2+Qj
	qH9UfqFrspkTs41H1cqKiGhY7cEcdOLVgMbTi7VGnhLdHNSFTIyKCGDU1U9gTb6grx/maBkI9ugVg
	E+H4Rogw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tIsKv-00000004p5m-1oT1;
	Wed, 04 Dec 2024 16:34:49 +0000
Date: Wed, 4 Dec 2024 16:34:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jan Kara <jack@suse.cz>
Cc: I Hsin Cheng <richard120310@gmail.com>, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] file: Wrap locking mechanism for f_pos_lock
Message-ID: <20241204163449.GR3387508@ZenIV>
References: <20241204092325.170349-1-richard120310@gmail.com>
 <20241204102644.hvutdftkueiiyss7@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204102644.hvutdftkueiiyss7@quack3>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 04, 2024 at 11:26:44AM +0100, Jan Kara wrote:
> On Wed 04-12-24 17:23:25, I Hsin Cheng wrote:
> > As the implementation of "f->f_pos_lock" may change in the future,
> > wrapping the actual implementation of locking and unlocking of it can
> > provide better decoupling semantics.
> > 
> > "__f_unlock_pos()" already exist and does that, adding "__f_lock_pos()"
> > can provide full decoupling.
> > 
> > Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
> 
> I guess this would make sense for consistence. But Al, what was the
> motivation of introducing __f_unlock_pos() in the first place? It has one
> caller and was silently introduced in 63b6df14134d ("give
> readdir(2)/getdents(2)/etc. uniform exclusion with lseek()") about 8 years
> ago.

Encapsulation, actually.  Look:

* grabbing the lock without setting FDPUT_POS_UNLOCK should never happen;
fdget_pos() does handle that, no need for grabbing the lock as an operation
on existing struct fd instance

* dropping the lock is done in destructor; no need for separate "it may be
locked here" scope

* we want fdput_pos() to be inlined (and preferably eliminated in the case
of failed fdget_pos())

__f_lock_pos() would *break* encapsulation - any user of that thing would
have to deal with FDPUT_POS_UNLOCK bit and the rest of struct fd guts.

