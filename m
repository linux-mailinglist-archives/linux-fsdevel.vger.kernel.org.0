Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AADB92EF5E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 17:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbhAHQmY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 11:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbhAHQmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 11:42:23 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D270C0612EA
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Jan 2021 08:41:43 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id w17so10823296ilj.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Jan 2021 08:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tfcIOHpOWkd6vXQn9Tle245dz2NTfaGcxHlFkJI3CvM=;
        b=m6xlwPdYzQsvZjRotIlCOJJXrwZjkdeOmljQcrsE/AQiBggArMAW0SxzaHLe4Ei//q
         A4wfMiENvJMmrFa9vhlGbMv6AWgiqL4gFJJEddG2RFDVgYFQdg8k9Yyr8wLU2hgzh0iP
         Tq7+/goX0VHd6TLz+b0DWlfLPOgmvJ87PsF4535ewSaeL7S62DDOe6229ixQpDSSW9+2
         dmOcF2mq1KdsIJ17Xorx3es3wU+e5G5eKs5BeCwuc1uIzj3ejPd8E/hudsHk5/SuNIy7
         61eSPa1AaMFR1ovu9yZiryF+VdUOe8KnEEEZJfnDvUoc3pHPEcgKElmqzEKN+qSil1En
         SuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tfcIOHpOWkd6vXQn9Tle245dz2NTfaGcxHlFkJI3CvM=;
        b=qCLbCXZS1Aj8SJhy4liuBuPXn9yFCArsMjhH/88uLVlVSe/D70HiKssd7I6rzPaBWm
         Be8SOANNQdezFTqqTsZc/zTT1YFRoDu3cL6RUMFo0HmxZSgwvEwV5TGT6FEs3HnRv9Fw
         bcFr13pyBUEQ8cjG/n2E1b+6GaaiSmQ3/6MzyDCHMf6Ph2FFTWFXwqO2ibOlestYF6el
         WrRxfVdTSI9bVA0xZGutkWSFzKG0hmW8isH0B09RY5ZOcXR5y1XNmZTVIiF7TYiaFpd4
         wQqR2HrYqMXjyNCUbVm5j1GHrzjJauz+/pOB33sDPntJPVwhVjd+6jvVJfYMFkKla/ay
         iRRQ==
X-Gm-Message-State: AOAM533XKkgAAcd2sRuw4i2uHTqaQv2H7mRnc8Z07BTphiMZZg9B6QAl
        VfdxspgLZ7etY/0qEVnYapbeGJxoPPDPe/VMDz+KeOm5
X-Google-Smtp-Source: ABdhPJxnZgEJ6IytvQqiTWUaDXV8AW/BCQQvzQGbYr0LGiX8vNRQl57/PMFFKQkFOcdTS8ERda0E3h6xuR73d9wYy6M=
X-Received: by 2002:a92:d587:: with SMTP id a7mr4627553iln.250.1610124102722;
 Fri, 08 Jan 2021 08:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20210107214401.249416-1-amir73il@gmail.com>
In-Reply-To: <20210107214401.249416-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 8 Jan 2021 18:41:31 +0200
Message-ID: <CAOQ4uxhQq1o3eb5ajMvY0Zan+HkOeMtZKEyD1Z0NKp7v_6SPBg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Generic per-mount io stats
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 7, 2021 at 11:44 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Miklos,
>
> I was trying to address the lack of iostat report for non-blockdev
> filesystems such as overlayfs and fuse.
>
> NFS has already addressed this with it own custom stats collection,
> which is displayed in /proc/<pid>/mountstats.
>
> When looking at the options, I found that a generic solution is quite
> simple and could serve all filesystems that opt-in to use it.
>
> This short patch set results in the following mountstats example report:
>
> device overlay mounted on /mnt with fstype overlay
>         times: 125 153
>         rchar: 12
>         wchar: 0
>         syscr: 2
>         syscw: 0
>
> The choise to collect and report io stats by mount and not by sb is
> quite arbitrary, because it was quite easy to implement and is natural
> to the existing mountstats proc file.
>
> I used the arbirtaty flag FS_USERNS_MOUNT as an example for a way for
> filesystem to opt-in to mount io stats, but it could be either an FS_
> SB_ or MNT_ flag.  I do not anticipate shortage of opinions on this
> matter.
>
> As for performance, the io accounting hooks are the existing hooks for
> task io accounting.  mount io stats add a dereference to mnt_pcp for
> the filesystems that opt-in and one per-cpu var update.  The dereference
> to mnt_sb->s_type->fs_flags is temporary as we will probably want to
> use an MNT_ flag, whether kernel internal or user controlled.
>
> What do everyone think about this?
>
> Al,
>
> did I break any subtle rules of the vfs?
>

That is besides dereferencing a NULL file pointer when getting EBADF
in p/readv/writev...

Thanks,
Amir.
