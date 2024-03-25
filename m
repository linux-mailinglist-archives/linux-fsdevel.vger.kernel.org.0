Return-Path: <linux-fsdevel+bounces-15253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF3B88B14D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 21:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46CC21F66A34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 20:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC294AECB;
	Mon, 25 Mar 2024 20:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niXDmykL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FDE433CA;
	Mon, 25 Mar 2024 20:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398384; cv=none; b=dGisJD8panRHS3ot5ZUitGoKkTnXhQdBokhbJu1r9TwvclY4/zmh9S7ccNIROjDq7R8xQBqVOfWvgdJ1MovBX8kXZCaFOZ/u34o75qD0weB1wWyXv6MNwvHE+dtCyC1VSgAAt4R71z3T3WzFwjx7bj4i86ycx0VgS+6qjohbWX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398384; c=relaxed/simple;
	bh=jmKUHFci2vuF+OaEjW1pVKxjDkIWXtyKZpuW9N4y/Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcIe0G3mBJkOwk5UaFgSzuwVnIlkGvziJXtjGJTKwAUXrt8qROVSvvwY7hQZ56tpKVy/4DMBDf94GOQ53mc3XOpAy6ds3AK5Hlg+bA5Uz0Y3KaRoyqST8dVwlf04HUOG7ROMfR+8BraHi5unBT/lf/YAxSVyZyBguNZmY3ndjUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niXDmykL; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so3112873a12.1;
        Mon, 25 Mar 2024 13:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711398382; x=1712003182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zM//w0ZQA39ATnyT3zYBHv3F+CzIiqRVQ67zJHzHQSE=;
        b=niXDmykLrkOSN6dR4oKX4A7k175YIUV33NwdBbfuYyprhy8E5lujRFsbXPOQ5zvQ59
         ca7zeVw05x9cNNIwPh2iBMCUPbpPW4ru9UNIVUqtciuJbRUyjj/F58/Xn8HXFFnvggDp
         MG2kgOm0EJkne3/a5lnOU18gmtwPeWP2XmJiMwoH6UA5meyqN0Ne7aCqe3tfR7GnSvm6
         GrLfi1ZhzG3guELIvA9EGxo7schQj32/nW1E8MHbiGbFjpcbM5mo33cHtLif5Hv06Efn
         ge283dHccC0iCUKE8+GI3oR7utO/FXxpHyVKAeNSWppZNUJE/H8EqoAjYU2MH50YZwS/
         QOTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711398382; x=1712003182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zM//w0ZQA39ATnyT3zYBHv3F+CzIiqRVQ67zJHzHQSE=;
        b=LC7McZdFbzAOF5/t5nERNLNDEEOVWLt7CeeMtPeLBFSi+ledxgH9+78F3hbJtxzcoe
         /Zs1L8O/Xr9AjNkQHYxSb6a7pPD16EK5VP4ipHtQlJF3VCqt/pm4u4hphuWDvEs1jERq
         ZfPAJXyJ39kiUfs1mT9AqgGqEFfhznQp2HSovGkXrsShZIhq+W8GqS8N1Wh1ct6w/HtT
         DoGBPkhHWXYvaafPCK2CKBuxPOssdiI+ZaKaWZkHheqvZtWsYd6KIuxjM0z4m9Hmu3Rm
         oxzweFIO/nwsKjQ5LxLdyZJQrvsAB/8ykSKsdQIrcIjV0mZZZ/+AcaPQC8EQlqu1VVxM
         7D1g==
X-Forwarded-Encrypted: i=1; AJvYcCW5IEHYj9q+4/ynquSLVEL7MhlqbKNCW4dq9rDGobBM1XCd2qpmvPgldi8lK6NZ02nas6/uNJ0qV6IgJjxKveBpYtr/9tjxoX4i7eApGzVNT7DO9rF8RITMGlNAOQ4Ktmx7KUbOqgQWWVJBpA==
X-Gm-Message-State: AOJu0Yy0fAFxkgttClcC3et8JPqjuoQ0mXDbbJHFWVhTgqqzBSmsijNJ
	mWJ3oLQ8a4/Zk5Dt2zWlFpzHfc1jAtDy09+TObYriwJPj4T+l3F3
X-Google-Smtp-Source: AGHT+IHqnA5sag8cpZvLjrUVzMX6qB8fx+bXfLavgzLRsx+qy3P2PK8yQ/Q7PtCapn370eT44Sj9PQ==
X-Received: by 2002:a17:90a:e392:b0:29d:fe34:fa16 with SMTP id b18-20020a17090ae39200b0029dfe34fa16mr6081228pjz.21.1711398381870;
        Mon, 25 Mar 2024 13:26:21 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id ns21-20020a17090b251500b002a068485de6sm2704002pjb.3.2024.03.25.13.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 13:26:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 25 Mar 2024 10:26:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org, bfoster@redhat.com, jack@suse.cz,
	dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH 6/6] writeback: remove unneeded GDTC_INIT_NO_WB
Message-ID: <ZgHd7GcUslrBEeoi@slm.duckdns.org>
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
 <20240320110222.6564-7-shikemeng@huaweicloud.com>
 <Zfr9my_tfxO-N6HS@mtj.duckdns.org>
 <becdb16b-a318-ec05-61d2-d190541ae997@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <becdb16b-a318-ec05-61d2-d190541ae997@huaweicloud.com>

On Thu, Mar 21, 2024 at 03:12:21PM +0800, Kemeng Shi wrote:
> 
> 
> on 3/20/2024 11:15 PM, Tejun Heo wrote:
> > Hello,
> > 
> > On Wed, Mar 20, 2024 at 07:02:22PM +0800, Kemeng Shi wrote:
> >> We never use gdtc->dom set with GDTC_INIT_NO_WB, just remove unneeded
> >> GDTC_INIT_NO_WB
> >>
> >> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> > ...
> >>  void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty)
> >>  {
> >> -	struct dirty_throttle_control gdtc = { GDTC_INIT_NO_WB };
> >> +	struct dirty_throttle_control gdtc = { };
> > 
> > Even if it's currently not referenced, wouldn't it still be better to always
> > guarantee that a dtc's dom is always initialized? I'm not sure what we get
> > by removing this.
> As we explicitly use GDTC_INIT_NO_WB to set global_wb_domain before
> calculating dirty limit with domain_dirty_limits, I intuitively think the dirty
> limit calculation in domain_dirty_limits is related to global_wb_domain when
> CONFIG_WRITEBACK_CGROUP is enabled while the truth is not. So this is a little
> confusing to me.
> Would it be acceptable to you that we keep useing GDTC_INIT_NO_WB but
> define GDTC_INIT_NO_WB to null fow now and redefine GDTC_INIT_NO_WB when some
> member of gdtc is really needed.
> Of couse I'm not insistent on this. Would like to hear you suggestion. Thanks!

Ah, I see. In that case, the proposed change of removing GDTC_INIT_NO_WB
looks good to me.

Thanks.

-- 
tejun

