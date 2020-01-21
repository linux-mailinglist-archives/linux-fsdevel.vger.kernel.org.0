Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA391437D9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 08:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgAUHry (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 02:47:54 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33102 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgAUHry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 02:47:54 -0500
Received: by mail-il1-f193.google.com with SMTP id v15so1651461iln.0;
        Mon, 20 Jan 2020 23:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PgjBhPbvshFDfbTkhZA28Te0UEivEgnibuK+F+CDeMw=;
        b=nqc+rxO6ibTOcZJ566VYbsDxMcnlALzKdSMga43H9i0fCDdV3POAscmCBadFbbfKcR
         BFfIqQ7TO+4bZril9E6hqr32maedxZE95eYHZnGUB/fLXYzwjbYA9qth94MBbHLlftb9
         gHe0f47lfmVXPrsYv7/BD6c3e5EV4xzzcuAlmXXhrTS1XG69RnJ5mdkEAfFAvTVqdbfq
         7HX4fR57V2jbx+mT6X7QFyHSKlYhnNBjs6clvOccnlquQ/38qu+3v7O8WgcsToGAmriB
         NZJqF+hIWO5NyEeVfQnjMdtCZbPbUa0VSdY7bhrW/okdm/B75124cjFWo9Y0ksx22ifl
         R1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PgjBhPbvshFDfbTkhZA28Te0UEivEgnibuK+F+CDeMw=;
        b=GCtg6HVm1a7yeCROxLDvtIQ7elNjljSLFwsxFQLyYSu4iKLgewa/g1qMlo6+oU7LZb
         POtVB+QUfYYnOM2gWMfzC+hwCQwpc1nM9oWDShnCLdtDYWk/mbgHL72pADUr39PHQkf3
         BYrnnIYBghGlOs3ulHXufxTqJ1d1Eu9O9wLmA5msDZ4AI0p5vKdhv9h2ssblYovch9C5
         vIgFZ9bz5Zzw4smGRuIlz3kr/ciqsrcPZPgjobpRBV5xwJdGrzqmncNGSEUy/ogp+T1h
         fJz5iaRN/Ryx8LpxZgr9y41i0KW5+Mh1VgGebHeq1UgWBGdL0JNjxl4Zh0xZtrFbSi8R
         LWBA==
X-Gm-Message-State: APjAAAVavxxedBjQlpCd+25BmCCDNbNQCwVEmNWa7wukGIR+IkH0X1mP
        7VHwoZCnAEGB+rByFeNQUEomBEMwugRCvDAL98A=
X-Google-Smtp-Source: APXvYqwvCy26eK74WcnhrWGh3ZJau/X4Pbmh8O54PvYsw6GC0n0c4VxqXT0yqYF88bbM9pFnRRP31sV5HpO7nVVnKIw=
X-Received: by 2002:a92:9c8c:: with SMTP id x12mr2548323ill.275.1579592873495;
 Mon, 20 Jan 2020 23:47:53 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5mvUmZca8TRVsyZvrB_Loeeo4Kd8T7rHw5s6iaN=yC+O_Q@mail.gmail.com>
In-Reply-To: <CAH2r5mvUmZca8TRVsyZvrB_Loeeo4Kd8T7rHw5s6iaN=yC+O_Q@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 21 Jan 2020 09:47:42 +0200
Message-ID: <CAOQ4uxipauh1UXHSFt=WsiaDexqecjm4eDkVfnQXN8eYofdg2A@mail.gmail.com>
Subject: Re: [LFS/MM TOPIC] Enabling file and directory change notification
 for network and cluster file systems
To:     Steve French <smfrench@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 21, 2020 at 5:55 AM Steve French <smfrench@gmail.com> wrote:
>
> Currently the inotify interface in the kernel can only be used for
> local file systems (unlike the previous change notify API used years
> ago, and the change notify interface in Windows and other OS which is
> primarily of interest for network file systems).
>
> I wanted to discuss the VFS changes needed to allow inotify requests
> to be passed into file systems so network and cluster file systems (as
> an example in the SMB3 case this simply means sending a
> SMB3_CHANGE_NOTIFY request to the server, whether Samba or Cloud
> (Azure) or Mac or Windows or Network Appliance - all support the API
> on the server side, the problem is that the network or cluster fs
> client isn't told about the request to wait on the inotify event).
> Although user space tools can use file system specific ioctls to wait
> on events, it is obviously preferable to allow network and cluster
> file systems to wait on events using the calls which current Linux
> GUIs use.
>
> This would allow gnome file manager GUI for example to be
> automatically updated when a file is added to an open directory window
> from another remote client.
>
> It would also fix the embarrassing problem noted in the inotify man page:
>
> "Inotify  reports  only events that a user-space program triggers
> through the filesystem
>        API.  As a result, it does not catch remote events that occur
> on  network  filesystems."
>
> but that is precisely the types of notifications that are most useful
> ... users often are aware of updates to local directories from the
> same system, but ... automatic notifications that allow GUIs to be
> updated on changes from **other** clients is of more value (and this
> is exactly what the equivalent API allows on other OS).
>
> The changes to the Linux VFS are small.
>
>

Miklos has already posted an RFC patch:
https://lore.kernel.org/linux-fsdevel/20190507085707.GD30899@veci.piliscsaba.redhat.com/

Did you try it?

You also did not answer Miklos' question:
does the smb protocol support whole filesystem (or subtree) notifications?
(or just per-directory notifications)?

Thanks,
Amir.
