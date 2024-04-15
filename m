Return-Path: <linux-fsdevel+bounces-16919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 505008A4DE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 13:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E520F1F20EF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 11:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B0C6996E;
	Mon, 15 Apr 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8esOm+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4BA69949;
	Mon, 15 Apr 2024 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181323; cv=none; b=mqt1cLFTLPQMRvLk8/J30L2OutcBq80LLHpGQ5P2ez8JA+Sw1lBuJoPsTEk2CaXYAsF63RTtNXoNczdP/+oc14xqd7s6fqPKGVcZBSMmUDK1fxOEDbqSlcD+jD7w45hWgPgJho2Wdh3ZsaU/mMIC3OgLTNsKGkFsquYO9ZtHPa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181323; c=relaxed/simple;
	bh=Y/Z03HT8kD26aOsWCeyihLa23jj60o45j3+7UDz7iNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPRrVoL1svCqWd6csWkso5kOQER01IA/rb37jklV7yEIIvR3+2O8LGyjVjml8P2OUfyO/bd4g5eBsPAfsyTO529X/GI/bQMMIWIXI76azT9nfzP9NH+bJUtaGfr2QMrtAxeEtsu05xM5TjC1/diCYhSluT270JPxda5I4/hgzOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8esOm+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FF4C113CC;
	Mon, 15 Apr 2024 11:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713181323;
	bh=Y/Z03HT8kD26aOsWCeyihLa23jj60o45j3+7UDz7iNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8esOm+EdLcri3WuHVbCnk6FGeKIJaXsmv384kNL1QT+SRK5CVyxw4WD5DA7QERLk
	 ROlWarRIE19j8zCVbpPJdOv8Ih+HdYpQMDbLCI3w7U6ry/Mykat6Iq92qcCnd/oYVm
	 yuVMvIZaYD4hbvqEbDca7ihZUk4nwq3yDIrtBHnIp9FEiKHGX9dM7fY3gituXpkU/B
	 RV7BKiNHdKXWgsLLOIO6b/VHVceWuN0QpwdBnLNEdjIsiueqcRTmZSj7saHBHWs4MW
	 gE9QMHA2le2UM1zgmoOC/H2xRM8rWY8tFTSCJ8BvMi95oSTBNDBz/+ri5BUb6PMTy+
	 +JabH/2Aof2Ew==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwKin-00000000809-0e8X;
	Mon, 15 Apr 2024 13:42:01 +0200
Date: Mon, 15 Apr 2024 13:42:01 +0200
From: Johan Hovold <johan@kernel.org>
To: Anton Altaparmakov <anton@tuxera.com>
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	"ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
	"linux-ntfs-dev@lists.sourceforge.net" <linux-ntfs-dev@lists.sourceforge.net>
Subject: Re: [PATCH 2/2] ntfs3: remove warning
Message-ID: <Zh0SicjFHCkMaOc0@hovoldconsulting.com>
References: <Zf2zPf5TO5oYt3I3@hovoldconsulting.com>
 <20240325-faucht-kiesel-82c6c35504b3@brauner>
 <ZgFN8LMYPZzp6vLy@hovoldconsulting.com>
 <20240325-shrimps-ballverlust-dc44fa157138@brauner>
 <a417b52b-d1c0-4b7d-9d8f-f1b2cd5145f6@leemhuis.info>
 <b0fa3c40-443b-4b89-99e9-678cbb89a67e@paragon-software.com>
 <Zhz5S3TA-Nd_8LY8@hovoldconsulting.com>
 <Zhz_axTjkJ6Aqeys@hovoldconsulting.com>
 <8FE8DF1E-C216-4A56-A16E-450D2AED7F5E@tuxera.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8FE8DF1E-C216-4A56-A16E-450D2AED7F5E@tuxera.com>

On Mon, Apr 15, 2024 at 11:32:50AM +0000, Anton Altaparmakov wrote:

> Had a look at ntfs3 code and it is corrupting your volume.  Every such
> message you are seeing is damaging a file or directory on your volume.

That's what I feared, thanks for confirming.
 
> I would personally suggest you modify your /etc/fstab to mount
> read-only.  If it is getting simple things like this wrong who knows
> what else it is doing incorrect...

I fully agree and that's partly also why I asked Christian to make sure
that the alias fs type is always mounted RO.

But it seems we have a bigger problem here and should just restore the
old ntfs driver for now.

Johan

