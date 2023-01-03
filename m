Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98C765C00B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jan 2023 13:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbjACMmG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Jan 2023 07:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjACMmE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:42:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AC89FD3;
        Tue,  3 Jan 2023 04:42:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2390D671AC;
        Tue,  3 Jan 2023 12:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672749722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pTRmPLN+nKDxpkvAuy7xPSj+P5EUaykcz/bu6SdbF0o=;
        b=gGorrRDau2nrUcCwnX8wbC7EN9jCz8eEPUV/e/66YNbDy15+B96B7v6eDHuv8KlU5byjMy
        IkeQvcaTZ4GBJIWnRymFXp5NTMwvcGMdUg6gP8wJfiR1vEafV4JUIluIKO2f4hCn33VJKW
        OZTxz++wX6FNhylZKDz0G2m2ndshblM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672749722;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pTRmPLN+nKDxpkvAuy7xPSj+P5EUaykcz/bu6SdbF0o=;
        b=osD1MW9Rp24AQxdfGkeuER8PF8qI1TxQbQPYHisjuff44K9ufUJwbC0hxa4YHJ3XGtDwhG
        wc7NwZkZ/vtuXxDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F5211392B;
        Tue,  3 Jan 2023 12:42:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f1ewA5oitGN9DgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 03 Jan 2023 12:42:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7D9B8A0742; Tue,  3 Jan 2023 13:42:01 +0100 (CET)
Date:   Tue, 3 Jan 2023 13:42:01 +0100
From:   Jan Kara <jack@suse.cz>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Jan Kara <jack@suse.cz>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v5 2/3] fanotify: define struct members to hold response
 decision context
Message-ID: <20230103124201.iopasddbtb6vi362@quack3>
References: <cover.1670606054.git.rgb@redhat.com>
 <45da8423b9b1e8fc7abd68cd2269acff8cf9022a.1670606054.git.rgb@redhat.com>
 <20221216164342.ojcbdifdmafq5njw@quack3>
 <Y6TCWe4/nR957pFh@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6TCWe4/nR957pFh@madcap2.tricolour.ca>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 22-12-22 15:47:21, Richard Guy Briggs wrote:
> On 2022-12-16 17:43, Jan Kara wrote:
> > On Mon 12-12-22 09:06:10, Richard Guy Briggs wrote:
> > > This patch adds a flag, FAN_INFO and an extensible buffer to provide
> > > additional information about response decisions.  The buffer contains
> > > one or more headers defining the information type and the length of the
> > > following information.  The patch defines one additional information
> > > type, FAN_RESPONSE_INFO_AUDIT_RULE, to audit a rule number.  This will
> > > allow for the creation of other information types in the future if other
> > > users of the API identify different needs.
> > > 
> > > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > > Link: https://lore.kernel.org/r/2745105.e9J7NaK4W3@x2
> > > Suggested-by: Jan Kara <jack@suse.cz>
> > > Link: https://lore.kernel.org/r/20201001101219.GE17860@quack2.suse.cz
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > 
> > Thanks for the patches. They look very good to me. Just two nits below. I
> > can do the small updates on commit if there would be no other changes. But
> > I'd like to get some review from audit guys for patch 3/3 before I commit
> > this.
> 
> I'd prefer to send a followup patch based on your recommendations rather
> than have you modify it.  It does save some back and forth though...

OK, since there are updates to patch 3 as well, I agree this is a better
way forward.

> > > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > > index caa1211bac8c..cf3584351e00 100644
> > > --- a/fs/notify/fanotify/fanotify_user.c
> > > +++ b/fs/notify/fanotify/fanotify_user.c
> > > @@ -283,19 +283,44 @@ static int create_fd(struct fsnotify_group *group, const struct path *path,
> > >  	return client_fd;
> > >  }
> > >  
> > > +static int process_access_response_info(int fd, const char __user *info, size_t info_len,
> > > +					struct fanotify_response_info_audit_rule *friar)
> > 
> > I prefer to keep lines within 80 columns, unless there is really good
> > reason (like with strings) to have them longer.
> 
> Sure.  In this case, it buys us little since the last line is lined up
> with the arguments openning bracket and it one long struct name unless I
> unalign that argument and back up the indent by one.

Yeah, that's what I'd generally do.

> > BTW, why do you call the info structure 'friar'? I feel some language twist
> > escapes me ;)
> 
> Fanotify_Response_Info_Audit_Rule, it is a pronounceable word, and
> besides they have a long reputation for making good beer.  :-D

Aha, ok :) Thanks for explanation.

> > > +{
> > > +	if (fd == FAN_NOFD)
> > > +		return -ENOENT;
> > 
> > I would not test 'fd' in this function at all. After all it is not part of
> > the response info structure and you do check it in
> > process_access_response() anyway.
> 
> I wrestled with that.  I was even tempted to swallow the following fd
> check too, but the flow would not have made as much sense for the
> non-INFO case.
> 
> My understanding from Amir was that FAN_NOFD was only to be sent in in
> conjuction with FAN_INFO to test if a newer kernel was present.

Yes, that is correct. But we not only want to check that FAN_INFO flag is
understood (as you do in your patch) but also whether a particular response
type is understood (which you don't verify for FAN_NOFD). Currently, there
is only one response type (FAN_RESPONSE_INFO_AUDIT_RULE) but if there are
more in the future we need old kernels to refuse new response types even
for FAN_NOFD case.

> I presumed that if FAN_NOFD was present without FAN_INFO that was an
> invalid input to an old kernel.

Yes, that is correct and I agree the conditions I've suggested below are
wrong in that regard and need a bit of tweaking. Thanks for catching it.

> > > +
> > > +	if (info_len != sizeof(*friar))
> > > +		return -EINVAL;
> > > +
> > > +	if (copy_from_user(friar, info, sizeof(*friar)))
> > > +		return -EFAULT;
> > > +
> > > +	if (friar->hdr.type != FAN_RESPONSE_INFO_AUDIT_RULE)
> > > +		return -EINVAL;
> > > +	if (friar->hdr.pad != 0)
> > > +		return -EINVAL;
> > > +	if (friar->hdr.len != sizeof(*friar))
> > > +		return -EINVAL;
> > > +
> > > +	return info_len;
> > > +}
> > > +
> > 
> > ...
> > 
> > > @@ -327,10 +359,18 @@ static int process_access_response(struct fsnotify_group *group,
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > -	if (fd < 0)
> > > +	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
> > >  		return -EINVAL;
> > >  
> > > -	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
> > > +	if (response & FAN_INFO) {
> > > +		ret = process_access_response_info(fd, info, info_len, &friar);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +	} else {
> > > +		ret = 0;
> > > +	}
> > > +
> > > +	if (fd < 0)
> > >  		return -EINVAL;
> > 
> > And here I'd do:
> > 
> > 	if (fd == FAN_NOFD)
> > 		return 0;
> > 	if (fd < 0)
> > 		return -EINVAL;
> > 
> > As we talked in previous revisions we'd specialcase FAN_NOFD to just verify
> > extra info is understood by the kernel so that application writing fanotify
> > responses has a way to check which information it can provide to the
> > kernel.
> 
> The reason for including it in process_access_response_info() is to make
> sure that it is included in the FAN_INFO case to detect this extension.
> If it were included here

I see what you're getting at now. So the condition

 	if (fd == FAN_NOFD)
 		return 0;

needs to be moved into 

	if (response & FAN_INFO)

branch after process_access_response_info(). I still prefer to keep it
outside of the process_access_response_info() function itself as it looks
more logical to me. Does it address your concerns?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
