Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBE71D9F74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 20:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgESS1y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 14:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgESS1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 14:27:54 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A40C08C5C0
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 11:27:54 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l73so1458497pjb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 11:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nYhYvn46e/4SmfmVVbZOq3r5oEKfrjVdnN/U9wz4NtY=;
        b=diMqmdWQ0qSMkp9euf6IGqcO8VzRvq0vOJY26a1wQ5Q8T/huOrpQE0gd6Ko7mlQmCM
         RYUjZqut0yYI6BG9dGiYopn7GCLIpO4F540x9+dcHcfT4ZhgrSPNJ2FyiIX9KBoAii2Y
         chvdiDdXI9/bVqduNh/8dHrLs1iQVkGJhhmbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nYhYvn46e/4SmfmVVbZOq3r5oEKfrjVdnN/U9wz4NtY=;
        b=VmhtHfgAbp9twOogaDn5BRpSpFI/uKN5ZrCWQJYykPgTefOrcMGNyP6mJfS4h2zPj8
         vNmJAaa4Pb3bxIEpK376FcynDxEK0ikfjI0rw9CzaN5+GKOZPtY1cTOgakf5SHB9FP19
         h32UGIZ+yiMweLWQLWbVjZjxNAdXUVTC/0EHS8hwwGlCFi53u6kcoy32mycVaida+mv2
         Dj3VYnY/5K8cFp4JdrKHnyyIhwLloFMgPqe6ZZxIOx4tJ0B853K9pkNTEYIO68XT79sE
         2VkM9X9uEJRY6xVka2bMFMZhyOSiqcuqejo1VxbA2oQLEakc8N0XxN6G03ANGrBZcN72
         Wc0A==
X-Gm-Message-State: AOAM533t9Ag0aflWkLiJ/n+TrBeNAtcJ8bB8Qodhy+PKQFbx+Aevcl56
        fow/y9tdY+E07P70G5z80/eUug==
X-Google-Smtp-Source: ABdhPJwaMTz8VrJTiETmULOC2bj+5LoutuSFETDCsFxyIxYRNBzPP4NYcHiEs4ivLHsqq7MQflRUMw==
X-Received: by 2002:a17:90a:8b84:: with SMTP id z4mr954246pjn.86.1589912873632;
        Tue, 19 May 2020 11:27:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a27sm146456pgn.62.2020.05.19.11.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:27:52 -0700 (PDT)
Date:   Tue, 19 May 2020 11:27:51 -0700
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
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 5/8] exec: Move the call of prepare_binprm into
 search_binary_handler
Message-ID: <202005191127.E9F66F9E88@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87d070zrvx.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d070zrvx.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 07:32:18PM -0500, Eric W. Biederman wrote:
> 
> The code in prepare_binary_handler needs to be run every time
> search_binary_handler is called so move the call into search_binary_handler
> itself to make the code simpler and easier to understand.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
