Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C400422D8D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Oct 2021 18:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbhJEQNC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Oct 2021 12:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbhJEQM6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:12:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFFFC061753
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Oct 2021 09:11:08 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id w11so2621417plz.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Oct 2021 09:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LOQoums2EVgJDxJo+caJ0kHdjSP5vLtw5iCXa+UR1B0=;
        b=FypNWYbB1OUHmHme2fLHqshWLMEfZo0TgfixcHklBKdzNYhBI9EwwXtHFSnEn4+8RA
         m/HvKEH6fGbfV/AdonziylF2dhzW9VLKJRWnHA0XH7B/wTM2rC9tYdO9X8TkBrhT8Euy
         WrJjmkjkVmFRJd9FA8HIFO6EsDSLqvI/YOgmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LOQoums2EVgJDxJo+caJ0kHdjSP5vLtw5iCXa+UR1B0=;
        b=MvhuCzmyVS3YpkO9yvJn80pE7jISwTK5wVVyP6kMyei8o48THd79+JcAa6aNd8QNbl
         9w5ui0WnaLKS1ZoPPEHGAgoaNoSwI2uRt5wIy++HrmDQ1SZPlZe3CrQfJef63kD7exNu
         oRk1XnEcMoY3UTRpY1xtycIlEikC0Q+H+/zUQiNWKfIeBVOhP6znLeQhqCoOekg18N6O
         ql4f9JQMAwFQVsrduuef7DE6u9PjuHitmRqpMPXPRSudnN5E6xMJo7bcwL2k8hJEG9xy
         eZVzCfKAavqZbnpmXI0sK0eME8wuK62RA4MVw77fZUjXOoyDOyX3tqJZSfcb8ChkLQlv
         y5kw==
X-Gm-Message-State: AOAM533PT0wWVSssRPfs51JacUagSe+utyQogTdZ3Qz+3P2QaZQ6P5Ah
        7IDg++EmckEnRJ2rFR2NH/1IyA==
X-Google-Smtp-Source: ABdhPJykuN5cLw2duFymZQgkXUxSiuquHuVEzLDtXdM75l71AU3pXVHx/RxwefjBcJdz6mZkTL+TlA==
X-Received: by 2002:a17:902:e544:b0:13e:e863:6cd2 with SMTP id n4-20020a170902e54400b0013ee8636cd2mr2901204plf.41.1633450267896;
        Tue, 05 Oct 2021 09:11:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c18sm17294235pge.69.2021.10.05.09.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 09:11:07 -0700 (PDT)
Date:   Tue, 5 Oct 2021 09:11:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Kuno Woudt <kuno@frob.nl>,
        Richard Fontana <fontana@sharpeleven.org>,
        copyleft-next@lists.fedorahosted.org,
        Ciaran Farrell <Ciaran.Farrell@suse.com>,
        Christopher De Nicolo <Christopher.DeNicolo@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v8 02/12] testing: use the copyleft-next-0.3.1 SPDX tag
Message-ID: <202110050909.739BF8A09@keescook>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927163805.808907-3-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 09:37:55AM -0700, Luis Chamberlain wrote:
> Two selftests drivers exist under the copyleft-next license.
> These drivers were added prior to SPDX practice taking full swing
> in the kernel. Now that we have an SPDX tag for copylef-next-0.3.1
> documented, embrace it and remove the boiler plate.
> 
> Cc: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Cc: Kuno Woudt <kuno@frob.nl>
> Cc: Richard Fontana <fontana@sharpeleven.org>
> Cc: copyleft-next@lists.fedorahosted.org
> Cc: Ciaran Farrell <Ciaran.Farrell@suse.com>
> Cc: Christopher De Nicolo <Christopher.DeNicolo@suse.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Thorsten Leemhuis <linux@leemhuis.info>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

You're the primary author, and it cleans up boilerplate, so LGTM.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
