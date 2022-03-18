Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4974DD7F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 11:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiCRKdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Mar 2022 06:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiCRKdm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Mar 2022 06:33:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5C324F28E
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Mar 2022 03:32:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 69936210EA;
        Fri, 18 Mar 2022 10:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647599541; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W4fhOyCXrndOa/3NEfTqbGLfFL9s3wutIX/A7ddRYu4=;
        b=Qo52uYTYO/6wdXjoPQqhHk2F+a7ADu4N24XdZqFgqGvElYzZa794f0/CMOoCdLDVjwND2R
        Z/FqWuwEXYXQtlpIjO0SkU0K35TP9zBC0smiold2Xq15uWt9xEB+wJzt9kjghMojTtQJSO
        75M3jKpfuY0YrZTEcBGgx4l/SsafBEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647599541;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W4fhOyCXrndOa/3NEfTqbGLfFL9s3wutIX/A7ddRYu4=;
        b=OXyuSb5ngEi96EtEFr9gcvfR2EDe077Lyv1Told8RpXiQMe+RkR7m2CzheTJJghdH6X0pC
        BXt+W7s5qMQ6GiBw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 442D1A3B83;
        Fri, 18 Mar 2022 10:32:21 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D161EA0615; Fri, 18 Mar 2022 11:32:19 +0100 (CET)
Date:   Fri, 18 Mar 2022 11:32:19 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 4/5] fanotify: add support for exclusive create of mark
Message-ID: <20220318103219.j744o5g5bmsneihz@quack3.lan>
References: <20220307155741.1352405-1-amir73il@gmail.com>
 <20220307155741.1352405-5-amir73il@gmail.com>
 <20220317153443.iy5rvns5nwxlxx43@quack3.lan>
 <20220317154550.y3rvxmmfcaf5n5st@quack3.lan>
 <CAOQ4uxi85LV7upQuBUjL==aaWoY8WGMG4DRQToj6Y-JCn-Ex=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi85LV7upQuBUjL==aaWoY8WGMG4DRQToj6Y-JCn-Ex=g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 18-03-22 05:13:01, Amir Goldstein wrote:
> On Thu, Mar 17, 2022 at 5:45 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 17-03-22 16:34:43, Jan Kara wrote:
> > > On Mon 07-03-22 17:57:40, Amir Goldstein wrote:
> > > > Similar to inotify's IN_MARK_CREATE, adding an fanotify mark with flag
> > > > FAN_MARK_CREATE will fail with error EEXIST if an fanotify mark already
> > > > exists on the object.
> > > >
> > > > Unlike inotify's IN_MARK_CREATE, FAN_MARK_CREATE has to supplied in
> > > > combination with FAN_MARK_ADD (FAN_MARK_ADD is like inotify_add_watch()
> > > > and the behavior of IN_MARK_ADD is the default for fanotify_mark()).
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > What I'm missing in this changelog is "why". Is it just about feature
> > > parity with inotify? I don't find this feature particularly useful...
> >
> > OK, now I understand after reading patch 5/5. Hum, but I'm not quite happy
> > about the limitation to non-existing mark as much as I understand why you
> > need it. Let me think...
> >
> 
> Sorry for not articulating the problem better.
> Let me write up the problem and maybe someone can come up with a better
> solution than I did.
> 
> The problem that I was trying to avoid with FAN_MARK_VOLATILE is similar
> to an existing UAPI problem with FAN_MARK_IGNORED_SURV_MODIFY -
> This flag can only be set and not cleared and when set it affects all the events
> set in the mask prior to that time, leading to unpredictable results.
>
> Let's say a user sets FAN_CLOSE in ignored mask without _SURV_MODIFY
> and later sets FAN_OPEN  in ignored mask with _SURV_MODIFY.
> Does the ignored mask now include FAN_CLOSE? That depends
> whether or not FAN_MODIFY event took place between the two calls.

Yeah, but with FAN_MARK_VOLATILE the problem also goes the other way
around. If I set FAN_MARK_VOLATILE on some inode and later add something to
a normal mask, I might be rightfully surprised when the mark gets evicted
and thus I will not get events I'm expecting. Granted the application would
be stepping on its own toes because marks are "merged" only for the same
notification group but still it could be surprising and avoiding such
mishaps would probably involve extra tracking on the application side.

The problem essentially lies in mixing mark "flags" (ONDIR, ON_CHILD,
VOLATILE, SURV_MODIFY) with mark mask. Mark operations with identical set
of flags can be merged without troubles but once flags are different
results of the merge are always "interesting". So far the consequences were
mostly benign (getting more events than the application may have expected)
but with FAN_MARK_VOLATILE we can also start loosing events and that is
more serious.

So far my thinking is that we either follow the path of possibly generating
more events than necessary (i.e., any merge of two masks that do not both
have FAN_MARK_VOLATILE set will clear FAN_MARK_VOLATILE) or we rework the
whole mark API (and implementation!) to completely avoid these strange
effects of flag merging. I don't like FAN_MARK_CREATE much because IMO it
solves only half of the problem - when new mark with a flag wants to merge
with an existing mark, but does not solve the other half when some other
mark wants to merge to a mark with a flag. Thoughts?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
