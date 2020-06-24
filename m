Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52330207609
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 16:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404040AbgFXOsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 10:48:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38827 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404026AbgFXOst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:48:49 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jo6hi-0006cf-MW; Wed, 24 Jun 2020 14:48:46 +0000
Date:   Wed, 24 Jun 2020 16:48:46 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>
Subject: overlayfs regression
Message-ID: <20200624144846.jtpolkxiqmery3uy@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Miklosz,
hey Amir,

We've been observing regressions in our containers test-suite with
commit:

Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Tue Mar 17 15:04:22 2020 +0100

    ovl: separate detection of remote upper layer from stacked overlay

    Following patch will allow remote as upper layer, but not overlay stacked
    on upper layer.  Separate the two concepts.

    This patch is doesn't change behavior.

    Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

It suddenly consistently reports:
[2422.695340] overlayfs: filesystem on '/home/lxcunpriv/.local/share/lxc/c2/overlay/delta' not supported as upperdir
in dmesg where it used to work fine for basically 6 years when we added
that test. The test creates a container c2 that uses the rootfs of
another container c1 (normal directory on an ext4 filesystem). Here you
can see the full mount options:

Invalid argument - Failed to mount "/home/lxcunpriv/.local/share/lxc/c1/rootfs" on "/usr/lib/x86_64-linux-gnu/lxc" with options "upperdir=/home/lxcunpriv/.local/share/lxc/c2/overlay/delta,lowerdir=/home/lxcunpriv/.local/share/lxc/c1/rootfs,workdir=/home/lxcunpriv/.local/share/lxc/c2/overlay/work"

Thanks!
Christian
