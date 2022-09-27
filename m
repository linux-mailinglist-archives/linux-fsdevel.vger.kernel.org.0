Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6AB5ED08E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 00:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiI0W4e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 18:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbiI0W42 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 18:56:28 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9087C1D2
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 15:56:25 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id e24-20020a05683013d800b0065be336b8feso7205468otq.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Sep 2022 15:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7isylDDRyS+VUoOPOaoDvNNAXX/X+Fc4DbBmSe+1Kyg=;
        b=FTMHk6dTuKIie2x5GJjR0s3y4GM1FORgXFB8ZlfC8/Ve2v35lO4uKvejn/gAvZ0Pxo
         R2ZMB5FRkgDbQTomuM+1qVP/iCwwlnZaaEfXQeFN4L+CmkV+kr6PPQyv7kaOKmeTIOEf
         HoKAxUfVBCnDsUfAxUicoUrq8RDjn42LywudDczXQtshbvfd+LPGFekAYHq8eMnAZ9QG
         FVnNoBRpxJVgKsGc6p3qfYcbXHcU4knbRXJljFJv/8sRe9aJZuSh1kVsESSVJ3kchpoD
         tUZHYzbE4ATA9QwGghMj6WaLssV0XUES4LF+3R1gwyvcyj5UAcVbUW8bzg2OiukaK3ug
         5xfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7isylDDRyS+VUoOPOaoDvNNAXX/X+Fc4DbBmSe+1Kyg=;
        b=GtjhP5tPS/WciLaCOmcsdXIzTLYfv23iCl4RRm7v+u6/yoHz5DXC4ZSRnxn6Loibuf
         sO1GgzGJKyPiYmr1Ly134oMv8ZKuPbK0uvjiHb0Elw2beuOFNx3im4Ptg1g+k8vYF9RF
         o1JGnvi3ix6o0pyu+4iydEjQ6qcAQUEFKdlLpFhdKWEU5pHybikPeU5Gkzdmcxrefws6
         QO1W7+KJAApxm4C7Dlj3S1pa5BhBg0FivLs1asiuACtHVtw2ql9s75fLQJ23UmN+gsVE
         Llxx90hAopKstVerJIoAYIc2Q7/u/LRI2YhQ1WSk8LGKE3tTpd2VPwvj5xJc8teSgtnY
         Gx8Q==
X-Gm-Message-State: ACrzQf2Yzve8D1jJaX5W/4cGAsgbv7d1+kOpRh/qY+pgTWmWgfvOwIhk
        /O0NG8VT4d59e4zKI2XcMXnASk+z2aCvczEB8710
X-Google-Smtp-Source: AMsMyM4VjvDmYO0pzKLxSe4e84L0ZsB/1Vky2a+YsGpfmZbZ2eiBkBPxThz2Oi3wMJBZNJxsWLkcKHRc3fHFlhcb+54=
X-Received: by 2002:a9d:1b70:0:b0:658:cfeb:d221 with SMTP id
 l103-20020a9d1b70000000b00658cfebd221mr12832509otl.34.1664319385208; Tue, 27
 Sep 2022 15:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220926140827.142806-1-brauner@kernel.org> <20220926140827.142806-14-brauner@kernel.org>
In-Reply-To: <20220926140827.142806-14-brauner@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 27 Sep 2022 18:56:14 -0400
Message-ID: <CAHC9VhTKDm-c2JGPv5JBx2EFCRLeAWXcQPS3T_JhyoMJD0-03Q@mail.gmail.com>
Subject: Re: [PATCH v2 13/30] evm: implement set acl hook
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 26, 2022 at 11:24 AM Christian Brauner <brauner@kernel.org> wrote:
>
> The current way of setting and getting posix acls through the generic
> xattr interface is error prone and type unsafe. The vfs needs to
> interpret and fixup posix acls before storing or reporting it to
> userspace. Various hacks exist to make this work. The code is hard to
> understand and difficult to maintain in it's current form. Instead of
> making this work by hacking posix acls through xattr handlers we are
> building a dedicated posix acl api around the get and set inode
> operations. This removes a lot of hackiness and makes the codepaths
> easier to maintain. A lot of background can be found in [1].
>
> So far posix acls were passed as a void blob to the security and
> integrity modules. Some of them like evm then proceed to interpret the
> void pointer and convert it into the kernel internal struct posix acl
> representation to perform their integrity checking magic. This is
> obviously pretty problematic as that requires knowledge that only the
> vfs is guaranteed to have and has lead to various bugs. Add a proper
> security hook for setting posix acls and pass down the posix acls in
> their appropriate vfs format instead of hacking it through a void
> pointer stored in the uapi format.
>
> I spent considerate time in the security module and integrity
> infrastructure and audited all codepaths. EVM is the only part that
> really has restrictions based on the actual posix acl values passed
> through it. Before this dedicated hook EVM used to translate from the
> uapi posix acl format sent to it in the form of a void pointer into the
> vfs format. This is not a good thing. Instead of hacking around in the
> uapi struct give EVM the posix acls in the appropriate vfs format and
> perform sane permissions checks that mirror what it used to to in the
> generic xattr hook.
>
> Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
> Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> ---
>
> Notes:
>     /* v2 */
>     unchanged
>
>  include/linux/evm.h               | 10 +++++
>  security/integrity/evm/evm_main.c | 66 ++++++++++++++++++++++++++++++-
>  security/security.c               |  9 ++++-
>  3 files changed, 83 insertions(+), 2 deletions(-)

Ultimately this is Mimi's call, and it can be done later after this
patchset is merged, but it seems to me that some of the code in
evm_inode_set_acl() could be pulled out into a helper function(s)
shared with evm_protect_xattr().

Reviewed-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
