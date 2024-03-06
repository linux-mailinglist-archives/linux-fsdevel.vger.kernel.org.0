Return-Path: <linux-fsdevel+bounces-13738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A64887351F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 11:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CCB28ADA4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 10:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF866CDCD;
	Wed,  6 Mar 2024 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMte2EXg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59CA60DD5
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722629; cv=none; b=Rfe4blW4y2qwp1VMU0XHiLuVaJZvNF/Hj9fZPMqYbJcjIwjIJmpB40tit31rzEJYKx/leoFEPXzZi0R0skpUz3yPqeIuidgUq/B3e6xKBqZ1aoXeri6B8mZ7v/6xVBlwH/3pgn8PbJUht5WKFHLG1KVPke/VIl3/c1/AEE0OpXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722629; c=relaxed/simple;
	bh=4x6EUUDZlblXWIG4A5/bymkSMsFnK5nby+sVoCW1ZEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SiTNZhOonkRlWnIkDyJeev1QptzcsBtRjS73dCA7LhkzKEcS4l8SslKWnaDxMYStJdniYn+n7h+IbCSISk/5/eR94mF4KzwmJ/Ng7Q3Vj/iw70mNlE6aJU8EEZjcQ/YHsdyV6uzhAsFXVPVs0y5WKk0OoYzB0ZBnT7Ee/lm2xIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMte2EXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67351C433F1;
	Wed,  6 Mar 2024 10:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709722629;
	bh=4x6EUUDZlblXWIG4A5/bymkSMsFnK5nby+sVoCW1ZEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FMte2EXgpwAeslXECK45DwJHR6rKRRoF3AFQrrQ1ypkQB/IpbWdsOiR8fqrG8StqL
	 xsgBrfUveiJx39TZfrBLMhjVLpLBWQMeBJzAh+f2cHg4B5ERckMZ/rZKVKCl4ZAAVQ
	 INz59yjCdQo19z8EaQhRfZKPkqSj9jBlLi9DOrpQyGMqh/ds9t0ry48lWgI2M6Hecc
	 fozwZogez4mbjKtO5X+MfN3dSdsJCofz6jaouL6ktRmIahVnRhHIYYTiCKiioEMbmx
	 RKysMgGh8lfXbPhOP2agIBKk5tDVqBFlJXM+48yjNO+J46lsgkkNQBykblv2ASiAwE
	 IwEKfaPlJo3uw==
Date: Wed, 6 Mar 2024 11:57:04 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Bill O'Donnell <billodo@redhat.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/2] vfs: convert debugfs & tracefs to the new mount API
Message-ID: <20240306-luftleer-erfroren-e23738e89b41@brauner>
References: <cfdebcc3-b9de-4680-a764-6bdf37c0accb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cfdebcc3-b9de-4680-a764-6bdf37c0accb@redhat.com>

On Tue, Mar 05, 2024 at 05:07:29PM -0600, Eric Sandeen wrote:
> Since debugfs and tracefs are cut & pasted one way or the other,
> do these at the same time.
> 
> Both of these patches originated in dhowells' tree at
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=mount-api-viro
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=mount-api-viro&id=ec14be9e2aa76f63458466bba86256e123ec4e51
> and
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=mount-api-viro&id=c4f2e60465859e02a6e36ed618dbaea16de8c8e0
> 
> I've forward-ported them to the mount API that landed, and
> fixed up remounting; ->reconfigure() needed to copy the
> parsed context options into the current superblock options
> to effect any remount changes.
> 
> While these do use the invalf() functions for some errors, they
> are new messages, not messages that used to go to dmesg that
> would be lost if userspace isn't listening.
> 
> I've done minimal testing - booting with the patches, testing
> some of the remount behavior for mode & uid.
> Oh, and I built it too. </brown_paper_bag>

Looks ok to me.

