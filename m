Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1702E2D6257
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Dec 2020 17:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392296AbgLJQpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Dec 2020 11:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391974AbgLJQpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:45:16 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5811C0613CF;
        Thu, 10 Dec 2020 08:44:36 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id e2so4725809pgi.5;
        Thu, 10 Dec 2020 08:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6r1VxP3lNmxiqtfsbEsJwybOwIKpVa3l9EOS4rtjIs=;
        b=R7SPHjgpg3mP/LQaoFtEybdof/xGXKUQhbGXAzB8JUBBjkWGfZONAmSRbN6l7NsVi8
         p9SKNHE+1DnSBrogmA47RzMIqfhkHZnCCU3q/ire6iTMdTo5bofepmC5PAmUAR/2jPqc
         fw276Oh/1X1U4E/a3YW5mL6M7V5TFnKtXPx3ur6UvYUKDJ1fW+APIMKbfKVYnKbMCbKI
         dvmN+Z5vXtHVoUgxaJqzjfwW1yeb6BkpALggrv4Z+TfdLNHp9ap6JTCqKywEuBnjcE5w
         XNTO6kyX55AQY+GYVpyjfruFvkmHLezhFM93QkQS556o3O2Uy8KG/6VlwUrNV1tUe6NN
         kDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6r1VxP3lNmxiqtfsbEsJwybOwIKpVa3l9EOS4rtjIs=;
        b=UCp7Hwt6l4OCQDV7zxTt00uLkGR7TeqsARGbEmC/nyzs5b1wQsTYyQXjxu207i+taF
         98ckWG7YaV4pl/2Jb6XCn26gN6ixsjIgqeJFmjiofTtQaAWEKdyQh+YE6/PN+TRdLuPc
         ZV8/Ae+RdWpcPoUps3NzpGy/JerTkvmoU76++96xnzpJLLDDS3xq1JXcPNcytYUNw+1k
         aDHTI86NIg5cB5g81jbJmhHPZap142Q8/2ympZR3UIu8RewqeoX3oaQsEHk0NG9UHahK
         D7AUsgLqrDyWfDI/M1prWtXqccQRjQ5fpSC/0RUP5vkMtjG7ViMs8XywSKppv+9OSqsj
         Rkbg==
X-Gm-Message-State: AOAM532r0vJ44LfFjnutDZF29EKLfPCQu2ThWw1by5RZO2t6VKPpnLUM
        KrVdEIjXxucyfRywkpWJKEjJjKmuorbs47rsfhE=
X-Google-Smtp-Source: ABdhPJxsLeER9ZJbzr5nparyCDipcH7OlJcAWiIYmYBDTkjmVzuNtxhwf7u1BNqMy/MmQRxrbiWHsg==
X-Received: by 2002:aa7:92c7:0:b029:197:e36f:fc5c with SMTP id k7-20020aa792c70000b0290197e36ffc5cmr7562994pfa.62.1607618676320;
        Thu, 10 Dec 2020 08:44:36 -0800 (PST)
Received: from cl-arch-kdev.. (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id k129sm6867175pgk.1.2020.12.10.08.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:44:35 -0800 (PST)
From:   Fox Chen <foxhlchen@gmail.com>
To:     raven@themaw.net
Cc:     akpm@linux-foundation.org, dhowells@redhat.com,
        gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, miklos@szeredi.hu,
        ricklind@linux.vnet.ibm.com, sfr@canb.auug.org.au, tj@kernel.org,
        viro@ZenIV.linux.org.uk, Fox Chen <foxhlchen@gmail.com>
Subject: RE:[PATCH v2 0/6] kernfs: proposed locking and concurrency improvement
Date:   Thu, 10 Dec 2020 16:44:23 +0000
Message-Id: <20201210164423.9084-1-foxhlchen@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I found this series of patches solves exact the problem I am trying to solve.
https://lore.kernel.org/lkml/20201202145837.48040-1-foxhlchen@gmail.com/

The problem is reported by Brice Goglin on thread:
Re: [PATCH 1/4] drivers core: Introduce CPU type sysfs interface
https://lore.kernel.org/lkml/X60dvJoT4fURcnsF@kroah.com/

I independently comfirmed that on a 96-core AWS c5.metal server.
Do open+read+write on /sys/devices/system/cpu/cpu15/topology/core_id 1000 times.
With a single thread it takes ~2.5 us for each open+read+close.
With one thread per core, 96 threads running simultaneously takes 540 us 
for each of the same operation (without much variation) -- 200x slower than the 
single thread one. 

My Benchmark code is here:
https://github.com/foxhlchen/sysfs_benchmark

The problem can only be observed in large machines (>=16 cores).
The more cores you have the slower it can be.

Perf shows that CPUs spend most of the time (>80%) waiting on mutex locks in 
kernfs_iop_permission and kernfs_dop_revalidate.

After applying this, performance gets huge boost -- with the fastest one at ~30 us 
to the worst at ~180 us (most of on spin_locks, the delay just stacking up, very
similar to the performance on ext4). 

I hope this problem can justifies this series of patches. A big mutex in kernfs
is really not nice. Due to this BIG LOCK, concurrency in kernfs is almost NONE,
even though you do operations on different files, they are contentious.

As we get more and more cores on normal machines and because sysfs provides such
important information, this problem should be fix. So please reconsider accepting
the patches.

For the patches, there is a mutex_lock in kn->attr_mutex, as Tejun mentioned here 
(https://lore.kernel.org/lkml/X8fe0cmu+aq1gi7O@mtj.duckdns.org/), maybe a global 
rwsem for kn->iattr will be better??



thanks,
fox

