Return-Path: <linux-fsdevel+bounces-26349-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FA2957F56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 09:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F130BB23FA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 07:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD40188CC4;
	Tue, 20 Aug 2024 07:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YklYdb2S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E5B17624C;
	Tue, 20 Aug 2024 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724138558; cv=none; b=B1jYzfe3H/Yl9bsej1S9O5zOtK+hCg/9hDhyIe8To3T8h0KzKsvvDSB4f5/nQHG/GNzDMTSGKucZzhS0S1Gs+y0cAcFW1q61kcfzTCC8bxu3gIdl5f4HIv5OF+I1G+E88ORLeUSFQcPafWNQeCk7+iag8+yNeOI2l9Mq30w0Q74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724138558; c=relaxed/simple;
	bh=LriHYktrpFppV4L+qCCcmg0UKokK3Nmowgf92BJLEmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dk9n7pAy6J37vgVaX5flWw7/togQgRJik+hnSiFcPhP6wAEtsCYhuDilewA8FMYVDXM+SE/5tWRzH8HDnHj/QtW/9PJjHw/FNfsvEyGyzpg8HEat3jsbILcDxS2UEmzeeCL2m29rxvlKAr71wiZ+HhIUSrSLt9V2ZOGCp/Oo2RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YklYdb2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EE0C4AF0B;
	Tue, 20 Aug 2024 07:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724138557;
	bh=LriHYktrpFppV4L+qCCcmg0UKokK3Nmowgf92BJLEmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YklYdb2SioRfckx/9fhTrAeG0B4lSOdavHNviTBM2G4cJoGbhM2yq64Fzc2BN5xzo
	 md6bJGrLsxQKiQaDARCvLEMEACnK97/TVr62Gh9z6sDKPAgox3o+45oPjZHMEYJDS3
	 eppxPEf7oeAYHzqjXpRR3r3br+nGXBSUJaiU/LkaW6sI58tWQ0OGyjgbnR3uhmpRUE
	 O3YDehhWUMDWvx3f1/CUdnOrAxzvmvYtJUZBoFVgbm51SS0+L0k3MFZr6T3kJ8EQn/
	 XGIuI7lz/8D69uWgqhv6G4YI+GklRco5wDgTeZYNEL4AU2YfiDU/vK5qF7KAD7PnH9
	 E6P9aFcux8Djw==
Date: Tue, 20 Aug 2024 09:22:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/9] Use wait_var_event() instead of I_DIO_WAKEUP
Message-ID: <20240820-ausschalten-lider-e30db5ffbde3@brauner>
References: <20240819053605.11706-1-neilb@suse.de>
 <20240819053605.11706-5-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240819053605.11706-5-neilb@suse.de>

On Mon, Aug 19, 2024 at 03:20:38PM GMT, NeilBrown wrote:
> inode_dio_wait() is essentially an open-coded version of
> wait_var_event().  Similarly inode_dio_wait_interruptible() is an
> open-coded version of wait_var_event_interruptible().
> 
> If we switch to waiting on the var, instead of an imaginary bit, the
> code is more transparent, is shorter, and we can discard I_DIO_WAKEUP.
> 
> Signed-off-by: NeilBrown <neilb@suse.de>
> ---

Neil, I've sent a patch for this last week already removing
__I_DIO_WAKEUP and it's in -next as
0009dc756e81 ("inode: remove __I_DIO_WAKEUP"). So you can drop this
patch, please.

