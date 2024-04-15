Return-Path: <linux-fsdevel+bounces-16895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AED98A465E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 02:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EE81F2185E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 00:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419E64A18;
	Mon, 15 Apr 2024 00:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o/Yre/Eq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E2F639;
	Mon, 15 Apr 2024 00:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713141322; cv=none; b=G1JNXQRUX3hc1kt1sQYvbmwl5CEcbz7SZXNMT4HxTqZZe4tRmenGwQzcCLQ5lj3JYhuB+yErHN8NWYm2zS1o+4fgfypg89/HclrZkkAuvo87oBC1f9OC5oxdXDW7wi7+hLy7OvmRDXIyu8WW9GAbGWoWn7U2958dwJxbt7vYXR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713141322; c=relaxed/simple;
	bh=eF4gUVmEWqxUGde3Qoo4hZPQVDGzxIk4yswdCgwHKYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnJAy25CAqUWvzyxyyNG0WN0rdlSxVA1ZEeOj024TXHl4/NSN8OM5gr+VZggxlH78U0RxJs5mZRk/rDsCArHm7eIBnsmtt3gioFFjpZLXqZIb6oTsvSav3K7B20L6fF4JJLau+aBr9HtbCt9Um0f7b6lEkFtJCopHKygXop+Ny8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o/Yre/Eq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=tSZ2znVGFEYYLYd8salQEdN1Czr767srg+/HVgkNDuQ=; b=o/Yre/EqOa5IgQwsRgc6zIiUj2
	brsb1oNT3IgNlnjCFoKoTycO0SyT7/cup1C+eXh7w2F3NTjbcD7aDZEFQyBbRAJcvfO2/bZsuZr3e
	46W9+8fBbxky6sprT60wofKVNVRzBCC7f84rujA6pIM/buIo30fqV2BLBVD6622YZyGy+jueL8jfl
	wFrQJZ3AUowx58Y9oxHsKLORQgFxVWhPD9P0OWS5flYFmYK9ySur0UMEAc+v8xNH9noFzf0hoN5q/
	repUy3ScloF+agBPuUAoJ+PVYwm1kVW0JII0vELCkl3zxaO1HKCN0fhRPMM8pyVJJsHV6l1ohuWfn
	0+0UjXRw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwAJR-0000000EYBv-23wK;
	Mon, 15 Apr 2024 00:35:09 +0000
Date: Mon, 15 Apr 2024 01:35:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH] module: ban '.', '..' as module names, ban '/' in module
 names
Message-ID: <Zhx2PfHjjTmjBZY8@casper.infradead.org>
References: <ee371cf7-69fa-4f9c-99b9-59bab86f25e4@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee371cf7-69fa-4f9c-99b9-59bab86f25e4@p183>

On Sun, Apr 14, 2024 at 10:05:05PM +0300, Alexey Dobriyan wrote:
> Any other subsystem should use nice helper function aptly named
> 
> 	string_is_vfs_ready()
> 
> and apply additional restrictions if necessary.
> 
> /proc/modules hints that newlines should be banned too,
> and \x1f, and whitespace, and similar looking characters 
> from different languages and emojis (except 🐧obviously).

I don't see the purpose of allowing any character in 0x01-0x1f.
How annoying to have BEL in there.  And, really, what's the value in
allowing characters after 0x7e?


