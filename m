Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724ED5B5AB0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 14:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiILM5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 08:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiILM5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:57:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8C2F56
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 05:57:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6B55A337A0;
        Mon, 12 Sep 2022 12:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662987455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rjiMFv3rJ4a6Wmtlqx9R9155H/X8ELw+UW3YDthOnUE=;
        b=YdnCJ2KtGNinrA60bR5CUl3s6F9zQVceqdsF9Nv8F+T9qlOtAuEDFzX74q8u1BJ+Vfnrhy
        smxdGN2qyebyvue/m5HePpIWjJKOwmAdGdL5KHLQeCHMKDRwhxGJ5b9Kbho9BA3i1okHIo
        +Kid4KlGjUmMdObYpSVezh/ediNz8KE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662987455;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rjiMFv3rJ4a6Wmtlqx9R9155H/X8ELw+UW3YDthOnUE=;
        b=bKtnwSgkyR60om1KtfyZ2VlTrDVyoZZ4+rCz3jg8iw5IbyXfAHF5NquBX7ZATG2BS1b/r/
        +eVN2OA13QmmwPCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F5C6139E0;
        Mon, 12 Sep 2022 12:57:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QSs8F78sH2PBIAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 12 Sep 2022 12:57:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DD12CA067E; Mon, 12 Sep 2022 14:57:34 +0200 (CEST)
Date:   Mon, 12 Sep 2022 14:57:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: thoughts about fanotify and HSM
Message-ID: <20220912125734.wpcw3udsqri4juuh@quack3>
References: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhrQ7hySTyHM0Atq=uzbNdHyGV5wfadJarhAu1jDFOUTg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Amir!

On Sun 11-09-22 21:12:06, Amir Goldstein wrote:
> I wanted to consult with you about preliminary design thoughts
> for implementing a hierarchical storage manager (HSM)
> with fanotify.
> 
> I have been in contact with some developers in the past
> who were interested in using fanotify to implement HSM
> (to replace old DMAPI implementation).

Ah, DMAPI. Shiver. Bad memories of carrying that hacky code in SUSE kernels
;)

So how serious are these guys about HSM and investing into it? Because
kernel is going to be only a small part of what's needed for it to be
useful and we've dropped DMAPI from SUSE kernels because the code was
painful to carry (and forwardport + it was not of great quality) and the
demand for it was not really big... So I'd prefer to avoid the major API
extension unless there are serious users out there - perhaps we will even
need to develop the kernel API in cooperation with the userspace part to
verify the result is actually usable and useful. But for now we can take it
as an interesting mental excercise ;)

> Basically, FAN_OPEN_PERM + FAN_MARK_FILESYSTEM
> should be enough to implement a basic HSM, but it is not
> sufficient for implementing more advanced HSM features.
> 
> Some of the HSM feature that I would like are:
> - blocking hook before access to file range and fill that range
> - blocking hook before lookup of child and optionally create child
> 
> My thoughts on the UAPI were:
> - Allow new combination of FAN_CLASS_PRE_CONTENT
>   and FAN_REPORT_FID/DFID_NAME
> - This combination does not allow any of the existing events
>   in mask
> - It Allows only new events such as FAN_PRE_ACCESS
>   FAN_PRE_MODIFY and FAN_PRE_LOOKUP
> - FAN_PRE_ACCESS and FAN_PRE_MODIFY can have
>   optional file range info
> - All the FAN_PRE_ events are called outside vfs locks and
>   specifically before sb_writers lock as in my fsnotify_pre_modify [1]
>   POC
> 
> That last part is important because the HSM daemon will
> need to make modifications to the accessed file/directory
> before allowing the operation to proceed.

My main worry here would be that with FAN_FILESYSTEM marks, there will be
far to many events (especially for the lookup & access cases) to reasonably
process. And since the events will be blocking, the impact on performance
will be large.

I think that a reasonably efficient HSM will have to stay in the kernel
(without generating work for userspace) for the "nothing to do" case. And
only in case something needs to be migrated, event is generated and
userspace gets involved. But it isn't obvious to me how to do this with
fanotify (I could imagine it with say overlayfs which is kind of HSM
solution already ;)).

> Naturally that opens the possibility for new userspace
> deadlocks. Nothing that is not already possible with permission
> event, but maybe deadlocks that are more inviting to trip over.
> 
> I am not sure if we need to do anything about this, but we
> could make it easier to ignore events from the HSM daemon
> itself if we want to, to make the userspace implementation easier.

So if the events happen only in the "migration needed" case, I don't think
deadlocks would be too problematic - it just requires a bit of care from
userspace so that the event processing & migration processes do not access
HSM managed stuff.

> Another thing that might be good to do is provide an administrative
> interface to iterate and abort pending fanotify permission/pre-content
> events.

You can always kill the listener. Or are you worried about cases where it
sleeps in UN state?

> You must have noticed the overlap between my old persistent
> change tracking journal and this design. The referenced branch
> is from that old POC.
> 
> I do believe that the use cases somewhat overlap and that the
> same building blocks could be used to implement a persistent
> change journal in userspace as you suggested back then.
> 
> Thoughts?

Yes, there is some overlap. But OTOH HSM seems to require more detailed and
generally more frequent events which seems like a challenge.

> [1] https://github.com/amir73il/linux/commits/fsnotify_pre_modify

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
