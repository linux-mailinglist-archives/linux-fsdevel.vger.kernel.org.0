Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965334DCA4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 16:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiCQPrR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 11:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbiCQPrQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:47:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4641AD3A5
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 08:45:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D2133210FD;
        Thu, 17 Mar 2022 15:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647531950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wsKmD7VBh3/FtyFAYCAOdn3XSx9fZIy8rL7/rmN8IGc=;
        b=qF/pYOpyGJ3sgdjDNXlp0fr6yGGRG2vEysExeJQA4VL5HTiGOqZ+cjfKpwRQ73BoqLmOqd
        sWgCHcg8cMlptbVO1/qLllxcXEn5gPJQ9FfAWIhb4AugywYh2ZAOHmvqbSm4Ty+aRIytbf
        LM2lSa5fECG3zAlZvkvlxop4DFqNoDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647531950;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wsKmD7VBh3/FtyFAYCAOdn3XSx9fZIy8rL7/rmN8IGc=;
        b=TBJ9DQRiOJg/bCUFETxGqpC+IlTu5EHun8GeWbQQXBxvQnoU+2gJxAmIguXx+tWsnoH4vW
        H4RHS1kSIbplvdCg==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BF961A3B89;
        Thu, 17 Mar 2022 15:45:50 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 77052A0615; Thu, 17 Mar 2022 16:45:50 +0100 (CET)
Date:   Thu, 17 Mar 2022 16:45:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] fanotify: add support for exclusive create of mark
Message-ID: <20220317154550.y3rvxmmfcaf5n5st@quack3.lan>
References: <20220307155741.1352405-1-amir73il@gmail.com>
 <20220307155741.1352405-5-amir73il@gmail.com>
 <20220317153443.iy5rvns5nwxlxx43@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317153443.iy5rvns5nwxlxx43@quack3.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 17-03-22 16:34:43, Jan Kara wrote:
> On Mon 07-03-22 17:57:40, Amir Goldstein wrote:
> > Similar to inotify's IN_MARK_CREATE, adding an fanotify mark with flag
> > FAN_MARK_CREATE will fail with error EEXIST if an fanotify mark already
> > exists on the object.
> > 
> > Unlike inotify's IN_MARK_CREATE, FAN_MARK_CREATE has to supplied in
> > combination with FAN_MARK_ADD (FAN_MARK_ADD is like inotify_add_watch()
> > and the behavior of IN_MARK_ADD is the default for fanotify_mark()).
> > 
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> 
> What I'm missing in this changelog is "why". Is it just about feature
> parity with inotify? I don't find this feature particularly useful...

OK, now I understand after reading patch 5/5. Hum, but I'm not quite happy
about the limitation to non-existing mark as much as I understand why you
need it. Let me think...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
