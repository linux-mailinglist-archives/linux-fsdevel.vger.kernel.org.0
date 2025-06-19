Return-Path: <linux-fsdevel+bounces-52253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8C9AE0C1D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 19:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361841BC6444
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 17:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522D528DF0F;
	Thu, 19 Jun 2025 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dur9MXq4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B936E1F874F;
	Thu, 19 Jun 2025 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750355298; cv=none; b=aHmDTmjWw3O9KHR30e8nQHW8Oa7GNWdKbkXXnbXX5evTQaM0P0RyxmKZ7UU/vjOslVXjFWiI5sPjmaFpyB/0GFpTy4sMC9pcqiViPP6t6vlNZZVCB6U7Ht67LuC5NGtw8XAIgUMOoQYFcmccTnw6fxBaOB9V0NyitIVBMbqGy3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750355298; c=relaxed/simple;
	bh=YvO5fzYLvhWnXwDLeu0osljtoe46Ll4TNlde5gM445I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NcVByybXj3eN7CpOg9jdIAlslnOLWNbO/NoZjL4vDiFRUc8unFezPvplkGnfxIQwQ2pOvDVM3V6re0jkidZtuxcRLoFVhJwBLy0zzl03g/gYWC1ucvKHMdjERsCMARv2Ogy6SCVxt9INew1OGxohAFG3tOpceKxT3+uol0sdumo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dur9MXq4; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32b910593edso5461571fa.1;
        Thu, 19 Jun 2025 10:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750355295; x=1750960095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvO5fzYLvhWnXwDLeu0osljtoe46Ll4TNlde5gM445I=;
        b=Dur9MXq4R6R2Uc5aLo/Q4OtbEiXhRUwMmJmrFW0i02qvDBRHmhvbbdrIW61q8v+TvK
         +UxDPreTNt9JftBgi85M1GVP8M0L3Vy+5eg8qe0oXt/yI7RWxMSQTuu83paFF3MDexLb
         Pr+ONVi63gQzvpyEW1JTnEEUppDwVPn8OP2X7Otr0mybAFEviTftYliHPk1EZUAbMo4l
         /gtFl0tqgBxDb8/069Loi5F1CLfVSNzNqH4TNV/A7E3WW477mQlDCFn67SP7awrNsGqU
         eXrCkQ2810+SbBHjFEPQRCQ6XqH0VeKFaX5V1iYW1Qv4YYVfb/TNsm1iiNJk27ZHDJ30
         Ii9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750355295; x=1750960095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YvO5fzYLvhWnXwDLeu0osljtoe46Ll4TNlde5gM445I=;
        b=JZTYpBFmYGFD09UOftSpE42jEYDdizIm2a5IqPVvwZDvYltOwOxoAv9JB5oC3cwOH0
         sCQCrIHeS83sZAkUCgeVIIbq3wUMn72tDJPJeLLEyMD/5/qkQNQDJj6ATOphAicfbt3p
         O2K0irs5oeHueyWFGXNU/UvL+YuguV2Jh/AekagNIrI3E3mG7vtuZt+e0RJL47gPuooa
         JN64+9EXJ+/nQW3XpynGLRzqKYoApAQNhnBWYTxHIKmXU8XStMU10eTQxbekOvVtmNsh
         X394c0cfRei4GB20ZCfQcRKxXN3ct70e8rJUQyb3c7UaCq3yTsQAC/ZG/d7V3Yeu4L9e
         dKUA==
X-Forwarded-Encrypted: i=1; AJvYcCUgrnmDxI5XrhidGwmAtP11cTOQUjjuWQU+pBep3Ykm8+Y/KrACd2pDuRDSaRdrndFY8+4nY1A92M9HreU=@vger.kernel.org, AJvYcCUlhjfLqPYeB/ULJYzOViWNF90vn4mwENe9VeFD/a+5DeEKfTJVKtoZNuDKphNSnnj48pN5gkLpXGo=@vger.kernel.org, AJvYcCUrpMJE+Ch3kYVOz1dTNRnFqS0G4CkMG+ys2a2wWlklhmaTocbOAV8MmnIuBT1PS45zHydwSWeHmPb/@vger.kernel.org, AJvYcCUxMH+t7wDdWMIE2HrMOe9zd65vBKJrTOwKIcfaFxix+uup0JmndXTxlp2vf/yampXX+OFPKd9b2WlW6gsc08o=@vger.kernel.org, AJvYcCVBKjYyBvDG3oFX5mMt6mQzIdH3RPAkL02dFgsi97xlghWLhJ8mFF1lDikoRnF84K9P74WX3axI5bcmtYc=@vger.kernel.org, AJvYcCVq0BmsKE0Mt7Pljq+57BAZCH1qWV7s7PgQj+CwxZjumQN6mTu6Cmg5/eFMOA4FgnEPfFY/2tlc8Q2/cA==@vger.kernel.org, AJvYcCW2dimP8UOEOb5S66NAbjlIyWUa642V91hVfpa4/VTaYkLY3OYK+sXqZJmLcJfqU0YR/v1QiBPavMWrJQO04A==@vger.kernel.org, AJvYcCWd38NLdzDwM91xidggvQ+ixK7FMCxPdXc14AUnSWzcglnmjYM3FR7O4+TGhnMyYZPi4d4n81XEdqJw@vger.kernel.org, AJvYcCWeIHF6kF7p/uWIoTSt8+TfUJ2s2MU5RbP/gANbxUtCvzltt1mVY3RLJvnk/eZ401zmOyMMC+KFwxVI@vger.kernel.org, AJvYcCWiCtY1cM4crGibVHh6
 qA0XCiCdt/BC9TspGGFQ/fDCSN652rBM13sBnq5ibfqmy6hxUeV7EkWv1byhSRsc@vger.kernel.org, AJvYcCX1d73rru5zLcGzOmqGMBpC6DBVq9gceGIZH7KKoQg+GzvFYE0A2D0dvjl9446g/f2Qhbdec7B6t70V7G0=@vger.kernel.org, AJvYcCXDo9SueBR1AOMvgWNmyMOoLVn/jIrv/7LyoKxOQxp+iWpfnlO9RIbM5CMmLgryvcfCrXzR+yAGGjuncQ==@vger.kernel.org, AJvYcCXc5KL/IeYUEkoZBLtjP/EMQHh0gNVuWchlrp018Mq9hzx2R5J0DlIpx9Ytjg8hQO/Aw4oNd2hz2iC3Y2ACHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEDwexr1WGUvgCuOfi5bsvm0FmJthPJYpT1zu5jX+cfpvet2r8
	UoAgX44V8Kd5CUN1abtPyzsdUGSdOybQXtl3+fH7G05Qy1pMh0qnOTxBAjQrw2SFMAiNE9m8SHR
	8W+hc2tN93CJfdy1cKkcjzeSUlCl94RE=
