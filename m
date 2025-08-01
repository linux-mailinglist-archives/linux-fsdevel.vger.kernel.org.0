Return-Path: <linux-fsdevel+bounces-56533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06023B18846
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 22:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8D2D4E01FE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 20:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019D020E011;
	Fri,  1 Aug 2025 20:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkU5VVeQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CCA1F9F70
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081092; cv=none; b=Xgw5ORyUdmPAXKU47LsUAnJr9Yny/Q3u9rbN74aQxvKJUNZV2ms+W2ykZDJgk3hG99Rq4sixtiT2ZLjmLPARiejme6Sq8eVBevZD487AJFo6JyAVqlazKo5XBGfu4oTluZntDGLCSOUMwjCb/V+BhjuFyOi+rwqHxrxt1oXEkWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081092; c=relaxed/simple;
	bh=/wjLVVWwu4q7VCeh2BNxcjNmwyyeXN0qaMEHPMWOkLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcchRbwmq5lExcGQf+GYZo4Cx0gsma/x9gr6QruEz56UPNbsuXLaQGRejwLPImTPx4E29htpopqHP+WEWf0qtLErSL2sztVTo2gFLGlIyWN1zmMN8PyhBYJjdkMaHenttlBKTKYXld2DxBU2RJSyQiEkeTb6VVaSNRc1+5dES4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkU5VVeQ; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab3d08dd53so15964431cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Aug 2025 13:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754081090; x=1754685890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQokanDIaeAB/qcCWloa6Wo5lh3IIVCmtWumD0Huw8g=;
        b=KkU5VVeQEb5e87wzdFEBaUMPlpUtsCOeGL6SvlvbML9SKMNZZHSU1dfiLu2NBHqW+r
         19TF36WwejaOFl9qbdby/gl1I7m+g91ZvGoQ/biKRjSJam9Ct4GnLmqxCJ88Dl1/nw0F
         Oe3fYUPyhZ30tBUZ0UWnzuBGMWLnolG5ARNYixl7/lqUqqYNYU7Eb8lvJMTa3ZCeOTMD
         wwKybuEbe6u+WYw6+WgkWlpGCZcdsu4cyZmapWYpRK8Q7NAPISMFix7cJZB2IlbjZZBn
         FDgGlC8Z7iLzRBR2m8dRJ5jAURegBBePWpnFVPzUzrAHQmJr3dchWVcuwmZCiOzAtqcn
         Im/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754081090; x=1754685890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQokanDIaeAB/qcCWloa6Wo5lh3IIVCmtWumD0Huw8g=;
        b=fyk3Ux1vv8EzEjThhZVEnzSOt0aqIhCbWNR9O+Pf57H+f3R/Heww+j5cLQsfBYTO+b
         kPJIrDQca2rs0X4nIwQoN/66RPRUcogqUtMMtvGGdlxRRlbJuoEYGlOJulc7ks+gSGbq
         UuhG16qBqrYMlUlwRcofPmRkXN4J64y+qQHz3O7j7TLBx5YHadH68g2834LrZfk2kfWO
         jDMhjlNnvkk4bCuHNLEeOdZHXoQDTif2ENkLzdWfZQbtiBGboVhFaLRcL1EX9B1DF/9x
         Q/6j/T5eDL469XdGcUEVq+k/clTLVRPt2Wi3z1FMUUS2pnuuPyp2AIKUzMLaDIkVfL0t
         jCLQ==
X-Gm-Message-State: AOJu0YwE+T99CeOPq3hfOzMZ2gLFwjJVXCAv+ABw3Rpy6AochfIchLzk
	/UAU+VnS3XIHmGVlKhTC9a7PMam7KQ5OWiBf+NwVn8a2RmaNHyMugb8sfEw1Y5me0Hz0VE6KZ/r
	DFj81QCCJk2VvhJweqi0oAFON1MNhW/uKQL7Q
X-Gm-Gg: ASbGncsDIftum3PuKrao5JVuJwPb+k1j74GnXXwlIIWG57noubpK7rhWtoLi+SwZuIK
	sneGBnvvW540Yr6gu3f/+BYn1OvyHv7sKYhjAjTJd3nV5QIate/tNjx9nCYB0idK9akiPBIgWo2
	l5pFn0qmeZTSYmZvVqFiadt0B6N7xKGlW5JKlPT7tw0bdyswe0Gn6YWAWXxbMXn+vov2/jAaVTe
	X2rqcxjR/ZHVO+CZQ==
X-Google-Smtp-Source: AGHT+IGGkiWVOP2eW9xtatXxP/oleTW3Uru3b+oV7nB56HJr40rit1lONms2uHURn2u1st5gGNdGreVd4pfLGjVtDkc=
X-Received: by 2002:a05:622a:4292:b0:4ab:66d1:dcdd with SMTP id
 d75a77b69052e-4af10aa84dfmr18917041cf.39.1754081089786; Fri, 01 Aug 2025
 13:44:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707234606.2300149-1-joannelkoong@gmail.com>
In-Reply-To: <20250707234606.2300149-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 1 Aug 2025 13:44:38 -0700
X-Gm-Features: Ac12FXzPiRacLzTH1VBKySCsSuC4Rr1d84DSIiIVoqRk8dcxoWcduN_EowlL3Gg
Message-ID: <CAJnrk1bTNV_uUUfoP9tYjqUVM1JvWwAo1HvVARY8RXPbACHc2A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fuse/mm: remove BDI_CAP_WRITEBACK_ACCT
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, david@redhat.com, willy@infradead.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 4:46=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> With the changes in commit 0c58a97f919c ("fuse: remove tmp folio for
> writebacks and internal rb tree") which removed using temp folios for dir=
ty
> page writeback, fuse can now use the default writeback accounting instead=
 of
> doing its own accounting. This allows us to get rid of BDI_CAP_WRITEBACK_=
ACCT
> altogether.
>
>
> Changelog
> ---------
> v1: https://lore.kernel.org/linux-fsdevel/20250703164556.1576674-1-joanne=
lkoong@gmail.com/
> v1 -> v2:
> * Get rid of unused variable declarations (kernel test robot)
> * Add David's acked-by
>
>
> Joanne Koong (2):
>   fuse: use default writeback accounting
>   mm: remove BDI_CAP_WRITEBACK_ACCT
>
>  fs/fuse/file.c              |  9 +-------
>  fs/fuse/inode.c             |  2 --
>  include/linux/backing-dev.h | 14 +-----------
>  mm/backing-dev.c            |  2 +-
>  mm/page-writeback.c         | 43 ++++++++++++++++---------------------
>  5 files changed, 21 insertions(+), 49 deletions(-)
>

Hi Miklos,

Do you find this patchset acceptable for the fuse tree?

Thanks,
Joanne
> --
> 2.47.1
>

