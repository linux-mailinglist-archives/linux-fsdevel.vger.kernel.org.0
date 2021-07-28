Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B333D9789
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 23:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhG1VaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 17:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhG1VaJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 17:30:09 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E35C061765
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jul 2021 14:30:07 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 184so3773820qkh.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jul 2021 14:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uVT1uFTAOGfK1fP5fzGaiByMshUd21P5nAY5t0mAWDw=;
        b=o4pY+ugBDJRzrhgcaJYE3XIJZ/sZ/DL9/abDHd9cjt+SdfzNT7ZItYIrHzt1ZzUKGW
         jPk87LcV9EbN29AUKteWvNlZ5PAZnZtNQCelTIIKjrsxHVgc61EI9m8JqbsFMDhVJ9Wt
         Ljo/lFqcApepJWx9bGlw2a4ErY9seplPEw2vq3gG87Yy42jzl4bXSKyN+zBirqcZucui
         qtc1pEWIC9s5EgdRSq9Lytn56zd+OUiePpmSYmCg5RD8LPI1zLZ8Cr4FMrZUNlxvAWyF
         LqFeon22h5DzRAxin62tbC7hDBDDN7TLbSEejSqSYxapDjDv+uvHv9J+cI5SiHaF7UGS
         VTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uVT1uFTAOGfK1fP5fzGaiByMshUd21P5nAY5t0mAWDw=;
        b=hpHI9g9I7TNohjt8TUF5rY4l3J5RqCaENPDmfSkdAVLCV9jejPSV1oggEmNU7fw7vB
         XNmk09LtkXsRAi2GCjA8fcv+QjHXv/1Ab+SKZZkTpMuhVLyjZPsQ6Nv8wkE9ZqKapWPI
         oand9SJjriFt8V1JFYNZVkzX1GlNWwLOfvu3HgNvR/m2l8khwi0Gz47re9515xu2q+7s
         WgKf4c9UG0mdUuqdmXEFCFFYEK14i4SlF5Ta+zuoOM9nwNR8aUEwTFWq36JBQxez3ps5
         rVM7XwS4rSNf3TPpnwP80A7Vi3Laklfdojf9mKP9jNjSkydJSoALua7EpacpLd+mLe/M
         fgOQ==
X-Gm-Message-State: AOAM533Tig1M969KABdmHsBeK+UL2PUQATzLi9jgfNCG+Ay7NRmk/Opv
        PMifsqlWDXT4sI2wW7Pc3jbW7w==
X-Google-Smtp-Source: ABdhPJy46q0J2ekkhkPZzNGpN9S/kQjLTruBQy5vunkhOpVUkV4xSJpf0x4MXXNiyBhVYP01cf58dw==
X-Received: by 2002:a37:9b44:: with SMTP id d65mr1729724qke.71.1627507806155;
        Wed, 28 Jul 2021 14:30:06 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u36sm455507qtc.71.2021.07.28.14.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 14:30:05 -0700 (PDT)
Subject: Re: [PATCH/RFC 00/11] expose btrfs subvols in mount table correctly
To:     "J. Bruce Fields" <bfields@fieldses.org>, NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <162742539595.32498.13687924366155737575.stgit@noble.brown>
 <20210728193536.GD3152@fieldses.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e75ccfd2-e09f-99b3-b132-3bd69f3c734c@toxicpanda.com>
Date:   Wed, 28 Jul 2021 17:30:04 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728193536.GD3152@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/28/21 3:35 PM, J. Bruce Fields wrote:
> I'm still stuck trying to understand why subvolumes can't get their own
> superblocks:
> 
> 	- Why are the performance issues Josef raises unsurmountable?
> 	  And why are they unique to btrfs?  (Surely there other cases
> 	  where people need hundreds or thousands of superblocks?)
> 

I don't think anybody has that many file systems.  For btrfs it's a single file 
system.  Think of syncfs, it's going to walk through all of the super blocks on 
the system calling ->sync_fs on each subvol superblock.  Now this isn't a huge 
deal, we could just have some flag that says "I'm not real" or even just have 
anonymous superblocks that don't get added to the global super_blocks list, and 
that would address my main pain points.

The second part is inode reclaim.  Again this particular problem could be 
avoided if we had an anonymous superblock that wasn't actually used, but the 
inode lru is per superblock.  Now with reclaim instead of walking all the 
inodes, you're walking a bunch of super blocks and then walking the list of 
inodes within those super blocks.  You're burning CPU cycles because now instead 
of getting big chunks of inodes to dispose, it's spread out across many super 
blocks.

The other weird thing is the way we apply pressure to shrinker systems.  We 
essentially say "try to evict X objects from your list", which means in this 
case with lots of subvolumes we'd be evicting waaaaay more inodes than you were 
before, likely impacting performance where you have workloads that have lots of 
files open across many subvolumes (which is what FB does with it's containers).

If we want a anonymous superblock per subvolume then the only way it'll work is 
if it's not actually tied into anything, and we still use the primary super 
block for the whole file system.  And if that's what we're going to do what's 
the point of the super block exactly?  This approach that Neil's come up with 
seems like a reasonable solution to me.  Christoph gets his separation and 
/proc/self/mountinfo, and we avoid the scalability headache of a billion super 
blocks.  Thanks,

Josef
