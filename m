Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4C26DFDD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 20:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjDLSoE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 14:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjDLSoC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:44:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389083C21;
        Wed, 12 Apr 2023 11:44:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D8EF11F8A3;
        Wed, 12 Apr 2023 18:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681325039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R8oh8fCTXsbgnIAiluTdCXt71YGvM6XVaCLxs6/UzYg=;
        b=gxNCvlnXWGT2Wk0n362XyEavrRxkY1vSUrc7Amhc4pLSmIAk9sr5PU9vCBtqblidIKdpyb
        HmeJvbvJZIjVXqtr7cJkdrqCdoOTrl4RIuaf3yu5i5lVI5nf+RANme7wYwSzL7jD/hNS1Q
        xsDul2VtOI+rWdpXQE/4MgHZbkBCbQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681325039;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R8oh8fCTXsbgnIAiluTdCXt71YGvM6XVaCLxs6/UzYg=;
        b=xCaZupbAdj1qQbkxi6AG3lhOFGxSwHrLRkGIXTZ5OU5PfUIfIwKPfTIBWFTRfovJEbI9yk
        JVihB73pSk8Nf/CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C16AC13498;
        Wed, 12 Apr 2023 18:43:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uF2+Lu/7NmRpBwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 12 Apr 2023 18:43:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0A3C4A0732; Wed, 12 Apr 2023 20:43:59 +0200 (CEST)
Date:   Wed, 12 Apr 2023 20:43:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [RFC][PATCH] fanotify: Enable FAN_REPORT_FID on more filesystem
 types
Message-ID: <20230412184359.grx7qyujnb63h4oy@quack3>
References: <20230411124037.1629654-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411124037.1629654-1-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Tue 11-04-23 15:40:37, Amir Goldstein wrote:
> If kernel supports FAN_REPORT_ANY_FID, use this flag to allow testing
> also filesystems that do not support fsid or NFS file handles (e.g. fuse).
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Jan,
> 
> I wanted to run an idea by you.
> 
> My motivation is to close functional gaps between fanotify and inotify.
> 
> One of the largest gaps right now is that FAN_REPORT_FID is limited
> to a subset of local filesystems.
> 
> The idea is to report fid's that are "good enough" and that there
> is no need to require that fid's can be used by open_by_handle_at()
> because that is a non-requirement for most use cases, unpriv listener
> in particular.

OK. I'd note that if you report only inode number, you are prone to the
problem that some inode gets freed (file deleted) and then reallocated (new
file created) and the resulting identifier is the same. It can be
problematic for a listener to detect these cases and deal with them.
Inotify does not have this problem at least for some cases because 'wd'
uniquely identifies the marked inode. For other cases (like watching dirs)
inotify has similar sort of problems. I'm muttering over this because in
theory filesystems not having i_generation counter on disk could approach
the problem in a similar way as FAT and then we could just use
FILEID_INO64_GEN for the file handle.

Also I have noticed your workaround with using st_dev for fsid. As I've
checked, there are actually very few filesystems that don't set fsid these
days. So maybe we could just get away with still refusing to report on
filesystems without fsid and possibly fixup filesystems which don't set
fsid yet and are used enough so that users complain?

> I chose a rather generic name for the flag to opt-in for "good enough"
> fid's.  At first, I was going to make those fid's self describing the
> fact that they are not NFS file handles, but in the name of simplicity
> to the API, I decided that this is not needed.

I'd like to discuss a bit about the meaning of the flag. On the first look
it is a bit strange to have a flag that says "give me a fh, if you don't
have it, give me ino". It would seem cleaner to have "give me fh" kind of
interface (FAN_REPORT_FID) and "give me ino" kind of interface (new
FAN_REPORT_* flag). I suspect you've chosen the more complex meaning
because you want to allow a usecase where watches of filesystems which
don't support filehandles are mixed with watches of filesystems which do
support filehandles in one notification group and getting filehandles is
actually prefered over getting just inode numbers? Do you see real benefit
in getting file handles when userspace has to implement fallback for
getting just inode numbers anyway?

> The patch below is from the LTP test [1] that verifies reported fid's.
> I am posting it because I think that the function fanotify_get_fid()
> demonstrates well, how a would-be fanotify library could be used to get
> a canonical fid.
> 
> That would-be routine can easily return the source of the fid values
> for a given filesystem and that information is constant for all objects
> on a given filesystem instance.
> 
> The choise to encode an actual file_handle of type FILEID_INO64 may
> seem controversial at first, but it simplifies things so much, that I
> grew very fond of it.

FILEID_INO64 is a bit of a hack in particular because it's difficult to
pretend FILEID_INO64 can be used for NFS. But I agree it is very convenient
:). If we were to do this cleanly we'd have to introduce a new info
structure with ino instead of handle and three new FAN_EVENT_INFO_TYPE_*
types. As I wrote above, we might be able to actually fill-in
FILEID_INO64_GEN which would be less controversial then I suppose.

> The LTP patch also demonstrated how terribly trivial it would be to
> adapt any existing fanotify programs to support any fs.
> 
> Kernel patches [2] are pretty simple IMO and
> man page patch [3] demonstrates that the API changes are minimal.
> 
> Thoughts?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
