Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FE0517B32
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 02:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiECATr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 20:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiECATq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 20:19:46 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EC22E0B3
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 May 2022 17:16:13 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b19so21350491wrh.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 May 2022 17:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kNk9ImiYyqs8H6PNkDNCstB2cSVahuRXdiPtWKtJN2c=;
        b=gF3NudlKE9cIBsVfyQYNBNcbiiEawjKgsk4NJn7Z3SN68TAr3NHMYtHWNUbXNG9b4M
         dNvPk1jdkXURu0uTDUGsRkRASLWGdXQlVnnFMstEqgCxLjN/qkjW1Ox9wos1Yf3p3WVI
         nqcViWTSZnYZrnrzpPwwrpEnuObEgrAUMlepzGoj0HPpGNfXXwiyB5NgLUiwDsH9R6H/
         1VpahIb0WwHGxypqkpGPN9MkjO6DpG8gy6AOfD3PvrbPjxiFaCEL5UbniSUygo42Tltp
         XBerRNHnAu9pOKrbBpPf27G6i9Z0SYqPBp19rfzypXuCYzsjC99T2tQTgIQToxpYvSs2
         vcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kNk9ImiYyqs8H6PNkDNCstB2cSVahuRXdiPtWKtJN2c=;
        b=meZx/nxyvJ1EpgLooms7nMuI77ft5suB8G70YG1RBDnN5DJPuXxEkVkc5EnxSx2zMB
         Lm0kDy/qmIDS2eBGBI6ghMgvVhuC7ZzG20MyzfZ3ZAFDTzIAChI9NVBEQRGFHR2EAiUE
         VLQlTict5toEhZsuWIK0m/Ac0Y/26ChElL4ll903Ppaz+rN5iQRhzOJOTgRrGJDGm3QP
         +4/Euq3gorBHA/PduKCA62RDjLjNkPi2Us5DwVGTI1/LHTIXdIm6E7JNbFZnVSHVf7m5
         oVZhp/0JUT1ORSj46huAvQOLahz9IirYMQuW6xMUNODK/MfQqbYMu2ACwNTLJpJAOK/H
         YVqg==
X-Gm-Message-State: AOAM532x+knnEdhE1ikL8g9cJC0P5cwkMavPvzw0gR7aaryrroswG7Pu
        8aAWwjuUOCIExAKMG53yLA+wTEsRHNkyeTH88Yhx
X-Google-Smtp-Source: ABdhPJwDXnvkzuQrsg4jjJ6lrmrJ0weOxLB6OlBDXrFnAsmV6t56dLHJtuYaDHSjFzCeb6NYzD6HmZ0cUnPyL4432dg=
X-Received: by 2002:a05:6000:80e:b0:20c:5b45:a700 with SMTP id
 bt14-20020a056000080e00b0020c5b45a700mr7229179wrb.662.1651536972237; Mon, 02
 May 2022 17:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1651174324.git.rgb@redhat.com> <Yms3hVYSRD1zT+Rz@madcap2.tricolour.ca>
In-Reply-To: <Yms3hVYSRD1zT+Rz@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 2 May 2022 20:16:01 -0400
Message-ID: <CAHC9VhSGda5NofudLtsKspPjGc9bnZd=DZL9Mo-PJtJbb9RO4w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] fanotify: Allow user space to pass back additional
 audit info
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 28, 2022 at 8:55 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2022-04-28 20:44, Richard Guy Briggs wrote:
> > The Fanotify API can be used for access control by requesting permission
> > event notification. The user space tooling that uses it may have a
> > complicated policy that inherently contains additional context for the
> > decision. If this information were available in the audit trail, policy
> > writers can close the loop on debugging policy. Also, if this additional
> > information were available, it would enable the creation of tools that
> > can suggest changes to the policy similar to how audit2allow can help
> > refine labeled security.
> >
> > This patch defines 2 additional fields within the response structure
> > returned from user space on a permission event. The first field is 16
> > bits for the context type. The context type will describe what the
> > meaning is of the second field. The audit system will separate the
> > pieces and log them individually.
> >
> > The audit function was updated to log the additional information in the
> > AUDIT_FANOTIFY record. The following is an example of the new record
> > format:
> >
> > type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_ctx=17
>
> It might have been a good idea to tag this as RFC...  I have a few
> questions:
>
> 1. Where did "resp=" come from?

According to the git log, it came from Steve Grubb via de8cd83e91bc
("audit: Record fanotify access control decisions").  Steve should
have known what he was doing with respect to field names so I'm
assuming he had a reason.

> It isn't in the field dictionary.  It
> seems like a needless duplication of "res=".  If it isn't, maybe it
> should have a "fan_" namespace prefix and become "fan_res="?

Regardless of what it should have been, it is "resp" now and we can't
really change it.  As far as the field dictionary is concerned, while
we should document these fields, it is important to note that when the
dictionary conflicts with the kernel, the kernel wins by definition.

> 2. It appears I'm ok changing the "__u32 response" to "__u16" without
> breaking old userspace.  Is this true on all arches?

I can't answer that for you, the fanotify folks will need to look at
that, but you likely already know that.  While I haven't gone through
the entire patchset yet, if it was me I probably would have left
response as a u32 and just added the extra fields; you are already
increasing the size of fanotify_response so why bother with shrinking
an existing field?

> 3. What should be the action if response contains unknown flags or
> types?  Is it reasonable to return -EINVAL?

Once again, not a fanotify expert, but EINVAL is intended for invalid
input so it seems like a reasonable choice.

> 4. Currently, struct fanotify_response has a fixed size, but if future
> types get defined that have variable buffer sizes, how would that be
> communicated or encoded?

If that is a concern, you should probably include a length field in
the structure before the variable length field.  You can't put it
before fd or response, so it's really a question of before or after
your new extra_info_type; I might suggest *after* extra_info_type, but
that's just me.


--
paul-moore.com
