Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A61B4B0204
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Feb 2022 02:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiBJBXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 20:23:49 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiBJBXr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:23:47 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A967653
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 17:23:48 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v12so6922319wrv.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Feb 2022 17:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Li5quPdFfkf9wbRdtlmdCqglV+EjSX34Ql2F2UVlVZU=;
        b=fOMUIw5AbKt2U96qrgnxxLAo10MBNk88R8KEIutobENaA3V15LwHlAW/36AxMOekjY
         3tLkuv7ygRQJmN7QlqnvqmpFmCNCZpB1qutjlW5TaQxr9rzlFCQ1F+FMo/CViMwfOjkH
         vuB3cxsoRU7F45Ft1ELo5RCPe1spmZozpgtfo6fe+hGIga/XtMBPShD/WudEP/oR+4J5
         qiNYsg25EDuwqYQqPKL1MIBTqOUxs0fWBsc8YAmJ+u7cQQOuJoywk+/AUqP2GsHvNLrT
         p6oa1nhC7EY6CLWpeDs1vc30Cds8td3h3EYWgmOcrgC/fG53xsUyJE5f5Cgc6qOGOicl
         nE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Li5quPdFfkf9wbRdtlmdCqglV+EjSX34Ql2F2UVlVZU=;
        b=OWoe8GAf4nW9Eu5GDWrgDU4HY/vLt4Y81eZ9UUkKgVnTQU3L9kOyIgJZFnCnDcH2sa
         epchQtZh10d3ZlrO6llLTYsjjITNqqgJSnxh4KYiFm//qyGQCvcpnCd0g8BG9/NqZxOy
         sVSu/87TfNVx9yu1xdJVzXUXdHswIRSC+Ny3rIO8c2Da+kZ8zt6vYVsE7qledbBzM2ZV
         7vd7CS45tvAyDnvu+qMQ24kgeQVqj/VjUbkjAZSMBExg6b1w0oSCbDVxLb9+WJ68VE3g
         dtXdnQC1TcBechtv6ShiCNNQlhwKZDSuBLuGk1SCi5zbs8LBj3jfBzfuai3dEA/7Er1Z
         iFEA==
X-Gm-Message-State: AOAM533txXk/gT93JnQU5dsp3PddpHVJkx7H+oT954hk38mXfImqhGt0
        D0o3yF48Hatj6dGnPgZuh2fVG1W6CEw1bQv6Q2zTvTyO7Q==
X-Google-Smtp-Source: ABdhPJxiVf5M2p8s2Ae5CnFjRuqXdrYYFU+3hk4iuMq3joHNia4DIVZlpt6NrmZUMvu1vNbpy0vgZGjN3Pp+jQ2jcmk=
X-Received: by 2002:a17:906:2ed0:: with SMTP id s16mr4108539eji.327.1644450252844;
 Wed, 09 Feb 2022 15:44:12 -0800 (PST)
MIME-Version: 1.0
References: <a112a586b0a7e6a1a2364a284fb50cf8fcbf7351.1644442795.git.rgb@redhat.com>
In-Reply-To: <a112a586b0a7e6a1a2364a284fb50cf8fcbf7351.1644442795.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Feb 2022 18:44:01 -0500
Message-ID: <CAHC9VhSr7U+4pdo7tpP=dUE4KKszZG4B5eksfoqkkKEVJRrT7w@mail.gmail.com>
Subject: Re: [PATCH v1] audit: fix illegal pointer dereference for openat2
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Arnd Bergmann <arnd@kernel.org>, stable@vger.kernel.org,
        Jeff Mahoney <jeffm@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 9, 2022 at 4:51 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> The user pointer was being illegally dereferenced directly to get the
> open_how flags data in audit_match_perm.  Use the previously saved flags
> data elsewhere in the context instead.
>
> Coverage is provided by the audit-testsuite syscalls_file test case.
>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/c96031b4-b76d-d82c-e232-1cccbbf71946@suse.com
> Fixes: 1c30e3af8a79 ("audit: add support for the openat2 syscall")
> Reported-by: Jeff Mahoney <jeffm@suse.com>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks Richard.  As this came in ~40m after the other patch, and both
are identical code changes, I've merged the other patch but I did add
a note that you also submitted a similar patch.  Once the automated
testing completes I'll send this up to Linus.

-- 
paul-moore.com
