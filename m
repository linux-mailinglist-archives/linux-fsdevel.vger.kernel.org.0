Return-Path: <linux-fsdevel+bounces-22764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DAB91BDD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 13:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF727B20B34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 11:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4E21586C9;
	Fri, 28 Jun 2024 11:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2jLpdy5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1287E36B11;
	Fri, 28 Jun 2024 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575496; cv=none; b=RVPS9RauoHUs0pWLvK2qfR0G61QbFujweH67ARhYyVUMXG4sBHY1p2oUuSN2K69LMv6kAXS9+x/Ytpw7PwY+WotOe2+LOwD23ECfXG4F0c46pd6lfdOz7pRMu+NLkpQp4kUiif3rfsJkHq9Hm3A2dV3ktqQRCRofZlnaBx4wa1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575496; c=relaxed/simple;
	bh=JnyH8SDEWZz2jLqqQ554GBh8tAQTx9UhgxFw8mc1sOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/ekTHwLR68ue4e1OPzSmF+YwxB68K/k3WphOrs6N2P2fi3dowoJYPfU2IHEpxWBuAbS4Ua86j8uurL4nF7VoYhHA4V5jy5PvPlpdFRAuaVc8/TiVCeEeMDb9+qT+z/Vhe8/nIK2NASsA60bhwYo3YoVFOkO4qDUqMQzCZCv9Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2jLpdy5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42760C116B1;
	Fri, 28 Jun 2024 11:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719575495;
	bh=JnyH8SDEWZz2jLqqQ554GBh8tAQTx9UhgxFw8mc1sOE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q2jLpdy50pCPaHfk/GszVqzRn1dxuGFUFV41ggzgLtbd1vvd6VrftxXXj5LqcGYG/
	 +pQJxdEuZubIiMSV4G293Ux6TkZo2cO+CAnzKpbs1kjqRY/g4mKzBtZajMTMmymjvX
	 X0U6KDa+sTVaDTxM0c+nMOnywNl0guwnWATROqr+G5ILAoco+6z8zYmEN/f1mdgEkO
	 23ce8OXwCMrCrxn83h7eI1IIYUIA73vAzjXsuKEG1gqrqIbp/66wXnc+GPnqRM3ffg
	 ZP9RXaVoiWAJFSwqvH69hm+Y7TQ0j/RopxvwAYcMdw0SGuNRBkO5cVUZYfaWBHdHex
	 Bf02GRW8AnyfQ==
Date: Fri, 28 Jun 2024 13:51:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, autofs@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-efi@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>, 
	linux-ext4@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>, linux-mm@kvack.org, 
	Jan Kara <jack@suse.cz>, ntfs3@lists.linux.dev, linux-cifs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Hans Caniullan <hcaniull@redhat.com>
Subject: Re: [PATCH 0/14] New uid & gid mount option parsing helpers
Message-ID: <20240628-diametral-median-bc0de7b68148@brauner>
References: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com>

On Thu, Jun 27, 2024 at 07:24:59PM GMT, Eric Sandeen wrote:
> Multiple filesystems take uid and gid as options, and the code to
> create the ID from an integer and validate it is standard boilerplate
> that can be moved into common helper functions, so do that for
> consistency and less cut&paste.
> 
> This also helps avoid the buggy pattern noted by Seth Jenkins at
> https://lore.kernel.org/lkml/CALxfFW4BXhEwxR0Q5LSkg-8Vb4r2MONKCcUCVioehXQKr35eHg@mail.gmail.com/
> because uid/gid parsing will fail before any assignment in most
> filesystems.
> 
> Net effect is a bit of code removal, as well.

Thanks, this all looks good to me. I'll have one comment about the fuse
patch.

