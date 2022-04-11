Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D754FB9B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 12:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345562AbiDKKdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 06:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345554AbiDKKdn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:33:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74E6434B5
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Apr 2022 03:31:29 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 661601F864;
        Mon, 11 Apr 2022 10:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649673088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cgghYed79d8cnZRVoEnkhx35HqYqQUiYpLquOT7z1hA=;
        b=wQIWNN5p4NTFMj5yglfmDyA5KOKYksglgfqivoYrG2GNUtlHPSryYBIKnB5Vw8gJeBdp2M
        cFSlUAigBNMjszbf46jO76xN1pvVcuVaKSlS42CoDIiWtULKnxEGeU2YuccEAGb1/4GXd8
        u7YPGBM1fFLViwBlDumflU5EKc60DhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649673088;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cgghYed79d8cnZRVoEnkhx35HqYqQUiYpLquOT7z1hA=;
        b=RMCpgnwfhOxSs0+TI79quhlQwT+VTBP6kndDxOSlbh3iJDrxzQrKNcpPF+atxN8TIRP32t
        XTyVdW0cnH/E+4BQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 48CD0A3B87;
        Mon, 11 Apr 2022 10:31:28 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 970E6A061B; Mon, 11 Apr 2022 12:31:22 +0200 (CEST)
Date:   Mon, 11 Apr 2022 12:31:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 06/16] fsnotify: create helpers for group mark_mutex
 lock
Message-ID: <20220411103122.3pofkcv7qoghe3f5@quack3.lan>
References: <20220329074904.2980320-1-amir73il@gmail.com>
 <20220329074904.2980320-7-amir73il@gmail.com>
 <20220407143552.c6cddwtus6eaut2j@quack3.lan>
 <CAOQ4uxi1MFjyGT84RCfgjyanuLCKq+G630ufx1J69RQXCygPbg@mail.gmail.com>
 <CAOQ4uxgxgoPaT_Gk3CA+i+6+EDiSmrV45F+AQ133tAakYOG0qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgxgoPaT_Gk3CA+i+6+EDiSmrV45F+AQ133tAakYOG0qQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 08-04-22 11:38:59, Amir Goldstein wrote:
> On Thu, Apr 7, 2022 at 5:53 PM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Thu, Apr 7, 2022 at 5:35 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 29-03-22 10:48:54, Amir Goldstein wrote:
> > > > Create helpers to take and release the group mark_mutex lock.
> > > >
> > > > Define a flag FSNOTIFY_GROUP_NOFS in fsnotify backend operations struct
> > > > that determines if the mark_mutex lock is fs reclaim safe or not.
> > > > If not safe, the nofs lock helpers should be used to take the lock and
> > > > disable direct fs reclaim.
> > > >
> > > > In that case we annotate the mutex with different lockdep class to
> > > > express to lockdep that an allocation of mark of an fs reclaim safe group
> > > > may take the group lock of another "NOFS" group to evict inodes.
> > > >
> > > > For now, converted only the callers in common code and no backend
> > > > defines the NOFS flag.  It is intended to be set by fanotify for
> > > > evictable marks support.
> > > >
> > > > Suggested-by: Jan Kara <jack@suse.cz>
> > > > Link: https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > A few design question here:
> > >
> > > 1) Why do you store the FSNOTIFY_GROUP_NOFS flag in ops? Sure, this
> > > particular flag is probably going to be the same per backend type but it
> > > seems a bit strange to have it in ops instead of in the group itself...
> >
> > I followed the pattern of struct file_system_type.
> > I didn't think per-group NOFS made much sense,
> > so it was easier this way.

I see. Yes, if they are unmutable, the having them in ops is probably fine.
But I'd rename them to say 'features' to better explain they are unmutable.

> > > 2) Why do we have fsnotify_group_nofs_lock() as well as
> > > fsnotify_group_lock()? We could detect whether we should set nofs based on
> > > group flag anyway. Is that so that callers don't have to bother with passing
> > > around the 'nofs'? Is it too bad? We could also store the old value of
> > > 'nofs' inside the group itself after locking it and then unlock can restore
> > > it without the caller needing to care about anything...
> >
> > Yes because it created unneeded code.
> > storing the local thread state in the group seems odd...
> >
> 
> I followed your suggestions and the result looks much better.
> Pushed result to fan_evictable branch.

Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
