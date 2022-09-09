Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E145B3A9A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 16:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIIOWt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 10:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIIOWq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696A2C0E79
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662733364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kl2ork6m1zrEpHk0BOexy0xVS0f6pUe1ZNwGgpO6tHw=;
        b=V47dgQX4KBQP7l6y62iMn5FmgrrzRowcA6j1Azr86TlTHOW6Y0CJLdVCguMc5vyiGFoZYB
        LGMtjl6tBFqjkMBAT8PQvwVCbzX/yhQvsNfx9IvSKK4K+n6kvhobrTmC3orvt3auLXnkb3
        GdiKOgvMesGO5W9O5p5xKj639oagwsU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-pOYcU8l_PayXSCoeduBV9A-1; Fri, 09 Sep 2022 10:22:39 -0400
X-MC-Unique: pOYcU8l_PayXSCoeduBV9A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A66AC1C05AFE;
        Fri,  9 Sep 2022 14:22:38 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.9.245])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C02942026D4C;
        Fri,  9 Sep 2022 14:22:37 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>, Jan Kara <jack@suse.cz>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full permission event response
Date:   Fri, 09 Sep 2022 10:22:37 -0400
Message-ID: <4748798.GXAFRqVoOG@x2>
Organization: Red Hat
In-Reply-To: <20220909110944.yfnuqhsiyw3ekkcn@quack3>
References: <cover.1659996830.git.rgb@redhat.com> <2254543.ElGaqSPkdT@x2> <20220909110944.yfnuqhsiyw3ekkcn@quack3>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday, September 9, 2022 7:09:44 AM EDT Jan Kara wrote:
> Hello Steve!
> 
> On Fri 09-09-22 00:03:53, Steve Grubb wrote:
> > On Thursday, September 8, 2022 10:41:44 PM EDT Richard Guy Briggs wrote:
> > > > I'm trying to abide by what was suggested by the fs-devel folks. I
> > > > can
> > > > live with it. But if you want to make something non-generic for all
> > > > users of fanotify, call the new field "trusted". This would decern
> > > > when
> > > > a decision was made because the file was untrusted or access denied
> > > > for
> > > > another reason.
> > > 
> > > So, "u32 trusted;" ?  How would you like that formatted?
> > > "fan_trust={0|1}"
> > 
> > So how does this play out if there is another user? Do they want a num=
> > and trust=  if not, then the AUDIT_FANOTIFY record will have multiple
> > formats which is not good. I'd rather suggest something generic that can
> > be interpreted based on who's attached to fanotify. IOW we have a
> > fan_type=0 and then followed by info0= info1=  the interpretation of
> > those solely depend on fan_type. If the fan_type does not need both,
> > then any interpretation skips what it doesn't need. If fan_type=1, then
> > it follows what arg0= and arg1= is for that format. But make this pivot
> > on fan_type and not actual names.
> So I think there is some misunderstanding so let me maybe spell out in
> detail how I see things so that we can get on the same page:
> 
> It was a requirement from me (and probably Amir) that there is a generic
> way to attach additional info to a response to fanotify permission event.
> This is achieved by defining:
> 
> struct fanotify_response_info_header {
>        __u8 type;
>        __u8 pad;
>        __u16 len;
> };
> 
> which is a generic header and kernel can based on 'len' field decide how
> large the response structure is (to safely copy it from userspace) and
> based on 'type' field it can decide who should be the recipient of this
> extra information (or generally what to do with it). So any additional
> info needs to start with this header.
> 
> Then there is:
> 
> struct fanotify_response_info_audit_rule {
>        struct fanotify_response_info_header hdr;
>        __u32 audit_rule;
> };
> 
> which properly starts with the header and hdr.type is expected to be
> FAN_RESPONSE_INFO_AUDIT_RULE. What happens after the header with type
> FAN_RESPONSE_INFO_AUDIT_RULE until length hdr.len is fully within *audit*
> subsystem's responsibility. Fanotify code will just pass this as an opaque
> blob to the audit subsystem.
> 
> So if you know audit subsystem will also need some other field together
> with 'audit_rule' now is a good time to add it and it doesn't have to be
> useful for anybody else besides audit. If someone else will need other
> information passed along with the response, he will append structure with
> another header with different 'type' field. In principle, there can be
> multiple structures appended to fanotify response like
> 
> <hdr> <data> <hdr> <data> ...
> 
> and fanotify subsystem will just pass them to different receivers based
> on the type in 'hdr' field.
> 
> Also if audit needs to pass even more information along with the respose,
> we can define a new 'type' for it. But the 'type' space is not infinite so
> I'd prefer this does not happen too often...
> 
> I hope this clears out things a bit.

Yes. Thank you.

Richard,  add subj_trust and obj_trust. These can be 0|1|2 for no, yes, 
unknown.

-Steve



