Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD0B2A487A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 15:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgKCOnT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 09:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgKCOmB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:42:01 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10DCC0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Nov 2020 06:42:01 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id g13so7825030qvu.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Nov 2020 06:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iw4PSo7AbJZH5Dd+dUsD+f1FdX1ZNJUdygGHBZctEH0=;
        b=ajtD7I0CSQG+fFaVKrwgJl5sCnuaND/65TxwQgJ+eZVnib8iEy5bmqtsQmYYVNuoc5
         dsIy3ID3xKu/bgZ9oIMnuWVxiCiHcvIYalK+rmV+m+CMsnPGfTD14ZURPmdgO170Ruoc
         OwWU5q8kZW0GNOO2eUiKjvt3v41hl/QcRA5VUVBID2tOxRlNwB/zln+YmGxupnA8QCc8
         X1Jc9cWnLdf2dRARg0nDj6zWCiFLIMn+JdGzaUY2zxRNMKCDxZbWUm+PWTmlJfHs36Tt
         5Fdwunj5+Ug/7wQl1Z/IHvcqTumJ7Q41lTRpGkqbLnRfQ+dSFK1PSiktHba+PEOGGsqb
         raVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iw4PSo7AbJZH5Dd+dUsD+f1FdX1ZNJUdygGHBZctEH0=;
        b=Xff+tZwhBGlKXPEl3pKj4Z3gH5Yo6bc0DznyXrVF6XEo1uXEYjrFSXq448HITUINRq
         Qk92viI3Er8nPwi1c68+BjKV7juY4BPeBph4o7sxV36Js3Ffb/G9tqyG7oRGNntS8rl7
         BpL1ZTjlBIvDAZ/gpbGGavC3WfFAgG3i56AIv7/pZ7pvq3xiOydRGv7E/z3qV0RARBWT
         AyqFZwM4R9kbUTVPlEENwj8V42eezhnwrefnH9PFVMlOxXWsaoaqMTtyXEj8+/o/Sd5L
         dQuWwc0IwtfdjFJTvDwp3rry6KYTFUriL6AGNMiHaefyyVs/VUc/E9/DaN3VJ9b8ao1O
         AD3w==
X-Gm-Message-State: AOAM531NtpYcJjnE8qekKG6Q1Sfk36VRWWMqCKjDJfsjgWf7JL7IPlxt
        RcvQgBUJUEGIJR9oOH26F8ylIe4T+t23Enz/
X-Google-Smtp-Source: ABdhPJwhXD47vW/PdHAY7sSF3lCRK7hn3i/iGCJSbHFEoam4F3veIq2E2HM6xtBBf4RUuC8TPtBqfg==
X-Received: by 2002:ad4:456c:: with SMTP id o12mr27917737qvu.48.1604414520590;
        Tue, 03 Nov 2020 06:42:00 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q1sm5368193qti.95.2020.11.03.06.41.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 06:41:59 -0800 (PST)
Subject: Re: [PATCH v9 19/41] btrfs: redirty released extent buffers in ZONED
 mode
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <b2c1ee9a3c4067b9f8823604e4c4c5c96d3abc61.1604065695.git.naohiro.aota@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <6d61ed1d-1801-5710-beac-03d363871ec8@toxicpanda.com>
Date:   Tue, 3 Nov 2020 09:41:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <b2c1ee9a3c4067b9f8823604e4c4c5c96d3abc61.1604065695.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/30/20 9:51 AM, Naohiro Aota wrote:
> Tree manipulating operations like merging nodes often release
> once-allocated tree nodes. Btrfs cleans such nodes so that pages in the
> node are not uselessly written out. On ZONED volumes, however, such
> optimization blocks the following IOs as the cancellation of the write out
> of the freed blocks breaks the sequential write sequence expected by the
> device.
> 
> This patch introduces a list of clean and unwritten extent buffers that
> have been released in a transaction. Btrfs redirty the buffer so that
> btree_write_cache_pages() can send proper bios to the devices.
> 
> Besides it clears the entire content of the extent buffer not to confuse
> raw block scanners e.g. btrfsck. By clearing the content,
> csum_dirty_buffer() complains about bytenr mismatch, so avoid the checking
> and checksum using newly introduced buffer flag EXTENT_BUFFER_NO_CHECK.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

This is a lot of work when you could just add

if (btrfs_is_zoned(fs_info))
	return;

to btrfs_clean_tree_block().  The dirty secret is we don't actually unset the 
bits in the transaction io tree because it would require memory allocation 
sometimes, so you don't even need to mess with ->dirty_pages in the first place. 
  The only thing you need is to keep from clearing the EB dirty.  In fact you 
could just do

if (btrfs_is_zoned(fs_info)) {
	memzero_extent_buffer(eb, 0, eb->len);
	set_bit(EXTENT_BUFFER_NO_CHECK, &eb->bflags);
}

to btrfs_clean_tree_block() and then in btrfs_free_tree_block() make sure we 
always pin the extent if we're zoned.  Thanks,

Josef
