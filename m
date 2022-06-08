Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD37542D83
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 12:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237056AbiFHKY7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 06:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237390AbiFHKYT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:24:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EB31153
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 03:14:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E088D1F37C;
        Wed,  8 Jun 2022 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654683287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+ZZuVnBnzdGmUPh6zDCG1yHu7D3u37yZv8OVQIBr9Q=;
        b=VkDpqL4pTYeWeTLo8i10Rz/WMt+734jUUThFfnN9XzZRIuIVwTUmA7aiLPkVuv/VjRdz8+
        yL9hJiUSUJ+ulNbkMUg23EB2qP+/pOUOvfbl9i7Lqu5tVUud4z7W7KQrll8gyy4tPtu23g
        thPwHgDYFUBQ5TfSiAVTEVW3MKkcy2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654683287;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R+ZZuVnBnzdGmUPh6zDCG1yHu7D3u37yZv8OVQIBr9Q=;
        b=MuB33uzlTYUlwTe2NgsVEvjc55tg33nN2MFyjN7lDPPgrL9+SaJYeZL27InCMyT2TYmpvh
        av39IXu3yd1JhlBA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D545B2C141;
        Wed,  8 Jun 2022 10:14:47 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5E021A06E2; Wed,  8 Jun 2022 12:14:46 +0200 (CEST)
Date:   Wed, 8 Jun 2022 12:14:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gal Rosen <gal.rosen@cybereason.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: Failed on reading from FANOTIFY file descriptor
Message-ID: <20220608101446.hocvxqolyt762bxf@quack3.lan>
References: <CAJ-MHhCyDB576-vpcJuazyrO-4Q1UuTprD88pdd0WRzjOx8ptQ@mail.gmail.com>
 <CAOQ4uxj=Cd=R7oj4i3vE+VNcpWGD3W=NpqBu8E09K205W-CTAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj=Cd=R7oj4i3vE+VNcpWGD3W=NpqBu8E09K205W-CTAA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 08-06-22 12:00:23, Amir Goldstein wrote:
> On Wed, Jun 8, 2022 at 11:31 AM Gal Rosen <gal.rosen@cybereason.com> wrote:
> >
> > Hi Jack,
> >
> > Can you provide details on the reason I sometimes get read errors on events that I get from FANOTIFY ?
> > My user space program watches on all mount points in the system and sometimes when in parallel I run full scan with another application on all my files in the endpoint, I get a read error when trying to read from the FANOTIFY fd on a new event.
> > The errno is sometimes EPERM (Operation not permitted) and sometimes EMFILE (Too many open files).
> >
> 
> Hi Gal,
> 
> EPERM is a bit surprising assuming that your process has CAP_SYS_ADMIN,
> so needs investigating, but EMFILE is quite obvious.
> Every event read needs to open a fd to place in event->fd.
> If you exceed your configured limit, this error is expected.
> You can bump the limit as CAP_SYS_ADMIN if that helps.

Correct. I want to add that the file descriptor is open when reading the
event from the kernel and the application that read the event is
responsible for closing the file descriptor. So it is the number of events
received by your application for which received fd has not been closed yet
that matters.

And EPERM error is indeed surprising. Is some security policy (SELinux?) in
place that could deny open?
							Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
