Return-Path: <linux-fsdevel+bounces-12787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4428672EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 12:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99AE284FB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 11:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9552F1D532;
	Mon, 26 Feb 2024 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb1ZZBRT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5791CFAD
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708946489; cv=none; b=qj1mvOmdc0NGi5T6BS5O/YH6RDMeZChgepjMCqlgYVD/miJ8AN71plzy/Yqda9P6LRVd3ZAaRVP6CC1m21YpSset/H5O1fcZw3uSP7+O+o+oMGATqao85DAalE1JDPmpS5YgoUuNioOLEKfZd1vIoksMnuXS+IqC1bCIbZFpb0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708946489; c=relaxed/simple;
	bh=rIag9Nc9+N9HgJpSJVuEFI/qflV5j4vpNniiYXReSB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLmMUnvQd5S2vR8Fi881X/qJCwR2suY0i6L6k0EryWBQcMNz5yOSEQmllb+hs0Fo/hUh+L50aqreta9ipeoPwwYB652dNfKra1i1GbShJUBoDjGID8I6vhGrlRRWRJUlMK10XX3TayrL3JRjy8mWz006EN+LrEkj7ez91HYYooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb1ZZBRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94696C433C7;
	Mon, 26 Feb 2024 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708946488;
	bh=rIag9Nc9+N9HgJpSJVuEFI/qflV5j4vpNniiYXReSB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kb1ZZBRTXZfNjIdbXKiacalsaK91RGJ6ABlTEnXsb6XpUCampscw71dRYYcjRy8v6
	 81Q/vb2SdlcHdbcV1gk2CaTS46fI3MmEfb24juuqYVyGwAuuVbjvIwxNVdD0nq9oAJ
	 2/eKT7ivAcYzh67M8vzkvy35RoJrFpj+LumQX6Yo9osoH5669Bmh4dmaDhfbj3IA3Z
	 Q5aOvV+wiCyqKwwcJKpdB2BLlMseB7/bADbN8ZbwYHpl4xetmiPS6OcbOrSrd44i6d
	 6wFrrz5xiWeI57TBiRTPQezAne2R8w9kJTF2z1dyS7iIWkdwPrgP6FS08CcvV9CwGo
	 mVhSEp2fT+LYQ==
Date: Mon, 26 Feb 2024 12:21:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Alexander Viro <aviro@redhat.com>, 
	Bill O'Donnell <billodo@redhat.com>, Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH RFC] vfs: always log mount API fs context messages to
 dmesg
Message-ID: <20240226-abprallen-umverteilen-a464fb978488@brauner>
References: <9934ed50-5760-4326-a921-cee0239355b0@redhat.com>
 <20240223-beraten-pilzbefall-6ca15beab35b@brauner>
 <4dd8f956-ab65-4c46-995c-892fa9cca283@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4dd8f956-ab65-4c46-995c-892fa9cca283@sandeen.net>

On Fri, Feb 23, 2024 at 10:27:54AM -0600, Eric Sandeen wrote:
> On 2/23/24 9:06 AM, Christian Brauner wrote:
> > On Thu, Feb 22, 2024 at 09:22:52AM -0600, Eric Sandeen wrote:
> >> As filesystems are converted to the new mount API, informational messages,
> >> errors, and warnings are being routed through infof, errorf, and warnf
> >> type functions provided by the mount API, which places these messages in
> >> the log buffer associated with the filesystem context rather than
> >> in the kernel log / dmesg.
> >>
> >> However, userspace is not yet extracting these messages, so they are
> >> essentially getting lost. mount(8) still refers the user to dmesg(1)
> >> on failure.
> > 
> > I mean sure we can do this. But we should try without a Kconfig option
> > for this.
> > 
> > But mount(8) and util-linux have been switched to the new mount api in
> > v2.39 and libmount already has the code to read and print the error
> > messages:
> > 
> > https://github.com/util-linux/util-linux/blob/7ca98ca6aab919f271a15e40276cbb411e62f0e4/libmount/src/hook_mount.c#L68
> 
> *nod*
> 
> > but it's hidden behind DEBUG.
> 
> Yup.
> 
> > So to me it seems much easier to just make
> > util-linux and log those extra messages than start putting them into
> > dmesg. Can't we try that first?
> 
> Sounds fine. Since we're trying to get a few more filesystems
> converted (hopefully all!) I just wanted to be sure that doing so
> doesn't end up losing useful information for the user.

I see.

