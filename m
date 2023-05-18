Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2560A7086B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 19:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjERRXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 13:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjERRW6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 13:22:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DB210CA
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 10:22:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4FE3643A8
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 17:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EF1C433EF;
        Thu, 18 May 2023 17:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684430570;
        bh=qL332bAyOJ/QGUfgQtAjGCo1WVWAnNLS4FtrMe1O/9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GGgFAoqzW8fECni4rQkheWj2C0RdrCB8TcX3cRjE163mk5IycQbMicfLEUAetkZ94
         icxvdrp2KVLw+FQMQ7UXnLEHbkFt0lnG4micsrQBsldL6L6nn5u7Wm6q+xKhvfpxJ/
         EI25k4q58RwJMzXqhzl/BBQPCLKpIwDT/9qWHtCcdAHpEpWw35k5uqokmYuY+MVQYY
         kk9FCYJjfUeaC7amo0JaNyxvJN+Z/yb+uAJ1hlrBWhgjYDz++fe8DLJAe+GK27a11B
         6+vS7QwnIx2ITFSidKYVukFcHxo/9fV4vlaYL4R6BiCqxD691tfLnaWAbnkNC4jDEy
         KGwciYgYG20Jg==
Date:   Thu, 18 May 2023 19:22:43 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
Message-ID: <20230518-beben-komitee-bc23b650f852@brauner>
References: <20230516001348.286414-1-andrii@kernel.org>
 <20230516001348.286414-2-andrii@kernel.org>
 <20230516-briefe-blutzellen-0432957bdd15@brauner>
 <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
 <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner>
 <20230517120528.GA17087@lst.de>
 <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
 <20230518-erdkugel-komprimieren-16548ca2a39c@brauner>
 <20230518162508.odupqkndqmpdfqnr@MacBook-Pro-8.local>
 <ZGZTXAdS7roSg3WE@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZGZTXAdS7roSg3WE@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 18, 2023 at 05:33:32PM +0100, Matthew Wilcox wrote:
> On Thu, May 18, 2023 at 09:25:08AM -0700, Alexei Starovoitov wrote:
> > We're still talking past each other.
> > 0 is an invalid bpf object. Not file.
> > There is a difference.
> > The kernel is breaking user space by returning non-file FDs in 0,1,2.
> > Especially as fd = 1 and 2.
> > ensure_good_fd() in libbpf is a library workaround to make sure bpf objects
> > are not the reason for user app brekage.
> > I firmly believe that making kernel return socket FDs and other special FDs with fd >=3
> > (under new sysctl, for example) will prevent user space breakage.
> 
> Wait, why are socket FDs special?  I shouldn't be able to have anything
> but chardev fds, pipes and regular files as fd 0,1,2?  I agree that having
> directory fds and blockdev fds as fd 0,1,2 are confusing and pointless,
> but I see the value in having a TCP socket as stdin/stdout/stderr.
> 
> If a fd shouldn't be used for stdio, having an ioctl to enable it
> and read/write return errors until/unless it's enabled makes sense.
> But now we have to label each fd as safe/not-safe for stdio, which we
> can as easily do by setting up our fops appropriately.  So I'm not sure
> what you're trying to accomplish here.

Yeah, I don't think we want weird ioctl()s to restrict file descriptor
ranges in any way. This all sounds pretty weird to me and I don't even
want to imagine the semantical oddness of suddenly restricting the
kernels ability to return some fds.

Honestly, most of the time sysctls such as this are the equivalent of
throwing the hands up in the air and leaving the room.
