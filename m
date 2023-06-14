Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB5D72FFCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jun 2023 15:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244798AbjFNNRa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 09:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjFNNR3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:17:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A0F191;
        Wed, 14 Jun 2023 06:17:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 651782253C;
        Wed, 14 Jun 2023 13:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686748645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TF9KeihZRpsRH7T+tME1HMriDiLYlq5Qpm9I9dncI04=;
        b=x6D7/vDI4fB3czijhPkylAjL59vWALMoOVZ2+0BgXEWptq2qjL56Qnjc5ytTDPRhW81JVp
        Zu3XHrUml5Gm+M3iYMSFmN5cDzGA6ZvpmJaDVwokxpzkotS+qbXuHzbNtdlrUfPHF9ubRh
        7gnvBOTk1EaWlq6FqCDQCHrUO0zq4dQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686748645;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TF9KeihZRpsRH7T+tME1HMriDiLYlq5Qpm9I9dncI04=;
        b=yJA1cNdW0aOM6hkHkZafKTzX2u7vwQbYBNCG5FN7DbGBmZG1djKyXVCh/sFWp7UtZX3e9X
        s5P5SHQv+Jl0zCBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50DCB1357F;
        Wed, 14 Jun 2023 13:17:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Vms7E+W9iWT7VgAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 14 Jun 2023 13:17:25 +0000
Message-ID: <cd816905-0e3e-6397-1a6f-fd4d29dfc739@suse.de>
Date:   Wed, 14 Jun 2023 15:17:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/7] RFC: high-order folio support for I/O
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20230614114637.89759-1-hare@suse.de>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230614114637.89759-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/14/23 13:46, Hannes Reinecke wrote:
> Hi all,
> 
> now, that was easy.
> Thanks to willy and his recent patchset to support large folios in
> gfs2 turns out that most of the work to support high-order folios
> for I/O is actually done.
> It only need twe rather obvious patches to allocate folios with
> the order derived from the mapping blocksize, and to adjust readahead
> to avoid reading off the end of the device.
> But with these two patches (and the patchset from hch to switch
> the block device over to iomap) (and the patchset from ritesh to
> support sub-blocksize iomap buffers) I can now do:
> 
> # modprobe brd rd_size=524288 rd_blksize=16384
> # mkfs.xfs -b size=16384 /dev/ram0
> 
> it still fails when trying to mount the device:
> 
> XFS (ram0): Cannot set_blocksize to 16384 on device ram0
> 
> but to my understanding this is being worked on.
> 
Turns out that was quite easy to fix (just remove the check in 
set_blocksize()), but now I get this:

SGI XFS with ACLs, security attributes, quota, no debug enabled
XFS (ram0): File system with blocksize 16384 bytes. Only pagesize (4096) 
or less will currently work.

Hmm. And btrfs doesn't fare better here:

BTRFS info (device ram0): using crc32c (crc32c-intel) checksum algorithm
BTRFS error (device ram0): sectorsize 16384 not yet supported for page 
size 4096
BTRFS error (device ram0): superblock contains fatal errors
BTRFS error (device ram0): open_ctree failed

But at least we _can_ test these filesystems now :-)

Cheers,

Hannes

