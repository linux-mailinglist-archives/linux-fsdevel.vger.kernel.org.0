Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FAE4D7DD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 09:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiCNIsR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 04:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiCNIsR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 04:48:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0203D3B01D
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Mar 2022 01:47:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A30071F37E;
        Mon, 14 Mar 2022 08:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647247626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uYIJlvr9prnMHB9zAmfFbf8VkrYiOhoizKkSPVCvcF0=;
        b=fsN03MQIvm9+2lQxbZWSwQxUa4mx49f3pX1CW4cEKuH+ZSgv5rqfjOr+aWQuQhhVyoUS9I
        pWm9e2182nFMq15G96EyXict3urNPuKHnbYoqr/fPM8hartRas61EKhQeGd5ppWpSDJ6GQ
        6kZtg7/t4kUrt+OTeSxbA7OJQW68vXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647247626;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uYIJlvr9prnMHB9zAmfFbf8VkrYiOhoizKkSPVCvcF0=;
        b=V4xfOgVVkV5vk5HOVmLc2/300g62oLzICc2JqHxHs+BqQiIAAJsSuAQf+3TGwEVdP56k32
        961p9zlO7Qn4LIAw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8E239A3B89;
        Mon, 14 Mar 2022 08:47:06 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 31165A0615; Mon, 14 Mar 2022 09:47:06 +0100 (CET)
Date:   Mon, 14 Mar 2022 09:47:06 +0100
From:   Jan Kara <jack@suse.cz>
To:     Srinivas <talkwithsrinivas@yahoo.co.in>
Cc:     Jan Kara <jack@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: Fanotify Directory exclusion not working when using
 FAN_MARK_MOUNT
Message-ID: <20220314084706.ncsk754gjywkcqxq@quack3.lan>
References: <1357949524.990839.1647084149724.ref@mail.yahoo.com>
 <1357949524.990839.1647084149724@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1357949524.990839.1647084149724@mail.yahoo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 12-03-22 11:22:29, Srinivas wrote:
> If a  process calls fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_MOUNT,
> FAN_OPEN_PERM, 0, "/mountpoint") no other directory exclusions can be
> applied.
> 
> However a path (file) exclusion can still be applied using 
> 
> fanotify_mark(fd, FAN_MARK_ADD | FAN_MARK_IGNORED_MASK |
> FAN_MARK_IGNORED_SURV_MODIFY, FAN_OPEN_PERM | FAN_CLOSE_WRITE, AT_FDCWD,
> "/tmp/fio/abc");  ===> path exclusion that works.
> 
> I think the directory exclusion not working is a bug as otherwise AV
> solutions cant exclude directories when using FAN_MARK_MOUNT.
> 
> I believe the change should be simple since we are already supporting
> path exclusions. So we should be able to add the same for the directory
> inode.
> 
> 215676 – fanotify Ignoring/Excluding a Directory not working with
> FAN_MARK_MOUNT (kernel.org)

Thanks for report! So I believe this should be fixed by commit 4f0b903ded
("fsnotify: fix merge with parent's ignored mask") which is currently
sitting in my tree and will go to Linus during the merge (opening in a
week).

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
