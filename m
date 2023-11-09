Return-Path: <linux-fsdevel+bounces-2631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 515357E72FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 21:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE199B20DB7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 20:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AB8200C1;
	Thu,  9 Nov 2023 20:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hA867jNY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F3A22329
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 20:39:30 +0000 (UTC)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104F430C0
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 12:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6pqI2L3TlB2g3jnH7sVrWgkAyDUiPpqTzF3Ggh40SNE=; b=hA867jNY+M8DMNTYcOr/+yfD5q
	v73INQtXKILFMMmWKgjEAe5QVyQDWyCCeBGuXjLg85DJ8qPOen/QPq8TLktgXGwbIjtErRBXq/EJE
	E+0kpAmwe2TCXCL6p6+VyrmX6s4oCiqJNVHf0oajTQVLi0h3dG93dl9LoCH9/jm0zGOpqZpMPAtx8
	z3rINq1MkRLBozOYEQOzxfctkc7f22HEtKw7ZTYEidZXW8EQN2a5wXg4exI2AmWlzwO10spItQLwu
	Ws7Jut7afB5AUGfMCOgQihoc24pPmlAwahsRxIYhbeQw/UG/rzfsSSC4xfB+wh7UKkPgNoUaTYIPc
	DwEx9ldg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r1BoF-00DZvC-01;
	Thu, 09 Nov 2023 20:39:27 +0000
Date: Thu, 9 Nov 2023 20:39:26 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/22] fast_dput(): handle underflows gracefully
Message-ID: <20231109203926.GE1957730@ZenIV>
References: <20231109061932.GA3181489@ZenIV>
 <20231109062056.3181775-1-viro@zeniv.linux.org.uk>
 <20231109062056.3181775-9-viro@zeniv.linux.org.uk>
 <20231109-ansetzen-waben-e4559960285c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109-ansetzen-waben-e4559960285c@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 09, 2023 at 03:46:21PM +0100, Christian Brauner wrote:
> On Thu, Nov 09, 2023 at 06:20:43AM +0000, Al Viro wrote:
> > If refcount is less than 1, we should just warn, unlock dentry and
> > return true, so that the caller doesn't try to do anything else.
> 
> That's effectively to guard against bugs in filesystems, not in dcache
> itself, right? Have we observed this frequently?

Hard to tell - it doesn't happen often, but... extra dput() somewhere
is not an impossible class of bugs.  I remember running into that
while doing work in namei.c, I certainly have seen failure exits in
random places that fucked refcounting up by dropping the wrong things.

