Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672BB215D0C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 19:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgGFRZp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 13:25:45 -0400
Received: from foss.arm.com ([217.140.110.172]:58314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729666AbgGFRZp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:25:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3030D6E;
        Mon,  6 Jul 2020 10:25:44 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF14C3F68F;
        Mon,  6 Jul 2020 10:25:43 -0700 (PDT)
Date:   Mon, 6 Jul 2020 18:25:41 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     viro@zeniv.linux.org.uk, mtk.manpages@gmail.com, shuah@kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close
 faster
Message-ID: <20200706172541.GG10992@arm.com>
References: <20200704140250.423345-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200704140250.423345-1-gregkh@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 04, 2020 at 04:02:46PM +0200, Greg Kroah-Hartman wrote:
> Here is a tiny new syscall, readfile, that makes it simpler to read
> small/medium sized files all in one shot, no need to do open/read/close.
> This is especially helpful for tools that poke around in procfs or
> sysfs, making a little bit of a less system load than before, especially
> as syscall overheads go up over time due to various CPU bugs being
> addressed.
> 
> There are 4 patches in this series, the first 3 are against the kernel
> tree, adding the syscall logic, wiring up the syscall, and adding some
> tests for it.
> 
> The last patch is agains the man-pages project, adding a tiny man page
> to try to describe the new syscall.

General question, using this series as an illustration only:


At the risk of starting a flamewar, why is this needed?  Is there a
realistic usecase that would get significant benefit from this?

A lot of syscalls seem to get added that combine or refactor the
functionality of existing syscalls without justifying why this is
needed (or even wise).  This case feels like a solution, not a
primitive, so I wonder if the long-term ABI fragmentation is worth the
benefit.

I ask because I'd like to get an idea of the policy on what is and is
not considered a frivolous ABI extension.

(I'm sure a usecase must be in mind, but it isn't mentioned here.
Certainly the time it takes top to dump the contents of /proc leaves
something to be desired.)

Cheers
---Dave
