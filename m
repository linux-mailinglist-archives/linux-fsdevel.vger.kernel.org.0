Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2639275AD86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 13:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjGTLyb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 07:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjGTLyX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:54:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31C430D0;
        Thu, 20 Jul 2023 04:54:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B96CF22BC4;
        Thu, 20 Jul 2023 11:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689854042;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KGcCAZ5I8bnB47Msu3RUYDroaG1uTPJ1kYihs3AE/sU=;
        b=R+cNwd++4wC8juSRvSxWjev/LFcidjVN3iwbNJ3u3W8XmY0Khd7gepU2AD5YscMwBJrCT3
        +/YGSJIKvkvnJUsqp+Q9GwTIAX8pgi+cuQ3MwAu5kctEiZVddZosCJsHIdJu17p1nSyoJo
        skKTfUkTAKAlLydvTHHR7uhMTgkmRmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689854042;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KGcCAZ5I8bnB47Msu3RUYDroaG1uTPJ1kYihs3AE/sU=;
        b=HzWYNBJn1sg+K8+Xm4DvnPbQuP9/ywGckUXcH9BTxuJkj+8c+5sbpXeeHPdzPLS/aoUWh9
        kQgiGcOdWXoYdIAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E0C7138EC;
        Thu, 20 Jul 2023 11:54:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IwfwIVoguWTGFwAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 20 Jul 2023 11:54:02 +0000
Date:   Thu, 20 Jul 2023 13:47:22 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: btrfs compressed writeback cleanups
Message-ID: <20230720114722.GY20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230628153144.22834-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628153144.22834-1-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 05:31:21PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series is a prequel to another big set of writeback patches, and
> mostly deals with compressed writeback, which does a few things very
> different from other writeback code.  The biggest results are the removal
> of the magic redirtying when handing off to the worker thread, and a fix
> for out of zone active resources handling when using compressed writeback
> on a zoned file system, but mostly it just removes a whole bunch of code.
> 
> Note that the first 5 patches have been out on the btrfs list as
> standalone submissions for a while, but they are included for completeness
> so that this series can be easily applied to the btrfs misc-next tree.

Besides the minor comment for patch 1 the rest looks good, rolls back
the evolution of the compression code to a good state. The flags to bool
is trivial change so I'd rather do it locally and you don't need to
resend. Thanks.
