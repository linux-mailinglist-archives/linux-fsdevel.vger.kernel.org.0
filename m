Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF82922E53D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 07:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgG0F1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 01:27:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59673 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726139AbgG0F1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 01:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595827638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AKE5Hc2PxuPIW6hu7a7doCEJmqwBxswHHKiFGDtBWQs=;
        b=KuCDzLEhWv1b+/Uu095gPIeZDehqdGr2jzIpoGZCQwF4MiOHYngWuEW5g/8Ee3xoEwmJaf
        woNtM/l6o7pmFAlu7cTlgANUJwODJkmWOqdsay7hDUCMNrNKMHLTifIiQDDS2366Pnkvag
        LaXv6zCU3+Wv97hZWvCsyUmvW46VK1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-WX2tJBGCNPCBLW1UaUOyYg-1; Mon, 27 Jul 2020 01:27:14 -0400
X-MC-Unique: WX2tJBGCNPCBLW1UaUOyYg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD4C259;
        Mon, 27 Jul 2020 05:27:09 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-104.ams2.redhat.com [10.36.112.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ECB8410013D0;
        Mon, 27 Jul 2020 05:27:01 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?utf-8?Q?Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Subject: Re: [PATCH v7 4/7] fs: Introduce O_MAYEXEC flag for openat2(2)
References: <20200723171227.446711-1-mic@digikod.net>
        <20200723171227.446711-5-mic@digikod.net>
        <20200727042106.GB794331@ZenIV.linux.org.uk>
Date:   Mon, 27 Jul 2020 07:27:00 +0200
In-Reply-To: <20200727042106.GB794331@ZenIV.linux.org.uk> (Al Viro's message
        of "Mon, 27 Jul 2020 05:21:06 +0100")
Message-ID: <87y2n55xzv.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Al Viro:

> On Thu, Jul 23, 2020 at 07:12:24PM +0200, Micka=C3=83=C2=ABl Sala=C3=83=
=C2=BCn wrote:
>> When the O_MAYEXEC flag is passed, openat2(2) may be subject to
>> additional restrictions depending on a security policy managed by the
>> kernel through a sysctl or implemented by an LSM thanks to the
>> inode_permission hook.  This new flag is ignored by open(2) and
>> openat(2) because of their unspecified flags handling.  When used with
>> openat2(2), the default behavior is only to forbid to open a directory.
>
> Correct me if I'm wrong, but it looks like you are introducing a magical
> flag that would mean "let the Linux S&M take an extra special whip
> for this open()".
>
> Why is it done during open?  If the caller is passing it deliberately,
> why not have an explicit request to apply given torture device to an
> already opened file?  Why not sys_masochism(int fd, char *hurt_flavour),
> for that matter?

While I do not think this is appropriate language for a workplace, Al
has a point: If the auditing event can be generated on an already-open
descriptor, it would also cover scenarios like this one:

  perl < /path/to/script

Where the process that opens the file does not (and cannot) know that it
will be used for execution purposes.

Thanks,
Florian

