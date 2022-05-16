Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFCD5292A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 23:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348773AbiEPVKF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 17:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349237AbiEPVJv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 17:09:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 13E3640A15
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 13:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652734395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lx6fMtvYSFtR17VOb5ndPu7Ip90p3B/5jvm8Z2oW2B8=;
        b=Q82bpWxrXeO3PfTz1DKtAYW64KWvBWT2oYiKw4qINeY8OgURfMhWaDq7TNV6jcf8ObfO+2
        AQnsakBmkf7Rg9SUf49ohJN/ajuJV9ldClt8a4UUXE6g0eUGKbNlft+tLcaVzO2YTld9UG
        LCn104j0Y4r4Z+iT48CHwdLLOqQwtc4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-613-AbIpmVwNMzuxid6hih_3Ow-1; Mon, 16 May 2022 16:53:11 -0400
X-MC-Unique: AbIpmVwNMzuxid6hih_3Ow-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 725B93C02B70;
        Mon, 16 May 2022 20:53:11 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FE60492C14;
        Mon, 16 May 2022 20:53:10 +0000 (UTC)
Date:   Mon, 16 May 2022 16:53:08 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Paul Moore <paul@paul-moore.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v2 2/3] fanotify: define struct members to hold response
 decision context
Message-ID: <YoK5tAy631AtZakH@madcap2.tricolour.ca>
References: <cover.1651174324.git.rgb@redhat.com>
 <17660b3f2817e5c0a19d1e9e5d40b53ff4561845.1651174324.git.rgb@redhat.com>
 <CAHC9VhQ3Qtpwhj6TeMR7rmdbUe_6VRHU9OymmDoDdsazeGuNKA@mail.gmail.com>
 <YnHX74E+COTp7AgY@madcap2.tricolour.ca>
 <20220505144456.nw6slyqw4pjizl5p@quack3.lan>
 <YnVtGRmrZpvoaEKg@madcap2.tricolour.ca>
 <20220509085440.uu27woqb3qkfmyvs@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509085440.uu27woqb3qkfmyvs@quack3.lan>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-05-09 10:54, Jan Kara wrote:
> On Fri 06-05-22 14:46:49, Richard Guy Briggs wrote:
> > On 2022-05-05 16:44, Jan Kara wrote:
> > > On Tue 03-05-22 21:33:35, Richard Guy Briggs wrote:
> > > > On 2022-05-02 20:16, Paul Moore wrote:
> > > > > On Thu, Apr 28, 2022 at 8:45 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > > This patch adds 2 structure members to the response returned from user
> > > > > > space on a permission event. The first field is 16 bits for the context
> > > > > > type.  The context type will describe what the meaning is of the second
> > > > > > field. The default is none. The patch defines one additional context
> > > > > > type which means that the second field is a 32-bit rule number. This
> > > > > > will allow for the creation of other context types in the future if
> > > > > > other users of the API identify different needs.  The second field size
> > > > > > is defined by the context type and can be used to pass along the data
> > > > > > described by the context.
> > > > > >
> > > > > > To support this, there is a macro for user space to check that the data
> > > > > > being sent is valid. Of course, without this check, anything that
> > > > > > overflows the bit field will trigger an EINVAL based on the use of
> > > > > > FAN_INVALID_RESPONSE_MASK in process_access_response().
> > > > > >
> > > 
> > > ...
> > > 
> > > > > >  static ssize_t fanotify_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
> > > > > >  {
> > > > > > -       struct fanotify_response response = { .fd = -1, .response = -1 };
> > > > > > +       struct fanotify_response response;
> > > > > >         struct fsnotify_group *group;
> > > > > >         int ret;
> > > > > > +       size_t size = min(count, sizeof(struct fanotify_response));
> > > > > >
> > > > > >         if (!IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
> > > > > >                 return -EINVAL;
> > > > > >
> > > > > >         group = file->private_data;
> > > > > >
> > > > > > -       if (count < sizeof(response))
> > > > > > +       if (count < offsetof(struct fanotify_response, extra_info_buf))
> > > > > >                 return -EINVAL;
> > > > > 
> > > > > Is this why you decided to shrink the fanotify_response:response field
> > > > > from 32-bits to 16-bits?  I hope not.  I would suggest both keeping
> > > > > the existing response field as 32-bits and explicitly checking for
> > > > > writes that are either the existing/compat length as well as the
> > > > > newer, longer length.
> > > > 
> > > > No.  I shrank it at Jan's suggestion.  I think I agree with you that
> > > > the response field should be kept at u32 as it is defined in userspace
> > > > and purge the doubt about what would happen with a new userspace with
> > > > an old kernel.
> > > 
> > > Hum, for the life of me I cannot find my response you mention here. Can you
> > > send a link so that I can refresh my memory? It has been a long time...
> > 
> > https://listman.redhat.com/archives/linux-audit/2020-October/017066.html
> > https://listman.redhat.com/archives/linux-audit/2020-October/017067.html
> 
> Thanks!
> 
> > > > > > +
> > > > > > +#define FANOTIFY_RESPONSE_EXTRA_LEN_MAX        \
> > > > > > +       (sizeof(union { \
> > > > > > +               struct fanotify_response_audit_rule r; \
> > > > > > +               /* add other extra info structures here */ \
> > > > > > +       }))
> > > > > > +
> > > > > >  struct fanotify_response {
> > > > > >         __s32 fd;
> > > > > > -       __u32 response;
> > > > > > +       __u16 response;
> > > > > > +       __u16 extra_info_type;
> > > > > > +       char extra_info_buf[FANOTIFY_RESPONSE_EXTRA_LEN_MAX];
> > > > > >  };
> > > > > 
> > > > > Since both the kernel and userspace are going to need to agree on the
> > > > > content and formatting of the fanotify_response:extra_info_buf field,
> > > > > why is it hidden behind a char array?  You might as well get rid of
> > > > > that abstraction and put the union directly in the fanotify_response
> > > > > struct.  It is possible you could also get rid of the
> > > > > fanotify_response_audit_rule struct this way too and just access the
> > > > > rule scalar directly.
> > > > 
> > > > This does make sense and my only concern would be a variable-length
> > > > type.  There isn't any reason to hide it.  If userspace chooses to use
> > > > the old interface and omit the type field then it defaults to NONE.
> > > > 
> > > > If future types with variable data are defined, the first field could be
> > > > a u32 that unions with the rule number that won't change the struct
> > > > size.
> > > 
> > > Struct fanotify_response size must not change, it is part of the kernel
> > > ABI. In particular your above change would break userspace code that is
> > > currently working just fine (e.g. allocating 8 bytes and expecting struct
> > > fanotify_response fits there, or just writing sizeof(struct
> > > fanotify_response) as a response while initializing only first 8 bytes).
> > 
> > Many kernel ABIs have been expanded without breaking them.
> > 
> > Is it reasonable for a userspace program to use a kernel structure
> > without also using its size for allocation and initialization?
> 
> Well, I'm not sure whether to call it reasonable but it certainly happens
> and we are generally obliged to keep backwards compatibility (the golden
> "don't break userspace" rule).

There's a lot of stupid things userspace could do that would render it
impossible to ever change or improve anything, including fixing security
bugs, with that absolutist approach.

> > > How I'd suggest doing it now (and I'd like to refresh my memory from my
> > > past emails you mention because in the past I might have thought something
> > > else ;)) is that you add another flag to 'response' field similar to
> > > FAN_AUDIT - like FAN_EXTRA_INFO. If that is present, it means extra info is
> > > to be expected after struct fanotify_response.
> > 
> > That's an interesting possibility...  I'm trying to predict if that
> > would be a problem for an old kernel...  In process_access_response() it
> > would fallthrough to the default case of -EINVAL but do so safely.
> 
> Yes, old kernel would just refuse such response so new userspace can adapt
> to that.

