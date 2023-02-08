Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB6468EE8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 13:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjBHMIV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 07:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjBHMIT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 07:08:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20EA271C;
        Wed,  8 Feb 2023 04:08:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9F279343C8;
        Wed,  8 Feb 2023 12:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675858096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6kQ/b9P2l8kee/E/h4Drwv3QCXDsx1UgO371zR6pPNI=;
        b=2eUEVLlgqXDFH01ik5PqmLSCHnU9HUNz7qsvoJujOPWFOvHr+cWW7YrG8oFoF8HvXHKbHc
        o2BXFxypcInEBi1xttwMravJ9FmmPyqDohP/bojOvbLunLi4V2cGifer2+/CJP9QjBbD1p
        6xNSodk42pbvKchO3LhegnN/GCBAjpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675858096;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6kQ/b9P2l8kee/E/h4Drwv3QCXDsx1UgO371zR6pPNI=;
        b=WyuWwpcnHLDmd1YOJR1OFXdNCpf05gthUwDbeUGauOz6tAa7M2XMMjr3doMKcN7TVlbOqY
        dL9/DzTRsb8zkmBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F9DC1358A;
        Wed,  8 Feb 2023 12:08:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EMX9IrCQ42O5YQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 08 Feb 2023 12:08:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 20E7FA06D5; Wed,  8 Feb 2023 13:08:16 +0100 (CET)
Date:   Wed, 8 Feb 2023 13:08:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jan Kara <jack@suse.cz>, Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v7 0/3] fanotify: Allow user space to pass back
 additional audit info
Message-ID: <20230208120816.2qhck3sb7u67vsib@quack3>
References: <cover.1675373475.git.rgb@redhat.com>
 <20230207120921.7pgh6uxs7ze7hkjo@quack3>
 <CAHC9VhQuD0UMYd12x9kOMwruDmQsyUFxQ8gJ3Q_qF6a58Lu+2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQuD0UMYd12x9kOMwruDmQsyUFxQ8gJ3Q_qF6a58Lu+2Q@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 07-02-23 09:54:11, Paul Moore wrote:
> On Tue, Feb 7, 2023 at 7:09 AM Jan Kara <jack@suse.cz> wrote:
> > On Fri 03-02-23 16:35:13, Richard Guy Briggs wrote:
> > > The Fanotify API can be used for access control by requesting permission
> > > event notification. The user space tooling that uses it may have a
> > > complicated policy that inherently contains additional context for the
> > > decision. If this information were available in the audit trail, policy
> > > writers can close the loop on debugging policy. Also, if this additional
> > > information were available, it would enable the creation of tools that
> > > can suggest changes to the policy similar to how audit2allow can help
> > > refine labeled security.
> > >
> > > This patchset defines a new flag (FAN_INFO) and new extensions that
> > > define additional information which are appended after the response
> > > structure returned from user space on a permission event.  The appended
> > > information is organized with headers containing a type and size that
> > > can be delegated to interested subsystems.  One new information type is
> > > defined to audit the triggering rule number.
> > >
> > > A newer kernel will work with an older userspace and an older kernel
> > > will behave as expected and reject a newer userspace, leaving it up to
> > > the newer userspace to test appropriately and adapt as necessary.  This
> > > is done by providing a a fully-formed FAN_INFO extension but setting the
> > > fd to FAN_NOFD.  On a capable kernel, it will succeed but issue no audit
> > > record, whereas on an older kernel it will fail.
> > >
> > > The audit function was updated to log the additional information in the
> > > AUDIT_FANOTIFY record. The following are examples of the new record
> > > format:
> > >   type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_info=3137 subj_trust=3 obj_trust=5
> > >   type=FANOTIFY msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=0 subj_trust=2 obj_trust=2
> >
> > Thanks! I've applied this series to my tree.
> 
> While I think this version of the patchset is fine, for future
> reference it would have been nice if you had waited for my ACK on
> patch 3/3; while Steve maintains his userspace tools, I'm the one
> responsible for maintaining the Linux Kernel's audit subsystem.

Aha, I'm sorry for that. I had the impression that on the last version of
the series you've said you don't see anything for which the series should
be respun so once Steve's objections where addressed and you were silent
for a few days, I thought you consider the thing settled... My bad.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
