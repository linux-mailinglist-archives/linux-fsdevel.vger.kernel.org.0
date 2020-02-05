Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66907153327
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 15:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgBEOhb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 09:37:31 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40846 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgBEOhb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:37:31 -0500
Received: by mail-io1-f67.google.com with SMTP id x1so2356909iop.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2020 06:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KVsxPrlJOoFLleMHbSICXmueT3cbTjhLtVKdCJmVFL4=;
        b=QlI2fX9a4+Y2WrA8oTPA6ogiEjScHVdggXONrc33iEqE6jVeWKGRVCjp26KGgWxnTc
         6eFNtogYdtnEsVCW2H82Et7pC7mDkCMhfwiZqsJQp3Gnw76NHlMnOQU8f0HddztjMZ3B
         13trLMzbqWlobDCby1bBUxhd6CDl6ShqjmiCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KVsxPrlJOoFLleMHbSICXmueT3cbTjhLtVKdCJmVFL4=;
        b=giPo9xcOw9lLurNDC8YX8305sewI1LrlFjDNZ5YgkZjMV49+QTYktYve5Jyjs/esr2
         lufj/3BDmMer6fUl5c/HndmYk7gvnhF1Di/lQOFz1wtIK1FeAUhHhlAymXZoUOSdhyZa
         REyCttQKfE4TAQH2w7nUf/PqJ4G1ufJq+zCio3/Bg+lSjmwhDFGPmobeD8XRjZECRrtV
         TyOGr05M4EqGzN8XXk/pXpb2O7AWfpGBrnmdbiF8n9ANYHKERX+3YNG+0DDrYfVpl7/A
         v50VkpAQ00gyk7rcN4pQKVr7lUNMVmKjjUIqAbYZSIifMrU9V7I8jo4vuYWaRFbenYk+
         3H+Q==
X-Gm-Message-State: APjAAAW5TtqcYDBqG9B1FS8vGuaBFbTX86VBNG9b9wDokjvqM0Ef7bbe
        S6S6mQPQcj6OYHdpJSHWYeUYN9cV7La8cX4S7cy7fg==
X-Google-Smtp-Source: APXvYqy98RKg+Pgm4U7b+FcfGbysES+PfP7XDug8jlZJTRdDySnhwHF20SyI2do5+mGu5TgWQwFvyHMsF/ZNJ615gFE=
X-Received: by 2002:a6b:24b:: with SMTP id 72mr26293862ioc.63.1580913450627;
 Wed, 05 Feb 2020 06:37:30 -0800 (PST)
MIME-Version: 1.0
References: <20200203073652.12067-1-ice_yangxiao@163.com>
In-Reply-To: <20200203073652.12067-1-ice_yangxiao@163.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Feb 2020 15:37:19 +0100
Message-ID: <CAJfpegsVjca2xGV=9xwE75a5NRSYqLpDu9x_q9CeDZ1vt-GyyQ@mail.gmail.com>
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

On Mon, Feb 3, 2020 at 8:37 AM Xiao Yang <ice_yangxiao@163.com> wrote:
>
> Buffered read in fuse normally goes via:
> -> generic_file_buffered_read()
>   ------------------------------
>   -> fuse_readpages()
>     -> fuse_send_readpages()
>   or
>   -> fuse_readpage() [if fuse_readpages() fails to get page]
>     -> fuse_do_readpage()
>   ------------------------------
>       -> fuse_simple_request()
>
> Buffered read changes original offset to page-aligned length by left-shift
> and extends original count to be multiples of PAGE_SIZE and then fuse
> forwards these new parameters to a userspace process, so it is possible
> for the resulting offset(e.g page-aligned offset + extended count) to
> exceed the whole file size(even the max value of off_t) when the userspace
> process does read with new parameters.
>
> xfstests generic/525 gets "pread: Invalid argument" error on virtiofs
> because it triggers this issue.  See the following explanation:
> PAGE_SIZE: 4096, file size: 2^63 - 1
> Original: offset: 2^63 - 2, count: 1
> Changed by buffered read: offset: 2^63 - 4096, count: 4096
> New offset + new count exceeds the file size as well as LLONG_MAX

Thanks for the report and analysis.

However this patch may corrupt the cache if i_size changes between
calls to fuse_page_length().  (e.g. first page length set to 33;
second page length to 45; then 33-4095 will be zeroed and 4096-4140
will be filled from offset 33-77).  This will be mitigated by the
pages being invalidated when i_size changes
(fuse_change_attributes()).  Filling the pages with wrong data is not
a good idea regardless.

I think the best approach is first to just fix the xfstest reported
bug by clamping the end offset to LLONG_MAX.  That's a simple patch,
independent of i_size, and hence trivial to verify and hard to mess
up.

Then we can think about  clamping to i_size, whether it is necessary
and if it is, how to best implement it.

Thanks,
Miklos
