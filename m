Return-Path: <linux-fsdevel+bounces-67894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DB5C4D047
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 11:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C74AF4ED03E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4760834A789;
	Tue, 11 Nov 2025 10:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IzqMPGmI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0877E2DECAA;
	Tue, 11 Nov 2025 10:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856198; cv=none; b=GD1CY86fkBam/ESiS+rDruUjwngmsueBXr+gl0TSmbU53pORsbMKX1ohF5PPxXmnTruHMID2DncQPTST6VmgvK/E9P+FAUtr1REvphcoIWsu1thM391DKKNUquOv8E37KNRMoNnOlhz3LAJSAH6m7jUL4C6BO3Rr1c3113qLKjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856198; c=relaxed/simple;
	bh=nqjG9e5ouf9/QJfHtEqkB+C1rULajgiDFGBOIdOlVXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isdswNJtaAHvVH4/uYCmEwdxiFTbZOklxBrzTWShj8miyNEoqEj6RU9DuMKvy5fW5KQ1vrUdRrPgtIY1GYaNQpHsUSptH549romr5rNfMwyQfIvlh4rmN8kGi9RugSJtnm6OWf//XmK0xmNI3loRpFG3jnn0e7fe/JzkXeIIgZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IzqMPGmI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UwY8bMBW+6nCls4uq8ltiivh8G6Vvd7e6jgK+4wrdQw=; b=IzqMPGmIFpXVhwtBbJ4YevQn6H
	Dv77J8f99QFHARBWa5I3UStkP0/QUjsnhRMHmxqFFmuNfc5hpLDexIKLXJbo6lwX13Yxd3JThiI2F
	yh6OkiVhAcq6wR5ZRrPEqdLYHHJfQb9xWaMur1PptmaJ+ld33dMvdFvJVMkhD6rWhP4aT+qnGGPTS
	kLdp9KxJ1KZkD1bkwgMVI6oWpMUi2THXQ63UFJp2NEtnkVdNGlbTvtyhlnnQkyOmlwi7x1vP9tyiP
	xX/cgju6SDFacjuEvh608/geqoMz69JAKi24xPnS+zXHm69a9bza9Ukuz+seQjkYGAZWKfLPJ3Bsw
	OIL53O6Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIlQR-0000000FxwZ-1noB;
	Tue, 11 Nov 2025 10:16:35 +0000
Date: Tue, 11 Nov 2025 10:16:35 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Ian Kent <raven@themaw.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	autofs mailing list <autofs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] autofs: dont trigger mount if it cant succeed
Message-ID: <20251111101635.GV2441659@ZenIV>
References: <20251111060439.19593-1-raven@themaw.net>
 <20251111060439.19593-3-raven@themaw.net>
 <20251111065951.GQ2441659@ZenIV>
 <d8040d10-3e2a-44d9-9df2-f275dc050fcd@themaw.net>
 <20251111090416.GR2441659@ZenIV>
 <3b7aee07-cf68-4186-b81d-2c4d9e44cc55@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b7aee07-cf68-4186-b81d-2c4d9e44cc55@themaw.net>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 11, 2025 at 06:13:19PM +0800, Ian Kent wrote:

> Anyway, for the moment, I think your saying just taking an ns_common
> reference
> 
> will be problematic as well.

If it is persistent - definitely.  We'd get a massive leak, since
namespace is torn apart when the refcount drops to zero.

