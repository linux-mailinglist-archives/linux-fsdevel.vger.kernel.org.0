Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4FAF1038A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 12:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfKTLXF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 06:23:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56398 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfKTLXF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 06:23:05 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iXO4N-0005RU-Kd; Wed, 20 Nov 2019 12:22:47 +0100
Date:   Wed, 20 Nov 2019 12:22:46 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Chen Yu <yu.c.chen@intel.com>
cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chen Yu <yu.chen.surf@gmail.com>
Subject: Re: [PATCH][v3] x86/resctrl: Add task resctrl information display
In-Reply-To: <20191120081628.26701-1-yu.c.chen@intel.com>
Message-ID: <alpine.DEB.2.21.1911201055260.6731@nanos.tec.linutronix.de>
References: <20191120081628.26701-1-yu.c.chen@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 20 Nov 2019, Chen Yu wrote:
> Monitoring tools that want to find out which resctrl CTRL
> and MONITOR groups a task belongs to must currently read
> the "tasks" file in every group until they locate the process
> ID.
> 
> Add an additional file /proc/{pid}/resctrl to provide this
> information.
> 
> For example:
>  cat /proc/1193/resctrl
> CTRL_MON:/ctrl_grp0
> MON:/ctrl_grp0/mon_groups/mon_grp0

The formatting is quite ugly and I don't see why this needs to be multiple
lines and have these uppercase prefixes.

A task can only be part of one control group and of one monitoring group
which is associated to the control group. So just providing:

 1)   ""
 2)   "/"
 3)   "/mon_groups/mon0"
 4)   "/group0"
 5)   "/group0/mon_groups/mon1"

is simple and clear enough, i.e.:

#1: Resctrl is not available

#2: Task is part of the root group, task not associated to any monitoring
    group

#3: Task is part of the root group and monitoring group mon0

#4: Task is part of control group group0, task not associated to any
    monitoring group

#5: Task is part of control group group0 and monitoring group mon1

Hmm?

Thanks,

	tglx
