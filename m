Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA54E519387
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 03:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245194AbiEDBh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 21:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245120AbiEDBh0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 21:37:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 328B020F49
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 18:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651628031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n2aBf4KQxQM2oI1uXoYV7Xqy3Cs9Qx0SckbbyhTqMDQ=;
        b=OaJc9jemFPY9fBZ+0lqOdQXZXmvw7/sFIGDhhxcXSRZywgtmaN4Z4clAlPudyCQPEownmb
        /55j7H4wlxga3SGB8ufMt2JDADxK++f3qAo6we7+yheyJpMbQrCEbUuxlGrl9NHOphiPpP
        WoBBdHBu6SUJ1MYVNnSAxVUkF5NCJ54=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-EE3N9Z4HN8Sll_PP1TV7Vw-1; Tue, 03 May 2022 21:33:48 -0400
X-MC-Unique: EE3N9Z4HN8Sll_PP1TV7Vw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C907693236A;
        Wed,  4 May 2022 01:33:47 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.48.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 27739111CD35;
        Wed,  4 May 2022 01:33:37 +0000 (UTC)
Date:   Tue, 3 May 2022 21:33:35 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 2/3] fanotify: define struct members to hold response
 decision context
Message-ID: <YnHX74E+COTp7AgY@madcap2.tricolour.ca>
References: <cover.1651174324.git.rgb@redhat.com>
 <17660b3f2817e5c0a19d1e9e5d40b53ff4561845.1651174324.git.rgb@redhat.com>
 <CAHC9VhQ3Qtpwhj6TeMR7rmdbUe_6VRHU9OymmDoDdsazeGuNKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQ3Qtpwhj6TeMR7rmdbUe_6VRHU9OymmDoDdsazeGuNKA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-05-02 20:16, Paul Moore wrote:
