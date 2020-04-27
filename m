Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241721B9FD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 11:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgD0J03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Apr 2020 05:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726537AbgD0J03 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Apr 2020 05:26:29 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC0CC0610D5
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 02:26:29 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id k8so13541186ejv.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2020 02:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=2+nrkvzlycDjC6Q5oyQFCIiuHCsvZXVHmDNkwcZBpMg=;
        b=Fz2YUAwoMsneNCC+y/OWMaVGw0XvrCmXDkAFKj1YQ02eJOWJfWZN6pZ1rxBIt/1CsF
         9XqTH1uvh2BU74pZgPE+c2XAjFEtrtmjUAWfpUaVw+sf7i2gQKigWc4tp+sqyBZjWjJb
         RY/CUdEJBvBSg9n9QyiB4A57mW24mzwW97c8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2+nrkvzlycDjC6Q5oyQFCIiuHCsvZXVHmDNkwcZBpMg=;
        b=H50TmsjUyEuZ8TLAeXOIxT2zcefun3lSBiQroEMbOKs7VSBGbMFmwNxeqgOsT0W6zb
         6UWYteIa4jeouW4KHAtMQamI4tG8ET/u/yIAVApw37M6hq0nfeEMgQVYYiyZHTK3wcH2
         xhIVtrcb4yNoqY5xUG7zrX7y/YdkS/bcO84J/Y6JRO9VqsvbOEWYjLo37QCJVVjnxyF9
         Peb+u5sLIiPxJ+iY3eRmrz3S3X+RFF4vuSs021YgIrUTN/4ceqjGTMAJ1Na/K3L5J/Fh
         GZYEFx9niQsi8Qf57DzZ+Tie17PGIFjmKn8SSeV59Z0Cg/8q4PMIqXbhcU5eXF0aYzer
         ieaA==
X-Gm-Message-State: AGi0PuZ9X/9wuNVB0jlaxn0Zue65BY2qiEj3+RkfdZLyFsmb93WWe9VF
        aMHPIggv+b74ALkHQinFtvxsNpadxZbuJmEIgiPwDlK90821gQ==
X-Google-Smtp-Source: APiQypLe8lxIvr6C9UirI8cogF8XKvSBvCQFguD600j/FHGqafHlZE07LJL04wQpqh8HoFnE6abcC4WK6mb17roIAz8=
X-Received: by 2002:a17:906:340a:: with SMTP id c10mr19169424ejb.218.1587979587805;
 Mon, 27 Apr 2020 02:26:27 -0700 (PDT)
MIME-Version: 1.0
References: <87k123h4vr.fsf@vostro.rath.org>
In-Reply-To: <87k123h4vr.fsf@vostro.rath.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 27 Apr 2020 11:26:16 +0200
Message-ID: <CAJfpeguqV=++b-PF6o6Y-pLvPioHrM-4mWE2rUqoFbmB7685FA@mail.gmail.com>
Subject: Re: [fuse] Getting visibility into reads from page cache
To:     linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 25, 2020 at 7:07 PM Nikolaus Rath <Nikolaus@rath.org> wrote:
>
> Hello,
>
> For debugging purposes, I would like to get information about read
> requests for FUSE filesystems that are answered from the page cache
> (i.e., that never make it to the FUSE userspace daemon).
>
> What would be the easiest way to accomplish that?
>
> For now I'd be happy with seeing regular reads and knowing when an
> application uses mmap (so that I know that I might be missing reads).
>
>
> Not having done any real kernel-level work, I would start by looking
> into using some tracing framework to hook into the relevant kernel
> function. However, I thought I'd ask here first to make sure that I'm
> not heading into the completely wrong direction.

Bpftrace is a nice high level tracing tool.

E.g.

  sudo bpftrace -e 'kretprobe:fuse_file_read_iter { printf ("fuse
read: %d\n", retval); }'

Thanks,
Miklos
