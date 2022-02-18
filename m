Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65ED4BB6EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Feb 2022 11:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbiBRKaI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Feb 2022 05:30:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiBRKaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Feb 2022 05:30:06 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE2A2B3562
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 02:29:48 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id d11so5389208vsm.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Feb 2022 02:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nUW+yjvOGY5MnqsplEiw6zB+s4SEHgpkTRWb7syEmLA=;
        b=pV/+DVmBkX4n3MSkEsK/IHeXXv9RWk9EHSPB4MKhH7x3f2zJHW4dYa0E1VwSRFEom2
         GcTpSeR7lK5MJnTLaiKuM+L5nmiG2Bhen//iBF9k8YT90tY2E3zpqkOiW3xEdXssA+h9
         hs76x5gYJHOrY0dl/97qLcrkwhRm7/DH/JGa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nUW+yjvOGY5MnqsplEiw6zB+s4SEHgpkTRWb7syEmLA=;
        b=nBU+e90HWvl4VLaLBvj6ttPcA65y7tfRX4zvCKc5FooB+PVkU0S2bBwz2nr57k24cV
         QiJB1yAd2pJMsbGLiljc9ko7wEKjfLmqPWEEcp64D5PCSRBHX1JK58mkdWlj4ecQV+R7
         f3vkLNmT7xEKMeQOtafQwIiN4Wsl2NEs6G80Fb+Z+gE9ThmczU6YyxbpQfGbCB/5CeX9
         dP6xZggmhrjhUDOStjDTigKX29Y2sBH/80CFMsde//KyxendYxmOn2V/0x9uAiGJAZOk
         5cWrDgaQfWRj1aSnwrta2eqLvHOyBIq6xj88KIgny5RhSatN8+FdeP328BCKnhyu/fI7
         k5tg==
X-Gm-Message-State: AOAM5307w5uG/V/yYktzVWsYu+IfFeBaEXA3vw6wE/KsYqRikuFPXR2C
        S3GqdqpEyokqPPJZdKsaqMKMyP2hwPs0fah+P/O2BA==
X-Google-Smtp-Source: ABdhPJzggqJaYvjOwI/FTU82vvTkybenYqxzztVqijg3p623fqprse0nJkReeguI4HS4VajU8uXM0898bMuQy3ytc58=
X-Received: by 2002:a67:e0cc:0:b0:31b:d7bf:8403 with SMTP id
 m12-20020a67e0cc000000b0031bd7bf8403mr3245630vsl.61.1645180187873; Fri, 18
 Feb 2022 02:29:47 -0800 (PST)
MIME-Version: 1.0
References: <874de72a-e196-66a7-39f7-e7fe8aa678ee@molgen.mpg.de>
 <CAJfpegs7qxiA+bKvS3_e_QNJEn+5YQxR=kEQ95W0wRFCeunWKw@mail.gmail.com>
 <20200717125208.GP12769@casper.infradead.org> <CAJfpeguYBT=3VG=75K5tXp3Yfm0JCkfQvCHPkKq8uNOrMc5+bw@mail.gmail.com>
 <ab73da52-fd72-7e1e-eb3c-ad0aef125692@molgen.mpg.de>
In-Reply-To: <ab73da52-fd72-7e1e-eb3c-ad0aef125692@molgen.mpg.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 18 Feb 2022 11:29:37 +0100
Message-ID: <CAJfpegu24JL5-R4ASG1wwfHFEn3hro+W4DD+MXWx8XBiKcg7Hw@mail.gmail.com>
Subject: Re: `ls` blocked with SSHFS mount
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, it+linux-fsdevel@molgen.mpg.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Fri, 18 Feb 2022 at 10:41, Paul Menzel <pmenzel@molgen.mpg.de> wrote:

> Unfortunately, it become quite a lot more annoying for the user, as it
> seems to prevent the system from suspending.

[...]
>
> Can this be worked around?

Yes, killing the sshfs process will enable the suspend to continue.

I suspect it would make sense for the suspend scritps to perform this
by default, since the ssh connection will likely be broken anyway
after resuming.

Thanks,
Miklos
