Return-Path: <linux-fsdevel+bounces-41176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18F2A2C043
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 11:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51EAC1689CB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 10:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33471DE4D8;
	Fri,  7 Feb 2025 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rhw8xQtD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E971DDC20;
	Fri,  7 Feb 2025 10:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738923177; cv=none; b=oklGDOMHqQeaHFbMLPvxXuwpA/qQ86sNGSPvvvQrqL4jbn1kG5EANbvJ15WOJ0befga9S/Jmm0mIRL2MHgZEuMMuKExSG0VPG/8IrsZzCg/yitZUz8WvAd6YsXvvGqDaGURoskuHx9MPUsXmUbl//r+picHRn6QGL1pA3FWlCDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738923177; c=relaxed/simple;
	bh=W2dmIg3oUDOm9DCScX49+gw8cLE6DvYRBcyiMfj1eLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmCWIZ23VYYE/hFz1Z+ha+5hwdEk6uCKenlRBlN1fd4dJmaMuyThSWhhktJYOBEQCoJHIhuJ8txopQTSU03cXn4SRp8JYps3XRNagdj7+4Ik59puq8tKwHw+MONPCIV2lqSxY5QX1tFvsmaY473VlgKPG+R4f9zj/MWxDIC4uoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rhw8xQtD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190D4C4CED1;
	Fri,  7 Feb 2025 10:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738923176;
	bh=W2dmIg3oUDOm9DCScX49+gw8cLE6DvYRBcyiMfj1eLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rhw8xQtDqC43RbxmIdKgcVomB30s290RM/r3W8i1L2+toVv+Z+uUK57ZGQHf0fOYJ
	 czo59tMjmuBeU5Ol6IRmdruDEArRRQyqLKthi8yMRl4NaCPdvtKCJ1qmkAJnOD8Wm5
	 ubq0vLm1TWR6urg7tW8ADDL31pTKQ65tdUTyvWErv2UzdUvq5/LD4lEVf1npa42fMO
	 KwzGqPLHem+MrsQPOGL+RM9WAItydmmohhrTvzKwO/KL0txZet0eyhTHDsPnVmeQC8
	 JVpYpjwhKakHLBfJ1Szk0V4f5Ze1UmsIWJQ+lh66blC4+ABYiT4Wk0neXo7zY35WFf
	 ZLpTq87K8O6vw==
Date: Fri, 7 Feb 2025 11:12:52 +0100
From: Christian Brauner <brauner@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jann Horn <jannh@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Luca Boccassi <luca.boccassi@gmail.com>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pidfs: improve ioctl handling
Message-ID: <20250207-lahmgelegt-zubringen-69a437fa5bd7@brauner>
References: <20250204-work-pidfs-ioctl-v1-1-04987d239575@kernel.org>
 <988727a0-fe48-4cc0-ab4c-20de01dbcddf@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <988727a0-fe48-4cc0-ab4c-20de01dbcddf@roeck-us.net>

On Thu, Feb 06, 2025 at 01:16:55PM -0800, Guenter Roeck wrote:
> On Tue, Feb 04, 2025 at 02:51:20PM +0100, Christian Brauner wrote:
> > Pidfs supports extensible and non-extensible ioctls. The extensible
> > ioctls need to check for the ioctl number itself not just the ioctl
> > command otherwise both backward- and forward compatibility are broken.
> > 
> > The pidfs ioctl handler also needs to look at the type of the ioctl
> > command to guard against cases where "[...] a daemon receives some
> > random file descriptor from a (potentially less privileged) client and
> > expects the FD to be of some specific type, it might call ioctl() on
> > this FD with some type-specific command and expect the call to fail if
> > the FD is of the wrong type; but due to the missing type check, the
> > kernel instead performs some action that userspace didn't expect."
> > (cf. [1]]
> > 
> > Reported-by: Jann Horn <jannh@google.com>
> > Cc: stable@vger.kernel.org # v6.13
> > Fixes: https://lore.kernel.org/r/CAG48ez2K9A5GwtgqO31u9ZL292we8ZwAA=TJwwEv7wRuJ3j4Lw@mail.gmail.com [1]
> 
> This is not a proper Fixes: tag.

Fixed.