X-Gm-Gg: ASbGncu1Ap4XRKaapXruYd/T6ZoJBKZZRVvY5NZjWJHNpeNdrTY5Tk7gUf+o+ESmVra
	lOCuL0pLgd4P01bREuik6gyM+nmaXoIeS9mfMT/VMY1tcDF1N1R+OQP1D73IhUmfSW+AYavrerr
	2idhxTQTAu1XVOEqwGGJVC+dUdh8mpVJWjICpy0ijk6x8dd4Gg/FjWDC94ys4l2hiZ6H+zjDPSx
	gFFTA==
X-Google-Smtp-Source: AGHT+IGL41V3DbmFvBsWr3jGwFHfcX0duW69mbczpCAOINsa85ECUigYdfUlpWqgF++enxibRnhFFvr8Kxdp2WtP+R0=
X-Received: by 2002:a05:651c:2203:b0:32a:8297:54c9 with SMTP id
 38308e7fff4ca-32b4a3088bbmr63065741fa.8.1750355294494; Thu, 19 Jun 2025
 10:48:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com> <f528ac4f35b9378931bd800920fee53fc0c5c74d.1750099179.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <f528ac4f35b9378931bd800920fee53fc0c5c74d.1750099179.git.lorenzo.stoakes@oracle.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Fri, 20 Jun 2025 02:47:58 +0900
X-Gm-Features: AX0GCFsRgomy43xV-Lv7Stfld1a1yqIyJ3-ysZ2OVO90S8cEE5UAjZMSvGqxZQ8
Message-ID: <CAKFNMom4NJ91Ov7twQ3AGT7PSqt5vN9ROrNHzfV53GHf=bK6oQ@mail.gmail.com>
Subject: Re: [PATCH 10/10] fs: replace mmap hook with .mmap_prepare for simple mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Jens Axboe <axboe@kernel.dk>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, 
	David Sterba <dsterba@suse.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Benjamin LaHaise <bcrl@kvack.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, 
	"Tigran A . Aivazian" <aivazian.tigran@gmail.com>, Kees Cook <kees@kernel.org>, Chris Mason <clm@fb.com>, 
	Josef Bacik <josef@toxicpanda.com>, Xiubo Li <xiubli@redhat.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Tyler Hicks <code@tyhicks.com>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse <dwmw2@infradead.org>, 
	Dave Kleikamp <shaggy@kernel.org>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Bob Copeland <me@bobcopeland.com>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Hans de Goede <hdegoede@redhat.com>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org, 
	linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-mm@kvack.org, 
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-um@lists.infradead.org, 
	linux-mtd@lists.infradead.org, jfs-discussion@lists.sourceforge.net, 
	linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, ntfs3@lists.linux.dev, 
	ocfs2-devel@lists.linux.dev, linux-karma-devel@lists.sourceforge.net, 
	devel@lists.orangefs.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-xfs@vger.kernel.org, 
	nvdimm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 4:48=E2=80=AFAM Lorenzo Stoakes wrote:
>
> Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
> callback"), the f_op->mmap() hook has been deprecated in favour of
> f_op->mmap_prepare().
>
> This callback is invoked in the mmap() logic far earlier, so error handli=
ng
> can be performed more safely without complicated and bug-prone state
> unwinding required should an error arise.
>
> This hook also avoids passing a pointer to a not-yet-correctly-establishe=
d
> VMA avoiding any issues with referencing this data structure.
>
> It rather provides a pointer to the new struct vm_area_desc descriptor ty=
pe
> which contains all required state and allows easy setting of required
> parameters without any consideration needing to be paid to locking or
> reference counts.
>
> Note that nested filesystems like overlayfs are compatible with an
> .mmap_prepare() callback since commit bb666b7c2707 ("mm: add mmap_prepare=
()
> compatibility layer for nested file systems").
>
> In this patch we apply this change to file systems with relatively simple
> mmap() hook logic - exfat, ceph, f2fs, bcachefs, zonefs, btrfs, ocfs2,
> orangefs, nilfs2, romfs, ramfs and aio.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

For nilfs2,

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi

