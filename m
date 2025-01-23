Return-Path: <linux-fsdevel+bounces-39990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F49FA1A97C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 19:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB8616A059
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 18:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74C8170A30;
	Thu, 23 Jan 2025 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RPof37F8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC0C16EC19
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737656339; cv=none; b=cg3O8R0S6Uh2OiPLG7dwSuJpqcc7mRZjfme02+H8tO1WUFJ2giWOHMRiHGhjtgS1CgTcxKxpUp6hYrE4WggBZNwHmV5XL9onEqEOAn1B69sswsr4Ff/jsizrJn5L9c63FE+1XQpjLAXtR27azYEWyw77D4OsxwnK1GJse+BBrbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737656339; c=relaxed/simple;
	bh=laOmoopLfj7f3LAWFETRklK/y8kNdSp/jqCjiZNaq7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBl8SG0LvO2vzXpGn+nA0N72RKwzG5fLWofhkRv63PSP8bW6eZPJjaCAMbWAaeOR8BiJJopCRve10WZ1SdQ+saoJQPciBlAYF7xlWpMlvULOVPp+3X4deuZ3RTfzR3HjFJVs1MgMj6+RrVyIefKg1i5D6hIlYkym2VtZpLfxz+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RPof37F8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dUIhvDzfyx6DZiieDRrmXrYPXvuQKjnVvYWf8/UJhYg=; b=RPof37F8PUWbZ8CLf/8/4///7c
	fJK5I6gcZR8qFUFYL5fLdOmZ+SDYzOZcURCwvh+9cYMyCEEh0KY9b35Y7buHToqzttGlCOfrOD2q0
	CBKmSnJs3oaPt0ZjxB+AtDGL9APRVEUk0UwOUDzWJ8B3VP72rJBfCnibT8MN8haig8/PEpb0sdObo
	KpCV93cXvr+0u78GQUINTQlRZicotvl7cSX7H5UceSk4CvJmYlOzbSif8XKq2L3LHNbjJLYJk5fkG
	1sh7zuKP39ZQAlisCgsMS5pyE7THkxGdAuLp6be5uE8N8wlIZBiRZ6GyAQxd6rZF782/rC6p1fch5
	m+7W6NIw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tb1n3-000000092eO-1ti5;
	Thu, 23 Jan 2025 18:18:53 +0000
Date: Thu, 23 Jan 2025 18:18:53 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Cc: "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
	"Saarinen, Jani" <jani.saarinen@intel.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: Regression on linux-next (next-20250120)
Message-ID: <20250123181853.GC1977892@ZenIV>
References: <SJ1PR11MB6129D7DA59A733AD38E081E3B9E02@SJ1PR11MB6129.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6129D7DA59A733AD38E081E3B9E02@SJ1PR11MB6129.namprd11.prod.outlook.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 23, 2025 at 03:41:08PM +0000, Borah, Chaitanya Kumar wrote:
> Hello Al,
> 
> Hope you are doing well. I am Chaitanya from the linux graphics team in Intel.
> 
> This mail is regarding a regression we are seeing in our CI runs[1] on linux-next repository.
> 
> Since the version next-20250120 [2], we are seeing the following regression

Ugh...  To narrow the things down, could you see if replacing
                fsd = kmalloc(sizeof(*fsd), GFP_KERNEL);
with
                fsd = kzalloc(sizeof(*fsd), GFP_KERNEL);
in fs/debugfs/file.c:__debugfs_file_get() affects the test?

