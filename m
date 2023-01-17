Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7684E66D829
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 09:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbjAQI13 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Jan 2023 03:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235811AbjAQI11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:27:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098A610C4;
        Tue, 17 Jan 2023 00:27:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8821E38128;
        Tue, 17 Jan 2023 08:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673944044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0iuG7PkMYKf7+8R4JHptOHZGwCBSRhIIXJ2tXnim9Ps=;
        b=NXJX/oGHZg/1ODfYgWCcmn+0wwahKQ7zQkXRd5DSD1mFUmbxeTWNWJ9JynfiA54gY3gsgT
        A0jT5X2CV4slDvfBntHDytf0JyN4M8tUzCO97VNpwARYJEmqu/iB5PS1eqm8ihKjP+yROz
        TGVleYHmmK6G0PLGwP9ur+XbG7/8n+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673944044;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0iuG7PkMYKf7+8R4JHptOHZGwCBSRhIIXJ2tXnim9Ps=;
        b=m+2JALH66lcQBqsBJFp+2YpheI9qlODjz1YCYeTugQ4orbs17m1hlVFr2Am4CoUB9w94VU
        E6i84SCD+FBiemCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 796E11390C;
        Tue, 17 Jan 2023 08:27:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4aCKHexbxmNxVQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 17 Jan 2023 08:27:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BDF5FA06B2; Tue, 17 Jan 2023 09:27:23 +0100 (CET)
Date:   Tue, 17 Jan 2023 09:27:23 +0100
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
Message-ID: <20230117082723.7g3ig6ernoslt7ub@quack3>
References: <cover.1670606054.git.rgb@redhat.com>
 <45da8423b9b1e8fc7abd68cd2269acff8cf9022a.1670606054.git.rgb@redhat.com>
 <20221216164342.ojcbdifdmafq5njw@quack3>
 <Y6TCWe4/nR957pFh@madcap2.tricolour.ca>
 <20230103124201.iopasddbtb6vi362@quack3>
 <Y8W2tcXFoUajzojc@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8W2tcXFoUajzojc@madcap2.tricolour.ca>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 16-01-23 15:42:29, Richard Guy Briggs wrote:
> On 2023-01-03 13:42, Jan Kara wrote:
> > On Thu 22-12-22 15:47:21, Richard Guy Briggs wrote:
> > > > > +
> > > > > +	if (info_len != sizeof(*friar))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	if (copy_from_user(friar, info, sizeof(*friar)))
> > > > > +		return -EFAULT;
> > > > > +
> > > > > +	if (friar->hdr.type != FAN_RESPONSE_INFO_AUDIT_RULE)
> > > > > +		return -EINVAL;
> > > > > +	if (friar->hdr.pad != 0)
> > > > > +		return -EINVAL;
> > > > > +	if (friar->hdr.len != sizeof(*friar))
> > > > > +		return -EINVAL;
> > > > > +
> > > > > +	return info_len;
> > > > > +}
> > > > > +
> > > > 
> > > > ...
> > > > 
> > > > > @@ -327,10 +359,18 @@ static int process_access_response(struct fsnotify_group *group,
> > > > >  		return -EINVAL;
> > > > >  	}
> > > > >  
> > > > > -	if (fd < 0)
> > > > > +	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
> > > > >  		return -EINVAL;
> > > > >  
> > > > > -	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
> > > > > +	if (response & FAN_INFO) {
> > > > > +		ret = process_access_response_info(fd, info, info_len, &friar);
> > > > > +		if (ret < 0)
> > > > > +			return ret;
> > > > > +	} else {
> > > > > +		ret = 0;
> > > > > +	}
> > > > > +
> > > > > +	if (fd < 0)
> > > > >  		return -EINVAL;
> > > > 
> > > > And here I'd do:
> > > > 
> > > > 	if (fd == FAN_NOFD)
> > > > 		return 0;
> > > > 	if (fd < 0)
> > > > 		return -EINVAL;
> > > > 
> > > > As we talked in previous revisions we'd specialcase FAN_NOFD to just verify
> > > > extra info is understood by the kernel so that application writing fanotify
> > > > responses has a way to check which information it can provide to the
> > > > kernel.
> > > 
> > > The reason for including it in process_access_response_info() is to make
> > > sure that it is included in the FAN_INFO case to detect this extension.
> > > If it were included here
> > 
> > I see what you're getting at now. So the condition
> > 
> >  	if (fd == FAN_NOFD)
> >  		return 0;
> > 
> > needs to be moved into 
> > 
> > 	if (response & FAN_INFO)
> > 
> > branch after process_access_response_info(). I still prefer to keep it
> > outside of the process_access_response_info() function itself as it looks
> > more logical to me. Does it address your concerns?
> 
> Ok.  Note that this does not return zero to userspace, since this
> function's return value is added to the size of the struct
> fanotify_response when there is no error.

Right, good point. 0 is not a good return value in this case.

> For that reason, I think it makes more sense to return -ENOENT, or some
> other unused error code that fits, unless you think it is acceptable to
> return sizeof(struct fanotify_response) when FAN_INFO is set to indicate
> this.

Yeah, my intention was to indicate "success" to userspace so I'd like to
return whatever we return for the case when struct fanotify_response is
accepted for a normal file descriptor - looks like info_len is the right
value. Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
