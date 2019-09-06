Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC2DAC030
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 21:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392548AbfIFTHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 15:07:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729131AbfIFTHX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:07:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0877830860BF;
        Fri,  6 Sep 2019 19:07:23 +0000 (UTC)
Received: from x2.localnet (ovpn-117-48.phx2.redhat.com [10.3.117.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A44560BF7;
        Fri,  6 Sep 2019 19:07:20 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
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
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Philippe =?ISO-8859-1?Q?Tr=E9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Steve Dower <steve.dower@python.org>,
        Thibaut S autereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Add support for O_MAYEXEC
Date:   Fri, 06 Sep 2019 15:07:19 -0400
Message-ID: <1802966.yheqmZt8Si@x2>
Organization: Red Hat
In-Reply-To: <87mufhckxv.fsf@oldenburg2.str.redhat.com>
References: <20190906152455.22757-1-mic@digikod.net> <2989749.1YmIBkDdQn@x2> <87mufhckxv.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 06 Sep 2019 19:07:23 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday, September 6, 2019 2:57:00 PM EDT Florian Weimer wrote:
> * Steve Grubb:
> > Now with LD_AUDIT
> > $ LD_AUDIT=/home/sgrubb/test/openflags/strip-flags.so.0 strace ./test
> > 2>&1 | grep passwd openat(3, "passwd", O_RDONLY)           = 4
> > 
> > No O_CLOEXEC flag.
> 
> I think you need to explain in detail why you consider this a problem.

Because you can strip the O_MAYEXEC flag from being passed into the kernel. 
Once you do that, you defeat the security mechanism because it never gets 
invoked. The issue is that the only thing that knows _why_ something is being 
opened is user space. With this mechanism, you can attempt to pass this 
reason to the kernel so that it may see if policy permits this. But you can 
just remove the flag.

-Steve

> With LD_PRELOAD and LD_AUDIT, you can already do anything, including
> scanning other loaded objects for a system call instruction and jumping
> to that (in case a security module in the kernel performs a PC check to
> confer additional privileges).
> 
> Thanks,
> Florian




