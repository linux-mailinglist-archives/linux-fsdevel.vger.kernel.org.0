Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8E9AABF5D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 20:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404605AbfIFS1o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 6 Sep 2019 14:27:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392062AbfIFS1o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:27:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24C82558A1;
        Fri,  6 Sep 2019 18:27:43 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-27.ams2.redhat.com [10.36.116.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E83F85EE1D;
        Fri,  6 Sep 2019 18:27:33 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?utf-8?Q?Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] fs: Add support for an O_MAYEXEC flag on sys_open()
References: <20190906152455.22757-1-mic@digikod.net>
        <20190906152455.22757-2-mic@digikod.net>
        <87ef0te7v3.fsf@oldenburg2.str.redhat.com>
        <75442f3b-a3d8-12db-579a-2c5983426b4d@ssi.gouv.fr>
        <20190906170739.kk3opr2phidb7ilb@yavin.dot.cyphar.com>
        <20190906172050.v44f43psd6qc6awi@wittgenstein>
        <20190906174041.GH7627@cisco>
Date:   Fri, 06 Sep 2019 20:27:31 +0200
In-Reply-To: <20190906174041.GH7627@cisco> (Tycho Andersen's message of "Fri,
        6 Sep 2019 11:40:41 -0600")
Message-ID: <87v9u5cmb0.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 06 Sep 2019 18:27:43 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Tycho Andersen:

> On Fri, Sep 06, 2019 at 07:20:51PM +0200, Christian Brauner wrote:
>> On Sat, Sep 07, 2019 at 03:07:39AM +1000, Aleksa Sarai wrote:
>> > On 2019-09-06, Mickaël Salaün <mickael.salaun@ssi.gouv.fr> wrote:
>> > > 
>> > > On 06/09/2019 17:56, Florian Weimer wrote:
>> > > > Let's assume I want to add support for this to the glibc dynamic loader,
>> > > > while still being able to run on older kernels.
>> > > >
>> > > > Is it safe to try the open call first, with O_MAYEXEC, and if that fails
>> > > > with EINVAL, try again without O_MAYEXEC?
>> > > 
>> > > The kernel ignore unknown open(2) flags, so yes, it is safe even for
>> > > older kernel to use O_MAYEXEC.
>> > 
>> > Depends on your definition of "safe" -- a security feature that you will
>> > silently not enable on older kernels doesn't sound super safe to me.
>> > Unfortunately this is a limitation of open(2) that we cannot change --
>> > which is why the openat2(2) proposal I've been posting gives -EINVAL for
>> > unknown O_* flags.
>> > 
>> > There is a way to probe for support (though unpleasant), by creating a
>> > test O_MAYEXEC fd and then checking if the flag is present in
>> > /proc/self/fdinfo/$n.
>> 
>> Which Florian said they can't do for various reasons.
>> 
>> It is a major painpoint if there's no easy way for userspace to probe
>> for support. Especially if it's security related which usually means
>> that you want to know whether this feature works or not.
>
> What about just trying to violate the policy via fexecve() instead of
> looking around in /proc? Still ugly, though.

How would we do this?  This is about opening the main executable as part
of an explicit loader invocation.  Typically, an fexecve will succeed
and try to run the program, but with the wrong dynamic loader.

Thanks,
Florian
