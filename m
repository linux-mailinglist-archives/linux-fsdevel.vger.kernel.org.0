Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7071221FDA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbgGNTmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729427AbgGNTmU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:42:20 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4585C061755;
        Tue, 14 Jul 2020 12:42:20 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so8056344pgf.0;
        Tue, 14 Jul 2020 12:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ZhRanqEZ6xrzrFJNj1TcXKoTTLAuy/jV3gWLNq6hZ4=;
        b=giu+sL5nBFSemahOaz6MWi28NSoEh5gBWf7W/REahIs3P6gyU45zkCg2aKS23Dn0S0
         M/gnZ9RUATYkOYeuop9a3noUH4U0ds3U4otsNJ3HVeUWMSUBQ7IDgRWFohRw/8wrjVne
         /FdX1Ekj/KQ4rJjpw1GwMn2lSMiwaZL63W0lUaeaAzpL/U7drbicEP46mKpmZZEN4yfi
         vq3nQnGox9EZjQ3R2vpbG+OjVSMFpNwSvFu6oSjZCZ54dJcJMeMQ8ucWLY+KPQ7UHG25
         QyNK4NgQT6oUSL/7yWEFfasxf5/E5Dii8tH73DLtBasnMYN0HnD90rSMFe4A8zWEpl1z
         +v/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ZhRanqEZ6xrzrFJNj1TcXKoTTLAuy/jV3gWLNq6hZ4=;
        b=EhRU0Ax1MA68QUWzp0TtspNjurMN2WYEcgfTY73L5U60QBAyKTVY7KLL4/Tl/ReEhB
         wUtKY/OxtzOljKMhypikF4l3zpNfA4NoIEyHBqLxvrji1H9p9QOjpLiH2s/knx6Emnd2
         lObxVTA/jNZZnNf1sRUtY7r4z6ARnouJqnl/eEGg3EUrS7hMFPzHM5wwKOqnbPUKUsWV
         ssp9bAvj6UXdsKJ2B0KbgsSsiZRLPw0JRuFEQfy1jKCWqnRD1+jPyK60DPeMerJ6pGRZ
         OfptGinbrciwJx9+GW/wctkgSIf7E4WeSlxsCHbz3156d32aXi5JRHcNvMflai6I7Cb0
         WOgw==
X-Gm-Message-State: AOAM533XtrJ0iK+azwqC8EQP9P8D8VSeUGEsmgM9b+yftBlooD2heZv5
        40vR0iuVZs4h43oRKEmNjfb3+kAQi7I=
X-Google-Smtp-Source: ABdhPJwCZW0EI5rCFgMKvm2MFTrsjjZtvXTrUu9XHGbNrwtGiJZJ/jM8nhz7CjNBJzySZOjUfWeRrw==
X-Received: by 2002:a62:4e06:: with SMTP id c6mr5741389pfb.296.1594755740258;
        Tue, 14 Jul 2020 12:42:20 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:96f0])
        by smtp.gmail.com with ESMTPSA id f2sm5394pfb.184.2020.07.14.12.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 12:42:19 -0700 (PDT)
Date:   Tue, 14 Jul 2020 12:42:16 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [merged][PATCH v3 00/16] Make the user mode driver code a better
 citizen
Message-ID: <20200714194216.sq2e3z44htts57qf@ast-mbp.dhcp.thefacebook.com>
References: <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
 <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
 <87y2oac50p.fsf@x220.int.ebiederm.org>
 <87bll17ili.fsf_-_@x220.int.ebiederm.org>
 <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
 <87r1tke44q.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1tke44q.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 09, 2020 at 05:05:09PM -0500, Eric W. Biederman wrote:
> 
> I have merged all of this into my exec-next tree.
> 
> The code is also available on the frozen branch:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git usermode-driver-cleanup
> 
> Declaring this set of changes done now, allows the work that depends
> upon this change to proceed.

Now I've pulled it into bpf-next as well.
In the mean time there were changes to kernel_write that broke bpfilter.ko
I fixed it up as well.
Thanks.
