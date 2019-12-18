Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BA2124747
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2019 13:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbfLRMwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Dec 2019 07:52:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44001 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726707AbfLRMwG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Dec 2019 07:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576673525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fz1C4BpCn0XBwscKEK5CV3W7xgzsRCUzKeY/3qkO/Js=;
        b=ALdVztwkzkdXKEy3By+x7WHaqWnwgcik+LH4fVx8vFtgIJoI8CHWnwYouwFXRytxKvxs61
        KA4Vyzy2krwQPUbHhcn3c3qZO3emYmYo0zKIw+c0JLN86STuCjqZ66tFchC/BWCO8sKCYB
        fd/ekT/mMJmf0koHarmiKWYJYCmRKno=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-xY7yRlSGMNCn0yZuBunk-g-1; Wed, 18 Dec 2019 07:52:04 -0500
X-MC-Unique: xY7yRlSGMNCn0yZuBunk-g-1
Received: by mail-ot1-f72.google.com with SMTP id v4so1043771otp.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2019 04:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fz1C4BpCn0XBwscKEK5CV3W7xgzsRCUzKeY/3qkO/Js=;
        b=bi1TGZHkWOJe73MV3M9oVZDvdCUBwt8ByGFmOLVRoISMo7MgGJJjlNSlVxmErW2/ez
         6+5MDj+UxiADJuQHIAWAiBwGzixIm40dNMJnqxk/DTNAM1H2o/S2fV6sF2IymhBM4T8V
         JcMcba30P7wLWUWswf5v00PayaiOwZKBdBR7t6vLN0kMB4CL+WhM/A1EyCiPZVytdMki
         6Q0zBxVVpTB4mg3Bjrg1TBvdkve7j1GdBIM1qd1zCDZln+w7SHfQOeQjT+a6Cjzpn27n
         a2Ffywb+HGHAp/wZ/x7xTo4RCp/7laPBWoZhj1lowrksT80h+3e/OfAPFpAOv84KC62R
         Ly5g==
X-Gm-Message-State: APjAAAXksxvThf0EhaaD+uCYepHnZd6Kfr+pq1e7nziwoR/txqeu80PH
        sSPd9N1TVo9Ol5d8fTcTAfPDjKo2jE9PLI/IoAbikhbxBdo+nodowGS9EwpbiBKbwer4so4/l+R
        J6XKcg5skVVcPqVFCmTB/d02ssLg7+33vnpm13X5ENA==
X-Received: by 2002:aca:b50b:: with SMTP id e11mr235718oif.72.1576673523443;
        Wed, 18 Dec 2019 04:52:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqzNnW7+BNpz9v4T2rGe5JN9P0bnFFK+0053Y4EXekhxOjcVx8wn/QURXj7KOopsEFATg9yxdbSk8mvoMerik3c=
X-Received: by 2002:aca:b50b:: with SMTP id e11mr235716oif.72.1576673523237;
 Wed, 18 Dec 2019 04:52:03 -0800 (PST)
MIME-Version: 1.0
References: <20191106190239.20860-1-agruenba@redhat.com> <20191218124346.GC19387@quack2.suse.cz>
In-Reply-To: <20191218124346.GC19387@quack2.suse.cz>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 18 Dec 2019 13:51:52 +0100
Message-ID: <CAHc6FU4SodZg1XTZ-BRjTrYiWVdGz4ZfbzZQtevv=TCuHwxbJw@mail.gmail.com>
Subject: Re: [PATCH] fs: Fix overflow in block_page_mkwrite
To:     Jan Kara <jack@suse.cz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

On Wed, Dec 18, 2019 at 1:43 PM Jan Kara <jack@suse.cz> wrote:
> On Wed 06-11-19 20:02:39, Andreas Gruenbacher wrote:
> > On architectures where ssize_t is wider than pgoff_t, the expression
> > ((page->index + 1) << PAGE_SHIFT) can overflow.  Rewrite to use the page
> > offset, which we already compute here anyway.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>
> This patch seems to have fallen through the cracks? Al?

There's been a v2 of this patch [*] and I'm about to send out a v3, so
please ignore this first version.

Thanks,
Andreas

[*] https://lore.kernel.org/linux-fsdevel/20191129142045.7215-1-agruenba@redhat.com/

