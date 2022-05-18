Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A2C52BCA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 16:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237776AbiERNYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 09:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiERNX6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 09:23:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA88C14ACB3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 May 2022 06:23:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id EA7E021AE1;
        Wed, 18 May 2022 13:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652880233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nww4hiLMEsNZOQlfFoeQ45ARSspsWlJ446MTJ6BhLUA=;
        b=R8DMuQYBD1LRcbxfa83WBsmW8u0wsCV5IJIi7B4yurgH1p/2qK2wURpMtc5CcbPET98rDh
        5IIdWn7FlWCqKqNVK5If4Yi/yTn5X/7SxQiftwI/9PKjKXN6Wf6l+55rhr7+OemOlHyxs5
        +nrkz3tTsufgY6YkYe7sNC1pVQJvmLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652880233;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nww4hiLMEsNZOQlfFoeQ45ARSspsWlJ446MTJ6BhLUA=;
        b=atAO34QWDYWiTvd32vGfj+aAF4c0A1Qdqr28hjdtuTv5RPd2k4nKTGKRQ0RrJ7Ms5kRpe+
        yOSLmLV6vVEc2sAw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0FE2C2C143;
        Wed, 18 May 2022 13:23:53 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5B9D6A062F; Wed, 18 May 2022 15:23:47 +0200 (CEST)
Date:   Wed, 18 May 2022 15:23:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Fixes for fanotify parent dir ignore mask logic
Message-ID: <20220518132347.ulrpnwm4zdjsygfq@quack3.lan>
References: <20220511190213.831646-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511190213.831646-1-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 11-05-22 22:02:11, Amir Goldstein wrote:
> Jan,
> 
> The following two patches are a prelude to FAN_MARK_IGNORE patch set [1].
> I have written tests [2] and man page draft [3] for FAN_MARK_IGNORE, but
> not proposing it for next, because one big UAPI change is enough and it
> is too late in the cycle anyway.
> 
> However, I though you may want to consider these two patches for next.
> The test fanotify09 on [2] has two new test cases for the fixes in these
> patches.
> 
> Thanks,
> Amir.
> 
> Changes since v1:
> - Change hacky mark iterator macros
> - Clarify mark iterator in fsnotify_iter_next()
> - Open code parent mark type logic in
>   fsnotify_iter_select_report_types()


Thanks! I've pushed the changes into my tree and updated the comment in
patch 1 as you suggested.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
