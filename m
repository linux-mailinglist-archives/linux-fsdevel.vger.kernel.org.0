Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9281CA0BF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 May 2020 04:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgEHCVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 22:21:42 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40539 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgEHCVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 22:21:42 -0400
Received: by mail-pj1-f67.google.com with SMTP id fu13so3532196pjb.5;
        Thu, 07 May 2020 19:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sCk5Kz/L26R1qfSoCe3hO4Rdhm8Vcm0AKmqx9EEaRqs=;
        b=GgrSEpYxmRnwgkfEMzNHaEEGcXonN62oS7LQy87JSRzcfQdgUqNUpqWjSvp0Fi4rpu
         IGWc5WQE+UaFJsEQCLzNvqBkIxoMlraK4+mv45CRctt77REW3y29/t0OSF00fJpi0Kwy
         jU8ogrUWcPwO1GsuV7iJGLV1otzYgKV1YWXopii6ueYQeXa8b7J6tl9u/pTelgl46Ngg
         LWsOiRu9dxlkGfGqlOZNfMxSwGCItvVDKLEufISC0EshLWeNuS3vCKOK4b9APicoBNX6
         Ee80nLns+YcFiJTqHDrJ17hGjuHE36acW5GVCPUZJ1dIHmlpNSjIHfOhLR6zcWILqzCm
         fKlw==
X-Gm-Message-State: AGi0PubStuagHkGFZss0QGBDHY8R1c8IqDDRmJtwvqD0xKjBqV6SAsDC
        Q5MV3PAzq53sR492kI2I6uI=
X-Google-Smtp-Source: APiQypLH3bqzMjxBt959/wwSgBKL1pGSXtPpBArl9pMYffCVuSDie8PJG/ipY+C3Q4wfk1BvF3nCEw==
X-Received: by 2002:a17:902:7c98:: with SMTP id y24mr161013pll.37.1588904500948;
        Thu, 07 May 2020 19:21:40 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g10sm109531pfk.103.2020.05.07.19.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 19:21:40 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7425F403EA; Fri,  8 May 2020 02:21:39 +0000 (UTC)
Date:   Fri, 8 May 2020 02:21:39 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, axboe@kernel.dk,
        zohar@linux.vnet.ibm.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: avoid fdput() after failed fdget() in
 ksys_sync_file_range()
Message-ID: <20200508022139.GD11244@42.do-not-panic.com>
References: <cover.1588894359.git.skhan@linuxfoundation.org>
 <31be6e0896eba59c06eb9d3d137b214f7220cc53.1588894359.git.skhan@linuxfoundation.org>
 <20200508000509.GK23230@ZenIV.linux.org.uk>
 <20200508002422.GL23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508002422.GL23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 08, 2020 at 01:24:22AM +0100, Al Viro wrote:
> On Fri, May 08, 2020 at 01:05:09AM +0100, Al Viro wrote:
> > On Thu, May 07, 2020 at 05:57:09PM -0600, Shuah Khan wrote:
> > > Fix ksys_sync_file_range() to avoid fdput() after a failed fdget().
> > > fdput() doesn't do fput() on this file since FDPUT_FPUT isn't set
> > > in fd.flags. Fix it anyway since failed fdget() doesn't require
> > > a fdput().
> > > 
> > > This was introdcued in a commit to add sync_file_range() helper.
> > 
> > Er...  What's the point microoptimizing the slow path here?
> 
> PS: I'm not saying the patch is incorrect, but Fixes: is IMO over the
> top.  And looking at that thing,
> {
>         struct fd f = fdget(fd);
>         int ret;
> 
> 	if (unlikely(!f.file))
> 		return -EBADF;
> 
> 	ret = sync_file_range(f.file, offset, nbytes, flags);
>         fdput(f);
>         return ret;
> }
> 
> might be cleaner, but that's a matter of taste...

This makes it easier to read.

  Luis
