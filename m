Return-Path: <linux-fsdevel+bounces-28945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2E5971A31
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 14:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 059E8B23CF1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 12:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AD01B81DC;
	Mon,  9 Sep 2024 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IeckOiqj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDABD1B81B3;
	Mon,  9 Sep 2024 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886757; cv=none; b=CiPVQwr5TGN4L80sc0KDnRxO077mxndNPgwqoBhejpMwGpSYal7aSgTp6ElVx8AFAEYX2yrWiNk/sTVOdQ0kv0L9DcDea0oqW3YRKYUaooMAckJ6dYFr6rEDAjZuU4ccWMyn+POLs8BO4gsyL8QzNLy4o27wHEZ/Wlmi7gvleHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886757; c=relaxed/simple;
	bh=dllIAoskj63/l7eTQ2o/TraRKUCuPi5qpjotFRb2y4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqSQybySr0umuNNcxSH+JrTTpR2p2WohalTYJc4GVAaA9++3Tlhn9OWZIpgsMbzxJJ4Brmst2H9i5Dnfq7kf6GFK2oUHsalNspgH9QWM59tvYdfMlzyWAKvnAao1lSbNLdBO8ihpIHBdw101jENxuih1q19K1Ic333GblnsYF4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IeckOiqj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15257C4CEC5;
	Mon,  9 Sep 2024 12:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725886757;
	bh=dllIAoskj63/l7eTQ2o/TraRKUCuPi5qpjotFRb2y4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IeckOiqj41XCDDZIUeMP+ut0ZxJpsgx4r29B7y+TzoKqJ/qLGKP3sxA/AC3m/KVlK
	 bNEJbCpC0hXPM91R8gqVwaHuEnDihVhPaM+QFeDuTo3EWHMN4kp8IAJ75+LNal4mLd
	 4cGZCkO6cPV0lz2B+5GNz2UDpp2VLri+tjhZrQ3HLgrDH+1FZGwiR2WtcZoKR+ntz2
	 c0wcmJZlT+dO3bIPTwF7C6ea/w1uAJfhHbwC1OCMN5Vvt/izsONXc/JuT/tl3ZmuU2
	 h4R+bFnuqzSsO+0YpMDkivNpIuZj4i2q4qEt9r8Od+9wxBSUtvPmA2arkgVl5H+ffq
	 DhPLXcRuxyXgg==
Date: Mon, 9 Sep 2024 14:59:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, linux-fsdevel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] fs/fuse: convert to use invalid_mnt_idmap
Message-ID: <20240909-unflexibel-darin-9b3fdd17fe6f@brauner>
References: <20240906143453.179506-1-aleksandr.mikhalitsyn@canonical.com>
 <20240906143453.179506-3-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240906143453.179506-3-aleksandr.mikhalitsyn@canonical.com>

On Fri, Sep 06, 2024 at 04:34:53PM GMT, Alexander Mikhalitsyn wrote:
> We should convert fs/fuse code to use a newly introduced
> invalid_mnt_idmap instead of passing a NULL as idmap pointer.
> 
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

