Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB9860C69C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 10:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiJYIhN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 04:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiJYIhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:37:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5D34505D
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 01:37:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEB36B818C7
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 08:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7198C433D6;
        Tue, 25 Oct 2022 08:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666687026;
        bh=GB1TG7LkedEnHyYAdacEbVV7vQ0BzroKJsdE0caV5T4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k2G8+X8hARXwlyd4RgHwed38XzjgBpYD0rsA+Z+AkScdipYSvsqxMmYYoIUQcAcSf
         W6xdxTT0a8gtnKK4situwHk2n9L8JVkwZBph2hIP5F5Z4qmtgYUCaGXxa91bIO+4K+
         PgJXFP4j24dhAWILSTWV4J7LRg6T0uQshuVlTs4fxL0OUm6DeoD5SMQ3SWk8brp/R3
         /PNmaIcGpStNt1RwQYLGqDDt3f4SGORyy9GGR/2EerQ26IgQOY5Y7UGfXvGrvL1WIt
         qLYr+GFA1VRQRhOEuwnPaahNILV2ar5FSd+z5L6rLEkOTl3YNMi5qDvg4aTXEzD45P
         4D8qhd/s4JG1w==
Date:   Tue, 25 Oct 2022 10:37:01 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Seth Forshee <sforshee@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [apparmor] [PATCH 4/8] apparmor: use type safe idmapping helpers
Message-ID: <20221025083701.cgaqrcett4frvq3f@wittgenstein>
References: <20221024111249.477648-1-brauner@kernel.org>
 <20221024111249.477648-5-brauner@kernel.org>
 <5ae36c94-18dd-2f7a-b5f4-3c2122415dc7@canonical.com>
 <20221025074427.jjfx4sa2kl7w5ua5@wittgenstein>
 <bd085a0c-543a-c67d-b1a3-c9ee891893eb@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd085a0c-543a-c67d-b1a3-c9ee891893eb@canonical.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 25, 2022 at 01:30:10AM -0700, John Johansen wrote:
> On 10/25/22 00:44, Christian Brauner wrote:
> > On Tue, Oct 25, 2022 at 12:16:02AM -0700, John Johansen wrote:
> > > On 10/24/22 04:12, Christian Brauner wrote:
> > > > We already ported most parts and filesystems over for v6.0 to the new
> > > > vfs{g,u}id_t type and associated helpers for v6.0. Convert the remaining
> > > > places so we can remove all the old helpers.
> > > > This is a non-functional change.
> > > > 
> > > > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > > 
> > > Acked-by: John Johansen <john.johansen@canonical.com>
> > 
> > Would you mind if I carry this patch together with the other conversion
> > patches in my tree? This would make the whole conversion a lot simpler
> > because we're removing a bunch of old helpers at the end.
> 
> Not at all. I almost asked which tree you wanted it in, and then got
> distracted and when I came back to it ...

Thank you! I appreciate it.
