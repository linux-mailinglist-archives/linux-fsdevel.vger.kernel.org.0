Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB17ABFDC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 20:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390887AbfIFSuH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Fri, 6 Sep 2019 14:50:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37016 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388320AbfIFSuH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:50:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4364610C0930;
        Fri,  6 Sep 2019 18:50:06 +0000 (UTC)
Received: from x2.localnet (ovpn-117-48.phx2.redhat.com [10.3.117.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2E5D60BF1;
        Fri,  6 Sep 2019 18:50:02 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
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
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Add support for O_MAYEXEC
Date:   Fri, 06 Sep 2019 14:50:02 -0400
Message-ID: <2989749.1YmIBkDdQn@x2>
Organization: Red Hat
In-Reply-To: <20190906152455.22757-1-mic@digikod.net>
References: <20190906152455.22757-1-mic@digikod.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Fri, 06 Sep 2019 18:50:06 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday, September 6, 2019 11:24:50 AM EDT Mickaël Salaün wrote:
> The goal of this patch series is to control script interpretation.  A
> new O_MAYEXEC flag used by sys_open() is added to enable userspace
> script interpreter to delegate to the kernel (and thus the system
> security policy) the permission to interpret/execute scripts or other
> files containing what can be seen as commands.

The problem is that this is only a gentleman's handshake. If I don't tell the
kernel that what I'm opening is tantamount to executing it, then the security
feature is never invoked. It is simple to strip the flags off of any system
call without needing privileges. For example:

#define _GNU_SOURCE
#include <link.h>
#include <fcntl.h>
#include <string.h>

unsigned int
la_version(unsigned int version)
{
    return version;
}

unsigned int
la_objopen(struct link_map *map, Lmid_t lmid, uintptr_t *cookie)
{
    return LA_FLG_BINDTO | LA_FLG_BINDFROM;
}

typedef int (*openat_t) (int dirfd, const char *pathname, int flags, mode_t mode);
static openat_t real_openat = 0L;
int my_openat(int dirfd, const char *pathname, int flags, mode_t mode)
{
        flags &= ~O_CLOEXEC;
        return real_openat(dirfd, pathname, flags, mode);
}

uintptr_t
la_symbind64(Elf64_Sym *sym, unsigned int ndx, uintptr_t *refcook,
        uintptr_t *defcook, unsigned int *flags, const char *symname)
{
    if (real_openat == 0L && strcmp(symname, "openat") == 0) {
        real_openat = (openat_t) sym->st_value;
        return (uintptr_t) my_openat;
    }
    return sym->st_value;
}

gcc -c -g -Wno-unused-parameter -W -Wall -Wundef -O2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fPIC  test.c
gcc -o strip-flags.so.0 -shared -Wl,-soname,strip-flags.so.0 -ldl test.o

Now, let's make a test program:

#include <stdio.h>
#include <dirent.h>
#include <fcntl.h>
#include <unistd.h>

int main(void)
{
        int dir_fd, fd;
        DIR *d = opendir("/etc");
        dir_fd = dirfd(d);
        fd = openat(dir_fd, "passwd", O_RDONLY|O_CLOEXEC);
        close (fd);
        closedir(d);
        return 0;
}

gcc -g -W -Wall -Wundef test.c -o test

OK, let's see what happens.
$ strace ./test 2>&1 | grep passwd
openat(3, "passwd", O_RDONLY|O_CLOEXEC) = 4

Now with LD_AUDIT
$ LD_AUDIT=/home/sgrubb/test/openflags/strip-flags.so.0 strace ./test 2>&1 | grep passwd
openat(3, "passwd", O_RDONLY)           = 4

No O_CLOEXEC flag.

-Steve


