Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E974A1C6245
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 22:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgEEUtf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 16:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728481AbgEEUtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 16:49:35 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A09C061A10
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 13:49:35 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t9so140163pjw.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 13:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gDQj+SjGugMQF8uI+esHL1nC61saNTbGZKF9q4vD+qY=;
        b=X68YJ+6115N6xJQyXmzCTQ+PpT+i6HwBzGRgAcXyUKaveCJp095cI3uGI+MEomoRZ4
         vvTeHPcOmw+LFxFuzftrI04yLDpWfcrQg4wNP+0hkHCoOBk6ys5D2SFBIRw2i5ZKl9Da
         sxRMptkqta1hpE1wpKHxnWvOeTW6xpYDTH8pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gDQj+SjGugMQF8uI+esHL1nC61saNTbGZKF9q4vD+qY=;
        b=JSt0BK8R+ZPpLh8LfdToyzLcJCpUyLYq/eRlnM1aTkRwVCK1AT3z33cRfkFZu93jf/
         8iUJ/I7+cfQ6GFtgtPm9LlvYvpmxszrCa8YsW7OlnYkGys+VI6MNtQw8VHuecOV+SxgA
         Tpzc5u3RdthbNk+Gdv5k9WT3HKMREUexC2GsLqO/PuMwqQj6RB18fydlIcen5wjDnvid
         b41sJvLKAT3fCqzr5gXBJR6KBZMAq7uy3G9koYkdtdgNefGa0JYP/QiIzZt2tHjj+F1K
         Rbvavo+5qbEg8kfa/ZFB/39pYAk8XDkFwi0hSodUz4ZPaFxydd+uXGMdWslNWS+rcuXj
         aqPQ==
X-Gm-Message-State: AGi0PuYR0RE+W+rXrSjg6Zsen4mmdy7zjWay3czSPbYNUI8g1FjUnkS9
        vy18gabhqXgMO/O1C8VkKxq+eQ==
X-Google-Smtp-Source: APiQypIBAlkG8zHKPW1X6EBiSl1Icjz6jxjYzyrkYgoneeW15xc46ZNoZsg5tUq2F0BQbxBZhiuepA==
X-Received: by 2002:a17:90a:8c3:: with SMTP id 3mr5039320pjn.147.1588711774351;
        Tue, 05 May 2020 13:49:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j7sm2832507pjy.9.2020.05.05.13.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 13:49:33 -0700 (PDT)
Date:   Tue, 5 May 2020 13:49:32 -0700
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
Subject: Re: [PATCH 3/7] exec: Rename the flag called_exec_mmap
 point_of_no_return
Message-ID: <202005051348.E3358B456@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87zhami2xp.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhami2xp.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 02:42:26PM -0500, Eric W. Biederman wrote:
> 
> Update the comments and make the code easier to understand by
> renaming this flag.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
