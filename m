Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 381F319A836
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 11:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbgDAJFS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 05:05:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32642 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729703AbgDAJFS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 05:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585731917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mb4kIVbxukf8hYYlfTgwk0b+aDpiHUCjs9XVPXjM6KU=;
        b=QsUJErAl3JsWBzOjRNJyyCFOvwg05A01dNFbgFhg0zTy8hAKI8uYi/b7sHmuopPYPafOPX
        RfmTC02T91UT5dNfarTHLqm1ZVbMsw+G07au+tVMwZblswDufoGdan/AYAKizb7D9Jo+eG
        kwo4OrDyHZjJLqpHvaxJoOLod3BcGHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-TR2mDEwoMVCJ4-Sl3VI-bg-1; Wed, 01 Apr 2020 05:05:13 -0400
X-MC-Unique: TR2mDEwoMVCJ4-Sl3VI-bg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D02A100551A;
        Wed,  1 Apr 2020 09:05:11 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 61E9C60F89;
        Wed,  1 Apr 2020 09:04:47 +0000 (UTC)
Date:   Wed, 1 Apr 2020 11:04:45 +0200
From:   Karel Zak <kzak@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        dray@redhat.com, mszeredi@redhat.com, swhiteho@redhat.com,
        jlayton@redhat.com, raven@themaw.net, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, lennart@poettering.net,
        cyphar@cyphar.com
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-ID: <20200401090445.6t73dt7gz36bv4rh@ws.net.home>
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
 <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2418286.1585691572@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:52:52PM +0100, David Howells wrote:
> Christian Brauner <christian.brauner@ubuntu.com> wrote:
> 
> > querying all properties of a mount atomically all-at-once,
> 
> I don't actually offer that, per se.
> 
> Having an atomic all-at-once query for a single mount is actually quite a
> burden on the system.  There's potentially a lot of state involved, much of
> which you don't necessarily need.

If all means "all possible attributes" than it is unnecessary, for
example ext4 timestamps or volume uuid/label are rarely necessary.
We usually need together (as consistent set):

    source
    mountpoint
    FS type
    FS root (FSINFO_ATTR_MOUNT_PATH)
    FS options (FSINFO_ATTR_CONFIGURATION)
    VFS attributes
    VFS propagation flags
    mount ID
    parent ID
    devno (or maj:min)

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

