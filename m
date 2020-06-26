Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C396820B60A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 18:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgFZQlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 12:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgFZQlA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 12:41:00 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47693C03E979;
        Fri, 26 Jun 2020 09:41:00 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b92so5166781pjc.4;
        Fri, 26 Jun 2020 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5LqYW51xK7TQbCbavtAtx+YWA3LheD03lcE6SqTAvKM=;
        b=F9l5RIiHhKx7cv+0X++i1kS7HsIaegPg8MCSmRVy5AJ8EDvtkK7pKyRX3w2SN9PRMH
         N1NOLSxOdItdFZBezn+QSxKsHYZHNqBlTSNbYU8LVsMPGr/c10bxz86BmY+RLQq/WNIj
         TOviNHMyYAhuvO/Lf493loj9jdL3c60yI7KasQJng0jWxmrIXhnBxmo0e1Z1TF21vE7x
         jmxYwN+DVifFKF/t2HLgUK0ntt+dDMH4gW30xaDFfpn1oIpqPO9wE6BMdTIjIqVBSgo0
         msl/QQoRgVrqbtuRk+gY8FURCmgD9DghIEL39jGcEONNhcsXP4lAakcPhwX8rG7a+8Zg
         1DUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5LqYW51xK7TQbCbavtAtx+YWA3LheD03lcE6SqTAvKM=;
        b=f2fNsDqYVMWauNLXPpzu7+78yTgJHOejEafNB2m69b9LtHYDqMRIVkLWrnaiqmAkto
         tecYXP1JMJOiCz1MMFd4C+dCMDUAHWFQIMtioHOcQX4yiq0uy7QoJm+HEezfeoI9G38R
         qN6KSmHXI5IW60PtslQ2DO2yS5OdURlNehV4Bo9jC/TCwPkWe8GZLoNckHx0GQtfgXE2
         6PzBAPR5GT472r6pEFVJikx4PHdacC/9O5Kavcyshd0gf/3N2luHCANNnHJFEZi3uJcQ
         tgTFniySsE0oyIpRGXO/Q8BDCgx5qyQSTH3lTvQS/honSsLmwLamGmX6XYv3ziu56CdF
         D6aA==
X-Gm-Message-State: AOAM533J7+wRFd3MlzfYhogtcXmULQl2Z/fDpmrX7LpG0DhPWNhfu2Zi
        YkB/T0M9PosLXzyPHInVo0g=
X-Google-Smtp-Source: ABdhPJwHsrMmONv391Xu9tVdSIZQdCYzxm0kL8g2QpDGSvWvA+1Axe3AtLf8HO9Yqlps0G/lj+BxPQ==
X-Received: by 2002:a17:902:a40c:: with SMTP id p12mr3373541plq.150.1593189659540;
        Fri, 26 Jun 2020 09:40:59 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:52bf])
        by smtp.gmail.com with ESMTPSA id o128sm2692849pfg.127.2020.06.26.09.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 09:40:58 -0700 (PDT)
Date:   Fri, 26 Jun 2020 09:40:55 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
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
        Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 00/14] Make the user mode driver code a better citizen
Message-ID: <20200626164055.5iasnou57yrtt6wz@ast-mbp.dhcp.thefacebook.com>
References: <20200625095725.GA3303921@kroah.com>
 <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
 <20200625120725.GA3493334@kroah.com>
 <20200625.123437.2219826613137938086.davem@davemloft.net>
 <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
 <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 26, 2020 at 07:51:41AM -0500, Eric W. Biederman wrote:
> 
> Asking for people to fix their bugs in this user mode driver code has
> been remarkably unproductive.  So here are my bug fixes.
> 
> I have tested them by booting with the code compiled in and
> by killing "bpfilter_umh" and running iptables -vnL to restart
> the userspace driver.
> 
> I have split the changes into small enough pieces so they should be
> easily readable and testable.  
> 
> The changes lean into the preexisting interfaces in the kernel and
> remove special cases for user mode driver code in favor of solutions
> that don't need special cases.  This results in smaller code with
> fewer bugs.
> 
> At a practical level this removes the maintenance burden of the
> user mode drivers from the user mode helper code and from exec as
> the special cases are removed.
> 
> Similarly the LSM interaction bugs are fixed by not having unnecessary
> special cases for user mode drivers.
> 
> Please let me know if you see any bugs.  Once the code review is
> finished I plan to take this through my tree.

I did a quick look and I like the cleanup. Thanks! The end result looks good.
The only problem that you keep breaking the build between patches,
so series will not be bisectable.
blob_to_mnt is a great idea. Much better than embedding fs you advocated earlier.

I'm swamped with other stuff today and will test the set Sunday/Monday
with other patches that I'm working on.
I'm not sure why you want to rename the interface. Seems pointless. But fine.

As far as routing trees. Do you mind I'll take it via bpf-next ?
As I said countless times we're working on bpf_iter using fork_blob.
If you take this set via your tree we would need to wait the whole kernel release.
Which is 8+ weeks before we can use the interface (due to renaming and overall changes).
I'd really like to avoid this huge delay.
Unless you can land it into 5.8-rc2 or rc3.
