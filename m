Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827E0517B35
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 02:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiECAUC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 20:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiECATw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 20:19:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAB637AB2
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 17:16:20 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id a14-20020a7bc1ce000000b00393fb52a386so450559wmj.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 May 2022 17:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WEBPkXZGZET4EOg9cNqgzGfoaXYf5cttjHHg7Lavyrc=;
        b=u0NnuCLWvA+j4fCTpPXTlOameD/fsMdeVXQnlE6sn/YvxBdcoQOutZx7GGA9/BVUP9
         qa1zezBlh9PyWkhRje1o2dkuSrJesxNSGB3pI7HZ7xyu3jBpwv89b7rIAgaqBG9uXy2B
         eUiD+hMF6vGP1FACV2CyxjMQsdAGuwzIZQW8PuMMu6MgRFhaZz1GPb97QijP2WQdBydU
         eZPQ7k66fs99I4BGeJdcyBcfL/KcZArFCBHbU3pvOAHrTQV/xX+AMLkogLHv5479Lh1L
         MnPkl7ZQwF42gnaqvM7GbjxVEHKoBWaroH0OF4KvZFFDr74jqiVibcAPParhHHN6rUdu
         ATXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WEBPkXZGZET4EOg9cNqgzGfoaXYf5cttjHHg7Lavyrc=;
        b=pQerll910bBM7ukEpCB3Cp91X9NL1zZzfUZ/8MVi009ccAv2UEC1GOQjUanU/wjMoR
         3l9oPMjxQn+s5omCJOXFwhWh4ivlfxc3TZwC0FX5to/4BQZQyqiKlZPC8MjQh0WX6wQT
         L3S9CBlq7cEJPAT1rhk8OARSgH9bGyvgOA5+sEmU150Wqp49PcLYUTTemtb1KwO0l+ZE
         W/XV4bUA3HM5Ee7c36GeoQQg728I9kDCOmBX2QfDa7goS3uhsPmjSqAt8G0HZTofJ8pa
         n75KFnAOqCl6xnaWiHLi2gxo2tGMqEO+J5FqyDxqkImYeAP9+NyTohFGOu30VOfp0jsG
         4TEA==
X-Gm-Message-State: AOAM531HKZlrr5/VHZ/z4CLYqwVI60hFay4Pi1VXqABC89mV5HDM4tAN
        IAeE5sNNKEFpJpzq+W8mHp0dy7bEF6N1MwxGFupl
X-Google-Smtp-Source: ABdhPJyZ4midsbD61Si1Qw0RhxNxL5d5wRIVNY/d5Kxnxugjn6yw9JwqCUzXCTQrt39kvTqxQ7ozsBrGJ7xQHItqm6s=
X-Received: by 2002:a7b:cf02:0:b0:393:fbb0:7189 with SMTP id
 l2-20020a7bcf02000000b00393fbb07189mr1065567wmg.197.1651536978767; Mon, 02
 May 2022 17:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651174324.git.rgb@redhat.com> <aa98a3ad00666a6fc0ce411755de4a1a60f5c0cd.1651174324.git.rgb@redhat.com>
In-Reply-To: <aa98a3ad00666a6fc0ce411755de4a1a60f5c0cd.1651174324.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 May 2022 20:16:07 -0400
Message-ID: <CAHC9VhSFOx1d_7-XnbobjZXjps_mXq3S33T_5E=PmNAeyqAsdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] fanotify: Ensure consistent variable type for response
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 28, 2022 at 8:45 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> The user space API for the response variable is __u32. This patch makes
> sure that the whole path through the kernel uses __u32 so that there is
> no sign extension or truncation of the user space response.
>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Link: https://lore.kernel.org/r/12617626.uLZWGnKmhe@x2
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Link: https://lore.kernel.org/r/aa98a3ad00666a6fc0ce411755de4a1a60f5c0cd.1651174324.git.rgb@redhat.com
> ---
>  fs/notify/fanotify/fanotify.h      | 2 +-
>  fs/notify/fanotify/fanotify_user.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

It seems like audit_fanotify()/__audit_fanotify() should also be
changed, yes?  Granted, in this case it's an unsigned int to u32
conversion so not really all that critical, but if you are going to
update the fanotify code you might as well update the audit code as
well for the sake of completeness.

--
paul-moore.com
