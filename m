Return-Path: <linux-fsdevel+bounces-71479-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD340CC3FF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 16:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 981853042B32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 15:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E7535CBD7;
	Tue, 16 Dec 2025 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1s/18BY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C22F34B412
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 15:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898497; cv=none; b=tdpVBnViC/bg528UZIl+hySz8STze8otJA+vyzux5s2z5gXsAxVwK+jaD8jPTxnlLPzt5ECXNvjFbcnWPkZstqvZbu4t9WmcwF3rjesgliGz9riowda8G1we3jwIsNcqIeujRbQGlVQrptWtIDUn6BImzvy7MMFvrepNZTzZUVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898497; c=relaxed/simple;
	bh=kUqJrtaM24NDu8J1LFBz422ot+phR2OLYLy5w6GVNNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IXyvn04/CycLTwoCrKDSSRGHoLHG6ZAr1Zaj0VIVVu+2X63KgfLNE2WE3zhC/HWHFfDjS0300iW6qG0KE7nhNSrgBD6qG5np0hNEOrU44fN1f80GWcHmIU0QmdWUUe3aP7tMXTqp4xJGr/HNajXxuW40pC7IcqiymmdJ/D68jRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1s/18BY; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b8c7a4f214so316311b3a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 07:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765898490; x=1766503290; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6A3FJy1wSkXfE42mqpxDchsxNCyuEhZg+omH3hGmm4=;
        b=O1s/18BYXzws8mK8UZFFV20BTkxvofAuiz4xpx4eKUDctx+f91J+v0cLmvqsTCbaOb
         QB4aMVGENSsAm3YW6Wa8VFaG1DET7Iq27W98kQjWx3w5z/7gBqNJs4jiKEVESk6PgWpb
         OnFDc8gRjZc+e9bX6GJsHkbaTe8SxcL+tPQoAmYEq5qmziB0/rMCCotDxuGLhfqshBQP
         ENkLSZgKAc7BnS0EYNFZmPSnlhH7x78cnAR/JemulzrVYIB7CyOIcKyaqIeMtI0xkbW7
         xvsQE+6FaK/D8QPMsprcLqXzDXbipLMdSTBkBmYDy7CjW1bTN+AzQS0zD8xCrvdNqfZS
         Btbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765898490; x=1766503290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G6A3FJy1wSkXfE42mqpxDchsxNCyuEhZg+omH3hGmm4=;
        b=bYd1/EWUUCvpEEP9IVuxbRuu2cjtBIZWeoeG8GHwKAwqmI1rrrDeyLoab9fopVoQgU
         Nz5lkxem0VMGrs74X6Ef92qcyFNCem9NKqISaDoCENP7UXtsfjcp1Hm7G9Lv1A7rP7ry
         XaOiAWsHm6e0ngltwJKmvFaUkLdjDZyUsJjPtfUeDLj64PABpfwCbSJ8xl1JiFh3Osb4
         A0fZKF3VFAateTU1I5dsEqgDGasElsjnEDOo2TTV6hqA5OIVJYl1BFC0JPHjD0g31ufE
         1ePFc4y8R/HdhsA5w+bTF5cTbhvs2ZdnFUR8UneVuoOS6iAfROwytHLwH5Rc6t1iQRmA
         AB9g==
X-Forwarded-Encrypted: i=1; AJvYcCVyoEhEggDHbs83R/CYdKxJcX+7oIs4eVud4T5vJqcDPwEfVHixjGej/LKGbpx4KMKPiBUneHXFrHP7+uaU@vger.kernel.org
X-Gm-Message-State: AOJu0YxLhh2YOVNwRQrlvDnRM3+gqVfV8JRjyT/hO+3MsZOPqjygHp0L
	oX+CbR4+Vshjc8VCKgdeBq9uSd0JZi/Ejxqn8QFKJeIK7Oy1kXQUVuNVNFwOhqsvo/gZuuGh8VJ
	+lmvA9rzHQ4FRGgeDOtAj1Pn+rnVPluc=
X-Gm-Gg: AY/fxX6flOuutVy9IOSWM1528Q7jfpF+7EoaWA8kzieOLtoxBjwNYeSoq4ygoDEGth7
	Quu+jtpnKI0IUCDdXxdCGNXtF0raASyyiGUWLwe4S+Re63AQFrCAK1Bmm/EqtVAdtYpewtLcgMU
	Ze441l/+j4xFJ8QWwlreaSjo2+5s/an3yJ/FDAe6ukf7ouFBnfkGgBI7ReihuRKTGrpJCkUKjJs
	hmFlElhTc/C9cOe4z/M9CRFCHWbneepQi2rDOkgQZAHdzBSBGFGLO1JVinptzDYFPEr12if
