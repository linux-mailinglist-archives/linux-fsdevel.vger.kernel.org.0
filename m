Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A03C249D0CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 18:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbiAZRcr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 12:32:47 -0500
Received: from mx1.mailbun.net ([170.39.20.100]:35956 "EHLO mx1.mailbun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243784AbiAZRcq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 12:32:46 -0500
Received: from [2607:fb90:d98b:8818:5079:94eb:24d5:e5c3] (unknown [172.58.109.194])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ariadne@dereferenced.org)
        by mx1.mailbun.net (Postfix) with ESMTPSA id BE499E0833;
        Wed, 26 Jan 2022 17:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dereferenced.org;
        s=mailbun; t=1643218365;
        bh=VyVwJZxqM+mG+8S6BSOCPiJeMsH3GkOoTp5Rc87H+dE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=bCeHXWfVGTsQAwzf5hSapW5Kc3+j+QInLMY4/CJCPjbCRYmZ7owzSNypUPvMr8jlR
         BfsKDPnW0Ry6GmRCPqmYk9AZwcMOomaBoUdTmpyuA8AcYVf/EhZxzH0F7q0PSGv5XW
         +e9On7A6KSf8SplOLXNpc6eywWotlRAK9lTw2HzdNHB2CHlPmGoGKIR5zuFxYSwXjy
         Sygy0dDgHb82NR8kuPF42k2XWTAcG8AXD5fykfUs52d1Yx0KtyjOQzhx95FNNAlX1+
         Hb+1gKpQpMEMVvTaRFuHhYhZ+eMw1mA/4cz040l4tmsmCp4eoW7F6SS2Jp8YD8Dw6q
         srJvSy1Yk/wIg==
Date:   Wed, 26 Jan 2022 11:32:38 -0600 (CST)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
cc:     Matthew Wilcox <willy@infradead.org>,
        Ariadne Conill <ariadne@dereferenced.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs/exec: require argv[0] presence in
 do_execveat_common()
In-Reply-To: <877damwi2u.fsf@email.froward.int.ebiederm.org>
Message-ID: <9e276534-5c97-67fc-4bae-8de11bab57ab@dereferenced.org>
References: <20220126114447.25776-1-ariadne@dereferenced.org> <YfFh6O2JS6MybamT@casper.infradead.org> <877damwi2u.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Wed, 26 Jan 2022, Eric W. Biederman wrote:

> Matthew Wilcox <willy@infradead.org> writes:
>
>> On Wed, Jan 26, 2022 at 11:44:47AM +0000, Ariadne Conill wrote:
>>> Interestingly, Michael Kerrisk opened an issue about this in 2008[1],
>>> but there was no consensus to support fixing this issue then.
>>> Hopefully now that CVE-2021-4034 shows practical exploitative use
>>> of this bug in a shellcode, we can reconsider.
>>>
>>> [0]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html
>>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=8408
>>
>> Having now read 8408 ... if ABI change is a concern (and I really doubt
>> it is), we could treat calling execve() with a NULL argv as if the
>> caller had passed an array of length 1 with the first element set to
>> NULL.  Just like we reopen fds 0,1,2 for suid execs if they were
>> closed.
>
> Where do we reopen fds 0,1,2 for suid execs?  I feel silly but I looked
> through the code fs/exec.c quickly and I could not see it.
>
>
> I am attracted to the notion of converting an empty argv array passed
> to the kernel into something we can safely pass to userspace.
>
> I think it would need to be having the first entry point to "" instead
> of the first entry being NULL.  That would maintain the invariant that you
> can always dereference a pointer in the argv array.

Yes, I think this is correct, because there's a lot of programs out there 
which will try to blindly read from argv[0], assuming it is present. 
Ensuring we wind up with {"", NULL} would be the way I would want to 
approach this if we go that route.

This approach would solve the problem with pkexec, but I still think there 
is some wisdom in denying with -EFAULT outright like other systems do.

Ariadne
