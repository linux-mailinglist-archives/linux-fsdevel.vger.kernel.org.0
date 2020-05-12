Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46801D0108
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 23:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbgELVkj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 17:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726268AbgELVki (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 17:40:38 -0400
Received: from mail.python.org (mail.python.org [IPv6:2a03:b0c0:2:d0::71:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF11C061A0C;
        Tue, 12 May 2020 14:40:37 -0700 (PDT)
Received: from seneca.home.cheimes.de (unknown [IPv6:2a04:4540:6510:1f00:49ee:d60d:b990:1a75])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.python.org (Postfix) with ESMTPSA id 49MB7745LTzpFD9;
        Tue, 12 May 2020 17:40:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=python.org; s=200901;
        t=1589319635; bh=5X03pNntp4aida3A8i1HP9pAxlVP60DfoAigezXtE3Y=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=fo27wUx9UR7x6VmF7xXiio9GscL/aHHHHa1Qo7TAqwNzvNk0q1RFmRgo3JMCoGNOd
         Ibr+/HXNAWmOJ6LIOwposSA9rHd4l6OgWHNwlVx7UuVupa/rDfpEjaRmZmQsFTfug0
         Gkvzi7fxirEgw42Z14GJqeeEWuz7qCuUAwY/JwyE=
Subject: Re: [PATCH v5 1/6] fs: Add support for an O_MAYEXEC flag on
 openat2(2)
To:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200505153156.925111-1-mic@digikod.net>
 <20200505153156.925111-2-mic@digikod.net> <202005121258.4213DC8A2@keescook>
From:   Christian Heimes <christian@python.org>
Autocrypt: addr=christian@python.org; prefer-encrypt=mutual; keydata=
 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
 53+DNOMi/34rdBwm0I62QkVYJYU=
Message-ID: <0c70debd-e79e-d514-06c6-4cd1e021fa8b@python.org>
Date:   Tue, 12 May 2020 23:40:35 +0200
MIME-Version: 1.0
In-Reply-To: <202005121258.4213DC8A2@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/05/2020 23.05, Kees Cook wrote:
> On Tue, May 05, 2020 at 05:31:51PM +0200, Mickaël Salaün wrote:
>> When the O_MAYEXEC flag is passed, openat2(2) may be subject to
>> additional restrictions depending on a security policy managed by the
>> kernel through a sysctl or implemented by an LSM thanks to the
>> inode_permission hook.  This new flag is ignored by open(2) and
>> openat(2).
>>
>> The underlying idea is to be able to restrict scripts interpretation
>> according to a policy defined by the system administrator.  For this to
>> be possible, script interpreters must use the O_MAYEXEC flag
>> appropriately.  To be fully effective, these interpreters also need to
>> handle the other ways to execute code: command line parameters (e.g.,
>> option -e for Perl), module loading (e.g., option -m for Python), stdin,
>> file sourcing, environment variables, configuration files, etc.
>> According to the threat model, it may be acceptable to allow some script
>> interpreters (e.g. Bash) to interpret commands from stdin, may it be a
>> TTY or a pipe, because it may not be enough to (directly) perform
>> syscalls.  Further documentation can be found in a following patch.
> 
> You touch on this lightly in the cover letter, but it seems there are
> plans for Python to restrict stdin parsing? Are there patches pending
> anywhere for other interpreters? (e.g. does CLIP OS have such patches?)
> 
> There's always a push-back against adding features that have external
> dependencies, and then those external dependencies can't happen without
> the kernel first adding a feature. :) I like getting these catch-22s
> broken, and I think the kernel is the right place to start, especially
> since the threat model (and implementation) is already proven out in
> CLIP OS, and now with IMA. So, while the interpreter side of this is
> still under development, this gives them the tool they need to get it
> done on the kernel side. So showing those pieces (as you've done) is
> great, and I think finding a little bit more detail here would be even
> better.

Hi,

Python core dev here.

Yes, there are plans to use feature for Python in combination with
additional restrictions. For backwards compatibility reasons we cannot
change the behavior of the default Python interpreter. I have plans to
provide a restricted Python binary that prohibits piping from stdin,
disables -c "some_code()", restricts import locations, and a couple of
other things. O_MAYEXEC flag makes it easier to block imports from
noexec filesystems.

My PoC [1] for a talk [2] last year is inspired by IMA appraisal and a
previous talk by Mickaël on O_MAYEXEC.

Christian

[1] https://github.com/zooba/spython/blob/master/linux_xattr/spython.c
[2]
https://speakerdeck.com/tiran/europython-2019-auditing-hooks-and-security-transparency-for-cpython
