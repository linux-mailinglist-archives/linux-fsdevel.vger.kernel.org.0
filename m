Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08234529F85
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 12:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245357AbiEQKfN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 06:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344428AbiEQKd6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 06:33:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB5249F3F;
        Tue, 17 May 2022 03:32:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 9A0B11F8FC;
        Tue, 17 May 2022 10:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652783557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AdREXbILgpGtR7QSP7HyKz+Fb2eDnxl8EyywWIr55KU=;
        b=mxTXweGcb6GrUBdjgKxduBWi5fu/wQ63HmsVjKqAF/l7FkWgQBUcfEQ2/e0h8bFUBMjtjs
        70CzIuvKyW1AJ9ILvyu2KJHHYs994TWddLIAsEbEnjjvW0uPPlwR/PqXKB80nyhGqTf00L
        ovINYCF9HL67tr//kHyzCex/SPB6/Lg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652783557;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AdREXbILgpGtR7QSP7HyKz+Fb2eDnxl8EyywWIr55KU=;
        b=7YaDNu7eoNpw36ifJtEnVIDyY62Mko373ZHyIPp8Ddsx9Bw9DQwLSIsRLipTKjKL1nMfAb
        7FsmvvFZQn4e2uDw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 336E52C141;
        Tue, 17 May 2022 10:32:37 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DF400A0631; Tue, 17 May 2022 12:32:36 +0200 (CEST)
Date:   Tue, 17 May 2022 12:32:36 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3 2/3] fanotify: define struct members to hold response
 decision context
Message-ID: <20220517103236.i7gtsw7akiikqwam@quack3.lan>
References: <cover.1652730821.git.rgb@redhat.com>
 <1520f08c023d1e919b1a2af161d5a19367b6b4bf.1652730821.git.rgb@redhat.com>
 <CAOQ4uxjV-eNxJ=O_WFTTzspCxXZqpMdh3Fe-N5aB-h1rDr_1hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjV-eNxJ=O_WFTTzspCxXZqpMdh3Fe-N5aB-h1rDr_1hQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 17-05-22 08:37:28, Amir Goldstein wrote:
> On Mon, May 16, 2022 at 11:22 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
> > This patch adds 2 structure members to the response returned from user
> > space on a permission event. The first field is 32 bits for the context
> > type.  The context type will describe what the meaning is of the second
> > field. The default is none. The patch defines one additional context
> > type which means that the second field is a union containing a 32-bit
> > rule number. This will allow for the creation of other context types in
> > the future if other users of the API identify different needs.  The
> > second field size is defined by the context type and can be used to pass
> > along the data described by the context.
> >
> > To support this, there is a macro for user space to check that the data
> > being sent is valid. Of course, without this check, anything that
> > overflows the bit field will trigger an EINVAL based on the use of
> > FAN_INVALID_RESPONSE_MASK in process_access_response().
> >
> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > Link: https://lore.kernel.org/r/2745105.e9J7NaK4W3@x2
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Link: https://lore.kernel.org/r/20201001101219.GE17860@quack2.suse.cz
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

