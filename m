Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B386D5BB9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Apr 2023 11:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbjDDJVO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 05:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjDDJVN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:21:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFA21982
        for <linux-fsdevel@vger.kernel.org>; Tue,  4 Apr 2023 02:21:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 17CDA22848;
        Tue,  4 Apr 2023 09:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680600070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5xoIXDtz3wCeJYX9gFZo4Bp9lKU7fCdIAG+Xgm5y23k=;
        b=O9St/87zLJa8n5mfkP+afxZVqP+6Pg0VQ3yFe6xLWxRr3AVmtnrr/ttuZuCBP3Sx7bxWiV
        r/r+lJrBAgConv4Pkvqq3ZfcKNaXrvmHcT3nkWhqmAit7Q00XVtn9ep3QAz9YKzMBAo6dJ
        jqvA3/UNaUE0MjtcmqfFc7I7rNKoffI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680600070;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5xoIXDtz3wCeJYX9gFZo4Bp9lKU7fCdIAG+Xgm5y23k=;
        b=yLHqsYt/Q1rn++dQH9yx3CB+x1hWgxKxzmBXU1xDvEqatUW8ilyPkLXj40dmU5DNslgR+w
        bBK5ZI4LN1ztIyAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 088701391A;
        Tue,  4 Apr 2023 09:21:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +uAGAgbsK2QuNgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 04 Apr 2023 09:21:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 886E5A0732; Tue,  4 Apr 2023 11:21:09 +0200 (CEST)
Date:   Tue, 4 Apr 2023 11:21:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        shepjeng@gmail.com, kernel@cccheng.net,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] splice: report related fsnotify events
Message-ID: <20230404092109.evsvdcv6p2e5bvtf@quack3>
References: <20230322062519.409752-1-cccheng@synology.com>
 <CAOQ4uxiAbMaXqa8r-ErVsM_N1eSNWq+Wnyua4d+Eq89JZWb7sA@mail.gmail.com>
 <CAOQ4uxg_=7ypNL1nZKQ-=Sp-Q11sQjA4Jbws3Zgxgvirdw242w@mail.gmail.com>
 <cd875f29-7dd8-58bd-1c81-af82a6f1cb88@kernel.dk>
 <CAOQ4uxjf2rHyUWYB+K-YqKBxq_0mLpOMfqnFm4njPJ+z+6nGcw@mail.gmail.com>
 <80ccc66e-b414-6b68-ae10-59cf38745b45@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80ccc66e-b414-6b68-ae10-59cf38745b45@kernel.dk>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 03-04-23 11:23:25, Jens Axboe wrote:
> On 4/3/23 11:15?AM, Amir Goldstein wrote:
> >> On 4/3/23 11:00?AM, Amir Goldstein wrote:
> >> io_uring does do it for non-polled IO, I don't think there's much point
> >> in adding it to IOPOLL however. Not really seeing any use cases where
> >> that would make sense.
> >>
> > 
> > Users subscribe to fsnotify because they want to be notified of changes/
> > access to a file.
> > Why do you think that polled IO should be exempt?
> 
> Because it's a drastically different use case. If you're doing high
> performance polled IO, then you'd never rely on something as slow as
> fsnotify to tell you of any changes that happened to a device or file.
> That would be counter productive.

Well, I guess Amir wanted to say that the application using fsnotify is not
necessarily the one doing high performance polled IO. You could have e.g.
data mirroring application A tracking files that need mirroring to another
host using fsnotify and if some application B uses high performance polled
IO to modify a file, application A could miss the modified file.

That being said if I look at exact details, currently I don't see a very
realistic usecase that would have problems (people don't depend on
FS_MODIFY or FS_ACCESS events too much, usually they just use FS_OPEN /
FS_CLOSE), which is likely why nobody reported these issues yet :).

								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
