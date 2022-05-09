Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E9251F911
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 12:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbiEIJxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 05:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiEIJs2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 05:48:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8725217704F
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 02:44:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 43BE91F9F5;
        Mon,  9 May 2022 09:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652089473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qCOMxsP6gXawwX6fmMzR64svAoIIp5nPZ8/UcSs6oY0=;
        b=al2W1I6sn3aY+rMlH2WsihRNjbUmA31AUz4mvm8S0yfTLLJ/3/KUF+spebIou45LS1nnkt
        bn3mhln9JYmp07bzjtChiWfvH8UeZDJ/u2xRrW7bXKVilHx8WxX4+Zb/lUruCGrFl0cGgE
        F2tnuPA6LKACr5bxfQsA5HKnTNyMakM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652089473;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qCOMxsP6gXawwX6fmMzR64svAoIIp5nPZ8/UcSs6oY0=;
        b=kFLbuUqua6ZkAI1fvysdC0qcGlfuy6BwHkq1KDK5JSiosuet7W/EOlhfFQcsEpepCgBdBI
        dxfj1ejFgqY/dcDg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2B7202C141;
        Mon,  9 May 2022 09:44:33 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DB48CA062A; Mon,  9 May 2022 11:44:31 +0200 (CEST)
Date:   Mon, 9 May 2022 11:44:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fanotify: do not allow setting FAN_RENAME on non-dir
Message-ID: <20220509094431.4tb3752vwj5tpngx@quack3.lan>
References: <20220506014626.191619-1-amir73il@gmail.com>
 <20220506091203.yknwtnnxaz6n547d@quack3.lan>
 <CAOQ4uxhvT=b6bNwxE5_XBmOh84nae72GhWJ_vaO8iwHgqY_ceA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhvT=b6bNwxE5_XBmOh84nae72GhWJ_vaO8iwHgqY_ceA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 07-05-22 08:57:00, Amir Goldstein wrote:
> On Fri, May 6, 2022 at 12:12 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Fri 06-05-22 04:46:26, Amir Goldstein wrote:
> > > The desired sematics of this action are not clear, so for now deny
> > > this action.  We may relax it when we decide on the semantics and
> > > implement them.
> > >
> > > Fixes: 8cc3b1ccd930 ("fanotify: wire up FAN_RENAME event")
> > > Link: https://lore.kernel.org/linux-fsdevel/20220505133057.zm5t6vumc4xdcnsg@quack3.lan/
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > Thanks guys. I've merged the fix to my tree (fast_track branch) and will
> > push it to Linus on Monday once it gets at least some exposure to
> > auto-testers.
> 
> Actually, I made a mistake.
> It should not return -EINVAL, it should return -ENOTDIR, because
> the error is the object not the syscall argument values.

Yeah, makes sense.

> Going forward, when Matthew implements FAN_RENAME on
> non-dir, the error should be changed to -EPERM (for unpriv caller).
> This will allow better documentation of behavior in kernel 5.17 and
> newer kernels.
> 
> Can you please fix that before sending to Linus?

Yup, I'll update that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
