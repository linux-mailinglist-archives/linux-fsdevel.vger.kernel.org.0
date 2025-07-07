Return-Path: <linux-fsdevel+bounces-54039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BACAFA9BA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 04:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAEDD3B24AA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 02:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751761C3C04;
	Mon,  7 Jul 2025 02:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gmz+XUvP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3491311AC
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 02:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751855958; cv=none; b=mOmwidlFbnkfdvq8jFiEMIE7EKDZvmhsJpZMMPPHPNDJis3QHmOhEbSfK0aAYR19ZCTpSL/bbyEJmdEo6jxCz4nW4NsHO0kAVI+WRzfFdFLcfsKxaY+LcmIjwrib+EEhEUJ/gtlGuXEok4LR4o51fhud0v8UjZSci6u1DYBExjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751855958; c=relaxed/simple;
	bh=atyvLyGvCJNyDgAWZ4IJQR5kCqQIHDUYFs82Oe/4Rqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiKXHeoe8OBdXOSj+cn2uqs30BZpGahe8nuTMCEfDlvnaGr/g3mTu8u7jCMo+EiVQ7KSjK0NMJQ4cu63WKE5Z3u4EGn43CLJ+3RfQB6fmAeFtgh+4DD3KFnu0pjHs/tqBK/RguK3LD3n4bq7Q5qX3vaOC3Npxe2MqcgnUb/Wvis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gmz+XUvP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso2030648b3a.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 06 Jul 2025 19:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1751855957; x=1752460757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2eqbUK4FYCJiLH0zvQx8aO0ccOeXGf/PUZ4UYY45Alo=;
        b=Gmz+XUvPBvXzCFBQIPvrzi746qy0JZY9fDtFxKt4GRSnYKfbLX/+fOAy2mhmsSJj0L
         M35O0ufh9eCqPzvrkR5joOnTUFtVx0FWDs9NRnLAvVqySdB82DHBRUGoql9BKmsXEU9r
         nZLfajN/uUy3Dhqtyya1jE8TY2dQDVnNpaliY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751855957; x=1752460757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2eqbUK4FYCJiLH0zvQx8aO0ccOeXGf/PUZ4UYY45Alo=;
        b=OzrdG+HTwCB5Hi4SG/QhYT0iFREJj6YycFlNbCK9iXWuJijNz+TViFK3GIaC/UoQp5
         mbwRnaq2AjrZewOzl3Mj1LxICfRo+8TUg/A8xfVsM9FqRuDQd4gc6pKMESxi3kYdHWaT
         UCA0XG/8dOKpA7RwPG6RDZpuRf9xhqjFAUSfrSKamXTcrT+Doym4PmA+Y8cVBv/JWaQ4
         xSF1kEoEfsSwH4F5QgFpisD7A9nQLnB75hyTEuA0I/V9EhvhLnYE9pbY0PtUwwpDiLg8
         js752vfD3rNBU0xq7+NRuJ+yG8DQr2c+cPqCkZuSEJDz4N7adjf2J4OCfuOseko+X6TQ
         f7qQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGR7C3+ac7Yk9uoZ94fBTNX54lZGRDXIz4CCZ45FBHnNICkMH8Q4Ogi1APrkaVwiTTYsV3yiiHM9cJAxhV@vger.kernel.org
X-Gm-Message-State: AOJu0YxvC7HvnQJYoZVGSckSKq3wEKSMPJBT1BZOP5jEsLY/nORTs7+e
	ffA6k1dEJeebFgXHKK5hq8579kvPOuM/wrm2GeZpwmwXTnZbmFh5ss3lhfRhQZP9xg==
X-Gm-Gg: ASbGnct2N1E/pvJWgADiB7oGHihtc84fdUxnlzng6u7kXJT7LrwbagAyoDFUqGuzhQm
	rKtIT6iMnW7G3Bmy8vsEh5jeEGi2xUXf3WsPv4quGIwpEHy0x6pOOnqUn6hqhyREIAdxi6yWppc
	UFOhQkTjHPXNL93H+Vp7dWa67r82CCfHU7nW/aOBgIp9T+wvmXL2FXumo/i+1IbFVXGE87LTam1
	fvk5WXKB9b5YXXCmy6ieNg/AW/qr5xYKt1uEKd0b5z6HPRwn26oJ7HUb9fUlzkCdgud5y5Yxr/W
	3A0DZFD0Dn1CA9TRHzKKtmfzlKKPqrJq6z46Yhi+jEe+FMN1Clz+uI0nUvGPNUJvHw==
X-Google-Smtp-Source: AGHT+IEurZuttkS95VnXcSGu+b+8TgCle7ih6/mBYzXLZUJ1AXkAhgjCuqtatOUxrSPej26STHUETw==
X-Received: by 2002:a05:6a20:4328:b0:1f5:95a7:8159 with SMTP id adf61e73a8af0-226095a5143mr15866459637.10.1751855956675;
        Sun, 06 Jul 2025 19:39:16 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:5470:7382:9666:68b0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee74cf48sm7419649a12.77.2025.07.06.19.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 19:39:16 -0700 (PDT)
Date: Mon, 7 Jul 2025 11:39:04 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v2 12/29] mm/zsmalloc: stop using __ClearPageMovable()
Message-ID: <5bc5vidilgjb37qypdlinywm64j447wtkirbmqdbmba2bgr3ob@22so3brrpctt>
References: <20250704102524.326966-1-david@redhat.com>
 <20250704102524.326966-13-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704102524.326966-13-david@redhat.com>

On (25/07/04 12:25), David Hildenbrand wrote:
> Instead, let's check in the callbacks if the page was already destroyed,
> which can be checked by looking at zpdesc->zspage (see reset_zpdesc()).
> 
> If we detect that the page was destroyed:
> 
> (1) Fail isolation, just like the migration core would
> 
> (2) Fake migration success just like the migration core would
> 
> In the putback case there is nothing to do, as we don't do anything just
> like the migration core would do.
> 
> In the future, we should look into not letting these pages get destroyed
> while they are isolated -- and instead delaying that to the
> putback/migration call. Add a TODO for that.
> 
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

