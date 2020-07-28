Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8B9230B97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 15:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbgG1Nk2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 09:40:28 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55330 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbgG1Nk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:40:28 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k0Pq5-0004Om-5K; Tue, 28 Jul 2020 13:40:17 +0000
Date:   Tue, 28 Jul 2020 15:40:15 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Steven Sistare <steven.sistare@oracle.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, peterz@infradead.org, esyr@redhat.com,
        jgg@ziepe.ca, christian@kellner.me, areber@redhat.com,
        cyphar@cyphar.com, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Message-ID: <20200728134015.tmjy5hy4xden2v5h@wittgenstein>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <87pn8glwd2.fsf@x220.int.ebiederm.org>
 <28125570-4129-bcba-099b-f90481cfbfe8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <28125570-4129-bcba-099b-f90481cfbfe8@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 02:00:17PM -0400, Steven Sistare wrote:
> On 7/27/2020 1:07 PM, ebiederm@xmission.com wrote:
> > Anthony Yznaga <anthony.yznaga@oracle.com> writes:
> > 
> >> This patchset adds support for preserving an anonymous memory range across
> >> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
> >> sharing memory in this manner, as opposed to re-attaching to a named shared
> >> memory segment, is to ensure it is mapped at the same virtual address in
> >> the new process as it was in the old one.  An intended use for this is to
> >> preserve guest memory for guests using vfio while qemu exec's an updated
> >> version of itself.  By ensuring the memory is preserved at a fixed address,
> >> vfio mappings and their associated kernel data structures can remain valid.
> >> In addition, for the qemu use case, qemu instances that back guest RAM with
> >> anonymous memory can be updated.
> > 
> > What is wrong with using a file descriptor to a possibly deleted file
> > and re-mmaping it?
> > 
> > There is already MAP_FIXED that allows you to ensure you have the same
> > address.
> 
> MAP_FIXED blows away any existing mapping in that range, which is not the 
> desired behavior.  We want to preserve the previously created mapping at

There's also MAP_FIXED_NOREPLACE since v4.17 in case that helps.

Note that this should really go to linux-api too. I won't argue to
resend it since that would mean spamming everyone's inbox with the same
thread again but in case you send a revised version, please ensure to Cc
linux-api. The glibc folks are listening on there too.

Thanks!
Christian
