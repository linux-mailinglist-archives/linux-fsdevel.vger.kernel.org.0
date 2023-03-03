Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEC56A8FE3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Mar 2023 04:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjCCD3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 22:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCCD3q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 22:29:46 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA93193D5;
        Thu,  2 Mar 2023 19:29:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9FE96CE1FCA;
        Fri,  3 Mar 2023 03:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE13C433EF;
        Fri,  3 Mar 2023 03:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677814181;
        bh=jGTitR1qTs9jt5skebaqYkkUPvmYqulmF/6G7GKH/Gk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVLVJFvz6KrHPuSUbWWh3QHfKd0mUo5k1HBRURzHeUCUt2EgfhfuaRpZpEc1WnSCs
         /e9iY9HL+jNHpQgLFjyrMVqfE8w3aCryG1tyjJ2G5oVCSnJzmOJV4swhwftj9E9Hc2
         Z2n7nEDdmml9VTjigxN2Zdsn0DiBYYgPYPN2lvrVvMftV6QEt9155s2k8zasSZ2mEN
         Wu3XjbnnUDVS6441MZPeu93Zbr20Yogghm0NSevUSbKUNbc0IT1RKoXOAp+94GNEVk
         NQoii7DTski890DrFV0Ae6Ti472NsqPbpppjWjNflf03NQHVqkvZIBzMt1Hk9hSnft
         cvtEDUkZh9lzw==
Date:   Thu, 2 Mar 2023 20:29:38 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <ZAFpokeFjyalHK7Q@kbusch-mbp.dhcp.thefacebook.com>
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <yq1356mh925.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1356mh925.fsf@ca-mkp.ca.oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 09:54:59PM -0500, Martin K. Petersen wrote:
> > For example, most cloud storage devices are doing read-ahead to try to
> > anticipate read requests from the VM.  This can interfere with the
> > read-ahead being done by the guest kernel.  So being able to tell
> > cloud storage device whether a particular read request is stemming
> > from a read-ahead or not.
> 
> Indeed. In our experience the hints that work best are the ones which
> convey to the storage device why the I/O is being performed.

This may be a pretty far-out-there idea, but I think SSD BPF injection has
potentially higher payoff than mere hints. The below paper does it in kernel,
but imagine doing it on the device!

  https://dl.acm.org/doi/pdf/10.1145/3458336.3465290
