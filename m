Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F681D71C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 09:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgERH04 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 03:26:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33318 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727033AbgERH0z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 03:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589786814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b/DaoBS5+cv0POCp9ooXqRzsTuOXn2M8MJgW8T9wUD0=;
        b=CxwDHCZ+31/rHf5KGQE7TxPXxDvXGm1R1Xh1RyIw78bafb9YU8sSe+1+HaB/DHMYyb6+Nu
        L9j4BWqbC8FjhQ+wzMADqGbRzrWBhOFL4dt6vWguOP+HE5fACh+DgCqjXsxs247YT2qr0P
        eEHsN1NZpYPwSu7sUltTD414IHUdZjM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-dXOuRvKLNjK0fPagzimQ0g-1; Mon, 18 May 2020 03:26:49 -0400
X-MC-Unique: dXOuRvKLNjK0fPagzimQ0g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 771CA56C8E;
        Mon, 18 May 2020 07:26:44 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-142.ams2.redhat.com [10.36.112.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C4A910013D9;
        Mon, 18 May 2020 07:26:36 +0000 (UTC)
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
References: <202005131525.D08BFB3@keescook> <202005132002.91B8B63@keescook>
        <CAEjxPJ7WjeQAz3XSCtgpYiRtH+Jx-UkSTaEcnVyz_jwXKE3dkw@mail.gmail.com>
        <202005140830.2475344F86@keescook>
        <CAEjxPJ4R_juwvRbKiCg5OGuhAi1ZuVytK4fKCDT_kT6VKc8iRg@mail.gmail.com>
        <b740d658-a2da-5773-7a10-59a0ca52ac6b@digikod.net>
        <202005142343.D580850@keescook>
        <87a729wpu1.fsf@oldenburg2.str.redhat.com>
        <202005150732.17C5EE0@keescook>
        <87r1vluuli.fsf@oldenburg2.str.redhat.com>
        <202005150847.2B1ED8F81@keescook>
Date:   Mon, 18 May 2020 09:26:34 +0200
In-Reply-To: <202005150847.2B1ED8F81@keescook> (Kees Cook's message of "Fri,
        15 May 2020 08:50:16 -0700")
Message-ID: <87ftbxg0ut.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Kees Cook:

> I think I misunderstood what you meant (Micka=C3=83=C2=ABl got me sorted =
out
> now). If O_EXEC is already meant to be "EXEC and _not_ READ nor WRITE",
> then yes, this new flag can't be O_EXEC. I was reading the glibc
> documentation (which treats it as a permission bit flag, not POSIX,
> which treats it as a complete mode description).

I see.  I think this part of the manual is actually very Hurd-specific
(before the O_ACCMODE description).  I'll see if I can make this clearer
in the markup.

Thanks,
Florian

