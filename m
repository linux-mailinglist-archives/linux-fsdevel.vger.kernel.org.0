Return-Path: <linux-fsdevel+bounces-71370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7BACBFCBD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 21:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 54911301E942
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 20:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1A51448D5;
	Mon, 15 Dec 2025 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPh/oprn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jZOzsmpN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E581E30F80D
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765831323; cv=none; b=WgPkdgBG05GlsLnkNydSaI/nIlwdIKSVD4gJEORXTerkUbpQFwa8GT3GARZ1eosaGPm0AmWlc0fS87gOgeVJXvVfIo/xVLmz89q5f+/JFh8u1babxKb/9pvWDjfiE92vL0N2RVgxHk945y5usbHRqr6xx9jiJ9q2Oz7G2L3EDrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765831323; c=relaxed/simple;
	bh=Tg2Hz5s/jJowltHvM8wwgjOW8nNKrG1QcZozg60XeFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8JH/57Lrfqv5Tq52JFhxVbNFauWYbl/pTQhwTAlKyzRst4CPyl6Lt78B3vZu5OkkgMXHkFgs+zC0tQNpu5QtgaJ2M2jKpajXaMTIJgtgFcjVI4nn+7Ypuqge4M1D0uSj9JiCF7Wli83MDzhZjPeTz0TIPYFZ5lwXZU2CEecRww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPh/oprn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jZOzsmpN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765831321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vIugujDFg05cEDjSFPsNuy7/nXwlnSCGQEq9oeQZt8U=;
	b=EPh/oprnsVUrz2G+idS1ZC2AM/rwA1+1CYkP4vO+y+Y9/Ks+UhZD8GQD8uiF7UNWRmm+Q8
	lYIJDilFvfrR2WTE+Al8Yo+CZTbbsG+JMUiIqor8rbyfp6JC2rk0SbDtLjgj40Qo1Qhd62
	7HXSH1GHpkG+G8IPBcGjz75EAvWohL4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-Hc0ZdkIWNBysfbBl9HeuZQ-1; Mon, 15 Dec 2025 15:41:59 -0500
X-MC-Unique: Hc0ZdkIWNBysfbBl9HeuZQ-1
X-Mimecast-MFC-AGG-ID: Hc0ZdkIWNBysfbBl9HeuZQ_1765831318
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47910af0c8bso29564145e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Dec 2025 12:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765831318; x=1766436118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vIugujDFg05cEDjSFPsNuy7/nXwlnSCGQEq9oeQZt8U=;
        b=jZOzsmpNQ8IM0eTqwUxKP4Ey+HqSdxApMvOpNiA+jWWmXPcpLV/A0Mcfjz0rB5zZwn
         CwvoQcTcySZgEQx2oMJ99ilBicTaG9lTrLud6zgI/4vPVBDNPBNQzai51JkBN5NHT8ht
         0BWZ4XEndfCJRolRG3tRana8GmgSko/VUs+5AfiunqdOz9skltG7tK+UybfnD8yu9ohZ
         iogSTSe/1nTdYunCd1zm83CRG+23mlN8vZmLCgCx3dp9FYNU3hxKFbYUYuFGtvHoyFFn
         oxx4z4mu44+Uy6o7bKq9fqpgr8sBWCQnleyp4JD5E/QXeUKGvENmgOtwF+VDJONsjbgG
         ZPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765831318; x=1766436118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIugujDFg05cEDjSFPsNuy7/nXwlnSCGQEq9oeQZt8U=;
        b=noUsK5LsEPQO9oIn4yn9QjXtKJYjvNVWnnimoRaMzOXQs355gH93dcl0nqFsa/CofV
         +mBX6xIqHPwVoGk8UVBs0IW+W66UO8JSGWxD/AacxCfmvDmCmMYhbyVgqBWrZYlvKHTX
         LSFTtGUNCCgNyf8ISUbpVcZPBpZzM27qyDX2txgPAh95xcnOJdRIuGHtj2m+Bo3drk1E
         dZ1AKHJQiiaZSqeGlDPdDWxYQeUF6A5jTFcVfQ63+uuAAVIHu7+sRaH6N5wnihCG3kFw
         cgyZ8uCKxidlSonRRb4982nOUEGeKwRhLCxVQTfwv957V1f03dVgiD43reyRyAgLeuMV
         pKCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUo1xXNmh02avUHfrox5X+zHRAizXaXCqXGAwxThyjR8nm/cXEP59gLaRKKjyQo2o4xIn/umXU0ufyfZ+vO@vger.kernel.org
