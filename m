Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBC41F087F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 22:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgFFUUD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 16:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgFFUUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 16:20:02 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCD7C03E96A;
        Sat,  6 Jun 2020 13:20:02 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id n9so5083207plk.1;
        Sat, 06 Jun 2020 13:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CHGImcU/cj8lWEPjqadgQCbjW/jQNwwqL4MPqrF+GpA=;
        b=fMqfpIzKuGUSwbzMMg2dAN+EsLwSlFRze2xP70TzrEkDvc2vmb7R5byVmPFYfYtK42
         NB5gahmga/I8kqBK+zu2L6hJ23r36w/DkEYKQmHPyqTAB1Gl6bY0hWyjPm+zb0Y0r7KZ
         RyFu+RGDEDHwro2f1ygo+uphmUw0qe8oOtm50o9gj8GJVervRHJ8FRxczVsUAleDpzHB
         0UI5QPtMP2DWaQDwzQi/jtia2niG5lxSYFe6AqBiiomNFNWQ+XfjTAIwcMPPBEf2jKZ3
         E2rIW0r6805MwP1sWIuEAyPhSNvlQ3bfJd3qNFeejbkWwNqpujjfwLOH8SUvjlANIVJR
         rJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CHGImcU/cj8lWEPjqadgQCbjW/jQNwwqL4MPqrF+GpA=;
        b=gyr6Z+j2Zkp5j2UIYJQGVFNc1UIH1r/cIcvSfWBmI8mgAwPAXyV32y0MLAEOeg/qiC
         FpBuOQcToQsSWbZEtWcI7oeb+akw2+xvvGi536bUBYdFYybRErSqNhH7RYd3DQzfQ/Q+
         Ion1A0sBCwW+f/TAa1Qfku4dm/kohv4aLLEpbHf5XZRt6mseiWSvQLNE+b67cquFyuai
         qzFN5sNoDUoegJkh/S6Ch97jCztU+CCvAV9YjaZFE2Z1NP/WZCa8qNOThAht49sDJ6s/
         N66dugDuEzbaoBPvXNn92KW+8MvRzEwcNubNMjoMV7X2zjg3TxxcYO+++UMGvU6ZNqD8
         80JQ==
X-Gm-Message-State: AOAM531xOK5UHmc95J+aQVQxRj/NHs2ipJDcYGS8LFBb4Av1Ds3zd7E2
        4OB5+Ued4cWBlY0lJ44qzVRV0zB7
X-Google-Smtp-Source: ABdhPJxaB4pNUdoeUNBhis3GWzoEUE7cjprkUPCHPjZv+WuUtQZgSiCkm4Emj3l2lcp9EQim4xYqFA==
X-Received: by 2002:a17:90b:4c0f:: with SMTP id na15mr9414418pjb.112.1591474801676;
        Sat, 06 Jun 2020 13:20:01 -0700 (PDT)
Received: from ast-mbp ([199.231.241.130])
        by smtp.gmail.com with ESMTPSA id m15sm2470223pgv.45.2020.06.06.13.20.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jun 2020 13:20:00 -0700 (PDT)
Date:   Sat, 6 Jun 2020 13:19:58 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        akpm@linux-foundation.org, ast@kernel.org, davem@davemloft.net,
        viro@zeniv.linux.org.uk, bpf <bpf@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] net/bpfilter:  Remove this broken and apparently
 unmantained
Message-ID: <20200606201956.rvfanoqkevjcptfl@ast-mbp>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
 <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
 <202006051903.C44988B@keescook>
 <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
User-Agent: NeoMutt/20180223
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 06, 2020 at 02:20:36PM -0500, Eric W. Biederman wrote:
> 
> Tetsuo Honda recently noticed that the exec support of bpfilter is buggy.
> https://lore.kernel.org/linux-fsdevel/2a8775b4-1dd5-9d5c-aa42-9872445e0942@i-love.sakura.ne.jp/
> 
> I agree with Al that Tetsuo's patch does not lend clarity to the code in
> exec.  At a rough glance Tetsuo's patch does appear correct.
> 
> There have been no replies from the people who I expect would be
> maintainers of the code.  When I look at the history of the code all it
> appears to have received since it was merged was trivial maintenance
> updates.  There has been no apparent work to finish fleshing out the
> code to do what it is was aimed to do.
> 
> Examinine the code the pid handling is questionable.  The custom hook
> into do_exit might prevent it but it appears that shutdown_umh has every
> possibility of sending SIGKILL to the wrong process.
> 
> The Kconfig documentation lists this code as experimental.
> 
> The code only supports ipv4 not ipv6 another strong sign that this
> code has not been going anywhere.
> 
> So as far as I can tell this bpfilter code was an experiment that did
> not succeed and now no one cares about it.
> 
> So let's fix all of the bugs by removing the code.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---
> 
> Kees, Tesuo.  Unless someone chimes in and says they care I will
> rebase this patch onto -rc1 to ensure I haven't missed something
> because of the merge window and send this to Linus.

NACKed-by: Alexei Starovoitov <ast@kernel.org>

Please mention specific bugs and let's fix them.
