Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D099D4281B7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Oct 2021 16:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhJJOXc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Oct 2021 10:23:32 -0400
Received: from albireo.enyo.de ([37.24.231.21]:55530 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231846AbhJJOXc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Oct 2021 10:23:32 -0400
X-Greylist: delayed 628 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Oct 2021 10:23:31 EDT
Received: from [172.17.203.2] (port=48075 helo=deneb.enyo.de)
        by albireo.enyo.de ([172.17.140.2]) with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1mZZWh-0005qE-Ez; Sun, 10 Oct 2021 14:10:07 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.94.2)
        (envelope-from <fw@deneb.enyo.de>)
        id 1mZZWh-0006hy-5Z; Sun, 10 Oct 2021 16:10:07 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        Philippe =?iso-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FC?= =?iso-8859-1?Q?n?= 
        <mic@linux.microsoft.com>
Subject: Re: [PATCH v14 1/3] fs: Add trusted_for(2) syscall implementation
 and related sysctl
References: <20211008104840.1733385-1-mic@digikod.net>
        <20211008104840.1733385-2-mic@digikod.net>
Date:   Sun, 10 Oct 2021 16:10:07 +0200
In-Reply-To: <20211008104840.1733385-2-mic@digikod.net>
 (=?iso-8859-1?Q?=22Micka=EBl_Sala=FCn=22's?=
        message of "Fri, 8 Oct 2021 12:48:38 +0200")
Message-ID: <87tuhpynr4.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Mickaël Salaün:

> Being able to restrict execution also enables to protect the kernel by
> restricting arbitrary syscalls that an attacker could perform with a
> crafted binary or certain script languages.  It also improves multilevel
> isolation by reducing the ability of an attacker to use side channels
> with specific code.  These restrictions can natively be enforced for ELF
> binaries (with the noexec mount option) but require this kernel
> extension to properly handle scripts (e.g. Python, Perl).  To get a
> consistent execution policy, additional memory restrictions should also
> be enforced (e.g. thanks to SELinux).

One example I have come across recently is that code which can be
safely loaded as a Perl module is definitely not a no-op as a shell
script: it downloads code and executes it, apparently over an
untrusted network connection and without signature checking.

Maybe in the IMA world, the expectation is that such ambiguous code
would not be signed in the first place, but general-purpose
distributions are heading in a different direction with
across-the-board signing:

  Signed RPM Contents
  <https://fedoraproject.org/wiki/Changes/Signed_RPM_Contents>

So I wonder if we need additional context information for a potential
LSM to identify the intended use case.