X-Google-Smtp-Source: AGHT+IFq0qaYbGK7y/3ERMab5mfBMJZm2RVpJeQ2PDWWvVrS9uWYHKl8nJo9NGLv/zMgaMY45LKm9slZF+vnfJuCU/o=
X-Received: by 2002:a05:7022:b98:b0:11e:3e9:3e89 with SMTP id
 a92af1059eb24-11f34c5d690mr6648024c88.7.1765898489968; Tue, 16 Dec 2025
 07:21:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215113903.46555-1-bagasdotme@gmail.com> <20251215113903.46555-10-bagasdotme@gmail.com>
In-Reply-To: <20251215113903.46555-10-bagasdotme@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 10:21:18 -0500
X-Gm-Features: AQt7F2rE8ID9d6NCh1LRY2rQdA6w_Kl1ZhHVictIiyXPuu3Pg_xadHkkj9RiiLU
Message-ID: <CADnq5_NsELxchDeka2CX1283p9mn4+P9_V9Mi+SNiWwM_sQepw@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH 09/14] drm/amd/display: Don't use
 kernel-doc comment in dc_register_software_state struct
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux AMDGPU <amd-gfx@lists.freedesktop.org>, 
	Linux DRI Development <dri-devel@lists.freedesktop.org>, 
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>, Linux Media <linux-media@vger.kernel.org>, 
	linaro-mm-sig@lists.linaro.org, kasan-dev@googlegroups.com, 
	Linux Virtualization <virtualization@lists.linux.dev>, 
	Linux Memory Management List <linux-mm@kvack.org>, Linux Network Bridge <bridge@lists.linux.dev>, 
	Linux Networking <netdev@vger.kernel.org>, Harry Wentland <harry.wentland@amd.com>, 
	Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
	Philipp Stanner <phasta@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Alex Hung <alex.hung@amd.com>, 
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, 
	George Shen <george.shen@amd.com>, Aric Cyr <aric.cyr@amd.com>, 
	Cruise Hung <Cruise.Hung@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Sunil Khatri <sunil.khatri@amd.com>, Dominik Kaszewski <dominik.kaszewski@amd.com>, 
	David Hildenbrand <david@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Max Kellermann <max.kellermann@ionos.com>, 
	"Nysal Jan K.A." <nysal@linux.ibm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Alexey Skidanov <alexey.skidanov@intel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Vitaly Wool <vitaly.wool@konsulko.se>, 
	Harry Yoo <harry.yoo@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>, NeilBrown <neil@brown.name>, 
	Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Ivan Lipski <ivan.lipski@amd.com>, Tao Zhou <tao.zhou1@amd.com>, 
	YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
	Lyude Paul <lyude@redhat.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Luben Tuikov <luben.tuikov@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
	Roopa Prabhu <roopa@cumulusnetworks.com>, Mao Zhu <zhumao001@208suo.com>, 
	Shaomin Deng <dengshaomin@cdjrlc.com>, Charles Han <hanchunchao@inspur.com>, 
	Jilin Yuan <yuanjilin@cdjrlc.com>, Swaraj Gaikwad <swarajgaikwad1925@gmail.com>, 
	George Anthony Vernon <contact@gvernon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Mon, Dec 15, 2025 at 6:41=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
>
> Sphinx reports kernel-doc warning:
>
> WARNING: ./drivers/gpu/drm/amd/display/dc/dc.h:2796 This comment starts w=
ith '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide=
/kernel-doc.rst
>  * Software state variables used to program register fields across the di=
splay pipeline
>
> Don't use kernel-doc comment syntax to fix it.
>
> Fixes: b0ff344fe70cd2 ("drm/amd/display: Add interface to capture expecte=
d HW state from SW state")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/di=
splay/dc/dc.h
> index 29edfa51ea2cc0..0a9758a042586f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -2793,7 +2793,7 @@ void dc_get_underflow_debug_data_for_otg(struct dc =
*dc, int primary_otg_inst, st
>
>  void dc_get_power_feature_status(struct dc *dc, int primary_otg_inst, st=
ruct power_features *out_data);
>
> -/**
> +/*
>   * Software state variables used to program register fields across the d=
isplay pipeline
>   */
>  struct dc_register_software_state {
> --
> An old man doll... just what I always wanted! - Clara
>
> _______________________________________________
> Linaro-mm-sig mailing list -- linaro-mm-sig@lists.linaro.org
> To unsubscribe send an email to linaro-mm-sig-leave@lists.linaro.org

