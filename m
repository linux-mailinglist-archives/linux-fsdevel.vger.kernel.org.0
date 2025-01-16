Return-Path: <linux-fsdevel+bounces-39433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6658A141E0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 19:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A643A6C05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 18:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC168234D0D;
	Thu, 16 Jan 2025 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="IM/P+qgv";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="IM/P+qgv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [104.223.66.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6672E234CE4;
	Thu, 16 Jan 2025 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.223.66.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737053690; cv=none; b=FIg5ZSS2bBmStyuXgNNIbeCVahgEuQVj/F61X+Aiazyzoie3YX5A71bs7elkWN7UN0KEtS3seXdXGVy6N/OJefojJL1ZxMaaOAmkWw7dWC0fmY4/3ayjK5fVJuBHW/k8VxOs7zzys5542Eao9zsVQ1OFRJQJErVWzUOqfLIDjIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737053690; c=relaxed/simple;
	bh=ad7sNV4YCydUq8bUoTWGvzwZNPp9IfcF4/wiMyIUDM0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GIb3SQxDL1k9Jj104u4/snBF0MFX0hSbWohh65XyeiG1+GVp3C1oSN+bGVoUWMN7qr7f8VgZZNagssaKPk+tYj0eOGQjfcKqsM/j1uMQbe3MvcoA8ZM+VGWYCuJI32o8nuiZwW4vBpB/gDpzzpm/98nenjEkEpod29ttvNkoers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=IM/P+qgv; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=IM/P+qgv; arc=none smtp.client-ip=104.223.66.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737053687;
	bh=ad7sNV4YCydUq8bUoTWGvzwZNPp9IfcF4/wiMyIUDM0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=IM/P+qgvbgap2x7hYSB0E5S1hdLRK18h71VbL/kf6jmX/NydT7SZ7clTKCuFtETSU
	 XQhnSgsUbHtc/XTiDYijzSg9FrLI/J+GF964y4CfRZvuyhtB4SqVXA/VmvYRoclds2
	 0fD5u2cit5VrV4qVX3CY+3Bs9wYmhMdO7lhs1GUg=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 9262A128708E;
	Thu, 16 Jan 2025 13:54:47 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 008G4XocDZ2u; Thu, 16 Jan 2025 13:54:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1737053687;
	bh=ad7sNV4YCydUq8bUoTWGvzwZNPp9IfcF4/wiMyIUDM0=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=IM/P+qgvbgap2x7hYSB0E5S1hdLRK18h71VbL/kf6jmX/NydT7SZ7clTKCuFtETSU
	 XQhnSgsUbHtc/XTiDYijzSg9FrLI/J+GF964y4CfRZvuyhtB4SqVXA/VmvYRoclds2
	 0fD5u2cit5VrV4qVX3CY+3Bs9wYmhMdO7lhs1GUg=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::db7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 937061287074;
	Thu, 16 Jan 2025 13:54:46 -0500 (EST)
Message-ID: <1d9e199d1b518a6661dee197bc767b2272acb318.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 6/6] efivarfs: fix error on write to new variable
 leaving remnants
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org, Ard Biesheuvel
	 <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, Christian Brauner
	 <brauner@kernel.org>
Date: Thu, 16 Jan 2025 13:54:44 -0500
In-Reply-To: <20250116184517.GK1977892@ZenIV>
References: <20250107023525.11466-1-James.Bottomley@HansenPartnership.com>
	 <20250107023525.11466-7-James.Bottomley@HansenPartnership.com>
	 <20250116184517.GK1977892@ZenIV>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2025-01-16 at 18:45 +0000, Al Viro wrote:
> On Mon, Jan 06, 2025 at 06:35:25PM -0800, James Bottomley wrote:
> 
> > +       inode_lock(inode);
> > +       if (d_unhashed(file->f_path.dentry)) {
> > +               /*
> > +                * file got removed; don't allow a set.  Caused by
> > an
> > +                * unsuccessful create or successful delete write
> > +                * racing with us.
> > +                */
> > +               bytes = -EIO;
> > +               goto out;
> > +       }
> 
> Wouldn't the check for zero ->i_size work here?  Would be easier to
> follow...

Unfortunately not.  The pathway for creating a variable involves a call
to efivarfs_create() (create inode op) first, which would in itself
create a zero length file, then a call to efivarfs_file_write(), so if
we key here on zero length we'd never be able to create new variables.

The idea behind the check is that delete could race with write and if
so, we can't resurrect the variable once it's been unhashed from the
directory, so we need to error out at that point.

Regards,

James


