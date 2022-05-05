Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128D151CC42
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 00:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352168AbiEEWrS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 18:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiEEWrR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 18:47:17 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEBD61CB11
        for <linux-fsdevel@vger.kernel.org>; Thu,  5 May 2022 15:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651790614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S++xEoaPk3awdld4uih1hEghHCgcjhVrUG43SeATCCQ=;
        b=M99hwUuDaspCmCWbjxjrkHxhtEy+3ubzvHdJmNO2kb9KNutmdntimCnWrWeKUpdMtbhZf6
        SOCKoMVXh4DrDC2KlJN1BYNguri/HboyIiCPAVGjre4pdEqTK7zEWUTrHSFdreEpK3WqNh
        xqXj2ze7jXhp19nUURYbwV9UJ9sCAJs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-wLwg2hWYO8mEl1vRrg8ugA-1; Thu, 05 May 2022 18:43:31 -0400
X-MC-Unique: wLwg2hWYO8mEl1vRrg8ugA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 284B780B71C;
        Thu,  5 May 2022 22:43:31 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.10.83])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E3F540CF900;
        Thu,  5 May 2022 22:43:30 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>
Cc:     Paul Moore <paul@paul-moore.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2 2/3] fanotify: define struct members to hold response decision context
Date:   Thu, 05 May 2022 18:43:29 -0400
Message-ID: <3488909.R56niFO833@x2>
Organization: Red Hat
In-Reply-To: <20220505144456.nw6slyqw4pjizl5p@quack3.lan>
References: <cover.1651174324.git.rgb@redhat.com> <YnHX74E+COTp7AgY@madcap2.tricolour.ca> <20220505144456.nw6slyqw4pjizl5p@quack3.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Jan,

