Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9019B4C7A3E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Feb 2022 21:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiB1UXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 15:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiB1UXD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 15:23:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651E055769;
        Mon, 28 Feb 2022 12:22:23 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D7774219A9;
        Mon, 28 Feb 2022 20:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646079741;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oaQvqY4GoekZ9bgVKvzwIOdOIWHcpeaoY1uSN8b1alc=;
        b=fkruWtvRz782Mz2BDJR85/7POkbBd6TfvOPyYXc7aqLq9li28v91LVhjZDW1shF5u2F5Z7
        R5C74HsbTtOBQlrUr8y++/o5bNyqNjb5buTFXUAFIejX2OvAldN/U0ZdmlCkYsNhXC/MZJ
        Sj5vOUEMdheUUWQ/o0brUgJl0MlwRAs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646079741;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oaQvqY4GoekZ9bgVKvzwIOdOIWHcpeaoY1uSN8b1alc=;
        b=ZlsAY6uxY63DJKaIY9pXQy3XvICHN1PJz0nRtdV+z1/kD6SsRvEAfvLb6nvj87AtzNjnzx
        vdovD5+06FwbOKAQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id A4A80A3B8C;
        Mon, 28 Feb 2022 20:22:21 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 6DA0ADA823; Mon, 28 Feb 2022 21:18:30 +0100 (CET)
Date:   Mon, 28 Feb 2022 21:18:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v3 2/2] btrfs: zoned: mark relocation as writing
Message-ID: <20220228201830.GK12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>
References: <cover.1645157220.git.naohiro.aota@wdc.com>
 <01fa2ddededefc7f03ca4d6df2cccfdbf550aa26.1645157220.git.naohiro.aota@wdc.com>
 <20220223103107.GM12643@twin.jikos.cz>
 <20220224021558.eubg4agqnkkodkd6@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224021558.eubg4agqnkkodkd6@naota-xeon>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 24, 2022 at 02:15:58AM +0000, Naohiro Aota wrote:
> On Wed, Feb 23, 2022 at 11:31:07AM +0100, David Sterba wrote:
> > On Fri, Feb 18, 2022 at 01:14:19PM +0900, Naohiro Aota wrote:
> It looks like this occurs when the balance is resumed. We also need
> sb_{start,end}_write around btrfs_balance() in balance_kthred().
> 
> I guess we can cause a hang if we resume the balance and freeze the FS
> at the same time.

We need to fix the missing write protection before the asserts can be
added, so I'll delete them from this patch and will submit the helpers
patch once after we have fixed all.