...
> >  static int process_access_response(struct fsnotify_group *group,
> > -                                  struct fanotify_response *response_struct)
> > +                                  struct fanotify_response *response_struct,
> > +                                  size_t count)
> >  {
> >         struct fanotify_perm_event *event;
> >         int fd = response_struct->fd;
> >         u32 response = response_struct->response;
> >
> > -       pr_debug("%s: group=%p fd=%d response=%u\n", __func__, group,
> > -                fd, response);
> > +       pr_debug("%s: group=%p fd=%d response=%u type=%u size=%lu\n", __func__,
> > +                group, fd, response, response_struct->extra_info_type, count);
> > +       if (fd < 0)
> > +               return -EINVAL;
> >         /*
> >          * make sure the response is valid, if invalid we do nothing and either
> >          * userspace can send a valid response or we will clean it up after the
> >          * timeout
> >          */
> > -       switch (response & ~FAN_AUDIT) {
> > -       case FAN_ALLOW:
> > -       case FAN_DENY:
> > -               break;
> > -       default:
> > -               return -EINVAL;
> > -       }
> > -
> > -       if (fd < 0)
> > +       if (FAN_INVALID_RESPONSE_MASK(response))
> 
> That is a logic change, because now the response value of 0 becomes valid.
> 
> Since you did not document this change in the commit message I assume this was
> non intentional?
> However, this behavior change is something that I did ask for, but it should be
> done is a separate commit:
> 
>  /* These are NOT bitwise flags.  Both bits can be used together.  */
> #define FAN_TEST          0x00
> #define FAN_ALLOW       0x01
> #define FAN_DENY        0x02
> #define FANOTIFY_RESPONSE_ACCESS \
>             (FAN_TEST|FAN_ALLOW | FAN_DENY)
> 
> ...
> int access = response & FANOTIFY_RESPONSE_ACCESS;
> 
> 1. Do return EINVAL for access == 0
> 2. Let all the rest of the EINVAL checks run (including extra type)
> 3. Move if (fd < 0) to last check
> 4. Add if (!access) return 0 before if (fd < 0)
> 
> That will provide a mechanism for userspace to probe the
> kernel support for extra types in general and specific types
> that it may respond with.

I have to admit I didn't quite grok your suggestion here although I
understand (and agree with) the general direction of the proposal :). Maybe
code would explain it better what you have in mind?

> > +/*
> > + * User space may need to record additional information about its decision.
> > + * The extra information type records what kind of information is included.
> > + * The default is none. We also define an extra informaion buffer whose
> 
> typo: informaion
> 
> > + * size is determined by the extra information type.
> > + *
> > + * If the context type is Rule, then the context following is the rule number
> > + * that triggered the user space decision.
> > + */
> > +
> > +#define FAN_RESPONSE_INFO_NONE         0
> > +#define FAN_RESPONSE_INFO_AUDIT_RULE   1
> > +
> > +union fanotify_response_extra {
> > +       __u32 audit_rule;
> > +};
> > +
> >  struct fanotify_response {
> >         __s32 fd;
> >         __u32 response;
> > +       __u32 extra_info_type;
> > +       union fanotify_response_extra extra_info;
> 
> IIRC, Jan wanted this to be a variable size record with info_type and info_len.
> I don't know if we want to make this flexible enough to allow for multiple
> records in the future like we do in events, but the common wisdom of
> the universe says that if we don't do it, we will need it.

Yes, please no unions in the API, that is always painful with the
alignment, size etc. What I had in mind was:

Keep fanotify_response as is:

struct fanotify_response {
	__s32 fd;
	__u32 response;
};

Define extra info header:

struct fanotify_response_info_header {
	__u8 info_type;
	__u8 pad;
	__u16 len;
};

And then struct for your audit rule:

struct fanotify_response_info_audit_rule {
	struct fanotify_response_info_header hdr;
	__u32 audit_rule;
};

The verification in fanotify_write() then goes like:

	struct fanotify_response response;
	char extra_info_buf[sizeof(struct fanotify_response_info_audit_rule)];

	if (copy_from_user(&response, buf, sizeof(response)))
		return -EFAULT;

	if (!(response.response & FAN_EXTRA_INFO)) {
		count = 0;
	} else {
		count -= sizeof(response);

		/* Simplistic parsing for now */
		if (count != sizeof(struct fanotify_response_info_audit_rule))
			return -EINVAL;
		if (copy_from_user(extra_info_buf, buf, count)
			return -EFAULT;
	}

	ret = process_access_response(group, &response, extra_info_buf, count);

And we pass extra_info_buf and count to audit_fanotify() where we need to do
further validation like: 

	struct fanotify_response_info_audit_rule *audit_response = NULL;

	if (count > 0) {
		/* Just one possible info type for now */
		audit_response = (struct fanotify_response_info_audit_rule *)extra_info_buf;
		if (audit_response->info_type != FAN_RESPONSE_INFO_AUDIT_RULE)
			return -EINVAL;
		if (audit_response->pad != 0)
			return -EINVAL;
		if (audit_response->len != sizeof(*audit_response))
			return -EINVAL;
	}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
