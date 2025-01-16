Return-Path: <linux-fsdevel+bounces-39436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA3AA141F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 20:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B80C16A7D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 19:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA6F230D02;
	Thu, 16 Jan 2025 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="GKbqlLA4";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="cOoGKG+D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0614D230981;
	Thu, 16 Jan 2025 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737054275; cv=none; b=M1VCA5heNqugqpZAfUqRWjDeQ4cdwx8chV9w3ec9OdlUXpmpAn+zhzGfBiEFcgHbt0ytXM2aoyRoKKBq4qvTHLIUrvRy3Q4hjYUbRw4UikPzE9DyonEWjabSe9rQFQJ0l63W2Z0qr9tsvkargVVk2mRXJ83din9fRdMXksiHUDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737054275; c=relaxed/simple;
	bh=apqhxwSIhDmRC+8R+thsQYxqT6Ve/LhqdvUwNbqBgvU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OGATsb/DYhNJtIeLd0o2qJK1yJvcs14jOIE1oYplDyhKyOe06B+HueIRt6wisdUkr+DSgLANLNxXIAMK/98k6lNsSPhxU0JR9B5NJBEOnx6xYKgqx++vsW3fP5HodpVgtwPNkzvMgpyLGnFYuSifc/3xBTTwCvNIut1rckufBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=GKbqlLA4; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=cOoGKG+D; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737054273;
	bh=apqhxwSIhDmRC+8R+thsQYxqT6Ve/LhqdvUwNbqBgvU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=GKbqlLA4JBZnfTnXrxOIwevi5bqQQFSNmd7ZGIRJLSnTaUcRSz1QpFN+bZvAMIfB8
	 39MqYb76lyVtcgT5ohQ9hRt4Wh5ZZWNVFIrNjfbFOwU5KgLwHC/pIHJIiOScP/MaMn
	 et5hR1RApao96iJaQMQ9gk1dn3qx3zMZaPUNEbVg=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1539012871E0;
	Thu, 16 Jan 2025 14:04:33 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ue6L5zeyBItq; Thu, 16 Jan 2025 14:04:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737054272;
	bh=apqhxwSIhDmRC+8R+thsQYxqT6Ve/LhqdvUwNbqBgvU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=cOoGKG+DjcGA8YAZVRPt9cFJIBu5wXXXs9IlL6CQzCdZzqMCgCbiVgac9hi6pvanh
	 DEmSallIj8ToSU1GF4eGaFZpDbPxsANykxcOGnt29yt6/+CKQea7ZfdIakTs1Lb58O
	 Qd454gIOL0lxtm8CJIuvldGXU7MHEIveCfh3By+U=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3772F12871CC;
	Thu, 16 Jan 2025 14:04:32 -0500 (EST)
Message-ID: <26411ea1c46a92cf3ac828b2ec09f26371959ed3.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 6/6] efivarfs: fix error on write to new variable
 leaving remnants
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, Ard Biesheuvel
	 <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, Christian Brauner
	 <brauner@kernel.org>
Date: Thu, 16 Jan 2025 14:04:27 -0500
In-Reply-To: <20250116185950.GL1977892@ZenIV>
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
	 <20250107023525.11466-7-James.Bottomley@HansenPartnership.com>
	 <20250116184517.GK1977892@ZenIV>
	 <1d9e199d1b518a6661dee197bc767b2272acb318.camel@HansenPartnership.com>
	 <20250116185950.GL1977892@ZenIV>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2025-01-16 at 18:59 +0000, Al Viro wrote:
> On Thu, Jan 16, 2025 at 01:54:44PM -0500, James Bottomley wrote:
> > On Thu, 2025-01-16 at 18:45 +0000, Al Viro wrote:
> > > On Mon, Jan 06, 2025 at 06:35:25PM -0800, James Bottomley wrote:
> > > 
> > > > +       inode_lock(inode);
> > > > +       if (d_unhashed(file->f_path.dentry)) {
> > > > +               /*
> > > > +                * file got removed; don't allow a set.  Caused by an
> > > > +                * unsuccessful create or successful delete write
> > > > +                * racing with us.
> > > > +                */
> > > > +               bytes = -EIO;
> > > > +               goto out;
> > > > +       }
> > > 
> > > Wouldn't the check for zero ->i_size work here?  Would be easier
> > > to follow...
> > 
> > Unfortunately not.  The pathway for creating a variable involves a
> > call to efivarfs_create() (create inode op) first, which would in
> > itself create a zero length file, then a call to
> > efivarfs_file_write(), so if we key here on zero length we'd never
> > be able to create new variables.
> > 
> > The idea behind the check is that delete could race with write and
> > if so, we can't resurrect the variable once it's been unhashed from
> > the directory, so we need to error out at that point.
> 
> D'oh...  Point, but it still feels as if you are misplacing the
> object state here ;-/
> 
> OK, so we have
>         * created, open but yet to be written into
>         * live
>         * removed
> 
> Might be better off with explicit state in efivar_entry...

OK, that would get rid of the race in efivarfs_file_release I'd been
worrying about where we can decide to remove the file under the inode
lock but have to make it unhashed after dropping the inode lock.

Regards,

James


