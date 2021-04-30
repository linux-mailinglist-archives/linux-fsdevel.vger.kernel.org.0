Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A65636FFD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Apr 2021 19:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhD3Rnu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Apr 2021 13:43:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47779 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231402AbhD3Rnt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Apr 2021 13:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619804580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zPK+tnaHcB/+VVM1x/RM+9OOIwaKwcMREYB79fPL+aU=;
        b=hrlcExNLLnJAI2ikAPJBUmJpTfRG1KJk7Uu0WyINInM9biFab5eIzN2ly2xOCgHgNIqX2w
        InqP5Xo02ZIUSvvhFq5zozoz7msajpcdl1KHrpVnuFmKckUl3UeRmIV58Zyy/2PvUjdRBd
        wEqpYelOKiFOZLL8OY52Ole+l8uH3cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-O_rHOhs4OoO9XBl4hm307A-1; Fri, 30 Apr 2021 13:42:49 -0400
X-MC-Unique: O_rHOhs4OoO9XBl4hm307A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D73702E93;
        Fri, 30 Apr 2021 17:42:47 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50AA35D74B;
        Fri, 30 Apr 2021 17:42:37 +0000 (UTC)
Date:   Fri, 30 Apr 2021 13:42:35 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [PATCH v2 0/3] audit: add support for openat2
Message-ID: <20210430174235.GB3141668@madcap2.tricolour.ca>
References: <cover.1619729297.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1619729297.git.rgb@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021-04-30 13:29, Richard Guy Briggs wrote:
> The openat2(2) syscall was added in v5.6.  Add support for openat2 to the
> audit syscall classifier and for recording openat2 parameters that cannot
> be captured in the syscall parameters of the SYSCALL record.

Well, that was a bit premature...  Commit descriptions in each of the
patches might be a good idea...  Somehow they got dropped from V1.  I
guess they seemed obvious to me.  :-)    Changelog might be a nice
addition too...  Sorry for the noise.

> Supporting userspace code can be found in
> https://github.com/rgbriggs/audit-userspace/tree/ghau-openat2
> 
> Supporting test case can be found in
> https://github.com/linux-audit/audit-testsuite/pull/103
> 
> Richard Guy Briggs (3):
>   audit: replace magic audit syscall class numbers with macros
>   audit: add support for the openat2 syscall
>   audit: add OPENAT2 record to list how
> 
>  arch/alpha/kernel/audit.c          | 10 ++++++----
>  arch/ia64/kernel/audit.c           | 10 ++++++----
>  arch/parisc/kernel/audit.c         | 10 ++++++----
>  arch/parisc/kernel/compat_audit.c  | 11 +++++++----
>  arch/powerpc/kernel/audit.c        | 12 +++++++-----
>  arch/powerpc/kernel/compat_audit.c | 13 ++++++++-----
>  arch/s390/kernel/audit.c           | 12 +++++++-----
>  arch/s390/kernel/compat_audit.c    | 13 ++++++++-----
>  arch/sparc/kernel/audit.c          | 12 +++++++-----
>  arch/sparc/kernel/compat_audit.c   | 13 ++++++++-----
>  arch/x86/ia32/audit.c              | 13 ++++++++-----
>  arch/x86/kernel/audit_64.c         | 10 ++++++----
>  fs/open.c                          |  2 ++
>  include/linux/audit.h              | 11 +++++++++++
>  include/linux/auditscm.h           | 24 +++++++++++++++++++++++
>  include/uapi/linux/audit.h         |  1 +
>  kernel/audit.h                     |  2 ++
>  kernel/auditsc.c                   | 31 ++++++++++++++++++++++++------
>  lib/audit.c                        | 14 +++++++++-----
>  lib/compat_audit.c                 | 15 ++++++++++-----
>  20 files changed, 168 insertions(+), 71 deletions(-)
>  create mode 100644 include/linux/auditscm.h
> 
> -- 
> 2.27.0
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

