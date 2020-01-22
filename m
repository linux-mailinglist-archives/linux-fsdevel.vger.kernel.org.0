Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3E84145DF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 22:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgAVV3T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 16:29:19 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34546 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgAVV3T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 16:29:19 -0500
Received: by mail-lj1-f195.google.com with SMTP id z22so752209ljg.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 13:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0IWzoSHaF7JN7KzmRnEKXue37+ElHpTL6tvjAuEiiiE=;
        b=vdbmKD+yNje7jhxOhco/lhYmf+3Q1q+XjGe74FJCrmQXQ5t6WJS+kdh6i9Krkm3ZTB
         zeqWO82x5b2dbahES4hr2RG0xoDgGanxYKm5yUIzlxfqnQXUOlyeGElCDg9Y2F956m+q
         7kLbk3H8VsgEX4YrYWvAKFyp0xFcpC5Fr974FOn9rnivaLGIufkBpu/uJeqfZEuV1WFE
         eABuXY7Ss5Si7RevcqYhdcQvJRfuH38hsWHMgIpSxxvws5XSUZZim12h+5uAeW2p966k
         3WcllzOlzMcPtleAH4Pm/M/kBtjWAsBD+u3/IbIpQgJo0Ocqw42SsFkzXbUoEtD7rVvM
         CRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0IWzoSHaF7JN7KzmRnEKXue37+ElHpTL6tvjAuEiiiE=;
        b=JOmMLU/Q95NBVsha2Ffi7unkn/KOKLJSK3+h+wnJG7S0TZXEPY94E42UNlXnsHZwL8
         EB28GyQb1AZxJKYXhsP/hvICZgZLycJRX80NSHrbP4MBIamNTciilU9bBu44qUCF4DPS
         97/MI48F+ZScBuE5TKRh8HgMVjtuRIXVJlxFFnki7Wyeps+YMfjTzpkGXZgNb3JCP1n1
         bIpzCTOZm0a5E0F8wuW6YQPoezwArVSfvE6HTQ8yLndziFfInL1A9KNwT2kXfl1kwzpj
         3TFavOU+CHi0/DFZE3XPEhbJcwIqv0oCbrWaN0rF/HJwbndrNtgPlvUiO5Jqe/aVftEu
         CRfg==
X-Gm-Message-State: APjAAAWwHE0JFz4Ck6GRAWV5Kk8Fniisxsr6NXC3NzeopmYpiTFsc2/V
        ebemhnRpfrbzcbRWibzJz5iTQmgVDG+OW2s3y9Bn
X-Google-Smtp-Source: APXvYqyJPHhr26PhrZ+pA9b8pTPEHYf1WFuy5Ob3gcESY7hxuJ6vYnDhzK5W1Ro4odt+SPVTOx5x/cd75TN9sGtuTYo=
X-Received: by 2002:a2e:5357:: with SMTP id t23mr21086243ljd.227.1579728556739;
 Wed, 22 Jan 2020 13:29:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577736799.git.rgb@redhat.com> <cfbb80a08fc770dd0dcf6dac6ff307a80d877c3f.1577736799.git.rgb@redhat.com>
In-Reply-To: <cfbb80a08fc770dd0dcf6dac6ff307a80d877c3f.1577736799.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Jan 2020 16:29:05 -0500
Message-ID: <CAHC9VhT1+mx_tVzyXD=UBqagqYgAFjZ=X1A6oBiMvjVCn8=V-w@mail.gmail.com>
Subject: Re: [PATCH ghak90 V8 12/16] audit: contid check descendancy and nesting
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 31, 2019 at 2:51 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Require the target task to be a descendant of the container
> orchestrator/engine.
>
> You would only change the audit container ID from one set or inherited
> value to another if you were nesting containers.
>
> If changing the contid, the container orchestrator/engine must be a
> descendant and not same orchestrator as the one that set it so it is not
> possible to change the contid of another orchestrator's container.
>
> Since the task_is_descendant() function is used in YAMA and in audit,
> remove the duplication and pull the function into kernel/core/sched.c
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  include/linux/sched.h    |  3 +++
>  kernel/audit.c           | 44 ++++++++++++++++++++++++++++++++++++--------
>  kernel/sched/core.c      | 33 +++++++++++++++++++++++++++++++++
>  security/yama/yama_lsm.c | 33 ---------------------------------
>  4 files changed, 72 insertions(+), 41 deletions(-)

...

> diff --git a/kernel/audit.c b/kernel/audit.c
> index f7a8d3288ca0..ef8e07524c46 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -2603,22 +2610,43 @@ int audit_set_contid(struct task_struct *task, u64 contid)
>         oldcontid = audit_get_contid(task);
>         read_lock(&tasklist_lock);
>         /* Don't allow the contid to be unset */
> -       if (!audit_contid_valid(contid))
> +       if (!audit_contid_valid(contid)) {
>                 rc = -EINVAL;
> +               goto unlock;
> +       }
>         /* Don't allow the contid to be set to the same value again */
> -       else if (contid == oldcontid) {
> +       if (contid == oldcontid) {
>                 rc = -EADDRINUSE;
> +               goto unlock;
> +       }
>         /* if we don't have caps, reject */
> -       else if (!capable(CAP_AUDIT_CONTROL))
> +       if (!capable(CAP_AUDIT_CONTROL)) {
>                 rc = -EPERM;
> -       /* if task has children or is not single-threaded, deny */
> -       else if (!list_empty(&task->children))
> +               goto unlock;
> +       }
> +       /* if task has children, deny */
> +       if (!list_empty(&task->children)) {
>                 rc = -EBUSY;
> -       else if (!(thread_group_leader(task) && thread_group_empty(task)))
> +               goto unlock;
> +       }
> +       /* if task is not single-threaded, deny */
> +       if (!(thread_group_leader(task) && thread_group_empty(task))) {
>                 rc = -EALREADY;
> -       /* if contid is already set, deny */
> -       else if (audit_contid_set(task))
> +               goto unlock;
> +       }

It seems like the if/else-if conversion above should be part of an
earlier patchset.

> +       /* if task is not descendant, block */
> +       if (task == current) {
> +               rc = -EBADSLT;
> +               goto unlock;
> +       }
> +       if (!task_is_descendant(current, task)) {
> +               rc = -EXDEV;
> +               goto unlock;
> +       }

I understand you are trying to provide a unique error code for each
failure case, but this is getting silly.  Let's group the descendent
checks under the same error code.

> +       /* only allow contid setting again if nesting */
> +       if (audit_contid_set(task) && audit_contid_isowner(task))
>                 rc = -ECHILD;

Should that be "!audit_contid_isowner()"?

--
paul moore
www.paul-moore.com
