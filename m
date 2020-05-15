Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9621D521F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 16:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgEOOn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 10:43:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27082 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726144AbgEOOn6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 10:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589553836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hR6lCjnUOV2j2gabpoQGpgvPB5RUTChOvM8hrmj3dmQ=;
        b=VSCRaFLca5yi3iQfBNH3T3ZjDyItQ586Ij887M9sCdMPqgLgHzbyqh71PwDoClQuE76Of3
        BlbSECSrAdiqui0iyv/jPGUWUbPtc7ZviNPaaWK+b9U3P+pLHPt8M/h7I2rd+b+ESotBbe
        kIOrN1TdVK7O9sREORy+1zUf41MQok8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-IBhV3vZSOp6wkLbJJ_diLA-1; Fri, 15 May 2020 10:43:52 -0400
X-MC-Unique: IBhV3vZSOp6wkLbJJ_diLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C02C78018A2;
        Fri, 15 May 2020 14:43:47 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-77.ams2.redhat.com [10.36.112.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8C92A5C241;
        Fri, 15 May 2020 14:43:39 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        John Johansen <john.johansen@canonical.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        "Lev R. Oshvang ." <levonshe@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Philippe =?utf-8?Q?Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: How about just O_EXEC? (was Re: [PATCH v5 3/6] fs: Enable to enforce noexec mounts or file exec through O_MAYEXEC)
References: <20200505153156.925111-4-mic@digikod.net>
        <CAEjxPJ7y2G5hW0WTH0rSrDZrorzcJ7nrQBjfps2OWV5t1BUYHw@mail.gmail.com>
        <202005131525.D08BFB3@keescook> <202005132002.91B8B63@keescook>
        <CAEjxPJ7WjeQAz3XSCtgpYiRtH+Jx-UkSTaEcnVyz_jwXKE3dkw@mail.gmail.com>
        <202005140830.2475344F86@keescook>
        <CAEjxPJ4R_juwvRbKiCg5OGuhAi1ZuVytK4fKCDT_kT6VKc8iRg@mail.gmail.com>
        <b740d658-a2da-5773-7a10-59a0ca52ac6b@digikod.net>
        <202005142343.D580850@keescook>
        <87a729wpu1.fsf@oldenburg2.str.redhat.com>
        <202005150732.17C5EE0@keescook>
Date:   Fri, 15 May 2020 16:43:37 +0200
In-Reply-To: <202005150732.17C5EE0@keescook> (Kees Cook's message of "Fri, 15
        May 2020 07:37:16 -0700")
Message-ID: <87r1vluuli.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Kees Cook:

> On Fri, May 15, 2020 at 10:43:34AM +0200, Florian Weimer wrote:
>> * Kees Cook:
>> 
>> > Maybe I've missed some earlier discussion that ruled this out, but I
>> > couldn't find it: let's just add O_EXEC and be done with it. It actually
>> > makes the execve() path more like openat2() and is much cleaner after
>> > a little refactoring. Here are the results, though I haven't emailed it
>> > yet since I still want to do some more testing:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=kspp/o_exec/v1
>> 
>> I think POSIX specifies O_EXEC in such a way that it does not confer
>> read permissions.  This seems incompatible with what we are trying to
>> achieve here.
>
> I was trying to retain this behavior, since we already make this
> distinction between execve() and uselib() with the MAY_* flags:
>
> execve():
>         struct open_flags open_exec_flags = {
>                 .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
>                 .acc_mode = MAY_EXEC,
>
> uselib():
>         static const struct open_flags uselib_flags = {
>                 .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
>                 .acc_mode = MAY_READ | MAY_EXEC,
>
> I tried to retain this in my proposal, in the O_EXEC does not imply
> MAY_READ:

That doesn't quite parse for me, sorry.

The point is that the script interpreter actually needs to *read* those
files in order to execute them.

Thanks,
Florian

