Return-Path: <linux-fsdevel+bounces-26397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7662F958E77
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 21:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C23E1F240FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 19:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C541158A37;
	Tue, 20 Aug 2024 19:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ashPc+o5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84B014C5A3;
	Tue, 20 Aug 2024 19:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724181133; cv=none; b=uA8Ctmxw7Hs/0mklH0FgU7ZSESfKNYyYJrvsmbGCYFBM3Dyqv9P4SCzcrp+ziONXW9yC5YHinbizstXc6RgATsZkKHbj6IwK7XLebJ1qGVOjlyWsGAmWhBSbb6ctjRqT+v/TDOwKGqoTTsSftjASn+60aWTG81xDUc6D4cWFuEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724181133; c=relaxed/simple;
	bh=eGP/kMNCE889EGSPnsUMDPXlztvShLSli+HTFbfFgd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GphoY+i5OGKBDiuw6voZsyDlbWKHP2Xz7L+FPIb8WXA+BETe/1m2O7HpfADIi7xY2fWEi/y3rJg2oL7cX6FO66pdrzLDm11OEpobYJneCTUKm9zsv24bLrqxxuweoUGRwKeLMp9yFe6dO5FD2l+wAVSMqc2dVwZsMxD/xRM/pMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ashPc+o5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E0CC4AF09;
	Tue, 20 Aug 2024 19:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724181132;
	bh=eGP/kMNCE889EGSPnsUMDPXlztvShLSli+HTFbfFgd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ashPc+o5y1+gWtdEmwMfIrAgyOWei+pRtS2kKoCyZeo3NwMohLSMkKxZ1v7kQYs3a
	 DvC7z3k2hGg4mJr6L8KHybQPsN9A1XqT1Rx2iyTsH2N5leCjVSjZbQCVt3L0sOLzsD
	 gaiYrxvZw/S5AWoKANjVHLPJ0xcTMaJOJGnLdlq6u8Yd5liyGmmAVcc7Ps2smGzgZI
	 QPxxnnVZJgxO+u8ZiUkMD6wjAO3sC7ApT6u/I7Ac/ACQ+VysDobn55QmhcJwa8lwQl
	 RqxzCgeWXrEB8vrK62jeT6owOZAGjjuRgkYY2S7J60FhsdioNjLEERWdeMlSFZKfcC
	 aXWE8WJsU7dCQ==
Date: Tue, 20 Aug 2024 21:12:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/9] Use wait_var_event() instead of I_DIO_WAKEUP
Message-ID: <20240820-rache-gerochen-aad94052320e@brauner>
References: <20240819053605.11706-1-neilb@suse.de>
 <20240819053605.11706-5-neilb@suse.de>
 <20240820-ausschalten-lider-e30db5ffbde3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240820-ausschalten-lider-e30db5ffbde3@brauner>

On Tue, Aug 20, 2024 at 09:22:33AM GMT, Christian Brauner wrote:
> On Mon, Aug 19, 2024 at 03:20:38PM GMT, NeilBrown wrote:
> > inode_dio_wait() is essentially an open-coded version of
> > wait_var_event().  Similarly inode_dio_wait_interruptible() is an
> > open-coded version of wait_var_event_interruptible().
> > 
> > If we switch to waiting on the var, instead of an imaginary bit, the
> > code is more transparent, is shorter, and we can discard I_DIO_WAKEUP.
> > 
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> 
> Neil, I've sent a patch for this last week already removing
> __I_DIO_WAKEUP and it's in -next as
> 0009dc756e81 ("inode: remove __I_DIO_WAKEUP"). So you can drop this

Today's the day of getting things slightly wrong it seems...
2726a7a8477d8c0 is what I meant.

