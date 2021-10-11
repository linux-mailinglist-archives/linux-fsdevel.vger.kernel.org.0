Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE0C4288B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 10:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbhJKI2N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Oct 2021 04:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbhJKI2N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:28:13 -0400
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050F6C061745
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Oct 2021 01:26:12 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4HSX1t5y8BzMqJTT;
        Mon, 11 Oct 2021 10:26:10 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4HSX1q3sgfzlhNx5;
        Mon, 11 Oct 2021 10:26:07 +0200 (CEST)
Subject: Re: [PATCH v14 1/3] fs: Add trusted_for(2) syscall implementation and
 related sysctl
To:     Florian Weimer <fw@deneb.enyo.de>
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
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
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
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20211008104840.1733385-1-mic@digikod.net>
 <20211008104840.1733385-2-mic@digikod.net> <87tuhpynr4.fsf@mid.deneb.enyo.de>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <334a71c1-b97e-e52e-e772-a9003ec676c3@digikod.net>
Date:   Mon, 11 Oct 2021 10:26:58 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <87tuhpynr4.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 10/10/2021 16:10, Florian Weimer wrote:
> * Mickaël Salaün:
> 
>> Being able to restrict execution also enables to protect the kernel by
>> restricting arbitrary syscalls that an attacker could perform with a
>> crafted binary or certain script languages.  It also improves multilevel
>> isolation by reducing the ability of an attacker to use side channels
>> with specific code.  These restrictions can natively be enforced for ELF
>> binaries (with the noexec mount option) but require this kernel
>> extension to properly handle scripts (e.g. Python, Perl).  To get a
>> consistent execution policy, additional memory restrictions should also
>> be enforced (e.g. thanks to SELinux).
> 
> One example I have come across recently is that code which can be
> safely loaded as a Perl module is definitely not a no-op as a shell
> script: it downloads code and executes it, apparently over an
> untrusted network connection and without signature checking.
> 
> Maybe in the IMA world, the expectation is that such ambiguous code
> would not be signed in the first place, but general-purpose
> distributions are heading in a different direction with
> across-the-board signing:
> 
>   Signed RPM Contents
>   <https://fedoraproject.org/wiki/Changes/Signed_RPM_Contents>
> 
> So I wonder if we need additional context information for a potential
> LSM to identify the intended use case.
> 

This is an interesting use case. I think such policy enforcement could
be done either with an existing LSM (e.g. IMA) or a new one (e.g. IPE),
but it could also partially be enforced by the script interpreter. The
kernel should have enough context: interpreter process (which could be
dedicated to a specific usage) and the opened script file, or we could
add a new usage flag to the trusted_for syscall if that makes sense.
Either way, this doesn't seem to be an issue for the current patch series.
