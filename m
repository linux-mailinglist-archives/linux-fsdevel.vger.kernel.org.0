Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC4852C34F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 May 2022 21:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241968AbiERT1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 May 2022 15:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241962AbiERT1O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 May 2022 15:27:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1BA5AEE5;
        Wed, 18 May 2022 12:27:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8F75B821A6;
        Wed, 18 May 2022 19:27:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68640C385A9;
        Wed, 18 May 2022 19:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652902030;
        bh=lmUg0JefmHdOdMZIz8mwoSC0s8SSSv+qaPcEDU25+Mo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rHjG0g/e43nPj6fRg3NPpB8iajmZa0UDhf7m2CKsB260KAX9zav9wA5OXgAWAh0eP
         Nsr25+VbQh4yxYdueRXagZyR5i8ra1bh7olbnnTgmpzyTd5EWZg7BAyUDQCAwmZsFO
         covqEzrK+gPjFBXVWNJ2vivUTv/d9/qVrBnZT4iM=
Date:   Wed, 18 May 2022 12:27:09 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH -next] exec: Remove redundant check in
 do_open_execat/uselib
Message-Id: <20220518122709.7fb5176967fb69324c260853@linux-foundation.org>
In-Reply-To: <202205181215.D448675BEA@keescook>
References: <20220518081227.1278192-1-chengzhihao1@huawei.com>
        <20220518104601.fc21907008231b60a0e54a8e@linux-foundation.org>
        <202205181215.D448675BEA@keescook>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 18 May 2022 12:17:45 -0700 Kees Cook <keescook@chromium.org> wrote:

> > > -	/*
> > > -	 * may_open() has already checked for this, so it should be
> > > -	 * impossible to trip now. But we need to be extra cautious
> > > -	 * and check again at the very end too.
> > > -	 */
> > > -	error = -EACCES;
> > > -	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
> > > -			 path_noexec(&file->f_path)))
> > > -		goto exit;
> > > -
> > 
> > Maybe we should retain the `goto exit'.  The remount has now occurred,
> > so the execution attempt should be denied.  If so, the comment should
> > be updated to better explain what's happening.
> > 
> > I guess we'd still be racy against `mount -o exec', but accidentally
> > denying something seems less serious than accidentally permitting it.
> 
> I'd like to leave this as-is, since we _do_ want to find the cases where
> we're about to allow an exec and a very important security check was NOT
> handled.

In which case we don't want the "_ONCE".  If some app is hammering away
at this trying to hit a race window then the operator wants that log
flood.

Or,umm, fix the dang race?
