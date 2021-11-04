Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98C5A4452D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 13:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhKDMUl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 08:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhKDMUk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 08:20:40 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA47C061714
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Nov 2021 05:18:02 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id i6so10369071uae.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Nov 2021 05:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RTUOBigYprSDOSFBZlrdvWF0TjMaLEUW+f2tRV3OT6g=;
        b=QE8m3S5NxgzsIFqtQEzvK04sRrsFyJtjg3I5B1NHEonhKYNOxow7yFp6OU2O8iqyyf
         IhMsIYIfd04WYLwn0Vq/BGM+K0dV48DlMnrlhAnqL3JmeuAxXH6bK48DL4PdEERAKQ8A
         rc/gVTG4M/S9Bh6TkVLg/lg27r8MUfbIVcRns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RTUOBigYprSDOSFBZlrdvWF0TjMaLEUW+f2tRV3OT6g=;
        b=U00HIlOjfN3nzVr0UwQICHlShTIvgrn8Q0jjXMWdS/qWSt3diPmP67ow+7oTBDOjvq
         FrlDMZ+Uo1RDyUIrAAAogbtnKA0LNCul364ci222+4/1bLBktKFpi7rPTDEg18X8/cyg
         egQo0IvYX3lw7Y2Hiii72wzAnAZAK5HepJJw79odh8qdTt7Hf6oSjh547knRglh25qyw
         7RxptLkEo4qGjWFl9K/GEfyQ0LDz4NePYN83w85rUreAI0FyVJbuT0vcG6WrsJzMG3J2
         sAjpwTQsNXwk60/FLRVnw6KX2ZGYsmw/fsvdRMCctGbS0A7ocHl9wSZmgkfFX+HYN13i
         9P4g==
X-Gm-Message-State: AOAM532lQ36rf69nVvvKPT7QL1jxmqFriN5pwjfRrTmuqUj5UyL7V/YT
        vXasE/NbG7Lc6DO2W1aKEXRa1GvV0F3Vej+aI/8l+mw+C2c=
X-Google-Smtp-Source: ABdhPJwWg6oh7iHifKyoltzizBmtDg8ZnKqtRi+i/OSK2axZR0pJdZTFXXfJZC6C6WKCi+xkMN8x49JTJEGWJgBT2P4=
X-Received: by 2002:a05:6102:3e84:: with SMTP id m4mr60444007vsv.51.1636028281822;
 Thu, 04 Nov 2021 05:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211103011527.42711-1-flyingpeng@tencent.com>
In-Reply-To: <20211103011527.42711-1-flyingpeng@tencent.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 4 Nov 2021 13:17:50 +0100
Message-ID: <CAJfpeguWtPFG_daMNA7=T-kQmgkcTPugMj7HWhh2mu+cwRWbxw@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix possible write position calculation error
To:     Peng Hao <flyingpenghao@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 3 Nov 2021 at 02:15, Peng Hao <flyingpenghao@gmail.com> wrote:
>
> The 'written' that generic_file_direct_write return through
> filemap_write_and_wait_range is not necessarily sequential,
> and its iocb->ki_pos has not been updated.

I don't see the bug, but maybe I'm missing something.  Can you please
explain in detail?

The patch looks good as a cleanup, but I'd very much like to know
first if it fixes a bug or not.

Thanks,
Miklos
