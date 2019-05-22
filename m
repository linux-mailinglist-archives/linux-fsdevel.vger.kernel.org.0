Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 821EB26979
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 20:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbfEVSAu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 14:00:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727984AbfEVSAu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 14:00:50 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 150D220879;
        Wed, 22 May 2019 18:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558548049;
        bh=BxDX0zE1L2lxwEfQ+woGkz+Jj0htrytBtWDUBCKFkJg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ES4L+ZTD6Cn80MqE8XMxhaBcCNe/EHFTLQkFrZvnmUvxsoEtqn1PF7Ns9ZsacoDDj
         Q4ro29HJMPKD9jMQ1nMFcDVn2MKocWIev5dKr1V8P7hq3VTqLiaG3ePE2Bj96xS762
         TTKbovEV589SjZFddd5pCWHY1uSGHXvUoq0eFRro=
Date:   Wed, 22 May 2019 11:00:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jan Luebbe <jlu@pengutronix.de>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: report eip and esp for all threads when
 coredumping
Message-Id: <20190522110047.6bc80ca511a1425d8a069110@linux-foundation.org>
In-Reply-To: <20190522161614.628-1-jlu@pengutronix.de>
References: <20190522161614.628-1-jlu@pengutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 22 May 2019 18:16:14 +0200 Jan Luebbe <jlu@pengutronix.de> wrote:

> Commit 0a1eb2d474ed ("fs/proc: Stop reporting eip and esp in
> /proc/PID/stat") stopped reporting eip/esp and commit fd7d56270b52
> ("fs/proc: Report eip/esp in /prod/PID/stat for coredumping")
> reintroduced the feature to fix a regression with userspace core dump
> handlers (such as minicoredumper).
> 
> Because PF_DUMPCORE is only set for the primary thread, this didn't fix
> the original problem for secondary threads. This commit checks
> mm->core_state instead, as already done for /proc/<pid>/status in
> task_core_dumping(). As we have a mm_struct available here anyway, this
> seems to be a clean solution.
> 

Could we please have an explicit and complete description of the
end-user visible effect of this change?

It sounds like we should be backporting this into -stable but without
the above info it's hard to determine this.

