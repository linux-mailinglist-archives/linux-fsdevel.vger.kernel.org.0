Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C5520260F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 20:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgFTS7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 14:59:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46024 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFTS7e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 14:59:34 -0400
Received: by mail-lf1-f66.google.com with SMTP id d7so7390823lfi.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jun 2020 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x63u2CH0kTOvK+Ylduvsgf843OJltI0Oa4WMxfgSi60=;
        b=YuZaZD+2V4T+V8YzzYJGa35OmsoetmgSGhdcjtcJee15mPLl0DDVPEosSzP/PWnHJj
         jgy4hPWH8VVmt2iYgXdkWir0ONer/cxkREFlgZ2wBjYY2Yu9ilgncolQOzb9kfd/gH8a
         5vaDuE8OvsPxmEYbptqvWO0a+mYBuV8TbyVfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x63u2CH0kTOvK+Ylduvsgf843OJltI0Oa4WMxfgSi60=;
        b=YbFNGCgL8ZEmzRiu10i07vUo5L2g0G+O+D9kwCdzlYF9QgNYhl4L3Y1oLpshWXe70l
         tySqa7EiNka1LKLRAGcb04pxXcuMCpF9vUZMKwebdMuussoEiZl1Zi53J6LTSycx1LCC
         ws7OB4V2Qv77VCB9qO+zuW4d4LWAtcqlrAEZDsAvdDC1zLpHBVHIbQqPz/dsHvV4rSDb
         2vwyhixO3RMJBHexXFe8pxsOtPMrYqE4lNhtZRlofUqo4dyfufqSuWNEZoLYpewTGpus
         VHllUzFsBQiLYNapRc969vyqr7sYRTZloJHfZ0QNky/HOIR6jEFgcQjNy+WvqJP5QE/o
         xPhQ==
X-Gm-Message-State: AOAM5322YkbzPZ4Zg43Smmt1zsNdLvCmRZxBij1Ot4Xut0miWMEdJ4x4
        5tjxIOafrVDwgZY0/8ayZQA6N8K8Vfw=
X-Google-Smtp-Source: ABdhPJyIeC6/JOZ4pBsC86Vbh7PQ8YxQ2LpBZaF/Y+p0PJkb0mxzkyo7VvJF3fU1zoVCE2qsGfSmfQ==
X-Received: by 2002:a19:4143:: with SMTP id o64mr5202038lfa.157.1592679511911;
        Sat, 20 Jun 2020 11:58:31 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id o19sm1808352ljc.23.2020.06.20.11.58.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 11:58:30 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id s1so15124040ljo.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Jun 2020 11:58:30 -0700 (PDT)
X-Received: by 2002:a2e:974e:: with SMTP id f14mr4590362ljj.102.1592679509716;
 Sat, 20 Jun 2020 11:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <87pn9u6h8c.fsf@x220.int.ebiederm.org> <87k1026h4x.fsf@x220.int.ebiederm.org>
In-Reply-To: <87k1026h4x.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Jun 2020 11:58:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgczNRMP-DK3Ga-e_HXvZMBbQNxthdGt=MqMZ0CFDHHcg@mail.gmail.com>
Message-ID: <CAHk-=wgczNRMP-DK3Ga-e_HXvZMBbQNxthdGt=MqMZ0CFDHHcg@mail.gmail.com>
Subject: Re: [PATCH 1/2] exec: Don't set group_exit_task during a coredump
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 19, 2020 at 11:36 AM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Instead test SIGNAL_GROUP_COREDUMP in signal_group_exit().

You say "instead", but the patch itself doesn't agree:

>  static inline int signal_group_exit(const struct signal_struct *sig)
>  {
> -       return  (sig->flags & SIGNAL_GROUP_EXIT) ||
> +       return  (sig->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP)) ||
>                 (sig->group_exit_task != NULL);
>  }

it does it _in_addition_to_.

I think the whole test for "sig->group_exit_task != NULL" should be
removed for this commit to make sense.

               Linus
