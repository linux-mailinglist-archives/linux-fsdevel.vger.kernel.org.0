Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872315550A2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jun 2022 18:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376393AbiFVQBz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jun 2022 12:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376336AbiFVQBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:01:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB65D4;
        Wed, 22 Jun 2022 09:00:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5FE3E21C8F;
        Wed, 22 Jun 2022 16:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655913650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UHjSRmma6M/WmRUm+RwQQFmHFLU3YNOPTDkKjsHF8kU=;
        b=BU5Q4P9yjBzX8LZBlci6zbmeXCuYm4wXLT1aEsPGUH5SXYjnJBY+Dxg32VAR40KEIZ2VIe
        UGd66Yd5N+fdH6uz3kxvZ0/3mhWAc+fWetY/FtUrGnlebCma0uJlEoEHewNLy/49GDa0ce
        dXI7o9SIM6gnnzSO/rl12GK1GeRHJ7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655913650;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UHjSRmma6M/WmRUm+RwQQFmHFLU3YNOPTDkKjsHF8kU=;
        b=1ft6gkkelxmF2/mkUATuYFA/TTpceB1eyvd1N4efenjuKyVmdHO952/PIyAUguTQV46AeM
        G5kh3URag+u1cPAA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4D2E32C141;
        Wed, 22 Jun 2022 16:00:50 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EDAD2A062B; Wed, 22 Jun 2022 18:00:49 +0200 (CEST)
Date:   Wed, 22 Jun 2022 18:00:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 1/2] fanotify: prepare for setting event flags in ignore
 mask
Message-ID: <20220622160049.koda4uazle7i2735@quack3.lan>
References: <20220620134551.2066847-1-amir73il@gmail.com>
 <20220620134551.2066847-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620134551.2066847-2-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 20-06-22 16:45:50, Amir Goldstein wrote:
> Setting flags FAN_ONDIR FAN_EVENT_ON_CHILD in ignore mask has no effect.
> The FAN_EVENT_ON_CHILD flag in mask implicitly applies to ignore mask and
> ignore mask is always implicitly applied to events on directories.
> 
> Define a mark flag that replaces this legacy behavior with logic of
> applying the ignore mask according to event flags in ignore mask.
> 
> Implement the new logic to prepare for supporting an ignore mask that
> ignores events on children and ignore mask that does not ignore events
> on directories.
> 
> To emphasize the change in terminology, also rename ignored_mask mark
> member to ignore_mask and use accessor to get only ignored events or
> events and flags.
> 
> This change in terminology finally aligns with the "ignore mask"
> language in man pages and in most of the comments.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

..

> @@ -423,7 +425,8 @@ static bool fsnotify_iter_select_report_types(
>  			 * But is *this mark* watching children?
>  			 */
>  			if (type == FSNOTIFY_ITER_TYPE_PARENT &&
> -			    !(mark->mask & FS_EVENT_ON_CHILD))
> +			    !(mark->mask & FS_EVENT_ON_CHILD) &&
> +			    !(fsnotify_ignore_mask(mark) & FS_EVENT_ON_CHILD))
>  				continue;

So now we have in ->report_mask the FSNOTIFY_ITER_TYPE_PARENT if either
->mask or ->ignore_mask have FS_EVENT_ON_CHILD set. But I see nothing that
would stop us from applying say ->mask to the set of events we are
interested in if FS_EVENT_ON_CHILD is set only in ->ignore_mask? And
there's the same problem in the other direction as well. Am I missing
something?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
