Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9AF413501
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 16:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhIUOHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 10:07:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40638 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233448AbhIUOHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 10:07:09 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A1EFF2014A;
        Tue, 21 Sep 2021 14:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632233139;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E557MN5H/z8gMR1F1UOzgrMHbd/CGDwH5EaTlthnE2Q=;
        b=v7PwXdhSncGdSn0M9Iq8A3YFGWARdPt3gbuo815jkU+soPK31djxrG92ITY9NNfKHraOal
        rA0KcBFdcdl+5Y1KKvi4EktFSrFglCPD3Fb2n9F4GBSa7dAmN4068mz/iwksfh1R8oErRg
        3GNQHficINR3MCbjv/JZLme3g1KsVzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632233139;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E557MN5H/z8gMR1F1UOzgrMHbd/CGDwH5EaTlthnE2Q=;
        b=PKvj/vdOw6eDti9HjiU84sIJYlLtvn8+PLaYrxEPOXszzqowYIXPaJNymb5oe/3evCNwNm
        kVstYJmGCMCSJDBQ==
Received: from g78 (unknown [10.163.24.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DCD40A3B84;
        Tue, 21 Sep 2021 14:05:38 +0000 (UTC)
References: <20210921130127.24131-1-rpalethorpe@suse.com>
 <CAK8P3a29ycNqOC_pD-UUtK37jK=Rz=nik=022Q1XtXr6-o6tuA@mail.gmail.com>
User-agent: mu4e 1.4.15; emacs 27.2
From:   Richard Palethorpe <rpalethorpe@suse.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [PATCH] aio: Wire up compat_sys_io_pgetevents_time64 for x86
Reply-To: rpalethorpe@suse.de
In-reply-to: <CAK8P3a29ycNqOC_pD-UUtK37jK=Rz=nik=022Q1XtXr6-o6tuA@mail.gmail.com>
Date:   Tue, 21 Sep 2021 15:05:38 +0100
Message-ID: <87o88mkor1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Arnd,

Arnd Bergmann <arnd@arndb.de> writes:

> On Tue, Sep 21, 2021 at 3:01 PM Richard Palethorpe <rpalethorpe@suse.com> wrote:
>>
>> The LTP test io_pgetevents02 fails in 32bit compat mode because an
>> nr_max of -1 appears to be treated as a large positive integer. This
>> causes pgetevents_time64 to return an event. The test expects the call
>> to fail and errno to be set to EINVAL.
>>
>> Using the compat syscall fixes the issue.
>>
>> Fixes: 7a35397f8c06 ("io_pgetevents: use __kernel_timespec")
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>
> Thanks a lot for finding this, indeed there is definitely a mistake that
> this function is defined and not used, but I don't yet see how it would
> get to the specific failure you report.
>
> Between the two implementations, I can see a difference in the
> handling of the signal mask, but that should only affect architectures
> with incompatible compat_sigset_t, i.e. big-endian or
> _COMPAT_NSIG_WORDS!=_NSIG_WORDS, and the latter is
> never true for currently supported architectures. On x86, there is
> no difference in the sigset at all.
>
> The negative 'nr' and 'min_nr' arguments that you list as causing
> the problem /should/ be converted by the magic
> SYSCALL_DEFINE6() definition. If this is currently broken, I would
> expect other syscalls to be affected as well.

That is what I thought, but I couldn't think of another explanation for
it.

>
> Have you tried reproducing this on non-x86 architectures? If I
> misremembered how the compat conversion in SYSCALL_DEFINE6()
> works, then all architectures that support CONFIG_COMPAT have
> to be fixed.
>
>          Arnd

No, but I suppose I can try it on ARM or PowerPC. I suppose printing the
arguments would be a good idea too.

-- 
Thank you,
Richard.
