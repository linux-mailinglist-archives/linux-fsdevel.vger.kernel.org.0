Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333BA1DC003
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 22:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgETURd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 16:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgETURd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 16:17:33 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB30AC061A0F
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2020 13:17:32 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id e18so4752250iog.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2020 13:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VyaSYeCN7SlfNpIcnaBLrvnj4Za8Y5YWee7k0M093LM=;
        b=EfnCZypmdGa8VpCH0ge9lM32x0XwnmHj2izqsNgRTS3I07JG3e/hF4lLCo5kXYO4/g
         GtxgCniYtCnG++FB/8kG6zPSRmFLKhxRqmmq4IdVKeBaftKKpwV9wCZorD+0tHjfkdlf
         iKIaBkXsdUOcUzEbaSjKSZqabgCT3OCAuVYYojsL0oGeaGv8yix5Xa36HevdrmZQA1d3
         oZiCFN22Zq85rpV1iC6H6WuqAmzoFZO6oguZ9pkB1ojjDMsp42z1ILZhpfs69Ar45MbZ
         DEZchCUERGXKZVtVhJ2ntdiyp4CuUJlSp/UEMGtBpuJcdmq5WBjbssYBuRlEU2sLgeuf
         ZmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VyaSYeCN7SlfNpIcnaBLrvnj4Za8Y5YWee7k0M093LM=;
        b=oLrkMh6J7DPt1pE3o6W5lf+og4l5pRTjwNqM1+JHuOXSdnGngd7xzKrB4CqWIHTt1E
         QyhQFuWxIhoc37tNxBFFCxOFsuJLVCNG8JPcVPUQh4jAnYhpSTubz5tO+SaAk/yfJJBk
         850196+jYtGOPjHy7TSXA97ea8/MlWTqnzWJ+YAZVkwkW7YCf2VsWcA32jciwdb8BVJI
         K+jBBygz84fPZl+GJKL1SRlPdywu9OnFwgAVrpd2/MDXRloJVDTdtNnRH93LaxgPgiCw
         9qLtFk/l1Td5FG3wMDbfAa89NwkBNx8i5Q2mnck3Hs8cmWoAuxaJBqdWXEyeORAaIUKp
         8Hsw==
X-Gm-Message-State: AOAM533SwFchYTuhmWDF/s4147Av+VI0hpIddSA/LUdFp7qNJYU4EUBH
        SrO6iD0Uytb8rXyt5xt3YnKgHbdBkryKg9yKwek+fA==
X-Google-Smtp-Source: ABdhPJxf5r3SCDgK6PuxVrPSpsHX45TKCMtlgHtmR2oB4Pr8N10SC5JVUCM3UWZi1m7AGto9SCPNRm16+lOlW4mhbLA=
X-Received: by 2002:a5d:8a10:: with SMTP id w16mr4683295iod.95.1590005851709;
 Wed, 20 May 2020 13:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200423002632.224776-1-dancol@google.com> <20200423002632.224776-3-dancol@google.com>
 <20200508125054-mutt-send-email-mst@kernel.org> <20200508125314-mutt-send-email-mst@kernel.org>
 <20200520045938.GC26186@redhat.com> <202005200921.2BD5A0ADD@keescook>
 <20200520194804.GJ26186@redhat.com> <20200520195134.GK26186@redhat.com>
In-Reply-To: <20200520195134.GK26186@redhat.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Wed, 20 May 2020 13:17:20 -0700
Message-ID: <CA+EESO4wEQz3CMxNLh8mQmTpUHdO+zZbV10zUfYGKEwfRPK2nQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add a new sysctl knob: unprivileged_userfaultfd_user_mode_only
To:     Andrea Arcangeli <aarcange@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Daniel Colascione <dancol@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Xu <peterx@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Tim Murray <timmurray@google.com>,
        Minchan Kim <minchan@google.com>,
        Sandeep Patil <sspatil@google.com>, kernel@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adding the Android kernel team in the discussion.

On Wed, May 20, 2020 at 12:51 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> On Wed, May 20, 2020 at 03:48:04PM -0400, Andrea Arcangeli wrote:
> > The sysctl /proc/sys/kernel/unprivileged_bpf_disabled is already there
>
> Oops I picked the wrong unprivileged_* :) of course I meant:
> /proc/sys/vm/unprivileged_userfaultfd
>
