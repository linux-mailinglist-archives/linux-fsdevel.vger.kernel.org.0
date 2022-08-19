Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D05599AC6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 13:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348591AbiHSLQ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 07:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348258AbiHSLQ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:16:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE04EE6AB;
        Fri, 19 Aug 2022 04:16:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 005591FD03;
        Fri, 19 Aug 2022 11:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660907815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bjOJ0wJh99TvSlpmfZexGHl3oZRR0QtY5bdZiD+GSIE=;
        b=ro7eE9dxlNfWzHnTeOZKwR9eaZTKW68Ub1e0ua1pisqjg1Db/z+J2RrmPbjRNCiKJjpaSv
        J7M4pJSAzBl96vTQeQcMPllVZoiN0t2JqVT89TMuBkVM0v3LeB9bHV/j9UxmeKmVshTYO7
        dvR8mYZatf7dHehHqTfUqkPPgZNmfko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660907815;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bjOJ0wJh99TvSlpmfZexGHl3oZRR0QtY5bdZiD+GSIE=;
        b=kcsjwZUiyBHa161xp4IW9DOE3Isqf/QOXlBX1nFDknF6aer5VQpyI8xclLhMaJm8wohaDC
        WgJuqpt5FzMOBxBA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CD80E2C141;
        Fri, 19 Aug 2022 11:16:54 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3D560A0635; Fri, 19 Aug 2022 13:16:54 +0200 (CEST)
Date:   Fri, 19 Aug 2022 13:16:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 2/4] fanotify: define struct members to hold response
 decision context
Message-ID: <20220819111654.qtxqqt23xqj3c5pj@quack3>
References: <cover.1659996830.git.rgb@redhat.com>
 <8767f3a0d43d6a994584b86c03eb659a662cc416.1659996830.git.rgb@redhat.com>
 <YvWdcX1Beo9ZbFXh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvWdcX1Beo9ZbFXh@google.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 12-08-22 10:23:13, Matthew Bobrowski wrote:
> On Tue, Aug 09, 2022 at 01:22:53PM -0400, Richard Guy Briggs wrote:
> > This patch adds a flag, FAN_INFO and an extensible buffer to provide
> > additional information about response decisions.  The buffer contains
> > one or more headers defining the information type and the length of the
> > following information.  The patch defines one additional information
> > type, FAN_RESPONSE_INFO_AUDIT_RULE, an audit rule number.  This will
> > allow for the creation of other information types in the future if other
> > users of the API identify different needs.
> > 
> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > Link: https://lore.kernel.org/r/2745105.e9J7NaK4W3@x2
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Link: https://lore.kernel.org/r/20201001101219.GE17860@quack2.suse.cz
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---

...

> > @@ -827,26 +877,33 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
> >  
> >  static ssize_t fanotify_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
> >  {
> > -	struct fanotify_response response = { .fd = -1, .response = -1 };
> > +	struct fanotify_response response;
> >  	struct fsnotify_group *group;
> >  	int ret;
> > +	const char __user *info_buf = buf + sizeof(struct fanotify_response);
> > +	size_t c;
> 
> Can we rename this to something like len or info_len instead? I
> dislike single character variable names outside of the scope of things
> like loops.
> 
> >  	if (!IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
> >  		return -EINVAL;
> >  
> >  	group = file->private_data;
> >  
> > -	if (count < sizeof(response))
> > -		return -EINVAL;
> > -
> > -	count = sizeof(response);
> > -
> >  	pr_debug("%s: group=%p count=%zu\n", __func__, group, count);
> >  
> > -	if (copy_from_user(&response, buf, count))
> > +	if (count < sizeof(response))
> > +		return -EINVAL;
> > +	if (copy_from_user(&response, buf, sizeof(response)))
> >  		return -EFAULT;
> >  
> > -	ret = process_access_response(group, &response);
> > +	c = count - sizeof(response);
> > +	if (response.response & FAN_INFO) {
> > +		if (c < sizeof(struct fanotify_response_info_header))
> > +			return -EINVAL;
> > +	} else {
> > +		if (c != 0)
> > +			return -EINVAL;
> 
> Hm, prior to this change we truncated the copy operation to the
> sizeof(struct fanotify_response) and didn't care if there maybe was
> extra data supplied in the buf or count > sizeof(struct
> fanotify_response). This leaves me wondering whether this check is
> needed for cases that are not (FAN_INFO | FAN_AUDIT)? The buf may
> still hold a valid fanotify_response despite buf/count possibly being
> larger than sizeof(struct fanotify_response)... I can see why you'd
> want to enforce this, but I'm wondering if it might break things if
> event listeners are responding to the permission events in an awkward
> way i.e. by calculating and supplying count incorrectly.
> 
> Also, if we do decide to keep this check around, then maybe it can be
> simplified into an else if instead?

So the check for (c != 0) in case FAN_INFO is not set is definitely asking
for userspace regression because before we have been just silently ignoring
additional bytes beyond standard reply. So please keep the old behavior of
ignoring extra bytes if FAN_INFO flag is not set. Thanks!

								Honza
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
