Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B1268DC2A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 15:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbjBGOyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 09:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjBGOyX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:54:23 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D728BB761
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Feb 2023 06:54:22 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id n2so8013767pgb.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Feb 2023 06:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/sFKKhZ90MQYN6W+lwU/csGafQQLGEIclrsug/GE52I=;
        b=UtuiuK6A5+g5V0jt0N0y6sDWoDiEGAvdrcqKjzVd+ZMiqmEemfcC3iO33EIwHn89gc
         oVsf0cIy3CvlhkIi9xPKRSAdIyH6sGHNnxPYMqLKBAO3BW5/WCN1SAn0VJfT1q186et3
         38pvpl4dZ//9OAA4CGbXqUpyhMH5vt2ZYn0Axzz9u9cZbfGotu84i1FvhhkNqaTPkYk6
         GD/TBS/1nMnLd+DtUVBk4Y5qc7J/b2ATJn07v+E/kCHjicODGwWSMDrBlScdonlpXm6h
         uHf3jV/wZAbl2hno+Rc3v0KFDfVfApyRDkIndp6Z7E5PUVl8r3pFD/X6NrP9F9dX5yzz
         P6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/sFKKhZ90MQYN6W+lwU/csGafQQLGEIclrsug/GE52I=;
        b=O7SMMkwEwNHoF7QhNtMg3bv6lEXUPD3oc7efjhfEG9nl7FvHhHTJgxOysotkpzcGlN
         tXdKe9Lj4FUQVLEErqzzKq6HXita3Js+XQ0+qvEZ6uWo5GEKcUm0jPNNNfm7oBSsfyyk
         9G5a5LtgKKjj875NkjYfIVLJVXTQNgBC95jKTp19W1b5SYkHubcxet3H0L4QnBBA9uMw
         vSzRiY5QzDgTxdBePFG/zcMR8XjVuacW0zlyaWybyFTiCGZDEAaC5M28SXYvhvlr9UhY
         e7o6ZGeR5B1BLWrNE7TEH4u/5WKluDsz9K1lYxn7eRu6tnhuLva97mi9M2fXLD1kqaeE
         dMsQ==
X-Gm-Message-State: AO0yUKVDqmW5HCeWDtLkotsc9gtv9BjJwkgsbTfEziwYzhDorjNy4Hxo
        gAPe76nz4NT/FeV+EyRUClB9abpInLqjhbA5AcRWqgpgpKW1
X-Google-Smtp-Source: AK7set/12SmTpGSfAsl0Qb15n4IkVg7Ti31+1DTyBVDLIOeevQ21dbZovK+nK1IW38jl/XJbAGuBV2UvWR9XWEQpqpw=
X-Received: by 2002:a62:18c6:0:b0:59c:3da0:1629 with SMTP id
 189-20020a6218c6000000b0059c3da01629mr760258pfy.6.1675781662291; Tue, 07 Feb
 2023 06:54:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675373475.git.rgb@redhat.com> <20230207120921.7pgh6uxs7ze7hkjo@quack3>
In-Reply-To: <20230207120921.7pgh6uxs7ze7hkjo@quack3>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Feb 2023 09:54:11 -0500
Message-ID: <CAHC9VhQuD0UMYd12x9kOMwruDmQsyUFxQ8gJ3Q_qF6a58Lu+2Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] fanotify: Allow user space to pass back additional
 audit info
To:     Jan Kara <jack@suse.cz>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 7, 2023 at 7:09 AM Jan Kara <jack@suse.cz> wrote:
> On Fri 03-02-23 16:35:13, Richard Guy Briggs wrote:
> > The Fanotify API can be used for access control by requesting permission
> > event notification. The user space tooling that uses it may have a
> > complicated policy that inherently contains additional context for the
> > decision. If this information were available in the audit trail, policy
> > writers can close the loop on debugging policy. Also, if this additional
> > information were available, it would enable the creation of tools that
> > can suggest changes to the policy similar to how audit2allow can help
> > refine labeled security.
> >
> > This patchset defines a new flag (FAN_INFO) and new extensions that
> > define additional information which are appended after the response
> > structure returned from user space on a permission event.  The appended
> > information is organized with headers containing a type and size that
> > can be delegated to interested subsystems.  One new information type is
> > defined to audit the triggering rule number.
> >
> > A newer kernel will work with an older userspace and an older kernel
> > will behave as expected and reject a newer userspace, leaving it up to
> > the newer userspace to test appropriately and adapt as necessary.  This
> > is done by providing a a fully-formed FAN_INFO extension but setting the
> > fd to FAN_NOFD.  On a capable kernel, it will succeed but issue no audit
> > record, whereas on an older kernel it will fail.
> >
> > The audit function was updated to log the additional information in the
> > AUDIT_FANOTIFY record. The following are examples of the new record
> > format:
> >   type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_info=3137 subj_trust=3 obj_trust=5
> >   type=FANOTIFY msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=0 subj_trust=2 obj_trust=2
>
> Thanks! I've applied this series to my tree.

While I think this version of the patchset is fine, for future
reference it would have been nice if you had waited for my ACK on
patch 3/3; while Steve maintains his userspace tools, I'm the one
responsible for maintaining the Linux Kernel's audit subsystem.

-- 
paul-moore.com
