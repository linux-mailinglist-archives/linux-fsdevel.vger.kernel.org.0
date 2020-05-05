Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A9C1C623A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 22:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgEEUpW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 16:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727785AbgEEUpW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 16:45:22 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D475C061A0F
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 13:45:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e6so130934pjt.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 13:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PwgvJhTVGN7aq20X1Hb7QG5i5YRhZZ77AIj5mgyusSM=;
        b=D/nZet2+qNxTUTj+LLTvOT2EYhCwDnhb9QENQrfcXrYgx4gxQ63ZBjh+ufC+HiNJ67
         6lLV4Oa1++q6m/PwAJFQSsVtdy3ut8+8zPARcQ+6n3d5wIrNBUFBeFfMSQG/KCnxGzyA
         KHyb3ERW7OFoHTjLecNb8hvxS0gnWOn5CluVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PwgvJhTVGN7aq20X1Hb7QG5i5YRhZZ77AIj5mgyusSM=;
        b=uKiaCLj8jQpEjz0+rAK8GaqJwnEbpWYJN59Hf8YvVSFc/6iOTlLDoENYj8T0ukd+QC
         +cZUwIaF+Kmc+weh+8RYSelnH4ibRfzcHrYnwbz4SQN12wQZsLWQMAfDxgPXNwY15L7I
         fQp3Q/PnJRvbaP1yneBkorO0tfLTBIJRxGVuv4WkBpzO+GrqhtMa+x4OJl1EP6Npz2Hn
         P7eMWTqoIdYITGIVCEqYvnWGIUZfCaSoUCYtCg3+UtRvc2ZW3Dt9WHpZO/4N1eapCMv2
         3l2JkjDihtgYaPdZpE06kSHoimCz8VsX2LMdk420bbvXn0z6rq84h6o+fYqHXWw9F0Yt
         WETw==
X-Gm-Message-State: AGi0PuYKrzlDxlqdGkRwjGNA1lRae0n7POQoFOmkI5LaaYKBTfKJMVoh
        z2lDTvTk8sRIq1ovNP7a6yPHTA==
X-Google-Smtp-Source: APiQypJelCbpz9Zyh1p8qR9xlzlqaRKqZbtcgKDa1zdHqrwx8Ea5nhY2TYzFLhCW5cMgdS79nUBwPA==
X-Received: by 2002:a17:90a:71c3:: with SMTP id m3mr5049962pjs.17.1588711519740;
        Tue, 05 May 2020 13:45:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s4sm12481pgv.78.2020.05.05.13.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 13:45:18 -0700 (PDT)
Date:   Tue, 5 May 2020 13:45:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/7] binfmt: Move install_exec_creds after setup_new_exec
 to match binfmt_elf
Message-ID: <202005051345.8280CC0E@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87bln2jhki.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bln2jhki.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 02:41:01PM -0500, Eric W. Biederman wrote:
> 
> In 2016 Linus moved install_exec_creds immediately after
> setup_new_exec, in binfmt_elf as a cleanup and as part of closing a
> potential information leak.
> 
> Perform the same cleanup for the other binary formats.
> 
> Different binary formats doing the same things the same way makes exec
> easier to reason about and easier to maintain.
> 
> The binfmt_flagt bits were tested by Greg Ungerer <gerg@linux-m68k.org>
> 
> Ref: 9f834ec18def ("binfmt_elf: switch to new creds when switching to new mm")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
