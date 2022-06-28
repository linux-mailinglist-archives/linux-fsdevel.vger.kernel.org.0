Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A5355C33B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 14:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbiF1KtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 06:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344294AbiF1KtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:49:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05596542;
        Tue, 28 Jun 2022 03:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88ED861956;
        Tue, 28 Jun 2022 10:48:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342C9C3411D;
        Tue, 28 Jun 2022 10:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656413338;
        bh=Ies8xD4MNzwqAy7s3L9C80SB0LLsY4MfQVpuud1nUR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sho2JGuocQWyYW/atWP2zOlT+kjh2jxM7WQuzYQUMtGSHOTamoQ+dW6bugHXOUxev
         50ePWfdZS2DliAAFYeDLWHJT35b8XZDPGH/qNtS4C9D1DzIdaXI9erQ/mudwoqUF+z
         ORLvlEuVY9ZkATyeD/Bb1qdqdvcFxcY3fG7JnacnRqFEXHkXt9WYsZ5MtoOps6zcoX
         l+a9otQ4QYAMfoYsEg4NiJX4iOluhBpyRsw9vqk2nOqYGXmIClpxTrOMw0Rjk9k6rQ
         If3yJ/B3aCmnyS77roy3CFQgO1deO0UtkmaQ5Ocppp4tmjVhiY+r22V/Exvdrwa6bS
         b0kp7BCsvgBHw==
Date:   Tue, 28 Jun 2022 12:48:53 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Guowei Du <duguoweisz@gmail.com>, amir73il@gmail.com,
        repnop@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, duguowei <duguowei@xiaomi.com>
Subject: Re: [PATCH 6/6] fanotify: add current_user_instances node
Message-ID: <20220628104853.c3gcsvabqv2zzckd@wittgenstein>
References: <20220628101413.10432-1-duguoweisz@gmail.com>
 <20220628104528.no4jarh2ihm5gxau@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220628104528.no4jarh2ihm5gxau@quack3>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 28, 2022 at 12:45:28PM +0200, Jan Kara wrote:
> On Tue 28-06-22 18:14:13, Guowei Du wrote:
> > From: duguowei <duguowei@xiaomi.com>
> > 
> > Add a node of sysctl, which is current_user_instances.
> > It shows current initialized group counts of system.
> > 
> > Signed-off-by: duguowei <duguowei@xiaomi.com>
> 
> Hum, I'm not sure about a wider context here but the changelog is certainly
> missing a motivation of this change - why do you need this counter? In
> particular because we already do maintain (and limit) the number of
> fanotify groups each user has allocated in a particular namespace...

Yeah, that's pretty strange as there's
/proc/sys/user/max_fanotify_groups
/proc/sys/user/max_fanotify_marks
it could be to have a ro counter that allows to display the current
number of groups? But that seems strange as we don't expose that
information anywhere for similar things. What would this be used for
even?
