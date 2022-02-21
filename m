Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61874BEA8E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Feb 2022 20:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiBUSf6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Feb 2022 13:35:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiBUSdq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:33:46 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C883A15A07
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Feb 2022 10:31:41 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMDTI-003hks-9M; Mon, 21 Feb 2022 18:31:40 +0000
Date:   Mon, 21 Feb 2022 18:31:40 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] umount/__detach_mounts() race
Message-ID: <YhPajBB8rQc9KEZl@zeniv-ca.linux.org.uk>
References: <YhMAy1WseafC+uIv@zeniv-ca.linux.org.uk>
 <YhMdVcrtXGLTrbWR@zeniv-ca.linux.org.uk>
 <87tucscgm5.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tucscgm5.fsf@email.froward.int.ebiederm.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:46:26AM -0600, Eric W. Biederman wrote:

> Such as breaking userspace code? Maybe.
> 
> Currently we exempt nsfs dentries from the same namespace restriction
> when cloning them.
> 
> If I read your proposal correctly you are proposing only exempting nsfs
> dentries that are internally mounted from the same namespace
> restriction.
> 
> We need to keep the ordinary case of bind mounts from one nsfs dentry to
> another dentry working even after it is mounted.

Sure - all of that is only checked if old_path.mnt is not already in our
namespace.  If you bind it in one place and then bind that to another,
the usual logics will trigger.
