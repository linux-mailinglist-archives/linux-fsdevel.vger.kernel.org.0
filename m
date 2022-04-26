Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC34B510726
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 20:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352077AbiDZSiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 14:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352059AbiDZSit (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:38:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179EE69481;
        Tue, 26 Apr 2022 11:35:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD01DB82176;
        Tue, 26 Apr 2022 18:35:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA53C385A4;
        Tue, 26 Apr 2022 18:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650998138;
        bh=LLfQaXD6zblsRqwDSRDavx3nsCfqgP66QLeczMHK1bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ji0Pb8RjJE18ILSmq7qJALClfKSPpJocedCSddP9MF/uUbHXgFwE1u16X10TeeUyB
         G9AcouCLRBn/ASARpjcnXIVLaiLXxqpuRHGLgkb3u4hcuL3B0JEPlcKaXjbqY1CpHS
         NeuV4n9wH4L05xrXZBcHPFeZhMS9gprT6arRh8QU=
Date:   Tue, 26 Apr 2022 20:35:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Block Mailing List <linux-block@vger.kernel.org>,
        Linux Filesystem Mailing List <linux-fsdevel@vger.kernel.org>
Subject: Re: Race-free block device opening
Message-ID: <Ymg7dihxLG923vs3@kroah.com>
References: <Ymg2HIc8NGraPNbM@itl-email>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymg2HIc8NGraPNbM@itl-email>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 26, 2022 at 02:12:22PM -0400, Demi Marie Obenour wrote:
> Right now, opening block devices in a race-free way is incredibly hard.
> The only reasonable approach I know of is sd_device_new_from_path() +
> sd_device_open(), and is only available in systemd git main.  It also
> requires waiting on systemd-udev to have processed udev rules, which can
> be a bottleneck.  There are better approaches in various special cases,
> such as using device-mapper ioctls to check that the device one has
> opened still has the name and/or UUID one expects.  However, none of
> them works for a plain call to open(2).

Why do you call open(2) on a block device?

> A much better approach would be for udev to point its symlinks at
> "/dev/disk/by-diskseq/$DISKSEQ" for non-partition disk devices, or at
> "/dev/disk/by-diskseq/${DISKSEQ}p${PARTITION}" for partitions.

You can do that today with udev rules, right?

> A
> filesystem would then be mounted at "/dev/disk/by-diskseq" that provides
> for race-free opening of these paths.

How would it be any less race-free than just open("/dev/sda1") is?

> This could be implemented in
> userspace using FUSE, either with difficulty using the current kernel
> API, or easily and efficiently using a new kernel API for opening a
> block device by diskseq + partition.  However, I think this should be
> handled by the Linux kernel itself.
> 
> What would be necessary to get this into the kernel?

Get what exactly?  I don't see anything the kernel needs to do here
specifically.  Normally block devices are accessed using mount(2), not
open(2).  Do you want a new mount(2)-type api?

thanks,

greg k-h
