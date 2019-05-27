Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40BA02B661
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 15:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfE0N0P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 09:26:15 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40300 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfE0N0P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 09:26:15 -0400
Received: by mail-yb1-f195.google.com with SMTP id g62so6592727ybg.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2019 06:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oznreZnks7m3LieCj+2AWLW+A3XJRLnOtCXolEovWa4=;
        b=nWCJVLh6dz/W0NktBY+J2oKQDwQ8nPQ+bc8DktrTrUBNWwgucIYiT3EzrFX4FgWTr1
         EERGO8MZ2sajDkb1KM3Y2ax7m8AmZBZgFjnsyqRftNi05E7taNdq02vzrY57hkP8PInU
         V/GhhOyCvlLjsHoFVtEQeT0pfKU9+XpvdfcMk4a9os4zOqI/C4KkvPDRGyURp7E5+6tX
         gNolRFCwoUaP7ckaDmEkh4m49bRW1ZU2lsoWvmvW690S8D5C2eM4a84blvgPY28R0stp
         77KecBtVTL6glBC2spmc5AAFzI+dBmiVW2GQe3fxZracJB1Wb9yPLOOlf3IU/io/15lB
         TvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oznreZnks7m3LieCj+2AWLW+A3XJRLnOtCXolEovWa4=;
        b=ZMrMTCKB+5ooDQHxBJlxeiv6Ptw/DhvclSChpGkQyCRvoicP4mA1RFH6s98WX39zGO
         UES/8GL3rJo06Nyr2pt9ktcdsMYgAQMYCZKKkIMSCo9nTONELpzJCNBN+qujwWNKoMvx
         TbVp+JMDwShkX6X50WRjPScZTJa9w5BVifktL0ddywnnHj0Wpqs5RPlClU2poF3HlGkl
         KlNapo2yQZXlxkRmmp+BVNugWaW/K719z6Us4ED/c8pOKGYo92u0j56oQwXDXKImG3rv
         EdW2bMokkoOs6OaE88s+iyP2mt3VTHCvziW7aiJ4XOJEifNPCfbOENvB8HvD3mi+wKXE
         pQLA==
X-Gm-Message-State: APjAAAVVCkh3rrxGz0gu5qQd9EvvfifZtw39pmfpuedaZuepQUPpvs9e
        Iqcq3pLrE1WBq41tMdNsIUNq6qijWWmrpjB1pkQ=
X-Google-Smtp-Source: APXvYqxGw8dvIilBIF/CBpImlmJtavEeZzrIrh4MFXdhKUQNK78gWQv4dmOsOVfMXgnZk9i9ySzhUj4LtoUsjsc92O8=
X-Received: by 2002:a25:a304:: with SMTP id d4mr36282694ybi.126.1558963574017;
 Mon, 27 May 2019 06:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190526143411.11244-1-amir73il@gmail.com> <20190526143411.11244-4-amir73il@gmail.com>
 <20190527105357.GD20440@quack2.suse.cz>
In-Reply-To: <20190527105357.GD20440@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 27 May 2019 16:26:03 +0300
Message-ID: <CAOQ4uxgmoWPsEiOrdBE5sF8-b5Hhw91eWCwO=WKbXfjgpsmu_w@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] rpc_pipefs: call fsnotify_{unlink,rmdir}() hooks
To:     Jan Kara <jack@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 27, 2019 at 1:54 PM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 26-05-19 17:34:04, Amir Goldstein wrote:
> > This will allow generating fsnotify delete events after the
> > fsnotify_nameremove() hook is removed from d_delete().
> >
> > Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
> > Cc: Anna Schumaker <anna.schumaker@netapp.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  net/sunrpc/rpc_pipe.c | 4 ++++
> >  1 file changed, 4 insertions(+)
>
> Hum, I don't think all __rpc_depopulate() calls are guarded by i_rwsem
> (e.g. those in rpc_gssd_dummy_populate()). Why aren't we using
> rpc_depopulate() in those cases? Trond, Anna?
>

Do we care? For fsnotify hook, we should only care that
d_parent/d_name are stable.
They are stable because rpc_pipefs has no rename.

Thanks,
Amir.