On Thursday, May 5, 2022 10:44:56 AM EDT Jan Kara wrote:
> On Tue 03-05-22 21:33:35, Richard Guy Briggs wrote:
> > On 2022-05-02 20:16, Paul Moore wrote:
> > > On Thu, Apr 28, 2022 at 8:45 PM Richard Guy Briggs <rgb@redhat.com> 
wrote:
> > > > This patch adds 2 structure members to the response returned from
> > > > user
> > > > space on a permission event. The first field is 16 bits for the
> > > > context
> > > > type.  The context type will describe what the meaning is of the
> > > > second
> > > > field. The default is none. The patch defines one additional context
> > > > type which means that the second field is a 32-bit rule number. This
> > > > will allow for the creation of other context types in the future if
> > > > other users of the API identify different needs.  The second field
> > > > size
> > > > is defined by the context type and can be used to pass along the data
> > > > described by the context.
> > > > 
> > > > To support this, there is a macro for user space to check that the
> > > > data
> > > > being sent is valid. Of course, without this check, anything that
> > > > overflows the bit field will trigger an EINVAL based on the use of
> > > > FAN_INVALID_RESPONSE_MASK in process_access_response().
> 
> ...
> 
> > > >  static ssize_t fanotify_write(struct file *file, const char __user
> > > >  *buf, size_t count, loff_t *pos) {
> > > > 
> > > > -       struct fanotify_response response = { .fd = -1, .response =
> > > > -1 };
> > > > +       struct fanotify_response response;
> > > > 
> > > >         struct fsnotify_group *group;
> > > >         int ret;
> > > > 
> > > > +       size_t size = min(count, sizeof(struct fanotify_response));
> > > > 
> > > >         if (!IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
> > > >         
> > > >                 return -EINVAL;
> > > >         
> > > >         group = file->private_data;
> > > > 
> > > > -       if (count < sizeof(response))
> > > > +       if (count < offsetof(struct fanotify_response,
> > > > extra_info_buf))
> > > > 
> > > >                 return -EINVAL;
> > > 
> > > Is this why you decided to shrink the fanotify_response:response field
> > > from 32-bits to 16-bits?  I hope not.  I would suggest both keeping
> > > the existing response field as 32-bits and explicitly checking for
> > > writes that are either the existing/compat length as well as the
> > > newer, longer length.
> > 
> > No.  I shrank it at Jan's suggestion.  I think I agree with you that
> > the response field should be kept at u32 as it is defined in userspace
> > and purge the doubt about what would happen with a new userspace with
> > an old kernel.
> 
> Hum, for the life of me I cannot find my response you mention here. Can you
> send a link so that I can refresh my memory? It has been a long time...

It was this thread:

https://marc.info/?t=160148236400005&r=1&w=2

-Steve

> > > > +
> > > > +#define FANOTIFY_RESPONSE_EXTRA_LEN_MAX        \
> > > > +       (sizeof(union { \
> > > > +               struct fanotify_response_audit_rule r; \
> > > > +               /* add other extra info structures here */ \
> > > > +       }))
> > > > +
> > > > 
> > > >  struct fanotify_response {
> > > >  
> > > >         __s32 fd;
> > > > 
> > > > -       __u32 response;
> > > > +       __u16 response;
> > > > +       __u16 extra_info_type;
> > > > +       char extra_info_buf[FANOTIFY_RESPONSE_EXTRA_LEN_MAX];
> > > > 
> > > >  };
> > > 
> > > Since both the kernel and userspace are going to need to agree on the
> > > content and formatting of the fanotify_response:extra_info_buf field,
> > > why is it hidden behind a char array?  You might as well get rid of
> > > that abstraction and put the union directly in the fanotify_response
> > > struct.  It is possible you could also get rid of the
> > > fanotify_response_audit_rule struct this way too and just access the
> > > rule scalar directly.
> > 
> > This does make sense and my only concern would be a variable-length
> > type.  There isn't any reason to hide it.  If userspace chooses to use
> > the old interface and omit the type field then it defaults to NONE.
> > 
> > If future types with variable data are defined, the first field could be
> > a u32 that unions with the rule number that won't change the struct
> > size.
> 
> Struct fanotify_response size must not change, it is part of the kernel
> ABI. In particular your above change would break userspace code that is
> currently working just fine (e.g. allocating 8 bytes and expecting struct
> fanotify_response fits there, or just writing sizeof(struct
> fanotify_response) as a response while initializing only first 8 bytes).
> How I'd suggest doing it now (and I'd like to refresh my memory from my
> past emails you mention because in the past I might have thought something
> else ;)) is that you add another flag to 'response' field similar to
> FAN_AUDIT - like FAN_EXTRA_INFO. If that is present, it means extra info is
> to be expected after struct fanotify_response. The extra info would always
> start with a header like:
> 
> struct fanotify_response_info_header {
>         __u8 info_type;
>         __u8 pad;
>         __u16 len;		/* This is including the header itself */
> }
> 
> And after such header there would be the 'blob' of data 'len - header size'
> long.  We use this same scheme when passing fanotify events to userspace
> and it has proven to be lightweight and extensible. It covers the
> situation when in the future audit would decide it wants other data (just
> change data type), it would also cover the situation when some other
> subsystem wants its information passed as well - there can be more
> structures like this attached at the end, we can process the response up
> to the length of the write.
> 
> Now these are just possible future extensions making sure we can extend the
> ABI without too much pain. In the current implementation I'd just return
> EINVAL whenever more than FANOTIFY_RESPONSE_MAX_LEN (16 bytes) is written
> and do very strict checks on what gets passed in. It is also trivially
> backwards compatible (old userspace on new kernel works just fine).
> 
> If you want to achieve compatibility of running new userspace on old kernel
> (I guess that's desirable), we have group flags for that - like we
> introduced FAN_ENABLE_AUDIT to allow for FAN_AUDIT flag in response we now
> need to add a flag like FAN_EXTENDED_PERMISSION_INFO telling the kernel it
> should expect an allow more info returning for permission events. At the
> same time this is the way for userspace to be able to tell whether the
> kernel supports this. I know this sounds tedious but that's the cost of
> extending the ABI in the compatible way. We've made various API mistakes
> in the past having to add weird workarounds to fanotify and we don't want
> to repeat those mistakes :).
> 
> One open question I have is what should the kernel do with 'info_type' in
> response it does not understand (in the future when there are possibly more
> different info types). It could just skip it because this should be just
> additional info for introspection (the only mandatory part is in
> fanotify_response, however it could surprise userspace that passed info is
> just getting ignored. To solve this we would have to somewhere report
> supported info types (maybe in fanotify fdinfo in proc). I guess we'll
> cross that bridge when we get to it.
> 
> Amir, what do you think?
> 
> 								Honza




