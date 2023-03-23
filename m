Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8885E6C6B15
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 15:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjCWOdw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 10:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCWOdu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:33:50 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D5555AB
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 07:33:50 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32NEXKRh010278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Mar 2023 10:33:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679582002; bh=n243UkKU1dhQVd7DjzyG88PTzABaz+ZslvR4BBb7qqM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=C3A0S93pvXptCixS1bEn3ZWm9blHoINL7rmJpXmQ1AI7LQGCBhlTVKfMLttc30AIn
         /mAkwxzcSQSI0LfDGTdodwzmQDF1WfDq5nhLyLR5dJSq62jIUF561n3LmfRrhkeXD0
         jaAKzhThfspyr6g9LbQrIK3tRaZGgeUwWayayD0c30L31WXijUnIdOosyubFeRQUE6
         Qfph8eAvQVenwT9qIjh04pXV6mIe9Z3kC+ADrsy/sCzGeRJRn7cb5xxItr4H428WNj
         0vflOAGwsHWvpz0tyfzrhIEfOInbeCSQVJ0tSCX6vFHxeYGYKD85IbOHpNEBve3wDB
         LUASlnZ/kqEXg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5669715C4279; Thu, 23 Mar 2023 10:33:20 -0400 (EDT)
Date:   Thu, 23 Mar 2023 10:33:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     viro@zeniv.linux.org.uk, jaegeuk@kernel.org, ebiggers@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel@collabora.com
Subject: Re: [PATCH 1/7] fs: Expose name under lookup to d_revalidate hook
Message-ID: <20230323143320.GC136146@mit.edu>
References: <20220622194603.102655-1-krisman@collabora.com>
 <20220622194603.102655-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622194603.102655-2-krisman@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_INVALID,DKIM_SIGNED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 22, 2022 at 03:45:57PM -0400, Gabriel Krisman Bertazi wrote:
> Negative dentries support on case-insensitive ext4/f2fs will require
> access to the name under lookup to ensure it matches the dentry.  This
> adds an optional new flavor of cached dentry revalidation hook to expose
> this extra parameter.
> 
> I'm fine with extending d_revalidate instead of adding a new hook, if
> it is considered cleaner and the approach is accepted.  I wrote a new
> hook to simplify reviewing.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>


Al, could you take a look and see if you have any objections?

Also, any thoughts about adding the new d_revalidate_name() callback
as opposed to change d_revalidate() to add an extra parameter?  It
looks like there are some 33 d_revalidate callbacks, from 24 file
sysetms, that would have to be changed.

Cheers,

					- Ted
