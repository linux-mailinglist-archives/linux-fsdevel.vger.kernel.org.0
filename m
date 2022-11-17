Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9617262E72C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 22:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbiKQVmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 16:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiKQVmd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:42:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35737682A9;
        Thu, 17 Nov 2022 13:42:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C65A361E76;
        Thu, 17 Nov 2022 21:42:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9AEC433C1;
        Thu, 17 Nov 2022 21:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668721352;
        bh=e4gyaeZKuN5TuhPKWwkSBb9I05Kqo8fxxhIvbwmMql4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yu3InIqynn9YYcRssyMle8HVsrGC3Zgm+jhC+xr8d75RH6T7EqQHfvcORUScdh/KS
         89m/3vCXOBaNT49RVYtd9q+km/mQvtZApDgbGXSKNDg1X8scXWwYCNp4IJau7Ox2TO
         S7StpMn3WR9AI49TAQ+T7PjCZWuu2bVKbcQ310vY=
Date:   Thu, 17 Nov 2022 22:38:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] Add a new generic system call which has better
 performance, to get /proc data, than existing mechanisms
Message-ID: <Y3ap3KjiMEAF39t7@kroah.com>
References: <1668623844-9114-1-git-send-email-anjali.k.kulkarni@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668623844-9114-1-git-send-email-anjali.k.kulkarni@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:37:24AM -0800, Anjali Kulkarni wrote:
> Currently, reading from /proc is an expensive operation, for a
> performance sensitive application

Then perhaps "performance sensitive applications" should not be reading
10's of thousands of /proc files?

Anyway, your proposal comes up every few years, in different ways.
Please research the past proposals for why this keeps failing and
perhaps you should just fix up your userspace code instead?

Also, look at attempts like the introduction of the readfile syscall as
well, if you want to remove the open/read/close set of syscalls into
one, but even that isn't all that useful for real-world applications, as
you can today use the io_uring api to achieve almost the same throughput
if really needed.

good luck!

greg k-h
