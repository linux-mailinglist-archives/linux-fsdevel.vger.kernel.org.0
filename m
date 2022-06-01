Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7FA53A49A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 14:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344614AbiFAMMX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jun 2022 08:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351149AbiFAMMT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:12:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7E45B8A4
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jun 2022 05:12:17 -0700 (PDT)
Date:   Wed, 1 Jun 2022 14:12:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654085534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QaqibuInm4BGmD3xWgYCg2MHSGgP/lnUFI7cczc7H5Q=;
        b=SF1zkK1Q68GbhYPyLJXbZWjuFQJqUewMcOgBCRFf1PHI8Vi6TSWKEjL8nzdt/GAlNz2ufd
        KfxqcYOhg4fFFZNH9NqN0amw2WSt/CzC4dm3ptQapiGqyeEHZoXVjN5G6jfUiqlqfkO/eV
        WULsLIOHi088ykjTEFx0FjLX0p9HnMfmfhpfz+UHHLgT06UehRB5pQ2+JMZhh02a2iPPQz
        wS6dqLLKuSUW1F07445NwP2EvxOQJdk62L4jCUTnpy62uckaeWg+XObt5c2yvmu4tk6f8K
        wL7yTwKYwlp1K+/WNXdxzbLPaObtIt7h2M76tKef8tYNJ0QRQ6R9UdYt+LK9Ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654085534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QaqibuInm4BGmD3xWgYCg2MHSGgP/lnUFI7cczc7H5Q=;
        b=Op5Rsjo+c5CXvt1HhoXWK+DRYFxa+XxzMzXZFc3+pLoSl8+kASSZYEhostmqd7U1a9XxUo
        kh4PRlnnz0/tsWCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Performance testing of d_alloc_parallel().
Message-ID: <YpdXnCeopVRWy0UB@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I've been looking in to testing d_alloc_parallel() for correctness and
performance after making changes to it. I haven't found anything useful.

I hacked one .c file to fill a directory with other directories and then
I hacked another .c file to walk/ scan that directory with multiple
threads.  I don't see much wakes (due to DCACHE_PAR_LOOKUP) on shm. This
is different on xfs.
The runtime of the walk/ scan directory varies a lot so I can't spot a
difference between orig vs patched. On shm I have a span between 15 and
55 secs.
Any suggestions?

Sebastian
