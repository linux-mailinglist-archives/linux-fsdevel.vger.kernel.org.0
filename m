Return-Path: <linux-fsdevel+bounces-68263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EAAC57B9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CB3242704D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBA5350A13;
	Thu, 13 Nov 2025 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/FZOuNf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8339F33F8D2;
	Thu, 13 Nov 2025 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763040195; cv=none; b=WxDwWdXp1t68me/z86RREDRl0DgQm+ZNv+/qWEHge/2QDEt1qnYPRQZ8PAJFRcVtifI9rwW364obHFBoJdinYhUbfllYU7L6fv2ZlEMOxhn14UEvzTaAh6dokSnGrxKC9AtsVEcYD/u1r3XPQd7rk+ZRESYDZ93kOB2urJt+B6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763040195; c=relaxed/simple;
	bh=lvfswMziEy292tZscIvVjJ1YW5U9G7u6NvZBOY/n+Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i782y6Gwn3xg8Fdj/ZV4GVgrlI1TGpq/Al1wujt24rsHYXzt2fnkF/57O4JOxfW9GuMhPhVQ4wbe6jyGzo3sYWnSO8Mho5bdNRNeg1/Ya/lSxdSAvPuMBZbKO8QPAstgJXFKtmsoS7nGtncO27gkQ1gxlXafS3+4s70nxImnQis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/FZOuNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA984C19422;
	Thu, 13 Nov 2025 13:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763040195;
	bh=lvfswMziEy292tZscIvVjJ1YW5U9G7u6NvZBOY/n+Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/FZOuNfAOMueneDT6L9Y9dKe+INTNo3uoaG3orzguzdEYZ5TZaI8MyO1uFTnwq2M
	 qfFbGhzXkmlvMGHMPGbN776roUS4yVHkznVNAqdozXAnW0bUGizjhq571lXzsSgN1Z
	 HLTirbSDKSe5ekYz3JrGyY+G31dAxlg3i9+cT67L7hbVKPau8Nk3Gl+KixjIdTk5A5
	 V3cKBYevhVJ++ueF8soRpVJcYXi/3B3OyQf8dKZ9NNKmVOqPHl04I610RNFL3KuquE
	 NnaK/OzloP5Wid61YY1wcaYGvsgoMIiIrOu18ZY/p4HboqZlFcq0Qu0gBUELZZOpr1
	 B0pUkWb0QFhyg==
Date: Thu, 13 Nov 2025 14:23:10 +0100
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: touch up predicts in path lookup
Message-ID: <20251113-dazukommen-zahlbar-4ef863954dac@brauner>
References: <20251105150630.756606-1-mjguzik@gmail.com>
 <CAGudoHFNDC_5=T3XKLzNpsMkZYaf_KbjHrL36rc0YWDWaJMS_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHFNDC_5=T3XKLzNpsMkZYaf_KbjHrL36rc0YWDWaJMS_w@mail.gmail.com>

On Wed, Nov 12, 2025 at 12:20:09PM +0100, Mateusz Guzik wrote:
> any opinions on this one

Yes, looks all sensible to me.

