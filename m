Return-Path: <linux-fsdevel+bounces-3902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B91D7F9A61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 07:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBEB91C2095C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Nov 2023 06:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5E8DF53;
	Mon, 27 Nov 2023 06:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBP9MEE4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F728133;
	Sun, 26 Nov 2023 22:57:28 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-58d564b98c9so991436eaf.2;
        Sun, 26 Nov 2023 22:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701068246; x=1701673046; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=74/KLKDQx7oWs6JsiZhrrTthn5ejri2WVO70RRXbHS8=;
        b=dBP9MEE4BFBaEewR1i7N9gLKoLP7ohxtbJKC3pX1r9DPVRuG/DEwA6oZtH1IcvjKZK
         HDP1x9t6wTFejo+W21SxuEXh9MYbfBkBHHmhsh8opI0qNdXUj+3vHk8NyF41mSKVVKfa
         Cc40SlW03keh0H34/zgcvy3mR4o4tjhSdC8noO4ppAhh2m55UrldPG8Wt8dSee4IhmSn
         GQFHmIg5oNgmL9nVjp8hZWqwoVTsLFGQ+36Dmsfd23pZENTKmfghH3wDfc/T265hJ/so
         5d/ep27nHuRfDwgLHOUt/qwAM/s2D6Cmbfb9hwYKkppgPHoE4k2BmUqWqAS+WU8LxtpU
         TIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701068246; x=1701673046;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=74/KLKDQx7oWs6JsiZhrrTthn5ejri2WVO70RRXbHS8=;
        b=dj4SuokoxtW9KTSWpEC8u7ngTBrMYDVWd0IPhTDO75r+mRUhwNm/YMfz9WmvJZkVQq
         PJxUgIuEzHZDsyCAjmc/19vReukqY1BGOua15pXdXs4uQ233y1L03MsmerylNVu4X4dF
         Xvx1N1NAhhk+sXfILWOfair1JfeeJ3gXVwzu2CABuZVjPsC4xXcOTJ8CrIKRYwpadt42
         oS8h1lXKKkgkXmr73vcdRoakB/rzW4Bz+L7xKDEtUB+i3eqZUAC36B+CxBi1ihG7EnXr
         VWLpFbcIyCgXlfLQWFRc9JezKSyo457bWzOSJld8efMFnc9ux5ZsLF578AlYFAddurJE
         A09w==
X-Gm-Message-State: AOJu0Yza4ryohJNk7XHn0UYQLG4zaLLtfvrGUndNj2B7uZrQcgcRiHZ9
	bufEnRDWWETWOq3f73dXdenHiNZ9RGQ=
X-Google-Smtp-Source: AGHT+IHWrgoOoBGzO4MkV9pko6R+DAJ50vuH0Sys7IrxiznYCopxvkFFCwMvZUur7FMOcpg+TUadLQ==
X-Received: by 2002:a05:6358:88e:b0:16e:1a22:a1ab with SMTP id m14-20020a056358088e00b0016e1a22a1abmr10451551rwj.26.1701068246392;
        Sun, 26 Nov 2023 22:57:26 -0800 (PST)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id 32-20020a630c60000000b005c19c586cb7sm7046325pgm.33.2023.11.26.22.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 22:57:25 -0800 (PST)
Date: Mon, 27 Nov 2023 12:27:22 +0530
Message-Id: <8734wrsmy5.fsf@doe.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Chandan Babu R <chandan.babu@oracle.com>, Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/13] iomap: factor out a iomap_writepage_handle_eof helper
In-Reply-To: <20231126124720.1249310-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> Most of iomap_do_writepage is dedidcated to handling a folio crossing or
> beyond i_size.  Split this is into a separate helper and update the
> commens to deal with folios instead of pages and make them more readable.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 128 ++++++++++++++++++++---------------------
>  1 file changed, 62 insertions(+), 66 deletions(-)

Just a small nit below.

