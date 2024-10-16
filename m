Return-Path: <linux-fsdevel+bounces-32117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE98C9A0C3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 16:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F97289E81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 14:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0F920F5B7;
	Wed, 16 Oct 2024 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="rA/Z3cyt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ABC20E022
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 14:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087255; cv=none; b=g/IZb2NxTmSzW81SpiDv7+XOds33k0JpOLguUPCvUN92oHVai3CJhPf5j7RW82BGR0c1yx5QrQkbCAisRM1/0EsSNksnX5LqbEuvP2fh9kqiPQ2wCQaWdiYynVBTfWP2RZtfcHuXovfgYP1c3Xpj3LJP9Z/wizYxeuISyJmmWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087255; c=relaxed/simple;
	bh=8fzIRUzMEp/M+4uVyX7kT2prkftlXCuQURP4L42YSj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txCLUhkuAtdnfKxi+CfJUNhPlDqfa8J1XoP2oioibxImQHcMCCn5eGa0YB9b08fnEsfaGAQFKq9tkPUMFeHO/lWZCLY/8FYs0JWEdMuIyXMjqbRVhbwvCPCm1wnzM9QRmIdzntSAHueZB5IYjD2wQtsbLKuXsTvHRiSmDdR3Gig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=rA/Z3cyt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oHL/sz5V4gpbg5Gf34J9UpVzaHkAp+WGrI3naf47XzE=; b=rA/Z3cytleFPebyiVbITsab/ei
	GJ7PJkSpcBrRoGPgq5kOcxpp+h9xQ2w+GfDw9qwvgCxTm1LGapUK8iXlrBsf+rbGgz6JgEjDErLR6
	7OVfkX31d+7l5IlNukI/FpgQGo0/nq0JFmgrUvaDg1fosVdVbVy59VQpQ1jWvUB3skIongD1E4+9K
	NC2wdWADdG02Oe9m42sW1o4zwGUMsMYoGwHzIZPUg29QiYoU3X/rhDxwZeRAiaD2nDo09TekH/Kr0
	Hw4ZOS8ztlqk+pESiOFSjD8CswLFx1ldPqAYlYsOVk1QbFgZ6pL3D9OnEhJzWwVIWUybZqd2ET+UZ
	fwG+WJMA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t14a2-00000004QGq-3X8h;
	Wed, 16 Oct 2024 14:00:50 +0000
Date: Wed, 16 Oct 2024 15:00:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241016140050.GI4017910@ZenIV>
References: <20241009040316.GY4017910@ZenIV>
 <20241015-falter-zuziehen-30594fd1e1c0@brauner>
 <20241016050908.GH4017910@ZenIV>
 <20241016-reingehen-glanz-809bd92bf4ab@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016-reingehen-glanz-809bd92bf4ab@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Oct 16, 2024 at 10:32:16AM +0200, Christian Brauner wrote:

> > ended up calling user_path_at() with empty pathname and nothing like LOOKUP_EMPTY
> > in lookup_flags.  Which bails out with -ENOENT, since getname() in there does
> > so.  My variant bails out with -EBADF and I'd argue that neither is correct.
> > 
> > Not sure what's the sane solution here, need to think for a while...
> 
> Fwiw, in the other thread we concluded to just not care about AT_FDCWD with "".
> And so far I agree with that.

Subject:?

