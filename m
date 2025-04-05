Return-Path: <linux-fsdevel+bounces-45813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3601A7CBCC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Apr 2025 22:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4314516A34E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Apr 2025 20:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51E41B4F08;
	Sat,  5 Apr 2025 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=infradead.org header.i=@infradead.org header.b="S0yC2KCE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E122770838;
	Sat,  5 Apr 2025 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743884977; cv=none; b=dTHmKJIexugZd/4wZDQ6ve0M9a3JWN0Nx3cGB1mHzWz9NSi7yWlGYVYyah/R8XfXOjKe9Lx2cHJ2OjXJRDmazHA8TUBUHacpogSJLQpkxZ4S5uVDZnGhY/PI3xF9jrlwWAC/ZascBCWO8dwHDHQURWs7fxtEnZ0WxTUjLa3EYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743884977; c=relaxed/simple;
	bh=2F21dY0co0+OxqOCz3O3iDpHTcAXTJvg8NLZSgAARaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+ZYxiFQBuehhHDkKv2RXE+wo97zTMrRCMMNvv7dFR8uuetA/GViJ7EnIkEfoX64sno97OglvD/1NfKxN3B5347K+wOeoKGyu/5o7ovmQkgm6ce+EGNx/eV5nIbFWqbNjuq9IctN2OSaFU2XiBbYwCdbDi8U/uy6qLa7SkJYyu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=fail (0-bit key) header.d=infradead.org header.i=@infradead.org header.b=S0yC2KCE reason="key not found in DNS"; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=evilplan.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FrDWFndKUQJt5tv+AT2agX+G7gxd/pGXR3tr7CSlT/E=; b=S0yC2KCEctypd/CXya7VN+BSBv
	1EqWuDsoZ312Loo9QULq4hrX2mX7xUxZ06KZGw7v+9JnmJySPc+QBbrLbodgy+FvGewwylJcXXZ4U
	gEGLV2Yz+009gTWVLXcFpY6K80jziPoXC9V4E7oYEu96yNssNwxKCbyFscVIzufQ7nV2n//71PFmF
	h8zUbVB+09ycTtCZGF14o8fUE90wXDtQFWKzjC6LVhfitlPf3XuC5UKpUaQja4xG9jAZ35vUlOdWC
	cvdpkhDMuFgE1+2Qsb/5g10HfAnkcUIxEh9j9iXge/e1vMYy+0obKTKMMjmxznBjKPlz3XxEzdKjq
	VENKdKYA==;
Received: from jlbec by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1A8u-0000000Fkyb-3Lba;
	Sat, 05 Apr 2025 20:29:29 +0000
Date: Sat, 5 Apr 2025 13:29:25 -0700
From: Joel Becker <jlbec@evilplan.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH] MAINTAINERS: configfs: add Andreas Hindborg as maintainer
Message-ID: <Z_GSpcn3bMRStzf4@google.com>
Mail-Followup-To: Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Breno Leitao <leitao@debian.org>
References: <bHDR61l3TdaMVptxe5z4Q_3_EsRteMfNoygbiFYZ8AzNolk9DPRCG2YDD3_kKYP6kAYel9tPGsq9J8x7gpb-ww==@protonmail.internalid>
 <Z-aDV4ae3p8_C6k7@infradead.org>
 <87frix5dk3.fsf@kernel.org>
 <20250403-sauer-himmel-df90d0e9047c@brauner>
 <Z--Ae5-C8xlUeX8t@infradead.org>
 <20250404-komodowaran-erspielen-cc2dcbcda3e3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404-komodowaran-erspielen-cc2dcbcda3e3@brauner>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
 come to perfection.
Sender: Joel Becker <jlbec@ftp.linux.org.uk>

On Fri, Apr 04, 2025 at 10:42:29AM +0200, Christian Brauner wrote:
> On Thu, Apr 03, 2025 at 11:47:23PM -0700, Christoph Hellwig wrote:
> > On Thu, Apr 03, 2025 at 01:27:27PM +0200, Christian Brauner wrote:
> > > There's no need to get upset. Several people pointed out that Joel
> > > Becker retired and since he hasn't responded this felt like the right
> > > thing to do. Just send a patch to add him back. I see no reason to not
> > > have Andreas step up to maintain it.
> > 
> > Removing someone just because they have retired feels odd, but hey who
> > am I to complain.  I did reach out to him when giving maintainership
> > and he replied although it did indeed take a while.
> 
> I mean, we can surely put Joel back in. My take would be to remove
> that person from the maintainer entry because people will get confused
> when they don't receive a reply. But I'm totally fine if we should leave
> Joel in.

Howdy folks,

I do apologize for my delayed responses.  I try to review patches as I
find them, but I haven't yet set up a dedicated tree -- a bit out of
practice.

The Rust patches gave me pause.  I have no context to review them --
even the little Rust I am familiar with looks nothing like the complex
stuff the kernel bindings are doing.  For that part, all I can do is
hope someone other than I knows what the Rust should be doing.

Thanks,
Joel


-- 

"What no boss of a programmer can ever understand is that a programmer
 is working when he's staring out of the window"
	- With apologies to Burton Rascoe

			http://www.jlbec.org/
			jlbec@evilplan.org