X-Gm-Message-State: AOJu0YzGtas3ZtaYDNOujqTUZnPQDjo1IqI7Z+ckWPUreZ/fyFHnF5vC
	KCGbdF4bI+yg0i+QVhSPos+vfLNM2op+zPIiBT8sS8xtDaQ+cMXrQgpfSnV4Nyi9rsyijykY+fK
	JoWVJb2k5w/lOZRaqgRXfZemXd/vpgcDny5iQRJC07KX8gINTYL0U5x7gAAMCk037YU4=
X-Gm-Gg: AY/fxX7/yUzXSTVceHvZ4oIc/QgXM4TodhyflsuzqFsY38Ua1sRSz4JG156nwDFqdv/
	or67jymUEq9GRjEEylavot8TQJY3rOlQ2Zsr5ilPJxB2/wX2LbvDmJNpY+XE7HfYSXQ94glIiCK
	7XpeKD+151QmHWmRcZ3FhNv5k5lmee/od6mnrjFmbzR5qTjixQtsa0yhkwPJAFg/VUoyZAPG5qN
	8ovl3dFDsaq2yhVerr/mxsMyFegpQORSjxNGPfTi9ghZCVbTAVhFh62eQ6DmmqvHQnwrPSZbbzu
	xAoZVnPWDhQYlp+M6NpzHvitqMX9/CMNV9cNZDRyMcH80XWb6i6grN4Mc49LgUDjG1j2upTkNeN
	aEBqdcGXaEWCfavy+gbCgxXG80/tvfhMA9w==
X-Received: by 2002:a05:600c:6290:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-47a8f8cdfd1mr164694445e9.16.1765831318210;
        Mon, 15 Dec 2025 12:41:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpvKxyv9KrTZN+I+gLKkWZxXPblkRG4VaB9KOKEG2SIjVVbTsH1HJ4pcy9Q9bDzIs00zZydQ==
X-Received: by 2002:a05:600c:6290:b0:477:76bf:e1fb with SMTP id 5b1f17b1804b1-47a8f8cdfd1mr164694005e9.16.1765831317597;
        Mon, 15 Dec 2025 12:41:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f6f26ebsm211656485e9.14.2025.12.15.12.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 12:41:56 -0800 (PST)
Date: Mon, 15 Dec 2025 15:41:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
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
Subject: Re: [PATCH 06/14] virtio: Describe @map and @vmap members in
 virtio_device struct
Message-ID: <20251215154141-mutt-send-email-mst@kernel.org>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
 <20251215113903.46555-7-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215113903.46555-7-bagasdotme@gmail.com>

On Mon, Dec 15, 2025 at 06:38:54PM +0700, Bagas Sanjaya wrote:
> Sphinx reports kernel-doc warnings:
> 
> WARNING: ./include/linux/virtio.h:181 struct member 'map' not described in 'virtio_device'
> WARNING: ./include/linux/virtio.h:181 struct member 'vmap' not described in 'virtio_device'
> 
> Describe these members.
> 
> Fixes: bee8c7c24b7373 ("virtio: introduce map ops in virtio core")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  include/linux/virtio.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 132a474e59140a..68ead8fda9c921 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -150,11 +150,13 @@ struct virtio_admin_cmd {
>   * @id: the device type identification (used to match it with a driver).
>   * @config: the configuration ops for this device.
>   * @vringh_config: configuration ops for host vrings.
> + * @map: configuration ops for device's mapping buffer
>   * @vqs: the list of virtqueues for this device.
>   * @features: the 64 lower features supported by both driver and device.
>   * @features_array: the full features space supported by both driver and
>   *		    device.
>   * @priv: private pointer for the driver's use.
> + * @vmap: device virtual map
>   * @debugfs_dir: debugfs directory entry.
>   * @debugfs_filter_features: features to be filtered set by debugfs.
>   */
> -- 
> An old man doll... just what I always wanted! - Clara


