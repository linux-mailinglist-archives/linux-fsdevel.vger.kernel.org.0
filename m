Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF4F518FAC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 23:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242545AbiECVBm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 17:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242588AbiECVBg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 17:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80BC93FBE9
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 13:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651611481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S4Eu2Fdnk6fNtantoen7gHvfIdyzwaNX0dgF5gU78/A=;
        b=Yla+cH783tWMc8JQcBnXz+XPj8ISz93nI+e3xMdBRmjcW0tZjBZn5JYpg9ZNZfQOPiNU+d
        /tcjJik4/3g3wb5PkyeK8xzAKz06KultzKkMI49LCouWhUO11sqpxll2+hnjMqcoUba1Re
        vFeIdL0nXcss9K9vD9L6QRZ4/GP3Ad0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-L3mR21syNkmDISvaLwmndw-1; Tue, 03 May 2022 16:57:58 -0400
X-MC-Unique: L3mR21syNkmDISvaLwmndw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 121CA10187EA;
        Tue,  3 May 2022 20:57:58 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.10.175])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A75EC28100;
        Tue,  3 May 2022 20:57:57 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Richard Guy Briggs <rgb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 0/3] fanotify: Allow user space to pass back additional audit info
Date:   Tue, 03 May 2022 16:57:57 -0400
Message-ID: <8060610.T7Z3S40VBb@x2>
Organization: Red Hat
In-Reply-To: <Yms3hVYSRD1zT+Rz@madcap2.tricolour.ca>
References: <cover.1651174324.git.rgb@redhat.com> <Yms3hVYSRD1zT+Rz@madcap2.tricolour.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thursday, April 28, 2022 8:55:33 PM EDT Richard Guy Briggs wrote:
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

This is an abbreviation for the response field of struct fanotify_response. I 
wanted to keep it short to save bytes.

> It isn't in the field dictionary.  It seems like a needless duplication of
> "res=".  If it isn't, maybe it should have a "fan_" namespace prefix and
> become "fan_res="?

At this point it's been interpretted for years.
 
> 2. It appears I'm ok changing the "__u32 response" to "__u16" without
> breaking old userspace.  Is this true on all arches?

If done carefully. Old user space won't try to use the new capabilities. The 
only trick is new user space/old kernel.

> 3. What should be the action if response contains unknown flags or
> types?  Is it reasonable to return -EINVAL?

The original patch was designed to allow the response metadata to take on 
various different meanings based on new usage. The original patch only defined 
a rule order numbering which if something else wanted to send it's own 
metadata about a decision, a new patch could layer on top of this without 
interfering.

If this is an access decision that is rejected with EINVAL (and assuming 
future decisions will also be formed the same way), the whole system is 
getting ready to lock up - even though a real answer is in the response.

> 4. Currently, struct fanotify_response has a fixed size, but if future
> types get defined that have variable buffer sizes, how would that be
> communicated or encoded?

I hadn't considered that as it would be too much of a change that I would be 
uncomfortable doing. That could be a future evolution if it's ever needed.

-Steve


