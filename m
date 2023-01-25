Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391F867B2DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 14:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjAYNBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 08:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbjAYNBa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:01:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C30846730;
        Wed, 25 Jan 2023 05:01:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1995121A38;
        Wed, 25 Jan 2023 13:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674651688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZHPUEmgHN9HHsele0Ce3YewvjVaFUupPCQ2N9ydCuzU=;
        b=r+QImpXSov56FLm1H+hELmnDF3ba33PDw9X+GNnrXwjl2eQ+ZuX3YhWChiKOdofziQIIEm
        lXbb2vLp56dhnNJ7EOBz3awHc1j72nCdmCZWUEIjOJydKML1zstPO/PSZz0O5XA4flp7vX
        J2LJKE4EyuI1Ln1V1xiBggPmq3RuK7Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF07E1339E;
        Wed, 25 Jan 2023 13:01:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uoscOCco0WNBGAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 25 Jan 2023 13:01:27 +0000
Date:   Wed, 25 Jan 2023 14:01:27 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Stefan Roesch <shr@devkernel.io>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, CGEL <cgel.zte@gmail.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [RESEND RFC PATCH v1 00/20] mm: process/cgroup ksm support
Message-ID: <Y9EoJ0jlXMeuJzuY@dhcp22.suse.cz>
References: <20230123173748.1734238-1-shr@devkernel.io>
 <5844ee9f-1992-a62a-2141-3b694a1e1915@redhat.com>
 <qvqwbkmnj014.fsf@dev0134.prn3.facebook.com>
 <a391e98c-88af-886c-0426-c41c9980afa1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a391e98c-88af-886c-0426-c41c9980afa1@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 24-01-23 19:01:49, David Hildenbrand wrote:
> [...]
> 
> > > I'm going to point out the security aspect, and that e.g., Windows used to
> > > enable it system-wide before getting taught by security experts otherwise.
> > > Details on KSM and security aspects can be found in that thread.
> > > 
> > If I'm not mistaken the security aspect exists today. When KSM is
> > enabled with madvise this is the same.
> 
> Yes, and we mostly only use it for virtual machines -- and to be precise,
> guest memory only -- where it has to be enabled explicitly on a well
> documented basis ...
> 
> Impossible for an admin to force it on other parts of the hypervisor process
> that might be more security sensitive. Or on other arbitrary applications,
> for now.
> 
> > 
> > > Long story short: one has to be very careful with that and only enable it for
> > > very carefully selected worklads. Letting a workload opt-in on a VMA level is
> > > most probably safer than an admin blindly turning this on for random processes
> > > ... >>
> [...]
> 
> > > 
> > > [1] https://lore.kernel.org/all/20220517092701.1662641-1-xu.xin16@zte.com.cn/
> > > [2] https://lore.kernel.org/all/20220609055658.703472-1-xu.xin16@zte.com.cn/
> > > 
> > My understanding is that there were problems with the patch and how it
> > exposed KSM. The other objection was the enable-all configuration
> > option.
> 
> I don't remember all the discussions, but one concern was how to handle
> processes that deliberately want to disable it on some parts of memory.
> 
> Anyhow, I cc'ed the relevant parties already.

Thanks! I do not remember all the details from the past discussion
except it was /proc and later global setting. Neither really were great
choices. We have discussed pidfd_madvise and prctl IIRC. For the latter
there was no real argument about when it is desirable to apply merging
on all existing vmas (e.g. is it really desirable on stack/brk or malloc
arenas or would user need to opt out for those).

I have read through your cover letter and it talks about the interface
but it doesn't really talk about usecases and how they are supposed to
use this feature - except the prctl based flag gets inherited. So could
you elaborate some more about those usecases please?
-- 
Michal Hocko
SUSE Labs
