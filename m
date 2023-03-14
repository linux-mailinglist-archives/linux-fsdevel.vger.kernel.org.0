Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DCC6B9668
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 14:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjCNNgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 09:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCNNgP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:36:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722B61420C
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Mar 2023 06:32:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0060021AEB;
        Tue, 14 Mar 2023 13:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678800738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IT+mb6PvmWfSs9ETOit6YSVPlOJgcNa4g15uj/sVF7I=;
        b=zMdySC3wdwe9IAoWG1z3IV/RCTwkK7Zu6dcD4MQULZVGQzOpaw/n1nhw4Zr+FzkcTCKkcw
        laTX97YZ17UH9G2X8iBShMsCqg1DOhrYZnkm9QfUQAeVZlVJQl/xXdJzm7UeuBLYUJAkn4
        CHb7MR41AFOErycTWW6eTTbntA540bw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678800738;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IT+mb6PvmWfSs9ETOit6YSVPlOJgcNa4g15uj/sVF7I=;
        b=WhNtZtTtnpm6hCBEcG93g2sjT/4SEAG+6UOL5BBLXuin4NEv6vDaQzQmZr7VlzFc43dYmJ
        EK3IPzsx9rHRIIAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E336D13A1B;
        Tue, 14 Mar 2023 13:32:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wUxxN2F3EGRjewAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 14 Mar 2023 13:32:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6B684A06FD; Tue, 14 Mar 2023 14:32:17 +0100 (CET)
Date:   Tue, 14 Mar 2023 14:32:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Leah Rumancik <leah.rumancik@gmail.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem backporting to stable
Message-ID: <20230314133217.nd6vwpjhu5jtxz7z@quack3>
References: <CACzhbgSZUCn-az1e9uCh0+AO314+yq6MJTTbFt0Hj8SGCiaWjw@mail.gmail.com>
 <Y/6u5ylrN2OdJm0B@magnolia>
 <ZA6LmJA/4HZMFraZ@sashalap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA6LmJA/4HZMFraZ@sashalap>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 12-03-23 22:34:00, Sasha Levin wrote:
> > How about we EOL the XFS code in the releases that nobody wants so that
> > patches can keep flowing to the ones that are still wanted?
> 
> We're in the process of going away from 6 year kernels which will in
> turn lessen the number of parallel trees we support.
> 
> OTOH, this raises the question of what Oracle plans to do after 5.4 goes
> EOL?

Well, I guess what every other distro does with old kernels. Fix whatever
customers report + a bunch of CVE fixes. We still support 2.6.16 so 5.4 is
"piece'a cake" ;)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
