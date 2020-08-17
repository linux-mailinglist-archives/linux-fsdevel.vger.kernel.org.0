Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673E9247883
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Aug 2020 23:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgHQVKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Aug 2020 17:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbgHQVKe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:10:34 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B6EC061344
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 14:10:33 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v6so18989376iow.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2020 14:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9EHgQ35aySRkSWoSC1c8YoXvxP+pSzRq6wKj/4IiByU=;
        b=nmmwQZfsGfkcsu0U0Ge/azJVsybIs0DClANORjcuXseaUqE7xU+GmjDUWh/r3evgV0
         iCf4N4rUJ/lHnNv1sezXrO6BPt99zGhlgtbI0H11Du2J8TpbpWF15LXlQHfv0wVdyput
         lK+CBcoR8bkNtpNTY9p58zgpDkX4+O1osLkhB8U+7ipxNJuv95p1V6OODqVobJ4ex1Cw
         RS4dyyB0lbeb/bFYHWzhPaSPZ8CMOdoZz+osDuSeK7iBn3eFo0CWcKuIdexNMPX6rtZq
         DTQlaCU0W3DBG9cAz4hoMbKSurjuASDfWtAHe8HK1afMuQ1n2GoqFAB/exU2/c5Bzt9C
         uq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9EHgQ35aySRkSWoSC1c8YoXvxP+pSzRq6wKj/4IiByU=;
        b=r2zJVaXyHmB+4DZM6ifuO3CLime3MfR8z7mctMQMzr4vYGY9odmiGQkhhS6HGkBiHF
         t4jJHhGTUJSMaNEXR9E2jUFVPkvoVQOloPYNkE1TQyGEv6OITM3pA9vzuVwu6XZIKCx8
         4Z8f2BTUCPbofws6hYTHApDpwLbeW15YxDWPy+ABDcksr2vmwfTvy2V/xj21Ur2BNOpI
         KdR/IB3CjVmZ7PlL5Wi59Brhb7fzvilCk6tUtO1o4CMD5+F3ygAP08FPOnkhMQV1rOAt
         s1dyQBbvU3/2bEvU1oPI46jQOHKtmLL3TdrMmCf+HrNr1aAmb6NhNPSSux1wHIL6vR8f
         NJlA==
X-Gm-Message-State: AOAM530DZye+KK8UecggTYHjz8WY3BaavMKxcbcnidqIG3GgBRg7FyOf
        auZ0y7a5pwNJumgH90ZBmKhPspWi0s5qQRPpC3xDGw==
X-Google-Smtp-Source: ABdhPJxiFq3B8jlTT9x7nauQdsmNfihA1P3qjy444B4xcH0rdSqORKjG5/PBTkWaTxe+K+cHUMN2/QSg9zhjmrkuP9c=
X-Received: by 2002:a02:c84b:: with SMTP id r11mr16265122jao.66.1597698631501;
 Mon, 17 Aug 2020 14:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200807224941.3440722-1-lokeshgidra@google.com>
 <20200807224941.3440722-2-lokeshgidra@google.com> <20200807230225.GW1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200807230225.GW1236603@ZenIV.linux.org.uk>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Mon, 17 Aug 2020 14:10:20 -0700
Message-ID: <CA+EESO5kDbSCcpzxij6M0aWXqKDyFds+azksQFrXES6ACzTFtA@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] Add a new LSM-supporting anonymous inode interface
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Daniel Colascione <dancol@dancol.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Aaron Goidel <acgoide@tycho.nsa.gov>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Reber <areber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Kalesh Singh <kaleshsingh@google.com>,
        Calin Juravle <calin@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Nick Kralevich <nnk@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        kernel-team@android.com, Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 7, 2020 at 4:02 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Aug 07, 2020 at 03:49:39PM -0700, Lokesh Gidra wrote:
>
> > The new functions accept an optional context_inode parameter that
> > callers can use to provide additional contextual information to
> > security modules, e.g., indicating that one anonymous struct file is a
> > logical child of another, allowing a security model to propagate
> > security information from one to the other.
>
> What the hell is "logical child" and what are the lifetime rules implied
> by that relationship?

context_inode provides the security context required by the security
modules for granting/denying permission to create an anon inode of the
same type.

In case of userfaultfd, the relationship between the context_inode and
the created inode is described as that of =E2=80=98logical child=E2=80=99 b=
ecause the
context_inode (userfaultfd inode of the parent process) provides the
security context required for creation of child process=E2=80=99 userfaultf=
d
inode. But there is no relationship beyond this point. Therefore, no
reference to context_inode is held anywhere.
