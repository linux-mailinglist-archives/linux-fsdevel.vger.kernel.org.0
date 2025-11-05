Return-Path: <linux-fsdevel+bounces-67180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 688ECC37435
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 19:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032383B53AD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 18:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3B726F46F;
	Wed,  5 Nov 2025 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CDITUnbF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A726ED2F
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762366614; cv=none; b=d6uFLJw23FaUMKH/5WEoh1pDJLzV82GCCNtmUaGwlR0os0CbfyTlD/NtPAUxGPxs9VLBxlCG+ulFUYREYyP0AviOvqMYvMckCAe+PKRUkzGNarhjqGUU/w/IRn7zKoZLEKNOAd8HnzTeUnV5pVp6ALIAEnS90CpjtbKdQskworM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762366614; c=relaxed/simple;
	bh=CHsVV9xGLdeBVjQzQ+KO9Y00h83ZIy5yu3puOCqoV9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMNp3Ifq6oOoh+Fv4hahurDPNo5kjQLjSg44dpge9hVheSzDi9hEbacTdnowjPc8dhDLvWY3lI/J0oPm8BCDDzyJY9dN+08iI9YiB8Lehkpdt1AZ1TPoGbx0k4ZdwoRcMiCLydbfAnLylsHN6BJ9eli0a+VLhgqPsB8rmY/o8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CDITUnbF; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-85a4ceb4c3dso10835085a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 10:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762366611; x=1762971411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHsVV9xGLdeBVjQzQ+KO9Y00h83ZIy5yu3puOCqoV9g=;
        b=CDITUnbF0zeKPEDxkTffAxzBC0jmHf5Y876UCRRtQ2rLcs8qb+Z88PVwnenEzbG9aw
         TMKKMq/cUOFjI2hTB2p69LTktVVOtIqKWN9gVdyAGB0YIcRo8qLYrHgvJ/lgpNMTOqYn
         5iGkwqREVHwe96A34n/Rc0FVPbB27ODK14DCh2OFhV9uFagGPKjsP9GYkvCjfza6Dr88
         6GMOm+6souMEhZX9dAd2h4LFh83WkPTW5+p0XwToVKFFytPbcqK/U523HxPJggggsXFT
         VGSfZzgVaOv85EidWvOuLQN8+8UnO2EVDpdPhjqOu8sJRpthaiOS7KXU+YZ62FxzOB5z
         H2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762366611; x=1762971411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHsVV9xGLdeBVjQzQ+KO9Y00h83ZIy5yu3puOCqoV9g=;
        b=cPdDxlWCOqrcfUE27rYYq/Lngp+tiGt8YNOWpm3fJuKL9CNssWIaGzzmoizwPTzGp9
         kmISxImlx92858dsrXFrwP5g1NNHPE9pmGbBJEr2E1syGQAO63HhnKD3t+Tx4HHhQtxA
         WPTNOErBuwc+aUjZn2SJDF26/qkVQREyke7VKZ0aYbAFMbfrUTHNLh9BPyMT4Snocc2m
         AuajwMEFUWWyKcyE5YJkaT62QPXFbVhEfayMJPz5ncl4wGKLSGAx1l1tsdYfM+jXY7nx
         HHXbe3WOBp5/3PQXVl5uNN0GkzqIXpCcpnBVNGePop1/mxdYEa4r/JqZpXCgSxxJIgYL
         j8uQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5cvBv79qKZKLKA2a1k+KsWA4Y8UcEWuPx2653MWviSjUkGrjmpxtajRv7tAvkNzDTym3vRYUMJecoq6Qg@vger.kernel.org
X-Gm-Message-State: AOJu0YwdkWZTEnFWgSqKiLmgE26G+iF6/QC491xuKZDCtHOPuwj4UCuk
	Pg3+2Teg8wQzjIjJYMl7SKmn51za9/2rFJr/Z+7ZDmin9dDjWKFYcW/IAq5dDb1apDw=
X-Gm-Gg: ASbGncvW3ibTb7yyNcUi7uszJyWLmk1u+ePaB2yvs4C8qRnFAOEnfpouEFrqoF/VeFg
	5MXOtUktfi9C+Lqe89EuJ6hbPpRn6S0hC24mjlqgX5KF6J3buPCOFb9SlQxlS98kEIj3DMO0bdG
	uwvR7E08x/oZ8q4ZpRoJwBCWNKKpstMOANnfKmBTVuKDjnOsGsGzDxSsJBAwuLD2rikP7APxs2b
	L6nYIHbSKu4FYK0ju+AwxP0taiWu/ILeuy7QsvUlrTFgiGGe6cRsEFDglCn7F79q03FgH5T5tFg
	ibFOdHhnF7cTF5g/rS9zB2AWOV105+RWy57tI+folwb4fXthso/RvvMMipy0MY6KXXEUbLuS/u4
	PswE969C9NNWRUthmDWjPIh25WPIqJfJLDEUf8cgDU6X/DAXQS8lAkwIFy19Q4n5TMoaxNN6HOd
	9jPdEOUjujU7N2q+uHQZKtZOol4ADv4g0CDH8kyz1B2kuqAw==
X-Google-Smtp-Source: AGHT+IFaewYCh7lZ/e3jrLC+zJ6aPttGSWBIKbLkQBuHB0fmqLtXdWY7nE/Y+kB9ksn8kefKsppo3A==
X-Received: by 2002:ad4:5aa7:0:b0:880:5cc1:6923 with SMTP id 6a1803df08f44-880711d8255mr64437896d6.36.1762366610614;
        Wed, 05 Nov 2025 10:16:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828c457bsm1883826d6.5.2025.11.05.10.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 10:16:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGi3s-00000007CLf-2PE0;
	Wed, 05 Nov 2025 14:16:48 -0400
Date: Wed, 5 Nov 2025 14:16:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Gregory Price <gourry@gourry.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
	Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
Message-ID: <20251105181648.GR1204670@ziepe.ca>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQtiUPwhY5brDrna@gourry-fedora-PF4VCD3F>
 <20251105172115.GQ1204670@ziepe.ca>
 <03e363c3-638a-4017-99c2-b6668ca8d25a@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e363c3-638a-4017-99c2-b6668ca8d25a@lucifer.local>

On Wed, Nov 05, 2025 at 05:32:29PM +0000, Lorenzo Stoakes wrote:

> Obviously heavily influenced by your great feedback, but I really did try to
> build it in a way that tried to simplify as much as possible.

My main remark, and it is not something you should necessarily do
anything about, but pte_none() can be given a consistent name too:

leafent_is_none_pte(pte)

Which is definted to be identical to:

leafent_is_none(leafent_from_pte(pte))

But presumably faster.

Jason

