Return-Path: <linux-fsdevel+bounces-35631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0E59D67CE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 07:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019762823E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 06:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D8F16F84F;
	Sat, 23 Nov 2024 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="l26VeVAs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F0F745F2;
	Sat, 23 Nov 2024 06:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732342453; cv=none; b=WT+c8QqyDw3qqq/vyOKGgUBXgltCCp1/DzDHcDb9dOwQyqcDExfmTPDzsLWUIlgRFLXoYD46dzPDyJEWskbOh/OiysF3tc3OCUTatXI2LAcZMDcNovtLNLs8hjQqib7A7yiC/RCJ2X4bDDg2ReFxTr9xf+HDjTn4B1FGbsqeONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732342453; c=relaxed/simple;
	bh=cWZA13NEpGgUKcjTGGxnbtDxPl+U5UyU6KnlR/FVdII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdej1Is1CyA76JQeEudP1hJckr8n8woI7OJ4GFwHEh1v6tcWLsd4wjApCixlZZtCdujtRMmysdjhWEqy1uFlkRlTv9OF3tYQF75dTvzqkD6o58y5cs8jAoHtpEsriU3j/hD/250CVwvWqiKcbpUCUCjQLacdA1q4tYLjVjb42Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=l26VeVAs; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EjvPV4IAoZwWE6d4dXszLiblhwQ+DDKq6CDDSeiu+tk=; b=l26VeVAsJoYSRJlNHvi9w/D/+C
	UDJSXkgaXbCP5iQ6wZEI6XM/210kElFGymGHoMEadmsQ+SKwYJqpUnyPiEdNfWR0DUWRCq2qfnHH/
	mP/P6tP8HCDbWI5rrACZ4phic2dkRtLb9D15aQplJmGVLOb7PFU6mV0AkVyvybpiqcoJemHqRAZf+
	I0yTODtAGoOdyH3hl/gjUSzGN5GCUHteGkZiZ1/L1/fIPgjuveqYR2+Bg2yzmjsoxF9FbnQxktvWm
	0tE0w6SqJWAD2+dRHJjTn9+ParTPtco1R4/x5DyEm4JT707P0BTBp3/xgazAPIKHl8GcPNyisSuJx
	oNUTBhFw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tEjPD-00000000deu-33NN;
	Sat, 23 Nov 2024 06:14:07 +0000
Date: Sat, 23 Nov 2024 06:14:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: Re: [GIT PULL] overlayfs updates for 6.13
Message-ID: <20241123061407.GR3387508@ZenIV>
References: <20241122095746.198762-1-amir73il@gmail.com>
 <CAHk-=wg_Hbtk1oeghodpDMc5Pq24x=aaihBHedfubyCXbntEMw@mail.gmail.com>
 <CAHk-=wgLSHFvUhf7J5aJuuWpkW7vayoHjmtbnY1HZZvT361uxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgLSHFvUhf7J5aJuuWpkW7vayoHjmtbnY1HZZvT361uxA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 22, 2024 at 10:09:04PM -0800, Linus Torvalds wrote:

>  (a) add a new "dup_cred()" helper
> 
>     /* Get the cred without clearing the 'non_rcu' flag */
>     const struct cred *dup_cred(const struct cred *cred)
>     { get_new_cred((struct cred *)cred); return cred; }

Umm...  Something like hold_cred() might be better - dup usually
implies copying an object...  For grapping a reference we
normally go for something like hold/get/grab/pin...

