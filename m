Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF2B654786
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 21:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLVUsR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 15:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiLVUsP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 15:48:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDF522B1B
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 12:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671742049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MBkwW1AcUtBRbFAy7tADg9c0t3Qyu1AJkfHSKMyEdjg=;
        b=eI1EHfi3TZsTDB+rk1CwrSqg3K1yvwicH2HLeRK83ZkZALzkALp2E/eRzndFYl7KqTRf7y
        l+AJm6cl8MxoeVTNDMvcUE4LjTry4PNe8OCCtQ9+Xq30uo1iPwWrxDi10mhxX83aBtQGm9
        TdnnhsfLZG/yk7DtEsIursmJz1dRJ2o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-W0ApSfykO0OlxaKD-rvsxQ-1; Thu, 22 Dec 2022 15:47:25 -0500
X-MC-Unique: W0ApSfykO0OlxaKD-rvsxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 260B53C01E0A;
        Thu, 22 Dec 2022 20:47:25 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-0-3.rdu2.redhat.com [10.22.0.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A3ABE14152F4;
        Thu, 22 Dec 2022 20:47:23 +0000 (UTC)
Date:   Thu, 22 Dec 2022 15:47:21 -0500
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
Message-ID: <Y6TCWe4/nR957pFh@madcap2.tricolour.ca>
References: <cover.1670606054.git.rgb@redhat.com>
 <45da8423b9b1e8fc7abd68cd2269acff8cf9022a.1670606054.git.rgb@redhat.com>
 <20221216164342.ojcbdifdmafq5njw@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216164342.ojcbdifdmafq5njw@quack3>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-12-16 17:43, Jan Kara wrote:
> On Mon 12-12-22 09:06:10, Richard Guy Briggs wrote:
> > This patch adds a flag, FAN_INFO and an extensible buffer to provide
> > additional information about response decisions.  The buffer contains
> > one or more headers defining the information type and the length of the
> > following information.  The patch defines one additional information
> > type, FAN_RESPONSE_INFO_AUDIT_RULE, to audit a rule number.  This will
> > allow for the creation of other information types in the future if other
> > users of the API identify different needs.
> > 
> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > Link: https://lore.kernel.org/r/2745105.e9J7NaK4W3@x2
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Link: https://lore.kernel.org/r/20201001101219.GE17860@quack2.suse.cz
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> 
> Thanks for the patches. They look very good to me. Just two nits below. I
> can do the small updates on commit if there would be no other changes. But
> I'd like to get some review from audit guys for patch 3/3 before I commit
> this.

I'd prefer to send a followup patch based on your recommendations rather
than have you modify it.  It does save some back and forth though...

> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index caa1211bac8c..cf3584351e00 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -283,19 +283,44 @@ static int create_fd(struct fsnotify_group *group, const struct path *path,
> >  	return client_fd;
> >  }
> >  
> > +static int process_access_response_info(int fd, const char __user *info, size_t info_len,
> > +					struct fanotify_response_info_audit_rule *friar)
> 
> I prefer to keep lines within 80 columns, unless there is really good
> reason (like with strings) to have them longer.

Sure.  In this case, it buys us little since the last line is lined up
with the arguments openning bracket and it one long struct name unless I
unalign that argument and back up the indent by one.

> BTW, why do you call the info structure 'friar'? I feel some language twist
> escapes me ;)

Fanotify_Response_Info_Audit_Rule, it is a pronounceable word, and
besides they have a long reputation for making good beer.  :-D

> > +{
> > +	if (fd == FAN_NOFD)
> > +		return -ENOENT;
> 
> I would not test 'fd' in this function at all. After all it is not part of
> the response info structure and you do check it in
> process_access_response() anyway.

I wrestled with that.  I was even tempted to swallow the following fd
check too, but the flow would not have made as much sense for the
non-INFO case.

My understanding from Amir was that FAN_NOFD was only to be sent in in
conjuction with FAN_INFO to test if a newer kernel was present.

I presumed that if FAN_NOFD was present without FAN_INFO that was an
invalid input to an old kernel.

> > +
> > +	if (info_len != sizeof(*friar))
> > +		return -EINVAL;
> > +
> > +	if (copy_from_user(friar, info, sizeof(*friar)))
> > +		return -EFAULT;
> > +
> > +	if (friar->hdr.type != FAN_RESPONSE_INFO_AUDIT_RULE)
> > +		return -EINVAL;
> > +	if (friar->hdr.pad != 0)
> > +		return -EINVAL;
> > +	if (friar->hdr.len != sizeof(*friar))
> > +		return -EINVAL;
> > +
> > +	return info_len;
> > +}
> > +
> 
> ...
> 
> > @@ -327,10 +359,18 @@ static int process_access_response(struct fsnotify_group *group,
> >  		return -EINVAL;
> >  	}
> >  
> > -	if (fd < 0)
> > +	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
> >  		return -EINVAL;
> >  
> > -	if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
> > +	if (response & FAN_INFO) {
> > +		ret = process_access_response_info(fd, info, info_len, &friar);
> > +		if (ret < 0)
> > +			return ret;
> > +	} else {
> > +		ret = 0;
> > +	}
> > +
> > +	if (fd < 0)
> >  		return -EINVAL;
> 
> And here I'd do:
> 
> 	if (fd == FAN_NOFD)
> 		return 0;
> 	if (fd < 0)
> 		return -EINVAL;
> 
> As we talked in previous revisions we'd specialcase FAN_NOFD to just verify
> extra info is understood by the kernel so that application writing fanotify
> responses has a way to check which information it can provide to the
> kernel.

The reason for including it in process_access_response_info() is to make
sure that it is included in the FAN_INFO case to detect this extension.
If it were included here

> 								Honza
> 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

