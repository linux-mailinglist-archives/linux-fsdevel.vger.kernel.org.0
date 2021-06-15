Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AF43A77E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 09:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhFOHZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 03:25:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55986 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhFOHZI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:25:08 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6E7E91FD55;
        Tue, 15 Jun 2021 07:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623741783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6eZ7sv20J/zTxJdQY8icfVWcp/rud6ByVlT9QMUOW/w=;
        b=Uu3bfIP7k0OW9SGXhPFpq21jUvL2cfk9c1itX9kPNlqt/X1WdyfMOZVgMSz5BeZ9UjTH4l
        MOd1nZQ1gn1SMs4Z0mpkKb9uGgYbuQV//NDKuTaHaW+uV329c3T7a7lBNvHSuCQDvur/wp
        kft3JM+lqCpoKy4shjIsyZlpZQCprlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623741783;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6eZ7sv20J/zTxJdQY8icfVWcp/rud6ByVlT9QMUOW/w=;
        b=7Kj4/DP0kr/zzyqV5MDFgdZ7MzsGo7MjKrI2CnTi30vgpGSbZ/Jqkv4hv1Ku3GTSMctBPv
        EpS7zV4CNvf+lKCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id EBD3C118DD;
        Tue, 15 Jun 2021 07:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623741783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6eZ7sv20J/zTxJdQY8icfVWcp/rud6ByVlT9QMUOW/w=;
        b=Uu3bfIP7k0OW9SGXhPFpq21jUvL2cfk9c1itX9kPNlqt/X1WdyfMOZVgMSz5BeZ9UjTH4l
        MOd1nZQ1gn1SMs4Z0mpkKb9uGgYbuQV//NDKuTaHaW+uV329c3T7a7lBNvHSuCQDvur/wp
        kft3JM+lqCpoKy4shjIsyZlpZQCprlw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623741783;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6eZ7sv20J/zTxJdQY8icfVWcp/rud6ByVlT9QMUOW/w=;
        b=7Kj4/DP0kr/zzyqV5MDFgdZ7MzsGo7MjKrI2CnTi30vgpGSbZ/Jqkv4hv1Ku3GTSMctBPv
        EpS7zV4CNvf+lKCA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id MvBaJ1VVyGDtMQAALh3uQQ
        (envelope-from <wqu@suse.de>); Tue, 15 Jun 2021 07:23:01 +0000
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
From:   Qu Wenruo <wqu@suse.de>
Subject: About `bio->bi_iter.bi_size` at write endio time
Message-ID: <18cbcd0b-8c49-00b8-558b-5d74b3664b85@suse.de>
Date:   Tue, 15 Jun 2021 15:22:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Recently I got a strange case where for write bio, at its endio time, I 
got bio->bi_iter.bi_size == 0, but bio_for_each_segment_all() reports we 
still have some bv_len.

And obviously, when the bio get submitted, its bi_size is not 0.

This is especially common for REQ_OP_ZONE_APPEND bio, but I also get 
rare bi_size == 0 at endio time, for REQ_OP_WRITE too.

So I guess bi_size at endio time is no longer reliable due to bio 
merging/splitting?

Thus the only correct way to get how large a bio really is, is through 
bio_for_each_segment_all()?

Thanks,
Qu
