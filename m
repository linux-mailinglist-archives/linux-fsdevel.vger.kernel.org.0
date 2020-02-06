Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14AFB15483D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 16:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBFPke (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 10:40:34 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:35208 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgBFPke (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:40:34 -0500
Received: by mail-il1-f194.google.com with SMTP id g12so5473205ild.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 07:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O2zmteoxGT1UC7Gb/8cgIPPD9Xtd/vq0NDvlaR9kX1k=;
        b=MoOVIog/vL2wou+pGWJ/S/xIA+emFGQjRJBab9z6LLgzThCAVSJstxOU6tQ8a3LqPr
         QY/fjHuaqRubX3PtpuOpro8M4LhEJ5einO9FC+DcqJrR1f+RWsb+M8fi0Xt1pX15eCZ6
         qGEhqi5/pe3DLRCQT5ShVkxKm0NC7C/7iQ+8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O2zmteoxGT1UC7Gb/8cgIPPD9Xtd/vq0NDvlaR9kX1k=;
        b=Oa4SDp1S4Sew+xx5GUHUlY8GgHZS28W6wnA9yiljtv5VNZH86ariV8KZwr2NcXLjIU
         lLFxowPd8wpc4tpkHSRQ44DRSwJKslIuIrCCsIRNKWlgVVEA981now9JVFelvubooT2N
         nlUOzhacN0wmnRAgIOoSSPS8DI9xwMvp5D46YeH9TSa6GZykH5VUw7qH8yB5JSaV8dAA
         F6G4qj+AoyUqi7B2G4HHb6qexYBjqfEtYR3MzVywNCEWexp27b3PGc32f+VapLaET0LZ
         ergbr3GL9qzP3Ghf8JW6iBqIdVW+8ouziifl4nO5fWhZrUo4pdnsI1FfCSwGa9IzD9eM
         wNCA==
X-Gm-Message-State: APjAAAU4C65jYIvTw9frQ4f2F7JuTJ6qNy3wWxBLBliz3m7xWT7VqHPf
        DSGjmhuVQIl0cLncJ0xS8gWKjkrGkvm71n9b+6vKYw==
X-Google-Smtp-Source: APXvYqyegvjHYD5bcMo0EkF9MtUYgm33NlQQH/TIpj/xZLHK6r7r/6SLqQVZDhoc45MyWb5gcmIgt5f1KPOsgT5axiM=
X-Received: by 2002:a92:89c2:: with SMTP id w63mr4436819ilk.252.1581003632438;
 Thu, 06 Feb 2020 07:40:32 -0800 (PST)
MIME-Version: 1.0
References: <20200203073652.12067-1-ice_yangxiao@163.com> <CAJfpegsVjca2xGV=9xwE75a5NRSYqLpDu9x_q9CeDZ1vt-GyyQ@mail.gmail.com>
 <CAJfpegsPfurF2fB+XgSjr-CnBNcjWiqYCB6bFwP8VKNp3sUChA@mail.gmail.com> <bd8402d6-6d90-c659-6dc4-ac890af900a6@163.com>
In-Reply-To: <bd8402d6-6d90-c659-6dc4-ac890af900a6@163.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 6 Feb 2020 16:40:21 +0100
Message-ID: <CAJfpegvXJ21OzMP2eU0bT4XEb40aAqfkrZdk6AQk5bEWmevOmQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: Don't make buffered read forward overflow value to
 a userspace process
To:     Xiao Yang <ice_yangxiao@163.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, yangx.jy@cn.fujitsu.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 6, 2020 at 1:33 PM Xiao Yang <ice_yangxiao@163.com> wrote:
>
> On 2/6/20 8:14 PM, Miklos Szeredi wrote:
> > On Wed, Feb 5, 2020 at 3:37 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> >> On Mon, Feb 3, 2020 at 8:37 AM Xiao Yang <ice_yangxiao@163.com> wrote:
> >>> Buffered read in fuse normally goes via:
> >>> -> generic_file_buffered_read()
> >>>    ------------------------------
> >>>    -> fuse_readpages()
> >>>      -> fuse_send_readpages()
> >>>    or
> >>>    -> fuse_readpage() [if fuse_readpages() fails to get page]
> >>>      -> fuse_do_readpage()
> >>>    ------------------------------
> >>>        -> fuse_simple_request()
> >>>
> >>> Buffered read changes original offset to page-aligned length by left-shift
> >>> and extends original count to be multiples of PAGE_SIZE and then fuse
> >>> forwards these new parameters to a userspace process, so it is possible
> >>> for the resulting offset(e.g page-aligned offset + extended count) to
> >>> exceed the whole file size(even the max value of off_t) when the userspace
> >>> process does read with new parameters.
> >>>
> >>> xfstests generic/525 gets "pread: Invalid argument" error on virtiofs
> >>> because it triggers this issue.  See the following explanation:
> >>> PAGE_SIZE: 4096, file size: 2^63 - 1
> >>> Original: offset: 2^63 - 2, count: 1
> >>> Changed by buffered read: offset: 2^63 - 4096, count: 4096
> >>> New offset + new count exceeds the file size as well as LLONG_MAX
> >> Thanks for the report and analysis.
> >>
> >> However this patch may corrupt the cache if i_size changes between
> >> calls to fuse_page_length().  (e.g. first page length set to 33;
> >> second page length to 45; then 33-4095 will be zeroed and 4096-4140
> >> will be filled from offset 33-77).  This will be mitigated by the
> >> pages being invalidated when i_size changes
> >> (fuse_change_attributes()).  Filling the pages with wrong data is not
> >> a good idea regardless.
> >>
> >> I think the best approach is first to just fix the xfstest reported
> >> bug by clamping the end offset to LLONG_MAX.  That's a simple patch,
> >> independent of i_size, and hence trivial to verify and hard to mess
> >> up.
> > Applied a fix and pushed to:
> >
> >    git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git#for-next
>
> Hi Miklos,
>
> Sorry for the late reply.
>
> You have applied a fix quickly when I am going to send a patch today.
>
> Just one comment for your fix:
>
> I think we need to add the overflow check in fuse_send_readpages() and
> fuse_do_readpage().
>
> Because generic_file_buffered_read() will call fuse_readpage() if
> fuse_readpages() fails to get page.

Thanks, fixed.

Miklos
