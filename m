Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9C5B1C625B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 22:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgEEUvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 16:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729281AbgEEUvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 16:51:11 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2421BC061A10
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 13:51:11 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mq3so139230pjb.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 13:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3hao9Rbd2DOkgWQuq9i9E+Ng3Pr6zL+wsaZllNiP784=;
        b=WgX/BZxHr++sd2IPiEB/unUtdMnEP1tXqVSjjQPQ7/lC6eDNdAE1MDzdb6OFx5jM6n
         iPGWeclUB9c9273Ekhi4XWJet840MqRqm8KbgQEQ2SIRTuL6i9FqK716EuoCCJSDNzvj
         jZlhOgsztO8LVHZZJLNeJsVSyIPERfb1DQfqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3hao9Rbd2DOkgWQuq9i9E+Ng3Pr6zL+wsaZllNiP784=;
        b=P1gBsp5JZNzvGkVdjbgHxOGuxbIa2Dng8OwI/58fXEBBNPdSCJoHTImhRygLBBMMVP
         e3Um5mHkwLQNf6hM/xmo9TwV3HDgzHAPzKsZmaenJl07nfKGMJz5qYCZLNoxPFHEUT2p
         S4Qusxzc9uFU8QloWIm2DdQCI7sVcLVx7ubYNss7mqFgF9W+9npy+azUXGuwjybO9b00
         uBBEKBsk3IGUW8/izw8IgfPgV0URr7ZFsRBZLQj1M/BOmY+MjOAdnHSVzBOYlmHPFZ6e
         anRB1YwODWV6xsLP960uNBveAH4QK5w2aNSvK5TgusiEU5j6Yfuteezxe3YkBvlDZNWr
         RfBg==
X-Gm-Message-State: AGi0PubDE4tw5ZgW78+N6OlNp1zbVXqaDM8urFve6Brb2Z0gLWOjfV92
        aUlSFARoVWEW/bIJcsMrCuDWqw==
X-Google-Smtp-Source: APiQypJ6njqoyd6pae1zIPv2aNYbmoo179h4Ms13R64/sNOWb9cOrMDgTpfu6+4Az4zWRwzmrRVS5A==
X-Received: by 2002:a17:902:728e:: with SMTP id d14mr4880686pll.107.1588711870715;
        Tue, 05 May 2020 13:51:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g16sm2739074pfq.203.2020.05.05.13.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 13:51:09 -0700 (PDT)
Date:   Tue, 5 May 2020 13:51:09 -0700
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
Subject: Re: [PATCH 5/7] exec: In setup_new_exec cache current in the local
 variable me
Message-ID: <202005051351.74B5320@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87o8r2i2ub.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8r2i2ub.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 02:44:28PM -0500, Eric W. Biederman wrote:
> 
> At least gcc 8.3 when generating code for x86_64 has a hard time
> consolidating multiple calls to current aka get_current(), and winds
> up unnecessarily rereading %gs:current_task several times in
> setup_new_exec.
> 
> Caching the value of current in the local variable of me generates
> slightly better and shorter assembly.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