But otherwise looks good to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 8148e4c9765dac..4a5a21809b0182 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1768,6 +1768,64 @@ iomap_add_to_ioend(struct inode *inode, loff_t pos, struct folio *folio,
>  	wbc_account_cgroup_owner(wbc, &folio->page, len);
>  }
>  
> +/*
> + * Check interaction of the folio with the file end.
> + *
> + * If the folio is entirely beyond i_size, return false.  If it straddles
> + * i_size, adjust end_pos and zero all data beyond i_size.
> + */
> +static bool iomap_writepage_handle_eof(struct folio *folio, struct inode *inode,
> +		u64 *end_pos)
> +{
> +	u64 isize = i_size_read(inode);

i_size_read(inode) returns loff_t type. Can we make end_pos also as
loff_t type. We anyway use loff_t for
folio_pos(folio) + folio_size(folio), at many places in fs/iomap. It
would be more consistent with the data type then.

Thoughts?

-ritesh


> +
> +	if (*end_pos > isize) {
> +		size_t poff = offset_in_folio(folio, isize);
> +		pgoff_t end_index = isize >> PAGE_SHIFT;
> +
> +		/*
> +		 * If the folio is entirely ouside of i_size, skip it.
> +		 *
> +		 * This can happen due to a truncate operation that is in
> +		 * progress and in that case truncate will finish it off once
> +		 * we've dropped the folio lock.
> +		 *
> +		 * Note that the pgoff_t used for end_index is an unsigned long.
> +		 * If the given offset is greater than 16TB on a 32-bit system,
> +		 * then if we checked if the folio is fully outside i_size with
> +		 * "if (folio->index >= end_index + 1)", "end_index + 1" would
> +		 * overflow and evaluate to 0.  Hence this folio would be
> +		 * redirtied and written out repeatedly, which would result in
> +		 * an infinite loop; the user program performing this operation
> +		 * would hang.  Instead, we can detect this situation by
> +		 * checking if the folio is totally beyond i_size or if its
> +		 * offset is just equal to the EOF.
> +		 */
> +		if (folio->index > end_index ||
> +		    (folio->index == end_index && poff == 0))
> +			return false;
> +
> +		/*
> +		 * The folio straddles i_size.
> +		 *
> +		 * It must be zeroed out on each and every writepage invocation
> +		 * because it may be mmapped:
> +		 *
> +		 *    A file is mapped in multiples of the page size.  For a
> +		 *    file that is not a multiple of the page size, the
> +		 *    remaining memory is zeroed when mapped, and writes to that
> +		 *    region are not written out to the file.
> +		 *
> +		 * Also adjust the writeback range to skip all blocks entirely
> +		 * beyond i_size.
> +		 */
> +		folio_zero_segment(folio, poff, folio_size(folio));
> +		*end_pos = isize;
> +	}
> +
> +	return true;
> +}
> +
>  /*
>   * We implement an immediate ioend submission policy here to avoid needing to
>   * chain multiple ioends and hence nest mempool allocations which can violate
> @@ -1906,78 +1964,16 @@ static int iomap_do_writepage(struct folio *folio,
>  {
>  	struct iomap_writepage_ctx *wpc = data;
>  	struct inode *inode = folio->mapping->host;
> -	u64 end_pos, isize;
> +	u64 end_pos = folio_pos(folio) + folio_size(folio);
>  
>  	trace_iomap_writepage(inode, folio_pos(folio), folio_size(folio));
>  
> -	/*
> -	 * Is this folio beyond the end of the file?
> -	 *
> -	 * The folio index is less than the end_index, adjust the end_pos
> -	 * to the highest offset that this folio should represent.
> -	 * -----------------------------------------------------
> -	 * |			file mapping	       | <EOF> |
> -	 * -----------------------------------------------------
> -	 * | Page ... | Page N-2 | Page N-1 |  Page N  |       |
> -	 * ^--------------------------------^----------|--------
> -	 * |     desired writeback range    |      see else    |
> -	 * ---------------------------------^------------------|
> -	 */
> -	isize = i_size_read(inode);
> -	end_pos = folio_pos(folio) + folio_size(folio);
> -	if (end_pos > isize) {
> -		/*
> -		 * Check whether the page to write out is beyond or straddles
> -		 * i_size or not.
> -		 * -------------------------------------------------------
> -		 * |		file mapping		        | <EOF>  |
> -		 * -------------------------------------------------------
> -		 * | Page ... | Page N-2 | Page N-1 |  Page N   | Beyond |
> -		 * ^--------------------------------^-----------|---------
> -		 * |				    |      Straddles     |
> -		 * ---------------------------------^-----------|--------|
> -		 */
> -		size_t poff = offset_in_folio(folio, isize);
> -		pgoff_t end_index = isize >> PAGE_SHIFT;
> -
> -		/*
> -		 * Skip the page if it's fully outside i_size, e.g.
> -		 * due to a truncate operation that's in progress.  We've
> -		 * cleaned this page and truncate will finish things off for
> -		 * us.
> -		 *
> -		 * Note that the end_index is unsigned long.  If the given
> -		 * offset is greater than 16TB on a 32-bit system then if we
> -		 * checked if the page is fully outside i_size with
> -		 * "if (page->index >= end_index + 1)", "end_index + 1" would
> -		 * overflow and evaluate to 0.  Hence this page would be
> -		 * redirtied and written out repeatedly, which would result in
> -		 * an infinite loop; the user program performing this operation
> -		 * would hang.  Instead, we can detect this situation by
> -		 * checking if the page is totally beyond i_size or if its
> -		 * offset is just equal to the EOF.
> -		 */
> -		if (folio->index > end_index ||
> -		    (folio->index == end_index && poff == 0))
> -			goto unlock;
> -
> -		/*
> -		 * The page straddles i_size.  It must be zeroed out on each
> -		 * and every writepage invocation because it may be mmapped.
> -		 * "A file is mapped in multiples of the page size.  For a file
> -		 * that is not a multiple of the page size, the remaining
> -		 * memory is zeroed when mapped, and writes to that region are
> -		 * not written out to the file."
> -		 */
> -		folio_zero_segment(folio, poff, folio_size(folio));
> -		end_pos = isize;
> +	if (!iomap_writepage_handle_eof(folio, inode, &end_pos)) {
> +		folio_unlock(folio);
> +		return 0;
>  	}
>  
>  	return iomap_writepage_map(wpc, wbc, inode, folio, end_pos);
> -
> -unlock:
> -	folio_unlock(folio);
> -	return 0;
>  }
>  
>  int
> -- 
> 2.39.2

