Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFEB2C50E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 13:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfE1LDZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 07:03:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55986 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfE1LDZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 07:03:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44A8E307B963;
        Tue, 28 May 2019 11:03:25 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-154.ams2.redhat.com [10.36.116.154])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C1D0A1B479;
        Tue, 28 May 2019 11:03:21 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] [RFC] Remove bdflush syscall stub
References: <20190528101012.11402-1-chrubis@suse.cz>
        <mvmr28idgfu.fsf@linux-m68k.org> <20190528104017.GA11969@rei>
Date:   Tue, 28 May 2019 13:03:20 +0200
In-Reply-To: <20190528104017.GA11969@rei> (Cyril Hrubis's message of "Tue, 28
        May 2019 12:40:18 +0200")
Message-ID: <87ftoyg7t3.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 28 May 2019 11:03:25 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Cyril Hrubis:

> Hi!
>> > I've tested the patch on i386. Before the patch calling bdflush() with
>> > attempt to tune a variable returned 0 and after the patch the syscall
>> > fails with EINVAL.
>> 
>> Should be ENOSYS, doesn't it?
>
> My bad, the LTP syscall wrapper handles ENOSYS and produces skipped
> results based on that.
>
> EINVAL is what you get for not yet implemented syscalls, i.e. new
> syscall on old kernel.

EINVAL?  Is that a bdflush-specific thing, test-specific, or is itmore
general?

glibc has fallback paths that test for ENOSYS only.  EINVAL will be
passed to the application, skipping fallback.  For missing system calls,
this is not what we want.

Thanks,
Florian
