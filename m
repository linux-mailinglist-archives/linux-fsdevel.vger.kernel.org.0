Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437172A6E86
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Nov 2020 21:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731492AbgKDUHR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Nov 2020 15:07:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:50374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727991AbgKDUHR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Nov 2020 15:07:17 -0500
Received: from gmail.com (unknown [104.132.1.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EE7220759;
        Wed,  4 Nov 2020 20:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604520435;
        bh=/KxEHYgp71/ldR6Q6v/198vdd/J27KB6R/yLwRxvdHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sMTdq2/JvXaoj6ioI59IfzGg+6h/K/RuZTjVhSyPvLS/M8m+Rxlu2JLIWkn788SR3
         s7EG8t9sMlRSBCVayPVdoWbJjvnm8ejMmPoj52tmJsfGYtb1SY/Jda4EcOCXuYN01k
         NhpVRHTGMoQrcZUeyOA5TumQe8awYGmol7L66rgg=
Date:   Wed, 4 Nov 2020 12:07:01 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
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
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        kaleshsingh@google.com, calin@google.com, surenb@google.com,
        nnk@google.com, jeffv@google.com, kernel-team@android.com
Subject: Re: [PATCH v10 0/3] SELinux support for anonymous inodes and UFFD
Message-ID: <20201104200701.GA1796392@gmail.com>
References: <20201011082936.4131726-1-lokeshgidra@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201011082936.4131726-1-lokeshgidra@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 11, 2020 at 01:29:33AM -0700, Lokesh Gidra wrote:
> Daniel Colascione (3):
>   Add a new LSM-supporting anonymous inode interface
>   Teach SELinux about anonymous inodes
>   Use secure anon inodes for userfaultfd

Patches are supposed to have subsystem prefixes, e.g.

	fs, security: add a new LSM-supporting anonymous inode interface
	selinux: implement init_security_anon()
	userfaultfd: use secure anon inodes

... but that points to the fact that the first one is really both fs and
security subsystem changes.  Patches should be one logical change only.  I
suggest splitting it up into:

	security: add init_security_anon() LSM hook
	fs: add anon_inode_getfd_secure()

- Eric
