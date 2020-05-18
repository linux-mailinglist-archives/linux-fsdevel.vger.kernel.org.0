Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94841D792E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 15:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgERNDB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 09:03:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60458 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgERNDB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 09:03:01 -0400
Received: from ip5f5af183.dynamic.kabel-deutschland.de ([95.90.241.131] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jafPw-0006cd-7l; Mon, 18 May 2020 13:02:52 +0000
Date:   Mon, 18 May 2020 15:02:51 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] exec: Change uselib(2) IS_SREG() failure to EACCES
Message-ID: <20200518130251.zih2s32q2rxhxg6f@wittgenstein>
References: <20200518055457.12302-1-keescook@chromium.org>
 <20200518055457.12302-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200518055457.12302-2-keescook@chromium.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 17, 2020 at 10:54:54PM -0700, Kees Cook wrote:
> Change uselib(2)' S_ISREG() error return to EACCES instead of EINVAL so
> the behavior matches execve(2), and the seemingly documented value.
> The "not a regular file" failure mode of execve(2) is explicitly
> documented[1], but it is not mentioned in uselib(2)[2] which does,
> however, say that open(2) and mmap(2) errors may apply. The documentation
> for open(2) does not include a "not a regular file" error[3], but mmap(2)
> does[4], and it is EACCES.
> 
> [1] http://man7.org/linux/man-pages/man2/execve.2.html#ERRORS
> [2] http://man7.org/linux/man-pages/man2/uselib.2.html#ERRORS
> [3] http://man7.org/linux/man-pages/man2/open.2.html#ERRORS
> [4] http://man7.org/linux/man-pages/man2/mmap.2.html#ERRORS
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

This is all extremely weird.
uselib has been deprected since forever basically which makes me doubt
this matters much but:
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Also - gulp (puts on flame proof suit) - may I suggest we check if there
are any distros out there that still set CONFIG_USELIB=y and if not do
what we did with the sysctl syscall and remove it? If someone yells we
can always backpaddle...

Christian
