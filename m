Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907876DF1CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 12:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjDLKSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 06:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDLKSb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:18:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C4E30FF;
        Wed, 12 Apr 2023 03:18:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5E3541F6E6;
        Wed, 12 Apr 2023 10:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681294709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1jO49i5gScCoN4EohEbYxBmHDQejCs3zeE3mWhaPo2E=;
        b=JwdCwmezTFhgu3Nqrw3CuY7MyRRtLJom+0BAtAr9yKwHmtpii+93jpQgcZcGV0aqM/aMgP
        iJXt3STNEfz9Edbn8Ursi9Zd42xpuziVsjGsuxrwuvbGOyKKybk1gMM4THXER+wXnrkrw+
        e0NfNGGMpvRpM5E6PKGGzch776QFTBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681294709;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1jO49i5gScCoN4EohEbYxBmHDQejCs3zeE3mWhaPo2E=;
        b=4gWzLfQxiYYx/4k40P81GmshV1aP9VQvMLGhFTitbwirp7RoA9OLqZeEKlgE+w+rPiL+c6
        oxa6BU1MCV0bvACg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51386132C7;
        Wed, 12 Apr 2023 10:18:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MyJpE3WFNmRPFQAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 12 Apr 2023 10:18:29 +0000
Message-ID: <6ca617db-5370-7f06-8b4e-c9e10f2fa567@suse.de>
Date:   Wed, 12 Apr 2023 12:18:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM/BPF TOPIC] Sunsetting buffer_heads
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ceterum censeo ...

Having looked at implementing large blocksizes I constantly get bogged 
down by buffer_heads and being as they are intricately linked into 
filesystems and mm.

And also everyone seems to have agreed to phase out buffer_heads eventually.

So maybe it's time to start discussing exactly _how_ this could be done.
And LSF/MM seems to be the idea location for it.

So far I've came across the following issues:

- reading superblocks / bread(): maybe convert to ->read_folio() ?
- bh_lru and friends (maybe pointless once bread() has been converted)
- How to handle legacy filesystems still running on buffer_heads

I'm sure this is an incomplete list, and I'm equally sure that several
people have their own ideas what should or need to be done.

So this BOF will be about collecting these ideas and coming up with a 
design how we can deprecated buffer_heads.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Frankenstr. 146, 90461 Nürnberg
Managing Directors: I. Totev, A. Myers, A. McDonald, M. B. Moerman
(HRB 36809, AG Nürnberg)
