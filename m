Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B3F1F31FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 03:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgFIB0m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 21:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgFIB0l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 21:26:41 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858CFC03E969;
        Mon,  8 Jun 2020 18:26:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u8so633775pje.4;
        Mon, 08 Jun 2020 18:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dHjMTIl41hxK3f+Tai0htksrYLVoZB5v3Ap3BbywxPI=;
        b=FLK+dHCSfZkvGSVqhDwSdYsqD83M8Y1TphFycMkD9+U7o83E79zmFi310YPM+g2E/E
         R8MbwCrDkTA3KeSh8LQSdXAJdRgi6CGSfjOLrBO+G+ew1rHGFJgIH0YXLrY++fS4lWlC
         MqtKBGB+TxjepS6tb5wBAZbM+mAbvajfFA3NmrsC9TP/U4AVhkOeYdMdyKCJYGsVzkVI
         7zHAMOX/J7mDjQ/9e9lqN46y7PNkrLgLEqi9BWWf6YBHUJhh4jsRIAjWhGbKZIZ6FffU
         5juZ5cXXFhRpi1zG7WxH/LAnXBw/BJ35VAiv598hP/PlpHRinhn1WqecbO1HD5MQk5Wr
         Yjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dHjMTIl41hxK3f+Tai0htksrYLVoZB5v3Ap3BbywxPI=;
        b=ikR0Xsw2q35CKfsjI5okvDIejERuXyctOvjA/5KsDGK5NORb0oqE1JD6yu2hcuTCRA
         C4zmaiMOq5bU6or1s0qaZsR/iVWVfpHTVwm8yXfv3veSOV9fVqcr17Qq0TqcDv11hC6u
         kITtgOezOl3JMewvhN8MXg49yS4sPvE6Uv02V+dJky933eY8WS9UFBV4eMVK3QmXu9Xu
         I4K6wKCMv/q3AxT9C7175OJfAP+YgJpyE4N1Qsxw05ydk1g46BdqU8ITElBF0OWWZVzH
         tPSUPrN/8KkcZo7zCqHEAVItZpE6dIAvy3LKnAQ4XkX0dGYwW8SSvVGm8Bh4zLRUqOLc
         jm7g==
X-Gm-Message-State: AOAM532dvtVCA9B9emiU/lcA+N1/NVlxnNhIjv2ICuMpEM/Wrs1l5mzp
        PAOI6OCdF7WlZIyvVNpeGwU=
X-Google-Smtp-Source: ABdhPJwSwbC8aez0teMBxoXCGgpSkG/RL4WKlwtXDFlrXEErVVjl33PzHSRFVw2Qo6noK+m7AO1BMQ==
X-Received: by 2002:a17:902:c411:: with SMTP id k17mr1141909plk.165.1591666000004;
        Mon, 08 Jun 2020 18:26:40 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:73f9])
        by smtp.gmail.com with ESMTPSA id 77sm8139479pfx.172.2020.06.08.18.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 18:26:39 -0700 (PDT)
Date:   Mon, 8 Jun 2020 18:26:36 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
Message-ID: <20200609012636.5peovadjayzonqyv@ast-mbp.dhcp.thefacebook.com>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
 <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
 <202006051903.C44988B@keescook>
 <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
 <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <CAHk-=wiUjZV5VmdqUOGjpNMmobGQKyZpaa=MuJ-5XM3Da86zBg@mail.gmail.com>
 <20200608162027.iyaqtnhrjtp3vos5@ast-mbp.dhcp.thefacebook.com>
 <202006081130.CE3AE614F@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006081130.CE3AE614F@keescook>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 08, 2020 at 11:35:12AM -0700, Kees Cook wrote:
> On Mon, Jun 08, 2020 at 09:20:27AM -0700, Alexei Starovoitov wrote:
> > Take android for example. It can certify vmlinux, but not boot fs image.
> 
> Huh? Yes it does, and for a while now. It uses Android uses dm-verity[1]
> and fs-verity[2].

I didn't mean 'certified' like untrusted or insecure.
I meant the vendor kernel has to satisfy and pass SDK checks to be
certified as an android phone whereas vendor can put more or less whatever
they like on the fs. Their own bloatware, etc.
So for android to make sure something is part of the whole sw package
it has to come from the kernel and its modules.
Well, at least that's what I've been told.
Similarly kernel upgrade doesn't necessary include boot image upgrade.
In that sense 'elf in vmlinux' addresses packaging issue.
