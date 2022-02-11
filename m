Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F0D4B1AE3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 02:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346641AbiBKBCf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Feb 2022 20:02:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346600AbiBKBCe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:02:34 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D9710BB;
        Thu, 10 Feb 2022 17:02:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 267C41F37D;
        Fri, 11 Feb 2022 01:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644541352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1sxGrciLmhXl3Lu3kC7iTxwvn6owJi4as2gkjmESHwU=;
        b=rGcm0uHXEdyTZMzra45UNXzf/Pd2bOUIKB6yJ/IjbnDGKUfDK6htFV/70T/TAYJR8pdhHV
        ru/vwR/FwVMt9Z7oj6uiVJUfVJB7oBrGeeHUkeba6aQ+/MNnZ/1BM+QdhLhwdwxsnXcogi
        QumI1/GRzDoBvoTWCWe7JkLAGPb/sbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644541352;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1sxGrciLmhXl3Lu3kC7iTxwvn6owJi4as2gkjmESHwU=;
        b=qd2SVakQYDMkSf2uPgrflqIOMx8nSiejcYDFT0wyCVgUA6yCCiiknvCr9KJsCfOwSlrDtn
        PKYFYcIhlLuEpVCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9C6C13C61;
        Fri, 11 Feb 2022 01:02:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DuM4G6e1BWKycAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Fri, 11 Feb 2022 01:02:31 +0000
Date:   Thu, 10 Feb 2022 19:02:29 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com, fvogt@suse.com
Subject: Re: [PATCH] Fix read-only superblock in case of subvol RO remount
Message-ID: <20220211010229.s3ghi6cbaev3uqm6@fiona>
References: <20220210165142.7zfgotun5qdtx4rq@fiona>
 <2db10c6d-513a-3b73-c694-0ef112baa389@cobb.uk.net>
 <20220210213058.m7kukfryrk4cgsye@fiona>
 <938de929-d63f-2f04-ec0a-9005ba013a2f@cobb.uk.net>
 <e0ffd0ce-d86e-1d30-dbdc-5b0f0b7cc131@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0ffd0ce-d86e-1d30-dbdc-5b0f0b7cc131@cobb.uk.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22:09 10/02, Graham Cobb wrote:
> On 10/02/2022 22:03, Graham Cobb wrote:
> > On 10/02/2022 21:30, Goldwyn Rodrigues wrote:
> >> On 19:54 10/02, Graham Cobb wrote:
> >>> On 10/02/2022 16:51, Goldwyn Rodrigues wrote:
> >>>> If a read-write root mount is remounted as read-only, the subvolume
> >>>> is also set to read-only.
> >>>
> >>> Errrr... Isn't that exactly what I want?
> >>>
> >>> If I have a btrfs filesystem with hundreds of subvols, some of which may
> >>> be mounted into various places in my filesystem, I would expect that if
> >>> I remount the main mountpoint as RO, that all the subvols become RO as
> >>> well. I actually don't mind if the behaviour went further and remounting
> >>> ANY of the mount points as RO would make them all RO.
> >>>
> >>> My mental model is that mounting a subvol somewhere is rather like a
> >>> bind mount. And a bind mount goes RO if the underlying fs goes RO -
> >>> doesn't it?
> >>>
> >>
> >> If we want bind mount, we would use bind mount. subvolume mounts and bind
> >> mounts are different and should be treated as different features.
> > 
> > Yes that's a good point. However, I am still not convinced that this is
> > a change in behaviour that is obvious enough to justify the risk of
> > disruption to existing systems, admin scripts or system managers.
> > 
> >>
> >>> Or am I just confused about what this patch is discussing?
> >>
> >> Root can also be considered as a unique subvolume with a unique
> >> subvolume id and a unique name=/
> > 
> > But with an important special property that is different from all other
> > subvolumes: all other subvolumes are reachable from it.

Not quite. You can mount a subvolume directly without mounting the root:

mount -o subvol=<subvolname> <device> <mountpoint>

> 
> I should be a bit clearer. Imagine you create a filesystem and then
> create two subvolumes within it: a and a/b. You are suggesting that the
> result of remounting the top level of the filesystem as RO causes
> different effect on whether subvolume b goes RO depending on whether
> subvolume a has also been mounted somewhere?

I did not understand the question, too many "whether"s. :)

Check the test case.

If you mount a root subvolume (/) and a root's subvolume (/a or /a/b in your
case). You remount root as ro, the subvolume a or a/b mounts also become
read-only. 

On the other hand, if you mount a or a/b (RW) _after_ root is remounted RO,
the subvolume mounts are RW.


-- 
Goldwyn
