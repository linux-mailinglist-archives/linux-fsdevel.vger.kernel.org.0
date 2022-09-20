Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E7F5BED9A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 21:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiITTYt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 15:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiITTYr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:24:47 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDD0B84D;
        Tue, 20 Sep 2022 12:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TPqwlRNwuUqV78TrpRLaS4sbUecgUF5r7GiXn2a7L1Q=; b=hAMJs5X93SALDRvjC0jFswmUv1
        mRvdmTGGxOBZ1BvU+7YzDKbGJPK4cMjTqfgfRD8K3kNI3gqh/zmCEdGUDBwhPeup7EjVvWkz5mBt6
        XTR0WBKlPeyfSb61UoQP5xvjMiOSVnpWAr0Af+bxEkLkPwmEXnqIIx/N6joNhFVKtbIiSdVR5BO9g
        J2YQTW/3aj8XquulrrmMK+c/CnOrFruUKhb+m7RbBNYwyCSAkZhOyEE7DzN5jDzUH4+lYURALbLzw
        Y29AVkQ6JwRLJ/AEqc/sRI7Gs4UMmxwnHQB2SXNjT5MeCisAm/oJ8QZIvsAPqhHH5gwdIgwtcilFp
        5wKj1vEA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oair2-001sIE-1H;
        Tue, 20 Sep 2022 19:24:24 +0000
Date:   Tue, 20 Sep 2022 20:24:24 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     ebiederm@xmission.com, keescook@chromium.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        tanghui20@huawei.com
Subject: Re: [PATCH] exec: Force binary name when argv is empty
Message-ID: <YyoTaBah0/z+ewWE@ZenIV>
References: <20220920120812.231417-1-renzhijie2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920120812.231417-1-renzhijie2@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 20, 2022 at 08:08:12PM +0800, Ren Zhijie wrote:
> From: Hui Tang <tanghui20@huawei.com>
> 
> First run './execv-main execv-child', there is empty in 'COMMAND' column
> when run 'ps -u'.
> 
>  USER       PID %CPU %MEM    VSZ   RSS TTY    [...] TIME COMMAND
>  root       368  0.3  0.0   4388   764 ttyS0        0:00 ./execv-main
>  root       369  0.6  0.0   4520   812 ttyS0        0:00
> 
> The program 'execv-main' as follows:
> 
>  int main(int argc, char **argv)
>  {
>    char *execv_argv[] = {NULL};
>    pid_t pid = fork();
> 
>    if (pid == 0) {
>      execv(argv[1], execv_argv);
>    } else if (pid > 0) {
>      wait(NULL);
>    }
>    return 0;
>  }
> 
> So replace empty string ("") added with the name of binary
> when calling execve with a NULL argv.
> 
> Fixes: dcd46d897adb ("exec: Force single empty string when argv is empty")

I don't see the point, to be honest...  You've passed BS argv to execve(),
why would you expect anything pretty from ps(1)?

IOW, where's the bug you are fixing?
