Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C6322211E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 13:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgGPLHc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 07:07:32 -0400
Received: from foss.arm.com ([217.140.110.172]:58250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbgGPLHc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:07:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6390A1063;
        Thu, 16 Jul 2020 04:07:31 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D620B3F68F;
        Thu, 16 Jul 2020 04:07:28 -0700 (PDT)
From:   Qais Yousef <qais.yousef@arm.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 2/3] Documentation/sysctl: Document uclamp sysctl knobs
Date:   Thu, 16 Jul 2020 12:03:46 +0100
Message-Id: <20200716110347.19553-3-qais.yousef@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716110347.19553-1-qais.yousef@arm.com>
References: <20200716110347.19553-1-qais.yousef@arm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Uclamp exposes 3 sysctl knobs:

	* sched_util_clamp_min
	* sched_util_clamp_max
	* sched_util_clamp_min_rt_default

Document them in sysctl/kernel.rst.

Signed-off-by: Qais Yousef <qais.yousef@arm.com>
CC: Jonathan Corbet <corbet@lwn.net>
CC: Juri Lelli <juri.lelli@redhat.com>
CC: Vincent Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ben Segall <bsegall@google.com>
CC: Mel Gorman <mgorman@suse.de>
CC: Luis Chamberlain <mcgrof@kernel.org>
CC: Kees Cook <keescook@chromium.org>
CC: Iurii Zaikin <yzaikin@google.com>
CC: Quentin Perret <qperret@google.com>
CC: Valentin Schneider <valentin.schneider@arm.com>
CC: Patrick Bellasi <patrick.bellasi@matbug.net>
CC: Pavan Kondeti <pkondeti@codeaurora.org>
CC: linux-doc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-fsdevel@vger.kernel.org
---
 Documentation/admin-guide/sysctl/kernel.rst | 54 +++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 83acf5025488..55bf6b4de4ec 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1062,6 +1062,60 @@ Enables/disables scheduler statistics. Enabling this feature
 incurs a small amount of overhead in the scheduler but is
 useful for debugging and performance tuning.
 
+sched_util_clamp_min:
+=====================
+
+Max allowed *minimum* utilization.
+
+Default value is 1024, which is the maximum possible value.
+
+It means that any requested uclamp.min value cannot be greater than
+sched_util_clamp_min, i.e., it is restricted to the range
+[0:sched_util_clamp_min].
+
+sched_util_clamp_max:
+=====================
+
+Max allowed *maximum* utilization.
+
+Default value is 1024, which is the maximum possible value.
+
+It means that any requested uclamp.max value cannot be greater than
+sched_util_clamp_max, i.e., it is restricted to the range
+[0:sched_util_clamp_max].
+
+sched_util_clamp_min_rt_default:
+================================
+
+By default Linux is tuned for performance. Which means that RT tasks always run
+at the highest frequency and most capable (highest capacity) CPU (in
+heterogeneous systems).
+
+Uclamp achieves this by setting the requested uclamp.min of all RT tasks to
+1024 by default, which effectively boosts the tasks to run at the highest
+frequency and biases them to run on the biggest CPU.
+
+This knob allows admins to change the default behavior when uclamp is being
+used. In battery powered devices particularly, running at the maximum
+capacity and frequency will increase energy consumption and shorten the battery
+life.
+
+This knob is only effective for RT tasks which the user hasn't modified their
+requested uclamp.min value via sched_setattr() syscall.
+
+This knob will not escape the range constraint imposed by sched_util_clamp_min
+defined above.
+
+For example if
+
+	sched_util_clamp_min_rt_default = 800
+	sched_util_clamp_min = 600
+
+Then the boost will be clamped to 600 because 800 is outside of the permissible
+range of [0:600]. This could happen for instance if a powersave mode will
+restrict all boosts temporarily by modifying sched_util_clamp_min. As soon as
+this restriction is lifted, the requested sched_util_clamp_min_rt_default
+will take effect.
 
 seccomp
 =======
-- 
2.17.1

