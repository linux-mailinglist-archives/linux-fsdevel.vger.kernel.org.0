Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EB05B3612
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 13:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiIILJv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 07:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiIILJs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:09:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C26A4E84A;
        Fri,  9 Sep 2022 04:09:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8F1292288F;
        Fri,  9 Sep 2022 11:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662721785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jc0d4GvYAZFGV+o/z8IImilKpYEBIOuhp0/HsQ8mNfY=;
        b=OtZDXLRAx8/3DXs7hJJ/D+PJQ5qqbdbUBgJFXYVCoDY6wzHrg9HPmkWGDZ3u8QSE4ssn1t
        aQJ3dwkChQWmRaVP3iVCjGMSQ+Qjuh2kZmPvpXTL+w6TkKocroeX9T2c8mw7XgsgXXWPuF
        SsizCCQDo5hZu0ObFUvkdyU0v2XG2Tw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662721785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jc0d4GvYAZFGV+o/z8IImilKpYEBIOuhp0/HsQ8mNfY=;
        b=qLZIFqvob0RnArjNrWkgvQBYJkD6KS6Ck8NjN9xQqOOYzPiVWqkAL7HDJdoARbJoBJgYMB
        OqAeq1tj2qeUT8Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80D84139D5;
        Fri,  9 Sep 2022 11:09:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id BdpvH/keG2MCCwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 09 Sep 2022 11:09:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DDADFA0684; Fri,  9 Sep 2022 13:09:44 +0200 (CEST)
Date:   Fri, 9 Sep 2022 13:09:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>, Jan Kara <jack@suse.cz>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v4 3/4] fanotify,audit: Allow audit to use the full
 permission event response
Message-ID: <20220909110944.yfnuqhsiyw3ekkcn@quack3>
References: <cover.1659996830.git.rgb@redhat.com>
 <2254258.ElGaqSPkdT@x2>
 <Yxqn6NVQr0jTQHiu@madcap2.tricolour.ca>
 <2254543.ElGaqSPkdT@x2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2254543.ElGaqSPkdT@x2>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Steve!

On Fri 09-09-22 00:03:53, Steve Grubb wrote:
> On Thursday, September 8, 2022 10:41:44 PM EDT Richard Guy Briggs wrote:
> > > I'm trying to abide by what was suggested by the fs-devel folks. I can
> > > live with it. But if you want to make something non-generic for all
> > > users of fanotify, call the new field "trusted". This would decern when
> > > a decision was made because the file was untrusted or access denied for
> > > another reason.
> >
> > So, "u32 trusted;" ?  How would you like that formatted?
> > "fan_trust={0|1}"
> 
> So how does this play out if there is another user? Do they want a num= and 
> trust=  if not, then the AUDIT_FANOTIFY record will have multiple formats 
> which is not good. I'd rather suggest something generic that can be 
> interpreted based on who's attached to fanotify. IOW we have a fan_type=0 and 
> then followed by info0= info1=  the interpretation of those solely depend on 
> fan_type. If the fan_type does not need both, then any interpretation skips 
> what it doesn't need. If fan_type=1, then it follows what arg0= and arg1= is 
> for that format. But make this pivot on fan_type and not actual names.

So I think there is some misunderstanding so let me maybe spell out in
detail how I see things so that we can get on the same page:

It was a requirement from me (and probably Amir) that there is a generic
way to attach additional info to a response to fanotify permission event.
This is achieved by defining:

struct fanotify_response_info_header {
       __u8 type;
       __u8 pad;
       __u16 len;
};

which is a generic header and kernel can based on 'len' field decide how
large the response structure is (to safely copy it from userspace) and
based on 'type' field it can decide who should be the recipient of this
extra information (or generally what to do with it). So any additional
info needs to start with this header.

Then there is:

struct fanotify_response_info_audit_rule {
       struct fanotify_response_info_header hdr;
       __u32 audit_rule;
};

which properly starts with the header and hdr.type is expected to be
FAN_RESPONSE_INFO_AUDIT_RULE. What happens after the header with type
FAN_RESPONSE_INFO_AUDIT_RULE until length hdr.len is fully within *audit*
subsystem's responsibility. Fanotify code will just pass this as an opaque
blob to the audit subsystem.

So if you know audit subsystem will also need some other field together
with 'audit_rule' now is a good time to add it and it doesn't have to be
useful for anybody else besides audit. If someone else will need other
information passed along with the response, he will append structure with
another header with different 'type' field. In principle, there can be
multiple structures appended to fanotify response like

<hdr> <data> <hdr> <data> ...

and fanotify subsystem will just pass them to different receivers based
on the type in 'hdr' field.

Also if audit needs to pass even more information along with the respose,
we can define a new 'type' for it. But the 'type' space is not infinite so
I'd prefer this does not happen too often...

I hope this clears out things a bit.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
