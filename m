Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8254599AFC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 13:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348802AbiHSLZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 07:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348819AbiHSLYw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:24:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685A7DA3C6;
        Fri, 19 Aug 2022 04:24:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 17E4C34450;
        Fri, 19 Aug 2022 11:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660908289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X71bsXQe8X2f7i/wXt+ZaSMOEJy6QPzm6trBFKfJVg4=;
        b=wSJow9AcSgg3Gh+KlijcBCh0yKDvH2+oVWlKE1M7jaD+ds6m1txscyAlqKbsMJI48k7qvI
        o05HJChUiE05yWV01tisn5upkQvq+6I2mGPk961MEfQGwHWrqM8I7rikZq9IJLDHvs8nho
        a9u+9BoEv0NxKoOSuLXSluohOJsYbmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660908289;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X71bsXQe8X2f7i/wXt+ZaSMOEJy6QPzm6trBFKfJVg4=;
        b=aVrT3+KO7RULInVTdRKbngA/gi84S5COyCdI15brX97/QfYBfXrCPYwkqh5YVHCL7n7RKd
        jf+Q1f7bubrM3bAQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E2A862C141;
        Fri, 19 Aug 2022 11:24:48 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9CD90A0635; Fri, 19 Aug 2022 13:24:48 +0200 (CEST)
Date:   Fri, 19 Aug 2022 13:24:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] fanotify: define struct members to hold response
 decision context
Message-ID: <20220819112448.poyke7hqcqrnolg5@quack3>
References: <cover.1659996830.git.rgb@redhat.com>
 <8767f3a0d43d6a994584b86c03eb659a662cc416.1659996830.git.rgb@redhat.com>
 <CAOQ4uxjWCyFNATVmAcgOa8HNk6Upj+PPrJF7DA9V-4LjOGAALA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjWCyFNATVmAcgOa8HNk6Upj+PPrJF7DA9V-4LjOGAALA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 10-08-22 08:22:49, Amir Goldstein wrote:
> [+linux-api]
> 
> On Tue, Aug 9, 2022 at 7:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> >
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

> >  static int process_access_response(struct fsnotify_group *group,
> > -                                  struct fanotify_response *response_struct)
> > +                                  struct fanotify_response *response_struct,
> > +                                  const char __user *buf,
> > +                                  size_t count)
> >  {
> >         struct fanotify_perm_event *event;
> >         int fd = response_struct->fd;
> >         u32 response = response_struct->response;
> > +       struct fanotify_response_info_header info_hdr;
> > +       char *info_buf = NULL;
> >
> > -       pr_debug("%s: group=%p fd=%d response=%u\n", __func__, group,
> > -                fd, response);
> > +       pr_debug("%s: group=%p fd=%d response=%u buf=%p size=%lu\n", __func__,
> > +                group, fd, response, info_buf, count);
> >         /*
> >          * make sure the response is valid, if invalid we do nothing and either
> >          * userspace can send a valid response or we will clean it up after the
> >          * timeout
> >          */
> > -       switch (response & ~FAN_AUDIT) {
> > +       if (response & ~FANOTIFY_RESPONSE_VALID_MASK)
> > +               return -EINVAL;
> > +       switch (response & FANOTIFY_RESPONSE_ACCESS) {
> >         case FAN_ALLOW:
> >         case FAN_DENY:
> >                 break;
> >         default:
> >                 return -EINVAL;
> >         }
> > -
> > -       if (fd < 0)
> > -               return -EINVAL;
> > -
> >         if ((response & FAN_AUDIT) && !FAN_GROUP_FLAG(group, FAN_ENABLE_AUDIT))
> >                 return -EINVAL;
> > +       if (fd < 0)
> > +               return -EINVAL;
> 
> Since you did not accept my suggestion of FAN_TEST [1],
> I am not sure why this check was moved.
> 
> However, if you move this check past FAN_INFO processing,
> you could change the error value to -ENOENT, same as the return value
> for an fd that is >= 0 but does not correspond to any pending
> permission event.
> 
> The idea was that userspace could write a test
> fanotify_response_info_audit_rule payload to fanotify fd with FAN_NOFD
> in the response.fd field.
> On old kernel, this will return EINVAL.
> On new kernel, if the fanotify_response_info_audit_rule payload
> passes all the validations, this will do nothing and return ENOENT.
> 
> [1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxi+8HUqyGxQBNMqSong92nreOWLKdy9MCrYg8wgW9Dj4g@mail.gmail.com/

Yes. Richard, if you don't like the FAN_TEST proposal from Amir, please
explain (preferably also with sample code) how you imagine userspace will
decide whether to use FAN_INFO flag in responses or not. Because if it will
just blindly set it, that will result in all permission events to finished
with EPERM for kernels not recognizing FAN_INFO.

> > -       if (count < sizeof(response))
> > -               return -EINVAL;
> > -
> > -       count = sizeof(response);
> > -
> >         pr_debug("%s: group=%p count=%zu\n", __func__, group, count);
> >
> > -       if (copy_from_user(&response, buf, count))
> > +       if (count < sizeof(response))
> > +               return -EINVAL;
> > +       if (copy_from_user(&response, buf, sizeof(response)))
> >                 return -EFAULT;
> >
> > -       ret = process_access_response(group, &response);
> > +       c = count - sizeof(response);
> > +       if (response.response & FAN_INFO) {
> > +               if (c < sizeof(struct fanotify_response_info_header))
> > +                       return -EINVAL;
> 
> Should FAN_INFO require FAN_AUDIT?

Currently we could but longer term not all additional info needs to be
related to audit so probably I'd not require that even now (which results
in info being effectively ignored after it is parsed).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
