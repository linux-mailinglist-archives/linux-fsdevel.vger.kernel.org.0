Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27CF517B33
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 02:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiECAUH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 20:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiECAUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 20:20:02 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BAA37BED
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 17:16:29 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e2so21387174wrh.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 May 2022 17:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yYv1vnQn01c0U+UUZJgP9Yz8sP26lRkEbJWLbcJb51Q=;
        b=ddRoWjOuUxYP6b00lDQWxMC8dG8BaQP8eAa1fxr/MmSiWbQUjDuHEJfp2okyiaEQkl
         Lg+phFet1W/aw+gC+toCkAmCxHa2I7pdP/F/qkoU3lcZRrvx/iVXfilL8BF88Dc/IU/z
         +VeMl9WNnkioNB0PHHQEBQR0tD7FOT40FkoWjzWMdD5aA/+B9FbqcqhHLdh0SVqq6oLt
         JmThc54G6v+6BSgFX6aldwkvPQZraIvnGNo/YRsQLxM4Ia+19s6QC9dnZTy8G1tvq+xv
         uJTuGkAYmlcuIHBBtL4ST5bNH0KfI8f6oBPHfWt/GWa13xuwQbPMvPlyiX7Gac3w1eeI
         07LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yYv1vnQn01c0U+UUZJgP9Yz8sP26lRkEbJWLbcJb51Q=;
        b=NeywLWU8OsjBcAc3KUq3JAIJNWfEwWCDeN1/uOoNvlvfBlLymk0lszLPeHW3lYTWCo
         iuGNgF+GMTVOu21OEbbb9d8T1aygazEFT8CgHi+hrOxG2lAOAfP+3nBbM2wfw+hxm12d
         1jBnTrnzvm9bLT7WnbnkxQdfOa+Jpy6QUXGVcDS8qWkUHB9Sz9K+TA3Bvhuq3lz+Fsve
         J8JZ7SvEJhHi/IYDOzHghaM5OFc7ENCCUkdp8FJpbBSfwsOU3+2lK/JTW90qJcT5bWS8
         xvFcpta0o5PspE/lSogBJ8V5DDC1YdfG9fWSu4QTC1l5QtJlCNT6L9RYQTIQIMNEKj3L
         xZEA==
X-Gm-Message-State: AOAM5316mT5y/pRseYmAc5lOKnNU57WP8oORcxh1nTaTf9V/onkJqFX0
        wdNLLM/eKUSNy5GgsWIFGI/QcZRr0O2GY2TQWYRc
X-Google-Smtp-Source: ABdhPJx2W6FrPHp5nIaG1ku1K5IvYfvfUoQkOIVxhtgUFxRn+IcKb0D+3Qlo2FAdxwIOQkQmJWw48FxCOzk4sUtqyPM=
X-Received: by 2002:a05:6000:10cc:b0:20a:de6f:3c48 with SMTP id
 b12-20020a05600010cc00b0020ade6f3c48mr10598403wrx.650.1651536988351; Mon, 02
 May 2022 17:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651174324.git.rgb@redhat.com> <23c7f206a465d88cc646a944515fcc6a365f5eb2.1651174324.git.rgb@redhat.com>
In-Reply-To: <23c7f206a465d88cc646a944515fcc6a365f5eb2.1651174324.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 May 2022 20:16:17 -0400
Message-ID: <CAHC9VhSwVS=u+FhDrC6QucZbm7B1PgFudLeYcT_C111OEEY3rg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fanotify: Allow audit to use the full permission
 event response
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 28, 2022 at 8:45 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> This patch passes the full value so that the audit function can use all
> of it. The audit function was updated to log the additional information in
> the AUDIT_FANOTIFY record. The following is an example of the new record
> format:
>
> type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_ctx=17
>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Link: https://lore.kernel.org/r/3075502.aeNJFYEL58@x2
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> Link: https://lore.kernel.org/r/23c7f206a465d88cc646a944515fcc6a365f5eb2.1651174324.git.rgb@redhat.com
> ---
>  fs/notify/fanotify/fanotify.c |  4 +++-
>  include/linux/audit.h         |  8 ++++----
>  kernel/auditsc.c              | 18 +++++++++++++++---
>  3 files changed, 22 insertions(+), 8 deletions(-)

...

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index ea2ee1181921..afdbc416069a 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -64,6 +64,7 @@
>  #include <uapi/linux/limits.h>
>  #include <uapi/linux/netfilter/nf_tables.h>
>  #include <uapi/linux/openat2.h> // struct open_how
> +#include <uapi/linux/fanotify.h>
>
>  #include "audit.h"
>
> @@ -2893,10 +2894,21 @@ void __audit_log_kern_module(char *name)
>         context->type = AUDIT_KERN_MODULE;
>  }
>
> -void __audit_fanotify(unsigned int response)
> +void __audit_fanotify(__u16 response, __u16 type, char *buf)
>  {
> -       audit_log(audit_context(), GFP_KERNEL,
> -               AUDIT_FANOTIFY, "resp=%u", response);
> +       switch (type) {
> +       case FAN_RESPONSE_INFO_AUDIT_RULE:
> +               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> +                         "resp=%u fan_type=%u fan_ctx=%u",
> +                         response, type, (__u32)*buf);

I think the above awkward cast helps the argument that
fanotify_response:extra_info_buf (and fanotify_perm_event) should
properly define a union to encapsulate the type specific data.  If you
defined a common union type you could share it among all of the
different users.


--
paul-moore.com
