Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B63221665
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 22:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGOUkR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 16:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOUkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:40:16 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A00BC08C5DB
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 13:40:16 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k5so3555332pjg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2020 13:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=3RdpnHt4YFQNegHM71xCSPo+5hGEKA55j9DzkLX+zEI=;
        b=W6JWWMnCCKRoZOrZTqxAVNCpWdse7JHrhl955F5ofkWIbY8yj0WiYEYIrzGnCpQmPr
         nebzAR1cLp77bQPydJtMWmGvGL1DOx/5b1SD2FJ+owpHkt8+SixM1Gqmi5haJ+ZpVK/l
         ohTNaS/ycfxJ7NhhCYIL+fq/TdpwR9jTHXNUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3RdpnHt4YFQNegHM71xCSPo+5hGEKA55j9DzkLX+zEI=;
        b=pD420LVdWGdnbK13CfON/igN5ubDEFW6dZGUaRjVwrt+BQF6BXD2/qQW1DiPaLjryu
         R+fv9UeWc6z7c52a4MBzGdb4JuEylk5okqh8JFlLFpvSXI6er9y75aIhnyw0AVmkAJRN
         w4KzitQ5M37jwHc382d2AZakDauYsLS6Gvyp6fx1AOSAK2Iy02W8nzddpGC9Lt3ab1lm
         Inm9YJTvy7wigN6/EvNl8evh7rgCrFLXZEB55RhupcOv+GjhRRGdpuAW1CYlEdY3aLT6
         P1y2jCdhL7Olm/YI42Tv4P2H+fpbE5Sc8mLzB+HUnURZoHiJZkfdx5T+737JjRVFAAiC
         ehvw==
X-Gm-Message-State: AOAM532Mvh58ZLOh1CyQ6Vet6LL+B00Iobk368wz91ku6+/Huqg1ij3k
        cS+7vekEaNOKQwUiRF8Pqmc4tg==
X-Google-Smtp-Source: ABdhPJy0QMC5q+2qYD6o7SHOebREIiw8ISqB8EjezF/XGzbblfIdGbOr3hMolHLPO5Yp/fgvt7Nt3A==
X-Received: by 2002:a17:90b:8d7:: with SMTP id ds23mr1507273pjb.148.1594845616072;
        Wed, 15 Jul 2020 13:40:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 66sm2720207pfd.93.2020.07.15.13.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 13:40:15 -0700 (PDT)
Date:   Wed, 15 Jul 2020 13:40:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 7/7] ima: add policy support for the new file open
 MAY_OPENEXEC flag
Message-ID: <202007151339.283D7CD@keescook>
References: <20200714181638.45751-1-mic@digikod.net>
 <20200714181638.45751-8-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200714181638.45751-8-mic@digikod.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:16:38PM +0200, Mickaël Salaün wrote:
> From: Mimi Zohar <zohar@linux.ibm.com>
> 
> The kernel has no way of differentiating between a file containing data
> or code being opened by an interpreter.  The proposed O_MAYEXEC
> openat2(2) flag bridges this gap by defining and enabling the
> MAY_OPENEXEC flag.
> 
> This patch adds IMA policy support for the new MAY_OPENEXEC flag.
> 
> Example:
> measure func=FILE_CHECK mask=^MAY_OPENEXEC
> appraise func=FILE_CHECK appraise_type=imasig mask=^MAY_OPENEXEC
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Acked-by: Mickaël Salaün <mic@digikod.net>

(Process nit: if you're sending this on behalf of another author, then
this should be Signed-off-by rather than Acked-by.)

-- 
Kees Cook
