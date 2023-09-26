Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991167AEF14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 16:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjIZOYi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Sep 2023 10:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjIZOYh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:24:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E5711D;
        Tue, 26 Sep 2023 07:24:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE21C433C7;
        Tue, 26 Sep 2023 14:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695738270;
        bh=AGmApwbQmIMmG0oLetKtfvZYkM3UfT/XuoVKlgBv2Aw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WPublGIKbp5ROVPQyMjOEr+CjBt2gY3B+PkvEJ/FwIWKm2lTO1pzNxMfSXZB5ytAV
         7U0zBTk603j0EMU51eY9tP+B8IjLvSzbb0B9jTLKDJzzdEpS1tjTA4Bvp5M6v9Sx5m
         wOuUoBniyXB9WKNE4zZppTdhJd69CkXyTiyX/363egTe2DsZ4lGJh5obYfJG00GEp7
         hTz8mNRn0vfegJyKx5cJ+C0bHjbIHsFzLmciajwSMvBSMhSStRJQHusvJNxyWk8w57
         X4TpqJVUSqDZZgXaUi7pfK9cFYAwyrN50NjRbbtvAjhDnvjNE1P859zNWEOCc1bTSu
         OWcMoMBBSyKmA==
Date:   Tue, 26 Sep 2023 16:24:26 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH] vfs: shave work on failed file open
Message-ID: <20230926-worum-angezapft-5c3f7770ad29@brauner>
References: <20230925205545.4135472-1-mjguzik@gmail.com>
 <20230926-anforderungen-obgleich-47e465f0bd47@brauner>
 <CAGudoHG0-BWTVRG8uZk5Gy8xSwpT8JO5Z=VfY3_dFcCaqhLf5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGudoHG0-BWTVRG8uZk5Gy8xSwpT8JO5Z=VfY3_dFcCaqhLf5Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > if (WARN_ON_ONCE(atomic_long_cmpxchg(&file->f_count, 1, 0) != 1)) {

> bench again.

Can you see how much of a difference it makes because imho it really
looks a lot nicer then this ugly atomic_read followed by atomic_set...
