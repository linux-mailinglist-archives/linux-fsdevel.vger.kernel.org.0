Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7966902E1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 10:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjBIJH6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 04:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjBIJHy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 04:07:54 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7909564B2;
        Thu,  9 Feb 2023 01:07:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5C27C5C53E;
        Thu,  9 Feb 2023 09:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675933671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CU3m83OXbTgSKoJXrcQdDx76tP8O5uzz+pn2OeaAdZw=;
        b=xNoBE+lwnVUOfPb0zDl+OFfEhjR5FvJXwjcM1KGhzHDounpReRjFnbuR9n6upD40EI2i01
        cwaOAtP0Xvq1oMGZEw7Re+YEy61VDXgD0LW9bEQNatNBEgPOWDr69FfpAXcttkYkWaeEqn
        G0CwmdWGvhQM9Kh6BVyIjaYmmpKw+ac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675933671;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CU3m83OXbTgSKoJXrcQdDx76tP8O5uzz+pn2OeaAdZw=;
        b=yFiGhdQ5QoCsgxvN6+hnz4ITZQD+Yxwc5mjKJNuH5yq/m/yu1qYx1Ehgxaf+DcdRj1WLjc
        fFI3EjFXOj4NomCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4CBA61339E;
        Thu,  9 Feb 2023 09:07:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id niyuEue35GP+IgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 09 Feb 2023 09:07:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CA87BA06D8; Thu,  9 Feb 2023 10:07:50 +0100 (CET)
Date:   Thu, 9 Feb 2023 10:07:50 +0100
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
Message-ID: <20230209090750.lx32p57jtul7pnv5@quack3>
References: <cover.1675373475.git.rgb@redhat.com>
 <20230207120921.7pgh6uxs7ze7hkjo@quack3>
 <CAHC9VhQuD0UMYd12x9kOMwruDmQsyUFxQ8gJ3Q_qF6a58Lu+2Q@mail.gmail.com>
 <20230208120816.2qhck3sb7u67vsib@quack3>
 <CAHC9VhSumNxmoYQ9JPtBgV0dc1fgR38Lqbo0w4PRxhvBdS=W_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSumNxmoYQ9JPtBgV0dc1fgR38Lqbo0w4PRxhvBdS=W_w@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 08-02-23 10:03:24, Paul Moore wrote:
> On Wed, Feb 8, 2023 at 7:08 AM Jan Kara <jack@suse.cz> wrote:
> > On Tue 07-02-23 09:54:11, Paul Moore wrote:
> > > On Tue, Feb 7, 2023 at 7:09 AM Jan Kara <jack@suse.cz> wrote:
> > > > On Fri 03-02-23 16:35:13, Richard Guy Briggs wrote:
> > > > > The Fanotify API can be used for access control by requesting permission
> > > > > event notification. The user space tooling that uses it may have a
> > > > > complicated policy that inherently contains additional context for the
> > > > > decision. If this information were available in the audit trail, policy
> > > > > writers can close the loop on debugging policy. Also, if this additional
> > > > > information were available, it would enable the creation of tools that
> > > > > can suggest changes to the policy similar to how audit2allow can help
> > > > > refine labeled security.
> > > > >
> > > > > This patchset defines a new flag (FAN_INFO) and new extensions that
> > > > > define additional information which are appended after the response
> > > > > structure returned from user space on a permission event.  The appended
> > > > > information is organized with headers containing a type and size that
> > > > > can be delegated to interested subsystems.  One new information type is
> > > > > defined to audit the triggering rule number.
> > > > >
> > > > > A newer kernel will work with an older userspace and an older kernel
> > > > > will behave as expected and reject a newer userspace, leaving it up to
> > > > > the newer userspace to test appropriately and adapt as necessary.  This
> > > > > is done by providing a a fully-formed FAN_INFO extension but setting the
> > > > > fd to FAN_NOFD.  On a capable kernel, it will succeed but issue no audit
> > > > > record, whereas on an older kernel it will fail.
> > > > >
> > > > > The audit function was updated to log the additional information in the
> > > > > AUDIT_FANOTIFY record. The following are examples of the new record
> > > > > format:
> > > > >   type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1 fan_info=3137 subj_trust=3 obj_trust=5
> > > > >   type=FANOTIFY msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=0 subj_trust=2 obj_trust=2
> > > >
> > > > Thanks! I've applied this series to my tree.
> > >
> > > While I think this version of the patchset is fine, for future
> > > reference it would have been nice if you had waited for my ACK on
> > > patch 3/3; while Steve maintains his userspace tools, I'm the one
> > > responsible for maintaining the Linux Kernel's audit subsystem.
> >
> > Aha, I'm sorry for that. I had the impression that on the last version of
> > the series you've said you don't see anything for which the series should
> > be respun so once Steve's objections where addressed and you were silent
> > for a few days, I thought you consider the thing settled... My bad.
> 
> That's understandable, especially given inconsistencies across
> subsystems.  If it helps, if I'm going to ACK something I make it
> explicit with a proper 'Acked-by: ...' line in my reply; if I say
> something looks good but there is no explicit ACK, there is usually
> something outstanding that needs to be resolved, e.g. questions,
> additional testing, etc.

Ok, thanks for letting me now. Next time I'll wait for an explicit ack from
you. This time, since everybody is fine with the actual patch, let's just
move on ;).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
