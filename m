Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390D81C623B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 22:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbgEEUq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 16:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726593AbgEEUq6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 16:46:58 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F1AC061A0F
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2020 13:46:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id v63so1486570pfb.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 13:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cf6vM9jESf9i80uLNJEG7Wy6/PA2gfS+11yY91l4C9I=;
        b=WaVGgy4JYd1RrK4347/7gV+LxtVa8vgUfpBud1rqRWoLPH1F6yr5WshwQUcgRX8Gvr
         5bxoKCQ7fk673Dle31PX4qmBW0XLqXlrzR4RCfXqCVUSnk2Tj6JZspFHlE3RZXY7VzzW
         YNlD5/u2GQN4bk92Zt1AR279/8VzdCYl/swwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cf6vM9jESf9i80uLNJEG7Wy6/PA2gfS+11yY91l4C9I=;
        b=U/uYw1fvS5crUgLBrz5ZFpjtSe7XIGE562VWndpnRraYH2V4E290OBLlW9yvGKtsPc
         Fa9RTLJvyhGcuzlv+wjK3x67BuG0NTIWIjW7OtukvXhEYBRanTxTHfBIp9eorIpetk7B
         Z5NBy4ekrce3AZAcHAaGbkU3PHxIXE1A2RYfmSaC59YU7hdhgDQ45nH1N8zhqbf0VISe
         mxvEMg8kAHqREExmFjUdhbrEy2j/M+ivq9gHNfmm2j8NAF28vP1VfQyF4RhwhJXg1STp
         43RG00pB4w+JXRYBstMq4TPoc1Hz8d5ana6G1iARo/0VhKVjrnbX4e4V05eh4pFkdsK2
         5s2A==
X-Gm-Message-State: AGi0PubxQj6MrYcT3dksBvaYjGQBGRzCfqs1PXXpB2/HlJb4eUIImKw1
        zSfaaXbnuAROikU6hg3Lw/pRWQ==
X-Google-Smtp-Source: APiQypIEOWpl227xWyWsBkD73jjEUHZZB6dRX6mndNGiWNGrJBu2r/mZdD4ojy2/zK2bxDc5DoaIqA==
X-Received: by 2002:a65:6094:: with SMTP id t20mr4545692pgu.220.1588711618222;
        Tue, 05 May 2020 13:46:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b16sm2799596pfp.89.2020.05.05.13.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 13:46:57 -0700 (PDT)
Date:   Tue, 5 May 2020 13:46:56 -0700
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
Subject: Re: [PATCH 2/7] exec: Make unlocking exec_update_mutex explict
Message-ID: <202005051346.B4752035A1@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <875zdajhj8.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zdajhj8.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 05, 2020 at 02:41:47PM -0500, Eric W. Biederman wrote:
> 
> With install_exec_creds updated to follow immediately after
> setup_new_exec, the failure of unshare_sighand is the only
> code path where exec_update_mutex is held but not explicitly
> unlocked.
> 
> Update that code path to explicitly unlock exec_update_mutex.
> 
> Remove the unlocking of exec_update_mutex from free_bprm.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
