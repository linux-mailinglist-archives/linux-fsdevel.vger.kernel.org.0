Return-Path: <linux-fsdevel+bounces-71373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7858CC056D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 01:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9FD4302C222
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 00:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA92220F3A;
	Tue, 16 Dec 2025 00:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5gtY4Ag"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B07B21E08D
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 00:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765844365; cv=none; b=rpBSNcP6B9EFDMebsceYXvAeA9FHP25oOGn7+bFsWfZOAdMsUmrkKr6vfRnTfEUD73kDXTRmJe4krZTu8I0Qd5Zt0m5GoJ4XNDlD2UNC2mrnS+3Sbt7oQIrgwczFvzwqH85K4L1YbNbSfA0Le/OKfe8uiCW70KDfdt1WYMjV2lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765844365; c=relaxed/simple;
	bh=2xBU63nTJiakTL8J+GV+JbrGyJ0kmCpFFyI7LldHPv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBhmaGKw9Jomk/i2Wfksz6jKmdjFnAqvZ56Wi2tlMpEK78owojjDWmxJQOp5BKJQOoi6QNL0FOMyfxIecGlQjPOdSjrhXSitimWBpUpCQwQ4k0SR2OCyX37Hb6B/YJUS/LEFzFE745NP9dHklRucokk+dUgcgNI9TouGesu+f7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5gtY4Ag; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b553412a19bso3719691a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 16:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765844363; x=1766449163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk1yhdZDsbmHyAUXRbfG+BCb5AaoOf6d28kSsthudBo=;
        b=D5gtY4AgYwc0gpeQTiO+/EeOjsoizr/MwhfDECqoD14EpGxn+omXKnnFXtgPxydAkQ
         DlRQegXiHSLVxrtvo+YtWDGHcp+Ify9tTLIDbn72XWW848VbxXHdj8vLkmLLU0+WRtg8
         eUpD6nVlMiYd9CXwaPnrIPegHsaIKk/sLUfFetcVhUhWTKQhQPDMr8lB4OpgTWx2x9rw
         TemhivmWz5W3E2qLk2KgLQFb9vbpoXRT1DxiBLcmOgit4Vw0FFvaA1z0r2lNQGKaHigh
         LxMSusJ1a7Q09CC0PDxf4oq2yX3W9niCivAFTAyQvJnq5AukYMzG1NaVrplY9Cwd8ctV
         bBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765844363; x=1766449163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sk1yhdZDsbmHyAUXRbfG+BCb5AaoOf6d28kSsthudBo=;
        b=RHbU/bqRDrKJTQntBOmOob43s5ScQJNE4XVaiQYgX1bzcbJ1tk6xAxbG+XuixhFdad
         whbepM4Gisov18Rwb7UA4ME0yZhH3gSNZEOd7HuL+IKwIuTc0zpOzl6adp/HOul4Ez+d
         Upc+xrOGVdfsyCywppwSnUezhcawVULBpTWHjOxQokjxWIcgZ7ZZuN5orjfAFf2bhucd
         mEDKt6Y62g5nMGvrKpe4w3hcquwIEBKFapzG78qB5X5sFyf1iuFptFiEvIdwNh2c0spQ
         CahcsklM+DU6Gw/29kQrBE4nHbGfj74kUHOH6S1IdduMNYYwzhI3sgEPszU0QA4V9eNg
         Zwig==
X-Forwarded-Encrypted: i=1; AJvYcCWpuVHGZdzSlkwgPSq40biqvoNlEJiqKk0lPO7hCSNFCBxScMC3ecoNDNzDaJhIqK74e6PNr1o/CgjT0Urb@vger.kernel.org
X-Gm-Message-State: AOJu0YxM/LNFkL2McWj4+UqH8PUp08KqOYdMrP5bGx93Ry1ieQWb/x21
	DJJjg179XPHiBdau2iQY+1dn7Ip5Da2XABNn7uGbG1uL2TlpgNprH74s
