Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9132A9AAB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 18:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgKFRSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 12:18:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727559AbgKFRSy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 12:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604683132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0TsLjvHU+FbaD8l4Rzu3kLqZMoFvtn2/N9vy+avsZTY=;
        b=UlqiVcnIMp/RBIUXOtwUl22ykBiNW/67g8E1fVLjAKVDkmxQ9DIzOO0NGsSctUjbNLgiPx
        0382Sb0ijv1w5hENV0B+6wL8BgZXbVCwoaWZD6nJheybOmWyuioL8m9YewcUySdrVgjTnY
        6marYWcfqaHkEy3GuFRfj/xPj6Xj6e8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-oxj5efy0P3emtdIS2rvWRA-1; Fri, 06 Nov 2020 12:18:50 -0500
X-MC-Unique: oxj5efy0P3emtdIS2rvWRA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2BF18030B8;
        Fri,  6 Nov 2020 17:18:49 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-167.rdu2.redhat.com [10.10.115.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB92E5C629;
        Fri,  6 Nov 2020 17:18:43 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 242A1225FCD; Fri,  6 Nov 2020 12:18:43 -0500 (EST)
Date:   Fri, 6 Nov 2020 12:18:43 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Subject: Re: [PATCH v3 3/6] fuse: setattr should set FATTR_KILL_PRIV upon
 size change
Message-ID: <20201106171843.GA1445528@redhat.com>
References: <20201009181512.65496-1-vgoyal@redhat.com>
 <20201009181512.65496-4-vgoyal@redhat.com>
 <CAJfpegu=ooDmc3hT9cOe2WEUHQN=twX01xbV+YfPQPJUHFMs-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegu=ooDmc3hT9cOe2WEUHQN=twX01xbV+YfPQPJUHFMs-g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 06, 2020 at 03:39:29PM +0100, Miklos Szeredi wrote:
> On Fri, Oct 9, 2020 at 8:16 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > If fc->handle_killpriv_v2 is enabled, we expect file server to clear
> > suid/sgid/security.capbility upon chown/truncate/write as appropriate.
> >
> > Upon truncate (ATTR_SIZE), suid/sgid is cleared only if caller does
> > not have CAP_FSETID. File server does not know whether caller has
> > CAP_FSETID or not. Hence set FATTR_KILL_PRIV upon truncate to let
> > file server know that caller does not have CAP_FSETID and it should
> > kill suid/sgid as appropriate.
> >
> > We don't have to send this information for chown (ATTR_UID/ATTR_GID)
> > as that always clears suid/sgid irrespective of capabilities of
> > calling process.
> 
> I'm  undecided on this.   Would it hurt to set it on chown?  That
> might make the logic in some servers simpler, no?
> 
> What would be the drawback of setting FATTR_KILL_PRIV for chown as well?

Hi Miklos,

Thinking loud.

So these are the rules we expect from VFS point of view.

- caps are always cleared on chown/write/truncate
- suid is always cleared on chown, while for truncate/write it is cleared
  only if caller does not have CAP_FSETID.
- sgid is always cleared on chown, while for truncate/write it is cleared
  only if caller does not have CAP_FSETID as well as file has group execute
  permission.

From server point of view, these rules become.

- caps are always cleared on chown/write/truncate
- suid is always cleared on chown, while for truncate/write it is cleared
  only if client set appropriate flag.
  	- For truncate, this flag will either be FUSE_OPEN_KILL_PRIV or
	  FATTR_KILL_PRIV.
	- For write, FUSE_WRITE_KILL_PRIV will be set.
- sgid is always cleared on chown, while for truncate/write it is cleared
  only if caller has set a flag as well as file has group execute permission.
  	- For truncate, this flag will either be FUSE_OPEN_KILL_PRIV or
	  FATTR_KILL_PRIV.
	- For write, FUSE_WRITE_KILL_PRIV will be set.

Above rules assumes that chown() will always clear caps/suid/sgid and
server does not have to rely on any flags.

I think it does not hurt to start passing FATTR_KILL_PRIV for chown()
as well. In that case, server will always clear caps on chown but
clear suid/sgid only if FATTR_KILL_PRIV is set. (Which will always
be set).

So anything is fine. We just need to document it well. I think I will
write it very clearly in qemu patch depending on what goes in kernel.

Thanks
Vivek

