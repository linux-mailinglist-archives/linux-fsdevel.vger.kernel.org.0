Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE2E75ACF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jul 2023 13:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjGTL3U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jul 2023 07:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjGTL3T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:29:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77947B7;
        Thu, 20 Jul 2023 04:29:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 38F3B22C72;
        Thu, 20 Jul 2023 11:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1689852557;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/GZFtaCwviVo3clHvhQILSVZM7UkpC7G6Eud25ti/QI=;
        b=oEnQPcKgUtQzIVT1Siaop1FqeU9dWBwzq+1qI+pfnDZji5eYRSR7szNo5CjRDmXLFkXohd
        HC3MIqXdUu9ckVB+bwkf7kyaonQxgaVlAjSbNbrM8zOD2UqJLqfi6W75owdgSm9oOUTopk
        Na1KN3mb/mrH8rk5ZU+sjrviJBdR4z4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1689852557;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/GZFtaCwviVo3clHvhQILSVZM7UkpC7G6Eud25ti/QI=;
        b=u4cs1Q5em97EoV5nqOb0e79vkudS18EV7AOLUmVJDELbIchtQeOlbAOyniPqyXE17LLSJV
        9QQl4FqIV6yuMEAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CE5D133DD;
        Thu, 20 Jul 2023 11:29:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pqpYAo0auWTvCQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 20 Jul 2023 11:29:17 +0000
Date:   Thu, 20 Jul 2023 13:22:36 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/23] btrfs: pass a flags argument to cow_file_range
Message-ID: <20230720112236.GW20457@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20230628153144.22834-1-hch@lst.de>
 <20230628153144.22834-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628153144.22834-2-hch@lst.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 05:31:22PM +0200, Christoph Hellwig wrote:
> The int used as bool unlock is not a very good way to describe the
> behavior, and the next patch will have to add another beahvior modifier.
> Switch to pass a flag instead, with an inital CFR_KEEP_LOCKED flag that
> specifies the pages should always be kept locked.  This is the inverse
> of the old unlock argument for the reason that it requires a flag for
> the exceptional behavior.

Int is the wrong type but I'm not sure that for two flags we should use
a bit flags. Two bool parameters are IMHO fine and "CFR" does not mean
anything, it's really only relevant for the function.
