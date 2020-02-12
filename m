Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1A0F15B02C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 19:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgBLSwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 13:52:13 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44137 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgBLSwN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:52:13 -0500
Received: by mail-qt1-f195.google.com with SMTP id k7so2379958qth.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Feb 2020 10:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ATjtj9uhoqbutpORm3twmVpl6WMWrzgSu/Pef3LSt8M=;
        b=CeOgukl06W8Hf4S1CRY2NUWa4z3u+gGuwykBw8jvgPAOCOEqPHzjcGo8O/kZffzk05
         v6pDOrnWKwO2Uc0Pv9YX1Gf3iRrqs1SZe9rz76aKfncwXlCGXaX4/VL3H8LkvrFOhDl6
         Q/W3RYEYvohBIFAMpqLUXnH67k2XGZf76gyo0SvoWnVwRbyTqyYt37GB5wSC2VoiiPF/
         +vb+eYKGZOVcrxuDvI2ZJ5+appiYzcQnj8hBF1TDF+Bef5PGXixPhNinsokmZ0m4fFXU
         tK8oQWE7EEyOZ+8guuS0/DagdIi9RENopyLQ8RF+FKBFkgaLAf+f6D+ZfNhPgp1YAEdo
         Xkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ATjtj9uhoqbutpORm3twmVpl6WMWrzgSu/Pef3LSt8M=;
        b=D0IzICDn+x9PGlEIwcRXRYWDVeDEj2y/24hdIWzItWGoxBwBTezKInxl4GHppnpWs1
         S1nZPloGzzN1ZZCxICZyCINzV/RdrGait1rGxexzsIOsIvW76yy3HnioHpY7H+YzaUTh
         wqSgVGqrPbnu+3ECx4TXiP5yt9se1twgBqV/0nTO/ljwJUovTFw98Su7LL7o5SMnF76i
         lZjyNRkQoCgJfY/dC9UKTVg4kQorw3h7PagznMHxkJXkCHYQ1+P2rD/VlCsnoLrUztyK
         inSV13W19FNiXPfbW6uq/VibW0L9cnrtQUiOrpnuR1zf4Dqo5P93Xai163MlrLVWEhFp
         HnfQ==
X-Gm-Message-State: APjAAAXRko2qCtBMSmnWmVyHxiU86ZD1SRzSQcOyJIVrDOv/W9VnH5eS
        AlVVMFJsarbSsZqRBvQaObKpzA==
X-Google-Smtp-Source: APXvYqx5Ca61AWNH6d2djo58vJ8Cb09R7uCxhUTN2gPc4ax8cB+65DSTSeMcWR0luIlwyTq0lYXeaw==
X-Received: by 2002:ac8:365c:: with SMTP id n28mr8285715qtb.260.1581533530780;
        Wed, 12 Feb 2020 10:52:10 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::5a94])
        by smtp.gmail.com with ESMTPSA id g53sm682746qtk.76.2020.02.12.10.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 10:52:09 -0800 (PST)
Date:   Wed, 12 Feb 2020 13:52:09 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@surriel.com>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker
 LRU
Message-ID: <20200212185209.GA206066@cmpxchg.org>
References: <20200211175507.178100-1-hannes@cmpxchg.org>
 <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org>
 <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <20200212163540.GA180867@cmpxchg.org>
 <20200212102645.7b2e5b228048b6d22331e47d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212102645.7b2e5b228048b6d22331e47d@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 12, 2020 at 10:26:45AM -0800, Andrew Morton wrote:
> On Wed, 12 Feb 2020 11:35:40 -0500 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > Since the cache purging code was written for highmem scenarios, how
> > about making it specific to CONFIG_HIGHMEM at least?
> 
> Why do I have memories of suggesting this a couple of weeks ago ;)

Sorry, you did. I went back and found your email now. It completely
slipped my mind after that thread went off into another direction.

> > That way we improve the situation for the more common setups, without
> > regressing highmem configurations. And if somebody wanted to improve
> > the CONFIG_HIGHMEM behavior as well, they could still do so.
> > 
> > Somethig like the below delta on top of my patch?
> 
> Does it need to be that complicated?  What's wrong with
> 
> --- a/fs/inode.c~a
> +++ a/fs/inode.c
> @@ -761,6 +761,10 @@ static enum lru_status inode_lru_isolate
>  		return LRU_ROTATE;
>  	}
>  
> +#ifdef CONFIG_HIGHMEM
> +	/*
> +	 * lengthy blah
> +	 */
>  	if (inode_has_buffers(inode) || inode->i_data.nrpages) {
>  		__iget(inode);
>  		spin_unlock(&inode->i_lock);
> @@ -779,6 +783,7 @@ static enum lru_status inode_lru_isolate
>  		spin_lock(lru_lock);
>  		return LRU_RETRY;
>  	}
> +#endif

Pages can show up here even under !CONFIG_HIGHMEM. Because of the lock
order to maintain LRU state (i_lock -> xa_lock), when the page cache
inserts new pages it doesn't unlink the inode from the LRU atomically,
and the shrinker might get here before inode_pages_set(). In that case
we need the shrinker to punt the inode off the LRU (the #else branch).

>  	WARN_ON(inode->i_state & I_NEW);
>  	inode->i_state |= I_FREEING;
> _
> 
> Whatever we do will need plenty of testing.  It wouldn't surprise me
> if there are people who unknowingly benefit from this code on
> 64-bit machines.

If we agree this is the way to go, I can put the patch into our tree
and gather data from the Facebook fleet before we merge it.
