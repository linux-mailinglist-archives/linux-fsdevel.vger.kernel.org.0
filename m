Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1114D220023
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 23:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgGNViP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 17:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgGNViO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:38:14 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76290C061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 14:38:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a24so2569105pfc.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 14:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kBZyCcCmpqlqMqsIRaCWhuIM19zS4zfakl+jOrhjE68=;
        b=a/bS0RLhvJ42yObBQpWU7RQa+G5uNb2e0zU2vIxVYbKgCuhuVCePOZGoJtjvmwd7iN
         xmKjxlDlfNIw1CAvsEm1szrJz74LLht0/WrPFkETS5x0dnr7wky6Use55EWzyo1YbgMf
         wB0RHcDtBRksPGUwkP02h4mG8W2IaiPO+VB6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kBZyCcCmpqlqMqsIRaCWhuIM19zS4zfakl+jOrhjE68=;
        b=ZkpI6yZAhxw2xIDDpLE+/oZhoj6oQ+c9DcMoVDkQCNntN27t/BF75wxiWnSVni0e1n
         2JE0Avdp3x7GtMqc9I44KObMkKhNWc7wvBYIYDr/DPoMQfqVMDxTx4HGSYWp94h7nAZH
         CEkGxyFIwyLg93UGVJ1jBF8j7CbYGOjUiJU5/J159q9XZO4qMNnpRRnD35vMdNVGF0cC
         /V5T4+qkSwYQ4txJRuEpD3qCDvo7dguyjTkWxKl7ATt0GqA7momJeqv7F770HSjavMaA
         q6Dy2T+P3te/FS1H6fU4wFzMbm/US2MxcMw3IhxPnbzoRLZRJzQNUctvbagNCeM7T1wL
         LbSg==
X-Gm-Message-State: AOAM530lGKpq6VDRi7Qg5FqKaD2+8xoF7gSiLR39LWN8Gqgdv2peuLXt
        dPlptsOJ4yXMmnE+3wCO4RASSQ==
X-Google-Smtp-Source: ABdhPJwFFznkEcbi8FULWjz22UCjJ7P9pQh+fwuMJMUGDuP9MkVzkem4ifewJtwGQEQdhFq/4ppcLQ==
X-Received: by 2002:aa7:818e:: with SMTP id g14mr6043210pfi.27.1594762694075;
        Tue, 14 Jul 2020 14:38:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i128sm123203pfe.74.2020.07.14.14.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:38:13 -0700 (PDT)
Date:   Tue, 14 Jul 2020 14:38:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/7] exec: Remove unnecessary spaces from binfmts.h
Message-ID: <202007141438.68F0CEDCE6@keescook>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87v9iq6x9x.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9iq6x9x.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:28:42AM -0500, Eric W. Biederman wrote:
> 
> The general convention in the linux kernel is to define a pointer
> member as "type *name".  The declaration of struct linux_binprm has
> several pointer defined as "type * name".  Update them to the
> form of "type *name" for consistency.
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
