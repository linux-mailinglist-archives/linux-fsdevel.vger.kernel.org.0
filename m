Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430C71F1D77
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 18:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbgFHQfu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 12:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730383AbgFHQfu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:35:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DC6C08C5C2;
        Mon,  8 Jun 2020 09:35:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 64so1912354pfv.11;
        Mon, 08 Jun 2020 09:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tyCbZyeBjZCo4Jy66q0dnIXiW7QuvcmvIIKzSP9Jy20=;
        b=l+lsgG6lFvCpiLNrLSRUKRsMUSYA02FpUs5yBPJ/hL6r7MDUISQgIb58pyqY04UCHh
         hEd4tLoC2NXK4/SEfuWfiRbWcSDpyslyNlBpz0hPGupm0vz1qyBYdwwbfVgnD2r+rOP+
         oZFVyJLqdq4xMGuwgDbeKOw22tKard6fUyhO952e4J8UGqaACOxM/YGODVeH9wPz1F9d
         k3OGVaG82xEYmWnSh6wldv6xXxvHu9x73oXvMiOUERKZlIw6rcP1HjqYsa2DMoys6k1s
         MCprG8k8GJhgKECViO/FwUA7kOzhosPD3b1rIhketXMXLFh50vDt45d6X3jcA7KYVrp6
         7xfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tyCbZyeBjZCo4Jy66q0dnIXiW7QuvcmvIIKzSP9Jy20=;
        b=bpRzmVbE/FI4Sz+FsT2Gn1xbnflX0P6gfLMZaIu5RRvvrxztRezX2B3O52vxPf9wFy
         x/sX+wSegA/rtYfI9ZvuSquEp7esYB9xJcOlAZgOx0wakH1WdX2R5qI7nP/iTKOa9RhY
         d3VDc7TCkFulhglrhmiGuJsg/KwKS4EcDLTVf1jR6vjhKMxMqXG2MBBIcqx5LDt7w9GN
         MS3YFmCFGfVfCJiwyzKGHiqM7RXvkC5D3xhuzAeg/L2Hj+Imtk0SCTiCG4dH5Q3FbPIZ
         R4laZnYlDK6dAJ0oK4FS9lsETy89CGzbWOcsTJY8m1USg/pfuwJqyHZZnNQ0ZF92OLtO
         kJqQ==
X-Gm-Message-State: AOAM533HPmyozMJn1Ef69xl2hNykbnc8Fdj6rBz/CpHo1gRq4RAVdWz0
        QXCGlnQOaFUivSKDHu13ao8=
X-Google-Smtp-Source: ABdhPJyer2VwwaPtfvHm8sp/l0HA39Mm5FiYsvebKBb5HpPCHugOXUSNB5G3GXtEigNoD7G6iNvXxw==
X-Received: by 2002:aa7:95bd:: with SMTP id a29mr21850467pfk.57.1591634148855;
        Mon, 08 Jun 2020 09:35:48 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:73f9])
        by smtp.gmail.com with ESMTPSA id j26sm7560615pfr.215.2020.06.08.09.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 09:35:48 -0700 (PDT)
Date:   Mon, 8 Jun 2020 09:35:45 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
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
Message-ID: <20200608163545.45p7stnholrqe6qp@ast-mbp.dhcp.thefacebook.com>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
 <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
 <202006051903.C44988B@keescook>
 <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
 <20200606201956.rvfanoqkevjcptfl@ast-mbp>
 <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
 <20200607014935.vhd3scr4qmawq7no@ast-mbp>
 <87mu5f8ljf.fsf@x220.int.ebiederm.org>
 <87pnab6qdl.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnab6qdl.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 07, 2020 at 06:56:38AM -0500, Eric W. Biederman wrote:
> ebiederm@xmission.com (Eric W. Biederman) writes:
> 
> > I have sympathy with your efforts but since the code is currently dead,
> > and in need of work.  I will write a good version of removing
> > CONFIG_BPFILTER_UMH on top of -rc1, leaving CONFIG_BPFILTER.
> 
> Of course when I just limit my code removal to code that depends upon
> the user mode helper all that is left is a Kconfig entry and
> include/uapi/linux/bpfilter.h.

This bit you can actually remove.
bpfilter didn't materialize.
But 'elf in vmlinux' is useful. Please keep it.

> I also noticed that the type of do_exeve_file is wrong. envp and argv
> are not "void *", they should be "const char __user *const __user *__argv".

Sounds like a trivial fix.
