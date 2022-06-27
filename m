Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97C255DAF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbiF0LZQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jun 2022 07:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbiF0LY4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:24:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FE3657B;
        Mon, 27 Jun 2022 04:24:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id AECD41F8F7;
        Mon, 27 Jun 2022 11:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656329093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YzTGenBrm+OiqMfJMDo9wynrPSJr5F5WAn1j6mWdRpA=;
        b=ZR3mW9WgOKx14/FW2Gk6L1u36VpV5n02zjYSdeg80IWzH0h7z2UJlmAOjRm30Ml42jCYpB
        ZOqYgKOtncp9bWNp2SUwdTgTtQWpZXAPmYUB9Y/YEO8En/lDIPyi+/jejnlNxhJzIc3Q0w
        clUPq2n5S/DGAWaA55xqxfPlUuFSUco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656329093;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YzTGenBrm+OiqMfJMDo9wynrPSJr5F5WAn1j6mWdRpA=;
        b=HcLaP7bxwQRymyB4zUptqugyU7pKF+CgDlAcmGqrrtfjbJrYW+6K/Njrbv42mmGp/OUxCn
        PE+xocAiSHVJiTDw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9D4A32C141;
        Mon, 27 Jun 2022 11:24:53 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4E458A062F; Mon, 27 Jun 2022 13:24:53 +0200 (CEST)
Date:   Mon, 27 Jun 2022 13:24:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] New fanotify API for ignoring events
Message-ID: <20220627112453.t733ysdrpd3iri5i@quack3.lan>
References: <20220624143538.2500990-1-amir73il@gmail.com>
 <CAOQ4uxj8CLbiOjwxZOK9jGM69suakdJtNp9=0b7W=ie4jGp3Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj8CLbiOjwxZOK9jGM69suakdJtNp9=0b7W=ie4jGp3Sg@mail.gmail.com>
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

On Sun 26-06-22 18:57:01, Amir Goldstein wrote:
> On Fri, Jun 24, 2022 at 5:35 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > As we discussed [1], here is the implementation of the new
> > FAN_MARK_IGNORE API, to try and sort the historic mess of
> > FAN_MARK_IGNORED_MASK.
> 
> When we started talking about adding FAN_MARK_IGNORE
> it was to address one specific flaw of FAN_MARK_IGNORED_MASK,
> but after staring at the API for some time, I realized there are other
> wrinkles with FAN_MARK_IGNORED_MASK that could be addressed
> by a fresh new API.
> 
> I added more input validations following the EEXIST that you requested.
> The new errors can be seen in the ERRORS section of the man page [3].
> The new restrictions will reduce the size of the test matrix, but I did not
> update the LTP tests [2] to check the new restrictions yet.
> 
> I do not plan to post v3 patches before improving the LTP tests,
> but I wanted to send this heads up as an API proposal review.
> The kernel commit that adds FAN_MARK_IGNORE [1] summarize the
> new API restrictions as follows:
> 
>     The new behavior is non-downgradable.  After calling fanotify_mark() with
>     FAN_MARK_IGNORE once, calling fanotify_mark() with FAN_MARK_IGNORED_MASK
>     on the same object will return EEXIST error.
> 
>     Setting the event flags with FAN_MARK_IGNORE on a non-dir inode mark
>     has no meaning and will return ENOTDIR error.
> 
>     The meaning of FAN_MARK_IGNORED_SURV_MODIFY is preserved with the new
>     FAN_MARK_IGNORE flag, but with a few semantic differences:
> 
>     1. FAN_MARK_IGNORED_SURV_MODIFY is required for filesystem and mount
>        marks and on an inode mark on a directory. Omitting this flag
>        will return EINVAL or EISDIR error.
> 
>     2. An ignore mask on a non-directory inode that survives modify could
>        never be downgraded to an ignore mask that does not survive modify.
>        With new FAN_MARK_IGNORE semantics we make that rule explicit -
>        trying to update a surviving ignore mask without the flag
>        FAN_MARK_IGNORED_SURV_MODIFY will return EEXIST error.
> 
>     The conveniene macro FAN_MARK_IGNORE_SURV is added for
>     (FAN_MARK_IGNORE | FAN_MARK_IGNORED_SURV_MODIFY), because the
>     common case should use short constant names.

This looks good to me. Thanks for working on this. The only additional
thing that occurred to me is that we might want to restrict events usable
with FAN_MARK_IGNORE similarly as we did restrict non-sensical events with
FAN_REPORT_TARGET_FID but after putting more thought into it I'm not sure
it is such a great idea because it is not so obvious which events may
be valid to ignore for a particular object and how is it with backward
compatibility when a new type of event becomes possible for an object.

								Honza
 
> [1] https://github.com/amir73il/linux/commits/fan_mark_ignore
> [2] https://github.com/amir73il/ltp/commits/fan_mark_ignore
> [3] https://github.com/amir73il/man-pages/commits/fan_mark_ignore
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
