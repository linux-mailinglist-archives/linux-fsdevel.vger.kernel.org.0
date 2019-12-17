Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2A991222E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 05:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfLQEMR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 23:12:17 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:33390 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfLQEMQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:12:16 -0500
Received: by mail-il1-f196.google.com with SMTP id r81so7320639ilk.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 20:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QoxadaWW8gdqCqTR7g88sYygce+uvqoqpKwAaToxPY8=;
        b=XJTthCXw5cRkrvMk9W9zP31SlCprBhmN9bjmfWK1m9YM+ogq52hr2jZwsg3nj/SfUA
         bX5xg0XzDFhIYHjw+cG4GLIuBv/lhekbZ5E3/a82tF/PTanP/CmO/7Vr/30RrcuPAP9d
         hqeIW/ds9OMJjQQGs6mpQE03yDQDckJfLVWRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QoxadaWW8gdqCqTR7g88sYygce+uvqoqpKwAaToxPY8=;
        b=FN9iWTLSxbaWDng12sf1WXs4dx3O8yt7GVdMsjGyypaeNUcIAxF0qdDWxEslVh4QtM
         +4o3p/bnVLf/cAiEaMUc6doamG9Rxt/Vn3J4d1s8wUqLLap67JynWOw+g0AoeSfT9zRA
         4PWD/t/cS2t2SATlyAoSpQyjQXaaU4kPqtdilIqdDtmp8k2lxdWGFLYYuy4yj5X45gLm
         2AvjxN+6KG+oC9qEsgRByMQ3n9jtOqgd9wN1Y419khfl69kPXkEVxoLP+sVzJMTEVW5I
         chLsPv1Z/f34bqz6eaYTmccw8mJRdpWr2p4V4ogYBwGITeji1lxDEMSQtap41YX9EVAn
         kh7g==
X-Gm-Message-State: APjAAAVFTaVpaMeIL+RqTFlpAHDFhHW4kJkzsxkaHuaQCqbOCuYtPUk7
        uCRR2+9elReB4q9SrwW3l/pVx2ebNFoJ1fOzt0PFLg==
X-Google-Smtp-Source: APXvYqytCDVTDSKmgDhKeCd73YPmXFEIeuPs0GS/fESzmomIE5/hghZTSN05OIzFl5blTQncUsmaZLbslWqmWxx2Acg=
X-Received: by 2002:a92:cc:: with SMTP id 195mr15206225ila.212.1576555935822;
 Mon, 16 Dec 2019 20:12:15 -0800 (PST)
MIME-Version: 1.0
References: <20191128155940.17530-1-mszeredi@redhat.com> <20191128155940.17530-13-mszeredi@redhat.com>
 <20191217033721.GS4203@ZenIV.linux.org.uk>
In-Reply-To: <20191217033721.GS4203@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Dec 2019 05:12:05 +0100
Message-ID: <CAJfpegtnyjm_qbfMo0neAvqdMymTPHxT2NZX70XnK_rD5xtKYw@mail.gmail.com>
Subject: Re: [PATCH 12/12] vfs: don't parse "silent" option
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 4:37 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, Nov 28, 2019 at 04:59:40PM +0100, Miklos Szeredi wrote:
> > While this is a standard option as documented in mount(8), it is ignored by
> > most filesystems.  So reject, unless filesystem explicitly wants to handle
> > it.
> >
> > The exception is unconverted filesystems, where it is unknown if the
> > filesystem handles this or not.
> >
> > Any implementation, such as mount(8), that needs to parse this option
> > without failing can simply ignore the return value from fsconfig().
>
> Unless I'm missing something, that will mean that having it in /etc/fstab
> for a converted filesystem (xfs, for example) will fail when booting
> new kernel with existing /sbin/mount.  Doesn't sound like a good idea...

Nope, the mount(2) case is not changed (see second hunk).

When mount(8) is converted to the new API, it can just handle such
back compat issues (ignore error from fconfig()) in that case.

Thanks,
Miklos
