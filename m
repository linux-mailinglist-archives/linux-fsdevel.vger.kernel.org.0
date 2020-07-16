Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6C0222BAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 21:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgGPTNe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 15:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbgGPTNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:13:32 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDC4C08C5CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 12:13:32 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g67so5314653pgc.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 12:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=P2Y3x3UF7aakg+eDh/JCMQ/ujg3OM7agEmMMQHUiWYw=;
        b=eUF5kUcP1I8IOHUVxI3FxJ/qxspiNpwWZ1kyR1myyi5d/rlntny124yFpRoBP0S+TU
         IULeT+p9QcpLBQJdqAMtaWb0tPOnG564tv2NICoimzwkKBF7b7R+TO++MSXHI9kPTYW4
         dLCo8Qo5IB3QU1NMvjyOcqhje5qnF9Vt8u7nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=P2Y3x3UF7aakg+eDh/JCMQ/ujg3OM7agEmMMQHUiWYw=;
        b=OdpP7J3cacGnkG4FAiT/VhWt7IYlQOhoZFWYVltEjP7GsPXsdTHk3rOo6lcwP4YxQd
         TIAt5AvsDp/RPQWoMs5RKe5cYZNB0e12utRqF1neqao2Lo3DFyQi63IYFyHyLN5aKfi5
         lBs6i5kon6cNxWDDTLN/3DcEwYXzjy83Pnm30Eidx/rAyFlmjhJbFBBiAqUspVaaIGCg
         b0zGV9bM+nzPtSX8w/DBfDI0CkIfJ7s64bb479GCJWYcDIdCcH+B1hJqghUkrrOOUvwE
         2XKKi4ibYUKSyYtvccJKffl7s13ifRJ8K/8vZ+v4Z0atr8nmcEX5WR9T0IYta2veE3fA
         u9dA==
X-Gm-Message-State: AOAM533iTPWvmJjpPShfLx6b9ntl0OTSt4w7LWUc4uD4p/5KWeb0ct6c
        eqA4Orfzs7JAmiYLLovc12Jg8Q==
X-Google-Smtp-Source: ABdhPJy1fQTquN4l33pCs4D4d2Xd1YwY/TqBCMAGvi2rtEVPLt90LIg/bGHmjLscqWmRjzI4Zwih4g==
X-Received: by 2002:a63:c150:: with SMTP id p16mr5583761pgi.141.1594926811598;
        Thu, 16 Jul 2020 12:13:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u14sm6060148pfk.211.2020.07.16.12.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 12:13:30 -0700 (PDT)
Date:   Thu, 16 Jul 2020 12:13:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
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
Message-ID: <202007161213.E8D240D98@keescook>
References: <20200714181638.45751-1-mic@digikod.net>
 <20200714181638.45751-8-mic@digikod.net>
 <202007151339.283D7CD@keescook>
 <8df69733-0088-3e3c-9c3d-2610414cea2b@digikod.net>
 <61c05cb0-a956-3cc7-5dab-e11ebf0e95bf@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61c05cb0-a956-3cc7-5dab-e11ebf0e95bf@infradead.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 07:59:20AM -0700, Randy Dunlap wrote:
> On 7/16/20 7:40 AM, Mickaël Salaün wrote:
> > 
> > On 15/07/2020 22:40, Kees Cook wrote:
> >> On Tue, Jul 14, 2020 at 08:16:38PM +0200, Mickaël Salaün wrote:
> >>> From: Mimi Zohar <zohar@linux.ibm.com>
> >>>
> >>> The kernel has no way of differentiating between a file containing data
> >>> or code being opened by an interpreter.  The proposed O_MAYEXEC
> >>> openat2(2) flag bridges this gap by defining and enabling the
> >>> MAY_OPENEXEC flag.
> >>>
> >>> This patch adds IMA policy support for the new MAY_OPENEXEC flag.
> >>>
> >>> Example:
> >>> measure func=FILE_CHECK mask=^MAY_OPENEXEC
> >>> appraise func=FILE_CHECK appraise_type=imasig mask=^MAY_OPENEXEC
> >>>
> >>> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> >>> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> >>> Acked-by: Mickaël Salaün <mic@digikod.net>
> >>
> >> (Process nit: if you're sending this on behalf of another author, then
> >> this should be Signed-off-by rather than Acked-by.)
> > 
> > I'm not a co-author of this patch.
> > 
> 
> from Documentation/process/submitting-patches.rst:
> 
> The Signed-off-by: tag indicates that the signer was involved in the
> development of the patch, or that he/she was in the patch's delivery path.
>                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Randy beat me to it. :)

-- 
Kees Cook
