Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD1FD3187B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Jun 2019 01:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfEaX5z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 19:57:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40762 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfEaX5z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 19:57:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id g69so4608912plb.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2019 16:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=t9nVl1gIHwlIdoPhU2OlffJsZVlBCqHfyxU1NxDBE+w=;
        b=XxqpFoEDxxYsXv/4FPKC3EeDy86Qea4fXnheC/QErrqTaFfb1DYKcOc9xLjxyp50fJ
         I7l4GQTXs7FBCzfUE/1WzOUe2DrXMZr68q2n8GhYcxryXpgvfTq2xiswwW71gQZeb0To
         EgX0kyQInFc5VoFMQRHEBrztfuU3p8gRUJX0dENTdMbwifbDFpzh1YxzD9i0TXK6Aq8I
         hYyR4q/WjiEdjBuNblWEPKiruEZfQ+qBtWKEsjl+2FueVcKvgL7Or1DlqCOGX0UWXX85
         evuqYlr6myFuaLyDYji1YhCn5Pe9bQaRG5r1XQcuc4XmNUzpu3aQIUXYkA1MVwBuS4si
         FygQ==
X-Gm-Message-State: APjAAAUdOozSPLf7OXkMeX7ecMmfRu1LXQbaT11ERO5lNZf1Awz3Scpy
        JixbxojI5U0AJkc2KLQv14Ow81CBlbc=
X-Google-Smtp-Source: APXvYqxtos57K7T2XrlqEmaGz3PgUmvWlxnSpQme8O4EI89epWX4DYPjXoKLLCIvww44k1fLGUHRiA==
X-Received: by 2002:a17:902:bb96:: with SMTP id m22mr13017495pls.5.1559347074023;
        Fri, 31 May 2019 16:57:54 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id t124sm7527066pfb.80.2019.05.31.16.57.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 16:57:53 -0700 (PDT)
Date:   Fri, 31 May 2019 16:57:53 -0700 (PDT)
X-Google-Original-Date: Fri, 31 May 2019 16:42:25 PDT (-0700)
Subject:     Re: [PATCH 3/5] asm-generic: Register fchmodat4 as syscall 428
In-Reply-To: <CAK8P3a2=xko56LbwV4tyhyyyX+tw+EV-NGavYEYj0q61t=mnwg@mail.gmail.com>
CC:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-d362e451-72d2-4893-a749-8469359b65ea@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 31 May 2019 12:56:39 PDT (-0700), Arnd Bergmann wrote:
> On Fri, May 31, 2019 at 9:23 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>
> As usual, each patch needs a changelog text. I would prefer having a single
> patch here that changes /all/ system call tables at once, rather than doing one
> at a time like we used to.

Works for me.  That also gives me something to write about it the text :)

> In linux-next, we are at number 434 now, and there are a couple of other
> new system calls being proposed right now (more than usual), so you may
> have to change the number a few times.

OK, no problem.  It'll be a bit easier to handle the number that way.

> Note: most architectures use .tbl files now, the exceptions are
> include/uapi/asm-generic/unistd.h and arch/arm64/include/asm/unistd32.h,
> and the latter also requires changing __NR_compat_syscalls in asm/unistd.h.
>
> Numbers should now be the same across architectures, except for alpha,
> which has a +110 offset. We have discussed ways to have a single
> file to modify for a new call on all architectures, but no patches yet.

OK, thanks.  I'll wait a bit for feedback, but unless there's anything else
I'll go ahead and finish this.
