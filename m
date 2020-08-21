Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1448924E254
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 22:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgHUU5G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 16:57:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53147 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725916AbgHUU5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 16:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598043423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TjXeWYgg6oHaO77mLFHFFSX/+r9SdHSNlcFRKDT7Acc=;
        b=fRNNYTk2sjvYsDrk/8s+S9brCks3P8Ond5ptV0yub95IDHy/cCTkmJLJkJaVhnDX8uj9Rw
        zMULxUZtgOBMzT/zGZmtfDG0nPcas5pxlCRDmJKLMzQp55pH9cYz4yITK7r02DITfKhUYS
        Nu/hQRneJyH5NFKXWQMJ8w7z6jXafZs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-VdxcJl2LNa6rr8WRytlLbg-1; Fri, 21 Aug 2020 16:56:59 -0400
X-MC-Unique: VdxcJl2LNa6rr8WRytlLbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42D9181F02F;
        Fri, 21 Aug 2020 20:56:58 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-222.rdu2.redhat.com [10.10.114.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F11D85F706;
        Fri, 21 Aug 2020 20:56:55 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9D58022036A; Fri, 21 Aug 2020 16:56:54 -0400 (EDT)
Date:   Fri, 21 Aug 2020 16:56:54 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Subject: Re: [PATCH 3/5] fuse: Add a flag FUSE_SETATTR_KILL_PRIV
Message-ID: <20200821205654.GB905782@redhat.com>
References: <20200724183812.19573-1-vgoyal@redhat.com>
 <20200724183812.19573-4-vgoyal@redhat.com>
 <CAJfpeguvMvc9rXChGrSuQsO9__Ln7exozmMWVY_1B8DrsV4rpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguvMvc9rXChGrSuQsO9__Ln7exozmMWVY_1B8DrsV4rpQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 21, 2020 at 04:53:59PM +0200, Miklos Szeredi wrote:
> On Fri, Jul 24, 2020 at 8:38 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> >
> > With handle_killpriv_v2, server needs to kill suid/sgid on truncate (setattr)
> > but it does not know if caller has CAP_FSETID or not. So like write, send
> > killpriv information in fuse_setattr_in and add a flag FUSE_SETATTR_KILL_PRIV.
> >
> > Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> 
> [...]
> 
> > +/**
> > + * Setattr flags
> > + * FUSE_SETATTR_KILL_PRIV: kill suid and sgid bits. sgid should be killed
> > + * only if group execute bit (S_IXGRP) is set. Meant to be used together
> > + * with FUSE_HANDLE_KILLPRIV_V2.
> > + */
> > +#define FUSE_SETATTR_KILL_PRIV (1 << 0)
> 
> Why not a FATTR_KILL_PRIV set in fuse_setattr_in.valid?

Yes, I should be able to do that. ATTR_KILL_PRIV is already there
which can map to FATTR_KILL_PRIV. Not sure why didn't I think of it.

Vivek

