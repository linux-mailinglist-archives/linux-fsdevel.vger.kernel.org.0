Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC832676D0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 02:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgILAaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 20:30:05 -0400
Received: from namei.org ([65.99.196.166]:56856 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgILAaE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 20:30:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id 08C0SqIZ019846;
        Sat, 12 Sep 2020 00:28:52 GMT
Date:   Sat, 12 Sep 2020 10:28:52 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Matthew Wilcox <willy@infradead.org>
cc:     =?ISO-8859-15?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        =?ISO-8859-15?Q?Philippe_Tr=E9buchet?= 
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
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v9 0/3] Add introspect_access(2) (was O_MAYEXEC)
In-Reply-To: <20200910184033.GX6583@casper.infradead.org>
Message-ID: <alpine.LRH.2.21.2009121019050.17638@namei.org>
References: <20200910164612.114215-1-mic@digikod.net> <20200910170424.GU6583@casper.infradead.org> <f6e2358c-8e5e-e688-3e66-2cdd943e360e@digikod.net> <a48145770780d36e90f28f1526805a7292eb74f6.camel@linux.ibm.com> <880bb4ee-89a2-b9b0-747b-0f779ceda995@digikod.net>
 <20200910184033.GX6583@casper.infradead.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1665246916-2084386636-1599870464=:17638"
Content-ID: <alpine.LRH.2.21.2009121028320.17638@namei.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-2084386636-1599870464=:17638
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LRH.2.21.2009121028321.17638@namei.org>

On Thu, 10 Sep 2020, Matthew Wilcox wrote:

> On Thu, Sep 10, 2020 at 08:38:21PM +0200, Mickaël Salaün wrote:
> > There is also the use case of noexec mounts and file permissions. From
> > user space point of view, it doesn't matter which kernel component is in
> > charge of defining the policy. The syscall should then not be tied with
> > a verification/integrity/signature/appraisal vocabulary, but simply an
> > access control one.
> 
> permission()?
> 

The caller is not asking the kernel to grant permission, it's asking 
"SHOULD I access this file?"

The caller doesn't know, for example, if the script file it's about to 
execute has been signed, or if it's from a noexec mount. It's asking the 
kernel, which does know. (Note that this could also be extended to reading 
configuration files).

How about: should_faccessat ?

-- 
James Morris
<jmorris@namei.org>
--1665246916-2084386636-1599870464=:17638--
