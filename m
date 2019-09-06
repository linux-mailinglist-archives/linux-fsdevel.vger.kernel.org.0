Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAFCDABF8D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 20:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406112AbfIFSoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 14:44:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41070 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406106AbfIFSoO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:44:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 350D018CE073;
        Fri,  6 Sep 2019 18:44:13 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-27.ams2.redhat.com [10.36.116.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 93B9C60BF1;
        Fri,  6 Sep 2019 18:44:05 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
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
        <f53ec45fd253e96d1c8d0ea6f9cca7f68afa51e3.camel@kernel.org>
        <1fbf54f6-7597-3633-a76c-11c4b2481add@ssi.gouv.fr>
        <5a59b309f9d0603d8481a483e16b5d12ecb77540.camel@kernel.org>
Date:   Fri, 06 Sep 2019 20:44:03 +0200
In-Reply-To: <5a59b309f9d0603d8481a483e16b5d12ecb77540.camel@kernel.org> (Jeff
        Layton's message of "Fri, 06 Sep 2019 14:38:11 -0400")
Message-ID: <87r24tcljg.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Fri, 06 Sep 2019 18:44:13 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Jeff Layton:

> Even better would be to declare the new flag in some openat2-only flag
> space, so there's no confusion about it being supported by legacy open
> calls.

Isn't that desirable anyway because otherwise fcntl with F_GETFL will
give really confusing results?

> If glibc wants to implement an open -> openat2 wrapper in userland
> later, it can set that flag in the wrapper implicitly to emulate the old
> behavior.

I see us rather doing the opposite, i.e. implement openat2 with
non-exotic flags using openat.  But we've bitten by this in the past, so
maybe that's not such a great idea.  It's tempting to make the same
mistake again for every new system call.

Thanks,
Florian
