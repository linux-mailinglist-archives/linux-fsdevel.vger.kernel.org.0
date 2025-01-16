Return-Path: <linux-fsdevel+bounces-39430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B51A141C9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 19:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE5F188A8EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 18:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BBD22CBD8;
	Thu, 16 Jan 2025 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="E6jDdm3R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF1A4414;
	Thu, 16 Jan 2025 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737052946; cv=none; b=CQeoV6fqrREXQB5Hs+dppTn0lg2MwWVgp9eAe9FZNsfMNq4pCeC7MN0szoXEtIsi+CBqwA2wayADFkVLZZ26UkP/ZjgMCdICIOHaLLGKbSADeAtAOhbXShxcDh1TdIm6ooAzKUYg0gLTUeivBeHM/45cnhNG0stuklYBW2FGgRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737052946; c=relaxed/simple;
	bh=Vx5rdNhWDvDQMOLcPEY67j0nHc3bBf5NxtwAS8sidrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWsbemw0eTsLIkSYrahJVn2piLmiZo6QALRARMPAqkUZ/2Agl5gExot+RoYKJ6/n2qjRym+owHOkV359RRq1Wf3rj6IQgm7Qm99P8q996kHV7fVqlbWwSraL6NBm4O9KlwpBm77th7TiN4ag8LNrIjdQnknrEZDQtvz3Awe9Y7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=E6jDdm3R; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Vx5rdNhWDvDQMOLcPEY67j0nHc3bBf5NxtwAS8sidrg=; b=E6jDdm3RjuLTrVr2NQhBJxWs32
	x26hysSE3q9dz1mBHaeuckmZOiczNEt4r2xTYoUBpAnDU+OWQtHDuhyW9A8gnqvtvd4CYw14onZ36
	Xrvoje1rfJHQFvpZ7lR8VeJwuFvtrmp71ou4HJjbHD3VzNN9qE09Uofy596ouGxTVrZNKOxCfmfzh
	BKm7gKt2dtF8PoRlJEwxie1o1lgq4rUGYhFjzOyHk+efsPs1lgARqh7nJU2bctNffV0JMRtNRMVX9
	lIPhwdfL0tny3YSEND1a5aDMyqAM6lYLGMtKFUrktKi76zh6NcbHmSMzRm/XWO6+ORxpvKPutOQlV
	+AR0So8Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYUox-00000002Y32-1dyx;
	Thu, 16 Jan 2025 18:42:23 +0000
Date: Thu, 16 Jan 2025 18:42:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 5/6] efivarfs: remove unused efivarfs_list
Message-ID: <20250116184223.GJ1977892@ZenIV>
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
 <20250107023525.11466-6-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107023525.11466-6-James.Bottomley@HansenPartnership.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jan 06, 2025 at 06:35:24PM -0800, James Bottomley wrote:
> Remove all function helpers and mentions of the efivarfs_list now that
> all consumers of the list have been removed and entry management goes
> exclusively through the inode.

BTW, do we need efivarfs_callback() separation from efivar_init()?
As minimum, what's the point of callback argument?

