Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E841CBDA2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 May 2020 07:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgEIFI2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 01:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgEIFI1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 01:08:27 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9617BC061A0C
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2020 22:08:27 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d22so1887353pgk.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2020 22:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zrKBo6dmu5PG/NLmVn82WxPrt7uW6KzvEPTvZO1VNDM=;
        b=ReNA6CSQZjGWpEt3QYlKKLvD/7VmKnOAoQyUDlxpzaGE0z6cn49+d6h9mJqT4cuAXU
         mk6IdbXREE/XDcCGOWmdH4bJARylVqF07rC5sbHrGNB9PycZ2xJ/Djq+N36lkJnNMVbt
         iN69KneiXrfariX6wSKdDk/unJ18A/EZyGMmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zrKBo6dmu5PG/NLmVn82WxPrt7uW6KzvEPTvZO1VNDM=;
        b=rPWGEEtKKzn+Twv5vHmimqmqaF+lLoi4x5gph/AY0qPm0SzD1TrrT89cigmj0PVsad
         P08GQP75r/p5q63Kh4fatLotoouCi84ec98VFLnV0QDDw+VpJ9TnsxfXQJun02jpBO4W
         C2t1zzLJuR7CwhP95L4puhzIcoh2CBovga0XKV42zAcwflf6xlcsDAQnGoJH3qD6x3yf
         1CIojI7zJ5uuiz6lmfsohJFOKjIIogbPPz3eK6JCshWMM6Pi/A2ft4PDntQI/eAnQ3LF
         wb9EeH/VXCsrJkm5Zg+Wq82o6x3rvOv1Yz5JvHtCPdFocFiwLkdNWZT+JbI5EE86kjlL
         nNRg==
X-Gm-Message-State: AGi0PuZBqu3Gc+vomYUdSitfdCEQ2Admk5n4AgAV95/3w3op8uJ8bTAp
        QTnri+tUJqOYTdVksMTc0Zhj0w==
X-Google-Smtp-Source: APiQypJDmzroFr+QawOyZ+F3tLV1wyTadbeiVFlDglOY+frqVcJOAeIDOPVelbmBFZyKsbXS3hWCnQ==
X-Received: by 2002:aa7:9839:: with SMTP id q25mr6175357pfl.311.1589000907057;
        Fri, 08 May 2020 22:08:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n69sm3637792pjc.8.2020.05.08.22.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 22:08:26 -0700 (PDT)
Date:   Fri, 8 May 2020 22:08:24 -0700
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
Subject: Re: [PATCH 3/6] exec: Stop open coding mutex_lock_killable of
 cred_guard_mutex
Message-ID: <202005082208.5FB101297A@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87blmy6zay.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blmy6zay.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 08, 2020 at 01:45:25PM -0500, Eric W. Biederman wrote:
> 
> Oleg modified the code that did
> "mutex_lock_interruptible(&current->cred_guard_mutex)" to return
> -ERESTARTNOINTR instead of -EINTR, so that userspace will never see a
> failure to grab the mutex.
> 
> Slightly earlier Liam R. Howlett defined mutex_lock_killable for
> exactly the same situation but it does it a little more cleanly.
> 
> Switch the code to mutex_lock_killable so that it is clearer what the
> code is doing.
> 
> Ref: ad776537cc6b ("Add mutex_lock_killable")
> Ref: 793285fcafce ("cred_guard_mutex: do not return -EINTR to user-space")
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
