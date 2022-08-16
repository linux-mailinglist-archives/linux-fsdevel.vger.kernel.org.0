Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9420E594F33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 05:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiHPDz7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 23:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiHPDz2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 23:55:28 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ED733DC6D
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 17:22:15 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-f2a4c51c45so9989796fac.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 17:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ajnf35L9FmE9vnp7SP1zj7Jbq2jKHjuvig7dYRcDFug=;
        b=RtgF+ge0o/5apZ+XTX/XqckJ2zulTrx3nLcGGV1o7Y9ezUhj+RUp09IW4vWuclfe7o
         bPfWbqL+8JGi1WAGWFPNSTjnMJUH4jyITqYSCntaw0G7/0K6u/NsprX9RSTZY5l6RGKe
         PMtR4tOg0/SD9ZYa22965atYkl13KwRExZizkR57kf1ejHg+TBf86fKIuMblY37VQbIO
         DZsm5flBSF+YS7J28rYgLFCWmtZc+pixqNsDOckgNr596pCNKvm7GETxNi+Ds2KFXSJr
         DIcrQNyeDHN/28Dp3URc1jbKgtGoAlg7QDeUkBnS3E4EbjXtn/AwhJyO8b9S3iDApl5o
         cbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ajnf35L9FmE9vnp7SP1zj7Jbq2jKHjuvig7dYRcDFug=;
        b=dwAIhr0r88oNWgn0wWzs332MZX0Im2Vl6BFekK6EYPutMuuUTPhQsPTv2ZvUipWhsC
         7r2B4uRRAXnLeXu6Anm0QiG/BPIvhEKsFnr79vRJEXvAeUDz8F2I2PtIXUX68jKSPZHD
         79d2eWvXrv59AmuvvquhXSsgQcG7pMAX0EJadLysmH4W9PWdzMucUBzuMqAhoCLWiLXm
         b4uOQhgFIAQc1V1MYebDxAZpkeGuqhBs4VN+pV4GTEyb57ndDCDg3WGgEOEEYRt4JO15
         AqUu+/oXwp3VkePD1zvz5jt3+SlT902FZTBLcORCvgyvOcwx9GD2wGZxMb+/PJ1YrtxF
         rgmA==
X-Gm-Message-State: ACgBeo0w7q4BZ1qI0rlY1L57p7ecNRXAfzCIEGRnilvpbh/wQdeOE3CC
        v2arZU452ya5n3EtsK1lcPbGRZT93uA/pR77ScW5
X-Google-Smtp-Source: AA6agR494gFsTH38En/qOYfSBSoNpSOSllUGl/TC4Qoem+2cwsv5M5P4upj4iL807PrVXTRzgQu4W9liyw6b2vu+YxE=
X-Received: by 2002:a05:6870:9588:b0:101:c003:bfe6 with SMTP id
 k8-20020a056870958800b00101c003bfe6mr12233196oao.41.1660609334831; Mon, 15
 Aug 2022 17:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659996830.git.rgb@redhat.com> <c4ae9b882c07ea9cac64094294da5edc0756bb50.1659996830.git.rgb@redhat.com>
In-Reply-To: <c4ae9b882c07ea9cac64094294da5edc0756bb50.1659996830.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Aug 2022 20:22:04 -0400
Message-ID: <CAHC9VhT0D=qtaYR-Ve1hRTtQXspuC09qQZyFdESj-tQstyvMFg@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full
 permission event response
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 9, 2022 at 1:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> This patch passes the full value so that the audit function can use all
> of it. The audit function was updated to log the additional information in
> the AUDIT_FANOTIFY record. The following is an example of the new record
> format:
>
> type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_info=17
>
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Link: https://lore.kernel.org/r/3075502.aeNJFYEL58@x2
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/notify/fanotify/fanotify.c |  3 ++-
>  include/linux/audit.h         |  9 +++++----
>  kernel/auditsc.c              | 31 ++++++++++++++++++++++++++++---
>  3 files changed, 35 insertions(+), 8 deletions(-)

You've hopefully already seen the kernel test robot build warning, so
I won't bring that up again, but a few comments below ...

> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 0f36062521f4..36c3ed1af085 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -276,7 +276,8 @@ static int fanotify_get_response(struct fsnotify_group *group,
>
>         /* Check if the response should be audited */
>         if (event->response & FAN_AUDIT)
> -               audit_fanotify(event->response & ~FAN_AUDIT);
> +               audit_fanotify(event->response & ~FAN_AUDIT,
> +                              event->info_len, event->info_buf);
>
>         pr_debug("%s: group=%p event=%p about to return ret=%d\n", __func__,
>                  group, event, ret);
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 3ea198a2cd59..c69efdba12ca 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -14,6 +14,7 @@
>  #include <linux/audit_arch.h>
>  #include <uapi/linux/audit.h>
>  #include <uapi/linux/netfilter/nf_tables.h>
> +#include <uapi/linux/fanotify.h>
>
>  #define AUDIT_INO_UNSET ((unsigned long)-1)
>  #define AUDIT_DEV_UNSET ((dev_t)-1)
> @@ -417,7 +418,7 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
>  extern void __audit_mmap_fd(int fd, int flags);
>  extern void __audit_openat2_how(struct open_how *how);
>  extern void __audit_log_kern_module(char *name);
> -extern void __audit_fanotify(u32 response);
> +extern void __audit_fanotify(u32 response, size_t len, char *buf);
>  extern void __audit_tk_injoffset(struct timespec64 offset);
>  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
>  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int nentries,
> @@ -524,10 +525,10 @@ static inline void audit_log_kern_module(char *name)
>                 __audit_log_kern_module(name);
>  }
>
> -static inline void audit_fanotify(u32 response)
> +static inline void audit_fanotify(u32 response, size_t len, char *buf)
>  {
>         if (!audit_dummy_context())
> -               __audit_fanotify(response);
> +               __audit_fanotify(response, len, buf);
>  }
>
>  static inline void audit_tk_injoffset(struct timespec64 offset)
> @@ -684,7 +685,7 @@ static inline void audit_log_kern_module(char *name)
>  {
>  }
>
> -static inline void audit_fanotify(u32 response)
> +static inline void audit_fanotify(u32 response, size_t len, char *buf)
>  { }
>
>  static inline void audit_tk_injoffset(struct timespec64 offset)
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 433418d73584..f000fec52360 100644
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
> @@ -2899,10 +2900,34 @@ void __audit_log_kern_module(char *name)
>         context->type = AUDIT_KERN_MODULE;
>  }
>
> -void __audit_fanotify(u32 response)
> +void __audit_fanotify(u32 response, size_t len, char *buf)
>  {
> -       audit_log(audit_context(), GFP_KERNEL,
> -               AUDIT_FANOTIFY, "resp=%u", response);
> +       struct fanotify_response_info_audit_rule *friar;
> +       size_t c = len;
> +       char *ib = buf;
> +
> +       if (!(len && buf)) {
> +               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> +                         "resp=%u fan_type=0 fan_info=?", response);
> +               return;
> +       }
> +       while (c >= sizeof(struct fanotify_response_info_header)) {
> +               friar = (struct fanotify_response_info_audit_rule *)buf;

Since the only use of this at the moment is the
fanotify_response_info_rule, why not pass the
fanotify_response_info_rule struct directly into this function?  We
can always change it if we need to in the future without affecting
userspace, and it would simplify the code.

> +               switch (friar->hdr.type) {
> +               case FAN_RESPONSE_INFO_AUDIT_RULE:
> +                       if (friar->hdr.len < sizeof(*friar)) {
> +                               audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> +                                         "resp=%u fan_type=%u fan_info=(incomplete)",
> +                                         response, friar->hdr.type);
> +                               return;
> +                       }
> +                       audit_log(audit_context(), GFP_KERNEL, AUDIT_FANOTIFY,
> +                                 "resp=%u fan_type=%u fan_info=%u",
> +                                 response, friar->hdr.type, friar->audit_rule);
> +               }
> +               c -= friar->hdr.len;
> +               ib += friar->hdr.len;
> +       }
>  }
>
>  void __audit_tk_injoffset(struct timespec64 offset)
> --
> 2.27.0

-- 
paul-moore.com
