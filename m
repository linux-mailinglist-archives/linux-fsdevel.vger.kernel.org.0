Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F83E275EF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 19:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgIWRoj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 13:44:39 -0400
Received: from relay.sw.ru ([185.231.240.75]:43134 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbgIWRoj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:44:39 -0400
Received: from [172.16.25.93] (helo=amikhalitsyn-pc0.sw.ru)
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <alexander.mikhalitsyn@virtuozzo.com>)
        id 1kL7uf-000qjf-JQ; Wed, 23 Sep 2020 19:46:37 +0300
From:   Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
To:     viro@zeniv.linux.org.uk
Cc:     avagin@gmail.com,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] fsopen: fsconfig syscall restart fix
Date:   Wed, 23 Sep 2020 19:46:35 +0300
Message-Id: <20200923164637.13032-1-alexander.mikhalitsyn@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi guys!

Sometimes ago our CRIU CI started reporting hardly-reproducible (on developer
environment) error "EBUSY" from fsconfig syscall in the CRIU cgroups code.
https://github.com/checkpoint-restore/criu/blob/criu-dev/criu/cgroup.c#L585
The machine on which we caught this problem is PowerPC (POWER8). After tracing
and debugging that we realized that problem is that we get ERESTARTNOINR
from vfs_get_tree function in vfs_fsconfig_locked. After a more deep
investigation, we found that the source is cgroup1_get_tree() and
restart_syscall() at the end. I personally have no idea why we caught this only
on POWER8 VM and have no such problem on amd64. But anyway this is incorrect
behaviour and our patch should fix this problem and make this impossible on all
architectures.

Big thanks to Andrei Vagin. He helped me a lot to fully understand the
problem and prepare this patch.

Regards, Alex

Alexander Mikhalitsyn (1):
  fsopen: fsconfig syscall restart fix

 fs/fsopen.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

-- 
2.25.1

