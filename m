Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE8B7083EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 16:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjERObK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 10:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjERObJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 10:31:09 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261B810D8
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 07:31:08 -0700 (PDT)
Received: from letrec.thunk.org (c-73-152-158-129.hsd1.va.comcast.net [73.152.158.129])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34IEUG4a016584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 May 2023 10:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684420220; bh=bn+QWVSe+9nTmAaBzja76pERh2P2tN8H0UdBFjfKOEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=G/QR5cGU53Jh92OhSLCsidEmAju7KVs5J0ndqhRggP5N3v1/IEl/Mu0H8qjgRfaWn
         do1UxsFE8xBd30DpAED9ld+3XvL3h93ftUWqm32fj6DLYYEUhhzRaWZdqFVwboviNH
         YFUihowT6ejy4A2Xxf6y2TaLwfHehtTLJSw5bx5f9FuQqUl3AAwpKG7e7TXFrGi8A1
         DcnelyioMuvXI6OaUQYQS9Vdfzx3W2X9Xult+fboEXR2AiFyFx2ESKHBBEHPRPwLve
         5NIpyvl/fexZNi/glnGQeeM+RlhJvxMdFtp4ftoj5GUc6sLCh+u/H3foLqYY//+D9f
         aq9/QZza99Zdw==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 912288C0244; Thu, 18 May 2023 10:30:16 -0400 (EDT)
Date:   Thu, 18 May 2023 10:30:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Christian Brauner <brauner@kernel.org>
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
Message-ID: <ZGY2eICf8Ndr3Xg5@mit.edu>
References: <20230516001348.286414-1-andrii@kernel.org>
 <20230516001348.286414-2-andrii@kernel.org>
 <20230516-briefe-blutzellen-0432957bdd15@brauner>
 <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
 <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner>
 <20230517120528.GA17087@lst.de>
 <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
 <20230518-erdkugel-komprimieren-16548ca2a39c@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518-erdkugel-komprimieren-16548ca2a39c@brauner>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The other thing to note is that while the *convention* may be that 0,
1, and 2 are for stdin, stdout, and stderr, this is a *userspae*
convention.  After all, system daemons like getty, gnome-terminal,
et. al, need to be able to open file descriptors for stdin, stdout,
and stderr, and it would be.....highly undesirable for the kernel to
have to special case those processes from being able to open those
file descriptors.  So in the eyes of Kernel to Userspace API's we
should not specially privilege the meaning of file descriptors 0, 1,
and 2.

Besides, we have a perfectly good way of expressing "not a FD" and
that is negative values!  File descriptors, after all, are signed
integers.

Finally, by having some kernel subsystem have a different meaning for
fd 0 means that there are potential security vulernabilities.  It may
be the case that userspace *SHOULD* not use fd 0 for anythingn other
than stdin, and that should be something which should be handed to it
by its parent process.

However, consider what might happen if a malicious program where to
exec a process, perhaps a setuid process, with fd 0 closed.  Now the
first file opened by that program will be assigned fd 0, and if that
gets passed to BPF, something surprising and wonderous --- but
hopefully not something that can be leveraged to be a high severity
security vulnerability --- may very well happen.

So if there is anyway to that we can change the BPF API's to change to
use negative values for special case meanings, we should do it.
Certainly for any new API's, and even for old API's, Linus has always
said that there are some special case times when we can break the
userspace ABI --- and security vulnerabilites are certainly one of
them.

Best regards,

					- Ted
