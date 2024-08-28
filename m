Return-Path: <linux-fsdevel+bounces-27503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BD4961D16
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E79A1F243CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 03:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1966D13C670;
	Wed, 28 Aug 2024 03:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="W0tdZLgZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886C200CD
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 03:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724816600; cv=none; b=JPZIkPWoTsxyAMpDektW1iyZruDw6WvpgKi5MG/9fi1dI3QF0voUrf6zU+Ink+Mp502QhrwXUEw1at/D3q5VnJUQHeBntIdgf25VbI9bTVbz1lffBfA8kF+8Y4qPmsAfyQNUJe+oEiaLMkk67rPY7yXoJD+xCHrJNPd2g0jzBKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724816600; c=relaxed/simple;
	bh=oJbbjEsTWJeh83Dbun3VLdDqfv3FibOrWpkJ3MsioDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtSJyaIccH5+5AyiZU8i8eZzGbBX74ea6Po13IZkVmRfuC0kUCVxVh+NtEfeD5p/hwYgP59+ba8uDbEBCz3L7Mrn89SRjyFihLW8jUSuUTn5Oh/mNgGdoj5wa3RaPbTMHqh3F+jSNEtN5FTkyk1gWDcY6VwMzsEoYPgyWth3le4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=W0tdZLgZ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7bb75419123so3992295a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 20:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724816598; x=1725421398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3gcUZ1E5jMHxcb+3WwyGJu9jgAZgzxZf/U+LqyUjPCQ=;
        b=W0tdZLgZI2HW8oNW+qA0W0Q4981gb1aDKuEGkOuQVMpVXehPkGu8E5PMntnxj1Zf+8
         0CHsBrZgZLfArAij8xnMDXNcg4gIh1kn0AJmpu0S7wlYRAOW1UuEghzcHyBN65EowxXn
         yzDbDR9s45KS/Wv1w/0DaQhhdOBBP9xsDZAhrk+WxlOUmqIMMiEk/dnpwKxs4Wh5J37N
         w1kHEzTqLRVuABx8XoyJ7pmUyHHWc+BKjHJgajar4v6yW2m0m+tA7Y+82oDdLLXis8qh
         F4jpUs4nNh2oq6EyVrnzBbdW8nUsJBXA0F9zY3IvgfZCw2OeShJUdkO4xLLrUKsyPdcz
         0wXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724816598; x=1725421398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gcUZ1E5jMHxcb+3WwyGJu9jgAZgzxZf/U+LqyUjPCQ=;
        b=AzaKRfjuph8z2k63QTqMdLu0VU4+Dz44CfClTb59C8o+3SzJHupH3XSwZS4FjK/tO7
         jQWkMG2HCZSFsp+cth7r7RudjMToGEBCCGlkU4HnJFXB/BvqvJ4yiNVaf/ljFrVbmrH9
         MBtO+LRsqY/3vx3RVAH8rKgs9Gk8m+qYO7Oq9mmC2RRPu+bof7oPl6GYLgVEMurxSdHJ
         DqiI9o9l36+ZqGGdImAmk/Qxza1hj31KUx3G9Tp5AqgwgBv6VoTjAPfcbXpyJvwuhg0B
         qWd4+270OhlgO0TBU45aMuHA9aYFARW0gr+Js2ymHLyho6Fz99/Z/mL/Qlwb93Z+0UYd
         0Gqg==
X-Gm-Message-State: AOJu0YwXSLCEv1pH0oNKHmv0B9WgX04G+3kTJIEuSu8YVGXg6NdvRLa8
	nQVgkXn8pUW+FCaVdAUsACo1wFD2Y571mzFPHrY/JivSC5Jw5vocBHmePS56T0Q=
X-Google-Smtp-Source: AGHT+IG6kQZeI9NbtLZWTvUhFsTxQi88npVwo77efHV7cZ8AlR8vpP3boDhXVMWim2DvAlGjyUTESw==
X-Received: by 2002:a05:6a21:9614:b0:1c2:8cf4:7656 with SMTP id adf61e73a8af0-1cc8b41ff12mr15414408637.10.1724816597889;
        Tue, 27 Aug 2024 20:43:17 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445fa589sm383406a91.17.2024.08.27.20.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 20:43:17 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sj9aT-00FIY6-1J;
	Wed, 28 Aug 2024 13:43:13 +1000
Date: Wed, 28 Aug 2024 13:43:13 +1000
From: Dave Chinner <david@fromorbit.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH 10/10] fs: super_cache_to_text()
Message-ID: <Zs6c0QIObPzSiH/1@dread.disaster.area>
References: <20240824191020.3170516-1-kent.overstreet@linux.dev>
 <20240824191020.3170516-11-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824191020.3170516-11-kent.overstreet@linux.dev>

On Sat, Aug 24, 2024 at 03:10:17PM -0400, Kent Overstreet wrote:
> Implement shrinker.to_text() for the superblock shrinker: print out nr
> of dentries and inodes, total and shrinkable.
> 
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
> ---
>  fs/super.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 5b0fea6ff1cd..d3e43127e311 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -36,6 +36,7 @@
>  #include <linux/lockdep.h>
>  #include <linux/user_namespace.h>
>  #include <linux/fs_context.h>
> +#include <linux/seq_buf.h>
>  #include <uapi/linux/mount.h>
>  #include "internal.h"
>  
> @@ -270,6 +271,16 @@ static unsigned long super_cache_count(struct shrinker *shrink,
>  	return total_objects;
>  }
>  
> +static void super_cache_to_text(struct seq_buf *out, struct shrinker *shrink)
> +{
> +	struct super_block *sb = shrink->private_data;
> +
> +	seq_buf_printf(out, "inodes:   total %zu shrinkable %lu\n",
> +		       per_cpu_sum(sb->s_inodes_nr), list_lru_count(&sb->s_inode_lru));
> +	seq_buf_printf(out, "dentries: toal %zu shrinkbale %lu\n",
> +		       per_cpu_sum(sb->s_dentry_nr), list_lru_count(&sb->s_dentry_lru));

There's no superblock identification in this output - how are we
supposed to take this information and relate it to the filesystems
that are mounted on the system?

Also, list_lru_count() only counts root memcg objects, so any inodes
and dentries accounted to memcgs and are freeable will not be
included in this output. For systems with lots of memcgs, that will
result in the superblock reporting lots of inodes and dentries, but
almost nothing being freeable. hence to do this correctly, there
needs to be per-node, per-memcg list_lru_count_one() iteration here...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

