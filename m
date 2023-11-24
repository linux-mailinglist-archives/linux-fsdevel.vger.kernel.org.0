Return-Path: <linux-fsdevel+bounces-3652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F39157F6D41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 08:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313CD1C20E11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051F19465;
	Fri, 24 Nov 2023 07:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uXCBppqR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E4FD4E;
	Thu, 23 Nov 2023 23:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=SpnOTVFE3iMqz3KRySppqp/Q/IzJfp9bgY48+5Sf17o=; b=uXCBppqR0PWBWuVqHPbwN/k+sW
	GgH3oXcHjTtzGlFmeN1H5YGPIX7jqKrtnIUR6LRXMNixFVX9ONXc0jrwZtSGQq9hk6YPzrf37QhWt
	WamxFoelqO9TT3zqWrySVbI4CGDHEdAVMHn1b/0z6ZuZS6uYdhIxbQxLFoFNvYz4MtlEkWJjmBTHO
	Wd8oWzGxOVnMlVIwddQcjI6dV9eebpep4/URkwjyhnNI/pOWpLIiUdVGlAso22NyhdJlu5NaXn8LH
	9ICgdwB9Gk1mccLNWo/oBN7pMQQqVeX840xDLhqhsYiBjM85w8FamxLKswTyhYcR+UXjkFhN+1UGW
	iTihpb4Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6R1p-002S76-2h;
	Fri, 24 Nov 2023 07:55:10 +0000
Date: Fri, 24 Nov 2023 07:55:09 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/21] dentry: switch the lists of children to hlist
Message-ID: <20231124075509.GU38156@ZenIV>
References: <20231124060200.GR38156@ZenIV>
 <20231124060422.576198-1-viro@zeniv.linux.org.uk>
 <20231124060422.576198-3-viro@zeniv.linux.org.uk>
 <CAOQ4uxjyS45FKJORfxpMHeFbZhszNR2QM6nTF46UxT1iz85Gsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjyS45FKJORfxpMHeFbZhszNR2QM6nTF46UxT1iz85Gsg@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Nov 24, 2023 at 09:44:27AM +0200, Amir Goldstein wrote:
> On Fri, Nov 24, 2023 at 8:05 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Saves a pointer per struct dentry and actually makes the things less
> > clumsy.  Cleaned the d_walk() and dcache_readdir() a bit by use
> > of hlist_for_... iterators.
> >
> > A couple of new helpers - d_first_child() and d_next_sibling(),
> > to make the expressions less awful.
> >
> > X-fuck-kABI: gladly
> 
> ???

It breaks kABI.  Hard.  For a good reason.  And if you need an elaboration
of the reasons why kABI is, er, not universally liked - let's take it
to private email.  Some rants are really too unprintable for maillists...

