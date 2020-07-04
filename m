Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868C6214232
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 02:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGDADV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 20:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgGDADU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 20:03:20 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAF9C061794;
        Fri,  3 Jul 2020 17:03:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f3so15747046pgr.2;
        Fri, 03 Jul 2020 17:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XfsnRGq5c7ISQMP6l12lIG9CT/MaV1ytAKPLovkdW6g=;
        b=OBGUXT9yA+G7A+0ACpDkuvOBizruNZlUi6m2uBHw58O/fWISX/mOkrCVRWmKfBetTs
         1rHrohBUhudhmqPZXYAko4J1WPW1lcU3mqOMiDO9x4a7G2W6l2jy9MacOGdbXd6ssffb
         3rzhjJDJSvl0Wl+FL0AWzIdok6xQQId192oFJ4OfYkvuNRjXdlxL0uomU062UWmVYLVv
         XyMCY8Ip7HDlP0yXehDFcxcyblxXYTZXf/AcFXL7UclLaK7hkdoRLu6aIpOvnhcaxFiN
         hhmGGppwMCNYUgt+bEfOmaZrQzLUc0wvL7hQBgOlsl8VVTZTd2AYWxlCt9aLUzUYyf6O
         /mCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XfsnRGq5c7ISQMP6l12lIG9CT/MaV1ytAKPLovkdW6g=;
        b=Q633J5urr1g398Au4nGXo22v5Au/8Cu6GPKB15IJdDZ+LEHsxQXL0ydMXJNX0WXhak
         Aed2/Rko/W84OsJ8VZx+HAC6wAfcRTVCSWaU2sFGG7dLHn4b+Zag+n+qLbmJ26kIBZfK
         W1RRLtTMLTn2NA5KBUuC6MJnPYcUYlaHylvAeLTQ5g7Z/+YbA3BaoG0vkpCi5aHGvkTP
         Ad26OmCsXqWtckALMnuCHEQjZKgKTVJY21yQFJ1FksRvOpqb8p6W8/uhLZyZH055wdxx
         XXI/f4uZBhCL1uGITw78stNp14ePoVwSVQBAMqfEPYdlZhSukph5HNUG0pcTHsvRM8h7
         g1AA==
X-Gm-Message-State: AOAM532yn0jCZxx/+n6fcisS1sMtie7cNa0kWUCES/tKJ3E+/gvdqm7C
        araBLRuWlwWJtJca7za3ktU=
X-Google-Smtp-Source: ABdhPJwHHJ3EdBT7aaN5Xo7682dRxRj8iLuo7RgIeJaLML1bJV+ESClFMpDgDn8cRiVupJ5LSZ4N9w==
X-Received: by 2002:a62:190a:: with SMTP id 10mr2980224pfz.29.1593821000161;
        Fri, 03 Jul 2020 17:03:20 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:d8c2])
        by smtp.gmail.com with ESMTPSA id b24sm12799253pgn.8.2020.07.03.17.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 17:03:19 -0700 (PDT)
Date:   Fri, 3 Jul 2020 17:03:16 -0700
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
Subject: Re: [PATCH v3 13/16] exit: Factor thread_group_exited out of
 pidfd_poll
Message-ID: <20200704000316.z5opxpi4iozjjtfj@ast-mbp.dhcp.thefacebook.com>
References: <87y2o1swee.fsf_-_@x220.int.ebiederm.org>
 <20200702164140.4468-13-ebiederm@xmission.com>
 <20200703203021.paebx25miovmaxqt@ast-mbp.dhcp.thefacebook.com>
 <873668s2j8.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873668s2j8.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 03, 2020 at 04:37:47PM -0500, Eric W. Biederman wrote:
> 
> > The rest all looks good to me. Tested with and without bpf_preload patches.
> > Feel free to create a frozen branch with this set.
> 
> Can I have your Tested-by and Acked-by?

For the set:
Acked-by: Alexei Starovoitov <ast@kernel.org>
Tested-by: Alexei Starovoitov <ast@kernel.org>
