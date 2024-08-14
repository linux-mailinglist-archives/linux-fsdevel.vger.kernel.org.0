Return-Path: <linux-fsdevel+bounces-25866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726D295129A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 04:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34387281C22
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 02:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66290219EA;
	Wed, 14 Aug 2024 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kKAt7Q7s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF75195;
	Wed, 14 Aug 2024 02:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723603261; cv=none; b=t+k8KEdYz6v1a+9huuC+FPJcKrOuLqdw/9grszUmRafoVVXneX4gkP6s/d+twWZf5PpooKGrJtIK6ymNBDMqpYtPLu3n2l6Sh59QrCR+JXxHgz1kJF9zGpJKxnjVxjr2l33dC1M2Tn0QR6lOMSEYB+ob4cc9u+RQEbqBLPwq9zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723603261; c=relaxed/simple;
	bh=8dP9AiapT9Um9uwELwhGryl/YoU5O8eDUgMtovY8fPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxFINyYW9uzVhVkhj743Du2p+x6tlZ9v/ib/5w6vYQF0ThNSPt5AHLTq97UULYbrFuZO5ePEKiOI71vbBlJZl1ln3o9e1XEWNYcya5pv2JadhaWUbwZxkbnHZZxQK/6jw/3AcNBXYOh7doEht3ddXlWUi8df/m1VOIueek+zrSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kKAt7Q7s; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HIunYI+utSGkb+hT1iVPyBe7kEUZHEY/bL93HVsyQBA=; b=kKAt7Q7sPaLmAQY/FH4h7VzG68
	mTo0FGEshQ14lzxu3zJzB5h8gJ+vAgcMyIWhlF8tJrRLdnikX3QynRSOvp38Pzo7fXJRv2t1gX9fo
	ADHdzTmdZnW5Cboq7ueBauavalTDGyyeL7rXNu5NtMSZqOtGEAnuQlXO0WN85zCNbxxtRCcd3k3Qn
	SmKGzDh061ONh2Path/2af+6a5FDNWm5Y+QGPu1EOEMIBXcUPOw8FDSsi3seT01TH70nyOysHdnK4
	XEGOUBTWoKGpZ+jQBHnZnV9vXcc3lSOlNnlW292F9VkboVt7JpHaaenWM6ks8/1iu7ryLWgbGPegY
	APusAN9w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1se3wX-00000001Utv-0Ih9;
	Wed, 14 Aug 2024 02:40:57 +0000
Date: Wed, 14 Aug 2024 03:40:57 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
Message-ID: <20240814024057.GP13701@ZenIV>
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
 <6e5bfb627a91f308a8c10a343fe918d511a2a1c1.camel@kernel.org>
 <20240814021817.GO13701@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814021817.GO13701@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 14, 2024 at 03:18:17AM +0100, Al Viro wrote:

> That's not the only problem; your "is it negative" test is inherently
> racy in RCU mode.  IOW, what is positive at the time you get here can
> bloody well go negative immediately afterwards.  Hit that with
> O_CREAT and you've got a bogus ENOENT...

Hmm...  OTOH, in that case you end up in step_into(), which will do the
right thing...

	How well does that series survive NFS client regression tests?
That's where I'd expect potentially subtle shite, what with short-circuited
->d_revalidate() on the final pathwalk step in open()...

