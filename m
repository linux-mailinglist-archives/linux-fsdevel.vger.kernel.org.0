Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC312AF8C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 20:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgKKTQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 14:16:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725949AbgKKTQa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 14:16:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605122188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i/7CMGpbhbxDC55K5G2xA2x8HkW7mbdCTvMXfQRtTj8=;
        b=QB+GB8gTugtYjLuJjgtbfWlXjuakKXgGNoVU528gbHepOU5aZL5ZIGLok6CSCjYNT4VbIA
        4oRib+64G1wY2tzcM9345fxpplXwCXBSho+TjPOmLwN+JFgfEKv2cvRpY1RFGSJj0+XCXe
        sW9xmn3nrU7jBPxpqSPEsWCltjlcRWo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-QLGuYPjcPAioTF5lr9BSIw-1; Wed, 11 Nov 2020 14:16:25 -0500
X-MC-Unique: QLGuYPjcPAioTF5lr9BSIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69F6E425FB;
        Wed, 11 Nov 2020 19:16:24 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-158.rdu2.redhat.com [10.10.115.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AF0719C71;
        Wed, 11 Nov 2020 19:16:20 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5AD17220203; Wed, 11 Nov 2020 14:16:20 -0500 (EST)
Date:   Wed, 11 Nov 2020 14:16:20 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Subject: Re: [PATCH v3 3/6] fuse: setattr should set FATTR_KILL_PRIV upon
 size change
Message-ID: <20201111191620.GA1577294@redhat.com>
References: <20201009181512.65496-1-vgoyal@redhat.com>
 <20201009181512.65496-4-vgoyal@redhat.com>
 <CAJfpegu=ooDmc3hT9cOe2WEUHQN=twX01xbV+YfPQPJUHFMs-g@mail.gmail.com>
 <20201106171843.GA1445528@redhat.com>
 <CAJfpegvvGL=GJX0a+cDUVhX754NibudTvHvtrBrCnk-FEnfQ6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvvGL=GJX0a+cDUVhX754NibudTvHvtrBrCnk-FEnfQ6A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 11, 2020 at 02:54:43PM +0100, Miklos Szeredi wrote:
> On Fri, Nov 6, 2020 at 6:18 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> 
> > I think it does not hurt to start passing FATTR_KILL_PRIV for chown()
> > as well. In that case, server will always clear caps on chown but
> > clear suid/sgid only if FATTR_KILL_PRIV is set. (Which will always
> > be set).
> 
> Okay.
> 
> More thoughts for FUSE_HANDLE_KILLPRIV_V2:
> 
>  - clear "security.capability" on write, truncate and chown unconditionally
>  - clear suid/sgid if
>     o setattr has FATTR_SIZE and  FATTR_KILL_PRIV
>     o setattr has FATTR_UID or FATTR_GID
>     o open has O_TRUNC and FUSE_OPEN_KILL_PRIV
>     o write has FUSE_WRITE_KILL_PRIV
> 
> Kernel has:
> ATTR_KILL_PRIV -> clear "security.capability"
> ATTR_KILL_SUID -> clear S_ISUID
> ATTR_KILL_SGID -> clear S_ISGID if executable
> 
> Fuse has:
> FUSE_*KILL_PRIV -> clear S_ISUID and S_ISGID if executable
> 
> So the fuse meaning of FUSE_*KILL_PRIV has a complementary meaning to
> that of ATTR_KILL_PRIV, which is somewhat confusing.  Also "PRIV"
> implies all privileges, including "security.capability" but the fuse
> ones relate to suid/sgid only.
> 
> How about FUSE_*KILL_SUIDGID (FUSE_WRITE_KILL_SUIDGID being an alias
> for FUSE_WRITE_KILL_PRIV)?

Hi Miklos,

Renaming FUSE_*KILL_PRIV to FUSE_*KILL_SUIDSGID sounds good. For a
breif moment I was also thinking that these FUSE_*KILL_PRIV and
and ATTR_KILL_PRIV are not exactly mapping. Glad you caught it
and made the situation better.

Thanks
Vivek

