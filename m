Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4677155E3E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345392AbiF1M4V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiF1M4U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:56:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BA72F660;
        Tue, 28 Jun 2022 05:56:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0EBF221D92;
        Tue, 28 Jun 2022 12:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656420978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HQpmIWQFU9OmoJCom9hzgNgWeE9U0h1oakBUN2acOpQ=;
        b=YM3Tsk3hYjZADSgcEQ9J/eR8a4jN2gluFHTrBdZH1YwLaFMqQibtqGUO3McbcB+FR/l9Er
        NLWOGJGgQ0JnliGGZbdfpr/91wxrNa2Th+0sJeN9XzniRI2e8Rk5o1y7nq1TUQRb7LdsWu
        LN8Md1yfkZf6q5WjHgnJsknkDRCfkJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656420978;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HQpmIWQFU9OmoJCom9hzgNgWeE9U0h1oakBUN2acOpQ=;
        b=Yq5DlDoB7FEPF2YfF4UKA1Nf/y+8pTrwo2zJ05NTIKzh26KtihHDpS30D3QvkIn+wI4a6g
        Vev6cdl3p7U/vcCA==
Received: from quack3.suse.cz (dhcp194.suse.cz [10.100.51.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BDC522C141;
        Tue, 28 Jun 2022 12:56:17 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 96B44A062F; Tue, 28 Jun 2022 14:56:17 +0200 (CEST)
Date:   Tue, 28 Jun 2022 14:56:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     guowei du <duguoweisz@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        duguowei <duguowei@xiaomi.com>
Subject: Re: [PATCH 6/6] fanotify: add current_user_instances node
Message-ID: <20220628125617.pljcpsr2xkzrrpxr@quack3>
References: <20220628101413.10432-1-duguoweisz@gmail.com>
 <20220628104528.no4jarh2ihm5gxau@quack3>
 <20220628104853.c3gcsvabqv2zzckd@wittgenstein>
 <CAC+1NxtAfbKOcW1hykyygScJgN7DsPKxLeuqNNZXLqekHgsG=Q@mail.gmail.com>
 <CAOQ4uxgtZDihnydqZ04wjm2XCYjui0nnkO0VGzyq-+ERW20pJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgtZDihnydqZ04wjm2XCYjui0nnkO0VGzyq-+ERW20pJw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 28-06-22 15:29:08, Amir Goldstein wrote:
> On Tue, Jun 28, 2022 at 2:50 PM guowei du <duguoweisz@gmail.com> wrote:
> >
> > hi, Mr Kara, Mr Brauner,
> >
> > I want to know how many fanotify readers are monitoring the fs event.
> > If userspace daemons monitoring all file system events are too many, maybe there will be an impact on performance.
> 
> I want something else which is more than just the number of groups.
> 
> I want to provide the admin the option to enumerate over all groups and
> list their marks and blocked events.

Listing all groups and marks makes sense to me. Often enough I was
extracting this information from a crashdump :).

Dumping of events may be a bit more challenging (especially as we'd need to
format the events which has some non-trivial implications) so I'm not 100%
convinced about that. I agree it might be useful but I'd have to see the
implementation...

> This would be similar to listing all the fdinfo of anon_inode:[fanotify] fds
> of processes that initialised fanotify groups.
> 
> This enumeration could be done for example in /sys/fs/fanotify/groups/
> 
> My main incentive is not only the enumeration.
> My main incentive is to provide an administrative interface to
> check for any fs operations that are currently blocked by a rogue
> fanotify permission events reader and an easy way for administrators
> to kill those rogue processes (i.e. buggy anti-malware).
> 
> This interface is inspired by the ability to enumerate and abort
> fuse connections for rogue fuse servers.
> 
> I want to do that for the existing permission events as a prerequisite
> to adding new blocking events to be used for implementation of
> hierarchical storage managers, similar the Windows ProjFs [1].
> This was allegedly the intended use case for group class
> FAN_CLASS_PRE_CONTENT (see man page).

Yes, that was the original intent of FAN_CLASS_PRE_CONTENT AFAIK.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
