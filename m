Return-Path: <linux-fsdevel+bounces-43722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9FFA5CC55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 18:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D83117A2FFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 17:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83757262814;
	Tue, 11 Mar 2025 17:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="A8Rdllsd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A71D514A;
	Tue, 11 Mar 2025 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714566; cv=none; b=mdO6oU/3JPMbAScQVlZYNZ/EV7KBTzboPMHlh6xYSNTTnoRYSZdvFOOaG8tJv9e0LfQfujuWrAjAs4AKJuOUCST7L3DM0JDwWTQxCG6DGN1GatV2LvC7JPtGIidrYSNihlbEO2Auho5krbAGUendnj24e1oDCElqqZHvTYWV2RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714566; c=relaxed/simple;
	bh=r9K/pML2QKrZ+VFIBeJGG95PlHUmfh65fiY4g/AjTqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qL935GjycpWcucXJLoa53/rE/PbgtB+NjBbBUYsUGob4/F/sCoShz02SVyTwyvkJF0oHdlvh190LyC5J/YjB0CGBHDisYLs3PypkZfyXrLcf9/vo7PdxMSlYkc3/9EtEuuK0t+omHD1qTkDlxK9lXb+N4KHwcE4PFsp1QE2OZtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=A8Rdllsd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OMTqX1o+mGTjuVFcJ948EuV68SMrVJ8x+VxsJfNM8nk=; b=A8RdllsdVK9vhYKqVOWSWPwZQJ
	maMEZ02XtjDWlUtyBRjGaoTeWgY8HZTRbJ8Vx/vh4n9I+IW4+WNyPfy9St/cq7LVTbtLt0bw3ol9O
	6yvRXKGPEXog8g5y6TgXbkzADSRfl5mk8ptpXdMgkg4tFcKT6KI9wfLwKMekcQ52nzAT+F8Sfo+gd
	v7wo+sPi0fqMfc6l7w6uId6DCYHqaZOxNe+2OgClGePuYXIFHmYlsLMvvTyPeqUHH0SmK/70ChaxS
	KsH4Y5XEEL8hJJ9PLDleqnRfL91gGMc65gv6OmEy5G7DxcSRJvw1r8ls56kR/PfxSuU05LZ4UBKkL
	LA9mfjMg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1ts3WK-00000004y1K-2bOC;
	Tue, 11 Mar 2025 17:36:00 +0000
Date: Tue, 11 Mar 2025 17:36:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Demi Marie Obenour <demi@invisiblethingslab.com>, cve@kernel.org,
	gnoack@google.com, gregkh@linuxfoundation.org,
	kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, mic@digikod.net,
	Demi Marie Obenour <demiobenour@gmail.com>
Subject: Re: Unprivileged filesystem mounts
Message-ID: <20250311173600.GR2023217@ZenIV>
References: <Z8948cR5aka4Cc5g@dread.disaster.area>
 <20250311021957.2887-1-demi@invisiblethingslab.com>
 <Z8_Q4nOR5X3iZq3j@dread.disaster.area>
 <20250311-desillusionieren-goldfisch-0c2ce3194e68@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311-desillusionieren-goldfisch-0c2ce3194e68@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Mar 11, 2025 at 12:01:48PM +0100, Christian Brauner wrote:

> The case where arbitrary devices stuck into a laptop (e.g., USB sticks)
> are mounted isn't solved by making a filesystem mountable unprivileged.
> The mounted device cannot show up in the global mount namespace
> somewhere since the user doesn't own the initial mount+user namespace.
> So it's pointless. In other words, there's filesystem level checks and
> mount namespace based checks. Circumventing that restriction means that
> any user can just mount the device at any location in the global mount
> namespace and therefore simply overmount other stuff.

Note that "untrusted contents" is not the worst thing you can run into -
it can be content changing behind your back.  I seriously doubt that
anyone fuzzes for that kind of crap (and no, it's not an invitation to
start).  I seriously doubt that there's any local filesystem that would
be resilent to that...

