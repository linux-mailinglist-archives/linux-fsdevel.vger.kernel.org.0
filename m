Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A743989CB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 14:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFBMmU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 08:42:20 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:41830 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFBMmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:42:13 -0400
Received: by mail-pg1-f177.google.com with SMTP id r1so2116666pgk.8;
        Wed, 02 Jun 2021 05:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hYXfyxZSmLanul1A7ftAzSj6LP9NlQ7DNARdgfnzZ54=;
        b=IOx8YvT8nf/98mIy6Kk6msUorKzqcs3IAU333eZIlO+Nk7uFiGmUzxtVKv3ahu3/GA
         qSk4LvzWGIwQC9gpHf5/jUAQYQUP3b+0JGkQkc0aGuMKRc7O2gXe5e+uFIKsbzsPtCJ+
         fF/uzvvWTiVNfu0nGcJ2zipznZIuDYJZdy2RzB6TA6myQBAq7+Vem1NSHwHBmznzCRvx
         jPyw2iWpCafdyFOa75KgffIdziBkHMi1sPuaBzJcJqg2IRqnTjzmjte1S8J1YyoUVA3r
         G7TwQuPvnoFNrqA8/VB4zrNMCJEPcQSRIlpIwKdTfw7x9Kz5Zurt5O7LEneCAlUoIiVf
         B5sA==
X-Gm-Message-State: AOAM533Ud5NoqJgXn/X2M3WvNoh3h0i8t/xiKNgq5OAlzoJL+nxyqZ0L
        lve0nKxIX7Fxt05I4uVAIVwBRmh+YfY=
X-Google-Smtp-Source: ABdhPJyWIBEO1MAlKvjSQ7qUUl80y9kfR1anA5bxCU61olb4vvDdRxABFGlrT70/SkYE0mEMNsFQcg==
X-Received: by 2002:a63:f40d:: with SMTP id g13mr34484886pgi.290.1622637613957;
        Wed, 02 Jun 2021 05:40:13 -0700 (PDT)
Received: from garbanzo (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id f5sm4617417pjp.37.2021.06.02.05.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 05:40:12 -0700 (PDT)
Date:   Wed, 2 Jun 2021 05:40:10 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        mcgrof@kernel.org
Subject: [LSF/MM/BPF TOPIC] scaling error injection beyond add_disk()
Message-ID: <20210602124010.vbjqwkber72xhftz@garbanzo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have not had any error handling as part of the block layer's
*add_disk() paths since the code's inception. As support for that is
being added the question becomes if using the kernel's error injection
infrastructure is actually appropriate here in consideration of scaling
similar strategies in other places for fs/block. Alternatives being
considered are things like live patching, eBPF, and kunit.

Scaling error injection using the kernel error injection infrastructure
can scale by using debugfs for variability in a specific target error
path of interest, as demonstrated in my latest patch series. This allows
us to ensure that generic routines are only forced to fail in the
context of add_disk(), for example, and not other aras of the kernel.
However, this still means adding boilerplate code for each piece of
code we want to force failure on a code path. This also implies we'd
have to ensure we ask developers to add a new call error injection
knobs and call per added code which can fail on the area of interest.

This begs the question -- can we do better?

An alternative example is to use live patching for each error call we
want to modify, however this poses the difficulty in that some calls
are very generic and we may not want to modify all instances of that
routine, but only *in context* of say, the add_disk() callers. That is,
for example, since add_disk() calls device_add(), we want to at some
point be able to test having that routine fail, but only if called
within the add_disk() path, and not for other cases. This makes
using live patching difficult. Likewise, there are the concerns of
possible alaternative bugs when using rmmod, or races not yet exposed.

If I can, I'll try to see if I can address what this might look like
with eBFP before LSFMM, but until then, the question still stands as
to what the best path forward might be for new code as we consider
adding error injection.

  Luis
