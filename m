Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD1C650A11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Dec 2022 11:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiLSK0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Dec 2022 05:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiLSKZz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Dec 2022 05:25:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B476CE41;
        Mon, 19 Dec 2022 02:25:50 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4E8BB37323;
        Mon, 19 Dec 2022 10:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671445549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3dICCo4812NSE+Ksmy3//irJG0tDZgjWzexkQRofcf4=;
        b=04zDuimBkZFtqJfiwxJUdw8+ClImZRpwGh3Hqc685njyuL1AJSbVSJRozZNlWm33juOQlN
        hTHs21Mm/5IZdYYBx205LIUvTVraqw1oc5+OY9zfwLTJL4tVh3syqfLzxpTSVmw2sYQX82
        HQX1lVVm80KmNEYFeqSkGJ/PHuVwQhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671445549;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3dICCo4812NSE+Ksmy3//irJG0tDZgjWzexkQRofcf4=;
        b=752P1krkWV/pAvwnMceaKk+TTkkrOBx+IWdoxCPUPGP9+qdWAHYBEegkxc8b7s4iMIDxeX
        R52yQgepv44hObAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C19313910;
        Mon, 19 Dec 2022 10:25:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NFydDi08oGOJNAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 19 Dec 2022 10:25:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B199AA0732; Mon, 19 Dec 2022 11:10:23 +0100 (CET)
Date:   Mon, 19 Dec 2022 11:10:23 +0100
From:   Jan Kara <jack@suse.cz>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Jan Kara <jack@suse.cz>, Richard Guy Briggs <rgb@redhat.com>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v5 2/3] fanotify: define struct members to hold response
 decision context
Message-ID: <20221219101023.6bqjj3jg3il2fbzf@quack3>
References: <cover.1670606054.git.rgb@redhat.com>
 <45da8423b9b1e8fc7abd68cd2269acff8cf9022a.1670606054.git.rgb@redhat.com>
 <20221216164342.ojcbdifdmafq5njw@quack3>
 <CAHC9VhQCQJ6_0RtHQHuA2FDje-3ick3b3ar8K8NAnuMF=ww2cA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhQCQJ6_0RtHQHuA2FDje-3ick3b3ar8K8NAnuMF=ww2cA@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 16-12-22 12:05:14, Paul Moore wrote:
> On Fri, Dec 16, 2022 at 11:43 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 12-12-22 09:06:10, Richard Guy Briggs wrote:
> > > This patch adds a flag, FAN_INFO and an extensible buffer to provide
> > > additional information about response decisions.  The buffer contains
> > > one or more headers defining the information type and the length of the
> > > following information.  The patch defines one additional information
> > > type, FAN_RESPONSE_INFO_AUDIT_RULE, to audit a rule number.  This will
> > > allow for the creation of other information types in the future if other
> > > users of the API identify different needs.
> > >
> > > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > > Link: https://lore.kernel.org/r/2745105.e9J7NaK4W3@x2
> > > Suggested-by: Jan Kara <jack@suse.cz>
> > > Link: https://lore.kernel.org/r/20201001101219.GE17860@quack2.suse.cz
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> >
> > Thanks for the patches. They look very good to me. Just two nits below. I
> > can do the small updates on commit if there would be no other changes. But
> > I'd like to get some review from audit guys for patch 3/3 before I commit
> > this.
> 
> It's in my review queue, but it's a bit lower in the pile as my
> understanding is that the linux-next folks don't like to see new
> things in the next branches until after the merge window closes.

Sure, there's no hurry :). I just wanted to make it clear where the things
stand.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
