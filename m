Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F8466D053
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 21:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjAPUnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 15:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjAPUnV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 15:43:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9412D2411E
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 12:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673901756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kgpmwAld50T/RlTnaDgeJfep1BuT7u8rE0qOi5VFIA8=;
        b=Y7ieMtXmHeE6UYTZiQPzkDcV+Cn0AS8Pcg+jHP1i13YWsWcT/TbZpplnKehhneeYXv/aCr
        G4/JBpdisTLTzoz9krQNKbxXP7q/SOJhcVw7vJxbhc8O8bXZCzOYpnw5mTl5dsTr7IwBox
        vqUt7wQJmwS3ngDwst1QqaX10s/5FF8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-l-zUWM7dMJCE9cSXcAtiJA-1; Mon, 16 Jan 2023 15:42:33 -0500
X-MC-Unique: l-zUWM7dMJCE9cSXcAtiJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3D5929AA384;
        Mon, 16 Jan 2023 20:42:32 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62B9140C6EC4;
        Mon, 16 Jan 2023 20:42:31 +0000 (UTC)
Date:   Mon, 16 Jan 2023 15:42:29 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v5 2/3] fanotify: define struct members to hold response
 decision context
Message-ID: <Y8W2tcXFoUajzojc@madcap2.tricolour.ca>
References: <cover.1670606054.git.rgb@redhat.com>
 <45da8423b9b1e8fc7abd68cd2269acff8cf9022a.1670606054.git.rgb@redhat.com>
 <20221216164342.ojcbdifdmafq5njw@quack3>
 <Y6TCWe4/nR957pFh@madcap2.tricolour.ca>
 <20230103124201.iopasddbtb6vi362@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103124201.iopasddbtb6vi362@quack3>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-01-03 13:42, Jan Kara wrote:
> On Thu 22-12-22 15:47:21, Richard Guy Briggs wrote:
> > On 2022-12-16 17:43, Jan Kara wrote:
> > > On Mon 12-12-22 09:06:10, Richard Guy Briggs wrote:
> > > > This patch adds a flag, FAN_INFO and an extensible buffer to provide
> > > > additional information about response decisions.  The buffer contains
> > > > one or more headers defining the information type and the length of the
> > > > following information.  The patch defines one additional information
> > > > type, FAN_RESPONSE_INFO_AUDIT_RULE, to audit a rule number.  This will
> > > > allow for the creation of other information types in the future if other
> > > > users of the API identify different needs.
> > > > 
> > > > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > > > Link: https://lore.kernel.org/r/2745105.e9J7NaK4W3@x2
> > > > Suggested-by: Jan Kara <jack@suse.cz>
> > > > Link: https://lore.kernel.org/r/20201001101219.GE17860@quack2.suse.cz
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

> > > > +{
> > > > +	if (fd == FAN_NOFD)
> > > > +		return -ENOENT;
> > > 
> > > I would not test 'fd' in this function at all. After all it is not part of
> > > the response info structure and you do check it in
> > > process_access_response() anyway.
> > 
> > I wrestled with that.  I was even tempted to swallow the following fd
> > check too, but the flow would not have made as much sense for the
> > non-INFO case.
> > 
> > My understanding from Amir was that FAN_NOFD was only to be sent in in
> > conjuction with FAN_INFO to test if a newer kernel was present.
> 
> Yes, that is correct. But we not only want to check that FAN_INFO flag is
> understood (as you do in your patch) but also whether a particular response
> type is understood (which you don't verify for FAN_NOFD). Currently, there
> is only one response type (FAN_RESPONSE_INFO_AUDIT_RULE) but if there are
> more in the future we need old kernels to refuse new response types even
> for FAN_NOFD case.

Ok, I agree the NOFD check should be after.

> > I presumed that if FAN_NOFD was present without FAN_INFO that was an
> > invalid input to an old kernel.
> 
> Yes, that is correct and I agree the conditions I've suggested below are
> wrong in that regard and need a bit of tweaking. Thanks for catching it.
> 
> > > > +
> > > > +	if (info_len != sizeof(*friar))
> > > > +		return -EINVAL;
> > > > +
> > > > +	if (copy_from_user(friar, info, sizeof(*friar)))
> > > > +		return -EFAULT;
> > > > +
> > > > +	if (friar->hdr.type != FAN_RESPONSE_INFO_AUDIT_RULE)
> > > > +		return -EINVAL;
> > > > +	if (friar->hdr.pad != 0)
> > > > +		return -EINVAL;
> > > > +	if (friar->hdr.len != sizeof(*friar))
> > > > +		return -EINVAL;
> > > > +
> > > > +	return info_len;
> > > > +}
> > > > +
> > > 
> > > ...
> > > 
> > > > @@ -327,10 +359,18 @@ static int process_access_response(struct fsnotify_group *group,
> > > >  		return -EINVAL;
> > > >  	}
> > > >  
> > > > -	if (fd < 0)
> > > > +	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
> > > >  		return -EINVAL;
> > > >  
> > > > -	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
> > > > +	if (response & FAN_INFO) {
> > > > +		ret = process_access_response_info(fd, info, info_len, &friar);
> > > > +		if (ret < 0)
> > > > +			return ret;
> > > > +	} else {
> > > > +		ret = 0;
> > > > +	}
> > > > +
> > > > +	if (fd < 0)
> > > >  		return -EINVAL;
> > > 
> > > And here I'd do:
> > > 
> > > 	if (fd == FAN_NOFD)
> > > 		return 0;
> > > 	if (fd < 0)
> > > 		return -EINVAL;
> > > 
> > > As we talked in previous revisions we'd specialcase FAN_NOFD to just verify
> > > extra info is understood by the kernel so that application writing fanotify
> > > responses has a way to check which information it can provide to the
> > > kernel.
> > 
> > The reason for including it in process_access_response_info() is to make
> > sure that it is included in the FAN_INFO case to detect this extension.
> > If it were included here
> 
> I see what you're getting at now. So the condition
> 
>  	if (fd == FAN_NOFD)
>  		return 0;
> 
> needs to be moved into 
> 
> 	if (response & FAN_INFO)
> 
> branch after process_access_response_info(). I still prefer to keep it
> outside of the process_access_response_info() function itself as it looks
> more logical to me. Does it address your concerns?

Ok.  Note that this does not return zero to userspace, since this
function's return value is added to the size of the struct
fanotify_response when there is no error.

For that reason, I think it makes more sense to return -ENOENT, or some
other unused error code that fits, unless you think it is acceptable to
return sizeof(struct fanotify_response) when FAN_INFO is set to indicate
this.

> Jan Kara <jack@suse.com>

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

