Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4147142C44
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 14:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgATNja (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 08:39:30 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37097 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgATNja (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:39:30 -0500
Received: by mail-io1-f65.google.com with SMTP id k24so33676713ioc.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2020 05:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hIrVa5Zc0Y/8LAMmD5SZvjRBvVBDNVksOBYzGDIjeGU=;
        b=IzFUeFd5PB/JBWIOe0W6aNsohUdczCpj/2A+NCFNQV1PCD4k8IiMCsj0y4medcFiod
         UOdDI6kkDpko2uv5p9+mt2IJvULy5y994Np+zBxZNg9WXRR88FY5wCH5KdFXe8USsNaQ
         qgFQgEvEAZaoC6Y/fUZvTvD6WnQQivrHL6ggA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hIrVa5Zc0Y/8LAMmD5SZvjRBvVBDNVksOBYzGDIjeGU=;
        b=FQIaG7BKpxjXI+iRG1WY0raa78jG79/wqip0tQrdlprJyINwS2GY6V7jara6T2Saf4
         062NF0AIrr0OUpTJEAbC6tVd/5/n5MKqnHV3e/WocvxN0Dghwg/ZP+RtbZPk9SzWDJ/m
         ZrxYz5o8fmcVtp6nWC6tluNzpRobauHAhqGcLUSRMEyUV4EY4D6cjOHKEo52qf6JHuG4
         M+cxz2HtjjyueknxAWFIuzWQaozV9K5nItuUun3lSj0D8jdkD96b/iIED3z1e8He2dH8
         oX2G1lMx0RPe6RP9oeyNyzIFeLiQP1MP6RfPm1lub1nKH2cbcB1YiSq9gweKxVflz/d0
         oJrw==
X-Gm-Message-State: APjAAAUr0jJnzrf6QHiwAHD/tBiTJ6V8UPPw44/nEMRmmwqYg81p1b2T
        e6ql5N8I3f7HzDL7XbqPXXyNVs3q8zFMsUw3A+1h0aSslQo=
X-Google-Smtp-Source: APXvYqwEFZa85NxoMnRlOMhpXhYC2XLWu2JDUCN0jpUzaBvGuWPPt8kZnzhiKP0UadsI0kv6WYMCekP+h1yfdZL806Y=
X-Received: by 2002:a6b:b74a:: with SMTP id h71mr18380016iof.212.1579527569452;
 Mon, 20 Jan 2020 05:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20200120121310.17601-1-cengiz@kernel.wtf>
In-Reply-To: <20200120121310.17601-1-cengiz@kernel.wtf>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 20 Jan 2020 14:39:18 +0100
Message-ID: <CAJfpegtOOCVrNkSmpmMY0dVH-359jc3RqXJ7K6dzvUqxtCxBtg@mail.gmail.com>
Subject: Re: [PATCH] fs: fuse: check return value of fuse_simple_request
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 20, 2020 at 1:13 PM Cengiz Can <cengiz@kernel.wtf> wrote:
>
> In `fs/fuse/file.c` `fuse_simple_request` is used in multiple places,
> with its return value properly checked for possible errors.
>
> However the usage on `fuse_file_put` ignores its return value. And the
> following `fuse_release_end` call used hard-coded error value of `0`.
>
> This triggers a warning in static analyzers and such.
>
> I've added a variable to capture `fuse_simple_request` result and passed
> that to `fuse_release_end` instead.

Which then goes on to ignore the error, so we are exactly where we
were with some added obscurity, which will be noticed by the next
generation of static analyzer, when you'd come up with an even more
obscure way to ignore the error, etc...  This leads to nowhere.

If this matters (not sure) then we'll need a notation to ignore the
return value.  Does casting to (void) work?

Thanks,
Miklos
