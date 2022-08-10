Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7918958E6B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 07:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiHJFWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 01:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiHJFWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 01:22:08 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B082564D2;
        Tue,  9 Aug 2022 22:22:07 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id 129so14047878vsq.8;
        Tue, 09 Aug 2022 22:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=oSJ3PBj2dSpaR7fCdE7LTCOdjNsBWGTVYv5P7MiZ/Uo=;
        b=q6N/lXJlPPq67/vmqmv7eUxMwDBlgmJ0clVG6xrfSqdE8UTuiMDEf6qn7zaikrA1A2
         5lGTPOyR9/gIyw24KeSYOaTbU5rzCefzE7M+AjGcwijuCMckHVvmhhcAtseDVTgQ0v8x
         IXIRnUzKKoDQen1FKXkWSVm+nS+0OQiVjtuSfzCzTqPbC8qrOs9+6WLEEa4j4NtDEGg2
         LcCEdVm3/zjuRwygldiJtxUZrGvl2GUlSZlT13Rg7czPz0U+1TlNPLimYAZ+9mS2InFn
         fY0nN9k5KXhO7fhMv+DkJJhZINo645Q7+NYjvqG4s1RbObcIquswgs+Fx2gRU28Y9NQv
         gLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oSJ3PBj2dSpaR7fCdE7LTCOdjNsBWGTVYv5P7MiZ/Uo=;
        b=mS+DIoirrNTZskqZz2B9fL5GkxmS2WEB5H0zTlVv0Z389KbDWfmx04TjwNEcbL/bsE
         1KpB8kBi2+sQ5YUfXVnOo+6QS1vHMzJ0HsitP6EQQYi6j0d/Wegy89z+ZxEKgubtb0zj
         VdXS/E8vklQ3oFFQ96wx0+rxMsXY64hTBOuqBhOYtI41NyT1R0friBcbBx2WMR5Ey9OA
         Qjyxx73E65ghFtGOWy8+GfakqVS6emwufmCIfWSSjrztXTrgw0q0F89wSqr0NJvuTTzu
         3X7UBO+fmHqmpcFCTN5DUvorx3PqyEgrMesPUIosk+qMF8hKgMCA9hkqRrsoqITOsyXL
         zZcQ==
X-Gm-Message-State: ACgBeo2Wtgel7UQNtlZtJTA1pfsJbDpZQ2REoBJ+h5s8Cn6p3Gf92Xz8
        x24OmNeuUxgAVCcOwuTfPCMztBgHJS0z57bW7CQ=
X-Google-Smtp-Source: AA6agR7Po/CU+pNnTYM3xUdj9rMd8Os9SsP3EV8ROX/RmUzooaXh1HD+5PighqocONKi7tNfMJeBU+Wtrjm24ZTXWp0=
X-Received: by 2002:a05:6102:3ecd:b0:358:57a1:d8a with SMTP id
 n13-20020a0561023ecd00b0035857a10d8amr10842757vsv.2.1660108926141; Tue, 09
 Aug 2022 22:22:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1659996830.git.rgb@redhat.com>
In-Reply-To: <cover.1659996830.git.rgb@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 10 Aug 2022 07:21:54 +0200
Message-ID: <CAOQ4uxiATP24r_0=2Y474FUPjSSg6TTv+txiXOouYE4+EYfNTA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] fanotify: Allow user space to pass back additional
 audit info
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[+linux-api]

On Tue, Aug 9, 2022 at 7:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> The Fanotify API can be used for access control by requesting permission
> event notification. The user space tooling that uses it may have a
> complicated policy that inherently contains additional context for the
> decision. If this information were available in the audit trail, policy
> writers can close the loop on debugging policy. Also, if this additional
> information were available, it would enable the creation of tools that
> can suggest changes to the policy similar to how audit2allow can help
> refine labeled security.
>
> This patchset defines a new flag (FAN_INFO) and new extensions that
> define additional information which are appended after the response
> structure returned from user space on a permission event.  The appended
> information is organized with headers containing a type and size that
> can be delegated to interested subsystems.  One new information type is
> defined for audit rule number.
>
> A newer kernel will work with an older userspace and an older kernel
> will behave as expected and reject a newer userspace, leaving it up to
> the newer userspace to test appropriately and adapt as necessary.

Since you did not accept my suggestion of FAN_TEST response code [1],
I am not really sure how you envision that "adapt as necessary" part.

A well designed UAPI should allow newer userspace to check for kernel
support of FAN_INFO on initialization.

For example, without this property of UAPI, it is going to be hard to write an
LTP test for the new functionality that does not run on older kernels.

As far as I can tell, your proposed UAPI does not provide this functionality.
It allows newer userspace to check for support of FAN_INFO only as a
response to a permission event.

You never replied to my question to explain why you think FAN_TEST
complicated things. The only purpose of FAN_TEST is for userspace
to be able to test FAN_INFO kernel support without providing a valid fd.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxi+8HUqyGxQBNMqSong92nreOWLKdy9MCrYg8wgW9Dj4g@mail.gmail.com/

>
> The audit function was updated to log the additional information in the
> AUDIT_FANOTIFY record. The following is an example of the new record
> format:
>
> type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_info=3F
>
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
> v3:
> - 1/3 switch {,__}audit_fanotify() from uint to u32
> - 2/3 re-add fanotify_get_response switch case FAN_DENY: to avoid unnecessary churn
> - add FAN_EXTRA flag to indicate more info and break with old kernel
> - change response from u16 to u32 to avoid endian issues
> - change extra_info_buf to union
> - move low-cost fd check earlier
> - change FAN_RESPONSE_INFO_AUDIT_NONE to FAN_RESPONSE_INFO_NONE
> - switch to u32 for internal and __u32 for uapi
> Link: https://lore.kernel.org/r/cover.1652724390.git.rgb@redhat.com

Link seems broken?

>
> v4:
> - scrap FAN_INVALID_RESPONSE_MASK in favour of original to catch invalid response == 0
> - introduce FANOTIFY_RESPONSE_* macros
> - uapi: remove union
> - keep original struct fanotify_response, add fan_info infra starting with audit reason
> - uapi add struct fanotify_response_info_header{type/pad/len} and struct fanotify_response_info_audit_rule{hdr/rule}
> - rename fan_ctx= to fan_info=, FAN_EXTRA to FAN_INFO
> - change event struct from type/buf to len/buf
> - enable multiple info extensions in one message
> - hex encode fan_info in __audit_fanotify()
> - record type FANOTIFY extended to "type=FANOTIFY msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=3F"
> Link: https://lore.kernel.org/r/cover.1659981772.git.rgb@redhat.com

Link seems broken?

Thanks,
Amir.
