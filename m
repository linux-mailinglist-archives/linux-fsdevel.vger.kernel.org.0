Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B314ACBEE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 23:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbiBGWRW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 17:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244054AbiBGWRR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:17:17 -0500
X-Greylist: delayed 409 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 14:17:15 PST
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB8BC061355;
        Mon,  7 Feb 2022 14:17:15 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=nerdbynature.de; i=@nerdbynature.de; q=dns/txt; s=key1;
 t=1644271824; h=date : from : to : cc : subject : in-reply-to :
 message-id : references : mime-version : content-type : from;
 bh=YDvfiw2/shfvHf2dTsRDeWDpQS7n9L1BOkNlOpDAq+0=;
 b=yGtRoHpE2Dt+N/NRXKoH7CyZ/ulBy09JLZXYQikDPqzfHxOgg4RuvoH/UyjFlPNRa6fna
 RKe8wfM8DgJCh4HCg==
Authentication-Results: mail.nerdbynature.de; dmarc=fail (p=none dis=none) header.from=nerdbynature.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nerdbynature.de;
 i=@nerdbynature.de; q=dns/txt; s=key0; t=1644271824; h=date : from :
 to : cc : subject : in-reply-to : message-id : references :
 mime-version : content-type : from;
 bh=YDvfiw2/shfvHf2dTsRDeWDpQS7n9L1BOkNlOpDAq+0=;
 b=P0camZa6ejb9S3SR257EbKxZjIMzASPuwQrAb1LNZJqnD6zGgtKUus0X0kLvfyVs4YVZE
 OVgbcDuvogWJt+1MsvDRNz4MbIJV8PELTQIreX0URSvSVP8X1Ho1ZKB/rW9UC7x0TkJ0JlT
 vHKcjnAvBX3tJdQAuqthzSdV/GXdPj1ohLBd/fPNy8ZLP3afRFtneyphR1JewsJDkoUmy2t
 TmwdVhEupR13gn8HU26CDu9GikHMG5Cg4Y+X2yNXPZNWACR0MbA/ut4hKVyanJCOGgEAyKq
 Ycn+yqK+8McJiY262kdmzwnkph4L6rvF7A5ZFq5r1GhFwCsMytX4Q7o5A+Yg==
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 0137F6026A;
        Mon,  7 Feb 2022 23:10:24 +0100 (CET)
Date:   Mon, 7 Feb 2022 23:10:23 +0100 (CET)
From:   Christian Kujau <lists@nerdbynature.de>
To:     Anthony Iliopoulos <ailiop@suse.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Jeff Layton <jlayton@kernel.org>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH RESEND] mount: warn only once about timestamp range
 expiration
In-Reply-To: <YfdPBUYno5f0bTVk@zeniv-ca.linux.org.uk>
Message-ID: <83203c86-dd51-76f4-dab8-6d3d8bd01ebe@nerdbynature.de>
References: <20220119202934.26495-1-ailiop@suse.com> <YfdPBUYno5f0bTVk@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On Wed, Jan 19, 2022 at 09:29:34PM +0100, Anthony Iliopoulos wrote:
> Commit f8b92ba67c5d ("mount: Add mount warning for impending timestamp
> expiry") introduced a mount warning regarding filesystem timestamp
> limits, that is printed upon each writable mount or remount.
> 
> This can result in a lot of unnecessary messages in the kernel log in
> setups where filesystems are being frequently remounted (or mounted
> multiple times).
> 
> Avoid this by setting a superblock flag which indicates that the warning
> has been emitted at least once for any particular mount, as suggested in

Great! I hope this lands in mainline soon. Applied this to 5.17.0-rc3 here 
and it warns on mounts, but not on remounts. Yay!

  Tested-by: Christian Kujau <lists@nerdbynature.de>

Thanks so much for not forgetting about this!
-- 
BOFH excuse #402:

Secretary sent chain letter to all 5000 employees.
