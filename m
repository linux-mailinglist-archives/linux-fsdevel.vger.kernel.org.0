Return-Path: <linux-fsdevel+bounces-42018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85525A3AC57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 00:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2D5175617
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2025 23:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C281DB37B;
	Tue, 18 Feb 2025 23:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRdA03wr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1E32862B7;
	Tue, 18 Feb 2025 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739920017; cv=none; b=sijYroweCq0RmC7cvCR0dRj3HwPaHG+c4cbiEXdzU/Nges5Sn3JwmaBaQMesythjPtElTWMlpNvalIAi6R5SR6AWiYpIqyx/Ms/AXiGCwGVtMln3p4yE6U1vSOvuvwJazs1YldqgevSwINb4x0pxtcCH6ja3AtPyPNNC/0q+kUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739920017; c=relaxed/simple;
	bh=XjJ7I+jIGdeY9vOy9NYF19tpQmyUregmGJlukIni29g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbTi4FTMvq6eLapSUOS1yIXkU6FAt8kFpm4EEf4or/ui6GyM1BH8YzvcnkF2RSP5klszWK0yePQ18TjFLpc8qK0PMCxJTXYxnb2uIVV0kOxNhfMDFBCwIKY1RlNoD7WLpOZqQhmVxPMh66V8wPtkcVjq51gtVVi9Z9qul4uOOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRdA03wr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04BFC4CEE2;
	Tue, 18 Feb 2025 23:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739920016;
	bh=XjJ7I+jIGdeY9vOy9NYF19tpQmyUregmGJlukIni29g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cRdA03wrhmh0Z67dvZeYvv0z4lKtZVySVfFFLG//fz7rVuX6jieSFXZQ2XwoJiqmO
	 SzL007jrWcN0m54LgpuQBUIPMK2aFpMEl1afC5nKbMS8AKedlZA18EGQD4MUozFPGt
	 MzXALowKwoXuYxrF4V5Ube6MRqU7iUU+3zf/dbv7L0bB4g1sLUVdk/t/Cv3MuXmkPW
	 I24VDr4QPPyq7dd131pe/7EuDHIiULZ6h1g51tqhqzNkB0GiQEPz51KyN/Nmyvyh1g
	 8JymjhjymFm8hVJrB6UKLkoPq1+2yMEBwPwviX7gU2gezmagVAglWCY7G19arEzqzi
	 TVkehzz9g2q9g==
Received: by pali.im (Postfix)
	id 0C7997EF; Wed, 19 Feb 2025 00:06:43 +0100 (CET)
Date: Wed, 19 Feb 2025 00:06:43 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Eric Biggers <ebiggers@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] fs: Add FS_XFLAG_COMPRESSED & FS_XFLAG_ENCRYPTED
 for FS_IOC_FS[GS]ETXATTR API
Message-ID: <20250218230643.fuc546ntkq3nnnom@pali>
References: <20250216164029.20673-1-pali@kernel.org>
 <20250216164029.20673-2-pali@kernel.org>
 <20250216183432.GA2404@sol.localdomain>
 <CAOQ4uxigYpzpttfaRc=xAxJc=f2bz89_eCideuftf3egTiE+3A@mail.gmail.com>
 <20250216202441.d3re7lfky6bcozkv@pali>
 <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>
 <Z7Pjb5tI6jJDlFZn@dread.disaster.area>
 <CAOQ4uxh6aWO7Emygi=dXCE3auDcZZCmDP+jmjhgdffuz1Vx6uQ@mail.gmail.com>
 <20250218192701.4q22uaqdyjxfp4p3@pali>
 <Z7UQHL5odYOBqAvo@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z7UQHL5odYOBqAvo@dread.disaster.area>
User-Agent: NeoMutt/20180716

On Wednesday 19 February 2025 09:56:28 Dave Chinner wrote:
> On Tue, Feb 18, 2025 at 08:27:01PM +0100, Pali Rohár wrote:
> > On Tuesday 18 February 2025 10:13:46 Amir Goldstein wrote:
> > > > and there is no need for whacky field
> > > > masks or anything like that. All it needs is a single bit to
> > > > indicate if the windows attributes are supported, and they are all
> > > > implemented as normal FS_XFLAG fields in the fsx_xflags field.
> > > >
> > 
> > If MS adds 3 new attributes then we cannot add them to fsx_xflags
> > because all bits of fsx_xflags would be exhausted.
> 
> And then we can discuss how to extend the fsxattr structure to
> implement more flags.
> 
> In this scenario we'd also need another flag bit to indicate that
> there is a second set of windows attributes that are supported...
> 
> i.e. this isn't a problem we need to solve right now.

Ok, that is possible solution for now.

> > Just having only one FS_XFLAGS_HAS_WIN_ATTRS flag for determining windows
> > attribute support is not enough, as it would not say anything useful for
> > userspace.
> 
> IDGI.
> 
> That flag is only needed to tell userspace "this filesystem supports
> windows attributes". Then GET will return the ones that are set,
> and SET will return -EINVAL for those that it can't set (e.g.
> compress, encrypt). What more does userspace actually need?

Userspace backup utility would like to backup as many attributes as
possible by what is supported by the target filesystem. What would such
utility would do if the target filesystem supports only HIDDEN
attribute, and source file has all windows attributes set? It would be
needed to issue 2*N syscalls in the worst case to set attributes.
It would be combination of GET+SET for every one windows attribute
because userspace does not know what is supported and what not.

IMHO this is suboptimal. If filesystem would provide API to get list of
supported attributes then this can be done by 2-3 syscalls.

