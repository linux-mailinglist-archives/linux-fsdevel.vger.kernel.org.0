Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C75B275A54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 16:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgIWOjs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 10:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgIWOjs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 10:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600871986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XtUNJYHV2J1JZ6JLBA0jisxCSujCzEq2vD80O/D6hKQ=;
        b=iY5/7dAe6kEgdFVW1z/ow1frn3WX7v/28nEB8WFbbrAEe9TNIK2z7i2fG2Y0iPR6iocjS2
        EHFfhUwf8l/aWF2K3tFuqit5C/OHl0g7qc9K1bHx/r3UBnkGqa634OfPvBEAr2qomvrLJh
        WS5qkt1Wp4Gi/vs+X3QEeA1AoaKRN3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-Ai1jqBmFMUa4zYresSj0Pg-1; Wed, 23 Sep 2020 10:39:44 -0400
X-MC-Unique: Ai1jqBmFMUa4zYresSj0Pg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CBF2018A2249;
        Wed, 23 Sep 2020 14:39:40 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-114-108.ams2.redhat.com [10.36.114.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 147BA7882D;
        Wed, 23 Sep 2020 14:39:32 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Solar Designer <solar@openwall.com>
Cc:     Pavel Machek <pavel@ucw.cz>, madvenka@linux.microsoft.com,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org, luto@kernel.org, David.Laight@ACULAB.COM,
        mark.rutland@arm.com, mic@digikod.net,
        Rich Felker <dalias@libc.org>
Subject: Re: [PATCH v2 0/4] [RFC] Implement Trampoline File Descriptor
References: <20200922215326.4603-1-madvenka@linux.microsoft.com>
        <20200923081426.GA30279@amd> <20200923091456.GA6177@openwall.com>
Date:   Wed, 23 Sep 2020 16:39:31 +0200
In-Reply-To: <20200923091456.GA6177@openwall.com> (Solar Designer's message of
        "Wed, 23 Sep 2020 11:14:57 +0200")
Message-ID: <87wo0ko8v0.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Solar Designer:

> While I share my opinion here, I don't mean that to block Madhavan's
> work.  I'd rather defer to people more knowledgeable in current userland
> and ABI issues/limitations and plans on dealing with those, especially
> to Florian Weimer.  I haven't seen Florian say anything specific for or
> against Madhavan's proposal, and I'd like to.  (Have I missed that?)

There was a previous discussion, where I provided feedback (not much
different from the feedback here, given that the mechanism is mostly the
same).

I think it's unnecessary for the libffi use case.  Precompiled code can
be loaded from disk because the libffi trampolines are so regular.  On
most architectures, it's not even the code that's patched, but some of
the data driving it, which happens to be located on the same page due to
a libffi quirk.

The libffi use case is a bit strange anyway: its trampolines are
type-generic, and the per-call adjustment is data-driven.  This means
that once you have libffi in the process, you have a generic
data-to-function-call mechanism available that can be abused (it's even
fully CET compatible in recent versions).  And then you need to look at
the processes that use libffi.  A lot of them contain bytecode
interpreters, and those enable data-driven arbitrary code execution as
well.  I know that there are efforts under way to harden Python, but
it's going to be tough to get to the point where things are still
difficult for an attacker once they have the ability to make mprotect
calls.

It was pointed out to me that libffi is doing things wrong, and the
trampolines should not be type-generic, but generated so that they match
the function being called.  That is, the marshal/unmarshal code would be
open-coded in the trampoline, rather than using some generic mechanism
plus run-time dispatch on data tables describing the function type.
That is a very different design (and typically used by compilers (JIT or
not JIT) to implement native calls).  Mapping some code page with a
repeating pattern would no longer work to defeat anti-JIT measures
because it's closer to real JIT.  I don't know if kernel support could
make sense in this context, but it would be a completely different
patch.

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

