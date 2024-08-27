Return-Path: <linux-fsdevel+bounces-27339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7BA9605E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 11:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AF0BB22BDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 09:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EC519D880;
	Tue, 27 Aug 2024 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhyPmM3g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85697158DD0
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724751677; cv=none; b=qt+uaVCmPhi5MXunYMY5BrAJq9Ey1lnvsva22O722eRUuAo/gztbCf/Imj3FYr3JjB4ziE6f2CcgRwaAjiDQtOyw+NjN5VApa2VtZk0MWDCMQaKxW/tCHotj8ca888lKtX/8CZdAAXrXxVPyfxfGsOmrKbpYeGozKS4qiwRDo00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724751677; c=relaxed/simple;
	bh=z4/NIg0kSm6efF0xfi0lPZE6h6SxozM3va97utnqAZo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aFpZY/2NhDXnOsrvArSI2z7gUhuVfY8WMVA6ZKsqI0VDEwuoz6fwFNkkJdtHGsRlNiDr20w9BNnCp7dF9GVXUVgvYsUEBk5K8ELZIn2B30lAt06ibxRyGrD92aQru3l9wDpAPb2ZjRBZT5NpaBF/fYT5E7tGVPSx3nH1j0cLrwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhyPmM3g; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d439583573so3807543a91.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 02:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724751675; x=1725356475; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9eF/ovgMNWCbZxUA+usXePWIYX5lVJyrJl48CB1hbVg=;
        b=EhyPmM3gZSZEvKGbFKn2Jm2bD5NQsSiXTAaQNQ65EbPbUrXmWMeQKgw5nmrF1wuCLl
         iZlLc9d4UmrsXnXUtiuKoTlvigxS5xwt83AyTemOp7zHDzBT948XwCkdW3JHbPw2xsud
         XyFLe7l7r4TJzzrdWIfL9GZFGa1X16z7+KFI/52HcZIWgwbyOzuhmuCNDj6FGwwX6B5k
         Ux/mLp1R2vcsVb88dr4+PFan0xUxFzmOuX1rGueRQLaeH9U6v0rQxP+/Pui/cbmLx/Gq
         Xw4QVzBKeA+RlMm9bts7GuP5YA7sj07MQxgccu0plHoC1WtetEBVrjo9htM5TinYNfg8
         ii/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724751675; x=1725356475;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9eF/ovgMNWCbZxUA+usXePWIYX5lVJyrJl48CB1hbVg=;
        b=WsgGqqJrvkiBJ41XR0pyK7UdTyxWTSkIL6BmYSbRwAk3WLA7NCCJMnLOMgyqSLvLyk
         xHTA0AVmMc8k2GN+yXlD8G3GeJwA9qi60ZgxqwkPeD5dCp5hTOPUilnIK139OY3ESHyS
         1dEP8tsTtVZbiIzaGXO0ty3UDyikAurZseT3K2xFLsyAsxu/mChmxewnBNTrZlh6aBJN
         2H3myDfR+bhFhs4b8+jm6Cb/6m6DfjkcpC+i+MZMmo85/qOI/1RJok7oP+y7bYJrtBty
         a7vss4dCytDSlfrtkrtbR3OTRv+clGsKmg9OF81wbFkXi67uz7hJWiAHWIYSiLwJhHix
         ykMA==
X-Gm-Message-State: AOJu0YzngQYUNcmWTTAqwVVq50euHtCfht1V33zSeeSPsgPySEsVpkxJ
	7fBPbWsylofeCi/b/+1WgWFsTOu11hUdUSIYOBfFlkuHxktiZmmvPBrbit7E+k0BvKvJ249tpVL
	P6JMb18Kb0eorHur+QvOnVJ5SFLZHjU8z
X-Google-Smtp-Source: AGHT+IHvbXUyz0tQkVoQR9i5dcMrLjoncGj0MRFUheTo7FrTup8aMjjg9zwOzYdKdmZIWiM/Yy3pfhcYsk5u+9TNZM4=
X-Received: by 2002:a17:90a:db8a:b0:2d3:c5f4:4298 with SMTP id
 98e67ed59e1d1-2d82580a069mr2823598a91.13.1724751674947; Tue, 27 Aug 2024
 02:41:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Tue, 27 Aug 2024 11:41:04 +0200
Message-ID: <CAOw_e7bB3C_zbpq6U+FdrjbwJAOKFJk1ZLLETrR+5xqRmv44SQ@mail.gmail.com>
Subject: FUSE passthrough: fd lifetime?
To: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi folks,

I am implementing passthrough support for go-fuse. It seems to be
working now (code:
https://review.gerrithub.io/c/hanwen/go-fuse/+/1199984 and
predecessors), but I am unsure of the correct lifetimes for the file
descriptors.

The passthrough_hp example seems to do:

Open:
  backing_fd = ..
  backing_id = ioctl(fuse_device_fd,
     FUSE_DEV_IOC_BACKING_OPEN, backing_fd)

Release:
  ioctl(fuse_device_fd,
     FUSE_DEV_IOC_BACKING_CLOSE, backing_id)
  close(backing_fd)

Is it necessary to keep backing_fd open while the backing file is
used? In the case of go-fuse, the backing_fd is managed by client
code, so I can't ensure it is kept open long enough. I can work around
this by doing

Open:
   new_backing_fd = ioctl(backing_fd, DUP_FD, 0)
   backing_id = ioctl(fuse_device_fd,
     FUSE_DEV_IOC_BACKING_OPEN, new_backing_fd)

Release:
  ioctl(fuse_device_fd,
     FUSE_DEV_IOC_BACKING_CLOSE, backing_id)
  close(new_backing_fd)

but it would double the number of FDs the process uses.

I tried simply closing the backing FD right after obtaining the
backing ID, and it seems to work. Is this permitted?

-- 
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen

