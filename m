Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F3D46ABFD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 23:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357504AbhLFWdL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 17:33:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:26738 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357505AbhLFWcL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638829720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M235F2fGs2lpXPk1msT4Xrgak7wvv9NcVSbC3tAoyks=;
        b=NFGHEwi5p1KPqGyFD2kgP3dlVWv/tYyANsdTw6E0J+dJpRBH4TB3Uq/aL6NTDC0GH80t+P
        uDvOOt8F85ln71Ze8BF7Cx7Wa2j9pzBKwBVGlCHbz/41qTgjDOn/jJnVyfcGEDAXMjimXN
        +WP29dLvwicdEjPNMU2d8uz5t6JVVLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-55-J7BTr1e-Nxin_wVUfqTdhQ-1; Mon, 06 Dec 2021 17:28:37 -0500
X-MC-Unique: J7BTr1e-Nxin_wVUfqTdhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B40F1E10;
        Mon,  6 Dec 2021 22:28:36 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.33.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F046B7095E;
        Mon,  6 Dec 2021 22:28:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 8A0B3225F31; Mon,  6 Dec 2021 17:28:35 -0500 (EST)
Date:   Mon, 6 Dec 2021 17:28:35 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Eric Wong <normalperson@yhbt.net>
Cc:     fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: per-inode locks in FUSE (kernel vs userspace)
Message-ID: <Ya6OkznJxzAFe8fT@redhat.com>
References: <20211203000534.M766663@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203000534.M766663@dcvr>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 03, 2021 at 12:05:34AM +0000, Eric Wong wrote:
> Hi all, I'm working on a new multi-threaded FS using the
> libfuse3 fuse_lowlevel.h API.  It looks to me like the kernel
> already performs the necessary locking on a per-inode basis to
> save me some work in userspace.
> 
> In particular, I originally thought I'd need pthreads mutexes on
> a per-inode (fuse_ino_t) basis to protect userspace data
> structures between the .setattr (truncate), .fsync, and
> .write_buf userspace callbacks.
> 
> However upon reading the kernel, I can see fuse_fsync,
> fuse_{cache,direct}_write_iter in fs/fuse/file.c all use
> inode_lock.  do_truncate also uses inode_lock in fs/open.c.
> 
> So it's look like implementing extra locking in userspace would
> do nothing useful in my case, right?

I guess it probably is a good idea to implement proper locking
in multi-threaded fs and not rely on what kind of locking
kernel is doing. If kernel locking changes down the line, your
implementation will be broken.

Vivek

