Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA944526A87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 21:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383889AbiEMTis (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 15:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383863AbiEMTil (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 15:38:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4676FA23;
        Fri, 13 May 2022 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=50oUJFS0CRaiUG2nXdYJz1eNDp24nYsSSOfImyNmLXQ=; b=rDJw8YY6/2qoi7Wd2z9/ax2QMp
        iWpd03mz287Ld+1+eDdTzp+dch0/xHjGAiIQ1I1o/8Fv+mMBYxEkI/WUkOGHJDL+ijzT1E2O9lfHo
        alrCDczA4yj3BF+NU0rgcvoFlNQMZxf+yy0YlWc+8Uw3uoSi7YeY/tYt0nxb5AN+RZ2nN8ATbmmsz
        YIrlezogmRxoX5w7OBkHTytnaZDZ8WAoK1NwqLnEZlmPHQt80ag/nTgHqnG4URw3l+Z/v1HqbK4o4
        7qUnbhtRizTpKfrkd4amsggqB3UsZ6aEflt4UIcRTtJ9UwIyN7+6iNloeNgmgf5ATBWN7Dkmp7odM
        Djr2DPQA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1npb7T-00HM21-Kz; Fri, 13 May 2022 19:38:35 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     patches@lists.linux.dev, amir73il@gmail.com, pankydev8@gmail.com,
        tytso@mit.edu, josef@toxicpanda.com, jmeneghi@redhat.com,
        jake@lwn.net, mcgrof@kernel.org
Subject: [PATCH 3/4] playbooks: add a common playbook a git reset task for kdevops
Date:   Fri, 13 May 2022 12:38:30 -0700
Message-Id: <20220513193831.4136212-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513193831.4136212-1-mcgrof@kernel.org>
References: <20220513193831.4136212-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Two playbooks share the concept of git cloning kdevops into
the target nodes (guests, cloud hosts, baremetal hosts) so that
expunge files can be used for avoiding tests. If you decide
you want to change the URL for that git tree it may not be
so obvious what to do.

Fortunately the solution is simple. You just tell ansible to use
the new git tree URL. That's it. It won't remove the old directory
and things work as expected.

But since we use the kdevops git tree on both fstests and blktests
it is not so obvious to developers that the thing to do here is
to just run 'make fstests' or 'make blktests' and even that is not
as efficient as that will also re-clone the fstests or blktests
tree respectively. When we just want to reset the kdevops git tree
we currently have no semantics to specify that. But since this is
a common post-deployment goal, just add a common playbook that let's
us do common tasks.

All we need then is the kconfig logic to define when some commmon
tasks might make sense. So to reset your kdevops git tree, all you
have to do now is change the configuration for it, then run:

make
make kdevops-git-reset

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kconfigs/workflows/Kconfig               |  4 +++
 playbooks/common.yml                     |  4 +++
 playbooks/roles/common/README.md         | 38 ++++++++++++++++++++++++
 playbooks/roles/common/defaults/main.yml |  7 +++++
 playbooks/roles/common/tasks/main.yml    | 23 ++++++++++++++
 workflows/common/Makefile                | 12 ++++++++
 6 files changed, 88 insertions(+)
 create mode 100644 playbooks/common.yml
 create mode 100644 playbooks/roles/common/README.md
 create mode 100644 playbooks/roles/common/defaults/main.yml
 create mode 100644 playbooks/roles/common/tasks/main.yml

diff --git a/kconfigs/workflows/Kconfig b/kconfigs/workflows/Kconfig
index 7f71470..817335b 100644
--- a/kconfigs/workflows/Kconfig
+++ b/kconfigs/workflows/Kconfig
@@ -175,6 +175,10 @@ source "workflows/blktests/Kconfig"
 endmenu
 endif # KDEVOPS_WORKFLOW_ENABLE_BLKTESTS
 
+config KDEVOPS_WORKFLOW_GIT_CLONES_KDEVOPS_GIT
+	bool
+	default y if KDEVOPS_WORKFLOW_ENABLE_FSTESTS || KDEVOPS_WORKFLOW_ENABLE_BLKTESTS
+
 endif # WORKFLOWS_LINUX_TESTS
 
 endif # WORKFLOWS_TESTS
diff --git a/playbooks/common.yml b/playbooks/common.yml
new file mode 100644
index 0000000..48485e3
--- /dev/null
+++ b/playbooks/common.yml
@@ -0,0 +1,4 @@
+---
+- hosts: all
+  roles:
+    - role: common
diff --git a/playbooks/roles/common/README.md b/playbooks/roles/common/README.md
new file mode 100644
index 0000000..2b0084c
--- /dev/null
+++ b/playbooks/roles/common/README.md
@@ -0,0 +1,38 @@
+common
+======
+
+The common role lets you add tasks which is commmon to all workflows.
+Without this we would be duplicating code.
+
+Requirements
+------------
+
+None.
+
+Role Variables
+--------------
+
+  * kdevops_git_reset: perform a git reset. This is useful in case you want
+	to change the URL you use for kdevops.
+
+Dependencies
+------------
+
+None.
+
+Example Playbook
+----------------
+
+Below is an example playbook task:
+
+```
+---
+- hosts: all
+  roles:
+    - role: common
+```
+
+License
+-------
+
+copyleft-next-0.3.1
diff --git a/playbooks/roles/common/defaults/main.yml b/playbooks/roles/common/defaults/main.yml
new file mode 100644
index 0000000..69cd0af
--- /dev/null
+++ b/playbooks/roles/common/defaults/main.yml
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier copyleft-next-0.3.1
+---
+
+kdevops_data: "/data/kdevops"
+kdevops_git: "https://github.com/linux-kdevops/kdevops.git"
+
+kdevops_git_reset: False
diff --git a/playbooks/roles/common/tasks/main.yml b/playbooks/roles/common/tasks/main.yml
new file mode 100644
index 0000000..4482349
--- /dev/null
+++ b/playbooks/roles/common/tasks/main.yml
@@ -0,0 +1,23 @@
+---
+- name: Import optional extra_args file
+  include_vars: "{{ item }}"
+  ignore_errors: yes
+  with_first_found:
+    - files:
+      - "../extra_vars.yml"
+      - "../extra_vars.yaml"
+      - "../extra_vars.json"
+      skip: true
+  tags: vars
+
+# Distro agnostic stuff goes below
+
+- name: git reset kdevops
+  environment:
+    GIT_SSL_NO_VERIFY:  true
+  git:
+    repo: "{{ kdevops_git }}"
+    dest: "{{ kdevops_data }}"
+  tags: [ 'kdevops_reset']
+  when:
+    - kdevops_git_reset|bool
diff --git a/workflows/common/Makefile b/workflows/common/Makefile
index da21d78..6596ed1 100644
--- a/workflows/common/Makefile
+++ b/workflows/common/Makefile
@@ -32,3 +32,15 @@ WORKFLOW_ARGS	+= data_user=$(WORKFLOW_DATA_USER)
 WORKFLOW_ARGS	+= data_group=$(WORKFLOW_DATA_GROUP)
 
 endif # CONFIG_WORKFLOW_INFER_USER_AND_GROUP == y
+
+ifeq (y,$(CONFIG_KDEVOPS_WORKFLOW_GIT_CLONES_KDEVOPS_GIT))
+kdevops-git-reset:
+	$(Q)ansible-playbook -f 30 -i hosts playbooks/common.yml --tags vars,kdevops_reset --extra-vars '{ kdevops_git_reset: True }' $(LIMIT_HOSTS)
+
+kdevops-help-menu:
+	@echo "Common workflow options:"
+	@echo "kdevops-git-reset:                      - Resets your kdevops git tree URL and contents on guests"
+	@echo
+
+HELP_TARGETS += kdevops-help-menu
+endif # CONFIG_KDEVOPS_WORKFLOW_GIT_CLONES_KDEVOPS_GIT
-- 
2.35.1

