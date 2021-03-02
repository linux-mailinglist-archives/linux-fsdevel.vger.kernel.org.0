Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DE532B4A9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Mar 2021 06:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237112AbhCCFYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 00:24:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42626 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351434AbhCBOYv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Mar 2021 09:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614694974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N3sSHK++R6zsz5fOVbw47mb0BUNgGRGZh9qrPGeQDx0=;
        b=LsTRMYpwxe7moxWb7DaO++tgzaGTZDvaWkSLFb5mpAj6rHlc+UkrGXwj/6ribQG7L6z0cT
        wbirxTI5Iqy7D1oYRuSHW2yJUnfe23JtGph1hZHp/hM2merxQRs/fmF8xzlFjhEcWc7X3v
        g+QmsKTfh32/CHCG2b4zXZYREa9HHPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-U146o1jFM_OqzMLU63kT_A-1; Tue, 02 Mar 2021 09:22:52 -0500
X-MC-Unique: U146o1jFM_OqzMLU63kT_A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB307107ACC7;
        Tue,  2 Mar 2021 14:22:51 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64D961971D;
        Tue,  2 Mar 2021 14:22:47 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id BAAD922054F; Tue,  2 Mar 2021 09:22:46 -0500 (EST)
Date:   Tue, 2 Mar 2021 09:22:46 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, linux-kernel@vger.kernel.org,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [RFC PATCH] fuse: Clear SGID bit when setting mode in setacl
Message-ID: <20210302142246.GC220334@redhat.com>
References: <20210226183357.28467-1-lhenriques@suse.de>
 <20210301163324.GC186178@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301163324.GC186178@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 01, 2021 at 11:33:24AM -0500, Vivek Goyal wrote:
> On Fri, Feb 26, 2021 at 06:33:57PM +0000, Luis Henriques wrote:
> > Setting file permissions with POSIX ACLs (setxattr) isn't clearing the
> > setgid bit.  This seems to be CVE-2016-7097, detected by running fstest
> > generic/375 in virtiofs.  Unfortunately, when the fix for this CVE landed
> > in the kernel with commit 073931017b49 ("posix_acl: Clear SGID bit when
> > setting file permissions"), FUSE didn't had ACLs support yet.
> 
> Hi Luis,
> 
> Interesting. I did not know that "chmod" can lead to clearing of SGID
> as well. Recently we implemented FUSE_HANDLE_KILLPRIV_V2 flag which
> means that file server is responsible for clearing of SUID/SGID/caps
> as per following rules.
> 
>     - caps are always cleared on chown/write/truncate
>     - suid is always cleared on chown, while for truncate/write it is cleared
>       only if caller does not have CAP_FSETID.
>     - sgid is always cleared on chown, while for truncate/write it is cleared
>       only if caller does not have CAP_FSETID as well as file has group execute
>       permission.
> 
> And we don't have anything about "chmod" in this list. Well, I will test
> this and come back to this little later.

Looks like I did not notice the setattr_prepare() call in
fuse_do_setattr() which clears SGID in client itself and server does not
have to do anything extra. So it works.

IOW, FUSE_HANDLE_KILLPRIV_V2 will not handle this particular case and
fuse client will clear SGID on chmod, if need be.

Vivek

