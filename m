Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC836E6605
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Apr 2023 15:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjDRNdq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Apr 2023 09:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDRNdp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:33:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053C2119;
        Tue, 18 Apr 2023 06:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9675B627CD;
        Tue, 18 Apr 2023 13:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CF1C433D2;
        Tue, 18 Apr 2023 13:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681824823;
        bh=sjWpY/3U61yul+qc15kLmGATqsrOJGSxx5qfA1YBaS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQ0hX7PKh42SV7joQukUDGQJAFWaaq/N9XLnNVbWwWUn0lcgIoogeH0jEc1YV9m9G
         sslxqB5JbbNh7spKC56qvfRQpPon8m3FyPKldwIBH+VdDHhPokrgKqAmjw37XGXBvs
         eGVbUqaUi/Rb/9oNrtj5op5TL+JSuTkVPksKwjSW78myZGWlsU+FnWGgxnbDCXSinN
         /mshRzlcw+uewaLiqwq118fYio7/dTHgabaiLikGGjCgvH+0juzExUFtGScDZj07th
         baeVQZ5RyhIkJNUTX/9rddNMYKzBt88pLr6pz0cwrBCfIs4gHyB8Cbi1p7n3/VGJzc
         rZeec+rIKVMIw==
Date:   Tue, 18 Apr 2023 15:33:37 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH 0/2] Monitoring unmounted fs with fanotify
Message-ID: <20230418-diesmal-heimlaufen-ba2f2d1e1938@brauner>
References: <20230414182903.1852019-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230414182903.1852019-1-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 09:29:01PM +0300, Amir Goldstein wrote:
> Jan,
> 
> Followup on my quest to close the gap with inotify functionality,
> here is a proposal for FAN_UNMOUNT event.
> 
> I have had many design questions about this:

I'm going to humbly express what I feel makes sense to me when looking
at this from a user perspective:

> 1) Should we also report FAN_UNMOUNT for marked inodes and sb
>    on sb shutdown (same as IN_UNMOUNT)?

My preference would be if this would be a separate event type.
FAN_SB_SHUTDOWN or something.

> 2) Should we also report FAN_UNMOUNT on sb mark for any unmounts
>    of that sb?

I don't think so. It feels to me that if you watch an sb you don't
necessarily want to watch bind mounts of that sb.

> 3) Should we report also the fid of the mount root? and if we do...
> 4) Should we report/consider FAN_ONDIR filter?
> 
> All of the questions above I answered "not unless somebody requests"
> in this first RFC.

Fwiw, I agree.

> 
> Specifically, I did get a request for an unmount event for containers
> use case.
> 
> I have also had doubts regarding the info records.
> I decided that reporting fsid and mntid is minimum, but couldn't
> decide if they were better of in a single MNTID record or seprate
> records.
> 
> I went with separate records, because:
> a) FAN_FS_ERROR has set a precendent of separate fid record with
>    fsid and empty fid, so I followed this precendent
> b) MNTID record we may want to add later with FAN_REPORT_MNTID
>    to all the path events, so better that it is independent

I agree.

> 
> There is test for the proposed API extention [1].
> 
> Thoughts?

I think this is a rather useful extension!
