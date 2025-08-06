Return-Path: <linux-fsdevel+bounces-56851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B16DBB1C9B0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 18:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306B9189BD0E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE139293C51;
	Wed,  6 Aug 2025 16:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDUMjS94"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514962AF1D;
	Wed,  6 Aug 2025 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497229; cv=none; b=QK+1SmKuM/XRpvpevAp7bsMQFucjEsBIbZkI6BsbizdS/bG9PbL3Ny45y6n90FwIcZx+cgQ2JI0Gum4mxNmQZeNAt3xkwLxKB/K9K609vqgzZ1wLohx9ecupi6EgJUHPAeYzB64P0ufKCKfkSdugONedWv8gMMysnYfMr2d/Rro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497229; c=relaxed/simple;
	bh=YzNUeRz+7NioewNCFAm3H45FqF6Pb+PeV+gi/hYZbgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IgjrFVPiXmXkwX1DDuoka+JrV+zsCqApQt3sdNi+JbZ6tjztvRDXZA+y4bz3DmUFi6O+5+9T0Yv7OPcDIJFQnesEghvGahTAmRSVJwdX/PVrR5Q7qvoAxQL/SoEr4JCBLTga0sIsSWQzKvqO2ifM5F4pqTW+9ncwZ9FtQqE5o9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDUMjS94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CC0C4CEE7;
	Wed,  6 Aug 2025 16:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754497228;
	bh=YzNUeRz+7NioewNCFAm3H45FqF6Pb+PeV+gi/hYZbgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jDUMjS94sgJQAZ5W00DgCyGrAW6+Trt3W/gI1nOMamwgPl56P6wr8/GVQ1HFmmZjH
	 6/LQJm5zFpFitXGcP64l/kDbGqCyCSIbTdHXJJz0FA6rwLO1OhMpTVBjWd26RbU1Qa
	 20wai22oS/gPJVFvG89ocT6IJ0oI05qIrHKdXFnYqaZOF5QRTaJkWdRZ5hj1fa89hp
	 u5Wz+zXci6GN9FOdsLo/Qh5CN3RzSoQbUJ69nL82LVeJvGpzQCVq/M1Rs1RsA8+bfM
	 L/V1FCago4T+cQ7LdEkoCb3ZvWVNk9Kms5F/YItBmwN2rwQlHcB0yKEZgN3e3B1rty
	 wJ6bribMzvyPA==
From: SeongJae Park <sj@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: SeongJae Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	david@redhat.com,
	vbabka@suse.cz,
	peterx@redhat.com,
	jannh@google.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	paulmck@kernel.org,
	shuah@kernel.org,
	adobriyan@gmail.com,
	brauner@kernel.org,
	josef@toxicpanda.com,
	yebin10@huawei.com,
	linux@weissschuh.net,
	willy@infradead.org,
	osalvador@suse.de,
	andrii@kernel.org,
	ryan.roberts@arm.com,
	christophe.leroy@csgroup.eu,
	tjmercier@google.com,
	kaleshsingh@google.com,
	aha310510@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/3] fs/proc/task_mmu: factor out proc_maps_private fields used by PROCMAP_QUERY
Date: Wed,  6 Aug 2025 09:20:25 -0700
Message-Id: <20250806162025.82266-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250806155905.824388-3-surenb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed,  6 Aug 2025 08:59:03 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Refactor struct proc_maps_private so that the fields used by PROCMAP_QUERY
> ioctl are moved into a separate structure. In the next patch this allows
> ioctl to reuse some of the functions used for reading /proc/pid/maps
> without using file->private_data. This prevents concurrent modification
> of file->private_data members by ioctl and /proc/pid/maps readers.
> 
> The change is pure code refactoring and has no functional changes.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

