Return-Path: <linux-fsdevel+bounces-38685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880B1A06855
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 23:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392211887519
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 22:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4983B1F708D;
	Wed,  8 Jan 2025 22:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K8lf6LFG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A33519EEBF
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jan 2025 22:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736375588; cv=none; b=gz7LcW2JW78hH7/O1MD0Ujedh3NzquUeoQSwinvUZm79y/HGrE5mMhXMrwuobhAwp89vrK7kJ9QZgQ86P/KfSSGluaIpb7SGOtjCjYwRlgq0wF3gnNLJa8LmjMlKvFSqF3eOdR6Lzv5nNKP1twOQehhctikAVJ/UJHMWYyT5qcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736375588; c=relaxed/simple;
	bh=+XCdhkvJJBSHqah3SNT1OriGy95I/Ptkbg7uA0OQFjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kz9XZwuhVK9m3+9kMQPonzz7GocbQV8aez0JL23vcnCMo3uQmMdRWITY5QY/IF0PFXmbCUWYIGqcc0p7NdUk+kFw3VOcje+PMeEib+VaSFSjDR5/k5vJOSGXdrkxmupsqDIIc5lV/JpFnrG1vdfjzc0/XZ/ZtU5MYIaIRzRvz6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K8lf6LFG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736375583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c44KyEVCOMuFpkcL9WOxByu7CVhuh3eisHK6Uj0dfDk=;
	b=K8lf6LFGuQcKY2a56UBCW3HM681eHjAxLjBIQrP1bgpDLa4YFZ+7GQ8WPwXnxktFBhQk/G
	mzA7jeAApYagDyewHEBlBjuiZezjFqa5j32PLt6qvMFh1/AsyOu0NibpJ8SP8K76zdwbdT
	E6BoEFD8BUoZqYX0hZ9HT5dAeowrf6Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-vIitAdTfNIeLF_33r0voSg-1; Wed,
 08 Jan 2025 17:33:00 -0500
X-MC-Unique: vIitAdTfNIeLF_33r0voSg-1
X-Mimecast-MFC-AGG-ID: vIitAdTfNIeLF_33r0voSg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4442219560B7;
	Wed,  8 Jan 2025 22:32:59 +0000 (UTC)
Received: from redhat.com (unknown [10.22.65.133])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2298E19560AD;
	Wed,  8 Jan 2025 22:32:57 +0000 (UTC)
Date: Wed, 8 Jan 2025 16:32:55 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] sysv: Remove the filesystem
Message-ID: <Z379F9ymCnMB2vt2@redhat.com>
References: <20250106162401.21156-1-jack@suse.cz>
 <20250107-wahrt-veredeln-84a1838928e8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107-wahrt-veredeln-84a1838928e8@brauner>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Tue, Jan 07, 2025 at 03:35:35PM +0100, Christian Brauner wrote:
> On Mon, Jan 06, 2025 at 05:24:01PM +0100, Jan Kara wrote:
> > Since 2002 (change "Replace BKL for chain locking with sysvfs-private
> > rwlock") the sysv filesystem was doing IO under a rwlock in its
> > get_block() function (yes, a non-sleepable lock hold over a function
> > used to read inode metadata for all reads and writes).  Nobody noticed
> > until syzbot in 2023 [1]. This shows nobody is using the filesystem.
> > Just drop it.
> > 
> > [1] https://lore.kernel.org/all/0000000000000ccf9a05ee84f5b0@google.com/
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  What do people think about this? Or should we perhaps go through a (short)
> >  deprecation period where we warn about removal?
> 
> Let's try and kill it. We can always put it back if we have to.
> 
So should any work toward converting sysv to the new mount API stop? ;)
Thanks-
Bill


