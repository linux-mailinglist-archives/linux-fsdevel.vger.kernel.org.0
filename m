Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE3822333E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 08:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgGQGCs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 02:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgGQGCs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:02:48 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC71C061755;
        Thu, 16 Jul 2020 23:02:47 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id k6so6404625ili.6;
        Thu, 16 Jul 2020 23:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ve/cmXtNUOqHiayEYTadiiBcyTXVbObeiw7WV4ExN98=;
        b=VbOvQYl/a15OZU3ZulHv64cd9EjeIZTIQ/l9Ih0MNzUws8Gr+INBxuM3rcBDbbG5fU
         kOCg2WnqrEiOr6T5HWD6fAOmYMd/uciZ+ubDNcXEAdl5h3u8y7T96tvNoduqGPicJIEV
         /T0JCyOpGz6pUVf+/7BdV4eovntNshzSNJAvE6LFZcFnqjF6n7P9uey7KPe5TVPHDMpa
         dq9CegXIHYLPQqdHr7U1o99vB6Iz50iajX1UC/lFemk/k0hMbGSm6FBFTbqUMwDZaqhf
         gM1vjMH6OPNg0olrZ4tL9Y1Ob5V6+WAPZOSGryvEuQTG9XNZtb28RxolBMgKwj1wN0EA
         aVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ve/cmXtNUOqHiayEYTadiiBcyTXVbObeiw7WV4ExN98=;
        b=Rpiz9ZGhsWeyLCpy9gYYNAGEEs0wAR53mDJ4AvFXQihNvddyYkOuk83yFpXhyQ0EvI
         SxtYDC8gcFn+ThgFwl7JVmdMtBSu5OLZ7C2b3Z8TZU0qmxZ356ddHyUgOGsoBOvOVikW
         RrSegGGCQTkpPOH9f7ve5pSJnkribnlmlWWyOquxpVjuzIuYgVUh0XCdgu9DePPGX8t/
         /Q+AK3a9oWjt0lYRGzvAwEcAx69qjV1XyEvW+o4SugmSkdI5fCK1tCT3FpqDx1VbZR4Z
         fWeMu2BABJjXGMVQRKlx1KCD5I62F96NA1UyDvmmlZYPSrYW8HtMykO/Df3ttcKTKivT
         cTUA==
X-Gm-Message-State: AOAM533LGvVXEWcQG47b1EWtV0wWdEQtjvPj/LsEoNryxR1cXyTD8pGq
        VfTekvZf+kUcMoqFdq9qeoWlFOtuKaoqVdu57Mk=
X-Google-Smtp-Source: ABdhPJxw89TDMcyDoUVy003U8UgoW1M2CjP36Z5/idIUBu7FhV64fYfsvsAeNagcVB2rNTRHLStu90ucqP2U2eQU/54=
X-Received: by 2002:a92:5fc9:: with SMTP id i70mr8774183ill.176.1594965767253;
 Thu, 16 Jul 2020 23:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200717050510.95832-1-ebiggers@kernel.org>
In-Reply-To: <20200717050510.95832-1-ebiggers@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 17 Jul 2020 08:02:36 +0200
Message-ID: <CA+icZUXyz8Oy6YBwiX5qgzY_zy3qGeFyEroNBxc+E6_NY-TxUw@mail.gmail.com>
Subject: Re: [PATCH v2] fs/direct-io: fix one-time init of ->s_dio_done_wq
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 7:08 AM Eric Biggers <ebiggers@kernel.org> wrote:
> - The preliminary checks for sb->s_dio_done_wq are a data race, since
>   they do a plain load of a concurrently modified variable.  According
>   to the C standard, this undefined behavior.  In practice, the kernel
>   does sometimes makes assumptions about data races might be okay in

Some small typos:
...this *is* undefined behavior...
...does sometimes make* assumptions about...

- Sedat -
