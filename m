Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F16A513FD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 02:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353566AbiD2A7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Apr 2022 20:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349980AbiD2A65 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Apr 2022 20:58:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 458314D24B
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Apr 2022 17:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651193740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TbBS5zGUgS72fwCgLEHg986yKV4qQhiV58eG+bVlwi0=;
        b=VlVnszvRzNVk6OgGl9Pt3G0lQG/MDamzJuVcsUx7fuUQ2OUuMsGp3ReykPerI4zmf09Ym4
        HPXoIVYjf9Vz6vhKGrnr2CJlO/eNI2XsSCHsxCCJ0cEQ4AIOtTkkUjZRMdqSNtAGkBRFZY
        gdqnjOwg2UgrNcVhAsZ4g5XgoE1rWC0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-470-YwUT7Fm4PhKmLw-WOikKfg-1; Thu, 28 Apr 2022 20:55:37 -0400
X-MC-Unique: YwUT7Fm4PhKmLw-WOikKfg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 784D7811E75;
        Fri, 29 Apr 2022 00:55:36 +0000 (UTC)
Received: from madcap2.tricolour.ca (ovpn-0-8.rdu2.redhat.com [10.22.0.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 617E740E7F06;
        Fri, 29 Apr 2022 00:55:35 +0000 (UTC)
Date:   Thu, 28 Apr 2022 20:55:33 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 0/3] fanotify: Allow user space to pass back
 additional audit info
Message-ID: <Yms3hVYSRD1zT+Rz@madcap2.tricolour.ca>
References: <cover.1651174324.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651174324.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-04-28 20:44, Richard Guy Briggs wrote:
> The Fanotify API can be used for access control by requesting permission
> event notification. The user space tooling that uses it may have a
> complicated policy that inherently contains additional context for the
> decision. If this information were available in the audit trail, policy
> writers can close the loop on debugging policy. Also, if this additional
> information were available, it would enable the creation of tools that
> can suggest changes to the policy similar to how audit2allow can help
> refine labeled security.
> 
> This patch defines 2 additional fields within the response structure
> returned from user space on a permission event. The first field is 16
> bits for the context type. The context type will describe what the
> meaning is of the second field. The audit system will separate the
> pieces and log them individually.
> 
> The audit function was updated to log the additional information in the
> AUDIT_FANOTIFY record. The following is an example of the new record
> format:
> 
> type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_ctx=17

It might have been a good idea to tag this as RFC...  I have a few
questions:

1. Where did "resp=" come from?  It isn't in the field dictionary.  It
seems like a needless duplication of "res=".  If it isn't, maybe it
should have a "fan_" namespace prefix and become "fan_res="?

2. It appears I'm ok changing the "__u32 response" to "__u16" without
breaking old userspace.  Is this true on all arches?

3. What should be the action if response contains unknown flags or
types?  Is it reasonable to return -EINVAL?

4. Currently, struct fanotify_response has a fixed size, but if future
types get defined that have variable buffer sizes, how would that be
communicated or encoded?

> changelog:
> v1:
> - first version by Steve Grubb <sgrubb@redhat.com>
> Link: https://lore.kernel.org/r/2042449.irdbgypaU6@x2
> 
> v2:
> - enhancements suggested by Jan Kara <jack@suse.cz>
> - 1/3 change %d to %u in pr_debug
> - 2/3 change response from __u32 to __u16
> - mod struct fanotify_response and fanotify_perm_event add extra_info_type, extra_info_buf
> - extra_info_buf size max FANOTIFY_MAX_RESPONSE_EXTRA_LEN, add struct fanotify_response_audit_rule
> - extend debug statements
> - remove unneeded macros
> - [internal] change interface to finish_permission_event() and process_access_response()
> - 3/3 update format of extra information
> - [internal] change interface to audit_fanotify()
> - change ctx_type= to fan_type=
> Link: https://lore.kernel.org/r/cover.1651174324.git.rgb@redhat.com
> 
> Richard Guy Briggs (3):
>   fanotify: Ensure consistent variable type for response
>   fanotify: define struct members to hold response decision context
>   fanotify: Allow audit to use the full permission event response
> 
>  fs/notify/fanotify/fanotify.c      |  5 ++-
>  fs/notify/fanotify/fanotify.h      |  4 +-
>  fs/notify/fanotify/fanotify_user.c | 59 ++++++++++++++++++++----------
>  include/linux/audit.h              |  8 ++--
>  include/linux/fanotify.h           |  3 ++
>  include/uapi/linux/fanotify.h      | 27 +++++++++++++-
>  kernel/auditsc.c                   | 18 +++++++--
>  7 files changed, 94 insertions(+), 30 deletions(-)
> 
> -- 
> 2.27.0
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

