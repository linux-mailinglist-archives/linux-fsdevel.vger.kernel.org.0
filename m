Return-Path: <linux-fsdevel+bounces-68466-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58552C5C8CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024F63AAFDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD18C30FC24;
	Fri, 14 Nov 2025 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmrsIzu6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338B730F931;
	Fri, 14 Nov 2025 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115716; cv=none; b=QnDu6PmC7Q9nTLLgBOSjKHLp5HQfP4Ctua+Ayes/lPflOXJWJ8nVbMFToksbKX22ZcfERyurBnVOMjeKqTZs2OAbVUdR7qDJKizkB78Mb705so6eeE+QN5CYS2c7iPwZeVq7xZlGTotN/e0Ek3YuUC8X9AOE58oib++NUjT+zeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115716; c=relaxed/simple;
	bh=4ZD0+GBdHfxL8K+LAmbo0TojavLGFwQdEWqnGlSU8TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D3qLwSPGxSik+etSUhSH63XrgO2vXZEue+zHwBP7I5TrRHFP0fP7hxrANhvkm2RwjBdnXhCTtozLscWwNst70ZkXCawOrEHdB5aX9rUg+HPe1GRi+6Jt5ft1kGMds0mhFE8gFSGvB9Ylng64RVdvZmrKCPSOJQrcQYEI6MAliwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmrsIzu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58998C113D0;
	Fri, 14 Nov 2025 10:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763115715;
	bh=4ZD0+GBdHfxL8K+LAmbo0TojavLGFwQdEWqnGlSU8TE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DmrsIzu6rPKdHDGa7rHsSYZy9bQj0pRIwXv5AGlbjtKi0Om6EP0px519sYwcloEE7
	 d/fzlcp4sH3on+GXRvVvdDDtSVdKCMJIT9ihQXft4BlofcC3vi5ULibG8uXwXDiJYi
	 Lzp1Du4A3BPnsEiNi9WDirKFDbFPMQ8/3DgJtJH80tgBvw/73Ulls5tRfkNfW9eH9v
	 8pTyolIC+/f+m4Nfol1jlAwDn1j8nUuQ3HgHgCLMbgdpH7FixTcn0xXY+VrXuhxEsO
	 eIpQw3tCcRama3r1Sf7Kgycrfxr10JFLyFsq+HJ//BcFTKaglLEYytsTsokdkSwvmt
	 lpCZD0PW8Op4w==
Date: Fri, 14 Nov 2025 11:21:51 +0100
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 34/42] ovl: extract do_ovl_rename() helper function
Message-ID: <20251114-zurief-tagebuch-790cf513c676@brauner>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
 <20251113-work-ovl-cred-guard-v3-34-b35ec983efc1@kernel.org>
 <CAOQ4uxgumgfM1GVE1oMiiN=aW3RBxM67OZGfVE+7e2qW6Ne_jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgumgfM1GVE1oMiiN=aW3RBxM67OZGfVE+7e2qW6Ne_jw@mail.gmail.com>

On Fri, Nov 14, 2025 at 10:03:56AM +0100, Amir Goldstein wrote:
> On Thu, Nov 13, 2025 at 10:33 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Extract the code that runs under overridden credentials into a separate
> > do_ovl_rename() helper function. Error handling is simplified. The
> > helper returns errors directly instead of using goto labels.
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> 
> For the record, the only way I could review this patch is by manually
> moving the helper and doing diff, so while I approve the code
> I think this is unreviewable as it is posted.

This function should've never been allowed to be this large in the first
place. It is a giant pain to read and modify.

If you have an approach where you can refactor it in tiny steps that I
can incorporate, be my guest. The only reason I'm doing it is because it
gets in my way here.

I've already split the cleanup into two patches.