Fair enough.

> > > The extra info would always start with a header like:
> > > 
> > > struct fanotify_response_info_header {
> > >         __u8 info_type;
> > >         __u8 pad;
> > >         __u16 len;		/* This is including the header itself */
> > > }
> > > 
> > > And after such header there would be the 'blob' of data 'len - header size'
> > > long.  We use this same scheme when passing fanotify events to userspace
> > > and it has proven to be lightweight and extensible. It covers the situation
> > > when in the future audit would decide it wants other data (just change data
> > > type), it would also cover the situation when some other subsystem wants
> > > its information passed as well - there can be more structures like this
> > > attached at the end, we can process the response up to the length of the
> > > write.
> > 
> > This reminds me of the RFC2367 (PF_KEYv2, why is that still right there
> > at the tip of my fingers?)
> > 
> > > Now these are just possible future extensions making sure we can extend the
> > > ABI without too much pain. In the current implementation I'd just return
> > > EINVAL whenever more than FANOTIFY_RESPONSE_MAX_LEN (16 bytes) is written 
> > > and do very strict checks on what gets passed in. It is also trivially
> > > backwards compatible (old userspace on new kernel works just fine).
> > 
> > Old userspace on new kernel would work fine with this idea, the v2 patch
> > posted, or with leaving the response field of struct fanotify_response
> > as __u32.
> 
> So I've realized the idea to reduce 'response' field to __u16 will not work
> for big endian architectures (that was a thinko of my old suggestion from
> 2020). Old userspace binaries will break with that.  So we have to keep
> 'response' to __u32 and just add a flag like I'm suggesting now or
> something like that.

Ok, this is the nagging suspicion I had.  This decides it in favour of
not changing that u32 response.

> > > If you want to achieve compatibility of running new userspace on old kernel
> > > (I guess that's desirable), we have group flags for that - like we
> > > introduced FAN_ENABLE_AUDIT to allow for FAN_AUDIT flag in response we now
> > > need to add a flag like FAN_EXTENDED_PERMISSION_INFO telling the kernel it
> > > should expect an allow more info returning for permission events. At the
> > > same time this is the way for userspace to be able to tell whether the
> > > kernel supports this. I know this sounds tedious but that's the cost of
> > > extending the ABI in the compatible way. We've made various API mistakes in
> > > the past having to add weird workarounds to fanotify and we don't want to
> > > repeat those mistakes :).
> > > 
> > > One open question I have is what should the kernel do with 'info_type' in
> > > response it does not understand (in the future when there are possibly more
> > > different info types). It could just skip it because this should be just
> > > additional info for introspection (the only mandatory part is in
> > > fanotify_response, however it could surprise userspace that passed info is
> > > just getting ignored. To solve this we would have to somewhere report
> > > supported info types (maybe in fanotify fdinfo in proc). I guess we'll
> > > cross that bridge when we get to it.
> > 
> > Well, one possibility is to return -EINVAL to signal the kernel is out
> > of date.
> 
> Yes, I think we've settled with Amir on returning -EINVAL in case unknown
> info is spotted.

Good.

> 								Honza
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