X-Gm-Gg: AY/fxX7SGDHWVZwW0WM22L+OLMzZFjEHiKbUi+wPgwOwBko/u6+KBIOOICwEKHUCHG4
	upOQUSlt4j1Yxm0gd30PTT/5z8j9LpdYZzQHuMTBg1uU8ECCmPm+SucDcrF+sca8Uz6wJnrlf/b
	lUcgqNfTfKUpCO03cGHHYBuEq0aTFsuEThaM+/scoaCIJMkq/SOYtnFOzDHpBEJzvQ7RM8+x40+
	cN2UEIJlcwaYqYNy5Mphjk6zLXr29lxbvI6GM8rHUL6tn28Kp4un78HGnVuctfYyfYkJsF13LWC
	zYo83fErrFksfvw+KNgkZoC4LPwEVKF5Dlriw6ezDDnucOEQCBk3B2ZBf6zaKup1whHKr9K0rua
	t+MjFgInw0omB9dRq/gKhayV+DJDU2djFE60XKQYa0vXlG97JOSQ9QBGtXkhUUghv5e3AoIVRaN
	8gVqEXIpWTYGkkXr6AmwUjXwteN2Eiflyu/z4ZPb0FMbs=
X-Google-Smtp-Source: AGHT+IHmrytMydYNAgs0qRZg7qEjrXkSVHGK3fUWY6ADeu6KzKqLiLcf4Z3v4UGHQ57LoQ8XnYjK1w==
X-Received: by 2002:a05:7301:f84:b0:2a4:3593:6466 with SMTP id 5a478bee46e88-2ac300f729dmr7381219eec.22.1765844362545;
        Mon, 15 Dec 2025 16:19:22 -0800 (PST)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e30491dsm51066947c88.16.2025.12.15.16.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 16:19:21 -0800 (PST)
Date: Mon, 15 Dec 2025 16:19:16 -0800
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
	Linux Media <linux-media@vger.kernel.org>,
	linaro-mm-sig@lists.linaro.org, kasan-dev@googlegroups.com,
	Linux Virtualization <virtualization@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Network Bridge <bridge@lists.linux.dev>,
	Linux Networking <netdev@vger.kernel.org>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Matthew Brost <matthew.brost@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Stanner <phasta@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Dillon Varone <Dillon.Varone@amd.com>,
	George Shen <george.shen@amd.com>, Aric Cyr <aric.cyr@amd.com>,
	Cruise Hung <Cruise.Hung@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Sunil Khatri <sunil.khatri@amd.com>,
	Dominik Kaszewski <dominik.kaszewski@amd.com>,
	David Hildenbrand <david@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	"Nysal Jan K.A." <nysal@linux.ibm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Alexey Skidanov <alexey.skidanov@intel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Vitaly Wool <vitaly.wool@konsulko.se>,
	Harry Yoo <harry.yoo@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>,
	NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, Ivan Lipski <ivan.lipski@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Lyude Paul <lyude@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Luben Tuikov <luben.tuikov@amd.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Roopa Prabhu <roopa@cumulusnetworks.com>,
	Mao Zhu <zhumao001@208suo.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Jilin Yuan <yuanjilin@cdjrlc.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
	George Anthony Vernon <contact@gvernon.com>
Subject: Re: [PATCH 04/14] mm: vmalloc: Fix up vrealloc_node_align()
 kernel-doc macro name
Message-ID: <aUClhBdwQb83vN0o@fedora>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
 <20251215113903.46555-5-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215113903.46555-5-bagasdotme@gmail.com>

On Mon, Dec 15, 2025 at 06:38:52PM +0700, Bagas Sanjaya wrote:
> Sphinx reports kernel-doc warning:
> 
> WARNING: ./mm/vmalloc.c:4284 expecting prototype for vrealloc_node_align_noprof(). Prototype was for vrealloc_node_align() instead
> 
> Fix the macro name in vrealloc_node_align_noprof() kernel-doc comment.
> 
> Fixes: 4c5d3365882dbb ("mm/vmalloc: allow to set node and align in vrealloc")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---

LGTM.
Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

