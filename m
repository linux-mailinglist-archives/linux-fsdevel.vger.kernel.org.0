Return-Path: <linux-fsdevel+bounces-55161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BA0B0767E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 15:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7E971AA27B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 12:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB722F5467;
	Wed, 16 Jul 2025 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qy+Mf1G3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A550B28C2CA;
	Wed, 16 Jul 2025 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670642; cv=none; b=kcDdZFsvY683nmx8gis5MqxfysbRGZzF++Wi8TJw3KiWx/dBEVISQRNe1ypZWrzike7BRhtJdgq/qZTEOgC2XOX4q/yyGbpvteyDu1lPiP0sJ5KiiE4mbCV0U5tXNTaSvuxgCb6Uzabsy9rESTLqYjZsvEDYqz6dhj23PRfmeV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670642; c=relaxed/simple;
	bh=VcUS0dGH2wrw6iExfsqdUu1BbgXr9w0BXMZvmB8YS3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOcXDeBjTnq5ldoBzth8cADOS7zh1IDRnZpdMMj+deLd+FZqlro16O/TgrnJl4pJ6/2MlrsCn0siFITVLK6q2y9QTWg7lGKiiPt1Iwj6KFnY6H+qgEeoG9cuoOiXuQVcZFu1Pwn2H+7dqY/AdpAGdgTZimfptcrW0hZw9Aw/w2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qy+Mf1G3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=8WjBaq62WfxPGFa8coyuo3PlCV3qYPJ3ILLM2MOzQAk=; b=Qy+Mf1G32449AxAmOsvxvnB9+4
	pWWUP7R+NI7k/0eoub5QtAw2BOHzFJStA/2JFN7I5SRAGGdwCSjI0ZArJtQsbqyHe8qKFqrziIHfx
	rJHe+bTeKKYgxvIg8mkN5ZIDvEWJUh/koeR6HjNy64UlnNilWjj/g4LnVr8uASRr1NHAyizfGDLh+
	GSLwiH0siUmJKJg1FlCGmWj2bSu8YVSeZ5RaZ3LhB4wlNssuA5hE0z7CfFUgYJ0e5koYYU9gMy28p
	mJMCjFyaaCb6isTfpvxKmSVxAFZxj2wz3nUZJVkrX4qi3152gSC1GVTL6QmfSFg7bYCfQnKLKWrjI
	cYfaisWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc1hG-00000007iqs-316b;
	Wed, 16 Jul 2025 12:57:18 +0000
Date: Wed, 16 Jul 2025 05:57:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/15] fs,fork,exit: export symbols necessary for
 KUnit UAPI support
Message-ID: <aHehrhXgQohy1JnQ@infradead.org>
References: <20250711123215-12326d5f-928c-40cd-8553-478859d9ed18@linutronix.de>
 <20250711154423.GW1880847@ZenIV>
 <20250714073704-ad146959-da12-4451-be01-819aba61c917@linutronix.de>
 <20250716072228-2dc39361-80b4-4603-8c20-4670a41e06ec@linutronix.de>
 <aHdE9zgr_vjQlpwH@infradead.org>
 <20250716101207-c4201cef-abbe-481d-bca5-c2b27f324506@linutronix.de>
 <aHeIyNmIYsKkBktV@infradead.org>
 <20250716132337-ee01c8f1-0942-4d45-a906-67d4884a765e@linutronix.de>
 <aHeOxh_yaQGFVVwM@infradead.org>
 <20250716143500-d42ea724-1bac-476e-80b8-1e033625392a@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250716143500-d42ea724-1bac-476e-80b8-1e033625392a@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jul 16, 2025 at 02:47:08PM +0200, Thomas Weißschuh wrote:
> This is exactly what I did in the beginning. Then I got told about the distros
> using KUNIT=m [0] and decided that it does make sense to support.

Well, not if you need to export tons of stuff for it.

> The actual code using these exports [1] was Cc'ed to both linux-fsdevel and
> linux-mm. In addition to the cover-letter and the exports patch.
> The rest of the series does not interact with the exports at all.


Incomplete series are not reviewable.  Don't even start arguing about
that, if you don't send series to all list they deserve to be ignored
in general.

