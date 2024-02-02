Return-Path: <linux-fsdevel+bounces-10076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20306847909
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D726F2962F3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 19:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB9F12C7E6;
	Fri,  2 Feb 2024 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fnIM5S8M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746F012C7E5;
	Fri,  2 Feb 2024 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899821; cv=none; b=nP8qBn2zhEmAd1KDzN+HNxLgyt8hy6oBYzau66g8p0NNThapxTGcpRVB2EO4FSeGRNn7aP1KbGLl0QImo1Z0RHKAM2gbTpz6v1iaxdWHP/agMf2v4e/gAxA+jCeZHZv5xnsNHVgq0k8OpwXFgeQ8EHdccnZ903RF17mFrosUFz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899821; c=relaxed/simple;
	bh=fzeY1VlgvPi47dk0X+uJv+op+kqkPwqjm2YRFBDKUuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/4ADOJUSJXmx/vI2siVRWC7HNPWJT778i9E/uHtqs5H6lpim7dZSVycalXqf0HdVMTuSaVLhaaVcxauKLwbn7mA7ZRa9Ow1XtpzyQjq9nRqPwG/k2VaM+X5VkE939cM7iymTUXMpBiR+g6aGREDNrUUp22BqQBs9fEmX7p4u0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fnIM5S8M; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WB1XmSi8bTlEku4b4dtz4QsMpA2q7ThsMTrffyCD+dw=; b=fnIM5S8Mazi6ZPXYoBdBoOw+Tn
	6tVuTorfFW591FhwOJRTmIR4vjOMMKPSWVMS9hBbdEaDHAFRZQtgaJ+HT0sH5po91vHLFvgsIcpM2
	aeEhZz0xwwZ8p/nCTw+MeZ4tKcpODkFQwiIxfsYJjV/wwe/j5ufQ+LP2iDBzle+6VN1e7hOlF1OeI
	GqOooAiee9YkcDJS/RvhmfVaupqOvrLOGTY2lCWbNwmZtWUEsiSR+O7MiJcnhpHz9MLQwNYEmYKfA
	WFFyADeendL88hHn/pfqt8KzUEoLEYDkK+zWOQYhnJRgnzz4ugo8OzrfRmRTtWmiBliJ2Je6zv7i/
	HRv+UOGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rVyc6-004BKo-1h;
	Fri, 02 Feb 2024 18:50:10 +0000
Date: Fri, 2 Feb 2024 18:50:10 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-unionfs@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fs: remove the inode argument to ->d_real() method
Message-ID: <20240202185010.GG2087318@ZenIV>
References: <20240202110132.1584111-1-amir73il@gmail.com>
 <20240202110132.1584111-3-amir73il@gmail.com>
 <20240202160509.GZ2087318@ZenIV>
 <20240202161601.GA976131@ZenIV>
 <063577b8-3d7f-4a7f-8ed7-332601c98122@linux.ibm.com>
 <20240202182732.GE2087318@ZenIV>
 <4662633b-47c0-469f-9578-8597bcc65703@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4662633b-47c0-469f-9578-8597bcc65703@linux.ibm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 02, 2024 at 01:32:39PM -0500, Stefan Berger wrote:

> I can take it from here unless you want to formally post it.

Less headache for me that way, but you want to test it - all
I've checked is that the damn thing compiles, and while it's
hard to fuck up and I don't see any brainos in there...
I'm way too low on caffeine at the moment.  It should be
safe from races, just verifying that it prints the right thing
when you hit that codepath would be enough.

