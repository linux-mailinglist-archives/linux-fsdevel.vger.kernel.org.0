Return-Path: <linux-fsdevel+bounces-2969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEBE7EE529
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 17:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9571C20A4F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Nov 2023 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50ED73C49F;
	Thu, 16 Nov 2023 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IP30y1Rw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2C0192;
	Thu, 16 Nov 2023 08:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=riSOf1KJYcYJX7tHfAe0adOVWJZiKuCUfRcm155CnM4=; b=IP30y1RwxmI6dfMPL49NEoB/nU
	8dSBXzV7GSaQs5i2bwkZqwze/tORGXYcRI0fbYszRpeyck/RyXuUhcsQTdRRxO7kkBJDp3y9Z26/Y
	hFwAfcc1NTlhk+A+XfNAjY1dYrzIdiLS8mGiwxJNn6F9GNaE2TjoDc2oM4etMe6tyMYavyuw2CGYL
	jbXEUf1nDiu6xhzS6vqPLSfG1wgEO1U0BFRq6BomTlNHUefIVXLSSoNMx3bWsGPdKzGroYyE+qLiX
	r0LgeUQSUMhRIt4irV+5tvGQpCl+O9CNCo+U6mGRwtXPIgLGqD/P2lRAilVBDK9yLhomRce4ZYXfE
	4a6KCZBg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r3fDy-00GfeW-1X;
	Thu, 16 Nov 2023 16:28:14 +0000
Date: Thu, 16 Nov 2023 16:28:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jeff Layton <jlayton@kernel.org>
Cc: Xiubo Li <xiubli@redhat.com>, linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: Re: [deadlock or dead code] ceph_encode_dentry_release() misuse of
 dget()
Message-ID: <20231116162814.GA1957730@ZenIV>
References: <20231116081919.GZ1957730@ZenIV>
 <44265305e099888191aa7482743f0fa7900e8336.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44265305e099888191aa7482743f0fa7900e8336.camel@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Nov 16, 2023 at 07:50:03AM -0500, Jeff Layton wrote:

> > Am I missing something subtle here?  Looks like that dget() is never
> > reached...
> 
> No, I think you're correct. That looks like dead code to me too.
> Probably we can just remove that "if (!dir)" condition altogether.
> 
> Did you want to send a patch, or would you rather Xiubo or I do it?

Up to you...  AFAICS, it had been dead code since ca6c8ae0f793 "ceph: pass
parent inode info to ceph_encode_dentry_release if we have it".  In other
words, that "if we have it" had already been true at that point.  Prior
to that commit dget() in there had been unconditional (and really a deadlock
fodder); making it conditional had made it actually unreachable and that
fixed the actual bug.

