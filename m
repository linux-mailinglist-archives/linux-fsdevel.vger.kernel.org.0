Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C372E1C6256
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 22:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgEEUuc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 16:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729322AbgEEUub (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 16:50:31 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95283C061A10
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 13:50:31 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id b8so1558080pgi.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 13:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gZPmqP7f0zZq0i6x3n5wYzmjgYaqHaT+GySyTpMlPTE=;
        b=Kve8F3BKs4sbH9Cpna7uFNaJN6fCv7xO+sFp9md+JOMcsVfxcmaVv+88JYyYgsbnag
         0FzzthJndg1UHG0uNLxFCD/9clIuGjzGfBzXIXCe3hfI6On3CzGWs6h9BcirTJNBTv00
         Dg1wvkjA4PIhmWOgtfNoLbSky1vPGQBSqYD/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gZPmqP7f0zZq0i6x3n5wYzmjgYaqHaT+GySyTpMlPTE=;
        b=C0nI6zHyIWauuxA9F/bRVzTWWSM39sYmC9bJ3i0lyFbDtCpgqX6ESEbIK54lWBmqs3
         EghaEwPMg//M7RCBoxTpnhLLj2S31eQt2q6naAothNeX7+ySnvv2FKsd5MXg/4za3xjH
         tQqKxc4BGsu/xJnibY9asPCVdtXCCeSCLqqF+kIWUwQTw2MT477teSh1nz0ERpGQHxAB
         1jMyIMab2kiadNKvWPrEtrO2MBbTtT6WK86RXMjgfYTzOn+8UtBNw+unRM9TB5QEojYH
         /HHAeNocUNXtNdDdohJGoE/mBZFwasOEkkJR0TUOh7aSP7tdIUJXjtg/ulGq1zwc8S/H
         AU+A==
X-Gm-Message-State: AGi0Pub9y3TBJHhRUw8iqgf2JcAjDBSg5dFMxokk57OdJ51ivDu0pdkr
        sXpr3PiwFpClmL2EHP2Lk5tudw==
X-Google-Smtp-Source: APiQypIUB2lMuWPuFNQUARBx41SRb0quETrjJOgDQIFQl6CnLZPg+Mzu4paMDk2eFPwm6Fc+UAIOEA==
X-Received: by 2002:a65:460f:: with SMTP id v15mr4347488pgq.24.1588711831209;
        Tue, 05 May 2020 13:50:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c4sm15795pga.73.2020.05.05.13.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 13:50:30 -0700 (PDT)
Date:   Tue, 5 May 2020 13:50:29 -0700
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
Subject: Re: [PATCH 4/7] exec: Merge install_exec_creds into setup_new_exec
Message-ID: <202005051350.FBB43BE@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87tv0ui2w2.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv0ui2w2.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 02:43:25PM -0500, Eric W. Biederman wrote:
> 
> The two functions are now always called one right after the
> other so merge them together to make future maintenance easier.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
