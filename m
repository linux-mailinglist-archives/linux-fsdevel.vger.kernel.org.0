Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962B549BE28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 23:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiAYWDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 17:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbiAYWDH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:03:07 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF35C06173B
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jan 2022 14:03:07 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id j16so10109773plx.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jan 2022 14:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utexas-edu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ivrIH0VuRMgF5s5Lp0eV9oO3+RUVBNYhH0V3HMLxvbg=;
        b=0W8e+o5O+vF1mmr0kFnXK/FBlMjRtF3IxHoyOKcom4RQc7SdqzUtpvmAjVySy2BLi/
         IVGMZnYCeViEovmFsy15WdMJKJ+1qTeIP0P49QQW4Kycuz3haZKVlLQt8LEunmviVQQW
         h9Oj+fG1ahNATD9FlR/FoOfHGEfn+WUbU7QhAIzkcEvTU/tHiKbtMFu1CzeV9IbIGyRm
         ByJJ+A/iap1WlSBVSgVaHVg/AK6/YxUnKCCTx7pnxwDVzhzsbJJkdySoy5HkM/jklQBm
         uNowoE8EMK2G2YJek/hHopAgVhYI8WY0Ei6mWWL9EPu34SpPyg3TMgRGIgpSWitdW8+R
         l7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ivrIH0VuRMgF5s5Lp0eV9oO3+RUVBNYhH0V3HMLxvbg=;
        b=Jk2Lt3cPP+TQwBPgYsrXMouO6fA6oxeZBXd2plkkHFyP8QXAmm2RuVKTYLDTOcfU49
         WNHrLLZJ8JJBR88TnNXdNwyBZpnm7Z0mgUR9Xd7iIKL8NJNXNLnxYYNpYBmXZFUlfsDF
         +7lJn4glaDzrKczOMoTFNrMBscCTDvnxEh1lkpQKPyUjhOxyet0V4e3nRAev9gISb7WH
         TtmnEj01m9zN5vJqekae3PJgpKtl+thPjAbZU/PyxrwwHFG5IrG3u+0VctghkT2dEsql
         O574P9PyJHelUx4L7UnEpUbj+mK6exKwLtsWaa7Nmkge0g3XF3xt9SB+xJrgbZVYI8zo
         /78A==
X-Gm-Message-State: AOAM530Y4ETE4/ab9aBVRNER+1zx5TJlDLnIpafWGnKk12qEFhC4gL+2
        9lVfwWBgx0TM7g+rGY98kUPgPhSqj2VwdEx7dJzQM9Gne9TZtjJ9
X-Google-Smtp-Source: ABdhPJwWY//d1beUbXAQiDaWfRXUJn5aqDFMauqjfCMV9BeQxdDiaIjS4GkW4sTWBcPrUFJ+ZV5OpO1aY2B5SBAZbP0=
X-Received: by 2002:a17:902:6b49:b0:14b:69b:cd3e with SMTP id
 g9-20020a1709026b4900b0014b069bcd3emr21044695plt.75.1643148186792; Tue, 25
 Jan 2022 14:03:06 -0800 (PST)
MIME-Version: 1.0
From:   Hayley Leblanc <hleblanc@utexas.edu>
Date:   Tue, 25 Jan 2022 16:02:56 -0600
Message-ID: <CAFadYX5iw4pCJ2L4s5rtvJCs8mL+tqk=5+tLVjSLOWdDeo7+MQ@mail.gmail.com>
Subject: Persistent memory file system development in Rust
To:     linux-fsdevel@vger.kernel.org, rust-for-linux@vger-kernel.org
Cc:     Vijay Chidambaram <vijayc@utexas.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

I'm a PhD student at UT Austin advised by Vijay Chidambaram (cc'ed).
We are interested in building a file system for persistent memory in
Rust, as recent research [1] has indicated that Rust's safety features
could eliminate some classes of crash consistency bugs in PM systems.
In doing so, we'd like to build a system that has the potential to be
adopted beyond the research community. I have a few questions (below)
about the direction of work in this area within the Linux community,
and would be interested in hearing your thoughts on the general idea
of this project as well.

1. What is the state of PM file system development in the kernel? I
know that there was some effort to merge NOVA [2] and nvfs [3] in the
last few years, but neither seems to have panned out.

2. What is the state of file system work, if any, on the Rust for
Linux side of things?

3. We're interested in using a framework called Bento [4] as the basis
for our file system development. Is this project on Linux devs' radar?
What are the rough chances that this work (or something similar) could
end up in the kernel at some point?

Thank you!

Best,
Hayley LeBlanc

--------------------------------------

[1]: https://cseweb.ucsd.edu/~mhoseinzadeh/hoseinzadeh-corundum-asplos21.pdf
[2]: https://lore.kernel.org/linux-fsdevel/150174646416.104003.14042713459553361884.stgit@hn
[3]: https://lore.kernel.org/linux-fsdevel/alpine.LRH.2.02.2009140852030.22422@file01.intranet.prod.int.rdu2.redhat.com/
[4]: https://github.com/smiller123/bento
