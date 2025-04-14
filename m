Return-Path: <linux-fsdevel+bounces-46423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBA7A8901B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 01:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9365E17DA98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 23:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8991FFC4F;
	Mon, 14 Apr 2025 23:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sc9l5Q4d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5A01FC7E7
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 23:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672967; cv=none; b=UYqmuDU38qYPdD/rdieD70d0Ivhmnz0p4idTgUnTOMoLOagSp9HG1Aqpq3utRZZr7dyN/zyKaqnwU3vCdO3GF/s7lAr98D3nVWx27a7Aw7+oQoS+xiBjXegVUUu1YkCo4bvrig+7Ufb1t+fDZb2mzk4p5XL9TKZBFls21PB3MQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672967; c=relaxed/simple;
	bh=4DnMfpFmbLxGeVz6jjMyOFFoUcbKIrrGS/xuWDmkbAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TABbDFKSCxppimcHN4UPF82t5bG+FHqhhA98R9o0sEAfPFdyMrU8NAiDqvTtqA70h9dq/Nu5C9FYNU8l7cETUe/cvKKA3q/S1CZOYe2dw5COc1vsuQ7yRmavJoCj/z4GvciKGMsVlYlOYQvuMnH00o+E4CPkeQ+zx5jQlG6uuxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sc9l5Q4d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744672964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTqOfhVMO3oX7s5hEfhf7N6UJGTux5HLcHvFLo78+oQ=;
	b=Sc9l5Q4dKvgAYKJoD0U6SwPUWlp07hIQraZzmo23vocSTnG1ufwQqiQUPb0LkKmoIXwUQ9
	KEKOJYiW+x0xt3cDtEdcOrfjqWSCe4HViqK1w6fDd2LMUYGzRiYUlhJTWF4bPtJ7iYvoSO
	vxIHxKnWw4FCXnMeeQ0lWTQcajO5cjI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-EPsTDwTHMUGUF0WLiBLwEQ-1; Mon, 14 Apr 2025 19:22:43 -0400
X-MC-Unique: EPsTDwTHMUGUF0WLiBLwEQ-1
X-Mimecast-MFC-AGG-ID: EPsTDwTHMUGUF0WLiBLwEQ_1744672962
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-225429696a9so62518975ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 16:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744672961; x=1745277761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTqOfhVMO3oX7s5hEfhf7N6UJGTux5HLcHvFLo78+oQ=;
        b=pe4baDtovlORLEiE04ulkwLD9UiyBcn1GWp4Yowq8AmWQ7yvsDFcV76SPMrP1eZ3Oc
         PC/Y43iqRmakpgONBUC3k0NIUVdad3LnZJIOGJY9TeaH0t0XZlDCzyp6MxRlXkFISS8u
         wYUOJlKHbB0mcYWHjBd38RlD5hggc4NKNLKsKO1frMax6i4TNvTRHx5ZqsK88c+QuRgs
         F4jgRz5nyoSU0+82DSg22iOHnNeYHpSYr4s5VXnbLKE5j6Q9D77UguoQ8ApLl7GYEUWT
         hmVPQAvD0/ktDfHN85VP/fwK0PjkqxFSeJj+HbINTf2arpBx9UEXxTBj6lMPoZ1/FB0h
         enPg==
X-Forwarded-Encrypted: i=1; AJvYcCUB/ppqYU+/BVyoqhWJw/kRJiN9qIBcX38E6gIa26L+bpTiZfHBJQb2hmnQqDAolVsiEHBVmpaO92l6CebH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5VFpFWWXwrbHBmZyyAzdj/vOAwTyWAqwPBPCjSarmuJLhqClr
	DlnXHJOlePl1fHKv5fkju+mR6swqIhf4xmaJIllHXXzvrUaBIB9bt5Ro6QN3g4OEjnA3ioVvT7e
	QbHI1YtTPnZlzX1dVNzGOPQw7CNY2pJPczcuZ0UUsfGdfEHwmsROYAPT5Q2I6rWWgbElQsb7+BJ
	Awvqs20xq5iadGOvS2kj6LjRqb4PBvIi80dAib/RgsAZn9zA==
X-Gm-Gg: ASbGnctGkOu0ZoNT620Qf4sQ6HCislZBO0jERBPyqRmcAfCemhVf4n04GVvaLqJ7fx5
	nC5tN3oa2iZC3DJyax8H82KsiEG2G/OF7rFljndjoXFi9jzH4pGr/VPfZIswZofByhpE=
X-Received: by 2002:a17:902:ea10:b0:21f:1202:f2f5 with SMTP id d9443c01a7336-22bea4a1e41mr165046245ad.8.1744672960905;
        Mon, 14 Apr 2025 16:22:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1AHsKSZHKc3ZG9l2EOP9IVYFBrGDAU7Mxy/wvMCYvA1yfGQ8huWiBkzCVojnxML9vlgqyT86Cp7v0R0BshkY=
X-Received: by 2002:a17:902:ea10:b0:21f:1202:f2f5 with SMTP id
 d9443c01a7336-22bea4a1e41mr165046005ad.8.1744672960646; Mon, 14 Apr 2025
 16:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412163914.3773459-1-agruenba@redhat.com> <20250412163914.3773459-3-agruenba@redhat.com>
 <20250414145120.6051e4f77024660b43b72c8a@linux-foundation.org>
In-Reply-To: <20250414145120.6051e4f77024660b43b72c8a@linux-foundation.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 15 Apr 2025 01:22:29 +0200
X-Gm-Features: ATxdqUGev3hKkKP_xReo0nZ3C7cPj6MnUdmVFecbVAT6bl5u52ieWp2nkeKtLgg
Message-ID: <CAHc6FU4CAzrNO24izcwYXFt-K0WFUdM6y0bAzmW6nb1CS0sexg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] writeback: Fix false warning in inode_to_wb()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Rafael Aquini <aquini@redhat.com>, 
	gfs2@lists.linux.dev, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 11:51=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Sat, 12 Apr 2025 18:39:12 +0200 Andreas Gruenbacher <agruenba@redhat.c=
om> wrote:
>
> > inode_to_wb() is used also for filesystems that don't support cgroup
> > writeback. For these filesystems inode->i_wb is stable during the
> > lifetime of the inode (it points to bdi->wb) and there's no need to hol=
d
> > locks protecting the inode->i_wb dereference. Improve the warning in
> > inode_to_wb() to not trigger for these filesystems.
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
>
> Yoo were on the patch delivery path so there should be a
> signed-off-by:Andreas somewhere.  I made that change to the mm.git copy
> of this patch.

I guess that's fine as long as Jan is credited as the author.

Thanks,
Andreas


