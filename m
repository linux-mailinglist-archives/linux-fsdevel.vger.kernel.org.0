Return-Path: <linux-fsdevel+bounces-23898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6F39348BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 09:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 938A9B216E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 07:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1656F7710F;
	Thu, 18 Jul 2024 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="R+D+F+Pd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B00487A5
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721287550; cv=none; b=X7VrWMEu+s1V5jI2KmvMJcuyPe/mtGSOpJkIk5wQ8lA8BMjeWQ06lihZTG/Li68lXvfX3lA5bdLQNRBLVJ52OCtJYOMyCz7RTC/FXdB+F3shVE4r5n8r5S8Ep4VjuCRl3CypqhcDD3FCpaVqZlgz+bZxSORCjV5y6YFh3JhLbcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721287550; c=relaxed/simple;
	bh=jOELyCaGkaykG65k6MmracYS/rExwA+PASAjNC9tR1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKVTyR4rYfbu/vyTRIbTYAEaxbQoKH567a5E0H4U9Gt3sVx041NUUeeFKGCx7Sm0QKLFyZZTr1VvEBFiskmUhENuYbybmQsjPxDCAY9yh2K6P3slLgwVoMkIQpezrKKtg5RXwBX8OplINLP2IlpKyhqkqB98uCedmXQJKi8bKY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=R+D+F+Pd; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a09634354eso465627a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 00:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721287547; x=1721892347; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vcwItFS0olVkauOdW6Vv7zuIp6VerMiLVs+nxpD7snM=;
        b=R+D+F+Pd7eEov5CEC3E6Jahz6RRxYkraAcLn11NmjqCAxPmrNjPkeBSit8FU4TeVKJ
         iEVYz5eWnirxY2TUGaY8GMpfFwJtvhd5X9WzUabUYMOyIe6sb/P6bN3x3yVeBk+bF7Cr
         Xw2kZ/tbR6mZj8s21DAzyZyVZkTAqdyCB9WIVgIwnBgsXxvzc+NKr9Q8b3xGBUEIkNyq
         k7JYUVBoSgS5XTXgXp2toLmua12gBkdaXBHgmnL3ID7jJe9KuOejemLt9VO05G//Qq1H
         thS5fDAmeQdT2YScbNfW0492k+f+68DL67SLFjt2vrW2f1jwjzVHRmAqhIXWjDBPee6I
         MOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721287547; x=1721892347;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcwItFS0olVkauOdW6Vv7zuIp6VerMiLVs+nxpD7snM=;
        b=FbG3DtLAWmoEOUSb5hY8JDOvy4Td0LH7fc922B2NmAQqjyKkI4IGkLJ0N/ZqqpFU56
         g9Jp5JESrdHd/2WaYvGRkguUD9znG06zGuz3LUNA4xYrwzx8HzM9BUYNi7Iz3vvfRbcH
         jOEC7KNP6q0oZ5d6mrd1purHj6DrisntiWLMpeUoczhQTEewt7p9qKSv78ojZHloKk3v
         gpD4Fp2bwAWZ1Vtl3pDW7qlMRM895H3FHJkMwfZIIWGOu5dxhIT1GLDgTnkd08ZdZOaL
         MesISRJYg4YRWcsqAvzwXCSRREzPJO8fgQ3WhxxDRBPC/7FQuL3ZD5vICb8BCEY4mnRy
         j4RQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqyPy9o0Mztmi4u5EGxPwcMsDNTzjeRLx0khzU6Cd0tr3rVD8EczP+bDfYoYSbWFTJ4r4P/VmRnmvy9FxVbZsNBuyWNg+U3fAV84JJcg==
X-Gm-Message-State: AOJu0Yyo74prpSO1qRYfklYq0Uysk9vHkpnn0swoZct+OVwmWOklMYLB
	67RiaMdJijgXxIbqS9Cxqoi0/nrJxo/2/64Oh2Ypbfm3XK4m2uz/FsEUw9yTZig=
X-Google-Smtp-Source: AGHT+IGaCt90Cox8GLORF2aRGCefxdPNLoxyupkBnqx9dhi7qboXugiP0cfGKgo+Px64AVA42Y6xeg==
X-Received: by 2002:a17:906:fb86:b0:a77:e1fb:7df0 with SMTP id a640c23a62f3a-a7a01138eb1mr265615566b.2.1721287546791;
        Thu, 18 Jul 2024 00:25:46 -0700 (PDT)
Received: from localhost (109-81-94-157.rct.o2.cz. [109.81.94.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff7a7sm522358266b.155.2024.07.18.00.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 00:25:46 -0700 (PDT)
Date: Thu, 18 Jul 2024 09:25:45 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Cgroups <cgroups@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 0/2] mm: skip memcg for certain address space
Message-ID: <ZpjDeSrZ40El5ALW@tiehlicka>
References: <cover.1720572937.git.wqu@suse.com>
 <8faa191c-a216-4da0-a92c-2456521dcf08@kernel.org>
 <Zpft2A_gzfAYBFfZ@tiehlicka>
 <9c0d7ce7-b17d-4d41-b98a-c50fd0c2c562@gmx.com>
 <9572fc2b-12b0-41a3-82dc-bb273bfdd51d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9572fc2b-12b0-41a3-82dc-bb273bfdd51d@kernel.org>

On Thu 18-07-24 09:17:42, Vlastimil Babka (SUSE) wrote:
> On 7/18/24 12:38 AM, Qu Wenruo wrote:
[...]
> > Does the folio order has anything related to the problem or just a
> > higher order makes it more possible?
> 
> I didn't spot anything in the memcg charge path that would depend on the
> order directly, hm. Also what kernel version was showing these soft lockups?

Correct. Order just defines the number of charges to be reclaimed.
Unlike the page allocator path we do not have any specific requirements
on the memory to be released. 

> > And finally, even without the hang problem, does it make any sense to
> > skip all the possible memcg charge completely, either to reduce latency
> > or just to reduce GFP_NOFAIL usage, for those user inaccessible inodes?

Let me just add to the pile of questions. Who does own this memory?

-- 
Michal Hocko
SUSE Labs

