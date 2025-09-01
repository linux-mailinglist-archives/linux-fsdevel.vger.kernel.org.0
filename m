Return-Path: <linux-fsdevel+bounces-59771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B28C8B3E072
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 12:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CF7718900C7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 10:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A9831159A;
	Mon,  1 Sep 2025 10:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2Vi8DkR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1643244660;
	Mon,  1 Sep 2025 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756723173; cv=none; b=X8kIkntNHCm5ygs7+YNI/SCwAbRayOV0xjZ+11/+4TaD7Oi/rheGX9t4Hvuciysn5ARmyBZVntVB7WeBfedqrYsfODRD3Y4I/JTEwtbnoXumUpP0n+dIWYcyr+OT2/JwhVUfZtCI15ElTkxf2gcCh8vnhIKEi61PCB7joyDmQPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756723173; c=relaxed/simple;
	bh=FHiYltysbexEFmxSGQPexk15gLPmJfD4YRRxaRNMbrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjQiywseRLan6H83peZ6v01h6cGM+yj17wF/fEGGHJbv3DRXdTWXevLORUiR+jwag/93z33stOWIzpAIBUqGS2OFQN47gjMxXQpfv+jpWwl0ZRoW2Xd3sivo6eKCmUa6oQUvl9So5D2O5paayCnG2z280+p3k/j+1oEn728ce6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2Vi8DkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4ABC4CEF0;
	Mon,  1 Sep 2025 10:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756723172;
	bh=FHiYltysbexEFmxSGQPexk15gLPmJfD4YRRxaRNMbrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E2Vi8DkRQCD4WkF9OcobZEqg1ixq6iljXWxHSi9BzLwcRBXgg+nxSRquse+KWndJI
	 E2qWk80P0OHW54W7XSgo02jrsSRXKobShr8lGk18EBJks7NIfY4A1Hhi0NLT2oq6u4
	 /NpeOjj33T4tL3H8wmbFAnyxhfXUOw+MkNLyKbtCB/wCLrPZC8aZkq51fafU+SYADa
	 +e0kU/IIqlatQ1ga4YPqDLUivT/pjtd3AprV1cxIh37/xAU3vZn7PuOMET3z4nxnJF
	 Cq0q7QzhW0n63pLc2HUzdU1KmTTLl1kEjQFZCPVjdpQ2jtA2YxjTOtPA1JJFzsBO99
	 3FpFwPlUSXv1g==
Date: Mon, 1 Sep 2025 12:39:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fs: revamp iput()
Message-ID: <20250901-obstsorten-winzig-50261a2c60fa@brauner>
References: <20250827-kraut-anekdote-35789fddbb0b@brauner>
 <20250827162410.4110657-1-mjguzik@gmail.com>
 <CAGudoHE5UmqcbZD1apLsc7G=YmUsDQ=-i=ZQHSD=4qAtsYa3yA@mail.gmail.com>
 <ox654jni32s6hlqqdney7trtmlp3c7i6vorebi4gizecou4wb6@o5tq3eax3xsz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ox654jni32s6hlqqdney7trtmlp3c7i6vorebi4gizecou4wb6@o5tq3eax3xsz>

On Mon, Sep 01, 2025 at 10:50:59AM +0200, Jan Kara wrote:
> On Sat 30-08-25 17:54:35, Mateusz Guzik wrote:
> > I'm writing a long response to this series, in the meantime I noticed
> > this bit landed in
> > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=vfs-6.18.inode.refcount.preliminaries&id=3cba19f6a00675fbc2af0987dfc90e216e6cfb74
> > but with some whitespace issues in comments -- they are indented with
> > spaces instead of tabs after the opening line.
> 
> Interesting. I didn't see an email about inclusion. Anyway, the change

Sorry, that waas my bad. I talked with Josef off-list and told him that
I would apply Mateusz suggestions with his CdB and SoB added. I forgot
to repeat that on the list.

> looks good to me so Christian, feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks!

