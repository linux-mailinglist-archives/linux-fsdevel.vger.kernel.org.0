Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C19F1C7A69
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 21:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgEFTiX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 15:38:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34504 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729316AbgEFTiW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 15:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588793901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4yGP/vMyHodm9DIXtqpc9Y5085eYUUAufi7jwsRMqFY=;
        b=bJBtLCbpiYSfHeOTzpKfxlnfTdkiWiffsuNOi8hZY/kUUDYAgDYF4H+1DYaUuUdnO1cYPx
        g+LFd4QUn8FTapE7XEndlCuW8mPDfovnDjEveKLgzgHm/QJkQbnugEyy2P+HykxUDJ98Li
        pwG3EDYCKx2GHvMna8U9W8VkfxAEMDc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-BghV_ulkOQ2QF-S-a2gkMA-1; Wed, 06 May 2020 15:38:19 -0400
X-MC-Unique: BghV_ulkOQ2QF-S-a2gkMA-1
Received: by mail-qk1-f198.google.com with SMTP id h186so2936349qkc.22
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 May 2020 12:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4yGP/vMyHodm9DIXtqpc9Y5085eYUUAufi7jwsRMqFY=;
        b=AqKRs8HdLTrqQyJTZjhggDjTDSOzUYG6d2jVs0BIMxD3Ajxuh+4dFpcTLr6LyI9LTN
         Z1FAJ6xuziyUmLTFpUDjPOyguirK4xryQ8i8VqIJ0/wSNVInH3TRNG08TEHu55mR+8wt
         NcPpoid+toVroVOlGi59f4L8AKrdLaNAC3gBww2Dn6CDx+wT9XKSfTPSCtsLnRJ6sdNh
         UhMbwj8yKBukAPswoC/xK/DyqNfoslT2lIRiGFEgcwNzvpTusoCwd0JSgL+hGnKxXn+j
         jfFJ7epqjrw4Y1rwtod461rQ8mefDgOPay3Ui+mSU1I8FFwUTwXDuBBdoDPWc1NjvuUx
         KCFw==
X-Gm-Message-State: AGi0PuZnno0bcnGDPjp0LkE3MERLEmnVN9YhLxxv4b6TA+fgosqV70k6
        GSDs7TVvz5p5i6ia+oXo3F89gRp2oWlD8Cm3+tNjJ45YGFsmpVfp3sZdXTbWeuQNf2SR+87O/Vw
        B5WqW+YTGMQweRUhiIvfkXIjHVw==
X-Received: by 2002:ac8:6cf:: with SMTP id j15mr10289654qth.143.1588793899434;
        Wed, 06 May 2020 12:38:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypJgeGRbgQoROxq+NzNkpj9p1DQBrBYEowm2aG2YpEWn4T7EEcbZzi+caA0aMstz/KZmNOVVMA==
X-Received: by 2002:ac8:6cf:: with SMTP id j15mr10289631qth.143.1588793899217;
        Wed, 06 May 2020 12:38:19 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id h188sm2445057qke.82.2020.05.06.12.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 12:38:18 -0700 (PDT)
Date:   Wed, 6 May 2020 15:38:16 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Jerome Glisse <jglisse@redhat.com>, Shaohua Li <shli@fb.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, timmurray@google.com,
        minchan@google.com, sspatil@google.com, lokeshgidra@google.com
Subject: Re: [PATCH 2/2] Add a new sysctl knob:
 unprivileged_userfaultfd_user_mode_only
Message-ID: <20200506193816.GB228260@xz-x1>
References: <20200423002632.224776-1-dancol@google.com>
 <20200423002632.224776-3-dancol@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423002632.224776-3-dancol@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:26:32PM -0700, Daniel Colascione wrote:
> +unprivileged_userfaultfd_user_mode_only
> +========================================
> +
> +This flag controls whether unprivileged users can use the userfaultfd
> +system calls to handle page faults in kernel mode.  If set to zero,
> +userfaultfd works with or without UFFD_USER_MODE_ONLY, modulo
> +unprivileged_userfaultfd above.  If set to one, users without
> +SYS_CAP_PTRACE must pass UFFD_USER_MODE_ONLY in order for userfaultfd
> +to succeed.  Prohibiting use of userfaultfd for handling faults from
> +kernel mode may make certain vulnerabilities more difficult
> +to exploit.
> +
> +The default value is 0.

If this is going to be added... I am thinking whether it should be easier to
add another value for unprivileged_userfaultfd, rather than a new sysctl. E.g.:

  "0": unprivileged userfaultfd forbidden
  "1": unprivileged userfaultfd allowed (both user/kernel faults)
  "2": unprivileged userfaultfd allowed (only user faults)

Because after all unprivileged_userfaultfd_user_mode_only will be meaningless
(iiuc) if unprivileged_userfaultfd=0.  The default value will also be the same
as before ("1") then.

Thanks,

-- 
Peter Xu

