Return-Path: <linux-fsdevel+bounces-7689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DCE82962A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 10:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76EA41C218DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 09:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A5F3E49D;
	Wed, 10 Jan 2024 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BzqKa9NU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54B43E472;
	Wed, 10 Jan 2024 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Fed6Wh38yLZ4VW44UQIVxDeEah6yaESJroVirbnMcCQ=; b=BzqKa9NUJWdXYv/6rgJZ4RYlWu
	NoYKk1B6vvpRdx9T5jBwEbUpXKbB8ClufPgK2+QxrMZA4mYpvYPlrZBfhNN3Eq3c8NvdELaZfWQBA
	qfmN5Oux/8hGs/+KFHxmTyEKgilboZcGvJOxMoPkRpYoolaZ1yYG44FbLUe8cXpQ9CY8mS090847h
	8HR55gJQTas2JOmu7+yt1dCZ3PU9LzfzRPVSS2UoIJ3XSSYdwsP/jr3oxtjv80gPLeoMHrEtLbaUc
	e8MTRADeIe8t1pag7oAFYXTjJvi3NNL5SVv5oRpf857r0P1F947fMRc+a1lIOdOLRinVn/+IgWgWD
	ujp50hSg==;
Received: from [2001:4bb8:191:2f6b:27f:45ef:e74a:3466] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNUls-00AsAW-1I;
	Wed, 10 Jan 2024 09:21:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	Chandan Babu R <chandan.babu@oracle.com>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Christian Koenig <christian.koenig@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	x86@kernel.org,
	linux-sgx@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: disable large folios for shmem file used by xfs xfile
Date: Wed, 10 Jan 2024 10:21:07 +0100
Message-Id: <20240110092109.1950011-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

Darrick reported that the fairly new XFS xfile code blows up when force
enabling large folio for shmem.  This series fixes this quickly by disabling
large folios for this particular shmem file for now until it can be fixed
properly, which will be a lot more invasive.

I've added most of you to the CC list as I suspect most other users of
shmem_file_setup and friends will have similar issues.

