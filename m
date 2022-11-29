Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782F663BDF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Nov 2022 11:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiK2KZd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Nov 2022 05:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiK2KZa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Nov 2022 05:25:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E894465E9;
        Tue, 29 Nov 2022 02:25:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8444E6163F;
        Tue, 29 Nov 2022 10:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06EDC433C1;
        Tue, 29 Nov 2022 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669717528;
        bh=NRLOmsfk8MrlF1SeO7QI1ZOUGcEP+Ip9WU2MdOCjcug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s97XJIDU33XGp3tUD24wXGXpMjRJgBmr07n1ALZnbsLTy/bzUO1QW/bGcjjn1ZWex
         F8B8x0uV1KYOmnkNhppoZ9zQs/gghkNr6v1St7N6mJ8VAeT1bwIHYvcJ92pcxhP4c6
         syEJ61xoeB5BqaU2U4VGNc5lFLvPwBeC8QLbxRj+oNRvwfnXrVk0iarxooOBkvnHm1
         u1J9lN8fZ/saHqpg6fEGujOyffXPKCxklGPlPIUT7rK/QKqBob++wCNTL6WXTEoa4Q
         9vpXF1PEXp/EDt8zez7Ze121wbtIExGUokR8Pfuly/Tu1KfzjWvfU4X4suWCn6/TtF
         CJbAUJVviEQ4w==
Date:   Tue, 29 Nov 2022 11:25:24 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     ditang chen <ditang.c@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com
Subject: Re: fs/pnode.c: propagate_one Oops in ltp/fs_bind test
Message-ID: <20221129102524.ulsthvmf6tbfwhmb@wittgenstein>
References: <CAHnGgyHAo+XQPchU4HaKshFbnyHYuD0EuHy17QvPRAZ4MFVq-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHnGgyHAo+XQPchU4HaKshFbnyHYuD0EuHy17QvPRAZ4MFVq-w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 15, 2022 at 11:04:01PM +0800, ditang chen wrote:
> Here is a reproducer:
> 1. Run netns.sh script in loop
> # while true; do ./netns.sh; done
> # cat netns.sh
> #!/bin/bash
> num=1000
> function create_netns()
> {
> for((i=0; i<$num; i++))
> do
>   ip netns add local$i
>   ip netns exec local$i pwd &
> done
> }
> function clean_netns()
> {
> for((i=0; i<$num; i++))
> do
>     ip netns del local$i
> done
> }
> create_netns
> clean_netns
> 
> 2.  run fs_bind/fs_bind24 in loop, fs_bind24 only
> # cat /opt/ltp/runtest/fs_bind
> #DESCRIPTION:Bind mounts and shared subtrees
> fs_bind24_sh fs_bind24.sh
> # while true; do /opt/ltp/runltp -f fs_bind; done
> 
> This oops also exists in the latest kernel code：

I've been running this since yesterday on v6.1-rc7 to reproduce and it
didn't trigger. It's unclear whether you're saying that you've managed
to reproduce this on mainline. It doesn't seem to be.
