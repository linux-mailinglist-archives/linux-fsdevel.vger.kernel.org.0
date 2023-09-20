Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE33A7A88EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbjITPuh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 11:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbjITPuf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:50:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5C7A9
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 08:50:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956AEC433C7;
        Wed, 20 Sep 2023 15:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695225029;
        bh=fNOIa4AwYPwOiPQW1qLtza71veQaUdwgs8Qi2wKUv9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BltX6ytK1KuYR+WWrFhxRt4hL2eX+rFX80xHN728pjU3BAepyK/nif0rIGSpoHWhw
         6m4XJ04AVATNAzIqcO/Q370fM/EX8LadlIXNxR7DNR1Maz5k3/KZRKvSgOPyET4BJ7
         FQ5kb3KTIkdrnQrDJw1SrVQZLhXdgCVPra8QmY9v4aKrHMxgKIuZ8oOQo8Pxpor8LU
         pHlTUXy/yVMNOMSH8BZWty0jqHrS9xC3PrB09HhcqzMNrEglt08GRz/jEECkV+RCoN
         LXe++N0rODtJBoqdT5k/BOKOnddbxXYkXNJHTqF+rvaovUSndsFCv2MW4mzkX4tKAL
         J98ctjem5Gldg==
Date:   Wed, 20 Sep 2023 17:50:26 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: When to lock pipe->rd_wait.lock?
Message-ID: <20230920-kabine-senden-e1a137f3d7cc@brauner>
References: <CAKPOu+-49kBuSExvrV7kfcZWbUsy_OdpuPW1hAv6ZtT98UiQFA@mail.gmail.com>
 <20230920-macht-rupfen-96240ce98330@brauner>
 <CAKPOu+9uO=wbTnesZ-jCw5E+AY1fwvcXykBtEQYOzHTyEeP_8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+9uO=wbTnesZ-jCw5E+AY1fwvcXykBtEQYOzHTyEeP_8g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 20, 2023 at 05:21:03PM +0200, Max Kellermann wrote:
> On Wed, Sep 20, 2023 at 3:30 PM Christian Brauner <brauner@kernel.org> wrote:
> > Afaict, the mutex is sufficient protection unless you're using
> > watchqueues which use post_one_notification() that cannot acquire the
> > pipe mutex. Since splice operations aren't supported on such kernel
> > notification pipes - see get_pipe_info() - it should be unproblematic.
> 
> Which means that the spinlocks can safely be removed from
> pipe_write(), because they are unnecessary overhead?

I don't think so, O_NOTIFICATION/watch queue pipes allow userspace to
use pipe_read() and pipe_write() but prevent the usage of splice. The
spinlock is there for post_one_notification() which is called from
kernel context.
