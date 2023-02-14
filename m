Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2176695D7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Feb 2023 09:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjBNIuY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Feb 2023 03:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjBNIuQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:50:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0888E2331E;
        Tue, 14 Feb 2023 00:50:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B3A221F37C;
        Tue, 14 Feb 2023 08:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676364608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fgt1M4WVOfjuxhjUWkQ8zKMH0N3h69+3N1PY/RQYSso=;
        b=LJno83LysU0JabzHaH661dd02/JbqhimY6SoOLZRFE3f4Cgy869WP8sBJLbDYzh6NcFInu
        yqb0at8wHLEel6A1u6OMZg6IuLtpQ2MMchvlw/wuHUDiOXc7JoY/9FDDZDoo6JC7mvoydT
        n3wzl2NEUheXadbBEu3WSH2a+cWHeIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676364608;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fgt1M4WVOfjuxhjUWkQ8zKMH0N3h69+3N1PY/RQYSso=;
        b=2aerJwqEJW1i/msnr0E9a2cnUo+n+bRMAfXO6jjFmooeM0VK8Y9t9j8mvOiYqVVLVkvBLk
        Cw3/wMWijTz65dDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A64C7138E3;
        Tue, 14 Feb 2023 08:50:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fOGcKEBL62NqMwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 14 Feb 2023 08:50:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 356C1A06D8; Tue, 14 Feb 2023 09:50:08 +0100 (CET)
Date:   Tue, 14 Feb 2023 09:50:08 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v3 7/8] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <20230214085008.gix3dvvyg7wcf3bz@quack3>
References: <Y8Z413XTPMr//bln@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230117110335.7dtlq4catefgjrm3@quack3>
 <Y8jizbGg6l2WxJPF@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230127144312.3m3hmcufcvxxp6f4@quack3>
 <Y9zHkMx7w4Io0TTv@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <Y+OGkVvzPN0RMv0O@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230209105418.ucowiqnnptbpwone@quack3>
 <Y+UzQJRIJEiAr4Z4@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230210143753.ofh6wouk7vi7ygcl@quack3>
 <Y+p6URWLBPd6VUHD@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+p6URWLBPd6VUHD@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Ojaswin!

On Mon 13-02-23 23:28:41, Ojaswin Mujoo wrote:
> On Fri, Feb 10, 2023 at 03:37:53PM +0100, Jan Kara wrote:
> > > See my comments at the end for more info.
> > > 
> > > > 
> > > > > Also, another thing I noticed is that after ext4_mb_normalize_request(),
> > > > > sometimes the original range can also exceed the normalized goal range,
> > > > > which is again was a bit surprising to me since my understanding was
> > > > > that normalized range would always encompass the orignal range.
> > > > 
> > > > Well, isn't that because (part of) the requested original range is already
> > > > preallocated? Or what causes the goal range to be shortened?
> > > > 
> > > Yes I think that pre existing PAs could be one of the cases.
> > > 
> > > Other than that, I'm also seeing some cases of sparse writes which can cause
> > > ext4_mb_normalize_request() to result in having an original range that
> > > overflows out of the goal range. For example, I observed these values just
> > > after the if else if else conditions in the function, before we check if range
> > > overlaps pre existing PAs:
> > > 
> > > orig_ex:2045/2055(len:10) normalized_range:0/2048, orig_isize:8417280
> > > 
> > > Basically, since isize is large and we are doing a sparse write, we end
> > > up in the following if condition:
> > > 
> > > 	} else if (NRL_CHECK_SIZE(ac->ac_o_ex.fe_len,
> > > 								(8<<20)>>bsbits, max, 8 * 1024)) {
> > > 		start_off = ((loff_t)ac->ac_o_ex.fe_logical >> (23 - bsbits)) << 23;
> > > 		size = 8 * 1024 * 1024;
> > >  }
> > > 
> > > Resulting in normalized range less than original range.
> > 
> > I see.
> > 
> > > Now, in any case, once we get such an overflow, if we try to enter the PA
> > > adjustment window in ext4_mb_new_inode_pa() function, we will again end
> > > up with a best extent overflowing out of goal extent since we would try
> > > to cover the original extent. 
> > > 
> > > So yeah, seems like there are 2 cases where we could result in
> > > overlapping PAs:
> > > 
> > > 1. Due to off calculation in PA adjustment window, as we discussed.  2.
> > > Due to original extent overflowing out of goal extent.
> > > 
> > > I think the 3 step solution you proposed works well to counter 1 but not
> > > 2, so we probably need some more logic on top of your solution to take
> > > care of that.  I'll think some more on how to fix this but I think this
> > > will be as a separate patch.
> > 
> > Well, my algorithm will still result in preallocation being within the goal
> > range AFAICS. In the example above we had:
> > 
> > Orig 2045/2055 Goal 0/2048
> > 
> > Suppose we found 200 blocks. So we try placing preallocation like:
> > 
> > 1848/2048, it covers the original starting block 2045 so we are fine and
> > create preallocation 1848/2048. Nothing has overflown the goal window...
> 
> Ahh okay, I though you meant checking if we covered the complete
> original range instead of just the original start. In that case we
> should be good.
> 
> However, I still feel that the example where we unnecessarily end up with 
> a lesser goal len than original len should not happen. Maybe in
> ext4_mb_normalize_request(), instead of hardcording the goal lengths for
> different i_sizes, we can select the next power of 2 greater than our
> original length or some similar heuristic. What do you think?

I agree that seems suboptimal but I'd leave tweaking this heuristic for a
separate patchset. In this one I'd just fix the minimum to make ranges not
overlap. The current heuristic makes sense as an anti-fragmentation measure
when there's enough free space. We can tweak the goal window heuristic of
mballoc but it would require some deeper thought and measurements, how it
affects fragmentation for various workloads so it is not just about
changing those several lines of code...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
