Return-Path: <linux-fsdevel+bounces-36327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 640549E1B2B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 12:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3753D167100
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 11:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E231E411D;
	Tue,  3 Dec 2024 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4d7wSbr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABBB1E009A
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Dec 2024 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226046; cv=none; b=pPrN4G4v6as/3m4iIHGUzT3ogPKTi/waCbRlo6nPO13aGpi7m9laL6imIcavcb8C5n/3vg9RcR1wy53X5C2N9dev8Wi2SEMm1SX5AgQNcmS6fRSQzBWDndUWJCu9GmlQLqKnaGvvkrffhvcQINfPLAQzOOjYADN8FnUY8XuhMBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226046; c=relaxed/simple;
	bh=LnKqt5/dMZE1dlBMlqvW/aX78Pi+4HYTVwecY/r/o1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AEdepqfOTpG8oPIJwYrAfr9TIdxBXurXHwDjzXOoQenGgYiesrYlq2toUUdXZuRxIkyFTFMW8UQylQg/tLyFUGd0R/3gNEA3VBpUthF1qBrQuLXkba0P+I5/kmc5Xmc9XgLfz0GgGfxG5Pco6+yBMk7l6JdgYQGrXWomPx+UuDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4d7wSbr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733226043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ed/sTHR8tKRh9onLxZzNAufXyOgNom4g+A7upwemPGo=;
	b=Q4d7wSbrlySMXgcKwObL2EwX9q77RCU1VeWv+OOncle+AzUxT/ZC5J3ZLPwYSUKV5SgqTL
	vgPjTWF3pKDeXgz8/eJcdf4P0KkZLiay7X8lvRLDZDNDdAefxaFDfWsNtPrhgTNUVkcze/
	BbTrl1+7a9Yest1R753V17+cLu49UC0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-CEv8c3qGNYmAWWeUdTmw9g-1; Tue,
 03 Dec 2024 06:40:40 -0500
X-MC-Unique: CEv8c3qGNYmAWWeUdTmw9g-1
X-Mimecast-MFC-AGG-ID: CEv8c3qGNYmAWWeUdTmw9g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8AEE195421E;
	Tue,  3 Dec 2024 11:40:38 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.12])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C796F195608A;
	Tue,  3 Dec 2024 11:40:35 +0000 (UTC)
Date: Tue, 3 Dec 2024 12:40:32 +0100
From: Karel Zak <kzak@redhat.com>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Ian Kent <raven@themaw.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH] fanotify: notify on mount attach and detach
Message-ID: <dqeiphslkdqyxevprnv7rb6l5baj32euh3v3drdq4db56cpgu3@oalgjntkdgol>
References: <20241128144002.42121-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128144002.42121-1-mszeredi@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


Thank you for working on this.

On Thu, Nov 28, 2024 at 03:39:59PM GMT, Miklos Szeredi wrote:
> To monitor an entire mount namespace with this new interface, watches need
> to be added to all existing mounts.  This can be done by performing
> listmount()/statmount() recursively at startup and when a new mount is
> added.

It seems that maintaining a complete tree of nodes on large systems
with thousands of mountpoints is quite costly for userspace. It also
appears to be fragile, as any missed new node (due to a race or other
reason) would result in the loss of the ability to monitor that part
of the hierarchy. Let's imagine that there are new mount nodes added
between the listmount() and fanotify_mark() calls. These nodes
will be invisible.

It would be beneficial to have a "recursive" flag that would allow for
opening only one mount node and receiving notifications for the entire
hierarchy. (I have no knowledge about fanotify, so it is possible that
this may not be feasible due to the internal design of fanotify.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


