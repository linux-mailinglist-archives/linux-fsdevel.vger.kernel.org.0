Return-Path: <linux-fsdevel+bounces-38763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2254A0834B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 00:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86BB168097
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 23:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484E6205AD7;
	Thu,  9 Jan 2025 23:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KubCwfOa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A6A171658
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2025 23:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736464144; cv=none; b=BopvvrOLN5h+5+GV5G3hxGZ7ZlrwqlUHglhMdmh6V3CgpWpgjr9nOCCbz/XckbAWK9qGUl+s9FX1iL15yhA7n2A0vd5FhTrafd4rdFdq8z878HdirlyZWdNfTSG5PhE9b+gdPc0j7jh/NNfAUpYubzFH59M8IGVH99bWMBwnxNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736464144; c=relaxed/simple;
	bh=i+MqWJUeuZmRDrxhehHssxOfMZ4xUp8D1ErxL6q7d6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMYH/jcRHFAw8LHznf9cjzdq++OTLmChVWpp55O/1DfsWfEMmXxK/J8wyeTLHiJu0M0CEO91CbgZ2Y82TV9adK8sI4ODFYzB1seWIMLZihgRqrczhIQ4WK7zXYoLlQjzKMK2GtVndIE4md5JCCioyklCnjwmZAKBWSFPKvbSufc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KubCwfOa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736464141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jr1dLn/f1pVPRWOoe+9hdGZOKJxCBE28hKBrhQtjWYA=;
	b=KubCwfOaK6wYlMOBFWNp2bUAvbV/6IgasdTq71SB8YdguKbzZ9yfw2apzWVZtkCa6lqvpw
	W26yzlBz/ahmCTL04tWhDCgu3XOUzS6uuIct0vk9u6QYUyb5MntVT0sI09Hq6c19145L8w
	j2CjyqlqSpbj73Nof5uyaaB7iOPW9Dk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-CFG922QaOf61_UGoAp1Y0w-1; Thu,
 09 Jan 2025 18:08:57 -0500
X-MC-Unique: CFG922QaOf61_UGoAp1Y0w-1
X-Mimecast-MFC-AGG-ID: CFG922QaOf61_UGoAp1Y0w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91C161955DB8;
	Thu,  9 Jan 2025 23:08:56 +0000 (UTC)
Received: from redhat.com (unknown [10.22.65.133])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0677519560AB;
	Thu,  9 Jan 2025 23:08:54 +0000 (UTC)
Date: Thu, 9 Jan 2025 17:08:52 -0600
From: Bill O'Donnell <bodonnel@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] sysv: Remove the filesystem
Message-ID: <Z4BXBESNG9v383kX@redhat.com>
References: <20250106162401.21156-1-jack@suse.cz>
 <20250107-wahrt-veredeln-84a1838928e8@brauner>
 <Z379F9ymCnMB2vt2@redhat.com>
 <20250109-bekunden-speck-87912b1860fa@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109-bekunden-speck-87912b1860fa@brauner>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Jan 09, 2025 at 04:05:13PM +0100, Christian Brauner wrote:
> On Wed, Jan 08, 2025 at 04:32:55PM -0600, Bill O'Donnell wrote:
> > On Tue, Jan 07, 2025 at 03:35:35PM +0100, Christian Brauner wrote:
> > > On Mon, Jan 06, 2025 at 05:24:01PM +0100, Jan Kara wrote:
> > > > Since 2002 (change "Replace BKL for chain locking with sysvfs-private
> > > > rwlock") the sysv filesystem was doing IO under a rwlock in its
> > > > get_block() function (yes, a non-sleepable lock hold over a function
> > > > used to read inode metadata for all reads and writes).  Nobody noticed
> > > > until syzbot in 2023 [1]. This shows nobody is using the filesystem.
> > > > Just drop it.
> > > > 
> > > > [1] https://lore.kernel.org/all/0000000000000ccf9a05ee84f5b0@google.com/
> > > > 
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > ---
> > > >  What do people think about this? Or should we perhaps go through a (short)
> > > >  deprecation period where we warn about removal?
> > > 
> > > Let's try and kill it. We can always put it back if we have to.
> > > 
> > So should any work toward converting sysv to the new mount API stop? ;)
> 
> So I would suggest we try and remove it for v6.15. If the removal
> survives the release of v6.16 I would call it a (qualified) success.
> 
> If during this time we find out that we have to keep it and have to
> reintroduce it then we may as well spend the time to port it to the new
> mount api.
> 
> Thoughts?
Makes sense to me.


