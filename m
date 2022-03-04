Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599224CE07C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 23:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiCDW5z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 17:57:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiCDW5s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 17:57:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC9122FD92
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Mar 2022 14:56:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FF7861E92
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Mar 2022 22:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34ECC340E9;
        Fri,  4 Mar 2022 22:56:56 +0000 (UTC)
Date:   Fri, 4 Mar 2022 17:56:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Dynamic allocation of pseudo file systems
Message-ID: <20220304175655.055dcdde@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At the 2021 Linux Plumbers Tracing Microconference there was a discussionon creating just-in-time dentrys for pseudo file systems (the tracing one
was about the events directory in tracefs).

https://lpc.events/event/11/contributions/1085/attachments/855/1668/Eventfs_split_v15.pdf

https://www.youtube.com/watch?v=jsxuVI7Wav0&list=PLVsQ_xZBEyN3wA8Ej4BUjudXFbXuxhnfc&t=7561s

At the microconference there was also interest in extending this to other
pseudo file systems like /sys and /proc. The rationale for this is due to
the fact that the dentrys take up a lot of memory, and there's no reason to
have them if nobody is looking at them. Having a way to create them at the
time the user looks at/enters the directory would save quite a bit. But
there may be issues. What happens if there's no memory to allocate?

Our focus was on just working with the tracefs file system, but I would
like to discuss how we could make this into a generic feature that any
pseudo file system can use, and discuss what issues could arise by it, and
how to mitigate those issues.

Sorry, for the delay in posting. I understand that the deadline has just
passed, but starting a new job had caused me to not pay attention and I
missed it. Hopefully, you can still consider this.

-- Steve