> On Thu, Apr 28, 2022 at 8:45 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > This patch adds 2 structure members to the response returned from user
> > space on a permission event. The first field is 16 bits for the context
> > type.  The context type will describe what the meaning is of the second
> > field. The default is none. The patch defines one additional context
> > type which means that the second field is a 32-bit rule number. This
> > will allow for the creation of other context types in the future if
> > other users of the API identify different needs.  The second field size
> > is defined by the context type and can be used to pass along the data
> > described by the context.
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
> > Link: https://lore.kernel.org/r/17660b3f2817e5c0a19d1e9e5d40b53ff4561845.1651174324.git.rgb@redhat.com
> > ---
> >  fs/notify/fanotify/fanotify.c      |  1 -
> >  fs/notify/fanotify/fanotify.h      |  4 +-
> >  fs/notify/fanotify/fanotify_user.c | 59 ++++++++++++++++++++----------
> >  include/linux/fanotify.h           |  3 ++
> >  include/uapi/linux/fanotify.h      | 27 +++++++++++++-
> >  5 files changed, 72 insertions(+), 22 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > index 985e995d2a39..00aff6e29bf8 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -266,7 +266,6 @@ static int fanotify_get_response(struct fsnotify_group *group,
> >         case FAN_ALLOW:
> >                 ret = 0;
> >                 break;
> > -       case FAN_DENY:
> 
> I personally would drop this from the patch if it was me, it doesn't
> change the behavior so it falls under the "noise" category, which
> could be a problem considering the lack of response on the original
> posting and this one.  Small, focused patches have a better shot of
> review/merging.

It was a harmless part of the original patch, but I agree it should go.

> >         default:
> >                 ret = -EPERM;
> >         }
> 
> ...
> 
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index 694516470660..f1ff4cf683fb 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -289,13 +289,19 @@ static int create_fd(struct fsnotify_group *group, struct path *path,
> >   */
> >  static void finish_permission_event(struct fsnotify_group *group,
> >                                     struct fanotify_perm_event *event,
> > -                                   __u32 response)
> > +                                   struct fanotify_response *response)
> >                                     __releases(&group->notification_lock)
> >  {
> >         bool destroy = false;
> >
> >         assert_spin_locked(&group->notification_lock);
> > -       event->response = response;
> > +       event->response = response->response;
> > +       event->extra_info_type = response->extra_info_type;
> > +       switch (event->extra_info_type) {
> > +       case FAN_RESPONSE_INFO_AUDIT_RULE:
> > +               memcpy(event->extra_info_buf, response->extra_info_buf,
> > +                      sizeof(struct fanotify_response_audit_rule));
> 
> Since the fanotify_perm_event:extra_info_buf and
> fanotify_response:extra_info_buf are the same type/length, and they
> will be the same regardless of the extra_info_type field, why not
> simply get rid of the above switch statement and do something like
> this:
> 
>   memcpy(event->extra_info_buf, response->extra_info_buf,
>          sizeof(response->extra_info_buf));

I've been wrestling with the possibility of doing a split between what
is presented to userspace and what's used in the kernel for struct
fanotify_response, while attempting to future-proof it.

At the moment, since the extra_info_buf is either zero or has a fixed
size for the "RULE" type, it seemed to be most efficient to do a static
allocation on the stack upon entry into fanotify_write() that was
only 4 octets more than the type "NONE" case.  Later, if a new type has
a variable extra_info_buf size, it can be internally allocated
dynamically.

> > +       }
> >         if (event->state == FAN_EVENT_CANCELED)
> >                 destroy = true;
> >         else
> 
> ...
> 
> > @@ -827,26 +845,25 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
> >
> >  static ssize_t fanotify_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
> >  {
> > -       struct fanotify_response response = { .fd = -1, .response = -1 };
> > +       struct fanotify_response response;
> >         struct fsnotify_group *group;
> >         int ret;
> > +       size_t size = min(count, sizeof(struct fanotify_response));
> >
> >         if (!IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
> >                 return -EINVAL;
> >
> >         group = file->private_data;
> >
> > -       if (count < sizeof(response))
> > +       if (count < offsetof(struct fanotify_response, extra_info_buf))
> >                 return -EINVAL;
> 
> Is this why you decided to shrink the fanotify_response:response field
> from 32-bits to 16-bits?  I hope not.  I would suggest both keeping
> the existing response field as 32-bits and explicitly checking for
> writes that are either the existing/compat length as well as the
> newer, longer length.

No.  I shrank it at Jan's suggestion.  I think I agree with you that
the response field should be kept at u32 as it is defined in userspace
and purge the doubt about what would happen with a new userspace with
an old kernel.

> > -       count = sizeof(response);
> > -
> >         pr_debug("%s: group=%p count=%zu\n", __func__, group, count);
> >
> > -       if (copy_from_user(&response, buf, count))
> > +       if (copy_from_user(&response, buf, size))
> >                 return -EFAULT;
> >
> > -       ret = process_access_response(group, &response);
> > +       ret = process_access_response(group, &response, count);
> >         if (ret < 0)
> >                 count = ret;
> >
> 
> ...
> 
> > diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> > index e8ac38cc2fd6..efb5a3a6f814 100644
> > --- a/include/uapi/linux/fanotify.h
> > +++ b/include/uapi/linux/fanotify.h
> > @@ -179,9 +179,34 @@ struct fanotify_event_info_error {
> >         __u32 error_count;
> >  };
> >
> > +/*
> > + * User space may need to record additional information about its decision.
> > + * The extra information type records what kind of information is included.
> > + * The default is none. We also define an extra informaion buffer whose
> > + * size is determined by the extra information type.
> > + *
> > + * If the context type is Rule, then the context following is the rule number
> > + * that triggered the user space decision.
> > + */
> > +
> > +#define FAN_RESPONSE_INFO_AUDIT_NONE   0
> > +#define FAN_RESPONSE_INFO_AUDIT_RULE   1
> > +
> > +struct fanotify_response_audit_rule {
> > +       __u32 rule;
> > +};
> > +
> > +#define FANOTIFY_RESPONSE_EXTRA_LEN_MAX        \
> > +       (sizeof(union { \
> > +               struct fanotify_response_audit_rule r; \
> > +               /* add other extra info structures here */ \
> > +       }))
> > +
> >  struct fanotify_response {
> >         __s32 fd;
> > -       __u32 response;
> > +       __u16 response;
> > +       __u16 extra_info_type;
> > +       char extra_info_buf[FANOTIFY_RESPONSE_EXTRA_LEN_MAX];
> >  };
> 
> Since both the kernel and userspace are going to need to agree on the
> content and formatting of the fanotify_response:extra_info_buf field,
> why is it hidden behind a char array?  You might as well get rid of
> that abstraction and put the union directly in the fanotify_response
> struct.  It is possible you could also get rid of the
> fanotify_response_audit_rule struct this way too and just access the
> rule scalar directly.

This does make sense and my only concern would be a variable-length
type.  There isn't any reason to hide it.  If userspace chooses to use
the old interface and omit the type field then it defaults to NONE.

If future types with variable data are defined, the first field could be
a u32 that unions with the rule number that won't change the struct
size.

Thanks for the feedback.

> paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

