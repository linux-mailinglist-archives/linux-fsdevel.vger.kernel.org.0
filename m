Return-Path: <linux-fsdevel+bounces-67606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3AEC446EA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 21:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AF33B063B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 20:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144B026B2CE;
	Sun,  9 Nov 2025 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="wUuaVauM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4691A0BD6;
	Sun,  9 Nov 2025 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762720829; cv=none; b=ldxVnJWP42q4cCeRkxeF55wYw5RikAc96abFI/iip8NAfw5AzSdO38arU//FxzixTArhMYfkF9paQl2HitnFD3q37P4Le91n6Ug2NnKxtWAJranV/tJFyxjnl/MhSUS0/LDqN5kNn+q60aunP/djSc/sXiVSR33KubhSwksIrDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762720829; c=relaxed/simple;
	bh=IMyNr6qrkO6d2PRolblpwhjRIVpF93t8I4D1MPZrVk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXGIxULIPs91Dx2FjONJ7rE6suhFjZbyXRIVWI1nWC2ZjHs0yu1HM2Hv04GxwXVxa+UuctRjiYNT//fPslO0JeO7df5p/6YDx/oteSC8ozuxUj8TaXbzfyobL2NeRnE6PrLUdetMPKJ3Nr22sX955s7Ul3Ka/EIf9nuQ246MIh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=wUuaVauM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BfmRhkxrsEs9tOM8wGbk7dXcVXNceBqTXcIhtt2SrKs=; b=wUuaVauMMR7ErCaLipgahv02uK
	f8zmYZUSkXrkSeIWVD+p2We+E7S0R1h/RkWnDRzYS23UkSGwmELAbRJJxSREYjeqifZdYxQ0MI7Y8
	whP1b+2iLCrarO1lAoXJmD7YCetyf1ykJN7sVe3HCohmhOOvBIYllaLsgF2qgYoPuJ6bpGVgIgYwX
	WVTBkowQ1Lmcdjvk4p6fM2kbY7LuhZft2NVC8ulf4OPzi+fEUEktbxyTH2D3vg2+jh6CBx75Obxt7
	6/7552MEzeebUdxzenriy13HTG10/jzbqdfcj+Rdt/3+FhTjfYrzTwilZk/MP+73IUGSCKVk2vREG
	7z5iDtNA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vICCw-00000007AxF-0Wo7;
	Sun, 09 Nov 2025 20:40:18 +0000
Date: Sun, 9 Nov 2025 20:40:18 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH v2 22/50] convert efivarfs
Message-ID: <20251109204018.GH2441659@ZenIV>
References: <20251028174540.GN2441659@ZenIV>
 <20251028210805.GP2441659@ZenIV>
 <CAMj1kXF6tvg6+CL_1x7h0HK1PoSGtxDjc0LQ1abGQBd5qrbffg@mail.gmail.com>
 <9f079d0c8cffb150c0decb673a12bfe1b835efc9.camel@HansenPartnership.com>
 <20251029193755.GU2441659@ZenIV>
 <CAMj1kXHnEq97bzt-C=zKJdV3BK3EDJCPz3Pfyk52p2735-4wFA@mail.gmail.com>
 <20251105-aufheben-ausmusterung-4588dab8c585@brauner>
 <423f5cc5352c54fc21e0570daeeddc4a58e74974.camel@HansenPartnership.com>
 <20251105-sohlen-fenster-e7c5af1204c4@brauner>
 <20251105-vorbild-zutreffen-fe00d1dd98db@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-vorbild-zutreffen-fe00d1dd98db@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Nov 05, 2025 at 02:43:34PM +0100, Christian Brauner wrote:

> -static void filesystems_freeze_callback(struct super_block *sb, void *unused)
> +static void filesystems_freeze_callback(struct super_block *sb, void *bool_freeze_all)
>  {
> +	bool freeze_all = *(bool *)bool_freeze_all;
> +
>  	if (!sb->s_op->freeze_fs && !sb->s_op->freeze_super)
>  		return;
>  
> +	if (!freeze_all) {

Minor nitpick: do we even need a dereference here?  Just check
whether the argument is NULL and adjust the caller...

