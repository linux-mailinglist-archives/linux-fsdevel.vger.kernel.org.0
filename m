Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56336222B9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 21:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgGPTMw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 15:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbgGPTMv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 15:12:51 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9E0C061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 12:12:50 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d1so4280785plr.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 12:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=reZvnOQ8bijPp6S5yQzmCOTTsMLuDmnyX5N/3GfwHXo=;
        b=lhX4KRZzVkUSda9R6NyorS54yyDn6hPMA24J3zBk96aHpX1ic/PoqYAe/VIB7Xy9B/
         HlVJ28tVKHEHHcNCuv/KrJOZBUcoLwz6roC1HJNW31P8tAYmIPcACI0nrMG4j1+ivpMt
         1Xfyw0pkzrtmnsj0jd8RERq8Fj7NvEgD8QxLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=reZvnOQ8bijPp6S5yQzmCOTTsMLuDmnyX5N/3GfwHXo=;
        b=set3cZdxfl/aRIiFCljHz+m+5nXcql617tRPcBydPa0SrxKwqcl9KEhn7VOc4pfMho
         XLQ7aFLhx1n/AecZ/GfzdbS26SmK+c+g1rqvhfi2Z/oWIG8Qg3IXXD0WQCP3ehZ6yP1j
         RPiilDcMSMnQ6yj9CNqinONXKYNzuAqUannIngknwGNOA8P/jWYi1L3uW7XyCJcemqlH
         Z/Yib/1DKvQcS34HmHTKijKH9zJMaJ7kVt66bq9UxL7fFCXZxsy1sRYBE/TyG7+ZSone
         VtKXggNWCyIK7QuySc2hUMDxYISYj+G0fBLXHvGW1S9tZIC9jN7cXQpJ0xoj6++/BXFg
         RgtQ==
X-Gm-Message-State: AOAM530PewAwH9e7o9M//1RSrliuD+x7lYSFZzJKhvm91L5a12b6XgwZ
        O2zXIejqJW242Y08WKjxGZlazA==
X-Google-Smtp-Source: ABdhPJzSOAMegB1OmeJ/PboDzHabSRQP9lhAlD8QVD09gpvRf9fpyvnr8fMJH6cpEeTI0kWvhxJF2g==
X-Received: by 2002:a17:902:7441:: with SMTP id e1mr4615121plt.23.1594926769952;
        Thu, 16 Jul 2020 12:12:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g22sm5602957pgb.82.2020.07.16.12.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 12:12:48 -0700 (PDT)
Date:   Thu, 16 Jul 2020 12:12:47 -0700
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
Message-ID: <202007160957.CABE4CC@keescook>
References: <20200714181638.45751-1-mic@digikod.net>
 <20200714181638.45751-8-mic@digikod.net>
 <202007151339.283D7CD@keescook>
 <8df69733-0088-3e3c-9c3d-2610414cea2b@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8df69733-0088-3e3c-9c3d-2610414cea2b@digikod.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 16, 2020 at 04:40:15PM +0200, Mickaël Salaün wrote:
> 
> On 15/07/2020 22:40, Kees Cook wrote:
> > On Tue, Jul 14, 2020 at 08:16:38PM +0200, Mickaël Salaün wrote:
> >> From: Mimi Zohar <zohar@linux.ibm.com>
> >>
> >> The kernel has no way of differentiating between a file containing data
> >> or code being opened by an interpreter.  The proposed O_MAYEXEC
> >> openat2(2) flag bridges this gap by defining and enabling the
> >> MAY_OPENEXEC flag.
> >>
> >> This patch adds IMA policy support for the new MAY_OPENEXEC flag.
> >>
> >> Example:
> >> measure func=FILE_CHECK mask=^MAY_OPENEXEC
> >> appraise func=FILE_CHECK appraise_type=imasig mask=^MAY_OPENEXEC
> >>
> >> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> >> Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> >> Acked-by: Mickaël Salaün <mic@digikod.net>
> > 
> > (Process nit: if you're sending this on behalf of another author, then
> > this should be Signed-off-by rather than Acked-by.)
> 
> I'm not a co-author of this patch.

Correct, but you are part of the delivery path to its entry to the
tree. If you were co-author, you would include "Co-developed-by" with
a Signed-off-by. (So my nit stands)

For excruciating details:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

"The Signed-off-by: tag indicates that the signer was ... in the patch’s
delivery path."

"Co-developed-by: ... is a used to give attribution to co-authors ..."

-- 
Kees Cook
