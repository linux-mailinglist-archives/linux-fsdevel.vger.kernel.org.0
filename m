Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D9F7AD88A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 15:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjIYNEx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 09:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjIYNEw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:04:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264729F;
        Mon, 25 Sep 2023 06:04:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFABFC433C7;
        Mon, 25 Sep 2023 13:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695647085;
        bh=5GuHghoJcw0TFo6RZTpC3p1AZANQLw1yiRSTt3ti8yE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pv1CXqBn5nTrzr0t9MFnlsVhtGHOK0QSh3H/lQVxM4MdRWJtvXnJTGjVDdxcA1KzW
         /vBix8pFtolV+cpyTWnQ8knvCMsM68JpCyWHOnqP9Tnrr+CsU9Tsa/PnkGNq8CKqru
         uyQ+i1SxAk/TuxunEmiou35oYvjd0fTbavpl9yMZ5lh5xhCPYmf6cSDGR4wn/1D1Ta
         FA5f/i+DIzV4hy49Ohei2TQFkRc0OlPSZrS6qxp0NR8Ki7uRyyWJt2yjDr17hokIK7
         M0YEDvRPu3o96x8vP39dGDNzL45Znjz8R9mGP5a2MZcROyQ5uArRlqiRDlvtaPOxEl
         L4yshaJhKj7fA==
Date:   Mon, 25 Sep 2023 15:04:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Message-ID: <20230925-total-debatten-2a1f839fde5a@brauner>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-3-mszeredi@redhat.com>
 <44631c05-6b8a-42dc-b37e-df6776baa5d4@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44631c05-6b8a-42dc-b37e-df6776baa5d4@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 25, 2023 at 02:57:31PM +0200, Arnd Bergmann wrote:
> On Wed, Sep 13, 2023, at 17:22, Miklos Szeredi wrote:
> 
> >  asmlinkage long sys_fstatfs64(unsigned int fd, size_t sz,
> >  				struct statfs64 __user *buf);
> > +asmlinkage long sys_statmnt(u64 mnt_id, u64 mask,
> > +			    struct statmnt __user *buf, size_t bufsize,
> > +			    unsigned int flags);
> 
> This definition is problematic on 32-bit architectures for two
> reasons:
> 
> - 64-bit register arguments are passed in pairs of registers
>   on two architectures, so anything passing those needs to
>   have a separate entry point for compat syscalls on 64-bit
>   architectures. I would suggest also using the same one on
>   32-bit ones, so you don't rely on the compiler splitting
>   up the long arguments into pairs.
> 
> - There is a limit of six argument registers for system call
>   entry points, but with two pairs and three single registers
>   you end up with seven of them.
> 
> The listmnt syscall in patch 3 also has the first problem,
> but not the second.

Both fields could also just be moved into the struct itself just like we
did for clone3() and others.
